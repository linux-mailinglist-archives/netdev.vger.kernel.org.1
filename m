Return-Path: <netdev+bounces-130699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D983498B38A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B3FB25E56
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 05:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2871BBBC0;
	Tue,  1 Oct 2024 05:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="BwrtE/jO"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505374E09
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727759448; cv=fail; b=qIViYPKwnCn4k04EPyk0/FwX8oewX1sEBZ3CnYANoMN7AHbY1I9DKyHDwWiFH4x153n1HLtsXU8n9CnBLEVlcfm7FzURJ3Q41uMlpx5kDh/hTcdCDwX2MAvuibGLwMfMVbEPVAe05IKvq+KeZGxevFp0YysV2Q8mj2xnvMRphek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727759448; c=relaxed/simple;
	bh=y0X729ts+z1H5BBKd4E2YWQscZfE1UcpsF72plNUehg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rtZqKKuecshKqbHRRYDaDZKFYwqIbWrdCh42oJUlO5Fe+PGAtz4ni2el7hesnNMfPGf4O0A485zivUiOfo840n3GLa9bdzQ+P3+UJiyhq+uejbzX2jXS7KVs0mKbSCyTh85K5YlKDZ40P9EFIDS7uPh56jlxWFDHTIlkU5iSqsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=BwrtE/jO; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 51F7081147
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 05:10:45 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03lp2232.outbound.protection.outlook.com [104.47.51.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 76614200055;
	Tue,  1 Oct 2024 05:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXlgEDbe1LMmvzBol1zkWswCSS/JTSq8gE6bYCcsviPYcgW2a5uDYWXNZ4BWUBY0QhF0ZsElN+sZBBEMdEY+/5Kf3xApa4a4d600wIF+d4cIWt7das8c0pRcqH/Tvtm1eowUrwB/6iG4q/M9nmeNGcG8IWmWL30URA2vo9f8WoE2DYqpOoK8PFuRqUy8A/VU530oXUp7Mt7BFO47Gj9HvuYp6T4WchRwHdLfePyEjyvP5ddoYm29MqFwLFBhaoaBJwKOHG3rFRU9H3RnC4jZAL/ozDoPOGhckiX5T/mupdYIx73Ndr+ugiurX/WN6cvgDHxkclp73K1uI5tXjxvcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e50ep5GWWGTxLZU8ZWYSMqq16cfMVP8Kf8yRq2LAhNE=;
 b=sF7tfrzffcTmoy9Hl3sB7/u4xcuwNYPi6T0h2939qmNU84+sGQssqLBp/yEkvYhajg9HCv5naHYtxLsXHSuUBikbtuMUndxGqMMeEMaxYLMOk+3fGz56JQalEhzBp/CHP46YuJP83iWu1el1gUl6ZKyv3biZOwgHoYEudVPMarpIuSO3y5Kpt1GOiA/eRQ5aep7nCDjthV6SEO93EOa+iWjOA1GkGdyeVOjzuRcwCW2wxC9fSh1Xe9mkaCoenQnP2U7Ho/jyWu53W/TCEkuid1KoxUqUkSVRmC/FUKc0/VI6zXx/ExQb+Ge354l2JmOANOy0FqVieEW6ZB/P/+umuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e50ep5GWWGTxLZU8ZWYSMqq16cfMVP8Kf8yRq2LAhNE=;
 b=BwrtE/jOspubXvMpb8KpQ2dEtN4vKxGf/8fGkLU0NFxWydN4tGY4/L5NqXPR8tFmUm+TF2VQ/4qfR8z6pFl9vF83aaRmtM1JwZ02PYxXLTEYUMeIt30BbZGVe0lUPZLWqMdQHzFNZe4TFIf2SdnWIJgPVtRKK5euWHqQdnxYlyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by VI0PR08MB10425.eurprd08.prod.outlook.com (2603:10a6:800:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 05:10:34 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 05:10:34 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next 1/2] Convert neighbour-table to use hlist
Date: Tue,  1 Oct 2024 05:09:56 +0000
Message-ID: <20241001050959.1799151-2-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241001050959.1799151-1-gnaaman@drivenets.com>
References: <20241001050959.1799151-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0042.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::30)
 To DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|VI0PR08MB10425:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e1405a-8113-459a-bf0b-08dce1d76156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F143sWF9LZuK8zYwh+O9LVmbG+8X2fQvVu4rgtEr28OmgsXnjHtI9xWbwZe+?=
 =?us-ascii?Q?yBuA/Z+5tqpEiW7UZONwLw5geBCCHiR5wy40GxZMalXCh1+DZSA5TQoOksrJ?=
 =?us-ascii?Q?r9Dloo9BtPaqA0lJo5qDODjO9X7MxpAYYbMH7RuZnsNYrtO+5Z4LGazFFu9M?=
 =?us-ascii?Q?3G0rgCAV8/XvuUEtu8MrvjI/O8sjrYmIYXbUUxDA6i9xhT6DAm4dS1lH+Hcm?=
 =?us-ascii?Q?ddWqJUopk3MMHiUYa+NXMjJ/1zcmW0xutDAle155n+BcSBhGlAPbF4Ml5xeE?=
 =?us-ascii?Q?4EfQjvcDY2Exnin60WD8s2pR670nyIYwy0W99NqKMnmRnXTNSP9fQw9z37kg?=
 =?us-ascii?Q?j59aGozY5PfLkg/tvTn3rf4md6JqGHMUn5fH24LEGS+hzc8lyhr0WWpROE3D?=
 =?us-ascii?Q?+RkoSK41A6ChEmORTXe0h4Z90vJ0gs+iECIgUu5lFgPu2Z1gET8xmNUhJ19w?=
 =?us-ascii?Q?52R4hMFAOHqNYml0NKhlBZBpndoTFSMxtWV1UlLs9oarAOKdjLXmj3RJhaiT?=
 =?us-ascii?Q?4lIaJDxzrH5n6OJ/VIxDzDcfWYQ0Rc0OIcRIguoDoDAshErA9SXmPdbKnjq+?=
 =?us-ascii?Q?0nivbRcnxKGd9IfIs17nXxpWybBCPqaBXP0DJHhzYLsEO8wMMCT3gCMQ3V6I?=
 =?us-ascii?Q?G6dVnmuVT92Dfn75q+BNnsA6QYJOsvAe08XwyXiY/8H8V8+Y2A7+EdmjMBUv?=
 =?us-ascii?Q?Oh0nMq/TZQb5viKZqU+HgV4TfElyCtlW8dNW2i+9GyZEoZVtdpjOYoUpFfGg?=
 =?us-ascii?Q?I4qLX9D5psBolpqrZqvLsr0Zm3OHmjLMc10qLjyP00cVr3WPA95XJAHSmMbc?=
 =?us-ascii?Q?+aZZxy/kpjAYamP4BoYF1Vbv2QwNlNoclnloHEoiO1STYTtUTg8YUhbekNus?=
 =?us-ascii?Q?OCEsjBwBHbexh2SRb0l/eDEcEBtKx4I2t024I0OkdqN5/KsdFoYVfGOkIBC+?=
 =?us-ascii?Q?n+/dGahLmlnFhSdp95VedeuBsUUVY3qB4ztRlhw6wRoLLel8rIHYJVVE2xEx?=
 =?us-ascii?Q?lD6rl+irRTfdmiBaBU3vVBRZfPTNGgmuCSFBI9O00tPZz0JYMqIOGvV6Ro3C?=
 =?us-ascii?Q?aNcYBKTW6NasWu8nMuzYx4oMQHRxF22cQEfWycUXpQZ0jMVkFMz24CHbAEeM?=
 =?us-ascii?Q?Tpi6vME3f+mAvkkwYPh4wpdLvdeNlIBsuEN5BdInGtfMx+PQK6Ls1qFlUeZZ?=
 =?us-ascii?Q?57V/t7wL03l9rfyMugRzInmt1WP/62T9lF28Dk2uW1+CaRSLjwD10a1L+Jrx?=
 =?us-ascii?Q?33zQNLsFvIxz6ORQGs1l0/UB2WME8sbIchmMbinuoylXg/vPxpW9pTmyvmmp?=
 =?us-ascii?Q?+4e1CGbU21EcP51Do98hvnJcM3ZuVElh095SQbJrLexxqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kMzEyyO1Y6tBYZqeCYeLiadLix2HwOv+AnbV/dxFiGO70jyX+IFYeLM4yOx5?=
 =?us-ascii?Q?XeJsMjI/as01K10lgbF8K4WI4tWs/Ic3zLqgclbCKYyFTWw/Oe2vZC2PE6VA?=
 =?us-ascii?Q?JbiicTG1fOCV8i4OvSKjwk7Hto+UQqgcmzlaUjmqsEdeHCkhWoz7ZFL5kC7c?=
 =?us-ascii?Q?fXI4jt9a84fmoZ/ZQvTMxX6FpPqyn6lWwFHZ9tPsggIqJty1hq0+S8gUhoi7?=
 =?us-ascii?Q?FOIsQtQ8TfvEdvBChC0KjW3S3dLirvog5w1HoWbmzHPKCVBonU5b9hMUaTIc?=
 =?us-ascii?Q?Xrn0ubBvYuSePUI0xNAWybN6VK8xdfwpeDP9agzn1V9uFD0HrGFJkIGPFRYh?=
 =?us-ascii?Q?P15ZizNGzXa4uxHNSb1+g4Qc4mn9Z2Wa/rhINPeLz8SRdycMJLszka8WWSbp?=
 =?us-ascii?Q?DwhnNoX65PvNRokxiK95z9KcuTul6/B1VOx9KcXaMEdrEyRYUkgbMtVzq8im?=
 =?us-ascii?Q?7omWcKStSH3uwKLRPZkzvjhOUN4JDYvgbAeOGGiIews9aG39aFMvfkxO0xLo?=
 =?us-ascii?Q?wj/7v/qSih3braLXB1CXdMnRvINlz9Nh2GHB1mnJNPUXC/lJ24ujyDjMU5Mo?=
 =?us-ascii?Q?kHZRZAXZuz8KSq3zjWR6FO0sJXjqUxRgm3yW3eboC4mme0atsDhGQjxEiHxz?=
 =?us-ascii?Q?V5ZM0FRXgMLPJ/xZoRewhYmIPvzDPFPba+Lj1TDGbWGrDF/qNdj5t6mF2HjI?=
 =?us-ascii?Q?LPHPovzq2W1M+IUjCGa8Rshp39VPN8gmNSAXt/MmofgTgI6IzNeC/oae7iiQ?=
 =?us-ascii?Q?huUEVSgQlaiCFnif3ec6oEu97URM5rDVmn/ua7bk7fw80sJKIq/QhOfxezNz?=
 =?us-ascii?Q?VFD7LRmunSlKu07vGhl8nJxDVNe/s1LckDvhUR8pPO9VBysctxFdwDvCckhp?=
 =?us-ascii?Q?gWe8x+UsTouBe7OAXJ58e+rBA74ykQkd7RWipbB/i6q37Os4UL/19bVhvw6c?=
 =?us-ascii?Q?NyktefZxOulaZUBM6FyAlY4S1MO0AX/3nRgLBqfS4skIMU/zRfKhZMRmvd9O?=
 =?us-ascii?Q?gcAXXdfrHGF4mllir5KW7hfwkrR2oe1gN3C9FyrwAHOJcL0INUF3LfompiGG?=
 =?us-ascii?Q?AfE9yDkKhtnLvMq1cA9yiNWhxAq5Q7bOHrC34HmrEKWFCEn5a6yiqqcEX092?=
 =?us-ascii?Q?2w62JHvkBH5g2HLNbSoPXgFIj1rDQPSkj9wXeoOcMfzCAU2PoXTs/BSF0Kqk?=
 =?us-ascii?Q?+FTUG3+60+VMLa5kgWgNT3Gd5vjSDWwtGn+hiOr5WI7X5/bdMVRGSiOd4a32?=
 =?us-ascii?Q?X93/1+7/7XMD3soJLA1KvxnN8iXho/eLr4hlHTrqPdBII+sRC5kSBMayAejA?=
 =?us-ascii?Q?yXM60Wh2ZG8JXUN6Jve4TwSA2uie7mNrNyyem0YFkyTnL4mM9RiXAQ4BK4Mp?=
 =?us-ascii?Q?jGGgnGlRMAd0FFl8LtDXxC5z7n3lTZRci/Egr2jALQE9+8hG0xzeOZ31SJon?=
 =?us-ascii?Q?Uu+SJXyjlgAA76dbe+e3+iybAiBwpPBa2gSIL3HbY+mhnHPFjaEtytQfvVg3?=
 =?us-ascii?Q?AREaQTcjt4PYRcPqgkq/8GjdE75qSjX0LcP6t6eD6FRjpat6H1vQrr/3YNCU?=
 =?us-ascii?Q?q5zhMDKVhEu7npe+veiFF+0SAKusYUi8gJ5yYE55?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BFZHDvScs9EkFVoaIDjOY6AJD742zSWtsDq0ZP9by8cnKsZ7RwFl/T7nofV9hhUNkUZYqhFZQVlhhnD5zKg0XyxheP7mdqpxfE8ZQVfO6CcZlLiPg7KgmusiGTv+IecDUAzE0WjDcqcWGIGWIID3n+XrYyjHdqLVrzTYto5EKwqT+gZ8zshWdnzTcQzr8rxXGNDLQ7gUtHGWD7U5LdBr2fuateWvQgTl7H5WWQjVZYtqM99SPiG5bJjaKWtQyEkFzt5eDOkJmw5jg3peYxRKa4qfGtpIoVmqcSMyCPzXLc5aVhfra4U0seUPVGZgEH8SkTNEOqMYWcYaoP+4lYK+Q0isoweTVj8Pj9yPjV/RCiN2vn+PolaGeRNfD4q4XTyqnYU3zeIm3vHepSkFUgs+MceSdv1nbl216gTD1GCEZni91UTdoTHI222eC07yLzJaEEnVSJARC3GRlN9XmqT7QB2lBRKWaIOXz1sSNYdiN/S9g/BMmTXXV53wFHv74+qHsLCWV7JqeKKntMmdsEOFmL2OsGLnWMkh7UR+v1ECEZ6aTdluwE2HdwSAphzbwD7/48E8Aw17JmX237RuJBEhUjr5lpUs6mC1uWBYmAcK89dAkrLndK4vvq6oQcujTIC1
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e1405a-8113-459a-bf0b-08dce1d76156
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:10:34.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peItge4yW48Bblg/jQaNAPUFmaG75eAN5/JiH6s+nwEh4s29ul1dQBEaz2lCHFEkMOz3TYY8uqnMsAvzmM7a6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10425
X-MDID: 1727759437-wALqAKVYlzm8
X-MDID-O:
 eu1;ams;1727759437;wALqAKVYlzm8;<gnaaman@drivenets.com>;18cd01b0b368a0fec4275fdb61cf0c87

Use doubly-linked instead of singly-linked list when linking neighbours,
so that it is possible to remove neighbours without traversing the
entire table.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |   8 +--
 net/core/neighbour.c    | 123 ++++++++++++++--------------------------
 2 files changed, 45 insertions(+), 86 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index a44f262a7384..77a4aa53aecb 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -135,7 +135,7 @@ struct neigh_statistics {
 #define NEIGH_CACHE_STAT_INC(tbl, field) this_cpu_inc((tbl)->stats->field)
 
 struct neighbour {
-	struct neighbour __rcu	*next;
+	struct hlist_node __rcu list;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -190,7 +190,7 @@ struct pneigh_entry {
 #define NEIGH_NUM_HASH_RND	4
 
 struct neigh_hash_table {
-	struct neighbour __rcu	**hash_buckets;
+	struct hlist_head __rcu	*hash_buckets;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
 	struct rcu_head		rcu;
@@ -304,9 +304,9 @@ static inline struct neighbour *___neigh_lookup_noref(
 	u32 hash_val;
 
 	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
-	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
+	for (n = (struct neighbour *)rcu_dereference(nht->hash_buckets[hash_val].first);
 	     n != NULL;
-	     n = rcu_dereference(n->next)) {
+	     n = (struct neighbour *)rcu_dereference(n->list.next)) {
 		if (n->dev == dev && key_eq(n, pkey))
 			return n;
 	}
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 77b819cd995b..5b48ed1fdcf0 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -37,6 +37,7 @@
 #include <linux/string.h>
 #include <linux/log2.h>
 #include <linux/inetdevice.h>
+#include <linux/rculist.h>
 #include <net/addrconf.h>
 
 #include <trace/events/neigh.h>
@@ -205,18 +206,13 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 	}
 }
 
-static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
-		      struct neigh_table *tbl)
+static bool neigh_del(struct neighbour *n, struct neigh_table *tbl)
 {
 	bool retval = false;
 
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
-		struct neighbour *neigh;
-
-		neigh = rcu_dereference_protected(n->next,
-						  lockdep_is_held(&tbl->lock));
-		rcu_assign_pointer(*np, neigh);
+		hlist_del_rcu(&n->list);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -228,25 +224,7 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 
 bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
 {
-	struct neigh_hash_table *nht;
-	void *pkey = ndel->primary_key;
-	u32 hash_val;
-	struct neighbour *n;
-	struct neighbour __rcu **np;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
-	hash_val = tbl->hash(pkey, ndel->dev, nht->hash_rnd);
-	hash_val = hash_val >> (32 - nht->hash_shift);
-
-	np = &nht->hash_buckets[hash_val];
-	while ((n = rcu_dereference_protected(*np,
-					      lockdep_is_held(&tbl->lock)))) {
-		if (n == ndel)
-			return neigh_del(n, np, tbl);
-		np = &n->next;
-	}
-	return false;
+	return neigh_del(ndel, tbl);
 }
 
 static int neigh_forced_gc(struct neigh_table *tbl)
@@ -388,21 +366,20 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
 		struct neighbour *n;
-		struct neighbour __rcu **np = &nht->hash_buckets[i];
+		struct neighbour __rcu **np =
+			(struct neighbour __rcu **)&nht->hash_buckets[i].first;
 
 		while ((n = rcu_dereference_protected(*np,
 					lockdep_is_held(&tbl->lock))) != NULL) {
 			if (dev && n->dev != dev) {
-				np = &n->next;
+				np = (struct neighbour __rcu **)&n->list.next;
 				continue;
 			}
 			if (skip_perm && n->nud_state & NUD_PERMANENT) {
-				np = &n->next;
+				np = (struct neighbour __rcu **)&n->list.next;
 				continue;
 			}
-			rcu_assign_pointer(*np,
-				   rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+			hlist_del_rcu(&n->list);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
 			neigh_mark_dead(n);
@@ -530,9 +507,9 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
-	size_t size = (1 << shift) * sizeof(struct neighbour *);
+	size_t size = (1 << shift) * sizeof(struct hlist_head);
 	struct neigh_hash_table *ret;
-	struct neighbour __rcu **buckets;
+	struct hlist_head __rcu *buckets;
 	int i;
 
 	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
@@ -541,7 +518,7 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 	if (size <= PAGE_SIZE) {
 		buckets = kzalloc(size, GFP_ATOMIC);
 	} else {
-		buckets = (struct neighbour __rcu **)
+		buckets = (struct hlist_head __rcu *)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
 		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
@@ -562,8 +539,8 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 	struct neigh_hash_table *nht = container_of(head,
 						    struct neigh_hash_table,
 						    rcu);
-	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets = nht->hash_buckets;
+	size_t size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
+	struct hlist_head __rcu *buckets = nht->hash_buckets;
 
 	if (size <= PAGE_SIZE) {
 		kfree(buckets);
@@ -591,22 +568,18 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
 		struct neighbour *n, *next;
 
-		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
-						   lockdep_is_held(&tbl->lock));
+		for (n = (struct neighbour *)
+			rcu_dereference_protected(old_nht->hash_buckets[i].first,
+						  lockdep_is_held(&tbl->lock));
 		     n != NULL;
 		     n = next) {
 			hash = tbl->hash(n->primary_key, n->dev,
 					 new_nht->hash_rnd);
 
 			hash >>= (32 - new_nht->hash_shift);
-			next = rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock));
-
-			rcu_assign_pointer(n->next,
-					   rcu_dereference_protected(
-						new_nht->hash_buckets[hash],
-						lockdep_is_held(&tbl->lock)));
-			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
+			next = (struct neighbour *)hlist_next_rcu(&n->list);
+			hlist_del_rcu(&n->list);
+			hlist_add_head_rcu(&n->list, &new_nht->hash_buckets[hash]);
 		}
 	}
 
@@ -693,11 +666,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		goto out_tbl_unlock;
 	}
 
-	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
-					    lockdep_is_held(&tbl->lock));
-	     n1 != NULL;
-	     n1 = rcu_dereference_protected(n1->next,
-			lockdep_is_held(&tbl->lock))) {
+	hlist_for_each_entry_rcu(n1,
+				 &nht->hash_buckets[hash_val],
+				 list,
+				 lockdep_is_held(&tbl->lock)) {
 		if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
 			if (want_ref)
 				neigh_hold(n1);
@@ -713,10 +685,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		list_add_tail(&n->managed_list, &n->tbl->managed_list);
 	if (want_ref)
 		neigh_hold(n);
-	rcu_assign_pointer(n->next,
-			   rcu_dereference_protected(nht->hash_buckets[hash_val],
-						     lockdep_is_held(&tbl->lock)));
-	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
+	hlist_add_head_rcu(&n->list, &nht->hash_buckets[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -976,7 +945,7 @@ static void neigh_periodic_work(struct work_struct *work)
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
-		np = &nht->hash_buckets[i];
+		np = (struct neighbour __rcu **)&nht->hash_buckets[i].first;
 
 		while ((n = rcu_dereference_protected(*np,
 				lockdep_is_held(&tbl->lock))) != NULL) {
@@ -999,9 +968,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->list);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -1010,7 +977,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			write_unlock(&n->lock);
 
 next_elt:
-			np = &n->next;
+			np = (struct neighbour __rcu **)&n->list.next;
 		}
 		/*
 		 * It's fine to release lock here, even if hash table
@@ -2728,9 +2695,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	for (h = s_h; h < (1 << nht->hash_shift); h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = rcu_dereference(nht->hash_buckets[h]), idx = 0;
-		     n != NULL;
-		     n = rcu_dereference(n->next)) {
+		hlist_for_each_entry_rcu(n, &nht->hash_buckets[h], list) {
 			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -3097,9 +3062,7 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
 
-		for (n = rcu_dereference(nht->hash_buckets[chain]);
-		     n != NULL;
-		     n = rcu_dereference(n->next))
+		hlist_for_each_entry_rcu(n, &nht->hash_buckets[chain], list)
 			cb(n, cookie);
 	}
 	read_unlock_bh(&tbl->lock);
@@ -3120,7 +3083,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 		struct neighbour *n;
 		struct neighbour __rcu **np;
 
-		np = &nht->hash_buckets[chain];
+		np = (struct neighbour __rcu **)&nht->hash_buckets[chain].first;
 		while ((n = rcu_dereference_protected(*np,
 					lockdep_is_held(&tbl->lock))) != NULL) {
 			int release;
@@ -3128,12 +3091,10 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 			write_lock(&n->lock);
 			release = cb(n);
 			if (release) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+				hlist_del_rcu(&n->list);
 				neigh_mark_dead(n);
 			} else
-				np = &n->next;
+				np = (struct neighbour __rcu **)&n->list.next;
 			write_unlock(&n->lock);
 			if (release)
 				neigh_cleanup_and_release(n);
@@ -3200,25 +3161,21 @@ static struct neighbour *neigh_get_first(struct seq_file *seq)
 
 	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;
 	for (bucket = 0; bucket < (1 << nht->hash_shift); bucket++) {
-		n = rcu_dereference(nht->hash_buckets[bucket]);
-
-		while (n) {
+		hlist_for_each_entry_rcu(n, &nht->hash_buckets[bucket], list) {
 			if (!net_eq(dev_net(n->dev), net))
-				goto next;
+				continue;
 			if (state->neigh_sub_iter) {
 				loff_t fakep = 0;
 				void *v;
 
 				v = state->neigh_sub_iter(state, n, &fakep);
 				if (!v)
-					goto next;
+					continue;
 			}
 			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
 				break;
 			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
 				break;
-next:
-			n = rcu_dereference(n->next);
 		}
 
 		if (n)
@@ -3242,7 +3199,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 		if (v)
 			return n;
 	}
-	n = rcu_dereference(n->next);
+
+	n = (struct neighbour *)hlist_next_rcu(&n->list);
 
 	while (1) {
 		while (n) {
@@ -3260,7 +3218,8 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
 				break;
 next:
-			n = rcu_dereference(n->next);
+
+			n = (struct neighbour *)hlist_next_rcu(&n->list);
 		}
 
 		if (n)
@@ -3269,7 +3228,7 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 		if (++state->bucket >= (1 << nht->hash_shift))
 			break;
 
-		n = rcu_dereference(nht->hash_buckets[state->bucket]);
+		n = (struct neighbour *)hlist_first_rcu(&nht->hash_buckets[state->bucket]);
 	}
 
 	if (n && pos)
-- 
2.46.0


