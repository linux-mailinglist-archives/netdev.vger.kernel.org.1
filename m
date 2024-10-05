Return-Path: <netdev+bounces-132422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0281F9919AB
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 20:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5941F21E95
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9FB15B968;
	Sat,  5 Oct 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxxP7rx5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA73A8F7;
	Sat,  5 Oct 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728154003; cv=none; b=Yz9m114taDPZPQMgMywQnrOjGq8aekc4xNz+5Ds6XpqlJD2foobx6UycC1Xyx6Xjg1kNybSz4ZIQomQnN15O1s5OXwDpmtQHMj46eteKVtgmFkUDiMgVLQGPfzYGbIrt7pmNN2jLOyzgBaLAba0FwA8rBXXMK6js1Dxg21l+EfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728154003; c=relaxed/simple;
	bh=R9wo9kFyQ5zJNfmc2tZz2c0qYerrpZST+cmbca7hfFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIO+0v9t+IkCjbWs37f3907Wk0gey3T6v128V+O6D9Du3B76Finj9rDSpjTWRMfOaSRtS5EKFe9OexNwcDOO8+Ms21HTWCjNyFd52EdCpfn43mMS/yty/y4ALH68seERjOZtie9lFf7w3aJ6o9daL/b0x/HFnN+hvRx2lcsCdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxxP7rx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D88EC4CEC2;
	Sat,  5 Oct 2024 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728154003;
	bh=R9wo9kFyQ5zJNfmc2tZz2c0qYerrpZST+cmbca7hfFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxxP7rx5/bZYPBonXEHk3Ci+qI7bBe+rfhMGlMOhdoom0vwPdjEisgnKZtCfPYIpD
	 SUBzsb8Ql9JOG/ezlHvW1RQ0GDycNvuRSUJ1FKnks4oQyvmCn+bPaQuZx4LP5VYvpm
	 /zIidJP0u0OcumhaqQCwSfwuy8Op32b9Ta8rE0aJr/0gE0dFlBL/7dbUNTPqKBp8vV
	 Ps9alwAObABgU+bNNY6DLw7LpM72SDvyhdLu4sHrQ6jneVGlrJov9ysvs3KpTaNv2i
	 cVfLaJuiv1w8Pbd0ZHT+aFoivI3j5gDy+KZtaIAdjFEHj1526HbbAYNRcaZGw3/F8S
	 K9d2pQFve+3Mw==
Date: Sat, 5 Oct 2024 13:46:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	=?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Robert Marko <robimarko@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: marvell,aquantia: add
 property to override MDI_CFG
Message-ID: <172815400176.520293.4576888144117206931.robh@kernel.org>
References: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>


On Fri, 04 Oct 2024 17:18:05 +0100, Daniel Golle wrote:
> Usually the MDI pair order reversal configuration is defined by
> bootstrap pin MDI_CFG. Some designs, however, require overriding the MDI
> pair order and force either normal or reverse order.
> 
> Add property 'marvell,mdi-cfg-order' to allow forcing either normal or
> reverse order of the MDI pairs.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: use integer enum instead of two properties as suggested
> v2: enforce mutually exclusive relationship of the two new properties in
>     dt-schema.
> 
>  Documentation/devicetree/bindings/net/marvell,aquantia.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


