Return-Path: <netdev+bounces-241605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C17C86C27
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AF1D4E139B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D499285CA2;
	Tue, 25 Nov 2025 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="gEikcmMI";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="UxncouVj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5936280318;
	Tue, 25 Nov 2025 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098326; cv=fail; b=YSJYg4pw7EFe6lvModYrW6Sp0Rknpq1v7c6gbpv7fAwh9d9IwMV1g0mvdK/YgtbZgaagxUlT+OpxI2jzvDFBudB0+XKaM5JszM6i9mMyMKjiFLEiJVIuqAzftwkdX1l0B2TBPzQAzIpp7utYrpg+KcK0QpRPkGRqgtdUN31AB60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098326; c=relaxed/simple;
	bh=dfEHAe1yKiGRbiy0Yz+OgumKB8FNb/LtPUxs045BvPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BBIzqzOB6llhrZgiJymmlh8CL/NdkcFv0xxvfQx30/lS3I9sFCme1eeioz0xcC808ecCoR47iassgEhvUXEutFWJ7jF4foM4E7IfLKmESPgCP4tJqIGxZTpSWNeAjeI1H3H+o9Zz/feL57QklE3ArTHnZ2Cq6CVBkAwIPTqCl/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=gEikcmMI; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=UxncouVj; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APGKZKC2183761;
	Tue, 25 Nov 2025 11:18:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=mQAm2ADbivzOFaVv9IDJGxNFm8vBfxF1MX/UEzCFK
	jw=; b=gEikcmMIewwGWJYP5WDwyB+ath9WlQzJ9plrijcITJynGfSVv9smoFGr2
	+hiUveMxHMlL0ykRickm6yR3ESCLIjZkw1cGLLWxnOo36xnxzoJo4onfp1bFxw82
	N0SuHuiPJhG2Uy26xGbHgQY2tELs+EMVo7NJhvVaMjg4gFwr3p6sE830rR8hAutH
	x2pptAL5a+KrFyxxPa/v2bZhxN9JheAAMHLWnHnw1fgXDQgxO34nkMHgctoweWYX
	1ou/JFcxxCsvwIP0nOeuF3pitwDm45u6lK4fhSdRbejw2kHlvUv7bKGr2KJ32o4w
	JNjDVVNwVW2LKy32m9S9xeLvaFK8g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022075.outbound.protection.outlook.com [40.107.200.75])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4anfw40cv3-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:18:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrubJn5AnyEpfmbszmdxtu4BchDKMehzQ8GAeoI7fjSlIswBRZPgIBVOHXYl1JFk2dsK1IcXxGRYwO6WAw4Fe7sQrWeXX/EjKduYTj4Ahj0d33nTQKWfKTIuLPAG1JN8SkzzHK3w4dPBzleluDa6c9J3OX+vDuywYxQ+wQ1tD+NA6+wnHmLutkhPUcZ4ht1KEbne3JM0cClXMDfxGZbsXa/nQTnIfemxy6ccqh5IBMpq1wQTL4EsGEcsQI9Nfa3dh632CRmzMqEv2IOTkujJYoysrRNVZgVFTRsCtsuoRqV26aNrzT6esY0cqzZcIyQiorQrubUN+ylLLbUpRe7+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQAm2ADbivzOFaVv9IDJGxNFm8vBfxF1MX/UEzCFKjw=;
 b=xsqr5L35bGshIBRhLbX9NbjP/YiedBHVXExtdEktPNeW7UMg/iE/Gyq8HViDOqTheI+AMH23xEqdWDgSi3VFvcMH+cEv+7n0JtGuA9PDOxTXDsY+ySzmtEALdsIL6s9pEzStiF6iYQt4um3BNTzoYUy89ir6x0XoKiJqs7JJxcp1YWkOHRsfqPPJKOkPtlWdQKJrQIYrsdzITkiC2MgqEW0b8RuFtb/0ZJ4uKOeBK6qjundKqaOc4PLdWz3j9sxl5sOwWo7POWE9sVYcia59IvlT1k67RNw3C85+f85zMHrG0EQghIu+EoZQmN+dgfeO7grvW0UNFhdrr1MOz4as4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQAm2ADbivzOFaVv9IDJGxNFm8vBfxF1MX/UEzCFKjw=;
 b=UxncouVjf+bhcCfTik9Zp+KgXbVUPJtv6F03Q5qaGH1omfNS4AgXH6aJgkCoYZ/d4f73mh2scgwrnSyShMrXFzFZGnvxgYnNbQYb2mrHeEJERo7z9T4tDz8PRYRDVuw/00wG4sSZEfAIuWLefRWFd4GOf+E1EAbKhvQ4Il+pUwspRSFgnBA3AKYaj0egGWMt4UYIeXHGJd9VzRi4VuZ0waEGlVTirrD0VfZ9hEcXFjMccHSclqDTEmqS5r3tntNMPaJKZCkK2zfCZU1ci9XDZY1rKNjL4kG46xw/4D3mcNds0/DxBfM6b0IALHms8PK/NRWyXZbd8SO1wkUNplHrGw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 19:18:33 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:18:33 +0000
From: Jon Kohler <jon@nutanix.com>
To: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v2 6/9] tun: use napi_build_skb in __tun_build_skb
Date: Tue, 25 Nov 2025 13:00:33 -0700
Message-ID: <20251125200041.1565663-7-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125200041.1565663-1-jon@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::15) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 08464f1a-28c7-49a8-f19b-08de2c576cbc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?siD0NCdRA/HsBh87qBVWT250ISskpTejkTWOl+hW69Plnn+asqVbfVnAopfm?=
 =?us-ascii?Q?0ncX/5Z2h83kqJf/KFU56zNx9DOjCvzj/utk7+rvsP11RMjW50jrQWLM5BRo?=
 =?us-ascii?Q?LQwuKp8P+7We0EAKlgheZHve9rzhVJ4zYUZPz/m70Mr9QHRAtT761cDFIfo8?=
 =?us-ascii?Q?npgTFlPweMUQ2DW2pH26umvFZeXmcF8Ot1xcExgjLjsha6yW1vHkEnerEq1H?=
 =?us-ascii?Q?SiZbAvvnBHbdz+Q2Vy4RxMhEU4mwxGliVVtTuZ54FRB8Re9cgMxdqOMxOMn+?=
 =?us-ascii?Q?yIjWoDgH6wvfSDQvcNxXI2JbRZLHSN/2noNeNui9IEkiFpcgOywwmAEB/sb+?=
 =?us-ascii?Q?exhRXfOehVYYi0hTwzmgJWFrLaLFEn5CnMhMiBRNDABtACkvtOyPnjzBj0Ur?=
 =?us-ascii?Q?uNxo95vsq2y50+toMajZQk5793xUkksC7cbaGVANM74eJho2DMnsvbvGnpdw?=
 =?us-ascii?Q?v9ym8fEMX/B6nIPY0cXaSUf6xFN0NnQhfD+C3k6IBuOqHwzbr1z5D4HP1GwD?=
 =?us-ascii?Q?qbttjPE7+8NVM21PbrSg7BQU6o+ElWPpplDQVwONPT+pkvOgrJcGnKXZXDiA?=
 =?us-ascii?Q?mcQBIBP9Hxg7IndQTfPC5tVaBqV1TUjqFDepcdpON3yJ7aRgjTIryjcrCGGP?=
 =?us-ascii?Q?avAqmPzKjAyTbXcgcxC5k1uqI8gEYXpG+qrbVlZiRUDIrHgAC393V4u8Ge9x?=
 =?us-ascii?Q?jHUCzYtF+TeLGd11uq/APYr6e0M2ZiRf8Kp+QTmanJhNVpzHjnx+kHZ9vOcF?=
 =?us-ascii?Q?j1nFi5bh25F+jcvX1Hh5Yi0s15dmPbTR50I8bEQDxRzmmFxkYnaDyi1eEBaV?=
 =?us-ascii?Q?cmUt0TBDf3sP6tEfhgYU6OWfnRpfSV2YJto7bpXHeKQVck5S9BV2uOlDwVQB?=
 =?us-ascii?Q?bWCUck5+psAKbjnL+UPJmuXzdlcogXmtY/oxOfm2ExHKvE/LIM2veVWmQd/+?=
 =?us-ascii?Q?OsK6q+pOjTVIfkEK6PP3lHaMWM+PtaJcR13W0xdmIqeJXeYn+XS9G1/Eeq4t?=
 =?us-ascii?Q?BPQrVcnDHqkDfR1PfZd0fUS2To4ZxAqBm8IdVLbQJ4Hp0ClCY6xfr1A3SXRL?=
 =?us-ascii?Q?tiDYxx/HoKw2HiyGthzXRg3WQ2URlwqVkT6brQd76tDDsEZ1Hb4ebRVI4VAr?=
 =?us-ascii?Q?LSfIAW6Oxf9sPrmscW4xTtGzWe9FffxFOuiDdjk2EePf4jtRzO8dZz2qscTV?=
 =?us-ascii?Q?DYBBtiy+EYrEPQBEZs4wp1SwgyBcC6lTOpm9Fttck4eVF7oWslw8a+HggeM0?=
 =?us-ascii?Q?daeQFgaIRhSzRSLh2ZA/+n8XG3A0/ShXeM7GcCKEvLWpTt/7JniYATfUKN2+?=
 =?us-ascii?Q?I0nkFS79gwk5K246C+tvO2fxANPDxQL/ASqoP9Jxf81OmUfwSxLfmfFL6HRj?=
 =?us-ascii?Q?9qyCfCXynsHA9w0Luo7q7aWPbHWAYEDFfUYdJlMl/elrSxoJAkNpdEHf4qTA?=
 =?us-ascii?Q?BNzGTYNw0YUmMuE3CCU3+vqCNmbsmYa0l0IPNGfAl0NLytj5QfroIFKPHGeC?=
 =?us-ascii?Q?a/YPvPj3HeOMAUX8xQ/CsUoomvBVy2VmE/xZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oup1xNs9IasEbiHo4Dxc/VjquU0jIYHIxdHFONWDZ4R3H66KzJDu2+NwVOGd?=
 =?us-ascii?Q?QV/loC7VmII1MTSYdLOySSoKwOOmM5o0X2O13zGSCDRWf6w7O32Zd+uRe2vD?=
 =?us-ascii?Q?5Ni2uPU2HByEcvKb0sM3J3/OyqWtBHDq/Vk8dZq7O4HSos+ErzluX+tydHRs?=
 =?us-ascii?Q?L9+ar8dlpo/Wt2+7f8DbTLYNvpSOHd4UeLouP9MzR4tskDQCBJBxaUofnUwu?=
 =?us-ascii?Q?b0fVX8sh6nTlDV6dOgQ83fQvUkBZBPQFvebYhA4cAT9T6mM2TiN89ZikmwMJ?=
 =?us-ascii?Q?CXfBTScBuNlluinRZtAuCX0fEeUJKILu3rXR5iKmKvSfoczJ0d2dUUydSygS?=
 =?us-ascii?Q?8gxEoPO5OsWlbzl8WLtCyGwhJ1YPxg7npTEzcaTN7lnlA2/+OanZ09zg6dCC?=
 =?us-ascii?Q?Cc9o0XE7Jhk2u4Xw6Kkqm5oZD6GIYtWUDi7JivDj57m6i3la+/15gUPN75jY?=
 =?us-ascii?Q?Sj+xBpx6uKWjb4Y0klwrsno6y/59/jALiNs4fChH23b60wiOBZYp2GodTJu/?=
 =?us-ascii?Q?jaiarj2iaR0zZ+RVcBWy8Bc8Bx0/NJfogjGXSzNxki8kDlG65LcLIb99icG4?=
 =?us-ascii?Q?42cUzdv46qAHi29oGcK/qq4TJwHsel9fiZ5X9t5Wn0H9cYSI8+mxcUD4II5Z?=
 =?us-ascii?Q?PM7BpyfY6s7lnyBvKscbPpzgic/muOKBK583OLE/ae5VH9DL5cDUxCqRWPoo?=
 =?us-ascii?Q?xq6m2jkp4telFgu6zIB3ZM50zU+8+BJb8slEAllDlzrBwjvSX3mAJ9k4C5cv?=
 =?us-ascii?Q?FieEoAKamqnnQmis1ShJOzyNrXeRo2kK+Jhyu5zRnte7q0erEh4bjqlpDig2?=
 =?us-ascii?Q?43c6+baBzzIoC63MvgroXk44L490G8wCl3cAd/upduL3IG6NCK1nzGlcCOgi?=
 =?us-ascii?Q?ZzSsZ0o91vZyFXBRs+SlBKcDVYRU2Fp975b+oZ359cwqzLXcX5rDMhzpUKYJ?=
 =?us-ascii?Q?kSL/vgO94zycpOTJRTEQw5zli4bGbNyUI05uY/+XTd/yC9ebvr0kZe0AUk4g?=
 =?us-ascii?Q?uNKN3wova71Lm3xTRimLQsQcIUlr8jCP1oF/8Z16kJYFYtG9PFWAHmciuarx?=
 =?us-ascii?Q?EBO0GEgaCXH7dlyfpbgACBPHNiDFMHvsUJTHw9jOoJlbc/nPGK/Cw0Ma9xIs?=
 =?us-ascii?Q?Z1umzA2ldrotL7hHd2wAq9L3EPkOCbJY4P/WrGDL9TcXqsLqj5UF73wMDxAy?=
 =?us-ascii?Q?BKsO+zhouhrv66DpPaCAVs+Yw15nemuPd8hy2IwYa9Cx47ok3qOpXMeDrKxZ?=
 =?us-ascii?Q?cs3MDZYxznxBZfMVXI9g8S67loiGh2wk7eevooZ4ZyIn4ClED3OQO46h1t4A?=
 =?us-ascii?Q?Di20oQNvKhF33lQZUq+xqLjsqC9j6svDDmYwd4/wsaOhkM1IYFx6giOW1B9t?=
 =?us-ascii?Q?4EYHc6/vYUwHuK17ISOqXa3l/3ptwwuzWhccvKn1ftOcae4MpzeRMsU5+1+c?=
 =?us-ascii?Q?a+qhCmuDBWQ5ANSiNb6xXxHRSKj/JcfNQnhRhk2gtZN6xLR0zEKrOvDzoVq/?=
 =?us-ascii?Q?BoNagZeStLbEHjl8lOJO54vHu15n43zkQH04pEc87/SNGWiuGLm3AudxK4a6?=
 =?us-ascii?Q?S5srKqsej644VI/hDQHPaZGq7+dFamfa5ZrWpH75QAL6Swvf0QlGtwZb5vGf?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08464f1a-28c7-49a8-f19b-08de2c576cbc
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:18:33.3053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFej8/1A1kf/8byp1Hlcc98cAPMBEdkCl1YiXknufZt6q9giuSXOOHrRbsUYv34av+WDvnzNGGOTGornDb4F/VMshHqSQviNunwVGXxXdVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-GUID: YCqjk9442l92oHK5xC9cv-_pJUsOvVhG
X-Authority-Analysis: v=2.4 cv=NfzrFmD4 c=1 sm=1 tr=0 ts=6926010b cx=c_pps
 a=5czeKszRpWsvzRcawb/TzA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=DtH-ZNJ2jHKKiKdS_QUA:9
X-Proofpoint-ORIG-GUID: YCqjk9442l92oHK5xC9cv-_pJUsOvVhG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MSBTYWx0ZWRfX7EHcXvDDWGVT
 RTBpC6MyF7ubOs9nz5TZcF8YukUSmLQ3zhlJ4qAc7xpHzW3OdYWe8evZoWMH18IXhQX3/gJYlXK
 Rs38095vFx5Ll/F1BPjCFtg/T8o4S1I4h24Tl45LRyDHDoO9/Av/WGlb53hkJ7ianLvr2z1164v
 fjqQOApYnDkFQNlC/oiIT0iNGESfA4k6zjP10RbiMux5adHNgBnDKFdknN4bJyaqOghTmKlUdY0
 js0bb1eQxJnD153zarZHkmkrUemcgpl3E6mbyxc6uH+LNn1J22NPD+6FOX7UdxLxXLJfuwrkCDk
 CwhQIyGe+UBMAJ2aa8nhNabk9Apgj/7jMArDAB6jGpAi8K5lnfv7wAKfVvH3k9FAqXiOrQcLrnO
 Hn+BK14K4WawQC+HeLB+e8W0/b5UzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Use napi_build_skb for small payload SKBs that end up using the
tun_build_skb path.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 64f944cce517..27c502786a04 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1538,7 +1538,11 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
 				       int buflen, int len, int pad,
 				       int metasize)
 {
-	struct sk_buff *skb = build_skb(buf, buflen);
+	struct sk_buff *skb;
+
+	local_bh_disable();
+	skb = napi_build_skb(buf, buflen);
+	local_bh_enable();
 
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0


