Return-Path: <netdev+bounces-24661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D142770F74
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD5128166D
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43122A957;
	Sat,  5 Aug 2023 11:29:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619B5238
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 11:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E589C433C7;
	Sat,  5 Aug 2023 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691234992;
	bh=41R+UDy76RZ+239Ysv/G0InDA0z3/1LiWQRgLFz4EaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnCuB194uQb/c8PJyHIal0m9jzTn0oTSdu0EdkLbJknJlZzDaTK4h3zSi1jsmVrGH
	 skEk4iMmU4SOctTFX3JBG88/4k0yUWtwWJo7/XzbfWGd1xG7RVMr3VUmL/nUeDEwk2
	 XW0OukTJ4h1V5ko+9bBdA1Kw9XEvG2iiV+aII/zo8Rq8ALikbwsRbAw1gYE+O7izZX
	 KGk6ILbIGyCzt2fKJ/QbZxWbnSr/iL8PNfse+c5kAp5SQK08COhhwIWD10xSRdtofU
	 JLelRkDczYoF1fCY1/ll81V+De4MCRPK1/azH+2fHhRy/u4cA1m0wCmVShItD3PoYW
	 EDottNVsy9bpA==
Date: Sat, 5 Aug 2023 13:29:48 +0200
From: Simon Horman <horms@kernel.org>
To: thunder.leizhen@huaweicloud.com
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH] net: hns: Remove a redundant check in hns_mdio_probe()
Message-ID: <ZM4yrM11M86Qy3vd@vergenet.net>
References: <20230804092753.1207-1-thunder.leizhen@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804092753.1207-1-thunder.leizhen@huaweicloud.com>

On Fri, Aug 04, 2023 at 05:27:53PM +0800, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Traverse all devices when a new driver is installed, or, traverse all
> drivers when a new device is added. In any case, the input argument
> 'pdev' of drv->probe() cannot be NULL.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Please specify the target tree, net-next or net, for patches for this
driver. In this case, as it isn't a bug fix, it would be net-next.

	Subject: [PATCH net-next] ...

That aside, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

