Return-Path: <netdev+bounces-289305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDW6CDcSDGoZVQUAu9opvQ
	(envelope-from <netdev+bounces-289305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:33:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE0B57923E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61D4A300D1D4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F24C3D8113;
	Tue, 19 May 2026 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QI9uAOy8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE413D5240
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175987; cv=fail; b=jlSUvz978ReqM8XFWngvoERyQ41z5hMQzfB6JeO65Z2zHniSr6LJuct3owZSAQYgmfriNwveKdI+lGyVpz6Qb7PYAYQ3rWssXLdlZDmQQAtfLVOTzjRoRewXRuQ+sQCd1+IwdijOOmIQxkA+1IutT/B4s/Hp/oSJZ/J/maPdqvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175987; c=relaxed/simple;
	bh=TpE/eV+rpi1Pg9+vZpG7BhC/WTQTI/1aTc3GDb5ebJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RixAVBMrVHqzxdJfOlSBMeEpFLfKaMJbq0DmJN1ayNBhCLHT6PJptWntn1BDA+lMHzBfoFf5WHj7SkDBQGi3O0gspeyGsbbXZeHXx/41gtDdTfN9hpAO36rBfA5G4JZ9StfuGkj0zCDHFCBK4j3VWAzPhWHFLP/vjbDseEQjqjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QI9uAOy8; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779175986; x=1810711986;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TpE/eV+rpi1Pg9+vZpG7BhC/WTQTI/1aTc3GDb5ebJE=;
  b=QI9uAOy8mW93Rq9PGJuNVcASbBJeP/3nNpJQ9UC5vaj1Ey3o8Y7Csbwq
   e53qmaDM5HqP2nUvjxDu8B/1UrDwHcryHN23O3ISBtd4sTsIqLVs+INtr
   Xh+QCKcKwxZeCDcNOCqEMv42R7xVCrHX0ZCZExMZ579vvEO6Uf50waxNi
   6J6hPOzC6mIikUnuoA1kymWRIBrZ6Xglzo6tHa2pHI8QxvDXLX+4ZPMFY
   +8FI/yLnP0UwwOys7dtC/HNCnMNUGUYyk3lGUfhejaDgjtMk8uKQuZM2x
   FF3TOFFJSrslUIJwSb/IhVAkSIy7STgAPrcVlzyaP2RgIhOtelky9jDZj
   A==;
X-CSE-ConnectionGUID: ubIWUYxUQ8eKV2C4nBDoDw==
X-CSE-MsgGUID: ldi+Jd40QZKMVEVKP2PFWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80075658"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80075658"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 00:33:05 -0700
X-CSE-ConnectionGUID: 6pfFIa67QomZDKjlFlGkTw==
X-CSE-MsgGUID: tnODB6AXQM6lGBS0odwAOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233304930"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 00:33:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 00:33:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 00:33:04 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 00:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgSb/6EwGWAGBGdp6YfTRVDIzif4/VlARVPlN/QYSCJLBY+dzrPbNd6np4cPOB1bAEp7w4efed2aDBdwJzLqMnhhC6lV54ezuBYSwISrs0nqfTEfMNaOGcg79NreMyX3p966BZ1RAzaw5TrojuRNY/I0XHOdSYjXZ1Jf9xq7xawzKqzyQoRzZTFkzjqZDjDybWl/aZ1ArVP1HJfedf1d+YdnseUN5+NOSLe+3BIuk/e3KvXllCw6efoptQQXHYQ0y3N5Lz6MjTNzcq1mBqogAgkUGkTc89tL8XuQGximRCskliUjm9gZkMMU5kQIxt+CqYapJpuMuEDTNdYBKy9Csw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPSqZFnYagwXmkpDiQnlKt6oatWTE5D2S+GgwMRRdfQ=;
 b=eotY/AYCOSfkyM5dcEOMGyAa9SXRDNv2OFQSz/1KG5qU4WDFhXlYlBnnd6DL/Qce17iRktFmT7Wk4pWfVzWCw35V93f1QB0HZ6ayOttiW7D2kA6XyKxm4+BBC8BM4jj7dsNCQTBVqUGsodMw/SUyCQ8NxJ7t8aJ6M4yCcmq2R1Irzr0ME0dyNtwbbbXp+MJXVo7na819e4qqw7Vj7Ko2+VkOUJk9vKJQZ+5fJrEAdJmBuqprgYeoGH1LsWOe0DSO0Rc28nBIVfV+W+4kWEhGpSdzMjb5A4VxGTgtfSYesNlxw+fG0VHco/ubWaUl5fuxUmNFP+Ghw4303OH8nYCUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 07:33:01 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 07:33:01 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/3] virtchnl, iavf, ice, i40e:
 add extended generic VF capability flags
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/3] virtchnl, iavf, ice,
 i40e: add extended generic VF capability flags
Thread-Index: AQHc1yUHgDfZJbCO50eeG4qCHJw9KbX1xLWAgB9QXhA=
Date: Tue, 19 May 2026 07:33:00 +0000
Message-ID: <IA3PR11MB89856269B945E7827E4812F68F002@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260428143716.9653-1-marcin.szycik@linux.intel.com>
 <20260428143716.9653-4-marcin.szycik@linux.intel.com>
 <IA3PR11MB89860B13BF6848A4A96B4EDDE5342@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89860B13BF6848A4A96B4EDDE5342@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|IA0PR11MB7840:EE_
x-ms-office365-filtering-correlation-id: 095220d6-abaa-4a4a-d057-08deb578db27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003|4143699003|11063799003;
x-microsoft-antispam-message-info: zDvC0QFs6VgNvCeashsDPMaXB2dAAwDT2IGOO+ozuHpU7XdJv4urpMGFvL2NG3oZ5E4OE/xPIsmG5Q1yB/EVVCC40spooFmfaDerDOezw1V0He3ds2toIA5Xw6jXEwdYc6EsLOAZm7QcT6PR/T1lsZMQ2d3vO/veAxUmKOOGgMLugqbtTfFHVR3wbLWYEIBVgexmYY3rkj68MHRAx48m79tcZrG0lzT7d3pXXcXr6wU4EdvvPud2x1QmIqgxYGpibsoacrCR78HugehocX/kooFQBvRK0NvWpWBrFzSWwIiGeIju86CFPnWXLgUMieQx6jkjLfr9oK1J/yk+5sjjNeYqWRVwj4B68tvTjltHnfjxScWqiCclxbvRu4yc6taCdgpeMrdaSGsHl9TyTCUbv5FgWGZqtzV+5bUVzpC6+GbHU+b6mISDWQlaKbSD0AeRsfG9gANoKH0ujDKAat+rsZMIUbOGem3Z5cT8glXljPS3C2Cs+n8FQYibbVH0GidQOLWWzpyAonpvZgyO2idh982ZVqXMs0mQTAQ0z5tQdtdF5OMp99wRQ3oSwERNv5datMV4+q5v1bVPCHp95ez8UcutqWUAW59G6RbTnlXTjEGGOnK61k0nc7HisA/tJMRO0/aQ+ZySVvMnl3egNRFd8DKUi/7sSI50CC9Jgzmy0kQINAXswrcpN34Tbybpy11XOqR3VeAGITWxSM3VL9GeWcs7475s/XsqLzFviF/ULoBoXDDtU5IxXg+Jpe2k6t6j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Noo/clLajLkdtbdfCrqyQkooHwZ9nlcMLEuoqwGArVCUEkWSUxQyzXUwynmX?=
 =?us-ascii?Q?RwJXYvOdl/Hn2sdAMaUqx2YNZWZyWv1ghgMrTnUr/yZnrlq4Sl8R3Le9oTTu?=
 =?us-ascii?Q?hDze9c2hC53rbnXfCfW3A6iywyKycbb/Q4ZYXxE7DDvyt1oyuvk5hrJW7EsQ?=
 =?us-ascii?Q?jYFpt7QbUAglF2qx5nfCmlRkNpk2oXE3+6YI+zQpDO38C6IAaQTsnJaLmmj3?=
 =?us-ascii?Q?80Ovssea0JC2FeBl1d6V8/CRPk1ZmDJRWtRUwBnTXnQl1D6HT7adDTeb8lq6?=
 =?us-ascii?Q?TiG//6cVezBbuyjvonHqwnAxboOcPyA5uW8ijyMkWnzPZQKvGzgM7MQ9RjAr?=
 =?us-ascii?Q?9kfq0XXJHSaH1W2UDyU1Jaz+SrAoH0k6jdCsMGH7Mu535qLkV+oNlJ3X6/Qs?=
 =?us-ascii?Q?zxQ8ohDwYeIhd+5/BeYZZ+Z08aI5vuoF/Udn5nFELjEmxCDUueOACjM0DpcE?=
 =?us-ascii?Q?r4/UtgZzY5SOmMLV27QZ8Aj/cq6ln4edJOXh8aXZLe1zs8QcyUNXDBAqrEn/?=
 =?us-ascii?Q?G9cjxG0P4jqir8K1qg/QkZyDLnV3iYWcO9oqXIF62Iyf94VTM6Y44zN/VHTr?=
 =?us-ascii?Q?ALuCfuXx97BbzdWlFeKRt0DjWxm8WrdK/lVXPF4dn0ETSW9BBL3jRlJRI/Em?=
 =?us-ascii?Q?d81UZKeg8/HLBo1/6pyoGIUjOQ9RYwKr7JXEJX4GcZrTZJGMfGxTdGS2ZF6q?=
 =?us-ascii?Q?VWJfcCr4odLRdnk9dtTyrjQ46/wr+/C01Pnx7fHGhxx0BZBiefDMFuF6vIt7?=
 =?us-ascii?Q?XMLcSTF+pVbV+s3llcviTmBelRt8zDRURxkJqpgZ0u+iKOOs8JdpZbKBvrsY?=
 =?us-ascii?Q?5manmtoBKg51e/XfEFzWtsWsVChaw3dp5pIvDYsGRVYyzYFDgUiXH6KGwPkq?=
 =?us-ascii?Q?ixD/YDk2CBCNEf+fESq04M7Wr/sGcLqLiBxvH25Du9CcGOCBevFImxYd6ygM?=
 =?us-ascii?Q?hTboByGuI6UMgIe3YA6yHihHBSgNCU8o8z4YXEkFv3pDXdyWZkt0BkcCi6b6?=
 =?us-ascii?Q?IBPg+1cmwI7Xe9JcmXQ6bYjn0c/bBuPBt553sJdEh/Vocu5lDuTOj2H++v7x?=
 =?us-ascii?Q?3htIGk9krBUROyt22uKgWU5xHUxudF2xndMoXr2TUo8N2dTvoZBcI+lPu0S5?=
 =?us-ascii?Q?O2DLW/GbjpJemhC9rQQTb/lEfLOOGKmn+lwYRasyeflCJTIKsgHxn4q/Y45i?=
 =?us-ascii?Q?5Jvw8VCEitqHaoMGui+pOunj+BRYa2pHKOHHQvPYL2P4Yz67rJPmpDIAOkES?=
 =?us-ascii?Q?vOxXvKcGyGk4FGoAVl+cXyfA8P/SuVPclYVRcOVFiZqx03w58oOVxfGfqpwq?=
 =?us-ascii?Q?NuP1RWzwcdNDsL1VqNDqA1RpsI/XAg4Oi0RH6s1VkFxdofmhDsxjPE0iZzbT?=
 =?us-ascii?Q?BMr6+siebHjPvKdNtaucRcb94g+F1I/59bBeextVqxtYGXtlaPJWr8w645yV?=
 =?us-ascii?Q?24rwY3Gvj1/xBm0F3gurOBj1txqbvbRdL9oO5Rc1iFPyu1XvmlVzk/kexz1r?=
 =?us-ascii?Q?axbn9Gp9CdYCJRftyBGw4ZModJti83EU3KrbWbpj5dycTMB1F314VyFkX+Zp?=
 =?us-ascii?Q?I5PsWB0LuODY9mOf2po7rQq6QoiMkppElBoM1bDa6ATEdjZW7aelDp29E3WC?=
 =?us-ascii?Q?IW/fi2q/eY1MpkDzmb/aBZqcDLXxVZHvCGARCZ1ooEaVMH3Zdngb1V0n/UDs?=
 =?us-ascii?Q?rPGZ8ueDxJGJDVtjZD9clRBn6BrTK3g+3hXxxQ6WCOsLYqLxStDuIRjRzvjM?=
 =?us-ascii?Q?6vl9fiK2zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BrqCU7+Jz7vykBIfkm7yK4x02ei8ocdpXFWbymzJ75ACIDxribFIqzekWO5OSvSOECW2/xkXlwkfUC4buzeY1SSYr3mSzx8rEiDUsfq7ycEiCjARtObSUYLsSFYZrhnnS117OaQZiKa/+jIVtmnv+WMZ1tg2j6HodendFrdGJX5hXalBrnoneum8TfKPabz2WuCcHYxhJEj9gXFfDug85ETto+Oo1NQJu88/9hYIA/zmqina+ptZ/fEZcBM3K2cB2z5TB1iEV+Ror9NJ6cijzrSbUBKzRZZGxPFvwqemta4AckVmYm4e9YYosd9MSVSI2dtGqHGiHXmW+89n4bL9iA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095220d6-abaa-4a4a-d057-08deb578db27
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 07:33:01.0053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: feGnQfj8KlGEDyj8E7as7VJrS3E5USs7hhtG4wKIUCgxFZSUCRjkYrT393b3xtZvnQQQzGtiUgNfiRAnuXrA2W0IZSEMiTfrzY37XwU/YSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289305-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8985.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim,osuosl.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: ABE0B57923E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Wednesday, April 29, 2026 11:21 AM
> To: Marcin Szycik <marcin.szycik@linux.intel.com>; intel-wired-
> lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Greenwalt, Paul <paul.greenwalt@intel.com>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next 3/3] virtchnl, iavf, ice, =
i40e: add
> extended generic VF capability flags
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Marcin Szycik
> > Sent: Tuesday, April 28, 2026 4:37 PM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; Greenwalt, Paul
> > <paul.greenwalt@intel.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Marcin Szycik
> > <marcin.szycik@linux.intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next 3/3] virtchnl, iavf, ice,
> > i40e: add extended generic VF capability flags
> >
> > VF capability flags in struct virtchnl_vf_resource::vf_cap_flags have
> > all been used up, preventing new flags from being added. Note that
> > despite not all bits being defined here, they are used by out-of-tree
> > releases of Intel drivers, therefore cannot be taken.
> >
> > virtchnl message size and structure must remain unchanged to not break
> > reverse compatibility, therefore the existing virtchnl structure
> > cannot be extended with additional fields (e.g. flags2). vf_cap_flags
> > type cannot be changed to a larger one for the same reason.
> >
> > Bit 2 of vf_cap_flags was reserved for exactly this case. Its presence
> > in message initially sent from VF shall now signal that there are more
> > capability flags to be parsed. If the PF driver acknowledges that via
> > VIRTCHNL_OP_GET_VF_RESOURCES response, the VF will send a separate
> > message: VIRTCHNL_OP_GET_VF_CAPS2, containing more capability flags.
> > Note: this mechanism is similar for VIRTCHNL_OP_1588_PTP_GET_CAPS.
> >
> > The new message supports flexible size, so more flags can be added
> > without any architectural changes. Care was taken to ensure that no
> > out-of-bounds reads happen in case the bitmap is shorter in one of the
> > drivers.
> >
> > The new message includes the original 32 bits too, for consistency and
> > more straightforward parsing.
> >
> > Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf.h        |  19 ++-
> >  .../net/ethernet/intel/ice/virt/virtchnl.h    |   2 +
> >  include/linux/intel/virtchnl.h                |  55 ++++++-
> >  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  84 +++++++++++
> >  drivers/net/ethernet/intel/iavf/iavf_main.c   |  60 ++++++++
> >  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 138
> > +++++++++++++++++-
> >  .../net/ethernet/intel/ice/virt/allowlist.c   |   6 +
> >  .../net/ethernet/intel/ice/virt/virtchnl.c    |  86 +++++++++++
> >  8 files changed, 444 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> > b/drivers/net/ethernet/intel/iavf/iavf.h
> > index 64576cba3a01..5d812b0a52a3 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf.h
> > +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> > @@ -343,6 +343,7 @@ struct iavf_adapter {
> >  #define IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS		BIT_ULL(42)
> >  #define IAVF_FLAG_AQ_GET_PTP_CAPS			BIT_ULL(43)
> >  #define IAVF_FLAG_AQ_SEND_PTP_CMD			BIT_ULL(44)
>=20
> ...
>=20
> >  	case VIRTCHNL_OP_UNKNOWN:
> >  	default:
> >  		dev_err(dev, "Unsupported opcode %d from VF %d\n", v_opcode,
> > --
> > 2.49.0
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


