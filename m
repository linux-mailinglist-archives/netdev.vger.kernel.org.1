Return-Path: <netdev+bounces-266559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OS8Glw+sWmtswIAu9opvQ
	(envelope-from <netdev+bounces-266559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:05:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC700261B76
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0315E330B638
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF1A3DCD80;
	Wed, 11 Mar 2026 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEShXGZl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE173DC4CE;
	Wed, 11 Mar 2026 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221089; cv=none; b=JTZ22KEZXjyFhqunBR1dbNYX2jxAP9u+BjK+2JHD2cV7swAZOW7eUnXCODSdeb0wy1fuc4l8kk48LcGOtFp8wCMqQYcmHcscwkR72+5CDxOjTx37GMpa+cjIjGcpobKjR9AbD/W8JKweX3h1MmQcl4gv8ndQk9vyWi529SOhKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221089; c=relaxed/simple;
	bh=sK0fiSjATxGyVujmdLFUMxxWbcCE3K/15DJI5Kl2I4U=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=CsZC94PrQ0+DBHRsWAbcPKIMvrYYQ6KwpKl0cZdbIo4ky7pJmDUGJMPZCII1NV6DciJmNZ774d//Fw3DPHW0GgPyEKiFXDbaPcgsSli4EPgYdu0o9U0LsdbWy1EC2rujQQpXWhjQhlzHgoG0V4CmfnOD8KdxaHtulOcZFD8HUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEShXGZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1223EC4CEF7;
	Wed, 11 Mar 2026 09:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773221089;
	bh=sK0fiSjATxGyVujmdLFUMxxWbcCE3K/15DJI5Kl2I4U=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=AEShXGZlpgiBVAbSH8SaQd4/6Zs4F6J3fMFPd5JYtelQyPQRzdNhN9CFQ9CQZzsr8
	 ttE0LXjjs9wmc6IhzdywKgPMd9bqvAcb3f2JkNlSXAyFinxVDN9EQqndVJypvoABLl
	 7Ls80LYETiF0gX0eCmR3ArTB/ok0Mg3Zjc9KugvacVzyjwZcb59NHJIbLebrrifTCt
	 JW5WDKTMfIhqPz6Pd6p1otqn2k8lh0h+qY8Sl7oCqcFqhXD4dqARcD+W1AMTkOENik
	 eMMldBfoOx4PznOEUyj+ywNzgqlehTWEw3hWNACiRycXULXlxz7luUerIddkWUdqeY
	 V4RJOD0NNsQ0w==
Date: Wed, 11 Mar 2026 04:24:48 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: NXP S32 Linux Team <s32@nxp.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 "David S. Miller" <davem@davemloft.net>, boon.khai.ng@altera.com, 
 vladimir.oltean@nxp.com, Sascha Hauer <s.hauer@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, rmk+kernel@armlinux.org.uk, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Matthias Brugger <mbrugger@suse.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 Fabio Estevam <festevam@gmail.com>, Chester Lin <chester62515@gmail.com>, 
 imx@lists.linux.dev
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
In-Reply-To: <20260311-dwmac_multi_irq-v9-4-f0c03ef8d01f@oss.nxp.com>
References: <20260311-dwmac_multi_irq-v9-0-f0c03ef8d01f@oss.nxp.com>
 <20260311-dwmac_multi_irq-v9-4-f0c03ef8d01f@oss.nxp.com>
Message-Id: <177322108829.2695119.13138199275449513148.robh@kernel.org>
Subject: Re: [PATCH v9 4/5] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
X-Rspamd-Queue-Id: CC700261B76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,st-md-mailman.stormreply.com,davemloft.net,altera.com,pengutronix.de,kernel.org,armlinux.org.uk,vger.kernel.org,lunn.ch,oss.nxp.com,suse.com,gmail.com,google.com,redhat.com,foss.st.com,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-266559-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Wed, 11 Mar 2026 08:53:59 +0100, Jan Petrous (OSS) wrote:
> The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lines,
> set them to allow using Multi-IRQ mode.
> 
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 47 +++++++++++++++++++---
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml:57:7: [error] duplication of key "items" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml:57:7: found duplicate key "items" with value "[]" (original value: "[]")
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/nxp,s32-dwmac.example.dts'
Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml:57:7: found duplicate key "items" with value "[]" (original value: "[]")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/nxp,s32-dwmac.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1597: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260311-dwmac_multi_irq-v9-4-f0c03ef8d01f@oss.nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


