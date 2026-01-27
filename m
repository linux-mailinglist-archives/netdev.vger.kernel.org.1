Return-Path: <netdev+bounces-253938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJJxKVrmeGmHtwEAu9opvQ
	(envelope-from <netdev+bounces-253938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:22:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566797B0C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D1CA3015736
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46887360722;
	Tue, 27 Jan 2026 16:22:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8853002CF;
	Tue, 27 Jan 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530966; cv=none; b=QFTJqIoAfj0NjsajxUPpfJbL1ffdZXjpog2TGlFaHwvgzoLBoDXd9GTvMM6vhIQ+m1k73Xs8PFWaZIFZ33opVQnLkROqthEG4ow2jECaFVnSRhhPt0z5S62iIVkbpS/cGH1NBwWW6EUvv1opkUurJDI0dZUXyh70pHMaiDNmR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530966; c=relaxed/simple;
	bh=bzEzsJt4MXGUIhvPjvkK2AeikSGIbnB2herqMgXFsDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6u5jZqzU3ISElVAOzDchiP3SGPHgjie2ATLw3MvrrrzAH3LiqFalIfv2SYF9TaMthPW+yU86MtVOjbK/PXtbmQ9efndssEnqyAO3zVnROvxQyajbs4MXgjaBjUrfoAtXQwVfLyDll00itadHKsBXFg/LOWoURIS7wQLh48QAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vklpv-000000001ZH-0WCi;
	Tue, 27 Jan 2026 16:22:39 +0000
Date: Tue, 27 Jan 2026 16:22:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dsa: lantiq,gswip:
 reference common PHY properties
Message-ID: <aXjmTMasMdE52Gfw@makrotopia.org>
References: <cover.1769519758.git.daniel@makrotopia.org>
 <d9b6212ad5137feeb58b28e9b0784f1084c813df.1769519758.git.daniel@makrotopia.org>
 <20260127132919.xsvapgqc65f44iah@skbuf>
 <aXjGh1nzeAz8TQzH@makrotopia.org>
 <ad3bbac2-1aea-401a-881f-a8a9860f84a9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad3bbac2-1aea-401a-881f-a8a9860f84a9@lunn.ch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253938-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,hauke-m.de,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid,maxlinear.com:url]
X-Rspamd-Queue-Id: 0566797B0C
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:21:26PM +0100, Andrew Lunn wrote:
> > > Is the PCS integrated into the port?
> > 
> > The PCS is hard-tied to port 4 of the switch. Neither can that port be
> > used for anything else than this PCS, nor can the PCS be used elsewhere.
> > It's a bit like they nuked one of the TP PHY ports and glued in that
> > SGMII PCS instead. The PCS is probably a ready-made IP block
> 
> Does it have IDs in register 2 and 3?

That'd be too easy ;)

register 2 is SGMII_PHY_MPLL_CFG2
register 3 is SGMII_PHY_RX0_CFG1

register 2 and 3 of the XAUI PHY which can be indirectly accessed also doesn't
contain anything meaningful (0x000a and 0x0000)

> Is there any clue if it is licensed from somebody?

At least it's not obvious in any way.

The documentation is public, see
https://www.maxlinear.com/product/interface/ethernet/ethernet-switches/gsw145
"Ethernet Switch GSW145 Data Sheet"
Section 4.2 SGMII_Registers

My guess that it is not genuinly designed for that switch IC stems from
the fact that it has features (EEE, for example) which aren't supported
in the way it is integrated in the switch.

