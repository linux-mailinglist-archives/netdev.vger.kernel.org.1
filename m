Return-Path: <netdev+bounces-253287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJhcKMahdmmOTAEAu9opvQ
	(envelope-from <netdev+bounces-253287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 00:05:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C99988316A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 00:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A860A3001B63
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F3630EF85;
	Sun, 25 Jan 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDzAfRIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1330EF96
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381811; cv=pass; b=RZgzmGs+6q+onR+Yhh/X5rvhctxvamQCllUR1CGILxkuKiwbNYwvEAQiE+ckAq24h1DlYfwF51JdUFbYZvvJWBsVGZQ65EnOtxYegIEObPKoiIg6E9pRJ11h+M5hs17i86bOELpuqtlCK4zsnLtuC8+M8Zhb/opclF55oO5fArU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381811; c=relaxed/simple;
	bh=IyC3BmPWqJIkU6BfZRfqMzmhH2hO+2V+/SU/liGwcL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWsBlrF8w2dlvmlu3iJayTDJT73M3m5RdQradaZo0zof58uGZgMSKqmNj1PjciUCsCOw9XQuuvyhuu8cXzUrdheMxE5wQE3QEWv0ltQveYpeMXojW13Ue6qwaLitB/RvblgbJde6O4tEE5CF1nJ0nGMsrNqYQ/g3QBssY2HpYis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDzAfRIb; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40423dbe98bso1589969fac.2
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 14:56:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769381809; cv=none;
        d=google.com; s=arc-20240605;
        b=hOhO1eGZzW9JPzd18K2Afe6AYeINrumQE7tqF1+ZnrY7PVOatGaQZbwp5li4n0q1Tb
         KUng/DHQgJNGVVZSe+zxTpzfKvLbxVNBeWZf/nJ8P4eeiW3AjGEWHPQhkz2TzTgkoiVh
         BeIGvNFh3un2LHZMGsXkrqRnUYCxH3zscV8GczTRiVT0yvAnSKzJU1vEOPX3r473aEoP
         LMOaL4Ld/9Xuc6tqoP3xt4h07bqpbBiPli+I2ZRNtoh7+fk9SX3Aatn/sEM0/6thKAH7
         +DwxcDLy4Ri+1Eg6gfsHO81wNWqdGZxTGejhctuuHLyhG+Ekpg6E7FufYys/cW/cLu38
         upZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zTgO0VCdnh1CfBBoLFE4r4P+fwbkrM17HUN8i/ddW6M=;
        fh=TowOf8hqkM++B81pg0tnD4Dimr3fcg48DhctYHA9ka4=;
        b=QlJJfJTR9/a/I2OWdZFrCa1Ol/H13ifmRxQllNIu5s32v8hIxpnIi5yU3sQOJliylP
         iEUhO9UWcZ7MR6GQHNEyEIe7Bvb+ABfGXFDOnsREqsWqq4Z64dSIgam5on6jujjJuTPN
         +W5j2qXv2UNhrWAa09hUv+qKOTlrcgHyYvrxtZOxvdA8BVZ/9vGX2fdh+MwBZUQGKkgh
         FdI0HZkVIqLguCRsV374HvDnzHTB2bDsW1lG274+UIJl0+8ahFSZGkXrlDRYpX7IgaJo
         4/O46OUFYr/4HtWd2z1eYGVRDp6/rXaAJAqGcrfL0DBwaS4eEVmFImFmf743w9bbpzRV
         03yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769381809; x=1769986609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTgO0VCdnh1CfBBoLFE4r4P+fwbkrM17HUN8i/ddW6M=;
        b=iDzAfRIb5pJCVS4bPL+4D41O4r+Tsj61BTQD3lp2jcrvnlFoBl2MqIfgqu0kyoiATP
         vGvql41pN2S4dm2s0D/tCJZUlSXQWGAovEeZG9ppUzp5GR99UsGoGe2v9Uz6HwM4mPWa
         MXkMhiwSU/7Oh49UEyAY9UDYa63OhDj/NCJjsWGfB8e2BSZolM1xAfdqqO11yINkSKdx
         Oq6Vd0qZFq6v8PWPAtbPIyMmSONq2+d1EPpQZFsk1iDRvfCpQ63iCfcFFF0PGfSsZWAm
         wjU3RD9boRdk54xBs8gOKeXZJWpLiEhl1RDn9mATHf7Q3RH6rKUfky2DZXxE/GXbHGL2
         0HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769381809; x=1769986609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTgO0VCdnh1CfBBoLFE4r4P+fwbkrM17HUN8i/ddW6M=;
        b=PuSIQx9jEwTbtn1JYnKx/PKfk5E4//nAC5TFpqyB/juDlvGe90hBnDQ3W8ek+p08ZS
         JMZFcgSSxaAREDPSfGu7cA9KjJWAZ20Q4bTjGdNs1Ce2A5KJFijuUf4iwqdsVIuaDMUS
         YPPElYdSFl8u93k2qPKyk9h4p3Gh9hipBbPc65GVr7k0cGO/+9FxqurIv5cWStzU1/Vr
         QhmhqH8YbkdKMDYkCPhhcM9O/8OVCNlee1I6Nb3ZkakaUXZYBHmBwV/+Wf4XTu8QirEd
         g/KP+aWmpPDupDUnNiR8P0kndHgpd3uVvZFBHcxmnd62GOpr8B/6XBqfYnz5SfgYNXom
         78dw==
X-Gm-Message-State: AOJu0YxPrtsrMpC7LVEao65JrE8BOTiRbeXw6IPivjgG/eaCifwFnRgk
	Le3iosG0auOhV0tScLrk2UtH1qT77akaFulIyyWjx2WLv0Xxv5h14f8JN4O4QR0xMC5KNYQYUPp
	NdSRGet7xiolLiYsp2KHCLl4xV7SEjhg=
X-Gm-Gg: AZuq6aKwpVII5Z6cMUr3GQTdpF10oQfz6a7wmxFcNBraOgHCyKnjSWn9IMWoN5sGgaT
	BYCY1lfdcMZpeUMZHVxYLOv204KUBZ1KK3N9IgKXqvPmdk1/l2qLxGnKd7AQWREDRMFlGWvvUEh
	Z8nR7NW0MJ3z9WfGtBBMKgdgeRKW8CazUD794faiq9zWrernr3OpnFW6GSRI1CopPVVBF0rEwGn
	1ZDmS99waWZ1nWoq2sQGpMg0KTOHX6dATpvNGpO0lVTYqiD1CHbZI3iDPlISB2Cd4MUxmZek5NE
	p3nmYvBW6RMWxVolZmC4xfyeKhw2PeCxoJhnkHT1ZBlKe3a7q/T8jhUUfAk1
X-Received: by 2002:a05:6820:1609:b0:659:9a49:8dea with SMTP id
 006d021491bc7-662e0450083mr1377281eaf.44.1769381808725; Sun, 25 Jan 2026
 14:56:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122185255.2761568-1-mmyangfl@gmail.com> <20260125223455.31fd7a93@pumpkin>
In-Reply-To: <20260125223455.31fd7a93@pumpkin>
From: Yangfl <mmyangfl@gmail.com>
Date: Mon, 26 Jan 2026 06:56:12 +0800
X-Gm-Features: AZwV_Qh11aaleaFzpaDBhtbnorJB6-ZX9WBC2tkVSbFXNX7yzlrhcDRvcGkAFUI
Message-ID: <CAAXyoMOtMz9Hn=gqS1Wj0ASTZ1JaReZnc685h7YN2sD9zjrtcA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: airoha: Use u64_stats_t with u64_stats_sync properly
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253287-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C99988316A
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 6:35=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 23 Jan 2026 02:52:51 +0800
> David Yang <mmyangfl@gmail.com> wrote:
>
> > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > against load/store tearing. Convert to u64_stats_t to ensure atomic
> > operations.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 136 +++++++++++------------
> >  drivers/net/ethernet/airoha/airoha_eth.h |  34 +++---
> >  2 files changed, 85 insertions(+), 85 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 62bcbbbe2a95..6ed220e5a094 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1472,131 +1472,131 @@ static void airoha_update_hw_stats(struct air=
oha_gdm_port *port)
> >
> >       /* TX */
> >       val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
> > -     port->stats.tx_ok_pkts +=3D ((u64)val << 32);
> > +     u64_stats_add(&port->stats.tx_ok_pkts, (u64)val << 32);
> >       val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
> > -     port->stats.tx_ok_pkts +=3D val;
> > +     u64_stats_add(&port->stats.tx_ok_pkts, val);
>
> Wouldn't that be better written as:
>         u64 val =3D airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id=
));
>         val =3D val << 32 + airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(=
port->id));
>         port->stats.tx_ok_pkts +=3D val;
> (Assuming there something has stopped the hardware increment the register
> between the two accesses, and there is an associated atomic zero.)
>
> Otherwise you are generating 'tearing' on 64bit systems by adding the hig=
h
> and low halves separately - regardless of how the stats are read.
> I think that works for 32bit as well.
>
> Making the code completely unreadable with 'special' types and 'special'
> copy routines really doesn't seem worth while.
> The compiler won't generate code that does 'data tearing' for aligned wor=
d
> accesses, and even if it did nothing would really break.

Quoting 316580b69d0a ("u64_stats: provide u64_stats_t type"):

  On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing.

  Using READ_ONCE()/WRITE_ONCE() would be needed.

> The most you want is a memcpy_in_words() function that guarantees to use
> 'word' size tranfsers for aligned buffers - and is probably an alias for
> normal memcpy() on all current systems.

See https://lore.kernel.org/r/20260120092137.2161162-1-mmyangfl@gmail.com

And if you want a memcpy, you need a buffer. If you want to fold the
buffer, that's basically WRITE_ONCE().

>
> OTOH data tearing can be seen for 64 bit adds on 32bit systems.
>
> It is worth nothing that on 32bits the 'packet count' and 'byte count'
> increments get seen as a pair, this doesn't happen on 64bit - one happens
> before the other.
>
>         David

