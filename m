Return-Path: <netdev+bounces-244153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 233BCCB0A89
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 18:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CCCB30B3FE6
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BBE331A70;
	Tue,  9 Dec 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKvtD8q2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1B331A67;
	Tue,  9 Dec 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765299546; cv=none; b=pcmKzomAxvIk/e49BvLBkaKIskHr5WCH/crdnBNKF6IWM43DZb73MKNr9DGBCCwBSjq3fQf9A0va8j1DBBI0f/L9wff2nmCsVo6BXSd1KkZgDBXt9ku5AfxTAeNCfkTLtm9UDn5wykGHe2R2Pvz+s5AtGzCp3/1HYRFgQnCxijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765299546; c=relaxed/simple;
	bh=GSU1zRRZ1vI5CnLegphBkx4E2oL9eoOFk6M4Ekfe64U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu7P1a6lPjjhd7jHkjD9SHyr5/yc45L9xQT8S5n0UIot2vMykDb7zWivaAv77TWRn3WTE1Zw5JnIm7qxZNTiq3+mHIm4X66qFbvXdNktg0F0iWxFjff1pxcR7gsXTciR1JchY+FH0Kri2HaZqGwZdVxn2P76N256uyMkxhHiHg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKvtD8q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AB8C4CEF5;
	Tue,  9 Dec 2025 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765299545;
	bh=GSU1zRRZ1vI5CnLegphBkx4E2oL9eoOFk6M4Ekfe64U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKvtD8q2Mr5Ov8kujcm2nZu71BRn6LoYQZ6sMswc+LtDX3YKwyUI2Fw5Wr7gJZQ9O
	 Z90TobqzwozMV4IzuTo7w7vFgsMcI2sF6NdjOMMRVJFXPAgqjKRt7bEyVGBj86Iqd3
	 02kTqwp/X6R8Jr49iB1jGOwVzKQwLB0dgTBxJIX/+18r4nB6wAe33gMG+BP9rSIfnG
	 CtXFPgnfUMpEbSExcUnmglCNsLf+c+FCFyRUuMq6aMDgQLHWz/vcCK2l4Em0HWe98Y
	 1Lrr19nP85zRE5sXtriv5wcGrCbY7nkGuwceLCm5ARFKIXFthRKUUAybNH1yT3H2MC
	 9FOk52Hg0z9FQ==
Date: Tue, 9 Dec 2025 16:59:00 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com, lantao5@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: hns3: using the num_tqps in the vf driver
 to apply for resources
Message-ID: <aThVVMH-1bAzpX3K@horms.kernel.org>
References: <20251209133825.3577343-1-shaojijie@huawei.com>
 <20251209133825.3577343-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209133825.3577343-2-shaojijie@huawei.com>

On Tue, Dec 09, 2025 at 09:38:23PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Currently, hdev->htqp is allocated using hdev->num_tqps, and kinfo->tqp
> is allocated using kinfo->num_tqps. However, kinfo->num_tqps is set to
> min(new_tqps, hdev->num_tqps);  Therefore, kinfo->num_tqps may be smaller
> than hdev->num_tqps, which causes some hdev->htqp[i] to remain
> uninitialized in hclgevf_knic_setup().
> 
> Thus, this patch allocates hdev->htqp and kinfo->tqp using hdev->num_tqps,
> ensuring that the lengths of hdev->htqp and kinfo->tqp are consistent
> and that all elements are properly initialized.
> 
> Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


