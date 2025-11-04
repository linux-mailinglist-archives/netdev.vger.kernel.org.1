Return-Path: <netdev+bounces-235429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E165C30672
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 11:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506663A3EF0
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713AE2D0631;
	Tue,  4 Nov 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="P/qMBIBe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6392D1931
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250329; cv=fail; b=BTe9IzVH1rIS5kTD91GcS4lvY9rHV3FWdwowQ5zjH7jTugVboQ9wayzqNHPxLFgQiWnUWuAnV6hTHBO2GuyuozVCIO4jvlta5BsPRHVJITlXttx3RI8sEYz1W/AxkWFvoaHX1jMt40taxEGqb+gLFksSZZIswECmypSQ5gDkfDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250329; c=relaxed/simple;
	bh=hzZcl4Ft03ykd6LNawVi6ijHfHG5jBb8J+r/toafE4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dIBoYhnO0qbNepMcNFzYw7MaiVZ5XxXSRz+6/L2PcwEzRtiXa7jSeC0aRlSKpKzue7zvGsXQ259hY+Pe+ZoXIMOQVgBKMDtyzY2Oh5Ne92GUsrIHK4KRh8eFPwdFE551QHj1MxWbJm4EqQ1zwDIWFziyFco8su/rHq5PccJLNDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=P/qMBIBe; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A49Fhau1955542;
	Tue, 4 Nov 2025 01:58:40 -0800
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020101.outbound.protection.outlook.com [40.93.198.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a7epqg3fu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 01:58:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuKKFfRcE0rnTlx3Joj9nVA174lBBDSGp7i1iORAJ/bvd6S45wJs9+6ip8A1U2TofsBQhyFvN/hYtgJEcdhJ4J7GHeucDd94nyA7fACnvBjJ8g7eZXjlx5iPfYME9xJ8rLh1iajbCe9/tlvLltvkjimnkyt4tGJLo4MdVg1nbUXZfZPcQ3gNgTuDH1wrYqTulfqPIkos26oD+40/ZSjOJJ7craEUKZl5J+yE/2FzMZSx7DsMI9AEPwzHIug9IbxF5YAWPmq9HOrqeL0W5jUa8P9ExuSSwmjKp/z3dbkOtrIQA+YQUFjmcayJYBd/U6jtIn7/rGQFoKQXaRulWmkrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzZcl4Ft03ykd6LNawVi6ijHfHG5jBb8J+r/toafE4U=;
 b=ycOUOqR9jvKJnPl10xRoPLdASeTv6vNyhMnCHKYAw85kD6gGYuAkUv88nKXJWiS1pfuzjLYzegOMIaKvpnRaD5z9nJlyueok1BqA8cYg3+YU2GuRZ07y/glQCqqTkX5WK0b8Hf4bfjuVTSjGBsYU3Cr8hCsNBLR2HWApDuyv6xoaFYTr4CRyqYovfGYt3ZeDDx4x7uG8Vrbg62Hf0PBh0w8FzdQeAd8daWuLU53Z2rT//0nlVo78vqvQ/Ij1Cd9xQg/5mIlG2Ryzcqm9+qFVZoZofBkWJmDEsU59e0c7BPGe5hwwcwxjY/67p89+BAdcUzJeNPse9YE3UxSRKO4eyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzZcl4Ft03ykd6LNawVi6ijHfHG5jBb8J+r/toafE4U=;
 b=P/qMBIBe9Ih/gV4ne7arYmJXSJsZDTdG/Tt4QnEqqeGmOJGpC33rAF9HGcD9WTKvsyysauBxd1kLwdiUFHTkZZPp5TdTslJBBHB8BiYwInChSl6o8Al7OLMiGAErHQI6pJbllCOSt19vgcB/B5CxIE502S6HcKYD1wCsNTdIDBQ=
Received: from MN0PR18MB5847.namprd18.prod.outlook.com (2603:10b6:208:4c4::12)
 by SJ4PPF053E84FED.namprd18.prod.outlook.com (2603:10b6:a0f:fc02::f06) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 09:58:37 +0000
Received: from MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0]) by MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0%5]) with mapi id 15.20.9253.017; Tue, 4 Nov 2025
 09:58:36 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Donald Hunter <donald.hunter@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE:  Re: ynl with nftables.yaml
Thread-Topic: Re: ynl with nftables.yaml
Thread-Index: AQHcTXGWN6pRDkyPJE6zRSzawH36Lw==
Date: Tue, 4 Nov 2025 09:58:36 +0000
Message-ID:
 <MN0PR18MB58471EE9725D35495B520DA9D3C4A@MN0PR18MB5847.namprd18.prod.outlook.com>
References:
 <MN0PR18MB58472AF35605FF6FC96EE6DDD3FBA@MN0PR18MB5847.namprd18.prod.outlook.com>
 <m2o6popoeq.fsf@gmail.com>
In-Reply-To: <m2o6popoeq.fsf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR18MB5847:EE_|SJ4PPF053E84FED:EE_
x-ms-office365-filtering-correlation-id: 82f6312c-a749-410c-30cd-08de1b88b8d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eENwRG5mK01IU1dkTkhqZHZOYUhpbGttSS9HeXBCZWRYT0xKbWtjNTQ1REtO?=
 =?utf-8?B?R2NxZ2F3dENXQk95b1gzNXd0MDEyMjZKbG1MRFpyVjEvRmgvUThUK1R6OHRV?=
 =?utf-8?B?dVR5THNveHlhK1ZiVnI1NjlXMWhDVmZPLzc0Mlhya25Vd0h5Ym1PSFUwUWFB?=
 =?utf-8?B?SXpzcUtBbS9JMEdyRXA1NlQzNmU1MGdwNFo0cHdpclp2bnVnODNYTXRidEd6?=
 =?utf-8?B?TXV1R3BnSXZBYVBOblZPaURIeFhTMEUxZWJXMVdIQW1QWEN4Y0FmZmkrVCtp?=
 =?utf-8?B?ZmF3cEdkc1JrQW5BOWNxL09CRUZHMUNHb3B1ZUhlMXAySnRueEtnR0RlelhY?=
 =?utf-8?B?cFRCUnhqZHFlVzZySG1xUkJZd29JeEFqNUhKc1lTTDd0b0ppeVpJa0h3Vjkw?=
 =?utf-8?B?VXlJeU5nc0lYK3J1QzVWK3FEZDZUU1ZjMFVQU241dy81MHJkK3R3TCtRSzZI?=
 =?utf-8?B?KzFwSFdjOWJTMGd5ZnBTSi95Sko3RG5ZaE9tV0N4YVFUTytUSUdrQUttejdY?=
 =?utf-8?B?b1cwTGZsQTRrU2o4TDZpNGRidnVoZDJUT05MMUNLRXBaNFJSS2RTdWRFaVRx?=
 =?utf-8?B?eW0yWG8yc0U3SmhtMm14b0MwREtFMTNUTHJEV0ZuSlBHUUdlK2tkVW50STZj?=
 =?utf-8?B?UHRhYXVYSjFBUkJ0NDB4amo1cXVpUDBPTHpVWlpZWHZwQlI4WUpGbVZlZG1k?=
 =?utf-8?B?Q0hhbFMzQTUwQmpiUXlQVDZQU0JSemVIaWJuRFRiTWZETS8xenJiY0RMaXcx?=
 =?utf-8?B?YU1XWFh2ZnY0Z1h4L2M1OE8yMkY5VzhwZ1VYcXJWYTJ6Szh4T3ZFYlVVZmFV?=
 =?utf-8?B?MCtzK3RVVkFlSzFBS3I2V25lcDdBaW9RaFRwY1BaVEpHSS9oeit4S09scDZC?=
 =?utf-8?B?QVF4aXNUK1pWRWpoUXlXZ1dXbHNvQ01RY2F5Wk90NmxibjhjU29ndk9IajNp?=
 =?utf-8?B?R29VRTgzbFNzYWJBamJCUDVWZG8xRS9KSkllaW84TW91UWUvaFlJR0JBOHM0?=
 =?utf-8?B?Mmc4ZnpYckFuVEMxcUdCZmtDNytxUnVZT1d3L1dhZm5kZHdHazJMYVBUbVA0?=
 =?utf-8?B?TENWbjhicEpRaUJ2bGxhL1hGOXRKNXJ2TUpDclk3V0wzSmpqZjVGaUVCZTNs?=
 =?utf-8?B?MjZVaTNvcHFjWXlKUEkrNmpkaUF6QnkrZjJuWFpuREtHc0JxMytyYWhuZTFK?=
 =?utf-8?B?eXVVb2FtNWV3a1lrb0htS0J2VjdiR2RwTHg4R29QMjJEVjBrdXdoOHJyUHAv?=
 =?utf-8?B?c3dvYlFleFhZVUhzOStVNkJWV01VNGZLY0dHZjgwQWpZQlNSejIyYWthZTdW?=
 =?utf-8?B?cVNIOEdFbE9EU2tnTndYZFFIUlJ4S0dkOEpWY2doWjNGMkUyd3ArdWpmL3ZE?=
 =?utf-8?B?VmtCRC9mSXpRcG51TTFGOW9aRWR4VmtQOWJobXREb1hWRDlKd0RWYUF6WUJ1?=
 =?utf-8?B?dWZ2eHBtT0l6bm5SZk1rWS9Cb0RQWWpLY2VZdUtmMThJS1kyQjZwbnhBZTFE?=
 =?utf-8?B?TGNSL1NxVzlUbUZOWWFVYnpVNnArcC9yZHpjcEw1bEt1SVdxYnRxVUZjMDFD?=
 =?utf-8?B?dmVwVi9wc1ZCMXp3MmNqYXlDdFBXcThpMGhCNGJFK2xOekZrbjQ0OXMwT0Fa?=
 =?utf-8?B?bmZjREpaei91REZzRG9vSEdlNkJjMmpYcWYrUkhaMUM1Q1BMWTc3Tzd3cFR1?=
 =?utf-8?B?c21RUituQjFGMmIrM1NBYXhGaTU4T3VxUG1TWlFXaDgzSGR4RVc3RzVXRitG?=
 =?utf-8?B?RU12RDhqYllpUm1jYnJ1TXZHNUtJU3k2aGRSY3ZTOC9YVnVjR0VBNkNjNStP?=
 =?utf-8?B?WlZNeGhwMFZmS1JPRnFUMXZkbW5CTERkdGxJVjVMWDVSKzd3dUFLREFpQ2FZ?=
 =?utf-8?B?QTFwQnI4RmpnOVVEKzBmc09iTEk5c2lGdzkzVlA2aWNZRHJaRlZrVTJrUHlO?=
 =?utf-8?B?c3dtb2JuZjYzMGVVUDlqMmx4SzJ1ak40cDNxZXptK1RNMUVhNkRrMFpvM2w4?=
 =?utf-8?B?Y0dGckVSd0JRKzI1ZTBacHlKMnJuaEYxenV3MG5hSkxNK2ljcVJQV3hTcXcv?=
 =?utf-8?Q?HhAhgd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR18MB5847.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXNvSWR2NldVYjE2c3VoUnZSdk9WbG9DMEw5Qytrcjd0WTJqRDBLQ1MyM3d0?=
 =?utf-8?B?NmJOcXdJODluWWZJT0o3UzVPdnBpOHExZUxKRXM1dkVHcWlTcXZpVUw2YXNu?=
 =?utf-8?B?MElsWlk0cVZ5QVliNXNXcEM2NkNMdENaZ2gxVWY3WCt0WDZhZ2M3MXRJVktR?=
 =?utf-8?B?SFNRakVWY01DZjRMVEVGQjg1OWcyWk5iK0hEV21lTGFKR0VIMC94ZlAzbVhQ?=
 =?utf-8?B?SDVQQ1VJNklmOGFIbnpuZjlEVkNPVUdmR3duR28wSjE4a1hieEsrMGpUZUJD?=
 =?utf-8?B?ck1kbUY3NGFwS1ZreUp5L1BzL1Yzdk45UUlvbWJvRm8yWFdQTVQyM3QwekJD?=
 =?utf-8?B?TUZFQTVaMlpJRlNzcDJTN1FEWDYreEtOMWRRL0RpaXV0d09HQXFiWE03cmNW?=
 =?utf-8?B?UkZ1RnFic3N2eFlDaEdkZE5rWmc0LzkvR0RweWRzUzdobGVBVENzdXlqVjhj?=
 =?utf-8?B?d2thejJjWGN6TzNDdEJDb2dMMEIxMndDNHlPNDlZbTFSdGxJQW9sT0UxbkpN?=
 =?utf-8?B?NXBBQnVNZ0JOSkFFWVBoQlRxa09XTHpYdk5jZWtmemJGNi9LaElZOXdMcksy?=
 =?utf-8?B?NTNBU2hOR1hRNy93RjhlWXQ4UGRWRldBVlZURm9YMGRhemhlbnQ2VG5keUJN?=
 =?utf-8?B?TDZhM1FYaC81ZUl0TmtFTEtRV2p6cG5iZFdsSFJrTWRPVWNzSForbXUzMjZh?=
 =?utf-8?B?OUNsdlVjbDNmTVgyVzdXLzhVdXdXYU8weDlJQmgycjVaNnBwdStvYkdmSjBa?=
 =?utf-8?B?VkhDV1hYei90d1pCdDUrWnJ5M0h6a1ZHMHFNSnlybytNSWM1akNPcHkydHNi?=
 =?utf-8?B?dFhFYzZ1Z3lXeXo3YlJOcXFpZi8ydU9GbjVzbmxzQ01SZ0dTWFZMVy9uV2du?=
 =?utf-8?B?Q1FwQmc4SW9JU3lSb21NTWxSMmZiUndGVGs4SmdVK0Q4bFFmU1ZRbVE5QkVn?=
 =?utf-8?B?a1g3N29zVzZkcnVnY1lDNVlhOGRnTGdFaGd0Zy9pNm1oakhpcTlDN256dERF?=
 =?utf-8?B?b3hTVC94U0t4Z0hEaU1IaFIzblI3ZFFsZW9PZ2dvbW1ncnpQUVJ6em93SDkv?=
 =?utf-8?B?M1hDU0w0WDdoc0ZqVlU3eXpCekRnK1k2Rm1MSnBnWG4zSlhtbXNFMXp3MTZ1?=
 =?utf-8?B?SGhjcUNYN21RMlZqVFVlUjhJL2h1MUZvMkdTQmNqT3Y1eG9UaEhRVDZpTjVx?=
 =?utf-8?B?N1dLSmN6bVBNOUQ4Y241ellka3ExN2pFZEFJSkxRaXJIdzgyN29LV0J3bkZT?=
 =?utf-8?B?dGl1VkJrVXRKY1hHdTFpSXM1ZDBob3ZwUWhVTjlZVUR3YU1UM3pmQnV4eEE0?=
 =?utf-8?B?WGo5ekhsRTJ2ekIyZ242RjlLclByWXhmenpCYWlKMWpMWC9ZdWhIV3E5K1Fp?=
 =?utf-8?B?VGZJSUNjY1ZVT2tpWDBndThTZGtVTTBSMFpkWUkyL2YxdGJ2QWpTUlovRGFN?=
 =?utf-8?B?YTlXUmhRcXg5bGpiUkIzTFkwNUNtUnZmY2hxZTl1Vm1IVVo2SVp6Zi8wTmQv?=
 =?utf-8?B?b1J6Wk5JM01KeGsxRjhuMHlEZVhKeWJxWXhlSWFIeHNEMFB5WkY5NWw3SDNn?=
 =?utf-8?B?amNET0xoVjVPL0FEblpFWmF3bVRyNXdabGcvRXowR1pTdWJBajM0dXFIYXhu?=
 =?utf-8?B?NE1sU2MvYnd6aHJIUk5paTJYQVB3S01JMkRLQytNV3pFeDZuVTJGT0xneGdH?=
 =?utf-8?B?dW40cGVEWkc3K3VVQU93aldMMGZBRHIyOGtjVnlVQkhQbG9mdkVxSzYzd0tn?=
 =?utf-8?B?cU5rT1haNExyV254dFlrQkVLRjJ6b3BtR05sS2QvSER5QnlLaXo1dzJrcy9Y?=
 =?utf-8?B?V3M2L2IrM2RHaXRIckJlNzhDbm1aS3VweGltWU5SblI2eVlLUHFPaUhoNmU5?=
 =?utf-8?B?K2tRVU5qQnR1SjJ0cGR4U3EyeXNBcFVFS3Bzd044RlhaWHZFRktlR2ZxQ0hU?=
 =?utf-8?B?REJocVBuQ0JYd0dOVjh6SnJiZHRCYWc4UGRkTTFibHp2Z2xSNysvNXlxN1VI?=
 =?utf-8?B?VjdvOTU4aHFIN0RiSWdPVUxSQUNOZHFiOWxOQ3QvY1RxOFRpNmh4dFQybzZ4?=
 =?utf-8?B?OElPQzVtcG9GWmNmRWo1UEU2SWZHR2NydTlWU3lqNWowVzJFK1J4UzNXNXlD?=
 =?utf-8?Q?/Yns2eP9uVnOKyq61WuK4fo+2?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR18MB5847.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f6312c-a749-410c-30cd-08de1b88b8d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 09:58:36.3373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pBuHypWFpZ0CvYggQHS/KZmJxXQEmb0Dpqg7ANiYZnxPnKoqrGmKKlDcqm3ouvd0ra25Gj4WHN4nEPOn+k/wUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF053E84FED
X-Authority-Analysis: v=2.4 cv=EuHfbCcA c=1 sm=1 tr=0 ts=6909ce50 cx=c_pps
 a=4RNThKpk0f9J61SA+MS+fA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=v-Zxk-TfWeLOVzvglycA:9 a=QEXdDO2ut3YA:10 a=EO9eNXdD_PIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA4MiBTYWx0ZWRfX2FkB093DqyXu
 ePmmrflf+0Q4qZEjG1YyhmI9NOZK62+QcuaDs8w95Fo5p58Uml1zMFTeHqmogK59asdKXIk9Y8z
 DFaXTLEGMqFvK9p/YPdvthwtAPgAL43K+BHJFzSq7iNEEMo/H6L/Ly/YoBphtxCa1e+uO05vgkZ
 1roaEtkSMm0+kBjAMLOdmHgGICK5PdI7/EILaklixZYFjHNqCdF2srvh0idRWazfvA1KxPFlTVl
 r6GOpno9A8iG1tSmCYWKXKz3Ai2DAOtBEuJm9dOj2PQhTtIE7CL9YHjJznHDE1fzVYTtuQIn2zZ
 lyFKP7V1XG5t2RyaaiAPNJecr29UGIlzfZV38HzCaY4JNAFzg2ofyHKqEq8Rkhmhv1pec0JzrfN
 TyL+8UVD7oqddhVYLjNJ3LkgrQgMKg==
X-Proofpoint-GUID: SiTpv8MQ_WP1Zb8zbQ9Cz2TfoBFfrRu9
X-Proofpoint-ORIG-GUID: SiTpv8MQ_WP1Zb8zbQ9Cz2TfoBFfrRu9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01

RnJvbTogRG9uYWxkIEh1bnRlciA8ZG9uYWxkLmh1bnRlckBnbWFpbC5jb20+IA0KU3ViamVjdDog
W0VYVEVSTkFMXSBSZTogeW5sIHdpdGggbmZ0YWJsZXMueWFtbA0KDQo+WWVzLCB0aGVyZSBpcyBh
biBpbnZhbGlkIGF0dHJpYnV0ZSBuYW1lIGluIG5mdGFibGVzLnlhbWwuIFRoZSBhdHRyaWJ1dGUg
c2hvdWxkIGJlDQo+c2V0LWlkDQoNCkFmdGVyIG1vZGlmaWNhdGlvbiwgY29tbWFuZCBqdXN0IGhh
bmdzLiBObyBsb2dzLiAgSG93IHRvIGRlYnVnID8NCg0KLVJhdGhlZXNoIA0K

