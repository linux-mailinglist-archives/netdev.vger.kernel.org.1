Return-Path: <netdev+bounces-307284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mtlqKdFUVWr5mwAAu9opvQ
	(envelope-from <netdev+bounces-307284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:12:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2E974F335
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:12:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=AuwGr0lG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307284-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307284-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 827CB306DAB2
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5F35F17D;
	Mon, 13 Jul 2026 21:12:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69735E1D4
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:12:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783977142; cv=pass; b=pg3Gtx8bW62jUfgSpVshEkGNWjI513+qNW83Lu8OrmG+hOKlhQhKGYUGGmAYOd2J0Vq4H1KccwdbWfkcMD2u9TiW1lJtckhdC8VoMgBw4JLYUFN2j0PCK0EgCg14lmxK7XC3/GHd6ZP3d0P1qUSbJkf1BzZBRSqryMkrZHSDeZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783977142; c=relaxed/simple;
	bh=8PXVs/vJwXci6zYoPKQ+hpQ4HKNdygv1qoTYmsjQx5Q=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBeNOV9p1lTKoUP2GnOt8zplwLqGXlfKKY3ZQb8sb0xi26SndRxl28Ha4UBSk1UOFGSX2KCBAY1JYsD3COM5MhT8ITfP+2kzrzvS0Vfds9sX6vx+YYAMBWXhLbCFvh2fR7gP8IkVctncUBmqfFc7eEeMjpbkCDocV8dqujUpiis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=AuwGr0lG; arc=pass smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc891373e0so41571405ad.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783977140; cv=none;
        d=google.com; s=arc-20260327;
        b=m5w6v6eYdNI6EUML2Rl7paSFsC3GtivPB2xZ7y0TSYrNNHsYBl9fDYwZyQWsV3smzU
         PxtJ/iW+45CSHzEhg9lCsdOh/fMFGs9zwxmx3YLwOd7avhhhuDjdbJGrVuYpA9Qx0MRK
         iNKpu2yepW4c8SKJFCKhz7tc8aiG6fYLQQF5+hRvecsR0Q+et88xMjZufJwWz4Yg5HRh
         KizWMP/EHQRJUpRL+77HeHl/fM8GgNKM06xsAK+z11wicudUr5azSzC+znO2w1qRwath
         hrptNFhy5oAe5dom+vzQeUoVpFCAoQVo8C8d8Pplfbr6ozUmXn5SdA1N1Bq5LFsRp0rN
         DcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=qUBCghi6kjnH1ka8HUmHkrbbiY09NwwjNH5EUa3nwfI=;
        fh=fr59jz4y/jo64MLSSKguX5xgAvW5/nQnxKR6cLM608M=;
        b=mmAImXEux6gW5X4RF91s3RbGUfwLKxg8zoD1tpc5G49x+QSjpDuieCZ24E+AwKeK9m
         6iN0zbSxuzPUMlT7HSnPZzt5O+JDP3PqVOl8cba5yVQfXJAtxhyCf8LYgZACDNd9VoZR
         UbbIciy4XDLGfPKdse0geFyekzHFTL5zioe4fEwYiEBzGrvGREHJTeIQdf7y6g0wPNYx
         IH0aDZDs8DFzhPXqlcH5/REiYGPYJHAMIEsx+8ZQt9m2fyVd8iN5hsV6LzKZXfNDFjbL
         /zAqHcB/zJdX0lweCl028UCUFFyYDsiCvSMKEcbhLfOKUtKEPwKIc8s+ye3G6PTheisr
         I/RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783977140; x=1784581940; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUBCghi6kjnH1ka8HUmHkrbbiY09NwwjNH5EUa3nwfI=;
        b=AuwGr0lGDDCHJtNm9lXTNc3DAbpSxBMnkBqNpX4312yBpmq5Q24mtRGrI3uPPLgQH9
         OMYgIz3Sr+2vC20tljuj9F0rhHDa5utb8guwLtVG2CRLfrzdBvrp+asMiPEiUkV9LSyK
         8bWdtWL40Zxx3PxkhwMqJni22W+CchbzzZ/xChuoib8HlT0/mTnORhSmc5LsJObSywMY
         3S2zBTJZO2p1wMesvG561TV0GfZCNj6646x3r8ZDoWwNy9CFa79KPFCRpum6lx5mrsna
         kgv6SdZSPoqoBn/Ht8yNUo212gCUSeK2EslvC9VDcW4UIK9pWR3ij80TRyD+WkkRJUCc
         1PLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783977140; x=1784581940;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qUBCghi6kjnH1ka8HUmHkrbbiY09NwwjNH5EUa3nwfI=;
        b=VerYnyOTXS8CskRqPFP1QX2GW6AWKy/gVNlDtBoqPzZQU/HmHwQEBID0rlLhPnR4yL
         7TVn+Rx5t2zUf7F6d6KJiresq5BH9PHB3saDb4D4eRqz0HeSl2O+TG7/2efrbyXVyMun
         1LE2gxxma2+HroFXpOrflWKu0MNgjw0Pf74+IPymm8oLLSKKyjKnMSGn7WViKeUYKTbz
         pyNGsBo5PNlR8iR64PJd/1A5bVMrpyBqSYe+Hjs4a96u3dNzhWYL6zvG+vJdBDpF3Cky
         CE1tkdxfTMEEn15iynSdCafZ1cYqRutmriJEu66/tlQQvcKFDpsJIpgKdEfnBepQjaU4
         vFog==
X-Forwarded-Encrypted: i=1; AHgh+RpC8/tTBj0ErYTaF6jY4EYlRjA4/jCEKjts2uOXDqa1rqMUsexHEdC7RwuCMJswrizCVc1JzKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/KvxeUCqhQkRYqimnh8vI6XDL12Oz+rAYTfIxfuwdO6+uZv8
	ZrQgToxZ/4zvQEsyfX++o6v3ipROfH0X22OsETmLWKpCYL/crg2kC8n0pIGPKjXlnue3VBQKaxt
	7FI9sxZppSXqDaJRswzRxjvrublI6Wz4Ps8QT4bW9HqUph6eZUNWF3Q==
X-Gm-Gg: AfdE7cnwP++CBMhEUh1CCpR5/lOezD6YSBOVdUFGl4r4xtq296cihqeWxHwtvYqMqla
	53QAMRq+ZDO1ayKWl3AakQabSc7fkQgln36YDAJnGfoUY2Wvw4QWEMfYrR/0+8wMw72ZFgLGboa
	h+WYgD0Ve80eUQFBdQNdKhjqTm4lGdHwLVGqIh88S/GtlydSMzPtVO4i4FP3J15yE2xIwtNCXVs
	Tpmo0oTeDiIUOpUmPFlJBM2v3uFfr8ndV/ojrsANQ4+fZmqhwdvlTjXEWnxnMjRBIw3wrZM+hS9
	tmtgZaMaSwJbBqD+JqDt5ZuGqOken7v/YC0kNJyyq5J9ZFIBZGqlv4PYdA==
X-Received: by 2002:a17:903:2301:b0:2ca:ed41:d331 with SMTP id
 d9443c01a7336-2ce9f27eb79mr100834245ad.45.1783977140474; Mon, 13 Jul 2026
 14:12:20 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jul 2026 16:12:20 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jul 2026 16:12:20 -0500
In-Reply-To: <20260713200417.dghlrj4ca27b6nd4@skbuf>
References: <20260713194010.54642-1-doruk@0sec.ai> <20260713194010.54642-2-doruk@0sec.ai>
 <20260713200417.dghlrj4ca27b6nd4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Mon, 13 Jul 2026 16:12:20 -0500
X-Gm-Features: AVVi8Ccf64lA0azySl9H8ulwhmt3h2F_jWjPpkuQXsHGkD6_OCbSPA-I2DgzOTY
Message-ID: <CAPdMp1qf4q42MAaRqqzYnhYyU9KvdryGQR+TWsFNvJ1oCTnPKw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net: dsa: tag_ocelot_8021q: don't read an unset
 MAC header on transmit
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Woojung Huh <woojung.huh@microchip.com>, Nick Child <nnac123@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Sabrina Dubroca <sd@queasysnail.net>, Arun Ramadoss <arun.ramadoss@microchip.com>, 
	UNGLinuxDriver@microchip.com, Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307284-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:andrew+netdev@lunn.ch,m:f.fainelli@gmail.com,m:woojung.huh@microchip.com,m:nnac123@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:sd@queasysnail.net,m:arun.ramadoss@microchip.com,m:UNGLinuxDriver@microchip.com,m:mpe@ellerman.id.au,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[0sec.ai];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,microchip.com,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.ozlabs.org,queasysnail.net,ellerman.id.au];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B2E974F335

Hi Vladimir,

Thanks for the review.

I checked the DSA cases with CONFIG_NET_DSA_LOOP=y. Since dsa_loop
normally uses DSA_TAG_PROTO_NONE, I used a local repro-only override
of dsa_loop_get_protocol() to select the relevant tagger, then sent an
AF_PACKET/SOCK_RAW frame with PACKET_QDISC_BYPASS and
sll_protocol=ETH_P_IP through lan1.

That leaves skb->mac_header unset (65535) on the direct-xmit path.

For tag_ocelot_8021q, the eth_hdr(skb) version reproduces as:

  BUG: KASAN: slab-out-of-bounds in ocelot_xmit()

Switching that site to skb_eth_hdr(skb) makes the same reproducer run clean.

I also checked the LAN937X path the same way by forcing
DSA_TAG_PROTO_LAN937X. The eth_hdr(skb) version reproduces as:

  BUG: KASAN: slab-out-of-bounds in lan937x_xmit()

and the skb_eth_hdr(skb) version runs clean with the same packet sender.

So yes, for these DSA TX paths this is a real bug on the
PACKET_QDISC_BYPASS path, not just a future-proofing cleanup. I have
not yet checked ibmveth with a pseries/ibmveth setup.

For the older DSA commits you listed, I think they should be treated
as stable candidates if they remove eth_hdr()/skb_mac_header() use
from the same TX path. I can go through those individually and send a
follow-up with the exact stable list if that would be useful.

Thanks,
Doruk

On Mon, 13 Jul 2026 23:04:17 +0300, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Mon, Jul 13, 2026 at 09:40:08PM +0200, Doruk Tan Ozturk wrote:
> > ocelot_xmit() reads the Ethernet header via eth_hdr(skb) to test the
> > destination address against the link-local range.
> >
> > On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
> > reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
> > resolves to skb->head + (u16)~0 and the read is out of bounds.
> >
> > On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
> > done for the same class by
> > commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
> > and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").
> >
> > Fixes: 43ba33b4f143 ("net: dsa: tag_ocelot_8021q: fix inability to inject STP BPDUs into BLOCKING ports")
> > Cc: stable@vger.kernel.org
> > Found by 0sec automated security-research tooling (https://0sec.ai).
> > Assisted-by: 0sec:claude-opus-4-8
> > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > ---
>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
>
> I was not aware of the bug introduced by commit d346a3fae3ff ("packet:
> introduce PACKET_QDISC_BYPASS socket option"). Commits
> eabb1494c9f2 ("net: dsa: tag_ocelot: do not rely on skb_mac_header() for VLAN xmit")
> 499b2491d550 ("net: dsa: tag_ksz: do not rely on skb_mac_header() in TX paths")
> f9346f00b5af ("net: dsa: tag_sja1105: don't rely on skb_mac_header() in TX paths")
> 0bcf2e4aca6c ("net: dsa: tag_ocelot: call only the relevant portion of __skb_vlan_pop() on TX")
>
> were made assuming that the bug to avoid would be exclusively a future
> one (the revert of commit 6d1ccff62780 ("net: reset mac header in
> dev_start_xmit()")) and thus they were not marked as bug fixes.
>
> Are they true bug fixes, as in "can we reproduce these [using
> CONFIG_NET_DSA_LOOP=y on virtually any network adapter]"? If so, should
> all the commits above also be backported to stable?

