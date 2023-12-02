Return-Path: <netdev+bounces-53232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BD6801AE3
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 06:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FD31C209B6
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 05:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71032BA22;
	Sat,  2 Dec 2023 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iyejulx5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484A619BF
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 05:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0BBC433C8;
	Sat,  2 Dec 2023 05:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701494368;
	bh=8jxISvQ5wiTf3w6KBQZeRqJTOGvH0KRxM2w8b45bfMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iyejulx5+mDAzZyu8k24nmTJNMPk5Jxx1kk4pBT2LJlmyZgxGil1tGXpjbSgwCK02
	 rCIoNsXhMl/RJJ0zaa4hjJzLtDZ4u4Ru5htP7OVow0Ucr+c3soW9Kpfzh49rKkWN7U
	 JaKRfv6e5TK4mvdaOGF3AEWqio3jdvltcKZlCEm/AyJ2vqqa7oKSxWc4UpBCIBcs/O
	 AH7Kyw112jFpF4d4dZg4G2CworjT0m6T64BggAN/FMTUtkeoZtWqfHZYKQP4PATe8N
	 nuiGTEIM8WMnzjR4aw2p75M080by+9Qg3h+uMcXJtiocqyP7O4EHgdlKM9UQ8rw6Wy
	 fkwYy5rWxEnGQ==
Date: Fri, 1 Dec 2023 21:19:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: hns: fix fake link up on xge port
Message-ID: <20231201211926.3807dd7f@kernel.org>
In-Reply-To: <20231201102703.4134592-3-shaojijie@huawei.com>
References: <20231201102703.4134592-1-shaojijie@huawei.com>
	<20231201102703.4134592-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Dec 2023 18:27:03 +0800 Jijie Shao wrote:
> +void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)

drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:69:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   69 | void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)
      | ^
      | static 

-- 
pw-bot: cr

