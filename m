Return-Path: <netdev+bounces-146086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DBD9D1EAC
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1BF280A7F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293D614265F;
	Tue, 19 Nov 2024 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuaBF9nI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1613BC18;
	Tue, 19 Nov 2024 03:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985670; cv=none; b=QGZDV54u0qUYmVh8nLjYPeB8+is4gU3BSyLYkdPf6WEWcGVeKurunQvvNobyWSU7quLIrZCtYoSjDsRgwZDYetcRJZbnYbJTAhkRdL3MvmiNMGv+34H5ztlAPExE+GIuTF9QueROZSoWgxGMZiMgFyPtF7iqeSLSgNzydvT0Psk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985670; c=relaxed/simple;
	bh=PMA46ECRKsd07Hejlsp2gsLPbrlGX1AuRmSsHxcbkPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6znxMpHtztl2/OjF409FpNHMCZwxZfv+SGE+fAhUY9ta9CFzWlWTkUT1c+2noXiYPraGbdEG/oljRwhD8hofVdlntH+rEXhjDoM2l7LekzFDMYtFux+peEt59+va0+2U+R2o1Pm+hjyHjuzbB+YutpfNWxcayIqOQisRwgsWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuaBF9nI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB4DC4CECF;
	Tue, 19 Nov 2024 03:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985669;
	bh=PMA46ECRKsd07Hejlsp2gsLPbrlGX1AuRmSsHxcbkPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fuaBF9nI84qDynVw3w3/EnFa9hdXqJw5HVOOEz11HuVzCt5PRX+V07DJebU87TyNX
	 HTOTIsZnhiIXbM9v6LDVwlLZhaCJQeWoBtFu+ky8ZlPtQQTFdAJ5gA69dWvna+sNwF
	 1brLz8yTOAXS05rWDxNfE+LsE3izhqJVEhVAUYXmgtYnsRbGF0yp22wApDOk7o8pHC
	 vsQHu7IPKqO2/u2a0PCtCnv08sOL6YokcG9FkOS4LphtqjGLA6szt+MemmeuULK4Ii
	 +qkHDlaonpIx432h/hyqO0B/ycHPevl8ZSkCDvc9iAi1CJb0WN6qkd9lqE2ycIAq2v
	 qqHIPKBIdEHSQ==
Date: Mon, 18 Nov 2024 19:07:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <hkelam@marvell.com>
Subject: Re: [PATCH V4 net-next 0/7] Support some features for the HIBMCGE
 driver
Message-ID: <20241118190747.2c4ab414@kernel.org>
In-Reply-To: <20241118141339.3224263-1-shaojijie@huawei.com>
References: <20241118141339.3224263-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 22:13:32 +0800 Jijie Shao wrote:
> In this patch series, The HIBMCGE driver implements some functions
> such as dump register, unicast MAC address filtering, debugfs and reset.

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new drivers,
features, code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


