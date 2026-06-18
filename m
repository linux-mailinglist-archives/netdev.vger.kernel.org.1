Return-Path: <netdev+bounces-300371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mEoRATi3M2qOFQYAu9opvQ
	(envelope-from <netdev+bounces-300371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:15:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C269EC44
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:15:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=Eo5dh7nj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300371-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300371-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 119BD3006B3A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA139D6CC;
	Thu, 18 Jun 2026 09:15:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BFD3191BA;
	Thu, 18 Jun 2026 09:15:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774132; cv=fail; b=hUKLGkRbgdJlkCMeYJwQob7w2TlDOMCO2YZ6w/GuitQ7bOI757ySUGRCTc+Jg4AuXhGHvHODzqOH6Q/UKPiK4WLs3NNZ9T/uqu03QJWAX/tkeydUUNEH6uEauSFXyWFvGTqB6/GXOy3zGEdRcq0WJvSwau3CDG0o4PcmHrUn8sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774132; c=relaxed/simple;
	bh=QPYh866hi1xmpemUhf7+dyhAi+4MVOklZum5tTdxr7A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mYSbC53iR2DxidSuEiB2Xvz3Uex4pwfYFRpI5EGQRVv/HMzHmaVAho3aUha9WYO2poeSjg8Utckz8771DU1e20Wl9uuoP6j9EyjTQxnxfEomPW76pvR1N69uii8f4MwBDcHbFTobBhgjCCbxaZo8kPP13iWlXgczFNZyPAKxw34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Eo5dh7nj; arc=fail smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8Fbwh4120852;
	Thu, 18 Jun 2026 02:15:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=otYcMs6W4ypdrP8CA/Aentc2g8VMOofCHxJPTDHW+Ow=; b=
	Eo5dh7njJM+mCEALv8DTe23BXlqqmNI49WiYtsP4Md3sCcgHt9b98Zua2fE/Km6B
	0SM5vT8GGbML1gJ5zXG7EwBl7HLWuJrI1Ye5nzLeyW/T/r04jRdhR92GVxILnzyZ
	LVjApz8hEkFQ4IN9CxAhOhF1hmOr3e42ZTi7mYxgKXUSXv7a9iS4W25Jnz7Me1ZN
	e3BH1SScQ7Rg01h7eiJqTLmzbJEA31q8ywaurD0QZWeiqRkhS8DAFHRdvNiKSeTe
	xbbQ0EaoP5jAk4zAPSV4tWUXDh4DGPAQXZYJyredcBRXl6MX/85z5F46Qdu5A8lB
	HOIQuAFea5laSBeq1oXyPA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eueft2ckd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOnvXRVZuQ4Y5PQDrrYD2VeRxZSHmpJp/mQjFRh7fT6xkSaQV5SfeFG2Whwb4j4qBX19iztSu3thEOTAorJW9nwMFujDMNVhoi3R9toDsXB4an3tzsRocbkCvZKlTu7ubddHDqgk2KCsO5jO2F5yqvWmksO+YI/+v+z5vC4EIAFuVUqPCrwkW31fd4RL1AydA9eX0VKQ0ZU8uV+iid2E3PJOsXAsPitPJ1FAVuNGN2vKd9O70D7dhR8WQRjSg8Iekjme6wTK5VvYlQAcfhCvMo0ixjSYbKTS3+E/Bas1i0lrxS/LFXRZsCGFzjH5+kPyADOjtRg64Gt8FjfmzuZGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otYcMs6W4ypdrP8CA/Aentc2g8VMOofCHxJPTDHW+Ow=;
 b=phxre4cjYu9HnDim1AKd9LzPAQU8T61UQWuIOOwWqUXjSJSEPgn9A3DAPOEc4pd1pjq7rHDyBBZI5OUlbVkNJzotWwCAcsVvdWXnRiZ/dlUy3317XgRx/x6d6F6zSJWlpR8WzK/Z1ipfQGNjh0rr9uRQH/D+u/qXN2qy8h9X7C0344lZ5Tux/e4EUDvbqdCDcBZcdaOZAs7zuVchO2FMz2wMc3z9ddZ/QwWNzJBg0KHErkDZgGB5wqOvPRzahBGHzD4oWlsBV3Mse7qUydJbDjkQjeeXjPJYdPn82/qqZTEb9nhvVORe+0lR6aHdam1mNOxbCFyN7r43nFW2S2KPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by CH2PR11MB8868.namprd11.prod.outlook.com (2603:10b6:610:284::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 09:15:05 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 09:15:05 +0000
Message-ID: <bb1ee9c0-06d2-4bb1-8960-4088c4148eea@windriver.com>
Date: Thu, 18 Jun 2026 17:14:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mvneta: free/request IRQ across suspend/resume
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        clrkwllms@kernel.org, rostedt@goodmis.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260617092028.1722407-1-yun.zhou@windriver.com>
 <20260618083952.IbGzrvJL@linutronix.de>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260618083952.IbGzrvJL@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|CH2PR11MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 2573ebe0-ad7d-42e4-e10c-08decd1a1590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Nzmn0U8yhs4Py4cUfVQJPbhQHeLkIOBS5WHSqGYroI9edVLdd71TPUs2vgQ1ECp6doH4nHUwza6DkYvrQkMYuhSh+FaRre8zd0DPvnxy9Ce0O89CL/tZk2ZpcSw9LcDyIrv/cxeu0QAxzMIDW+/JPm6pt84W3rOGl/ATC39Y4SErnjuvnTfcMn4V+2T426/8ekFlALxruXxAeTdQ3x6O2Bu7EE8GTStBJaplyy3HJ6uQ+x59ROEHjcqsJxpwqCgjFsJoHEoamyuYLwP5ADX7H8drYNaqHGouEoDVrXKtGafhugeeh+fcLHIHmMBoGKS8yTnnG+NCEc+GPixQva6qgIjqGUx+3jBdTpgjzaBAyKJYMZEWIqmFbGGBT8QNhJC6OwxD9O9Eok5fM5k5zc1Qcxv32NOKcdWdou+ag2aUPS4Kv9rmFPhvvE8CGepg1rsnNpIoMuUC2i1xiFZdsIGD5+oQSuHvefZILX3lSBT+a+z/230VXL+/IzN2PQnESvWe1Y1lFzVddn6dWGjdSVvZCBs/qU74P5Ke2fn/t9KFB2trMo+cKiT1THBc1g/nQTEUHN/zZMnnEVxJLfzym69+HJPKFCmEcUmFntX3vI+9FtkU1qwOzdp84xmh8+Wh49d43NBFjaK+oPytKD1nD2Xkl8bFfWC9NEeBc0E30afJ05qp6QWLhYJsr1YaPwlwq8eJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHozVjhlVzFlZHdIT0FuMXoyN2pxQmVCTis3UldmK1YyNGNldEs1cXJDN1JH?=
 =?utf-8?B?SUdycTl6N0x5bUMvMytDc1RXSkhzMHk0Mkx1OEpZaEl4d2hzTDVDNVE1TVhl?=
 =?utf-8?B?UjkyMmxHckVHSGJnNjF5UE9KYWhESXUvTHZId3oweVgyNzJ3UVJpRVNmbVZo?=
 =?utf-8?B?bTU0dzZSMWRDQVhKZ3FxdkNjdldRcUZtZ3BYN2ZlQjdLT2NzL0UrOVZvOXU4?=
 =?utf-8?B?eGkvKy9vMWhJTEFXcHVDb0dXNTU4Vnozd2FkUmtZc1MrVk1Kd2c4ZjVJUGRw?=
 =?utf-8?B?bGFOQkp5L3lNbGY3dlpReTVKb1JLQTRHdFNCZFJEdUs5MTZRaXFIamUrVDlt?=
 =?utf-8?B?bEFlWEtKZDFScG5QWUI1WnBGdzhHZkZjak05cTQzbzdrbWU2L0FpcmpKREFY?=
 =?utf-8?B?VzJCMnBCMExaOWxyc0JSK2NzZGV3ZCs5QTY3TlJtTVdrUUx6RGpFdU1PR2hP?=
 =?utf-8?B?SVpCWmY1SXZwYUlOWkdvNUxnL0hKdnhmR0c2OGdUTktmOURGUWdXOGFuVWRu?=
 =?utf-8?B?SFJ5MnhBWHFjZHhxL3hBT2JBbmxWMDZIQzlIOUJmZWhwNUR4T0xrQUtjTTZI?=
 =?utf-8?B?ZEgxTG1ZN0Z5SDdyVjNVb1BTTkNCaWprZmhQZTVoZlpvQjhaUEpwOTRlWHF5?=
 =?utf-8?B?TnF1RmJKYkJIZW9OSmFybllUS3JZMnltaE13SC9hS21JVFVUbXl5dG1HWkdu?=
 =?utf-8?B?Yk43TWhzSzhBQ2FYUzllR2dGZi9kQmVkRzJUWlBET3orODgvVXlHUXUrUi8z?=
 =?utf-8?B?L2dVcnhBMXcrUWJJcUc0cE92N2NnaFhFdTg5UkF0aXZIK1pZREEzaXlxd0JQ?=
 =?utf-8?B?WXlaYWFYU0RYckNueFZESk1jcDRLV0R0MlI3eXZxdElUcmVvSDUxdnQ0OEZK?=
 =?utf-8?B?YmVHM0VNVTZNdkJqU0xPVEVnK25oakVGUUhzMU5RNkxMcW1TTW5JRTRFVS9M?=
 =?utf-8?B?TjloMnRZY1JEelBjd0tKOFlndVVLSlJXVUNqWDRGemRINFVPQUI5R0grb2pN?=
 =?utf-8?B?dldES2tvRE0vaWdiRFFld3RnUm1abTF6bkhnYjdYcE1SdTNjM2ZMM3pQek1F?=
 =?utf-8?B?dDBmUnpGT3RVaVFuZzRGdGMwUWZvdXVjV3NIYnBwNzB1SWFVRy90bFlaL2I2?=
 =?utf-8?B?bW16NGRwRlQ1SS9uU3AyR3pIL3FNSkhwRGg2ME1qOVovcWJKRHEwbWk1a1dQ?=
 =?utf-8?B?Yis3MHR4QUFIWkc2Rm1GMkFkUEl2a2hocjNWTWdBQkFpQWhLVDYxUnJIb1dk?=
 =?utf-8?B?ZWduM1VlYXhVZVdjMi9jNkgwQzZVeGRlOWxHcUZKMGwybzN4ZGtKQS9jS1h3?=
 =?utf-8?B?NXZwZ0hyNy9DcWh2N2ZhaWEzV3U2WldVOEpyL25qUGsreE50aERDOHdodERs?=
 =?utf-8?B?UXVNeDNmRVBHUDgzU2xCZTNYK3h1SkQwMUtHM3ZENW1hN01GN1JrNFBQZTVG?=
 =?utf-8?B?UVlLWFlGWjlZVEsyQzFzdUQrWmRaWGJsajNnVlZlbVVTTUlXU2JQT3QvMjVL?=
 =?utf-8?B?UllNNCtMOFhXSVhzcU1uK1RqZmV1UkNUbG8xNlFqaTFpOXczK2RYdE5JbEIv?=
 =?utf-8?B?MUVWMjF2QlVicEVKY0E1QjRkc3hDSEZrR0ROOUdHR0owWjVuSThERW9LcEpR?=
 =?utf-8?B?MCtmRTZHempzUVJ6MTJtRnBjZTBVUzlHVmN5VnYxNmY0QThDbkcyNGxGN0VZ?=
 =?utf-8?B?UDZQMHR5WFpnRTgxNkxOQm5uR3h2YWdVR3dILzBpZk44NDFUYzNVYXJZejlE?=
 =?utf-8?B?V1VqQVhlSzRWSW5Kc0t3OFZjYkh1am4yVU0rTG9kakhLcmpJbzhtSE9FSHU4?=
 =?utf-8?B?bE5GSVZCRDN2MXkzUHlSazJZaEZvdU9ScGdPNlpldWRIbGxsalRkc3RqQkJC?=
 =?utf-8?B?TDEyOXNubGgvajlVMjNQQVoyYU5wMlVZVk16bGZBMHptdlVYa0FsVWRKQ21U?=
 =?utf-8?B?NWpGb1JiYmZueGN0T2crTUo2YWhpckNOT2NiOG9yemttRmNVWU5RbXVhVXpL?=
 =?utf-8?B?ODE0VjlFYllocURaM2dCQk9pcUYwbi9jM3lONlJucGRjdlNWOUxIeGJVUHQ2?=
 =?utf-8?B?VmxZNE8xaUJpVzI2QmY2UXhKTmJZWURuMUVsZVRjVnpwaCtJU3JWZEFFR05p?=
 =?utf-8?B?U25pamx4UDQwaitsdjBrdFBRenBrcmM4VU1IMlczYTRUdGEzcWhPTlJISVhr?=
 =?utf-8?B?Tk5lc2tPSXhvTmVFY2NUYnlYbnB6Mys5cW5uMTRwaE1BczAwd211b2NXQWJm?=
 =?utf-8?B?T05vL3B3dlc2VVNCc0sreUxHTGZnQmVmeHJuSXZzMVo2SVNkcXZrQUxPbXBW?=
 =?utf-8?B?V0dPb1d3cEk4cjZGMDlQbGcrZXROT2lqK0NXeTBpdHdURmhWVUg4UT09?=
X-Exchange-RoutingPolicyChecked:
	G5ydZa6c99Icveb18Cjn5VFG84lWwMgENAyRf1Q876WZ530+V3oTPUOfmZSi09u5d2zKRjtqIg1Kjx4jEmdJcVzX8hEkt/yPxBAGnyG+iy/DwUpzV2T2yu3eaMvRuDgkldsHr7bEDTPWppqJokoW3bV4U043HlIfToFobZIxr2WsXJ8gXsbA0vVcF2yUDMdEmtYIFsVYj+rxTD6rbofMeX9PBUKqPKSJmO7DrwKdqDEFXeFoQC701335cF9FM4lX6XLUauw8UmS1LFd6+uIKBjcQiQyQonQcoKKkBXCXRomnYwrWmCJWtUOJ8Aad1tsLXlH517MFjKC7vptiOPMHOw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2573ebe0-ad7d-42e4-e10c-08decd1a1590
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 09:15:05.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7E7NLlZKUmv+ltlgtJApZT7moaOrkY83sA5w8kgemDy25j5C7wblSsQ/zmEJiyqxVwbOEqcilmTseXkE1xWuIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8868
X-Proofpoint-ORIG-GUID: HLALQiSI3Oygj2ODRQnmQddnadQtqJ0D
X-Authority-Analysis: v=2.4 cv=B+2JFutM c=1 sm=1 tr=0 ts=6a33b71d cx=c_pps
 a=oxxrQmGkUFFO/gDwv9AvRA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=bmrry5mmEwNol66n0X0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HLALQiSI3Oygj2ODRQnmQddnadQtqJ0D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4NSBTYWx0ZWRfX910jk/eWIEWb
 GZUhmx6XEdTaSXLiGW31vsu26L4VM5uRiCO/Fd5tFyFuTl6R4BNE5UCdBpHTKsS3oV4B6EZg2Gz
 bv4y27mdscgLS9IXiJ3cvmhqqw6vHQixQLu7Nzleu7zAtLgb7BSa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4NSBTYWx0ZWRfX5i+0QXC3Kl8T
 EW/UtfJdJO10rE3dRQmo7ViRbamWY4YMTb42+Mn/4rXP73TyP+gCnEU6CTzKhjDRZQgHTDOsEWd
 9S/e5o8QQrV7Va4ZWiS1yliizSn/v1W/yFgoN71uyFfaYVufYP1E9qnO2W0g37aGwtaDIg+Vijv
 Hm+ZSwBC/WJX+ockFn11Viu/eUptZ1dgup/fYPPrYkC1xvYx5v5VFC/NQHBRJppEj0w66jLC7xd
 MnDG5MlL9MjzDOOZb/JVl6OY6FMQKfsMXQoGhLVPgFSXjtw1zODbJpoPrklbK2626AdBmXFnCc7
 OtgGqVj7Y+6rrLcEvcPG3G2EYf+0onTe053xxun6og1LvlfMJZSVQ5fiwYOUwsv5FAkdpjDH1xN
 iZ4eCUIU33S8s0qJS1tUiBbimi5qVfJ0LDq6rSTpy5dbntcMw6wOFWfL05ld+fTLU9TrEz7QTtl
 fWqS+1iWR93kAxm1eZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180085
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300371-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:mid,windriver.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,goodmis.org,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 501C269EC44


On 6/18/26 16:39, Sebastian Andrzej Siewior wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On 2026-06-17 17:20:28 [+0800], Yun Zhou wrote:
>> On PREEMPT_RT, the mvneta IRQ handler is force-threaded. Under high
> There is also the `threadirqs' option.
>
>> network traffic, the IRQ can enter suspend with desc->depth == 1
>> (masked by the oneshot mechanism between handler invocations).
> That would be irq_desc::depth.
>
>> During suspend, the kernel increments depth to 2 and masks the
>> interrupt at the MPIC level (clearing the SRC_CTL CPU routing bit,
>> due to IRQCHIP_MASK_ON_SUSPEND).
> The interrupt should be masked while the depth counter goes 0->1, no?
>
>>                                   On resume, depth is decremented
>> back to 1, but since it does not reach 0, the unmask is never
>> called. The MPIC CPU routing remains cleared, permanently disabling
>> interrupt delivery.
> But why not? In my naive assumption, we get into suspend with
> irq_desc::depth = 2 and the threaded should be woken up. Once the
> treaded handler is done the counter should decrement by one. Then again
> during resume reaching 0 leading to the unmask. If the thread handler is
> frozen and defrosted on resume then it should still happen but in
> different order.
>
> Something is missing here based on my naive assumption.
>
>> Fix by freeing the IRQ in suspend and re-requesting it in resume.
>> This ensures a clean IRQ state (depth=0, proper hardware routing)
>> on every resume cycle, regardless of the pre-suspend depth. This
>> follows the approach used by other drivers (e.g. igb).
> The igb shutdowns the device entirely, not just freeing the IRQ.
You are right. The original analysis was wrong — mvneta uses
request_percpu_irq() which sets IRQF_NO_SUSPEND, so the PM framework
never touches this IRQ. The depth never changes from 1.

The actual root cause is simpler: mvneta_percpu_isr() calls
disable_percpu_irq() before scheduling NAPI, and enable_percpu_irq()
is called in napi_complete_done(). If suspend hits during active NAPI
polling, the MPIC percpu IRQ stays masked after resume because
mvneta_start_dev() doesn't restore it.

Will send a v3 with the correct one-liner fix (enable_percpu_irq in
the resume path). Apologies for the incorrect analysis.

BR,
Yun

