Return-Path: <netdev+bounces-149265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0AA9E4F8C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D5A286F2E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0BE1C1F13;
	Thu,  5 Dec 2024 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L61V3IR+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A492391BC;
	Thu,  5 Dec 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386647; cv=none; b=g/cHNNhliLdYgA6QwO9Pzp/skoUft1pwIzQC956RJJTW9iiRsYhBlS9AcLf99llCVEsm0iLzCCLLnYlYrnYT0UaD4aqH7AzRaq04P8ThzVHrRaelKYbKkpakxx8bTY1+FKbLD4X7/g2MP9ZlOhKIU7MoaPpZFfeI/ug1wf4JuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386647; c=relaxed/simple;
	bh=ni+p7YrZWyil+4dN5QnPHPpHckV7kcNYl1xVZiVxSvo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Q7qylyd6f026VB7W8t0LbhIgdG/1AIVALLZ36VaRyoSjqQsQSX/7Uhfmz3ZBGvsDh7viUM2sHsDpcTCZBttidwpPPUOPhqiCxhYiagVFPYnxN+Bf6LWrROPAyD2tmwN7Je9u4U2UgM3Nvdd13dMM7iRb5oynEKepia7NwxECUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L61V3IR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AA5C4CED1;
	Thu,  5 Dec 2024 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733386646;
	bh=ni+p7YrZWyil+4dN5QnPHPpHckV7kcNYl1xVZiVxSvo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=L61V3IR+SxQz6YJuQbV+OFHLfzXVf65wr1piDng2DNpemcjcOYvfwaY8eiERFSUYH
	 qxpUX4HLlArJOqsJDurHU5AL2aSX42hkSEPk50Ikrb9Fu280RzH5p1ChoD7JU0R82O
	 Y3i8FLvuUuLHJcSZWEyT47xe2JVARA1VZHxSIwTFbWofM58IyQmU/u2tYHJlUxongj
	 yc3X7UoT42WoR4ZVA752nyGrZo166MyqECgSNdkU11D+m3eJq8kvKd10yH0vSER0OV
	 Aw/LmvJEmBGGu9rL4HHilm73mhM1TkunO+tJUhk/Dvd0cIbUM2dYHlUbyscy9K/3mr
	 KHG6gbrB/UBTQ==
Date: Thu, 05 Dec 2024 02:17:24 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
 pabeni@redhat.com, kuba@kernel.org, conor+dt@kernel.org, 
 p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, krzk+dt@kernel.org, 
 edumazet@google.com, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
In-Reply-To: <20241205072048.1397570-2-jacky_chou@aspeedtech.com>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
 <20241205072048.1397570-2-jacky_chou@aspeedtech.com>
Message-Id: <173338664470.2288815.2371095841901159008.robh@kernel.org>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: ftgmac100: support
 for AST2700


On Thu, 05 Dec 2024 15:20:42 +0800, Jacky Chou wrote:
> The AST2700 is the 7th generation SoC from Aspeed.
> Add compatible support and resets property for AST2700 in
> yaml.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml         | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml: then:properties:resets: {'maxItems': 1, 'items': [{'description': 'MAC IP reset for AST2700'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241205072048.1397570-2-jacky_chou@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


