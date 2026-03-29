Return-Path: <netdev+bounces-272996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK1wKPWDyWnfygUAu9opvQ
	(envelope-from <netdev+bounces-272996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:56:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7F3353D9F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 507B33003BF1
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A173876B3;
	Sun, 29 Mar 2026 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tV6ZGpUI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DC431E832;
	Sun, 29 Mar 2026 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814187; cv=none; b=KAr82j3hdARlvt1gVlFfakECTF7ZHQ75YA52aAr+Zd34M40beErZJO32WCs8NTWYvIJsUTC/CHhTT+OqJj415W6HzOZ7yGK+dBQtln9CjHAMJ4+25ErZcst5TAU+A/Y7pnY/ij8bPWclrsNXATAiKXH7GtQ8EfVioOpkZv06zm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814187; c=relaxed/simple;
	bh=ZJ5/QEyJDwHeAjpIviEC2gkwfNZ0Zbh042e2vzaSits=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWshPnfW7ZCa8X/dJR8K/j5Uqrq6y9o0lS36hCaPHq0NDw6XjXwdLt+tG5OwRqdp8xVIXSYI77LFvzciws7udafOa5vbG3QQQkTCsWgdFJAVQwir2uOthBen6jRo+XVa3p449v/tKayFzX/nMwKplTwWs7zIxZxiV6YIYaFRCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tV6ZGpUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89948C116C6;
	Sun, 29 Mar 2026 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774814187;
	bh=ZJ5/QEyJDwHeAjpIviEC2gkwfNZ0Zbh042e2vzaSits=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tV6ZGpUIeKXEfgRargYr/cZTEepNlTxsFhB13tgWfJ7FKGmy7KKvct+w8iXHnPYJg
	 rJTnkVwMSxGt4Xs6z9kWeFM3g1Jg0RfNeivczzpnCgK/C6mb3f5fV409OseUpVAegX
	 I64JGYkhXsxhEv7SizJA+UM1KnrZxZSpoCjhRA+9VJXFcfWfwIUE+6L7Kzm4/k++yo
	 dLv7E5P/H9MN7TEGFKnYMKhMLO0MPE+Zh0a19OIwnJeqQO81mGeQzLKz5TDaJxBV4m
	 fo+wsyI5VhfRU4awVrt9CmPV3UZsn3KexFOfZIMZkJ96bLKvRjuxUh0rXruAeprY80
	 OEnIKJ4L/J9QQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	woojung.huh@microchip.com,
	linux@armlinux.org.uk,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/9] dt-bindings: net: lan9645x: add LAN9645X switch bindings
Date: Sun, 29 Mar 2026 12:56:25 -0700
Message-ID: <20260329195625.2789069-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-2-f7504e3b0681@microchip.com>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-2-f7504e3b0681@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-272996-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.9:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE7F3353D9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dt-bindings: net: lan9645x: add LAN9645X switch bindings

Add bindings for LAN9645X switch. We use a fallback compatible for the
smallest SKU microchip,lan96455s-switch.

> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
> new file mode 100644
> index 000000000000..0282e25c05d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml

[ ... ]

> +patternProperties:
> +  "^(ethernet-)?ports$":
> +    type: object
> +    additionalProperties: true
> +    patternProperties:
> +      "^(ethernet-)?port@[0-8]$":

Does having additionalProperties set to true bypass the port number
restriction?

Since dsa.yaml allows port@[0-9a-f]+, it seems port@9 would silently pass
validation as an additional property. Should this be unevaluatedProperties
set to false instead?

> +        type: object
> +        description: Ethernet switch ports
> +
> +        $ref: dsa-port.yaml#
> +
> +        properties:
> +          rx-internal-delay-ps:
> +            const: 2000
> +
> +          tx-internal-delay-ps:
> +            const: 2000

Does enforcing a 2000ps delay conflict with standard rgmii bindings?

As documented in net/ethernet-controller.yaml, a full 2ns delay is
typically modeled using phy-mode set to rgmii-id rather than hardcoding the
delay properties with a base rgmii mode.

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false

How are the five integrated 10/100/1000Base-T phys mentioned in the
description modeled?

Since unevaluatedProperties is false at the top level and there is no
definition or reference for an mdio node, wouldn't adding an mdio subnode
to configure these phys fail schema validation?

Should there be a reference to /schemas/net/mdio.yaml#?

