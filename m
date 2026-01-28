Return-Path: <netdev+bounces-254451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HRLEuV3emmE6wEAu9opvQ
	(envelope-from <netdev+bounces-254451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:56:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8462A8DDD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DE1D300E15C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29329376482;
	Wed, 28 Jan 2026 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT7u2N7M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622C376478
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633760; cv=none; b=RV861yAiNta7hB47KLj6asBMIxA1yAoix/hdUIjIxEDunZV+FRniIGzIo2J4JCcubGdV/moncOyBIb3/lfOT9MpjgAr0dY2Vj3idNM4ScDl79fxa1n6SbJhXHdgJO2wNIZFmK/aNHFQsxYdgJjdzCWhrNRC+TsGnigot7CppoLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633760; c=relaxed/simple;
	bh=gMQepSK8f7qhYnYkO0okMJg/16Om5zTTPa+WGPVbmyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROsM078IlnNcKWhHnOY+Ge3lFg+yFmv0rqliGZ0Jxft3vqXmCZWwgd4Hlg33LrpLr5jRJlsuERciX8tNJYsYc/HGHICpEnRNnhf/UMlsHNMZ2GK82CpCybcdN2B5YBqkrJzWkyNYX8OnX0dvTKW2VvdwwSXUzno5oeEoXPy/a8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT7u2N7M; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4357b308f28so32965f8f.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769633757; x=1770238557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inVrPakEQC1UyRcMQR3934qNzhI0Dd0xU2zpnTM65tM=;
        b=VT7u2N7MwolAOKiNA76rzxqPWsLNUtCaKicyspyfrf0N7xzotXYGPbZ5Vy4sm1voAg
         2WJNvKNPMCv3my2TqQRytNXDU6rrExB4JvvyH79eTWZfQMQS7InSiKxSE/e9zIm0GElP
         ZCQ6q/QXmuGEBQcdCtE51et59LdyB0Tu4DU/N/9DPP0cTIFZndn6YiJ/GqXXeiL/2V6A
         oeOdF5Fi8UYmUGaqzDu1a78U8liBDmXpgRAuA8LMn76z7OEhkYxngHSzYB5rQvf4XjbE
         AXP5i5XTGKyfk89PfLryZ/y8mS0MYapiXtTOn5MPjMdt7AB0abGl/tB918+crtj8kdKz
         WDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769633757; x=1770238557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inVrPakEQC1UyRcMQR3934qNzhI0Dd0xU2zpnTM65tM=;
        b=jROS857vP9BqJYDFytEsnqDQV7yXZbuqvg3Ecr3R275Ugld1qBexqX4IPkZMMnpxvf
         7iK+dWMbTbnzkBFN0xlbubHUwlbf0x2fGls9YqZuoDvefKfcKPsXVCbWTraWv2c2yRJO
         dI1IowYreBSv2VN9ef5KtM+HKMW2D5OQgmsMpqZKtS3H1ByNvmglUpMjk3DFfx1X6NAP
         /+k6sHJAw9+sDJKnK0LY1AeWt3UkjfexiMx2qbwDne+qW6S2nxphJqVu486kOjolvikL
         mzCt1TLAVBcl66KFZP2uR34oIhBHTLBP1FEJayaRRUovrxBInQOz/8j/b592ZZxJWBwb
         VGpg==
X-Forwarded-Encrypted: i=1; AJvYcCVamPT2hELMGb3yMMNtffa1t1n8fq9tQl2xX/Kz5cJ24qAEOEb4CRiUsPDKgDN8nSFJ6UowpBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69K5/YQuklR49B8NobtqQlVr3MdjFAgcklXkBwRPezgiwbg80
	+UkOK1DMGtV8lJgNZwMus4k7blor+fBJvTjnyLBSaU+IAUSbZBk0eEze
X-Gm-Gg: AZuq6aILMvMbCv+swhgfm0pW50yeq+EQMKySNHA6UbFSxa56HQs2fczsZqd9jGcabVn
	ze1jLmSDRxF6UOo2OF6G0CN55jNek12P20bz62HAyJ7hM2iWoJ5qu90Z8Em63+oSj1hkIAS66A6
	lA4Ozh3Z0EA6qm5UbveHcGqCASsJDalGTmj10EeMvDGPHzNdzONm5kbHBrXDoheJDNWb3YfPSBL
	hhV/pghYnM0Ic3cjLGaYOCj4ao2DHTlyVf1tTefgP+bgLENVtc3yGMagvQxLlmwDfyMAIxhX4lx
	tvLJWnD1YE9TZlTBa+kyTWLJW8ZKMW9I6ZamhZmYTJ0mbk0+nq/eix/o0q3D/owz7ATHVGXpKKh
	9/M6mfNlAt1CVsDURP+KWBa4PFLGsE+LnORMwNplVdCfxIoU1IrOjcpN/FaprL/0sjlgwEfULAT
	RHUw==
X-Received: by 2002:a05:600c:34cd:b0:471:3b6:e24 with SMTP id 5b1f17b1804b1-48073cc37cemr10857405e9.8.1769633756442;
        Wed, 28 Jan 2026 12:55:56 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:6c51:3f46:e918:f0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10f82aesm10032262f8f.19.2026.01.28.12.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 12:55:55 -0800 (PST)
Date: Wed, 28 Jan 2026 22:55:52 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v9 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <20260128205552.2mheraoxodwqisns@skbuf>
References: <cover.1769549559.git.daniel@makrotopia.org>
 <35ba37bee00af9de047e8ac49fcd739f10736f84.1769549559.git.daniel@makrotopia.org>
 <20260128112950.q2kzl632w3jidyls@skbuf>
 <aXo9MnBFuaj8d5Hv@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXo9MnBFuaj8d5Hv@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-254451-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8462A8DDD
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:45:38PM +0000, Daniel Golle wrote:
> > > +static int mxl862xx_configure_tag_proto(struct dsa_switch *ds, int port, bool enable)
> > > +{
> > > +	struct mxl862xx_ctp_port_assignment assign = {
> > > +		.number_of_ctp_port = cpu_to_le16(enable ? (32 - DSA_MXL_PORT(port)) : 1),
> > > +		.logical_port_id = DSA_MXL_PORT(port),
> > > +		.first_ctp_port_id = cpu_to_le16(DSA_MXL_PORT(port)),
> > > +		.mode = cpu_to_le32(MXL862XX_LOGICAL_PORT_ETHERNET),
> > 
> > I have a really hard time understanding the physical port to CTP port
> > mapping here. Specifically, I see you allocate 1 CTP port (sub-interface)
> > per user port, and the rest up to 32 CTP ports as sub-interfaces of the
> > DSA CPU port.
> > 
> > But I can only see this working if the index of the DSA CPU port is the
> > last. Otherwise, won't the CTP port IDs of user ports subsequent to the
> > DSA CPU port overlap with sub-interfaces of the latter?
> > 
> > Example:
> > mxl862xx_configure_tag_proto(ds, 3, true) // CPU port
> > -> .number_of_ctp_port = cpu_to_le16(32 - DSA_MXL_PORT(3)), // 28
> > -> .logical_port_id = DSA_MXL_PORT(3), // 4
> > -> .first_ctp_port_id = cpu_to_le16(DSA_MXL_PORT(3)), // 4
> > mxl862xx_configure_tag_proto(ds, 4, false) // user port
> > -> .number_of_ctp_port = cpu_to_le16(1), // 1
> > -> .logical_port_id = DSA_MXL_PORT(4), // 5
> > -> .first_ctp_port_id = cpu_to_le16(DSA_MXL_PORT(4)), // 5
> > 
> > Doesn't the CTP port ID of user port 4 (5) collide with sub-interface 2
> > of CPU port 3?
> 
> Absolutely true. It works coincidental because only SerDes port 0
> (port_id 9) is allowed to be CPU port. When using SerDes port 1
> (port_id 13) as a user port it already starts to be tricky and more care
> needs to be taken when setting up CTP port assignment...
> 
> Now that I understand more of what it actually does I'll try to come up
> with something smarter.

I think the next step is to figure out how to best allocate the
limited sub-interfaces for the CPU port depending on what is actually
needed from them, because...

> > If the hardware supports multiple CPU ports, then please describe all
> > CPU ports as such in the device tree, and make an effort to handle that
> > description gracefully even if you cannot make use of the second CPU port.
> 
> The number of available CTP (32) limits the possible setup for CPU ports.
> The reference driver only allows port_id 9 (SerDes 0) to be used as CPU
> port. SerDes 1 may also be used as CPU port in theory.
> 
> > See the rules by which dsa_tree_setup_cpu_ports() creates the initial
> > user to CPU port mapping. This avoids a future breakage you'll cause
> > with old kernels when you update the device tree to describe the second
> > CPU port for what it is.
> 
> Understood. On old kernel, lets assume with this basic driver just added
> but future DT with more than one CPU port described one should still end
> up with the first CPU port used and all ports assigned to that CPU port.
> Right?

...with multiple CPU ports, calls such as dsa_switch_for_each_cpu_port()
will enumerate them all. The second CPU port will exist and will be set
up like all others (including mxl862xx_configure_tag_proto()), it's just
that no user port will be mapped to it (dp->cpu_dp will all point to the
first CPU port).

> > > [...]
> > > +#define MXL862XX_MAX_PHY_PORT_NUM	8
> > > +#define MXL862XX_MAX_EXT_PORT_NUM	7
> > > +#define MXL862XX_MAX_PORT_NUM		(MXL862XX_MAX_PHY_PORT_NUM + \
> > > +					 MXL862XX_MAX_EXT_PORT_NUM)
> > 
> > 8 + 7 == 15. This is written into ds->num_ports.
> 
> Good you are asking this. It's another oddity which came from the vendor
> driver. It's wrong in many ways, see below.

Ok, so in the next revision you'll set it to 17 according to the table
below, right?

> > Could you please explain how this agrees with the Kconfig help text:
> > 	  These switches have two 10GE SerDes interfaces, one typically
> > 	  used as CPU port.
> > 	   MxL86282 has eight 2.5 Gigabit PHYs
> > 	   MxL86252 has five 2.5 Gigabit PHYs
> > 
> > What are the extra port indices used for, and is it ok that MxL86282 and
> > MxL86252 are registered with the same ds->num_ports value? This should
> > be visible in the "devlink port" command - even unused ports have
> > devlink instances.
> 
> This is probably because the SerDes ports also support 10G QXGMII PHYs
> with 4x 2.5G TP ports connected via a single pair of 10G SerDes lanes.
> In this case 4 port indexes are used for the 4 ports.
> 
> My understanding of the internal port IDs by now:
> 	 MxL86282				MxL86252
> port 0:  microcontroller			microcontroller
> port 1:  PHY port 0				PHY port 0
> port 2:  PHY port 1				PHY port 1
> port 3:  PHY port 2				PHY port 2
> port 4:  PHY port 3				PHY port 3
> port 5:  PHY port 4				PHY port 4
> port 6:  PHY port 5				n/c
> port 7:  PHY port 6				n/c
> port 8:  PHY port 7				n/c
> port 9:  SerDes PCS 0				SerDes PCS 0
> port 10: SerDes PCS 0 (QXGMII)			SerDes PCS 0 (QXGMII)
> port 11: SerDes PCS 0 (QXGMII)			SerDes PCS 0 (QXGMII)
> port 12: SerDes PCS 0 (QXGMII)			SerDes PCS 0 (QXGMII)

For multi-port SerDes interfaces like 10G-QXGMII, technically each port
has its own PCS (port 10 -> PCS 1, port 11 -> PCS 2, etc). But I think I
understood the general idea. Maybe it would have been better to say
"SerDes lane 0 PCS 0" etc.

> port 13: SerDes PCS 1				SerDes PCS 1
> port 14: SerDes PCS 1 (QXGMII)			SerDes PCS 1 (QXGMII)
> port 15: SerDes PCS 1 (QXGMII)			SerDes PCS 1 (QXGMII)
> port 16: SerDes PCS 1 (QXGMII)			SerDes PCS 1 (QXGMII)

To be clear, what would be a proper name for the first column in this table?
Physical ports, right?

> MaxLinear seems to tell board designers to always use port 9 as CPU port
> and port 13 for an SFP cage or for an additional single-port PHY.

Ok, I assume that's what your board has as well. If I quickly run those
numbers into mxl862_tag_xmit(), then I guess that if you wanted to ping
each port (with cpu_port = 9), you'd set:

         MXL862_SUBIF_ID			MXL862_IGP_EGP
port 0:  7					9
port 1:  8					9
port 2:  9					9
port 3:  10					9
port 4:  11					9
port 5:  12					9
port 6:  13					9
port 7:  14					9
port 8:  15					9
port 9:  16					9
port 10: 17					9
port 11: 18					9
port 12: 19					9
port 13: 20					9
port 14: 21					9
port 15: 22					9
port 16: 23					9

I wonder how those MXL862_SUBIF_ID values map to the .number_of_ctp_port
configured by mxl862xx_configure_tag_proto(), which is 32 - DSA_MXL_PORT(9) == 22.
So to target port 16, you'd need a MXL862_SUBIF_ID which is out of range,
and results in an unrepresentable CTP index of 32. And subif_id values
0..6 are unused. Something doesn't add up...

Where does the 16 come from in the "usr_port + 16 - cpu_port" formula?

> But this seem to be limitations of their current downstream driver
> implementation and the hardware would be capable of using either
> or both SerDes port as CPU port, and also support connecting a QXGMII PHY
> to end up with 12 TP ports in total.

Interesting. If your host SoC supported 10G-QXGMII, you could
reconfigure both sides of that 10G SerDes interface on your existing
board and test quad CPU ports just for fun and giggles.

> Port 0 indeed turned out to be the microcontroller, I can confirm that
> because it screams when poking it with IEEE1588v2 packets, which you
> get to see in the kernel logs:
> net eth1: Invalid source port, packet dropped, tag: 88 c3 0f 04 00 00 00 10
>                                                                          ^^
>                                           IGP/EGP is 0 here, Record-ID is 1
> 
> The datasheet says that Record-ID "[...] is used for logging information
> for PTP and OAM packets".
> 
> And calling mxl862xx_port_disable() on it makes it shut up...

In SJA1110 I could also ping the microcontroller by putting an IP
address on that user port. I am shutting it down during probe time, in
sja1110_disable_microcontroller(), and not relying on the firmware at all.


Maybe this is a stupid question, but I still don't quite grasp the purpose
of the logical port + sub-interface scheme from its use.

From what I could gather:
- xmit from Linux targets the logical port ID of the CPU port, and a
  sub-interface somehow in an implicit 1:1 association with user ports,
  which seems under-dimensioned in the maximal scenario
- the P-Mapper documentation says it can map one of {VLAN PCP, IP DSCP,
  LAG ID} to a sub-interface, but this feature is left to the firmware
  default state (MXL862XX_BRIDGE_PORT_CONFIG_MASK_EGRESS_CTP_MAPPING is
  never set), so I cannot make any assumptions about its influence

I don't quite understand how these two uses interact.

