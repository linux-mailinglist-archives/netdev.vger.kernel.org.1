Return-Path: <netdev+bounces-150674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 547E79EB26A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC5E16C9BD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B61AAE08;
	Tue, 10 Dec 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="kuPzgP5d"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41231AAE1A;
	Tue, 10 Dec 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838982; cv=fail; b=uaSZhKRiBo8+R8qFL7Vez2xJaGdbvMKqSo4j2S1dzQXri56RrO1hUmVbNccSeWZ9lUjJvgmAEfPhonNUQWqU+14a4kuOMNkj3ktre6unyyK2CKa4olVpoj0jnRPnNcdzPSG2HccvpmgK847H2g6+M7ze3WyATL7QVdrODizj5C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838982; c=relaxed/simple;
	bh=6HP8UWfF9yo0/JUlqgEl9IHZpGOW33ky5Bu7Lh/X8PM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WLiQTM35Tms+mg0MTZeZy+QOQ76PfvUYGPLQZpPTurA/D3dF7wxIyGof9o/WAyWfma/gt/AsHJmXNCEhCA637dW/7+WkfI4smz+qfom5MLs7Ry6SuH+/IamRrCNaV4NABGjWpiJHwqlD5BzDQroSy+kpIGZL7PyzckjLnj9Phm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=kuPzgP5d; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BACZVsF027025;
	Tue, 10 Dec 2024 05:55:54 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43ensk846q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 05:55:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAzsMzisYViGNZTY/koY4VprXomWnwVq9bU9TELf4QNHg2qd9VPmubEkbHhkjkLZcRcNJqkUHzXZdpa3fD9nnT+m4zMDqdsc4zgyjkTsGz9+ZJX3O1Xh7gR/TT1vKX7LD1cJtbE34xa6carJf/0/GNyMx1G99GZjI5YB/xmhQVYpUMl5/IM2b41VlPbWCCI7YANEqmaNentpDC3qWKC5toW04+ksVJeQSflFo7n0+hnBUgaGPYx82qA+sIQqLBfnPl9kEi/+0FIIy4GGMlnN0yoOYvHhS8PWRTFRbuHdDyLC69pZj7yuSMaCH7vPjQ2Kw7ezZHc9zeQQUnPjzmyYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HP8UWfF9yo0/JUlqgEl9IHZpGOW33ky5Bu7Lh/X8PM=;
 b=vHv/gjkYBcOoP5UA+t3r4npWc7cFx1HdKnKRfuJ7igUlgMm35I6gnRgYPXBEAfE6x+Bgp7kCoiLMX6k6EXZEwmL8rsZ4OP78H2RVbVh2W3ltZ+hAhVG5xixc07mUZ6IC23jlR0wvMVj+i7MHzkEVaIl1vSucwYVE8KWFZwfPQ4TKB2PM7xLZgckA9GisQUUKXY5aTS26sNpWNYcR3ReGGkM/wKPyZ956IBdD5HSnK/rt57q0NCXADZB46adI/KbqtMo+ccTjvSnEddw1rmZemOlZzSazEJ0ycIDOH5aSfggjZax5W/H+OvQFkbER9KvWR2u0dAgXXKT8k6v1lmZNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HP8UWfF9yo0/JUlqgEl9IHZpGOW33ky5Bu7Lh/X8PM=;
 b=kuPzgP5d7hrMEzwcO7kB6mZtFxr+l5rsjSJldOQfKB9lr+YosFhQJCRJy6IkWS1hcLFp9YxTsJ0LL3un34D3s9FdMf39zxacoJPgKOz/dCImISJiwNRW247JSneEVimpMQS6HUdo2FlI0+ShTxpMV2uSB4jwLXlcQP9qwO1oEmY=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by CH0PR18MB4225.namprd18.prod.outlook.com (2603:10b6:610:bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 13:55:51 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e%6]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 13:55:50 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Sai Krishna Gajula <saikrishnag@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v5 1/6] octeontx2: Set appropriate PF, VF masks
 and shifts based on silicon
Thread-Topic: [net-next PATCH v5 1/6] octeontx2: Set appropriate PF, VF masks
 and shifts based on silicon
Thread-Index: AQHbSws4zHSwIa0thEuX3AY9bgorhA==
Date: Tue, 10 Dec 2024 13:55:50 +0000
Message-ID:
 <CO1PR18MB4666D202E13064800B338799A13D2@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20241204140821.1858263-1-saikrishnag@marvell.com>
	<20241204140821.1858263-2-saikrishnag@marvell.com>
	<20241207183824.4a306105@kernel.org>
	<CO1PR18MB466694B5C67641606838782BA13C2@CO1PR18MB4666.namprd18.prod.outlook.com>
	<CO1PR18MB4666941A2B96DF6FC59E7119A13C2@CO1PR18MB4666.namprd18.prod.outlook.com>
 <20241209132525.600ba231@kernel.org>
 <CO1PR18MB46664C4F8AA71F0FF2A98A68A13D2@CO1PR18MB4666.namprd18.prod.outlook.com>
 <CO1PR18MB46669A23447A3A954AB5C219A13D2@CO1PR18MB4666.namprd18.prod.outlook.com>
In-Reply-To:
 <CO1PR18MB46669A23447A3A954AB5C219A13D2@CO1PR18MB4666.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|CH0PR18MB4225:EE_
x-ms-office365-filtering-correlation-id: 3cc857bf-cb7a-46c8-d9ad-08dd19225b64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWN5bUNiVisvVGlzR0twWFBkNG9VQlQrNzVuM1laZzBkMEZTdFM2QTZZSjNr?=
 =?utf-8?B?TWZ2K3JQcmQ2UmlKOFl2SjAzYlQ1OHc1RnFHcTN2anFHK2JaN3VYNlZEYUdj?=
 =?utf-8?B?blBmQ2NzaDEybEtVMEdlYTBLSkgrYm9WS2REbHltS2F0aVZoWDYvQ0N5Yjho?=
 =?utf-8?B?bUo0dDJSaGlJaWVrVzNsZnBzcitlOVVqQ3NRZ24zaDZicUtnWjI5dHNvVlJy?=
 =?utf-8?B?b3BkUkFNSjFLeG55WndLM2pMdEdtQlg3c3lSLzlQQ1RLODZtNmF0SEMrU3pu?=
 =?utf-8?B?K1JaeXN2QUpvbGZwN0VxeFU2OFJBRmJGbTFmM2VOcS9nclJhTDlkWnQwRTV0?=
 =?utf-8?B?T0NCUThITlNnYTVNSXBNNU03RHhFYnJ3THVkTlo2UTgzZDArMFZleE52U3Vp?=
 =?utf-8?B?RjdnQlF4aHYvenNLZC9qL0pnR1ZqcTVMN3ZTNlRUaC9FaFlXWnZjelh3K29C?=
 =?utf-8?B?VGNDL3VsZm1FOGNXQnd0Q1RWaWNrd3BML1RRaHJKTTJGZ3NtcURzRzFYckNI?=
 =?utf-8?B?VTROM2lKOTljZk5WN0k2aHZoN2NMa3lDZzNzMzNudktKUmhQTStUOFVtKzVP?=
 =?utf-8?B?cEtwYU9QU1RPUzlPdVBqb2J2ejNybktkN2JHcllNYXgwRGw4VEliamdneUF1?=
 =?utf-8?B?UGtHSjh1Y0d4K2xBVFpIQ21ZL2dZeFNad3VLZzI2RkdKQ0RWamJYTGlnUWp3?=
 =?utf-8?B?b1R2dlpjOUxZU1hDVWVBdGRLbmRlN1l6RVZ0TDY5NUF3R29rcFc3NDYvWUcy?=
 =?utf-8?B?RGlkL1JuM1VBMWlNNE9NU29RVlAzS1F3OTh5U0d6YmJYK2ZhTWZ2a2FLREow?=
 =?utf-8?B?SEcvcmYxRVZkWUhkNS9kLzE4c081QzYyMFUxL3oxQlpyajU1OFpId01sSEcr?=
 =?utf-8?B?SkVTbWVNRTdLZk5iUmhsamVJUi9IaTJGdGVlblh1OWhGRTJibEpleVgxdXVo?=
 =?utf-8?B?L1VWOW1YaFY0TTBhdkFlTGpIMDkzdDZFVlYxYjdFdnFTVURnZkVRdkRwb3hR?=
 =?utf-8?B?NEZ5TzM5R1p0RGJUVTUzdFhRNVpsbFY4VEdicS9PcWptL2krY0tzVTlVMVBI?=
 =?utf-8?B?d1JmZ2J6aW5lMTBQQlNlQ0g4dGRueTV2TlZEajNVTFBFbU1FNFFhS1Z3UmxS?=
 =?utf-8?B?QXhFRytSd3MxS1QrU1Y0RkV5YWtRaWpXbUVBTHlad1NsM2IvQkoxR1dRbWNW?=
 =?utf-8?B?RGFzbHNLditxYW5TOXFpazRYeG1PaTFpeE9RSkhHcTlaR0FrTmFvNlpqc1dr?=
 =?utf-8?B?K2NnOEJlZmV4OFhBV2Z4MFhwTFVYWDhEWEY1a0tjVzJGSXpWRjFTdzVXZk5L?=
 =?utf-8?B?VmlTWk05dytWbkNYVDZWR1lPOEkreFJOZGV6am1GenE1TlpuLzQxZlRON2lh?=
 =?utf-8?B?NC8vRkZSUllVa2FJSitkU3hrSnc1UzY5Y2RXWnhjcys4VUJzOGlSOUluTDZp?=
 =?utf-8?B?bTZualFMT1VUWTk2a3NEQWo4eE9CQURCRGNyTkZKU0VyaGY0NDJPSmJxbjVF?=
 =?utf-8?B?am9nNmxFY2JWbTkrS2xpVDBCY2FxNmdldzJXM1ZaWUpoWnV4UjJwb2ZKam1C?=
 =?utf-8?B?YVNEaVg1ejljWWNjL0I2VWtmcStROHFmRnpwaEthdGhzYTQ5YmRsZERrOGtH?=
 =?utf-8?B?Q1Y4THd2TEJvRGZzTGtsNHBYcVZtTWl5OGozdUlJOTNqdWdyR3h2TnV0aEI3?=
 =?utf-8?B?SE55TU1kWnBjZ2V0WWxzOU5PZTZSUnZoN2RRRkMxNWNucFdNd2JNZ3NGaVBU?=
 =?utf-8?B?SUFDMjBaNXdYc2ZpNTk1YzBzQW4vRktHUTJBeCtaYlY1OW56YTlLdTNDZ3p1?=
 =?utf-8?B?dXhhMTY2OC9hQzl3dFpPS2dpNXY1WGd6b3BZNmRwdWZqaE1ZY0JVQ29lcG1s?=
 =?utf-8?B?ektiZE9wNjZiVGJTaWl5TjBJME9OU09mY2kxMk9CaXZCVUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUt5Q3JDR3RXWmJrNWlaa08zdEY0MHRxdkZrOEJiLzZHYXFjbWpLc0IwVG1R?=
 =?utf-8?B?aDRsSFlJbHJUN0dqUWFaZFdjQmlvTk8xQW95cXlUV2dqaGNBcTRlV1Y2eUhl?=
 =?utf-8?B?RUFpZVNqRjZwWnkyUGUwSXZCWDY5OVN1bURxSlhHNFFMdDR3QTJzdVRoUm9I?=
 =?utf-8?B?a2pOL0FwT2docUJ5UHRkT285STBKdzhRZjA3Rkowdm4xSklEUEhwdEJzZDQx?=
 =?utf-8?B?dmlSVmFtKzJQOGJrS2VSQnFweGVuUWI4alJQblg3WTFGYVFLYndtU3lhL2lj?=
 =?utf-8?B?amM2ZnBMN2pWMThxVGVCTUY4Y0k2di8vSXZJeUN6UE1wWGlGb25CYW4wQWNk?=
 =?utf-8?B?Mi9LZUp4Y09TOURjZHdwbjNPTW83Tmlack9wQzFhV1BlWENlQ2htVVFTY1BO?=
 =?utf-8?B?U0NJYll0Z1RoOGszQnM5Z01kbzVTZ0hlU013L1JML2Z0RmNyQ04xRTQyWFc3?=
 =?utf-8?B?aUJHNlc0QXpleFNyTjdRREFmN09sRHo1bXVqUUxsVFBhS0pLM2lmalZEZDZT?=
 =?utf-8?B?cUlyNHhkTUY4aFFBOGcrcVA5L0VDaEZQdEFwVE50MFlDVUxuNUV4NndCekg1?=
 =?utf-8?B?WFpEWTl4aHIxaDcwS3dzU3ZVcUpOczBTY1pZVmFUcHJmWEtSZU1tMVJ3MzVn?=
 =?utf-8?B?Ymg0eTZlQTFlZFpFUmhHSUNRZ2U0Nlp5YjFrZExMdTc5bmwrRDkyc0llU0FJ?=
 =?utf-8?B?MmV4TVE3YWRUSU9zK2UvSTA2N2ZsTHFWN3RkTEl3WmRkQmQ3NkVBd0pURHZY?=
 =?utf-8?B?ZzQ0TklUbVNWTTQ3RUg2Q1lnalh2VUJ5bHhpL0FpYTlMRWRiMXR0eDdDYUVG?=
 =?utf-8?B?c1pKUFByeiszUlZDV016S0V2THJmTXAzOVp2OUd5N3RJSGNmTVlYdndxK2RS?=
 =?utf-8?B?cWNsTXQ5WjZQMkJyM00vV3UyY2VXREhxK0pvdWpzb2FzOFpIT1U3K2cvTkY3?=
 =?utf-8?B?V0laNTZqYnFhR2pyUlN5RXVhMnpGa1JmWmc2UWZ0UTVxSUlyRnNvNWprT2Rl?=
 =?utf-8?B?OXNyZUcxRGdpUW5aSXF6WHJlT2szMERtTjdqcnk1OVo0RUNsdkpDWUR5cnBC?=
 =?utf-8?B?OG5iRU4rZFZpYTdiM1kwOGh0U0FnRU9UM1pwT1BGRTl4V3ZVVXpXcEpjQmQx?=
 =?utf-8?B?TUh0cUMwWFNqRStiUldPQ2RuNndmVVhxa2dkWVVIbHZja3VUZS9lay9oN2xv?=
 =?utf-8?B?TlhmVzdvNWlzVmxwWHVxYWtmT1VMNHA4TnFKdVgxdHQvVENmMnNRWUVtaFpU?=
 =?utf-8?B?azNDSGYxdCtVaXN5Z2ZyaEZjVWFZTSsyNTB4K2hVYnlzeHFoOGJWd1dKRjZ2?=
 =?utf-8?B?dk01WUJtVVMrNWhXTlVpWUprVXFFajVveEljcXlaQ09TcjZBRmtUSlZ2SWNE?=
 =?utf-8?B?NjlvMGMyS0RpL0E2VktiZmFCSU9TTCtyOXNrUFhuNm5ZeWQ3SlNNV3BPL09L?=
 =?utf-8?B?R2hlN1FCYWpLd1BLTjlmYnhsTHc4TVYxUkJSeUhBRE54ZXljN0QyWkRCRUJr?=
 =?utf-8?B?Y0VZbytJemNVZ2tqSmNxMEw5RDJlZ2VOdXZZakRJcllDWnlmSkd5UTQvZkFY?=
 =?utf-8?B?eW5sNG9MbGN6VmtyK3grN1N5RzljYklEU2M3R2Exd3BGZTNvWjB4TnBIOHdi?=
 =?utf-8?B?ZWt1K0xGMjVMZmZVMjRDZDhSMWZyanpRTW94R25MU2JZZnkxTk54RUQ2TTRp?=
 =?utf-8?B?cjB2dUhON3E0M2VVNUpWbG1tNzdJTEJHNDNsREhic0ZWODVIOVFLSHYvSDl2?=
 =?utf-8?B?NHdqVjFqdEdBMkcrZHp6Y0lmcFp6MVRidDE2NUdpbzg3R1h6cEY5Tms2RjFj?=
 =?utf-8?B?MUZSeEtjTng3b0d2aHlReEwyT2kxalVINml6WW0xNm5YQlZ5YmZuay9mNW5w?=
 =?utf-8?B?ZVpySWgzRzc0c055MzlYY1N1Zko0U09sQTh5ZXhhMjYzZUtwWS9FWWZNZUkw?=
 =?utf-8?B?Rllvak5aQ3hxcFlUMFpuMUVOTGpRUnNoanZBc3YzZk5PaVhHYTYweXZsQlc5?=
 =?utf-8?B?YWVoS05MVnE4eTl2VU04eVNIQ3FvbDFEcWs2a1M5UWFzejMwQmQ3K2VzRW1V?=
 =?utf-8?B?c0IrWnNYbzJnZkx0T3NhQnY5bWxMOVJValhSSTZVM29PeUx2eEU5YVB0Wkpy?=
 =?utf-8?Q?DwLHZCLwYML3UvQu9B/c1lyn0?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc857bf-cb7a-46c8-d9ad-08dd19225b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 13:55:50.9187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43LipaEmDPpQJnQS8Kks4WiH+/j1HpXcOOstyxqF1k3Va67/AZ+ojaX51zGeV9MW59SswCevpd1sfIDKOC4AcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4225
X-Proofpoint-GUID: k6YablaGWSwu6fWfBbh6U9OrJuz2zMn6
X-Proofpoint-ORIG-GUID: k6YablaGWSwu6fWfBbh6U9OrJuz2zMn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

SGkgSmFrdWIsDQoNCj5Gcm9tOiBKYWt1YiBLaWNpbnNraSA8bWFpbHRvOmt1YmFAa2VybmVsLm9y
Zz4NCj5TZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxMCwgMjAyNCAyOjU1IEFNDQo+VG86IFN1YmJh
cmF5YSBTdW5kZWVwIEJoYXR0YSA8bWFpbHRvOnNiaGF0dGFAbWFydmVsbC5jb20+DQo+Q2M6IFNh
aSBLcmlzaG5hIEdhanVsYSA8bWFpbHRvOnNhaWtyaXNobmFnQG1hcnZlbGwuY29tPjsNCj5tYWls
dG86ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgbWFpbHRvOmVkdW1hemV0QGdvb2dsZS5jb207DQo+bWFp
bHRvOnBhYmVuaUByZWRoYXQuY29tOyBtYWlsdG86bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbWFp
bHRvOmxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFN1bmlsIEtvdnZ1cmkgR291dGhh
bSA8bWFpbHRvOnNnb3V0aGFtQG1hcnZlbGwuY29tPjsNCj5HZWV0aGFzb3dqYW55YSBBa3VsYSA8
bWFpbHRvOmdha3VsYUBtYXJ2ZWxsLmNvbT47IExpbnUgQ2hlcmlhbg0KPjxtYWlsdG86bGNoZXJp
YW5AbWFydmVsbC5jb20+OyBKZXJpbiBKYWNvYiA8bWFpbHRvOmplcmluakBtYXJ2ZWxsLmNvbT47
DQo+SGFyaXByYXNhZCBLZWxhbSA8bWFpbHRvOmhrZWxhbUBtYXJ2ZWxsLmNvbT47DQo+bWFpbHRv
OmFuZHJldytuZXRkZXZAbHVubi5jaDsgbWFpbHRvOmthbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJv
YWRjb20uY29tDQo+U3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtuZXQtbmV4dCBQQVRDSCB2
NSAxLzZdIG9jdGVvbnR4MjogU2V0IGFwcHJvcHJpYXRlDQo+UEYsIFZGIG1hc2tzIGFuZCBzaGlm
dHMgYmFzZWQgb24gc2lsaWNvbg0KPj4gPj4gLSNkZWZpbmUgUlZVX1BGVkZfUEZfU0hJRlQJMTAN
Cj4+ID4+IC0jZGVmaW5lIFJWVV9QRlZGX1BGX01BU0sJMHgzRg0KPj4gPj4gLSNkZWZpbmUgUlZV
X1BGVkZfRlVOQ19TSElGVAkwDQo+PiA+PiAtI2RlZmluZSBSVlVfUEZWRl9GVU5DX01BU0sJMHgz
RkYNCj4+ID4+ICsjZGVmaW5lIFJWVV9QRlZGX1BGX1NISUZUCXJ2dV9wY2lmdW5jX3BmX3NoaWZ0
DQo+PiA+PiArI2RlZmluZSBSVlVfUEZWRl9QRl9NQVNLCXJ2dV9wY2lmdW5jX3BmX21hc2sNCj4+
ID4+ICsjZGVmaW5lIFJWVV9QRlZGX0ZVTkNfU0hJRlQJcnZ1X3BjaWZ1bmNfZnVuY19zaGlmdA0K
Pj4gPj4gKyNkZWZpbmUgUlZVX1BGVkZfRlVOQ19NQVNLCXJ2dV9wY2lmdW5jX2Z1bmNfbWFzaw0K
Pj4gPg0KPj4gPldoeSBkbyB5b3UgbWFpbnRhaW4gdGhlc2UgZGVmaW5lcz8gTG9va3MgbGlrZSBh
biB1bm5lY2Vzc2FyeQ0KPj4gPmluZGlyZWN0aW9uLg0KPj4gPg0KPj4gPkdpdmVuIHRoZXNlIGFy
ZSBzaW1wbGUgbWFzayBhbmQgc2hpZnQgdmFsdWVzIHRoZXkgcHJvYmFibHkgaGF2ZSB0cml2aWFs
DQo+PiA+dXNlcnMuIFN0YXJ0IGJ5IGFkZGluZyBoZWxwZXJzIHdoaWNoIHBlcmZvcm0gdGhlIGNv
bnZlcnNpb25zIHVzaW5nDQo+PiA+dGhvc2UsIHRoZW4geW91IGNhbiBtb3JlIGVhc2lseSB1cGRh
dGUgY29uc3RhbnRzLg0KPj4NCj4+IFRoZXJlIGFyZSB0b28gbWFueSBwbGFjZXMgdGhlc2UgbWFz
a3MgYXJlIHVzZWQgaGVuY2UgYWRkZWQgdGhpcw0KPj4gaW5kaXJlY3Rpb24uDQo+PiAjIGdyZXAg
UlZVX1BGVkZfIGRyaXZlcnMvKiAtaW5yIHwgd2MgLWwNCj4+IDEzNQ0KPg0KPlllcywgSSBoYXZl
IGNoZWNrZWQgYmVmb3JlIG1ha2luZyB0aGUgc3VnZ2VzdGlvbi4NCj5BZGQgYSBoZWxwZXIgZmly
c3QsIHlvdSBjYW4gdXNlIGNvY2NpIHRvIGRvIHRoZSBjb252ZXJzaW9ucy4NCg0KSW5pdGlhbGx5
IEkgdGhvdWdodCBvZiBkb2luZyBzaW1pbGFyIGtpbmQgb2YgY2hhbmdlcyBieSB2aXNpdGluZyBl
YWNoIGxpbmUgdXNpbmcgdGhlc2UgbWFza3MuIEJ1dCBwYXRjaCB3b3VsZCBiZQ0KbXVjaCBiaWdn
ZXIgYW5kIGFsc28gdG8gYXZvaWQgYW55IHJlZ3Jlc3Npb24gaXNzdWVzIGZvciBleGlzdGluZyBz
aWxpY29ucyBhbmQgY3J5cHRvIGRyaXZlciwgSSB0aG91Z2h0IHRoaXMgd291bGQgYmUgc2FmZSBh
bmQgc2ltcGxlLg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoaXMgaXMgc3RpbGwgbm90IG9rYXkg
Zm9yIHlvdS4NCg0KVGhhbmtzLA0KU3VuZGVlcA0KDQoNCg==

