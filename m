Return-Path: <netdev+bounces-56210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC4780E2B1
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8283BB20E2D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE47481;
	Tue, 12 Dec 2023 03:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWSo+D3s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB856FBC
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 03:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C09BC433C8;
	Tue, 12 Dec 2023 03:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702351284;
	bh=wRPseFsynabFF6ox9cUgnxmV7l2w8DducyuqPfkFGTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hWSo+D3sNzmsjgH0dbI8NyBUQ3biddHYlnS5fa1RbEQJtV3fl42MNBgUvaqgHp9oo
	 QmYoultXA22eYUunYcfYlZiEKjza0Q7XnhvqVU7jEJONnFl5ssOgpRp1o6O3dXCFbR
	 qlYZmXNF1PPVVWOIBMdStUbf6E3gNytZ1Nq/UDAFW7Yy7sFrBgy/4mhyS6aQRXhWGX
	 35eGZHhtYUF46f6u+Z4WfCNkorphg5gfkcyTQOBICnCNXxd0Dk4cb2IR6JrM5AKAtR
	 kxV5o6M3EKWtGx4EzcRKQZsNfVy+YFZLdg63YP9VmGxFKZHvDgM1NMaYO7YNuXrRK9
	 owmsbHG8rIp7g==
Date: Mon, 11 Dec 2023 19:21:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next 5/6] net: hns3: Add support for some CMIS
 transceiver modules
Message-ID: <20231211192122.14da98f0@kernel.org>
In-Reply-To: <20231211020816.69434-6-shaojijie@huawei.com>
References: <20231211020816.69434-1-shaojijie@huawei.com>
	<20231211020816.69434-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 10:08:15 +0800 Jijie Shao wrote:
> Add two more SFF-8024 Identifier Values that according to the standard
> support the Common Management Interface Specification (CMIS) memory map
> so the hns3 driver will be able to dump, parse and print their EEPROM
> contents.This two SFF-8024 Identifier Values are SFF8024_ID_QSFP_DD (0x18)
> and SFF8024_ID_QSFP_PLUS_CMIS (0x1E).

Hm, you don't implement the ethtool get_module_eeprom_by_page op?
I thought for QSFP DD page support was basically required.

