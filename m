Return-Path: <netdev+bounces-141337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A199BA7DC
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4761C20A61
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15E18A92E;
	Sun,  3 Nov 2024 20:18:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5617C0BE;
	Sun,  3 Nov 2024 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730665095; cv=none; b=pkLMwWzULmX7qYNdRiwx/RN/h5gb3PDz5JYDhDadxh1Kd90kyLnTYfKVPADsS3gm91b5Ma+bn+o5IdtS/HI2pzeRJf5EsFsUwW1breIl4hgqJWc92/qFBnLX3PXL2uzLF1Y2mHsIEP0f7qkZs0oJSzyK7Vg26xuY+WpxCyGWFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730665095; c=relaxed/simple;
	bh=/ciKSopirvkv3bpu9Z0N61Ak7iL4yGd4OdLlW/MVWjs=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZFE5EPICQowrVQ4GRp8A++cJ52HbRmNoF3zkQY3dAESTz1VS1nBqion4yJsk/ehq8BqM2yLvBQifRiHYFqdfyVNEE3UWzf8DdWlYbsiXSBh7jHAZJE/Bb3AhbNg/Bo4QdiDsDzCfGTUqcLHcBLJd1r2/mrSGXTJKFV+ZEpuWoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XhQnt4N8Jz6K5x0;
	Mon,  4 Nov 2024 04:15:30 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FE02140B39;
	Mon,  4 Nov 2024 04:18:09 +0800 (CST)
Received: from GurSIX1 (10.204.106.27) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 3 Nov
 2024 21:17:57 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: 'Andrew Lunn' <andrew@lunn.ch>
CC: 'Jakub Kicinski' <kuba@kernel.org>, "Gongfan (Eric, Chip)"
	<gongfan1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Cai Huoqing
	<cai.huoqing@linux.dev>, "Guoxin (D)" <guoxin09@huawei.com>, shenchenyang
	<shenchenyang1@hisilicon.com>, "zhoushuai (A)" <zhoushuai28@huawei.com>,
	"Wulike (Collin)" <wulike1@huawei.com>, "shijing (A)" <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>
References: <cover.1730290527.git.gur.stavi@huawei.com> <ebb0fefe47c29ffed5af21d6bd39d19c2bcddd9c.1730290527.git.gur.stavi@huawei.com> <20241031193523.09f63a7e@kernel.org> <000001db2dec$10d92680$328b7380$@huawei.com> <661620c5-acdd-43df-8316-da01b0d2f2b3@lunn.ch>
In-Reply-To: <661620c5-acdd-43df-8316-da01b0d2f2b3@lunn.ch>
Subject: RE: [RFC net-next v01 1/1] net: hinic3: Add a driver for Huawei 3rd gen NIC
Date: Sun, 3 Nov 2024 22:17:55 +0200
Message-ID: <000201db2e2d$82ad67d0$88083770$@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbKsTa0xys0oGhWkSQIdOtZx32g7KhpxmAgARHMWOAAA4WcA==
Content-Language: en-us
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 frapeml500005.china.huawei.com (7.182.85.13)

> On Sun, Nov 03, 2024 at 02:29:27PM +0200, Gur Stavi wrote:
> > > On Wed, 30 Oct 2024 14:25:47 +0200 Gur Stavi wrote:
> > > >  50 files changed, 18058 insertions(+)
> > >
> > > 4kLoC is the right ballpark to target for the initial submission.
> > > Please cut this down and submit a minimal driver, then add the
> > > features.
> >
> > Ack.
> > There is indeed code which is not critical to basic Ethernet
> functionality
> > that can be postponed to later.
> >
> > Our HW management infrastructure is rather large and contains 2
> separate
> > mechanisms (cmdq+mbox). While I hope we can trim the driver to a VF-
> only
> > version with no ethtool support that will fit the 10KLoC ballpark, the
> 4KLoC
> > goal is probably unrealistic for a functional driver.
> 
> It is really all about making you code attractive to reviewers. No
> reviewer is likely to have time to review a single 10KLoc patch. A

The minimal work for a functional Ethernet driver when responding to
probe is:
1. Initialize device management
2. Create IO queues using device management
3. Register interrupts
4. Create netdev on top of the io queues
5. Handle TX+RX

At the moment, just our TX+RX code is ~4KLoC.

> reviewer is more likely to look at the code if it is broken up into 15
> smaller patches, each one which can be reviewed in a coffee break

We can obviously break a larger submission into multiple patches if
requested.
But when researching we saw a comment from David that indicated that there
is no advantage in that for initial submissions.
https://lore.kernel.org/netdev/20170817.220343.905568389038615738.davem@dave
mloft.net/
Quote:
"And this is a fine way to add a huge new driver (although not my
personal preference)."

Breaking a 10KLoC submission into a few 4KLcC (or less) patches helps to
review specific patches (and ignore other patches) but all lines still need
to be approved at once so someone must review them.

Breaking 10KLoC into multiple submissions is easier to review and approve
(in parts), but merged code will be non-functional until the last
submission.
It will compile fine, do no harm, and nobody will pick it except for allyes
builds.

> etc. Also, reviewers have interests. I personally have no interest in
> mailbox APIs, actually moving frames around, etc. I want to easily
> find the ethtool code, have you got pause wrong like nearly everybody
> does, are the statistics correctly broken up into the standard groups,

To properly review (error prone) pause it would be better to remove it from
initial submission and add it in a later dedicated submission.

> are you abusing debugfs? Having little patches with good subject lines
> will draw me towards the patches i want to review.
> 
> 10KLoC is still on the large size. Can you throw VF out, it is just a
> plain borring single function device, like the good old e1000e?

VF driver is just like good old e1000e NIC. It is a driver that registers
A single PCI vid:did, "unaware" that its part of SRIOV, and performs the
initialization sequence described above when probed.

> 
> 	Andrew


