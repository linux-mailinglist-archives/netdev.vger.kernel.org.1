Return-Path: <netdev+bounces-20188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B575E38B
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 18:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8E9281775
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041521C31;
	Sun, 23 Jul 2023 16:22:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1401879
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 16:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F25C433C7;
	Sun, 23 Jul 2023 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690129321;
	bh=VlKwicQ1FtbfywJIZNn75dqLhDSkbzEV7/AeiOVrpgw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=URS+/Gvavy5vkLcIuROrDFd772aHbPjyncKjtpUQHIiYm//H7ORNBfZlIV+wdTCMa
	 GSKKS1gevOYD9f8ZkPmcjwwEIrJGNWAmGiQlxNqSJpLMjrvY0u7JGu2E1om6IAk/SD
	 OaM5EpMxcZZdTXwzfbN+6glk63IUPUBb+qvu9koTTQ0gSVbeL9SM74Ls8f/6E1LkE4
	 r0H/FfykHBAgMO7o3exeJAyN/7opYVKh/u14S1qFKOkq5VRUs8m6qj2LIvh0h3fgrg
	 ORp22IrmYh7VU2y7ATVJ0+h0M12stfi4sBETVHhJTjz7Cde5NkE/pEWYQ28tqzx+Qe
	 1Z293/STzQTnA==
Received: (nullmailer pid 915352 invoked by uid 1000);
	Sun, 23 Jul 2023 16:21:59 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paolo Abeni <pabeni@redhat.com>, Po-Yu Chuang <ratbert@faraday-tech.com>, netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20230723155107.4498-1-fr0st61te@gmail.com>
References: <20230723155107.4498-1-fr0st61te@gmail.com>
Message-Id: <169012931925.915323.851405439785815833.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: net: ftgmac100: convert to yaml version
 from txt
Date: Sun, 23 Jul 2023 10:21:59 -0600


On Sun, 23 Jul 2023 18:51:07 +0300, Ivan Mikhaylov wrote:
> Conversion from ftgmac100.txt to yaml format version.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 102 ++++++++++++++++++
>  .../devicetree/bindings/net/ftgmac100.txt     |  67 ------------
>  2 files changed, 102 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/ftgmac100.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml: properties:clock-names: 'oneOf' conditional failed, one must be fixed:
	[{'enum': ['MACCLK', 'RCLK']}] is too short
	False schema does not allow 1
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230723155107.4498-1-fr0st61te@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


