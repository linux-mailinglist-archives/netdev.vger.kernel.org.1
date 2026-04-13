Return-Path: <netdev+bounces-278047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NaIE0TO3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:06:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5573EB18A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4713E3008320
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79BD3BE145;
	Mon, 13 Apr 2026 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3dSkadM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7253BE159;
	Mon, 13 Apr 2026 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078395; cv=fail; b=sLEGcHaXq8NM0Go5JTdwyojKY7T7Oo4lJlORopWReqbGldr0Rllu/lGL9E/RMDg6TzQTCCD01LKA13UPaWVYAf/ixbzHQnWpZCiXA98LSTAEzAgYkSXNRkneP3847HFR+9MefvsxaHI9nH/zcpvr9f9BNywE4zbbZ8zf0/ckqBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078395; c=relaxed/simple;
	bh=KBK2E7QiyKADSHTVjqsnMKUr82SRUu8zpVloX1ccoXU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KHyI6QGjltvJy1i9ldibMCUTcECe82bdXbCuxcA0fLOq6UQkOqIuliYaMVI9ww7makiqjHX6fRgcyZkDvjwHOd9sHiQhyLl3r26txp+V3DKXjUMhdFMe1JzMC99fp2yVNgDlOpY8fdLzcxgnEY9K61wq8Qi9wSlrkhQzPf/e9IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3dSkadM; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776078394; x=1807614394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KBK2E7QiyKADSHTVjqsnMKUr82SRUu8zpVloX1ccoXU=;
  b=W3dSkadMs+N5fBPub0luKP7ocLPPovuASjPOonmTjk4v/+NwT3ciII7R
   Hb60tdBhCqHopQQwUg4/HGKK1IYCFkwH98c7pdd0xbpIRW4omqNGgaZRP
   H24sohc7f6fwNOYCHhM7gFfXuILmrfAYQSd8KxcUBJnINRa2VGvO18IcA
   QUvLCfMdMm1bCPMSIGKqzKwH+AOO0NVvs/NRpKso0Lcw0wXRFaa3pY4vE
   gSxpJpx+so41U67WR7f7wnmdHXSPJ6U3LTYS3k22FLfN7++sYDrn9iVMu
   qsfApYCEIskFpN15kKafKz+s5zldQhPQYVlGEMFQA7u0V4GLXCq7GDDyT
   w==;
X-CSE-ConnectionGUID: 2osQyaXOQYGtgOPj6GDM1g==
X-CSE-MsgGUID: 1OAl5pkUT+iyPXEVtDGLwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76175835"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="76175835"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:06:33 -0700
X-CSE-ConnectionGUID: mlvWuf6pQ36MZO9UaIyyFw==
X-CSE-MsgGUID: +B8Kz/1WTead0PEI+pYKKw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:06:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:06:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 04:06:32 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.29)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:06:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGqJWnRxWYdNAMCV0/RRjfsvNmr8JRF8DJphqZXAWDsXjVvCtfm41Fhn1kB8WmVhL2x4p2K8KiA0rBSQ4OMSZDjDFCm+ocCVrSqcUbvrZ57lwRCGiu7xFsYR39fRgH58c1FxX8fs5WVo1p7xA2GF4jQR9zxY2QNt2XsiegPtbhVZlwdux8PP3N1hKSLMhRRkJ5y7ezDvg/kWFZV42Rczkq8mZ8oM3twkAEcDvvZ0NX6bv5PS+GKOM3uU93gRxd6n1HQvDGR+KmKl6vtbgYbR7RzO2saVXO31C+oVSt8+8u4AGBR8LIKicGA3ATZ0QXo1u0FQBtFz64b6q+lwKBegsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaUQkm3ji4uWuAHcc09ZH0307zoZoU5oSbymUpchdyw=;
 b=iSHgVw79zRbMvHw+5kyyoEZzfOVPlGiyYF/10vLFKbya6izMK+k1F5B7g91Y/mYQMaOWOwR9/A5BRSW4p2ouIJEvSORtBDxGpkw5H6Os0GDSb4Ln7Y1U/zsMO5+SH1hd0zOTg0mQXUzuw3OpHuccEPoKLfvQP388J0sXTf3CArTvqbcexP6m+sJqBJ+pMZY6DMZd5/2gzF8Sd1DcpPZYe67gZpoLC4jYlUHq0GubGL6yjHOnDjQExdu12r8Ejp9Pd3oq1F2SuUjbzLfmo39IBDw7lOI7Sd3ypGJFTFc5FwxApjkYavGjzJLXB5oVeZBEOBMXP2QeXdfCX27sf6x5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB6841.namprd11.prod.outlook.com (2603:10b6:930:62::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 11:06:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Mon, 13 Apr 2026
 11:06:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, stable
	<stable@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] idpf: fix double free and
 use-after-free in aux device error paths
Thread-Topic: [Intel-wired-lan] [PATCH net] idpf: fix double free and
 use-after-free in aux device error paths
Thread-Index: AQHcyZu/E8M8djZt4kS6cHaoKhkcRrXc191w
Date: Mon, 13 Apr 2026 11:06:28 +0000
Message-ID: <IA3PR11MB89867D9A3665ECA17BE60ED7E5242@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <2026041116-retail-bagginess-250f@gregkh>
In-Reply-To: <2026041116-retail-bagginess-250f@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB6841:EE_
x-ms-office365-filtering-correlation-id: 02cfbcc5-12c7-4a5e-71ab-08de994cb647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: ywiKFFVNcM5Hj8vTWe4bBfhbxe7mQINahQZCoE6npU9aRaEwbM9SombKlzPc/3OrnyBly7xUiS/Kboi5B91mjGuww3Dw15bdMVze65RG4rPio7E2zJPoVn9LVp4TbetlEf6M47FtpTEJ9P3XcEdBlcRcG6mJS8XKnCdfyMtdfO6im3sOZPP7Hh9MMcfrU5ilgq7S0NAUJsHfrQ5OWFAhwzWT7I8nHwtmxFWtP9IMArBgpkYY4SU5+i6a5PaEyLrmOUBFIHbYI6CpU8HgPPzoAI2vrkNJt5SOegLhfsIZrwO72bA5af/17p2tqEdNnWW+oXlTMOIKDbHqvcO5SYpihTl0Xc4qUhKFdo2CMSkR1SHGF5CaJmI4wMe1Uhsm+0shWttwgyE2RB9K4Xb9TJYZow/Kg2/qwdDQEVzJ63tCq3PRZECJj7HjrRSZnS6s34uUCb4WdsDOeEtWutoSs4oZSu/5URopbg69Bu0sleIZZBOA5Gj771sTT/jMFD5GkDLjVggI+gtbEc2qODxLMo/VhPmwa3tSa6H4N5Yu8ym7H8dP6ArgftX99Vib/RzhCKA1/T550Ti/GtPSYb5mBLDnIhXGccuj8GexOps93SmZoOlpBpI8B3TSGH9nuv09IrfiNhlZcTJ8DoQTHbrHxDi2j84drU16+GrVx96XS66IiRnwv7WdU9LF468H2UQz5uAqj2r0K5gkE3Ky9kHB6p+cYuopfFeCpEI+fMFBEVgDCF2ZIdssCWtE/5pnjHO29fVu3f7dcPXiyX7xL7quoZULVygL+uD/jS2IHd0T1ZaVp2M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dZpxGD4v9W8zWJC3cb4OMAyD6U1UCLVIlm4bKUf8CO5edEZmTbIv/pjQIsN4?=
 =?us-ascii?Q?IvLAoFOM9tXovM30mdx1s169daRyNsX4mIugsmMj0bROmuSEDrOjiNIwnBzj?=
 =?us-ascii?Q?fuwoQ/C50FgCnm8k2QWQSiEwynP5y8rF0Osy3yw1Liy2seQn32mA0eHGfHBW?=
 =?us-ascii?Q?OxIlgvjVYp/AWd81X15F0kS89K2YuhKq44CEXz75XLYOD6xiYeZ/0kUUeQ70?=
 =?us-ascii?Q?jRIoE7OYmkbHiHWavkGHUanVP4Max0K+Re11f0Y63UWZo+jDhQ+1nC/pXkec?=
 =?us-ascii?Q?WFoG/qN1QoiCFVc/0CSLWHDnXMfYS79TVlxKBGl9R0pT6NzETZTpgVYm+VTx?=
 =?us-ascii?Q?xe94G3Nt+7QUjGgVcn9/UXnfkMGIKS7dJSqu7LW0cy20eaZep0H10dVNLLq3?=
 =?us-ascii?Q?oZMUj3WiJuLzK2RtsMijAeRCn5DjpXz914kB3bqmomP7eYD52uo9YuIVSijk?=
 =?us-ascii?Q?c4LjCRLxT31tVFuQYawoM5haZlbp9pmrsWk5u0LM3P9dptoHx6i98c8e0OJT?=
 =?us-ascii?Q?pqeIvZJZlDOKMmhyMDY+KGTLEGkEUCLPpiOYGSAWTFwd8R42g1c6Z+6KePnn?=
 =?us-ascii?Q?z3qz9cq1Eul82ujgWnmV10Vrumt2+EDQcyhxEk5bmAb9NmG+GkQLviM2b6F8?=
 =?us-ascii?Q?kiV4fA4w+60I9f81tnYVKoVyU2tSnKI2iT9vJcX427VTFbWnO9WZyrgamIkj?=
 =?us-ascii?Q?mYx8qMNwARUHZJQlGl0WiKOeD8jatBaJVLVMEUfKla7RxlvNjOEcOrLkMY76?=
 =?us-ascii?Q?tMzwdqxz+hr5UkD1g9H8QAIO0cZ2tcSWF0cf6iN8W+/G1lfu8YoiEGVKalyF?=
 =?us-ascii?Q?MAfWNkEAiq2bx6I1DBOcSELapzXWD/s1nO8Mi+5pXldoGwtqd85MzusMi+Hc?=
 =?us-ascii?Q?xcgrfJl4nb+z456lrWza/rrILnTDJ6LztDfgGt7ZvdZdu/TXDem9OS5XPqyt?=
 =?us-ascii?Q?L2PX/1DLhiQ9yutzRuCKhYiCHv+ZE6HbYtofliYLLvApk8MsWaWkZTtklxSH?=
 =?us-ascii?Q?5pupMxdG/Mf+ly3h7VjjA8GEC5AguAc6Ou+6LS0vnkgq6gGDvMsOL3alaJox?=
 =?us-ascii?Q?pMBI88x3fD9LZwbt4aQjkHUrcVkJcaC3OboN3CuSlf/lTQzSMmlFILw1YhxI?=
 =?us-ascii?Q?ONIKXxHYXzQvGJMMkei9KhUWu9GMVjyT9kGdiUbdWX3O55lKjo6ETJX+BTev?=
 =?us-ascii?Q?rbMwcAbWB2GRJfRLcs1iszC3B4BU5zRhU9hujfziTJrEmpU6LO+3ZKD9N70V?=
 =?us-ascii?Q?kdlayVhePrTGwmje0mq7FgXFT8tDgmmT3CUOGWVJWfIMXIAmtXLmzjfl2acf?=
 =?us-ascii?Q?V8EO/62moeoUtWhwC8Y5t00fYYp9g27jvJuOs4MatSg/2pPYp9u1qdb4erhX?=
 =?us-ascii?Q?hALIaqSlkGQTpxykrXPvS+8UVVtpFO71tptVn5+LaJJh9wFWdw+LbQ+6L23g?=
 =?us-ascii?Q?BZtcHMkC55UEhzqeslTTh+uqCtwnBWZYATc/ZwHve+YwDTCYdkP721jqZmqK?=
 =?us-ascii?Q?Ix1bwVTXBOoS2uNI+6o25TE9XuShtl5iFG3dYtQclN+Y6oGX/KyNVVmI7rCe?=
 =?us-ascii?Q?OOzxg7X/ld5qqvCfEp2ZGwRXXuFp0Q/gSz3FtX0Ui5pn8sF64HHAgWQgLjBP?=
 =?us-ascii?Q?RdxVwSF4TpnUaP/SISXKLhIwNhLeBu5DKH2WOGp4eKQdUZy/N7uisRtt9PE3?=
 =?us-ascii?Q?oWcMJKFJAgCOaoPalP0SBTT3XHUmkfbTNsHjeTHhsj57vhgXrollYN3mKrU2?=
 =?us-ascii?Q?4/Dz4otSWO+Ei1hasrrLpuzA+vKcMb4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L4KbBUS3i/6lfAE+PsTtCMKxHuWoPF1fEPLF2LNTZJVuEJi+brYMGQWtLl1gy3Q1KSYie2ycIfAMxPl53tB6JpzZD0ZsM7dJdTvU7gU24cHexMrM1zLJy3mPcUJtCAJT4bxgfMbk/GEkFYNrl92e1hNQgGij/Sk+eFnNHPuiUoKAOEUiRtgNjcDshHwW24m3HUoQi8srWrU+OH6eVexetAH2Bx0nmp42omooZox7T677VFPG1624XhrCxz+6MPLv879f07/0T7mEGtFE0SZS35Ir0IQ1//RFw3xNVkVlUvKx1/1aX/r+zh01uEC2z32/55xiFozJasJd30PEVGt5cw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cfbcc5-12c7-4a5e-71ab-08de994cb647
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 11:06:28.7827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ogz87aWeiLiYwGkOwKNNSWfTG0kcC+a4QYMhjLYn/q/CwXU/VGR5oV4yOgu9it4QwTz+Xae4jROTrIycTcnn1GiwCuP1Ir+YifuhdH8FYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6841
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278047-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EC5573EB18A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Greg Kroah-Hartman
> Sent: Saturday, April 11, 2026 12:12 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Greg Kroah-
> Hartman <gregkh@linuxfoundation.org>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; stable <stable@kernel.org>
> Subject: [Intel-wired-lan] [PATCH net] idpf: fix double free and use-
> after-free in aux device error paths
>=20
> When auxiliary_device_add() fails in idpf_plug_vport_aux_dev() or
> idpf_plug_core_aux_dev(), the err_aux_dev_add label calls
> auxiliary_device_uninit() and falls through to err_aux_dev_init.  The
> uninit call will trigger put_device(), which invokes the release
> callback (idpf_vport_adev_release / idpf_core_adev_release) that frees
> iadev.  The fall-through then reads adev->id from the freed iadev for
> ida_free() and double-frees iadev with kfree().
>=20
> Free the IDA slot and clear the back-pointer before uninit, while adev
> is still valid, then return immediately.
>=20
> Commit 65637c3a1811 65637c3a1811 ("idpf: fix UAF in RDMA core aux dev
> deinitialization") fixed the same use-after-free in the matching
> unplug path in this file but missed both probe error paths.
>=20
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: stable <stable@kernel.org>
> Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create,
> init, and destroy")
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create,
> init, and destroy")
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, these cleanup paths are messy, but I couldn't see a simpler way
> without a lot more rework, so I choose the simple way :)
>=20
>  drivers/net/ethernet/intel/idpf/idpf_idc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index 7e4f4ac92653..b7d6b08fc89e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -90,7 +90,10 @@ static int idpf_plug_vport_aux_dev(struct
> iidc_rdma_core_dev_info *cdev_info,
>  	return 0;
>=20
>  err_aux_dev_add:
> +	ida_free(&idpf_idc_ida, adev->id);
> +	vdev_info->adev =3D NULL;
>  	auxiliary_device_uninit(adev);
> +	return ret;
>  err_aux_dev_init:
>  	ida_free(&idpf_idc_ida, adev->id);
>  err_ida_alloc:
> @@ -228,7 +231,10 @@ static int idpf_plug_core_aux_dev(struct
> iidc_rdma_core_dev_info *cdev_info)
>  	return 0;
>=20
>  err_aux_dev_add:
> +	ida_free(&idpf_idc_ida, adev->id);
> +	cdev_info->adev =3D NULL;
>  	auxiliary_device_uninit(adev);
> +	return ret;
>  err_aux_dev_init:
>  	ida_free(&idpf_idc_ida, adev->id);
>  err_ida_alloc:
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

