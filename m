Return-Path: <netdev+bounces-168319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CA9A3E820
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0A6189601D
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8F264F81;
	Thu, 20 Feb 2025 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2dpPz8r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681051DFE32;
	Thu, 20 Feb 2025 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093098; cv=none; b=HeyYnRURze4cpCNrccZIZXlbc+JwnQkEu1M8Gjo4YdWWFEmTaiPJgXusr+/ZVzPj0UGI4uAYM06ykAPW7ObcLaAwl0uuDzbHuNfwMZej+KwrXzLwQU64xAXZguorRY6SyCB9oJC30l69JdUmAqIU4xKtPre2p+cJGnXkWwEWQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093098; c=relaxed/simple;
	bh=fesaolpwMKxzwkA2whJtKMvco8gQp07uWXyXJETthrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOVZFD3p79bj2Qzkd2n8weDXCFc9k+8eg38slxaCGSAfN0Za9JwU8pksTfITZ53oVjdR12EKeGNwUqzLVA00pHHJUBItHzoZnX+vS/7e2tIpwTgClfo+wnvRWqIR65CbcUmor6qLt1QHWbqWsBC6pM0wKPBiPZMmT3Kt81XbraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2dpPz8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBBEC4CEE3;
	Thu, 20 Feb 2025 23:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740093097;
	bh=fesaolpwMKxzwkA2whJtKMvco8gQp07uWXyXJETthrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V2dpPz8r+fKDYI8NnK34SxBBjsasLzt0oksL4+fV/BTHk5GckVktSYuvNYk0QwZVw
	 13mh6q69Nb3j3OSJw19pgIyo3sHREdVv/yqNVMCqf+nJF+qlhVHGkclWqsQoZOUV7m
	 2uBL4QBSkF5Hj0N+cee9vISCQMMKcF1WTodGv0utrYFGMtgrjSPpDXeuDqzABcl8is
	 O/KnSGcem9PHcmiiLqiM1KnyyHjGKaGXrqUqCJ+VVOhPF4J+sHzr/4frZ84TPRCrUH
	 SoxIyKAyPk7ciinCttop9ojiDR3w2NRi0kIDLvzbVPcADWFcPtl7KU/JYn9I3+2KQN
	 EK3GYDbAl0Zwg==
Date: Thu, 20 Feb 2025 15:11:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 2/6] net: hibmcge: Add rx checksum offload
 supported in this module
Message-ID: <20250220151136.2cb46929@kernel.org>
In-Reply-To: <20250218085829.3172126-3-shaojijie@huawei.com>
References: <20250218085829.3172126-1-shaojijie@huawei.com>
	<20250218085829.3172126-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 16:58:25 +0800 Jijie Shao wrote:
> +static netdev_features_t hbg_net_fix_features(struct net_device *netdev,
> +					      netdev_features_t features)
> +{
> +	return features & HBG_SUPPORT_FEATURES;
> +}

Do you need this? Why would the stack try to set features you don't
support/advertize? Also you may clear SW features unnecessarily this
way.
-- 
pw-bot: cr

