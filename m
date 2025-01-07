Return-Path: <netdev+bounces-155783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0DFA03BE5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC47E3A462A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F521E47B0;
	Tue,  7 Jan 2025 10:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8021E2606;
	Tue,  7 Jan 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736244633; cv=none; b=RgPdfBMO4CoQnVkLSzjYdeHulNlgv7BlgkTpySAU+YHP7D4+a5aiCeadHzLq6Fk8AeiAM7SmahKWwxWJOTdCfl8f7xqGnRYPtjrbM45H6GQWbOTyrrSMZcLI3WMptNzknvMiKigIHEjEuyNorI0JEyD0/wmr/RvEYEYmLUO/szE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736244633; c=relaxed/simple;
	bh=Mhto81Z6MhtXiGgKkqFllrVaZvgvVjmX68GSIQvAYBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQ+qg7hMQRnq5Y+06G3D3EWQ6DWx1NB52hPdpUsPXY678bL9Yn5TpD3isBb6v+JTCuXzYEXyPCjrEBDX1O4+/VEJYl8WEokvigKZ61f2hO/r3fxq/KhOlORB/gxeOOd4HFWMpZYEe0EbifcU0AphECsdJb7utWy3iqnrxgPOLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YS6Fw0Rpzz6M4X5;
	Tue,  7 Jan 2025 18:08:52 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 343B514038F;
	Tue,  7 Jan 2025 18:10:25 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 7 Jan
 2025 11:10:13 +0100
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
Date: Tue, 7 Jan 2025 12:23:11 +0200
Message-ID: <20250107102311.3552206-1-gur.stavi@huawei.com>
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
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500005.china.huawei.com (7.182.85.13)

> >+static struct hinic3_adev *hinic3_add_one_adev(struct hinic3_hwdev
> >*hwdev,
> >+					       enum hinic3_service_type svc_type)
> >+{
> >+	struct hinic3_adev *hadev;
> >+	const char *svc_name;
> >+	int ret;
> >+
> >+	hadev =3D kzalloc(sizeof(*hadev), GFP_KERNEL);
> >+	if (!hadev)
> >+		return NULL;
> >+
> >+	svc_name =3D hinic3_adev_devices[svc_type].name;
> >+	hadev->adev.name =3D svc_name;
> >+	hadev->adev.id =3D hwdev->dev_id;
> >+	hadev->adev.dev.parent =3D hwdev->dev;
> >+	hadev->adev.dev.release =3D hinic3_comm_adev_release;
> >+	hadev->svc_type =3D svc_type;
> >+	hadev->hwdev =3D hwdev;
> >+
> >+	ret =3D auxiliary_device_init(&hadev->adev);
> >+	if (ret) {
> >+		dev_err(hwdev->dev, "failed init adev %s %u\n",
> >+			svc_name, hwdev->dev_id);
> >+		kfree(hadev);
> >+		return NULL;
> >+	}
> >+
> >+	ret =3D auxiliary_device_add(&hadev->adev);
> >+	if (ret) {
> >+		dev_err(hwdev->dev, "failed to add adev %s %u\n",
> >+			svc_name, hwdev->dev_id);
> >+		auxiliary_device_uninit(&hadev->adev);

> [Suman] memleak for hadev?

No. Calling auxiliary_device_uninit after a successful
auxiliary_device_init will trigger a call to hinic3_comm_adev_release
that releases the memory.

> >+		return NULL;
> >+	}
> >+
> >+	return hadev;
> >+}
> >+

