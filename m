Return-Path: <netdev+bounces-24663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D484A770F77
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 13:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8508A2821E9
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB1CAD27;
	Sat,  5 Aug 2023 11:36:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C05238
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 11:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0014C433C8;
	Sat,  5 Aug 2023 11:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691235361;
	bh=kd0VkQAwzmUYG0iJSUv7G6zXv1A7lZ6NymdjHkdbFIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6L8sW/9wM+iyNIcrZkuY613GL/EUkuQe7N6VfbdZ9Xskkmne//nVd2ClUsRZ7tuI
	 M008b24M1eaODEo8x61YTPLydhlWfcaK9ryW4W0y4+X34PULMwOsIzLpDPlChs5U9z
	 yU9odLlE+hIJ92v50BBkY7pEjGPjSeFg5DaYkc2PSIbAZ9GDkvVX8hqjftZAdc5hUI
	 ra7BAmowfVqynSdv5mhj7K2VaXfm4B677oxAnVLXlvM2PYD2VxP/tfyTKCkElSny3r
	 d07txzAxkPrWU/4lHOtvH640uMLD+oCezjUrdTt/0xl4BjENzW1amH6FdmlW27GhAJ
	 fi6/3MoK1gXlQ==
Date: Sat, 5 Aug 2023 13:35:57 +0200
From: Simon Horman <horms@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, alexandru.tachici@analog.com,
	andrew@lunn.ch, amit.kumar-mahapatra@amd.com,
	weiyongjun1@huawei.com
Subject: Re: [PATCH net-next] net: ethernet: adi: adin1110: use
 eth_broadcast_addr() to assign broadcast address
Message-ID: <ZM40HQAzPtSKRGCL@vergenet.net>
References: <20230804093531.1428598-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804093531.1428598-1-yangyingliang@huawei.com>

On Fri, Aug 04, 2023 at 05:35:31PM +0800, Yang Yingliang wrote:
> Use eth_broadcast_addr() to assign broadcast address instead
> of memset().
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


