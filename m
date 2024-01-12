Return-Path: <netdev+bounces-63252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE582BF87
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270E328790D
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2AE6A01F;
	Fri, 12 Jan 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ei6VDghr"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2142.outbound.protection.outlook.com [40.92.63.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5C67E9E
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0yXyWFv1qwotAzIiXNHFFeaJ1lHZV0i7gu5xR7KxQJv1k5gpzUGvaYLcAJ5X73qTyzaFpyfTlaotQFK3j7fpxLD9l+OPGtN3XrE2k0skAjH3tm9chSw4n2Sd33i8RLSzBD6s/91szs3o4XyjKRZOZTR45TDMe1kgVAXi/7YyW9hl4LfaVnBEy/lw+6E8RZMV7RE/40PPwcPJqctAtifIvFNEi110Fsufc4j8OKkeDWhfwc/oMtCNdHcY08D+xfFAecY11onEYtI9/hEPu31UcX1r6qZYto2baZalBjQsHzMA2tqAy/N6GmDEjWLyuudGbUyySP1TjNNcDfjWTSJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRdTgS5gnznVzvZF5ZycBIMq8pNjJaiqH4oGED2Jhj0=;
 b=JREVe9rnAbZ/pVtl+2olfZqIug4KcPLr1/AFGsj7avF/EvzpjKpt0KFgCBLmjvTf9E/oK4k22y1zF++2rkXOrMDzRicEbWEh+6icqeP+R6+wWDce5TagAzVcP9H3TmeRKpzf8y1QQYPkP2u2wXnbblaVXNniEz7g84XLcGjqWKDWBtvLGQhXgeW6ejJVtBqG95rg2ANP88WpBuG/Atwty5EwRTdDRRfwH8jCdkyRQdgepjf88z2H9d+ZmvRIYZngacUCz+btzD+wMi+4ko2xNxETZ51HHr8uWDV7HBSPN4hK/cWX52vXt52pothqaCYZ/arzwPPiXpMwJd0uMrfteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRdTgS5gnznVzvZF5ZycBIMq8pNjJaiqH4oGED2Jhj0=;
 b=ei6VDghrAMvX9dJIyHUXoHtyq8XIEW6Ad5gCFF2EsnoNplk8/S6dtmdhcb15o2T/zo1Zi9ewZV/jHoxbpG3VK4NLjo/BNOvHRF+trZQQTnoAsJAHe1DC1yvZX2v8P97NPrIFgTrgMvIt3MA4own4v+PTgouj0qwuhiRV8lSjhDzQJiDljp+XZFzqOuR6U5s/QNFaSx7k7PcjlZRtJ9sRe1Ch11duqMWsv/hbtaUWxpoWjWgVENX/kXGOQSpqAJ99734HYNdboC9n3c92D+ovpCjMhzA1no3TRNFUnrOF+Ts0zYEfxwKJgBAY0WKW0HNtW7/wJ8BOX4avEkHFnskeAQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY4P282MB4175.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 12:00:44 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::558b:ab0e:b8b1:8cbd%5]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 12:00:44 +0000
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
Subject: [net-next v4 1/4] wwan: core: Add WWAN fastboot port type
Date: Fri, 12 Jan 2024 20:00:11 +0800
Message-ID:
 <MEYP282MB269748C6BD0F44E64D444F92BB6F2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112120014.3917-1-songjinjian@hotmail.com>
References: <20240112120014.3917-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [O/8TlOoefPNZIH4gG/X4QJzwOHcKj6yd]
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240112120014.3917-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY4P282MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a792a4-1e4b-42d9-e7d1-08dc13661ad9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3PWT9Q1HOnRmPtzKxFb4RHhwGM39Xgw83svZBpCH0TrM5I3EMfYdYX9YolIRKdePxAzEfnEHtwk35oSOIgXelj0jE10mjIe/EBIOA3zf/azALhjV8Dyha9URNNJiL/auSHkpVxbIznYxQMr2S4AmWEm4LLhCGkB31OJFQwg85WiP8Odd+9zed0zjMBTC6wQ0nStykYYJUTqANmIQSGZCktmIJkdDjiPwlGWyaHI4UkwFpaYx+Sp5GdO/d4/xuXl29plC+b0YT9RoNmL/uNtS/ivY4YcOamYcrdpOwE7AE9gYozWte+et7mh5IDMFlyhVljKQ8OMp0qwef+vqvyZOKv67+uPqaMAKa5kW625PMhxeYRUqQ7zzr1FAC8rXKBVMNBbun7hsJOj6bHaau3s0Tvezm+pm1+uHaDBzOkVNlvOTD33syzGr9AkCvi0DO9xpuQfNvzugc76xkJLMYPRB/K4isnhsoyTF6/QY5fGrA4P54fkoY0QWlS389gN7C3cLD7uDMfhWuNRod4P9y7J+aFVFNlfeH4O6hmNTaHFYz4UByV4MVjU9rlfqFIdJCdZ9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uyJk3hxXpbRnDB0UCazkWBhXs/utamDGbOX6lcatd0N+gse+VRW9DbmwKOqn?=
 =?us-ascii?Q?kpFDdIkOIuuByKnYVIPOgSCirDfVRWUL0lh3lCp9UK7J1Do31tbPJjjn1hmK?=
 =?us-ascii?Q?oxs85HyR+NOC1Qm9GiwA4XNpvc+7oLc9ODoDMfgdEcffX9gcJ3Bc1NKBtUNU?=
 =?us-ascii?Q?LFW8lJ4rm+TmQTLP+DzpecnOSMnqfHsxCBt38CoN7P/2vmRKlngtHYRyNuRK?=
 =?us-ascii?Q?s9jQUBPDwgTs5O6oGYR+YcspVSb/YK/jyGlko13MTt1v8ASX/XXt50wW3XfF?=
 =?us-ascii?Q?MKGfFUSo5NBGRwy39D9ZbPHGGtCuXI8VADGdea7Mynyc5PVpq8TgANaY8kRT?=
 =?us-ascii?Q?bMcxZHcSaGoBdS8zb7mmkZTkyD5KUsdI5R+Ekvpii6Awb6BmUOnH1F3p8UOL?=
 =?us-ascii?Q?CSpyL5Sb1SMzTVZZQP+2Dab7zJwhm9x+wYe6xHuhNmiaBSjcXaJkXot4StLg?=
 =?us-ascii?Q?2m+m9PgDK7ZJCIsdIHgPbL6hwWAHwPeTsbZGcaUTePgzbSS1RpmUoAhE0JGK?=
 =?us-ascii?Q?pHIdI0f2hF3tcqwtho25yT6GM35niVPTJ8PWqo7zMSSixleKEzCN7sqVfqvN?=
 =?us-ascii?Q?3Q3lLw7cU2pFHHpTJN15We1FNJLm85fsAugQbVss4gct2BL6Em8Vvc6ze9IS?=
 =?us-ascii?Q?HLHBgNdL8/f02jYt2LyIPcAN9Zow7tUAl4SoIU/LIIuJD7dsr+A5QydFe0D3?=
 =?us-ascii?Q?nSf7+Hsdt86z5mJNM2QwpBjS3SZyWOizFwHIgR2r/+Ci6mdEU07C1l5e03rv?=
 =?us-ascii?Q?VdeBJloCgDfJRmONtaY+S4p3vyDsUAQ2yegx/bmDvIzl8CTgOueMNVaIOtx8?=
 =?us-ascii?Q?vV3NuPdCkmFkq/wJSrCaYgmdp/fqPtGpuHoWt/A9PK49AphpdyIrT7LgMW4c?=
 =?us-ascii?Q?I04BF0PSYzCC3+G/LMqpIlkT2RAIgggYiSjlJ8/IL2ckmsajhCPM2Xum36X+?=
 =?us-ascii?Q?2tunywuS2gLT9JmcUY7jdohm2oA7pdor3G/fFX6nvJIQbunAdeCJrzo9d2bv?=
 =?us-ascii?Q?8riXJsbSzXJKe+4IzkR0uWg1cwFBmmpzaElabnkb6Dr7jSBLU6n615XBx958?=
 =?us-ascii?Q?EFl6siNu2jdtVzzRRFLjxVHgZ4kALao+HGNWTCApNLvnaqXftHSvkYX45b+p?=
 =?us-ascii?Q?UEyRwSSWa+tYd2s7v1Jt7jvh9+UkL8wVWRZrvZJND7zTt76Ejs8RpBSPVJVr?=
 =?us-ascii?Q?s5LreXw7l2lY8MNdh6fQym5jeZjJnQ7blTkq6SLaGPt5mO1UfsOQzTrrZPQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a792a4-1e4b-42d9-e7d1-08dc13661ad9
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 12:00:44.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4175

From: Jinjian Song <jinjian.song@fibocom.com>

Add a new WWAN port that connects to the device fastboot protocol
interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v4:
 * no change
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


