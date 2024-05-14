Return-Path: <netdev+bounces-96311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA988C4EC7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38DD281F58
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F1185953;
	Tue, 14 May 2024 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="vWr8Ly5V"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A458594C;
	Tue, 14 May 2024 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678821; cv=fail; b=VcZgaGHYUPkNBf5bdalO00rdgdDpHXdE0BkWX42q8EaknJqVeZpe6zmhE04qCt+zFlzVd9eJE1dWIjAmmo6oDJSusMx/7Obth5kgvhZOXx0u6qOSwl89sZWBfhHMAKFJznBqmKR8gTC6nhBdBA/sX+2I6RACv8FE9x+T8ApuXzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678821; c=relaxed/simple;
	bh=ACsfjYiGWlJNYg7vq3QbCLBwsvZHZC5JUVXX2xHveTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mfnbg6vuMkTzpMxnyDtQc/i5XTNUDRP5mMd8fLdUwZfdccc3zsUknebDp6eL0TrcN/sGYsAtZBmQrl2B95tcUM0rgUNaBs7AtMhUHn77P5vvIh4Uj1KhoiwnesTUjQQeCu/V2L22jdIS2MP8LAvGGVeN91FFINmwyDbQ1jKGIPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=vWr8Ly5V; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44E8b39s012775;
	Tue, 14 May 2024 02:26:10 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y3udn9hfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 02:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mL69+cm5/AuCt7/4LfgELriss/D1QkP67GNu7RJRYN+hLs7YR4Vc38ZRO19M3T/zd5rV7iMfNIasB1SJ+AvDmRQQrAybsW0Whr8GR2dK7k4pJ/+aeNRKH7MpNHSmyQAfibtLA/BkdBoi0siU1BNUTGiFETBmsVFE/WervCMlrIyLdreBFBa8E0++yQ8yT0KylG03uzGjMeXQTGhiKgZ3ze0XObUOcxdWkdJKMVm2wxux/+EKvO1NqvVBBFkadOpyXMt8kFUxZ2uW1vcNnmqvrfi1miGEuow/R8oIRKsuVzy8XaLfoTZfxBqM6yijgIv5VnCCXwaQUbFq4LemvbH2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0y9QyzxpnUOCyOP4brl/R4GOttBwCiq4HYdZLvuk+M=;
 b=C1UCTbpVdZNdkNcb7X4bENp8hxHAkzIml1v4tOGdu82pR34jQRTwfPjomdd4SAiDWaT2miYo0Z15K+Iga0DEiL9NMPR6q+lgPVaO2JKP++vosJQDQ713UjjAEAdo5J/oxhrGn562Aqnjxjc3XAt6We7ZpJ5kECcoz6dSiaidnTq7t/REmofsQt7R/WmXW+9Pl9bxxWry/guw5ijRNMlGHw6r3RBSLB1Em2VLBMDI0wIF8rP+JjrMY2cKZR9q4bJH3jOFIQy70Unq1ijnav1j8lRcMc3lLLABJrVaahv46SXQNSSqJ8sOYILff/MpNclcgmFHsz+5i6TeJDfjq6Ng4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0y9QyzxpnUOCyOP4brl/R4GOttBwCiq4HYdZLvuk+M=;
 b=vWr8Ly5V4IPSOg+2mxvA28OJiA1olqJVCvxyd2W/XdSJtmMk0fqG/BEva17wePGVwGewTuTOWY/c45XoxKExtTLUcdWiAcF3Yv5gzNDfCCKF3YTs7dS/KdvZhEA7V8XAcT/rlOHlBaRevtDH+2BYY0Mc5la14psD3gL6vuO9esA=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by SN7PR18MB4112.namprd18.prod.outlook.com (2603:10b6:806:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 09:26:07 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Tue, 14 May 2024
 09:26:07 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Wei Fang <wei.fang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Shenwei Wang
	<shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
Thread-Topic: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
Thread-Index: AQHapRfDaiJFn1FWf0uT/Cuv3lOav7GVFuiAgAFb01A=
Date: Tue, 14 May 2024 09:26:07 +0000
Message-ID: 
 <PH0PR18MB44748039C05AE91AAD2DB514DEE32@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240513015127.961360-1-wei.fang@nxp.com>
 <PH0PR18MB4474D5050F6CBA0B2D4A6041DEE22@PH0PR18MB4474.namprd18.prod.outlook.com>
 <PAXPR04MB851010A6DBA52A04DA104E1C88E22@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To: 
 <PAXPR04MB851010A6DBA52A04DA104E1C88E22@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|SN7PR18MB4112:EE_
x-ms-office365-filtering-correlation-id: e0cd3313-f3a5-46ef-7919-08dc73f7e27b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|366007|376005|1800799015|921011|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UHRkbm80VjNNa1Y1Nmd1eHVSemdSU0ZTQmtGMDlaSnB5MXpmNHB2T25T?=
 =?iso-2022-jp?B?U0pOUWpQSmk4NWlQZG14emR6Smx1S2FhWGp0WXpyRjRHVkg5T2F6RmFW?=
 =?iso-2022-jp?B?NWthWFYzSHZmWk5zcVBMQ3V5aUs0OFdGNnJVRmYvSlJ0UWxoVzlpTml1?=
 =?iso-2022-jp?B?RHV3d1NoZkJkWk9kSHBpc3N6WHNvWnEwa0NqUllRRFQ1N1lRYkVWVHU4?=
 =?iso-2022-jp?B?S0hySUFaYW03NVAvM0UxMTAvbnY3dHJUQ2ZBK0xrYllhSGJCTFVqeUJD?=
 =?iso-2022-jp?B?ZnlnZXJCOXVDMTl2WW5UUmEwaWk3TTBlR244ajBQS2RnNGhLQ29nNE5m?=
 =?iso-2022-jp?B?bzhJak5jVERiVWlxUVBPWlVFeW5Ya3MxUnI3cGI5YzlPcmhPSUQ3cGdV?=
 =?iso-2022-jp?B?UkVycjRTSmc2ZDRVWXNtT0FnUG1DWEJyUzlIOEhOV0Z1bEl1UCtpM0sv?=
 =?iso-2022-jp?B?MW11UkY1Y0hVd24wOVRuT3VZTDJhU3YrNDdMQ0pVZTlta3A5bW1QM2Mr?=
 =?iso-2022-jp?B?c1laZk4yRVdEQVVPQWhPVEcrNXB5cEZ3eDY0VnU4b3FPcFRtbk5MSnly?=
 =?iso-2022-jp?B?MlVkaVF0RjF2Slk1WkRwb1E3Z2tZWml5emt0YnAzMExvRUE1WmVCTUxS?=
 =?iso-2022-jp?B?bjZ6Y2wwdW1VVlF5cUpLcjJsc1FHLzVZY1dPdCtkM2wya2NibExnVTBv?=
 =?iso-2022-jp?B?SVYwdEVQSXF2TTV4ZHczdUJxbjhZT3BvMm5GY1BkNE1pcnNwSzIyMDBm?=
 =?iso-2022-jp?B?blRkanZsMkpYMVRlenJWRkJCQy8xRml2UjJhTFNhUG1qMmV0aFF6VFdL?=
 =?iso-2022-jp?B?ZmJWSkJNaHdrSzNqVG5PeU1MQWlGVDROTnhDallzU2JzNlFnVFk3Tmox?=
 =?iso-2022-jp?B?cGZ0Q3lBTWRVdzBDdHd5anpYMVdNc21xdmI1bWxaWXRYVEo1OVFQL2pS?=
 =?iso-2022-jp?B?eEFKNlI3RTcvbC9SSlYxSXZ3OUMxRnZ1ZE9tNEF3b2g4SndGOHMrTFg4?=
 =?iso-2022-jp?B?OW5HK3duZWhtM0d6SVJCSVJFRE5HNHg4MXZuZWt1TkVGcC8yMlRtSU1V?=
 =?iso-2022-jp?B?dmZ4VnV3OENxTFRpcXQyNkdWTEZBMzZobVE3cUhWaDYzcEoreTNMQ05D?=
 =?iso-2022-jp?B?NnVTWlBtWmRzVmVLbFJiTFBPZ2tKNlpvREc2cGg4elBJQkYvRlNoV1Vm?=
 =?iso-2022-jp?B?V0VqSU9HdFA1cnIvcEh6dVZ6U0FDelFyVWRpdkJORUk4MERmSGRIV0lv?=
 =?iso-2022-jp?B?bll3TzJIc0VZQ3M4emVRZytwWDBPZ3dOc1IzdUdHbWRzRFhsRWNuS3cr?=
 =?iso-2022-jp?B?OXZmQjB1am9DTHg4RzRmZjd4ZjVCQjFCMGV5MGhPTi81a1lDbm5ncHlR?=
 =?iso-2022-jp?B?bHo4MTg4aVhMWDY5Mi81UUZlV2hpSVN4SStrT2s1Z2tWc2I1N1ZwbXli?=
 =?iso-2022-jp?B?WWgvZXYxcS85S2xIUVBmYnAwSUVQRjE2Y0IyUVpHM0gzZldFTUZ1Ymwz?=
 =?iso-2022-jp?B?bWtNcW1yc2RmK1lZVktJZ1I0TnpXc3VFM3VCSldTSzRQUGZGdFNNb1Uz?=
 =?iso-2022-jp?B?bVFHSXNqZmtvdGJQOFVPUHkrM3RmWHovaU5OdWU2TDZzZTYzSHhKc01z?=
 =?iso-2022-jp?B?aXR5ODZoaWNMUWUzNGo3emxJekd0QVdKOUhhLzAxUmc5SjBhaVZCdjVZ?=
 =?iso-2022-jp?B?dlh4ZzdsNjNEQnkyNFIzUlpDYlppb0JhSUtYQk5BUjJMb2p3dzhvOVJC?=
 =?iso-2022-jp?B?T09SZUFRYktuSlZadUh0TEV6K0lYUlVleGF3TUQ5MEVwNG96R05ueFJV?=
 =?iso-2022-jp?B?MjkrelUzL2JPMENoN3lmRUFVYkJMeVJqRFVxa1FmME8vUTB2eWtBa3Uz?=
 =?iso-2022-jp?B?bUhPeWRGRHBNNjc2dGpTTHRoZjVDK2ZFaEJaeTZzZVJYMlFqME1XRVRE?=
 =?iso-2022-jp?B?MVBSb0RVRUo5V2MrT1NGS2pkUWxJYjl4WFRjdVY0cTNaQXAzbVZjeFpy?=
 =?iso-2022-jp?B?ST0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aFZWVk45Y1NiMVpKT3ZJN3VpTk82WU9YbjVpNUgyZ1NoTEwwN1FDNVRI?=
 =?iso-2022-jp?B?MTJ2MkNmVk9vWE1VNmhaMC9nSUhWMXNOaWVVSXFvcHAwbzRzTVNzL3Bk?=
 =?iso-2022-jp?B?ZmZheVdHdlNLK1NneGtZTmt1MUsrWGFnZmJRNFEzZkxjbXFWSTZES3hy?=
 =?iso-2022-jp?B?R0RMcXBqWUxyOXBrdWxlWFN0UVlPM1hZN0hZWlpmNkw0VHNaSE5oYVdL?=
 =?iso-2022-jp?B?L3F6Tk1wQnhRUVVDL2pUbjZpRVQyTC9IWUNQR2pnaCtzeStxcXBFajhE?=
 =?iso-2022-jp?B?QXU3b0xwdEl4NHlsR08vRjlHSWh5Z3R3VkpBQ3FObk9LdUNGcitCNUhI?=
 =?iso-2022-jp?B?UGdWTDMwWC9XQ1Zmc1JWZmtVMEoxTVp3clM2VzgwR2liMmJXeEcvWFdx?=
 =?iso-2022-jp?B?bktCVnM4Qm5NK2p3VDBVRG55ZHJSQ1BXUUdDa1hQZU1CT0lsakh4WEZU?=
 =?iso-2022-jp?B?TG11azlJTW1rZGpxWlFQUitnUkNRdVFNemJEWFVwa1F5dUt0RnVmS0Z5?=
 =?iso-2022-jp?B?a3MvMlJrODhqVDVNRDhSREV2Z1JuVEM5YUVuVWxIaUN2SHkxczV2dDhS?=
 =?iso-2022-jp?B?UlpseUh6VmcyRDdCTlZyOWFjUzBsV0pXdjRnOHBGVGRHaFJuYVlNUFVC?=
 =?iso-2022-jp?B?b2VHR0tUZ0dZUEpWcVdabE1aUXdQSllWakVuamt1NDhjT2c3Y1BDdGMx?=
 =?iso-2022-jp?B?azJobG9PbVpVcVZtV0xMem55L1h6cXpocmQvNFdZcHJJQmFqSkxuT28y?=
 =?iso-2022-jp?B?MnhKeW1CWG0rc25KUmRIVGhFVUZBTUE3ZGZQUTZmQTVLNkJtWnJGTGVa?=
 =?iso-2022-jp?B?QzFZQnE3TVRDenNKYnhHbjBOZDY2c2podzlSdysxUEppajMyU01EV3pM?=
 =?iso-2022-jp?B?U0E2ZnlEaVYvdnY1ZWdSTmVSdks5OThROExKaTJ0a2xDNCtwNDhEOTlU?=
 =?iso-2022-jp?B?VHlOZVhaQWJPcXlOYW1JNmxYbEsrb2cwTHc2R2NHdEMyaVFwSDdkNUZz?=
 =?iso-2022-jp?B?OHdTcm5DNVVVUzhGV2gxalBnd2xEa0I2YjRIMTc5RnArVTlHc3BlT3FW?=
 =?iso-2022-jp?B?RllTUjA3MlpraUdoNlV5VnlnUU50MVpIZC9qd0lOQVE5KzhUdVlhTjRo?=
 =?iso-2022-jp?B?TXJRZm05Nm96QWxteTRuTTdvNUYzeWFFaFhFdkUwM2FSOGRRZFFIaUJY?=
 =?iso-2022-jp?B?MEJGcnd2NVdGUXlnM2dIT0FsYlVpbTVndDNvMHBFUGxldm93SkZzZzVo?=
 =?iso-2022-jp?B?TnU0SGpCQWdWdXpUZUYreFR3NUx5eHBET1kyZ0FSUU1UZmg5eUt5dWRN?=
 =?iso-2022-jp?B?cXBzbXBPd3d3VnE2WWh3bTllWXczMjUrTjhkbThlTCtGRG9QUWFPMXhy?=
 =?iso-2022-jp?B?SnZxK01MckRQS0ZRUkcyeVBtU3JTR2xtY2REZ2VyYkFnY0RMT3RXRDcw?=
 =?iso-2022-jp?B?QXVXODAwZXFNcVJjNFdQcFdBSkwvWThvRzlBZG5wc3ordS9qVTJtQ2Iy?=
 =?iso-2022-jp?B?ajE0RHFFc1Y5enJmWC9saE1oT1J0dDZaTy9WYlkzTExndW4vbGRVZzhz?=
 =?iso-2022-jp?B?SjNNKy8wSVRrajkzK043MXdOUmxPT09lZG9nYzc5Wm5IZUp5SXlRakFi?=
 =?iso-2022-jp?B?QmVvTHBvL2hDdlhSeXJOMDZnN3BBYm5YeVdDT09PVXNCODc4elFucGxw?=
 =?iso-2022-jp?B?RkpBUThHaWVGTEdDWXUxZG51ZlNPM1BtUzFDcFprVDhubjBLNTdjcWRW?=
 =?iso-2022-jp?B?bEllall2bjRSU1lqNkhDcEFnVytwaGtqdjQ1S2J0RTdYVmI1M0htWUgw?=
 =?iso-2022-jp?B?eDJsOXlMcFFQbFBFaSt6M1ZVbDJ5UFFpSTY4Y3MramlqdExaODArbWVu?=
 =?iso-2022-jp?B?OFNaM2VDbTdnVFZ0Vm1MMG9nSTRDWXROSzNtT2pxOWxlaWtVSmtXL2lM?=
 =?iso-2022-jp?B?T1ZLTk41WFU1a0NRaXlFclE3YUdHaWtsVEo3UEVvVU82ZzVpQ3hHVXBM?=
 =?iso-2022-jp?B?NFV2RlFaMDJNVStDblBUa1RYQld3WUc3ZkNsSFgrRS9IZHpmcDgyZ1N4?=
 =?iso-2022-jp?B?U0pKZnhFcFpmV2NmTzlSZHNSeW9UOURtZ2FRTWhDdmxVZHZPT0oxTS9R?=
 =?iso-2022-jp?B?aWI4NjVNWXlYNDJhbnc0RFZSQUlPVzZYeHc2MzdiWkhCRkxtclFsSzhX?=
 =?iso-2022-jp?B?akZIMFZ6RnN2R2JSOWh6SzNMZ2s0YnRreDZYbXlKY014ODN1d0RWVk1i?=
 =?iso-2022-jp?B?ZDg1d3ZRb1Rwemx5ejVacXBEaU53ZU13RERmdFJ2TmFJamFqWTAzM05R?=
 =?iso-2022-jp?B?UUdhMw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cd3313-f3a5-46ef-7919-08dc73f7e27b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 09:26:07.3572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HH9hoaECFRhjfMyqA03e0v+JCi3STk8lyrzSwokA7KidSUs6sqUZj9fxklYBWUMXQtE6VMpIFE2GXlH2WtD5ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4112
X-Proofpoint-ORIG-GUID: KJ0wcnlCwoJj8kpEYzKdY9BnlYQFZGwV
X-Proofpoint-GUID: KJ0wcnlCwoJj8kpEYzKdY9BnlYQFZGwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_04,2024-05-10_02,2023-05-22_02


> > -----Original Message-----
> > From: Hariprasad Kelam <hkelam@marvell.com>
> > Sent: 2024=1B$BG/=1B(B5=1B$B7n=1B(B13=1B$BF|=1B(B 17:27
> > To: Wei Fang <wei.fang@nxp.com>; davem@davemloft.net;
> > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Shenwei
> Wang
> > <shenwei.wang@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > richardcochran@gmail.com; andrew@lunn.ch; netdev@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: [PATCH net] net: fec: avoid lock evasion when reading
> > pps_enable
> >
> > See inline,
> >
> > > The assignment of pps_enable is protected by tmreg_lock, but the
> > > read operation of pps_enable is not. So the Coverity tool reports a
> > > lock evasion warning which may cause data race to occur when running
> > > in a multithread environment. Although this issue is almost
> > > impossible to occur, we'd better fix it, at least it seems more
> > > logically reasonable, and it also prevents Coverity from continuing t=
o issue
> warnings.
> > >
> > > Fixes: 278d24047891 ("net: fec: ptp: Enable PPS output based on ptp
> > > clock")
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > ---
> > >  drivers/net/ethernet/freescale/fec_ptp.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
> > > b/drivers/net/ethernet/freescale/fec_ptp.c
> > > index 181d9bfbee22..8d37274a3fb0 100644
> > > --- a/drivers/net/ethernet/freescale/fec_ptp.c
> > > +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> > > @@ -104,14 +104,16 @@ static int fec_ptp_enable_pps(struct
> > > fec_enet_private *fep, uint enable)
> > >  	struct timespec64 ts;
> > >  	u64 ns;
> > >
> > > -	if (fep->pps_enable =3D=3D enable)
> > > -		return 0;
> > > -
> > >  	fep->pps_channel =3D DEFAULT_PPS_CHANNEL;
> > >  	fep->reload_period =3D PPS_OUPUT_RELOAD_PERIOD;
> > >
> > >  	spin_lock_irqsave(&fep->tmreg_lock, flags);
> > >
> > > +	if (fep->pps_enable =3D=3D enable) {
> >
> > Can we atomic_set/get instead of spin_lock here.
> >
> I'm afraid that cannot eliminate the lock evasion warning, because it's s=
till
> possible that multithreads take the false branch of "if (fep->pps_enable =
=3D=3D
> enable)" before pps_enable is updated.
>=20
> Since  in fec_ptp_enable_pps(), value of pps_enable is checked before ent=
ering the actual code changes,
  Better approach is to use atomic_read/write. This is not only for reading=
 but for assigning the values as well.
  This way covertity wont complain.


> > Thanks,
> > Hariprasad k
> > > +		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> > > +		return 0;
> > > +	}
> > > +
> > >  	if (enable) {
> > >  		/* clear capture or output compare interrupt status if have.
> > >  		 */
> > > --
> > > 2.34.1
> > >


