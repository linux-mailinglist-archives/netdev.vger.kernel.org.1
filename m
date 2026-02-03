Return-Path: <netdev+bounces-256454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNE1DotTgmliSQMAu9opvQ
	(envelope-from <netdev+bounces-256454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 20:59:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6ABDE504
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 20:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BB6A305E998
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 19:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621F7366DB9;
	Tue,  3 Feb 2026 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kUgRtqZW"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88E2F5311
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148700; cv=fail; b=VI4Vm3aAIY7ztlCkc+AGidELVG8fYou5w6Fxvxsi7NM3kvVxKxeabS4RMNubvYv3ELHTm5HcrgcI7Av0r+tszuVubOXYSx/pOrBslRJD6IPvA1CzSSMdpIeAAPpLins3yBZTfVfVW3cIY1lQBfUysuqbimamNIzRyC2Lm9GdQGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148700; c=relaxed/simple;
	bh=qN+pKhVNqWJtPJnBRZBv3Nyy5GABe8ZCSqj99DPDbx4=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=YWHs1aTNGq4tWvIXGgyabjX5eDJjjxhS8irDz8p3+tu4KOWOK1BfN/dZnt56HY+phUXsBei12tD14mIqEA0Kc9QqO1tTUaTA/0padWqwXmZD8aJ+HkHW3t7txsgsina7y+wiMJsmIk3y8xmPIcqEW610DCHmk3d81osqi//tKLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kUgRtqZW; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChdNyROzPh3I/2pVNrqgQYMq+GbCHFt5Xk5I8uAnhiOGb4H08EbfJnvTXOfT7I8GHyKm+tVlI4hQy50zZcFStSzq6mdfHD8SygK2dtCcGoukJR0m6Hi4vNFqBfHySbQPOWU6wNwXJf2aGrOdg7GavkwDfVR4Rmj2c8MEQ6W9U2k8RI8Q6MCKvz9JcWEXWFJxI6E82mtH2ROqb4E9OgFg4TUuUd1l2InHETnpg1n2eVXjQ+VDEBHryRGrl5ifVf8C7y0OGFQcaNNVI6K9jA5H1kLBfxkuNI5dzyDRL1WG3rWhFJI1gvkYkcwLDqEm1v/2QXC0VeYFMOoSBBF1JPHXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN+pKhVNqWJtPJnBRZBv3Nyy5GABe8ZCSqj99DPDbx4=;
 b=ElBJ8tMeBpPjgBu5WtljVGj3YyndEkqxUx4YG3ARQTNApYdCOnHib7nBapIK6oxO0XIc4/DcJ1TGSff5jjeWG5wH62Nytk7V2LpfCBxgxj5R+4mNMcA0UPnjvSdqguZhwla/2t0oKStHCmEobPu7s/B8ObQEbDR4kFkQaK82ar9i9PwKjnJpoelp8rOXRmgyhypCCAPX5Q4rucUs2cor7an4zmhvYH5C4GdzsJgsLdzVoCk8Km/xy2yxqBhwOhFRrTzckDsGLZFsZpNRcEdoMzPbkD1Kbo9FqV+rVPiw9IGJSDXAxRZkO2WhRshl7YVrUnVBSpba/asz4y5a6FowrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN+pKhVNqWJtPJnBRZBv3Nyy5GABe8ZCSqj99DPDbx4=;
 b=kUgRtqZWYBDDqcK0EyU7zayYcEMbRRRCLlsF+N3R1LEBDPnePj0Ki/1JKN10VQQ5HJOOIcddtzjnt8UTBMEWrGNlVkUEBZvcb2vb8WCoago7iW9Db27oZYWc+jNSMUSSyLuEmzof7sKLNIPMJVJ5ppagJCCNtaG6YP3UcASefg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 19:58:14 +0000
Received: from MW6PR12MB8900.namprd12.prod.outlook.com
 ([fe80::ff2c:ccff:3267:b91]) by MW6PR12MB8900.namprd12.prod.outlook.com
 ([fe80::ff2c:ccff:3267:b91%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 19:58:14 +0000
Message-ID: <c4b5955a-8ec6-47ac-913d-4a959e0b477e@amd.com>
Date: Tue, 3 Feb 2026 11:58:13 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
Subject: net/xdp: Potential issue with xp_aligned_validate_desc() in
 multi-buffer packets
To: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com
Cc: sdf@fomichev.me, netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To MW6PR12MB8900.namprd12.prod.outlook.com
 (2603:10b6:303:244::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8900:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: b3491b98-154a-4a95-3ada-08de635e90e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0Foek10aWpKc2FnYmd2L1B3QThkY2NubjY2UlZITGZwQ2JLZ1E3TVEweHlk?=
 =?utf-8?B?SUIxZVUwVk41K3NBbWo3Ulk4WFVOSTJJbUJxdDdtd3ZjaW45d2NXUUptOG9t?=
 =?utf-8?B?Z1BGUWNYaXlFeUs0Z2Myc3k3dVZwY0FhZm5NeEYwaG5LOWF3VUUyNCtRY0cy?=
 =?utf-8?B?RWxtLytrVTB1QWpnZEhRdURVNlZBYjZRY3pqN1ZTS3MwT25NM2Q4TWI4UjJY?=
 =?utf-8?B?S2M2di9wQldjR1ZlOVFkRC9OREU5bk9zdUxRR1o3dkRZd28xbTFjRjFLV0ZY?=
 =?utf-8?B?eVFzMWRCdjBvckRhQXdIb3piQnExU0drMFZSRWJ0T3hIS2Z2MjI4TjFZZEJH?=
 =?utf-8?B?clVLdHBrVjlkNHI4RlFGMGlBT1Z3T1BhZlhoMlFPcWI0OFVlamZSQVlZTTM4?=
 =?utf-8?B?T0ozSDJOdHBLcW5wbUd6TjZXL3dnRjdBTW1jQ2hLUDROcGFLVmNUUGdRTjly?=
 =?utf-8?B?MDVsNzlwbTJKV2t6QXA3TFAyZkFkNFVPbVJNUkhZUC84WnJKN1BDNy9sRWZY?=
 =?utf-8?B?RVhkcG01Nk1xRUU2STM5dWx1bDVBV2MwcnhLajVLZnpMemdOVFlQcXdBWXJk?=
 =?utf-8?B?NWkrb3pyeCtURmVYblBXVUwyNmpYUy9oWmlOSGdmYTRnRkxFa1JVOWNydFRs?=
 =?utf-8?B?VFNGclJtMkFheVV3RVpGemhTSnY2bk9XN1F5blZ0MUZjMVdoNWtXeGVUcyta?=
 =?utf-8?B?N0dZd1kxbVFVWCtJU0VFdnpJQnR6dDJsVk0vT2pKV2xtNm5TSmZwWDlVZk44?=
 =?utf-8?B?YUVSWHZ5bCs2MVoxMXlBSU5STHhibEJnV2xqcDQrZ2F4WHE3RVhtek12T3Vh?=
 =?utf-8?B?aStORWJYWGQ1WjhjTTNoWTNzWEdBZDE2SFlxYUwyKzRaNnFqVEVWQThQYUFN?=
 =?utf-8?B?RkJHbDlYaDBuOUhyOWlDaWpweFlKVFUvbjBBQVdteVEzSVRuR2FVM1M4SFpY?=
 =?utf-8?B?R29WMzdqRXJheStrZXREY0dWTk5qdkZENXRQUnJyekVxWTlDNDhNeFFKMWQ2?=
 =?utf-8?B?QUVhckg2VWtXc2x6QnNNL0t3MXY0NWlzc3Rld0d4SXFRUGp1dTVleHJSdzNG?=
 =?utf-8?B?cXpPelRXMVo3eVZiYU4rSzF1MVNhK0ZEQkRlc3luRlZaWEdIZWYvaGJrMm4v?=
 =?utf-8?B?S3VSZ0h0bHh4VWxmMXNNMGtTdFphSGJZaWNXMG8zc1Jnbm04OEdJSW85bkVD?=
 =?utf-8?B?REV4OUgxZEJ4MjZlcWtlN3dTYWhyd0hQZmt2SjJpeGpTQXY4OGFaQVVmb0h2?=
 =?utf-8?B?KzhmZjJFWGxSM0tjSmlCSUdQcUVQS3JWU1d4UHE5aGRoanBvaVEvaWdlaUhE?=
 =?utf-8?B?REJLZllrNkxZQ0hQZ1pOVmpIejBiUUJITzZiSC84b0UyQSs1ODlCY05vVk1o?=
 =?utf-8?B?ZlozekxWcEVjSkhObUorSXFiSHZ1Q25CZEh6T2Rld28wdGZ3TWVOTUpmNzhE?=
 =?utf-8?B?ckVyR2FNOEtkOGhHWWE3ZkFSWFUzQjZuTnpkbk9QVHROaCtsNkFuRDFCZ0py?=
 =?utf-8?B?MTFCQVBhOVpYU1I1cFpaTkZxODhJeFhIVnhWanpiZDk0ejhyOS9idm9YcytB?=
 =?utf-8?B?NktMMDV0WEpyYnZPcnNiTWlubWgwbnQrLzRqKytjdGFvb2FnaTF4V0FNZThL?=
 =?utf-8?B?WllwM3ZEM1JHOTNXdlJ0VlJqUEliR2dGMWpOOVVSWFpwek5UdWxwdlZmV1R1?=
 =?utf-8?B?WDJBNFRDRXZGRlFUQmhROUVlVHB5WDd5OTZxYzVlZjVyRU5FTXZOZUJpVVVs?=
 =?utf-8?B?c2FaZE9RemdXUzYvbTU1QTl3WTR5TUViMU5ZK1pOR1hYWnJQbGoyVnRiekFV?=
 =?utf-8?B?anhqWXlKQmZaSHVGaVQ5L1BQdGsyUytNOW9lU0FXV3ZJWjA4NmhPd3hlaUda?=
 =?utf-8?B?czFoUlZwb0lna21pSmpiYTFpWWprNTloNmRJd1YvUnRENjFUa21sT3JOcnhm?=
 =?utf-8?B?SFRtMHBldEJpRm5ScGV5YXYwMyt2Vk5xYmZINFUyV0labmxHT0pxTS8wTWVI?=
 =?utf-8?B?Zitzc0QrcDhIZ25zNTNLb1VEcTdLaTltaHVxR3BwZ0owdHByRUd1MHNzOWFy?=
 =?utf-8?B?cDFGc2lGRSt1UFMxbWtYOGd4b0ZLTk1BeklrU1JpNjRKa3ZPbGwyMkp5M1Fn?=
 =?utf-8?Q?qWX4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk1JN09lWjhBOE43YlpVZHV5bE16aHRpaWFxUWJ5dExua1NQcjRObk1uRHFF?=
 =?utf-8?B?ai9tNHZrUEdHeVFvT1hIQWVSVjJsL1VlMU43KzN1anhYaEkwdGNYU0xSY3Bo?=
 =?utf-8?B?MmltZ1p3ajgvTEhKcGxja29Wd2VxS3Z3dmFZaG5CVTc3TkIvSk5uT1FyRElj?=
 =?utf-8?B?OXJuZTJUclA4a1U5bVZzcWV2OGMwcGJEbURMUEZFaUF5TEpRdG1pdytmRGdZ?=
 =?utf-8?B?M2R6SGdNeUg0eGJOaVF0WDdYYU5qL0lUNzlONG0yeVE0UFFSaEU1alI5d3NR?=
 =?utf-8?B?K1BSZmYwQzVIOG9MVThPOUpjeHQyTzJSTW9ZZnZBL0xhK2hpSnVqcjZkU0Jx?=
 =?utf-8?B?WkRTUENsYkhVemR5djRvbFdHUmJ2cnk2bDhhVWZUNWFPS3J6ZGl4Yk5yRHgw?=
 =?utf-8?B?VzgrM0J2QUw2UFFhdDBUVE1HeHh2dXRDZnFxUTBrNGpBUllrZGZhd1pMN0VN?=
 =?utf-8?B?TDlWdEVaMDZ3VjJrZE9xYXhOUWluUm1lOVlJUXppejJOZmZvU1FObENURlJM?=
 =?utf-8?B?TFpiTkJjTEMrOEEydDVWbXA3czk3cWo4UXN6Q1NBbHlEWkx2NnQyYzJEY0ts?=
 =?utf-8?B?U1ZDeU55LytERlF5Q3RRM0EzOUFkRG5jSlQxY1RXTkphNUNnU3BvSjBOeE9Y?=
 =?utf-8?B?Z1Z3QVFWRkp4UjIwSWdid1RxWXZjY3pnakFHb3BqVFl3QjZnS3ZYUWJJVkk1?=
 =?utf-8?B?U0FQY0FScjlDYS8rOUVFbGtENTZueWZxTkM5WnlBOGthVXQ2dTdOa2tNRXhV?=
 =?utf-8?B?K1AzbDR5elJha3NlYTFhcDJ2dGU1OHd2WVlaT2pSd3FpaWlwOFdzays0cjZD?=
 =?utf-8?B?QU5hRktJRGs2ZWM3SEVQNCt2U3BBcGczditSYjEzOVdJMDBhYjlaNXZMMjNB?=
 =?utf-8?B?WjE1Rm8rNFY2eUhlZHRJc1FBczNidFdoQ0FVaDNjN1RSeStjRkNGbVZ4bW5M?=
 =?utf-8?B?OTkva1VVMTRKSHlQU1N2ZWpVaWhjY3FFVHN6V0liQXlnRzlLbVhIaCtiNXRY?=
 =?utf-8?B?WCs0QmMydzR6bFQzcENGSkQvUXBFaVd1anlVMlZXS0pVSmJmRDhYV1BMbXBS?=
 =?utf-8?B?Q05UQmRVOEhtRFVrZ0ovVG1kcmlUZ2RYZlNHa2NmVHFXT0NuOTMwcGd5UUt1?=
 =?utf-8?B?M0sySHQyb2pSbTd6cTVVbkI4MkQ1ZEtKWGE0VGdFS3FlR3VSS3FPYnY3TGFG?=
 =?utf-8?B?eDFZWDdybTM5L002KzNKVmdwTm5HL2hkUWZETXd5bHlKMWttczNoaFFKOGlx?=
 =?utf-8?B?ZlRpdEZEVTg5UFFBU0I5czg3d244ZG15QXhjY2ZUMmJwclRCZ2VMSTcvbXlp?=
 =?utf-8?B?Q0RweXRmQmRDTHp2bVVrRTVJVGs1T2YzYk1aR05jcFJxZGlZbDNTOTMrNXFa?=
 =?utf-8?B?UHFydnhsZmVybUJDeCs0Ty83RzNOL2t1b2xlbWF1cGpBcEFxL1FPSElvdG1n?=
 =?utf-8?B?QVZ3OWd5QkJYQnl2Q2JDS2Flc2N6ekI4bzJwVS9WU09xWHVDdnBjQ210WkV2?=
 =?utf-8?B?UEV6ZGppNkRUc1pxcUhXemFvcmVxY0dWYjBSQ09oczllT2ZyTlEzdzVoKyti?=
 =?utf-8?B?QlFlQkw4TzZiZmpObnVSdDZqRDlaQ0h3Yk9HaEpTb1hqS3hicVZKU0ZRV3dq?=
 =?utf-8?B?aFg2alBsOG5vcXJhNUZlS2VhcWNXcDEyejFiSkJadVBqYlRCV2EyNDV1cDRX?=
 =?utf-8?B?NG1Ea2RHbFZRQXArQkl3eUNtYmlKSjQ5Tm9DNnZ0ZTVRYzd6V2x6YzYwNGxM?=
 =?utf-8?B?VVRjVEhIVTRyWTZraFlTa3l6eHhzLzE0NEd2SU1YTDU2VTVHOG13a1F6Nk00?=
 =?utf-8?B?MnNGZ2xDTkdyOGJVNmh2akpGbnRzQkhqSDUrejFYY1pjZiswZ0U0U2JmVUtS?=
 =?utf-8?B?ZEFYOTVSalRSRkdrM1p4R1lMM1R6SW8xY0MvWDlmRW0vN2lVdm5xUEdpSFp6?=
 =?utf-8?B?TmtsZHAwbUFGS3ZGZ3N0SkxVWC9XWGtoWnU5VHU2OW1pR2FCOElEYWZITzJ3?=
 =?utf-8?B?WnpHNEVIVFZyK2ZHYm1DaHpDNHkvWXJFbFJUV2NlN3dLZUJHMDBtNFZEYS9m?=
 =?utf-8?B?ekFoaFBvOGZxSEIyOGVka0MxMXVzV3daSTFiaFFudy82WnVWa3FOWG9TMTZZ?=
 =?utf-8?B?RGtxL0h4UTJwZGRtVHNYWHVVZ01DRWFoWXFmYk1OdzFNT0sxVnp0MnhYdXcr?=
 =?utf-8?B?eXEyQ3VXNFZBYlQxK2JVUlJPZVpneHZ6b0RKaTR5UXpGN256bnR3bnducW52?=
 =?utf-8?B?bVNLdEMreEM2dVNlS2tyYnpGeC9Lbko2TkhjNEppcTlWbUxtd2VYTWo2V3dB?=
 =?utf-8?B?WFllOTB0UFFFSUxjS0d3bVNCcU5IVS9TUnNPbnZaOHExbXo0R2lXUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3491b98-154a-4a95-3ada-08de635e90e1
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 19:58:14.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t56PsNhYOVAlhZFwwn9rqg5nFPbaisxdNLq58b/f5bTJnaMm/8P5rQmhBXr9Tmv8SWHy39ekKbLVNsz9kAomxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256454-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A6ABDE504
X-Rspamd-Action: no action

Hi XDP maintainers,

I have noticed a potential issue with multi-buffer packet support in the
xp_aligned_validate_desc() function in net/xdp/xsk_queue.h.

In xp_aligned_validate_desc(), the validation always adjusts the address
and length by pool->tx_metadata_len:

   u64 addr = desc->addr - pool->tx_metadata_len;
   u64 len = desc->len + pool->tx_metadata_len;

However, in multi-buffer XDP packets, only the first descriptor contains
TX metadata. Subsequent descriptors do not have
metadata and should not be validated with this adjustment.

This causes validation failures for the 2nd buffer onward in
multi-buffer packets when TX metadata is enabled.

The same issue exists in xp_unaligned_validate_desc() as well.

I'm happy to submit a patch if this is indeed a bug. Please let me know
your thoughts.

Thanks,
Nikhil


