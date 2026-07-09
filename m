Return-Path: <netdev+bounces-306351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4e9gNA33T2rxrAIAu9opvQ
	(envelope-from <netdev+bounces-306351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 21:31:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2E3734FFF
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 21:31:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xqvi1vRp;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306351-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306351-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B69B1301F9DD
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF2C3BB11B;
	Thu,  9 Jul 2026 19:31:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4D3BBFD3;
	Thu,  9 Jul 2026 19:31:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625465; cv=none; b=fJSpn7Ochkt/7p2+O4b4zY4/uCbekbFJlQMt0BIKMgikVg2xApqeZygv7w8vB10vG5948kTmUxyeii8NcTvdYLmDsNuivFOaCLEz9qZ5WyjQl/SXq090Ek20SBCCr6zOmTTsgt6Df8RkWz0gQ1UINhGYE4jq3oDfWGaQ8AmdNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625465; c=relaxed/simple;
	bh=nPdk0wLiglWbmv8CImFoITXX66UG323kvIOGdHTnBDE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LaMtC4343v/V9w/X9xeg2VXINE1AEy/46ADvGOSoxpk5WWIXnP7Ba6nLRC8ucrdg8LQqX9PjRbgau8tbamkMNsaSgPfaEkCQq3rjTaH4DVCVzDoM80N7IxCWVsfxLLLnblm0ORllQjxanrcRA7qTzbs5CnB75qTfuqigMwUmM8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xqvi1vRp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223CD1F00A3A;
	Thu,  9 Jul 2026 19:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783625462;
	bh=wOQPDaTUbeRaM7DIPsOUnVQ9NOIfjKXC/WmBn8dq7PE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=Xqvi1vRpGOpjTgMtOfg95Z5nfPVJ5WlY4AW3sFJIaWyLOm5UETnSXxW/70+AJN4NI
	 XnLoYyLEiZI7Wbq1dMWTD/QJil6cCmdDbkyc2KK8k84D9NB30D1Lr9FuklLSU5ojUs
	 3bqmbtV8BF+p8i5yNRmqlD43J5aZjHJ5zJWZxnJcWYF+1NR/sUvcX3jislN+w5GBdp
	 W053z5Gpw0Di5BI1D9pVTV5zUqhQGVWFFA8uM12seJj7xO2maDrXtzZCmRf7VS4e1a
	 ISPlpyl+F3PDE+TQEDZ5JQvqtBrOh0/Yv+71/TqPF34vBp5aWg6wKOIs+mn4SJcWUa
	 so/n2mSkOdbmw==
Date: Thu, 09 Jul 2026 14:31:01 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org, 
 Rengarajan.S@microchip.com, edumazet@google.com, andrew+netdev@lunn.ch, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
To: Mikhail Lukianchikov <avermoal@gmail.com>
In-Reply-To: <20260709181724.24682-2-avermoal@gmail.com>
References: <20260709181724.24682-2-avermoal@gmail.com>
Message-Id: <178362546037.1021520.7768707354122248220.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: net: microchip,lan78xx: convert to DT
 schema
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:pabeni@redhat.com,m:kuba@kernel.org,m:Rengarajan.S@microchip.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:conor+dt@kernel.org,m:krzk+dt@kernel.org,m:avermoal@gmail.com,m:andrew@lunn.ch,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306351-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA2E3734FFF


On Fri, 10 Jul 2026 00:17:25 +0600, Mikhail Lukianchikov wrote:
> Convert the Microchip LAN78xx family (LAN7800, LAN7801, LAN7850) binding
> documentation from plain text to DT schema.
> 
> The conversion adds proper validation for the 'microchip,led-modes'
> property inside the MDIO node and updates the MAINTAINERS entry.
> 
> Signed-off-by: Mikhail Lukianchikov <avermoal@gmail.com>
> ---
> Changes in v2:
>  - Rename file to microchip,lan7800.yaml.
>  - Keeps only one maintainer.
>  - Code style fixed.
>  - Example fixed, remove usb-port@1 node.
>  - Move patternProperties for PHY inside mdio node to fix validation. (suggested by sashiko-bot)
> 
> Link to v1: https://lore.kernel.org/netdev/20260707165840.107409-1-avermoal@gmail.com
> 
>  .../bindings/net/microchip,lan7800.yaml       | 105 ++++++++++++++++++
>  .../bindings/net/microchip,lan78xx.txt        |  53 ---------
>  MAINTAINERS                                   |   3 +-
>  3 files changed, 106 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan7800.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/microchip,lan7800.example.dtb: /: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/microchip,lan7800.example.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/microchip,lan7800.example.dtb: /: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/microchip,lan7800.example.dtb: /: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
Documentation/devicetree/bindings/net/microchip,lan7800.example.dtb: /usb: failed to match any schema with compatible: ['usb-host']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260709181724.24682-2-avermoal@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


