Return-Path: <netdev+bounces-56202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C4780E28F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45356B214A2
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8A35660;
	Tue, 12 Dec 2023 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT11Gvho"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E63525F
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 03:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4DDC433C8;
	Tue, 12 Dec 2023 03:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702351080;
	bh=duVtBYF9/uEhtteq5lUjxhQBMmTnPleG8zmcnq1CCxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WT11GvhoK9rwieQoiDZI3rGVQKEHcQkthKU4+grqOG6ygOej/EE5+ycmUdj+Xp/Wl
	 ftDXugi8mrCyiQy6Tq74fJsryOZtDnwLreEd4LV/DF5CC2Yy4vGiBD2TufgJU2YzIv
	 g0r1yffPh61kYI99RVUcRG+WvHa4O6DxO5CvkKE53uBuZ+un7QvJWPExEVjeLeTn4b
	 NoffrD6Tvt4PRx+Lnt5KN0i9YD/JeF2u9DUKrPGNmxktNm573spvyQjt1fFSsL0+fK
	 2ffRHS93QFdBR4+CIPi3ytSeqo7TGMye6/euxAE0a6WuU+88ePUFhxtef+zvswJPdF
	 1hQFLkJk8o6Kg==
Date: Mon, 11 Dec 2023 19:17:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] net: hns3: add support for
 page_pool_get_stats
Message-ID: <20231211191759.61764363@kernel.org>
In-Reply-To: <20231211020816.69434-2-shaojijie@huawei.com>
References: <20231211020816.69434-1-shaojijie@huawei.com>
	<20231211020816.69434-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 10:08:11 +0800 Jijie Shao wrote:
> Add support for page_pool_get_stats, then the hns3 driver
> can get page pool statistics by ethtool.

Sorry, you're late to the party :( We have now added the ability to
read page pool stats via netlink. The support was merged as
a379972973a80924b1d03443e20f113ff76a94c7.

If you use the page pools in your driver in a normal way (each page
pool only used by one NAPI instance and one netdev) you should use
that instead of dumping the stats into ethtool -S.
-- 
pw-bot: cr

