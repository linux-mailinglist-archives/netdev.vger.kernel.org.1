Return-Path: <netdev+bounces-133629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD1E996925
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C18C281FDD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78F618E039;
	Wed,  9 Oct 2024 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkddAh53"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85217332B;
	Wed,  9 Oct 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474402; cv=none; b=rhNFJBrOPMf80/waTUkwcXimXq7Icriq/TKdsCJcnMyvVm8Swj2nsDm+qRVH5L+Yt1s0nZyZCMUJDZW02JdYlVekwj4d80Cvz3LG0lA95eejywIWJbzx6WTiFRLhvH8isX1QHHqYMKVTtjqG1xWBc6GQLg2EDI2C+fltVV/djsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474402; c=relaxed/simple;
	bh=zBuqDGL47fFD3anVWs8F4TVEb21XQ+COZigFwByA2wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT334ATFYRakw4KyFIlPeewhJebR7zsuwF2JZRQsTd1kISl0TyowJk2MnKXh56xOh26RmHLlr0GOiv0+bK6IZrzbVQd6dVjVSMDgKODdq1lX9M3Wfo2n74qAD9hSNDHGPRLSXeNOEYwpuVEWGagRPMX9HJbIZO3wI2v6c1dm8bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkddAh53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F08C4CEC5;
	Wed,  9 Oct 2024 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728474401;
	bh=zBuqDGL47fFD3anVWs8F4TVEb21XQ+COZigFwByA2wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkddAh531RdCGXC1aarJkZmrq/NG5DJfmc22maFqr1lB427lKnxUeDQ2ua5IfxI5t
	 xSh4IDKVKyEXeGThEpHE2aTSg0BYykHr/PTw5TL7IrbIHEZXMpb5RndRzjJzA3RhAy
	 3qKpYjninZ/FIdF1He9oat3q79ys+Edrt8Z/Jrw1rK/bgfnfw46zyZz/c4yf2WRNxX
	 XjC/7ty9Y8L/rS8L4AeGFV01K77MyNDqjRMxXPlM3TNkpmwvmHjPDXI3gHWDSM5oje
	 GM3NRRDSOBF8udIJEygLJVXWsHvgsAt8nikOhn6oRsYPsq7i1DvIHff5AuDK4iWbkp
	 dc5c+kV3vO44A==
Date: Wed, 9 Oct 2024 12:46:36 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, salil.mehta@huawei.com,
	liuyonglong@huawei.com, wangpeiyang1@huawei.com, lanhao@huawei.com,
	chenhao418@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: hns3/hns: Update the maintainer for the
 HNS3/HNS ethernet driver
Message-ID: <20241009114636.GI99782@kernel.org>
References: <20241008024836.999848-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008024836.999848-1-shaojijie@huawei.com>

On Tue, Oct 08, 2024 at 10:48:36AM +0800, Jijie Shao wrote:
> Yisen Zhuang has left the company in September.
> Jian Shen will be responsible for maintaining the
> hns3/hns driver's code in the future,
> so add Jian Shen to the hns3/hns driver's matainer list.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Thanks,

I see contributions from Jian Shen over an extended period of time
so this seems entirely appropriate to me.

Reviewed-by: Simon Horman <horms@kernel.org>

