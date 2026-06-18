Return-Path: <netdev+bounces-300342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W+HpF/GjM2pIEgYAu9opvQ
	(envelope-from <netdev+bounces-300342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:53:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1036B69E3BD
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:53:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=airoha.com header.s=dk header.b=LHYu11UG;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.s=selector2-mediateko365-onmicrosoft-com header.b=lwTvMg9F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300342-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300342-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=airoha.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4E50300230B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3BA3C942B;
	Thu, 18 Jun 2026 07:53:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378453ACEF8
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:53:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769191; cv=fail; b=kPgyBE/Zi0fhr8q9/U7VCiCBX0ahbtLiZmgnzctZRaX57Xa3NY5kCDa0UUM1REbhCH7CmNAxzZUSJ8DFXYec8csK+jHaATIiwg4iis606YwVOcJjouNI8+8xne7H8HVPNZJQCpDOTNE067TC4RaCEr84gK2BT85iL1mO9NOm7gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769191; c=relaxed/simple;
	bh=VirhjsQ2PYCOt1eRH4Quz8Pkg2XQGCWlxNu7S62WaCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RzYDC7bigzJnmkwDWdBvS6Kv0DAoKJCfoAUFheGgQrjGKmo+H155cl8OR2meJwRUAGSZePi0ZDIDTg1QKKSROvaF9QYQoZ+0jHSeOIZCrLBHUzIc+k3XgHanCG4QKlIYB4yX1ZrkF1+uxz7W+OZTxY1UhnVvx9wMaVHmtPIcp7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b=LHYu11UG; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=lwTvMg9F; arc=fail smtp.client-ip=60.244.123.138
X-UUID: ba2718b86aea11f1b1788b6acf885367-20260618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VirhjsQ2PYCOt1eRH4Quz8Pkg2XQGCWlxNu7S62WaCE=;
	b=LHYu11UGiEBoRvhVP+tloNV19xYZClf1zIdcKJPt5ldqvj9VCSodFRo4F03TXyOKQBTHWM/VcSzzfDHsKooFsos7vOdYTizKDAEW6rpB7TEGDm+wJQRxNJei2gF2MV/zOAHIYWif7nUGMKODQOha2y9aJk1iT0LQdChISpSl5NQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:94181593-6bad-4ee2-bf3e-6dc2fa1b9a73,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:5471d0ed-45e6-4692-a476-3f71842ee83b,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|817|836|865|888|898,TC
	:-5,Content:-10|-8|-5|14|50,EDM:-3,IP:nil,URL:0,File:130,RT:-1,Bulk:nil,QS
	:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ba2718b86aea11f1b1788b6acf885367-20260618
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <leto.liu@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1802310232; Thu, 18 Jun 2026 15:53:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Jun 2026 15:52:59 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 18 Jun 2026 15:52:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+9Mu7eGQ0UNymtskl8xZ1ABsFSKZleSQxMotC5jDY+nBXy26RtvEIhwxr19qGDVZ6Lsn01eeA45qLD8qkS9AxccVm6oPIZGUjAXi/DtwNQwZn/xZ2NMQUoLOqT4JXWryNjacm9GArmx90nB1jrh0yQHpF1Yzs5ayY6o5xyUPJyQsXpfOgB+q35DGgh5xTEBdg1evQJYi1nEok00UxuT6u6IzjoZ9sDHjjFI00vFiV5svCVDZ2a8kGtvgCdNm6lJiNrJXuNw8ob+PYrG6IDnQPZwor9mBArQ6jlLL6SenwoDbh/uhf3OsoAX/QoBLlv8JCFUUWHItHdeWeDhVDHg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VirhjsQ2PYCOt1eRH4Quz8Pkg2XQGCWlxNu7S62WaCE=;
 b=wc20/RRG97FgpgHalP9GOjTnw8TJ5+48010Bb32n6mJFJg4W7CG9zyBEJcYNUGIZBtIOZ++KfXzF8l4P/J6UJB96MiLtLZEw1I3fP2Zvt5tyLctEzg/qpjVp1gpMpKadMSiAh9FyzfY0jHrxQlRJHbbqjrsZM7W5oxyE6Hn4YlGupI10Kc+rXuiEmQTloUMlcqqFX0j3BZ8z9PGVYt0BS5QBRyi0sEml3vFFdfcKCHgGM+UBUcs832o0RxcG0rhfYd3clrz9Cwb9MiNQ0l1mBWPnLGMjkNVCM6JwggLFyxvNU19khzTfZ2kOxFGvX0kwY2rfL0hLIGb/syZKJY/+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VirhjsQ2PYCOt1eRH4Quz8Pkg2XQGCWlxNu7S62WaCE=;
 b=lwTvMg9FLJ8w6RDC53Ee8EKDUEhQsWhskCl9Gnv30sqHkD+3tG60GRQfTtcr0aNZOoU1EJzMB0cyyCTFLHQMf9iDTpHWf7T/ZLzGxQsEmDaXdT0ZcEQUPPpyTCiVxALmiQwR0Qijal1yEHM3Twi/YIa59jp2RcOJz02aEa9SBj8=
Received: from JH0PR03MB8619.apcprd03.prod.outlook.com (2603:1096:990:9b::6)
 by KL1PR03MB6897.apcprd03.prod.outlook.com (2603:1096:820:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:52:56 +0000
Received: from JH0PR03MB8619.apcprd03.prod.outlook.com
 ([fe80::e172:cb68:ccdc:8ea1]) by JH0PR03MB8619.apcprd03.prod.outlook.com
 ([fe80::e172:cb68:ccdc:8ea1%5]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 07:52:56 +0000
From: =?utf-8?B?TGV0byBMaXUgKOWImOa2myk=?= <Leto.Liu@airoha.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, =?utf-8?B?QnJvd24gSHVhbmcgKOm7g+afj+e/sCk=?=
	<Brown.Huang@airoha.com>
Subject: Re: [PATCH net] net: airoha: Add retry mechanism to
 airoha_qdma_set_trtcm_param()
Thread-Topic: [PATCH net] net: airoha: Add retry mechanism to
 airoha_qdma_set_trtcm_param()
Thread-Index: AQHc+Ylh2dv3psIJ7UuD1HiILnGJqLZD+94Q
Date: Thu, 18 Jun 2026 07:52:56 +0000
Message-ID: <JH0PR03MB861947E264CABC1C57D5A283E5E32@JH0PR03MB8619.apcprd03.prod.outlook.com>
References: <20260608-airoha_qdma_set_trtcm_param-retry-fix-v1-1-f07704f0d8c5@kernel.org>
 <aiqHgJ6FiAMu5gmF@lore-desk>
In-Reply-To: <aiqHgJ6FiAMu5gmF@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB8619:EE_|KL1PR03MB6897:EE_
x-ms-office365-filtering-correlation-id: 9610141d-8700-49c4-9e5f-08decd0e9c09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: jb2uaaNmlFeh5pMTQLrQu7vIBclzUJbpviFznomMXf7V82k8IYUjuCJVqz/onVlXyUsPlS5DvQWg+/OSrFanG4p3bGXL/fWHF9uyHZB9CcGZk2l1MuRX3psZoIybldgPgGniH/S5plUwbzTTA9o52qFgUP96wa4txWBWeF2BYjo4iTw4WxefgibkIYxrQiigDJG5xeKdFJVRF6HSzyL7D6zjMJ3hQWGvgjO/gubS/bGgFYs1WdMdBtifEQXptO5ox6JUEf8UtSoqzlTV4po1+8NNMyck8xNfZKoQxaxG2lv+5MsKDYd3vaWgh0azs/QHgh1aQ5gfLhoBc624tQFZeB0jI3AwLd9pgAyYCGt5Q/n1yFju67gwSYeBkckX/bx5rOgHwfmDZzydPGJNMq+vfBWg8iuFhuQIxaCRZEaEwdy5qOBKejtjFxvwAxZGwnFFXuGTnxwHEqwKDGZPQa7qfVzIByWqeTO+w6fp14ZSZ6gpm14/gBjMYORsKLpkPYFJ5oIaTVK8aydAYum/DIl86iSv80ZoVhqHpOQBujfMnxpYhhZoo4OxNE/YlpjzZQMt8LpvbEk3AqHjEK+w9KjvJVUceTuDAZhXipz2IUUbwg1/MDPpBQgfGrui4F6hdQj397RTshO4j+dQ47u6dOGYV+XONuNyt3Uz7JJNq/i1rNsroajXYXpX+iFCiEmX+W4a+DyHw3tSPY5QjYJe0zIsmGoBSXQJgxF5HN/+LnUkHgaQVRuodVHvTj3FMW2f3Z0H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB8619.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWFzQzF6K0x0bVViTnVOWWFZMDNnMWllakQvcDJuMXJ0QjBVRDI2KytBdTBt?=
 =?utf-8?B?Q2FPOW9DVkFYMURoU3YvSEw0TzU0MGhRYUc4eDRWRUNyblJ2NEg1VkFad0xV?=
 =?utf-8?B?SVgwcGx4b0YvQ3BQRXBUVTRZeElVNk1EWjMwTVJ4OVNudlppL0RyT0dPaEVk?=
 =?utf-8?B?c2RydEZPVzhoSTIrUUdBYlowZHZRYkNEUzRsUERlRUpGNUZ6SEZ0elpUQzNm?=
 =?utf-8?B?MU5GYmhGekx3SGQ2dmdHdGdIYzdEUzhwZTM3a0VUKzFUYmd3WGl0dFFYbUd6?=
 =?utf-8?B?L3FlVUwzcjhSTzhrSEIzeTFFYUxtSm1PK0FiYXI0Mk44SDRxUGZmSXMxY2p3?=
 =?utf-8?B?ZG1zdmdSVHdpWmFDQUJDVGRsck4rTHRKS1loK2ZKSytkTndNSlNGMEE5dG15?=
 =?utf-8?B?L1VRTzdCbHNrU2VRbE5jZ0lSQ3lyRVVRTm1vNzlDa0QvOGJGWW9LNHZ2dHF0?=
 =?utf-8?B?ZCttNDd3d1dOU1BHTEVDVTBRK1F2UUVHeTlkZWwwNHJxaStNcW10VzA0eVVI?=
 =?utf-8?B?cGU3ZGJlTkxBK1o1U2xpTHJWRytmUWtTaHBRZCtCeVNuU0FLSjQxeG93Qkgx?=
 =?utf-8?B?UUtTK3laaWhzYURZcmJ6blA0VjhFcEtmbUhkMWp5eVJWRElHSHBCbjdDQnFO?=
 =?utf-8?B?YUYyWERFT3FZc1R3ZHp0RjJXUWI2c1gxSTY1eVA3bkg4Z1NrMlFaWWN6VTFI?=
 =?utf-8?B?REpJTEtKTHR4Y3M5a3V2WlJzSTlpeURmeDkyQXp2bE0wR2ZGdktoNFN2allM?=
 =?utf-8?B?QzJ6WlJkWEtlWnRaYnFZajlsQ3NRd3lSa2pVTm5XUmdkV1VEajV3bUxLNHBm?=
 =?utf-8?B?d0F1aU5iNTM1UHRhdGl6eGxDazMyV3ltZDBjOTVLaDRLR0JlSEIwR0kvNEhw?=
 =?utf-8?B?ejB3K0JIVGxPY0hnUEFaNXJzTXZoeHhucVBpNFJPSWJTNVNrTjlvOWY0RE9B?=
 =?utf-8?B?MzEyS3U0NzRBWEhDTmd4S1lSbHZRbWo5RWdVWXhXMkQzUHZUS09rWUQwelZX?=
 =?utf-8?B?MnVoOFhZVmd5R1pYdWRwZ1pEbVFzSEU2amJzVlNidE9aL1dSNXE0NEM4UGlO?=
 =?utf-8?B?dkZqbmdjMGR6MVA5TlVWV1EyWloyUFE3M3FndG15Qzl0OWw4UkN3andkVDlW?=
 =?utf-8?B?TGtYTlRnVk5CNlNGV3lPUmRBN3ZDVVMzbGpCdHZlckdUcll1cmdybnRJSDcx?=
 =?utf-8?B?N3I1cm9UK3lVQTk0NUNnNTdneGsxK0V0cXNLSkZPN0crT2JnM3ZaUWZpV1NU?=
 =?utf-8?B?dWpnV01WWFBrbW0wOFdKbjlReXB3T2dER0h6OHpqYlBVeDJsc1JoZGovM25T?=
 =?utf-8?B?NEYxRjdHZ2tnaU9kZ2xEcGtHTkc1MExEMklXOXoyTTFVNGRMaVcxaGVqcVdX?=
 =?utf-8?B?NnJad3BiWHBxSld2TjBEVzcyK2swNmdMTVJjdmhiNlhCTXdPWXBFWEhIMnRj?=
 =?utf-8?B?ZjJISjBhczR3Z0VISm1wNWlCT3I4YlpCMzFtcW56aG82dkxSYVZsY1d6QlND?=
 =?utf-8?B?aXpPdHJxRnJBWlB3UGRySVBaSEZZOWZRRHJ3bzhnWTRUQ0ZFNlFKZWlOL1p4?=
 =?utf-8?B?SDVJalpBRGptMjlHZWdPNnFZTUhTNnM4YTBsQVNPUzk0azQ3Zk5wUlh4M3Ar?=
 =?utf-8?B?WHhUWGZXN0NBekN6NjZrdjVQTzlHR1NGckkwY1ZTSkoyMHR5NTlPbkx6NUts?=
 =?utf-8?B?ZnlUcWhEUUp0Uk5hVisrb2RDekU5MlpxVk1oeldveUdsNEtwVXAwSmxyc2Fl?=
 =?utf-8?B?dGM0L0lveWFUQnp4TDNITVp4aHJUSnJyOUZkTm9sbS85cUVybE5aWUxRZStF?=
 =?utf-8?B?bE1sYzFNekVURWhFcXAzNEZhSThPTWVvdjhKQXp1WGE2dVlKSVpDcUZCZ1RK?=
 =?utf-8?B?Qld1aFZQK2g0Y0wwTGJLb25qM0hiTE1PcS9QZ3BKYkJ2UXZ6eFFycGVhemk4?=
 =?utf-8?B?ZHBnV2R1Vi9UMUtLN3BiQkRXSE5tQWNxbHA4ZGljMDcrTHNLQmdVd3RCYWVB?=
 =?utf-8?B?YmhsT011bWhyN1Fid3lOeUdsc3BxTEpUK012b2RncG5DK3BqcTZBNkJWQ1Vh?=
 =?utf-8?B?L1lyMjc2cUpERENkb3lHKzNuZ1FaV1JPKzlhSUdPZ3QzaGdmNTk3Vno2bUds?=
 =?utf-8?B?SHFCeWZQblo5cDhnZ0NIZWFJVHg0Z2hHeWd4L051RVF0Z3NSaVJDZkM4c2Vs?=
 =?utf-8?B?cmtVajJ5bHNaMk9Ucm9WU3hqRzUwVEszcExhajFBQjU0dkUxZnlkTzY1akRC?=
 =?utf-8?B?THdxTU1lbzBEd2xEOFZqS2tjZXZVanFGVVJDZFhEV25aZklvSEZvKyt3TnRQ?=
 =?utf-8?Q?RxtCX4EbxpbDExwK1L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V4MPdhw3/BM436CvcbctzAqBZndki9sFxvwo8511ReH1bCElJJQF6LlG1n1KnC61ivxGKY5aKwwQ4ffG1EGZSC83PEBTdCG+Yn4hSdC88JLxb9rzEIKPTHuiZFV8cV0LhpuQKLWxBtEnCexH7g4d+zgYGA1jmrgNn9ZHjtotaFpoLAR+wPvnxDm7+AX7w3v2r/qNcu3GWmSvHEorrMnnuqU7mc6xW1pgv8iKJEF7lXSU7shqfe98NXFFI6ptiKnPn0RB5HSpWNIKSuIq8UYWDL9C0ZqUsf1ZFyzcYmsp6Z3C56+0NjFFhAocVQ7UFJWN5qZYGvdNMIF6W1Bu9u73iQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB8619.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9610141d-8700-49c4-9e5f-08decd0e9c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 07:52:56.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjhOKsr/xqr4AKuFtT0OMzpoCh/a/K6uuBL2dkYVAdOsmQGnNZ9dRGrvRpHcOkNrdtUWkbVWbwsWWHreqhUOsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6897
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[airoha.com,quarantine];
	R_DKIM_ALLOW(-0.20)[airoha.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300342-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Leto.Liu@airoha.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:Brown.Huang@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,JH0PR03MB8619.apcprd03.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Leto.Liu@airoha.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[airoha.com:+,mediateko365.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1036B69E3BD

PkkgdGhpbmsgdGhlIGlzc3VlIHJlcG9ydGVkIGJ5IHNhc2hpa28gaW4gWzBdIGlzIHZhbGlkIGFu
ZCBpdCBuZWVkcyB0byBiZSBhZGRyZXNzZWQgaW4gdjIsIGJ1dCBzaW5jZSBJIGFtIG5vdCB0aGUg
b3JpZ2luYWwgYXV0aG9yIG9mIHRoZSBwYXRjaCwgSSB3aWxsIGxldCBCcm93biBvciBMZXRvIGNv
bW1lbnQgb24gaXQuDQo+DQo+UmVnYXJkcywNCj5Mb3JlbnpvDQo+DQpUaGFua3MgZm9yIHRoZSBj
YXJlZnVsIHJldmlldyDigJQgeW91IGFyZSBhYnNvbHV0ZWx5IHJpZ2h0Lg0KSW4gdGhlIGN1cnJl
bnQgdmVyc2lvbiwgdGhlIGltbWVkaWF0ZSBjYWxsIHRvIGFpcm9oYV9xZG1hX2dldF90cnRjbV9w
YXJhbSgpIGNhbiBpbmRlZWQgY2xvYmJlciB0aGUgd3JpdGUgY29tbWFuZCB3ZSBqdXN0IGlzc3Vl
ZC4gVGhhdCBoZWxwZXIgcHJvZ3JhbXMgUkVHX1RSVENNX0NGR19QQVJBTSgpIHRvIHN0YXJ0IGEg
cmVhZCB0cmFuc2FjdGlvbiwgc28gd2l0aG91dCBmaXJzdCB3YWl0aW5nIGZvciBUUlRDTV9QQVJB
TV9SV19ET05FX01BU0sgYWZ0ZXIgdGhlIHdyaXRlLCB3ZSBtYXkgb3ZlcndyaXRlIHRoZSBjb21t
YW5kIHJlZ2lzdGVyIGJlZm9yZSB0aGUgaGFyZHdhcmUgaGFzIGxhdGNoZWQvZmluaXNoZWQgdGhl
IHdyaXRlLiBUaGUgYWRkZWQgd21iKCkgb25seSBlbmZvcmNlcyB0aGUgb3JkZXJpbmcgYmV0d2Vl
biB0aGUgREFUQSBhbmQgQ0ZHIHdyaXRlcywgYnV0IGl0IGRvZXMgbm90IGd1YXJhbnRlZSB0aGUg
d3JpdGUgdHJhbnNhY3Rpb24gaGFzIGNvbXBsZXRlZC4NCkkgd2lsbCBhZGRyZXNzIHRoaXMgYnkg
cmVzdG9yaW5nIHRoZSBET05FIHBvbGxpbmcgYWZ0ZXIgdGhlIHdyaXRlLCBhbmQgb25seSB0aGVu
IHBlcmZvcm1pbmcgdGhlIHJlYWQtYmFjayB2ZXJpZmljYXRpb24gKGkuZS4g4oCcd3JpdGUg4oaS
IHBvbGwgRE9ORSDihpIgcmVhZC1iYWNrIOKGkiBjb21wYXJl4oCdLCB3aXRoIHJldHJpZXMgYXMg
bmVlZGVkKS4gQWxzbywgdG8gYXZvaWQgY2xvYmJlcmluZyB0aGUgdmFsIGFyZ3VtZW50LCB0aGUg
cG9sbCB3aWxsIHVzZSBhIHNlcGFyYXRlIHRlbXBvcmFyeSB2YXJpYWJsZS4NCkkgaGF2ZSByZXZp
c2VkIHRoZSBwYXRjaCBpbnRvIGEgdjIgdmVyc2lvbiBiYXNlZCBvbiB0aGlzIGFwcHJvYWNoLCBh
bmQgaXQgaXMgY3VycmVudGx5IHVuZGVyIHRlc3RpbmcgYW5kIHZhbGlkYXRpb24uIFNpbmNlIHRo
aXMgaXMgYW4gaW50ZXJtaXR0ZW50IGlzc3VlLCBJIGFtIHJ1bm5pbmcgbG9uZy1kdXJhdGlvbiBz
dGFiaWxpdHkgdGVzdHMuIEkgZXhwZWN0IHRvIHByb3ZpZGUgdGhlIHYyIHBhdGNoIGJ5IG5leHQg
TW9uZGF5Lg0KDQpCZXN0IFJlZ2FyZHMsIExldG8NCg==

