Return-Path: <netdev+bounces-155862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A72A04134
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500A17A25D0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72481E9B3F;
	Tue,  7 Jan 2025 13:51:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0439FF3;
	Tue,  7 Jan 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257864; cv=none; b=C2+BNgS05Fk/eigVZClW5XpAewkrwLGwURs/ZcKef2KDiCMh7A0wopryf9t/b3kwO8Ax3LGUEB70GDqkq4z/BjU3D9uD11FYck2TRxzPzEcpIAbPY6wB5fC4hqN1h44zPqcasghDq39WIT3B1QAKqLPTZnt0BonH9f+YRDp6JIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257864; c=relaxed/simple;
	bh=v6R+8psuWm2S8FVjNAFp1FwJQEmIC5d0m8nBQCiuZfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIzO6HH7fH8ZabkN965Gpz2geegAAqktJ+0Rh1/fumwmkFRaKtL/95lgzink2sYATiHtfIytNyURkJm5VrFTCxzpwUbv3zfDY4ssUao+kR7XSlfvKa8HWdWfDuFrPemMl1e+fyV53EPhuXbOBdC9VyiDTTrIeudOCqOUnajIr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YSC8t1PCcz6J6bt;
	Tue,  7 Jan 2025 21:49:50 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 00FF31409EA;
	Tue,  7 Jan 2025 21:50:55 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 7 Jan
 2025 14:50:43 +0100
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
Date: Tue, 7 Jan 2025 16:03:42 +0200
Message-ID: <20250107140342.3553459-1-gur.stavi@huawei.com>
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

> >+static int comm_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd,
> >const void *buf_in,
> >+				 u32 in_size, void *buf_out, u32 *out_size)
> >+{
> >+	return hinic3_send_mbox_to_mgmt(hwdev, HINIC3_MOD_COMM, cmd,
> >buf_in,
> >+					in_size, buf_out, out_size, 0);
> >+}
> [Suman] Any reason we need this wrapper? We can directly call hinic3_send_m=
> box_to_mgmt() from hinic3_func_reset()

This wrapper is used frequently (10 times or more) and it reduces number
of parameters from 8 to 6.

> >+

