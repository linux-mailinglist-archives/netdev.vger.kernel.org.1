Return-Path: <netdev+bounces-119239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4281954F11
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600782846C9
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA81BE235;
	Fri, 16 Aug 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxQTUXO5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DA1BDA82;
	Fri, 16 Aug 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826520; cv=none; b=jFnqy1ZHr+U/hf94ZG5xv366kBd7kYs5Ji/SN9Qk7UIse1PX2PoYTrg5bKmavKeRX19cpIOQcg7b0LRz2UDW+6VjhMkptnEZLLC+NkPwiPZIMiYYlNtg3QO2nweEJbAwDq3dE1ax/SQl7cM2DQ00pqS3TS12Tn7ICdaIx9emZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826520; c=relaxed/simple;
	bh=P1cwZfjIOfORwRPmlBK5XtIM4Ca9TP9yZhamFhfZtps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=butDUf2bOzOvnGfqd2OxOdinPXGf1E4PvVA2OiBN7ejvL0GjdrTWa+4QbALve5fi9pIbqwX4adeXvhO1qexlfNy7Cy4Zp/igQSqWXikxT5fkY2UqHU7gKSl8VQeZE6bSR1MK2kQ7aRNhOaEDPguFlQvbTNL7eNer4PhSaebvyV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxQTUXO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C61C32782;
	Fri, 16 Aug 2024 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723826520;
	bh=P1cwZfjIOfORwRPmlBK5XtIM4Ca9TP9yZhamFhfZtps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxQTUXO5DkErJxTHogjExEUmUir+S6QiHI+x+hS6ezCbxVOHl9k5pSe2Vw6C0k0+F
	 U2s5v5cZsmlABBDw9z2Zrh3zc7Hs6wkeqp3gt6dhAlRzQVkkzcHsv8WsKKhoOur+4v
	 fQOe3c+sNXqNjuwrqrLel0bgxu7vsJfLhSF9ckNl9JpmGfR07uOtBU9x19tSPmeNPH
	 StTLSTV1YfARoR1KZp+6NkpxllL/qMhzea8Oc7FH/fXykhGaaf5YF8jHHfCiuNO/au
	 w+DgLP8HcNRc0FS9TnwuO/ts1UDFJdrBJZGvqd2kIeEZf2rtsGe5pi2UQHm/VUXCr+
	 ZJdzLx5zHCddA==
Date: Fri, 16 Aug 2024 17:41:56 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mptcp: Remove unused declaration
 mptcp_sockopt_sync()
Message-ID: <20240816164156.GX632411@kernel.org>
References: <20240816100404.879598-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816100404.879598-1-yuehaibing@huawei.com>

On Fri, Aug 16, 2024 at 06:04:04PM +0800, Yue Haibing wrote:
> Commit a1ab24e5fc4a ("mptcp: consolidate sockopt synchronization")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


