Return-Path: <netdev+bounces-304544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ee8OMYm3R2ogeAAAu9opvQ
	(envelope-from <netdev+bounces-304544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:22:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA6702CCF
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:22:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=RhsaoJPV;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304544-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304544-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA1B3011589
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8483D4123;
	Fri,  3 Jul 2026 13:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09573BB113;
	Fri,  3 Jul 2026 13:06:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083988; cv=fail; b=lgnY3UYxRrw+Dx4y+8ULCxhi/cyo5GYBmgQnu9u7SEqHjKuhRFJTT0KprFJNW1zwcLzBD9zWBir6gtotVP5ByxWcFDuQpNKTiC7mrQVQmelacAv6ulCfI919UtfOei4DZcgf7K/3MsTIlLO0Fk7VXy1zldNR6dQOsRibCgQdYeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083988; c=relaxed/simple;
	bh=5LHbpcamNc+I7MY8vZZYwZxzDSU0r+8yF+AVV47qvJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hpJqEVfZL57vynO+d/odXj28Xf+1EDjjsjiO1h3fdthnBwPDHZWThwtrMR68uZFeagUiDtROvcuhIsbNZqf3WD+vhdhVTA0G5BDmrIy8obbiK/+WVNQflTGKfDVmqQ9LkTp+1brGUWIbCivXalts7sxxsNwEbi2UolWHqdI/FFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhsaoJPV; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783083987; x=1814619987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5LHbpcamNc+I7MY8vZZYwZxzDSU0r+8yF+AVV47qvJ4=;
  b=RhsaoJPV3+JOfPg6X+Yu5UoLeqDGPeesLYaRmPfuJ3Vxw2hvF6h6r3gj
   1kmuN/PEJcLtIX1KlZxdJTO8RdatdovOvE6Zq0iWH9YCfJqjW1Dvl3vLw
   s53En0zklku+XOlOP92ASRa3R3Ryr1ufr3kWiG79mI91riRMe+kVbxDK8
   IXYqMs8WWn/nFKUR4LM3cpSooVfNAEwHPkiG+qoUxwJrmBXTz7ciMZbgu
   m3ZetEHcG+GmbYtFijEr5D3QphfXjiHOiYTj4nsA+76Ghu49i7BK+OFDx
   mouy6HfhJZyiEqGFpRcw0SrcQ9hjbAkrd6KduB1hCdB8JxZuiSeZGeK4s
   g==;
X-CSE-ConnectionGUID: e/qCO1+7SumaMp0BoYTfXQ==
X-CSE-MsgGUID: R4cj9d9JQ1aTaTDGtwUTZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83930814"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83930814"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:06:27 -0700
X-CSE-ConnectionGUID: myvUTOwMTPC16c7Uv8D3TQ==
X-CSE-MsgGUID: C6XFnplFTW6P2gnIuDhgog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="249754947"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:06:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:06:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 06:06:25 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:06:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grZ8YHtA/stJmQuuGXmkZTzi3aOv7MPY6oL9D0U39GpgdBmQiZ5btd64+CRO2VYBApFXMClYtXtnIVdwzmxHuWcCQaOFgbQjOBNKl7+uRvqpFQLHhSP95PSJ2zn1sex3ENE5f941sVU6lLuhZkCPH9oyDo90Low7qpvFJWhGHQ8iPXdbs+N3dRIkIcMRxqGBq5CxYx6zFembzxCTPh1tA9SVJjbotA1Rts/GVLoTUPL4pnMVxHmJCW+BTfP9mqkieGBl/90+eDFLxEbK7XnyDm09y7ZEOqnDv/1cien0u7skj2CRFtqH7rokgASak2JeZc1hr/fXCaoajvD82XnKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LHbpcamNc+I7MY8vZZYwZxzDSU0r+8yF+AVV47qvJ4=;
 b=lA4CRUqcwP+LcGxn0WWQfWLP9VHH78/ayoIG7CW5dhvPauxnbDidUOh6FGIkLJAjlxfk7GI6SrQlBrBG04F7TIrLpJedQEV+IC4O8hrWawuNWda7trLHPC3vj5zK4JlhBxE5ROKyHpvBOCfW/t6UoEOBu3U6HEdYR7EPCXBy9Gq7jQhFOj4ieEI0DlSmekVFm7jTvBknrPbfhpaJwCLC8wZb61FbC+HXtq/Fq7lyoEy/sjy996Oq+GoayZQkVumrZJZvJOEZmIEN3aXcJ6dhJhDdop81oz7J8e501bQC6dEe5E16K8ZZpcE0b9nKOWRqCd5Xay5z4vPOrYZQFuPmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH8PR11MB7119.namprd11.prod.outlook.com (2603:10b6:510:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 13:06:21 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 13:06:21 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>
CC: Cedric Jehasse <cedric.jehasse@gmail.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>, "Tyrrell, Kieran" <kieran@sienda.com>, Ryan
 Wilkins <Ryan.Wilkins@telosalliance.com>, Mattias Forsblad
	<mattias.forsblad@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 03/17] net: dsa: tag_dsa: Add helper to add DSA
 header to RMU frame
Thread-Topic: [PATCH net-next 03/17] net: dsa: tag_dsa: Add helper to add DSA
 header to RMU frame
Thread-Index: AQHdCsCXb6uVvpoBe0mEtJ+ObQDX8bZbw3Jg
Date: Fri, 3 Jul 2026 13:06:21 +0000
Message-ID: <PH0PR11MB5902834434E8B7ACE4964EDDF0F42@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
 <20260703-net-next-mv88e6xxx-rmu-v1-3-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-3-991a27d78bca@padl.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH8PR11MB7119:EE_
x-ms-office365-filtering-correlation-id: e94a7c24-b1ba-40cc-b3ee-08ded903e0d7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|22082099003|18002099003|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: xndpb7ilyf5rCYWvi4p1/dFHdwqRIKIQKzr5gfIlONcUMBOqtypKpAA7PrdcjPzlkrUo8A5RZGiKpVehLVANWe+gNvAVIFpS5ibcUElIarAoLp4WeoU50c7IP9HNp6ISTCEzTjGsRuwsgQSUxCjqCdHPE/BH1MktKyrEljgbMROSfsda7JM4LweWKOu+vB7iNs5vBRNMnW+oSJOZbxJ0XUG1ko8vzfYYg/Ijrn+tf+gPRGNTMEoPT5jrT/nRmQFLP1EYzO5aNQH/SiFCruH13Y599zaghZzOsCRe05UUlcnH1jzj0TTSKWN0QIHDmoIKENeN6QsjInabbXOw5jDbbEmPjnW9FvMVUoIevngYMEZAjcQO1OZuah8rkPGMsmpsFaqpqN4ThUpThEKbIYFQf0Lc5ZvODgRBDK/tp/sQPGLxw9QwMx0o57qhQ/BwjchLBpIJ/f2JWRgZQ2B3aTKjd4bOMO3tzlKDlU18j8+h/UJ0jm6AH9ssWANnCWJ5vVnxjrwnQusjdOkd1GBm8DliCVx6Mz8loDV1mqn2azCg0KmuPv7x5wh7Ms4UNtiL/BWr31tYl0vgAKNT2C3kkzC/WsepFKrnED5adjwLMJWWpnZdDOJri5fF3nooGqoQ8zdjuhz3sZRinmNwnu3ASUjnepCxvLV+A/kZohUEWvb2dP7iQR7ERzlpmtzUBIFMS010ZpQ+huga/YL29Pjd3zwGT5+sFP8WUe+VmMDUMbbdFqF6pNFWoXVCa6ZQHr4LSpUc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFlBWHRMUFE3YzEzVm44c3AvclgwZ0RNelRUOXM1TWxTSlNLeEJMbVpTcndp?=
 =?utf-8?B?eEhDS2pOVjRycDdNZWx4UUd6T2V2S1J2M1RGTmVVNlVyUU0vejlJUVgwelRX?=
 =?utf-8?B?TVpaOVA3WUFyd3hGKzA5OXdsdHlUZk5vbWxOT1ZaWnBlQWIxL0pEUUFVMHdU?=
 =?utf-8?B?a25jM2pHem9TeUZ3SXM4dDVXd2pDZjJJSU5tNGlMNUZsUjl1cTFlTzI1Q280?=
 =?utf-8?B?Uitqb2lxVGI2dzVBekdxdEFsRnRFRmx0Q1JpYTN2MkZrMDlIc29HcjIyWUZV?=
 =?utf-8?B?d3dXYzJ5VHFCSWttUmhXQTYzOUNHY2hyWUdVUC8yQVpsbHhzSnBWTnppUlFa?=
 =?utf-8?B?MmFKSEJwY2x1YlRQS1pueUh3ekNLWjFTbHBUZXhnMGRUZTdmQ3hwYlJ0YkFr?=
 =?utf-8?B?KzgyUVpwSTE0dSsybVJWbGFXaVowNWk4eFJRWXdEdlFWVnRvbkdzNmluekZX?=
 =?utf-8?B?ODA5Ym52T2U4M3QrWGdXSjA0clp4OHFZT3dMYTJPSzZNWWhtRFJITTBQWGJk?=
 =?utf-8?B?aThldU0vR0Y1MEFpekk3NzZrQjkrUlRhWXBxWXU1NFlpdjZYbWlJbWRGRFRJ?=
 =?utf-8?B?RlBIYzVVaWlMbnRLWmxhRXd4bnpMZ1l4b29ReEU2T2EvZnRDZjhSREpnaWF3?=
 =?utf-8?B?bHJqV1FIVTV0Wm5SL0FlanVuQ0JDaXZQdUFDcWJ1QzNPVnpPb2w2VEJQZGUv?=
 =?utf-8?B?NUpKUlJRN3RMYkM2LzRRd1pvdSt1SHNBOTVYMXlxbzMvdTNoWHFLekE4T1Mw?=
 =?utf-8?B?QXRSR29wY3k2RENaU1h4c0J4dGcxNXBVcm8yaGV3aUdZYTNpWVRUb0hQRHdv?=
 =?utf-8?B?S3doVVppa1lDK2NmdGxJZHZSQnVDVXFmeXpMeDFYNHhoNy9qUkxnV0dOaDVz?=
 =?utf-8?B?eUhDTzRLRytFNWltdHcvRzBJUlJPZWpLM1NVWnU2RDVPRkZyUTZXY0pONzdH?=
 =?utf-8?B?eVZVajEzVWtSckFKbmVMWFpkZ052d25HYUV0UXIrTlk0cmtUTnVVUHg4WXd2?=
 =?utf-8?B?VFdIc1ZGVWZPblk2UG56a2NSTGVlVG9pbDZITjlIYzZVdDVNWjZOQVFIK2hB?=
 =?utf-8?B?OVFnck53NG9EeFE5cUp5VjFmUjhCazEzdm54dmR2bVZkY1JyaWx5b0RJVFpW?=
 =?utf-8?B?Mmd6NWs2TzF2QU9SbGVGL29CVFl6RVRYb3JMVU9nZ3FjL2JldTI4OUVjRDFQ?=
 =?utf-8?B?cnVidHdCNW0vNWJKamdYaFMxdXhFS3FsTWZBeWJjcUx3UkFsbmVpU3hMQjZ5?=
 =?utf-8?B?YmZuV0dvZVVUQytET3IwTlgwZXdwSWp2MFVNcUE0NncwNmREWUU5Wi9NZDVw?=
 =?utf-8?B?STVsZFdtSGFia1dMem9ELzRhNnlacG5ySUM2R1lFeHlIOTAvcWx0cTY5cm94?=
 =?utf-8?B?Q0N5dlNYMVR4aFJqRHR1Z3RSblVxVVNUcFhYeVc0aGxXOGY0T0ExV0JGYmJl?=
 =?utf-8?B?bUhJMnJHeDcvb2lZb2FaeHFDcU1pWis0RWFlR3BMYW80OXA2MHk5UC9KUTJM?=
 =?utf-8?B?a0Z5NUQydHpNb3R5Z1NHSW1pVGNXWWhhWDJySCt5d0dCdi9PbElnczBZcmw4?=
 =?utf-8?B?Q2YxalgyYjc2WTg3QjFwVlU0aURFRjBQVjgrREpkS2dUWHV2RnlBbDhlaTdY?=
 =?utf-8?B?VnBXTHhrRUVDUXBNRkg4VGxYVnNheFFhZkxGditoR21Udk5iTnAreG9LL29P?=
 =?utf-8?B?YkY5MFpkK29mSHBjOHVmWDhjNUN1UUFSQ3ZGRDJtSkEvb2NrZjgzZFlPeVNx?=
 =?utf-8?B?SXhROUFUckdJTHFlS3UzYzRaKys3bENJY042OGNWZUNJc1hmTmpPd3pEaFlh?=
 =?utf-8?B?UDY4NGh1UmFOdk85WTBkU25Hc3FKL1V4ZEhxQVl4ZlBLYldsVjlSSDg2Q1hB?=
 =?utf-8?B?VUhtUlJyQUh5RHZMNExFclh0eEE1cXN6TWtJR3Brd2xnNXd4YXoxaElQYkNH?=
 =?utf-8?B?VlNTKy9sVzdsakM2N1lzcHRKZ0p4Z3BVWGNXUXBQRHZPL29uZkYwcnBoYThO?=
 =?utf-8?B?VHNTc0lzMFR5NFphQkMwVnlZZDQyMnRJWG5jdC80UzNTQ0FncnJtME9CZGFy?=
 =?utf-8?B?eXhiSTNzL3pTVmpXME5jdzhOTTV3Q283U1g0MmxoUVNPWW94RFczTGFsT1Rw?=
 =?utf-8?B?Zk0ySWdaektFZzBSZzUraGQ5RG9RWjFlRUQvQ3ZBSENGK0hLMkZ1eGxKVUJL?=
 =?utf-8?B?eW5VOGhQK2dmYzNUTE5DSlp4ZlRHWDVRamlqSnlLWE5Ickh2aUZSdFczem1U?=
 =?utf-8?B?TTZ5OFkwT2c4NmZ3VnR2UmdibTl3ckc1aElTb2hKNU1FZW9EUnFwb0ZXekNU?=
 =?utf-8?B?ZDcrQmdMOTFnVXdVQVNvZk5sdU14Q1JpK3Q1Q1c0S1QvdHM3ZEJqQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cSCd6Mz9U2k23aY2qNBrEzTAAHJ706xvpmD0cd2iuYsQu49VhuWt2tM1GrrZTSfZferetoGMBzyEtLhpwdhTaJcVW9JBcRqJEHzX/hFlgh0QdUAsFrKhnFx6X3klZGnFgkAdRuApZZr4u/zarqRCs+s8sQYPLMvABWzPu2LNc0ehdhsMmZ602R8kq16pE21OV0NYhkcoAuW9e/dwlPaNemQbMAtmX5ZaWqdBKPB8MvkUebyRKnxXVPFvAnU/dVbkWIfE7ggAEOYXulRR8RXY9u7KfWptQP8DPVrXvuqifR/uvn+nRCdF8/olIU/WpzMltXMLpp4ng5DcH5BcxlVWrA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94a7c24-b1ba-40cc-b3ee-08ded903e0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 13:06:21.3282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uM8LbPzuWb3Y1sGT3KtFHkeCcsdeeGvM7HsGmcwXmx/w576h1tCt9g9GXB0ihds+nEA4q4xrH4bWf0NmbrtM9dzcF7U6KXxPB+fGFbyNyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7119
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304544-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[padl.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,padl.com:email,vger.kernel.org:from_smtp,lunn.ch:email];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65CA6702CCF

RnJvbTogTHVrZSBIb3dhcmQgPGx1a2VoQHBhZGwuY29tPiANClNlbnQ6IEZyaWRheSwgSnVseSAz
LCAyMDI2IDk6NDcgQU0NCg0KPkZyb206IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4N
Cj5BIFJNVSBmcmFtZSBzZW50IHRvIHRoZSBzd2l0Y2ggbmVlZHMgYSBEU0EgaGVhZGVyLiBBZGQg
YSBoZWxwZXIgdG8gdGhlDQo+dGFnIGRyaXZlciB0byBhZGQgc3VjaCBhIGhlYWRlciB0byBhbiBz
a2J1ZmYsIGFuZCBwcm92aWRlIGFjY2VzcyB0bw0KPnRoZSBoZWxwZXIgdmlhIHRoZSB0YWdnZXIg
ZGF0YSBzdHJ1Y3R1cmUuIFRoaXMga2VlcHMgbW9zdCBvZiB0aGUNCj5kZXRhaWxzIG9mIHRoZSBE
U0EgaGVhZGVyIGluIHRoZSB0YWcgZHJpdmVyLg0KPg0KPlNpZ25lZC1vZmYtYnk6IEFuZHJldyBM
dW5uIDxhbmRyZXdAbHVubi5jaD4NCg0KeW91ciB0YWcgaXMgbWlzc2luZyBoZXJlOyBwbGVhc2Ug
Y2hlY2sgdGFncyBjb3JyZWN0bmVzcyBvdmVyIHRoZSB3aG9sZSBzZXJpZXMNCg0K

