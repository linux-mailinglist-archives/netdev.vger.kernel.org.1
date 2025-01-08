Return-Path: <netdev+bounces-156159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87006A052B4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7581888B62
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 05:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313661A2380;
	Wed,  8 Jan 2025 05:39:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA7D10E4;
	Wed,  8 Jan 2025 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314744; cv=none; b=sc8RthyAKBj+xhHq3rdy2AqUtkNDwr1fDMcc3oGx4jl14DSkl3usWNQsJhy6A1RxKt7shz3n4guIYuFQ/T3qBep7YetsoX7t+RvaSgkgtdhYqtr7ea1qEyIonaBkF5rwVoFCQ+0bz97NyLORxlIJXaY/XYLC2x5KlvVHvS9+N5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314744; c=relaxed/simple;
	bh=W2VOjqzqTsTWPL3loVIZgrsRG44qpu4kshILJ/OXVaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVcdo8au21YPRDQ4mLESpeZ5tZQOPOm7SR2I1INbFIaCH80MExNhVu8K7RxFD6yjhbDWife+CpNOGrcru35bTN8yWWfGitPJYtgKhu3/+idAOSuAlpDCt3D7lAhDJWvg8bLREMCcZsmp298TsPMn6tKGKBde2H9FDVaMS0H7An8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YScBl5hXYz6K5xK;
	Wed,  8 Jan 2025 13:37:51 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id B5B9E140C72;
	Wed,  8 Jan 2025 13:38:58 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 8 Jan
 2025 06:38:47 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: <sumang@marvell.com>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <gur.stavi@huawei.com>, <helgaas@kernel.org>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <meny.yossefi@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: RE: [EXTERNAL] [PATCH net-next v03 1/1] hinic3: module initialization and tx/rx logic
Date: Wed, 8 Jan 2025 07:51:44 +0200
Message-ID: <20250108055144.3556942-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <SJ0PR18MB5216BED17023369322EE4A6ADB152@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <SJ0PR18MB5216BED17023369322EE4A6ADB152@SJ0PR18MB5216.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 frapeml500005.china.huawei.com (7.182.85.13)

> >+static void hinic3_link_status_change(struct net_device *netdev, bool
> >link_status_up)
> >+{
> >+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
> >+
> >+	if (!HINIC3_CHANNEL_RES_VALID(nic_dev))
> >+		return;
> >+
> >+	if (link_status_up) {
> >+		if (netif_carrier_ok(netdev))
> >+			return;
> >+
> >+		nic_dev->link_status_up =3D true;
> >+		netif_carrier_on(netdev);

> [Suman] don't we need to call netif_tx_start_all_queues as well?=20

No, netif_tx_start/stop_all_queues should be called in ndo_open/close.
Carrier status change event does not start/stop tx queues.

> >+		netdev_dbg(netdev, "Link is up\n");
> >+	} else {
> >+		if (!netif_carrier_ok(netdev))
> >+			return;
> >+
> >+		nic_dev->link_status_up =3D false;
> >+		netif_carrier_off(netdev);

> [Suman] don't we need to call netif_tx_stop_all_queues as well?

Same.

> >+		netdev_dbg(netdev, "Link is down\n");
> >+	}
> >+}
> >+

