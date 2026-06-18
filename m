Return-Path: <netdev+bounces-300507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uV7ZExwpNGoUQQYAu9opvQ
	(envelope-from <netdev+bounces-300507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 19:21:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB86A1E42
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 19:21:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OTM+26u8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300507-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300507-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F02A30148CA
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF8280A56;
	Thu, 18 Jun 2026 17:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FC45BE3
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 17:21:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803286; cv=pass; b=iTM2Km0NecEmuCIDJBOY45m6pzQEgRbPNyCEy0XdP9z6bNX1+P5m6qVSv5/AUMFcFq7iajis+vP6lZw2DwWVvG4B/GCHWKUf4ZFjBTOgYFI0DU9ys18tcy/nPcEWONhv+6btg6GdY0SceXBjeYaBeVoV/zfsBl9yBmmng5vD5pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803286; c=relaxed/simple;
	bh=SNVxKxZtm6MtxffewaIGtszjj8gQJpxWGCiafHK4u1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsUNzBw4YUZwLF6UAqqkLNQ4X5mnuOFcq34JD0qXRk6koQnmm8i935pPOXplTWYO2oszwtxnRskvC83VFrH4oPbCerFC5wR8GB7wiNscJiW0sH7D7i3xpisTE1jqrf/vFmMvQEqSAnfeqxmp/AqcH+AJeLT+6/8r4cXhPy0S7ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTM+26u8; arc=pass smtp.client-ip=209.85.160.51
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-446c53679cbso877146fac.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781803283; cv=none;
        d=google.com; s=arc-20240605;
        b=FqCR4PrQBNUbuwLGUHlo1NyoVl4ma19iuLYCQQ9+51mrNE7t3Z97obo9dcl0FamfQA
         GylVXdqhMZ661xbXlpmFGL/vsngCS1cLW/cJkjVFjw6PVzPcbiRdg6UAPXttldcLvj6f
         kkmtMNO+NzbsLZ9nVEl3pB0cydfSdYfJ9TBJN8QMWRWKjoNu2kJtakmouyqCL641js8I
         XQg/j4whif7ycKG5BI840huHSTo15BjXVUbizx/OAaEpyfdT9C2EnindciwKGOQiu9EY
         N8pN/DouWZkMJdFOVNk4tPcXHvREbPI6hhiS/64INyVYyhMSwLTxAk01mj8RnvNol9B4
         yiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T6a3eE2IK2HV0Y82Cb9fPT4nILmvz4oKCqUQPin7x5g=;
        fh=QnFjqanEv1yzH4T5rB3gKgkxI+NSQULsuJfGUE/whMQ=;
        b=UJwfBjr6XJaAtAVXNjqRHKvYsaV1A2cDrQ3h5178IHJJVe24D0b9UTZ2ZgvLP8IDzA
         udcodQ+7Y0KBL4mk6jy0h+5RFIyO2tBd62muJX06mIQABaZzY224JnL+xqkWks9AfC6J
         NoCixwo6Gu06KOltDlQHL0hNn7ZDJkGVEobwG0RYmHSr5UEhs7Rz2gLx1VGGbq6YZafY
         Q//T8/F4aTxW1iubyzh/+4uQaeqIPfXe38JFLAGrn/xpTMPOCPgn/BVeenLeB3Le8iIk
         iya/bRysDcDHCFajoCZm5ulyVpQLfChjRneYcPx0nisWgq7TMTp8GiLWRNi+/C26dnUa
         e62g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781803283; x=1782408083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6a3eE2IK2HV0Y82Cb9fPT4nILmvz4oKCqUQPin7x5g=;
        b=OTM+26u8acbtvl5XiC+aWAO0p2jvn7O9NDUcr6zsDv2G/JCnF96q/2H/wENfb5DQIO
         phleS+X/P53FT3yRJjjXDKbwMg13X8hVugIMfGqFdcX7psELfT/F+jyXSDQXy/6aKIbv
         g6W+0jb1hTJRCBNyv/czyOXIsz2WWQdK21224pOTFBVoXBNd9G4oGNhKp2P4QiscNg9K
         jAValTkrG13Z+KJ/wr/sTFFpZSuQjCT558x9jJnueKw3mS+2KA/RG/wtyp6ePZowCPva
         w005SizwxHoDhaKXvV5pT4IHzUwRvcNFSlspcWZd1iBFhPeu0yqc8zd/0/Zsvw4aANrm
         zw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781803283; x=1782408083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T6a3eE2IK2HV0Y82Cb9fPT4nILmvz4oKCqUQPin7x5g=;
        b=liuxEBAoQeCzUasSv74qLVm3XAjO9FnJZsu+vR+I7F/JoTmiYemod6RW2Kkj0tfenA
         PIIshV2Q83s3FxSzbSQ6WZS3YDGbFfa0kbcWLG6kp0PBit9i3vHOBcQ+sNiUSYX+ul0t
         qqdkd9fJKVc7s5qrERs2stclEEUlDZIhQ7kjghKl0KzeLdFIRvy0Alquv+3eHmzlyWcC
         r/+CNqCsKo6Dvz/Ow9qVDemENAFWY3h2g5qUu6wn5yfEH/JL4Ethoc4uLXF9jbKzUriN
         RVO1eR7H/egd/QF+gji9qXAa2opMl64bB1qCHneQ8bt7YnIi9D6rNx11jX8ME2kwt65s
         WT1g==
X-Gm-Message-State: AOJu0Yx5d0YI8WXFRq7Un4b392rSNYnpr0mPDvw83pp9hKgfl7Ae1pck
	vkYaT0ial4abTBEEpOMlFOP10pVoKSHMKJjf9xRotcLqFJ8vQo1J/PbNXBU/wPrO9LpTYA/NVWO
	PAST3NYcBLrnVcXoDuiVXEw8uIUEjZG4=
X-Gm-Gg: AfdE7ckK35kVqHyAMb6w2e/emd6AUlBehWBGNkdvH7g2z8jgnig/IV9NL6c8zHO8p6Q
	mepkPZcsXAzuRxWPiH3eJ7Ww/6JXxHKJtL+3cgiN/+Zg/fxC8h85ZpMB12JryCpxQFdG9Vco12K
	uxohr5L5Y7e+JJZLx7FWn4OF0Z8fMAGrkkCF7tTGTslAF8ZNieIADpgvHo2sKJ8eN+YFkmqOw4u
	dEwnxtG43kkJZij4ZVs165L8voz8bCmaNa7Uyp7AG1PlXX3E9kCNn4sXCl5lNND97/yMZhe
X-Received: by 2002:a05:6871:c8c2:b0:417:3441:6c54 with SMTP id
 586e51a60fabf-447072a23d5mr305707fac.27.1781803273620; Thu, 18 Jun 2026
 10:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781788385.git.qianyuluo3@gmail.com> <46eb334399ce0e25e0897b42f21020541d159300.1781788385.git.qianyuluo3@gmail.com>
In-Reply-To: <46eb334399ce0e25e0897b42f21020541d159300.1781788385.git.qianyuluo3@gmail.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 18 Jun 2026 10:21:01 -0700
X-Gm-Features: AVVi8CfKd8MaV-dXfJPQ83kkQDIHa-CA9lvn7QfmSo5DJWJOfbSl3Ch_eKDsYUA
Message-ID: <CAHsH6Gvsf-JEQyetucAVT6mjaJDi=gMT1pDWFDagb1fhjmveGg@mail.gmail.com>
Subject: Re: [PATCH 1/1] xfrm: nat_keepalive: avoid double free on send error
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, yuantan098@gmail.com, 
	bird@lzu.edu.cn, qianyuluo3@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300507-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[eyalbirger@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,secunet.com,gondor.apana.org.au,davemloft.net,gmail.com,lzu.edu.cn];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:qianyuluo3@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eyalbirger@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lzu.edu.cn:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49EB86A1E42

On Thu, Jun 18, 2026 at 9:36=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Qianyu Luo <qianyuluo3@gmail.com>
>
> nat_keepalive_send() frees the keepalive skb whenever the IPv4 or IPv6
> send helper reports an error.
>
> That cleanup is only correct before the skb is handed to the output
> path. Once ip_build_and_send_pkt() or ip6_xmit() takes ownership, the
> networking stack may already have consumed the skb before returning an
> error, so freeing it again is unsafe.
>
> Handle the pre-handoff failure cases inside nat_keepalive_send_ipv4()
> and nat_keepalive_send_ipv6(), where the caller still owns the skb, and
> keep nat_keepalive_send() responsible only for family dispatch and the
> unsupported-family cleanup path.

Thanks for the fix!

>
> Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP =
states")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Qianyu Luo <qianyuluo3@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/xfrm/xfrm_nat_keepalive.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.=
c
> index 458931062a04..f71328096f11 100644
> --- a/net/xfrm/xfrm_nat_keepalive.c
> +++ b/net/xfrm/xfrm_nat_keepalive.c
> @@ -55,8 +55,10 @@ static int nat_keepalive_send_ipv4(struct sk_buff *skb=
,
>                            ka->encap_sport, sock_net_uid(net, NULL));
>
>         rt =3D ip_route_output_key(net, &fl4);
> -       if (IS_ERR(rt))
> +       if (IS_ERR(rt)) {
> +               kfree_skb(skb);
>                 return PTR_ERR(rt);
> +       }
>
>         skb_dst_set(skb, &rt->dst);
>
> @@ -100,6 +102,7 @@ static int nat_keepalive_send_ipv6(struct sk_buff *sk=
b,
>         sock_net_set(sk, net);
>         dst =3D ip6_dst_lookup_flow(net, sk, &fl6, NULL);
>         if (IS_ERR(dst)) {
> +               kfree_skb(skb);
>                 local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);

Any reason to do the kfree under lock?

Eyal

