Return-Path: <netdev+bounces-162579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD8A27458
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D638918840F6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADBE2135D7;
	Tue,  4 Feb 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQEoA0zj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19412135CD;
	Tue,  4 Feb 2025 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679291; cv=none; b=LeJ5ph7vbQSvuZOgUJK2wInXQsfX/mpUVacp16ydVfjEgd4hV6BPBfCOJGe43Yd++WTK5LXjBzxTqd5d2ImeyHSKoygnumL/HsvKrAg3KG00TnfEF/kIer39C6yRaOk57mUvYJSpTuTs/SVkQYTeYI0EsyGwVJ8bIm2Jx96ZF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679291; c=relaxed/simple;
	bh=yk5WtGeAX0utttGwRTmJMREP9MkKnH5xe5K91AxJU7w=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=fflcaJ6ULTGiDM9XUeEYxKrfDFFkOijz9yurS1PqFLN3ju/9+w6/wdWt/1f7LI/raeHO/M8qpQ8OBGZPyODyWpie4kHt4KNAsF7jcesDekGv3GhaP8mSVOhZlPXRW8GernXKM+T9SrNu34T/6UYIW/m/O/C1rSafy36z8jq8at4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQEoA0zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DC5C4CEDF;
	Tue,  4 Feb 2025 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738679291;
	bh=yk5WtGeAX0utttGwRTmJMREP9MkKnH5xe5K91AxJU7w=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=vQEoA0zj11UGUt2d0hdvvz2e+PxZqlYrpiqJ/zANLF8sZ2eHVKUdGScjmm4i4g+Jj
	 GGsaXWrIxj5oeBPHOKS2yrGLj8NEdwEw8Bo1CUM/PSWne902IXvqzueCRagxXssLcn
	 IZjzrjiN0Ee86BCAVz2UYAd8TkNzIgMvIijAEYWbPBi3EbvV7+bOJV9o64WyihG6X1
	 IFkPIIxMRPG5feqaTgN/JBWF1lv+SdNmdr1nxbll4nwJyE6DGs7j4WvhmqXz1CAabp
	 B1Vj2wEvOmrFiHyy9MhtsL/gjCYPynIXBT9wS2djnxONWv17kz/Rg42pYuzKPr/vf7
	 bEBGTg755xxNw==
Date: Tue, 04 Feb 2025 08:28:09 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Davis <afd@ti.com>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
In-Reply-To: <20250204-dp83822-tx-swing-v3-1-9798e96500d9@liebherr.com>
References: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
 <20250204-dp83822-tx-swing-v3-1-9798e96500d9@liebherr.com>
Message-Id: <173867928985.2681882.12579959912610885418.robh@kernel.org>
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent


On Tue, 04 Feb 2025 14:09:15 +0100, Dimitri Fedrau wrote:
> Add property tx-amplitude-100base-tx-percent in the device tree bindings
> for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
> necessary to compensate losses on the PCB and connector, so the voltages
> measured on the RJ45 pins are conforming.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/ethernet-phy.yaml: properties:tx-amplitude-100base-tx-percent: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250204-dp83822-tx-swing-v3-1-9798e96500d9@liebherr.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


