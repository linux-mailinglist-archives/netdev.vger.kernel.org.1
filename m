Return-Path: <netdev+bounces-75042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB8867E15
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 18:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2314C1C2CC14
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F66112D742;
	Mon, 26 Feb 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ub0uMEH3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3912CD9B
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967845; cv=none; b=ap8skEQdpy/4YA+Cv3Dzf/RtHRygGywijKHAPGV3RPTkX+qFrpLifIH8aZdLGoqrbu6kEmsU8qFrvOZcM5gN5+8WxWKcUMu40GRbsQThd7PJMcv6nKqOQRdREUFRQnDmWtDAz25irIeGAwqqWiGzjvRZW7sp8IcvyUQPlVFrIyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967845; c=relaxed/simple;
	bh=yK4PFiT51e+QTMA7C35BsgMHvWahXH9rZTcd4Say+sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cznjmby68khS2/ld+b02gZZvO3LjTyuTRkfrNTvzZjxV2dgUf0jg9q/kHN4DdJ/wl7PTmvyss+tRoxR1WOtH6ggBkOmz/igTq+aXs0Lc7ZMq4SpHzrUkuVo3hh9WgZMIC/94yMVrSm3Jg/Lf6Hn7fAnCf+MR7RvEOnm1v7e3UMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ub0uMEH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DABEC433F1;
	Mon, 26 Feb 2024 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708967844;
	bh=yK4PFiT51e+QTMA7C35BsgMHvWahXH9rZTcd4Say+sQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ub0uMEH3EoN703MpmnyB/a3w1mmfMRN/GTPQnz7gLzGo/woJyWzgMz4cCCzLOPuIJ
	 K5uY2ryj2md4tMpXa4+2g63PPfneT1QP5x5Ip9Ve9LThLzBCdpmGAQtxEiGwe+4NHU
	 BSHCSToi7Ol9CyjJn/lOxp8Y4pHEl2X8rsh0Do2lx7w/GdfUmmcR8MTzTKeOCRH/mX
	 HpMiHiY8txtZgz7lV44CutoQmbxMsCkJspCJCZ/4q+4jAxmBtiNNKQORBGAM25re6I
	 Zt/4XqKaE0fhqr9ncfKo6OSnZRHATgg+686QtUU3LVzrGoZF5DWJU601N19qq2TcOj
	 A4ll8VsPX0F7A==
Message-ID: <6af82695-66a8-4a95-a2bb-e6b1c8942a8d@kernel.org>
Date: Mon, 26 Feb 2024 19:17:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 06/10] net: ti: icssg-prueth: Adjust IPG
 configuration for SR1.0
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-7-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240221152421.112324-7-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 21/02/2024 17:24, Diogo Ivo wrote:
> Correctly adjust the IPG based on the Silicon Revision.
> 
> Based on the work of Roger Quadros, Vignesh Raghavendra
> and Grygorii Strashko in TI's 5.10 SDK [1].
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

