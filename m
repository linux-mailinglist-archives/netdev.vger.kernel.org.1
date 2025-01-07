Return-Path: <netdev+bounces-155788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCC0A03C48
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893097A28EE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66D11E3DCC;
	Tue,  7 Jan 2025 10:25:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BE1E0B75;
	Tue,  7 Jan 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245508; cv=none; b=JTEBy4wu34BY+7YU5r0QRmuwStpd2YPYBd9KzdI9QEb2lLpU3rHv/L8dXh+yoyDqVn4LhRbj/1iol4+ve56J7deWJpRv5OYvkBmW6FYPn5ntXpK7pdUGCpQuCGxJyKDAfTEjoaHDfzuKZ1gxDwBU/FQqBtFEvlddc8hwHLJ9slw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245508; c=relaxed/simple;
	bh=ZqXullAWF2S1RNd1MTH4kt8y/5h8iwhHoXVIKzff+m0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMDVzV8DUHCiA7zs19hxN+aMH/uQYoZ+aNrpVLjLSZ9+I2Jv1u7IVuPRThje5tP8RyO/QnEZO8BDl3vBrZOL4k8LKx6/2T+qdgIEvrnz0SUYcC53zaRxeCGHs4B7vBBcoa90pKaPTDkQLJi+Vp87BcGG2W/P3F1CnywIJ0yflhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YS6Zn6DMXz6M4WK;
	Tue,  7 Jan 2025 18:23:29 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id F35BE1409EA;
	Tue,  7 Jan 2025 18:25:02 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 7 Jan
 2025 11:24:51 +0100
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
Date: Tue, 7 Jan 2025 12:37:49 +0200
Message-ID: <20250107103749.3552291-1-gur.stavi@huawei.com>
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
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500005.china.huawei.com (7.182.85.13)

> >+enum hinic3_service_type {
> >+	SERVICE_T_NIC =3D 0,
> >+	SERVICE_T_MAX =3D 1,
> >+	/* Only used for interruption resource management, mark the request
> >module */
> >+	SERVICE_T_INTF =3D (1 << 15),

> [Suman] any reason to define a type after _MAX? Does _MAX has some other co=
> nnotation? Also, one generic comment would be to use symmetrical naming con=
> vention like HINIC3_SERVICE_T_NIC or something like that.

The HW supports multiple services. E.g. RoCE. We plan to add support
for some of them them later. The specific service values are used by
HW (e.g. when reporting events) and therefore need to be defined
explicitly. MAX is a SW only value that is used to define array that is
accessed by service index.

We will add a comment for that.

> >+};
>
> ...
>
> >+static bool hinic3_adev_svc_supported(struct hinic3_hwdev *hwdev,
> >+				      enum hinic3_service_type svc_type)
> >+{
> >+	switch (svc_type) {
> >+	case SERVICE_T_NIC:

> [Suman] Are there other SERVICE type which will be introduced later?

Yes. As explained above.

> >+		return hinic3_support_nic(hwdev);
> >+	default:
> >+		break;
> >+	}
> >+
> >+	return false;
> >+}


