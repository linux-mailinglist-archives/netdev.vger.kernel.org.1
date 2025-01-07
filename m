Return-Path: <netdev+bounces-155993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60066A04921
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 19:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF327A2A20
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CDA1E3DC5;
	Tue,  7 Jan 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8Uox00V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D291D95B3;
	Tue,  7 Jan 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274157; cv=none; b=icQVESDCBq4ZIeOTGJXSEkapaDsGHvVePmPjDnwfrPbINWcaM7LrUQ+QErZhEhTM2n4frcSxeNtQTRGU1peHxbzCIDpsDX2sUMKeDSDB+xcHhEQqzURmP4VbWvgFsw+4yTPihSxlYuO4gBaFm3+uHlS5Hyp926/9kBoj6PdSG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274157; c=relaxed/simple;
	bh=nQt0n0t3yZF3lcbbDEr06Sl/D9a0HeRqKxRgtUlA08I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=WB01iFHLxypUcmj3a8JIwcJTrIDRNM0nHmXrM7Pap3ZCXY55V8PJEyR1OoDUun0ZcvK+gAHB+ZizGNU1O4GbO1Kx7Y8+O+LdK9ibP/p3x+kbwvEZYm6b7+c97yYNMJgLJfYTruHxaqLEX2E0pN32x9JGb9AoFdQmSbvaeJ7Koj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8Uox00V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A9DC4CED6;
	Tue,  7 Jan 2025 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736274156;
	bh=nQt0n0t3yZF3lcbbDEr06Sl/D9a0HeRqKxRgtUlA08I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Y8Uox00V0JqdR041OQIfsDcEnXxckrrsxU+9GwVzlDW75rqIbyuwc/gSpA/1JFEws
	 3ILKwoSAbMHiK6q+Iy3iIFE2ZQjba3dsgC4QqqMM75IE6xzfd4M60L6bnC9h1XIFg1
	 813GljNv7DbP7qomTalL0jq0xCVsBLhgbGSYgF/KDvjt0AHRm8tCZ6XbXBp4b9pbvd
	 0S3rmZzcpycYu2LROF9Acl6tOjSoiztCEzw3vhQ5m4VNcIiys9FUBjEUb9q5YIH1Zt
	 33dBBdWB559MFABnYDCYlXp9p6tO0t2X3CPRa02N8NhghE31+7ZQlMaOfWcirRZxuC
	 tIbd6/eNeyYsw==
Date: Tue, 07 Jan 2025 12:22:35 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: eajames@linux.ibm.com, linux-aspeed@lists.ozlabs.org, 
 netdev@vger.kernel.org, kuba@kernel.org, minyard@acm.org, joel@jms.id.au, 
 andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 davem@davemloft.net, krzk+dt@kernel.org, conor+dt@kernel.org, 
 ratbert@faraday-tech.com, pabeni@redhat.com, 
 openipmi-developer@lists.sourceforge.net, edumazet@google.com, 
 andrew+netdev@lunn.ch
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250107162350.1281165-3-ninad@linux.ibm.com>
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
 <20250107162350.1281165-3-ninad@linux.ibm.com>
Message-Id: <173627415580.1273439.8070481995690256439.robh@kernel.org>
Subject: Re: [PATCH v2 02/10] bindings: ipmi: Add binding for IPMB device
 intf


On Tue, 07 Jan 2025 10:23:39 -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface driver.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:21.17-30: Warning (reg_format): /example-0/i2c/i2c@10:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:18.13-24.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for I2C bus
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:18.13-24.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for I2C bus
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:19.20-23.15: Warning (avoid_default_addr_size): /example-0/i2c/i2c@10: Relying on default #address-cells value
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:19.20-23.15: Warning (avoid_default_addr_size): /example-0/i2c/i2c@10: Relying on default #size-cells value
Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250107162350.1281165-3-ninad@linux.ibm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


