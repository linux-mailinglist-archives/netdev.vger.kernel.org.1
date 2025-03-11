Return-Path: <netdev+bounces-173891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA8DA5C21D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4B53B1BA3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1970114BF89;
	Tue, 11 Mar 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNaoEciT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E793A1494BB;
	Tue, 11 Mar 2025 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698831; cv=none; b=PrI0QGqbt85eMYZM9qESp8ixx2qnsJQGhBQ1kdh9rCg/1thHr5UE2TBN5oTe2H9eouhvxZGCr2Ej1kLEK6A2eQSKz0LNxz071JMOIG3Zv3TOK0kWPNEcPjA116IBg2/+o0raXyu910WMyIDKRwCzF85EoJJv0xoTvGdPOr9kd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698831; c=relaxed/simple;
	bh=We+ZlcIGkvH5xghwknJnqzxZ5+drU9HZs1RqCbl9KWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFI3Na8rUMtCu1mtVMn3gu6zSD3Sslzx/5yfE/DzCWX92SW/SciSXb2lnNHXhZ+9qve5ESWVEm7pfoOiHr9T7T8r+/9HNOmtfMjW/oJd7zdsHI/8WkdWj3bP1FUwlVujPwHU1BTrSBMNg+eUvXzuyE6fRmBG16CcBhSqOj5Vl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNaoEciT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B754AC4CEE9;
	Tue, 11 Mar 2025 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741698830;
	bh=We+ZlcIGkvH5xghwknJnqzxZ5+drU9HZs1RqCbl9KWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNaoEciTJp7cUIcy6WYdTD5CkUSmLEKMCWDDMmHaWfXwgThK2yvNumt0uYXsSylWa
	 IzjrsO6UrB9irN0rkDPUbVHNGHPl8HfaotTjb99xcXmS+whzFo/yp2YVKa6VQ3I8Rd
	 JdtXOCHV0pdxa2iu3ANb6gGI50M98PNFxk8dMHWCUNnddg39mVOkt+/VkGKUb2AvVB
	 OoufXmQmgndJ8uAFZqVMLFgnyOdT9OPbi0+ToKiIpSFRw9psDYt5HAGYhD51PFdYqG
	 ppovyS+wJXyoaQgCiuCI/3mQZqNJF6e03J8HXZmOemXGpO2drPm57jCbln2bnMg4TR
	 g2w28tmbb6PnQ==
Date: Tue, 11 Mar 2025 14:13:42 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: hns3: use string choices helper
Message-ID: <20250311131342.GN4159220@kernel.org>
References: <20250307113733.819448-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307113733.819448-1-shaojijie@huawei.com>

On Fri, Mar 07, 2025 at 07:37:33PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Use string choices helper for better readability.
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


