Return-Path: <netdev+bounces-106041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2D9146CC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78DF0B21992
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5A613440F;
	Mon, 24 Jun 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="U71V2+FP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1801339A4;
	Mon, 24 Jun 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223037; cv=fail; b=cZJ513TA54ClmcZBzhiYq6arkxRW91G8xUu6sbT3OXI2MK+4MdlUKv8sQMkPRlo8pzRIO7s+wF5RY8gBF6O4iNEdcF4iSCHudHuqxC6S3RneJiRxWT8+VYETIGtgInOmhlOYA/WFjyC9xksYrNepihYUNgCwjGBw+BK998rvJ3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223037; c=relaxed/simple;
	bh=wYS2h2LAJXUdnQd2yLqxMR+Uzt1aAyPNUKhhpPJEu6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rz751hMaEmn9UX71Faus48jLhoSwHEt+hHaGRT8JWNvSmd8HiseopOvICLmiyDGqTI/sGz+pKwAJ/gk7BxCi3y7gBJWRu+8VOIokg89G/1J2cP+NqaXkvoKdDobrspIIIHaqtlhIPPmzcbuVpjh0ZOYmBnxZfFIrgIo586RGp04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=U71V2+FP; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NMkDOL024531;
	Mon, 24 Jun 2024 02:57:09 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yxcgtk27p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 02:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdkGsoZCFrwjhc8qOOT+l9bhOXAT4s5j7V6Z7+zsNxG3bPwz8oOADcON9TJ6Gb5oOLQ+G9aX5aA63tI4YsXGfSL7hNpiWl4P+Bo38NhWb2oLXqAVo1oQgFGFXGl1dAVMk1to+X4g3XH3iwXvKq8FHztXJXr4pG8AirFWEGJwemMYaPFuOXAv6pCpmmQUMALCOKRXOzj7UFKgmLpfeVrXoji7igqqUYGtmD+NTzi9opKmrVEZgJBwyosMHZUonz5fwt33iuYQ55kyN8cg5z601RaN8ggIY6MP0DvrT8Y+CT8c02h7OlWofU32tdef8AHjlBZtbq9/8CQ7LgxDfLyTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYS2h2LAJXUdnQd2yLqxMR+Uzt1aAyPNUKhhpPJEu6s=;
 b=l7V75a/Fo70TivDJzTlDHa9MpfBcd7TeMUa/nAk/OBehSH0INE1OK75HR9UR0QfVhyCUC80pmbaVPblOYuYvmcx4p0gW4t2eR4x7XDmXPB85z6KUwbH1q2QXAzSzic4hUpnZ0rhUDJrwJWeJdKjmeonJQhjuzohdZ9ZqI5k+zU0khO34Rj8954p3HWHRHfGh8k/iaUZEj8kpMlmUFBJRFKT49QQDM+r7lZY4f2fFymF1QyLo1zhg7qMidVrxwu+hw6CHfyVSMhU8Y1dAgIsLeBNc/Gspb6/0fS/aHtkVkkOSoo+1pym/+CSCMhZEEb7PnN/2aHfgfewjgRZu48twYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYS2h2LAJXUdnQd2yLqxMR+Uzt1aAyPNUKhhpPJEu6s=;
 b=U71V2+FPTKB+6goGOaX+NVDhb3jqJgstSmtiRQEaRiFpYwsSC4USc1amAEmlZ4iUn0/a/trtt1bK8fuAMaEAivWoIRe6Wu53sBFB/Cgnf0pjLIG3e25GwGfGriBUi0fkgMho/2nXPXc11V9gSA+cA4WhJaov938xvdSt4OHAV7Y=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by LV3PR18MB5755.namprd18.prod.outlook.com (2603:10b6:408:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 24 Jun
 2024 09:56:54 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 09:56:54 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [net-next PATCH v5 01/10] octeontx2-pf: Refactoring RVU driver
Thread-Topic: [net-next PATCH v5 01/10] octeontx2-pf: Refactoring RVU driver
Thread-Index: AQHaxhzX9xrcau5yIkKgLyAObUI6ag==
Date: Mon, 24 Jun 2024 09:56:53 +0000
Message-ID: 
 <CH0PR18MB4339D4B6A41AE0378573422ECDD42@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-2-gakula@marvell.com>
 <20240618074058.GC8447@kernel.org>
In-Reply-To: <20240618074058.GC8447@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|LV3PR18MB5755:EE_
x-ms-office365-filtering-correlation-id: 166687d0-6fbc-408d-7030-08dc9433fa23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cXBwaWxOMUZ2bFJlR1lqRUdkU3ZEdGpVcGNqbDZxcHUxdVJmMzF1TG42Yk1G?=
 =?utf-8?B?YXg0Z1dQYi9NMU1Ma3hSL0dwblJueVExWmNYUDBUYWx2bE1YNE9QNXJ1Q2VQ?=
 =?utf-8?B?OEZnUFZTd3NlclpBSzE4djlIS0cyaHBtTmVhWWJNLzVIZit2Y3lhUDNEeUZN?=
 =?utf-8?B?ZUZMME81TjhUUjE3aVFpV0ZudG0rdG8xT1d6NCtveGZ1NUluZm1rdEtLU1BQ?=
 =?utf-8?B?SEVxdUVVZ1lOWUU5amNqR1UvWXJsMVUra013VFEyeVlMbTZKZWFOakQ2MkJC?=
 =?utf-8?B?VW5ZMGJST3hkK3oyeFp4ZzJ2VytFd1ZoM1RnaEhhYk9TMHd2ZngxOVNJQXE0?=
 =?utf-8?B?ajZBSWoxOTBaVmhEZ3JySUhTWVRCQmxEWEZSY0NKQXAvS2FwNnh4R01HMS9G?=
 =?utf-8?B?dVJ4RDUxSnV0eG1lbEt2OXlRVjdvY3h2WlJvQld5b2xoNzlGTER0NG5kTGdx?=
 =?utf-8?B?WWJJeWFrMzVLVnZyR25nM0dySTFDQ0lFR2I2ZW9tcmgwSWxSbkRFRndvMHNs?=
 =?utf-8?B?Z0lRcHBHenhnZ2dMNWdNWVFOK1dvQTJzV2Ztd2x6TWZHN2ZVNkdzeXJ0dHB6?=
 =?utf-8?B?VnUxYkljYlpqUVpBMVN6RUt3YTY0c0E0VXAvdTB4TVkxWTdmVTg3RS9iNlJo?=
 =?utf-8?B?d1ZlK2hoN1dOWlp2UUtza2kwd3dsK0lmd1lNZ1NXZ3k4U1ExRXg4TTMwc2Qz?=
 =?utf-8?B?eGgxYUZyazIzWTNhRkxLNENhL0t0eWtJUlM3cFFGKzVoTCtzNWJDdGJhWDVT?=
 =?utf-8?B?eFQrUGwxRjBTY1p2aG9DaUgyS0JVRDh1UkJsMkRQc0ZRS3JTNjYzVG4vOGVI?=
 =?utf-8?B?WnZnRFVyWjExWXRtZ1BmUnNlajBKL0loRVJFZ092VjdaZk5kQ1FrK2RlOUNr?=
 =?utf-8?B?OUxNVFN3MStzVnJVM0xZdGp6a2hvcmtBdUp5UWNxYlNqeHVMVUg3Unl5Q3M1?=
 =?utf-8?B?cGhqci9QbnowMlFvS1NNN3pLVFErVVkvcE0vaEdKd0tra3lKZnM5SGR1aFQ2?=
 =?utf-8?B?d1FqUmIxOXhTQk0wbEgyV2tScFZuYVhUZm0rdDMxZFhteWpCdkQ0cE4xb3p1?=
 =?utf-8?B?M1BYSXM5S2Y5SEdVdkJMNWdTa1E2TVhMYThUbU9UYXlPNUNRdk5KR05FbHF2?=
 =?utf-8?B?YlZrQzRUbGQwUExDSGhITmd5M3VONWZzVks0aG1ENHYrTU9nVi80aGR6ZW0x?=
 =?utf-8?B?NFo3TXVpR0NBSURFMGVvZi9PbUNNbk00a3NlWmlyZGdIL1lWRk5JTGJHV012?=
 =?utf-8?B?NW5BeWh2Um11b1FXRTdOSUFQRm1GVVhTUW01Q3lnN0dFemkzR2hqRW1MVEdW?=
 =?utf-8?B?TTl5elVkSW1RdzhqTk1mWUpZaHVzTjA3WTdxZXJtNXdyaUQ1dmdtdnJmaGZy?=
 =?utf-8?B?NDdKNnd1aU9nMFFUSjJvUnJHQjdJdGdXeVkwb2dHYXdRZnQ4YlduSUNDVnJO?=
 =?utf-8?B?dFM5R0sraFlpMGtBZy92YlVmS09UQmNGK3B5WVoxYVMxdW1nM2FURHFnaHlp?=
 =?utf-8?B?Z0h0MHdZbkdOV3Y3M2F3SkFxeGxhTDd1Q3VGOTNlZUtSbCtwWmdWajFweCtX?=
 =?utf-8?B?L0lCVTRxOTFnR05oZHE3aFlsTWVUT3B5eExUUkFqOFBPT2trWTFFY2Q4Sm9j?=
 =?utf-8?B?R3FQYjVxbEhJN2tuN3kzSFhTYnZuYnkvT25SNXQ4VGswVFlsd0xDOHdPN0Ey?=
 =?utf-8?B?UFhCNFVoMzlHSmFJT2h0SGxRNFV1YVFOaStPOHR4STlnWTFtWlpZMjdFN0RB?=
 =?utf-8?B?eFYvWEwxWVo5TnA3b2dlOFN1aFhvMUNSRG5UWXZ0SVdkZTlYNzk3QTZTdVpE?=
 =?utf-8?Q?K0H3prUP5rsvslVNwrHfPjxREPBPWJbwPH1XE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MVJsTnRSdHlNcXNnODNydUpHcnpIYVZsMWRvTG5Sc0paYlF1V01xTWhzclk0?=
 =?utf-8?B?YjNtT1VHUUF6Z1l0R1FHWGtud2FlenVBRnBGTkpuS1RrY2lkTVZxOEhsZU45?=
 =?utf-8?B?bS9maEFvUGpkbDl6M2xOQ253Nk85SitRbUdSTS9sVkJsdEZLK0hkbWJxcTlT?=
 =?utf-8?B?UFV6b3RoVGM4SktZM01EZnhHMXpsalA4clRPTEhuakhTTDd2VFFiQUk0R0NE?=
 =?utf-8?B?Mjc2Z2tFR0NDY2hPWWdTTHV1N0FOYnNmdzJNNGwwZS9leVlDak9JZERtVk9o?=
 =?utf-8?B?VEtsVDF2UTd2M09Kcmd1cnM5dmY3RDUwVk1VRjRuQTZndy9hUTcxWmlNTTl5?=
 =?utf-8?B?OHFuTEMxYTMxZS9VdFo0SUVYc2hBU3l5MGcycXFuRnVHN29qOHhyRC9mREhB?=
 =?utf-8?B?NlhyQUlvYjJOZTBKVUJoTkRCSTF1alM2R2F3MExwRW13N2hLWjh1U0poSXoz?=
 =?utf-8?B?WDlTQ0NtOWdaQlJ3Yk5VYkg3NGRCNWFPeXhwL0FGWDZvY3plTjQ3a1crbHZ5?=
 =?utf-8?B?UFJTUVowUTZqdjMrazNneUhmR3hIcTF6WFkrR1lUNmg1ZEYwdGxCWGlKT3l1?=
 =?utf-8?B?NTZ0UjBTRXNYODVjaktvUUNrRjIwWkkvWDVtZFYxNERqczZtSm9YQWVLRXVY?=
 =?utf-8?B?eUNYTXZCd0QxUDdRYmhIbTZLQ1dXdHlQekMzb2pGQlZlRE5yWmx1ekFZOEV5?=
 =?utf-8?B?MGMwUVQrdnNjQzliVU91aE43RGh4OG91WTJqTmdCYzdMTzd1ZXRrWkM5L2xy?=
 =?utf-8?B?SWxRbUp0Vm9JZ1Z1d08rdlhoK0NpS3hKbmdud0VXbU16cWRTWGZTdFJzbit6?=
 =?utf-8?B?WGljZUorY2JvcC9HeU1oUFNvL1VpVHNwU2k3cTh6NEQ0cFB0WVZTY3BhdGU1?=
 =?utf-8?B?S0IzVmdhWWdZc3dmRkRpSTBmRW0xT3Z4V1JkMHhWeWdGcDVwc09ScW5XVzg4?=
 =?utf-8?B?S0oxUS9DV2s4VFg5U0kyOXZsWFhjbGZIcElramYxcXg2VlY2eU5Fb04zZlBp?=
 =?utf-8?B?WVhKd2ZoY2dVVmVJT2puMmJrZU0yTjFhcGx6dXJscFRoYW44U3pmWnBubVhO?=
 =?utf-8?B?ZGpNN3dITDZoRjVqSVdqMVI1Smh6RE5ESTU4K3h0RUVBQThGTWNtVzdVejl3?=
 =?utf-8?B?U3ExT1pBMmdnalNLaGZ2Rm1LVkdIc0RuSCtSanVUMXJZRU1YdlFYbXhFRU95?=
 =?utf-8?B?dFhSRWF1RkhGNzZIOUgxMWc4NFN4MHhqanNsRkVPZDlhamx0V1orcDArNVBX?=
 =?utf-8?B?ZW0vZUN3U1J5cWhiRE42Q3BvR1pBejFGcVBnK0tEc0NoLzZnUTRMV2MwV3FT?=
 =?utf-8?B?cjJabXJleExDQm1xeXZJaHZzY0ZvQ0lSVUJHQ3BCU0kvNEV2T0VuSkVzTnY5?=
 =?utf-8?B?TDIrWEU2Vk5sSHFQOVQvd3BKeFNLSzNMRnlCODJTZjZtZExPNFp3WDBnK0wv?=
 =?utf-8?B?SmIwZDJ4RlJIRXhWSDlTTkhJalhwYUYwMHRNK3crSHR1TlhFS0d3Nkdja0hP?=
 =?utf-8?B?MGtlUFB0OWpFK0crS1krR3VjYlVkVEdXcDBFMDBhWW5xeExWZnlkQWJNS1Rv?=
 =?utf-8?B?RWdHWHo3cDlCVnIzRjdiazhFdDVaWTNwNWRtdW9FTEtUc29vYjNRcVFFZEZv?=
 =?utf-8?B?d1VPRlFGUEhheTNIeFRaWFpqL2tocEV1OWRWQ0dEd2k1MmduU0M3MVo0SW5Q?=
 =?utf-8?B?bkowREE0UC8wdVRFM3VROHh5azd4OVFXN2FyTDlKZE1BcDkySmJ6N3pWWEk1?=
 =?utf-8?B?WGtLQVpvSEh0T0dlUkxtREsvRTk4dGc2ZnRxem0zYysrbFRzdEViSTFxY3Rk?=
 =?utf-8?B?eWEzYzNnUmgvMGM1Y1dMNzNqMHJFR050MzViRjlibC9SUEEzV1FaZ1Z5cHQz?=
 =?utf-8?B?Sk9pdEhsMDlyRzVnUFN1QS9yRXJQVDhhL0I1WjJYeDljclc5bEJCbVZuYTk0?=
 =?utf-8?B?VmhaTkM0a3NxcWxqYmVXTExJVmdGUERaSjdqMDB2RDFlSXlsSG9hVHcvcHA0?=
 =?utf-8?B?aUlieWFIN0ZxSFpLM1ZQR0JWZEJMSGZHQVlsTXYra1d0OFdTRit2MkJlOFg5?=
 =?utf-8?B?QVdvYm82c0o5NmNNV1M2aVNBR0JNMk5GbXczRWtXdktDQW9xVyt2ZEpxQmgv?=
 =?utf-8?Q?1Iys=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 166687d0-6fbc-408d-7030-08dc9433fa23
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 09:56:54.0482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgdhuM2QIeZUS3wBd1DqQyEDls6fxX7pSG34kbewpU41isiQanBfXfCGQkYI7PxAnOOCtK558tPWPBESxHonJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5755
X-Proofpoint-GUID: rSVVSjJQXvoiFx0wINeQ6bFCq9SJwTsY
X-Proofpoint-ORIG-GUID: rSVVSjJQXvoiFx0wINeQ6bFCq9SJwTsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-21_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNpbW9uIEhvcm1hbiA8aG9y
bXNAa2VybmVsLm9yZz4NCj5TZW50OiBUdWVzZGF5LCBKdW5lIDE4LCAyMDI0IDE6MTEgUE0NCj5U
bzogR2VldGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj5DYzogbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga3ViYUBrZXJu
ZWwub3JnOw0KPmRhdmVtQGRhdmVtbG9mdC5uZXQ7IHBhYmVuaUByZWRoYXQuY29tOyBlZHVtYXpl
dEBnb29nbGUuY29tOyBTdW5pbA0KPktvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5j
b20+OyBTdWJiYXJheWEgU3VuZGVlcCBCaGF0dGENCj48c2JoYXR0YUBtYXJ2ZWxsLmNvbT47IEhh
cmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxsLmNvbT4NCj5TdWJqZWN0OiBbRVhURVJOQUxd
IFJlOiBbbmV0LW5leHQgUEFUQ0ggdjUgMDEvMTBdIG9jdGVvbnR4Mi1wZjogUmVmYWN0b3JpbmcN
Cj5SVlUgZHJpdmVyDQo+DQo+T24gVHVlLCBKdW4gMTEsIDIwMjQgYXQgMDk6NTI6MDRQTSArMDUz
MCwgR2VldGhhIHNvd2phbnlhIHdyb3RlOg0KPj4gUmVmYWN0b3JpbmcgYW5kIGV4cG9ydCBsaXN0
IG9mIHNoYXJlZCBmdW5jdGlvbnMgc3VjaCB0aGF0IHRoZXkgY2FuIGJlDQo+PiB1c2VkIGJ5IGJv
dGggUlZVIE5JQyBhbmQgcmVwcmVzZW50b3IgZHJpdmVyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IEdlZXRoYSBzb3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0KPg0KPi4uLg0KPg0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9u
aXguYw0KPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9ydnVf
bml4LmMNCj4NCj4uLi4NCj4NCj4+IEBAIC0yOTQ5LDYgKzI5NTIsNyBAQCBzdGF0aWMgaW50IG5p
eF90eF92dGFnX2FsbG9jKHN0cnVjdCBydnUgKnJ2dSwgaW50DQo+YmxrYWRkciwNCj4+ICAJbXV0
ZXhfdW5sb2NrKCZ2bGFuLT5yc3JjX2xvY2spOw0KPj4NCj4+ICAJcmVndmFsID0gc2l6ZSA/IHZ0
YWcgOiB2dGFnIDw8IDMyOw0KPj4gKwlyZWd2YWwgfD0gKHZ0YWcgJiB+R0VOTUFTS19VTEwoNDcs
IDApKSA8PCA0ODsNCj4NCj5IaSBHZWV0aGEsDQo+DQo+SSdtIGEgbGl0dGxlIGNvbmZ1c2VkIGJ5
IHRoZSBsaW5lIGFib3ZlLg0KPg0KPnZ0YWcgaXMgYSA2NCBiaXQgdmFsdWUuDQo+SXQgaXMgbWFz
a2VkLCBsZWF2aW5nIHRoZSB1cHBlciAxNiBiaXRzIGludGFjdCwgYW5kIHRoZSBsb3dlciA0OCBi
aXRzIGFzIHplcm9zLg0KPkl0IGlzIHRoZW4gbGVmdC1zaGlmdGVkIDQ4IGJpdHMuDQo+QnkgbXkg
cmVhc29uaW5nIHRoZSByZXN1bHQgaXMgYWx3YXlzIDAuDQo+DQo+ZS5nLg0KPiAgMHgxMjM0NTY3
ODlhYmNkZWYxICYgfkdFTk1BU0tfVUxMKDQ3LCAwKSA9PiAweDEyMzQwMDAwMDAwMDAwMDANCj4g
IDB4MTIzNDAwMDAwMDAwMDAwMCA8PCA0OCA9PiAwDQo+DQpXaWxsIHJlcGxhY2UgYXMgYmVsb3cg
aW4gbmV4dCB2ZXJzaW9uLg0KICArICAgICBldHlwZSA9ICBGSUVMRF9HRVQoTklYX1ZMQU5fRVRZ
UEVfTUFTSywgdnRhZyk7DQorICAgICAgIHJlZ3ZhbCB8PSBGSUVMRF9QUkVQKE5JWF9WTEFOX0VU
WVBFX01BU0ssIGV0eXBlKTsNCg0KPkFsc28sIEkgc3VzcGVjdCB0aGF0IEZJRUxEX1BSRVAgY291
bGQgYmUgdXNlZCB0byBnb29kIGVmZmVjdCBoZXJlLg0KPihBbmQsIGFzIGFuIGFzaWRlLCBlbHNl
d2hlcmUgaW4gdGhpcyBmaWxlL2RyaXZlci4pDQo+DQo+PiAgCXJ2dV93cml0ZTY0KHJ2dSwgYmxr
YWRkciwNCj4+ICAJCSAgICBOSVhfQUZfVFhfVlRBR19ERUZYX0RBVEEoaW5kZXgpLCByZWd2YWwp
OyBAQCAtNDYxOSw2DQo+KzQ2MjMsNyBAQA0KPj4gc3RhdGljIHZvaWQgbml4X2xpbmtfY29uZmln
KHN0cnVjdCBydnUgKnJ2dSwgaW50IGJsa2FkZHIsDQo+PiAgCXJ2dV9nZXRfbGJrX2xpbmtfbWF4
X2ZycyhydnUsICZsYmtfbWF4X2Zycyk7DQo+PiAgCXJ2dV9nZXRfbG1hY19saW5rX21heF9mcnMo
cnZ1LCAmbG1hY19tYXhfZnJzKTsNCj4+DQo+PiArCXJ2dV93cml0ZTY0KHJ2dSwgYmxrYWRkciwg
TklYX0FGX1NEUF9MSU5LX0NSRURJVCwNCj5TRFBfTElOS19DUkVESVQpOw0KPj4gIAkvKiBTZXQg
ZGVmYXVsdCBtaW4vbWF4IHBhY2tldCBsZW5ndGhzIGFsbG93ZWQgb24gTklYIFJ4IGxpbmtzLg0K
Pj4gIAkgKg0KPj4gIAkgKiBXaXRoIEhXIHJlc2V0IG1pbmxlbiB2YWx1ZSBvZiA2MGJ5dGUsIEhX
IHdpbGwgdHJlYXQgQVJQIHBrdHMgQEANCj4+IC00NjMwLDE0ICs0NjM1LDE0IEBAIHN0YXRpYyB2
b2lkIG5peF9saW5rX2NvbmZpZyhzdHJ1Y3QgcnZ1ICpydnUsIGludA0KPmJsa2FkZHIsDQo+PiAg
CQkJCSgodTY0KWxtYWNfbWF4X2ZycyA8PCAxNikgfA0KPk5JQ19IV19NSU5fRlJTKTsNCj4+ICAJ
fQ0KPj4NCj4+IC0JZm9yIChsaW5rID0gaHctPmNneF9saW5rczsgbGluayA8IGh3LT5sYmtfbGlu
a3M7IGxpbmsrKykgew0KPj4gKwlmb3IgKGxpbmsgPSBody0+Y2d4X2xpbmtzOyBsaW5rIDwgaHct
PmNneF9saW5rcyArIGh3LT5sYmtfbGlua3M7DQo+PiArbGluaysrKSB7DQo+PiAgCQlydnVfd3Jp
dGU2NChydnUsIGJsa2FkZHIsIE5JWF9BRl9SWF9MSU5LWF9DRkcobGluayksDQo+PiAgCQkJICAg
ICgodTY0KWxia19tYXhfZnJzIDw8IDE2KSB8IE5JQ19IV19NSU5fRlJTKTsNCj4+ICAJfQ0KPj4g
IAlpZiAoaHctPnNkcF9saW5rcykgew0KPj4gIAkJbGluayA9IGh3LT5jZ3hfbGlua3MgKyBody0+
bGJrX2xpbmtzOw0KPj4gIAkJcnZ1X3dyaXRlNjQocnZ1LCBibGthZGRyLCBOSVhfQUZfUlhfTElO
S1hfQ0ZHKGxpbmspLA0KPj4gLQkJCSAgICBTRFBfSFdfTUFYX0ZSUyA8PCAxNiB8IE5JQ19IV19N
SU5fRlJTKTsNCj4+ICsJCQkgICAgU0RQX0hXX01BWF9GUlMgPDwgMTYgfCBTRFBfSFdfTUlOX0ZS
Uyk7DQo+PiAgCX0NCj4+DQo+PiAgCS8qIEdldCBNQ1MgZXh0ZXJuYWwgYnlwYXNzIHN0YXR1cyBm
b3IgQ04xMEstQiAqLw0KPg0KPi4uLg0K

