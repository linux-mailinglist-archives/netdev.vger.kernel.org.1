Return-Path: <netdev+bounces-251830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EWnDBWjcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:57:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE5254C7E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC7C78AAB93
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393A244A735;
	Wed, 21 Jan 2026 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="W89AiRZ6";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="W89AiRZ6"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023111.outbound.protection.outlook.com [40.107.162.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4E829AAEA;
	Wed, 21 Jan 2026 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.111
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988676; cv=fail; b=WUTwJmM3fqDCDukm+97dh8OTLxU9CyYBuav0ohd6vQUDehUud1TRK6na4m06Ds4ybozaQLyp6DUUrDEIiKgMV2tN/lOs3Mc8P5BrO0RRyzdL+KlPMK0km3bZ/EQgEDEiZHjNjyQvVRGdnpJSePIPTHZ1eUJwooVyM03YsLWq04w=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988676; c=relaxed/simple;
	bh=46jYdosa1rtPzXWfMkQQzDyiDrtQXxuBFZesxS0Di7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dhLne74lLGZsbWGr9Kd17m0L/mv21DKL5qql79f5W+feXVVLWx38oXDmkvfkSqZrG9n4FwACGpewK0AntaTKETminOyTDexapyCcSvlBm6cjRsmaDYe5qVLoulRVdBZd2Zdoy5JLDiNz4MpRWqclz99BLpifk4aXcdQCG7hniaY=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=W89AiRZ6; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=W89AiRZ6; arc=fail smtp.client-ip=40.107.162.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WP8pXmQcLQ9JL4os1UdFiVcBS58Fxhawss/Kce4XY19qcMS1lxVmgKO+glJ1tv5MAGrIoFk+CLhkb3UXFahOJTX3wuj3nbIdsvUzLvHsUN+Cr3I79SbbWnvuVYo/s6YKU98xxZ2AQER3dV6AYlSS8HxvjAqlhhaYF4sNUgmDOXh3s+WkU7WlvbAwOPydeMl8TfkLal1Bw28U8W2X9Vj4JrgSq6uaMw7m303snqFlwFmpY8w4GgrCBg3rx3DkspIkomyNqkqomw3aBLJWlm/eN0rTJXhBlET623M9imSO90p8I0Ire0lYi72OWR1fa9cDtsHr82MCZJ7ZNoroEwnr3Q==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46jYdosa1rtPzXWfMkQQzDyiDrtQXxuBFZesxS0Di7w=;
 b=Q+wOexzZ2iiLtQ3Z6gVS3f/yXSqAobpo9wvDozZvBNWB2zIXccmVKE6GWhpVelxgNTj7v7/HXFP/6EzoWPVv1JSigs1l3SpS+GNp5QlzCF9gOzPhVlEtHcgbqNmlNFobpbYJrB5tUrJLCu651CSoTcV1PdTp3+x8/05/7XxItTF3pHPjagGvozverUwOBhvR3YHJntkN0sexV5FyiCEo8G7A+gAWyDz1n1Gxny1VuGCr13AZka9V8hKKNryIu/jPMWSZ8jWXFdv3rxdJ00W9f0pcWoHXrrAEwERf0kWo4PNarcbCclRMyhUCzylh5rLPzV6YMTbGu/hwVYgO+EqNrg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46jYdosa1rtPzXWfMkQQzDyiDrtQXxuBFZesxS0Di7w=;
 b=W89AiRZ6Kwz2gIei4GLRmTGvdDtgRH970mzjfc/+0/EFQ0grNXSQIym1Pqh98azT+wniF3xg1+5Sjj5IseRUQBR8xdzopYxv7XTC3n1ktAdQxn2+YVZ6EZZCHXZUg1Kv9MhsH439Mr6dmRld2Z4l9wbRF46hkNDXuoA3PXWx8HI=
Received: from DUZPR01CA0259.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::7) by VI0PR04MB10709.eurprd04.prod.outlook.com
 (2603:10a6:800:262::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:44:23 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::41) by DUZPR01CA0259.outlook.office365.com
 (2603:10a6:10:4b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 09:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 09:44:22 +0000
Received: from emails-574016-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-30.eu-west-1.compute.internal [10.20.6.30])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 7D4348061F;
	Wed, 21 Jan 2026 09:44:22 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768988662; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=46jYdosa1rtPzXWfMkQQzDyiDrtQXxuBFZesxS0Di7w=;
 b=mfUMRKnakkrh5Junm3/m3jdzUDnTRojvrOi45dGJ3bvS1JErA/4OO3NruCPC7w6fX1653
 urGpt//GsYN4R05qPtJra0i1BfWFBiXR7bpbIdzrz7WmKcRccdybVFRHgq+CHJMWu1WdJyQ
 6gRz9Yv45kf+43VIv3bkrtVH5NVT2bQ=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768988662;
 b=JCg926EIwCzIAllQ2i2HMMJ0gxnpeXszhy2owxkdZQa2KVg9LX5rsALj4PtJ+/CxiLMFS
 CQtumeIlYYk/+gh3VrS1bn8LO7IcL4aKSuVCfp6S5LVYHITHQtFmzrzUwhqMJLnQb8UpMtU
 OPj948wmmTltNV4ppCT9tWUOWszPEXA=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1wS+cXZqWjRyUPo/mO2mKIpYDX3r9QT8CVnhH+zh5O/MfqNnxqQLPq1lnl8N0oqawQ47Z61TnSd6OpOX83/SRqE7QgByiPEHU6x9ROjnUXXnCJ0fwTbW7V2wZvIO54iKiQmL4yTG7iUMLU7mQ+gAmUj6B229aOcxndw5q1V0440N9PhgodutX+Wk4GSUucsZWh/JP4Iaw7wsV5qn7UtxFUgm4Nk2AehTfXTCze8no4k3bCh8fZfx7ng3qsevJXzbNmNf8HPokdpqyS7ivIFKTGuWqZYBEXkWaqdaz3bdpwrCDVnjceNvhwA9DBUdoJgkCttw+T0T1UlwsBHexwmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46jYdosa1rtPzXWfMkQQzDyiDrtQXxuBFZesxS0Di7w=;
 b=jD1g+EhrbAdMMhoi+vO2boxfI8Lp50FZYvhqfj2Ryd7a3kw9Q80DLkWx6dHsDdRJXtfA4UYP1DWlZQ7HFUy18CkzhpYXaDxTfn3ncjmuWFjkqCQR2yx+0SdtR1lRxz/kqpsfJHJfwKwJ0mJywu6InjWTkIWbT6CE8reulL4kEcZ+D6X6I/uMpx7Z/O+2YjrxCO/fZnTU/VhC1vhKgXeIxKa/jI1mTNi/25xkWGkpsaPNIk8f+7cev2909YZe0U7gI/CwaCyr5Xioly7pAAqMpQqB//RGT4j3VcDZFR0xC+POjv0/oHXJYlD1lXuzPPO4t/paHmrSFHoPixqjXsHo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46jYdosa1rtPzXWfMkQQzDyiDrtQXxuBFZesxS0Di7w=;
 b=W89AiRZ6Kwz2gIei4GLRmTGvdDtgRH970mzjfc/+0/EFQ0grNXSQIym1Pqh98azT+wniF3xg1+5Sjj5IseRUQBR8xdzopYxv7XTC3n1ktAdQxn2+YVZ6EZZCHXZUg1Kv9MhsH439Mr6dmRld2Z4l9wbRF46hkNDXuoA3PXWx8HI=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:44:11 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:44:11 +0000
From: Josua Mayer <josua@solid-run.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mikhail Anikin
	<mikhail.anikin@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>, Yazan
 Shhady <yazan.shhady@solid-run.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] net: sfp: support 25G long-range modules (extended
 compliance code 0x3)
Thread-Topic: [PATCH 2/2] net: sfp: support 25G long-range modules (extended
 compliance code 0x3)
Thread-Index: AQHciIPWrdEyCfl1vkmXqYoNtgVQkbVZ4w4AgAKA5gA=
Date: Wed, 21 Jan 2026 09:44:11 +0000
Message-ID: <b42b2f5e-917d-4088-99ad-67214bb288ee@solid-run.com>
References: <20260118-sfp-25g-lr-v1-0-2daf48ffae7f@solid-run.com>
 <20260118-sfp-25g-lr-v1-2-2daf48ffae7f@solid-run.com>
 <20260119113018.48da59a2@kernel.org>
In-Reply-To: <20260119113018.48da59a2@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|DB8PR04MB7193:EE_|DB1PEPF000509F5:EE_|VI0PR04MB10709:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf0e9d6-66fe-4671-b2ee-08de58d1a83a
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZGdwVFZwZktBSFA5VWZ0bFVYVmp5V2hYTXlvcitFR3ZreGRmNlM3eFRZWmJz?=
 =?utf-8?B?bjBzUjhxR3FHTjEySzltUmMyK3pYZThuL3ViR1lCYTlSaFZ6SVFVc002aURs?=
 =?utf-8?B?WFdBR0gxaVRPQW9kUXc3L3g3MWlUS0JzRGJhYjFDeEM1dVY3aUtHcVNsYUZ2?=
 =?utf-8?B?T29CenBRVGhLa0pETzJXWTlZSm1tRitxbWVOWFd2cFA2YUl1VlpQL3V1KzN5?=
 =?utf-8?B?elR6ejJtZTMrS01lZmZuWU4vRHRIUUUwRjVsWDl0aTBTY0lXMkVmOW4yNnh5?=
 =?utf-8?B?cDk1MktlakVMaXBaRlpEeSs4UHdvSEdXM2NsQU9YQyswZFNwRDJPTXJzTnNG?=
 =?utf-8?B?TTNUa2lCWERua1d3R2JPVmdFZnppdzIyY3ZoM3ZaeDV2aXVDa2tGemEwT3NF?=
 =?utf-8?B?TWdQZDZ6T3h1VWpMekh0TjI3RUZ4UnBUN1dQbVEyZ3VEM0xDbjZLVm5RL3dM?=
 =?utf-8?B?cTh6SGYrUjBKaEdIV1o2VjJOWi9rbmhydVk5R1U5RXFTMmtxcjN1YjNiMGly?=
 =?utf-8?B?d2xvNGVLNTNSTlVFTkpUSFA1cTZEUE1US2J0ajBmMWFIRFd3WTRYV096ZzRW?=
 =?utf-8?B?dUxDaG4vVVZObTRQdHh5bnFxSmtMQXNGUDdaWmtqc0QvZXRoNnNXalMzcWZv?=
 =?utf-8?B?TU5aM1hpYXQ5eFYxaURYcnczekFHQnlOMmJEMVpGZkxZdTE5blVVaXBFbnla?=
 =?utf-8?B?ckFrRnlhVFdHcUpmYjA1enBkSnU3eWpEbGdUb2NEcFZRTjlHaDFRbnRXdTFZ?=
 =?utf-8?B?c09vK0xOWHJ6MjFpalhPanBkQTFXd1BiUmwvUmVPdEtwVCtLRUJPVVBjakFk?=
 =?utf-8?B?Y1lDYTNmWEZlcUVseFNOMUJDRnBmT2NxcW0yTU9oVmhmSC9uYUV5elFpRXBF?=
 =?utf-8?B?bFhNcDlWTmY0bW5pakRsTUZKYXd3QjluSmt3cWpML0hUd051dmUyNnYydjFT?=
 =?utf-8?B?dmVmKzQ5V1VUYkJhc0lya1BvTEtLdC9FSHUvVGR5bTRNZVFBTHltdCtkVFZx?=
 =?utf-8?B?SnEyN3czcTBTY1NpNjhjRlpEMURaT284ZWhjTU9kTzV2VGRaQ1M0QTMwUGNl?=
 =?utf-8?B?L3hLNW9iaVhkZE5XWi9VSUxSejhjV1I3TzFCOUYvd3dRN2RjWGg2Q0FKVHlq?=
 =?utf-8?B?RTlCVGNMbytuRUhhWnVONEIyc045UFdQc2Nod3NJdjFaUTRveXBnbDd4N3NB?=
 =?utf-8?B?UkhTUk1qalVKZGFvNFhkRTZtY1Z0RzhHSVhGRzdNKzVQWlVwUU5XdWRMTlFl?=
 =?utf-8?B?dmJYbWJNR1JGVnlWMUxyUU9jUlNpOGpMMzBxblhCY0krcThlYXMyTktiVlU0?=
 =?utf-8?B?d0JONEFPWElIQnVxWktFMkxueTFTY0hoK0lPNFYwc0xvQlNna1pXS0Nldk5k?=
 =?utf-8?B?OE9HOWpSVDVBTjNaRGlQSkpKbEVPV2pKT2U5SEM0b1VxZnkrQXBxVjA2b21L?=
 =?utf-8?B?a2xoT1VlOFJTMG5kQ1pNT2UzdlVoVmRKWU9sSEVYSEdQUzJzb0U1UU9zdGNu?=
 =?utf-8?B?d3RnclIxVkFjajFmbk16TFlrbGk5d1YvMWQyR2l0OGZIK1FPc2k2VXlDbzFJ?=
 =?utf-8?B?eXUzOXlKMFl1VmtTWm5HczRCWlNNem5xQlFHVmdEaU81QUdmZW5FM2c4aytr?=
 =?utf-8?B?Z2o1NGZGUm9GOFpqblorejFNQXU0RWMyY1kxclYrOHIwdnV6V2EzUDg3cmh1?=
 =?utf-8?B?RUg4M2dpTG01N25RYis4b01TT2hldklvTWxpNTFlalRyaVpNakhCWERLc3dB?=
 =?utf-8?B?a2Z5WlRpa0xKYTJzbERLSm5KLzE1OEYraWR0b2plSkpBYkczSzJKUW5zblJJ?=
 =?utf-8?B?K3NCbnNQU3doRnRvakhOQVlhNmdKQm5UTTJYbEd3bC80bkxxN3FsMDJnY2NS?=
 =?utf-8?B?M3ZoSkNJaUhtN3ovVFgxYnlnK1E1alArdlgyUkZncm1sRXBudHVoaHZLdnpr?=
 =?utf-8?B?anR2TUlQc2o1dUVQQ2hKQ2tkcDAvSjkwbVZPQ2k1Y3JBUTdJZGpqY2ZOOUUw?=
 =?utf-8?B?Sk4yNldNMnlXY1hVeXFabEpIeVk0MEwvL3Z2MC8rVkROQndocDlGejRGeGFo?=
 =?utf-8?B?YXFVWGcwYktNUFJEbXcwSm96QnI5TC9iWmdqRkZsT1p4ZmtaOUYxYk5VY29w?=
 =?utf-8?B?OHRneVo2dWRSNmZrNlQ3V25zR1M3SHIvNzIwL1d3cFQxV1l3bFdsQXI3cGlZ?=
 =?utf-8?Q?DTVq5vpVDsU/QvmXOi5dNmA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <319A05937EDFD04389E601EE10BDCC51@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7193
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 618c998e79674589b5881c1ac169b559:solidrun,office365_emails,sent,inline:c67bca4b73802d96899a24b8029f6a91
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	65ef87b8-30e7-4ee8-9fe8-08de58d1a16f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|376014|7416014|36860700013|14060799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTdac253Y0hBSFJuUVBPMGplNzU2N2ZJTWhNcTVNSzNqWTB0MVdkMHQ1YmNh?=
 =?utf-8?B?ZFc1SVN2T1lJWHkyb3k4UUJYNmhjZ3pjZU5IN0lNUFZUTWVUMUowUGRONit6?=
 =?utf-8?B?M3NvWVdVaGVhWkwxVTEzMjUyeExiaXpXZnZMclNIdFZsa3RvcWdnbHJlRXBj?=
 =?utf-8?B?SWpKL3dOdllWK3I3VFpBcHJNb2NHMFhsMkhBai8vYkhNM1NzQVp0Uk9sQjBL?=
 =?utf-8?B?WlJGMExicmxiQWt2Vm5qZWNVMGNINVFrejAxOGdyRXUrUTFTMkx0QWNwWjdI?=
 =?utf-8?B?RVNsQ01PbTZ5NHFxeUJjcXBQVWZOYStZTXV4N0VCcVlueUg4OGxxNDIzNnoy?=
 =?utf-8?B?Z2xwWUlLZGRFWG56bmNpaC8vSDludTNTTkZkYWpndnBCNHNHVS9PTEtSSGJs?=
 =?utf-8?B?QkRPZlRVQnhuOGh0U0o1eEllNlpGTzBpLy9NZlN5OE9xQ2pqZHV0NmhaS0c1?=
 =?utf-8?B?bENwZThKUlBUU1c1VWk2VzZHTUVydnp4VGhDb0E5elBZcXVZemJZRWdGOFJi?=
 =?utf-8?B?YXhra09yZ3BKRGNaNG42ckxQbnppak5oY3VGSXRvTlY4Zkc3MFMyR2lNaG1J?=
 =?utf-8?B?Z2lHejQzbUx6OUM3UHk2elRINk5ld0tYMlpUM1hIZEZWWGxGbXBRQWtpT0tN?=
 =?utf-8?B?SG1KOCsyRmdpbU1XcHBrc25wY2VqSFJBaXhtTDBhS2h4NUxsR2VGZ0J2Yjg0?=
 =?utf-8?B?eXEyc05ieUhKczcwQTBsN2tPT3N3cEdPa3V1S0xmYlU3N0Nia1BTSzdhdzVu?=
 =?utf-8?B?YlVZak1XUGV2SFpDQ000SUttVDZnek1VM0JORUdqWmQ2cjZsd2VTTlJrTDVQ?=
 =?utf-8?B?KzZZc1VSQVlNV1huZ2xwMEdHcUZ0MlRoZEUyZ0VNT3J3RVp3blZ0WVl4VnRa?=
 =?utf-8?B?UE5jRVYvRDB4ZzdhRDNFY2NnMFRUVEdqeWVqejdKUndsZlJqUG1JQkdsTk0r?=
 =?utf-8?B?SlBMeVNHTTNmU1llbHJQY2pZQktYbHVNNGxrd1lYeGFxcFZoRDBaOGV4TUdy?=
 =?utf-8?B?VmhnUEtmSUZkdHk0UzVybjVlTE5nSWZOQmtkcm0zU2xTSmV6OHNoMFExenN5?=
 =?utf-8?B?S1NPeFVveFR5WjEvZUs2aFZFWklJVFJRVWtPcVA5NC9SVmVHMG9sV0lCRHhq?=
 =?utf-8?B?bkpzZm5WdENENGRWblhGK3paayt6aGVVaG9Uc2VrOWdSTHp4TFpsL0lONldR?=
 =?utf-8?B?VFFmcVYxelE1RGxFTUk1V1ZHSmpJMVJVcTlTYzNDSjJLVmltL1Y1YXIrUURT?=
 =?utf-8?B?a0tSbFlQU2RPbngvTnBzNWR3VnRhcjV3UnlFMTlqOWl0bTcyVkMyS25xUW9s?=
 =?utf-8?B?R0s0clVpRVo3Y0Y3UEcrWThxcEprU3haVk9Va29rTDlmOGNTUWpsU0pNQm00?=
 =?utf-8?B?TGUvd1VBOHhTNXhicEQveXkwdUZINHVxcnRtOTBCMHMyaFZwZUtRdWE2MzdE?=
 =?utf-8?B?czNuWXZjWEVWVnUxZ3hKTmtyeWFwOTUzamFhR2ViS3ltYzQrS3VhbUpMRnJF?=
 =?utf-8?B?NlBvUFhTSEhRU2FoQmhnMC9pSzVDSGNmWjdVNEFESjVDdVIwVlZQSkZjQ3hS?=
 =?utf-8?B?OXBZNE52bVBVK21maVRQOEVPQXYyazY0N3I0Z3YzbVEyRHpWMndWUG1yWURL?=
 =?utf-8?B?NFJsbWRJU0xoMHJZUGhaT0ZDWWc2dDhIUW14NkFIc2x0TVZSVmdXYUpmWmRX?=
 =?utf-8?B?VlJEMHJzaExpRkE4Mk5wRlpibTVMdlJVNy9qSjhwOW56MXpPajJzMWVpWnNC?=
 =?utf-8?B?ekFRRGJ6SjFqdjFSUHJrSjRHQW1RQ0ZmbHdPdHBqR2ZLZTNaMmtQbCtBb1BY?=
 =?utf-8?B?dXA3VjBoQ2RRVXljQXFoUW5CcTVPc3FTVExySC9UYTBHdWVNTDcyQ3VDc2Fw?=
 =?utf-8?B?UWRvWnhSa1hmbkRwSTdVY00xdmpacXpUVUlZS1oxekZCTGFrUytyckp1cm5L?=
 =?utf-8?B?YldlOGN5RTd5OFBpVVdsQjhwTzN3QXhuM01GZDRSRk1Gdkc2SnU2TFhhQnN6?=
 =?utf-8?B?bG90TGZWR2RlRUVGRXJCcDhpWmlrUHdoanZGUitGVWducHE3QzBKMjdVazRt?=
 =?utf-8?B?WkMrVU9wY2k5Nkthd085U3M3Q05ncytGRkphSVdOQkU4TGU4SFh2RDFUQUVG?=
 =?utf-8?B?YURWRWhUQVZCS0Y1aGY0ZFdxSStBZURCQit4eHZ0SHJmTEt5YzF0RDI2N1o5?=
 =?utf-8?B?T0pYcHU4RW9BczZiay9PekF1cFNvUjZSUDV5SmhIdklTU29lZ1dRaUcvay9C?=
 =?utf-8?B?VjlpK3FZM2NFcGdtV1d3Z2ZWMFZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(376014)(7416014)(36860700013)(14060799003)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:44:22.6573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf0e9d6-66fe-4671-b2ee-08de58d1a83a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10709
X-Spamd-Result: default: False [0.74 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251830-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:url,solid-run.com:mid,solidrn.onmicrosoft.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,kernel.org,solid-run.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8BE5254C7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMTkvMDEvMjAyNiAyMTozMCwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IE9uIFN1biwgMTgg
SmFuIDIwMjYgMTY6MDc6MzggKzAyMDAgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBAQCAtMjQ3LDYg
KzI0Nyw3IEBAIHN0YXRpYyB2b2lkIHNmcF9tb2R1bGVfcGFyc2Vfc3VwcG9ydChzdHJ1Y3Qgc2Zw
X2J1cyAqYnVzLA0KPj4gICAJY2FzZSBTRkY4MDI0X0VDQ18xMDBHQkFTRV9MUjRfMjVHQkFTRV9M
UjoNCj4+ICAgCWNhc2UgU0ZGODAyNF9FQ0NfMTAwR0JBU0VfRVI0XzI1R0JBU0VfRVI6DQo+PiAg
IAkJcGh5bGlua19zZXQobW9kZXMsIDEwMDAwMGJhc2VMUjRfRVI0X0Z1bGwpOw0KPj4gKwkJcGh5
bGlua19zZXQobW9kZXMsIDI1MDAwYmFzZUxSX0Z1bGwpOw0KPiBJIF90aGlua18gdGhlIGRpc2N1
c3Npb24gaGVyZSBjb25jbHVkZWQgdGhhdCB0aGUgcGF0Y2ggaXMgaW5zdWZmaWNpZW50DQo+IC8g
RG9BPyBFaXRoZXIgd2F5LCBJIHdhbnRlZCB0byByZWxheSB0aGF0IEFJIGNvZGUgcmV2aWV3IHBv
aW50cyBvdXQNCj4gd2UgbWF5IGFsc28gd2FudCB0byBzZXQgX19zZXRfYml0KFBIWV9JTlRFUkZB
Q0VfTU9ERV8yNUdCQVNFUiwNCj4gaW50ZXJmYWNlcykgaGVyZToNCj4NCj4gaHR0cHM6Ly9uZXRk
ZXYtYWkuYm90cy5saW51eC5kZXYvYWktcmV2aWV3Lmh0bWw/aWQ9YzkxYzBmNTQtNTZkNS00MzU2
LTg5Y2QtYjU3Y2JiMjg5NDk1DQo+DQpJIGNvbmNsdWRlZCB0aGUgZm9sbG93aW5nOg0KDQoxLiB0
aGVyZSBpcyBubyBjb25mdXNpb24gd2l0aCBxc2ZwIC8gNCBzZXJkZXMgbGFuZXMNCg0KMi4gMjVH
QkFTRVIgaXMgaW5kZWVkIG1pc3NpbmcsIGJlY2F1c2UgdGhpcyBjYXNlIGRvZXMgbm90IGZhbGx0
aHJvdWdoLg0KDQpTb21ldGhpbmcgb3BlbiBmb3IgZGlzY3Vzc2lvbiBpcyB3aGV0aGVyIHRvIGhh
bmRsZQ0KU0ZGODAyNF9FQ0NfMTAwR0JBU0VfTFI0XzI1R0JBU0VfTFIvX0VSIGRpZmZlcmVudGx5
LCBlLmcuOg0KDQogwqAgwqAgY2FzZSBTRkY4MDI0X0VDQ18xMDBHQkFTRV9MUjRfMjVHQkFTRV9M
UjoNCiDCoCDCoCDCoCDCoCBwaHlsaW5rX3NldChtb2RlcywgMjUwMDBiYXNlTFJfRnVsbCk7DQog
wqAgwqAgwqAgwqAgZmFsbHRocm91Z2g7DQogwqAgwqAgY2FzZSBTRkY4MDI0X0VDQ18xMDBHQkFT
RV9FUjRfMjVHQkFTRV9FUjoNCiDCoCDCoCDCoCDCoCBwaHlsaW5rX3NldChtb2RlcywgMTAwMDAw
YmFzZUxSNF9FUjRfRnVsbCk7DQogwqAgwqAgwqAgwqAgX19zZXRfYml0KFBIWV9JTlRFUkZBQ0Vf
TU9ERV8yNUdCQVNFUiwgaW50ZXJmYWNlcyk7DQogwqAgwqAgwqAgwqAgYnJlYWs7DQoNCkkuZS4g
c2hvdWxkIHRoZSBFUiB2YXJpYW50IHN1cHBvcnQgMjUwMDBiYXNlTFJfRnVsbD8NCg0K


