Return-Path: <netdev+bounces-295911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gPlXGF0JI2qcgwEAu9opvQ
	(envelope-from <netdev+bounces-295911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 19:37:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F10BE64A3AA
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 19:37:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sony.com header.s=p1 header.b="JuKbP/tG";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295911-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295911-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=sony.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0458D3056B19
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D357A1A3154;
	Fri,  5 Jun 2026 17:32:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A9416D04;
	Fri,  5 Jun 2026 17:32:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680754; cv=fail; b=Enh3II1K3rtTJx1KmlQDJzXtWmCZxXjfygt4V4KB7B9UQz8jCdo6LGBRue/9OmeHPVUlXa51GFgQ6PQx3fer1JOabMx34DH0byv328PuWTWcQNnkNMBtc1tBwcVdpMy1LSlvCSeFSsPzDtDO4j0ls9I7sSwjCatbOTog+2zeKFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680754; c=relaxed/simple;
	bh=HEFrNPzbj1NOutaBuLHmu8wmBmtEs0VCkg3uR60d350=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f/Ylv3T86VEAJZLIup8DRnWlcg4KePPHTkukAddiygZofVTkC/uba5mlKKTIxuLuh0sMJXtk/4SfAcEG3wp3KPYEqzxDXiZsuNhYhv99IJPtGqmMfzyHvIYMyUC3QjM2gfpXAK1HQKSDT/H+dttv9E1FLQ0kaPdVDG5XMqEI9TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=JuKbP/tG; arc=fail smtp.client-ip=185.183.30.70
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655GpPSU987047;
	Fri, 5 Jun 2026 17:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=HEFrNPz
	bj1NOutaBuLHmu8wmBmtEs0VCkg3uR60d350=; b=JuKbP/tGdOWGDWk1Iv4xVxi
	Gw1iztKWtY35q7i/+bcC8zs/1jQFAip1HKfklSnGNm1AM3WTT7VOY6ZEE24fy1j5
	mU9DsjQMVjMX9pI2Mvos1IiuIkE65myX5vD9AasfbRtEFxTc9QcLHwFISWNicdAX
	k1yvNgCK344TNqjZgkj/jDlS4cgWhInBNJfWCCMfM9puU+Y2s6QipeUbUTkGSloM
	Rks3lU3DbqRfHLYhjyNSf+VSCAAJIJwwWwrLvO+5HQ4NnuOzeaWDg9l2MMVOW2kq
	Qv+9qqNsAfKNQpkRAcuHUGsWBakq5u8udC7Ov+RinTTwFNw4sheYacRYHvLrGxQ=
	=
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4efpp5qbuf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 05 Jun 2026 17:31:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh9CKH/RZFda5mxSB6v/FUvVILzQAvsmInCLhNbqcEoWxJ69SHFgZmmul3YsTYvUGYDFsuJnhTK3d98rxXJfWziWhI/r9UWlThBiBdwr6Z0nI/YlxC+XTzeJkxAgObmD5w18PDmU5xcIVzMeEk3OglSJyK9tKIrlO46qvtOuNi760A1C3fK2CWrwFokGtD63Qes3YGQR1EmBOx5fieud/TSRh1jdwxVfF28M236xsnKN1bua+NeNV4pR0i4lahwoGVTUv3k+4BPMNX83y6NDmYlgTc/+IlYFhfcQsahX4Bs/pAmndoSEBsthbQ/bvMt8VbV1O/2N16KChiNSpx+KQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEFrNPzbj1NOutaBuLHmu8wmBmtEs0VCkg3uR60d350=;
 b=ZuQMh3DFn+EpTKv9HZ9OiOTJ1soB7m3TKmrJxn5jffNZSI/97Eoj1A7WpsAWb3JBVj9pLDyibKsJq1J+seJbV6Prhx7kux+bMQ4+My4QdBLyh0m8j1/01gqM4JixpEAOgZDoEe+Q9LEJdJqVnaycQamdWTC2STUxYqWOwPycKc7Jvh5FVZDZvLB8bttKzz2yFI7dmgrIQrZamskXX5Kmva+OE1HJmw2jfACTUjhB0SAGZlgtHDX9nkFoFu7MQjh4nuoERn67kbWsYfpPaOpgnSC1vhiEHplWI/97A7H9OHbWqSQ3jR0tTxZz2xRXYzYopisSOkR3GGpoXRRHkoyDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by DS1PR13MB6917.namprd13.prod.outlook.com (2603:10b6:8:1dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.2; Fri, 5 Jun 2026
 17:31:53 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::29e9:b355:cabf:66f1%3]) with mapi id 15.21.0113.002; Fri, 5 Jun 2026
 17:31:51 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>,
        "linux-spdx@vger.kernel.org"
	<linux-spdx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "jmaloy@redhat.com" <jmaloy@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [PATCH] tipc: Add SPDX id lines to source files
Thread-Topic: [PATCH] tipc: Add SPDX id lines to source files
Thread-Index: AQHc9FFUlV10YYXnxEudftH68E0XT7YvLzyAgADuuuCAAAwngIAADanQ
Date: Fri, 5 Jun 2026 17:31:50 +0000
Message-ID:
 <MW5PR13MB56322296263725D452A71BA6FD112@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20260604183805.747630-1-tim.bird@sony.com>
 <GV1P189MB1988FB0E53EA8D3FCC2533BDC6112@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <MW5PR13MB56323F0BA8638F14186DB228FD112@MW5PR13MB5632.namprd13.prod.outlook.com>
 <GV1P189MB1988CF69395CB583074480F8C6112@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To:
 <GV1P189MB1988CF69395CB583074480F8C6112@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|DS1PR13MB6917:EE_
x-ms-office365-filtering-correlation-id: fe1ebad0-ef4e-4550-26ee-08dec3285420
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|4143699003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 Zf1XOW92q14pQ6H1SFyb3palF2SGucnuFHPagNdqEFyFdCYGU5kNmz6ZYc2AN3CQy6xkDXjEPQdWlbUf5JNyeVNRYx/+Ic7FC3Xkm0zPgaZi7bIUSm1JqZbt1CRo419FEaYhS2t39K/Z0pi1GH/N/lxJySyDnkhy+pIPS5nHkXF8r5YxaapdUXctmBvrU4iguUXmfpQvTGOVVvigzsB/dt5nfV40G5NLGsIAjhJuEm8yRBe6raQTWO8IzAa1snplOxqB0Cwx/xPow07Ah+V/8DOoGXAG+rXacCHiKz+OP93/ZTu622atAnDIRN4W1txRGg28MXQ9WPHLLEqiYiATwspmVIK3RZNUQgAvcwlGGICmysILxmd/t4wl8Htzlr3u1lEqiUHpzAKhAtUvcqH4t6scMNo5ZqP4lJq48rq42u0rDpTuknlLwsXSYokcQPCpopGIvY7q4jzz+Fp18gADnAYQ0jrrx+lPIFf7A2y4CT1kvUYJd0WDNnPtQBKWaV7tmd4BMQoaSmXmkF2KdLb0rVpz6OrV0Pq0eN9zHMfOnv+EXQOMePwDkAQiPEsYaQf/bvG3O0IEaFmirSR0dURInZZEt0iA9PoKIdOR7UXL41QgIiu4u1dwclWxU0IFGqexgrbKwkKsQuxQ35b2AdZvxDlPcJWHf+BsQFuG0ZjpSAgJSNXTWo93onz2HiAdcIpj82J2VWnZx92x+Lk52vOiU4aYB31eRWhjsaJYLfMtzjYZuMuOcvqSI1lNhbF/2tzP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGRtUGk0RWlLYU1mdTB5RVZCWUZGNitMMWNFYlRGQjVITVVId2hlbXZlbVdo?=
 =?utf-8?B?T3JpNHRZMW5YVVl3T0JQT3k1RTZXaFVNbFJIYTJiWGZXYnVBZ1hvWmszTTU2?=
 =?utf-8?B?bEd0Nkt3TndQNHltOXdSU2lxaGg5clIzR0ljWS9PSEtCTGVTRVBJN0t6OXhr?=
 =?utf-8?B?VHlnNnB2VVVvOHdjQ0FkTEJlOHBQSXR0Y25kSXFIcnpYN2FLLzYyRE1XRndP?=
 =?utf-8?B?bzJVOW5IOVJEVGtRaEk3NjdJL2llZ2NqUUs1R25FVHpkbTVvSVZCYUhUVFhW?=
 =?utf-8?B?aU1mOFhRVjUwOXZXek1MNHJPbEtHQmQ5NWRmTTUrbmd3VmNwWmRsTjlwZGZJ?=
 =?utf-8?B?Vmt2S0NOVU84K1FVVGNQS0RZcDcwNmpGSWpDQWpIRGZHWmErMFFONlN4TWFm?=
 =?utf-8?B?MXVseHorM0VodStaMmtCMWhBcWcra25wTGJQc2htdmRLVnVKWjlnYUNjYlBn?=
 =?utf-8?B?c1p4Q0lmVzlyZlpwTGFPcGpaU2Y2a2llQ2tQSjBGT3NmeENxdmZIYzQyMnBB?=
 =?utf-8?B?OTc2VDBNUmdrWEZaRVlQTzVxMDF6ZU1OaWdIY3h1RHVBWEtXMFVPMEZoanVw?=
 =?utf-8?B?amFkU0hFbzB6VW1tMkVOdlc4NXhjV1YvaWhxYkwyU3lmbzhoWXNFcU1VdVpK?=
 =?utf-8?B?UzVnSElwNVppekJsdGttS3M0dmZrclJZWkFWMklQVmlsMkZVVHkrTlV0ZEdZ?=
 =?utf-8?B?cFgwQTNzTGhvdFgvbzN2aVpvRjRHNU9Yei9IbHNwdGt4WHRGZVRlZ1NDeEFD?=
 =?utf-8?B?YTVzejNRNDhvaCt2TzhEeUNScmtFSnpMaGxrUXl4VDVvUDg3eUN1bER4MURp?=
 =?utf-8?B?QTc0TlpGZmIyZU5TLzVGZ2dLL0FwUWxuSFFZcFFoUUZYc0krTExlUzk2bjFv?=
 =?utf-8?B?TnpjMHJWZ3M1NDcyekt5TFVkR2FhamVvc21tc1QrbkFDcU01Skd2QlV2dzlp?=
 =?utf-8?B?TVBZR0h1b2k3V0pTU25GSHE1R1RCalpRcW9lajVsZnorUzVKamdEYURNZWlk?=
 =?utf-8?B?VHZXQWlULzZFaCtWQTdtRHNreTRoWEN5VDFMK0k1QWJ1U3h6enc4VDdmMm1o?=
 =?utf-8?B?eFlWY3ZFVERDaGVTbk14ajR2YkR3VVZuem9SZUh4MEg0YzhSRlJkTE9yZkt6?=
 =?utf-8?B?bmRWZmdXNXl4M1VlMllhdy9ZMXU3Y2pEaVp4YldYcWFUQmZsc2VHc0IrVmhT?=
 =?utf-8?B?TlJpRGhmTStVWjgzUmJGczFnVFMyR21zREh2bWtxZERhSy9MeENaV0M5d3lS?=
 =?utf-8?B?aUVSVE93SUgvRTJ2dW90RFkrY2RYT1Ryckk1aGNJTGlGWlNtRGZiektaWVN1?=
 =?utf-8?B?SmMxMkRYdzNsc2ZhYjZueXRVVUM0Sk1ZbTVyZHFUbnlQSjVsb1B1OS9nK21F?=
 =?utf-8?B?a0FGVDRhVXo2T1h2MG5Ra2xRMmhmRlZ3NEFIck1UNkxmOXVJL2RmVlJpVFR0?=
 =?utf-8?B?ZU9TVTk5ZzMycjQ1NFZ3Ry9icUJzMmErT2piWEFqak01R2p1ZEpKclpiYzlx?=
 =?utf-8?B?Zm9HckR6c2hmNkRJajBuSEFxejFhT3BUa0dVZWh4bGZtSkFQNXBJb2dzWU5t?=
 =?utf-8?B?SnRjS2lUOE5RMS8ra1g2OGg3R05Mdk00dE1laEYwd1JOcVVlSWdlRmdqZStM?=
 =?utf-8?B?cTRCWWhRanRyYmFXRXpGVlpTZXBWY1lLdXVqdHdnbHRnZVM4MzhRdmUrMlo1?=
 =?utf-8?B?OE5kK3dpN0l4T0w2clJuTHdiMmROaVZzSWlnVTFvc2pjMVcwbTkvSk1Qaito?=
 =?utf-8?B?cER2b1hGMUVlcGZKZk1CemJTU2Q0bEkwei9FNlJHdlV2WnNCaFlaL05HTVZo?=
 =?utf-8?B?SGNFSE94eCthcVNsa21STDFpb1VNN3ZLaWtGY2Njd2xsL2ZCUm5hckRoVm03?=
 =?utf-8?B?Tk5MM2RHanNWQ0hMQUVRd1U0UTducXdCdXJXMUhoc3pqRWN5Wm82cXZLOGE5?=
 =?utf-8?B?eVZ1QjczUjN2eUJvRHoyOTJPcTVsRG5vcHQxdHMwOUxWVm5EcWRvOS9Hd1pI?=
 =?utf-8?B?Ry9xNHNac0F5b1h6aXVKMmM4SDh5YXRKT2lmckhTTWNacEdBL05DejdkcmVI?=
 =?utf-8?B?T1BkOHNidXIyWlRxNTdScUl1SEZtZWVMM1JwcGVmOHcyNVVsK3o0OTBQTFZq?=
 =?utf-8?B?NzFFNUllSnNXNFNtekIrN3p2L1J1NDltVlNzd054U3lUNzVLT0VzdGsxdjhv?=
 =?utf-8?B?bnoxTEIrUjFyYWpJakR6YkRvMWlzbDZ0NFAvb0pOTHVwcS9nUi93bllURXN5?=
 =?utf-8?B?NVJZUmppUUdBcldXOG5NNlpNQXdQNVBGWmJ4Nk1QdXNOVnRiZ1VsQ3NrcGFl?=
 =?utf-8?B?aWw3TlhEdUZ4SEh1eGtFdWlLOFE5TzJERjFIZHJHeThKb0RURzhlTmc4VWdj?=
 =?utf-8?Q?b/cdCGXENXFcdh+OFpxGnqKZwdbJmEe57J4qq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	DS10dSGtHKH4wHoNf7bH758Pui7e7nfn8HYZsEVgkDBU0IWEjkNnxCWE/DO/VtPnnuq7ECNYJB3fyaEWhU9/sr26KZY4idsAYZTBPNsKeQHE+a6Fd5f986/Mk6qlKuD8sJovsZX2qv59ncW9yZ0eR/3c1HElljXadpxoBNKCVxDX7pgAfn2Monjg9iaOKyRvD7AK1kHCqXgSg0R2B3GTscMig2lF7LZyTYg02JFyQ1kVyoGAu1NZeBAiNzoorW9XSHeFD1AETpT4Di9W1qTsL/XvA24sgmdBVz1cRiCuemlFkpdfhpg9YDdIt1nx4QP1aONx46VfSUtafyBjZblOSA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A2gxDyoIIWSmarsdteX3dTgVJ8xAGNHiBNaSOK85EGpOESLEyUAvDKjlb0Oj1gWNfy9JVBALfDyYsNFdhza3FSOzASYC+TGfYiGFPI/NyaqwYm1DA/VhKv2YTp2JVg8XwlBjRc7Tpy3H/0ckL7lwnYgSmilS7XMEcijkGZHj0wNN11RtXXFojHTzizdeBNC0pIoa0YrxHJhzysy1vxtWuYJ4ehQoB1u0UAmHoICyhCjxIa+7TSnT/96IZ6fL90boinU7RTNjQXVLd/H143CtMOSfSW5z/YZAMZvDp6oYNMuMVQfYPJUFWmCHTyZP8wkmSlyqdH9dJjq1GrJQL5OswFCJjoh33iz2G6aasVykzqhnu/LsLHFiNg31COXZRyRAbHX6YCidqmRPvc5U8ZXeJmKa/f7bGt4Cnsjkj/4EwuFM4ETyUM89Pbn+O0JGDqoZVtE81gEY1/vm54OXVukqUoWbfT4gfGRMC7owZEdzsDnd4Uyuhp9edcqbfILGZG7dqhrFQmPllYuEjpXIoHJhxCGG4nISUJPC/Akgoo5GZXBqQrfZTumKw7U+ilkiHWrQ7d6uKuFDKQSUVvRtjEqOUMkc6QpY5VAkdL9tYJ+wUNPk4N7NwtWZVOwbx/j4x6bl
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1ebad0-ef4e-4550-26ee-08dec3285420
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 17:31:50.9877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9eraWZ80xtYg//8q4eflr47M64TweeDhSTiOZZDRypTLxVWBCMqepYx1vN3W1FRUdA5FPLj+DTetcX3xe3Paw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR13MB6917
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE3MiBTYWx0ZWRfX6Gk5igQZTVD2
 8UC0dmzuRCkSnVBcX1c2v21h4SRfEEeXgxALjYpgal2fo4eXirfjg9v23VYpA+PiyAeA06+2ppL
 Gkqu5gjPY6k5PeoQJwJyKeFScb3x+PozF9TAhgheISpzJcND2Axes87lqkV6WGMPHlTIBBeMuNy
 VsWOFezYrYoEeTwgCc8PWwPNIq+GbqNHj7qzHFYGWSGGw/Hz+YxxGoawGqAL1gvDZxNpN/2TJhV
 9ZkUJfevnE7IO/g5QfQpVaLwJHSKYvxL5vlkj0xGAVdO288w07jCXydoz1CWKfQV1sMuFg4BVWw
 TEiYwjkj78L+6r1ojZrnD/WxmZSWJ4joovAPU9Jr/D8b7iHr6vWn0/l0+Od+G+aTr13e983qPgJ
 nXyZIBNm9/VYBtBKeppl2JFaVrA4gfSEaKfokdghhQ1OvGht4IXpWUGO3p2XIpkQndNdMdPXyY2
 tjDY1ArQdaQ0IGxXYsg==
X-Proofpoint-ORIG-GUID: 30t-Hn7g8ea_W0egioBj19QeIIcPzZKj
X-Proofpoint-GUID: 30t-Hn7g8ea_W0egioBj19QeIIcPzZKj
X-Authority-Analysis: v=2.4 cv=Nt/htcdJ c=1 sm=1 tr=0 ts=6a23080d cx=c_pps
 a=3RjCkzAZQHL7PUncwJf+GQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KAb5x4SsHD3PzxGk7EmX:22 a=cIyGuqrkuvkXWOl_fzuj:22 a=93Ubh6UdAAAA:8
 a=02hD3WDiEKGFPMP6GBYA:9 a=QEXdDO2ut3YA:10 a=q-6THwuxr82FYj4XiUVi:22
X-Sony-Outbound-GUID: 30t-Hn7g8ea_W0egioBj19QeIIcPzZKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_03,2026-06-05_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sony.com,none];
	R_DKIM_ALLOW(-0.20)[sony.com:s=p1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-295911-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-spdx@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Tim.Bird@sony.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sony.com:from_mime,sony.com:dkim,opensource.org:url,est.tech:email,vger.kernel.org:from_smtp,MW5PR13MB5632.namprd13.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Tim.Bird@sony.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sony.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F10BE64A3AA

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVuZyBRdWFuZyBOZ3V5
ZW4gPHR1bmcucXVhbmcubmd1eWVuQGVzdC50ZWNoPg0KPiA+IENhbiB5b3UgcGxlYXNlIGV4cGxh
aW4gd2h5IHlvdSBiZWxpZXZlIHRoZSBvcmlnaW5hbCBsaWNlbnNlIG9mIFRJUEMgaXMgR1BMLTIu
MCBhbmQgbm90IGR1YWwtbGljZW5zZWQ/DQo+ID4gRG8geW91IGhhdmUgZXZpZGVuY2Ugb3V0c2lk
ZSBvZiB0aGUga2VybmVsIHJlcG9zaXRvcnkgYW5kIGNvbW1pdCBoaXN0b3J5IHRoYXQgeW91IGFy
ZSByZWZlcnJpbmcgdG8/DQo+IA0KPiBJIHJlZmVycmVkIHRvIGh0dHBzOi8vb3BlbnNvdXJjZS5v
cmcvbGljZW5zZS9ic2QtMy1jbGF1c2U6DQo+IFRoZSBmaXJzdCBsaW5lICJDb3B5cmlnaHQgPFlF
QVI+IDxDT1BZUklHSFQgSE9MREVSPiIgZG9lcyBub3Qgc2VlbSBsb29rIGxpa2Ugd2hhdCBkZXNj
cmliZSBpbiBjdXJyZW50IGZpbGVzOg0KPiAiKiBDb3B5cmlnaHQgKGMpIDIwMDQtMjAwNSwgMjAx
MC0yMDExLCBXaW5kIFJpdmVyIFN5c3RlbXMNCj4gICAqIENvcHlyaWdodCAoYykgMjAyMC0yMDIx
LCBSZWQgSGF0IEluYw0KPiAgKiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPiAiDQoNClRoZSBDb3B5
cmlnaHQgbGluZSBpcyBhbGxvd2VkIHRvIGJlIGRpZmZlcmVudC4gIFdoYXQgeW91IHNlZSBvbiB0
aGF0IHdlYiBzaXRlIGlzIGEgdGVtcGxhdGUsDQp3aXRoIHBsYWNlaG9sZGVycyBmb3IgdGhlIHll
YXIgYW5kIGNvcHlyaWdodCBob2xkZXIuDQoNClRha2UgYSBsb29rIGF0OiBMSUNFTlNFUy9wcmVm
ZXJyZWQvQlNELTMtQ2xhdXNlIGluIHRoZSBrZXJuZWwgc291cmNlIHRyZWUuDQpJdCBoYXMgYSBz
aW1pbGFyIHRlbXBsYXRlLCB3aGVyZSB0aGUgeWVhciBhbmQgb3duZXIgb24gdGhlIENvcHlyaWdo
dCBsaW5lIGFyZSBhbGxvd2VkDQp0byBiZSBkaWZmZXJlbnQgZnJvbSBvbmUgZmlsZSB0byBhbm90
aGVyLg0KDQo+IEZ1cnRoZXIgbW9yZSwgR1BMIGlzIG1lbnRpb25lZCBpbiB0aGUgcGFyYWdyYXBo
IG1ha2VzIG1lIHRoaW5rIHRoYXQgaXQgaXMgZm9yIEdQTC0yLjAgbGljZW5zZSBvbmx5Lg0KPiBJ
IG1pZ2h0IGJlIHdyb25nIG9yIG1pc3Mgc29tZSBoaXN0b3J5IG9mIGN1cnJlbnQgaGVhZGVycy4N
Cg0KVGhlIHVzZSBvZiB0aGUgd29yZCAiQWx0ZXJuYXRpdmVseSIgaW4gdGhlIHBhcmFncmFwaCBt
ZW50aW9uaW5nIEdQTCB2ZXJzaW9uIDIgZXN0YWJsaXNoZXMgdGhlDQpkdWFsIGxpY2Vuc2luZyBz
dGF0dXMuDQogLS0gVGltDQoNCj4gDQo+ID4gVGhlIGN1cnJlbnQgdGV4dCBpbiB0aGUgaGVhZGVy
cyBvZiBhbGwgdGhlc2UgZmlsZXMgY29udGFpbnMgdGhlIGZ1bGwsIGV4YWN0IHRleHQgb2YgdGhl
IEJTRC0zLUNsYXVzZQ0KPiA+IGxpY2Vuc2UsIGFsb25nIHdpdGggYSBzdGF0ZW1lbnQgdGhhdCAi
QWx0ZXJuYXRpdmVseSwgdGhpcyBzb2Z0d2FyZSBtYXkgYmUgZGlzdHJpYnV0ZWQgdW5kZXIgdGhl
IHRlcm1zIG9mIHRoZQ0KPiA+IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlICgiR1BMIikgdmVy
c2lvbiAyIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLiIgIFRo
aXMgaGFzDQo+ID4gYmVlbiB0aGUgY2FzZSBzaW5jZSAyMDA2LCB3aGVuIHRoaXMgY29kZSB3YXMg
aW50cm9kdWNlZCBpbnRvIHRoZSBrZXJuZWwgc291cmNlIHRyZWUqLg0KPiANCj4gPiBUaGlzIGlz
IHRoZSBvbmUgb2YgdGhlIG1vc3QgdW5hbWJpZ3VvdXMgY2FzZXMgb2YgZHVhbCBsaWNlbnNpbmcg
SSBoYXZlIGVuY291bnRlcmVkIHdoaWxlIHdvcmtpbmcgb24NCj4gPiB0aGVzZSBTUERYIElEIExp
bmVzLg0KPiAgPiAtLSBUaW0NCj4gDQo+ID4gKiBEZXRhaWxzOg0KPiA+IFBlciBMaW5kb24sIHdv
cmtpbmcgZm9yIEVyaWNzc29uLCBpbnRyb2R1Y2VkIG1vc3Qgb2YgdGhlc2UgZmlsZXMgb24gSmFu
IDIsIDIwMDYsIHdpdGggYSBCU0QtMy1DbGF1c2UNCj4gPiBsaWNlbnNlLiAgTW9zdCBvZiB0aGUg
ZmlsZXMgd2VyZSBpbnRyb2R1Y2VkIHdpdGggY29tbWl0IGI5N2JmM2ZkOGY2YQ0KPiA+IE9uIEph
biAxMSwgMjAwNiwgYSBsaXR0bGUgb3ZlciBhIHdlZWsgbGF0ZXIsIFBlciBjbGFyaWZpZWQgdGhh
dCB0aGUgbGljZW5zZSB3YXMgaW50ZW5kZWQgdG8gYmUgZHVhbCBsaWNlbnNlZCwNCj4gPiBhbmQg
YWRkZWQgdGhlICJBbHRlcm5hdGl2ZWx5Li4uIiBjbGF1c2UuICBUaGlzIHdhcyBpbiBjb21taXQg
OWVhMWZkM2MxYTE1Lg0K

