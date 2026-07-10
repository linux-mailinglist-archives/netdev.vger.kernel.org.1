Return-Path: <netdev+bounces-306719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 91hmORh4UWpPFQMAu9opvQ
	(envelope-from <netdev+bounces-306719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 00:54:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6761673FA48
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 00:54:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=5PEemnWD;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306719-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306719-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9D43300D763
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 22:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1691240861C;
	Fri, 10 Jul 2026 22:54:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623A40861E
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 22:54:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783724053; cv=none; b=NB8pH1H05ddbWFDRzGMdiDMQUBXjZkAlcea6VfhicGhRGCo9n7YNhpXINIr29hYH4G88sXn/gLA+zaz5AVfPgxjSydUQqIS5coFJ0x4Hf9xhvV+EJNQA8C6isz9QqMage/0MSlOwx39BARbt15oOwQj8+L/pvfp+iORUZsrL0FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783724053; c=relaxed/simple;
	bh=yq4rIY8Sn9xhHVMjv1cPVJ7g1E7JWDAXAtQIHDSkfOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7JU+MBkaPeNEhthv9d5urUN3OORVRnqggYUQzo0EjPMMDrA60OsoTvIzEcjFt5KLRScW45R/m9bJqqiMsB3a1YPkH2dhySg/EsfzPPkXeJjmdp8fn//ZyEN0eQwje0imygzhAMJvvDFp+cVN7SQNMbEsF1ncvZJ9GhiLSY7qNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5PEemnWD; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qb+hEUDBnocfW1i1l/WFDAmbxYJvmsrhRjk5pOLX5hM=; b=5PEemnWDMB+x+S2WPKDUafXd4a
	56e1ulnyshmquLyKyjXjb5SKFg45//2LllHPWj5ubqTY+tmrfGc6BZhOQ/q4cCRsgOu9++/Hnq3Me
	/CEO+2DhT+SDEjjBGlEcLL0jfhatqaki/7REb645mS9ebSpaxAl9edxIDxu7R4SJIaI8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiK6a-00BiF7-GQ; Sat, 11 Jul 2026 00:54:00 +0200
Date: Sat, 11 Jul 2026 00:54:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "D H, Siddaraju" <siddaraju.dh@intel.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Das, Shubham" <shubham.das@intel.com>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"singhai.anjali55@gmail.com" <singhai.anjali55@gmail.com>,
	"Brandeburg, Jesse" <jbrandeburg@cloudflare.com>
Subject: Re: Ethtool is missing C2C link modes
Message-ID: <e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306719-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:siddaraju.dh@intel.com,m:maxime.chevallier@bootlin.com,m:mkubecek@suse.cz,m:netdev@vger.kernel.org,m:balaji.chintalapalle@intel.com,m:shubham.das@intel.com,m:vijay.srinivasan@intel.com,m:sridhar.samudrala@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:singhai.anjali55@gmail.com,m:jbrandeburg@cloudflare.com,m:singhaianjali55@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[bootlin.com,suse.cz,vger.kernel.org,intel.com,gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6761673FA48

On Fri, Jul 10, 2026 at 09:45:43PM +0000, D H, Siddaraju wrote:
> Hello Linux Ethernet team, Maxime, Andrew & Michal,
> 
> The IEEE AUI chip-to-chip (C2C) is the accepted standard for connecting
> chips that handle subfunctions within the OSI physical layer. Just to
> pick, the C2C is widely used when connecting Ethernet SoCs with retimers
> and PCS SerDes terminated external-phys to offload PHY sublayer functions.

It cannot be that widely used if Linux does not support it yet :-)

> With the existing ethtool link modes, we were not able to fit these C2C
> interfaces on any others (we fitted **SGMII interfaces to baseT link modes)
> and we see this as a gap. If you acknowledge this, we plan to send an
> RFC patch to define below listed C2C link modes to ethtool.
> 
> 	25G_AUI_C2C		IEEE 802.3 Annex 109A

So 109 is about 25GBASE-R. We have the following link modes for that:

       ETHTOOL_LINK_MODE_25000baseCR_Full_BIT  = 31,
       ETHTOOL_LINK_MODE_25000baseKR_Full_BIT  = 32,
       ETHTOOL_LINK_MODE_25000baseSR_Full_BIT  = 33,

Why break the pattern? Why not add:

       ETHTOOL_LINK_MODE_25000baseC2C_Full_BIT

Is C2C that different to CR, KR, DR?

> 	200GAUI-4 C2C		IEEE 802.3 Annex 120D
> 	100GAUI-1 C2C		IEEE 802.3ck Annex 120F
> 	200GAUI-2 C2C		IEEE 802.3ck Clause 162
> 	400GAUI-4 C2C		IEEE 802.3ck Clause 163

If you look at the existing pattern for link modes which need to
specify the number of lanes:

        ETHTOOL_LINK_MODE_800000baseCR8_Full_BIT
        ETHTOOL_LINK_MODE_400000baseDR4_Full_BIT
	ETHTOOL_LINK_MODE_200000baseKR2_Full_BIT

why put the number in the middle?

Since you are breaking the existing pattern, it would be good to
include a justification why you picked your pattern.

Also, an architecture question...

It sounds like you use this between the MAC and the PCS. The PCS can
then be connected to a PHY, and the PHY then has a line side. (I'm
being a bit loose with the terms here, i should probably be saying
PMA, PMD etc.)

Should ethtool be saying:

Settings for eth0:
	Supported ports: [ TP	 MII ]
	Supported link modes:   25000baseC2C

or should it be reporting:

Settings for eth0:
	Supported ports: [ TP	 MII ]
	Supported link modes:   25000baseSR

I _think_ ethtool reports the media, not some intermediary format.

Is ETHTOOL_LINK_MODE_25000baseC2C_Full_BIT actually needed? I suppose
one use case would be when you directly connect two MACs together, PMA
to PMA. So a 25G NIC directly connected to a switch port, with no
'media' in the middle. Then ethtool probably should report
25000baseC2C.

	Andrew

