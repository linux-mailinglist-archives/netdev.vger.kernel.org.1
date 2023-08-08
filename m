Return-Path: <netdev+bounces-25622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E2C774EFA
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750302812B3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D6619884;
	Tue,  8 Aug 2023 23:09:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244029AB
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B28CC433C8;
	Tue,  8 Aug 2023 23:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691536138;
	bh=LHEpy2kMQ+rpGqp2zqA3hITqBkpx3yfPAhm/qBa1WjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DernWmM2Kj3iduIMGxQwplnR99FsBz3TD6HP7XeMcibatEPDaS+Oh6E1B09ijvs9M
	 whGcxDHcMFghlv2Cc8zjs2k1F/NSXIwENjQiYInpchYBblznxDUiXFWBtjuS2RcDMI
	 2QxcmBLadY5QZHwIst78ZB3tHXAiUUWBWzAa0cAwRBt4j4FZrpzl9ZDiqA20kCjXUm
	 RPmfAfPEIFumMKyx2ED6/kQpX4HbsyzmaF/WBjIyIC3C/X6HvdmbnNJW5ihGu23QCX
	 fPsBE4tW1XchXe2cFq0C7YSXeC8JFt9fx315YDW8Lcyq+sNnh2RqT8lfOEFHJ53c+I
	 O45gFfnFSyB5Q==
Date: Tue, 8 Aug 2023 16:08:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] devlink: Remove unused
 devlink_dpipe_table_resource_set() declaration
Message-ID: <20230808160857.5d45cfb2@kernel.org>
In-Reply-To: <20230807143214.46648-1-yuehaibing@huawei.com>
References: <20230807143214.46648-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Aug 2023 22:32:14 +0800 Yue Haibing wrote:
> Commit f6b19b354d50 ("net: devlink: select NET_DEVLINK from drivers")

FTR not really, that commit just removed a stub. I fixed it to say
f655dacb59ac ("net: devlink: remove unused locked functions")

