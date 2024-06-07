Return-Path: <netdev+bounces-101724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E23C8FFE10
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B2B1F2247F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2718D15B108;
	Fri,  7 Jun 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="E+6pDkg7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00615AD9B;
	Fri,  7 Jun 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749209; cv=fail; b=sMO59RBpZ5RzWuIjtySml9Df/Jh2hL4AluIg0AlVJkplS9Q7hEdBRqH0vjrm+P9DEB0PCvLwK+0xZaOiDIAu+DKja9dkGmtc5iCFO1XeZIfJzqODrB4m7AbPTCp984XEMZfkOq1z3bAsEs84KxQ0hBMdJ2+oeOyGkkGpCSFJZkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749209; c=relaxed/simple;
	bh=70fIuuuF2riNxInrSvanvdK4hooldUF8yWAlJiYWGMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vGARg4ZL2hRacW/yvOgkqrH/QED3XPROmglOi/w1Mqa8CNqSrCCIlVLKV2VYo8efN5Gyy8dZiG+a73Wx0GKy+8GLCNvTqVZ0GKdQ81tQUmJf/hWmCDup6lIXvpCTmuapXq1GoAHA3rf7NMGzrly2tyzmaF4buE+rHl8zY/pXQaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=E+6pDkg7; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4575BHLJ027639;
	Fri, 7 Jun 2024 01:33:00 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ykuu20ft3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 01:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9QHWn1Ls7dxtjLQLQ8M1wwi8hCgS6QZ0971AC5PneCmhKnvxR+JLT0lhBatUd3S2pkX05wQLo+bhctrw07MnUeyqrlLrwQoNo01/qqBltkiTUb0h1riWZBgR7W6D3H1eGoInBrRrWBUJiFgwT+gsZTZnlm/qJ/oTPuuRfd2czSLUUT35kjMqQ+3w37XeRlwvGL9Yf2LKsSEOwj4qe+f3GOFUriLwAYkt/b2Snr1uF+awc5H4ApBqPn3gWmWa9EHqqtn1vOgQKZWHgNEo/oSx6Y+EPW6YP3jtwKQM+vdK+SjSji3ZwyI/WjfFB7+hppcQuZ/S/XBu1rdWEnKieEtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70fIuuuF2riNxInrSvanvdK4hooldUF8yWAlJiYWGMM=;
 b=fCPw4TGsuAcY3Ifzva/HNGoZ9hAdgJ6E1mUddyMTILQ5l6w0GNMAU+L3WMZDMdzRkghvFtKdCGlTHVNaSqTrvR/Cj0XhOsSA+ui4i2cIIXBeOYAb7486L1c2bKcfAs0vW7G6EMXXAg+lonU2OrKixn+b+9QydfyAHAQmu0Nprdm0qdtP0mjYyc+m//cskicE5euJyeb5XmovxvnzcABGI25EwICNYSfLL3wrrRACu+jsMlKCrTHuN0CyWJowI2LwFJI+GLcng6Y7qVtIscyDUCjFMVy0g4rV5VvMaBbF4jekreKxficURUkDyWkq7n7uZf5xcKSvGnQ7TLEqK+g5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70fIuuuF2riNxInrSvanvdK4hooldUF8yWAlJiYWGMM=;
 b=E+6pDkg7jRzK9A4/on8ITWk1FJtL+tEnONMPvOskntkVEPuUNg7cACSHdsikjwV98ao9QUtHmKvJlwU9DkWwUf9Q7CFmevOWCZNV9Xx1nasWZf2mCeSzhdIMq4b7yfFyq1W1V1vABB/KmZf0WrQOUR6YZxU6BuELuQ8HNOdhrsM=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by MW3PR18MB3500.namprd18.prod.outlook.com (2603:10b6:303:56::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 08:32:49 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e%4]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 08:32:49 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: =?utf-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
        Clark
 Wang <xiaoning.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH v2] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588 being
 cleared on link-down
Thread-Topic: [PATCH v2] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588
 being cleared on link-down
Thread-Index: AQHauLVHxMAwfZ5cWEKU8wqwZe2dug==
Date: Fri, 7 Jun 2024 08:32:48 +0000
Message-ID: 
 <PH0PR18MB4474DC325887DE80C1A2D7F0DEFB2@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240607081855.132741-1-csokas.bence@prolan.hu>
In-Reply-To: <20240607081855.132741-1-csokas.bence@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|MW3PR18MB3500:EE_
x-ms-office365-filtering-correlation-id: b099ec3b-e540-4248-db2c-08dc86cc6a19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VTh5Yk1Pekdic2Zncjl4THY4QTdOWWxKQ3pwTVlsbTZuUVlTQnM3ekpYUnhI?=
 =?utf-8?B?akRtd3kvMkFMYklCT1NhTU0vK0M4RFE4bFRNRGFweWVjQ28wZ242TFE5Q1Ex?=
 =?utf-8?B?RU1TOUo0ZmNuem9SNHZ4R05QMGtBN012bEhtQkpTcEJhUThIb3FtejdiTFQz?=
 =?utf-8?B?dUt4aGZwQnhaei8xTXBjU2laUUoya1crUlJNVHJyQm5zMkEwYktLVUlMaDRr?=
 =?utf-8?B?bStnZndMUmZ2STBQblhCcnB4UFdMRy8vQjNSLzVKc1E5WW53ZEFxZnE2Rlp2?=
 =?utf-8?B?dGl3K2NSNXc0emc1c3dscVlLeTNzcThzZjl6UnVRc2kyMFhTWHEyeGF1QnM1?=
 =?utf-8?B?eXIvV05aYWMzKytUamhiZi80YXdqMVZ3QXZGOHNnUG1xaXVGazI1MHhtQmg4?=
 =?utf-8?B?dnFqOEcwN1hEZ0Z0YkNocFNJaSthcElnTG9lT1BFTnhrQi9lSnBIQkhnSE96?=
 =?utf-8?B?bnlxN2g2SmFuRXVvTC84UEZONUp4TTFtY3o4bW1pRzdSbWlDME9ZeHpTdzRx?=
 =?utf-8?B?TTdZVlpIUXJ3Y0tNQzk0d3lrNk5wTXZVeUg0UEkvUzc5TW5Fa2RkU2VDWTRs?=
 =?utf-8?B?ZTJhZThwRDVwRjZ5blYvU0RmbHM5N2VHekRKSHovWGx3OWJ4blJFLzhMcUU3?=
 =?utf-8?B?SEx0aDVidUtDTi9yVHFSRnRBSmJnMzhFOHF3ZFFWaXZXWjVkRllJYXcxRTJV?=
 =?utf-8?B?TS8rVTg3L2lhaitsZzdtRC84Rjk0MW5lT1dlNnZ3dTNKdFQwWi9DMm4rTlJ5?=
 =?utf-8?B?UnAxQjBseUl1Zk1FYlZGQTRyOHpJVUFuUXZHN3I5T3h0L2lFVTNKczQyVGky?=
 =?utf-8?B?WThmM28vVlBvcVRpVmxiK0tCTXUzYjhhVWNZTDhBY1hSaUs5cERmYlBHVUN3?=
 =?utf-8?B?UUNJems1YkpDYTJVS2JqNnNrTENidU9UT1YwbmVvUWplSWRVNTlmTEJIRTJo?=
 =?utf-8?B?N2JSLzQ3WEZ4SUpSZ1dPZHl6RTV4alBVTUE3OHdYbk5UZHdmTnJZam9zSjBs?=
 =?utf-8?B?VTFRaUJsVEdnWmlzd2VLZHlVWkVyUFczanR2MWdIemR1dUFITEVzMFgxc3ZM?=
 =?utf-8?B?N3E3NlRIcW9sMGhiSUJ3K1pxT3hUWlBPSUpFeEhublZDTjFLSEpNOHBSRFEx?=
 =?utf-8?B?eUg2NC9CWUFjVFora2U0WlpsaC85TGRsMDJsdkRwRkgzSHc4Mk0vb1RFYnVS?=
 =?utf-8?B?WmtvNkVyM0p3OWh2QktWcU5tQ1pUUDlyT3NLODdtVWs4U0VUQmhtbnIrWEJ3?=
 =?utf-8?B?NzgrYnhFcFAvNWIrS1VvL29VSUI0cUhyYzk1eEdnc0ppNjlDWUZpWUpLTkI3?=
 =?utf-8?B?WnNsZStEVVZsNlVzL3lOSnVhK05EeUxScnFmTis4R2MzTmZiSTdRaHZPUjNq?=
 =?utf-8?B?KzhoY0Z0cVV5SW1xeGdoREhvQWtWV09NODJNVkFsUjUrYTFxaVE5Z0s5M3c0?=
 =?utf-8?B?Y3dFUENDKytNZnBKaytMcDB2QitIc2VxSXpRM0lGWFQ1M0d1NTZTOGRXdzcz?=
 =?utf-8?B?eWNLNWEwRWtGV2VuMmJWclRZYmJtTlpjMmZ6NTlYSXBkTys5YkJkS2QwemFL?=
 =?utf-8?B?OWlMdXhFU0NVa3grWU9EbnVwR09uanlPZUdZcWk3VFREQytDbDNQb0Q3aFVv?=
 =?utf-8?B?bEdUV1Q1TzFTcWNLaHZ6RjBzWGRjSERsWG9tYlBDNVYyL0JzdXUxbzFybzJ5?=
 =?utf-8?B?YnpRalRuZlpTaGF3SDZOcUVYMXNIMFZlbS9JWjVNclhKMGZkR3gxQ3prQW0v?=
 =?utf-8?B?Y0k2YlB1YTNXMXFlVGNwVlJGZFVad1lqMlpHclRRUkFTaTd2WmtrZHFjUy9V?=
 =?utf-8?Q?XPyx+A0nmSpDl/aNULHQKn7JDFq9VKmVMzmt8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cm95eFd0UUxOR1hNQU85Z2lGZFp2dmdlQVdWSFBDeDV1ZnhqV004MTNvYzZs?=
 =?utf-8?B?OVpBb2tjcWpUNjhRMTMvS29YdjlwUzM2cEc5VlNhV0k3ZUJpRldncXRqR3BV?=
 =?utf-8?B?Um1iMlBHUklCODRGbVB6eU5WeUVick5JSDdDdHlqR1NJQ3JNY2R5MFh0M21u?=
 =?utf-8?B?cXF6RXJad01LazlqaU1kOXROUUZ3M0RnUU9CUzFoL0FYS29xclB2amg0MUlu?=
 =?utf-8?B?WFZjSGlZKy9SL1JYalhpdlpsQXBUVDdEdnFnUzlsTUx0T0pCcThCRlhTWS9n?=
 =?utf-8?B?Znp6VVpZeGhGNVpLRVpEbkJZdmM0YWh4Z0xlU3NDZ3BEbEswWDJOdFQyY2Yy?=
 =?utf-8?B?Y0lvVXdoNkFEdjUxZmlKazFvNEhEVXBESlVQQUFmWGorUUxlMW1ETXFTTGc1?=
 =?utf-8?B?RUYxUURONGs0alB0d1VUTmFKUFZBaDE4bUhyVEdqZDFEVFo0eGxtY0J5Vi9s?=
 =?utf-8?B?MnhLQUlGNlhtWHYrNnBETVhnZFk4WFpZc1hJSlpsSXZiREJJeGkxNEZpWkZB?=
 =?utf-8?B?eGFTdHl5c1A3VzBlR2VOYnBYMHZ1V3hLY1NMNTRHRmppSW5nQnRyNHF0ZGsw?=
 =?utf-8?B?QklvTVBYOVBFY2thUU9TVHBkZ3pQV3FlUDZlL25lZDBSTzBDTVBCMlFSTDJa?=
 =?utf-8?B?OUMzMUJUVm1pVnZsWjdYSHJFZjVsdTBVUEo2NWFKRjRJc0JnS3daTWo5a295?=
 =?utf-8?B?NGxMZmZmdE5IMlZKSlF0d1BrSlkxNEFuQ2M0TWRnTFFyZ0RxeE5oUnRKTjBJ?=
 =?utf-8?B?SS9oR1Y0OGg5V2l4cmYrajJaTzJpdXNyQ1V1L25YQXVETkZhbE14T0pHbUtE?=
 =?utf-8?B?VTNyUXNOaHlZU2xnRHRjaUtKN1dsN0VhNFNITjF2R045Njl5ZCtSZTlLUFhs?=
 =?utf-8?B?RVpVUm5KNFFpdkNXK2VrZEVRZXZoTzhyaDVsWjJJT0dnTTlmTnZlNUh3Qnl6?=
 =?utf-8?B?bVNvTllXYTc5R2dqQlZscVlUcEQzZVdrWTk4cXEyRnBkNjNXaHVHYUxUbEEv?=
 =?utf-8?B?aFZWMVdxZ2xWR3ZCK3V0YUwxc0Evem9ydGdGd0RiQVphTnI3a3RXMVFLNUor?=
 =?utf-8?B?Z29rbm91dlZrT042TnFHK01Ic08vQTkrbjhVTUh4NVhxM0V1YXY2cDlnWlZv?=
 =?utf-8?B?azZidm9NaFFYaGsrZWFmVGQwU1NBM1NyZXlqSGdySzhkYVNNSlNycjVnaHp6?=
 =?utf-8?B?MjRyU3dDTnFtY1Q0QVNLSlJ1eGk2VWxFd2xvMGhzVytEcXlMeWtDQm4wd1ZE?=
 =?utf-8?B?K0FXTi96YlFmMDlmVDJpaEZhYUgyanc5Rm5GTHl5RjRJekNxWnVMaHVOdUxS?=
 =?utf-8?B?ZEF2WGNmb2hEMkY4YzZIMXNtVGFxclRJR3NqN2NvL2IvTDBQRnBtZ1lyY2hs?=
 =?utf-8?B?S2gzajEyVDJ4TkpaWGhaSnNEMC9iaWNQeTcrYjlZYnNuVnZQSWw2dXFwUEJo?=
 =?utf-8?B?MG01VnNoeXd4N1d5UDVSWCtKSC9Ienp6Z1JFa1dpM002QUsxcWs5UkZ0R1Jo?=
 =?utf-8?B?cFREbEdQbkpBa28wTUR6aDFMVzdCK002R1N1L1p1Y2xpRkpsYWRTV04vZmY0?=
 =?utf-8?B?TGRMdUZEZFFlNEpwNzdHeUhrYVQzbUo2Vmh1L2tvWlNhZkpucmM2Sk5qVGVH?=
 =?utf-8?B?d2s5dXU0TTVBMC8rcUVmVlowMk1yRWtmQ2dud1VsejY5dFdQby9zZ3VJeEU1?=
 =?utf-8?B?Ny9ibldvVVU0cFlGazlYYXJNUml3Tm9qS1RaUEFpclhuNzd5VndRMldXVW9s?=
 =?utf-8?B?THZHOEp1b0lOV0FqRTluMHB6UXdSN1NEc2FNRU1lajI2RzJTbXRSWXlSQlda?=
 =?utf-8?B?REdZOUl3WnZ5YVZocjdZQlVqbE52azBMM1BFVW1CTTFmUEQ5WHhOMW5pQWZG?=
 =?utf-8?B?MXd0ZXpJbG9XMlU4b212dWRKTC83ZkZPWFUxSmZxWUttWXpOai9sZUgzOU5B?=
 =?utf-8?B?Y2k5N004MW1idkx5ZUpCRENiSld4WENaY1M1b3k3WW5GUGdHcXNaZ2dHNTFX?=
 =?utf-8?B?ZlUvVE5UR0pkcjBpR2kvVVBCV29UbFd4TzZrOUV4bm9HWFlMUmEvYThsdUJj?=
 =?utf-8?B?ODlLamQ0b0REVnhlelVORjAxMEZNVUtKMllYZyt4U3k5VU9DTFJJcGkyOUZM?=
 =?utf-8?Q?mPj4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b099ec3b-e540-4248-db2c-08dc86cc6a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 08:32:48.9887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V13G/leFtsnVY5S0vXsqDKGZjacSQyxko9pSKy7ZGRGfPLMgaz6NzUWNJ5/FOw52xbLLDgQWCb14Bgwv6L9JXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3500
X-Proofpoint-ORIG-GUID: A6ipA2np7aQbBWPj6VT3QGuvEfVT7bEc
X-Proofpoint-GUID: A6ipA2np7aQbBWPj6VT3QGuvEfVT7bEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_02,2024-06-06_02,2024-05-17_01

PiBGRUNfRUNSX0VOMTU4OCBiaXQgZ2V0cyBjbGVhcmVkIGFmdGVyIE1BQyByZXNldCBpbiBgZmVj
X3N0b3AoKWAsIHdoaWNoIG1ha2VzDQo+IGFsbCAxNTg4IGZ1bmN0aW9uYWxpdHkgc2h1dCBkb3du
IG9uIGxpbmstZG93bi4gSG93ZXZlciwgc29tZSBmdW5jdGlvbmFsaXR5DQo+IG5lZWRzIHRvIGJl
IHJldGFpbmVkIChlLmcuIFBQUykgZXZlbiB3aXRob3V0IGxpbmsuDQo+IA0KDQoNCiAgICBTaW5j
ZSB0aGlzIHBhdGNoIGlzIHRhcmdldGVkIGZvciBuZXQsIHBsZWFzZSBhZGQgZml4ZXMgdGFnLg0K
DQoNClRoYW5rcywNCkhhcmlwcmFzYWQgaw0KPiBTaWduZWQtb2ZmLWJ5OiAiQ3PDs2vDoXMsIEJl
bmNlIiA8Y3Nva2FzLmJlbmNlQHByb2xhbi5odT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYyB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
ZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZmVjX21haW4uYw0KPiBpbmRleCA4ODFlY2U3MzVkY2YuLmZiMTkyOTU1MjlhMiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAgLTEzNjEsNiAr
MTM2MSwxMiBAQCBmZWNfc3RvcChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldikNCj4gIAkJd3JpdGVs
KEZFQ19FQ1JfRVRIRVJFTiwgZmVwLT5od3AgKyBGRUNfRUNOVFJMKTsNCj4gIAkJd3JpdGVsKHJt
aWlfbW9kZSwgZmVwLT5od3AgKyBGRUNfUl9DTlRSTCk7DQo+ICAJfQ0KPiArDQo+ICsJaWYgKGZl
cC0+YnVmZGVzY19leCkgew0KPiArCQl2YWwgPSByZWFkbChmZXAtPmh3cCArIEZFQ19FQ05UUkwp
Ow0KPiArCQl2YWwgfD0gRkVDX0VDUl9FTjE1ODg7DQo+ICsJCXdyaXRlbCh2YWwsIGZlcC0+aHdw
ICsgRkVDX0VDTlRSTCk7DQo+ICsJfQ0KPiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkDQo+IC0tDQo+
IDIuMzQuMQ0KPiANCj4gDQoNCg==

