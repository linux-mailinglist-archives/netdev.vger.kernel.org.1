Return-Path: <netdev+bounces-161584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D09A2276E
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 02:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B4A7A296E
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723821D52B;
	Thu, 30 Jan 2025 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH+ODpsg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E00E8C1F
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738199850; cv=none; b=LM+sYxJyCTw0RybLaDDY+TXy5y/J4eNGI06Jf+4MIhVJ5eS1P0mr1vqBdvHnPLHGeUdeSt3p6n+sp/vWTm9ppzvNi+xlOBBMUtO+uCYLpSn6G22Wavfk4rTG8OJ/MzimeElfNBtfJJE4WrYPnS0RBKuGB8+pyPqePTNeP7FFJtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738199850; c=relaxed/simple;
	bh=sEDoEDIT6l8s6vcPxjZ2Ah7yyn+PM6QOedykYX3TKG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxQSiYPADc5sp7oKuO+JAz/DZoXoouRl7WZr1SkE1Fp5rbD1DoIlAVW7j+lV2vJyFHN1OzrXY0owjopLKQtvXViHMcNh8dRX+IogrlyNT66c/1KH5RfDko03/l7pHE2bZ3Mxc7b34pzTt47DAoiu0GJ1nkz4J/GlUnnG6YUv8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH+ODpsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86243C4CED1;
	Thu, 30 Jan 2025 01:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738199849;
	bh=sEDoEDIT6l8s6vcPxjZ2Ah7yyn+PM6QOedykYX3TKG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QH+ODpsgeThPCiGmOzhExoxAfaCTAmhQ0dbB3MDGVxxc4CUb6bVjj2ZYO7ge/cL2O
	 t2yn1ageidhHWKu/oFs4G0M/0h8R7S4Nn2c+i0g63uCNeUUu38MVxZjMTHXqBL5n+g
	 oolPTjKIfxjSEY2Wi2cXfKwXsdROycHFBz89mKF+fulBresve5MB3p9+iRh6Y2LLfK
	 bWX1vBdAL1E5Br4c27AeJZIiYH3u8pbqIP/zHJy1X8wgUkOSaf+Z9/hjAEKvsjbs38
	 lLWXy+RBSeyenyy4afPE+dvViUFWNDmzv5SvfjbVYhbTwHCoUYuJ/jjGLrkO8iLoGi
	 ++8OFA3BnZh2g==
Date: Wed, 29 Jan 2025 17:17:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
 <mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
 "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
 <amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Message-ID: <20250129171728.1ad90a87@kernel.org>
In-Reply-To: <DM6PR12MB4516FF124D760E1D3A826161D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-9-danieller@nvidia.com>
	<20250127121258.63f79e53@kernel.org>
	<DM6PR12MB45169E557CE078AB5C7CB116D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20250128140923.144412cf@kernel.org>
	<DM6PR12MB4516FF124D760E1D3A826161D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 07:06:09 +0000 Danielle Ratson wrote:
> > Is the consumer of the JSON output supposed to be parsing the units and
> > making sure to scale the values every time it reads (e.g. divide by 1000 if it
> > wants W but unit is mW)?
> > 
> > Or the unit is fully implied by the key, and can't change? IOW the unit is only
> > listed so that the human writing the consumer can figure out the unit and then
> > hardcode it?  
> 
> Yes, the unit is implied by the key is hardcoded. Same as for the
> regular output, it should give the costumer idea about the scale.
> There are also temperature fields that could be either F or C
> degrees. So overall , the units fields should align all the fields
> that implies some sort of scale. 

Some sort of a schema would be a better place to document the unit
of the fields, IMO.

