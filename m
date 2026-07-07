Return-Path: <netdev+bounces-305568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zm/4HGJGTWpyxgEAu9opvQ
	(envelope-from <netdev+bounces-305568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:33:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B3771EA79
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:33:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bSEclqlg;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305568-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305568-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECAB43013716
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 18:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B13F3EBF36;
	Tue,  7 Jul 2026 18:33:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6643F4B6;
	Tue,  7 Jul 2026 18:33:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449181; cv=none; b=lMxbGnREyAo5GfypLGYVY8B7BhGSx+/JnhFASfPH1mktXv5xQ8pqRgMDYf0FN0vILUY4HYEJQbl0Ef+YaWLdMjLGSbunLVgqFZG6UCZNB6RZC6bpgQiKxLpidl6PIR6lUkLPVJtLTBnmw63bLFfGdj6IhtpjTwbXNVJn4Zj9htU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449181; c=relaxed/simple;
	bh=P51/JJ0y3mMFG7YE2Uz3EMjOL6J9azpFYTXILHsr97k=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=iid1Y1oyWq+OLkUsb0qECRm3wnkTIrCDdQfRSkA0rPwC8bUTsCiCZRRjGgBR7obDgdS45ttowYYDSMzPsRykSp5Y8/hz4P5oDM8dwtDekLxzEU7+3dlLUwhOJe7vGIq0p+024IsFtJI5IoLLNj49azAoxvamEVDQF4vsG5WsXNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSEclqlg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFEB1F000E9;
	Tue,  7 Jul 2026 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783449180;
	bh=oDId+F9Q8sjFATMQdxVY2dRWUEpcTb5ObrRiQhxwi+k=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=bSEclqlg+7W8IhP5E6cPoc66IbYZtj4myhu2F9bmfuW/c3zw70d4S21JKXmQgT1Tz
	 1ErfH04h2mUZzdcYihFvKqzbfIz61xMJ0DiLWdT3Ga/JJMJGJv55g/LLEtkt4wAJd+
	 2t53GAvtTZnWzO+IMD1/H7YM+9RLLsWAfBwph5FVwq7naW3g7qPeSSIXwk7fTVbP50
	 zVauK3buao0wmcX4SoK/uNlVtrZXUE56XpEl7HALTIOLh/sBpFuq/4urWFK+8Czmri
	 YO4xvT/hl6HL3V6Kaxn0caMRklSq9K/5ruNYucDSaoSH0ydb5hWk70eJJKLTY+DA4/
	 reM7vycowRd7Q==
Date: Tue, 07 Jul 2026 13:32:59 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: UNGLinuxDriver <UNGLinuxDriver@microchip.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>, 
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
To: Mikhail Lukianchikov <avermoal@gmail.com>
In-Reply-To: <20260707165840.107409-1-avermoal@gmail.com>
References: <20260707165840.107409-1-avermoal@gmail.com>
Message-Id: <178344917921.3727597.7607936677033722171.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: net: convert microchip,lan78xx.txt to
 YAML schema
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:UNGLinuxDriver@microchip.com,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:krzk+dt@kernel.org,m:linux-kernel@vger.kernel.org,m:Rengarajan.S@microchip.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:avermoal@gmail.com,m:conor@kernel.org,m:krzk@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305568-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7B3771EA79


On Tue, 07 Jul 2026 22:58:40 +0600, Mikhail Lukianchikov wrote:
> Convert the Microchip LAN78xx family (LAN7800, LAN7801, LAN7850) binding
> documentation from plain text to DT schema format using YAML.
> 
> The conversion was validated with 'make dt_binding_check'
> 
> Signed-off-by: Mikhail Lukianchikov <avermoal@gmail.com>
> ---
>  .../bindings/net/microchip,lan78xx.txt        |  53 --------
>  .../bindings/net/microchip,lan78xx.yaml       | 113 ++++++++++++++++++
>  2 files changed, 113 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/microchip,lan78xx.example.dtb: /: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/microchip,lan78xx.example.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/microchip,lan78xx.example.dtb: /: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/microchip,lan78xx.example.dtb: /: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
Documentation/devicetree/bindings/net/microchip,lan78xx.example.dtb: /usb: failed to match any schema with compatible: ['usb-host']

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/microchip,lan78xx.txt
MAINTAINERS: Documentation/devicetree/bindings/net/microchip,lan78xx.txt

See https://patchwork.kernel.org/project/devicetree/patch/20260707165840.107409-1-avermoal@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


