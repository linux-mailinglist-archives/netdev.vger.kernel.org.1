Return-Path: <netdev+bounces-275861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bgVsDWSF1GkwuwcAu9opvQ
	(envelope-from <netdev+bounces-275861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 06:17:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 949123A9AE4
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 06:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C5E63012CA9
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 04:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F7615B971;
	Tue,  7 Apr 2026 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7NUvK3m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18D4C97
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 04:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775535455; cv=pass; b=XbVpUV4JBNBggVBVDRa9woQ3pwhbGTJKHnC+JtPq33tTH4a6pFsa/yWpfkj68872YcBthW9Rm9rK2aoi5z17CoL+m7rd26a/i627hvnAHHfn6cSpvrgIqpzEvW5KvFJKCzFmEnN24YdkGYGfP6oo2lKV9pkP66VREZAVh/0TdFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775535455; c=relaxed/simple;
	bh=Sw7ty+29veqGp5LQJRH7glKwePKiIhW+LcAyP2s9O+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcOdg4Dz/GAkYBIfVdMlWyx3jC2G0tN93swYt8BxhZ21gyNqzwKSioZJsPPG1td6a5b9BdkK1TAvJZkh0z7CV0u2seRviCHfTYhyoR8JeZ0pRpI63xuyKteolE9osFipb7cklT7wVSkgv1h6w2P2/g2XkCJVty3nnh8eA8ijA2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7NUvK3m; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c19d23b19so40214c88.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 21:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775535453; cv=none;
        d=google.com; s=arc-20240605;
        b=OdKh+39BlKw0bRQyq4cnB9j6e0KQxvf4h1+3LnAW/+5czlxdwCsoeGZiso9OyW0xlS
         k48aC+D5Mbr8ysTyQoIfQFENw7GrTD7coADrNMJhxOk0dmb1zI6pjzfOWeoQFhJpFGwY
         WsJ+EQNHmw4RROV0UKVtVoQd+kEYa3JNu8lW8b8Ig6tSJmIrXG9JmsRRCkMsiTFf1Pta
         9WgqPaumjXHB/9qevgDK+P/+fxU48d4EmsHHU2kiirJqTZOwcrvqPGOo4EI20bRTVGV2
         k6XTYWjhfYwtAi7NOxiSjfLdizsoBMtcMTPtTc4JzX5VuzyQB7sf8mR9a7xTuilZYK2K
         qFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AyYS6PCArwoFK69Ul2Lan69GZWWz4KZxx8evAz2lAUY=;
        fh=7HfJqo4yIBpdTKM/B8vkXiFgqqNi5t65ByLUo5vMqiI=;
        b=GNsZPoeNd0D1E2WByVbWIfwg+Bcflmpain+kdRDr+9ias4wYOj4itlodFk5Ho2bWU4
         6rhqiypTDyO3ZIvu4JCB8bZDD8Z/ThP0ooGx1yttzvv530W1lGwQTa/C3JoQu5RJauqM
         jnKDEuCHgD+OGSnvqq4ndgXMSjMOv15LNbWJaknjhaSreuqJoPCe2hyIlETQ56OpmX7s
         wm10ZxNLbXISo+rK1/y0870oVxKQBJ3AqaAa4i7ubPIB6ulZ0c0UaPX41UGLNYkR9Jh5
         eWZldP1TuZlaZTP8M4IgodDGqkJLzgna9yS/y8gw6KQ8SvCQunFlCzcxOwDHZQkiVrq/
         yfFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775535453; x=1776140253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyYS6PCArwoFK69Ul2Lan69GZWWz4KZxx8evAz2lAUY=;
        b=h7NUvK3mG3g86hm6udSjw73qAZqrP2DFC/H4/qj3Lzn3QoeeoQbUZiipOOUiU9iJ54
         pVb0QEl8B7sX+tQ69lZFs2D+U3iUpmvZz5v7pjZLzb6g3PoI9fDUzVk3r0qkBB+JXQzf
         VC9oPfZpixf2SSet2b7jWdzmFqZc27I1XSZJ5sHF/xJS2s03do1Nt8DkrBE1PhFOxEV0
         5411julxX4tA7LkAVxDDFs3qUaubJ//ooHE81tqjzrBOCV0PbYVvNFv3PB5wLS+pV0O9
         ZHod9bza962jC75nBjA35154T1IZ2elH8oBx89Tu+cDXwzM03YjmmPdZvPWHxSJhPBSe
         Yl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775535453; x=1776140253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyYS6PCArwoFK69Ul2Lan69GZWWz4KZxx8evAz2lAUY=;
        b=LhO9oG0XXYGeSTq5IAHlFt+qEarv4m5rhPwttkMzJ8gmx/IRg8X2uftrzgL0Rztxk0
         2KZalY/sIthsmQZy1Z2qDQ1YNyyDq/x57LaGg00gOCzLnCHRtecwyh76w+SU5vLgZX5S
         KaDYLwyXAVETSM1TUPbdjXEpN+DypyeiBGJnX+vHPUOTKnpBTJKIXofAMCgVQydHleXL
         MKxaW7YBuU+uWnD6tsh8OP2fXPHjsUED6iUNyzi9F/QFN7MYE5dEtBTjCqHh/dkHTe72
         e9rBaJbq+mZm9znOEAZ1YRjohsGkcKL46CMbm7rZLhDIY0HM9aENlWAozN2FXv/7J63a
         rwiQ==
X-Gm-Message-State: AOJu0Yx/DCINasiRo3fT/TdtPfLJpEUgv7Swc6OSlazyK6JUnjhbhTwf
	DJhSSy5sQN+3OgttV3oAHyW5L7CtNUHPQWY3PhXo5B8SV24zMwfJJ7OdB7ZKiRYEHRGTiv2p64L
	Zf3uIn4/nDAiQgSoYcF4NhyeGavr+/Thjv0S3jBUe
X-Gm-Gg: AeBDieulfVdrGT30epvoo4DNyP7/E5msHwvAXAjAqM1NAFXAtU6Vni6w6tr+fFOEVgN
	GKc5e/fxMEYLwwmI79EJ5jArsO5F4bnDgbPq/iiteS8fF/JIkBLzeFhegw8SSKtMILYWtSso/pz
	eTDpIU0lbdCejkGbVij272QYwq6QitINA8V06tyS2QiiexaIouUH+OH+xcDkDYzHT2Ww3jm49is
	TfO3FdvGogg7oRPW1MxGVNh/u0EoKsvd+Q5SDf8N6R4JSKTShpCcdbl8cIDvGAPRpPVsDXkD7nk
	HCP+9RRH100QsfUJDirDcrPp9Q0GpFzY/OqrDTl/MFFIoGUVlIOziLEE22ckjnpOzHZj5AxBQ0T
	DHkAd5FU=
X-Received: by 2002:a05:7022:e02:b0:12b:f881:d8d0 with SMTP id
 a92af1059eb24-12bfb7459f4mr7362897c88.18.1775535452787; Mon, 06 Apr 2026
 21:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775207252.git.wangjiexun2025@gmail.com> <e597de49d761fdc6961f49d638ce26bd3f74e988.1775207252.git.wangjiexun2025@gmail.com>
In-Reply-To: <e597de49d761fdc6961f49d638ce26bd3f74e988.1775207252.git.wangjiexun2025@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 6 Apr 2026 21:17:21 -0700
X-Gm-Features: AQROBzBAHphE4lXXMiSCwDLdeWnZAvHZv1I7HbyYfBZBXMGqnInJjFrg0rjys5w
Message-ID: <CAAVpQUDe6cg4fNVHjy+EdtCUj+oEbi_2ohz5PVkNZmcTfS2kDA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] af_unix: read UNIX_DIAG_VFS data under unix_state_lock
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, xemul@parallels.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, yuantan098@gmail.com, 
	bird@lzu.edu.cn, enjou1224z@gmail.com, wangjiexun2025@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275861-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,parallels.com,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 949123A9AE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 6:53=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Jiexun Wang <wangjiexun2025@gmail.com>
>
> Exact UNIX diag lookups hold a reference to the socket, but not to
> u->path. Meanwhile, unix_release_sock() clears u->path under
> unix_state_lock() and drops the path reference after unlocking.
>
> Read the inode and device numbers for UNIX_DIAG_VFS while holding
> unix_state_lock(), then emit the netlink attribute after dropping the
> lock.
>
> This keeps the VFS data stable while the reply is being built.
>
> Fixes: 5f7b0569460b ("unix_diag: Unix inode info NLA")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/unix/diag.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/net/unix/diag.c b/net/unix/diag.c
> index ca3473026151..76b2c48137dd 100644
> --- a/net/unix/diag.c
> +++ b/net/unix/diag.c
> @@ -28,18 +28,23 @@ static int sk_diag_dump_name(struct sock *sk, struct =
sk_buff *nlskb)
>
>  static int sk_diag_dump_vfs(struct sock *sk, struct sk_buff *nlskb)
>  {
> -       struct dentry *dentry =3D unix_sk(sk)->path.dentry;
> +       struct dentry *dentry;
> +       struct unix_diag_vfs uv;
> +       bool have_vfs =3D false;

nit: Please keep the reverse xmas order.
https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html#local-v=
ariable-ordering-reverse-xmas-tree-rcs


>
> +       unix_state_lock(sk);
> +       dentry =3D unix_sk(sk)->path.dentry;
>         if (dentry) {
> -               struct unix_diag_vfs uv =3D {
> -                       .udiag_vfs_ino =3D d_backing_inode(dentry)->i_ino=
,
> -                       .udiag_vfs_dev =3D dentry->d_sb->s_dev,
> -               };
> -
> -               return nla_put(nlskb, UNIX_DIAG_VFS, sizeof(uv), &uv);
> +               uv.udiag_vfs_ino =3D d_backing_inode(dentry)->i_ino;
> +               uv.udiag_vfs_dev =3D dentry->d_sb->s_dev;
> +               have_vfs =3D true;
>         }
> +       unix_state_unlock(sk);
>
> -       return 0;
> +       if (!have_vfs)
> +               return 0;
> +
> +       return nla_put(nlskb, UNIX_DIAG_VFS, sizeof(uv), &uv);
>  }
>
>  static int sk_diag_dump_peer(struct sock *sk, struct sk_buff *nlskb)
> --
> 2.34.1
>

