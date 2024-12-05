Return-Path: <netdev+bounces-149454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9289E5B38
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D166E188360E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015321D581;
	Thu,  5 Dec 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxMhhosm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA66A18B483;
	Thu,  5 Dec 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415755; cv=none; b=uUzBH1YHwt7KSlWdGUDDzVUO4FjQJOgamb40J/LvMEShjzw/3vSjbeVwu1KsS8+0t2Le3jU67MgZGlDoEce7F1g8jH5OfHxqVQS2xcADHX7MstgYf39DLIC8+3T0jmiMOLiU3CK4tCsgwvAYHe09usojoo8oWcznsJwJcFXGvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415755; c=relaxed/simple;
	bh=UfpBoaWzipUkr6zt+fTmA1zrHvkOCxwku6cXwe0eGMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdHPTQc0BLVN5qaEMtKgUt3xejfotLGZ7siYoEi5de4nEfL3TFgMXd4VMSDAiEC+yv/l7AMqPdI/pyGocsbpIbJk/lk2px70Y0v82ZDlkXbJc6rHm1RGhV0oCdrATMFOb1+o9P1MSMoQ3uL93sOCWRs0dVSCnAieaCfki3Zh3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxMhhosm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC644C4CED1;
	Thu,  5 Dec 2024 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733415754;
	bh=UfpBoaWzipUkr6zt+fTmA1zrHvkOCxwku6cXwe0eGMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxMhhosmxupV+xkW/RzRCd/hTJxe3keBYEakI1XshVWiiDo1q4/AgEKd/glIM4j8q
	 It0ck3ZOCjQ1KJnT7NKOoJX4WMe6eE2JXcnKQv9xphJo3r4FR7YNivDC1JEpTJgVsF
	 dq57089AA6lQqAQLwbXeS38OuPMETRSMhhnTXa2EVXtMTesKmiu18C3YKhoq+91Mlx
	 DBDX+jKZEm3TllEoeLX78SKhEDDGL1lsVOFdpjzva6/SNcbvwSsgOkUxfhPDuNOBbJ
	 yNdZgrFf69STVWxxl6Hfrt/+GAclIchZ43g5/VKSMtIS/2slEmBz2Hrm1yj5COzDVc
	 70tTMHPyvUfPQ==
Date: Thu, 5 Dec 2024 16:21:28 +0000
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
Subject: Re: [PATCH V4 RESEND net-next 1/7] net: hibmcge: Add debugfs
 supported in this module
Message-ID: <20241205162128.GA2581@kernel.org>
References: <20241203150131.3139399-1-shaojijie@huawei.com>
 <20241203150131.3139399-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203150131.3139399-2-shaojijie@huawei.com>

On Tue, Dec 03, 2024 at 11:01:25PM +0800, Jijie Shao wrote:
> This patch initializes debugfs and creates root directory
> for each device. The tx_ring and rx_ring debugfs files
> are implemented together.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


