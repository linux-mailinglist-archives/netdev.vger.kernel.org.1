Return-Path: <netdev+bounces-108776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B17925629
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029FB1C20DB7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2113B5B4;
	Wed,  3 Jul 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Cnx/vAqs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D84D584;
	Wed,  3 Jul 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997840; cv=fail; b=VDNSHyLkBp+qJrZnZqVUeLQwURuhXXLe7wB6t1MRgGaliELOk04enbV0URQcFmg/v/iz79KnnvE3lA+/PskDzRoz+WxJF6RVc3ln9DFUTKD0fIJi5CpEw88FrH9e5/k1F2kzMfbPsoNvOdTlaLVVUA73L+K3yGCMaqALm6Ct4RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997840; c=relaxed/simple;
	bh=3U25ZPizY79fpEmxFvG2bs4LlSB1OEw8r5IY7ZC9W7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G2euDDf4eU4dNGQI86j4CIJsznCuqcStYHDqR+DS9RXSm7P/Xsn9Ua+oh0l4K7bvhHLg0EKDxlbp7d2/yDtb+qBRT9bJy0WWTKuy2OLQhBLMsTXCK118YFoLz+idjj02Ki5Qv3cd8oG4Qqq9NAYQDgBhA6hcrcpAPvHrrYXDyZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Cnx/vAqs; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46384gDA005104;
	Wed, 3 Jul 2024 02:10:25 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4049mdwyu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 02:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcVhyIu/8jv6IWPWaCGOSOuepvCpHxHx4z7s0yJ7l0UMz+6TG+F6lu8pVFOIcfD1aEizNVlKH6vrdToXH9kPvEuGV6lrx5LFMm8mPElDkLdXFWfFpphHKCminUDxGIuk1/BMIr+QRyqFicOpcKFtBjVM+LKR8Xj7SmwErpy9c9r0l945fm0rN1pLSFJ3aX1Y4vFF4D+8smZnOAuoJXu+bWjyty6XEWZUXB76PyAqYFNT4giVpd0CWfIkWnoe9XnqCePTGKV0hxQZ9n9A5h7O24pGQs3OlkP6CkShVqHIc54G8wsh2mqlvfFItjGyLmN+xi4M+uMNUvSPi6Mdz2jjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U25ZPizY79fpEmxFvG2bs4LlSB1OEw8r5IY7ZC9W7E=;
 b=ZA71g90QWQLkOs6yoSXmGGELfVrvU6IT/ejR589Z7XcPAI/uYQNFNlALvn9Ic9Emd6VqJS4AWbLDUEqmzRwlBIjsr7uVxjTZJM+gujIMAzKweUXqjZC2v5VLXm7RlkR7blpuNT05zGAPrQF7gbaZc9TwBVjbtBVVdGggPEo+RCMtqX0NKXgyPDysKw411zXkfpU5Jb0pcCp3EQfijsheDVd0zr8tiESsawF4VO7fYw1qxUpfRiOLpRCGfAkr8sduCp3AC58xbFR5HVk1jO8LVHCoaC1JpfPNmETzetGd8WK3X6PhBxfvBrDM4fV44bftXhmgKTIbjjHtqLXMggdhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U25ZPizY79fpEmxFvG2bs4LlSB1OEw8r5IY7ZC9W7E=;
 b=Cnx/vAqs6enmq6x0U9EB/E7xNy+7wilqu7eM1pv06J47f5kkV/7FZNb705dfmCcUol0+if4G+bmRG87KlSwWRPsxJFxwbjzQo6P75ZSW+0DhVoMLr08l/SaaPugAQ7JvJyC1w+txvRFYerfJpMk4lfiDTxskpR3ZAeXEgYrACk8=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SJ0PR18MB4106.namprd18.prod.outlook.com (2603:10b6:a03:2ca::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 09:10:23 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 09:10:22 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
 representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
 representors
Thread-Index: AQHayWAH5wurYZD5Kk24R5BnL2IOPLHiyIeAgAA6lCA=
Date: Wed, 3 Jul 2024 09:10:22 +0000
Message-ID: 
 <CH0PR18MB433908D7965F931EB7D37570CDDD2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240628133517.8591-1-gakula@marvell.com>
 <20240701201215.5b68e164@kernel.org>
In-Reply-To: <20240701201215.5b68e164@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SJ0PR18MB4106:EE_
x-ms-office365-filtering-correlation-id: edbed2c9-192e-4f74-d8af-08dc9b3ff838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cjdpdnh4dEdOL0lQMnpTTFNjZ0RZSTRjdUp5Q1dmMlhzMXZ3K0dHRk5CSlJW?=
 =?utf-8?B?RnppaCs0VWpwWlR3cHl1UjIxckxiY1BaSE05bmQ3QlQrb29kek9qc3pwRER3?=
 =?utf-8?B?dzJzcHB4eHU0VVVOL2R0L1piQXJnam0xMi85amJYdGVRdjNsTk5tQTdRSXMx?=
 =?utf-8?B?SlRZRS9HL0ZVTENKSXNmeWxsSFluWWhVNnNpcG1FRUwyekJGYm9FU0NhZW1Y?=
 =?utf-8?B?QXNTR3lqVzFPa21RZmF3NFZ5SS82bmxwczA1NU9kVUFjWUpSblJjc3VhOXBW?=
 =?utf-8?B?S0pFSXcrdWVKenRDMVI1aG5vL2F6aldRT2xySTV2NlVUMUZNR21KN0xiamxQ?=
 =?utf-8?B?OGVWdDJieGs0Q2p4YTdOOS9hZnJabzBnck1pTUljK25WdEFTRUVXcHpOb0xx?=
 =?utf-8?B?RFNxenpEMXJhanhTc3BrZFhacGF4UVVBTU9iSzk4M3Fzc0JKVTdMbll5M1RZ?=
 =?utf-8?B?NWE2cnVsOHNMdFVKMUxrMHVUbEFFU25zZmVSU2Zsb1pjdm9qVW9lWHlVQnov?=
 =?utf-8?B?THo1T0Qvd2F5ZW5BNDRTUy9vUllvdWptK1JTNHBZUVZGa2t5bitUdlAvdjF3?=
 =?utf-8?B?Q1dGK3BqM29MejlXQTI2TjFxandGMncwTGhhdDZOMjg1QUpCeWowMnFXTkpv?=
 =?utf-8?B?Wkh0Y0NtODNZaUhiK3JPUENUcnpJdmU5NmFJOFZPTGN2UHVlTURJUGNiaVVZ?=
 =?utf-8?B?eDVqczBlbHNpOGZmallIUnhydi8yRndYL2FqeCtpSFZXVVNEb2Q2N09EbWM1?=
 =?utf-8?B?YzI5d0VXQnFYYzNEaEVXUGVqVURSSXRzM3VwYkwxZk1XZmFBNysxNG8rWGNY?=
 =?utf-8?B?VTdIUTZ6cFliSnZNYjZVbHhMc0s4RzNkVVZlZjdnL1M3WXVZR1Q1OG95QURo?=
 =?utf-8?B?ckk2VHEwSHNhMFczalJhYUVUcGMrZVE4aGRGdlFsbjJkeTJxMHpqTU1rRWM2?=
 =?utf-8?B?VDdOcWdjWHo0c0c3bmRHUjk0SVB4bGh1YkszczdOTnVqUUtVcXlpTU9uYjNP?=
 =?utf-8?B?bmFmbjRDYUpPRVVQMVl6TXBmU1ZNVC96NnBjUHlzVWhMc0dPYXpKdFhYTUh3?=
 =?utf-8?B?ejFiMFV0WHRpdHVwbmhKMk96VWxtemM4QjB3bVJXK28waWcvWkxMSnN6MGpE?=
 =?utf-8?B?V1l6NkU4Qm11VHR5eFBZNlNjMUxOdWdaR0FqWGYrcjJkTThOeGNjbDg1aEoy?=
 =?utf-8?B?WmV5S2pyN0ZJWGtwa1lFc3lmTHhNMDJFRXBmUUFOMk1mV2NweXllUUtoM1hn?=
 =?utf-8?B?eWRvc0k5YkdRUnlWZlRCM0phd0tnKzFObXVaTUJ6VFVNclN2VTc0cWZkUkRO?=
 =?utf-8?B?RFd4L09rdFJhK2JyOXE2R3hCYVRwejA4WHlCQUJsZ0J4RVJRTzYvWWVueFFY?=
 =?utf-8?B?S0RsZ0ZOSTUwR1RBbnIxSi84U2UxQlUzSkRhVG1EZm9KS3B5am1tNzkzem1L?=
 =?utf-8?B?SnhDVFlkeWNnYlhmUzRXa0pObmd1Tmk2V21lTzFTWjNSZU9keEtKUmJEV0VP?=
 =?utf-8?B?d205bExTWmd3RGI4amdCdG5zWEY4UXZjd2lCMHhmK0N1YnBYaG9xQmZSNHNB?=
 =?utf-8?B?YzZ3eUhkb1cybFZMVXJGeUkyeVpFYVozMC8zSFR2Ti96djk2OUs1eUlUVTFn?=
 =?utf-8?B?aFdDYitvSWg0SkJyNEpuSGl0TnI4SmNpZTVvNWgzdmdoV28wcmJhR0owR3d1?=
 =?utf-8?B?WWp5YVJLSlludjVDNWpLdW1oVGtTU1NyOTYxcTZ1R2c1NDB4U09JWmd2OFo5?=
 =?utf-8?B?cmozUjU1VVVsWlNlL0hYOE5zUmJNTXh5Rlh2TG0rYStlMjE2YjZZYmpEbi8x?=
 =?utf-8?B?cGR3OWhkTFNLZTNGMUJpY3ZHek5pTnJMbWs3dXFkM2FJVXVreU1Md2RtUEcr?=
 =?utf-8?B?Q1hYeXBhcFZuOGQvTXRIRzY0eFpUcTA4Z1RPQjEvd1FrRkE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Ty9tcE5TU0h2SkJzcHR4ZTYvS1MzMmNLdHdITW9oZXlpODhRY3VRV3JHRTlx?=
 =?utf-8?B?ZXQ3MS8xQ2RUbHBnWGh6Rk5FSFZEYmZhcll4bkZ4b1duSi82UlB6TWE2UktO?=
 =?utf-8?B?KzNiM3N3MGUwUnZFcmFtaTBlVWdWMytDOEdOd21tY25XTW5TZGhOK2FXOWZR?=
 =?utf-8?B?elIvODlBampsUk92SVBCd2NFOWQ3dVFpc3FvSlZUVmduM251cGtxV3NQRWpC?=
 =?utf-8?B?Y0M3RTFKazZFelpvWG1IS1d0cFhnQlNrVlNmYllzdXBENitFc1ZnYTUyMkdN?=
 =?utf-8?B?WkRuTmtQMFk0MGw3TGtLazdKZmc2Q1ZXeSt3LzVZVEl6djF4VzYyRXg3KzRD?=
 =?utf-8?B?VjhZNWRTdnowUEg3QTYzNGhKcitGc2xRWkFnbGNvazZhNERzNEZlVm1zZXZX?=
 =?utf-8?B?WWtaR1BSamNJZ1h2dFFKRzBsRGR6cW9oSk5vMUFwTlo5OG5hSk90ZVBsT1Y0?=
 =?utf-8?B?dlp5L0lXWnJwYUtNcjlzL0FwTXdTRnpTQktvRElka3AvSHdWTkMzR2p0SW90?=
 =?utf-8?B?bGl3cTVmeG1NSlFjQi81Z0V4d3A3amhmOUhMakM2TTVrNW5VY0JYUnFhczJQ?=
 =?utf-8?B?ZU80bU5RMWJrSnZPbmZZQmx3dzRIb0VjdjB0UzZDZ01GWmdkcGhJWlhZaFdL?=
 =?utf-8?B?aTBoaWlwbERkemxaRUFJeUY4RHMrcU9VUm51QmlsV3QyYlpZUDhYUUJKaUlP?=
 =?utf-8?B?LzI3Zlpnbzg1WE9KRm9KaFhtNXQ3WVc4TVhmLzNXK1F5OTdpY3pzTCtGNmhy?=
 =?utf-8?B?aDU1YisvbHBEVjZnNUlJa3VBZFo4bWV0YkNZZlB0NFh5TlVYN0haWWlwbHhX?=
 =?utf-8?B?cVppRzByWkVEQlhlaHh5eCtpZmQxVE50cnk2ajcrTUpQNWtnNnhnbzQ0U1Qy?=
 =?utf-8?B?TTZ2RWJ2M3E0Z3pCTXp6TUEySEN3TzVlODEvME0zbXNTcjluUTAyai9uWGsw?=
 =?utf-8?B?REpSeHRaWTFVc1dHckZycXJTT0xpRzdGWXpQZW1ldm5xZnU4UEovZ2htckps?=
 =?utf-8?B?Ym9US1J1M0kvdlQ2dGUxbW9RaDZYWWcrbjFiV0tRQ29NekpzSGtybnRRdVRq?=
 =?utf-8?B?N0NUaUZxaVFMdncrUU5jUUY5L2V2bm0zNVgreS9CRWYrRGkvUnRoMzBybGZo?=
 =?utf-8?B?QWpWRjVLd1JqQkZrTzFZNWxZWWEvdnhQRnRoZ2xBaFdUUDR6ZHFsdlVKNzJG?=
 =?utf-8?B?d200V3FxVWdNM3VJbUN4bWVMYzYxZ0VDMTV3eXZWM2wvekFWU1hSdjcweXRQ?=
 =?utf-8?B?SUh0MTRUVFVVZnpFS3ovclllTjV6ejdLS1lGYkdra0ZZYmFPbm1QcDRQbzZZ?=
 =?utf-8?B?REFWVVJDTldLRWlRZG91NDNNcU8zTzhBcENXVlJicUUxakZyYzgrSi9SRytZ?=
 =?utf-8?B?Vk80WldQOG1haFI0ZmJHY0dqTkdaUWFQcWw4dkNBbnFLdTlRS1pWcUczWm9Z?=
 =?utf-8?B?aWZzdmdzMGVacTFCWDlEZnI4ak8xR1lMMDU5YXBReEtENGd2MFVvV0d4TElO?=
 =?utf-8?B?SFVIVG9oR3ZWR0F0QWhNNlNXRXJ3M1p2U3l0Wnp3QURqdE11NnV5c2lqSTY1?=
 =?utf-8?B?cXdxdFRXalFqL2l1ZFJoZWFWUmd0Mm8zRUZTYXA1Q3FHazhDSG1LdzF2QlZI?=
 =?utf-8?B?RlVyTFJnQkEvVjRBbTFTY29NRGsxbmd6ZGVzSmtHUkJoaFd1VEVhckpPU212?=
 =?utf-8?B?MVN0NU9nNERSSlkyMDRNU0dmWUxnTU1aUnJ0cWFzUzFUcU5HNFBSWVk0T21l?=
 =?utf-8?B?WGpoNmZkdUltOVptWjU2NU03VWdvQlEvMXJBVGp2L1BRa1dBaEtRelB1VERi?=
 =?utf-8?B?dTB0d1k3M3ZtTmlWUzJ6V3V4QnZnZEJFZ0NVbFFNK25UVmtDbGtqZEY5d0Rr?=
 =?utf-8?B?UGNJckYwMnVRWU1IMHBWSTk1YkJ3V2YxUXIwZnRWRUtyUlRmL2hTb0x2T1FT?=
 =?utf-8?B?OG5zR1RXU1Y3V1IyaDJxYm15bmlyTTVuTWZQTWYzLzhwb1E5QnZSUjBGODI3?=
 =?utf-8?B?d0hRUUhXdFdyalYzMWQvS20xaS8wS2Y0dkZ3V1dYdzhlM2VnQ2FkVVNDVVZN?=
 =?utf-8?B?Sjc3VVJEUUpxRDVheEZZSGR6RXA1cXRKN0t1dnhQYUw2WEh1TlorV2pHcThV?=
 =?utf-8?Q?zAik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbed2c9-192e-4f74-d8af-08dc9b3ff838
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:10:22.8878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihBb5Z2+AUZ7HjgHK78guzphY2eSiFhD7ntpd6b4zoHHfFUJVKEPKXWtApt15VWgtC2eQCJqPLbKC2Lu1cwN0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4106
X-Proofpoint-GUID: iobkwWgRuHmyx9BQRIL4_ARktHCVkrlD
X-Proofpoint-ORIG-GUID: iobkwWgRuHmyx9BQRIL4_ARktHCVkrlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+U2VudDogVHVlc2RheSwgSnVseSAyLCAyMDI0IDg6NDIgQU0NCj5U
bzogR2VldGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj5DYzogbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj5kYXZlbUBk
YXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgU3Vu
aWwNCj5Lb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgU3ViYmFyYXlhIFN1
bmRlZXAgQmhhdHRhDQo+PHNiaGF0dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtIDxo
a2VsYW1AbWFydmVsbC5jb20+DQo+U3ViamVjdDogW0VYVEVSTkFMXSBSZTogW25ldC1uZXh0IFBB
VENIIHY3IDAwLzEwXSBJbnRyb2R1Y2UgUlZVDQo+cmVwcmVzZW50b3JzDQo+DQo+T24gRnJpLCAy
OCBKdW4gMjAyNCAxOTowNTowNyArMDUzMCBHZWV0aGEgc293amFueWEgd3JvdGU6DQo+PiBUaGlz
IHNlcmllcyBhZGRzIHJlcHJlc2VudG9yIHN1cHBvcnQgZm9yIGVhY2ggcnZ1IGRldmljZXMuDQo+
PiBXaGVuIHN3aXRjaGRldiBtb2RlIGlzIGVuYWJsZWQsIHJlcHJlc2VudG9yIG5ldGRldiBpcyBy
ZWdpc3RlcmVkIGZvcg0KPj4gZWFjaCBydnUgZGV2aWNlLiBJbiBpbXBsZW1lbnRhdGlvbiBvZiBy
ZXByZXNlbnRvciBtb2RlbCwgb25lIE5JWCBIVyBMRg0KPj4gd2l0aCBtdWx0aXBsZSBTUSBhbmQg
UlEgaXMgcmVzZXJ2ZWQsIHdoZXJlIGVhY2ggUlEgYW5kIFNRIG9mIHRoZSBMRg0KPj4gYXJlIG1h
cHBlZCB0byBhIHJlcHJlc2VudG9yLiBBIGxvb3BiYWNrIGNoYW5uZWwgaXMgcmVzZXJ2ZWQgdG8g
c3VwcG9ydA0KPj4gcGFja2V0IHBhdGggYmV0d2VlbiByZXByZXNlbnRvcnMgYW5kIFZGcy4NCj4+
IENOMTBLIHNpbGljb24gc3VwcG9ydHMgMiB0eXBlcyBvZiBNQUNzLCBSUE0gYW5kIFNEUC4gVGhp
cyBwYXRjaCBzZXQNCj4+IGFkZHMgcmVwcmVzZW50b3Igc3VwcG9ydCBmb3IgYm90aCBSUE0gYW5k
IFNEUCBNQUMgaW50ZXJmYWNlcy4NCj4+DQo+PiAtIFBhdGNoIDE6IFJlZmFjdG9ycyBhbmQgZXhw
b3J0cyB0aGUgc2hhcmVkIHNlcnZpY2UgZnVuY3Rpb25zLg0KPj4gLSBQYXRjaCAyOiBJbXBsZW1l
bnRzIGJhc2ljIHJlcHJlc2VudG9yIGRyaXZlci4NCj4+IC0gUGF0Y2ggMzogQWRkIGRldmxpbmsg
c3VwcG9ydCB0byBjcmVhdGUgcmVwcmVzZW50b3IgbmV0ZGV2cyB0aGF0DQo+PiAgIGNhbiBiZSB1
c2VkIHRvIG1hbmFnZSBWRnMuDQo+PiAtIFBhdGNoIDQ6IEltcGxlbWVudHMgYmFzZWMgbmV0ZGV2
X25kb19vcHMuDQo+PiAtIFBhdGNoIDU6IEluc3RhbGxzIHRjYW0gcnVsZXMgdG8gcm91dGUgcGFj
a2V0cyBiZXR3ZWVuIHJlcHJlc2VudG9yIGFuZA0KPj4gCSAgIFZGcy4NCj4+IC0gUGF0Y2ggNjog
RW5hYmxlcyBmZXRjaGluZyBWRiBzdGF0cyB2aWEgcmVwcmVzZW50b3IgaW50ZXJmYWNlDQo+PiAt
IFBhdGNoIDc6IEFkZHMgc3VwcG9ydCB0byBzeW5jIGxpbmsgc3RhdGUgYmV0d2VlbiByZXByZXNl
bnRvcnMgYW5kIFZGcyAuDQo+PiAtIFBhdGNoIDg6IEVuYWJsZXMgY29uZmlndXJpbmcgVkYgTVRV
IHZpYSByZXByZXNlbnRvciBuZXRkZXZzLg0KPj4gLSBQYXRjaCA5OiBBZGQgcmVwcmVzZW50b3Jz
IGZvciBzZHAgTUFDLg0KPj4gLSBQYXRjaCAxMDogQWRkIGRldmxpbmsgcG9ydCBzdXBwb3J0Lg0K
Pj4NCj4+IENvbW1hbmQgdG8gY3JlYXRlIFZGIHJlcHJlc2VudG9yDQo+PiAjZGV2bGluayBkZXYg
ZXN3aXRjaCBzZXQgcGNpLzAwMDI6MWM6MDAuMCBtb2RlIHN3aXRjaGRldiBWRg0KPj4gcmVwcmVz
ZW50b3JzIGFyZSBjcmVhdGVkIGZvciBlYWNoIFZGIHdoZW4gc3dpdGNoIG1vZGUgaXMgc2V0IHN3
aXRjaGRldg0KPj4gb24gcmVwcmVzZW50b3IgUENJIGRldmljZSAjIGRldmxpbmsgZGV2IGVzd2l0
Y2ggc2V0IHBjaS8wMDAyOjFjOjAwLjANCj4+IG1vZGUgc3dpdGNoZGV2ICMgaXAgbGluayBzaG93
DQo+PiAyNTogcjBwMTogPEJST0FEQ0FTVCxNVUxUSUNBU1Q+IG10dSAxNTAwIHFkaXNjIG5vb3Ag
c3RhdGUgRE9XTg0KPm1vZGUgREVGQVVMVCBncm91cCBkZWZhdWx0IHFsZW4gMTAwMA0KPj4gICAg
IGxpbmsvZXRoZXIgMzI6MGY6MGY6ZjA6NjA6ZjEgYnJkIGZmOmZmOmZmOmZmOmZmOmZmDQo+PiAy
NjogcjFwMTogPEJST0FEQ0FTVCxNVUxUSUNBU1Q+IG10dSAxNTAwIHFkaXNjIG5vb3Agc3RhdGUg
RE9XTg0KPm1vZGUgREVGQVVMVCBncm91cCBkZWZhdWx0IHFsZW4gMTAwMA0KPj4gICAgIGxpbmsv
ZXRoZXIgM2U6NWQ6OWE6NGQ6ZTc6N2IgYnJkIGZmOmZmOmZmOmZmOmZmOmZmDQo+Pg0KPj4gI2Rl
dmxpbmsgZGV2DQo+PiBwY2kvMDAwMjowMTowMC4wDQo+PiBwY2kvMDAwMjowMjowMC4wDQo+PiBw
Y2kvMDAwMjowMzowMC4wDQo+PiBwY2kvMDAwMjowNDowMC4wDQo+PiBwY2kvMDAwMjowNTowMC4w
DQo+PiBwY2kvMDAwMjowNjowMC4wDQo+PiBwY2kvMDAwMjowNzowMC4wDQo+Pg0KPj4gfiMgZGV2
bGluayBwb3J0DQo+PiBwY2kvMDAwMjoxYzowMC4wLzA6IHR5cGUgZXRoIG5ldGRldiByMHAxdjAg
Zmxhdm91ciBwY2lwZiBjb250cm9sbGVyIDANCj4+IHBmbnVtIDEgdmZudW0gMCBleHRlcm5hbCBm
YWxzZSBzcGxpdHRhYmxlIGZhbHNlDQo+PiBwY2kvMDAwMjoxYzowMC4wLzE6IHR5cGUgZXRoIG5l
dGRldiByMXAxdjEgZmxhdm91ciBwY2l2ZiBjb250cm9sbGVyIDANCj4+IHBmbnVtIDEgdmZudW0g
MSBleHRlcm5hbCBmYWxzZSBzcGxpdHRhYmxlIGZhbHNlDQo+PiBwY2kvMDAwMjoxYzowMC4wLzI6
IHR5cGUgZXRoIG5ldGRldiByMnAxdjIgZmxhdm91ciBwY2l2ZiBjb250cm9sbGVyIDANCj4+IHBm
bnVtIDEgdmZudW0gMiBleHRlcm5hbCBmYWxzZSBzcGxpdHRhYmxlIGZhbHNlDQo+PiBwY2kvMDAw
MjoxYzowMC4wLzM6IHR5cGUgZXRoIG5ldGRldiByM3AxdjMgZmxhdm91ciBwY2l2ZiBjb250cm9s
bGVyIDANCj4+IHBmbnVtIDEgdmZudW0gMyBleHRlcm5hbCBmYWxzZSBzcGxpdHRhYmxlIGZhbHNl
DQo+DQo+UGxlYXNlIGRvY3VtZW50IHRoZSBzdGF0ZSBiZWZvcmUgYW5kIGFmdGVyIHN3aXRjaGlu
ZyBtb2RlcywgYW5kIHJlY29yZCB0aGlzDQo+aW5mb3JtYXRpb24gaW4NCj5Eb2N1bWVudGF0aW9u
L25ldHdvcmtpbmcvZGV2aWNlX2RyaXZlcnMvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIucnN0
DQpPay4gV2lsbCBuZXh0IHZlcnNpb24gd2l0aCBkb2N1bWVudGF0aW9uLg0KPg0KPkluIHRoZSBj
b21tYW5kcyBhYm92ZSB5b3Ugc2VlbSB0byBvcGVyYXRlIG9uIGEgcGNpLzAwMDI6MWM6MDAuMCBk
ZXZsaW5rDQo+aW5zdGFuY2UsIGFuZCB5ZXQgZGV2bGluayBkZXYgZG9lcyBub3QgbGlzdCBpdC4g
WW91IGhhdmUgMiBuZXRkZXZzLA0KPjggZGV2bGlua3MsIDQgcG9ydHMsIGFuZCBubyBQRiBpbnN0
YW5jZS4gSXQgZG9lcyBub3QgYWRkIHVwLi4NClRoZSBsb2cgd2FzIGxhcmdlLiBXaGVuIEkgY3V0
IHNob3J0IGFjdHVhbCBkZXZpY2Ugd2FzIG1pc3NpbmcuIFdpbGwgcHJvdmlkZQ0KY29tcGxldGUg
bG9nIGluIHRoZSBkb2N1bWVudGF0aW9uLiAgDQoNCg0K

