Return-Path: <netdev+bounces-294552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3D7fJcjAH2rEpQAAu9opvQ
	(envelope-from <netdev+bounces-294552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 07:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7560634648
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 07:51:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=UIjvXSEl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294552-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294552-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C9C3138F05
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 05:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D6D3D0C09;
	Wed,  3 Jun 2026 05:45:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B2394797
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 05:45:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465502; cv=pass; b=YoXQegYvnp10gualICmQj+4JB1OaYr4y9IJuopap7WHewh1hV7RH3YmeRarlg1R+DZ5gkidbf66299uVukWoKilZ1cN1DFn3N/zfzRPWhrxizfd2rS5PzNATi7/IoUBrmD4Ba+1whX3J1TeC0nAPzo0q4+MeeqaroPkPEh2ehs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465502; c=relaxed/simple;
	bh=q7sXLUgCYAJNFOzBXxGUQn3RNQs4UjMR4X/4Y2mbink=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaxNMNHudI5x2S2O/VvpFk9wZOi7KSocxAPA8J9l1P0zpPbT7uE70zSgFeD9jeFsdTw6rqo5wShimwgywSm4UOEHWqALFWAFIuH1G3XFORMVE2MRXHvCWBv3jONJwgxAfk25c+8KGO0OIwOqXnLvs8gHvqRJ0nPXCqtIrT0WdCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UIjvXSEl; arc=pass smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5176fc0cc72so13563251cf.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 22:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780465499; cv=none;
        d=google.com; s=arc-20240605;
        b=jMuEOgh2aA7XbQ5SqF45oxrnbKhqMS5SdUKcYmU0N2vjq73UecJTAn2sSWBni2vZ5/
         xiejvEoaZl6o3HaZKskQzW4w1gr/OPhEVSyhppQ3YevkkJE/AbITNYJP2I+wNiGcgLTU
         AEnIq9zVfwVZKPCXCLtvbvuRm6Ah19meDzzEBLT993LvDetAD0492JyGBi3rxIdR2JJ7
         vG4w2YlxxaMOnqian44WKx68se8WBH88CQ7A52B4zonS/JUtYQpfh16c9DGktOpLu2xA
         KbqAO3nDCFkwIiFKC7NKdgUUVoQy1wvDxrftERRp7yTmJHGRplh6pijqjKXDLKAB4bUZ
         dUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NOSw8ZQnOV7yjpgB8BcONy1T5k1e8Oor4oTc6XVPx5g=;
        fh=JuUjbNfORtNVAwbgB91/4+PMWM14BrplNlw5PZf4ww8=;
        b=e12yrbOQkt1Sdt8aoK/Zrh6dP6i8DMkRcjpbed/5mRazPICwFyM+YafhEevhb11NAi
         k/vrhieZ81H4fGc2BqAWADq2NerRMv5400z9lCKENi7xIWY+wCkTMGaiYe4sFhAAn23Y
         ktVZdZPs9+nWFJ24GySrx0iDcAyxw6RkElh3Nv/klysx5N4AgDTP4vWY9SbjrXt1tDsG
         lous1Q8ka03tvBEUMIelvQ+albiizNAto5qelWUfXVvrJhyq/4WKeAjG83olY1+i1UbW
         MWSxHcuejOrAk2gaq//Lg1o5Tm2X4o30JKtX+uTTtBMaa3P5FKRWJqMOqWGQ8qBYkpOg
         2vQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780465499; x=1781070299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOSw8ZQnOV7yjpgB8BcONy1T5k1e8Oor4oTc6XVPx5g=;
        b=UIjvXSElAz82EYhxpyQgdFNsgE0BIYLu1yJ3IJFj9IuKXJF4bfyhZpM7qLAWg98oV3
         SjzfObWi+zARYo9zZPZwZEQgVLbO1bdD2FaZLRDV98idfCcTClJMB5SzzKgz5ZZT33wX
         XlbxAe9aBJ2iYNE2kIe9fE8kBYDtKhAQajM4EnSiG48cW4GAmJ7TGEJtpI/lZEGUgrqc
         cMdeRzVFC8vo45jbsRsseJKodKQ5gzc/HHsxhRPkBmSlVRpp3uqByBJawwBLd/ZVTk7w
         t7ReynFo20qlnBKGLQR38Mvw8JqGkqGiJmY0B0VzHVu6firjSa3jEjyjyMQBAfwZUVJp
         Vk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780465499; x=1781070299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOSw8ZQnOV7yjpgB8BcONy1T5k1e8Oor4oTc6XVPx5g=;
        b=qlFGWUhjYtBxJ6pdE7QwuFecoogcbR+Ji4nHU9Rdx/0nyJ+FaFFHf2rPT1s4NU/TcN
         aYRuiiw0eZcJ1TX8dx0mrf4RhRhZC0V2mGG8sUa5EG80EhzkoBHB1p1SrLniODXYZMqo
         m+dEfsp9BPpCAyboxiv9JWQajFh8WJ11QqfFBpGMJDgJppUQAy43gRUWJ2j+946Drw+k
         Keu8d8OJs2G3szjEdv0wqBhm2ZEkGLXq6Au2s69CQcCkCf+SvKZFmTtIRLJDSuWmvSuR
         YoOSmyt7ppNDKIk4lTNW5UyD47gRESOD3Axr3iBmN0V9ZEtbOl0aCGPnDdsm8A9hwwXo
         Oc+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+DDrpCamm3n9kHILnxy72I7T1qsNur83UguN/JnDNckpHYCnPuuYULKF4Y7kER7xoLUXFwKy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ7fGqgpgfPzk3J+qkLdz1c80M9cprfXCitwlaPz4P3+yUdrel
	zT9OCNrg0jdCRDLOr/0+FHziHCvz9ch+x0VvIm3RJ4b5ulGtYQ+KS8RgE0GhGqwjvZg2avckOr0
	Uo4bKOoSAY//FtowmFvOrF6iANe5RmTBlQErj+iIv
X-Gm-Gg: Acq92OFysQZZQaI0VXgUV8hy6AC1+4CP9Ndf1UG11fXgev8JTb7gLThVjwAtCLr1Ia4
	nlyIAWs3quyQlPX8JDsSvWQm/uDKVQI5s04vv8ZnG3jdDQRQkeRfoSY/Nx0TGsbKBf3RWiVivaD
	N3oefKIxECpr17Lf8JSwcE2FiMp2PImWjagSMlrCCPjv7YHVtrpgaUAJo/l7Q/F/yjROIElYAot
	bUC0VZLvZaq0H1tp1x3mONw3yBLqj6CqCYe8AWh66ILyl24FnOIeh1JzV336t6ojGOr4mjQjxJK
	QPG0iFpBaCnRNiYxpmKI2jotyOL77t9hrL+b+QvyBg9mEodleEEAO9UtCVSvM3sHYlAGbD28ZyH
	FjWoDmqc0+y0k/wMSnSQfZXHhwyu1zJ9ffuN00Ec=
X-Received: by 2002:ac8:5816:0:b0:510:1325:32a0 with SMTP id
 d75a77b69052e-517787cda68mr32387201cf.56.1780465499109; Tue, 02 Jun 2026
 22:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603030810.3593625-1-yun.zhou@windriver.com>
In-Reply-To: <20260603030810.3593625-1-yun.zhou@windriver.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jun 2026 22:44:45 -0700
X-Gm-Features: AVHnY4JH8PHa30_lxQ5iUcrQon-2PPMj4ELyTyxSTEKMAcuj7MtOEPJiWN5hNDg
Message-ID: <CANn89iL2OnKcFOV7hHON=70670bC9vsUXBFm3nADU89qgepVfA@mail.gmail.com>
Subject: Re: [PATCH] flow_dissector: fix uninit-value in __skb_flow_dissect()
 for ETH_ADDRS
To: Yun Zhou <yun.zhou@windriver.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294552-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,vger.kernel.org:from_smtp,windriver.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7560634648

On Tue, Jun 2, 2026 at 8:08=E2=80=AFPM Yun Zhou <yun.zhou@windriver.com> wr=
ote:
>
> When dissecting FLOW_DISSECTOR_KEY_ETH_ADDRS, the code unconditionally
> copies sizeof(flow_dissector_key_eth_addrs) (12 bytes) from eth_hdr(skb).
> However, if the packet is too short (e.g., a 1-byte packet sent via
> AF_PACKET on a TUN device), eth_hdr(skb) points to uninitialized skb
> memory beyond the actual packet data.
>
> This causes KMSAN to report uninit-value in __fl_lookup() when the
> uninitialized eth addresses are used as rhashtable lookup key in
> cls_flower.
>
> Fix by checking that sufficient data exists from mac_header to skb tail
> before copying. If not enough data, zero the key to ensure deterministic
> behavior (no false matches).
>
> Reported-by: syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com

Please add a Closes: tag

I found some not relevant syzbot report :

https://lore.kernel.org/netdev/6a196faf.c16d89a8.217f2c.0002.GAE@google.com=
/

> Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addr=
esses")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>  net/core/flow_dissector.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 2a98f5fa74eb..d5817b800079 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1173,13 +1173,19 @@ bool __skb_flow_dissect(const struct net *net,
>
>         if (dissector_uses_key(flow_dissector,
>                                FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> -               struct ethhdr *eth =3D eth_hdr(skb);
>                 struct flow_dissector_key_eth_addrs *key_eth_addrs;
>
>                 key_eth_addrs =3D skb_flow_dissector_target(flow_dissecto=
r,
>                                                           FLOW_DISSECTOR_=
KEY_ETH_ADDRS,
>                                                           target_containe=
r);
> -               memcpy(key_eth_addrs, eth, sizeof(*key_eth_addrs));
> +               /* Ensure the skb has enough data at mac_header to cover
> +                * both src and dst Ethernet addresses.
> +                */
> +               if (skb_mac_header_was_set(skb) &&
> +                   skb_tail_pointer(skb) - skb_mac_header(skb) >=3D size=
of(*key_eth_addrs))
> +                       memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*key_e=
th_addrs));
> +               else
> +                       memset(key_eth_addrs, 0, sizeof(*key_eth_addrs));
>         }

Can you show us a stack trace, why mac_header would not be set at this poin=
t?

