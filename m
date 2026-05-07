Return-Path: <netdev+bounces-285279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNKFEgJ7/GkwQgAAu9opvQ
	(envelope-from <netdev+bounces-285279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:44:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB32B4E7A65
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DAAA305EF67
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4423E8688;
	Thu,  7 May 2026 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yNwAi/22"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109B3E6DE8;
	Thu,  7 May 2026 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154054; cv=none; b=FfIZTE3+qLKPp5W+JjiYsKGDnSrXUBPi42U3sNgBP8WPjy8tnGsHDG1pgsGgXsUlOWJWzJRCMqr+wRscSQSTR+8MiJ0TBJ/3Z2Dqf+0XpqYLnEL3jEwjmPpVcStMX2kcdo546UZGIbfHfiCRXpXyBkyQX9hKf3M9cDXLyuBee3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154054; c=relaxed/simple;
	bh=Ljcv0sP7OdGRzGMPcPlzo4vL4eqkqZAH0pJ3yD8mQhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nklplnKFDNU7YNZS2EV2NhDGbBa8HfJtWzK6X1hkuVpDjSvMtDiXcnT1ZpIJlZVbGXMmZJfN68ESm/bJjXufv/nr+zgqdxRkxWLlEOHaGwCAEHcInHabOC3JvA/DdDA5j1NtXiOCxncZEHAK3A/fT7BxGQIfBT0qMMhe/hoWSKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yNwAi/22; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 31E0CC5DC5B;
	Thu,  7 May 2026 11:41:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C9DB60495;
	Thu,  7 May 2026 11:40:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBE60107F2392;
	Thu,  7 May 2026 13:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778154049; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gSfYtuWjOT5LpDJ9EwdjiU/eoXSwkeYgp7LEVAKYAY8=;
	b=yNwAi/22GAOgUTY7IDGlhuTyl/C9azi9u+uNGSW8DRy34dzEDh2IFZ70mQdWmcynISc8EZ
	AUysPvzK+kRGwD7hLdT26aHsxWQFMs+HtDQ5YqyKQNW9QvnpumZZF5fcUN33UjjjYWWe3F
	mfUaX2R+zvpqWw6ZgWallNYc7o52dzJno9RGvX1s2FLlbM18eLUPbce7WzpFI4yEvmTaj1
	xyws+mroWGdWUcwADZqQK+HSumuyf5Q2k1qxkPoeJ5lgy7b+R9q6AuSHEoQzsS5HIFARpz
	rEXHPRVYwuBUjhKNyyvgbfBphVPjzRDXwPcoZ+AFkY2cUBKd8wYkndQbCH9SEg==
Date: Thu, 7 May 2026 13:40:43 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: lan966x: Accept standard ethernet
 prefixes
Message-ID: <20260507134043.35fdb1b9@bootlin.com>
In-Reply-To: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>
References: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>
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
X-Rspamd-Queue-Id: AB32B4E7A65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285279-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[bootlin.com:s=dkim];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.881];
	TAGGED_RCPT(0.00)[netdev,dt];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.0:email,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

Hi Linus,

On Thu, 07 May 2026 11:26:01 +0200
Linus Walleij <linusw@kernel.org> wrote:

> The dsa.yaml and ethernet-switch.yaml bindings recommend
> prefixing ethernet switches and ports with "ethernet-" so
> make the LAN966x do the same.
> 
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../devicetree/bindings/net/microchip,lan966x-switch.yaml      | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> index 306ef9ecf2b9..0f0f35865ef4 100644
> --- a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
> @@ -17,7 +17,7 @@ description: |
>  
>  properties:
>    $nodename:
> -    pattern: "^switch@[0-9a-f]+$"
> +    pattern: "^(ethernet-)?switch@[0-9a-f]+$"
>  
>    compatible:
>      const: microchip,lan966x-switch
> @@ -70,7 +70,7 @@ properties:
>      additionalProperties: false
>  
>      patternProperties:
> -      "^port@[0-9a-f]+$":
> +      "^(ethernet-)?port@[0-9a-f]+$":
>          type: object
>  
>          $ref: /schemas/net/ethernet-controller.yaml#
> @@ -138,7 +138,7 @@ additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> -    switch: switch@e0000000 {
> +    switch: ethernet-switch@e0000000 {
>        compatible = "microchip,lan966x-switch";
>        reg =  <0xe0000000 0x0100000>,
>               <0xe2000000 0x0800000>;
> @@ -151,14 +151,14 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        port0: port@0 {
> +        port0: ethernet-port@0 {
>            reg = <0>;
>            phy-handle = <&phy0>;
>            phys = <&serdes 0 0>;
>            phy-mode = "gmii";
>          };
>  
> -        port1: port@1 {
> +        port1: ethernet-port@1 {
>            reg = <1>;
>            sfp = <&sfp_eth1>;
>            managed = "in-band-status";
> 
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260507-lan966-binding-0df62a018509
> 
> Best regards,
> --  
> Linus Walleij <linusw@kernel.org>
> 

With those changes, dtb_check will not be happy when following dtsi/dts are
involved:
  - arch/arm/boot/dts/microchip/lan966x.dtsi
  - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt.dtsi
  - arch/arm/boot/dts/microchip/lan966x-pcb8290.dts
  - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
  - arch/arm/boot/dts/microchip/lan966x-kontron-kswitch-d10-mmt-8g.dts

IMHO they should be updated as part of the series.

Best regards,
Hervé

