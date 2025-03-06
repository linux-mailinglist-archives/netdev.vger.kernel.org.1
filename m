Return-Path: <netdev+bounces-172312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D1DA542BA
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 07:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B267A727F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 06:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213C1A01B9;
	Thu,  6 Mar 2025 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhSnoZrN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69A81362;
	Thu,  6 Mar 2025 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242208; cv=none; b=MfISAOB67R8hij5zLB8lFZi6IPHs5+GZ7Z+OgthnzL7wI0EYt5cWN47VYtJRTX1Dz0Vhlm6HFncy0q+ojSV2zLzP5ve6GAizHHZKwF0F8TM144t/+86j2AxmnnNdduIylSvVB1ncwGERXX/GhOKHcqtibEd9BS4tBkgIQMATOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242208; c=relaxed/simple;
	bh=42Tqw/AvyybOy6obt+bWEXQQeWJhwDRee8ky/rb6WVQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GuMr1TrGowg26H8fRd+y9tIE/VybQzzLTz0MWyQI91ItAhx+c+d87XDfY7MFCTG/QuZQeeyQUizqpjy1dCX8EjDyEo2ja+4y3g9yR4yY4WnFw9sgEKC5j3AmMHavURdT07H1ar0032uyZVKFF0Wkvw95brv8s1+vcPOfaQ5LcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhSnoZrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379BEC4CEE4;
	Thu,  6 Mar 2025 06:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741242207;
	bh=42Tqw/AvyybOy6obt+bWEXQQeWJhwDRee8ky/rb6WVQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=dhSnoZrNcxWVkchSF2xa6uKkHxtspLssP8U/c6HcCnz0rPzeO29/XX1Kn9oeGmyMX
	 BpXRzmxBSCdwqcvDmxZTHeSY6n3POgC0tmWcbBaCiK4cBOxR7DQv9uSn6dS/IGpaKR
	 8monrNk4pIAF1d69OmuIuemOLP2PSrsQcq5Hxk/4GWevNVbrDjw4eYq2zggKurtmUJ
	 JNQxwwCDC9PupcBVr45ffLJjFZIiBlZO54FLFgKAeMCxyq1Jo5xlOr+NEYSZs1W6MM
	 hf3+jhbBIbjFKcgCXEMdPaHuGZt8gjfTsRg+89DWdpPChTPWpTmzCAAGOSFCsL0o5A
	 qzCgJxaYLI6vA==
Date: Thu, 06 Mar 2025 00:23:25 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, 
 devicetree@vger.kernel.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Philipp Zabel <p.zabel@pengutronix.de>, noltari@gmail.com, 
 jonas.gorski@gmail.com, Eric Dumazet <edumazet@google.com>, 
 netdev@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
To: Kyle Hendry <kylehendrydev@gmail.com>
In-Reply-To: <20250306053105.41677-4-kylehendrydev@gmail.com>
References: <20250306053105.41677-1-kylehendrydev@gmail.com>
 <20250306053105.41677-4-kylehendrydev@gmail.com>
Message-Id: <174124220560.3504158.13507296530192889296.robh@kernel.org>
Subject: Re: [PATCH net-next v4 3/3] dt-bindings: net: phy: add BCM63268
 GPHY


On Wed, 05 Mar 2025 21:31:00 -0800, Kyle Hendry wrote:
> Add YAML bindings for BCM63268 internal GPHY
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>  .../bindings/net/brcm,bcm63268-gphy.yaml      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml: maintainers:0: 'TBD' does not match '@'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250306053105.41677-4-kylehendrydev@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


