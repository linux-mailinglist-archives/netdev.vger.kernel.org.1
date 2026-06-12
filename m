Return-Path: <netdev+bounces-298556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Pa5Jo3QK2o0FgQAu9opvQ
	(envelope-from <netdev+bounces-298556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:25:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B526783B0
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:25:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gn8j9diU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298556-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298556-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A7F3013A8E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BCE399346;
	Fri, 12 Jun 2026 09:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712E3769EE;
	Fri, 12 Jun 2026 09:25:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256311; cv=fail; b=XQ+PGbSlLMQHMVAiWrv8zZIGF668d2vYvZKVK8fCe+Y5ZO4GsHQqbnyITVgCK1jvB75Fw9KfuIgozqPhbfHdM73ZWjFT4QcPzCOX6r/Mwy95b9CrNEx0kn7jzCwdEbkf4A2jy4ThUMKj+6w+kIArlbY0d5Er6r1sS3olw6cXFYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256311; c=relaxed/simple;
	bh=iTYOKpFBlt/c3VEVSRVExoSXW2gP3YiVeVVW4wMKZYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IAxC8s12sSzoGU2sIkw2jK7b7ATQ/hoej8rZYAHH8NPzqiovRpm5G+7JZDsMup7zizED5heVrnuhVYPI9ecw/DqdqGT2d7Ex+B9mk3oVuII2y3MtMBsFpWT5fnWKkF/40kVUTS7it8SCYvtN32mFU2Q6QYgZuxu0TXzoHSfLavU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gn8j9diU; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781256309; x=1812792309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iTYOKpFBlt/c3VEVSRVExoSXW2gP3YiVeVVW4wMKZYw=;
  b=gn8j9diU5gaQVMeB7K1j5H2BhGKUSnO2zpcPTWPxDSNIFMaQi/KqJJ76
   wCbbA29MEXLzzdTD5zKR7aMizsMD2wWdB+MSnBo/HYWICpwLDBh6K2Vr1
   uapY7urtE4APXZ/lHnsaJ6ecXxNByIvL6naHvJU1avJYW6GgQi/T7/p87
   i2ZntYQSDFzGvzOpdiqlctU+F35486RmZpXWdMK7oODIFb/cqx5aFq3q7
   u1GUucrOfI9QMQZvSSeadYlfQD96My1uVC0e6KKa7ZWs61YpYQwr/8NCU
   fvvwyKOZjCGPQY0D3sn1ZhycCvL6cMgnV/zg4s9JV0jIwcLidfK+6UNNJ
   A==;
X-CSE-ConnectionGUID: dTfMaC1cSQKEgrmm/jjnrg==
X-CSE-MsgGUID: /bnPjGDZT1OMvZaBu1srfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85982967"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="85982967"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:25:08 -0700
X-CSE-ConnectionGUID: 0PqRYRt4SZmz4/O/Jl9zrA==
X-CSE-MsgGUID: STNzxt5WSvWyBU/EKawV7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="240422692"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:25:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 02:25:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 02:25:07 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 02:25:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kubRyig/Otpv8CiKFyml52bzArbe3CPTZf07kZl6VJyn2CShhBbLKIfk4crB7q/SM0lM7UNfw7T/zm+XIEMUGa1dZSrpOLr90Gc9lKIe/mQOSIQirJK+7nIq9zTDEAmlb8B45dM+Ok9roGUkTm4JjfxC8+lXbV14lqwKjtHtAhg2Q+hnnML1BCkBcxmnBdZaJZVYcnOBtP9k1LpUAmwkptsVNyxivbQut43rDSvYgtTkpEGgSs1vgqYCiX3gkbdYSVA51dJelVzuR6wxYkaC+vcaI8te8r2FMqGLKn0ZiML41G8lrEcq7+KkQMgozFI+WPSy0Y3RFufCabgh1V6Nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTYOKpFBlt/c3VEVSRVExoSXW2gP3YiVeVVW4wMKZYw=;
 b=hv7/Eij525fikU/A7hV9HoEXKayRqsqoniwhvKEWQJUh8SZsk5y/RnKOwcnB0I7j7dkCTIO6B89cPqfjGU8T5x2qDFgKDGWGgCJe6ODCjGyZEi7SfeTp3FckhuvCpw62+5Q/dxxhNenmweKo+Qx9L8KtAcrR9UkTB1nY76m+OnrWkYR2QnLYaLmZzj87b+oA+pLA2rGexd1orcN9Sz+QMKEkn5nwTsgJdcX/IR2l4yHplLjpmHTIQz9roOEmrKRpiX1sYo/01cMaaLsENmqWluRrreMlwVE3qiuuMETekvgd4Jy1NbajMAAv4LQ5A6AQz5GO8TpsKuRmcuCZmF8kXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DSVPR11MB9717.namprd11.prod.outlook.com (2603:10b6:8:34c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 09:25:00 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:25:00 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Wentao Guan <guanwentao@uniontech.com>, "lorenzo@kernel.org"
	<lorenzo@kernel.org>
CC: "nbd@nbd.name" <nbd@nbd.name>, "sujuan.chen@mediatek.com"
	<sujuan.chen@mediatek.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "niecheng1@uniontech.com"
	<niecheng1@uniontech.com>, "zhanjun@uniontech.com" <zhanjun@uniontech.com>
Subject: RE: [PATCH net] net: ethernet: mtk_wed: debugfs: correct index in
 wed_amsdu_show()
Thread-Topic: [PATCH net] net: ethernet: mtk_wed: debugfs: correct index in
 wed_amsdu_show()
Thread-Index: AQHc+jdtzgaL5kbn5UWD3mCBccZvprY6pNTQ
Date: Fri, 12 Jun 2026 09:24:59 +0000
Message-ID: <PH0PR11MB5902816638ABEF8EAC1C1D48F0182@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260612064501.203058-1-guanwentao@uniontech.com>
In-Reply-To: <20260612064501.203058-1-guanwentao@uniontech.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DSVPR11MB9717:EE_
x-ms-office365-filtering-correlation-id: 9a8608e8-3d49-4b83-0c8b-08dec86479e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|11063799006|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: NdAAxlvQV2jCWFHjfbcaQolqavDMMhgFWUW3Ugn7lpKBMvsHPvT3l7KaTRlOtuRZxUiEGC6wIrGyzU6gjwz0bO5xSWiKYP9mrGMvTmUPyswuox04DNEQCtjBINmdo9JagjK5pdniTPFz/ILZybawiQ7eYYU6nTk6KmeehM6dbZOuOUAqiR3QxynsBj9TS1hxd3MEU+3gevCpyYkePvfvkkOJtfeSpDcPWF6xV4iIEoylEQWo3WJhslAcV2trPrsOfBy2KXCDvd8nURavapM2bN5E/6efPzVX3NfAyiQKBie5/94XuIWUVldEii20xcWHq0E+C8b9NEaK2JqcMfbCDqNo39js8LGvTH2nr/tGUvnZlS3AByvs87Xv5tjdAbQPPJsZJAwCnoMWzOqt6/+wdPaFnVu1AwTxxFl/cgCh9zIhqOJtgblOQKyOfNY06MyJwZQxBTslj+fdpjzepuRtliDFkYplbU0APh26TZu6B9Qa/mN+rq3PCs03ThDPT/eDRlEXO6+NbDsbNzLWpUE9Xf5oQveLbZvU9NAEUFAjMrPvuyZqMFqGE7HUyfb9ERwPALX6WeXp0MvWyB8eljRpyILl1HUa/Boibm2UC7BYYz68HVT8Y/+B13r0Vo3MxcNDj6+t1USkbWPhRTpR6DWh8FqgxnDPfbAlEtE6AlmY+BzEUn/ROF6xd65nyjspaNA/70pxrAuDYBk1X/zadir+UYwUo1/SbKrLn8st0cI1lnZgfsFI7xdMLiUN/jGUp+b3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(11063799006)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zBaYSUiZOphizCJXnnpR9aPr8zzdxKVy/kiQ2zfcAGS1RzoHFffnwGR8C7iL?=
 =?us-ascii?Q?kwxQuEeRkmV7LKXasiY2TJOHalVEd1lm1lq0EZK6b8qdfWFxS2SpFC/RyHHO?=
 =?us-ascii?Q?9iEhKx8V6kVbgk+XJXBtijQg51Ag3iBP9/7C3r0N8j4+J0YFOeZKK/DA0Mc4?=
 =?us-ascii?Q?2XozVwV+NjDpviBgdGjXV2W/xafVCvjOERFRU/UkYnxaFlL1U1IvdFG3xjnQ?=
 =?us-ascii?Q?P+qKGE4GSMPao23dZ5wnF0GWbJlhiF62MVVX1ZqmQys+TNfFcQLTN1jDzR6Y?=
 =?us-ascii?Q?a//g1HbThjGRoiJsoj0ksCnEypz0WArlce7KaLkABnJQFD+RbIrzesm639V9?=
 =?us-ascii?Q?mxMAJxa5QDUG3Emx4WfChPJEjD5OGAbJVH6TWcLBUI7o/u6IQMdIK4gywYx/?=
 =?us-ascii?Q?jD99TmLf/MwGY4NEKhMQM1/diDsTo3bLRIUxf6OpAK/pivmXQ8sQBlBavdyg?=
 =?us-ascii?Q?9U0rnRm+8jETbfwmDmk826awMHIJO3p54M+vq50xBT6Dz+EIkkRC+ABuUutl?=
 =?us-ascii?Q?inPe2Tknlyc7iTExdtbVRNU8/u2Y4IuCxkIeRG6HPT9KhiVeroBRzV9BZqj0?=
 =?us-ascii?Q?tE1ndSI4UYICpGzpo2KrLpulPkYrzx4KAWY+4s8PZXBcYvYiV9rhE9v/8o1A?=
 =?us-ascii?Q?BnHxsm8Kf2x0VSuVVT1nvbn2I9T9K2uyQvAtkm44Ua5bVt0UYRMUK6wnCuPQ?=
 =?us-ascii?Q?bz0qgbDghMut/fPyZ5hLLeMx37e6Ib1MOYirnuoPa2ucX8nE4O5uV8OP10+8?=
 =?us-ascii?Q?C9GTvrilxPIOQGJwfixd2kbr6XoJZTXMO12Q5M7+ObCLyvdbqUadAMVE+Ytw?=
 =?us-ascii?Q?9TLHJp4UWBOFmqzMNGN7ubsWTjGFDEMVIylllLrhOTCn0qtkU5YDm3CVnVRS?=
 =?us-ascii?Q?nOsC10+84WcTwK54QB7nPcnHelBuhGYXMLbOavAUnBueYlkO6pST/KVMJs+R?=
 =?us-ascii?Q?M8/yIW//Jlw1QaP+UdJUxlhwWCu+D5PKjd3j+cX7O6dxzzBxiujZlHbEvR5s?=
 =?us-ascii?Q?MZ+7fZplzrV1e8qbvNi7jrgpC6G0O4nnX2sf4cSxIgp2GtCCO+ihnQqFquQn?=
 =?us-ascii?Q?3hxoY9ILPxgIAiFAql4JaqhZbLvgDRwVEwuojPHt8DF2rWjN9aGH8phieYsv?=
 =?us-ascii?Q?S1fk9MViil+7ufC/H/WNKJeFGANHSBnw/58aK0A4xfKatVyWrYKINOl/8fPN?=
 =?us-ascii?Q?RCCjiyvGetuVlJhLvQjuHR6N0IwGI3re2PmOvWkoRCZmmhvhq3waJsj1Ooje?=
 =?us-ascii?Q?53MACtCUMnNNgSJQ5feAelNpJrQ0J3puPGHqPThputqsF2A0Rnq/H7GgMN6Z?=
 =?us-ascii?Q?/hNyytw3RLllyWqg/UNl68cLKSIeC3VH2Yp/kCalKk8tmCP2ZL+uDXrKIRNi?=
 =?us-ascii?Q?QWIUZCJ3bKaYvkY9+K2q61J88iFmFD+KpvdiGIr/asfd1sLQBB9298GWgman?=
 =?us-ascii?Q?6VwjKy/Xxqs2WIe9mVzoE1sHPDijIENG3NleXApQIwHd9akhqUAjbqlK8lXG?=
 =?us-ascii?Q?TGBMNlb0/3lTv2OJG3SiL39X+f2AwuALlJNh+NUKL9A7UJpwceCp+WwJgweP?=
 =?us-ascii?Q?1McrvH8yL/CJpaOpDk9uWQSrP2gzhXsLblBfQghrsVh6n2hQuz0lL9O+RH4L?=
 =?us-ascii?Q?PuvgpBhwQIkKH0wPuV9b1b1phD8ZME2Gg0F5KqIVJkOhiHPMBMixuaA+Zu8y?=
 =?us-ascii?Q?RMgD0Lvr0XihKVIv0/Y9JeIhRfvdRTkcZBr1KroEmmT1NeHbVxtDjugq7pNf?=
 =?us-ascii?Q?6bJaj9LhoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MRt2/Po7YcWY7r5NhhjghKmsvILok3xlsf10tYMXy2RK+6gUKdseKGfNOBaGxgRAuZaTBOfAA0KSzT/6B+11imXto1MSIppCR9CcaYsCKDtGD2sQANw3bNrpJD/8dLQJAbrdwzxGPY91fPAZOJBufSHsw6qqn6HFUHnkkPIT6I8GVxTrz807SivAn329gSiKaY97IjC1ZJuRzNbgfH+WDUfaVtB3se8uOJ8aUH3jYXCk9VnAT8Z0sK097aoK2uVA+oKAggPSOQev9tAyOI+pmxp3r+iBObDSfM8BhJDjeLeAJYgMdHHTRu6UzMdOq9J+UdrKPMpP09seEkBv0jdGnw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8608e8-3d49-4b83-0c8b-08dec86479e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 09:25:00.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PWbuGBpGASz+jBWNaN1eNG3LE/vwdz4fTE48fzpWgQiI/Iu69AaeOC/Vh0DtuBU9iJnn9XawPit0KcpLmeMpARMLOWlhgRB4ZTrCA16pjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9717
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298556-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:guanwentao@uniontech.com,m:lorenzo@kernel.org,m:nbd@nbd.name,m:sujuan.chen@mediatek.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:niecheng1@uniontech.com,m:zhanjun@uniontech.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:from_mime,vger.kernel.org:from_smtp,PH0PR11MB5902.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7B526783B0

From: Wentao Guan <guanwentao@uniontech.com>=20
Sent: Friday, June 12, 2026 8:45 AM

>WED_MON_AMSDU_ENG_CNT point to different entry by 'base+n*offect' mode,
>correct the wed amsdu entry number in wed_amsdu_show().

offset?

>
>Fixes: 3f3de094e8342 ("net: ethernet: mtk_wed: debugfs: add WED 3.0 debugf=
s entries")
>Assisted-by: Copilot:gpt-5.2
>Signed-off-by: Wentao Guan <guanwentao@uniontech.com>



