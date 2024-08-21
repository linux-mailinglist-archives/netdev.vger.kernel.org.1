Return-Path: <netdev+bounces-120406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A630E959289
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 03:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86681C22B16
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DDD136E37;
	Wed, 21 Aug 2024 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1/p0rIP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9B55C29;
	Wed, 21 Aug 2024 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205336; cv=none; b=Z82NRMxTz32/7L2PJi6VcSYcAMdgM4zzTH8aMZGbE9KRCL8p7KdUbsSRngbK7hr47I09IT8cpZzasnxleNW2CR9N3a8NyallSe2MoC0OcamAzvF4koxfTLY3ZlUNbL+w662mW7uBj7I2+/1EVjsj4NwCIGqySL2RbvbKIjo2sUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205336; c=relaxed/simple;
	bh=Q8NXkpmkPMz3V5XRc/KSSKRIImkk7KmqLFBenf1pywY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYV2CMo7whjudzRZNEctXyUKMgJ4F5BPKyiOa04KBSRMXOcBi05nJA8ykGw1Hvums3NuHQsfcPl3gf1fLR318mvT/sgdtXtZa5Ry8cMGvC7Kedvtq8F/lvd3WHXTYsV6UAQHrmgFInBy1gH5W/0ali/KkyjzMgFM9zkCtha6HN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1/p0rIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867D5C4AF09;
	Wed, 21 Aug 2024 01:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724205335;
	bh=Q8NXkpmkPMz3V5XRc/KSSKRIImkk7KmqLFBenf1pywY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F1/p0rIPh3uDfeAgssHIxlX5oz5d8Sk4riEKSoAWTXB+QBtxaYY8jBma+HsqVLE13
	 8HoT/asI5sKtOmk1O8F2u75lQJrYczj3ly/06ohpbaat3ooshcSRJbnQouBbYmkJjF
	 AvUj7tFrAewnJSDo5hH/Aw9csi9Lry0yFJMcVxsLPNVaI2Jzx16CxbPYehgoByLj80
	 w2Qp4Z5sW7sZqffCRaFle4Ows6KOwFuWedE2XlGu4ftv/8ChK787pxR1Ri2+9kjiSl
	 Uco8tz+/pksJ4+eIDR9RufjlOfh7zVqJ5kVZhgs03XmMJPKTn8lGgZMhdPo7D5pml1
	 G7mimyw1mlkFQ==
Date: Tue, 20 Aug 2024 18:55:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <sudongming1@huawei.com>,
 <xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 00/11] Add support of HIBMCGE Ethernet
 Driver
Message-ID: <20240820185533.054901d9@kernel.org>
In-Reply-To: <20240820140154.137876-1-shaojijie@huawei.com>
References: <20240820140154.137876-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 22:01:43 +0800 Jijie Shao wrote:
> This patch set adds the support of Hisilicon BMC Gigabit Ethernet Driver.
> 
> This patch set includes basic Rx/Tx functionality. It also includes
> the registration and interrupt codes.
> 
> This work provides the initial support to the HIBMCGE and
> would incrementally add features or enhancements.


Does not build

  ERROR: modpost: "phy_attached_info" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
  ERROR: modpost: "phy_ethtool_set_link_ksettings" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
  ERROR: modpost: "phy_connect_direct" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
  ERROR: modpost: "phy_ethtool_get_link_ksettings" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
  ERROR: modpost: "phy_start" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
  ERROR: modpost: "phy_remove_link_mode" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
  ERROR: modpost: "phy_print_status" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
  ERROR: modpost: "devm_mdiobus_alloc_size" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
  ERROR: modpost: "mdiobus_get_phy" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
  ERROR: modpost: "__devm_mdiobus_register" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
  WARNING: modpost: suppressed 2 unresolved symbol warnings because there were too many)

