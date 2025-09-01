Return-Path: <netdev+bounces-218856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6617B3EDED
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C581A88434
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608CB320A06;
	Mon,  1 Sep 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBukxT1i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B14202997;
	Mon,  1 Sep 2025 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756751666; cv=none; b=tSm0P6mB2H3jr+GMMjAbGWljqtz/Ad9CkFntp/2PEDWkRV7BCh+40dtKcD34EITRVce1pTH7J9xJM+UaEC4bo8thpnLYVQX5+sQXVk/s/hd+R2+oMr6UKLaoXFXZrepv5tHqndFy6/0BEAYU0JOUxikKPK8Dx/CvUbwqksamMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756751666; c=relaxed/simple;
	bh=D46GHdoN/n1k1YzmS3UciOt8fqGu8n9y7YtX+yxd3l4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rKEWBx+PgY2YG6KCReYdCdttkkJrD6BZ8aR5W1nm60YGcAODaNYhLCkHqfgb3Z2a7yOsbwqtlfH7TTY++v6V5NREU0Fsd3n/cYFYX3mBaUZCDLuIUt8b562DwtXVUQJw0jVIT0FD/+XOHWfpvIKI2UvytaYDXVPXRe7iW00TiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBukxT1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C22BC4CEF0;
	Mon,  1 Sep 2025 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756751664;
	bh=D46GHdoN/n1k1YzmS3UciOt8fqGu8n9y7YtX+yxd3l4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=tBukxT1iDHx1MtlqYb8fa5G/EVEJe6WC3XgUqfEcxiQ2ZJhI/SzJww12udDUSbQy3
	 4fOregpneiqU7aVHY5ywvuIYjQlPpZk6SKfnwNfx1x4t2TndKWpxCir7rsnZbZo3MP
	 cGB8XYZLNeU//1qHdGRX9LaZhcmubUO5uk0MJL0tVf4+5ldPr/sSHE7rPMjVlZG/+G
	 D4pcdCbtxj/vQhIJ0CwFaCD3vP9/vjQgzfB4F8kCHT7w91i42+DM8ecAjUf+k3fuXX
	 f7MRpKZiOB8mxdQQ7t8szTsQpQFijWcjikananK+HYPFZuCfysR1rfRQac5yNsAWGp
	 8ft45he34eFhg==
Date: Mon, 01 Sep 2025 13:34:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Quan Nguyen <quan@os.amperecomputing.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 Keyur Chudgar <keyur@os.amperecomputing.com>, 
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
In-Reply-To: <20250829202817.1271907-1-robh@kernel.org>
References: <20250829202817.1271907-1-robh@kernel.org>
Message-Id: <175675161498.5921.10650849049249219942.robh@kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Convert apm,xgene-enet
 to DT schema


On Fri, 29 Aug 2025 15:28:14 -0500, Rob Herring (Arm) wrote:
> Convert the APM XGene Ethernet binding to DT schema format.
> 
> Add the missing apm,xgene2-sgenet and apm,xgene2-xgenet compatibles.
> Drop "reg-names" as required. Add support for up to 16 interrupts.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/net/apm,xgene-enet.yaml          | 114 ++++++++++++++++++
>  .../bindings/net/apm-xgene-enet.txt           |  91 --------------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 115 insertions(+), 92 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/apm,xgene-enet.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/apm-xgene-enet.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/apm,xgene-enet.example.dtb: ethernet-phy-id001c.c915@3 (ethernet-phy-id001c.c915): $nodename:0: 'ethernet-phy-id001c.c915@3' does not match '^ethernet-phy(@[a-f0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/apm,xgene-enet.example.dtb: ethernet-phy-id001c.c915@3 (ethernet-phy-id001c.c915): Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/realtek,rtl82xx.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250829202817.1271907-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


