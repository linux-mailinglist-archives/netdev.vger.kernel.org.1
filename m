Return-Path: <netdev+bounces-272280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPbOAmm+xWkeBAUAu9opvQ
	(envelope-from <netdev+bounces-272280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:16:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9165633CFB6
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6CF2302A520
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D234E74E;
	Thu, 26 Mar 2026 23:11:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1467351C10;
	Thu, 26 Mar 2026 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774566694; cv=none; b=QsdXGo45FC7wgqnBRuFxXR2xmHiL2hFL659ct9p5UleSfdYdZIN2xPEEXjFR7H1tZVBeRMRUyjAdJzPO0GQQ5unm1J8MlOjIH0rQ6QB9S/gSiOwoIIfyAuzSO+lTYq8/P99X7OSVi3Hf4L+d0F16dvzvNDNc+0iNKSG1L+ch8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774566694; c=relaxed/simple;
	bh=aiNzbg55Me8/6ra6ON8VHicbaEbyNwmfMoAes3c0TC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnbAdnif1oiWScMbtgcEgvCF1rWqetdH60NA6y1FSedCY7ydNQxwP0P+OcDeEBoZaZpUpX1k9z56ZCSGNmB+fKsCmeQHUKMyFkAFGlZNSgWMR1vLGJfnipC6+D1CxTuzaiTSEWZXR1fhEJH5CiMO+vAzqdkvRizbeKhkSuIlRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w5trK-000000006dg-0Zct;
	Thu, 26 Mar 2026 23:11:26 +0000
Date: Thu, 26 Mar 2026 23:11:23 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: add MT7628 ESW
Message-ID: <acW9G8vrMz89Enss@makrotopia.org>
References: <20260326204413.3317584-1-joey@tinyisr.com>
 <20260326204413.3317584-2-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326204413.3317584-2-joey@tinyisr.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272280-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.6:email,tinyisr.com:email,makrotopia.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9165633CFB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:44:10PM +0200, Joris Vaisvila wrote:
> Add bindings for MT7628 SoC's Embedded Switch.
> [...]
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
> new file mode 100644
> index 000000000000..d3c9df30ed5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/mediatek,mt7628-esw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT7628 Embedded Ethernet Switch
> +
> +maintainers:
> +  - Joris Vaisvila <joey@tinyisr.com>
> +
> +description:
> +  The MT7628 SoC's built-in Ethernet Switch is a five port switch with
> +  integrated 10/100 PHYs. The switch registers are directly mapped in the SoC's
> +  memory. The switch has an internally connected 1G CPU port and 5 user ports
> +  connected to the built-in Fast Ethernet PHYs.
> +
> [...]
> +            port@6 {
> +                reg = <6>;
> +                ethernet = <&ethernet>;
> +                phy-mode = "rgmii";

Is this actually RGMII internally? Or some unknown internal way to
wire the switch CPU port to the CPU MAC? In this case, "internal"
should be used here as well.

