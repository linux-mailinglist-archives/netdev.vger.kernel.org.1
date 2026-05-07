Return-Path: <netdev+bounces-285300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJrfIF2C/GkcQwAAu9opvQ
	(envelope-from <netdev+bounces-285300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:15:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A54E80FD
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D66D301FD48
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435833EF0BB;
	Thu,  7 May 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ufX/kk6i"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E983ED104;
	Thu,  7 May 2026 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156001; cv=none; b=c3Uvnm9FNtEMqdhiFxwWea7ebQ0HRnv7zoN9E51aJqBdgqklnr1Wrlq3WiIM7QovMmshw8+CBx5CYkWJ5XUeORM1uSj95peFrxHaZsMzA0tYsFxArqvkTuZbGeMJOWCVPPj0rIEgCH/y102QtoG1LvQavgvh5dYtiNs6r6FXBg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156001; c=relaxed/simple;
	bh=V6fWqpFSJPMdgTfitPaJ1+bb22iQbWdkpSnEeVRLmHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OY5K+0YNp3ORI1XnVV4FDcs/S/i1pbWVOqdefAb0Qlwv+YOYvcREgkCgayiquXSUx0dc79cxYiTudTIt4CBrIUlGETBcRxaaWwQ6l0uDxZ+CWzrpNN9KMEf1YUcZSDjU/tpiJCO1DgYFf3WswP7FJx/QdE48u22XGWkhaRRO90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ufX/kk6i; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0A2794E42C2D;
	Thu,  7 May 2026 12:13:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C794F60495;
	Thu,  7 May 2026 12:13:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3DC010819483;
	Thu,  7 May 2026 14:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778155993; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+Ftx9k12Lemi+1+O946qI6HbpB8PGdkORjxMb2JLTTQ=;
	b=ufX/kk6igYUgFzVNRacIJalFsft5ERRaLDaV8I7QwdG3cSN3GmbVaRv3BtMslEfxQzxuHh
	24mJB9AYg6p0j526yrHzkwgrZGhaKZd+zz9btDG7NYlaPOrqhhXqjOPgesFAwlWH62k4rB
	qxnieiecOsty0Mu/Vg+h49ck+HFvoL/gHOiSNH1CZywPosL6Yd9lHwkZZfJdy/T6IOdeoW
	/avhALlbkmY5TD+pIgmnmYA3JF5JFY5BNku+aLz6XlBji4RPbd2HSnRmdrdt9JmJ1+1z4L
	UVnko33cC3s7bciSlNJo/8UaENngBwFxfnFB7QhBkERLqU2Sq7iq5NSpF4xCJw==
Date: Thu, 7 May 2026 14:13:05 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: lan966x: Accept standard ethernet
 prefixes
Message-ID: <20260507141305.2d84ecb5@bootlin.com>
In-Reply-To: <20260507115935.GA1119810-robh@kernel.org>
References: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>
	<20260507134043.35fdb1b9@bootlin.com>
	<20260507115935.GA1119810-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: D64A54E80FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	TAGGED_FROM(0.00)[bounces-285300-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	R_DKIM_ALLOW(0.00)[bootlin.com:s=dkim];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.898];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,e0000000:email]
X-Rspamd-Action: no action

Hi Rob, Linus,

On Thu, 7 May 2026 06:59:35 -0500
Rob Herring <robh@kernel.org> wrote:

> On Thu, May 07, 2026 at 01:40:43PM +0200, Herve Codina wrote:
> > Hi Linus,
> > 
> > On Thu, 07 May 2026 11:26:01 +0200
> > Linus Walleij <linusw@kernel.org> wrote:
> >   
> > > The dsa.yaml and ethernet-switch.yaml bindings recommend
> > > prefixing ethernet switches and ports with "ethernet-" so
> > > make the LAN966x do the same.
> > > 
> > > Reported-by: Herve Codina <herve.codina@bootlin.com>
> > > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > > ---
> > >  .../devicetree/bindings/net/microchip,lan966x-switch.yaml      | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> > > index 306ef9ecf2b9..0f0f35865ef4 100644
> > > --- a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> > > +++ b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> > > @@ -17,7 +17,7 @@ description: |
> > >  
> > >  properties:
> > >    $nodename:
> > > -    pattern: "^switch@[0-9a-f]+$"
> > > +    pattern: "^(ethernet-)?switch@[0-9a-f]+$"
> > >  
> > >    compatible:
> > >      const: microchip,lan966x-switch
> > > @@ -70,7 +70,7 @@ properties:
> > >      additionalProperties: false
> > >  
> > >      patternProperties:
> > > -      "^port@[0-9a-f]+$":
> > > +      "^(ethernet-)?port@[0-9a-f]+$":
> > >          type: object
> > >  
> > >          $ref: /schemas/net/ethernet-controller.yaml#
> > > @@ -138,7 +138,7 @@ additionalProperties: false
> > >  examples:
> > >    - |
> > >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > -    switch: switch@e0000000 {
> > > +    switch: ethernet-switch@e0000000 {
> > >        compatible = "microchip,lan966x-switch";
> > >        reg =  <0xe0000000 0x0100000>,
> > >               <0xe2000000 0x0800000>;
> > > @@ -151,14 +151,14 @@ examples:
> > >          #address-cells = <1>;
> > >          #size-cells = <0>;
> > >  
> > > -        port0: port@0 {
> > > +        port0: ethernet-port@0 {
> > >            reg = <0>;
> > >            phy-handle = <&phy0>;
> > >            phys = <&serdes 0 0>;
> > >            phy-mode = "gmii";
> > >          };
> > >  
> > > -        port1: port@1 {
> > > +        port1: ethernet-port@1 {
> > >            reg = <1>;
> > >            sfp = <&sfp_eth1>;
> > >            managed = "in-band-status";
> > > 
> > > ---
> > > base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> > > change-id: 20260507-lan966-binding-0df62a018509
> > > 
> > > Best regards,
> > > --  
> > > Linus Walleij <linusw@kernel.org>
> > >   
> > 
> > With those changes, dtb_check will not be happy when following dtsi/dts are
> > involved:
> >   - arch/arm/boot/dts/microchip/lan966x.dtsi
> >   - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt.dtsi
> >   - arch/arm/boot/dts/microchip/lan966x-pcb8290.dts
> >   - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
> >   - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-8g.dts  
> 
> How so? the added prefix is optional.

Oups, I've missed that. My bad.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Sorry for the noise.

Best regards,
Hervé

