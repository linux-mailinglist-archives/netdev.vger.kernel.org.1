Return-Path: <netdev+bounces-161359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B8A20D3A
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 019147A136C
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512C1C831A;
	Tue, 28 Jan 2025 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7JIhBo+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6086F9F8;
	Tue, 28 Jan 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078807; cv=none; b=rwrDt7ADXlbflngwD2ds/bm3ER9+GSOnuB48kBM4cg60OMmW92Z1rEtTmSIhU/BCtFsIKMENYOD73lpBLm2EDr68Hx6+caTAStNK+pPhwvEjSfWc9rX10rni+SBX3TzTd3FefldeVwno+6z4QBpx60ruhkExYOML3mkzWWpJy6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078807; c=relaxed/simple;
	bh=1Yhm9+Sys8O2xe0fP21kTV+Z0Km1KjgTwV+bcMX8KNs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=OZt6cejyJifD7bUlHx3i/miQeKvcg25N3856WE9Sf6VJrMO5QClhKpuo6rWUefc/TxFICfLLhf2aWRbc26DbXlM7TJnNZT0/4pjpamUUiXSNsqSgdFitNIKbbHasUYyXsA5GOGRsfCujIj5oA3UzSL6e0+ELWg5Mampnu7PgzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7JIhBo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7EBC4CED3;
	Tue, 28 Jan 2025 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738078806;
	bh=1Yhm9+Sys8O2xe0fP21kTV+Z0Km1KjgTwV+bcMX8KNs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=a7JIhBo+kbWOFf0tpozOgd09Ki5iNofAEkfScgYtJ2SIN4xTLLJhFkpKd6pZk3umJ
	 Tq4pDr/cQyCTESKxz4NnSRQnq8VCqp4zzbTZqjiGzs9WXhIO5fdeqfSQoqp+iVlS3k
	 KAct9GhJDaQwyq5eIpPxcP5qkYryaSs9Ql4kVZpgKIKyWLbV1TsZJTma0Th+eFacjZ
	 qbYjX4K5WFfr9HcSRMP4YIswlUuEtttWwr+xMjT3BTZCqjglzuMV4h0kNqw5jDNgWV
	 sv5bFu78lU/XB2/ywANJEk3slNl+HFhHgZAj2QPN591nk3THoJIzCQv9gHtlbfzJar
	 o631Gii1/jw8Q==
Date: Tue, 28 Jan 2025 09:40:05 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kuba@kernel.org, conor+dt@kernel.org, alexandre.torgue@foss.st.com, 
 linux-samsung-soc@vger.kernel.org, mcoquelin.stm32@gmail.com, 
 linux-arm-kernel@lists.infradead.org, pankaj.dubey@samsung.com, 
 edumazet@google.com, peppe.cavallaro@st.com, devicetree@vger.kernel.org, 
 jayati.sahu@samsung.com, rcsekar@samsung.com, andrew@lunn.ch, 
 pabeni@redhat.com, gost.dev@samsung.com, joabreu@synopsys.com, 
 richardcochran@gmail.com, ravi.patel@samsung.com, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ssiddha@tesla.com, 
 alim.akhtar@samsung.com, linux-stm32@st-md-mailman.stormreply.com, 
 davem@davemloft.net, linux-fsd@tesla.com, krzk@kernel.org
To: Swathi K S <swathi.ks@samsung.com>
In-Reply-To: <20250128102558.22459-2-swathi.ks@samsung.com>
References: <20250128102558.22459-1-swathi.ks@samsung.com>
 <CGME20250128102725epcas5p44b02ac2980a3aeb0016ce9fdef011ecf@epcas5p4.samsung.com>
 <20250128102558.22459-2-swathi.ks@samsung.com>
Message-Id: <173807880529.3533023.16090537630413289579.robh@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings


On Tue, 28 Jan 2025 15:55:55 +0530, Swathi K S wrote:
> Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
> Ethernet YAML schema to enable the DT validation.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  5 +-
>  .../bindings/net/tesla,fsd-ethqos.yaml        | 91 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml:41:6: [warning] wrong indentation: expected 6 but found 5 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250128102558.22459-2-swathi.ks@samsung.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


