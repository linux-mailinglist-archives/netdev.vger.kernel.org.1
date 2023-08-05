Return-Path: <netdev+bounces-24682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E113F77105D
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 17:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BA21C20AC3
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02D0C2CD;
	Sat,  5 Aug 2023 15:38:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B41FA0
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 15:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E21DC433C7;
	Sat,  5 Aug 2023 15:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691249891;
	bh=j/d3rWJglEtiMPNpicQRzhq8Gf1R+0qg0c5wppIeVLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYiLEgxu1+UzeAVgKWZs2ijMYqsvbZDP3ftd1VNx7exIf1sEkakP/UKSePDhQKuLf
	 aOI2+1ZtZHtMzvdRTx76m2PmFy6HblcCgtXXUjb5DV3M7l6DZxaZuywYTnL4Um3WfM
	 06VIrzcO7YlvYYS1X9iQTzr2zlFpBldoqVBmhOL7XfhiVIs+RyDNdlOzhTr9xAiMOt
	 S452jyprGzxMR5n131Ze2c98Dhe+Ax3qjCL9j6tLovuSt7min5LufNQCSfv39f3wOz
	 PC8+lzawAQIJKUUKZhhh3G71V984JZOqoaf21I5+MAg5vlkooXHY+wZNq3NOH0h0gs
	 9dveREwKw0pLw==
Date: Sat, 5 Aug 2023 17:38:08 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: hns: Remove unused function declaration
 mac_adjust_link()
Message-ID: <ZM5s4O+gSiKOa7BS@vergenet.net>
References: <20230804130048.39808-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804130048.39808-1-yuehaibing@huawei.com>

On Fri, Aug 04, 2023 at 09:00:48PM +0800, Yue Haibing wrote:
> Commit 511e6bc071db ("net: add Hisilicon Network Subsystem DSAF support")
> declared but never implemented this, remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


