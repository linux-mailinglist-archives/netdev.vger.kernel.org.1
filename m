Return-Path: <netdev+bounces-276232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOjRJ1yy1WlF8wcAu9opvQ
	(envelope-from <netdev+bounces-276232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:41:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A09E43B6012
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 679EB3004D82
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 01:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A69F344023;
	Wed,  8 Apr 2026 01:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGqFnd9b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75301448E0
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612503; cv=pass; b=E0xteygqY/9agzq6afkZA+NKvmlHvnIvJw78lVvvOQcxsmfOUDxVGT9ydiVxo9TLm9rNYtOeioXlVvLoatkRqCualRh9ZkfIIZfrXO14xW4tMMERLLqSSx6a7mru5wurgKApgdo/hyNRLhBBjpkyX7fWsml/1gmf3GNr4cTnU5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612503; c=relaxed/simple;
	bh=5MlT58hfS4caY4q/4sk4eSUtC8qLMW6P9xHmoBbwENs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+aurjCg64SY73pLHL72fQM/STqwL/ROmm/oMy/HMJvz7y1ub9qBZEWHvlCS8/6Viy4bvD4aqJjuoiL61ekJakdkVArsoJ/ZnRTpKuPCxvsrc+uzpFfowQhsgOQ18sANUPed8Cg4cWa50LEckYqhheCjLpcHI8/4nPoMV8CV1SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGqFnd9b; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c20010f10so1060007c88.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 18:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775612501; cv=none;
        d=google.com; s=arc-20240605;
        b=lc/E2/TyhNb2HdKSuTOkeZMBk5xkiag5LbX/2jEW3zX5ex6Z0ZjRogYbkvd+ynFepP
         v0FwXxnXbAoZj8UkfVg2gKyNWUYIymvDQhBFeNtqVM/wDmCcZza9lC2oNPCwQSFJINHR
         yWOPFh8xBD8xWkv1mHM7B/rZKIThajR9l+kHA0Pp/G0QPzOn4baEGntPJbsgf6Ah8Rdx
         JZ9iDF0MB/UfM0eMJN3MTNpWrys+11qy3cSNDPosgSN3lGviSAPJM/MFMyQdaN28AcDC
         yQSC1RpwoiDTg8nKTKFc618apcdHs7sQVY69fR+iupijrDXrxQzHoBE/U/dA2gwPoNIc
         l76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wzk8OjbF0P4IbV3jecTkNRUesUvMPLzyGDTALY0f1NU=;
        fh=7HfJqo4yIBpdTKM/B8vkXiFgqqNi5t65ByLUo5vMqiI=;
        b=ESjn/yJsjokc45/ddhcA///G4Ne1PtCrWa6mRqlRCGNiG6BTbFl0BzNP/hn1LC8xMv
         zgSrK9a8xDwOaJPnbBVaCHk8TgFTRqBvnNDnLQKXUhtH2imi0Nbo2BdH/iZ6+12s5BhU
         chRfKzdzjYfKvDj+YGuNIjToi3L0j34FTMKU5LYe5ms816xOCZLg1NiJ5H2LmNk642Gz
         4Ep7vFE0km+iH7nOBa2xfjRbSaAHRG9V5qotAQBxBq6A65WdX/wGBSwcGc5f6khFRCCZ
         diU1UyFHcACIYFb22Gw+mKgG+TrRmSdK9Yy+W5tRAkY7wSv/805gaOESw+DvyibtgiDg
         ttUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775612501; x=1776217301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wzk8OjbF0P4IbV3jecTkNRUesUvMPLzyGDTALY0f1NU=;
        b=vGqFnd9bllxb76ODsF9H/AK03NouIrn2bWdK0/2FbCFO6yEp+tOSFy3rmzRVXYUyc0
         rv1RIIfYWOfho6/CTGjdSQJbxESCKPCQHFKklFievEAbc4Y0Wrn9YRoERB/C9WbqOqzI
         ZJqiCab7hf+qKEj3SVMZDYw53SkWXsCLPAa7URMPBtoJrXWGxCUTrqruep1PLChzYkr1
         fn0Z4A2Cp12M1Ho6o9X2g0NQtS1ShcZfOq+27lI9+piLBMnZ1KZ6kT51j4vEPTzsmyCU
         2rFpeBdnmvvZCTfgs4HeGlk6YI1ksbTX4mUIgDWjr0I+QKnwagWGzp642F4ib3N7nOi2
         yFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775612501; x=1776217301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wzk8OjbF0P4IbV3jecTkNRUesUvMPLzyGDTALY0f1NU=;
        b=sb23849TEKLIGmwGcUztkQ7GcQjD17MIMVy7iMkSxiG4eLJFVSRQbLabj3qFwPaHG8
         u30uXoXsCWhRCkVhJlfPBD8t2kUyJ/BWBpsMBDIReTSvUHErvgaNiT8+is4aLahnBPcV
         3S2lndkR2KjBSQTxhbRejXjArPmW3nLwFG8Roe9dJLeidxNG6rdw4ViqjMh4LR708zrU
         dkBHIBuhppM7iQCkA74GLF1iW0OB49kZVH3IFe+KSMX5s5ivWugpvafmxrRROz0+HpOu
         jBiVhb9c/Pdk/m8xoqDDv9OQiD3XmgzWhGZoq3bRBcuUsR22smP9519uFIxpPQK6nqH7
         aK1g==
X-Gm-Message-State: AOJu0YzPimb6n7OnfUmqjUN/uNXM/sR+i/W+ynFeF89iyoQqioBCwqS8
	bmj9judTtE8164fJOrFYIqULIjCbmumT1nunj8MPqZu6I2dh4Fpge3ZQzViqxALkt+Kbg5Dvwpf
	97upQyw1mwoSCnbJw9Q6vvQS/quR/WiQYk6Jgv/E3
X-Gm-Gg: AeBDiethuaA4mRJ13tDioXQzyTUwbHslD3aVtVDQO1mJQX2rFLJ5B0EBWyAOPPZxzTa
	qJdH4ubm/oZV18kqChHJVpV3iqj2xQdbhqgikKM/KEew5xwFNou4Kht38oFGNbLT+pqlg2Kj0PY
	IQ4mKG7R3CKnslIZVZvUaAUkmhKaUKPRykxDbL82FYrCSs6+akkXfXymZHztwDJtShxXZcjWWkd
	2zRlGkF+1rgFUaGvcVx66F9i0o4iiaEeBzShcHJytcsJg0Vl0kVO7uWvSiIoo9c7DGgXbDA+tlS
	9jnrqpnGEMLoAdRZA6ByrASB26bFu5o92y9gJmc0VpVMqsdDAaQEQhjWUkDDxI29Nla43q/i
X-Received: by 2002:a05:7022:2221:b0:127:33e0:ea33 with SMTP id
 a92af1059eb24-12bfb74c9bcmr10411353c88.22.1775612500296; Tue, 07 Apr 2026
 18:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775207252.git.wangjiexun2025@gmail.com> <20260407080015.1744197-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260407080015.1744197-1-n05ec@lzu.edu.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 7 Apr 2026 18:41:28 -0700
X-Gm-Features: AQROBzChHTxrWH1mkvCH0vaCf0kZJrV-ZgG5oD7uEhiOXEgPkK0lHWR4AAfT0A0
Message-ID: <CAAVpQUAGm-jSrt4mEP-58gfmNgOjW8fX2hHVdiOM6tE06KJGKg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] af_unix: read UNIX_DIAG_VFS data under unix_state_lock
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276232-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,lzu.edu.cn:email]
X-Rspamd-Queue-Id: A09E43B6012
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 1:00=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
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

Looks good, thanks !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Next time your team post patches, please make sure
to follow this guideline:

Documentation/process/maintainer-netdev.rst

(e.g. post a next revision as a separate thread, etc)



> ---
> Changes in v2:
> - reorder local variables in reverse xmas tree order
>
>  net/unix/diag.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/net/unix/diag.c b/net/unix/diag.c
> index ca3473026151..c9c1e51c4419 100644
> --- a/net/unix/diag.c
> +++ b/net/unix/diag.c
> @@ -28,18 +28,23 @@ static int sk_diag_dump_name(struct sock *sk, struct =
sk_buff *nlskb)
>
>  static int sk_diag_dump_vfs(struct sock *sk, struct sk_buff *nlskb)
>  {
> -       struct dentry *dentry =3D unix_sk(sk)->path.dentry;
> +       struct unix_diag_vfs uv;
> +       struct dentry *dentry;
> +       bool have_vfs =3D false;
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

