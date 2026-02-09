Return-Path: <netdev+bounces-257966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGJpFTMbimmtHAAAu9opvQ
	(envelope-from <netdev+bounces-257966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 18:36:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD46B11317D
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 18:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83D30303FA94
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B23815FA;
	Mon,  9 Feb 2026 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6dd0ZKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E481437BE8C
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658560; cv=pass; b=RX37BH2mCJruN2gI253WSwaE3WPDueCUcXHbk508CIHInioKMPxX+laSVj1k/7xxl9yuCJjvOrJc+jBrVFwjhkJDUIQ1xVOA6XWmU94iTbpevMlhHEbUe9qFogae4XJe3MxGgqUxDjpjX+5m1q5BE6I5Km2guWHAQ3us8rsQOHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658560; c=relaxed/simple;
	bh=Zza6fG/7gkBsCugMLdhsSdQmEhlcQmaBEf+6pifPJ8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpODM2uu2+b8844Wmhp+Z8dIAXEFQFVsA1TILsglXcONWrYZX4AzlDeX1dlYm5U/6/x5eF9/GLzHRtlVquf0o46PtyXCT4xpiX4UrD35EOCxq2sDo3xPVKlf2/42dHTEZ8HzcOBTc1I/BsA9+eOJgQBUqEPzcwp0sdPvp64ZaaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6dd0ZKh; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-896f6d4b6c1so21581286d6.2
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 09:35:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770658559; cv=none;
        d=google.com; s=arc-20240605;
        b=ULPg4q2gTu2eWFiLR5PmWEKDxNpJL5z/TvvuZI+1w2RR7ksXYlQ1Y+OmmZwdOyHaJA
         u0GYTUrBfWeZDWEb/fbMOnAU4j9oc9AgGZSR4Dha6+xbppXqjzUS5g2EQhnEv7BerDXK
         de2X/tsYUXEhQgI8bAqr/kf9UQ5D0tTVB6/eC1REoTC68u8ZhhvAzTek6TBizWtxAF4A
         oXKBM9BYYrl8RoJP1Atw1wnlRV3KnM0ZD/HfRVPYvk4XNR5Rp/F1ncPSnK+IkBm7I6PP
         w2ls1QeSaopRxlT5pupDuDjFaVMPZvdh6xO0hvx0CmKz1yY49AX249oxEJovezLGcagi
         NNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0+QZaXVkR/GDEUmopJwC7Hm8triH+CsN0ZCixlzal18=;
        fh=4U0INgt2IrfD+PIt+fNKPxVeZnRnzqeb6Kiq2vH0XbM=;
        b=CkQQ1SlKNwDd0pGT46fxz2qIzLMJTm+UhvA8C/KUhiKX9BexERaW4G/y2RdhWrVovX
         356D8kHTJGDKIsg0+HxfD86QvtYWMs8mX4pnLXqsc18RT4u1/boxHHXjkXWiDa1lsRMr
         Xw/yQ7WYcPvN6IS2+K9UBkdtaNtc3biFT/3HeV/ZEEOR9Mdlb4+fh/1MLj0/3vdGlvBg
         +3Z/nFqCKs3HVXAfNFjyqVGPq/hhK09moFhw0096PhFbxSiPb7d/6JUcCTrSQu89ooy3
         aCzxBonmVyw4rISQsLYr4HeZjA+xjpRSFqiiTFYVrO5wuKEeXrD0JaZh2cF+8r09Fl3c
         LsAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658559; x=1771263359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+QZaXVkR/GDEUmopJwC7Hm8triH+CsN0ZCixlzal18=;
        b=i6dd0ZKhMsPOtEN10KLnbynNWvVtT3/4FeetC6uedCt7In1lCqJ8mqAp06f6xmgNnJ
         hjeXURUBQyCLPffH48MHIxdXaIWv6+T0DAFmIW18khadQ4SYJWfiqDJIEDeKUiNCBpGo
         DYxHqmp56fS/rXvi4iiUlRFq7I5dMpUuEa0XqAN326QqKK9RIXh+VrVgHIgFeQSBcDsN
         a/5guaVualNvGgIIFq3RLIc+2Xj+1Zcv+9eOHkFWRlq7Z1PIJH14kB6GkmOgM4HmRuFp
         xt5NiU8nL3asHF3c2xMEHmPigwBDK4Tv/ftmLkehXS5Pu+7UotivImCM8ykgd+4uYlC8
         OjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658559; x=1771263359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+QZaXVkR/GDEUmopJwC7Hm8triH+CsN0ZCixlzal18=;
        b=AcOdhrXHBzj5wcnZlgTcsfL5vud2OPX883xWj82pacqvowGpNAvQkeMtSSr3u1JpAS
         kVnJnB7ZWTuuDYRWIFtf/v1MzRIlkpICJ0yuTzx7hUjMdkaNzEkw5RMH5iYZ1wXJN+Bq
         SoWDSlx5TVGryhZrYMsAg9riKEQauCB/WuStkGIslai8k4YiZ/Eoq97s9ZHhC80loUoa
         KllfcI/eSORV1bQP+SdeU7SS2S0/zG2ltMmDsyOifn4laiGuG7pYygJtupetEf9M7nc8
         99Uudlkt2x4j7DuIcKth/UmldcQKC+wqU5xoMbTGduwr2Gt6TGHA6BXlmSbHzxAMi/Uv
         xsGA==
X-Forwarded-Encrypted: i=1; AJvYcCWN8NyL6EIrzw5mG9cfJV/0EuWc+FdLFDCfZCFGJAlsHYQmC8RVKTBOkk+WfcOwmg0gpdNsPs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNFEfezs5jq/nTAyTbO2LbLf1m9D5qjFEbn2digmKaxZNDPcx
	Z+7up4iqI1pUDfYdYiAGj8a97pX7rlU67Ro16IegcOluEqanwbpHIQGUtjb+osuUM7KUy+y5y5d
	nZAlOYcYtGpspSrlS1Tw5LtkHribbO+42MXkjjt9gw2JxISVSxtMNqGyjQ8s=
X-Gm-Gg: AZuq6aLM0l/V/283A6IvpMpk0vw2kNo+Nl64xPrxv/Ct1czbfwh9+2sGs8K2nJC0UUy
	apYcDy+ol7qrVFC4XhRQMBaEibIpIJR6ZCKSCGD68bKWMVGDYq+pgzBG/Ozy8UEB0aDiX2cvZcu
	LIEY53BVJVlabZ4fiqM1wiwYpMYCG83/8GWJ2R+u/wqK9TpJRihgryYjRUAceJXUDIsytZUIe9u
	1+ozH3yI3OIxDL/CBYT0aWc9DNHoYT+WGdNf9vDACFL+uSRbh6/52L3f5JcKw2DgajOTJV0/1Bt
	bO58
X-Received: by 2002:a05:6214:1bca:b0:896:f95e:65d with SMTP id
 6a1803df08f44-896f95e08a7mr76354036d6.17.1770658558506; Mon, 09 Feb 2026
 09:35:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209162851.11800-1-git@danielhodges.dev>
In-Reply-To: <20260209162851.11800-1-git@danielhodges.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Feb 2026 18:35:46 +0100
X-Gm-Features: AZwV_Qjov3YGswy7_4GGfKAfoL17GR9LASdoCNBKqXkMVUXhf3p5NH-2ao88de0
Message-ID: <CANn89iJYk3T3sVf0osRy3_jvH6H_Xbgu6bdgqamJY-6pUoiHTA@mail.gmail.com>
Subject: Re: [PATCH] macsec: skip PACKET_LOOPBACK frames in macsec_handle_frame()
To: Daniel Hodges <git@danielhodges.dev>
Cc: sd@queasysnail.net, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+0e665e4b99cb925286a0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257966-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,0e665e4b99cb925286a0];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,danielhodges.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: AD46B11317D
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 5:29=E2=80=AFPM Daniel Hodges <git@danielhodges.dev>=
 wrote:
>
> macsec_handle_frame() assumes all incoming frames have a valid Ethernet
> header at skb_mac_header(skb) and reads hdr->eth.h_proto to determine
> whether to process the frame as MACsec.  However, loopback packets are
> delivered with pkt_type PACKET_LOOPBACK and carry only a
> protocol-specific header (e.g. 7-byte phonethdr), not a full Ethernet
> header. Reading 14 bytes of ethhdr from such a short header results in a
> slab-out-of-bounds / uninit-value access.
>
> Fix this by returning RX_HANDLER_PASS early for PACKET_LOOPBACK frames,
> consistent with how macvlan_handle_frame() handles this case.

In the syzbot report, I do not see dev_loopback_xmit() being involved ?

>
> Reported-by: syzbot+0e665e4b99cb925286a0@syzkaller.appspotmail.com
> Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  drivers/net/macsec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 0206b84284ab..edcc51f82327 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -1103,6 +1103,13 @@ static rx_handler_result_t macsec_handle_frame(str=
uct sk_buff **pskb)
>         bool pulled_sci;
>         int ret;
>
> +       /* Loopback packets (e.g. from phonet) don't have L2 headers, so
> +        * attempting to interpret the mac header as Ethernet would read
> +        * uninitialized memory.  Let them pass through unmodified.
> +        */
> +       if (unlikely(skb->pkt_type =3D=3D PACKET_LOOPBACK))
> +               return RX_HANDLER_PASS;
> +
>         if (skb_headroom(skb) < ETH_HLEN)
>                 goto drop_direct;
>
> --
> 2.52.0

I think the issue is in this skb_headroom() check really, this is not
really doing what we need.

Note that the existing check (if (hdr->eth.h_proto !=3D
htons(ETH_P_MACSEC))) should kick properly
if phonet was able to send a bigger packet.

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index c2cb2d20976b..ef4cdf25d425 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1141,7 +1141,7 @@ static rx_handler_result_t
macsec_handle_frame(struct sk_buff **pskb)
        bool pulled_sci;
        int ret;

-       if (skb_headroom(skb) < ETH_HLEN)
+       if (!pskb_may_pull(skb, skb_mac_offset(skb) + ETH_HLEN))
                goto drop_direct;

        hdr =3D macsec_ethhdr(skb);

