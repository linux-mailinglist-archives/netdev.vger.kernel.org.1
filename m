Return-Path: <netdev+bounces-151279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 147709EDDF7
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728BD167645
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 03:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F07014389F;
	Thu, 12 Dec 2024 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2zLSggm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443338DDB;
	Thu, 12 Dec 2024 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733974884; cv=none; b=BQZlJutOdbxtdxMtD/Yej2K8S4scP216OIYFTqhQ54UEjb1eLgFnwNv7CDs+pdb2JciyizLA8AAGJnA54UStmJXs2soR8AZF5vzrPOP71OynTn7UuXLQlc8dbwej0eZEuqKkdkiWHYDG9Nv/vtruRcyp2g5HL9orAbE7fDYQ+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733974884; c=relaxed/simple;
	bh=7Vi1Sc9kCGtKQksRtAfKyk/bPxwvFdGJDdkUvncYg8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZ8esqsbFRjU+oxsp2loedvBmZoz5VEa1gFtMQAlW2iaUbr4Cs8WnCNpv6XLPW0B33GPP6/0y0CIL8imDhsQhct9rb7edTbW7Yr6VGYFfZHxN9O6WkRaMnwaN+DWdiXLnxBGdUopxXduSH9GWczFg/LLAY1mF1+6IZeY2nRYKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2zLSggm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317F8C4CED1;
	Thu, 12 Dec 2024 03:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733974884;
	bh=7Vi1Sc9kCGtKQksRtAfKyk/bPxwvFdGJDdkUvncYg8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G2zLSggmzEFyOKFADq5n4DbpgYATKEExUnAmufeBGTR+tzG4vbtSeyFnCJspU0Jpj
	 K800gGsDkIIPxuIplISk0VilwFQ/0arl4iMo2pwv1umZrOkG7W2wsBlVtVf/UxVkIz
	 2fjXR+PgMSSLaCxFclTIELDLofVk1lF/TGsV71dmjxctSS80kKnWxKHSJQgPb1R/ac
	 SZi7gAW1wKDMmgMEZBHUv0/fTavxxLJGGEAtv8wd7M+uFElqnuLRYefTVPXzZIFJRi
	 aVRnP7hVH30jdNvH4p2HojZA20EQ89V60HTPyDdE74xeLbI4/XezD42bTrhKGS3DP/
	 V0nHNHoBqN7PA==
Date: Wed, 11 Dec 2024 19:41:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <gregkh@linuxfoundation.org>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <hkelam@marvell.com>
Subject: Re: [PATCH V6 net-next 1/7] net: hibmcge: Add debugfs supported in
 this module
Message-ID: <20241211194122.26d6b38b@kernel.org>
In-Reply-To: <20241210134855.2864577-2-shaojijie@huawei.com>
References: <20241210134855.2864577-1-shaojijie@huawei.com>
	<20241210134855.2864577-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 21:48:49 +0800 Jijie Shao wrote:
> +#define hbg_get_bool_str(state) ((state) ? "true" : "false")

If you're defining a wrapper for this you're better off using
str_true_false()

