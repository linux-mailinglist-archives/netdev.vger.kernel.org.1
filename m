Return-Path: <netdev+bounces-216016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10539B318C5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF3C1C81CFC
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D25D2FD1D2;
	Fri, 22 Aug 2025 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1z4knZh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326872E6114;
	Fri, 22 Aug 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867540; cv=none; b=mST5m3FZeS/kADycUsEPqBXNKp9s/lSrISE8MieOZyv0G71GJsvXPZLWvHKjyjoEIyDFBrEDHVbgWu8/dyvMR8GrZNEBqQPnWZ0QJ5l0ndBZVj+ELLwcnNP5NNi1W2pjjo8z3QqllVnjNwTl3LiQ7pEVDkljzJDOM7BuzxqChI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867540; c=relaxed/simple;
	bh=gRkkjX/EdfDu31YPDvy5ttFGv7KmWKXEGbB8WqkZ5sw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=i9d+uuLB0B0QWbbRIa+waBciy3cFpJ4HQQpWOsZVLYZ7wDLyeg9Namp+dg+J7fs6XW7HEYMZsQ1lJo/nQKbU4CUjNfathjtNddDnFCsfMr4Q091soEHKn6wTROQMxbvZ6CKtYbZXif9h25L52QwSghbZcYcO4SQf1K9Ie1YCY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1z4knZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F00FC113CF;
	Fri, 22 Aug 2025 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755867539;
	bh=gRkkjX/EdfDu31YPDvy5ttFGv7KmWKXEGbB8WqkZ5sw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=m1z4knZhUJiPcUj33fKZiFYItL9YVRy7wJOmMm0xOBEAooFVLCtyH08b//fM140EM
	 W7UhYnEzcsf1fSOdhnqIGRX0ICNlLDjqseF4lJrm6RcJBn/6upDVlI2lN6YOzUzdmH
	 0HWOojpM88YPoM8hYwXJZ/hmUpjcAFp4yZp7EfU/qPuhISEpqJk3SvnVvF90MS/Fdo
	 16bR+obgg7JebRKy/9b0e6yQzE4aDqo1Un+3QB2WKhcl/5wY/Zca8vmyLXjoW0r4eE
	 DFhifQ2bjeAgYF2Q78TgCfkgYp6RWRx8J9hKzMn2hqujETTBqtrTTIBXAzuGlH801H
	 vhQmbaUXRU5Qg==
Date: Fri, 22 Aug 2025 07:58:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com, 
 devicetree@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, 
 davem@davemloft.net, conor+dt@kernel.org, sureshnagaraj@maxlinear.com, 
 edumazet@google.com, yzhu@maxlinear.com
To: Jack Ping CHNG <jchng@maxlinear.com>
In-Reply-To: <20250822090809.1464232-3-jchng@maxlinear.com>
References: <20250822090809.1464232-1-jchng@maxlinear.com>
 <20250822090809.1464232-3-jchng@maxlinear.com>
Message-Id: <175586751398.3283621.10950421213702804757.robh@kernel.org>
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: mxl: Add MxL LGM
 Network Processor SoC


On Fri, 22 Aug 2025 17:08:09 +0800, Jack Ping CHNG wrote:
> Introduce device-tree binding documentation for
> MaxLinear LGM Network Processor
> 
> Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
> ---
>  .../devicetree/bindings/net/mxl,lgm-eth.yaml  | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml:5:10: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml: patternProperties: '^interface$' should not be valid under {'pattern': '^\\^[a-zA-Z0-9,\\-._#@]+\\$$'}
	hint: Fixed strings belong in 'properties', not 'patternProperties'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250822090809.1464232-3-jchng@maxlinear.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


