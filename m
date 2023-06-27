Return-Path: <netdev+bounces-14346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1A7406D2
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 01:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D0528105D
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 23:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884DC19909;
	Tue, 27 Jun 2023 23:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CC84A27
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 23:22:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20224B3
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 16:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDmcO27T+Zy9KMs00I9ucwgzVeYD6BrJ7QMqCtK5Q/s7DcmUVp3y+qn8FUqkHrkWaLA6JVgleWNtne1bhuYNoZ3ljTW41nBFJoL82Lb3yvlhGd+bBuPwHFhpAT9HcJ643fFTtMVKh0IJWEAuFRdLPCopwtmisv7Il3XsiGDKhrgPz5fFX9jBBsZur5YrtxnFIELy3EtRWtAJgOW5mRNy0tmiGNr1BZxRLfTfJQuHJhKOQFDpwr4sGGufrUYzkjIVMWQ7kek9B8rB13Oeki0d2m/gWJQVegQzvqaoDYK07x7SFr0agHbSBykyTFmqeMD693v7hghC/jek6v5rOokiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGGG3TJAhFeAyuDOKcukmBMnvBQzNRcTr7aaq1gjCn0=;
 b=bZ5usaY37kdoEFz9fAMtivNgpBoBiG4wG3WxApD5VvGQAXL13dwSHGif3zcqDc7hqs4/FcE/y9UYqRs2jhLlhltEESemN89V5V8mntYkiF477cn6pbyPm1s9LtnbSNOI+1pJ+5sAre8A1rabLCzs+TJn59OTP1HFzD5MeTCr4OT3UKBxgZ7+ZdVVoxuI4GPT/Rn1C7MoW5fSBf4YWHy/5B4RTCIqe1ZnSo+qDkP3IJfZa2ocUbguz3QRgjsbgItpkKdfmk5VskziWrmrVsn6pRzvXzWm+DNqolAhIY1wCsLMX7xtssnfhShhaKdQhnasBDjBTy2G7vq8QUqyd348Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGGG3TJAhFeAyuDOKcukmBMnvBQzNRcTr7aaq1gjCn0=;
 b=H4BV1vWKFOuFX1BQMHlkVREZG3yPLFS7fCxIei2aqeNEZNANwR61YcnAm10ya0CQOuIe01rVIJadmtHGCJS9OkENK6YfBRuHqsJIxm+r2qOh2WIpbJsX/3CyM//56zITLUHyBNRigys4N6Y6NDp+fGazj+KzoV7mUy5///AE2S/fr2V7p//R5UgmILXgvAKv1uDagzgnC918RGIuxPUOSKbpwHwE82Se0//xPAwujh6gJ0xf0ysgJG3diLqtHGAwqW0HvYfTKPOiWD1P6FL4qkz+jmEFINpCh6VfvPw1g2c2D05uKGKvDOiwyxUakTZ+98um/a2qzNi18z4x3smIhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 23:22:09 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 23:22:08 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeed@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	lkft-triage@lists.linaro.org,
	"LTP List" <ltp@lists.linux.it>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device attribute invisible when not supported
Date: Tue, 27 Jun 2023 16:21:39 -0700
Message-Id: <20230627232139.213130-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::12) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 80be58d5-a1e0-4bac-4334-08db7765538f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lg+Ma5qwky8S77OMek+qJ5LVy3WHLAq5rLKvSMAqQDU2lj/tvaKSavPuLdezVrMmiOR2P11ok2SMJETKRvYdfrmv/tORiy5ShpZjsCPArUNLqChSbA1Wj7zm4ePBlXnppSnGrdq2RM/L6okKQA8vZ7jTyYphpv7OJfPLesp3pY81CEADNNc47+K8cLhh7uAimYZO6wfr65V/6sFTr7KFO09hNSIdiMXtFH2OS9HXP6/Kl22pulPuibzTWPKNF8PaUp9S84DfZSPdkyZCW3sHyLjONltFO3nawpNU8/oLUxdXKMVWFBfFZWhuaKQ7TP8WIEPFy2z5ukvKjh6PfoywHfvZVEDYkZU0a0cYtJcSqXlLiDoYr/13Gdnkg0BBhpauYFu/1vaFajWn9+W7DQtJRX3lUs5jTdE3S9J+qwtbKq2vQBtLeWwKECuEVg1V49uQ/mfOdlc8B0BISYJdt7XmCYoO0FO9IPG2+iLcUMUN60GE/ZxPHbiNYxK4Eg2I5QA5ZEdDgqmgnmgeIUnVU5mj9OguCeSxYneQGW75xO9pNIhpn8WLm207WFzpw8UyjaX6Tg6zLDfkJmm2cfjqM5lgosivpAyuii6AE47nNeF0YhO0C5bq6QAhE88Ut20EVf/C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(36756003)(966005)(6666004)(54906003)(1076003)(478600001)(2616005)(83380400001)(186003)(6486002)(2906002)(5660300002)(7416002)(6916009)(66946007)(38100700002)(8676002)(86362001)(316002)(8936002)(41300700001)(4326008)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GayT5f5Wh+WWKnFC0VKF/qb2NaNimENUKzq40Bl9nSboXSD601Z9De5tBLLM?=
 =?us-ascii?Q?/QF8eVBhZ1hzreGFQJETO9XQIOO0QVCNFgf+udr6h1gHKUemUMClG3ZSjZYr?=
 =?us-ascii?Q?AWPcoPB9PiSMqVVbDpPYz+Xj8WLTMAYbyidntz/tMI041dbWSukyxUkx6SAS?=
 =?us-ascii?Q?UwL0Fha8EY7JMqLHTxAYhMavv6/k7CrKlDUJk+CP71iImFqs18WgBa2S/MOi?=
 =?us-ascii?Q?hU6EVWe4dBOQ3QhQmjlqv5UPmXsqNBiV2opn/rnOYmT8c1MXxSHozM4imoYz?=
 =?us-ascii?Q?chtUtRuYQa9dxwYqt0/4ko99Bu/tG4AOeUWCtp0Pao/RZsrdEfRzJQnd73rU?=
 =?us-ascii?Q?M8VgwnRECUcaOrQ9iUmeOM9kWNfb5Tc5qUASAUCajrOF4bjTfdOjC2isnfsV?=
 =?us-ascii?Q?h9/B7mcDmSRZLoTv2Guvs0yv+cg9+X2ZV4e1TipF1S5EzEc+e8Rlbma+Zxrj?=
 =?us-ascii?Q?nzKLx+BE+zgo+1yFWAFLyBtckJfs+MaZ+yC2WTtnX8JjImsgr68gjJpwdOjk?=
 =?us-ascii?Q?S1GK4oa5s7YxZum661AEUr1L4BL39HODMKIQAyMD3IQC3SxQDXfgBFudn9sy?=
 =?us-ascii?Q?c5tK/SQkASEBG3i5c1ndDPwWhNgsG+rJ6ccdRuiw0B9Dv2N3ElAdgP168QLO?=
 =?us-ascii?Q?PDwFjglkdqcaq6+LMJiXdbTnYcJorZjjAzN5I9YbCa0+66GAExfAZr/n7S2J?=
 =?us-ascii?Q?QwpXpMlK6yRmfip1ifv0iIQoH60fhTOnwYdFBqAeKxdTAWQAWIikL+j6PDJp?=
 =?us-ascii?Q?egsue0AAQC0baVLplpb1GIzJ8Zr4wVT+HeL1kXd2dskZoW62sBTuyAWEyi1T?=
 =?us-ascii?Q?89L46tBc0+bXm73dK4urBDkTXtGpwKXdSX14Qsqo+iN3ErGGCmt/Qluf12uc?=
 =?us-ascii?Q?QkBP7polSdF3SaVp2CzqltFdKWj1xy8kfHq1SMmNjTqPvRiHA3eN8DYmibGP?=
 =?us-ascii?Q?WSx7vOmtUVScreerlI+bnj+Qiaor8EO1VKSznaXmwzjk3gSZJmwIt11YBbK6?=
 =?us-ascii?Q?nWAzCTqAri/yIuaGKRZUhVdY11+QEXWSZQfXpnMKlEeh6UZ8PZ3JjzEVnMpS?=
 =?us-ascii?Q?t39wtY9xKkobRo9/rs40lnm+QIcLTQE8HPI1O2pH9B95wqn0f/i7JLEI85yd?=
 =?us-ascii?Q?RWmA8iXO1oWKrQlmRBsCCG7/Vd1suo0ePXudyrpuzp//wNH5DIBC85r6rkmN?=
 =?us-ascii?Q?Rbzawtsh3sks4HMbYT/DyO90OhMXZH7ovJfghJhHyaZ8bq8B6b/oJx6XbXbD?=
 =?us-ascii?Q?RCFRVCxpM6nykp/SvXXFGmessGxi3F3/faAXHGvZflw1V7pS5fMgVGFMm3ID?=
 =?us-ascii?Q?A93OK9xeP6VrHuKnTOzLzsubiiIZaQLGt9q9GQy/J2QINwhSWdcfSCx6smau?=
 =?us-ascii?Q?iHbwY5CdUGWwN1uPeJ2vqNVCnxwzp4wAYgTqXmqe1L6cuxYfXfh7tZq/1O+L?=
 =?us-ascii?Q?gA5xPqSCevEs3uYHhqEEbCZBMRuFh0r74M8d4fvabeN7q5RMF5v7CoE6JZtN?=
 =?us-ascii?Q?IchOsrw2wYnRzHEOJ0eKsduiFr84RKxKMTfMTkd/1UZ0m/BoHdb+qd9Of7Ql?=
 =?us-ascii?Q?mcjozH3gE0GUqPqe2PGxgFCzFQ+fLeq8pwbKbhhjPUGByOPCpUweOadouuGg?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80be58d5-a1e0-4bac-4334-08db7765538f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 23:22:08.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5huhNro4P9Hl+k0CG4K7tUvNSpf2+b3Lb7DiQlBt+H6lPxeFDbO0TTep+m3shLGpXF5RT+dSKWkYfydl0zpuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The .adjphase operation is an operation that is implemented only by certain
PHCs. The sysfs device attribute node for querying the maximum phase
adjustment supported should not be exposed on devices that do not support
.adjphase.

Fixes: c3b60ab7a4df ("ptp: Add .getmaxphase callback to ptp_clock_info")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Link: https://lore.kernel.org/netdev/20230627162146.GA114473@dev-arch.thelio-3990X/
Link: https://lore.kernel.org/all/CA+G9fYtKCZeAUTtwe69iK8Xcz1mOKQzwcy49wd+imZrfj6ifXA@mail.gmail.com/
---
 drivers/ptp/ptp_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 77219cdcd683..6e4d5456a885 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -358,6 +358,9 @@ static umode_t ptp_is_attribute_visible(struct kobject *kobj,
 		   attr == &dev_attr_max_vclocks.attr) {
 		if (ptp->is_virtual_clock)
 			mode = 0;
+	} else if (attr == &dev_attr_max_phase_adjustment.attr) {
+		if (!info->adjphase || !info->getmaxphase)
+			mode = 0;
 	}
 
 	return mode;
-- 
2.40.1


