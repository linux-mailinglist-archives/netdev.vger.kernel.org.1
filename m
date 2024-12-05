Return-Path: <netdev+bounces-149458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1959E5B81
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801C3163374
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A3D1DD87C;
	Thu,  5 Dec 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX1+FKZr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD41CD2B;
	Thu,  5 Dec 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416420; cv=none; b=aQgJE/i+Dq5VrKotnqGx/Dd2tnB5mjK2eAOw3bxebnd2DLuYqBIxtYdidTZhN4C+IpGRumBt8XPr06ySjmXkmaOZyxotsTXuuOZJlPkoTWVq1HNxmT2w3dpdeG7qgb9v7clt9XNXDismursQW5EhEdFrMfKVrAeApsDd1jcvorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416420; c=relaxed/simple;
	bh=Jm9FiVVGkKCn41GUNMduC5sc7+xW/qRItpfR0BrbJ38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmPkwQuWO+pYomgWpy3MSi+/duE+SQupmyJCdAfGnuJoiPVs5R95OwPOL4Jm0dr7O47xTIj6yrO9cI7E5XexvlguNiO0/QzNCQTD3MrkzbPK6e5KCv2WNV6RO3n+43OxR41GSKtVMtgpIidm8wiL9k4sjY+P5rp9oryjT+VmI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX1+FKZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE7CC4CED1;
	Thu,  5 Dec 2024 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733416420;
	bh=Jm9FiVVGkKCn41GUNMduC5sc7+xW/qRItpfR0BrbJ38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BX1+FKZrECZyz7hYRCDzu0I5iEUeKgr0vm+inPn+wLVSzfhnoE/aYqxqExsf97N4z
	 RUDIB4f8NmnmIob6l+KXHG7IZDJeaPVzqb+DbawPEsMnmHU2tQNvju9yVb1YoRwEzO
	 mcXhTDcNwnUb+WlbNiYo1Rj1azD6xwZj/JpiUQf8j5z2NjDjGpbKJ4CqdXcOzSbUks
	 o3Tpxxf0R9S5SrlpVd9Bh8AOSILmlqLISQdYOoL3CJ8dpT9ADFXWEriwQeeJtWC2ef
	 I2MZyTqKteI8nYsSoVLK1MQm5rFckbiRjd4g3mbDUQyzIq8dZ25zGfSYb2EIBdRYOO
	 Ceo1draz1V70w==
Date: Thu, 5 Dec 2024 16:33:34 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, hkelam@marvell.com
Subject: Re: [PATCH V4 RESEND net-next 6/7] net: hibmcge: Add reset supported
 in this module
Message-ID: <20241205163334.GC2581@kernel.org>
References: <20241203150131.3139399-1-shaojijie@huawei.com>
 <20241203150131.3139399-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203150131.3139399-7-shaojijie@huawei.com>

On Tue, Dec 03, 2024 at 11:01:30PM +0800, Jijie Shao wrote:
> Sometimes, if the port doesn't work, we can try to fix it by resetting it.
> 
> This patch supports reset triggered by ethtool or FLR of PCIe, For example:
>  ethtool --reset eth0 dedicated
>  echo 1 > /sys/bus/pci/devices/0000\:83\:00.1/reset
> 
> We hope that the reset can be performed only when the port is down,
> and the port cannot be up during the reset.
> Therefore, the entire reset process is protected by the rtnl lock.
> But the ethtool command already holds the rtnl lock in the dev_ethtool().
> So, the reset operation is not directly performed in
> ethtool_ops.reset() function. Instead, the reset operation
> is triggered by a scheduled task.
> 
> After the reset is complete, the hardware registers are restored
> to their default values. Therefore, some rebuild operations are
> required to rewrite the user configuration to the registers.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


