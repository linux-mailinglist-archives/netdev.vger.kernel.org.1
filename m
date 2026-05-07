Return-Path: <netdev+bounces-285294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHJiJht//GnXQgAAu9opvQ
	(envelope-from <netdev+bounces-285294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:01:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 372C94E7E8C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD550302D090
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101373EDAD0;
	Thu,  7 May 2026 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq45yKfc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDE3EDACE;
	Thu,  7 May 2026 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155178; cv=none; b=WFSqdwbTOfUpEVu6T6h30yPfYPehkMOMP+O/FprfyLdePDUkkcmnP/dNYT9N932kDTt0E23FoEO0cGI4sr1fFbiYFtDBygB1XR2ACP9rCNdhEdeFfsOt1wOBu0Abz61rctKJaeFQwBihOIJyEAHi+anSa2UXLy2Kx86xN89enNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155178; c=relaxed/simple;
	bh=9Qi7Bqf5701zJ+UIELOq4/coD675DIWia6FjFcBsdSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU6h0E3MrdlTXn21XzUWRSOiNT0OFvVrQd4jRN5ChG9eBqKH4NpQVq5lsLXFKi5vtOW5zyVWFch/n/uYEPJYJ7ZTwbMkd+DoFoYF1TO2NCK5cLMbKrbeYSDiKsZTb3mRSKJH9uhyUWBTb/Oasn1Xq5HsNX0/Iu0UvNXbycS/r8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq45yKfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEE1C2BCB2;
	Thu,  7 May 2026 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778155177;
	bh=9Qi7Bqf5701zJ+UIELOq4/coD675DIWia6FjFcBsdSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bq45yKfcYsPFrE1PHqbs6G+XyY2DJcGK41Vz3PwpzJB3t096MthbcPGb1ILjQ7XDw
	 Xo4pa/qX0L07J7j1Vai5aowj9taZgDkcjA6pfu90MU76J+Go2uXC16ufpjnl6JRRH5
	 0IOxz0YxsDe+gYfRyLpGBn7jFWPM9HFpB2Mb+dWjBW0vNoBYQSfyzlksJmIJyUHUt2
	 4mJ5e19UP6lfuYRPo2SczVOchJAhey9XFUM4dwCDZ0eodWRAA18AEzuybR53bWjCIW
	 wnUHLJ/ZnmnV7uKC5nvk0ZeYd3y8B17TCKy7hmwg+Z0MOHARiFcMGfElUpmWDJ+muH
	 ToaMw08cwweOQ==
Date: Thu, 7 May 2026 06:59:35 -0500
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: lan966x: Accept standard ethernet
 prefixes
Message-ID: <20260507115935.GA1119810-robh@kernel.org>
References: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>
 <20260507134043.35fdb1b9@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507134043.35fdb1b9@bootlin.com>
X-Rspamd-Queue-Id: 372C94E7E8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285294-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[12];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	NEURAL_HAM(-0.00)[-0.024];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.0:email,bootlin.com:email,e0000000:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 01:40:43PM +0200, Herve Codina wrote:
> Hi Linus,
> 
> On Thu, 07 May 2026 11:26:01 +0200
> Linus Walleij <linusw@kernel.org> wrote:
> 
> > The dsa.yaml and ethernet-switch.yaml bindings recommend
> > prefixing ethernet switches and ports with "ethernet-" so
> > make the LAN966x do the same.
> > 
> > Reported-by: Herve Codina <herve.codina@bootlin.com>
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > ---
> >  .../devicetree/bindings/net/microchip,lan966x-switch.yaml      | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> > index 306ef9ecf2b9..0f0f35865ef4 100644
> > --- a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> > +++ b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> > @@ -17,7 +17,7 @@ description: |
> >  
> >  properties:
> >    $nodename:
> > -    pattern: "^switch@[0-9a-f]+$"
> > +    pattern: "^(ethernet-)?switch@[0-9a-f]+$"
> >  
> >    compatible:
> >      const: microchip,lan966x-switch
> > @@ -70,7 +70,7 @@ properties:
> >      additionalProperties: false
> >  
> >      patternProperties:
> > -      "^port@[0-9a-f]+$":
> > +      "^(ethernet-)?port@[0-9a-f]+$":
> >          type: object
> >  
> >          $ref: /schemas/net/ethernet-controller.yaml#
> > @@ -138,7 +138,7 @@ additionalProperties: false
> >  examples:
> >    - |
> >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> > -    switch: switch@e0000000 {
> > +    switch: ethernet-switch@e0000000 {
> >        compatible = "microchip,lan966x-switch";
> >        reg =  <0xe0000000 0x0100000>,
> >               <0xe2000000 0x0800000>;
> > @@ -151,14 +151,14 @@ examples:
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> >  
> > -        port0: port@0 {
> > +        port0: ethernet-port@0 {
> >            reg = <0>;
> >            phy-handle = <&phy0>;
> >            phys = <&serdes 0 0>;
> >            phy-mode = "gmii";
> >          };
> >  
> > -        port1: port@1 {
> > +        port1: ethernet-port@1 {
> >            reg = <1>;
> >            sfp = <&sfp_eth1>;
> >            managed = "in-band-status";
> > 
> > ---
> > base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> > change-id: 20260507-lan966-binding-0df62a018509
> > 
> > Best regards,
> > --  
> > Linus Walleij <linusw@kernel.org>
> > 
> 
> With those changes, dtb_check will not be happy when following dtsi/dts are
> involved:
>   - arch/arm/boot/dts/microchip/lan966x.dtsi
>   - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt.dtsi
>   - arch/arm/boot/dts/microchip/lan966x-pcb8290.dts
>   - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
>   - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-8g.dts

How so? the added prefix is optional.

Rob

