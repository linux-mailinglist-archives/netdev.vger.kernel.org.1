Return-Path: <netdev+bounces-34312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D928B7A311A
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 17:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9368628221A
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F034314A82;
	Sat, 16 Sep 2023 15:31:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66914296
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 15:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C61C433C8;
	Sat, 16 Sep 2023 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694878271;
	bh=bwbdn6mceJx6nwNkmrcHaUUVzKQ7uA631d88CdeBgX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efIRaBcuNeqRcMDsP8VUYJsZFR5VXy9Jakyd1yGl3ICbfrUfsFd6/cZMWpdS6GeGz
	 l+NtKd1WNg3Sz5vu4wYduVD8YAfKhW0RSwvwKgSk0hju6387fIzPfl199oYZgxy30+
	 bmiHwQPSbz4r7reLlATaWrZndzMU688JfQFpytZXkvReXrIRw/xkQxgWheCZCaQSET
	 /L4rMmnIAMOynBR2xo1TM27IKwcIJwgXxFxnjY+SgxP2HyD5WZx3IQruh3nUhOU0NP
	 z8itMWZswbbI/zbKVG5yLJ+JjamlYAxd3r1ZwR7tFJOykc/e3Dyj/QsTGpgzRx7Wjm
	 2BvVXOtdIsOpA==
Date: Sat, 16 Sep 2023 17:31:06 +0200
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/5] net: hns3: add 5ms delay before clear firmware
 reset irq source
Message-ID: <20230916153106.GE1125562@kernel.org>
References: <20230915095305.422328-1-shaojijie@huawei.com>
 <20230915095305.422328-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915095305.422328-6-shaojijie@huawei.com>

On Fri, Sep 15, 2023 at 05:53:05PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> Currently the reset process in hns3 and firmware watchdog init process is
> asynchronous. we think firmware watchdog initialization is completed
> before hns3 clear the firmware interrupt source. However, firmware
> initialization may not complete early.
> 
> so we add delay before hns3 clear firmware interrupt source and 5 ms delay
> is enough to avoid second firmware reset interrupt.
> 
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Hi Jijie Shao,

is it appropriate to add the following tag?

Fixes: c1a81619d73a ("net: hns3: Add mailbox interrupt handling to PF driver")

