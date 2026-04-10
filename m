Return-Path: <netdev+bounces-277213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DzhMhVn2GnwcwgAu9opvQ
	(envelope-from <netdev+bounces-277213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:57:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D51243D19B1
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD866300845C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5196301704;
	Fri, 10 Apr 2026 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU+tNdyi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A920B22;
	Fri, 10 Apr 2026 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789840; cv=none; b=G6qVGxFPRQPbGZVeJ6JqBBGwth5g7a/XEu9Gkr3x1e/QfVutF9t+DiiDKkRU/K6shUGgSnblLvBq2ZH7ht221/qWmyMywvaHn3JyyzUWHQeG6qCK1EiMW6X7N/Q6ZAjAw/XA2jo92T9nB9qyTzAWJs2kJ+shHKwxjkxNcTW35WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789840; c=relaxed/simple;
	bh=IKf4EW+QLPbsa3En9V6h7KZYMgwrWGQkMLZPo2Qgp3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRAPnaAgZOJ6PZE0J48a3iTflAWqdRva0u+XXL0XJ8jNXqrworBu1Rbo4VBqqjcFZf7WYPdjbhzB0BcYTh1GAL9QNL7N4V6VJSs4FdEYEQwzNO1Pa1O1qST/sVrlIIvyehNIRCzTeTCYdHpxGzj7Mvp2kyCqXMfS4nm58cI7NNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU+tNdyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94145C4CEF7;
	Fri, 10 Apr 2026 02:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775789840;
	bh=IKf4EW+QLPbsa3En9V6h7KZYMgwrWGQkMLZPo2Qgp3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NU+tNdyi5LDgN+hZ25/LSwm+Rp0G2W/mqL5UgeESus1izF9V0gMno1z3dyjqul9dG
	 WEjnCgxPoJAvEIfCFl7bM5Aj5EddhGwEZAxKcl9e3vaCBfjVcsGGd1nwKM47vuIf7y
	 Ly+69/lFfA9tnW7q4cKJz/l+TMGVE/ymaBQoem7vJO3EvJbgVEk3Th6dPYh0DTuqEC
	 QKVb3V5rvQ9DzqR2sGUuD3Wyl6rIMLTdPdTtv4TfDGquupFU+StIwt9xMWoTgFltOT
	 rd0S8fOHDCpM042wA+SVAaJGZXNlZ43CLujtOqiSOW61QGpGUT0W3GbFBHM3LlTdIc
	 ykHDPWjqElkDQ==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/12] dt-bindings: net: airoha: Add EN7581 ethernet-ports properties
Date: Thu,  9 Apr 2026 19:57:17 -0700
Message-ID: <20260410025717.1809904-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-1-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-1-ab6ea49d59ff@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277213-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_PROHIBIT(0.00)[0.0.0.2:email,0.0.0.1:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D51243D19B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "For your consideration."
---
dt-bindings: net: airoha: Add EN7581 ethernet-ports properties

This commit introduces the ethernet-port property to model a net_device
connected via an external arbiter to the GDM3 or GDM4 ports on EN7581
and AN7583 SoCs.

> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> index fbe2ddcdd909c..ebbd433e9c9fb 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> @@ -130,6 +130,30 @@ patternProperties:
>          maximum: 4
>          description: GMAC port identifier
>  
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^ethernet-port@[0-5]$":

The commit message states that GDM1 and GDM2 do not support connection
with the external arbiter. However, since this pattern property appears to
be placed inside the generic ^ethernet@[1-4]$ block, does this allow a
device tree to incorrectly configure ethernet-port subnodes on ethernet@1
or ethernet@2 and still pass schema validation?

Could this be restricted to GDM3 and GDM4, perhaps by splitting the
patternProperties or using an if/then block based on the reg property?

> +        type: object
> +        unevaluatedProperties: false
> +        $ref: ethernet-controller.yaml#

Does referencing ethernet-controller.yaml cause a validation conflict here?

The ethernet-controller.yaml schema enforces a strict nodename pattern
of ^ethernet(@.*)?$. Since these new nodes use the -port suffix and are
named ethernet-port@X, will they unconditionally fail the node name
validation enforced by the referenced schema during dt_binding_check?

[ ... ]
-- 
pw-bot: cr

