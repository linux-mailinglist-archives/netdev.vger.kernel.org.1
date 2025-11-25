Return-Path: <netdev+bounces-241656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF80C87405
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 376194E1889
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE0F27FD6E;
	Tue, 25 Nov 2025 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Bi1X6Qyd";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vBVQWAbF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E41A23B9;
	Tue, 25 Nov 2025 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107188; cv=fail; b=gzD2xxbbkKmnNIQyhUPdaTcmwf38f1tiEUOfIXknD6Pyc1D9vGYHPAQhzEIFb0Q8qia+V2qYD3/ntG1YjdcKOBSqS3rinkVNyZ11wWSZHVKsyhvCcvnfe4w7tAu6doJ6GqMDZVkUOpbeyuCCela52QKUS8dhNa28J/DbH478foI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107188; c=relaxed/simple;
	bh=/jNZwTUcStV2jjGy0uimL7KMvjUdKHyKbGY7vQ+Gu3g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CIA1vgM3sQJ9QDVk7UsCziel3ZK7oiAUCDYCRwrdvvg7bwBvVDnCDBUx1XvlxAgmCUQalvBW0wL5DhcuJLyoDGXlHFIuoWsKF3v29Nn1KpT2jlSJia8xvXqFmKXvNk4mYaF3W9ztEhmIFJvpbVOtZTI1AnhiX8cQpN3dAzBonyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Bi1X6Qyd; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=vBVQWAbF; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APHWukQ1890194;
	Tue, 25 Nov 2025 13:45:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=z/ps9kml07P01
	cojDETOsfAQG5Gozz0gwbKIWzPdAw4=; b=Bi1X6QydpgE9D2Or5iPb2A0hr0qnW
	qdP4xhLxNVmfpps5m3qx46xVwdm1FCzHmVrVqTiRTt8jfHQIdoLq0MljbI/QdgsP
	ro0657MUjv3YmcIGTOdgPCFZbPj5ly7RXU7qgWeQDbk5x6joHhtIgdtswJ8RGTKq
	EN3pZfdVB9X5wlGTPAJwSZYdrfhHDSJKD8ZRSK1Eaf/fowl0BBR+Fvk+yTpUBBk8
	uuITf5nSAwDhSNz1bjJYk8pZ/p8fCSRRERZ4o++Zq4OjGt2UkGk6Hh0oSRXLai2D
	lczZfphC0a9Y2IFyQ0Q4mDo/EwG7M+Qh8DHStT6Dki+6zQ8AkBblgDknQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021104.outbound.protection.outlook.com [40.93.194.104])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4angxyrf09-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 13:45:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSUAFTfECTAwAp128cDDksRhFuu5DsgU77Hz40gM5vkZlmZbtMPXYaKUF6doEJt8VllCsjDoZazjsCR7ZIFa7RvqoiG8s1KTJejPHbY1Tz3TY5s1upnfOL7zEqCguqkJRLhsx9a9wKOrBzSz+cMlfGwMvwx2JloNNTSdqyEWUca4KkK15n4vIM7m60IYN9Oc7ZAo5M4JFMgrLp499SuqR9ogba/uVO6CEpkEt2ItmD6MUkVSO4z0S+inMMWfk5aTkefP6jvGgVKIqsGS+/eKGVycKriCgKzUq9847HdRShQNAfHrdn5Bflhp4iFik5NNVcI2bpX6jzBR1ch+ryHMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/ps9kml07P01cojDETOsfAQG5Gozz0gwbKIWzPdAw4=;
 b=MDYy7weZhynGcHlo/bsbISbEPcoQ5F2gv7UJIBY/O5L51d7bfXk9qeSwJu08IiG6MN1lFkMqlqZ4EIed3shzDWlOB+Zk87hbkAunwZlqcZqS1lvCcW16wLZiEOarYCc2yPxUz+g+s4DalUIu44ue40c/6S8lOU5rf1QvRuy9U5HSlS6W2727uuuL//iRt8WmYAdepxSzkLpteY/MeD5xmoZdSXyuxcT4YnggNSIeSlwuaOPvtAY6VWTGCfA7QqmlJgrGW7JCiaKBZE6D+eRo+v5AqfRjUgCzPlU3xZv7BH4ikT4WKGLDp9B+lfIFBRt8FxMQ2Cf9njAQNHo7OerJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/ps9kml07P01cojDETOsfAQG5Gozz0gwbKIWzPdAw4=;
 b=vBVQWAbF5xfTOpt8DKXdb25yGsEQUa/jUPWo5fX5HNbOncMrz3g6ilHNzICKU1lGbj+if6W0tX4ZN5IXkGH6YfNrNXhTG/NH47Z8Me9Y2os/tgUMHku7QCVbMWE0HgPxIF6pVCZaanaQru5oi3PQFODljDnettd7Oat5EI2EZ/EgAbUVXTrbqltZvluXkr7SaLIXV699ImTzn8S+MIWgilHpSn4I75APnfJ7j4ubBuHDEHehb+/fxJimFIJxiWDpf8E2iuz0Junzyz/3fjzZk09n0U4AhMZi1GiW2ts01eaYN/zxuHu8m0LNRJn/Fewut6Od19Ah8FUpfIRKSUl6WQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by IA1PR02MB9520.namprd02.prod.outlook.com
 (2603:10b6:208:3f5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 21:45:35 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 21:45:35 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net v3] virtio-net: avoid unnecessary checksum calculation on guest RX
Date: Tue, 25 Nov 2025 15:27:53 -0700
Message-ID: <20251125222754.1737443-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0107.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::28) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|IA1PR02MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: a509b292-8fa2-45cd-a197-08de2c6bf757
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jRMF+DQEeWZg0dQD9Js4NKIgGYjJ/PVXj6P+os8qKI31WEVPWs3q9krVtPPQ?=
 =?us-ascii?Q?fRRI9y3cmRjif9AXBgbLYCGPotBanvjKL/RgtdTn/kCZ06A6NKkoT9XGPWgY?=
 =?us-ascii?Q?4HTjUUByyOrNjyJvq+91OtaWiPiqT06HYnbw3ZBK9Egej2YT7DBjej/X59UA?=
 =?us-ascii?Q?IualMGVk7bmQv/O65TqEoHFyTGWy2lUg4mtKwSilM2+a/xG+HoqaRJSWayWo?=
 =?us-ascii?Q?sJh8dgRBDunZHQF+v59YtNc5ahy8NQEydgDawdPIrmmoaCtKjReTs5ho4Tfu?=
 =?us-ascii?Q?KOLubkyjNtIShBia3ghboKgFHybxpZp1O2B624NknlNDSw1G3W9QNc8r/hMF?=
 =?us-ascii?Q?w7QW/nTdn8U1bErzziHdBinegx5u/U6KRB7zfL5EWdwrVW9mV9kBroGAUEvY?=
 =?us-ascii?Q?loYeLUPoJOaga0LYLypS+aDUHfzn7mToWa+D1k1XTV5NPzMo1I/266sRNUkY?=
 =?us-ascii?Q?RzI/UFDfAS4ha2GyqF0g1yoi5rHtW+mlMI2mRb5yWjCVmI+Ir+wRIM1IuDXV?=
 =?us-ascii?Q?cB4ZMztqI4JbMlFKdn6uSustu1f6TRAoDbDIWX+Dct6f8LxcwLqDWFNpTIRi?=
 =?us-ascii?Q?87alClcsvrxp3D4gp9hIWL47g2boiB2M9ZEDWLa5OmMLsZbRJQKK88mTueqb?=
 =?us-ascii?Q?hgR0RPlsGS1FHbqmPZOjdDwE0qW1HsNOQT4CmBkHMhWlK0TQZv6DaaWvfhZS?=
 =?us-ascii?Q?H3GuNMPBqOuQ6yPlKV6kEqgl2A/aoiY71+vGcHvLDLcRMjH1Ws4OfRWfdyX3?=
 =?us-ascii?Q?5Yg6KneErxO9yEVb6obbxH0Xmsqx4RIYpz8AoO170Pj+ta6SnEckztjqSMIB?=
 =?us-ascii?Q?+AyuMIaSMtrHtvr/x3L3wDEwQbVa4Wpktir1QZ0Pu/B26bhhSwkJqmM1GAxn?=
 =?us-ascii?Q?Ac4JDkUe/UDKew4YhVwpeK5PN4FDR+q5wEMYCpXAcgA/0Rbz0RPahdkPSPQz?=
 =?us-ascii?Q?sBYir5YOxTTSPwkp0s4dPZ1dRhwjJwOr3+nRF8j1GeiedCWm5Z/cU976W6ZI?=
 =?us-ascii?Q?PqZza2kcA/nCBKM/7N/01YyjkWBc/xbqbZntKGSlqXg8BHOvPx2jXNCHS8nm?=
 =?us-ascii?Q?SnzFpS24Fi6s89MgWDKs9ZJ4YIgHEtWV44oVsXbt7Y1JnbZg+en+wNSoTCK9?=
 =?us-ascii?Q?Otj9ZP2pYqTmUwdFojO1qZ4RibpPHELvybKyshxio+fSWiPAVUlJ8sRsAtXA?=
 =?us-ascii?Q?qKPpw6yqJ2VkwLuCl8IPm6AdGkOM2+Ce4qeWxQ4xDI355KHXPaXTvQ4EeGlY?=
 =?us-ascii?Q?XqAVw2mXBXF1rsvR2A5R3R7RhbCTRD7iqx6qLNIUV69/qJPps6r6bJAHUquo?=
 =?us-ascii?Q?uMU5xlCqpJ/WSer8vqT9688a9vqBgalUTpqu5nNzES420ZZRpvzI5sLqyeVP?=
 =?us-ascii?Q?UXpacdfi8hMZXqRPjk7Ms1/NSRQV7XSO2KbsQvstBsGSpbFKFdOMkzY2WrKV?=
 =?us-ascii?Q?H+jNFH85XrqRSx8YJzohmOylBv4NCm/oxNKeagfu5tTfifcd/T1JL8oiUGld?=
 =?us-ascii?Q?WCqWMjFIwRjEfiJ8xNpMttqTbIQzgjqzxGy4u2e0S+7MKBXP50RsmnJG5A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a0o+A9a5dqUwCG9AGVezIYQ4fpFo/XAdNoGTpmx+qr3ESQTWVUbZS4aGeXEo?=
 =?us-ascii?Q?vq2EQwRVsXZ1nQqUVWtZNpcq2DgyCBdEXPJfh9X/BEa4G9t2tPzGd3lnonxP?=
 =?us-ascii?Q?W02LHkE9exDxchloMj5TSwtrcaktcyhpfBt5h6SXjOq2EGdFrc4x3a6u3riF?=
 =?us-ascii?Q?OVme4s6QvtZCWmYx5UqoWieaoRFme/nh6SJlqlEXx+rkuXIhqUtL8XKJatzn?=
 =?us-ascii?Q?gnSUgCHPkknPeuTPR5GKV2VGmbjFzTjhzFWIdP9vd3PrsW6IwoeBLqPVBbqH?=
 =?us-ascii?Q?5O3yoZNXwdaNMrBwCOjDA+cE2a3sgg0xyjbspGp1b478bGIdokgk4o8tcIJ9?=
 =?us-ascii?Q?VtEmGSn8Zb54CcMgvln0dSeuWlPVtWUmrl9VnDz+FPYfIZvyEjPavf2MRaGN?=
 =?us-ascii?Q?tOuB7fDhi9nDQ9SMr0Gmlqw6nRkLgWluFwasqPm4LU5w1lr1QCk6qle1hCsG?=
 =?us-ascii?Q?Il2JTS95FIkg2fDdcb+wGaXdqXqgxkleaRvDfVLa6eUTYWXeilzQ3IxjB4vN?=
 =?us-ascii?Q?+loZINVVJZlX6EDjXlFr1ms0pkOdHzxtHi8XMb3uxHGBqLbdVnNwvMZsF4Ya?=
 =?us-ascii?Q?04UrSEQIXPPmTd/03JWzWq6+/2rxfuh2/u4Ncfz9pGIyioIZ0nyEkxKo3DTS?=
 =?us-ascii?Q?afA6hELdkxWRn4QZz+k74SDumO/e73hdpkQOnVt+plp6zDE9lse+ShzmbBDd?=
 =?us-ascii?Q?OEWA3Cd4zDtakvisFsKY56mn52HWc0JFGTK+++/MvQGFNNpX/aLVABzfzJFR?=
 =?us-ascii?Q?tNCPJK5n3l4RWpz3rbsBEtnuOTRQi6hjZto7ntZzukxakKCYCfBvVOx73+uS?=
 =?us-ascii?Q?YdAbIEERu0odp7IM2zZCZDSGwUwEWIutpwieZUSKYERwRoZG5UP1cybt/svj?=
 =?us-ascii?Q?oXiZVTBDVGiu/ROtaemqphPJk4Pe+BZ676QHiSVMSru41+yCzpGzoIiRanU3?=
 =?us-ascii?Q?55tO7XAhEkA6qPoptBF1sRi/3S2KTBokIP6SP10vooF53z6mkGdhMjEQ8Xwb?=
 =?us-ascii?Q?YhBv35JW3m54Ds9BTwQW/4ZCOxjp68kFcDmLCrvemAABa/Wqvek/51W6/b5A?=
 =?us-ascii?Q?T7mHcL1OFKYfQTZwCCafiYiHy6OBpPIfQQ34GXF8LmEQIEnq2s069XSIpJeW?=
 =?us-ascii?Q?ZGX2DRPSYn/kIrNZET17OKUE1D2ak/f+mRSGb6vCEmfQVjH9Pna497fhNoIP?=
 =?us-ascii?Q?cZqPcRkrJvJX5fXHhQnVd0yyfu6fyM+WhgIc2pMF4RqWMapp8ScjYTzXuPfa?=
 =?us-ascii?Q?EY9p6aWTrGUYpFp23GL32gY36IgYdjOB1Pobcukz9wdRqSzfx1nihBs3o6F+?=
 =?us-ascii?Q?X+w6vFHVcBnQuWNBBTWb1EZqHlScpnLDWey9r5IWyRpYlC3QWmGDARJijg7K?=
 =?us-ascii?Q?M1GDeeLUdTWJ0t2jOmwqPFbKNKL4omxGaSsuhXA8QpomqgmwB3Y24bLJDTP3?=
 =?us-ascii?Q?JPVZmiz99BISC8YiNVc/VdLIXYcQ1yXkqxVrNr+2TsxR2juCL6FytUdRefMR?=
 =?us-ascii?Q?zPSEs1aKqzLz9G+JgHwBXEqTWkPeeVXj97I97UAapcCJ5mNnNNSPQgqvsGb6?=
 =?us-ascii?Q?Q7Z0TRVtFBOctD2ATBT4owbtY1kBuqaE41dbWftYGgEhh1MDrtjHu4JpQTNy?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a509b292-8fa2-45cd-a197-08de2c6bf757
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 21:45:35.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPo4dTwLSv2s5tzTmf1qFLayYObHYiOyN2fXEry+4IIGL9BzHeKPZrPez/HTaDPkg6S6dqTXfX2QsR/gIkN/Zt3Qq/1f3BL5m3EDKGfa5KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9520
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE4MSBTYWx0ZWRfX5z6mJnzZj7mc
 S6+IVvYWrV/3t9gN9+KLN21Ag0uqqUGGduHxrShYzzTahMUvdg+ni09dJJh6iNzqpC0syparEfp
 LvQ/Y4955qERGeABvQFoX3m9tCvgG4i2UuODEwjwqlWpQqsUrUyDdGxxj5fMVm5qUZPb8/evWHo
 QAM85V7prYxegQ7e1U4ckvnUB9vW9SElJvr0C5UCq2fw1LwkNHGJTlib5fjhPOMRxtJ7iWDoh9L
 WA6aOklXqq5hYnbVuSvGOuL9AeXSA0wslFYhD/MaRJGI5cMp6Kvlk3kWvkB4njO6UYXvr4KQXTq
 C2Lp+1qm1Ag21ERxdo73A8ZC7rfWnr7CYS0Ndu4o/kvuDRUkxwveXwKu+vo/0/sQRE3i2Tm0Kz7
 lu/eQjMqJ2cckN4os7UaUCS+Lx3mtQ==
X-Proofpoint-ORIG-GUID: GC_vrtTVvidgMSJ1u98LlUaESLPiDUla
X-Proofpoint-GUID: GC_vrtTVvidgMSJ1u98LlUaESLPiDUla
X-Authority-Analysis: v=2.4 cv=BeXVE7t2 c=1 sm=1 tr=0 ts=69262382 cx=c_pps
 a=zDPZN7IXkwPire9PJGhe3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=CJVaotp78blY4fChFuAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
GSO tunneling.") inadvertently altered checksum offload behavior
for guests not using UDP GSO tunneling.

Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
has_data_valid = true to virtio_net_hdr_from_skb.

After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
which passes has_data_valid = false into both call sites.

This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
guests are forced to recalculate checksums unnecessarily.

Restore the previous behavior by ensuring has_data_valid = true is
passed in the !tnl_gso_type case, but only from tun side, as
virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.

Cc: Paolo Abeni <pabeni@redhat.com>
Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
v2-v3: Add net tag (whoops, sorry!)
v1-v2: Add arg to avoid conflict from driver (Paolo) and send to net
       instead of net-next.
 drivers/net/tun_vnet.h     | 2 +-
 drivers/net/virtio_net.c   | 3 ++-
 include/linux/virtio_net.h | 7 ++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 81662328b2c7..a5f93b6c4482 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
 
 	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
 					tun_vnet_is_little_endian(flags),
-					vlan_hlen)) {
+					vlan_hlen, true)) {
 		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cfa006b88688..96f2d2a59003 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3339,7 +3339,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
 
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
-					virtio_is_little_endian(vi->vdev), 0))
+					virtio_is_little_endian(vi->vdev), 0,
+					false))
 		return -EPROTO;
 
 	if (vi->mergeable_rx_bufs)
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index b673c31569f3..75dabb763c65 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -384,7 +384,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
 			    bool tnl_hdr_negotiated,
 			    bool little_endian,
-			    int vlan_hlen)
+			    int vlan_hlen,
+			    bool has_data_valid)
 {
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
 	unsigned int inner_nh, outer_th;
@@ -394,8 +395,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
 						    SKB_GSO_UDP_TUNNEL_CSUM);
 	if (!tnl_gso_type)
-		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
-					       vlan_hlen);
+		return virtio_net_hdr_from_skb(skb, hdr, little_endian,
+					       has_data_valid, vlan_hlen);
 
 	/* Tunnel support not negotiated but skb ask for it. */
 	if (!tnl_hdr_negotiated)
-- 
2.43.0


