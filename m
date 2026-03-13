Return-Path: <netdev+bounces-267264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CmgLGVts2kEWQAAu9opvQ
	(envelope-from <netdev+bounces-267264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:50:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B17727C4F1
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C05CB30624AE
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC8326952;
	Fri, 13 Mar 2026 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2KImEI5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0C32470E;
	Fri, 13 Mar 2026 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366593; cv=none; b=QVo2xsz2s7p7OyEYPwpIIuf7VyGvo9i0eI8X5yfFyAmfZxYO/gZXzsOCSueQ9I4gQBlpegXr0QqMR6hyIh5RClHpi2C26/z89EJwkeuKugKEngVVOXqFpdufks+mXhk/klqcDT4nBHwo/kEWa+vS3JH98/EVkA7ozVaJ7lN1mXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366593; c=relaxed/simple;
	bh=F91gakCgMQJ71odPLD1BnZmnceEA8oexGyjaqdDD64A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuNqzIqnVi3zEIjhKIMvVlyo/Q9BS1gvYY6PEp05MjJMvSVBi4N5tLAUrB2z25+QYyGfkBT+LpSbfiKATfF54skccLT1pgeU7/0A3+xoeK4H5Xq+RKckKozQuGm5R2Ldc0L1PLsYooMSm0DTW97QzZxpQA19nzJBBLfSwsQ6r6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2KImEI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3546C4CEF7;
	Fri, 13 Mar 2026 01:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366592;
	bh=F91gakCgMQJ71odPLD1BnZmnceEA8oexGyjaqdDD64A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j2KImEI5qMO7guoIMqk8r89msIKbSD6itp0DvbBzbdKIU7zAamLsu1X1k+nu5J/T+
	 v7YR7YwSfoe3WksOaPaxXm7H4I5bmeU87rPn3YC0zzVC04R3knbicY5l18L1mmvzKH
	 EcbJkF6anf7ccxf9AiNjsld1wT0EZ1nWPm6e9GprtYlYxTgaK+BhdfvwKigkhH8/5H
	 l3xjcHZHKbIIjiUORJrV0p/3FXTzIOtOHELb5gONSNoFAT5xhMh6b15e1ieXsdDTlJ
	 J6Enx5+zgrg2P9vV8vHJf63UEPRHhCpATz0JMgLGBmHX+C4XdLIMdSn+ePAnLC1RE+
	 837mBfAcGpQCw==
From: Jakub Kicinski <kuba@kernel.org>
To: charles.perry@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	nicolas.ferre@microchip.com
Subject: Re: [net-next,v2,1/3] dt-bindings: net: cdns,macb: add a compatible for Microchip pic64hpsc
Date: Thu, 12 Mar 2026 18:49:43 -0700
Message-ID: <20260313014943.1513621-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310212202.3991199-2-charles.perry@microchip.com>
References: <20260310212202.3991199-2-charles.perry@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-267264-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1B17727C4F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "Not sure about the first one but the second one looks
legit"

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
dt-bindings: net: cdns,macb: add a compatible for Microchip pic64hpsc

This commit adds "microchip,pic64hpsc-gem" for "PIC64-HPSC" and
"microchip,pic64hx-gem" for "PIC64HX" compatible strings. It also adds a
conditional schema check to prevent adding PHYs under the GEM node for
hardware where MDIO controllers are unconnected from physical pins.

> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -70,6 +70,14 @@
>                - microchip,sama7d65-gem   # Microchip SAMA7D65 gigabit ethernet interface
>            - const: microchip,sama7g5-gem # Microchip SAMA7G5 gigabit ethernet interface
>
> +      - items:
> +          - const: microchip,pic64hpsc-gem # Microchip PIC64-HPSC
> +          - const: cdns,gem
> +      - items:
> +          - const: microchip,pic64hx-gem   # Microchip PIC64HX
> +          - const: microchip,pic64hpsc-gem # Microchip PIC64-HPSC
> +          - const: cdns,gem

The fallback structure appears reversed from what was recommended in v1
review. Conor Dooley suggested that pic64hpsc should fallback to pic64hx:

  - items:
      - const: microchip,pic64hx-gem
      - const: cdns,gem
  - items:
      - const: microchip,pic64hpsc-gem
      - const: microchip,pic64hx-gem
      - const: cdns,gem

However, the current implementation has pic64hx falling back to pic64hpsc
instead. Was this reversal intentional, or should the order match the
reviewer's recommendation?

https://lore.kernel.org/netdev/20260303-emperor-childlike-6c43d8a91753@spud/

>
>    reg:
>      minItems: 1

[ ... ]

> @@ -196,6 +204,17 @@
>        required:
>          - phys
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,p64h-gem
> +    then:
> +      patternProperties:
> +        "^ethernet-phy@[0-9a-f]$": false
> +      properties:
> +        mdio: false

The conditional check references 'microchip,p64h-gem', but the compatible
strings actually added above are 'microchip,pic64hpsc-gem' and
'microchip,pic64hx-gem'. This causes the validation rule to never trigger
for the new hardware variants.

According to the commit message, the GEM IPs within pic64hpsc have their
MDIO controllers unconnected from physical pins, and this check should
prevent adding PHYs under the GEM node. However, device trees using
'microchip,pic64hpsc-gem' or 'microchip,pic64hx-gem' with invalid
MDIO/ethernet-phy configurations will silently pass schema validation.

Should this check use 'microchip,pic64hpsc-gem' instead?

This appears to be a remnant from v1 of the patch, where 'p64h' was used
as an abbreviation. Conor Dooley requested in v1 that the full 'pic'
spelling be used instead of the shortened form, and the compatible names
were updated accordingly, but this schema check was missed.

https://lore.kernel.org/netdev/20260303-emperor-childlike-6c43d8a91753@spud/

>
>  unevaluatedProperties: false
>
>  examples:
-- 
pw-bot: cr

