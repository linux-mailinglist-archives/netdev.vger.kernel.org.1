Return-Path: <netdev+bounces-170316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C57A48239
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AAEA188F472
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD59D24DFE8;
	Thu, 27 Feb 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+zIfa19"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233623F285;
	Thu, 27 Feb 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667631; cv=none; b=gMPRHvZjwiwKCEm4ALFEAFwo8Dy0U9q8van7ZTFJIGyt03fdZTCiRSEdM1L2p13EBidkBnK9rAU8Hw74broBhASvJgZuVEmqL3UdeaTLqDRuNRk5uxULtGN3i5AbzWvl7aHa1cFiZyUj0rqg2/l4tXUB1TToqelMKhbQNkOfnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667631; c=relaxed/simple;
	bh=jox/nfnwrjGVspjEMLfYePtujaSPad7kpCrtDhZkrbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CI4MncWq7lLXqwfn+OgO/g+/AqMSTlGmmayju49/AkS5vg9So86hhg+4aRCv+K5fZUKI5DTX2jBbGT0Hs22BAGgL9iYS4o+NF2WQHnymGtQ9M/DORBKostmknhQ6vk5SkRYF5NvQiZ6rsXJ1rGpgr8PA161FosfnkU6tpXZRQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+zIfa19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F33C4CEDD;
	Thu, 27 Feb 2025 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740667630;
	bh=jox/nfnwrjGVspjEMLfYePtujaSPad7kpCrtDhZkrbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D+zIfa19zkkTaux2FTjQm0ge9hDBDiUyElLgz2ec9g0UW5ggQA26WIbtDNCRs/fOc
	 t0ReRpIHH2Zjs/rfi2VR+rfQz2WBjk8t3b/NGBvT0h6ZB7zXDK3MJLk7z6yTeX0HXt
	 PPvcvMtDDxHdjuxAwEj6yERSzNOyhuPtohfGwxnX92ql5Iie9xOFY/kqzfq97vR5vj
	 4lZoj5ofQj/bXHH4XoN2p3JisgjN8jTgnhyyHvj909sslZslrCphnlOialGZNV1vwV
	 z005MwR6LGEkZyUAEG29EIeGKV/Bq+S8JrIF7I4rM7Pw+fTLAUk63NC1Ms55kpY1Q2
	 RqwMpalXXaSaQ==
Date: Thu, 27 Feb 2025 06:47:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH v3 net-next 2/6] net: hibmcge: Add support for rx
 checksum offload
Message-ID: <20250227064708.7811dfa7@kernel.org>
In-Reply-To: <11198621-5c04-4a00-a69e-165e22ebf0e8@huawei.com>
References: <20250221115526.1082660-1-shaojijie@huawei.com>
	<20250221115526.1082660-3-shaojijie@huawei.com>
	<20250224190937.05b421d0@kernel.org>
	<641ddf73-3497-433b-baf4-f7189384d19b@huawei.com>
	<20250225082306.524e8d6a@kernel.org>
	<11198621-5c04-4a00-a69e-165e22ebf0e8@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 19:28:25 +0800 Jijie Shao wrote:
> rx checksum offload enable:
> 	device check ok ->  CHECKSUM_UNNECESSARY -> stack
> 	device check fail ->  drop

Don't drop packets on csum validation failure.
The stack can easily handle packets with bad csum.
And users will monitor stack metrics for csum errors.
Plus devices are wrong more often than the stack.

