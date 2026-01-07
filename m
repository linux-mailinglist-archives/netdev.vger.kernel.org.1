Return-Path: <netdev+bounces-247567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C60DCFBD1F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 04:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF6ED3053822
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 03:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AC624DCF9;
	Wed,  7 Jan 2026 03:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TETJILce"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F462459ED;
	Wed,  7 Jan 2026 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767755666; cv=none; b=sNCqh7P3avp9p+iPRRJHMc4YkQlgKdnucsOoL7HYUhdX71ubslEpwsHUn5QuuNdf8Y7TjTBvq3egH5WRTsZyCfsQYiTdBJesYkYWKgI3rp4wG1D8rAQO0O5QrtQzjIAr10s8f0atyUdFzQ85bw3qtcUhrAJKrR2WGjifVwjZSAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767755666; c=relaxed/simple;
	bh=utL2nfz5EoZTvedXTHBJDDuw4SD7O9GvJTYP69jjwmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQGxhF48yItS49l9doc6TxM1gMsg42bHMUEUnhc3lJyG12g3i2ULVkyNypNV0dZj0gvvw0+PoFeqQrImWcOxqOQjko96vJ4XbBWzUyAwosbs2X13fPtkX+1gAa5rGtxxAGWd0ZN4ThoF1zIeb6Z5t5B5bG09EOq+xkGtIdXpaBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TETJILce; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OragN944WmsE+e9587xjrYCzr49jdWWwnPtXERoJoAs=;
	b=TETJILceukpWNcQ4CceVU0yy56qe48a8v6SAHhIaTgk6U22pc07PGVXEydFRzqvYX5oX+WLAM
	Dr/ZP3x20ugFg1krzZJR32xL88H06+8XDoPMqt2NBaCat+4Y67dH/tT8wj3Lmj90a304KjUzkzt
	gHy8Rg9tj304HElq2PI8RM4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dmCj60V5BzcbPg;
	Wed,  7 Jan 2026 11:10:50 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A2402016A;
	Wed,  7 Jan 2026 11:14:21 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 7 Jan 2026 11:14:20 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <gongfan1@huawei.com>
CC: <Markus.Elfring@web.de>, <alok.a.tiwari@oracle.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<guoxin09@huawei.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <luoyang82@h-partners.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>, <shijing34@huawei.com>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v09 2/9] hinic3: Add PF management interfaces
Date: Wed, 7 Jan 2026 11:14:13 +0800
Message-ID: <20260107031413.941-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <155d1e55a0ad8f1cef1fd223da28bc39b4ed6abf.1767707500.git.zhuyikai1@h-partners.com>
References: <155d1e55a0ad8f1cef1fd223da28bc39b4ed6abf.1767707500.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> > +static void hinic3_init_mgmt_msg_work(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,
> > +				      struct hinic3_recv_msg *recv_msg)
> > +{
> > +	struct mgmt_msg_handle_work *mgmt_work;
> > +
> > +	mgmt_work = kmalloc(sizeof(*mgmt_work), GFP_KERNEL);
> > +	if (!mgmt_work)
> > +		return;
> > +
> > +	if (recv_msg->msg_len) {
> > +		mgmt_work->msg = kmalloc(recv_msg->msg_len, GFP_KERNEL);
> > +		if (!mgmt_work->msg) {
> > +			kfree(mgmt_work);
> > +			return;
> > +		}
> > +	}
> 
> When recv_msg->msg_len is zero, the above conditional is not taken, leaving
> mgmt_work->msg uninitialized. The work handler later calls kfree() on this
> uninitialized pointer at the "out" label in hinic3_recv_mgmt_msg_work_handler().
> 
> A zero-length message can arrive when seg_len is 0 in hinic3_recv_msg_add_seg(),
> which only validates seg_len > MGMT_SEG_LEN_MAX but does not reject seg_len == 0.
> 
> Should mgmt_work->msg be initialized to NULL before the conditional, or should
> an else clause set it to NULL?

We will address the AI review comments in patch 2/5/8 sooner.

