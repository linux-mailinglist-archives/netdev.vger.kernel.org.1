Return-Path: <netdev+bounces-292588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKqNKTf5F2oWXwgAu9opvQ
	(envelope-from <netdev+bounces-292588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:13:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFD15EE5DC
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 331403017FA2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACB7368970;
	Thu, 28 May 2026 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ookPXggQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF73672B8
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955503; cv=pass; b=G4YojgpQwzwdA4z9YIaKtdXPIO6Tqx6453iq46Y+iZE8R20FoncPHi7dREiT/iYIqdWzM0jycWukMgQ/qzMvbjZhY4WzBgguOfxetPRdQRq8pKyiXw6VqtRRcBY+K1Qem4U8V7ALnCJQdHEAGvrmoTEwMz68MMMNwbLNXSIvjUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955503; c=relaxed/simple;
	bh=KRbyLL93HFOeDXI8HX7+1a0qnJ60ZrvrzlZlIINQotI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGK62g43OM6Z2QSmDgNCDrUOeSYkam6SgAwfCn6OJgzZ2tCyQ4zhoaSXN7dNsSmO8MJyir62LjkXSKO+dCqNCnFPYrPPRhKn5vZ5xcTn4CqrqvktytLeMvVubnACL+OKthk7PXlqI0iLsdG8gY37bWX8Dm2iwxcSkHKxkFKp8nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ookPXggQ; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1363fe80fe8so7260389c88.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 01:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779955501; cv=none;
        d=google.com; s=arc-20240605;
        b=S5b98wrjjDl5FQyrrCHBbeuL8W6QLoaDqoSwfjXVgbGbG0abMSCnOB9WxK04w9K0oR
         IBTelNJwoFKAVb7fOGpJ5ApaNzC7toxvTo0oImFrZG/zzywICxG/rHFaoUReDEE2/Bq9
         f29oZXUVWW3XDPfIO1PO9WEnYm6peYou81W1fp/hydPLpelOI5Kwbnv/Os0azzv9BVVw
         MaiUkTRoJpZTHy6aCPEh4kwUcuO/PO5VZGj0sNcgrKBeVYeLSuSy+xDkZdVSHPizgt68
         vi4o0wpf//7YlDaJeLZhVUpLXM558c3nSufWJGYjl3NvTACac6bLCch55q5iLypxoy7/
         PHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HJfOIh4KRJb9Fi/Phv9TqmuKbBE21gJDkIwmd5iAe+c=;
        fh=kaC/VbkgzHco1fSfv3p8wBQh7SG94USUBaGKC6hUi0M=;
        b=WK72k0klwmL2YsWFMdJU951wAo77SuTAs8yML9hDpyy+5PWW64C/uMtA93zgubjgGQ
         aJ1J9rx6ML3hvz1XXiHz4lwSlGnAH8wQIyidz/1vJ+2s1YJKXeP53eEbnhlqvyzSvTef
         OtGWsT61IzUck169iAeb2SsBa/lrHJj8jP+qdox5bCvlZROAwV5z/RK/jhjPaNYEou0l
         PFtrukC4pgyd97WqSK0D80F3aN2amJA9QhqdUjM5rjxw2UJKQLXzysY7xRjr4J0ORp7C
         qoOiMuJau04h2VZ7MmU+M4QFPBN9s1fIU9w63VwKOZAwETRkb7xEIjwIwkwv8fxzxVS6
         BU4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779955501; x=1780560301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJfOIh4KRJb9Fi/Phv9TqmuKbBE21gJDkIwmd5iAe+c=;
        b=ookPXggQgSdkZaYnpSsgzxy2tAdSNmD1DUl9MmmZVKj747lak7Dt7kT7n2BsuZ5q2h
         fU/U4XQ1+oJW+CMNLRNdQhKlRPzpIfWHuWzn/zYgfVkKso7jK1aT0qZ/jKITW/DCRa15
         Q0i4NWbkkJg/nW8RaAHXE1E7vFdxCE0wABKbnDRBWsfAQM7wApbn+2vDvDw3Q8vttvj1
         n0Ew+B4FYI4AS7eL+7YF2v2XynBtuNBFfOgc6itODDa6rvgMEjhm3PEcXNLUhIhGuOTN
         VN00Q4f1OaCFe8dBBJIuvL+NvHxhOIfCPGsCW5X45inGcbLI8dbarSm5UtSAPFCFgRRk
         XniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779955501; x=1780560301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJfOIh4KRJb9Fi/Phv9TqmuKbBE21gJDkIwmd5iAe+c=;
        b=htChBb4Q3pGqnmHvvwd/idoLMG0wuwLSn8wBSBz5xmJmsELTPUu+SweAzA4JCbq2TS
         AQFjgx9XtroceNb5VXBqSR15tVU4My5k2e/FGtU/91weBRXlIWX4W4Mkmu8FNl9yHDbt
         gh2kKhbhdt3Buc/LKFgQ9qLP3oiLglC3qARK8azxgYiHBq+pJxGI0bj3+2vh20lDDhfo
         gANCpBq12PFKJvs/IPd/oLQMhC9mSQ9i0TFCuJt2DpAPUSQWiaoHkcRtEbHbmWGmZ3wK
         tadlvWVU6GiSHND6uGKXVPwdqD5jz1KTq1LS5jhksMYULrSBd3x6pUL8lPSdAfbnL1Jv
         Z96w==
X-Forwarded-Encrypted: i=1; AFNElJ8z5UqTcwoUC9geQrMxVzJyP5Xj3bz0MM/HXDC75Eq58ovaDSlWvyz+31rtE2tP9hTg9TyVob4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1LmEZAE8S45u5cLQnmGhurljvQdAYZ+d/pN9DEntJm7B8+uAh
	CTFJindggRWoY8TH9MmYFqkF4NaNOCtCMqOyg1CPw4FLtrdG5UhVWNervwpC+HWopzXVJ7r+M4z
	BNcqFkaowYv1G4E5z1U3QzhfMXe5ERxdktlnYKQos
X-Gm-Gg: Acq92OHEi8W+lpgL7TSMLxzXBLFSsc9HzkKGmAEW+EJBdL7168GTu4/Gj8BYPVpDiAe
	U7mRKqCMr9fw8QmYJkszzYGTyapf9CPxnjM4lsXsMhwWGB1+OVJdhEFphxS/iHO7rnB+bG5n7ym
	iOIBs8Q7sAuulgzXqdMWYG3zDoVBlEw5eE/BQ/9cPfEAOA+EgxITMCIHlir2n1VZ+y3cykXUxr5
	ddHnVKAaGRCB3xS6Ciu13Fo6lXqP8Vmi/P2+U4m7HTIVanNtYntS8+y4VQ2YjPifhdJv9EL1OdI
	QzTqD75tkHbZY3+o2+yMr/QnOFL8+MrEqNnYQXR6nj12ah59XJomRNB633ufY9ZV5avMcGUveq3
	gMauVZrLbzi9c35kC/6TVdySMcb2fT1Mn9NQuulW+2FwTFe+s7IUXN3rRRLjR
X-Received: by 2002:a05:7022:48:b0:136:c77a:64f3 with SMTP id
 a92af1059eb24-136c77a6b4fmr6992851c88.5.1779955500587; Thu, 28 May 2026
 01:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528073614.1169858-1-vulab@iscas.ac.cn>
In-Reply-To: <20260528073614.1169858-1-vulab@iscas.ac.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 28 May 2026 01:04:49 -0700
X-Gm-Features: AVHnY4IcFEPUl3BCCt8xH4egeGxTpseLue9B6WUPH05zlrzruz2LwLDKXI_Xr2A
Message-ID: <CAAVpQUDMK=uY16vwCDjC0hN-BCVAD++WGpJgJrmmNKtqQFJU9w@mail.gmail.com>
Subject: Re: [PATCH] netlink: fix skb refcount leak when dump start fails
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kees Cook <kees@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292588-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 1CFD15EE5DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 12:36=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> __netlink_dump_start() takes an extra reference on the received skb
> via refcount_inc(&skb->users) before storing it in cb->skb for the
> dump callback to consume. If the subsequent netlink_dump() call fails
> (line 2440), the dump was never started so the completion callback
> that would normally release cb->skb will never be invoked.
>
> In this case, the function returns the error directly without calling
> kfree_skb(skb) to release the extra reference taken at entry.
>
> Add kfree_skb(skb) before returning when netlink_dump() fails, so the
> skb reference is properly released.

Isn't consume_skb() in netlink_unicast_kernel() the one to free skb ?


>
> Fixes: b44d211e166b ("netlink: handle errors from netlink_dump()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/netlink/af_netlink.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 2aeb0680807d..d904c1aad35d 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2441,8 +2441,10 @@ int __netlink_dump_start(struct sock *ssk, struct =
sk_buff *skb,
>
>         sock_put(sk);
>
> -       if (ret)
> +       if (ret) {
> +               kfree_skb(skb);
>                 return ret;
> +       }
>
>         /* We successfully started a dump, by returning -EINTR we
>          * signal not to send ACK even if it was requested.
> --
> 2.34.1
>

