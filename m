Return-Path: <netdev+bounces-156061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFAFA04CB1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D251887210
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7196F1E3DFF;
	Tue,  7 Jan 2025 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJf7DYF3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456401E3779;
	Tue,  7 Jan 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290474; cv=none; b=IACFUrF5wxHLC/94erThA5nt8adHg38RI3BnRDY6QhKFvRl3MNjVCi/0fnsueZdpLEOyvaRJZL0tYl/+2/m8q72tp7LrDHthYnZiaN9aIHqyVZ3i11+AZjli2+49nKqS1hrwlzWVm1HiWZRt3zkDhi2W8pNeztssuSlKLSt3Wo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290474; c=relaxed/simple;
	bh=dYbF7CHxuuCz2p1jW22Ix5UW0UmrzVjjqtNsyO8jekA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rsBMAv3/ZNZxdNFJ1kox9sta87J1hPtlnfRn58ZKn0iLBLBmzxdkarRz1bJGm6nAhaoHTOk/GD7I4tBagNa/GxDiHj2FjjSxmwwn9c++oUyWiPfyvE2EaJQu69daNRy2oNLyN/+qHhxmz4gnP15ScByLnYldgWscc+ALmcU+WG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJf7DYF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A7DC4CEE8;
	Tue,  7 Jan 2025 22:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736290473;
	bh=dYbF7CHxuuCz2p1jW22Ix5UW0UmrzVjjqtNsyO8jekA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LJf7DYF3n6cj3pBXooqWfWIUfMxkpq+W8jkF9sAjxC7pNSYms7tQbAQ9ZcS6HULtp
	 0zn6w2Tc9E71TTX19KpDZYeTBMbyqAiqX2S2Hu2uRHXmrV9YkPRDjDDNT/YZ1iRyd4
	 RLWfGOKVsiMoPJvQRWNbHSvi/WyUkvIUR0W9UWq+Ssg6rulAXGwW9oOaNlIbp5xbVs
	 GIdvbuuIr+Us+G0Q9045WfDhoZpZSlHpNytlG/in7WZGCnMGerIXzvaP7nnHXaiF48
	 NZgt0JQEE54lkJtYijy4F9cjWTwzJLBpQqXxWrX4oRw5Vn2gv8MXAoVIprSD0SS09a
	 rRKbWZgYVdhpQ==
Date: Tue, 07 Jan 2025 16:54:32 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, krzk+dt@kernel.org, netdev@vger.kernel.org, 
 davem@davemloft.net, andrew@codeconstruct.com.au, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 ratbert@faraday-tech.com, minyard@acm.org, andrew+netdev@lunn.ch, 
 edumazet@google.com, joel@jms.id.au, kuba@kernel.org, 
 openipmi-developer@lists.sourceforge.net, pabeni@redhat.com, 
 eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
 conor+dt@kernel.org
To: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250107162350.1281165-1-ninad@linux.ibm.com>
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
Message-Id: <173629037049.1994533.7630339914217766401.robh@kernel.org>
Subject: Re: [PATCH v2 00/10] DTS updates for system1 BMC


On Tue, 07 Jan 2025 10:23:37 -0600, Ninad Palsule wrote:
> Hello,
> 
> Please review the patch set.
> 
> V2:
> ---
>   Fixed CHECK_DTBS errors by
>     - Using generic node names
>     - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
>     - Adding binding documentation for IPMB device interface
> 
> NINAD PALSULE (7):
>   ARM: dts: aspeed: system1: Add IPMB device
>   ARM: dts: aspeed: system1: Add GPIO line name
>   ARM: dts: aspeed: system1: Add RGMII support
>   ARM: dts: aspeed: system1: Reduce sgpio speed
>   ARM: dts: aspeed: system1: Update LED gpio name
>   ARM: dts: aspeed: system1: Remove VRs max8952
>   ARM: dts: aspeed: system1: Mark GPIO line high/low
> 
> Ninad Palsule (3):
>   dt-bindings: net: faraday,ftgmac100: Add phys mode
>   bindings: ipmi: Add binding for IPMB device intf
>   ARM: dts: aspeed: system1: Disable gpio pull down
> 
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  42 +++++
>  .../bindings/net/faraday,ftgmac100.yaml       |   3 +
>  .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 177 ++++++++++++------
>  3 files changed, 163 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 
> --
> 2.43.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20250107162350.1281165-1-ninad@linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#






