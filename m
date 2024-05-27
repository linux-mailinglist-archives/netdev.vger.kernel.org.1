Return-Path: <netdev+bounces-98163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B411D8CFD88
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F3A280D18
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865D513A88B;
	Mon, 27 May 2024 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ANGcjx/Z";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ISnTAjZV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E82E3F7;
	Mon, 27 May 2024 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803729; cv=fail; b=NgjJnNtZA19KtXIxaABBn8tVCy5r9/69OiKlmdZuFVCe4PxR6WfVEYLRcKV9D3R1jC9xkGFid6ALSfW5XoDbSAuRz/Xaf1qDIeTtdy3YPT8oeUDnY/S7JCqmSF0sAfKPZi9DWLpB+iBbSLNbdeayyXasgt4/Ptpj/VvCoFqF/MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803729; c=relaxed/simple;
	bh=K8Qz+cmUrYgmNf0w2YD1b1YK38VakqbvOrVHQ4CgAaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D97CJLUCrlS3fL19l0jCGodpNd1ksyc098gul5xuaYz26kXzDNEufU1c6tNzPwot8YIrApO/xIFFC1s11l+xpzqm0vjwew0oVJ9R1T/xdCxJ5ZRJ7x2vxe+a6UUlopJpDj1ZPNBmCs5EYzu3Eu2TQdhuKEXobFiCLtH3QaPADzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ANGcjx/Z; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ISnTAjZV; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716803727; x=1748339727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K8Qz+cmUrYgmNf0w2YD1b1YK38VakqbvOrVHQ4CgAaw=;
  b=ANGcjx/Z34gJf//T4Wpg8y/y0Lyss3ecsH51nivs6/tjdLV5Un/wl14Q
   zajThuVtJL2Gox3oQGfGivaerqca9apcL1/Mcwjfux9P7Uk+ayDbwLeFT
   QlZNKE5QxsV/RzmBLnqdR2cHeNexxbL7ZQjkwtA97msr2GtIstJEdC1pn
   1W936Z41XylIRHfKhQ8fIqbY82WcxKgQBAQ1zmXzwIjgcHVU5U8MrCt0s
   5VcHkmkQ6nbQhhkFmjwqXewBsAdrnDT2SzXptiJSYElmbwngFUeCOC3Mo
   MhA9Wn2oWqpimFCwYwGxKtYmI0NrsCRzHwJ8KRSifqnAj00DN2PL4CEYd
   w==;
X-CSE-ConnectionGUID: Wynlb3B7QSSI5QhCvnsbBw==
X-CSE-MsgGUID: Hm0v0xbnRkCbDB9gBrt6Kg==
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="193776369"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2024 02:55:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 May 2024 02:55:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 27 May 2024 02:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGZ7kr2HG1iV6mvft6EqgISzIOeODHHuXX8ojAceqDAcBEtrMAhKzM3BE8g7ykhAP+km19/EldIMOtD+E2t+IH+cOAkmuFuKFj641Iyk9KYl20O5zHbrUJxEO0aK2x/ZUvXpVMzrgmaZKXjTe1SDIcAsefK3jQ2JXE/ddwAoVFWB/fmE+XSUcNwWPQb5B9Qpc/LOfmIha+mb2JPVwFN96Vlcw0M3bv9v264jSWB101GgbGNz+ddWSNF5dF/TqJLZ/PuasHZQaCu81rNUWqe5t1H4YnUR/LvWAY8iTHVyb9dEAKtu7Tu+ub2F49y7j+DiswZ/4k20+ygliZKVF6hnrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8Qz+cmUrYgmNf0w2YD1b1YK38VakqbvOrVHQ4CgAaw=;
 b=ht71GOW81jU70gBuDU64qwgZ2PlKvHGF0CEAIq7dUKDmIkbXjgr08SH+IqbJRgp6SGtjp3YT6anNUSLk9Nc+L09bLz4ZSVEOAwP0LSsvc8PaRSTZrC7Pp5PUnaaVCoaVGZcKRjkGRliY2MkxUpEc5AhR65qMH5iHli3lVCZjgjEcH5i6K80pw3A26C7+J89ZquHV8/mdNNyQsqW5jsvOJqIWWFM74GhGH+H2BXT1VTKsHHA5v2T1eWfg4C/hcQynzenf5VjCyQh5sPOWe2w1cuALrJnZCCZ2sCaeExmAnlu+gURepU+NhoGHUuprLotMrxBXjLutFJo3FU5mu/drIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Qz+cmUrYgmNf0w2YD1b1YK38VakqbvOrVHQ4CgAaw=;
 b=ISnTAjZVDf4+nbCLl0LAXzgG8n1BG/b68evJE7lQEntyEUi6ABzy7dXW2ntWO9v5V/kgF9UpDBuZ/S9lPHmVN9aAYC67IdyKDon4/38yCI+b3NqUEX4PmKQPuy2431dCATNofDQv24M6xvma0QCC4yZGsyi9B6MXUlp/ZvO5l2FEuoBlB2CywrpKfgLKRPTDO/GnV69duFFAjL94bJ4ntqS28ixsk2+rwAt8LKFq1ICoC92iunGfOU4CSzF6G+FQvRRZKxbcKyOmpCqTg8q7Up85ghswCkA4oHo+7457oRusa6qda3nRcdrqJtHZa2NVIBTmmbC1VCZMCBkXwVD9Tg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 09:54:59 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Mon, 27 May 2024
 09:54:59 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <linux@armlinux.org.uk>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 0/1] phy: microchip_t1s: lan865x rev.b1 support
Thread-Topic: [PATCH net 0/1] phy: microchip_t1s: lan865x rev.b1 support
Thread-Index: AQHarePdJZh+m0FZZ0WCxjUHsxgGEbGmgtyAgARZMAA=
Date: Mon, 27 May 2024 09:54:59 +0000
Message-ID: <97e4c603-319e-4398-9239-7a3b8bdfe88d@microchip.com>
References: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
 <ZlCym64L+T8SIjgt@shell.armlinux.org.uk>
In-Reply-To: <ZlCym64L+T8SIjgt@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|BL3PR11MB6507:EE_
x-ms-office365-filtering-correlation-id: ee99ecd2-fa43-4df3-f7cc-08dc7e331252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TUl6NTU1ZE5UendoYldGam1KZCtLUnRwK1ZFeGN4OE5HR1ZKejgzU1FMc3pG?=
 =?utf-8?B?QnpBZzNiV1ZFeSs1c08vdkI4YmsvUm85U09rSWNOU1dCdlFSZnVDNnJMQVdX?=
 =?utf-8?B?b2FxRkgxL3dPcUduN2c2U0hJU3g2VU11Y0Zpb0Z3cFRlNGhoTUdFaHRnUVpJ?=
 =?utf-8?B?MEtBWnRpSHBCOS9YbVJwUHdDbGQ3RW1lVnU2eFNPbmFqbWR1dk9aMHJtQml5?=
 =?utf-8?B?bjd5ZUo4ZUlQelNGWUM1NHJFUm1YNFpOK2k4SnVxdnhTTkhjUFRjRXMxaUxh?=
 =?utf-8?B?dHRzSTd2VmV0TXFRL3dNeVpURDBJYW0wRGRXdWpEcU0waCswajhxcWczOVlp?=
 =?utf-8?B?TXVoellrdHBVN1RLSk9ZS2gzTW1RdUdoUE9kOHgvTUliQ0puR0lWZTF2RXo5?=
 =?utf-8?B?VVJJeWNHUFM4RzJYbVpUNzhBWXFFZmFZMzcyaE5UWWFINHFhNGVMeGlzUHc5?=
 =?utf-8?B?L1pTODNFLzV2d0I3cE12WjhxZFFMbTBJZGNmUktySVpiUDMyQUh0MWorYUZz?=
 =?utf-8?B?cUZEeUpsdW5MQldpTlF6NDJPNGh6UVovc0NCa0tuZitQYVVUVmJoby9qNTFV?=
 =?utf-8?B?czV0eUlCTmltWnJUVmc2VlY2SUdaM3pyL2MrNGc3YU1LUE9vR0ZUR28rd0FM?=
 =?utf-8?B?YUZYOE42aGhnMVJJYmZBZFVUaEt0OGw3Q2VrTUsrUHlUZHBYY1pKMFp6ZDBS?=
 =?utf-8?B?Z0x3Z0xIMXM2ZnFVRHFNTUQ3NSs1S2FLTkZCdHZENTk1OWxkQTcrV2l0MTJQ?=
 =?utf-8?B?SWlzcHVGdXJ4aGJaaTcxQTFrd0tScFlqSW9WWWFYdERjdCtPazUyMlBhZ1RJ?=
 =?utf-8?B?ZGRlOFhxQWR2dG1wb2gwZU1lRUxCWmxEbVl3ODd1VzdZNGtyWnRlOTh6cVZ0?=
 =?utf-8?B?dVJOcVVzMkZTZmwxQ3pwZGdWREh5ZHJ0bW9WSzNET3ljTEh4T0MyS0RrSjlC?=
 =?utf-8?B?UGl6cERuOW5ja3B3aHZJSm5SVy9oazJvbXJWaFIwMzlSMm1SSjBEQzh6NC8w?=
 =?utf-8?B?eTZiOUZ0VnBsT0trRlZJQ1ZvMFF2SjJKUHF3Ty9VVGZKbWFEaWZndkJoWk1l?=
 =?utf-8?B?ZHVlM0xWY3MvaG5qNDB1ZlhteW83eVkyWngwRDVVUkg5RnBjdlhIRTlLUXF0?=
 =?utf-8?B?dDNFM2gzaTE2aGJ5bEc3RUNFOUFsc053eWVrQ1EzTFZMS2krUGlLTTU3UzZo?=
 =?utf-8?B?MXdUMCs5c2hpWm91MEY2WkMxWmxMYnhldXBqOXVjMlBLeXByZXk1M2ZBVjY5?=
 =?utf-8?B?K1lrSGdOaWkreGEzUFhPMEt5eW5OR0lvcFJNWHhUbWxyNXBXY2lkUW9Qd00w?=
 =?utf-8?B?Z0phejBZLzQzNmdQdnZpK1hwUzBLNWdFMU9SMlVteDVKdzNnV2lWdjhabmcw?=
 =?utf-8?B?YXo2eGxsT2FCdSsvRTNOZ0QyNnpzeEx3WEtrN0JFUG5ZRHJHaVh3OW52dXox?=
 =?utf-8?B?cnRUYXRoaDFVSVdRYXJvTVdmQVV5a2FuMzAxcnJTSkdoc3JjUnd2UGloZXFL?=
 =?utf-8?B?SnlkOGJVdXdIL0djdWxGMldGdUZBdGhlOW1iV2hEdUgzSXNDUURBWXpMMW1H?=
 =?utf-8?B?OWNXRWxSa1hPeG5mOGswT2R5UzNFZmQrZHZmd1d3aU1jRnJCaExhOWRqQ1Q3?=
 =?utf-8?B?VDFNd091ZnpXZDZEclBDNi9oeTdKejF6akxkVGk3OEFFaGE3SDF1R2tteFFB?=
 =?utf-8?B?YXZUZUYrWXBKQ0NWS0FTa25KRGNYd2ZQZ0VLdmxkbUtVSHlkblZjZTNncFFh?=
 =?utf-8?Q?SrZv6NbYEcDflaIOEY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHFyTDM5R1gzaCtZVGdsbXV1Wk9rQXNoeVRDSTBoVWdlSWFqOHJBQ3JGSGpa?=
 =?utf-8?B?TkhjQlhmYnh4eS9MdDFmaWN2TzRBRm4yWlJYV1JZanlRUzJIUklZWVRvM1A5?=
 =?utf-8?B?SWZzRlZhdm51YTF3amVTWXh1K2VZVldqUEhqWllZRWFob21YYkxDRGlCVDRv?=
 =?utf-8?B?aXhZTkNoUDlpaWJRblF0d29tUHhDei9uT3dJVS91M0xvb0RqMGpCOFZ4cWdU?=
 =?utf-8?B?N1hLTjNyWFlQUDQ4emx3RlU1ekxTMnBPeEpuSm1zMk1DSEdlcHpyWTU3Vmww?=
 =?utf-8?B?SlNOeG1OQnlvTVdNRXJVTlpDeHpkcDdvZi9Ddllqb3FiQmNOdHJ5djZMdVBv?=
 =?utf-8?B?VjJtZkFLRlg0Skl3ejVmZUhSWndaNW5iT094WjB3MXF0aTg4d0FhZGlwejRs?=
 =?utf-8?B?TWlGV2xKVGpKUkJSTDZqVzNlN0Y0c1Q2MStwVTJiK2Flb0J0MW9CM2JJOGRL?=
 =?utf-8?B?NHQzaDExUWxjam40KzhSSjNEbWJRUzNMNlA5RnFMNE8yNXpNZHJRNzNXZ3JH?=
 =?utf-8?B?OThQQzRWcjhBZG5Za0tzWkNhdExDdEY1dmkxd3ZDYThqOGxXelRpWUYwaERI?=
 =?utf-8?B?Y2NFUmd4WkZLQmpBemgrc21pY0I3SGdXczR2MHVKWHE5emV0dHlXdWVzSzJU?=
 =?utf-8?B?MlpvQVdzelpsQ1M5bEsvUFF4b2dlZG9HY3ZIQzBQQ2FIU3FURGRtNmJxQTNa?=
 =?utf-8?B?OTJ6NUx1VkxaNlVHNzVTNmJVYWNOK2owTDQxSkRHK0kxdDNuNTY3S1ZlbC9S?=
 =?utf-8?B?dmNLWlNsbE5jeU15QURIelhhRWMxZHkxWjZsRGRkZGd4Qml5U25RN3pTUmdE?=
 =?utf-8?B?VWJ5eUdzemFtQW5EWlRlV1cxaUhWL1BoVHNqcWpoTTdKV0Njd0UxNThOQ0R5?=
 =?utf-8?B?L1BFMDdTNk0ya2Znb2xMRGFlV2ZrdldqWUc4VnNQTG0zNFdMNkR4dEhzcElH?=
 =?utf-8?B?bDViS3dLZ0I2UG1TMHowN3o2RUFoYlViVHJ1NWJFeUordEFUTzRZN0JtRXcx?=
 =?utf-8?B?akxTUWs0NUJRSzJLY1B2aTA3LzhoS01jSVJaMVdYWmV5azVnQUxwWnZ5OFcw?=
 =?utf-8?B?RUY1UFpSd09XdmFMTjVVWjkwT2dRYWExRnh1d05ROEkwcm16elkvWk1TS1Jk?=
 =?utf-8?B?OWdxclNyNGwrVmV5cEtYNVhuVC9PVnNOMGowS3RWeGI3L05sTWExeWppM0tB?=
 =?utf-8?B?bzBBVUMycDVyWWNvajdKOTNUVVZjbkVCSTVPWVY5NXlBQjZuek03Q3V2L1hT?=
 =?utf-8?B?NnRad3J6L3R2VHFUUXVHRnlIWDZhaE9BMlQzN2xUbkdHMThHTVRnVE1XajlI?=
 =?utf-8?B?QkNrelZKTlk2aGx3SVlKT1cyVDg4djlFTEx4aEgvY3VqYWg1L1dHT2ZjL2lz?=
 =?utf-8?B?RTZZZmRFUXJlSDlSa2t0YjkySlA2MDlGMlRmRGxLSXBiYnJjZWM2L3l5STI4?=
 =?utf-8?B?Yi9NSHp4ajFnV2ZyMkUycTE5aUtYck0zaDJheTVoQlFzak1LVnJYcjhvWWM3?=
 =?utf-8?B?TW5QVlJjYmJtaHJYaW1YWW44NUtFamZuRW5DZ0RVbStrcEFaaEUzV2k4Ukhq?=
 =?utf-8?B?M1o4R004cURiODUxRGNoVFhtNEJkSitRNFlNd2NuaUJxVVRkVUVMbTcyWlRE?=
 =?utf-8?B?bjlmNDJJOHptUVJSWWNLa1BiaXNERCtuTnpVWldqMkxmWDdaYUgwWkNBeHFq?=
 =?utf-8?B?TzFqUzVVVGN5eDRXUnlpS1Q3OUQ1Tk5EVnZqYk5tZTNoSG05ZWFVeklWQkMz?=
 =?utf-8?B?VGhoUk9KYU9XSzVITTFjWVVWL01sZEY3SU9FZi8xcFR2SVUvY0dOTW5tQnlh?=
 =?utf-8?B?emF0ME1YYThuY245SjRWUzFYb2RLNXY1MTNYVmxESXpUUmF2bUNpcE1DVDZq?=
 =?utf-8?B?S3hKNE9EaWd3Q1BjTjFpc283OGUxajR2ejZrQ3FndVd3Sk81TVp3NUN1ZG1G?=
 =?utf-8?B?Y0d1bHNwbTJUVEdnS2NLS1pSOGRDcDgwZzBVYkN4MjQ3d3FkR2pIdTI3R1d0?=
 =?utf-8?B?ckxKZWxxV2w3dk5kTU5xbUlFd0l6TmRSODcwaWNjVGgwMmU2NStMakRTQTMx?=
 =?utf-8?B?ZFdPZjdUYWxYcGxDWUVCQjgyY0hybzB4MzU4YTNkOEVFZDgzUzZRODhGTlRJ?=
 =?utf-8?B?bWRkbGhVWUd1VnM2VEhRMld1QnFENGlWL1A1NUZCU3cwVGRDbzcxMHUzbGNh?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CB15D5455F30242A19F4505B2E8B648@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee99ecd2-fa43-4df3-f7cc-08dc7e331252
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 09:54:59.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HD3zp9sksLCUYp/i1na1SFM24J2sC+f2NuOwQC0oVc7GELcO8gVGm+tlCZvUPE+IwbZ33QcthsNwUG3oCTwiFHL0j1UKiGVlblDPI4Vs5sS3fvLawDddX0yYj/Wo4MWq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507

SGksDQoNCk9uIDI0LzA1LzI0IDk6MDAgcG0sIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIE1heSAy
NCwgMjAyNCBhdCAwNDowNzowNVBNICswMjAwLCBSYW3Ds24gTm9yZGluIFJvZHJpZ3VleiB3cm90
ZToNCj4+IEhpLA0KPj4gTGV0IG1lIGZpcnN0IHByZXBlbmQgdGhpcyBzdWJtaXNzaW9uIHdpdGgg
NCBwb2ludHM6DQo+Pg0KPj4gKiB0aGlzIGlzIG5vdCBpbiBhIG1lcmdlLXJlYWR5IHN0YXRlDQo+
PiAqIHNvbWUgY29kZSBoYXMgYmVlbiBjb3BpZWQgZnJvbSB0aGUgb25nb2luZyBvYV90YzYgd29y
ayBieSBQYXJ0aGliYW4NCj4+ICogdGhpcyBoYXMgdG8gaW50ZXJvcCB3aXRoIGNvZGUgbm90IHll
dCBtZXJnZWQgKG9hX3RjNikNCj4+ICogTWljcm9jaGlwIGlzIGxvb2tpbmcgaW50byBpZiByZXYu
YjAgY2FuIHVzZSB0aGUgcmV2LmIxIGluaXQgcHJvY2VkdXJlDQo+Pg0KPj4gVGhlIG9uZ29pbmcg
d29yayBieSBQYXJ0aGliYW4gVmVlcmFzb29yYW4gaXMgcHJvYmFibHkgZ29ubmEgZ2V0IGF0IGxl
YXN0DQo+PiBvbmUgbW9yZSByZXZpc2lvbg0KPj4gKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25l
dGRldi8yMDI0MDQxODEyNTY0OC4zNzI1MjYtMS1QYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9j
aGlwLmNvbS8pDQo+Pg0KPj4gSSdtIHB1Ymxpc2hpbmcgdGhpcyBlYXJseSBhcyBpdCBjb3VsZCBi
ZW5lZml0IHNvbWUgb2YgdGhlIGRpc2N1c3Npb25zIGluDQo+PiB0aGUgb2FfdGM2IHRocmVhZHMs
IGFzIHdlbGwgYXMgZ2l2aW5nIG90aGVyIGRldnMgdGhlIHBvc3NpYmlsaXR5DQo+PiBtYXNzYWdp
bmcgdGhpbmdzIHRvIGEgc3RhdGUgd2hlcmUgdGhleSBjYW4gdXNlIHRoZSByZXYuYjEgY2hpcCAo
cmV2LmIwDQo+PiBpcyBlb2wpLg0KPj4gQW5kIEkgbmVlZCBmZWVkYmFjayBvbiBob3cgdG8gd3Jh
cCB0aGlzIHVwLg0KPj4NCj4+IEZhciBhcyBJIGNhbiB0ZWxsIHRoZSBwaHktZHJpdmVyIGNhbm5v
dCBhY2Nlc3Mgc29tZSBvZiB0aGUgcmVncyBuZWNlc3NhcnkNCj4+IGZvciBwcm9iaW5nIHRoZSBo
YXJkd2FyZSBhbmQgcGVyZm9ybWluZyB0aGUgaW5pdC9maXh1cCB3aXRob3V0IGdvaW5nDQo+PiBv
dmVyIHRoZSBzcGkgaW50ZXJmYWNlLg0KPj4gVGhlIE1NRENUUkwgcmVnaXN0ZXIgKHVzZWQgd2l0
aCBpbmRpcmVjdCBhY2Nlc3MpIGNhbiBhZGRyZXNzDQo+Pg0KPj4gKiBQTUEgLSBtbXMgMw0KPj4g
KiBQQ1MgLSBtbXMgMg0KPj4gKiBWZW5kb3Igc3BlY2lmaWMgLyBQTENBIC0gbW1zIDQNCj4+DQo+
PiBUaGlzIGRyaXZlciBuZWVkcyB0byBhY2Nlc3MgbW1zIChtZW1vcnkgbWFwIHNlbGVlY3RvcikN
Cj4+ICogbWFjIHJlZ2lzdGVycyAtIG1tcyAxLA0KPj4gKiB2ZW5kb3Igc3BlY2lmaWMgLyBQTENB
IC0gbW1zIDQNCj4+ICogdmVuY29yIHNwZWNpZmljIC0gbW1zIDEwDQo+Pg0KPj4gRmFyIGFzIEkg
Y2FuIHRlbGwsIG1tcyAxIGFuZCAxMCBhcmUgb25seSBhY2Nlc3NpYmxlIHZpYSBzcGkuIEluIHRo
ZQ0KPj4gb2FfdGM2IHBhdGNoZXMgdGhpcyBpcyBlbmFibGVkIGJ5IHRoZSBvYV90YzYgZnJhbWV3
b3JrIGJ5IHBvcHVsYXRpbmcgdGhlDQo+PiBtZGlvYnVzLT5yZWFkL3dyaXRlX2M0NSBmdW5jcy4N
Cj4+DQo+PiBJbiBvcmRlciB0byBhY2Nlc3MgYW55IG1tcyBJIG5lZWRlZCBJIGFkZGVkIHRoZSBm
b2xsb3dpbmcgY2hhbmdlIGluIHRoZQ0KPj4gb2FfdGM2LmMgbW9kdWxlDQo+Pg0KPj4gc3RhdGlj
IGludCBvYV90YzZfZ2V0X3BoeV9jNDVfbW1zKGludCBkZXZudW0pDQo+PiAgIHsNCj4+ICsgICAg
ICAgaWYoZGV2bnVtICYgQklUKDMxKSkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2bnVt
ICYgR0VOTUFTSygzMCwgMCk7DQo+Pg0KPj4gV2hpY2ggY29ycmVzcG9uZHMgdG8gdGhlICdtbXMg
fCBCSVQoMzEpJyBzbmlwcGV0cyBpbiB0aGlzIGNvbW1pdCwgdGhpcw0KPj4gaXMgcmVhbGx5IG5v
dCBob3cgdGhpbmdzIHNob3VsZCBiZSBoYW5kbGVkLCBhbmQgSSBuZWVkIGlucHV0IG9uIGhvdyB0
bw0KPj4gcHJvY2VlZCBoZXJlLg0KPiANCj4gU28gaWYgYml0IDMxIG9mIHRoZSBkZXZudW0gaXMg
c2V0LCB0aGVuIHRoZSBvdGhlciBiaXRzIHNwZWNpZnkgdGhlDQo+IE1NUyBpbnN0ZWFkIG9mIHRo
ZSBNTUQuDQo+IA0KPiBJJ20gbm90IHN1cmUgd2Ugd2FudCB0byBvdmVybG9hZCB0aGUgUEhZIGlu
dGVyZmFjZSBpbiB0aGlzIHdheS4gV2UNCj4gaGF2ZSBiZWVuIGRvd24gdGhpcyBwYXRoIGJlZm9y
ZSB3aXRoIHRoZSBNRElPIGJ1cyByZWFkL3dyaXRlIG1ldGhvZHMNCj4gYmVpbmcgdXNlZCBmb3Ig
Ym90aCBDMjIgYW5kIEM0NSBhY2Nlc3NlcywgYW5kIGl0IGNyZWF0ZWQgcHJvYmxlbXMsDQo+IHNv
IEkgZG9uJ3QgdGhpbmsgd2Ugd2FudCB0byByZXBlYXQgdGhhdCBtaXN0YWtlIGJ5IGRvaW5nIHRo
ZSBzYW1lDQo+IHRoaW5nIGhlcmUuDQo+IA0KPiBUaGVyZSdzIGEgY29tbWVudCBpbiB0aGUgb3Jp
Z2luYWwgcGF0Y2hlcyBldGMgYWJvdXQgdGhlIFBIWSBiZWluZw0KPiBkaXNjb3ZlcmVkIHZpYSBD
MjIsIGFuZCB0aGVuIG5vdCB1c2luZyB0aGUgZGlyZWN0IGFjY2Vzc2VzIHRvIHRoZQ0KPiBDNDUg
cmVnaXN0ZXIgc3BhY2UuIEknbSB3b25kZXJpbmcgd2hldGhlciB3ZSBzaG91bGQgc3BsaXQNCj4g
cGh5ZGV2LT5pc19jNDUgdG8gYmUgcGh5ZGV2LT5wcm9iZWRfYzQ1IC8gcGh5ZGV2LT51c2VfYzQ1
Lg0KPiANCj4gVGhlIGZvcm1lciBnZXRzIHVzZWQgZHVyaW5nIGJ1cyBzY2FubmluZyBhbmQgcHJv
YmUgdGltZSB0byBkZXRlcm1pbmUNCj4gaG93IHdlIG1hdGNoIHRoZSBkZXZpY2UgZHJpdmVyIHRv
IHRoZSBwaHlkZXYuIFRoZSBsYXR0ZXIgZ2V0cyB1c2VkDQo+IF9vbmx5XyB0byBkZXRlcm1pbmUg
d2hldGhlciB0aGUgcmVhZC93cml0ZV9tbWQgb3BzIHVzZSBkaXJlY3QgbW9kZQ0KPiBvciBpbmRp
cmVjdCBtb2RlLg0KPiANCj4gQmVmb3JlIHRoZSBkcml2ZXIgcHJvYmUgaXMgY2FsbGVkLCB3ZSBz
aG91bGQgZG86DQo+IA0KPiAgICAgICAgICBwaHlkZXYtPnVzZV9tbWQgPSBwaHlkZXYtPnByb2Jl
ZF9jNDU7DQo+IA0KPiB0byBlbnN1cmUgdGhhdCB0b2RheXMgYmVoYXZpb3VyIGlzIHByZXNlcnZl
ZC4gVGhlbiwgcHJvdmlkZSBhDQo+IGZ1bmN0aW9uLCBtYXliZSwgcGh5X3VzZV9kaXJlY3RfYzQ1
KHBoeWRldikgd2hpY2ggd2lsbCBzZXQgdGhpcw0KPiBwaHlkZXYtPnVzZV9tbWQgZmxhZywgYW5k
IHBoeV91c2VfaW5kaXJlY3RfYzQ1KHBoeWRldikgd2hpY2ggd2lsbA0KPiBjbGVhciBpdC4NCj4g
DQo+IHBoeV91c2VfZGlyZWN0X2M0NSgpIHNob3VsZCBhbHNvIGNoZWNrIHdoZXRoZXIgdGhlIE1E
SU8gYnVzIHRoYXQNCj4gaXMgYXR0YWNoZWQgc3VwcG9ydHMgQzQ1IGFjY2VzcywgYW5kIHJldHVy
biBhbiBlcnJvciBpZiBub3QuDQo+IA0KPiBUaGF0IHdpbGwgZ2l2ZSB5b3UgdGhlIGFiaWxpdHkg
dG8gdXNlIHRoZSBkaXJlY3QgYWNjZXNzIG1ldGhvZA0KPiB3aGVyZSBuZWNlc3NhcnkuDQo+IA0K
PiBUaGVyZSdzIGEgY29tbWVudCBpbiB0aGUgcmVmZXJyZWQgdG8gY29kZToNCj4gDQo+ICsgICAg
ICAgLyogT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4IGNvbXBsaWFuY2UgTUFDLVBIWXMgd2lsbCBo
YXZlIGJvdGggQzIyIGFuZA0KPiArICAgICAgICAqIEM0NSByZWdpc3RlcnMgc3BhY2UuIElmIHRo
ZSBQSFkgaXMgZGlzY292ZXJlZCB2aWEgQzIyIGJ1cyBwcm90b2NvbCBpdA0KPiArICAgICAgICAq
IGFzc3VtZXMgaXQgdXNlcyBDMjIgcHJvdG9jb2wgYW5kIGFsd2F5cyB1c2VzIEMyMiByZWdpc3Rl
cnMgaW5kaXJlY3QNCj4gKyAgICAgICAgKiBhY2Nlc3MgdG8gYWNjZXNzIEM0NSByZWdpc3RlcnMu
IFRoaXMgaXMgYmVjYXVzZSwgd2UgZG9uJ3QgaGF2ZSBhDQo+ICsgICAgICAgICogY2xlYW4gc2Vw
YXJhdGlvbiBiZXR3ZWVuIEMyMi9DNDUgcmVnaXN0ZXIgc3BhY2UgYW5kIEMyMi9DNDUgTURJTyBi
dXMNCj4gKyAgICAgICAgKiBwcm90b2NvbHMuIFJlc3VsdGluZywgUEhZIEM0NSByZWdpc3RlcnMg
ZGlyZWN0IGFjY2VzcyBjYW4ndCBiZSB1c2VkDQo+ICsgICAgICAgICogd2hpY2ggY2FuIHNhdmUg
bXVsdGlwbGUgU1BJIGJ1cyBhY2Nlc3MuIFRvIHN1cHBvcnQgdGhpcyBmZWF0dXJlLCBQSFkNCj4g
KyAgICAgICAgKiBkcml2ZXJzIGNhbiBzZXQgLnJlYWRfbW1kLy53cml0ZV9tbWQgaW4gdGhlIFBI
WSBkcml2ZXIgdG8gY2FsbA0KPiArICAgICAgICAqIC5yZWFkX2M0NS8ud3JpdGVfYzQ1LiBFeDog
ZHJpdmVycy9uZXQvcGh5L21pY3JvY2hpcF90MXMuYw0KPiArICAgICAgICAqLw0KPiANCj4gd2hp
Y2ggSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZC4gSXQgY2xhaW1zIHRoYXQgQzQ1IGRpcmVjdCBh
Y2Nlc3MNCj4gInNhdmVzIiBtdWx0aXBsZSBTUEkgYnVzIGFjY2Vzc2VzLiBIb3dldmVyLCBDNDUg
aW5kaXJlY3QgYWNjZXNzDQpTb3JyeSBmb3IgdGhlIG1pc3VuZGVyc3RhbmRpbmcgaGVyZS4gUHJv
YmFibHkgSSBzaG91bGQgaGF2ZSB1c2VkICJhdm9pZCIgDQppbiB0aGUgcGxhY2Ugb2YgInNhdmUi
IG1pZ2h0IGNsZWFyIHRoZSB0aGluZ3MgcHJvcGVybHkuIFRoZSBpbnRlbnRpb24gb2YgDQp0aGlz
IGNvbW1lbnQgaXMsIFBIWSBDNDUgZGlyZWN0IGFjY2VzcyB3aWxsIGJlIGZhc3RlciB0aGFuIFBI
WSBDNDUgDQppbmRpcmVjdCBhY2Nlc3MgYXMgUEhZIEM0NSBpbmRpcmVjdCBhY2Nlc3MgbmVlZHMg
NCBTUEkgYnVzIGFjY2Vzcy4NCg0KSWYgeW91IGFncmVlLCBJIHdpbGwgY29ycmVjdCBpdCBpbiB0
aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiByZXF1aXJl
czoNCj4gDQo+IDEuIEEgQzIyIHdyaXRlIHRvIHRoZSBNTUQgY29udHJvbCByZWdpc3Rlcg0KPiAy
LiBBIEMyMiB3cml0ZSB0byB0aGUgTU1EIGRhdGEgcmVnaXN0ZXINCj4gMy4gQW5vdGhlciBDMjIg
d3JpdGUgdG8gdGhlIE1NRCBjb250cm9sIHJlZ2lzdGVyDQo+IDQuIEEgYzIyIHJlYWQgb3Igd3Jp
dGUgdG8gYWNjZXNzIHRoZSBhY3R1YWwgZGF0YS4NCj4gDQo+IERvIGZvdXIgQzIyIGJ1cyB0cmFu
c2FjdGlvbnMgb3ZlciBTUEkgcmVxdWlyZSBtb3JlIG9yIGxlc3MgU1BJIGJ1cw0KPiBhY2Nlc3Nl
cyB0aGFuIGEgc2luZ2xlIEM0NSBidXMgdHJhbnNhY3Rpb24gb3ZlciBTUEk/IEkgc3VzcGVjdCBu
b3QsDQo+IHdoaWNoIG1ha2VzIHRoZSBjb21tZW50IGFib3ZlIGZhY3R1YWxseSBpbmNvcnJlY3Qu
DQo+IA0KPiBJZiB3ZSBoYXZlIGRpcmVjdCBDNDUgYWNjZXNzIHdvcmtpbmcsIGRvZXMgdGhhdCBy
ZW1vdmUgdGhlIG5lZWQgdG8NCj4gaGF2ZSB0aGlzIHNwZWNpYWwgYml0LTMxIHRvIHNpZ25hbCBN
TVMgYWNjZXNzIHJlcXVpcmVtZW50Pw0KPiANCj4gVGhhbmtzLg0KPiANCj4gLS0NCj4gUk1LJ3Mg
UGF0Y2ggc3lzdGVtOiBodHRwczovL3d3dy5hcm1saW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNo
ZXMvDQo+IEZUVFAgaXMgaGVyZSEgODBNYnBzIGRvd24gMTBNYnBzIHVwLiBEZWNlbnQgY29ubmVj
dGl2aXR5IGF0IGxhc3QhDQoNCg==

