Return-Path: <netdev+bounces-141281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C399BA571
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 13:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF7F1F2100D
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E800115E5CA;
	Sun,  3 Nov 2024 12:47:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB2A50;
	Sun,  3 Nov 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730638067; cv=none; b=j3r+kIcyH98Eg9qhz92x5D8xSYH4YraeDy4WAHAhyLkfjnZDs8fwmmublQ3BeUkQ+tWIBXkJ6RHXyZUokLxv2VmUUh9XFeCQWEWU3DYDzxeVsiLcvEfQcFibWC1OGRbDo3pCZICnsTeTmaWyRurBr6IJFuvN+VtJ5pSOXp2KM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730638067; c=relaxed/simple;
	bh=SUH/9qeDJywkSzvKXFuQPnpTfF2TscJ0TEkBuPIKc0Y=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=CP/vvlsWwKVqF3N/eOy67CuzkeyVqa12P+aNM5LAgIy72af+7bRauyv9We2rQ7zBuzszd19qUxjAWcl/mOqcm+hfSisn08w6wUfiIvgw4+zORf+JqgkORN//u/ONo7PWvKSQ3Mw8pQDN0e4l6EvVR2ciy6fZPBzYOu2YqhJ1QJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XhDQj2w8fz67lS1;
	Sun,  3 Nov 2024 20:28:13 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 327131404F5;
	Sun,  3 Nov 2024 20:29:42 +0800 (CST)
Received: from GurSIX1 (10.204.106.27) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 3 Nov
 2024 13:29:29 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: 'Jakub Kicinski' <kuba@kernel.org>
CC: "Gongfan (Eric, Chip)" <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Cai Huoqing
	<cai.huoqing@linux.dev>, "Guoxin (D)" <guoxin09@huawei.com>, shenchenyang
	<shenchenyang1@hisilicon.com>, "zhoushuai (A)" <zhoushuai28@huawei.com>,
	"Wulike (Collin)" <wulike1@huawei.com>, "shijing (A)" <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>
References: <cover.1730290527.git.gur.stavi@huawei.com>	<ebb0fefe47c29ffed5af21d6bd39d19c2bcddd9c.1730290527.git.gur.stavi@huawei.com> <20241031193523.09f63a7e@kernel.org>
In-Reply-To: <20241031193523.09f63a7e@kernel.org>
Subject: RE: [RFC net-next v01 1/1] net: hinic3: Add a driver for Huawei 3rd gen NIC
Date: Sun, 3 Nov 2024 14:29:27 +0200
Message-ID: <000001db2dec$10d92680$328b7380$@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbKsTa0xys0oGhWkSQIdOtZx32g7KhpxmAgAPaQnA=
Content-Language: en-us
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500005.china.huawei.com (7.182.85.13)

> On Wed, 30 Oct 2024 14:25:47 +0200 Gur Stavi wrote:
> >  50 files changed, 18058 insertions(+)
> 
> 4kLoC is the right ballpark to target for the initial submission.
> Please cut this down and submit a minimal driver, then add the
> features.

Ack.
There is indeed code which is not critical to basic Ethernet functionality
that can be postponed to later.

Our HW management infrastructure is rather large and contains 2 separate
mechanisms (cmdq+mbox). While I hope we can trim the driver to a VF-only
version with no ethtool support that will fit the 10KLoC ballpark, the 4KLoC
goal is probably unrealistic for a functional driver.

Is it valid to submit a non-functional kernel module and make it functional
with follow-up submissions? For example:
Submission 1: TX+RX logic
Submission 2: Device management infrastructure
Submission 3: PCI device registration and netdev creation


Some initial submission cases we studied before our submission:

Amazon/ena: 10858 insertions
https://lore.kernel.org/netdev/1470827002-23081-1-git-send-email-netanel@ann
apurnalabs.com/

Microsoft/mana: 6168 insertions
https://lore.kernel.org/netdev/20210416060705.21998-1-decui@microsoft.com/

Huawei/hinic: 12728 insertions
https://lore.kernel.org/netdev/cover.1503330613.git.aviad.krawczyk@huawei.co
m/



