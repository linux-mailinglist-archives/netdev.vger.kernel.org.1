Return-Path: <netdev+bounces-60455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B52881F66C
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 10:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0621F2338F
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609E63C9;
	Thu, 28 Dec 2023 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="nINutjcx"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2164.outbound.protection.outlook.com [40.92.63.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0BF6129
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASQGiLmh4trJ4oIuh1yA2MBZC1Q2iv9UMEKgAau9gVTO17Aw2tE7Mt/oAfLk+5I03wAdfgjyUUZlr9b6A9ydELMCQeE/5llQKdAXbRQiYFe+WaLGNZ7rmApYeHtnwtK635M69W/C8eyByrFtQInzag3VJb9wi3nm6tzryQj3C88ppx3NgrKL+3MVZiMBRRng9UDYmRAqjCIfj7etuyYWRWg8a1b2cF3+klY9cV80ZqHPsoBVSBEvEV08Cn4qVsQuT3zVMZofovw03U7tCZqmwm4PlVLZ6aBS0KRnHQXhR9OErdWiSAzDNYyUAg+tSUdICV/8HIxXpnMgV8agivyb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad2Uced7H3dBHvRtC9Dgf5ISCF7MeY1WU9XVO4TbxXk=;
 b=N4IUpn1XFIyc7bnTs2ruxEP381I+WYgBR5v3f/pWUljfyFt3N1TFHcmRfSY8tUXytHM1vOFc/lfN8o7LCEenHGiwJ1voKRasVLXM6D0M6CXqHiQ9sDKFOgZyq5B5ZsM0aDGkMsJ+5HgXsKleSmmD4J25P3wC199FCXiZdyodqWqJ198dA1k5B/X8S33jY39Th+4uKR2jWyujG+v4oXJr6CPuN6yANu8Qc/dThI1GlEseIzfuYTAMRUYvUoi8ql1T5uBZP4os2zORmM4DAW61qCLnadpKeqNeZyVg/kl4oXeHEnWyGsKpEYVeoOMr+vvHWYnAqPO0xKDAQ2K1BVWSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad2Uced7H3dBHvRtC9Dgf5ISCF7MeY1WU9XVO4TbxXk=;
 b=nINutjcxRHDxCZHLUaevVjPvSTJ1jVbtl5XhsCzYCbPJHvv11Wc4nSGokibi3MV+CtL/wPy/pKYShlkd/2fX+zXQhQBMAP8TUQ8qQLtufNhcImhTbjArGesjWg0G4nq9gD/V3pUaT7YhFZqbeJ25vGoLle8kewYie9hOc3BL7pp/MRKu6eqCHmW6K9FoayRnXGsu2/d/uFqHsEBaic5r51K6zIFj5s7aXI+m4P9cOBIEVbJKoSAILC/xN+Kni9k6lc9lyCGd00M2EDrz/6qFHpLJZ8eUTE9F0k4QnKv+hsj9fbebQU39aC2tVDStJ+kxaTW3m7I0h1btVw6YZcD/QA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY4P282MB1497.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 09:44:50 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd%4]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:44:50 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v3 1/3] wwan: core: Add WWAN fastboot port type
Date: Thu, 28 Dec 2023 17:44:09 +0800
Message-ID:
 <MEYP282MB269763F186A848ABA299CD7FBB9EA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228094411.13224-1-songjinjian@hotmail.com>
References: <20231228094411.13224-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [XqYCPA9o3yPYbTtzFvtZ1h6t1i07CMac]
X-ClientProxiedBy: TYCP301CA0040.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::12) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20231228094411.13224-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY4P282MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: 955c367d-9c3a-4001-2770-08dc0789a2bf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MxXqIkgd6GfNfRgvEc5UwbB6yNI/6Mj8DPlcTzTP55LkwPY6lf/L3mbDZPfWgVerZ+GaGM85lC0Kxf7LM+V40DAazQd7hiBTEtaivJeuMgNbLOsw/AB8TtQA8lvT6wZVfO/8W53L74JrvHTeTAZ1cw/guPHO/Iydi3pEDKhMwO4R/RCaMayswCRJEDMRUgZBGthqMwZWhebXS1HjKwludKpt+810aSahL34h9iRrBj4gM7hqMcYAKQ/jPZKymhnF8n2HqYwIps5USJ+NqT/zBasKxcnSEZdA/PmWIohmBM2IuF3O4AD99M3i8/Q3R5NtaG3jpzohWwV/uJ4pJxza02TF7z+SKJaSOHVA82V1KLURJp9HdraBcXdyKNeT1NzPQN7oEj5nqEeK9jNmLQHh8HEyx7KhlwHM2XwBXnbWCTjRKLctu7TWCtCV0ZeXAnAhW35ASK6eeItxiqN5tM02rya/kqFAZHhj04eGMhETBNfWwFv/98d+9k74oVkbas8Bw4vZOcDQ0Tt5oI9gx/369bIF03NiDEkGEgqND3aRdGZKgXEGeGOownEDceZaVnyO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oUUv8panEl7GDJ5sgnBk/RbrnUBZmbyffQKStFwoYyG2JH4UNWqsSzBO8Ko4?=
 =?us-ascii?Q?zvugC8BHM7rvmpq7Mkwwk4pbdVJeNXAa7C2QDfvqmR+uWSAFahX531pYxFz5?=
 =?us-ascii?Q?0O4rys92bUsFsfrjElAz8dbmE53wvsrKiOQnXcofF0CVFVfMwzPzeO/RdSjl?=
 =?us-ascii?Q?elF09BmUsUmzjBx491i9v23b3DsQ5RkLW9ycJ5OnqvTxRvG9I/KaocPakhqC?=
 =?us-ascii?Q?XmDJwDKi8IJJtyg8NgqgcaiQVoKKvzEAsBQro4OvSVLXsmpWPobUmZ9vb/Eu?=
 =?us-ascii?Q?l+5T6vT1QS9PXkW1rj/euJM6OOgu03/5tZAezDrV7E0ROU1mL/BeoK9+XPJ7?=
 =?us-ascii?Q?UJzkvkaFthJhT+CReQebL6HsdSmMnJdKVa8dN+rhXyy7Sdspc3i5vcuJlHcQ?=
 =?us-ascii?Q?NTp3UMu3lNQAPdl5akRQHBxp0MZoqUqTbuxTOrmkEmWiFN/617+S8uSTfTqv?=
 =?us-ascii?Q?6zU/bMop93SyFerNG77byjYG89EWanFPVLtgsepNUlMGo5JiAcZDfPBZZoAV?=
 =?us-ascii?Q?XZYI78+jZ9UmR5M3yzswW+IHtawPalYbKy6XU2wepRSDpPT9lprUpt0PN8FZ?=
 =?us-ascii?Q?JRVNWMY2D8bvzMjWt4dmbpH9E6TUbBMQTSc8dh5d9BYJpv5EkaPRHSz3mgIh?=
 =?us-ascii?Q?Gd2hAEs9nO1Fcefb0CG1LaRb6hCTboZzhF/lD3wq9M3EBfuPrtv8PVmAdLNW?=
 =?us-ascii?Q?hWqdF08zSHKYcOCvE4yD13g8wpDsvIjrOEtcOrnvZ9pWZtvrv/GPSGLe/ZEi?=
 =?us-ascii?Q?FXMpfs6wa4J4SwMYvUw11FFsKaQxQhO+ZiEjF7wyLd1AYGc9vPjLuWUs2/o/?=
 =?us-ascii?Q?wY0K1/typyujLbUXnkgWY3fap5lWhxcqvudJ7/qoDGImn8W0L0W3z3tQLmEH?=
 =?us-ascii?Q?yx2FSnawk9pU+qLaJJ9YXGx378u6IkUNF723JDUrTDGFmWFBfjLNSVrvvBAz?=
 =?us-ascii?Q?3SAFJHXI4ZG/doyvKeHJfpnEep5vGAsQ7gIzjRF5AV8r+drBjMBSMBHjO1iI?=
 =?us-ascii?Q?FAWSZTQFiLUguMmUIqg0VIaUgSHecTOe7+WDl/+90h8OLoZkwT/42gWYCSbe?=
 =?us-ascii?Q?TE8zzcFE6LrO/S18hfqDQ/NS/U2CFfQCoTK3eAlz5wc0yFfL/sQj3zmVXE2J?=
 =?us-ascii?Q?9wlXByh0RWLin0bf3zERoDVRjmQsbuWwkQcw36Orw/DpMWoGRubgjfNo4m4K?=
 =?us-ascii?Q?M9aLAY2YjP0jJC80vCPjRhDc8jRoDPJHWnJmOeEK2xHmNo51v4GEHqTRGDg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 955c367d-9c3a-4001-2770-08dc0789a2bf
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:44:50.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1497

From: Jinjian Song <jinjian.song@fibocom.com>

Add a new WWAN port that connects to the device fastboot protocol
interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v3:
 * no change
v2:
 * no change 
---
 drivers/net/wwan/wwan_core.c | 4 ++++
 include/linux/wwan.h         | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 72e01e550a16..2ed20b20e7fc 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -328,6 +328,10 @@ static const struct {
 		.name = "XMMRPC",
 		.devsuf = "xmmrpc",
 	},
+	[WWAN_PORT_FASTBOOT] = {
+		.name = "FASTBOOT",
+		.devsuf = "fastboot",
+	},
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 01fa15506286..170fdee6339c 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -16,6 +16,7 @@
  * @WWAN_PORT_QCDM: Qcom Modem diagnostic interface
  * @WWAN_PORT_FIREHOSE: XML based command protocol
  * @WWAN_PORT_XMMRPC: Control protocol for Intel XMM modems
+ * @WWAN_PORT_FASTBOOT: Fastboot protocol control
  *
  * @WWAN_PORT_MAX: Highest supported port types
  * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
@@ -28,6 +29,7 @@ enum wwan_port_type {
 	WWAN_PORT_QCDM,
 	WWAN_PORT_FIREHOSE,
 	WWAN_PORT_XMMRPC,
+	WWAN_PORT_FASTBOOT,
 
 	/* Add new port types above this line */
 
-- 
2.34.1


