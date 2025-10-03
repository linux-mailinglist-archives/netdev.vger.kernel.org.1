Return-Path: <netdev+bounces-227746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D02CBB683B
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 13:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97965189B66D
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BB72E9ECD;
	Fri,  3 Oct 2025 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ilV1lxnC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836A283680
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489593; cv=fail; b=hZadcpCzfIr/hEV6O7dW2sUa1s8GXWIHiN43V3ZzVI9vZoR6RM7AUkbeqo7X0+6sg9ishHgXDx6lmCZKmuRsOCIolQTUtqT4ZH6BPdxSCiOXC63Avi7sEBYBdftRQYg0AOLJMF7ufn+B6Lw7B4OVbTwJJg9YOZfEGb72M6DsftA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489593; c=relaxed/simple;
	bh=iM6SI85916qFWWmFPMjEzE2EQqdCVZmolV+c4JQvB/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PiR7jwg+KlBusfA/TKjeUNQEThvjkmhjhhrTdclF5mhIAw7MPCV/n3vwgDAdIUxr6joKc238x+XH6PiQuYuqgHtgGzoDDGoOeDLOtYNytNRNq3jiPN0LMO8yiy1+Xse/0TwYtP3mxefGtO4FYg1UGKRqIrnTugh8XAFCWVYhJe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ilV1lxnC; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593ASCsZ027968;
	Fri, 3 Oct 2025 04:06:17 -0700
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023094.outbound.protection.outlook.com [40.107.201.94])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49j34f9386-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Oct 2025 04:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODR6aEfhMpZ2pT0HHWqJ7jIvMDoe+QUWWlmaTkPfiJ4y6GeYiuZI6HMSn6bB4YRvSiWPGcVHizbS8Ex/r7LI6YZqYcxKYwkBnH+F7be38Hr4FC1m0QKpKIeHIVYuBQCRbgbZdem3ya9aDZ7DBhFtfpGsuIh2Hxw/JtKWWtyFXjh4I5mhuR5Nqhjoxy/msGVFOyZ43GP+m4FfXLXKPB/rZ7c/ozKFbQBcSgyx8G7/yPD/dWMGbj9aeq20qAZ7QnyWi0bYj4WA9wPi9uqLJWty1y9Jhnogx9YPW+zenIWpWDpPMdC2TYSYbE9ykjwM2Bx+Q332um2e0eRc/LqfPrJ62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iM6SI85916qFWWmFPMjEzE2EQqdCVZmolV+c4JQvB/0=;
 b=fTlbIgSMhgwG3gMqNYNThoPlaRHVdSoiPMJaJ8mgkMH808PEwAnsWcsRtUL6IVdnu3BFtl3TSDrrBBnMv4OGtRbYrIyK+NLuG42b/RKDRqufh4O0GCtjba5waQNh2ezUSu2PwLUfPm88aCuVZLbKVEIgHaJ0JdrIjCmiXA6/NJ5UXG2HoOLy2L86wmux+jn92u9m5anQLC83iq2qApW0ZEY0TX7tFerGzf11E40awex6Jn6nDZjeJSSdaY8gBwPR+OMNIAUh7z8jMTel3yfc4AFgJd4QmH8lw8cJUdzW2YncMrBry1SzjoE+71mIUfxoU20qHxPjmn0nkdyoHzYPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iM6SI85916qFWWmFPMjEzE2EQqdCVZmolV+c4JQvB/0=;
 b=ilV1lxnCB4kpxGHyLjI/zeNPMw96mPp4EZ65dxIaH9fnOPcbjlPl8Z5xUg85KKz4rigG28LukRKmoxCS0hN0CagLKv6zc7ijmcic5aBWbWfk3aFkdITeITqJdPPKfWQNt0GVK2SO8D2RnMov//bZ83QfRgG+plSPUC/Vz0h07hc=
Received: from DM4PR18MB4269.namprd18.prod.outlook.com (2603:10b6:5:394::18)
 by PH8PR18MB5382.namprd18.prod.outlook.com (2603:10b6:510:255::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 11:06:09 +0000
Received: from DM4PR18MB4269.namprd18.prod.outlook.com
 ([fe80::9796:166:30d:454a]) by DM4PR18MB4269.namprd18.prod.outlook.com
 ([fe80::9796:166:30d:454a%3]) with mapi id 15.20.9160.008; Fri, 3 Oct 2025
 11:06:09 +0000
From: Shiva Shankar Kommula <kshankar@marvell.com>
To: Jason Wang <jasowang@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mst@redhat.com"
	<mst@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "parav@nvidia.com" <parav@nvidia.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        Srujana Challa <schalla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1 net-next 1/3] net: implement virtio
 helper to handle outer nw offset
Thread-Topic: [EXTERNAL] Re: [PATCH v1 net-next 1/3] net: implement virtio
 helper to handle outer nw offset
Thread-Index: AQHcLO1qz0oQQ+pFXkOQJ59mlNKFRrShhpGAgA60k3A=
Date: Fri, 3 Oct 2025 11:06:09 +0000
Message-ID:
 <DM4PR18MB42699169ADEDE7BCF87D6AF0DFE4A@DM4PR18MB4269.namprd18.prod.outlook.com>
References: <20250923202258.2738717-1-kshankar@marvell.com>
 <20250923202258.2738717-2-kshankar@marvell.com>
 <CACGkMEvUMq7xgOndvWUYU=BZL=ZZD1q_LRy=5YFL7k80cYBRRg@mail.gmail.com>
 <CACGkMEskxO4JKXZZiDSi6GgrTg1bRSteaYAAJe1wJ6=Lp5byeQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEskxO4JKXZZiDSi6GgrTg1bRSteaYAAJe1wJ6=Lp5byeQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB4269:EE_|PH8PR18MB5382:EE_
x-ms-office365-filtering-correlation-id: b2798bae-f2dd-4cbb-84e5-08de026cdb3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWN3NXM0L0ZJcW1mU3JjQ1FqRDdlS2gvMUwzcERmMENyZ1FBTVdDcnR5SENJ?=
 =?utf-8?B?KzdWcjNBTlh2RmdMdUtaQnRvdmNsVys5NmZwN296YytwVTB3anIvdWNGNHRz?=
 =?utf-8?B?QzhYYVE3SlV0citJWmJJcDBPUzBHSmVKYzYzcGdxSElCMmVVdTFwdnhuRjBt?=
 =?utf-8?B?VGIwZFBOM3k1OU1nSFZnRGoyRFNGaTAwYUs5ek1rcU1PL0k0ZmtXMkxLSmFS?=
 =?utf-8?B?V2tLb2owVExSeW1DR0w5YzJ4MXYvelZIWC94NEp3YktaVW9IeFU0N05zLzht?=
 =?utf-8?B?dzRQVTZzcTNMcURodEs0SDdXcS81NDJNazBPeEF2UVlsZ1ZMK0JzT3V6cUUr?=
 =?utf-8?B?aEExWGUvbXlkaWsxQWZnTEVTaEV5NmF1UmFtZ09rQkE0cmp5Y0E3UUJIZDZL?=
 =?utf-8?B?bFZBTGxoRnZWdzJwRjhNcy84OUdLV0dHcXcrUE8vWC9Gd1h3eVpyd010SGtz?=
 =?utf-8?B?ZjBoZEkyL1dsMEkwK0VEWGh4QmtEVGt1WkFtbXVUcmd5TzlqQ00veWM1M01J?=
 =?utf-8?B?VnBMa3hSem1jZEtlVnpwdnlhZjZ2SXRaUHNXZFhUd3drWVhxTTZscnZpSkFn?=
 =?utf-8?B?d3pMYWJrRC9hYWd3US8xeTc1UkR4VmJ2NGgvZGpiR3gzTmdLUHNYcDh2VFkz?=
 =?utf-8?B?MkFxcG5Oemo3M2d1c1RvY3dlV2tsWi80NytiSHltUmI3U2Q3Vk1zazVSS3hN?=
 =?utf-8?B?Vks3WG9DYUtiSmFEQUN2UC94WkRqOVpqNnNHWmJ4SE56ZUlyNWdhSTgxbmNO?=
 =?utf-8?B?amtWdDdXM050WC9CY0h1TDhVemswZ25iTUlRK0NpLy92aS9rcmJWakRoTWI0?=
 =?utf-8?B?RXExR1Z3eVY4S2pSWmQ3U3dtODBFeE9MM1N4dGRDeDMzbXhJN2pnNy9zZDNZ?=
 =?utf-8?B?NUtOY3dleWZ6UGJ6TzAxeklOYWE4QzVOS3NZVG1QdWlKU1MzaHA1aGZsUmNs?=
 =?utf-8?B?bGFFUjRGTWExd3NPeFFJZHZCMUtOdG0wSm9uejR2OFNmWkpvUC9NcmNzYUpU?=
 =?utf-8?B?bUF4bUpjMmpMS0ZsYU9ucjZpZ2dMblRvU09weUt5d2xENnVhUFRDdHFnSXRO?=
 =?utf-8?B?bWdpcnkxQWZPY3JPVjR0a0V1MVBINjc3TDhMTFRGUjJxdFJjZzVTYTBxbXNw?=
 =?utf-8?B?RU9IVnIra29pdUZ6Z0hxeEVhL3lCT0JMYlQ4SHhZVkhVdllNa0J6R2cvRGtk?=
 =?utf-8?B?LzAxcUlFem1wZVVnamI5ZW1wTktVMkdvdUtSVGdFRThkWk52YnlyZDV3UVB2?=
 =?utf-8?B?YldPMi9wR1phZTN6dzBGTGp4cHpsQ213K01xajY3V0JlU3N4N3pqSUxIaCtr?=
 =?utf-8?B?bEFNRkJpU1dQR1BHNm1URTJRaVYrT0tMaHdRUVpWb1B6RWMzSjRvcEptOEZQ?=
 =?utf-8?B?UmhsdlZPcFVVMDYydWNpODk5ZEp5SUlSNVBXWWdWSWZ4OEdhQmhHTXZPSWNT?=
 =?utf-8?B?QUY3ZkVKWTc5bXNIMkFjcXlGVlNzUW4wWXAxWmRrZ3hIa2xQVCtKQU5KMUhu?=
 =?utf-8?B?K29ucXpjaFF0UzhlWVBCUFpnY0FBcnNvTjZnRXlIV2IxOElSOS9LT0ZTTjVy?=
 =?utf-8?B?enlXZWpMWitVWWdWak1tbnVXQlQ4cVhoZjVLRGxPcjNJMnFtdlJZMDU4Z3ZZ?=
 =?utf-8?B?M2VWeHZhSXlTajBndXdZNE1MZHhMYUlpQXMrUzNDdk1qakwzeFRNZTY2LzdG?=
 =?utf-8?B?UHowUUp3K1N6SEx5SUZPWWlwekF2aEZEbjdFMzNxVW9tbWhsTmRGWWs2RXZG?=
 =?utf-8?B?dzNOSU0vT242VGJCSm5vN1RCUU14T0lHVGI3T09POFlqeWRKWFRGT0k1dDdF?=
 =?utf-8?B?V3dOMzg3ai9qQUpRakE2ZzhoL0d6QlVPUG9SVVlZenlpT2NrSnpBZVFGZmhy?=
 =?utf-8?B?UU1HQ2Q1enRzSlJsZXl2Q2lVTnYrbzc0YzA5MThJeTR2WXFOUXNuWEdPY1Ar?=
 =?utf-8?B?OEFrWWluTy9FWkVNdHpxNFlITDN2R0JmT254VlExakkzK2JlcDFSZ0g3bnBM?=
 =?utf-8?B?QWdDMzI5TktRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4269.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2dYTXVoOGpDRDhLZDZTN3hzQ08raWJNVGdrbzhsYkNyTnVwV09JNGxNK3I4?=
 =?utf-8?B?Tk1oTzl1a3FaR2VCOXpkTjB3bjBFcFoyLzBvWWZHaC9YN0N6SFF0WlRvbTJ3?=
 =?utf-8?B?UzdNRDNoTUtVeVM3N0FLVFlZNkR3ejBUQVZ1cm9kNzltaWh1WFBUc0dwdGd3?=
 =?utf-8?B?RGZQZGI2MWZScUg5QWdJR0RlN3dSTEErZEd1WkcwYXR0NjI1aTMzUWQ3RUZp?=
 =?utf-8?B?Q0NsK2xQUGtKWkZEdHVCbzYrdDEyako1Y3BYMFVzMW1qT2tKbDFtc2FaR3VS?=
 =?utf-8?B?V1dFL2Q4VXlveFNVOHEyQnFDVHRjeVJGOVdESHY0Z29hMmxReitaUVJwSlBR?=
 =?utf-8?B?czN4TVkzd3dUWGdUQ1h3dGJybmhTb0JIWW94TzBFQUhJbG9PWmJpRE9UQU1u?=
 =?utf-8?B?U2hOUldPZUp6bkRCbmlIRFhNYWdsZmhlUUs3UGNoQXZxc1dQZjgwZTFhcTNC?=
 =?utf-8?B?Zkx1SUdDZlNFeVBORnBwS2hqRm03bFUwQjRCbmVnSnNVaGV6cWxrUjRGdzcr?=
 =?utf-8?B?WkJUNnlXTGNlN3hISGExTHpTb1B5U0RsK05sd3dwQ3B2VlBnYU5rRDg5cUIy?=
 =?utf-8?B?dnhzUHgraUdSWWhMaGhrT01ITUFHL2ZkTUxWSmRTOXVGTlNvYmxPZTRZK3lY?=
 =?utf-8?B?Nm5tQzZjdExIUzFndjk0UGZabnB6amttaWZGVThjaStLcVJIc2xsektaaS9h?=
 =?utf-8?B?VmdnTE5XNGFZV24wU0lhdUtkWHBOYzg1SUhrelR3emp3YTFLVnJjaDcxeHB1?=
 =?utf-8?B?SCt0NFVpTU5rRzZJZllPcUhza1J5VW93am5ocHlvS1NhNE5aZ0x3QktBcjNr?=
 =?utf-8?B?aGQ0ai9OdkFHYVdaOUFJUE5QSXByL0orT1VjMVpBZ2VoVEloRTRjU1FpMkxN?=
 =?utf-8?B?Q3cxb3hBVmhNZVIvZ2VpMFZGY0gvZXJOTFRVVzViN2tScEdlV291SXFxeDBp?=
 =?utf-8?B?Z0Q4YUYyM1FxRWV6UFFhSkVyekNiQ2YvQmRxemo5eExQRWQ4WHhLVmoxNm1y?=
 =?utf-8?B?MTVzeCt5MDBJUFBDWkIxamZpd2xqeVg1c1F1T1c4cmtMeG5QenpxdTlteGpI?=
 =?utf-8?B?M05mK0pGM3d6VmJBVkgzK1k4cWhvbS8zRHZMUjBwcng3cG5wWEw5L29YZ0FI?=
 =?utf-8?B?eDJocUU5VUUvL0NYK1ROc2F2bERSMU9XcUZuckdpbm80MEkzL0V0UkJiditD?=
 =?utf-8?B?OVhZbmdKeGFDdEoxNWlWTXJNOUthTDYxV0dTd0J0ei9raEtPRWQ4MncrdnpC?=
 =?utf-8?B?RjdDaDgyNENPaDU0RzhFUHp2ZlU4UzloSTB5VXRFNFNDUSs2cG8xd3dKRXFG?=
 =?utf-8?B?cFFQUTUxQS9mQnBUL1pvUTdWQ3hCQUFST05PQXBwSU9ZTUdvbkpCMmNPTUhG?=
 =?utf-8?B?OCsrMTNJbTE3SGFpV0JGNUE2YkxWWVFHZUxVekVjMXBIUjc3cnBHYkYrQjh6?=
 =?utf-8?B?YjI1d3AzSnUvMks2S2xGemtic2l5andwSFpaRktSK3dVNFE0Q21zMmZEVmJ2?=
 =?utf-8?B?RnZXbWJHTFlhdmNtdkE0aGpYMlhuSUMremEvanNsTFR5SlVpTkt6dkk2U3VV?=
 =?utf-8?B?UWRydlBmV2Jyd0RVOFE4bWNLU3VEWWJDd2F5a0lJL3BXSFdrdjYybWVWaWUr?=
 =?utf-8?B?Tjg5RjhSNGloQUx5WXlWeEMyL0NFVC9YaTRzMGtaUW91cVhpRmd0ZUlMSkxQ?=
 =?utf-8?B?NkF5SnhnaDZmd25UdzljYy9DR0FsQlNvRWZmOUlDemlrNXFqVGRwR1dvTCtt?=
 =?utf-8?B?d3dqNkM2VmNrV2pyeFZsTklPZmhGOFZKL3FqNzZ4TDJaVXBiZXAxNmRwVjBa?=
 =?utf-8?B?WGQxbGQwdFgvYUxmV1FKM2NuYUhqL2EwMVQxWFBLeERvS1dYRWMxZ096cFZE?=
 =?utf-8?B?UGVKaFArYXEzaW9jbmI4eXN4YlBZZnpJMmFuRGk2UDhvNnlkRjRQd0c1YlFt?=
 =?utf-8?B?QXVXWEEyL3VUbWpkVC82SzhINGJnNVVuRElHNDMwSzlSRWRoS0ZPY1YvVVZK?=
 =?utf-8?B?ZURwY21nRWI0ZWRvcE1nb25ieW5pNWhnRk1SN3pQalJab01Id3ZYMUNKSTYy?=
 =?utf-8?B?c1NLUFZKWGVpcWw2UnNKN1FMSlN0M1A5M3YwV0ZxLzk0M1MzN25BR1BWQWRQ?=
 =?utf-8?Q?a58vrtTmsbet1bcXyxyANqJNV?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4269.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2798bae-f2dd-4cbb-84e5-08de026cdb3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 11:06:09.0795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpsyGxC6vz1czlrr1fbXrs8WvtNbKyltYiw+HUPPdHDLy9JqJxpcgzOVWoFK9Vm4D38L9qdt2rM2AtFLD2BSLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5382
X-Proofpoint-GUID: Vfa5Ucbzu89GAkSTeohfQpgz_uiR1zPy
X-Proofpoint-ORIG-GUID: Vfa5Ucbzu89GAkSTeohfQpgz_uiR1zPy
X-Authority-Analysis: v=2.4 cv=d7z4CBjE c=1 sm=1 tr=0 ts=68dfae29 cx=c_pps a=8Q3VSxVeqSVE8Qz93TfAXw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=Ikd4Dj_1AAAA:8 a=RpNjiQI2AAAA:8 a=zAedfTacrMLYgPLa9uYA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDIwNiBTYWx0ZWRfX4hTaukx2rCng 3FALpyJ50uKxMHbyNUJw+ag0PDfQ81erT6wTF0n8hzdLOFHmmp5zcWL3CQ9+h8qliOrhdB6lpj+ sKQAHRcp9fYoTPpWmMXNhATWx+v9dGkVuSxjtDvlFnFesi1UZnit6TnUR8YkIInbYEzSERArCPT
 xu0iRzwvPLLTbphhUzjk1jLj6708j2GHgE0MJ+Oacnc0NztOh1CqOrakZiX3VUkkXBIcBLIwWEM tShielZFUpL9cI8v7TAjjWcSuAYu6FnPzxPftMYMe9bRbAg2N62DANRnDa4v7syIZhZeD1p6BO1 Pqi1gNfoV3vuK1lkymnDc5OtwVmCD9phwisTjRHLzQdvpKiQAimzd+LUc14sFJik1AuFyTuXa89
 mqMnJg0/Q9kLQbsfJbfqOOq8SfLqeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_03,2025-10-02_03,2025-03-28_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjUg
Njo0MiBBTQ0KPiBUbzogU2hpdmEgU2hhbmthciBLb21tdWxhIDxrc2hhbmthckBtYXJ2ZWxsLmNv
bT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IG1zdEByZWRoYXQuY29tOyBwYWJlbmlA
cmVkaGF0LmNvbTsNCj4geHVhbnpodW9AbGludXguYWxpYmFiYS5jb207IHZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LmRldjsNCj4gcGFyYXZAbnZpZGlhLmNvbTsgSmVyaW4gSmFjb2IgPGplcmlu
akBtYXJ2ZWxsLmNvbT47IE5pdGhpbiBLdW1hcg0KPiBEYWJpbHB1cmFtIDxuZGFiaWxwdXJhbUBt
YXJ2ZWxsLmNvbT47IFNhdGFuYW5kYSBCdXJsYQ0KPiA8c2J1cmxhQG1hcnZlbGwuY29tPjsgU3J1
amFuYSBDaGFsbGEgPHNjaGFsbGFAbWFydmVsbC5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
UmU6IFtQQVRDSCB2MSBuZXQtbmV4dCAxLzNdIG5ldDogaW1wbGVtZW50IHZpcnRpbyBoZWxwZXIN
Cj4gdG8gaGFuZGxlIG91dGVyIG53IG9mZnNldA0KPiANCj4gT24gV2VkLCBTZXAgMjQsIDIwMjUg
YXQgODrigIo1MSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0DigIpyZWRoYXQu4oCKY29tPg0KPiB3
cm90ZTogPiA+IE9uIFdlZCwgU2VwIDI0LCAyMDI1IGF0IDQ64oCKMjMgQU0gS29tbXVsYSBTaGl2
YSBTaGFua2FyID4NCj4gPGtzaGFua2FyQOKAim1hcnZlbGwu4oCKY29tPiB3cm90ZTogPiA+ID4g
PiB2aXJ0aW8gc3BlY2lmaWNhdGlvbiBpbnRyb2R1Y2VkDQo+IHN1cHBvcnQgWmpRY21RUllGcGZw
dEJhbm5lclN0YXJ0IFByaW9yaXRpemUgc2VjdXJpdHkgZm9yIGV4dGVybmFsIGVtYWlsczoNCj4g
Q29uZmlybSBzZW5kZXIgYW5kIGNvbnRlbnQgc2FmZXR5IGJlZm9yZSBjbGlja2luZyBsaW5rcyBv
ciBvcGVuaW5nDQo+IGF0dGFjaG1lbnRzIDxodHRwczovL3VzLXBoaXNoYWxhcm0tDQo+IGV3dC5w
cm9vZnBvaW50LmNvbS9FV1QvdjEvQ1JWbVhrcVchdUszWC0NCj4gOUU2U1JwMFhHVFZ0ajNWSVFf
enlVTWpIc0prLXFCZk5YTll3US0NCj4gS2FhTmkwT1Zia0ZSUWxINmR0SllMTUp4QjRudDdPZWRS
QUxMdDNXYm9sNU9BZ3kyc0xPaVp6TWZYclcwZk0NCj4gZTUxYUdNS1RDckw0Tmk0SW5rJD4NCj4g
UmVwb3J0IFN1c3BpY2lvdXMNCj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj4gT24gV2Vk
LCBTZXAgMjQsIDIwMjUgYXQgODo1MeKAr0FNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBTZXAgMjQsIDIwMjUgYXQgNDoyM+KAr0FN
IEtvbW11bGEgU2hpdmEgU2hhbmthcg0KPiA+IDxrc2hhbmthckBtYXJ2ZWxsLmNvbT4gd3JvdGU6
DQo+ID4gPg0KPiA+ID4gdmlydGlvIHNwZWNpZmljYXRpb24gaW50cm9kdWNlZCBzdXBwb3J0IGZv
ciBvdXRlciBuZXR3b3JrIGhlYWRlcg0KPiA+ID4gb2Zmc2V0IGJyb2FkY2FzdC4NCj4gPiA+DQo+
ID4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIG5lZWRlZCBkZWZpbmVzIGFuZCB2aXJ0aW8g
aGVhZGVyIHBhcnNpbmcNCj4gPiA+IGNhcGFiaWxpdGllcy4NCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBLb21tdWxhIFNoaXZhIFNoYW5rYXIgPGtzaGFua2FyQG1hcnZlbGwuY29tPg0KPiA+
ID4gLS0tDQo+ID4gPiAgaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmggICAgICB8IDQwDQo+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIGluY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fbmV0LmggfCAgOCArKysrKysrDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0OCBp
bnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmly
dGlvX25ldC5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmgNCj4gPiA+IGluZGV4IDIwZTA1
ODRkYjFkZC4uZTYxNTNlOTEwNmQzIDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92
aXJ0aW9fbmV0LmgNCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX25ldC5oDQo+ID4g
PiBAQCAtMzc0LDYgKzM3NCw0NiBAQCBzdGF0aWMgaW5saW5lIGludA0KPiB2aXJ0aW9fbmV0X2hh
bmRsZV9jc3VtX29mZmxvYWQoc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4gPiA+ICAgICAgICAgcmV0
dXJuIDA7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICtzdGF0aWMgaW5saW5lIGludA0KPiA+ID4g
K3ZpcnRpb19uZXRfb3V0X25ldF9oZWFkZXJfdG9fc2tiKHN0cnVjdCBza19idWZmICpza2IsDQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9o
ZHJfdjFfaGFzaF90dW5uZWxfb3V0X25ldF9oZHINCj4gKnZoZHIsDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBib29sIG91dF9uZXRfaGRyX25lZ290aWF0ZWQsDQo+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGxpdHRsZV9lbmRpYW4pIHsN
Cj4gPiA+ICsgICAgICAgdW5zaWduZWQgaW50IG91dF9uZXRfaGRyX29mZjsNCj4gPiA+ICsNCj4g
PiA+ICsgICAgICAgaWYgKCFvdXRfbmV0X2hkcl9uZWdvdGlhdGVkKQ0KPiA+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiAwOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICBpZiAodmhkci0+b3V0ZXJf
bmhfb2Zmc2V0KSB7DQo+ID4gPiArICAgICAgICAgICAgICAgb3V0X25ldF9oZHJfb2ZmID0gX192
aXJ0aW8xNl90b19jcHUobGl0dGxlX2VuZGlhbiwgdmhkci0NCj4gPm91dGVyX25oX29mZnNldCk7
DQo+ID4gPiArICAgICAgICAgICAgICAgc2tiX3NldF9uZXR3b3JrX2hlYWRlcihza2IsIG91dF9u
ZXRfaGRyX29mZik7DQo+ID4gPiArICAgICAgIH0NCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgcmV0
dXJuIDA7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBpbmxpbmUgaW50DQo+ID4g
PiArdmlydGlvX25ldF9vdXRfbmV0X2hlYWRlcl9mcm9tX3NrYihjb25zdCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
dmlydGlvX25ldF9oZHJfdjFfaGFzaF90dW5uZWxfb3V0X25ldF9oZHINCj4gKnZoZHIsDQo+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgb3V0X25ldF9oZHJfbmVn
b3RpYXRlZCwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBs
aXR0bGVfZW5kaWFuKSB7DQo+ID4gPiArICAgICAgIHVuc2lnbmVkIGludCBvdXRfbmV0X2hkcl9v
ZmY7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGlmICghb3V0X25ldF9oZHJfbmVnb3RpYXRlZCkg
ew0KPiA+ID4gKyAgICAgICAgICAgICAgIHZoZHItPm91dGVyX25oX29mZnNldCA9IDA7DQo+ID4g
PiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiArICAgICAgIH0NCj4gPiA+ICsNCj4g
PiA+ICsgICAgICAgb3V0X25ldF9oZHJfb2ZmID0gc2tiX25ldHdvcmtfb2Zmc2V0KHNrYik7DQo+
ID4gPiArICAgICAgIGlmIChvdXRfbmV0X2hkcl9vZmYgJiYgc2tiLT5wcm90b2NvbCA9PSBodG9u
cyhFVEhfUF9JUCkpDQo+ID4gPiArICAgICAgICAgICAgICAgdmhkci0+b3V0ZXJfbmhfb2Zmc2V0
ID0gX19jcHVfdG9fdmlydGlvMTYobGl0dGxlX2VuZGlhbiwNCj4gPiA+ICsNCj4gPiA+ICsgb3V0
X25ldF9oZHJfb2ZmKTsNCj4gPg0KPiA+IEknZCBleHBlY3QgdGhpcyB0byB3b3JrIGZvciBJUFY2
IGFzIHdlbGwuDQpUaGlzIGZlYXR1cmUgY291bGQgYmUgZXh0ZW5kZWQgdG8gYm90aCBJUHY0IGFu
ZCBJUHY2IGFzIHRoZXkgYm90aCB1c2VkIGluIEdTTy4gDQpJIHdpbGwgc2VuZCB2MiB3aXRoIElQ
djYgc3VwcG9ydC4NCj4gDQo+IE9yIHdoeSBpdCBvbmx5IHdvcmtzIGZvciBJUC9JUFY2Lg0KQUZB
SUssICB2aXJ0aW8gZGV2aWNlIGFjY2VsZXJhdGlvbiBmZWF0dXJlcyBhcmUgb3B0aW1pemVkIGZv
ciB0aGUgSVAgcHJvdG9jb2wgDQphbmQgdHJhbnNwb3J0IGxheWVycyBsaWtlIFRDUC9VRFAuIA0K
QWx0aG91Z2ggb3RoZXIgcHJvdG9jb2xzIGxpa2UgSVBYIHVzZXMgc2ltaWxhciBjaGVja3N1bSBh
bGdvIHVzZWQgaW4gSVAgY2hlY2tzdW0sIHRoZXkgYXJlIG5vdCANCnV0aWxpemVkIGluIGRldmlj
ZSBvZmZsb2FkaW5nLiANCj4gDQo+ID4NCj4gPiBUaGFua3MNCj4gDQo+IFRoYW5rcw0KDQo=

