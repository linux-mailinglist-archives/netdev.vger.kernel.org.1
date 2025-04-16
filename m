Return-Path: <netdev+bounces-183434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32314A90A53
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9195A3A75F8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A99D218AC0;
	Wed, 16 Apr 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPQ4W11s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0E202C42;
	Wed, 16 Apr 2025 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825323; cv=none; b=IHGIwZm8D38s1s4gaFdB0Sa+pgOwHuqzBLQSjTrbBn5SyeR1N5YRYUSGO74Ae09fO3/L+3kWJTL4xTfEatAI0vpCfk4YYp5reSRgxp5bszcwzTd2OZE4jmQKWDENRbYlH8//SbgNsC8i9N4GuEuPcKfhaTos+tZgxn+MdniLa8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825323; c=relaxed/simple;
	bh=fzzjNsTOIQf2qJggT3eDFAxMy7Vwudm1uX77sPkiASo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VwlqA4RjNyUWJCObGVwrkeNt2y+ktKpxeDR1uNiUmJfBH4IuOiKl5aU3F7Ju2kpDCWFSXsPJX/Iqs51m4WdHlneGTIc7/WhX8iDm7hJ5OKODJ2iaqmXjrNuAxKmleVaXHTIkhstGZukWI5OwS9Gc65ZhKRbgzNtndbA827LcOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPQ4W11s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8008BC4CEE2;
	Wed, 16 Apr 2025 17:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744825322;
	bh=fzzjNsTOIQf2qJggT3eDFAxMy7Vwudm1uX77sPkiASo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=WPQ4W11sZS7Jytt53u2ONx7nl2wIRp0aH2Zb1OKbhyv8Rt3hDjMSAwFznOcm3Ot1Q
	 VP+AqIOIPUuGBzA4z8oBagF3RX0Tgtze3hCEmvgBG7COkU/pq7l1K/QuOGqFBaGzHj
	 cDftwuODppthjlk0wQgUfOM/HvOOXxTszo8i0KA71CX0Mo0NFQfLfSf4tQKXTmHs79
	 IFMvYU9bsa+Vse+nx6j54L33WIPyzpfWSFRujxwvtrAKBEcQKGj4keg6x86xY1oD/4
	 bmI2JPF8r0UUSYp00OGoPjmyCfPVWo2vfDH01pE9vJfYhvHPTK+G+thF2E1fRiFtxk
	 vBcUiNlTY+zOA==
Date: Wed, 16 Apr 2025 12:42:01 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org, 
 Prathosh Satish <Prathosh.Satish@microchip.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kees Cook <kees@kernel.org>, 
 Michal Schmidt <mschmidt@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>, Andy Shevchenko <andy@kernel.org>, 
 devicetree@vger.kernel.org
To: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250416162144.670760-3-ivecera@redhat.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-3-ivecera@redhat.com>
Message-Id: <174482532098.3485034.14305412993449574460.robh@kernel.org>
Subject: Re: [PATCH v3 net-next 2/8] dt-bindings: dpll: Add support for
 Microchip Azurite chip family


On Wed, 16 Apr 2025 18:21:38 +0200, Ivan Vecera wrote:
> Add DT bindings for Microchip Azurite DPLL chip family. These chips
> provides up to 5 independent DPLL channels, 10 differential or
> single-ended inputs and 10 differential or 20 single-ended outputs.
> It can be connected via I2C or SPI busses.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> v1->v3:
> * single file for both i2c & spi
> * 5 compatibles for all supported chips from the family
> ---
>  .../bindings/dpll/microchip,zl30731.yaml      | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/dpll/microchip,zl3073x.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250416162144.670760-3-ivecera@redhat.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


