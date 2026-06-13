Return-Path: <netdev+bounces-298950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FpBoGiM/LWoQeQQAu9opvQ
	(envelope-from <netdev+bounces-298950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:29:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A784A67E747
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:29:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=ZYTy1GUH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298950-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298950-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF144302AC03
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4783A59A7;
	Sat, 13 Jun 2026 11:29:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A562232B115;
	Sat, 13 Jun 2026 11:29:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350172; cv=fail; b=aoijDZ6jRmEwu7EDAQ+uIeHMcMH1zlR/Cj66Q/KgC4sVYACCFB41JmfZifI6BPXcWTM+K9prx8f1TRTwvNk85HSuZME8sC8fYV8swFwamZGEd8cHHa7fGbg6JyZYrkXt7KBPe1c7tLMIpOmlbbrz1nVDNv4e+Yy9zNsROx0T82o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350172; c=relaxed/simple;
	bh=9QzTeuFyBmvVSKa/U0tAcNAC/yzxV8lAUTzXUmsy3RI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ik2VcDKay1DI4KFa6X1qkzlA4u5gpr6wqO3sjtFPDBXxgaOdyIqDWEa/8/VU0qSAAQzA4gggR9ElJJWBvWv68VEkAmKPBANx0fxoy0mDRltb7+N/72NGyYfMIo8Psp2nVxe/k2I8vDyUBwNO20BwQJwtXrJCcaeJN+BJuwXNebU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ZYTy1GUH; arc=fail smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DB2cLe184955;
	Sat, 13 Jun 2026 04:29:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=c2MoNk2TYtUhWzEk/wbyb6jdEYlVzHnRXf+8dNtEjIg=; b=
	ZYTy1GUH3HhCWMaUpEFwoAPTxzs732EPMyjb3BaZew1NBB8S6Auf1550aWQx4Tjn
	kzfXIAQgv1xHyRmwqN3B3aQpWc04CB0Qc5HAOWo+5YmrOnkV+4qqAy14aIXGIFxt
	l+EYqPaonDgj9LitUin+gvOWdbSk7NBjDhd9/d9M0/giAUyQrSSWTxCfknn3yWix
	1Bhdt4Adl41GoBWolwdHsI+s0CJ7q5kRUPz6XHT72aTSXHfoIik9pkHLYVa3FBQ2
	LTFfD43coLItNvwN9P1P/ABX2KLrvW2hHQSPQW2o6tPsGUBmTFkSPhDJKJMnOJWE
	XWt2/y9oLNNUm8/i6cSrZw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4es2g086s6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 04:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxbhthJbtYroEcs52ERestWoFAqmEZdUAtGArmqy0F6LExBG0hmRfCawGpxpb8Gh6JJR/nWkkxZ2uvVgOFzIPEFbUsNL1QCfX+OtfvD+zvgfogLpqVmsb35CjeO9EWbb7pnIhUehStJonDMWyjnKFLl7SV9XjsjNNBA0g/6MzAwEE7zMGmTFtpHw68vJ8ecXwurJswR7ulqeGK8WuV29Z4J9dToYiFlnLfNXB8vHN2Yb1clfCjgufT7eHrYycC2FzXos74ZOPym4DYx5Qz7sr0Uzj89tIJdxKxK0pmHCDtX16A3SyWJ5cpstTMV4YuXzZLw0zbKeA4jE7FRZN7Gp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2MoNk2TYtUhWzEk/wbyb6jdEYlVzHnRXf+8dNtEjIg=;
 b=w10Vx2A51+ew8ewyojnJ2KgVH5WxJtRvyd7dglbCcO7ODfzhEdsx1C81q14mbbO28f3aadBmnEDEWwfTSrz8mJRpOvr+ozoXc0GkBW+NXRobYoOKhG2XS3fM+Pgc6orLZkMeaHf95LfNVhSzSiKlivEujXygHhu3Y6XNEC4pC1J//kPIN2DH+k/PIHU6/1IEpvqai6TVL2HQwogKUDpHO2nMA0rjFYx02xZ2rCeV/bOfQxl6LL7Ov3MCQX69cqWrs4/lbSdWo+vTVUJ/IwmkQR48E1Y+c65xpNrOiKgT7iDXtQsjtS6+BQIPdFdRY82NFOgX3JsLMff/q1uxybuPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by IA6PR11MB985489.namprd11.prod.outlook.com (2603:10b6:208:5ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Sat, 13 Jun
 2026 11:29:11 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0113.014; Sat, 13 Jun 2026
 11:29:10 +0000
From: "Zhou, Yun" <Yun.Zhou@windriver.com>
To: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "qingfang.deng@linux.dev" <qingfang.deng@linux.dev>,
        "jiri@resnulli.us" <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] flow_dissector: fix uninit-value in
 __skb_flow_dissect() for ETH_ADDRS
Thread-Topic: [PATCH v3] flow_dissector: fix uninit-value in
 __skb_flow_dissect() for ETH_ADDRS
Thread-Index: AQHc+yPvBFJRGKOP2UmN9jvBf9zPMLY8WRvo
Date: Sat, 13 Jun 2026 11:29:10 +0000
Message-ID:
 <CH0PR11MB53321B644C4E0850093914929F192@CH0PR11MB5332.namprd11.prod.outlook.com>
References: <20260609023752.1245848-1-yun.zhou@windriver.com>
 <20260613110055.2318264-1-yun.zhou@windriver.com>
In-Reply-To: <20260613110055.2318264-1-yun.zhou@windriver.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-06-13T11:29:10.364Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5332:EE_|IA6PR11MB985489:EE_
x-ms-office365-filtering-correlation-id: 974eedef-ceff-467f-4978-08dec93efd58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|6133799003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 pdjTDHeHSzWFNCzdm1Ol7whsmyoNwT2BpgRiz+g2xdIenaX5LEwzfPKcRTMfJvq/jPsC6DABDmgIUiXLHNwDhNugR0y3WhdP8kFVEQ/My/tE0HwwJ9vMfJUQVLTeTZlFjN2170fMhgsVk3HZbQe86ZSIC8VAyC4T+nGFXW086V+iI4F7TSrZqHjkMPvQsyAECMar4loqrbFgCjkuheYc1FALunQKjMA7H+nK6D0yHjFYCJ3v6NLDd/XiLYfOHjxCax+JBhfoJjcPIxnZ5XO8t6FWvw/QFKGPubOV65VNueM5cmeqGy9ycqA1jOSrbEd6vU5FfLt8UugNfT5e010+gCgfD3jfWa80la4xHf2fGvlPJlXyBC4bKa8VQm363DmAJ6jViWzJsQqYkElvDOucvPQ2SGI8u+t+tQwtFBWnyJ+MwpfrEkVpUTPpkb5emFayztf+V4LzIn7ACIvMxL4zSoxLupvgeVCE0Nx5Vp6811mtlcU5IEGhFW+6W1qIdATjNDP65yB2RGTzk4Vl7yBaFVca88pewTX55+fgSdlZF7itTJtDjF1FXHLMkiGGed34DRcov6euOB0zEgC9bnIiI5qu1Eamdsbuc9457WaISWLnHTqA7SD+8KxwZVs2YMPnvazpLMNi5m7OvZ7KA/KHUSt/eZ3OJRXEq9oAPk32PJ0cgdqvDg9Rbdb3TnGpNesogPrnP6G0LMH3Jm7KzZN1sA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NxbYWvLvfgDD55lX68HjFalkRPrdgUPE7sSJHlaUUZJMSESxhch+I4wlkQ72?=
 =?us-ascii?Q?RQuQu7Bwf3O1VShJFnXyVuPnlJ2p8PNqrfVMZuWT+BCzwa2Sw5RCJ/xiwv4b?=
 =?us-ascii?Q?9gTlN4x/JYvG7q9lb8xwOxp4WEvoCH74WyxFf3m8D53Spl2/3s03X7QZHs4D?=
 =?us-ascii?Q?fMwa4pwVdmEQlFUCw3aA4z3C4gkf1KaZ68MFNIzKJoMy1Yl+kOcWH85HNBD1?=
 =?us-ascii?Q?KFamME1QW9tr9apLKwaSR13qzvfjUj+cJ9wQ0DTfoh3npTW5wGAF5OVhUqnF?=
 =?us-ascii?Q?cx2kEN9fO3eMPYeXYxWNgGTX3tebPhIrQw3WuBgFRPN1zPOXw8tnb22S6bUi?=
 =?us-ascii?Q?grDBESJFmywHXAGIWuly5lpW29SAWo6rEyDueWy2Qejl6+k/4hsEKWQtPdVy?=
 =?us-ascii?Q?cINSP1KvsLj3cGxUKznJhEjsXlOeg6mUAUlmw1HOPlQFxMkId7jHw//e/kUY?=
 =?us-ascii?Q?XomsPj2Wes+Pf9+0HKiQhQuv7omzIdeL9WDKQ7UYPLcolRVabsz2w4wmuTAf?=
 =?us-ascii?Q?TxiJlu43kp0pNeYUtzjGrlDu+5HL1g84aUUVXxb1k8z3s0BAi+/TCJlGtIwO?=
 =?us-ascii?Q?L2BoVXXZXHh9Rn9shP3xk7F+Z3rVHn9++Y/XePNIhnGsNczyobuqAYkwTR3+?=
 =?us-ascii?Q?hM9NyfqoknNgKlifmLvxUFiOSGZNKUA2Z0Qu1DaPCf08Ks/Vf7aKVpXoVQa3?=
 =?us-ascii?Q?MdZeC7O1CD7urFulz1NsITaa1aloYh5EioCF5PASXAipHxNRzbhf5dPP0TJT?=
 =?us-ascii?Q?un5z+B6D2xE4WaSVRyLJRZVruhQ06yTwRwAtDxFcbOxy6CTCNlrtgPZP6IkD?=
 =?us-ascii?Q?8MEPk8bhxIofVIJCiFGDod4k15peVyVTTEbRIjJMHKTQ0ISWhRYo3vMsoxYu?=
 =?us-ascii?Q?bNuBawLAZ0GQTIC6a47t28+4SUBkBjUK6KJNvkiMaaDzAcZm1qHwzxmAgd77?=
 =?us-ascii?Q?TC4LDJOkdOw8YX7VhiM3IghtQrAwXV4G0Tyr6Zt9l84yq7tvANEKGuvmZK4o?=
 =?us-ascii?Q?u6C85GSlW6TCcaOGYXsQrB67Mo9lwbwSaZvnNQYsRuTLHSJ8chsAzlmNlfhU?=
 =?us-ascii?Q?Je+kq0tyu6Dpjn07kUstHE32rk1YMgpfiZVjPdveQOJqqoFJAr1GvWM3sFga?=
 =?us-ascii?Q?L++KWzWrLTSVoG5RNt9zvqKZ4XRqcvSP/g+XXcc3/DSfAEerJbYvb7sCIukS?=
 =?us-ascii?Q?K+ig3AfZlYtE4eGG3d1JzA6Ou0LNJfO0z56wBg18roOHueA7KsC7urWiTjpP?=
 =?us-ascii?Q?ELCf0ttoafI+s0F/rK/WFoBA5bky5RadmmMPBySNT4RLu9+V6RVxW2Q57Xzk?=
 =?us-ascii?Q?mv9RSjmjy/ylE9iBBBOMnj+H6MNwYhFcbaCeZ67pS2mbeRnPqeHCMxe+ou5U?=
 =?us-ascii?Q?Hf5G5yXic/vHy/RZtrqOs4Cjma4KmDenV47JBZw/XOEsspMi3On6LUnxhMtY?=
 =?us-ascii?Q?kypzGJktbh9lk3MEVzZQBqOSpMzsDGHm1WfCyaZv/EF1fKr7q8t57z1KXDow?=
 =?us-ascii?Q?PKGLwwUiywy6RjorrjEvzTvrstXSXyeBtNHlQk8sLJeT8dxzsTLAU/Bh+C2H?=
 =?us-ascii?Q?pHznpxWwb2d65N2bR6SkVv8pfI2EOI1AiUOyCQWWr9BRSSNvSW/Qi4p2VzJL?=
 =?us-ascii?Q?4EZwlkomVELLImjbDPzRGz0GVM1Qoek/wjw0CNJbLKwRXXWNAfeio5nAbro3?=
 =?us-ascii?Q?2+2gStOgAjRBrorqhNQ3OFPoAuitCm9PMVWLkhVBdaZnnnpUnSju4/X6ivMA?=
 =?us-ascii?Q?J4l0kf66Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dh87me+5IEi9/NwnFKOpdkRp2Q0+rDHji7yz52GMS/HYAlUbgIhrtIB6oGW79hZsCn9BhZj58jWc3fNu0LFgc9j9yT3jVdscEKHaWWR0Fn+if15JA7NC7BXRcAIgV/M1IFXV90o+ejVYHzZWIXyR9uWmglyy6fw2GrVLcxLnP1h0/kjgV6yGjXka3WrJ7nd5ZL3+KMKyd3k/M2txyO22kClnVTU8C/VoC/SGl9gu5ZAt58e5Y2R3FP1pYCuwaihcnnWR7m0hknalbgwHLkLl/fl0qd0l5gy+UGT6NKLthRoQ9pBcpjGTbrvrBjKudnrHtJpsc+R/+/KSPEpD9l6Ftw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974eedef-ceff-467f-4978-08dec93efd58
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2026 11:29:10.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvSQwFr8Z2UwYWCdInsS29Iy4M/bNG4ScuDmLJ4ep1AM5nbcFfLP7+9Dg0qeV/BmqcL68R6exwbfBcF4kzVlNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR11MB985489
X-Authority-Analysis: v=2.4 cv=ZJ/nX37b c=1 sm=1 tr=0 ts=6a2d3f09 cx=c_pps
 a=boTDQTO5XcRoDQ12XycLVw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8
 a=c78_fcLdy5ar3p3FhH4A:9 a=CjuIK1q_8ugA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDExNiBTYWx0ZWRfX0sasV+7pQmy0
 DSBFWOJakIAB9MzTIx2hyETw4WITRFdYZmvE8umU1HTCZ1u+CP457G+OumvqO9yVSyhTYKZ85yc
 4JMiuKWuNAoZIvXD8zsNwf7izttvc1D15SwBY5h5bXBbnxvZjntyq6iIvECJgZWYNSRVf8bk7AD
 wI82SicYqlTLd9jO7iCdvl2w06M829R0fKNKXpd5FIvbY+xfGYIydEimm9a4dsV93pBRAfN6v65
 EbhSqsoDcWdTV/a+PFYdBTYUYuZh5JGXef60/pT9IQr7yVLi+nfuCG3pPvfRlIkSx72gfO9ZsJl
 n/HSzMz4yZ4UO15YcubaGibteoUtrpH/z7ATk2KK3dvsMiK4BXECbpFS3jw2MwJ3zrc3TsvZyej
 Tak6M7QVqxxg9CIj/g1U7QC/9DYanPY3SciPustN2XzQtBab3G4B3+p8EeDnzqwpTev4s779bx7
 bHNs+29pUONxJsib4qw==
X-Proofpoint-ORIG-GUID: y0obv79kTkstd6dBHCgdp51mewASTJrt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDExNiBTYWx0ZWRfXwK/2x84bw1fE
 5T6VBmWuFi7bdTBa97dmwzSYQYvXRt4Z006vawFXL5oo88KhxGLpV/oE+NB/n+BhSxrXPxBcFwW
 mVnNX6VmhyyBlIbD+LKBijviyOIxScNAHiBwNaJcXdEbXAb5URV6
X-Proofpoint-GUID: y0obv79kTkstd6dBHCgdp51mewASTJrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606130116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298950-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,windriver.com:dkim,windriver.com:email,windriver.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[Yun.Zhou@windriver.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:qingfang.deng@linux.dev,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Yun.Zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A784A67E747

Superseded. I will launch a new thread later.

________________________________________
From: Yun Zhou <yun.zhou@windriver.com>
Sent: Saturday, June 13, 2026 19:00
To: davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redha=
t.com; horms@kernel.org; qingfang.deng@linux.dev; jiri@resnulli.us
Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Zhou, Yun
Subject: [PATCH v3] flow_dissector: fix uninit-value in __skb_flow_dissect(=
) for ETH_ADDRS

__skb_flow_dissect() unconditionally reads 12 bytes from eth_hdr(skb)
when FLOW_DISSECTOR_KEY_ETH_ADDRS is requested. This assumes the skb
has a valid Ethernet header at mac_header, which is not always the case.

The problem can be triggered by:
 1. Creating a TUN device in L3 mode (IFF_TUN, hard_header_len=3D0)
 2. Attaching a multiq qdisc with a flower filter matching on eth_src
 3. Sending a packet through AF_PACKET

Since TUN in L3 mode has no link-layer header, mac_header points to
the L3 data area. The flow dissector reads 12 bytes of uninitialized
skb memory, which then propagates through fl_set_masked_key() and is
used as a rhashtable lookup key in __fl_lookup(), as reported by KMSAN.

Rejecting the filter in the control path (at tc filter add time) is
not feasible because TC filter blocks can be shared between arbitrary
devices -- a filter installed on an Ethernet device may later classify
packets on a headerless device through a shared block. The device
association is not fixed at filter creation time.

Fix this in the data path by checking skb->dev->hard_header_len before
reading. If the device does not have a link-layer header large enough
to contain the Ethernet addresses, zero the key so the filter will not
match.

Reported-by: syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dfa2f5b1fb06147be5e16
Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addres=
ses")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v3: Replace skb_tail_pointer() - skb_mac_header() length check with
    skb->dev->hard_header_len check.

v2: Adjust commit message and comment.

 net/core/flow_dissector.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 2a98f5fa74eb..0b235ec0743f 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1173,13 +1173,20 @@ bool __skb_flow_dissect(const struct net *net,

        if (dissector_uses_key(flow_dissector,
                               FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
-               struct ethhdr *eth =3D eth_hdr(skb);
                struct flow_dissector_key_eth_addrs *key_eth_addrs;

                key_eth_addrs =3D skb_flow_dissector_target(flow_dissector,
                                                          FLOW_DISSECTOR_KE=
Y_ETH_ADDRS,
                                                          target_container)=
;
-               memcpy(key_eth_addrs, eth, sizeof(*key_eth_addrs));
+               /* TC filter blocks can be shared across devices with
+                * different header lengths, so we cannot validate this
+                * when the filter is installed -- check at dissect time.
+                */
+               if (skb->dev &&
+                   skb->dev->hard_header_len >=3D sizeof(*key_eth_addrs))
+                       memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*key_eth=
_addrs));
+               else
+                       memset(key_eth_addrs, 0, sizeof(*key_eth_addrs));
        }

        if (dissector_uses_key(flow_dissector,
--
2.43.0


