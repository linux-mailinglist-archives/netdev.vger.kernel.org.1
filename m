Return-Path: <netdev+bounces-208588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ADAB0C399
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D194188471C
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5382C08BA;
	Mon, 21 Jul 2025 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9i/uffP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93112BE053;
	Mon, 21 Jul 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098455; cv=fail; b=XvBOqkBoXrq+6EGgJu25fyENmZw1U8b3fL231J4sC1iy8dG4BJ/AyxG3F//JfMxMkxejH0K2QGxGmWTN8N6wLdHJKD2aHY+0woA5LCALFc/x3fF5DPU5G4USFw749hPzXn83/hf0DCY6OQewSpdpW56OWZqIsoUF5SLVY6TrQBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098455; c=relaxed/simple;
	bh=fhfwdTzVxsI3LOUUD+JXnEpZ81l1MiVqg9mf/OYaQt4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YeyeIEhwvUALagkkfhMLMSBtfke8Ar8E730m/ROzOXz7Y6Ij9Zm2qg/XMUoT26oCFOujXNZ3jAYeKE5HnOWxZ7CgzTTWElGVGhJ57kWdDeAuCwoiM8sGsz8ILvYdc7muzq0gEe30OmTRcxLVzH+MKs8Id3dr4fDSA0XUQD9L2wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9i/uffP; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753098454; x=1784634454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fhfwdTzVxsI3LOUUD+JXnEpZ81l1MiVqg9mf/OYaQt4=;
  b=m9i/uffPZt1wzf6sYSef534d54mqdzo2phHQHluUnsWMwsamsDoY7Fm8
   vwxAfuBw45K/JKDOog2m0lKOzsUV0BZ257xUa4NHHqvfxy8yZitSORh6m
   Gj6hmgrgxVqj6ogvOkLboPpdVXiuSCRlyy0wEHk7IJDJI7koUKj2HqCKS
   yXDBidIzHfN4Us6f8tB8UQ6Q/b52lIm6M9fy0N9StSxwc5yOPNsENhmIY
   QOH2TKY3oYfDRLsl2ke/sVzgafV5c7rRAD/xvUlVJS+V786XG1naBzBd+
   9tfu/kKQqm5PXIJHmqjokvIYVewYmIw4y8WCp5N06waQa4dO8MOd7v5R5
   A==;
X-CSE-ConnectionGUID: gczHQ7SFTqygqhaVPdctyw==
X-CSE-MsgGUID: PV+l4vqTSKaSCSeFzINPcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="66000787"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="66000787"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:47:33 -0700
X-CSE-ConnectionGUID: WW+m/irISWaWFAfb/rVQZg==
X-CSE-MsgGUID: NWO8aFpNQZWeMuRMYYr7sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="159160508"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:47:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 04:47:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 04:47:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.54)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 21 Jul 2025 04:47:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faKhUqB3Yvab8j9iSW1VWF1fvgcZEkn8CZMElQGAT5clUhPvIdVqx8krtJCPjLrrI+foKxf5hoxggAnlONYpJCAqSizruRtzycoSLMtnwI+i3a+Z/WN+foOIAUdrXpS3UUgBfh/ztBW+olW8nMW50OvwleOih5G6JA0DbSUwl/iepYuoUYVZY034IiafMbPDGdn+nErQIcfMagbyukmUMlG7qD7ST6wCVHfM2hUg/zlNzJlQ6F9a7WGS/HUOvzzg9h/yMylPbNWrVrfnwwad+5MwuXNhd7vtyaZCI++3TSBv776iltMLS2mdt4RR2z3AyfaDYi8Pu79W/QvUogToYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhfwdTzVxsI3LOUUD+JXnEpZ81l1MiVqg9mf/OYaQt4=;
 b=mz6NcW1hqJaxNz4n+KimlIiROV2bOOWQvCv/bfxHpuBqh8MLxXm3SCkiY0VIsB9LCoZKrM9lZ2dYhuUYgbLkw2m/t/TQz1z4WH+Jduct3bmbJd5VO9lu+WRWyGb08nnYg33SAAIpr3iUU4C8KltvitHu5OZSZlwLcMiG9z4f2mxHR2kyHnkDJV7DZls55K65suZ6rQali87VTRawOa3wLh/Jmgla1QAPvjiYMby76kmWKJqfcL//GNg60P11yz9YS6uUx6oRQzb7uEaJMnFGMZ2MYTu79fzidRW9fpx28MFvz35TeZH2qKj9eai+P+SNwlkA2vXEXL143S46+BWIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ2PR11MB7520.namprd11.prod.outlook.com (2603:10b6:a03:4c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 11:47:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.8922.037; Mon, 21 Jul 2025
 11:47:29 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Yuto Ohnuki
	<ytohnuki@amazon.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1] ixgbevf: remove unused
 fields from struct ixgbevf_adapter
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1] ixgbevf: remove unused
 fields from struct ixgbevf_adapter
Thread-Index: AQHb9vdVlz1/3hpwIU6AYIrCLSnYbrQ2DaYAgACxdgCABb0ScA==
Date: Mon, 21 Jul 2025 11:47:29 +0000
Message-ID: <IA3PR11MB89861BE40BCCFED551B067D5E55DA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250717084609.28436-1-ytohnuki@amazon.com>
 <IA3PR11MB8986F59CEDE4BF3B7994241EE551A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <d4144828-f266-4a57-a78c-55a3b20b8cf7@intel.com>
In-Reply-To: <d4144828-f266-4a57-a78c-55a3b20b8cf7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ2PR11MB7520:EE_
x-ms-office365-filtering-correlation-id: 311b76ae-2dc6-4ade-a964-08ddc84c5f06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NmtFL3hmMzY4cWZFZG8zVW16QTNuYkVtNmc0OEt1TzNST1hYWkNvMEs1ZjU0?=
 =?utf-8?B?QmxCZGJrTVpNVEVXZ2FUaFNrYWxxMGdjTDlIOHA2cFdYSzdCR1FHS3BOUkFF?=
 =?utf-8?B?R2xrSFdGWng5Z2NkY0s0M1VmaWVaelV4UkIvS0dRNXRPYTQ2aGVocnZUeEtz?=
 =?utf-8?B?SUZwNEJvTzFCZG44ejdYN0tDV3ovSU5qOW9oM1JkS3FGY3VWQW5yOTlJUktm?=
 =?utf-8?B?S3lKaW9xSWppblREMkY1aFFNWUplbFgwVVlYeHFrM29pbFk0T3Y5QkptMW9F?=
 =?utf-8?B?T2dRbzBGbFFid0VMT0VLQ2c1YjJOUUVHeDM0RURhMmxTN2txM1dyVlVmOThq?=
 =?utf-8?B?dkhjdlRaM2pNNkU4ckZsbWxqU1Q5VHk0VUoxTmx3bEdwWll5Z2Y0MGE2bnlQ?=
 =?utf-8?B?MmVCN3pCY2RsVU55dDlwMXptVGFxZGxMOWlJMjdzTjFMalE4NWxKRFhRTStp?=
 =?utf-8?B?VVFHQlFxZlZyT2NRcnlXU3F4anNGTlJXSGRYdjN2VVNIdHo0cVlwOWw4TXIv?=
 =?utf-8?B?ekpNVDNRbGFPa0ZFYXg2elMyOGFQbzZWbnJqWWtFbllYdUxuWGk3UGliY3Zv?=
 =?utf-8?B?T1dTYUpPQys4MUcvTXJTQ01LWU1salp4aHVLdVBLZE5QU0VlQ1F0akQ1Tk42?=
 =?utf-8?B?bFFIWEE1eDZ2QTNTV1NMSE9WL0EveEZnZEgxTWdleFRCb3BkTU10dURKWXBO?=
 =?utf-8?B?UDJsZVlzbDFVOVI4TW5SZnU0OUd1MFdYU1VwQzcxeXNaSFNUMzJUVDlZV2dr?=
 =?utf-8?B?Y2dtamZVVkpucUpIaVg2YkNzVU1oOE4xM2JqUGRBQ05UT3ZqZWVBU0JYYUNy?=
 =?utf-8?B?ZHZ0alZqeHBHREZoazJLRkFQcU9salhrYWwxRHZhRXJEbHg4bGk5WHVORTdL?=
 =?utf-8?B?N2FjY3hQY2I3RmZhMVcyb2FrZHFnajRBNmN1UzFNcjBoaXN2SkZmWkQ4NlFI?=
 =?utf-8?B?Q3FsbG0wWnZ4SENlNWU0NkpjVUg1dXFmSGt4YUxYdWtZbGUxeTRjaE1rZDE5?=
 =?utf-8?B?ZkkwZGZtcUtkd0VCbkFoQ3phdkhsWDAzSTJhZjFXWFhtT0NXYkRmWGY0MlZY?=
 =?utf-8?B?V3NFZXJzZnd5aUlOUThHMVZaNmpEWHZ0QThsMHZ0QlpLTitFblozTWo4RWt5?=
 =?utf-8?B?bmY0SlhBbVpaSnJHVGlaZ0FJMk0rYjEzRGU2WHpSazBEN1J4WDNqcGE4akJI?=
 =?utf-8?B?SjkwcUlmbGRCbTFuNmxXbXJOa3FDYUJJZW44aFhNc3oxYXlLZzFiRmV0OFV4?=
 =?utf-8?B?OFZHemdveTRIMSs3V3ozdHlLb2tZMUhLQzBuZHM2YUh1VS9Qc3R5ZWV3L2wr?=
 =?utf-8?B?N0lua1hFYkJYRDJEczhuTXZyQVd6REFqZzhWTGJZd2JKYWRZajRxWnVFL0Ji?=
 =?utf-8?B?b3Rxc3Q0SEx4TS9Yc0FNNG13K1l0NUR0SHRyYXlTNnprcGFRSlF1VVdLUCtE?=
 =?utf-8?B?MUd6eVlTOVVuVW8wdmdDaFNteUc2ZGxBMVhRTXRlV04rTWplVTNlOTlDamp1?=
 =?utf-8?B?YzZVVkw2d3pzU3V6ODNhQjlETkczd0VpdEJ5cUNsMjN4SzdVOHNJZXhRWGZn?=
 =?utf-8?B?MkFucWZCTUJBNVFiSGl3Q01qN2pVU2g5TVhtZU1mWVliNzB2cW1zdnJXUTVh?=
 =?utf-8?B?YllhbEEwSzZibmxEL0VNcWVyZ21LWEJ4U0E2NGE5NUhJUjRlS204bGdvY2Rp?=
 =?utf-8?B?TkkyMDR5MGh5MDM5WWRLNndQZEl1YzlSTytCYXhnY2pBWXpzK0NPTER6QzEz?=
 =?utf-8?B?dUI5WjZzam05RU1GbGFhWWR4aXhrT0lVeUg0R3JLdnRUcTNmcU0rNXBqZkRr?=
 =?utf-8?B?TWN6dDZDMWNQbHpPbC9aR0ZVUURXZDNoRm9pQld5aWc1YktLK3ZTK0hkWUhV?=
 =?utf-8?B?N1pBS0ZieTVuczRhRi9Jbk9xUkxGVlo4Y0JHbGlObXFvYTE0aVdnazRlZDhv?=
 =?utf-8?B?cHRIOHVLNVJ1VVlBQ0hsdXFTUUJZb1ZrWjdXZlBVYmwwRXFCT2NKczBDcEZa?=
 =?utf-8?Q?qp/6/f1B3Xja7c35Kgvdadz86nPJDY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHNMYVJPWmp0alBZV0Q3UDZDbzdNQ0lhTHozMDdIVG5HdUlDRzRBNk13RDdW?=
 =?utf-8?B?OTkyTGxHRU14WFVsQ2lFRThaSC9QMlBpYWQ4Ym41NyszeUJyY0pzZHRvZFhI?=
 =?utf-8?B?R29TdUVpZXBnV3dpV3NyNmM5UiszSHZ1dWZJTkxlSFd4Q0lYUnp6Q3dtcENi?=
 =?utf-8?B?YnJPSW9RVDdpY2Jpbmo0aGY3a2lJU0xRM1d4R3Uybi9aUVh5Mkc3VnBjenFt?=
 =?utf-8?B?MWVXSEpxeFB2YVhmdEZFTk5HTExyNmNZWHdmZXQ4aDdWQVgxR2lsWE8vRzNa?=
 =?utf-8?B?TWZCVjFxUUYreFYxNXY0bTRQYWdpQU9TSXdacldpd296ZStTaUJWcDUzTkdS?=
 =?utf-8?B?R0tCZnVWRUZwallmWjI1ck5WSk92MDUxVDVvV3VvWmlxdDJnRkZWTUduRDY0?=
 =?utf-8?B?UHVPc1FPak10NUIxbjg4aVZKdHlUeWRkZkRhMHpaVkp4a3VrRWc1SzVDaHFs?=
 =?utf-8?B?UisrVC9hSkNDRlQzRnF3dFZkWitwcHVURm1OYlRvRWtBYy9aYmVoZ0dLM0x6?=
 =?utf-8?B?aXNZSkZBR0g1QlBUYlA3Y0VJbkZtTTFoYnVub3FZYkJGQy85Qlo2VGZJdFcy?=
 =?utf-8?B?V1lteHE3a1kzU1FNVVVCV1VPUEtFb1AyOFRmeFpQTVBKTDB1NjdyUG9LNEph?=
 =?utf-8?B?K1A1WlY3VVRSTVh4VHAzaWFyZjl0SytESHM2bTlIZzFlNFNHZUZ1cEJHV3J5?=
 =?utf-8?B?TEJZWERwQVVUWnlyekpEQS9qakd4aUJjNkJOTDVrYUZsRzRmSWE4QXNFM0kr?=
 =?utf-8?B?Y3kyeFg1dENNbTZYemVKSEFQMm5PejEvdXNTVko0c3piaVRUbG1ubHZWMWxX?=
 =?utf-8?B?YU93QTl0dkNYMHNtZGs5WFRLTDdKU2JCSnE0VHpmVDY5Q2lYemNyYnBhZ2Qv?=
 =?utf-8?B?MHBMblNxSXczRC9QRjR0TDc2dkFuVTkwQkdFUWNsVUExQlhBaStUMHJQVWN4?=
 =?utf-8?B?Tk82bnBxcHpzZkJPQWZ5SG91NTdScFJTUWdBRzZiUWEzMFMycTBhV2w5U21N?=
 =?utf-8?B?SDVWTUpZcmlvMGNpcTM1eTV2b294WXBKYjZuMS9UYnlwK3JJdGZSWTNsZ1dM?=
 =?utf-8?B?R0xZb3ZmZkF0cnQvZFZGWlJaVXR1aHJPN3dHN1ZZK1llVG5jYjNwYkNQeVVv?=
 =?utf-8?B?NUwrbllYb3ZLR3FHelVzZ2pWWVRJTXd4YzZScjhpYi82SkowbTJ0RC9Hcnoy?=
 =?utf-8?B?NkZpdUZ0K0w4aXBpei8xRXJiZXA0Zk5sODA3WjRqak9GbmJOSDRHNVZ5NVJi?=
 =?utf-8?B?bmNML1pyVFBzVjhoUnV3dGlTTzBPNnVPR2t3VGtUd3BzaVZ1Ym5lUlNnZmdW?=
 =?utf-8?B?KzUwMm40eGJrZVB6d0FSMkJ6SGxVWFV1Y2gwZDZpcnhkU2EyWEQ1V1BoU2FJ?=
 =?utf-8?B?dHA3NHFhS3Z4N0FSTjFBZVY5WGRLbDE5dUNNdzRSTzdWd0txb3Q3ZUdVSDRk?=
 =?utf-8?B?ZXpvYm1IcDhxd0toc1J5Ly9FNEZwNW9Hb2pQb0JORllzelF1SUxXbzE0d0hw?=
 =?utf-8?B?MllqSlpDZzBkZmdvdU1mQ3liU0J0K3RCcWpiR1Y2MzFQdEM1YUpUSnYycW16?=
 =?utf-8?B?aUdtSWk2U3hFMS9HY3BiYjhybzlHWU9RUjlWUzNwbHJyR0EzTktLQ1NnOFlD?=
 =?utf-8?B?Q0xuVjRDTmk1aHRMVmU4NVFUZVFZenI0OThTM0R2Z0xZOTduMm13Y3NFWDNa?=
 =?utf-8?B?MnlvOE5RcU5GaUNab1d2NTY3RFA2N21lUmtYQytVMTZBSGZlOEhTNUlWeTkx?=
 =?utf-8?B?cmhwRHBaa2NIeWR1MkVBaEowcGk2UVRTQmo2ejdJcWxaWjJBcjBMcDFUUXdC?=
 =?utf-8?B?bU5VamRIM282SXdpeVNlLzZ2SHJpaWw4RDJjbnordmZxV2Urc0RMR0tYRGIx?=
 =?utf-8?B?dlo2ODhPbTlUbEFaemhLK1U0QzlZcTF3cU5uQUVudHdqSGhSSDhDY1V6ZGto?=
 =?utf-8?B?M25aaEVtTEh4SWdZK0lHdFFORnBNUEM1V0lsYzFTTGEwOVRSOUpKQnpReFZr?=
 =?utf-8?B?bGdRbGt6Tkh2R0VqMGNDcUxrNkJ2NW9hUjVJVU52VTA3MysvenhsZFNQSHdO?=
 =?utf-8?B?LzdINkwrTTRoZU5CaG1NMHJNUW13NmZmK2llMUl6M0VkNFdwWjNFSU16UUlO?=
 =?utf-8?B?UHIwVjVWNGtuVkM4R1NBdENmckdzcUhUNFA4akluMEpHVmpkQWtMV09oNkJX?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311b76ae-2dc6-4ade-a964-08ddc84c5f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 11:47:29.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNGIslS0WBq2sQmolSxwbWDUEv7Yen0j1bVIJsGjZbGeW8hEnUbax9q4pWOup+sYdw2jXT3utNEDWvAv4NgZI0noBLkWUWn67Rm2y/jL/z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmd1eWVuLCBBbnRob255
IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAx
NywgMjAyNSAxMDowOCBQTQ0KPiBUbzogTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5s
b2t0aW9ub3ZAaW50ZWwuY29tPjsgWXV0byBPaG51a2kNCj4gPHl0b2hudWtpQGFtYXpvbi5jb20+
OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0K
PiBDYzogQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMgLiBNaWxs
ZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2ds
ZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkg
PHBhYmVuaUByZWRoYXQuY29tPjsgaW50ZWwtDQo+IHdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXh0IHYxXSBp
eGdiZXZmOiByZW1vdmUNCj4gdW51c2VkIGZpZWxkcyBmcm9tIHN0cnVjdCBpeGdiZXZmX2FkYXB0
ZXINCj4gDQo+IA0KPiANCj4gT24gNy8xNy8yMDI1IDI6MzMgQU0sIExva3Rpb25vdiwgQWxla3Nh
bmRyIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogSW50ZWwtd2lyZWQtbGFuIDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wu
b3JnPiBPbg0KPiBCZWhhbGYNCj4gPj4gT2YgWXV0byBPaG51a2kNCj4gPj4gU2VudDogVGh1cnNk
YXksIEp1bHkgMTcsIDIwMjUgMTA6NDYgQU0NCj4gPj4gVG86IE5ndXllbiwgQW50aG9ueSBMIDxh
bnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsDQo+ID4+IFByemVteXNsYXcgPHBy
emVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo+ID4+IENjOiBBbmRyZXcgTHVubiA8YW5kcmV3
K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUyAuIE1pbGxlcg0KPiA+PiA8ZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViDQo+ID4+IEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+
OyBpbnRlbC0NCj4gPj4gd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiA+PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBZdXRvIE9obnVr
aSA8eXRvaG51a2lAYW1hem9uLmNvbT4NCj4gPj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0g
W1BBVENIIGl3bC1uZXh0IHYxXSBpeGdiZXZmOiByZW1vdmUNCj4gdW51c2VkDQo+ID4+IGZpZWxk
cyBmcm9tIHN0cnVjdCBpeGdiZXZmX2FkYXB0ZXINCj4gPj4NCj4gPj4gUmVtb3ZlIGh3X3J4X25v
X2RtYV9yZXNvdXJjZXMgYW5kIGVpdHJfcGFyYW0gZmllbGRzIGZyb20gc3RydWN0DQo+ID4+IGl4
Z2JldmZfYWRhcHRlciBzaW5jZSB0aGVzZSBmaWVsZHMgYXJlIG5ldmVyIHJlZmVyZW5jZWQgaW4g
dGhlDQo+IGRyaXZlci4NCj4gPj4NCj4gPj4gTm90ZSB0aGF0IHRoZSBpbnRlcnJ1cHQgdGhyb3R0
bGUgcmF0ZSBpcyBjb250cm9sbGVkIGJ5IHRoZQ0KPiA+PiByeF9pdHJfc2V0dGluZyBhbmQgdHhf
aXRyX3NldHRpbmcgdmFyaWFibGVzLg0KPiA+Pg0KPiA+PiBUaGlzIGNoYW5nZSBzaW1wbGlmaWVz
IHRoZSBpeGdiZXZmIGRyaXZlciBieSByZW1vdmluZyB1bnVzZWQNCj4gZmllbGRzLA0KPiA+PiB3
aGljaCBpbXByb3ZlcyBtYWludGFpbmFiaWxpdHkuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6
IFl1dG8gT2hudWtpIDx5dG9obnVraUBhbWF6b24uY29tPg0KPiA+IENhbiB5b3UgYWRkICdGaXhl
czonIG9yICdDbGVhbnVwOicgdGFnID8NCj4gDQo+IEFzIHRoZXJlJ3Mgbm8gdXNlciBidWcsIEkg
ZG9uJ3QgYmVsaWV2ZSB0aGlzIHdhcnJhbnRzIGEgRml4ZXM6IHRhZy4NCj4gDQo+IEknbSBub3Qg
ZmFtaWxpYXIgd2l0aCBhIENsZWFudXA6IHRhZzsgb24gcXVpY2sgYnJvd3NlIG9mIGdpdCBsb2cs
IEknbQ0KPiBub3Qgc2VlaW5nIG9uZSBiZWluZyB1c2VkKD8pDQo+IA0KPiBUaGFua3MsDQo+IFRv
bnkNCj4gDQpHb29kIGRheSwgVG9ueQ0KRXhhbXBsZXMgb2YgdGhlIHRhZyBjb3VsZCBiZSBnZXQ6
IGdpdCBsb2cgLS1ncmVwPSJeQ2xlYW51cDoiIC0tb25lbGluZQ0KZmY5ZmIyZSBNZXJnZSB0YWcg
J3NhbXN1bmctc29jLTUuMTknIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9rcnprL2xpbnV4IGludG8gYXJtL3NvYw0KMTViNWI3NiBNZXJnZSB0YWcgJ3Nh
bXN1bmctc29jLTUuMTknIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9rcnprL2xpbnV4IGludG8gYXJtL2RyaXZlcnMNCjU2NmQzMzYgbW06IHdhcm4gb24g
ZGVsZXRpbmcgcmVkaXJ0aWVkIG9ubHkgaWYgYWNjb3VudGVkDQozNTE4OWI4IGtlcm5lbC9hY2N0
LmM6IHVzZSAjZWxpZiBpbnN0ZWFkIG9mICNlbmQgYW5kICNlbGlmDQowYmJlNGNlIGlvbW11L2Ft
ZDogRml4IHRoZSBvdmVyd3JpdHRlbiBmaWVsZCBpbiBJVk1EIGhlYWRlcg0KNTIxZWMxYyBNZXJn
ZSB0YWcgJ3JlbmVzYXMtZHQtYmluZGluZ3MtZm9yLXY0LjE4JyBvZiBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9ob3Jtcy9yZW5lc2FzIGludG8gbmV4dC9k
dA0KODc4ZTkxNyBNZXJnZSB0YWcgJ3JlbmVzYXMtZHQyLWZvci12NC4xMycgb2YgaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaG9ybXMvcmVuZXNhcyBpbnRv
IG5leHQvZHQNCmMzYWNjMzIgTWVyZ2UgdGFnICdyZW5lc2FzLWFybTY0LWR0Mi1mb3ItdjQuMTIn
IG9mIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2hvcm1z
L3JlbmVzYXMgaW50byBuZXh0L2R0NjQNCjg4NTVlMTQgTWVyZ2UgdGFnICdyZW5lc2FzLWR0LWZv
ci12NC4xMicgb2YgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvaG9ybXMvcmVuZXNhcyBpbnRvIG5leHQvZHQNCjUzNDRkZjYgTWVyZ2UgdGFnICdyZW5lc2Fz
LWFybTY0LWR0LWZvci12NC4xMicgb2YgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvaG9ybXMvcmVuZXNhcyBpbnRvIG5leHQvZHQ2NA0KODM3YTkwZSBuZXRm
aWx0ZXI6IGlwc2V0OiBSZWdyb3VwIGlwX3NldF9wdXRfZXh0ZW5zaW9ucyBhbmQgYWRkIGV4dGVy
bg0KLi4uDQoNCj4gPg0KPiA+IEFsZXgNCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaXhnYmV2Zi9peGdiZXZmLmggfCAzIC0tLQ0KPiA+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaXhnYmV2Zi9peGdiZXZmLmgNCj4gPj4gYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9peGdiZXZmL2l4Z2JldmYuaA0KPiA+PiBpbmRleCA0Mzg0ZTg5MmY5NjcuLjNh
Mzc5ZTZhM2EyYSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aXhnYmV2Zi9peGdiZXZmLmgNCj4gPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aXhnYmV2Zi9peGdiZXZmLmgNCj4gPj4gQEAgLTM0Niw3ICszNDYsNiBAQCBzdHJ1Y3QgaXhnYmV2
Zl9hZGFwdGVyIHsNCj4gPj4gICAJaW50IG51bV9yeF9xdWV1ZXM7DQo+ID4+ICAgCXN0cnVjdCBp
eGdiZXZmX3JpbmcgKnJ4X3JpbmdbTUFYX1RYX1FVRVVFU107IC8qIE9uZSBwZXIgYWN0aXZlDQo+
ID4+IHF1ZXVlICovDQo+ID4+ICAgCXU2NCBod19jc3VtX3J4X2Vycm9yOw0KPiA+PiAtCXU2NCBo
d19yeF9ub19kbWFfcmVzb3VyY2VzOw0KPiA+PiAgIAlpbnQgbnVtX21zaXhfdmVjdG9yczsNCj4g
Pj4gICAJdTY0IGFsbG9jX3J4X3BhZ2VfZmFpbGVkOw0KPiA+PiAgIAl1NjQgYWxsb2NfcnhfYnVm
Zl9mYWlsZWQ7DQo+ID4+IEBAIC0zNjMsOCArMzYyLDYgQEAgc3RydWN0IGl4Z2JldmZfYWRhcHRl
ciB7DQo+ID4+ICAgCS8qIHN0cnVjdHMgZGVmaW5lZCBpbiBpeGdiZV92Zi5oICovDQo+ID4+ICAg
CXN0cnVjdCBpeGdiZV9odyBodzsNCj4gPj4gICAJdTE2IG1zZ19lbmFibGU7DQo+ID4+IC0JLyog
SW50ZXJydXB0IFRocm90dGxlIFJhdGUgKi8NCj4gPj4gLQl1MzIgZWl0cl9wYXJhbTsNCj4gPj4N
Cj4gPj4gICAJc3RydWN0IGl4Z2JldmZfaHdfc3RhdHMgc3RhdHM7DQo+ID4+DQo+ID4+IC0tDQo+
ID4+IDIuNDcuMQ0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBBbWF6b24gV2ViIFNlcnZp
Y2VzIEVNRUEgU0FSTCwgMzggYXZlbnVlIEpvaG4gRi4gS2VubmVkeSwgTC0xODU1DQo+ID4+IEx1
eGVtYm91cmcsIFIuQy5TLiBMdXhlbWJvdXJnIEIxODYyODQNCj4gPj4NCj4gPj4gQW1hem9uIFdl
YiBTZXJ2aWNlcyBFTUVBIFNBUkwsIElyaXNoIEJyYW5jaCwgT25lIEJ1cmxpbmd0b24gUGxhemEs
DQo+ID4+IEJ1cmxpbmd0b24gUm9hZCwgRHVibGluIDQsIElyZWxhbmQsIGJyYW5jaCByZWdpc3Ry
YXRpb24gbnVtYmVyDQo+IDkwODcwNQ0KPiA+Pg0KPiA+Pg0KPiA+DQoNCg==

