Return-Path: <netdev+bounces-302007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oNpvOAdKPWpx0wgAu9opvQ
	(envelope-from <netdev+bounces-302007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:32:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCCB6C7155
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:32:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=h+ZR9kak;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302007-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302007-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A9253014225
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5895A26ED25;
	Thu, 25 Jun 2026 15:31:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E20233951
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:31:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401486; cv=none; b=jxU1Hm6MK9BDeRxxwY7vD8Bmw+wE8L7XN3W2QRXNp9TodS7Hm7djGk27vk0kH5yX5mnKohWX27Bq8wA6HFpReVW2Wda1T9oBbyzsKcnS3xQQfLTlWK4s/iropsMV9UD2LGQO9gkx+6ugTBmm/haZtz3MuAqbZxPkmpRidGFmioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401486; c=relaxed/simple;
	bh=5si4HBLOsNBuOQi9ys3UjQuVfKW1Nb5Nh8gHgGsr2Zk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=fs0nRBXSjDEkxE5iO5yRPvhtl0r72M/kkCzkuATS5gv42nJU9HWLO+dbyv30ZUrbhfnH/RwkfHCxtzacE/j5l8+4L8KJi+xGVBZOxyaaMwtdM/sT7VIzbGEfA4NbHt4AlEG6HszsFZAmq4jny47imCYxw5gO9xoiQrPZtVd9Jgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=h+ZR9kak; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1782401484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5si4HBLOsNBuOQi9ys3UjQuVfKW1Nb5Nh8gHgGsr2Zk=;
	b=h+ZR9kak7CdTjkglVFqJysQDj0exdphDM06fVCXxLuN8Ask1kvCNvWBVzDiERwoSE0lh21
	ayz6cIwyK3fRFSnLWENymKDsjHAHhckXPPmHkIAEJWHv/8aUax1QO5cNu35I8MyGQm7Nta
	fz5oADA5Hh4JPtITfru/3DEq5QuIM9YMzQEaCvoi6BbJX0+MxTWPwiXtmc3FYT/mvX9gs/
	ccq3kqE2ykHo0SoLEY+RZVQ+FcbP9O89DlZg1Dkg7BdwrJkiOmABREonnnJQZaAJZlXM0q
	pqiZr7nM6hPnKlVo5W4xjajzi3yzn/gNmePUKnVKSivLiPbKN2ai96MRQiyAlA==
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-57-YB1rcQjZMFCZRyc3vF5kwg-1; Thu,
 25 Jun 2026 08:31:22 -0700
X-MC-Unique: YB1rcQjZMFCZRyc3vF5kwg-1
X-Mimecast-MFC-AGG-ID: YB1rcQjZMFCZRyc3vF5kwg_1782401480
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by CH2PR02MB6823.namprd02.prod.outlook.com (2603:10b6:610:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 15:31:15 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 15:31:15 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Conor.Dooley@microchip.com"
	<Conor.Dooley@microchip.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Topic: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Index: AQHc+e0nFxx0u09WdkC+bo9XNPrS8rZAt0OAgAMGobCABlg+EIABlccAgAAFtTCAA5jlAIAAJzFwgAAJedA=
Date: Thu, 25 Jun 2026 15:31:15 +0000
Message-ID: <CYYPR02MB98285BD6A2639E0B01AE407183EC2@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-1-4533a9e85ce2@onsemi.com>
 <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
 <CYYPR02MB9828CD98EEEB9B218A940E4483E32@CYYPR02MB9828.namprd02.prod.outlook.com>
 <CYYPR02MB9828A1434E6339A6CFCCA74283EF2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <64f4f30e-a987-4289-b36a-1acc977a6764@microchip.com>
 <CYYPR02MB9828E1167750AEA090EC60CD83EE2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <f127837f-e08f-48e0-a3a9-906e1d61d6bb@microchip.com>
 <CYYPR02MB982836BC273D09FD3BDE623583EC2@CYYPR02MB9828.namprd02.prod.outlook.com>
In-Reply-To: <CYYPR02MB982836BC273D09FD3BDE623583EC2@CYYPR02MB9828.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|CH2PR02MB6823:EE_
x-ms-office365-filtering-correlation-id: 92b5fc23-c654-44b5-7557-08ded2cecbd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|4143699003|56012099006|11063799006|22082099003|18002099003|921020|38070700021
x-microsoft-antispam-message-info: NUw5DV+hkLKp3xSJSq9nirUPwXCPzIT6md4+dbXZHVufAdLP453kh/xebwiTpudBx5U3Tf6/RuDjykMXU1sA8KYHQ8kRlWzxvSzjEIyeyTaLmNtNNsXuJthbswfwRtXz5D5tiiPOcO5i9nNyttSVQl8R/PbvberwyPghbpYEyyly51zVwzAi4SCVvW3A4kFhAp+3zUHoez8G8G6lSCqB42/Ifga/LFGrhZIeKBKn9R3HivKFGeKPzyApoKjnwSl5/sYTNPDkGsvTp7vy5d1ifuiF8x6z9tsvcO2G6xdJ6quVzjOpFttVKaQQtKzDE+gh/9Ezr3G3zYlLXKk/wFCUa78lQLoFP8fHSJksiQSrgVW5eSY53VJL6tzgLf5vLbDK1HUKYK77AHOnAO0apdEWTkufDTDgV1UrHhf9E1o9NgpS3FNKgRIjPJY3fz18RmoWtqcBjiyG0GjcAygTukERM1L7q/aZISk9Xm98vqqceB1sy7qQDOUOP4/9r3gR608AP+W3Cvh6ICLPn6Ogj1FoIIn3uK+020uJT2Qp61MY/V8hVL1cPkzPG58+hQpiwVTYY3HhBIovNJNi6UgARHEK21hNEJD9/DFbm4m+97NMjpR8ZmPJ4hvRp8qbKXMwNBZgGWgUF9WPQOUbc8SEPCNJYKTFbZ+PYvbg2hCaZXuu6bn00NVA5WtNcNGyDElBfxmMkbivJo/+M8HlFH7HR8xZQmU6NN6sN/XVocrvhwu5QtkozG/dWlFIbZUxdNdhYMXK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(921020)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHFIVzAzTE9KcXEydWFjVGw5MVFaV3hETmlXdXhsWmd0bTBmdWRGTG9QRERZ?=
 =?utf-8?B?N3hPYWViMWhPWHVreVp1ZmZpVFlPaFNtcHNLanVZMSsyZUdzK0pLSmVTOHEr?=
 =?utf-8?B?YjJ4T2tQTnhzWWJEK3dpeTMxV0dKZXVvRVJ3UXY2cWJFM2hwdVovbWZkZkRj?=
 =?utf-8?B?SHBMNHcxWmNIZ3lzYXlKNHNRcEVPNFNPa2xMSSthUFBobHRXUFVXaVZtOWps?=
 =?utf-8?B?cFpBeS9Qdk5XeExyWTZuRXN0b1AxNFd3M1FvNU9rRmVrY1NweldOVzh6aWNT?=
 =?utf-8?B?Z3JnQkFNZ3hjdlVtQ0lKZ0RaV3ZzbkdPbHB1YThrM0pDa0ZwMUF3WDBobDZl?=
 =?utf-8?B?K2YwNEZHdEtoSWNoR0dJcDZOcFN6Vy8zcGxiQ0FTUm9rTm5nNDdnTmpCTmtW?=
 =?utf-8?B?NzdaMGRmYUlCQjJULzIyNVBDQzM3QWxRUzRxNWVtVWtmcWhlOUtEVmZrQ3ZY?=
 =?utf-8?B?bk1jcTVjcWNaV2hDVVprZnB0SWhuWmNNYVNDUW5FQk45cDJ3TVBMZS9wSFNR?=
 =?utf-8?B?aDJKNGg5S291VmJKNXNBTzhPbU5lNklLMjdzSVRablBrU0t1TXNFZnpKM09E?=
 =?utf-8?B?dVRNYklGMUU5QlVRclhzWlBtMGhIeTNCaGQyVitCcHdWa28rWVVUNzhueWhY?=
 =?utf-8?B?SGZqemswUzJxUnNPOWZVMy8xbTlZK3o0czBNbjBhajMrUHBqR1RNdmx4VjNZ?=
 =?utf-8?B?YzN6VFFNY3U3ZFVsN1JVM1NvYy9FWGtnbGcvTjE1eHYrazlQM1duU3NLL0hD?=
 =?utf-8?B?RmRLT25CY1I4N3lVOVRXNEtSbnZpYWFTcGtNMWxYNFJLS1ZRTW0yNFpLUlNT?=
 =?utf-8?B?SndxQWFaYVVGM0pzN2RLcDE0RUlmN0R5VkcyKzd0T1hESm9PL28xWnA3ZkZa?=
 =?utf-8?B?a0VSYnBSVnZKZENQelRBcncycUtyaWp5V1BkR3lLODYyKzFQeUFyeXRGRHFy?=
 =?utf-8?B?eDB4ZjZWVERySThZT0hEN1lub1pXOWRZVGRTS2U0Mnpzd0kzbk5VSDZSYkRV?=
 =?utf-8?B?L0Q4a29FU0Z6UVQ0L0Zsazd6Nk8vdmJYaWdrNE9aZkEvOXZTMGhocTlLMEJu?=
 =?utf-8?B?S0lmTlNkdmdTVDNNV1VWUEdPUUZCTUl5b0VmVFdsQkl5Um50SUdEMlI2VEtN?=
 =?utf-8?B?M3I3VlZtdFhMVi9KcTgrSk5INXFqVGZTTmYvRFpJNFBmd2NaMkJNVHAvVnhs?=
 =?utf-8?B?V0g2bE0wMWlXajdyTkhwVWRpUkpXQlIrMDZGaEQ4QzB6bVpHQTdMN3hCdWFM?=
 =?utf-8?B?eEhib1FBR2h3OFlSQUg2d1RmcGZjVm82b2NKazJNaE05VlBlRElFVkZqamZE?=
 =?utf-8?B?RkRldDd1bXpyUndFQW9aSE9GMHBDdVlVcEtmT3B1T2diNmFKc0MzVWQwQ0V5?=
 =?utf-8?B?a1VmQ1pidm9aamFXN1RKQzFSMlhkVUZjbjExQldPdU9mSmpmdkVNYnIzNjZR?=
 =?utf-8?B?eWxabG5hRWx0WkRvUDQ5OWptdnpoQ2d6TDVXa2tnWk9ZQmRmdU9yTnFRNVFw?=
 =?utf-8?B?WWVXcWdROGdyelJ4cU92Y2hhcWhDUlVtTTRqcDBJM0x2S3N6eHhYNFNuNHkw?=
 =?utf-8?B?K0RGUXdoaVQ5TFloOFhLc2pCU0NRcnNiRnZYKy9pczArVEwzN2x2ODVreEJZ?=
 =?utf-8?B?MGFCay9HQmNFSlRrRkorUmkzRENQTVU0b3BqWWsrbTI0N0k1MHNJVkNEYlFE?=
 =?utf-8?B?WU9rWG9lSENwL1BRSUF6N1pMMzJQT05WMU9KOWRSdnRFS2M5eEx0UHM0T1B0?=
 =?utf-8?B?TGc5TWF1MC81QWlvc2Q2M3JtdUtQNHJyL0pFSFBDN05xRkZxaG5VZklucWJn?=
 =?utf-8?B?K3h4TkMzVnNjYXF6aGtUQ2RYRVpyTlJZbXZFS09xRm9SUjNZUEhPcVFBa1Np?=
 =?utf-8?B?Mk40ckNHeHpjSVU2Q2JObDl4bThVdlhKZ2J5eUo5TkE3RjlsVVdzK0l2VGxI?=
 =?utf-8?B?azF6M2NSdHpOUHhocXlZN1BaR0dqUVM2cG8yODNldTNrYUdHQThmNWdYU3NW?=
 =?utf-8?B?amNxWGQ0SFFEN3FoaTArcTBqZ05mWmxZRHk3SjZEbnFheWEvcVZkbVZMY2k3?=
 =?utf-8?B?WGNqNUtiOGE5UmdUWG5GTEhDRVFYQVZBcy9aTkVvMGNhZTZReFRyVWxnMmpL?=
 =?utf-8?B?dVZydDg1Vkh2eXU2UndGVlZNVGRVQXlqclplZlBOQVk2VlVpL1Fva0VtYUx4?=
 =?utf-8?B?dDhTSTVhUm1TUnhiYkNxQ1ZuTjBTMWZ1Ykk4UUpNUDV6TlE4NmZ6eXdRUzVk?=
 =?utf-8?B?eVJTeDNMWHJmbmF3K2pUcmlCOHAzUlZlb21CTEFQSTZPUjRESzhUWlJNTU5i?=
 =?utf-8?B?U2ZTcldnNXJHb1VHVllHUGJEVVc2VkJKRjhMdXh5VXFjUjBwc0xXU283bWlX?=
 =?utf-8?Q?jl3h57ud6bROqLU4=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bUu5FwNHGIy7Vcy+uA3KFAt687eZKhKukb/MSAfd+BnEo/kHQzJ0Eaol3F7Bj5ZG4c/XeIEjDyfDSfDwOogJivPRZKfFOs+lQBOW0r8YNQH4kGKY0SVKeLyNhYsdNdsd4qGIP1CN7SsAZOsmoVvtStNQ6o07TQd1LqdMK7XF0pz1ycUJ5z3MJ5gNFqFniUHi9emPRayMCzYx06BdU+IZbUu+ukuSsEHQ6Y1QwFiJPjKbBm6QBnJocT1g7LlU370DN+lMfRI47kpk+vP3OEzMZxxFeLjvBWXVonFk/iNEaCes+9T4lTsiIJoWlhQ/dFQIuWa66a2doRoWrGbq/vKS1w==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b5fc23-c654-44b5-7557-08ded2cecbd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 15:31:15.7270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtrkVOVCOO4VcWsNYy/H0ftKRNkQxI1PSxqYq18/t9sPqq+/lLGS3pBIPvTCilAoaFUQBPFNiOVdSEiFqhzY2OXbNwZNsTEmbGBM6RO/LJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6823
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VRAse8oNPEjjgPP7FYisb65LKEfV8gN7qyeQHyXVbX8_1782401480
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302007-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:dkim,onsemi.com:from_mime,vger.kernel.org:from_smtp,CYYPR02MB9828.namprd02.prod.outlook.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBCCB6C7155

UGFydGhpYmFuLA0KDQpMZXQgbWUga25vdyBpZiB5b3UgcHJlZmVyIHVwZGF0aW5nIHRoZSBwYXRj
aHNldC4gSSBjZXJ0YWlubHkgcHJlZmVyIGFkZGluZyBhIE5VTEwgY2hlY2sgDQpJbiBvYV90YzZf
dXBkYXRlX3J4X3NrYiBmdW5jdGlvbi4NCg0KDQo+IA0KPiBSb290IGNhdXNlIHNlZW1zIHRvIGJl
IHNhbWUuIFdoZW4gb2FfdGM2X3VwZGF0ZV9yeF9za2IgZnVuY3Rpb24gaXMgY2FsbGVkLCB0YzYt
DQo+ID5yeF9za2INCj4gc2VlbXMgdG8gYmUgTlVMTCwgd2hpY2ggbWF5IG1lYW4sIGNvbnRyb2xs
ZXIgc2VlbXMgdG8gYmUgbm90IGdldHRpbmcgc3RhcnQNCj4gDQo+IEkgaGF2ZSBhIHRoZW9yeS4g
TG9vayBhdCBsaW5lICM5MzMuIFdlIGhhdmUgdGhlIGZvbGxvd2luZyBjb21tZW50LiBJIGFtIHN1
cmUgdGhpcyBjb3VsZA0KPiBiZSB0cnVlDQo+IGZvciB0aGUgY2FsbCB0byBvYV90YzZfcHJjc19y
eF9mcmFtZV9lbmQgYXQgbGluZSAjOTI2IG9yIG9hX3RjNl9wcmNzX29uZ29pbmdfcnhfZnJhbWUN
Cj4gYXQgbGluZSAjOTUwLg0KPiAgICAgICAgICAgICAgICAvKiBBZnRlciByeCBidWZmZXIgb3Zl
cmZsb3cgZXJyb3IgcmVjZWl2ZWQsIHRoZXJlIG1pZ2h0IGJlIGENCj4gICAgICAgICAgICAgICAg
ICAqIHBvc3NpYmlsaXR5IG9mIGdldHRpbmcgYW4gZW5kIHZhbGlkIG9mIGEgcHJldmlvdXNseQ0K
PiAgICAgICAgICAgICAgICAgICogaW5jb21wbGV0ZSByeCBmcmFtZSBhbG9uZyB3aXRoIHRoZSBu
ZXcgcnggZnJhbWUgc3RhcnQgdmFsaWQuDQo+ICAgICAgICAgICAgICAgICAgKi8NCj4gDQoNCg==


