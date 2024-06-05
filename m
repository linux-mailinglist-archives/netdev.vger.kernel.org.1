Return-Path: <netdev+bounces-101034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784708FD010
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DD9298726
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47705194A7F;
	Wed,  5 Jun 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ImoG8Nkj";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qugBOabC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC3518FDBF
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594731; cv=fail; b=p5rpIJEsRRoMaZ/8zbJwPfjvO2mmdQ3B6SYpxe+QYHX9fTigdNcFxJOLTlzX7euEI2XQFi+VEJDM38CjE4lZGzN64mJhRTCviK1oo4LxWZp3/GGF1r1/e4QOtiUE0h7ZIvHSNPPID3F2ZiioSb5FPXQNnGFDbJ3iX0X0PpveP+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594731; c=relaxed/simple;
	bh=0BTwMfkKCcfvD0idgzF4d3f6FF2YXTrYGxAMEgE7knQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBRkLptKZXLf5Ze+Cg7crM8PF+OGREr/l6j0LgtEzUGCZKelh0aVZpdIkTpDi+RB06wH56PWtqGc5swMhA2Iyksx4fMGRlUR/BlscqtEpIWlx/e7imhbcgCGpqMYtbu/4DYxP5hcb/BVVQJxNauPKP7sg9N0EvfJ/wao0QyuH4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ImoG8Nkj; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qugBOabC; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717594728; x=1749130728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0BTwMfkKCcfvD0idgzF4d3f6FF2YXTrYGxAMEgE7knQ=;
  b=ImoG8Nkjf2lhR1ZlDHHzfM3r00ltV0P3Yz0hkOQkmzZx+0T6nrWpL6+R
   RXaNww2IjhgYg5zL5GmXGvxM4noRPEVOpG6A1ICFf4BpzS6i88zKOVbs0
   tS2bB8BxnvD1GtM+SVZ3eDDTFWXzkKnKBUb11dyDU+rghlscdp/SdkqTV
   iDIx8e5et7crsOdwCn6s++YeOmRYDYuiQGtttWl+S+e8rXqLPR92Jbvd/
   iEs9nfWW0jo4p1z6ctqxQPgxNp5adcEvWdwIDlyg9oLfeO9qLnOObKla6
   FH2+FtBGGS3p1+Qti8THh9nTdURWeUMMyeqlNan+m3/A9B0s1T3t9GABX
   A==;
X-CSE-ConnectionGUID: Af9ZPE+FQ7GD+QcxeOd+NA==
X-CSE-MsgGUID: 36rhm05PS02u65u9MqANjw==
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="27013760"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2024 06:37:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Jun 2024 06:37:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 5 Jun 2024 06:37:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7lyfFukXUWrlx7ovkI880Hsfs8LNUXKMzHYyobrLj5/wTFxMj97Mc2yF4LbLapaTl7oWLMhYeNrtnQQ9EM/4Tnh2JRbh7jVTH854cH72fyqy2NtWRh0MEkSEhwkkTJ+4Sv9TXnwilhkwIQKlbAdJL3gKezFpVeHdYjKcCTnOyOKRuOGla1CZy8Lpc6FtxMwi07fr5kNStRQ6Fa3mUClZUXwUxRxLBeBHDvS1DmgPQYketgU5xw6wda+55X2I7PdAM+3XPVQt5Zg9NcJgXLC59cKQhvx4hykUGMwD20m/ZN9MNeU8B7L0fvIcfIwk/7Zl+GTbtKNo69VNe0LTtLycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BTwMfkKCcfvD0idgzF4d3f6FF2YXTrYGxAMEgE7knQ=;
 b=cFsAlbZHKMP06Bu8cbw81NcnPq/ZkiM9zKluWYO6J74nQ3CU1smNGZnxdQpIDlg94tHgmEqrBf5axobx0e0oxSf2610uNWH0y95VLR9bg2FhrGTnKbwoowhVc0GyYDE4pdqh9ljBWj+zjjROBc8mNN8Szkgh335WVtt9x0ByHVcBgoXQkgx0Anp+pQzu6e37Qa4PUYB78uLTNxy8By2W955We4E8I+1dH2Slpuy6DGrqY4I3Sx6XvIn4il/sHA8/aiKqgpO/mMFWMhyHuh3fX3+GRhMh8ysYc4BsIyQQX+QUuhumRbM4gjjO4b9Xu5Dz5Yrmr5z61Meb9dYtxa1Fkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BTwMfkKCcfvD0idgzF4d3f6FF2YXTrYGxAMEgE7knQ=;
 b=qugBOabCrnHe07opvCcbST5juoDyABjrL6/W9OViAlWGCTY8ppxb7bgyKzYkovQTHu1Vsweuc8n//LIJ4QCiX8+OvU6x5j5KJTp/roJKg2K62UA2PLNvR0kcIw8NypuMx5mnXqV5wcWrclYNqpTIBGtn+JcKe3qpUuC7dtrdtLYYnYu9StoQspIAnNh090pN8NaweygbTqJd0OFsUafk5I1tIIp7QI9fFK7VSGEgWhbH5cGrClxhVK1WHCGsGOcTiJmS6fBwRppEBw/ehVGKQSPRFUq3QeG3lC+yFIs1ypV3p7M7/CPN/iOnGRTA7+h1fVl2od4naZNl1Vo7Z8o9Gg==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by CO1PR11MB4785.namprd11.prod.outlook.com (2603:10b6:303:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 13:37:28 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 13:37:28 +0000
From: <Woojung.Huh@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <horms@kernel.org>,
	<Tristram.Ha@microchip.com>, <Arun.Ramadoss@microchip.com>,
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
Thread-Topic: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
Thread-Index: AQHatmECha3DGgOR9Uuf/GUr++OEXrG4D3PQgADJ54CAAFQY4A==
Date: Wed, 5 Jun 2024 13:37:27 +0000
Message-ID: <BL0PR11MB2913735D479B97241D0AF2AEE7F92@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240604092304.314636-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <BL0PR11MB2913D8FC28BA3569FDADD4A7E7F82@BL0PR11MB2913.namprd11.prod.outlook.com>
 <19eef958-5222-4663-bd94-5a5fb3d65caf@savoirfairelinux.com>
In-Reply-To: <19eef958-5222-4663-bd94-5a5fb3d65caf@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|CO1PR11MB4785:EE_
x-ms-office365-filtering-correlation-id: a1ff827c-1776-4e2b-10cf-08dc8564a451
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UGhmUXRUTlpmOENKY1huek1MOWt1b3p2cmZqaU0yTGprTlRiTzNOZFNBTit5?=
 =?utf-8?B?SndYT3FQcG9oSEc4eEtwR0I0cHpiODR6ZVkrQmRXTnVTcEk0eHVxSmVlYngz?=
 =?utf-8?B?Sk9XbmxTWTAwVlU4NGx0NHJ2cmdiRll1bjJSZWNGdU0rS1hqc2I5S1dGZ1Fs?=
 =?utf-8?B?Y2t3UWpDcWU3WkJERmNPei9ndmpQOWdMa3ZxQXpuUzdmYmY1U3MzeFhDMVgv?=
 =?utf-8?B?ZkdLejF3NEM4YnlqOGtPd3BrOElPOXRGdTk2N201Q1plNDQxSlFkVlZWN0dG?=
 =?utf-8?B?UTZxTk9pczJKRzZSenYvSGNJQ2pENmZQaVRybVpDeGhqUVcxbHZ6MEdQWnlJ?=
 =?utf-8?B?a0gvYTZaYnI4K1dXNTdRbE1Ka0l0a3JQeXdwOUZVcW1obE9iQjUwZ3E5SUdW?=
 =?utf-8?B?OWJZWDFTamJtcTNPUEdzVVd3aTdMN3N6bmJ0WU1nMnY0d0lERE5xTTVqbitW?=
 =?utf-8?B?aGUrd0xXb2w3dVRHRUxvNEdLZ2o4ZWJMWkdKZ3BRcWk3WURxM2ZVYUU2TmVL?=
 =?utf-8?B?bHVhRWVtb2p0L0Y1QmpQVGRIeW1NTDh3NWo2ZUdid1A2dFpCRGJOVGF6OGZP?=
 =?utf-8?B?TVV5dEFQaVg1OUdTWXZxNDROL29IanBrN1hxdkl1UWwrR2VBbGU2a3ZFM3Nk?=
 =?utf-8?B?N3FQZ1hickhFdUFidlUzUFp2OU80YzZxeSs4M3JFNkFqclc5SW9YQkRNUC9R?=
 =?utf-8?B?NGxvd204UERHUEVyblpkcUZyd2RkVngrdTU3ZzRXUWNhb3YvbHFOT3F1d1ZN?=
 =?utf-8?B?blpjWjZXU21XeGJHTWNJMGZnMlpmdm1uSlpwUm51elAwQkMwLzMrYTlaUjRt?=
 =?utf-8?B?RzBmTVhzMFhxREZFQlhmZERlZCsyWGVBSkx5SkZBdldJbUorZXZmR1JnREda?=
 =?utf-8?B?dmRtUVVKczhxQ1BVTkpmS0JsS2R4bzJMMElGKytGbld1UXpHeXd5RGdNOTVt?=
 =?utf-8?B?ZjBzakZQd01YRTZNME9LK25rU0RjbnRuUmhnNURzN1dFY0ZNRncwcEFjQnF3?=
 =?utf-8?B?R1ZyRzd2WDIwakFZT0dScGpUaDJib2xNSG5lRGhFZmlvYjVBNVJtSHpNMDFE?=
 =?utf-8?B?T29ZQ3dhdmlOOXEzeWQrbGZNNTdBRG8rM1ZNMStrVHRtU3lSVXp4T2d0bFlp?=
 =?utf-8?B?b29lWk5VN0tCM0ZUS29LTWw0dnlDSjBmc2tkTmsvNm5jZUM5Q1dtQzBmR3Zu?=
 =?utf-8?B?cGVFRkF4dWVsMUcyb0U3empkMkRWelRSRlhvZUpTUGMxQXhFaXJ6U0FzY29u?=
 =?utf-8?B?WEU5YVhzNEw0dUlUVzZDVHpZcDBDbTVxdjB2cjlTcHpPc1Fadm9GMk5NQ0dR?=
 =?utf-8?B?ZFZYU0MzWG9JTm9abnRKWitOMmk3OFVtZVNybzdUeDlGK3NJZmkvRTJxMlln?=
 =?utf-8?B?eElvWEJVV3NWZWExd09WbENCb3FINXI3RGpyaFptRW5RZGh6d2oxNjVmaWdY?=
 =?utf-8?B?UU9FWGE5U1poeGdweUFVVXlMVm80TW5WbW5PaGNuOGxNWGhhdzI5TUlQb2xJ?=
 =?utf-8?B?UlFmYXozYitmQ2ppYlhTTEhuZ3Jkaldld3JIVGZMaDAzeU1pWm9Pem9UM1Vp?=
 =?utf-8?B?UDhFVU42Z1RMUldVYTNOOUVmNmlyUVN3UVNNUmwvSFJjaXBvZ3NwV0NCSWtS?=
 =?utf-8?B?L3NNK2dndk81bEdvbmU1UjJEL2RZVkpwVjNXWFNpT2tLd2pKcHNndmFrb2ZM?=
 =?utf-8?B?V2JNeENJNFNQRkh3MTNVdzNxTkpwMTJCWjN4bVpnaGhYbnVBb3V0QjJWTzBj?=
 =?utf-8?Q?PlkTyjNecowcVj/0d8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDN3enVSb09Va0FnY2NzSFl6MDZ3S2VOZSsxSVlCdWJSWjNqYWNIZEx2VWJU?=
 =?utf-8?B?eTlLd0lnVVhnZlp2QmdieHk0anFRcVE1Nkkvcy9hQ3VIZFQzVThNR1FZLzBU?=
 =?utf-8?B?a2dRS0RNcXRlbnlGZkUyTFRvZkpYWGdEeFFhMDBZQ2pvS0xaUkh5YVZjSWVh?=
 =?utf-8?B?VGZOQmhsNGVjemxDVCtqdUFncWgxeWZwblErWkV5QUtSdVdrUEVHd1lJSFZu?=
 =?utf-8?B?YkNpQUExelE0MnB3Zy9Ra1pxWm5IVzI4OVdJa1p3VHRORDVuN3ZIcVBiaFZT?=
 =?utf-8?B?N0lkYUd2b2FkZVB1UThSdVRWUU9KODhBRkNRYmd3bkRRL29wQW5NQkhpSmRj?=
 =?utf-8?B?eUthUSttRERqSDJGcklhS2NRZHo4Q3lIZDY0bXhHVjIvclExVGJUQWF4MnJw?=
 =?utf-8?B?OXV1bTVtanNrN3ZDcWhxWmR2WEFIQXJRVEdlWE5nUDZGZVJnVVlDUFZrcFFz?=
 =?utf-8?B?UTRISlp3NzRlK0IxV0ZmRXZqWENLSStEYWpJQlRZUUU5eWRVcTJaY2RRTUxy?=
 =?utf-8?B?STVESzlpRjhrbmVFaFBFcGhtS1ZheVRaVGxOOWRrQURNTGJRVDN6aTRIa3FR?=
 =?utf-8?B?RC9lcmNqMVM1L25JV2haQmlDVjdrQzF6a3loOFgwSUZKdTZyRzR3cDlzb3Vm?=
 =?utf-8?B?c3VSUURrZzQwMHloZDVCNGZsNGxvKzl5N2xVWUxXeXRiMDRzeUVJU0pua1dx?=
 =?utf-8?B?VnoybklOc1ZyTHZ3c0orTzhlSkNlQ3pvK2tkMGhGcUpmeTEyaENzRUtIeUM5?=
 =?utf-8?B?Y05xYXlyYVQvekpYRjlsSndwWGt6L2d5WG9heGYxMThoQ2t6bDZsbGtVTU9V?=
 =?utf-8?B?S21mVllwWkZiVVAwTis5cUJpMFdnemduZnlNSlk5djJ0cUhmdWZZTVdQQnJU?=
 =?utf-8?B?Z2RZUkVYcnFQcXArdmlROXh0ZU1jUXhlcEtORkZLam9kdlJtNTdPeWtxbmRx?=
 =?utf-8?B?TjZRSDlUZzhZdklVV3pnZkJ3cFlUdFcxTk5pU2p3aHIyeVE4V3Fwdm5zSmNK?=
 =?utf-8?B?Sk1lelBldmdvSGtrSHRnbmVEK2IwWWdOKzMvbHVQUEpCZXBsUk9haGtRVFZi?=
 =?utf-8?B?M2pqRk9HNDNvRUZFeTNUVkxDWXFFOUIwbEloRlhsMjc5TFRRdXpyemk2aTkz?=
 =?utf-8?B?bTRZRkZTdG1rYmNEMHY2R0JQOWF0aVRxempZQTU5bW1MdEJTTU5WdW1DbUln?=
 =?utf-8?B?RittbU5zbFV6alVLazVJd3lxQVh4aWxQRDhVRUNUMW1kTVVxd2J0UDJ1L2NR?=
 =?utf-8?B?ODdhM1JEUktRazBVWStyd24zai9Lbi9pRGlqdzJFWWkvU0dxSDlvc0tDV3dX?=
 =?utf-8?B?UnNVTFhSbDFDWEkyN0dIdktrQVo2YWhVVUlUWFUrMlRxWjhOWkVsR0JGSWVV?=
 =?utf-8?B?dUVjSDYxT1RRakV4cWdqcHNybStYay91RlhDS05PY1FMYnZDbkxDTWZxQnVZ?=
 =?utf-8?B?RmVWMytOT1EzbGtkR21VMHNlR2hWVFVVVTVzRkZoakVHeENLQU1aSzVsNWps?=
 =?utf-8?B?SHFOSmFnYTR2ZDN6SmdTL2daZFhZcTJTVXpNMW1kNm12UE8ydSs5eWFVTWsy?=
 =?utf-8?B?eFhRanhseWJlQldoLy9ibEpCZndwT0VkNzNXMG5YbUxjbE1ybGdDNTFhVm40?=
 =?utf-8?B?aGtyWXlMRWVGb2R5UFlhdDZzLzI3TFJKcHF6TGRXSzZZSXgwOWhNWkhaUHEy?=
 =?utf-8?B?ZmU4Ynd1dENNQlFyMUZYMi95VnBSeWV2ZlZUczlsNFRMTS9obGptd3RMblox?=
 =?utf-8?B?TWZOVS9lSEQ3SGU1TldmcmxuNm9pa1JNZEYrOTI4R3ZRRmZRSlVaS3VqM3dq?=
 =?utf-8?B?OWV4cUdPNTAxeHArV01oVTZvaXE3WUpYNGxCSEVFcWNPaTFzTjZlZWpndHh1?=
 =?utf-8?B?VEY4cE9zUWRxMjZVQTA3UnhuOG5jR0RpNXZYNDc2bDM1R1FKMzBLNWkraFYv?=
 =?utf-8?B?T0M2Y0V0SXlaTExWVHdEUVVhYkNhbWtYcnNrWFNSNW1IMElCODU4L2FvY0dm?=
 =?utf-8?B?R0tweUZRa1FVTTNNUGp4SmR2NWh1ZHBDN1c4VFlOcjhpbGxwWkRxTUExcTRU?=
 =?utf-8?B?UlNNQVk3TW1pS3k3R25zNHlYb204V0hvanY0ZytGR0ZRQ2Y1M1FQeFdINTdG?=
 =?utf-8?Q?eDXM+wRSs5X/rq49nmE6R76hm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ff827c-1776-4e2b-10cf-08dc8564a451
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 13:37:27.9327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3YsRf5OgMrlsF776TNPD4z3novYA6Qx94+gjRvRMYAs7Q5lo1oJSUPpczK1+cfd6AD9KX9NZsgxP92kKY5A6m2V00KdJIBzetO0zp2UoEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4785

SGkgRW5ndWVycmFuZCwNCg0KVGhhbmtzIGZvciBkZXRhaWwgYW5kIHRpY2tldCBudW1iZXIuDQpM
ZXQgbWUgYXNrIG91ciB0ZWFtIGFib3V0IHlvdXIgb2JzZXJ2YXRpb25zIGFuZCBnZXQgYmFjayB0
byB5b3UuDQoNClRoYW5rcw0KV29vanVuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEVuZ3VlcnJhbmQgZGUgUmliYXVjb3VydCA8ZW5ndWVycmFuZC5kZS0NCj4gcmli
YXVjb3VydEBzYXZvaXJmYWlyZWxpbnV4LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDUs
IDIwMjQgNDozNCBBTQ0KPiBUbzogV29vanVuZyBIdWggLSBDMjE2OTkgPFdvb2p1bmcuSHVoQG1p
Y3JvY2hpcC5jb20+DQo+IENjOiBhbmRyZXdAbHVubi5jaDsgaGthbGx3ZWl0MUBnbWFpbC5jb207
IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gVU5HTGludXhEcml2ZXIgPFVOR0xpbnV4RHJpdmVy
QG1pY3JvY2hpcC5jb20+OyBob3Jtc0BrZXJuZWwub3JnOyBUcmlzdHJhbSBIYQ0KPiAtIEMyNDI2
OCA8VHJpc3RyYW0uSGFAbWljcm9jaGlwLmNvbT47IEFydW4gUmFtYWRvc3MgLSBJMTc3NjkNCj4g
PEFydW4uUmFtYWRvc3NAbWljcm9jaGlwLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCBuZXQgdjUgMS80XSBuZXQ6IHBoeTogbWljcmVsOiBhZGQgTWlj
cm9jaGlwIEtTWiA5ODk3DQo+IFN3aXRjaCBQSFkgc3VwcG9ydA0KPiANCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIDA0LzA2LzIw
MjQgMjI6NDksIFdvb2p1bmcuSHVoQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+ID4gSGkgRW5ndWVy
cmFuZCwNCj4gPg0KPiA+IENhbiB5b3UgaGVscCBtZSB0byB1bmRlcnN0YW5kIHlvdXIgc2V0dXA/
IEkgY291bGQgc2VlIHlvdSBhcmUgdXNpbmcNCj4gPiAgIC0gSG9zdCBDUFUgOiBpLk1YNlVMTA0K
PiA+ICAgLSBEU0EgU3dpdGNoIDogS1NaOTg5N1IgKGh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5jb20v
ZW4tdXMvcHJvZHVjdC9rc3o5ODk3KQ0KPiA+ICAgLSBIb3N0LXRvLUtTWiBpbnRlcmZhY2UgOiBS
R01JSSBmb3IgZGF0YSBwYXRoICYgU1BJIGZvciBjb250cm9sDQo+ID4gQmFzZWQgb24gdGhpcywg
Q1BVIHBvcnQgaXMgZWl0aGVyIEdNQUM2IG9yIEdNQUM3IChGaWd1cmUgMi0xIG9mIFsxXSkNCj4g
Pg0KPiA+IEkgaGF2ZSB0d28gcXVlc3Rpb25zIGZvciB5b3UuDQo+ID4gMS4gUEhZIG9uIENQVSBw
b3J0DQo+ID4gICAgIFdoaWNoIEdNQUMgKG9yIHBvcnQgbnVtYmVyKSBpcyBjb25uZWN0ZWQgYmV0
d2VlbiBIb3N0IENQVSBhbmQgS1NaOTg5N1I/DQo+ID4gICAgIElmIENQVSBwb3J0IGlzIGVpdGhl
ciBHTUFDNiBvciBHTUFDNywgaXQgaXMganVzdCBhIE1BQy10by1NQUMNCj4gY29ubmVjdGlvbiBv
dmVyIFJHTUlJLg0KPiANCj4gSSdtIHVzaW5nIHBvcnQgbnVtYmVyIDYgYXMgdGhlIENQVSBwb3J0
IGZvciBLU1o5ODk3Ui4gR01BQzYgaXMgZGlyZWN0bHkNCj4gY29ubmVjdGVkIHRvIHRoZSBNQUMg
b2YgaS5NWDZVTEwgKGRyaXZlciBpcyBpLk1YIGZlYykuIEknbSB1c2luZyBSTUlJDQo+IHNpbmNl
IGdpZ2FiaXQgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUgaS5NWDZVTEwuDQo+IA0KPiA+IDIuIFBI
WSBJRA0KPiA+ICAgICBJdHMgUEhZIElEIGlzIGRpZmZlcmVudCB3aGVuIGNoZWNraW5nIGRhdGFz
aGVldCBvZiBLU1o5ODk3IGFuZCBLU1o4MDgxLg0KPiA+ICAgICBQSFkgSUQgb2YgUG9ydCAxLTUg
b2YgS1NaOTg5NyBpcyAweDAwMjItMHgxNjMxIHBlciBbMV0NCj4gPiAgICAgUEhZIElEIG9mIEtT
WjgwODEgaXMgMHgwMDIyLTB4MDE1NnggcGVyIFsyXQ0KPiBUaGF0J3MgdHJ1ZSBmb3IgcG9ydCAx
LTUsIGhvd2V2ZXIsIEkgZm91bmQgb3V0IHRoYXQgdGhlIHBoeV9pZCBlbWl0dGVkDQo+IGJ5IEdN
QUM2IGlzIDB4MDAyMjE1NjEuIEl0IGlzIHRoZSBzYW1lIGFzIEtTWjgwODEtcmV2QTMgYWNjb3Jk
aW5nIHRvIHRoZQ0KPiBkYXRhc2hlZXQuIEkgYWxzbyBzdHVkaWVkIGFsbCByZWdpc3RlcnMgYXQg
cnVudGltZSBmb3IgYSByZWxpYWJsZQ0KPiBkaWZmZXJlbmNlIHRvIGltcGxlbWVudCBzb21ldGhp
bmcgbGlrZSBrc3o4MDUxX2tzejg3OTVfbWF0Y2hfcGh5X2RldmljZQ0KPiBiZXR3ZWVuIEdNQUM2
IGFuZCBLU1o4MDgxLCBidXQgbm9uZSBhcHBlYXJlZCB0byBtZS4gRm9sbG93aW5nDQo+IHN1Z2dl
c3Rpb25zIGJ5IEFuZHJldyBMdW5uLCBJIGFkZGVkIHRoaXMgdmlydHVhbCBwaHlfaWQgKDB4MDAy
MjE3ZmYpIHRvDQo+IGhhcmRjb2RlIGluIHRoZSBkZXZpY2V0cmVlLiBJJ20gaGFwcHkgd2l0aCB0
aGlzIHNvbHV0aW9uLg0KPiA+DQo+ID4gQmVzaWRlIHBhdGNoLCB5b3UgY2FuIGNyZWF0ZSBhIHRp
Y2tldCB0byBNaWNyb2NoaXAgc2l0ZQ0KPiAoaHR0cHM6Ly9taWNyb2NoaXBzdXBwb3J0LmZvcmNl
LmNvbS9zL3N1cHBvcnRzZXJ2aWNlKQ0KPiA+IGlmIHlvdSB0aGluayBpdCBpcyBlYXNpZXIgdG8g
c29sdmUgeW91ciBwcm9ibGVtLg0KPiBJIGNyZWF0ZWQgYSBqb2luZWQgdGlja2V0IGZvciB0cmFj
a2luZyAoQ2FzZSBudW1iZXIgMDE0NTcyNzkpLg0KPiA+DQo+IA0KPiBUaGFuayB5b3UgdmVyeSBt
dWNoIGZvciB5b3VyIHRpbWUsDQo+IA0KPiBFbmd1ZXJyYW5kIGRlIFJpYmF1Y291cnQNCj4gDQo+
ID4gQmVzdCByZWdhcmRzLA0KPiA+IFdvb2p1bmcNCj4gPg0KPiA+IFsxXQ0KPiBodHRwczovL3d3
MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9hZW1Eb2N1bWVudHMvZG9jdW1lbnRzL09USC9Qcm9k
dWN0RG9jdW1lDQo+IG50cy9EYXRhU2hlZXRzL0tTWjk4OTdSLURhdGEtU2hlZXQtRFMwMDAwMjMz
MEQucGRmDQo+ID4gWzJdIGh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5jb20vZW4tdXMvcHJvZHVjdC9r
c3o4MDgxI2RvY3VtZW50LXRhYmxlDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPj4gRnJvbTogRW5ndWVycmFuZCBkZSBSaWJhdWNvdXJ0IDxlbmd1ZXJyYW5kLmRlLQ0K
PiA+PiByaWJhdWNvdXJ0QHNhdm9pcmZhaXJlbGludXguY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5
LCBKdW5lIDQsIDIwMjQgNToyMyBBTQ0KPiA+PiBUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0K
PiA+PiBDYzogYW5kcmV3QGx1bm4uY2g7IGhrYWxsd2VpdDFAZ21haWwuY29tOyBsaW51eEBhcm1s
aW51eC5vcmcudWs7IFdvb2p1bmcNCj4gSHVoDQo+ID4+IC0gQzIxNjk5IDxXb29qdW5nLkh1aEBt
aWNyb2NoaXAuY29tPjsgVU5HTGludXhEcml2ZXINCj4gPj4gPFVOR0xpbnV4RHJpdmVyQG1pY3Jv
Y2hpcC5jb20+OyBob3Jtc0BrZXJuZWwub3JnOyBUcmlzdHJhbSBIYSAtIEMyNDI2OA0KPiA+PiA8
VHJpc3RyYW0uSGFAbWljcm9jaGlwLmNvbT47IEFydW4gUmFtYWRvc3MgLSBJMTc3NjkNCj4gPj4g
PEFydW4uUmFtYWRvc3NAbWljcm9jaGlwLmNvbT47IEVuZ3VlcnJhbmQgZGUgUmliYXVjb3VydCA8
ZW5ndWVycmFuZC5kZS0NCj4gPj4gcmliYXVjb3VydEBzYXZvaXJmYWlyZWxpbnV4LmNvbT4NCj4g
Pj4gU3ViamVjdDogW1BBVENIIG5ldCB2NSAxLzRdIG5ldDogcGh5OiBtaWNyZWw6IGFkZCBNaWNy
b2NoaXAgS1NaIDk4OTcNCj4gU3dpdGNoDQo+ID4+IFBIWSBzdXBwb3J0DQo+ID4+DQo+ID4+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cNCj4gdGhlDQo+ID4+IGNvbnRlbnQgaXMgc2FmZQ0KPiA+Pg0KPiA+PiBUaGVy
ZSBpcyBhIERTQSBkcml2ZXIgZm9yIG1pY3JvY2hpcCxrc3o5ODk3IHdoaWNoIGNhbiBiZSBjb250
cm9sbGVkDQo+ID4+IHRocm91Z2ggU1BJIG9yIEkyQy4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQg
Zm9yIGl0J3MgQ1BVIHBvcnRzIFBIWXMgdG8NCj4gPj4gYWxzbyBhbGxvdyBuZXR3b3JrIGFjY2Vz
cyB0byB0aGUgc3dpdGNoJ3MgQ1BVIHBvcnQuDQo+ID4+DQo+ID4+IFRoZSBDUFUgcG9ydHMgUEhZ
cyBvZiB0aGUgS1NaOTg5NyBhcmUgbm90IGRvY3VtZW50ZWQgaW4gdGhlIGRhdGFzaGVldC4NCj4g
Pj4gVGhleSB3ZWlyZGx5IHVzZSB0aGUgc2FtZSBQSFkgSUQgYXMgdGhlIEtTWjgwODEsIHdoaWNo
IGlzIGEgZGlmZmVyZW50DQo+ID4+IFBIWSBhbmQgdGhhdCBkcml2ZXIgaXNuJ3QgY29tcGF0aWJs
ZSB3aXRoIEtTWjk4OTcuIEJlZm9yZSB0aGlzIHBhdGNoLA0KPiA+PiB0aGUgS1NaODA4MSBkcml2
ZXIgd2FzIHVzZWQgZm9yIHRoZSBDUFUgcG9ydHMgb2YgdGhlIEtTWjk4OTcgYnV0IHRoZQ0KPiA+
PiBsaW5rIHdvdWxkIG5ldmVyIGNvbWUgdXAuDQo+ID4+DQo+ID4+IEEgbmV3IGRyaXZlciBmb3Ig
dGhlIEtTWjk4OTcgaXMgYWRkZWQsIGJhc2VkIG9uIHRoZSBjb21wYXRpYmxlIEtTWjg3WFguDQo+
ID4+IEkgY291bGQgbm90IHRlc3QgaWYgR2lnYWJpdCBFdGhlcm5ldCB3b3JrcywgYnV0IHRoZSBs
aW5rIGNvbWVzIHVwIGFuZA0KPiA+PiBjYW4gc3VjY2Vzc2Z1bGx5IGFsbG93IHBhY2tldHMgdG8g
YmUgc2VudCBhbmQgcmVjZWl2ZWQgd2l0aCBEU0EgdGFncy4NCj4gPj4NCj4gPj4gVG8gcmVzb2x2
ZSB0aGUgS1NaODA4MS9LU1o5ODk3IHBoeV9pZCBjb25mbGljdHMsIEkgY291bGQgbm90IGZpbmQg
YW55DQo+ID4+IHN0YWJsZSByZWdpc3RlciB0byBkaXN0aW5ndWlzaCB0aGVtLiBJbnN0ZWFkIG9m
IGEgbWF0Y2hfcGh5X2RldmljZSgpICwNCj4gPj4gSSd2ZSBkZWNsYXJlZCBhIHZpcnR1YWwgcGh5
X2lkIHdpdGggdGhlIGhpZ2hlc3QgdmFsdWUgaW4gTWljcm9jaGlwJ3MgT1VJDQo+ID4+IHJhbmdl
Lg0KPiA+Pg0KPiA+PiBFeGFtcGxlIHVzYWdlIGluIHRoZSBkZXZpY2UgdHJlZToNCj4gPj4gICAg
ICAgICAgY29tcGF0aWJsZSA9ICJldGhlcm5ldC1waHktaWQwMDIyLjE3ZmYiOw0KPiA+Pg0KPiA+
PiBBIGRpc2N1c3Npb24gdG8gZmluZCBiZXR0ZXIgYWx0ZXJuYXRpdmVzIGhhZCBiZWVuIG9wZW5l
ZCB3aXRoIHRoZQ0KPiA+PiBNaWNyb2NoaXAgdGVhbSwgd2l0aCBubyByZXNwb25zZSB5ZXQuDQo+
ID4+DQo+ID4+IFNlZSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjAyMDcxNzQ1MzIu
MzYyNzgxLTEtZW5ndWVycmFuZC5kZS0NCj4gPj4gcmliYXVjb3VydEBzYXZvaXJmYWlyZWxpbnV4
LmNvbS8NCj4gPj4NCj4gPj4gRml4ZXM6IGI5ODdlOThlNTBhYiAoImRzYTogYWRkIERTQSBzd2l0
Y2ggZHJpdmVyIGZvciBNaWNyb2NoaXAgS1NaOTQ3NyIpDQo+ID4+IFNpZ25lZC1vZmYtYnk6IEVu
Z3VlcnJhbmQgZGUgUmliYXVjb3VydCA8ZW5ndWVycmFuZC5kZS0NCj4gPj4gcmliYXVjb3VydEBz
YXZvaXJmYWlyZWxpbnV4LmNvbT4NCj4gPj4gLS0tDQo+ID4+IHY1Og0KPiA+PiAgIC0gcmV3cmFw
IGNvbW1lbnRzDQo+ID4+ICAgLSByZXN0b3JlIHN1c3BlbmQvcmVzdW1lIGZvciBLU1o5ODk3DQo+
ID4+IHY0OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA1MzExNDI0MzAuNjc4MTk4
LTItZW5ndWVycmFuZC5kZS0NCj4gPj4gcmliYXVjb3VydEBzYXZvaXJmYWlyZWxpbnV4LmNvbS8N
Cj4gPj4gICAtIHJlYmFzZSBvbiBuZXQvbWFpbg0KPiA+PiAgIC0gYWRkIEZpeGVzIHRhZw0KPiA+
PiAgIC0gdXNlIHBzZXVkbyBwaHlfaWQgaW5zdGVhZCBvZiBvZl90cmVlIHNlYXJjaA0KPiA+PiB2
MzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNTMwMTAyNDM2LjIyNjE4OS0yLWVu
Z3VlcnJhbmQuZGUtDQo+ID4+IHJpYmF1Y291cnRAc2F2b2lyZmFpcmVsaW51eC5jb20vDQo+ID4+
IC0tLQ0KPiA+PiAgIGRyaXZlcnMvbmV0L3BoeS9taWNyZWwuYyAgIHwgMTMgKysrKysrKysrKysr
LQ0KPiA+PiAgIGluY2x1ZGUvbGludXgvbWljcmVsX3BoeS5oIHwgIDQgKysrKw0KPiA+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5L21pY3JlbC5jIGIvZHJpdmVycy9uZXQvcGh5
L21pY3JlbC5jDQo+ID4+IGluZGV4IDhjMjBjZjkzNzUzMC4uMTFlNThmYzYyOGRmIDEwMDY0NA0K
PiA+PiAtLS0gYS9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMNCj4gPj4gKysrIGIvZHJpdmVycy9u
ZXQvcGh5L21pY3JlbC5jDQo+ID4+IEBAIC0xNiw3ICsxNiw3IEBADQo+ID4+ICAgICogICAgICAg
ICAgICAgICAgICAgICAgICBrc3o4MDgxLCBrc3o4MDkxLA0KPiA+PiAgICAqICAgICAgICAgICAg
ICAgICAgICAgICAga3N6ODA2MSwNCj4gPj4gICAgKiAgICAgICAgICAgICBTd2l0Y2ggOiBrc3o4
ODczLCBrc3o4ODZ4DQo+ID4+IC0gKiAgICAgICAgICAgICAgICAgICAgICBrc3o5NDc3LCBsYW44
ODA0DQo+ID4+ICsgKiAgICAgICAgICAgICAgICAgICAgICBrc3o5NDc3LCBrc3o5ODk3LCBsYW44
ODA0DQo+ID4+ICAgICovDQo+ID4+DQo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+
DQo+ID4+IEBAIC01NTQ1LDYgKzU1NDUsMTYgQEAgc3RhdGljIHN0cnVjdCBwaHlfZHJpdmVyIGtz
cGh5X2RyaXZlcltdID0gew0KPiA+PiAgICAgICAgICAuc3VzcGVuZCAgICAgICAgPSBnZW5waHlf
c3VzcGVuZCwNCj4gPj4gICAgICAgICAgLnJlc3VtZSAgICAgICAgID0ga3N6OTQ3N19yZXN1bWUs
DQo+ID4+ICAgICAgICAgIC5nZXRfZmVhdHVyZXMgICA9IGtzejk0NzdfZ2V0X2ZlYXR1cmVzLA0K
PiA+PiArfSwgew0KPiA+PiArICAgICAgIC5waHlfaWQgICAgICAgICA9IFBIWV9JRF9LU1o5ODk3
LA0KPiA+PiArICAgICAgIC5waHlfaWRfbWFzayAgICA9IE1JQ1JFTF9QSFlfSURfTUFTSywNCj4g
Pj4gKyAgICAgICAubmFtZSAgICAgICAgICAgPSAiTWljcm9jaGlwIEtTWjk4OTcgU3dpdGNoIiwN
Cj4gPj4gKyAgICAgICAvKiBQSFlfQkFTSUNfRkVBVFVSRVMgKi8NCj4gPj4gKyAgICAgICAuY29u
ZmlnX2luaXQgICAgPSBrc3pwaHlfY29uZmlnX2luaXQsDQo+ID4+ICsgICAgICAgLmNvbmZpZ19h
bmVnICAgID0ga3N6ODg3M21sbF9jb25maWdfYW5lZywNCj4gPj4gKyAgICAgICAucmVhZF9zdGF0
dXMgICAgPSBrc3o4ODczbWxsX3JlYWRfc3RhdHVzLA0KPiA+PiArICAgICAgIC5zdXNwZW5kICAg
ICAgICA9IGdlbnBoeV9zdXNwZW5kLA0KPiA+PiArICAgICAgIC5yZXN1bWUgICAgICAgICA9IGdl
bnBoeV9yZXN1bWUsDQo+ID4+ICAgfSB9Ow0KPiA+Pg0KPiA+PiAgIG1vZHVsZV9waHlfZHJpdmVy
KGtzcGh5X2RyaXZlcik7DQo+ID4+IEBAIC01NTcwLDYgKzU1ODAsNyBAQCBzdGF0aWMgc3RydWN0
IG1kaW9fZGV2aWNlX2lkIF9fbWF5YmVfdW51c2VkDQo+ID4+IG1pY3JlbF90YmxbXSA9IHsNCj4g
Pj4gICAgICAgICAgeyBQSFlfSURfTEFOODgxNCwgTUlDUkVMX1BIWV9JRF9NQVNLIH0sDQo+ID4+
ICAgICAgICAgIHsgUEhZX0lEX0xBTjg4MDQsIE1JQ1JFTF9QSFlfSURfTUFTSyB9LA0KPiA+PiAg
ICAgICAgICB7IFBIWV9JRF9MQU44ODQxLCBNSUNSRUxfUEhZX0lEX01BU0sgfSwNCj4gPj4gKyAg
ICAgICB7IFBIWV9JRF9LU1o5ODk3LCBNSUNSRUxfUEhZX0lEX01BU0sgfSwNCj4gPj4gICAgICAg
ICAgeyB9DQo+ID4+ICAgfTsNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
bWljcmVsX3BoeS5oIGIvaW5jbHVkZS9saW51eC9taWNyZWxfcGh5LmgNCj4gPj4gaW5kZXggNTkx
YmY1YjVlOGRjLi44MWNjMTZkYzJkZGYgMTAwNjQ0DQo+ID4+IC0tLSBhL2luY2x1ZGUvbGludXgv
bWljcmVsX3BoeS5oDQo+ID4+ICsrKyBiL2luY2x1ZGUvbGludXgvbWljcmVsX3BoeS5oDQo+ID4+
IEBAIC0zOSw2ICszOSwxMCBAQA0KPiA+PiAgICNkZWZpbmUgUEhZX0lEX0tTWjg3WFggICAgICAg
ICAweDAwMjIxNTUwDQo+ID4+DQo+ID4+ICAgI2RlZmluZSAgICAgICAgUEhZX0lEX0tTWjk0Nzcg
ICAgICAgICAgMHgwMDIyMTYzMQ0KPiA+PiArLyogUHNldWRvIElEIHRvIHNwZWNpZnkgaW4gY29t
cGF0aWJsZSBmaWVsZCBvZiBkZXZpY2UgdHJlZS4NCj4gPj4gKyAqIE90aGVyd2lzZSB0aGUgZGV2
aWNlIHJlcG9ydHMgdGhlIHNhbWUgSUQgYXMgS1NaODA4MSBvbiBDUFUgcG9ydHMuDQo+ID4+ICsg
Ki8NCj4gPj4gKyNkZWZpbmUgICAgICAgIFBIWV9JRF9LU1o5ODk3ICAgICAgICAgIDB4MDAyMjE3
ZmYNCj4gPj4NCj4gPj4gICAvKiBzdHJ1Y3QgcGh5X2RldmljZSBkZXZfZmxhZ3MgZGVmaW5pdGlv
bnMgKi8NCj4gPj4gICAjZGVmaW5lIE1JQ1JFTF9QSFlfNTBNSFpfQ0xLICAgQklUKDApDQo+ID4+
IC0tDQo+ID4+IDIuMzQuMQ0KPiA+DQo=

