Return-Path: <netdev+bounces-216924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 135E7B36157
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5917A1BA6BD2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E7F223DE5;
	Tue, 26 Aug 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqITwN81"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725B211491;
	Tue, 26 Aug 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213511; cv=none; b=ICUK0V7iPwmuQp0dXTD6t0CwZP0Zv4ONneYVYhlOgOZDfc0+B/P2gLv88gc9sYP/nzlAQoDa5ni/8ffzA3K7xb4eCwRIi8R7zzGvNzmSTyczlI8E+IJsLXWAp0LDHxNMsOxqx12pRWBXOPgy3TwQ4FF5N4JjgAE+jiW1RPwbov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213511; c=relaxed/simple;
	bh=oVWUaTb9JTJ6VCjQWJr2JJZLQXbpB2cQ8kVN0SOUbIQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GdGX+VkoWB2m/3IOna0MpX7JUOabsUGJ0IzcB2oDfjcXuXeEC3CT1Z2uzJd6Bfow5+1MTcG3SqSGN5uGsFf+M4EZ6mB16Ni/hZ75yUIITbbFHIUM3JiVote3gOGXtWCkcwVy5gDkyZ3uXnuzjAs00Cx7cyFsgMQiDrnXu44qPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqITwN81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B2CC4CEF1;
	Tue, 26 Aug 2025 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756213511;
	bh=oVWUaTb9JTJ6VCjQWJr2JJZLQXbpB2cQ8kVN0SOUbIQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YqITwN81aCSIAjjlRKtqxxMDT3OwGtG79wvALWYqfA+M5IqocJpi05LSUm0H8PbgG
	 8sQwtQYClfF/XTptMACHPrWYEysboEIWprljjQAe/oVj8KqmS+Dg44gDpDPopsEp+m
	 WeZwK2Evi5/FcHJTxaFaFr/ViRI0l4tzYFFRkOAm0p1eIQKHq4+B79cJNYTHE/701/
	 KqXZHEwZS15xV5ZD2MmywNhVa8HJ7w6D+V16nyRuTH53wA8L33Uhmwy+8t83DzgVTy
	 VHWxUCVdk4t4P7YzyMtipTKATGkl+apXLzlJzY6NInaTSBiw6iwDjq88iN4NO3xspy
	 mjwNqtK5RKutA==
Date: Tue, 26 Aug 2025 08:05:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, conor+dt@kernel.org, 
 sureshnagaraj@maxlinear.com, edumazet@google.com, 
 devicetree@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org, 
 krzk+dt@kernel.org, yzhu@maxlinear.com, netdev@vger.kernel.org
To: Jack Ping CHNG <jchng@maxlinear.com>
In-Reply-To: <20250826031044.563778-2-jchng@maxlinear.com>
References: <20250826031044.563778-1-jchng@maxlinear.com>
 <20250826031044.563778-2-jchng@maxlinear.com>
Message-Id: <175621343176.4659.6580069253445672718.robh@kernel.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: mxl: Add MxL LGM
 Network Processor SoC


On Tue, 26 Aug 2025 11:10:43 +0800, Jack Ping CHNG wrote:
> Introduce device-tree binding documentation for MaxLinear LGM Network
> Processor
> 
> Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
> ---
>  .../devicetree/bindings/net/mxl,lgm-eth.yaml  | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mxl,lgm-eth.example.dtb: eth (mxl,lgm-eth): interface@1:compatible:0: 'mxl,lgm-mac' was expected
	from schema $id: http://devicetree.org/schemas/net/mxl,lgm-eth.yaml#
Documentation/devicetree/bindings/net/mxl,lgm-eth.example.dtb: /example-0/eth/interface@1: failed to match any schema with compatible: ['mxl,eth-mac']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250826031044.563778-2-jchng@maxlinear.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


