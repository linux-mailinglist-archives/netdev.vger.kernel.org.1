Return-Path: <netdev+bounces-119478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8377955D2F
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A78D2818D5
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C06D71B3A;
	Sun, 18 Aug 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF3J7OXY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD34E23AD;
	Sun, 18 Aug 2024 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723995189; cv=none; b=pFGjfDTkpTMJ/pRwKeBHSlyChvqL5NCWgJCTUHeBPlVGlYysv8bkxcI2ob+r2crEhWEH1aqxbhfw60+aCcJFWMZh8pKzebKrJCJONExTs6B6LLY10dAiJk1WmacSmB8SzVbaHb6YOA93HqQrhZ0uR3XsDWr5fGFY1cuK7W4IjoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723995189; c=relaxed/simple;
	bh=TOAEYS6Urfn9oRugVSVFnfJ659g4VYI2XF9dzx/BbH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHPTtrYZD5QHZFi42Zfn9SOCjXuyGZCoqjUOXd5+i6xYRl12uUI9l1qO1R1HhyxMVkWZSyXWb2a/5LZREGVauLEtvds5/W48/eLKSa66FYODgjgjr61m4LTVzoki8T0g6ZUkeqrcCZRj7JB6v9LOX7cm0Hi169nSff3JZ/85Jg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF3J7OXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D3CC32786;
	Sun, 18 Aug 2024 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723995188;
	bh=TOAEYS6Urfn9oRugVSVFnfJ659g4VYI2XF9dzx/BbH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YF3J7OXYea15wr/GdAFC7TwcTVstP47SI9ZhiuD5OTKGpnCqWgJLVZEtoHK2Ttepb
	 EcsJqDY5qL3kLwttZMtlAV0s8imAuOqy4PwAXV4CanHAvKb8tEqCdi01ui3vQ4wsKe
	 SuueTSfj96DVm4Epi1nvs0X9uTwxeNX2dSYf5w1ah4xsVz5uKa7s6vEojtdfF3GpkH
	 zATJM5WzgUTPu3QMs6H4m/JInYY3F7+JRpiGE6OPTMX1nE8rO72uE+ZcAV+/U7ImXH
	 JdYGZwcowtAc8RLKw3SYAi/L4FQ9F+30sCUgw75pLpu75bpnnzFqy9NQ4rG2T832bq
	 8O1qd5AZ+mKxw==
Date: Sun, 18 Aug 2024 09:33:06 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-binding: ptp: fsl,ptp: add pci1957,ee02
 compatible string for fsl,enetc-ptp
Message-ID: <172399517578.119603.6812036696536583229.robh@kernel.org>
References: <20240814204619.4045222-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814204619.4045222-1-Frank.Li@nxp.com>


On Wed, 14 Aug 2024 16:46:18 -0400, Frank Li wrote:
> fsl,enetc-ptp is embedded pcie device. Add compatible string pci1957,ee02.
> 
> Fix warning:
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: ethernet@0,4:
> 	compatible:0: 'pci1957,ee02' is not one of ['fsl,etsec-ptp', 'fsl,fman-ptp-timer', 'fsl,dpaa2-ptp', 'fsl,enetc-ptp']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/ptp/fsl,ptp.yaml      | 22 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


