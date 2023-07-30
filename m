Return-Path: <netdev+bounces-22652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F687768702
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 20:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A591C209D5
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364CA14F73;
	Sun, 30 Jul 2023 18:07:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F43D78
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 18:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEB1C433C7;
	Sun, 30 Jul 2023 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690740442;
	bh=iPW6Oi5yplI8WHOIzKrbqU9cTFrQcDMForF2HZJ/bWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOLmgKwkuwy9UpXyy5/a0iJONcWZOC4I3lRb/5iKmmo1FsxlokcR2CtS88dozbFMJ
	 amW+wpcIIFauUn+AUq8i3A9j4+xpvuOpN9C4XT3UsCLjPo2VifgpaznutsNghU31py
	 8e3U7VeIcx/ll0EjAjPrmyER0sPFxCKSDmx4FwTvHXMlpp3fpuQ7KJ9jgsc4dTV/RL
	 AOJvGd/6dCNjHeGE9kwpiCTlkNJCDLp2UjUiDbWUaQb8FenJD6PQnR5XLvPZfdk4nB
	 bj0ERtIHOQ/p5QQeIQ+fFmet9bu5Q7wYxFXeIQMZpxR9ZuE9fSzXbebA4zk7yllSnG
	 vZRfwrP/4vUXg==
Date: Sun, 30 Jul 2023 20:07:18 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/hsr: Remove unused function declarations
Message-ID: <ZMam1gYzGbVJKL3m@kernel.org>
References: <20230729123456.36340-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729123456.36340-1-yuehaibing@huawei.com>

On Sat, Jul 29, 2023 at 08:34:56PM +0800, Yue Haibing wrote:
> commit f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
> introducted these but never implemented.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


