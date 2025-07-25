Return-Path: <netdev+bounces-209931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD3B11581
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 03:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C61CE4325
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 01:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408EA199252;
	Fri, 25 Jul 2025 01:01:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CA1373;
	Fri, 25 Jul 2025 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753405293; cv=none; b=t89Fx4e44jsKwNDnjvw16UHQBQpQm8XQkOuS/HXjkbzFlXl5fE2bf8038ob84ZUjKE/H7h6F8t0QCoTi+BcrfkPY0eHsB3O3jF7PC/8RBfBAEgHmqWhdXt7bMq1rfv5Dbx1to9Nrv39T4BweIC+y8pwDZJinsAa1KBlnI0qEXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753405293; c=relaxed/simple;
	bh=S68IOHF/e0NaShcmphW9LK69DgrIZLy9G7r8GH8JSf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fvnptmtn7tgzqtP7z/1SqqEsZPDuVOsmpdqUZauhv4m2y21bJTY+BS4IQsVCmuZuAwWPBcR7j1BV2l0GXLGo/MQ7+UYuaKEEzK8THMk45RnlNzFEf9h1vjrFBvH1jF7VGEwJfGs5nVqt2485yK4dEfyJwTBdj6oxhDNEiWbthas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bp8bc148hzGq30;
	Fri, 25 Jul 2025 08:57:16 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4280B180B6A;
	Fri, 25 Jul 2025 09:01:27 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Jul 2025 09:01:25 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <gongfan1@huawei.com>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<fuguiming@h-partners.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<vadim.fedorenko@linux.dev>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>,
	<zhuyikai1@h-partners.com>
Subject: [PATCH net-next v11 0/8] net: hinic3: Add a driver for Huawei 3rd gen NIC - management interfaces
Date: Fri, 25 Jul 2025 09:01:18 +0800
Message-ID: <20250725010119.4976-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1753240706.git.zhuyikai1@h-partners.com>
References: <cover.1753240706.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> PATCH 02 V10: https://lore.kernel.org/netdev/cover.1753152592.git.zhuyikai1@h-partners.com
> * Use spin_lock in aeq & ceq events instead of bits ops (Jakub Kicinski)
> * Modify memory barriers comments to explain more clearly (Jakub Kicinski)
>
> PATCH 02 V11:
> * Remove unused cb_state variable (Simon Horman)

Oops. This patch was mistakenly sent and the V10 review comments have not been
fully revised. We will send a new patch after 24 hours.

