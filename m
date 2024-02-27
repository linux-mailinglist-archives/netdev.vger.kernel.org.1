Return-Path: <netdev+bounces-75417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72805869D5B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B1EB20328
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DE4481BD;
	Tue, 27 Feb 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ0E1Xti"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A5481AD
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054342; cv=none; b=i7qoiScMxAn110vlbC40z1h9moHZeKBsZS66U8l7fjJQmTYBlFMaaHVjuhibghHKQq4J3OHH8iH7W1NIymg29UyiFQQRrgbZ5gmG2WC2hib7CMMmgTWSw2my3Vk/cKtllZ5MxTkcponTFLk1PKMei+pLDsNNtRj8SYvI1KLOo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054342; c=relaxed/simple;
	bh=TcSmgbYP2IGQhFJd5QD5+6/5wHCWnfjoirmXXEoIHbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCgmwUN+5xTOM1v+Is8lpmATao1Jnffon5W3N+t5P8VkEWFCiW36ZHkbI/GYjsCDW3cZp8petrNJ8guDD3CXRu2IDBvhwdkBT7iI8CwdZkl16KNZ89BGIJMrRverH11xUFYs73vKcipmLGnOApOxjqzkvMcK0jZhQYXp/77EIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ0E1Xti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BABFC433C7;
	Tue, 27 Feb 2024 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709054342;
	bh=TcSmgbYP2IGQhFJd5QD5+6/5wHCWnfjoirmXXEoIHbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQ0E1Xti/Kd8ddxiPHuxkgEr/9vAvKjzxRIzkfR9C1QcDpbuMMM6gJ/Zga1m5E4xY
	 ql1YNznVo/0aG9tTFRujzOBNb1FVlX8ILLl68GunCwzAC5DHN/Qn1NO6VS8XgoHeis
	 OZfB5oCjVNlEv20qDHCEx12IWYEy7n6pH3FRkTvzczu/Zk/FLVuRbJlcerXo/WFnD1
	 IfUKoGZYMf75ggKcm9BmF3rJzbqbC2HU1nP7fm6rmuyeE15oHke52u9JgFCErR7VOD
	 xtb18sOlVHBnoijVz9a7aFrpiAvy34OA1OXvUAWqrb5QbTAJbE6jmni1XShBcSo+Ew
	 9GnziWTvApnwQ==
Date: Tue, 27 Feb 2024 17:18:58 +0000
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] ipv6: raw: remove useless input parameter in
 rawv6_get/seticmpfilter
Message-ID: <20240227171858.GF277116@kernel.org>
References: <20240227005745.3556353-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227005745.3556353-1-shaozhengchao@huawei.com>

On Tue, Feb 27, 2024 at 08:57:45AM +0800, Zhengchao Shao wrote:
> The input parameter 'level' in rawv6_get/seticmpfilter is not used.
> Therefore, remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


