Return-Path: <netdev+bounces-262266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AT7NPh8o2noEgUAu9opvQ
	(envelope-from <netdev+bounces-262266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:40:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 390DF1C9BFF
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E45B6302417E
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445D335AC07;
	Sat, 28 Feb 2026 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwgWfcYT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E6430BA7
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772322038; cv=none; b=WkTi4N2yFOGvIyHiJv3IuYN3hSOuL+Yq85qOn2TaZgMIhXBnruxB+e473owBDJapPnLb3DeGL2knrhEat38J2ycNSqsnsBa3m+XH5tbVzvhwHhv49Jgd/1cgPQg4bgxRNvgZ3DppBUK6CMwbGxg+2ipBLJoUmNB6hTbmGhjIkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772322038; c=relaxed/simple;
	bh=v4w9zko3j40OD4fY0W4/F/MbA0wtP+VgVxwOz1+A2/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDjDPzMAqhiBMQFOite54b9E/kz7SADBytelZXFGNS71hdYPbYJtHsPF5zJgK57+ymWTejeXpSeviHMQ0me9vTGdUgVoFXZoQ5DkKAoq2L6qSTL3zl7PqZYrJOcQ/NBl/EMWvqbH1E17kzKZNh+kuLLoRMdK3auvZ89OzOI6N30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwgWfcYT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806b8fca44so4585185e9.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 15:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772322035; x=1772926835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxHhPe4KoHt6q/6e5kLZqoiGpFRaYCF5u6G3udBnEzQ=;
        b=DwgWfcYT9RObcheGeiDlpIUFMUR2HQHnoUUeq4S5x8Wedzs3u6LY8lRUmqhDnxDf42
         7zn4UolUNDtGpd2MHGVHKAOAECT1EOqa4ff19xPd4dMsoZtxyyvL+E/tknu6rH2ouYV9
         c7EAWdAA1Pc9SrY/d2ZTbRhezI2sug2/yGpYhJFWKVkcUWJF9GDcIx+Lu2qv61yi4o4r
         aC1rDpvwV/ZkaevvG/viQ8ngRHVZiFuL2qHa8kcTjVnBj+WlK46/I/xIzbvMx8o61MYn
         oUOuAiX6O6BsZkpaPtFZcL/iXU1etTsCzozuuN+2c5uHyrExkt1pXMtAp5UW4ffiVFXI
         lXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772322035; x=1772926835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxHhPe4KoHt6q/6e5kLZqoiGpFRaYCF5u6G3udBnEzQ=;
        b=Gb3XvDLCNXq/8fQXiXilOyDnz+TzTzqOT3K6sItTmddABVN3LPvuzFosk8q0T84bBf
         hS2rb5RtdTzqx1p/biJzYBDTEe+UD1abWsjr7YInuJ6rRifqclOzIO4ayZVxxIERY/xF
         SCC1odUtQ5SLmXAvH+wgJlQUyp4/Wgv+sfnKQtfRueoNgK2tNq1Eb6NVLrUmSFzMlZEr
         DVQ6jbrQMTkFjTQW/mG0SevVDkaHTL2NXV2iTRt4rnmWhDgSGxxu/anzCuH01RIX3lIi
         6YQUP3XgD3hPKW7byLeZUSYD98qudo6O9r0YEdxJXSFChwlcz3KppwrOg8jDdzhr6M3e
         Jp/w==
X-Gm-Message-State: AOJu0YzJdC/XWE1x4h0B/4+7yKj9MrF0cz5NCSCpo5qCYnuoFlyNEiLk
	T1oz5Vi1uWUypKU4ms8n71KEJuFPhFxdFNyZZaRspP8uf79ZFMd0qgd/PRUKFw==
X-Gm-Gg: ATEYQzzUR3rHCpBop7v6ty6qdQAqPeiGhLsHTatsuQjHuKtcAlgVu3oLKKNNbUysiy6
	4FE01eVyGl2M/RFe+hUOI582rxaoA1SCY+WOL8SihDnA0xIfWyHCAgtVtCfr8wYNV20oFotYg7O
	9s/VOqxkD23eOYvmPDbCkads8CeM0rBtMaXir/NtQPO/rf0MzbpKj6ODX3bfpWrtD3CQrtJwtDU
	gj2A9dnC0GSH7EOwupoBaHR8AjEiEySlOQ3smcLeGmjfXeL/mAeowx2jX/jrX+cpyk0iL5rKN3Z
	lsyKwtvVMANH3CTod/jQ3QljKNwHRGPr2NwD7XukDz6ke1iy7R2Snfu9WT3RfmQbgOzYed/tV2p
	90qJXzkIvJYJpedYsnT8w5Wxne/g3Ece2jJ9SvEE4sxffzYTWJhjKLey2wFW/Ch8Q2EhdSSS345
	lfCh8ghGijpAJyIFz9xis=
X-Received: by 2002:a05:600c:5249:b0:471:ab1:18f5 with SMTP id 5b1f17b1804b1-483c9c3b2f4mr80514165e9.7.1772322034855;
        Sat, 28 Feb 2026 15:40:34 -0800 (PST)
Received: from skbuf ([2a02:2f04:d608:3a00:53bb:2a43:1888:95a0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750701sm327932415e9.11.2026.02.28.15.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 15:40:34 -0800 (PST)
Date: Sun, 1 Mar 2026 01:40:31 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC 0/2 net-next] net: dsa: MT7628 embedded switch initial
 support
Message-ID: <20260228234031.bimzpo4mmu6t5rty@skbuf>
References: <20260228185242.800836-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228185242.800836-1-joey@tinyisr.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262266-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vonger.cn:url]
X-Rspamd-Queue-Id: 390DF1C9BFF
X-Rspamd-Action: no action

Hi Joris,

On Sat, Feb 28, 2026 at 08:52:40PM +0200, Joris Vaisvila wrote:
> Hello,
> 
> This RFC adds initial support for the basic functionality needed to
> operate the MT7628 embedded switch.
> 
> The driver configures the switch to isolate each port and does not
> offload any bridge functions, so all of the forwarding is done in
> software. Bridge and VLAN offloading are possible but omitted to
> simplify this initial patch set.
> 
> The special tag currently overlaps some functionality with tag_8021q,
> but it enables precise TX handling and (more) precise RX handling for
> future VLAN offloading.
> 
> Tested on MT7628AN with 5 100mbps ports. All 5 ports were tested for
> correct forwarding with two devices.
> 
> # Request for comments:
> 
> - What would be an acceptable way to present the undocumented phy init
>   in mt7628_vendor_phys_init and switch_init?

Like Andrew said. Run cat /sys/bus/mdio_bus/devices/.../phy_id for your
probed embedded PHYs, and write a specific PHY driver for that ID in
drivers/net/phy/. With some luck, you may already be using a specific
PHY driver, case in which you might be able to work out what the things
in mt7628_vendor_phys_init() do, based on what doesn't work without them.

What undocumented bits in switch_init? These?

	/* undocumented init sequence from openwrt/uboot */
	regmap_write(esw->regmap, MT7628_ESW_REG_FCT0, 0xC8A07850);
	regmap_write(esw->regmap, MT7628_ESW_REG_SGC2, 0x00000000);

I ran a Google search for MT7628 and found:
https://vonger.cn/upload/MT7628_Full.pdf

It says:
FCT0 (Flow Control Threshold 0)
Bits 31:24 FC_RLS_TH   Flow Control Release Threshold
Bits 23:16 FC_SET_TH   Flow Control Set Threshold
Bits 15:8  DRO_RLS_TH  Drop Release Threshold
Bits 7:0   DROP_SET_TH Drop Set Threshold

SGC2 (Switch Global Control 2)
Bits 31    P6_RXFC_QUE_EN       Port 6 RX flow control on per egress queue
Bits 30    P6_TXFC_WL_EN        Port 6 TX flow controll by Switch WAN/LAN port
Bits 29:24 LAN_PMAP             Lan port bit map
Bits 23    SPECIAL_TAG_EN       Special Tag enable
Bits 22:16 TX_CPU_TPID_BIT_MAP  Transmit CPU TPID(810x) port bit map
Bits 12    P6_TXFC_QUE_EN       Port 6 per queue TX flow control
Bits 11    ARBITER_LAN_EN       Memory arbiter only for P0~P4 enable
Bits 10    CPU_TPID_EN          CPU TPID(81xx) enable
Bits 9     ARBITER_GPT_EN       Memory Arbiter only for P5 and P6
Bits 8     SLOT_4TO1            Memory Arbiter Ratio Selection
Bits 6:0   DOUBLE_TAG_EN        Insert double tag field

I don't really understand why you left them "undocumented"?

The PHY registers indeed seem to not be described in that PDF. But maybe
it's an embedded version of a similar discrete PHY for which you can find
documentation (elsewhere).

> - Should I aim to set all register default values for general switch
>   config or is relying on the documented switch reset state acceptable?

Too little information to answer the question. We need to know if the
documented out-of-reset state of the switch is reliable. You have more
time spent with the switch, so it's probably a question for you. You
assert two reset domains - rst_esw and rst_ephy. If that is enough to
restore the hardware to the documented states, then all is probably
fine. If not, you'd need to explain what is persistent across resets,
and who else may have touched it (bootloader, kexec etc).

If it was more of a general question - from network maintainers there is
no requirement that you redundantly write all registers with what is
supposed to be their out-of-reset value.

> - I am also looking for any and all feedback on the architecture and
>   coding style of this driver.

Oh, this is the fun part :)

I'll start in order with what I think is the most important. I would
love to know more about the tag_8021q and VLAN unaware implementation,
but that may be made irrelevant by something else, so I'll skip it for
now.

I found some references in the documentation to a block named "Switch
DMA (SDM)" starting with base address 10100800. Can you comment on what
purpose this block serves? At a superficial glance, it appears to allow
packet injection into the switch from the embedded MIPS CPU. I wonder,
in that case, whether packet I/O can be done without DSA tags through
those packet rings (case in which a pure switchdev driver might have
been more appropriate than DSA).

I looked at arch/mips/boot/dts/ralink/mt7628a.dtsi and found nothing
Ethernet-related. So it's a bit hard to comment from me whether this is
an instance of mtk_eth_soc.c or something, that is being used as a DSA
conduit. Case in which your architectural choice is fine.


Perhaps a bit more wording in the cover letter and/or commit messages
regarding the general switch block diagram would be nice, in terms that
Linux people already understand.


In terms of coding style there's a few hiccups. I would call out
incorrect alignment of arguments of multi-line functions (they should be
aligned with the open parenthesis, accounting for 8-character wide tabs).

Also, we practice an empty line between local variable declarations and
the beginning of code in a function body.

And the struct platform_driver mt7628_driver definition is indented with
spaces, not tabs, unlike the rest of the code.

And you don't need to put a comma after sentinel entries ("{},"). The
only reason we do commas after terminating array entries is to minimize
the git diff when adding new elements to the array.  But with sentinels,
we expect no follow-up by their very definition.

And we practice something called "reverse Christmas tree notation",
where local variable declarations in functions are sorted in the
decreasing order of their line length. No other subsystem except netdev
does that, but we're pretty crazy about it, so yeah, you're not going to
get us stop nagging you about it.

And we don't practice initializing variables with 0 (or NULL) as part of
their definition, when that value is going to be overwritten later in
the function with no reads in between. Examples: "ret", "val" in
mt7628_phy_read(), "ds", "esw" in mt7628_probe(), maybe more.

> Thank you for your time and feedback.
> 
> Joris Vaisvila (2):
>   net: dsa: initial MT7628 special tag driver
>   net: dsa: initial support for MT7628 embedded switch
> 
>  drivers/net/dsa/Kconfig  |   6 +
>  drivers/net/dsa/Makefile |   1 +
>  drivers/net/dsa/mt7628.c | 567 +++++++++++++++++++++++++++++++++++++++
>  include/net/dsa.h        |   2 +
>  net/dsa/Kconfig          |   6 +
>  net/dsa/Makefile         |   1 +
>  net/dsa/tag_mt7628.c     |  85 ++++++
>  7 files changed, 668 insertions(+)
>  create mode 100644 drivers/net/dsa/mt7628.c
>  create mode 100644 net/dsa/tag_mt7628.c
> 
> -- 
> 2.53.0
> 

