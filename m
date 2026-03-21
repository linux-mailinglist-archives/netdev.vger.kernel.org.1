Return-Path: <netdev+bounces-270252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IME2GmD4vmnmmgMAu9opvQ
	(envelope-from <netdev+bounces-270252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:58:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A19F2E716D
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B95030156C6
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FB535C19B;
	Sat, 21 Mar 2026 19:58:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91FE253932;
	Sat, 21 Mar 2026 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123100; cv=none; b=TllsTSGH3gETJd4fDc9oKq9XTfuAMmltmUzrVJ+1W6amwr1pAn2TW77U/42FAKUKWvr335oKTkTxrgK7fpEh7jE3FggNkcHpDRu/OPveLsYT/Tidh1xF6DVYItVIT1bcCuWe/i5g6yFxV1OcRxVWkHXY7IhmdZn3GXK4nt/qhLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123100; c=relaxed/simple;
	bh=a7AXLFxq4/Tc+kA0yTxLBTleu4PLSeVGFcwMoHNJTTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4jHGBIkNhLeJ55KXlg+s+MxwDfpnulXg3xI6T8mEbizLL38PFDSM91cjcLv6gCWVhVJFi9dVwwE35q7ZrmdQqqGm50uds5Ibu99fuIetvjGFmzfcDmcJMOGyZoEAEGZvqwaKfjHxwTCMxWy+iaJWO6Hs+vanN0qJss+p+MQFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w42Se-000000000nk-2rWU;
	Sat, 21 Mar 2026 19:58:16 +0000
Date: Sat, 21 Mar 2026 19:58:13 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [RFC v3 1/4] dt-bindings: net: dsa: add MT7628 ESW
Message-ID: <ab74VdNNS2MaVd1r@makrotopia.org>
References: <20260321194340.2140783-1-joey@tinyisr.com>
 <20260321194340.2140783-2-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321194340.2140783-2-joey@tinyisr.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270252-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tinyisr.com:email,makrotopia.org:mid]
X-Rspamd-Queue-Id: 2A19F2E716D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 09:43:37PM +0200, Joris Vaisvila wrote:
> Add bindings for MT7628 SoC's Embedded Switch.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> [...]
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
> new file mode 100644
> index 000000000000..5955c07a1be7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
> [...]
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#

Why would anyone define the MDIO bus or PHYs therein?
 - PHY addresses match port addresses
 - Only C22 operations are used
 - No reasonable way to connect any external PHYs
=> relying on ds->user_mii_bus, or even just defining phy_read and phy_read ops
in struct dsa_switch_ops should be sufficient? Unless you need the PHYs in DT,
eg. to define PHY LEDs... But that can then come later once you actually add
support for that.
(netdev maintainer folks: correct me if I'm wrong)

> [...]
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                label = "swp0";

Do not add labels in binding example, remove them from
all ports.

