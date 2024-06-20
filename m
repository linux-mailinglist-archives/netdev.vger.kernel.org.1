Return-Path: <netdev+bounces-105116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D3490FC31
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFD1283FD2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA622F1E;
	Thu, 20 Jun 2024 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n9yFgTx0";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FnvnD8An"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7353B657;
	Thu, 20 Jun 2024 05:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718861682; cv=fail; b=q0ORXHM377OXZc6QyQmMeHIrVXoR4ViuZvKXd5oAvXrskArh0Wv/fD83KkNzc2de6qcCo/97pllPEjjdUEpm5TGgv8tPISEMq7D4+2Vh617ETNopvbNvwRM5htp2Uu+SQvXAL8zL2SxiSMWqXbR/DbitICC1BXG0UG9rZXS+HCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718861682; c=relaxed/simple;
	bh=MUDUJ5+FuHbk1omL03p3kQnRfQx6OVTPUenEK15yADI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=idQqRM6uKJEeLLsboAprC9gf6Up/mZHH7ZPb5kJZnJ8pkFR6JDIaeq0XIHmPXd3dhH38C00b8UcDm63paaN58CRUUY9q57xxSwu6TJKXuCIiLGWYc1n9+bBfw/3gWT51pnBEwqEDNSizs1YWcRJ9Hiqzb8ObDeM+WCDp4+rnTj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n9yFgTx0; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FnvnD8An; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718861681; x=1750397681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MUDUJ5+FuHbk1omL03p3kQnRfQx6OVTPUenEK15yADI=;
  b=n9yFgTx0/cfHqxZaC1c8K27jEFgs7Q2nrRNFNOIWkQAwgnN2g9P1YQ7N
   kgxM2qw/xJv1VoKp0Y4/pWYM4NIKRxtfsVR5q97kMG6V9mrApUSM898ZB
   qIS21pQFv+lbY343ZFnVvdFFOBn/5Lapx0PidMPmNIhoU7vzO4ZS/okuS
   JzClLjrOXvSCtEc2NQtJ8uTYLuzyy0jfepIYfqK0d8xvCEum4YeArz9Z4
   vM75tVf4+2GCYU/FVXS663tjplHgwq/wCuCmwJlxakJSpefEmno36PSnZ
   YbYtYTNbvQh3MEMg+Lj8PMn/Fw2813JrUMOe97WC9N4kNy/XrIBS0tTRt
   w==;
X-CSE-ConnectionGUID: 2yajG+4fRv+iLFOnM2kbZA==
X-CSE-MsgGUID: +GncXltCSXe7Y9NHZxOlQg==
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="28275720"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2024 22:34:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 19 Jun 2024 22:34:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 19 Jun 2024 22:34:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1sVEBv5e8zI2J/5UwTnn/R4b40GRZvwg7idwLyZB9kaPZUgSoVhVPECnkkzrem5SxoI+KoDNcQmNl1zk3ALDL/n71VJqmkGAYCbgsnayxpCXxbxLKD+kxhEmYW9V7AhKzxeEmy4W1iRGT5CsxwFUCMkY4o04cW8JOF6RRApTHDIaJY+45okBGtq9DYKdWFS+DHCx+p45lDBz6MXiKWXDoTbLM6V2peEMT1e7wfHXKvj5j5HD2frVfri7/sDFrOmFv48c9ab9xDhF+NrI1kT8kemFOikMofZWnhb7fwRh+7Gl1+nvgEcxh/1EiWVW2LnG/pBjmENGje3EbmxrNZHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUDUJ5+FuHbk1omL03p3kQnRfQx6OVTPUenEK15yADI=;
 b=HsuGUXwNzfTeVwPA04+vuUFI65n0nEIRg8Kz8zuKaRPIO/OOVRe9iR1SLCUre7Z2fSco59ZSzLPg/xFROVPlxW6S0dqbcwZW+G56rjS7cDuqDc0h9LJBOpUAqjaLvnVgGLHnYlyLNfactUFYpdL9nAGnBYTYqTsznj4uukdqX7A4oyu6FsA30SmXHgR6RfsJBWHTIQhRKaPpnur0XGDY+oWItspxlr6SCVUJC4vl+tUjliBfDZbkQ0wFYhPNLe4DFAmyI4zv/AWSA/I7KWpTlUlWdZn+NhniIagIFcbYCbj+y7YVlnYpAs7zxzGuVtFjy/eJoEsNLJy9gGollCI9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUDUJ5+FuHbk1omL03p3kQnRfQx6OVTPUenEK15yADI=;
 b=FnvnD8AnR6wvo8CDu+NLpCtg1zDnT3DEnwC5OVKW6sYX9SWlqkLpHQSgEA3aiYV2vPRFsqnC2eJGxfOGY+EyVfJNAaj1AyHQUmipUZcu1ThNJjg2bIuvAH3VYhcsEafOOp+Oy4sCW4a8zgaGyQkwQQFgN6go0uoUOBu1ctJCqfauxB0vR94AC4YsxfB/o5gIC7SQpmumojW4ER2/cUVGwVPxo+d+IHikWxe8D0874/Zh5BElxhz62Ejt7nl2whO2nftHe6DbmjfuA8ECqU80VaWLrXdRZINrZeDh4axu4c0RaYd8r4UyhVkDZiKzKSDpQXiwS0GPQY7a3reBSi8RZg==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by PH8PR11MB6611.namprd11.prod.outlook.com (2603:10b6:510:1ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Thu, 20 Jun
 2024 05:33:58 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 05:33:57 +0000
From: <Rengarajan.S@microchip.com>
To: <kuba@kernel.org>
CC: <linux-usb@vger.kernel.org>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <linux-kernel@vger.kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1] lan78xx: lan7801 MAC support with lan8841
Thread-Topic: [PATCH net-next v1] lan78xx: lan7801 MAC support with lan8841
Thread-Index: AQHau+QKS3/WRMWFLkKW/F+crLJ6w7HE64OAgAtDIoA=
Date: Thu, 20 Jun 2024 05:33:57 +0000
Message-ID: <d3340e88870bb3a63355b729ffe41b6792a1c2da.camel@microchip.com>
References: <20240611094233.865234-1-rengarajan.s@microchip.com>
	 <20240612183309.01782254@kernel.org>
In-Reply-To: <20240612183309.01782254@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|PH8PR11MB6611:EE_
x-ms-office365-filtering-correlation-id: 435dff82-70b1-4711-0808-08dc90ea94f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?b3BEeGJPM2RFYmtMWVhuRWcxWHlQZDIvUksrMjdYNzI4d2dadnMwK2RrOHVQ?=
 =?utf-8?B?b3BCWlpqRDViME8xQjFZbHU1QTNqeGR3TWhyRmc0bDlJdk5rVWdRQ0ZjUFN0?=
 =?utf-8?B?Z2FPaTZxam5SdUpzdzBHdzlQWlNQeERlZ2lNdUl3MVh0eGlMZ2dITHVEVzVW?=
 =?utf-8?B?cVp3OWVCMEJ4blQ2NVVSR3RKbktGOXFUN3ZUcWZkRnY0NTFacGZEa01UQWVZ?=
 =?utf-8?B?elFkbEE2ZkpDTWx6eDlCcmlkQ2ZWbEM1bnUyVGR5cWNybUZPd3BoKzVDZytR?=
 =?utf-8?B?WnFJd1NUSVRGR3BEYTIvM2VIMlpra3BrS3dOYkJOWUU1YnR6SWMrMzdFa1Fr?=
 =?utf-8?B?WERiZzIrN29jZnNSak45ekRDSzNzbTVxLzdDVHpRbHY0OXhoSEx5MGwzUkEw?=
 =?utf-8?B?bGg2WVBNMjVqK2hwckQ3TklRaHdobm5XemI5cGlyTW9rT0tIZmpiS3piYjZC?=
 =?utf-8?B?clljSW50S0gwSHJ3R05SR3lUd0ZucFZPdzJGKzM5dzhDQi9aWVNwL0ladUF1?=
 =?utf-8?B?NFFjQ2g2dVd5QnlqS3RSVXFOKzRIZktrVm0zWFlyajBzUE9PNWY4OG10Nk8z?=
 =?utf-8?B?bXhTMHNUSXlyb1FmVERnQTFMRDl5MFBZYXU2Y2FHMXZaZXF3WUlxdmFRbFJT?=
 =?utf-8?B?YzlJMU1UR1hDVGpOMkR0TlhwaTNURnJJNmJJWXdZYVdOQ1RUd0RQRE1sdEtB?=
 =?utf-8?B?Mk9uWE5YVGhLODRqYzd1aDN3SCtKNmNSaXRYeFpXaGVKWjB2MEd6N1ZNRGtS?=
 =?utf-8?B?R0lHU0E4dnlhZEZyRXdId3JhYnlOMFZtYWJHeCtYNkdIeDk1aG5TbUpXOWpa?=
 =?utf-8?B?dlVLdVB4aXdNcW94SlQxOEhlZ1BxU3FIbjhyQ0hrbGVFZGY3Y0NhSWxFZE5P?=
 =?utf-8?B?ZjNLK2FNUE5aR1Nua2h2SHpBbFoxMXpMdFY1VEFUU0lCRVRaeW1aSFdXMDNG?=
 =?utf-8?B?VWMyODU2eldSZ0w0STlYMjVNZUp0VUZXNGpYMUlZUCtDL3Bqc1p4YzJPRGY3?=
 =?utf-8?B?WFJLdU9kWTU1Wnl4aElmdnBQdndua3lOeENJQnk0c21qM0dYZzYrRUdKL2Fv?=
 =?utf-8?B?RFdBVU51OFVzR3VzTU45QUdVSDBGTmI0SFZidkQ1R3d6VXBIOVhIenNmZjk5?=
 =?utf-8?B?andRaFBrWWp0R0duZHMvcHEvTGZrQ0FZM0VpWVp3bGl6VUt5QlNyYXAzU2FU?=
 =?utf-8?B?L3dNbVVrcnZxNmtielRoNjlRVUhSc1krSFlpRTBzcVhpdG9lbjh6MW5Rb0hP?=
 =?utf-8?B?WUVDMlE0TjhGSFFSaUNGNTdocHM3Wmp3T3lHVnc2N3JYTC9DL1VhWkFGcEZ1?=
 =?utf-8?B?ZHdnQjlBeDRCWnB3ZWk3YXNmcUhCcG45SS9kRkdMUTZTZlNtM3FoQUV0NHg0?=
 =?utf-8?B?UnI2K1dpQjJwaXNCUzg1UjZDTjI2SGNaYk85ZlVobVVnd2ZHbXRvTkY1N1px?=
 =?utf-8?B?UytmeW1QZFYya1FER25ZTHkzNFR5cXNvV2g3L28rME5sL1NoN0pMdXdFSU1n?=
 =?utf-8?B?NWdsaXNTandCdzhuckx1ZHpwTExURmw3eFI4bnN1TDZDVmZwRFZlWUR1c0pP?=
 =?utf-8?B?TlE4dThxNUJoQTNNMUUrZE5pKzVMc24zVTR0TldmRlJUZVJMbXgzQm9vTzYr?=
 =?utf-8?B?Q1JPanBZanNsN3BHaEZaYkhVUlVrSnJzRVhHdTNYRTc2WW8wSGtiaklTbjUz?=
 =?utf-8?B?VEMxQ2JtdmNENllGV2xEQ1o4RG5rb3BBa3J6c2hyV2F3UnhUOGlBODV6em1l?=
 =?utf-8?B?N1Z4UGwxWTNKd1FWNmN3NWs3VCtPU2hMQXJUUmdxdmxPNHBpUG1qZmtSUDlF?=
 =?utf-8?Q?uP2y73GCFwzjRbMcC160/x2ufmTGZGkZVUWEA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUdBa3g2Yy9ranQwNnVvd01OVC90cHVGQk1aUmQ1VWo4VStHVDBDTGtibGk3?=
 =?utf-8?B?S2szQjk1TWpkVlVHVUtQay9YYk94NGcyelB5ejBnWXJQNjhMR3pKZkp3cjd4?=
 =?utf-8?B?Q1pqakY0Yjcyc3hiR2dDeFEwY2lKVTFVeEwxcmt4a0dxZmFTblYzUStNd1BL?=
 =?utf-8?B?OFRxTnphNXBEYWxVS2RPb0JuNjlmc1VTdmFKdzl2MGp4dnRvaThmaU1ESDh2?=
 =?utf-8?B?TUlXOVN6V2ppd2xSZFJJVDlPWlltNVhvOU5yLzd4OFh6bk1JcVlod0NBMkJ1?=
 =?utf-8?B?TW1pRXRmblFtK3l0cWhZbjh6N2JqZS9seWVQZTZZUUJhVXFTUXRnWXBwdlR4?=
 =?utf-8?B?OXNHRFY2K0svM1F1NGhSRW1ZMzAvWStMMUZzTVh4RHN3OEdFaU44ZkZhNi9O?=
 =?utf-8?B?YkNmdDQxVS9zZTNDeEJmamNReTFXLzJTNXhvYSthNUQwWmN2NlFhaWxWREM3?=
 =?utf-8?B?Skg1aGRxa3l0cmdQL3FtVlh2VWJYdlYzOVpYVmg0TXRvY0tYd0NxZzhmYmVo?=
 =?utf-8?B?MHNXTjlhYW9PaWxYZlFmaHBVU0ZQZGZ1S1NTQ3lSNzQ3Q05sRUNrSjVLek9Z?=
 =?utf-8?B?LzE1STkyamNCblJrQnhqU1N4dlNVd0gzU09mMDZFYTZtZ0JvN09tc0w2OStO?=
 =?utf-8?B?Y0xZRUNiUEJBblFjcGY0aDJGY0t3S05PM3pCek9RQnFKS1g2amp3eUhrRjJH?=
 =?utf-8?B?NDVqNlB0NjVucTVhSlBlQlAvV2E5WlcwMXlDSVBGa3cxZTU4Qk9xQ2M5VGRo?=
 =?utf-8?B?S2ZKR1hTanNydEJaZ20wbmRqdFpXSml6eThIR1BDZjlVQXd2alVBVXJTdUtO?=
 =?utf-8?B?Y1h6V0NIZ0pMdnlVRGVVU3c2RysyRDhKVFZsNHNpdlJ5MlRRVURUTlFxSWZG?=
 =?utf-8?B?aDBoU29kcU5PUHI2bVhSbXB6eWdLeGI1VFY1WjhtamErVk0velJtV3pqRmo5?=
 =?utf-8?B?M3ltRXBtQjl3aUhWNGFwUWZleW45NVB3TmJaRU9aQUliZUlqOEwxdGlScDhX?=
 =?utf-8?B?NmNWUFZNTTJ2YUlPaW9UR3hpaUs4MXZ6Z05UMVUzSWQwZXNnOWZXV1I2ZkZI?=
 =?utf-8?B?ZjNQN3VZL002eWFDeWZKa0xhYk5lenU4cldaME1NZEVRQTFXYUYycmsySmVS?=
 =?utf-8?B?d015amFSbTVXcThSTUV5SDA5ano2dm9wQjVsQ1I0ZWpYSlRweEg2L0h6ZWZW?=
 =?utf-8?B?WlY0clBOWFprZFE1WDRmVkMzbFVudUdaSTVKbWcyQjd0L0dsRFdsZ21MR2Nl?=
 =?utf-8?B?ZnVZTExnazRPZGJjdGJldEluY2ZWeEc4YkgxVXJxZmdBNDFVNlYxMmdodmJW?=
 =?utf-8?B?MHNxQ2k4aFVTcHd0b3M2T28zWFNNYXJzM3FVanhDUUlzWG5SbHpTTmdVWmNS?=
 =?utf-8?B?WkdpbU4yWEtrUE0xTHVUYi9wcHlmZG5xMTlSSytpL09GM3NnakpZM0xjSkQ3?=
 =?utf-8?B?dWFaeW4xZzJNUU55UXNWU1ZRcngrdVEyaDFGUUJ5R0hFT29qWlZCK0poVUhV?=
 =?utf-8?B?VWIxcXpGN01XQzM1WCtna3VMY3d3S3oyNnppK2JYWjYxNkFCVlplcjdVRnNV?=
 =?utf-8?B?aVBhWUlQcGdSOWMyR3NRVXZpODJmY2IxUTFvbVhkc3dzRGYwa2dzQkh2ZWJP?=
 =?utf-8?B?KzR6VVJORkJXNllKU05RWmZSRDFBY2lwTkNwbkNiSHdwVG5lZi9vYU5nUE5C?=
 =?utf-8?B?WkdhTTF6UFd0dlNZRDQzd0ZvcnYvTzlrVzl2RWVSNFYrSHV4bTRXRjVmNFpC?=
 =?utf-8?B?S0JSU2pVQjM3cjd6TEhpclY1bkNIbEVPeHhaWUtkbXUrcWJyaXdKUld3KzM2?=
 =?utf-8?B?Mzk2WlRNdkVCM2FNQUZxSzFjOXNqdGVBRStlSEpCdllhNGp0bHJ6OHRLN25k?=
 =?utf-8?B?YjhXTzBYRGJ4ckRrcVEzK1ZhaVIxOWZhY0E5d2U1ZXRZMkVpblJka1NmTzYz?=
 =?utf-8?B?OUU0Qlh6L2FaTGw1RTNaS1VSL3NJRXlJelh2NmpJMXl2b2dSNThoK2RyOXJv?=
 =?utf-8?B?UHlLZC9yVjhYMW5pN0xlK0NSK2t4b3A0VEttdkM3UlI5K0hMU3dDY2RiNkEx?=
 =?utf-8?B?ckl0dXZLVHlFZFQ3QUJwM0Zxczl1MEUwVEpSYkpvNCs5Rk5jUEhCKzZteXNk?=
 =?utf-8?B?UEJlTDBUMWVRRTNxUUlkVXRrRGx6OHlKYkxiWlhkUnRxd2REL0ZTK2Iwd2Jp?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <037A9382539D6742A0BBA04A4936F5CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435dff82-70b1-4711-0808-08dc90ea94f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 05:33:57.5328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jzswvk2vFhGCHqRumkExqbxBwTTcGGrJNYoHpYIQebOCf3a+Xvmlfry7sNXi5qYTuGCJwtwIbi9wmKqEMivUQ2dpd44eu2ZV8FWUKJ+QxHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6611

SGkgSmFrdWIsDQoNCkFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5IGluIHJlcGx5LiBUaGFua3MgZm9y
IHJldmlld2luZyB0aGUgcGF0Y2ggYW5kDQpwbGVhc2UgZmluZCBteSBjb21tZW50cyBpbmxpbmUu
DQoNCk9uIFdlZCwgMjAyNC0wNi0xMiBhdCAxODozMyAtMDcwMCwgSmFrdWIgS2ljaW5za2kgd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVHVl
LCAxMSBKdW4gMjAyNCAxNToxMjozMyArMDUzMCBSZW5nYXJhamFuIFMgd3JvdGU6DQo+ID4gIC8q
IGRlZmluZSBleHRlcm5hbCBwaHkgaWQgKi8NCj4gPiAgI2RlZmluZSAgICAgIFBIWV9MQU44ODM1
ICAgICAgICAgICAgICAgICAgICAgKDB4MDAwN0MxMzApDQo+ID4gKyNkZWZpbmUgUEhZX0xBTjg4
NDEgICAgICAgICAgICAgICAgICAoMHgwMDIyMTY1MCkNCj4gDQo+IEZvciB3aGF0ZXZlciByZWFz
b24gdGhlIGV4aXN0aW5nIGNvZGUgdXNlcyBhIHRhYiBiZXR3ZWVuIGRlZmluZSBhbmQNCj4gaXRz
DQo+IG5hbWUsIHNvIGxldCdzIHN0aWNrIHRvIHRoYXQ/DQoNClN1cmUuIFdpbGwgYWRkcmVzcyB0
aGUgY2hhbmdlIGluIHRoZSBuZXh0IHBhdGNoIHJldmlzaW9uLg0KDQo+IA0KPiA+ICAjZGVmaW5l
ICAgICAgUEhZX0tTWjkwMzFSTlggICAgICAgICAgICAgICAgICAoMHgwMDIyMTYyMCkNCj4gPiAN
Cj4gPiAgLyogdXNlIGV0aHRvb2wgdG8gY2hhbmdlIHRoZSBsZXZlbCBmb3IgYW55IGdpdmVuIGRl
dmljZSAqLw0KPiA+IEBAIC0yMzI3LDYgKzIzMjgsMTMgQEAgc3RhdGljIHN0cnVjdCBwaHlfZGV2
aWNlDQo+ID4gKmxhbjc4MDFfcGh5X2luaXQoc3RydWN0IGxhbjc4eHhfbmV0ICpkZXYpDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgIG5ldGRldl9lcnIoZGV2LT5uZXQsICJGYWlsZWQgdG8gcmVn
aXN0ZXINCj4gPiBmaXh1cCBmb3IgUEhZX0xBTjg4MzVcbiIpOw0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAg
ICAgIC8qIGV4dGVybmFsIFBIWSBmaXh1cCBmb3IgTEFOODg0MSAqLw0KPiA+ICsgICAgICAgICAg
ICAgcmV0ID0gcGh5X3JlZ2lzdGVyX2ZpeHVwX2Zvcl91aWQoUEhZX0xBTjg4NDEsDQo+ID4gMHhm
ZmZmZmZmMCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGxhbjg4MzVfZml4dXApOw0KPiA+ICsgICAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgbmV0ZGV2X2VycihkZXYtPm5ldCwgIkZhaWxlZCB0byBy
ZWdpc3Rlcg0KPiA+IGZpeHVwIGZvciBQSFlfTEFOODg0MVxuIik7DQo+IA0KPiBEb24ndCB5b3Ug
aGF2ZSB0byB1bnJlZ2lzdGVyIHRoZSBwcmV2aW91cyBmaXh1cCBvbiB0aGUgZXJyb3IgcGF0aA0K
PiBoZXJlPw0KPiBJbiBmYWN0IHRoZSBleGlzdGluZyBlcnJvciBwYXRoIGZvciBQSFlfTEFOODgz
NSBpcyBtaXNzaW5nIGFuDQo+IHVucmVnc2l0ZXINCj4gZm9yIFBIWV9LU1o5MDMxUk5YLg0KDQpU
aGVyZSBpcyBhIHNlcGVyYXRlIHJlZ2lzdGVyIGFuZCB1bnJlZ2lzdGVyIGRvbmUgZm9yIFBIWV9M
QU44ODM1IGFuZA0KUEhZX0tTWjkwMzFSTlguIEFsc28sIGlmIHRoZSByZXQgPCAwIHRoZSBmaXh1
cCBpcyBub3QgcmVnaXN0ZXJlZCBhbmQNCnRoZXJlIGlzIG5vIG5lZWQgdG8gdW5yZWdpc3RlciBp
dCBmdXJ0aGVyLiBDYW4geW91IHBsZWFzZSBlbGFib3JhdGUgb24NCndoYXQgaXMgbWlzc2luZyBp
biBjYXNlIG9mIHVucmVnaXN0ZXJpbmcgUEhZX0tTWjkwMzFSTlguDQoNCj4gDQo+IENvdWxkIHlv
dSBwbGVhc2Ugc2VuZCBhIHNlcGFyYXRlIGZpeCBmb3IgdGhhdCB3aXRoIGEgRml4ZXMgdGFnPw0K
PiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+ID4gKyAgICAgICAg
ICAgICB9DQo=

