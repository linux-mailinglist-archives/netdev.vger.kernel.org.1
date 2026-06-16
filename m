Return-Path: <netdev+bounces-299687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LoOMHOiaMGoWVAUAu9opvQ
	(envelope-from <netdev+bounces-299687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:38:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F0168AF8F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:37:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XxY9AAxN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299687-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299687-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 556E1301C953
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981F1F37D3;
	Tue, 16 Jun 2026 00:37:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D11EB5C2;
	Tue, 16 Jun 2026 00:37:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570263; cv=none; b=mXs+TTvg/ShTcA//vf8qx65f4gBWt1kJ9ZswbCnWlObqtQawxCREkLxEGIeghHSdEWEd4mlA3WYcPTs6VjooddJWjhmmqy61odH1O/r5FonUUBT1K26whUueD3CsakUU7IXvoshOBlBp+uuf5QO+Ad2anXsSN47uDEppliZjY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570263; c=relaxed/simple;
	bh=oDCsuCMb0UZskrnrhT93t4U6IJbXFvEYkSZJB+lCOTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrphi/4tOJJSXRFkEJMFW0Wc2IBQq1i498lQajI4uVfUbQdqytAPH5ecEHu1+hBuE6dG9CaCCEDwvtJ3WveJQc/08OfG6DXU5ulTnCUbaaG79t4T3WNlBYmnp9WeHjtPryE9IIw3sD73fjxiDCDeqphSkDhYzVhGMha/WoNA7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxY9AAxN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7931F000E9;
	Tue, 16 Jun 2026 00:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570262;
	bh=pwlfq9NsxzvBQnFHajGag7dZWGEpN/7xc03Xb09HCsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XxY9AAxNnPNz4OWCqKeqPTzktqgpClS279HKXuZWG02T1gng//GoRRLFl3uM21O3b
	 jBqgGY1FNhA4vTxmnbdz0Z1oLIsb3yBVxg1Qi1onXxmBOYFa6+RwODvNBlUBR6XmI1
	 eovEIzVNE3QEvhSq6cQKYAlKiRrnY+i27KfOglFwNloJ/PwJrCi8W0qn/0gtyrOf5S
	 lZs7Eldnw83o7Tv56BiZoBaV1cOQ3TOVA4B1692KmGjrFxPzuCVaoOz+2/VtlX4TiT
	 b1sYt98COLjJCCdG+bS5nvRimrYIwr8YjqZECpOX9oDdb9Kc/bbrv03q9dPthG4/SP
	 A3OXRedtmd3CQ==
From: Jakub Kicinski <kuba@kernel.org>
To: markus.stockhausen@gmx.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Mon, 15 Jun 2026 17:37:39 -0700
Message-ID: <20260616003739.1104538-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613112946.1071411-2-markus.stockhausen@gmx.de>
References: <20260613112946.1071411-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:kuba@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299687-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8F0168AF8F

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series

This commit extends the realtek,rtl9301-mdio binding to cover the
lower-end Realtek Otto switch families: Maple (RTL8380/8381/8382) and
Cypress (RTL8391/8392/8393). New compatible strings are added for these
SoCs alongside the existing RTL9300/RTL9311 entries.

> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> index 271e05bae9c5..de33364b67ef 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> @@ -12,6 +12,16 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - enum:
> +              - realtek,rtl8381-mdio
> +              - realtek,rtl8382-mdio
> +          - const: realtek,rtl8380-mdio
> +      - items:
> +          - enum:
> +              - realtek,rtl8392-mdio
> +              - realtek,rtl8393-mdio
> +          - const: realtek,rtl8391-mdio

[Low]
With this change the binding now describes three distinct SoC families
(RTL83xx Maple, RTL839x Cypress, and the existing RTL93xx), but the
file still carries:

  title: Realtek RTL9300 MDIO Controller

Should the title (and the top-level description, if applicable) be
updated to reflect the broader scope now that RTL8380/8381/8382 and
RTL8391/8392/8393 are covered by the same schema?

> @@ -24,6 +34,8 @@ properties:
>                - realtek,rtl9313-mdio
>            - const: realtek,rtl9311-mdio
>        - enum:
> +          - realtek,rtl8380-mdio
> +          - realtek,rtl8391-mdio
>            - realtek,rtl9301-mdio
>            - realtek,rtl9311-mdio
>
-- 
pw-bot: cr

