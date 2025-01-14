Return-Path: <netdev+bounces-158301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E0BA115BB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F257161B5C
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB73F21420F;
	Tue, 14 Jan 2025 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxngMlvI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A07222565;
	Tue, 14 Jan 2025 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899077; cv=none; b=vBbO7FnJdy28S+iIwtkdmK6GdoBW0AJYR/MxYHRwq0zmTSkHlqKHofZ1470Fl/xkj/FJVSTHsaxb/I1nwG9sXo1pnvggoyBj6stoYR11gWExI25xH9NFddfJzSahUYLNZNfpF8QaKUobWhtCN9QY5QunRX3O4N0JqHz8QtPl2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899077; c=relaxed/simple;
	bh=qYcadH5zTVf6YXQcR12gkpEXX8NXXimDRL8MXEYl88I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lS+01i0ZdShYHEEoAvbxpWT45yF1l2xdF6D1D8AKzoh1sk/UvVFfkAsxfeff2oY6OarCMmnNs74xPMdmlNlS6FA6iiueD++K8ydvSAgd9qXiBymVHYM3TUgwjZ0LKrUPMSgFSY6F835K8NJQ/x87n7uD1m5TLQzfRJ0/cnu7nF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxngMlvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29BAC4CEDD;
	Tue, 14 Jan 2025 23:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736899077;
	bh=qYcadH5zTVf6YXQcR12gkpEXX8NXXimDRL8MXEYl88I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=jxngMlvI1aMH7uwkSNtEMSo14UCuU2hwadYpy8TGifVRhFKGYRXkjD8bHJaeDuGjp
	 AeuWNlEeSkWvTVqZZHSyoVuIEOfWATWVpJfr1CTZkPcPUqxjNsTEQhSov8/KnowEL5
	 CvQg9E8qJCtw9Il4ZjD2H2I9Cqly4JEQPTspsZBthQy65l6WPXtta9EFp6hG+9UKnI
	 m9DFyGiLnsMunIEMMhHIEgusMkuF1M6leSBraIeKhJCHqf92d865JChCjeNBvTyU4f
	 cdFhJabsFOTtH0IsfqAktwOWynpwEd9PBgziJ0YRbPkQaTNAXtDIM5zA+LO6T1/lM/
	 pTET4Szz1XfIQ==
Date: Tue, 14 Jan 2025 17:57:55 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew@codeconstruct.com.au, 
 davem@davemloft.net, edumazet@google.com, 
 openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 joel@jms.id.au, linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
 conor+dt@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
 minyard@acm.org, eajames@linux.ibm.com, 
 linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250114220147.757075-3-ninad@linux.ibm.com>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-3-ninad@linux.ibm.com>
Message-Id: <173689894057.1969633.10540050942005147267.robh@kernel.org>
Subject: Re: [PATCH v5 02/10] bindings: ipmi: Add binding for IPMB device
 intf


On Tue, 14 Jan 2025 16:01:36 -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface.
> This device is already in use in both driver and .dts files.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dts:24.32-33 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/ipmi/ipmb-dev.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250114220147.757075-3-ninad@linux.ibm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


