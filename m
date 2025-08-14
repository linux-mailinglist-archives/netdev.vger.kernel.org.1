Return-Path: <netdev+bounces-213633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E95AB25F0F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA1EB606EA
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3B28980F;
	Thu, 14 Aug 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZu4Se1s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B691FDE01;
	Thu, 14 Aug 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160619; cv=none; b=IEFgyNE1I6iefUpUrtijR2GV5Ym8HhUSafOM/vSdvFzmvhJfiFocvE7EnNHfVwS8sT7oHWbZUiYjth/unIZcf4gCgK4TE9rZDFvBC2vkM3YPpjsoMJfJ3T6iBoEaU2jPx+DXsALtSE+2EEfns5v1SGP/5Z9R8e3ehtCFWttWNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160619; c=relaxed/simple;
	bh=tU5iipaDEUy6NFDdG2V1HfYPchwAoL9oGgj2hDb7VKU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lGy8lUNYDmRHX+X9dZs7lMjVvu16SoDONUMs57vech8R87Qv2gK9e/SejATK1dVI51C0j+Wuqp5+IO6OWaXtuqiCBhfZKJ9Nk036fa3BNrieoUVguYGJKJhs8u2reRZ58hfvP9in9L6QzvXPEgseHXntT37agMEv5C5QJXCWcEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZu4Se1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBFFC4CEEF;
	Thu, 14 Aug 2025 08:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755160618;
	bh=tU5iipaDEUy6NFDdG2V1HfYPchwAoL9oGgj2hDb7VKU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pZu4Se1sZSkaFhuobBWv5m5jYhXyjrZqrSLVIZlP/GORW8EWSCa99FpaW2FWGtfkt
	 xu1InKq/CuaJWBLvZ7pJQGoNuBe2sPScF66BCDX+pNwdmvvNKhSjF/toNx3/QnXF0I
	 xdhYkFS5wTLQBJQGeEhsZuH4hWzKKcxgtu5j8eAvecGIlDcnQTO5OUODPVKkJNkChr
	 Jx46Q0YsHVAICsW4cQpYhsfSkFwL1tGfclIe7JEJo+885OM/yAATBU2wvNVJCGKhel
	 x9wkBhXYljY9TUKieG2RGzAa3Whl+anh+Is6jA2of4EAO0NmeR/BsjASqGZxEo32Me
	 Txwbl8N0bO5aA==
Date: Thu, 14 Aug 2025 03:36:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
To: David Yang <mmyangfl@gmail.com>
In-Reply-To: <20250814065032.3766988-2-mmyangfl@gmail.com>
References: <20250814065032.3766988-1-mmyangfl@gmail.com>
 <20250814065032.3766988-2-mmyangfl@gmail.com>
Message-Id: <175516061769.1975599.3085098117739247200.robh@kernel.org>
Subject: Re: [RFC net-next 1/3] dt-bindings: net: dsa: yt921x: Add
 Motorcomm YT921x switch support


On Thu, 14 Aug 2025 14:50:20 +0800, David Yang wrote:
> The Motorcomm YT921x series is a family of Ethernet switches with up to
> 8 internal GbE PHYs and up to 2 GMACs.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../bindings/net/dsa/motorcomm,yt921x.yaml    | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml: motorcomm,switch-id: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250814065032.3766988-2-mmyangfl@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


