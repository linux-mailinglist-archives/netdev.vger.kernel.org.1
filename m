Return-Path: <netdev+bounces-106780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85AB9179D4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151031C20753
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6ED15A856;
	Wed, 26 Jun 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aApLDCYU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A31FBB;
	Wed, 26 Jun 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387450; cv=none; b=S8vBt177Tej20yzjgi96qwnvYuOAuL+p2d3JkKptgrn8Oa5Yo825xqjRGaaDrmw/kKH0nQ2D/7Dp93Z9p4rD4BpM9zPx3Vgp2NzDnfiM1sfxlrQkgwZI6cjNOJMj177rY0v2kcBhFS5fljT3nnb1e9vrokCoKNvvnsQp2BvDfyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387450; c=relaxed/simple;
	bh=nRSlKVcpayELllH5UVKhFKJKcDAvMvdyHvTbz1LOGLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3esfDW10J3Os70gTqES3b1VrbhlQY+Yx6xi7j5kCQrGRZ+ZYh9jYHaN/jCe0iXfkqabjQvbxSWLBc/4ZPwnmpmhqekbhSENs4+nHfjXkTtc8K/yDMgaUGfkM8JotW5a5X+xIbe+y6t06B2/i2S9/WR6/JGtqMx4MB0lU4VoTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aApLDCYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B51C2BD10;
	Wed, 26 Jun 2024 07:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719387449;
	bh=nRSlKVcpayELllH5UVKhFKJKcDAvMvdyHvTbz1LOGLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aApLDCYUcHF0LOtt35jiJ4sozSrPxRHWtPg7n9ePn2DdqbBUM0vTDdYCI9iRlcPed
	 i6F1LgrTd2cLmSQYC4UQB33BT2rnB2gWiWmq6x8VIWpAjJJWVgltMTGrfhdSLnnULp
	 oFbNO0ruteElkkQhG6x+kkCwt2F+X9heTxnCICtpTMBcO6dOq49CD4UVmE42EPd97+
	 eESn53hbAri2/8JY8pcX/jPbt5JZV9BoGeGbDzM7toY969hk5yN7qwzZdy09Kqo9IW
	 g8eIA4ecKcZg4bBLKUxDhDiffQZQrXjjxAWu7+x/Lv3P8bnvQWh45Cr4WWa8cU5jSL
	 Hf4yEXVwFLM8Q==
Message-ID: <040eb302-df2b-4ad4-a12d-58aad53f5f39@kernel.org>
Date: Wed, 26 Jun 2024 10:37:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Split out common
 object into module
To: MD Danish Anwar <danishanwar@ti.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Diogo Ivo <diogo.ivo@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, kernel test robot <lkp@intel.com>,
 Thorsten Leemhuis <linux@leemhuis.info>
References: <20240606073639.3299252-1-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240606073639.3299252-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/06/2024 10:36, MD Danish Anwar wrote:
> icssg_prueth.c and icssg_prueth_sr1.c drivers use multiple common .c
> files. These common objects are getting added to multiple modules. As a
> result when both drivers are enabled in .config, below warning is seen.
> 
> drivers/net/ethernet/ti/Makefile: icssg/icssg_common.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_classifier.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_config.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_mii_cfg.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_stats.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> drivers/net/ethernet/ti/Makefile: icssg/icssg_ethtool.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
> 
> Fix this by building a new module (icssg.o) for all the common objects.
> Both the driver can then depend on this common module.
> 
> This also fixes below error seen when both drivers are built.
> ERROR: modpost: "icssg_queue_pop"
> [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> ERROR: modpost: "icssg_queue_push"
> [drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405182038.ncf1mL7Z-lkp@intel.com/
> Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to configure FDB")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

