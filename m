Return-Path: <netdev+bounces-127225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1739974A64
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F7C1C206A2
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A71311AC;
	Wed, 11 Sep 2024 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="AwHkApU/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEA182D2;
	Wed, 11 Sep 2024 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036013; cv=fail; b=t3cbqYR7eglNYBuOk0XnhSxbfzn1ojV3YXVHVT4l0UVWQeJ5pdG+ygR6n0zHn/zc0/q5hl+kXH8oiUAzxwGnzXxFgDdNXPThTdi5B6N+NTlbx+HfohxAdaMATVQKHAnuzUNXsVUGb1gRUFq6lEAe2MY4T5p2NsO9dqPOnGao5bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036013; c=relaxed/simple;
	bh=Eu219g1MVsMlcxFsq7EuRrldXcJ2R+LRTV6qHdywRo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GoaJ7H84wWdO7MPr7OrrBYvksJ70F5bN1wuf4r45V8zVE1AOCVkpiwfIou9xJskk7uj6zppphX+8n//7EgWzdjXzrVE3GOmk+km3v6qZRg/JI4P6d9CWhvkL5gSUAxcXKpeMZBCFiNnuf+J4ge9ve4Dt+Q8v66K1hzji22ZwMxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=AwHkApU/; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B6LTJq000562;
	Tue, 10 Sep 2024 23:26:43 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41gyc0d5fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 23:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfGv823XiRAgTG+5J9z8TdtH47jhreZSZd0JE/A7UAwIo/vZwHto82/ebKE6YW27UF+/Sl+mtLTN+cgXzb7iRr8Ebmq0nfW9a+oKKIYH8V69ggq1DPVg0uad/Fjv4W/UMdNQhKZUU0IGPvPUhtfDCShAQ82i7Wl4VyfS9oElmo+vZVFXTh4ib0d6S/hX2nTjWuYaA/ZmxrYJwGFQqwCJ6dIWmcG8Ed+iZl0cIfixgdAn7uqSzqk9t+bpfJScB6e9YQxZqru0d1vypUhsTy03v2X92pvInz9qExQxnBNDK9Yb4VTpfofg4k18OBgypXr40oyB8junZDJStgc1TqHAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu219g1MVsMlcxFsq7EuRrldXcJ2R+LRTV6qHdywRo4=;
 b=KuotP+meh88l1n1T+NIL3PX63MbvduKgvYsxnCAHmnINB44ba6rYIUo+0cZMf0ptsob8k9za6cFX2ed6Ik/y9/d6Koyb5J62psPE/FxnMPNZ4QgpyQ5jU3FF3p6Gey7DNjGT1l+372s/+C9VfcgTfjZEgkUNvyy6SdljdgvY/WZaIM5Pk7lClHpoUAXsipYQyZ1X02WhM51C7Y3b4vUxRST3CUm2MojAddKKFm/S0RmxbUzEFQh3POFZqXhN/A+nE1nYtcimlnj2h1E1UXQBMl5XHf/QGKtx1fEz9yynhye/YBUF4ot/RNsQLCLfzqw7TZW2wvn84IIXVsHYYRPo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu219g1MVsMlcxFsq7EuRrldXcJ2R+LRTV6qHdywRo4=;
 b=AwHkApU/nFUkEAXEI+rThfKqs5fMu8S7XbEUGNTJWRe5JrNFc5jYMNiqHyIw/P4734JLqHICDnnpuQHlKFEpIZN1H/MxPqmkkx3+43xSQWh74fu4GPq8LjdowzKncUaR6yH0UQIi8j5UOliRSlvyoQrLenkW8Tr/eOGUzvDfNSk=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by CH0PR18MB5530.namprd18.prod.outlook.com (2603:10b6:610:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 06:26:36 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%2]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:26:36 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v2 2/4] octeontx2-pf: Add new APIs
 for queue memory alloc/free.
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v2 2/4] octeontx2-pf: Add new
 APIs for queue memory alloc/free.
Thread-Index: AQHa/3j0GCIAdFqzFUOhD+MPD/ENKbJQzDGAgAFWwuA=
Date: Wed, 11 Sep 2024 06:26:36 +0000
Message-ID:
 <CH0PR18MB4339D0B361321187585DB975CD9B2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240905094935.26271-1-gakula@marvell.com>
 <20240905094935.26271-3-gakula@marvell.com>
 <d58d7b9a-ae20-4c07-af17-425cbdfd861b@redhat.com>
In-Reply-To: <d58d7b9a-ae20-4c07-af17-425cbdfd861b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|CH0PR18MB5530:EE_
x-ms-office365-filtering-correlation-id: 961a4cc1-7e33-41a4-a298-08dcd22aaff7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2U4czdDWmlSN21qYisvdlBadzg1TURUMExPU2d2azVWTnZwK0V2U3lQaXdG?=
 =?utf-8?B?MU5rUG5ralpSamxOazJRaEp0V000ZEV2Q0F6cG1HaW9BdUs5Z3NTaUVpQi9D?=
 =?utf-8?B?QlBTMnBzNTNOUDBQSDdrenBJcm1KQnpZdEptWk9zcG9VM09jTi84T1hCTElX?=
 =?utf-8?B?Q2xIQzV0SDlSNlJsTytWNUhsUnpNZjVpZERNSG9RYUw4THIzOExqZnJCZ2ND?=
 =?utf-8?B?NlA3WEFoekx4cEVIM3RMYzJDWkQ4QzVRdlFSN0hMNVRzcHZybEs0ZjBHQWZT?=
 =?utf-8?B?aGNrdnhXWWo2NUp6SEQ2S3Jkam5taThUVjArYTFFSXhIS3pSYU13WXl5MFIr?=
 =?utf-8?B?cHdRUlFXZGNvTHU4Wk1iK0cwV3JzbGoxR3lTR3RaSjJwZ0R6V2llcUgzTlE0?=
 =?utf-8?B?eFp3TEp6YnJzcjR4dmdEcTFTSjlsQ1pmeTcxQ1VNWWFndzl4V010NEpiZ2Vw?=
 =?utf-8?B?SHpwbTY4L0dmYkxVcFY4ekxCS2NtYWtoMmx0dVdKd3lpY0Yra2NUamZ2UXBN?=
 =?utf-8?B?L3RXWVZoV1ZnZzBoNUI3MGNiREFqT3liNlZTVDAxQXZRWEpmeHJJOUJhMVRh?=
 =?utf-8?B?SzR6dU1hemZHZzVWV1hCbVdTbnZSdVl6SVBvTC9hZDJ5MHM1MElBYmRuUkFQ?=
 =?utf-8?B?L3l2ZkpVVXNraXFRb3c3VVN0cEVCYjlTVExVNG94Wmxna2JKYUtCN1FESUQr?=
 =?utf-8?B?NEZvVFBLUFRUbHJILzI3MThacCtsNU5kQXc4NkRFZ3h4V044S1k0bnprT1JN?=
 =?utf-8?B?Zk9la2VDVkdjWlhRNVRReWJsV1c0bkYwckNIK3lrMWowa3ZIaCsraUtCaGJ2?=
 =?utf-8?B?eW8zQ3JEMGhsWURmemVHcE10c055S2F1bzdEOGNUOUxrUnB6YmlaeTh5M0Jk?=
 =?utf-8?B?TjZXUk10RWorZC9xZWVQdFZZS3Y1RlVRQ3lKU1dpaW0vaTVrL3pvRS93UDd2?=
 =?utf-8?B?c0lWSzVkaVUzaGNPWXZ2NENHcGJIT2QxYW56MmtDVWxIbmk5Z0N5L21XNXpn?=
 =?utf-8?B?dUxmRWxiZDI1eXB5S3NLVVFBOWRkMm45NzBMWC96SFBsRlNIUURLZ0xDZUZU?=
 =?utf-8?B?cDJ0VlRlUHZoWE9JNDdDb1dvcEJPSHp6VU9DUjJoRWpTK0ZwdytaSUp6cm42?=
 =?utf-8?B?U3pCS3VMK0RWcGtqK2E0UnBvYW5ualF6QldwazcvVjF5c1Awc3UzTVN1WHFs?=
 =?utf-8?B?eXJGRUovUGxSa1BIaFpKdXpNQ0NBd2NEVkwrME14UjNtMzltVktOamhOc0ZB?=
 =?utf-8?B?V2pXWFpFSUpMZ3BKdWViSWlOR1JSWUtucGFhRytqdmtEWkJVTFk1bGJkV1A0?=
 =?utf-8?B?YlZqL24rVnJHQzVDeS9DVWM2VVhETkp6R0ZQeUZzVVNaUDlMcnRwRC8zMlh2?=
 =?utf-8?B?WTRsbmJDdHlIRkxReldtRWI3NlR4YldvbmlKK3pDUGdoUGtUOVBROEdZdGp6?=
 =?utf-8?B?anFGSFp4eHRURlpBSkk2a1YvL01yS0hnVmxTTTJwWk1yK01NU3hXSENaS1d1?=
 =?utf-8?B?Z2dRcEMyNGlXVy9jY2RQY3NNRVk4U2QvU3dxUC85bTJqWmEwQ2xtdGJLemdS?=
 =?utf-8?B?VWlQVndweDlXVHVVYldRdlhKZDlNV3YzR0F4Q0NVSDV0ZjBFTnlTUEFDckgv?=
 =?utf-8?B?UUVIN0ZSYTZ0ZWlDSlZMd2NJVUYvYnBWcTJXNmwrRmVqQmlRU3pLQ2dhdG83?=
 =?utf-8?B?K3QvbWY4SDFENnRDcGU0TlAvTURtMGdkUUsrWTJlejdGSmlDaWxjQnozdEg5?=
 =?utf-8?B?TSt2dmJ4aUhUUndNRld1bmlIcDBvZEhtc21pNEUybVUrUEFqeGFQRlZCV3hx?=
 =?utf-8?B?NElhbmZ6YW9XbGxqbXZPZnBXQ0hhTWJtb211ZzZ0dkFpbXBscEV6bkNTY1RU?=
 =?utf-8?B?S2Jsb0tSY284anRrTmpwU3NsenhtTjZtTkRjWm5naGJoZXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzczV0VTcXcwbjhVSXZnM3NxYVI5VkpvbXgvblZmZmF2cHBZMTZZTFR3SW9T?=
 =?utf-8?B?aVV4UHFxakRxRnhLbU9LUE5sZUdXUTRCajRBU0VlRDhhbUswd0NNdlRNRlpx?=
 =?utf-8?B?UGx4MjZnc040M2xlSHFkM1lLdE56Z0RKcEhzS3ZWT1kxSzdvZWNqNWdFa2lT?=
 =?utf-8?B?THl4dTBsK2xWN1JEMldhOFBWWXRBSzNlZjFoSDFUeDRqZXVWZ295WGUzSmxU?=
 =?utf-8?B?Q0JiWUoycUM3a29hbmxkMy95bWpIcVY4VEZrSi9vWjZzditYWjFnaGd1Znoy?=
 =?utf-8?B?UmVIdTlmaVpSb2xXK3ZzeVFTenZQYWFQczNIeVhZRTZwTTVDamhUaXFGWjIr?=
 =?utf-8?B?SlhuNVRoRUFXcHVrVGJwaE81RllDWDR4SnowWkwrZTIvMUdGaWpXS3d3NGky?=
 =?utf-8?B?aVIxa1o4dUhVbzByM1BqNXJ5alFtSG9EUVJFRzZNcFkxKzJnV0pqU3BrYUxv?=
 =?utf-8?B?VnNKdDJjZGx1d1NYc09lK2FVckxTczNVclZQTXNZWXQ2ZHRNYlZTRmVCS2R6?=
 =?utf-8?B?OGgxVEVhYzIvZ2txWG9IUzFpd3VkVUlmcFR0OWhwdUpPY0xlQ1ZpVDV1MkpB?=
 =?utf-8?B?aDNLSFVvTkZGNzVFZUxRT2syNWtmSzRlazg5SG9CNU9iSG02VGlQclIxRVAw?=
 =?utf-8?B?a1lqdWY5TUxUd1ZHMksvOGJTTWl1QXFyVHBSalZBYXA4SGYwby9nWWQrS2VR?=
 =?utf-8?B?UFZObzVEVjE0N1NKZWxQaFI5SUJVMGtMYitya0lJbUdYeHliR2FYeGhiQmdS?=
 =?utf-8?B?MHdKTkZFR3dMeXJUQVpMY0VOWmxmM2JGQU9jREJpMVJFeHZuZ2dWOTZ3QUhN?=
 =?utf-8?B?K1dsbGdYa3RiWWFEY2UxRllMd0loOGQwbkVta1dRd2RWNGtTWHJocm5KQUV1?=
 =?utf-8?B?U1ZManAxSE10QVQyNE9DQy9nMGl0VmFYbVFnMDNmNUhvRnZXejlXUmRwWU04?=
 =?utf-8?B?S29yN09ZZmY2QTlKRENiMmRFQ3I5dVBoSDlZNi9EaDVaeTdpZUN0dk45ZElv?=
 =?utf-8?B?S2RFU1lDMGszeEJnWWVrekUvcFljVHRqcmxOd3F1V0tLNCs5NjduT0FxWFph?=
 =?utf-8?B?K3JLeHJOcXFHMjQwM3Q3djExYWNoVWRGbmpGMVUxWDdwZXFEWVNDR0Zwd0li?=
 =?utf-8?B?UzJYT0ZoWk5BVGFycTdZNDBZSGNXMTF1bXh0YWVuK1JHZUZ1WHJqMUhaeVpP?=
 =?utf-8?B?NmJpTlNIdDl0Z2hvckpITCsrNWROOVhmc3JueGVJckVrVnBlZDNmMmY2R2xD?=
 =?utf-8?B?MDJOVFRVVnc1YUpIYnFVaEdxd3JmamFxdGVhUzN4NHg2aEVnRHZ3RHJXcW1C?=
 =?utf-8?B?UGlUWUZWMisxQ3QvQTQ3elJkOE5sS0s0clZ2TGVScU91QXdhdGdkdDg5eENx?=
 =?utf-8?B?QWFLYkxkU1hHajdSSEhiUTc0NVJTM0Mvc2I3NXJaQ2ZBOUZISVVkZGdBTlli?=
 =?utf-8?B?K3NueEZqSlI2cDg3MnFNRnJHWlRuS3YrUW9Vekl0Nk5zZHdxTkVJdFd4b0lx?=
 =?utf-8?B?bUdGSkVJRVRuOHNyNXJJUVNOKzQ3TnluWENDMHo3MjdVODJCV2R6ZlQzMDRY?=
 =?utf-8?B?enZmVlVtVnl6ZDFIQzJZK0I4NzdOUWJGYkVZZndoNXcwdU5pYUFGZkdtRHph?=
 =?utf-8?B?NHUvc0orYmtqNncxSGhDc3BWNTBwdDJJR2RsSGN5ekZ2eXFxR0FpNzlFVjND?=
 =?utf-8?B?elg4NjFIV1dGZDhRa01XOWYxT2lKZVQ5NjJJb0pkUVRuS21qa1o1S2lvbCtU?=
 =?utf-8?B?aTA0QzA0cm9jNktxbTA3Z2o5SXFDS0xDS3d0SlAxZTIvZUJBQ1hSS0tlbkVE?=
 =?utf-8?B?RTNVeG5rT1N1ZXNIbVhVNUNRRlNGeVhxSUJwOW4wOU9paFBNS2FvaGE5bUpq?=
 =?utf-8?B?VGxPakMrNmxMaXZEdlYzM3pmaTlOYys3UExIS3RyV2krb3gwdVJYdjliRHFy?=
 =?utf-8?B?TllSWnRjcU1KaGJBeWYwTnYzQUo1d3NVVllTQ0t1VXc5VDJlMXB4MW4ycjdi?=
 =?utf-8?B?aHVIVStCUXdaZUlPKzFGZlJjS1NqNzRSM1hUYU9GakVSRjJONzRGdXk3SXNE?=
 =?utf-8?B?NDV3ZTI1bFFLdzJPNEl6eG9RSEY0SlhOL21LR1hmTmZ6RHJtUVQvc2svQm91?=
 =?utf-8?Q?hoIY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 961a4cc1-7e33-41a4-a298-08dcd22aaff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 06:26:36.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxYxaZsKp7ZXWc8jaVPr3lhT4OoaTQYHMp1gPv/8vF/9yc2NwFmFHVLUL8Zb8k1S49XEF4yGI0BS67T8vpg/Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5530
X-Proofpoint-ORIG-GUID: Iyv_wgkknK_-ig-AgRvEZb8T9WumfUXl
X-Proofpoint-GUID: Iyv_wgkknK_-ig-AgRvEZb8T9WumfUXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTAsIDIwMjQgMzoxMSBQ
TQ0KPlRvOiBHZWV0aGFzb3dqYW55YSBBa3VsYSA8Z2FrdWxhQG1hcnZlbGwuY29tPjsgbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsNCj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+Q2M6IGt1
YmFAa2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgamlyaUByZXNudWxsaS51czsNCj5l
ZHVtYXpldEBnb29nbGUuY29tOyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZl
bGwuY29tPjsNCj5TdWJiYXJheWEgU3VuZGVlcCBCaGF0dGEgPHNiaGF0dGFAbWFydmVsbC5jb20+
OyBIYXJpcHJhc2FkIEtlbGFtDQo+PGhrZWxhbUBtYXJ2ZWxsLmNvbT4NCj5TdWJqZWN0OiBbRVhU
RVJOQUxdIFJlOiBbbmV0LW5leHQgUEFUQ0ggdjIgMi80XSBvY3Rlb250eDItcGY6IEFkZCBuZXcg
QVBJcw0KPmZvciBxdWV1ZSBtZW1vcnkgYWxsb2MvZnJlZS4NCj5PbiA5LzUvMjQgMTE6NDksIEdl
ZXRoYSBzb3dqYW55YSB3cm90ZToNCj4+IEdyb3VwIHRoZSBxdWV1ZShSWC9UWC9DUSkgbWVtb3J5
IGFsbG9jYXRpb24gYW5kIGZyZWUgY29kZSB0byBzaW5nbGUgQVBJcy4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBHZWV0aGEgc293amFueWEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj4+IC0tLQ0KPj4g
ICAuLi4vbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmggICAgICAgfCAgMiArDQo+
PiAgIC4uLi9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5jICB8IDU0ICsr
KysrKysrKysrKystLS0tLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCsp
LCAxNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmgNCj4+IGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmgNCj4+IGluZGV4IGE0
NzAwMWEyYjkzZi4uZGY1NDhhZWZmZWNmIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmgNCj4+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2NvbW1vbi5oDQo+PiBA
QCAtOTk3LDYgKzk5Nyw4IEBAIGludCBvdHgyX3Bvb2xfaW5pdChzdHJ1Y3Qgb3R4Ml9uaWMgKnBm
dmYsIHUxNiBwb29sX2lkLA0KPj4gICBpbnQgb3R4Ml9hdXJhX2luaXQoc3RydWN0IG90eDJfbmlj
ICpwZnZmLCBpbnQgYXVyYV9pZCwNCj4+ICAgCQkgICBpbnQgcG9vbF9pZCwgaW50IG51bXB0cnMp
Ow0KPj4gICBpbnQgb3R4Ml9pbml0X3JzcmMoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHN0cnVjdCBv
dHgyX25pYyAqcGYpOw0KPj4gK3ZvaWQgb3R4Ml9mcmVlX3F1ZXVlX21lbShzdHJ1Y3Qgb3R4Ml9x
c2V0ICpxc2V0KTsgaW50DQo+PiArb3R4Ml9hbGxvY19xdWV1ZV9tZW0oc3RydWN0IG90eDJfbmlj
ICpwZik7DQo+Pg0KPj4gICAvKiBSU1MgY29uZmlndXJhdGlvbiBBUElzKi8NCj4+ICAgaW50IG90
eDJfcnNzX2luaXQoc3RydWN0IG90eDJfbmljICpwZnZmKTsgZGlmZiAtLWdpdA0KPj4gYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5jDQo+PiBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3BmLmMNCj4+IGlu
ZGV4IDRjZmVjYTVjYTYyNi4uNmRmZDZkMTA2NGFkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfcGYuYw0KPj4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfcGYuYw0KPj4gQEAg
LTE3NzAsMTUgKzE3NzAsMjMgQEAgc3RhdGljIHZvaWQgb3R4Ml9kaW1fd29yayhzdHJ1Y3Qgd29y
a19zdHJ1Y3QNCj4qdykNCj4+ICAgCWRpbS0+c3RhdGUgPSBESU1fU1RBUlRfTUVBU1VSRTsNCj4+
ICAgfQ0KPj4NCj4+IC1pbnQgb3R4Ml9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYpDQo+
PiArdm9pZCBvdHgyX2ZyZWVfcXVldWVfbWVtKHN0cnVjdCBvdHgyX3FzZXQgKnFzZXQpIHsNCj4+
ICsJa2ZyZWUocXNldC0+c3EpOw0KPj4gKwlxc2V0LT5zcSA9IE5VTEw7DQo+PiArCWtmcmVlKHFz
ZXQtPmNxKTsNCj4+ICsJcXNldC0+Y3EgPSBOVUxMOw0KPj4gKwlrZnJlZShxc2V0LT5ycSk7DQo+
PiArCXFzZXQtPnJxID0gTlVMTDsNCj4+ICsJa2ZyZWUocXNldC0+bmFwaSk7DQo+DQo+SXQncyBz
dHJhbmdlIHRoYXQgdGhlIG5hcGkgcHRyIGlzIG5vdCByZXNldCBoZXJlLiBZb3Ugc2hvdWxkIGFk
ZCBhIGNvbW1lbnQNCj5kZXNjcmliaW5nIHRoZSByZWFzb24gb3IgemVybyBzdWNoIGZpZWxkLCB0
b28uDQogInFzZXQtPm5hcGkgIiBwdHIgZ2V0IGluaXRpYWxpemVkIGFuZCBmcmVlIG9uIG90eDJf
b3Blbi9vdHgyX3N0b3AuIA0KVGhpcyBwdHIgaXMgbm90IHJlZmVycmVkIGlmIHRoZSBpbnRlcmZh
Y2UgaXMgaW4gZG93biBzdGF0ZS4gSGVuY2UsIHB0ciByZXNldCBpcyBub3QgbmVlZGVkLg0KV2ls
bCBhZGQgcHJvcGVyIGNvbW1lbnQgaW4gbmV4dCB2ZXJzaW9uLg0KID4NCj5UaGFua3MsDQo+DQo+
UGFvbG8NCg0K

