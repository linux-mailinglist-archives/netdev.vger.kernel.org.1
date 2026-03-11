Return-Path: <netdev+bounces-266686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LzrESuOsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:45:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE2266BC4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36D123062498
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2C3E022C;
	Wed, 11 Mar 2026 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKgnjD8K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="takHO7ks"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59C3A383F;
	Wed, 11 Mar 2026 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243869; cv=fail; b=OBw47ZQkf6hmNViEvFlS5Dj9h4pKQXmoG4wyA1Fs7PKHhNqIE6NxNoIexDs7RDtaxBAr3gMDjqFpMrwstPsBzTqQ1RdIo7CHo6o09MidruSvO35hHaM9ZrjJIpIhXU5EXtNKEHrcfcaYotcBpsETUJeWpPnkyUZ6EDwqhMX/jkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243869; c=relaxed/simple;
	bh=WUIm7Zz3DQEejBzVkBArODLtniTW9DTkEUTGbF5Ggwk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MM0oA7n5X+Ak+14TNoL3+c75TBiq5xeZmnhutm3JohAuRAZ+NaELjt5sjofxNXgjmW9hcjfLygFUfO7bQXHqHxxl1Sa3sk+Yyvp6TafZzAmz7iJ+99KfXsaFZzF4/YqdJKpirosxcalpKGlzRHVffgSouFcCljpN93YWoARDj28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JKgnjD8K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=takHO7ks; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BDMhaF1821609;
	Wed, 11 Mar 2026 15:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JTX8ELueQZLAZfpG6jdQ23rcGKzkCQG975bdQKRCOyY=; b=
	JKgnjD8Kf0iL9gUdTMXc3GzQNqziWkcNajtEgSkNlo0GKJLdnhsegP2h7QAirh4e
	epaszpdgPBjFjYUffDA7W2rOJMBqGwF2iY9N0E1RQ4d5Fb3sAIIcEY3mSwQU6g4O
	ng5Iupcb46ZGm9ExxxjGSZ3XMAwJO13E5P3aFc9FvCcq+iSwI8IsF79iaMxcg7ET
	ntz8/ItAe6ra85/2GHAT7fLrNUvTLeEYRxygxwJT6e3OgdUz5H7gP1HmAYAekINC
	TI1ABmtY8AaSXi78rAM4Z1ldoiVfdUKeeuQD5fV4c7Y5HXBfQpGcbVGYMCfSjx6+
	j7QCiGW3K3TsRqCHMgO6fw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cu52d0q23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 15:44:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62BFJ72l012926;
	Wed, 11 Mar 2026 15:44:14 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafg8xvh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 15:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey4Mb0K3qNYnhVgrc2GXkXMaF1YjWbIwAUD9DN7Pr+iddP72aJieXd1UEarm/Fgj6hC7PPbdv9ygXXaPnnfHxihx7zJNGtjgI8DG2ripqN1EbrqdfasVPPUtWc7n8VVklyBEC8ehiPyGKss86eymPBOEmjT+QlPHbRy0GoDeW9RwEMknLVf/U59q6ttPorN63eGUEjM4NwVq2EBbgHNnlrzzBKXSZn75AKy/fjrnBnaWLPlVYUf/27F1O9d00sgFsvifnT/b6zU2RuHCwR9lKtYN/WMi36gazOGCGHkfGBr6Yrd5NPpx1pyKI3YbqXiXoG2x+SLec1losDZNevtDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTX8ELueQZLAZfpG6jdQ23rcGKzkCQG975bdQKRCOyY=;
 b=ewoJ7B/aHqcTWUKG/aXYJS8dFHEwUXFmwbbnmiAhloCqID4R9IM7SAytXarpRiWw3B7KKupgGvwTdNI32+WHL4SNO/MKxIzKURiMprxrdegvfdHblRDnG/MOpB8x7jdrWiCV7nv5/uh6+sbHVD5N7CYJsI2XAjQKKrLa8NxT101NA2JXr6zLTkCeyG673x7LpEjm3LnOTRakSZebrIk0d046kOt8PC3gj7JmxBMVRioizS19m1outjYL1EQJoGYvWTNII3K6DGgW182qWdemePyd3oaQfPnjN92tEV6pulSjiiG/nYNY9IdqkoW1AxNR6mWHDHJdgTK79TT9B4Y2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTX8ELueQZLAZfpG6jdQ23rcGKzkCQG975bdQKRCOyY=;
 b=takHO7ksdrPRQfYMmsccO931CxBrg4NlsjRYg/VPE0eqFfwYnNm0VxRwBegTefhRQ5to50EoxBq1M7WItocB9PgycACQma1RMrlsvCOUm6cgmSOb9NfidyfNXsEc4xWAil4chOuTKenOk2AXtE3nhEVktoLX7QMWR2O4peIZ4kU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH0PR10MB4924.namprd10.prod.outlook.com (2603:10b6:610:ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Wed, 11 Mar
 2026 15:44:11 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9678.020; Wed, 11 Mar 2026
 15:44:11 +0000
Message-ID: <d5b55407-ea7c-471e-9a8e-37601c5fc573@oracle.com>
Date: Wed, 11 Mar 2026 21:14:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 02/10] bng_en: query PHY capabilities and
 report link status
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
        Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
References: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
 <20260310144044.21672-3-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260310144044.21672-3-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0048.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH0PR10MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbc3829-e0a1-4ea3-6522-08de7f850910
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 aR58UaZJd/XdZFZ2iik58f4uNP9kh3C+FZqxrtHlJLOwQUo1HNT97a/t4UifHqjViOxL+rg1vYj4n5Ljt7oOkeThF8FBFtyO8IH+oYdiHz5JrghEHhEc5uD6yNIhRdPMu/NrK81eMScOb05AS1Bz35q2miOswOYQk/RIiKbXIUUihZNtnB7yv3S4MDDiyeDJtMGebtbMH+761qj0uZH+enMXg+heVN134+dEv1s9wIsm2zCvMTsvjbpfTOCX7OEwHorCHwHrbmcEv3W7VIv0Y8g2of/heWZhMw05vEzwDchPemflb6VaSTkvVmc+e7/A6sSVocHG2u8hAbTAXMv3YpgsUryHu0TSuE0op0TVVFIZiNCnxCReRr6c0bZMWXlTgcAVIEz/tB59EKEmnV5SaQuU36fkyhFCe4Jv4tt80KgIRpWs7xWdpqHgA3Hbuzj2CtPk6Vzpz+kSpI6WKZw2iTL9jGmgmkBexKLniATGweS46CExemiGe3413ZvQxJcix5gkkqYW11TnIrEFlaJYmpeWV0/JeMXAmZoiDvFU4AkrUAN2IwnVdIl62lVgHR2xv9p+cXbQrDyjkGJh4/ueYqxujK/XcILmCi08bhXy7crurMzXS+IfhQwiKquTseAHI5Fn9Gne1n+sdSNXmP1CaS9NstJay+K9h52fSr3mE+c5dC27dwyWJmgT4TKYA/J1AKzzB9CO8u11P5q3oxQz2yL/U4SpuKunZsFtczQBnaU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y1Y4cDlQRmdYajhELzE2MEg0Y0Y2Ui9NZ2dZWUpMcUpHUHN0K1l0aTVYM0Ex?=
 =?utf-8?B?dDhla3RtRWd3OHR3NmJzVzN6d1Y5bDR1RDdVd0U3Slp2TlRBblRjMnhsRTBl?=
 =?utf-8?B?LzAyR3EzbExJd0RpaDNQZXNHY0NQdDJIV3ArNjdIQ0NpN0lJWG15NUJud3ZC?=
 =?utf-8?B?cmU5bzkvWEp2SmpXTS9HUmNZQkdGSndocXg5NUxPWjZBTGVRZVh6Y3FaUWlZ?=
 =?utf-8?B?T0hKYk1oR1NSbzFINGpmQW13VFAyaDlzdUFpK2NZL1hGRTNOanR4dnN0amp4?=
 =?utf-8?B?U0QrZlFiYUFDaFo3RVJ0TTdzQVF6U2N5SS9JdEk3aEYxSXpGbVlwaGUwVUtT?=
 =?utf-8?B?c0JjWWxyamJnVzNIOExaTU9MOEVtWVNWZnEwUSsxdzJqQSsyVVVYU0wzS0lL?=
 =?utf-8?B?dGJOVmk4WEtmSDJsbHBTbThwK0JVV01JcFZpR1FlbDNhSUpOMWlRVnRlODNE?=
 =?utf-8?B?MVRabmVXdzJTQUJFeEhhZWVCWmRFQlg5VGlDUHZzU2NSQlhld2ptYVR3dlpC?=
 =?utf-8?B?bFhlZnpGK09BR3VOWjZZNklJdlF1Y2FxSnFtajNiUHBDckpaQURnb3kvU1RD?=
 =?utf-8?B?MjBGTGxudVh6ZmdMcG1oQkFLOHVsL1M1TnIreG9GaDRhVGVQT3dLbDBTUEhT?=
 =?utf-8?B?ZUVCOWNJbzdtUitGcEZOM0FkQzFuS0krL0hmRnIweHJBTVhvQnEyT29kbzJo?=
 =?utf-8?B?VkZ5Ym8wYkk2dzRtUEZ6V1ZtYWsvQ3Q0U1p5dzBUUHJDMEh4cmdROFByRlF3?=
 =?utf-8?B?U3FvQzNwbGxEMXlxUWRrRGwzbHBoNU81dTM3bVUwaUZoOHVGU1cvbXVqWklj?=
 =?utf-8?B?QjJmSWhRWmlVL21UQmxiK3pNMHcwR200dkRqMnhkaURhZGlNOTN5MGRXNkYw?=
 =?utf-8?B?eHJubnNIU3doR2Z0eW1LZml6N1lCd1ZVaVRGQ3Q2VXN4dWF1NTdnTHpqaFFh?=
 =?utf-8?B?Sm1QN1pQVTJNUjc2c3hPYTRIZlVDd3BZa1ozbUZ2dDd1UE5sSWhwbGZJTTJT?=
 =?utf-8?B?MTVCNTJkY1lTRjdoQU5nWnVvYmpIdWtIRGtpZjlESnJLQTFqMUpjK05ZNFUw?=
 =?utf-8?B?TVBGMlN2RGtoNnlkZ0FXcU1nY1lLRzBxdU1PVXdOOEFZRG9PN0g2NWZTNkNJ?=
 =?utf-8?B?ZDd5K3J5RHlST2VmekhSTmVXU1N1ODhsU0hkVVJ2d1JsNXNSUHJKbVVXbDlG?=
 =?utf-8?B?Unk4WDFQZ2tYOHMydDkwMitSUHE2ZUdjakx4d2g2NW5FRkpaL1lYbEpUNUh3?=
 =?utf-8?B?cVZSUTFwQXowcGNISkpwWUVaY2VVTXNoYUJrM2J4QWRIQ2ZIU09xVG9JNThN?=
 =?utf-8?B?cWJZNFNYVmxueTZvdHBYRTQ4UWI4c2k3aExoMGVtQU9jbE1YMW1SNTRaWldk?=
 =?utf-8?B?SzN6eVhuSXR6VnZUblIvaUFLZjA4clIyNUdVSVIzTThKUXVxUlFqMzJyQlVL?=
 =?utf-8?B?SUdzSnY4ckhNVzdrOFV2YXRkRzR6NFFxOVAyZjFDdk94cDJNMThYSSs1YjBl?=
 =?utf-8?B?aE9sNHhaU0pRcFV4QmhPSk1GazZ6MWNvcVF3T0ZpTkFidE94UGRiOExidUo3?=
 =?utf-8?B?QnNRK3YyMGxhcmFkTEJjaUY4RnU4ZnFWVUptSVBpY2dwcURyZGdQOHpvdC9F?=
 =?utf-8?B?UlhjMzlTK1h1dFZYdFE3c0FCZ0pyUU5KYzRqODIvenpoR1dVQmJDZGJOcEhW?=
 =?utf-8?B?NHFVUVFCMmJRSUpDS0xiZnZLdlhTWFVzcmdOV1d4a3JRb2RaM21LbjUvTWQr?=
 =?utf-8?B?Z0xTRUttMWJCdzBXc0NKZjhpNHo1aGpKMlRQVUNXN0x3Z1l3Z0thMUo1YWlI?=
 =?utf-8?B?emJiQmgvVXhLbzU1TXltQzlxSGJjUzhaT3llNml4enFDaE54WWxaMVR4czlH?=
 =?utf-8?B?VkJhNjhLcmE2Z0tRS3dNTFMyVndaR0tpaE41SWtpZ1pvT0Z2NlM3NjJ2c3hC?=
 =?utf-8?B?VVVhNHZPZUdlR3BmYXJXbHZsemNLQTVXajFuaXh3cExhMXJqR2pYdTZCaDkv?=
 =?utf-8?B?cTNNbnJmZk9JdlkzL1RLZUNsSzNkeGhYSTBaRElwQlJ6ZXpwMGhDQWlFeU9o?=
 =?utf-8?B?bGl1Yk41U01UZHpubDRDQ25nVmt4V0dJYm1nYUdCUURaMUVYemlzVGN5WVFw?=
 =?utf-8?B?TFM4MjFxY2pzUGNPTGxqM01hTFRjbU1aODJhYW13dkxJenJqVFVrMlRzVVBI?=
 =?utf-8?B?SzRHYTBBU1BpdDNleW9BTVlPSEpGZGlObW9rcW1NbnVuWXlMUTRHSWt1TFZK?=
 =?utf-8?B?R1p0YnNhcHdacGMyV2U4T3FQQlpUbUtYWFcrK3FGMFFQTkwwU2ovbVdkWUFm?=
 =?utf-8?B?cFczaCt4dWZvZFZtakRrejR4SFVWMm1RSGtaU0UvUW1VdEVJUmtTYVJXeVVI?=
 =?utf-8?Q?OSF16WDZQmXyep4g=3D?=
X-Exchange-RoutingPolicyChecked:
	c5Db+qjJET9mN7MVRAyVn+sNJRlbTQSo9blvh8sJ/2RIXtJkrFTQfjRxCL/jzkqpxswlrqg3wuhBZo/w2YGyFURYFaVYo/THrhDQMNqHwt1HZnziomxAGrv4R7fImOVoHVTli/SBE7UHlj806DLkJ2WVs7RDDpqcFDXVdI+k3XqCLwAzaja2s81bcBcSup60398BACIYXWFMoMGQhSvzSk3BMITCf8Wc8GaxbBVW7/WVc+7aHwXDozQty0x3MGD6EjfrCUisUXLzUY3fkJ+am0ppE4P6Mp8aeUK6mpTiEJJggmTwKsSD3CWQ/cXRCPCcttgWV3KC1oP39zkpMwhU6A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jR+MijRLY6QxIhWgqhWb+g1nhZ5vyMtZS/YUXvhIjWp/WsAAcbC3aTmBdMq+CP1XbhTvX8efMne7SWCkjlLRYTpCspxUWCuQFW4VkwfXnieKmhP+FpPCGbEmNRH5MF1ndB+kFYwcQOAGJ26AW6n7TE6egdCEyrG2jdKEIOG3gX4ExfCYHlpYjQ8gOio2iOC7T8sX2U0PmTwU66z7V6/mnqAut6Casb7vR9JYy7LxRRfS+Rxqadc2sUl9wRN4imb0n7nS3Rsr4EHxzoT5o+i2V/vTijPQLmNaXZ/AIpWF+A21CGXfRMoKsLNs3dgSq/Lfkw9gP2oQM914Tm3Gzs4ssZUfXNlJITBQHfuz3FC9fOzK0oltr44kLZw0DgzOzH6FB1LKuY0ItbudfeUNZ0QX7EDCsD6FloEx4pdgiiKV3uW040Y5vy8pE9uS1H60wYUN7Wg9UYaICb+ZIl4i+Gt5Ufm2m+uDAy47J8+B/SuSV3et0aYCbNJNBdZgH44Zd9QwhYjsmn711zGgTfP3u5XVduIi5KhWbaex1Hg7CjCKIPFkPA7FDF6XLBmGXi2JTGD3adYyghNBJjO2kfY3lReryXCszKj6eSBKuBrnDReB2Ls=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbc3829-e0a1-4ea3-6522-08de7f850910
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:44:11.4625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aj5lItsw9zMtQfKbTzHj0z/LlQUIC1XSbfQ0x0aWYfDaTCa7Hw1gSr0KRVJKZJNtBCH8yy09Lhd7QA4Up+NnZeq2pm7toe6MSxLEInMF1sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110133
X-Proofpoint-ORIG-GUID: 41XpH_ENyEPVCiC742RGkiRnKHPnpJaW
X-Authority-Analysis: v=2.4 cv=N8Uk1m9B c=1 sm=1 tr=0 ts=69b18dcf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=mCo-YxjPDgww8h7LTm8A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13819
X-Proofpoint-GUID: 41XpH_ENyEPVCiC742RGkiRnKHPnpJaW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzMyBTYWx0ZWRfX5euvGYsQefs7
 p16GGw8yeHm89/RKUQGsxAxAHME6YykUpqmNTlFnRuqHL4k9Y/Dej5xqHiQIYZvf7xrZCd6o4Sr
 ggE7ZzOQX+J+/zIhMJFnYLa20gc+9JzuI7/cKtR/SCLAtxwRSvhDiNFxAz0emvnupslKRzkkCkr
 z7Vu8cfIOng/v5C/2f0RdNxMr4WI3yFF1TUjrI7VP9NOpciOy/C346XfQZwYe/sWeFfDbhJ9HXZ
 jAWg49gKto2zEe1OIdtjH+MfjwWZMeQwASMddLoR5IC+05BWE1phDI6CQl+vLliWFJTllWpN7MO
 nWUL+c8u3hqhw1lRcPSyYO1k7KN1UkwRoC8dgAtj6o+3Dw4t20i6GSVYUNwr8tBxAL6a5CNWj9J
 LPbpcyu9OjBvObREHOrLnhYqlWDejL0F45VDEuK+S76oiqfcuMYze5N/k6xFjv/WCAPU6UlFqp5
 A9hyGQQx6AGsNzsI7mESlkoAdvlo+k+h7V1tBw98=
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-266686-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9BFE2266BC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/10/2026 8:10 PM, Bhargava Marreddy wrote:
> +void bnge_report_link(struct bnge_dev *bd)
> +{
> +	if (BNGE_LINK_IS_UP(bd)) {
> +		const char *signal = "";
> +		const char *flow_ctrl;
> +		const char *duplex;
> +		u32 speed;
> +		u16 fec;
> +
> +		netif_carrier_on(bd->netdev);
> +		speed = bnge_fw_to_ethtool_speed(bd->link_info.link_speed);
> +		if (speed == SPEED_UNKNOWN) {
> +			netdev_info(bd->netdev,
> +				    "NIC Link is Up, speed unknown\n");
> +			return;
> +		}
> +		if (bd->link_info.duplex == BNGE_LINK_DUPLEX_FULL)
> +			duplex = "full";
> +		else
> +			duplex = "half";
> +		if (bd->link_info.pause == BNGE_LINK_PAUSE_BOTH)
> +			flow_ctrl = "ON - receive & transmit";
> +		else if (bd->link_info.pause == BNGE_LINK_PAUSE_TX)
> +			flow_ctrl = "ON - transmit";
> +		else if (bd->link_info.pause == BNGE_LINK_PAUSE_RX)
> +			flow_ctrl = "ON - receive";
> +		else
> +			flow_ctrl = "none";
> +		if (bd->link_info.phy_qcfg_resp.option_flags &
> +		    PORT_PHY_QCFG_RESP_OPTION_FLAGS_SIGNAL_MODE_KNOWN) {
> +			u8 sig_mode = bd->link_info.active_fec_sig_mode &
> +				      PORT_PHY_QCFG_RESP_SIGNAL_MODE_MASK;
> +			switch (sig_mode) {
> +			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ:
> +				signal = "(NRZ) ";
> +				break;
> +			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4:
> +				signal = "(PAM4 56Gbps) ";
> +				break;
> +			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112:
> +				signal = "(PAM4 112Gbps) ";
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +		netdev_info(bd->netdev, "NIC Link is Up, %u Mbps %s%s duplex, Flow control: %s\n",
> +			    speed, signal, duplex, flow_ctrl);
> +		fec = bd->link_info.fec_cfg;
> +		if (!(fec & PORT_PHY_QCFG_RESP_FEC_CFG_FEC_NONE_SUPPORTED))
> +			netdev_info(bd->netdev, "FEC autoneg %s encoding: %s\n",
> +				    (fec & BNGE_FEC_AUTONEG) ? "on" : "off",
> +				    bnge_report_fec(&bd->link_info));
> +	} else {
> +		netif_carrier_off(bd->netdev);
> +		netdev_err(bd->netdev, "NIC Link is Down\n");

Is netdev_err() appropriate here? If this is not a hardware fault
netdev_info() might be more appropriate for a normal link-down
event.

> +	}
> +}

Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks,
Alok

