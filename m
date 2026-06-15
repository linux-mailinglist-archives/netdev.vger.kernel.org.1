Return-Path: <netdev+bounces-299560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XmBxI0BBMGrfQQUAu9opvQ
	(envelope-from <netdev+bounces-299560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:15:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCF46891CA
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:15:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ENce0SEO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299560-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299560-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92E67306D86E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD933090C4;
	Mon, 15 Jun 2026 18:14:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A6304976;
	Mon, 15 Jun 2026 18:14:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547284; cv=fail; b=Lsbk24DyrJV3W4dAVWS279xLigP7uRJ/n3lthIqD7JvGbq6Ahk1KL72kDyyeObuvQJRcElzMTcw/iFuDZgfA20dsyJMRaAWzyWmr+A5WWDWxTmea1jFxjEih0z38iX+d6mBPoferVxR8D+ELY2W1rKbVavlbIjSBuep06wRM3AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547284; c=relaxed/simple;
	bh=ke+tnYdFZT7P94qsdfDjm+uFNWFP1aB02kb1efk/kXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ih6nGjJenop7qQHo3ruioKamFbS/G1TPsUEq3Bg+EOUISPSOsrVaUB1tV7ROJaTq8lCJqDufvL9pSakVnuefqGbaLaGKvyFSPt6AvLCairieumGwlfnPJO2yLVQbHB22JQ9HfhP6sgYeZhDm3prLtfHcBckTeD+zn8+Yrl/8LcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENce0SEO; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781547281; x=1813083281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ke+tnYdFZT7P94qsdfDjm+uFNWFP1aB02kb1efk/kXc=;
  b=ENce0SEOeqgY5lPFrIY+J3veOfpRMCf73QQrr4pFL/Sb6UaIGw5StRUj
   FHW7wubbFe57aMeWe/8MLioWSNuImz7Kfp0tf/AoRPdTMB2lEO6zqmAIR
   gzvmUQaPF05EWuC6BmyOGfkc2kCwGnFWsdalY35Key8Chwtdef9c8sK0d
   plsq37jN2SxDTppOa1Uc7/RRc0pgeDR/xkSKqxYWLgrm4gS6UJ9jz+5GF
   GXuRj220/1+SWcKH8t6CmARTkYno5NNS0lPqk9GmSjEC7/MMbFBELc7Sg
   zG/SUgvxKcDoOfygw7RVVljFYy7kAh3JX3H/u9ypCmtNF4LXWbzx9fv7L
   w==;
X-CSE-ConnectionGUID: jpE+aYy9SaKv4sQH0LlrHQ==
X-CSE-MsgGUID: NiSj5PKtRo2Vyq8SxeLBUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="104968440"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="104968440"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 11:14:40 -0700
X-CSE-ConnectionGUID: mHvUhZB8Q5uG97VgY4yMyg==
X-CSE-MsgGUID: a0ZpgupZSWaqd1w8GwoCjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="251834336"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 11:14:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 11:14:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 11:14:40 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 11:14:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvXcZs+J/UHH6JImGPazQ8fMib7L1J9yo8cOQPz6KUduN5dAt8QynlPqmvQGYnmqOI9CQJyLNe4I5Cq5ncjkD/PcMKAUQU2wC8Y/5efCQIKEt7BnKVvb3d0CmUbHzNHgfa4d66pSNJOpIcz+M6MtWoyUX5LWAwFPtGPQ8d9S7bQNNTjDWoUrJ9FLLzb2OOg5rDU95wSufkgW/oDF/FEElhq2j5iXXjLw242UICiqgOU3C2Tt2dsiX+VZWM0Wmmeckvzyeq5vI8wFgJIc6X54KeFAvWHoRn2pg7o5uOhFuF1RGtBYfFbEznPsadMrk0RNB5lBOMMBqgCQVRt+3gX8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2c2NU/jXSjPpRuTm5kl+U5BMKHzFMw4563XVQ30DNY=;
 b=FHCa34x6eaWrOm1IVTkDfmU9x3ocowTKe59kk8ghKsTHBR8Zv0PH4/7zKyX9VOOP0yamXvr0mPPrnqgXio4gCLnO/603wzM6UdV5yUMnvxeGbpfo4enoEiM2RFD0UHyHWqWvzIQmDKsecHjFoRkiysJnKhfI9UUPBA60MYgQ1fzDv6F78y6YgDJPoRFh+IsH4eIucFJv3bFmWI7ZjSd+6NPkQB6WiL4Igrx8OoZGr9ChymZFjGjYL3+st26qfOzVhoUjG+0Y64IT0GYjpLSr/SqsGC79WhzNQ7iElQ8+AZmJ52i8Ib4XZkSYniSQ/fcT6ctx679jv2k9eeleqnbdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 18:14:31 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%6]) with mapi id 15.21.0048.016; Mon, 15 Jun 2026
 18:14:31 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Fodor, Zoltan" <zoltan.fodor@intel.com>,
	"horms@kernel.org" <horms@kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Grinberg, Vitaly" <vgrinber@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v12] ice: add support for
 unmanaged DPLL on E830 NIC
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v12] ice: add support for
 unmanaged DPLL on E830 NIC
Thread-Index: AQHc3twdLLW8WIY8IkSSVUTjpDZGs7Y/NBpg
Date: Mon, 15 Jun 2026 18:14:31 +0000
Message-ID: <PH0PR11MB7522B24592865895CDC2637DA0E62@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260508110856.550999-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20260508110856.550999-1-arkadiusz.kubalewski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CO1PR11MB5025:EE_
x-ms-office365-filtering-correlation-id: 8f4ea098-884e-426d-0816-08decb09f272
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|3023799007|6133799003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: ZLpRLxOG7HG5mjGTm6OV3ALMeTmnNudsDQoUJaTj3z887B55bGc88opWuDLtghRNC0srJYvl7w8Sg3+yPzvxzMnw952+mb6xsz9dYB2kaz0+uKCEmZQJnQ79jAPfyOMTHyq9I708JB8GYyiTHvJLOim8FOwGNFE800+bK5KXgauNDcdW7V0e5FqluVMf2pqfhPxxOyYlBREgRsmNU4G6SrpFuDWbe6IhxDU9jNlrUca2abyZ6oP29+fAIAU1NCT/1U+jXZ6hh1MFjTuQ4M05p3TTQDAV6bcb9IND8ok+Qnds6lgbWZiViFfTMw2BKCZz7EEO0hWtF+ElcdEjqOdpiDNxp/70ClMdAWWaOREHsBLcWtScm2BUDBKl8nyfXtK2VN7IYkwlXW7t3l3saEsxT/5mL4OIzyZl78nAJSmUP0B1L6+X0jdB5sLZoBgn5Ru0S1GHtiCBrU7r7TRajwTEXRAanqyIK55UKK8iKPbL5ul3gvRUV1SXizY9UWWgFwhNzglDVSgBElAYnOFwabyOXrsyMe0msmHV807ylZdoJ++ujawVXrAuicSMCHfUUK5sZrqpDKkYxF6Dj+88BNbPwx6jkPCgHd6XxD5UGR0jv/Dpn+sUe+2ntnJtBC8yn+zHGXjw/30yslD3jag8Da635CO6+I1XH61TGO4WgzG5TBRhmo93asxE6u0zGCVArMYSONVKuq35Pzxt7Nm+9zGejnD7Ik5pBmigK+amJnft9MttNxn9/ehIoqD2hVDRGZ8e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lj+3+9M1HqKmXNgdfKeZOS1AgEYuIQW1Ffxb5buYRkJBZPM+UAqdTRxYZBXW?=
 =?us-ascii?Q?Nckp5k6XWA8nEETn+6IGq4Wmwqs4EfAT5UEIlgQz3sdZdInX6fsI4D6zGYZg?=
 =?us-ascii?Q?GsoXrScH7wQL03st9eECdQCwhHiAG6ocyqSIo961ViAWU8W+qCfkqAQ87MHw?=
 =?us-ascii?Q?BZTpxE+7QwE5wPOsnVKqhAcYcAbVX3yYAFJa86kr204OTBijG6jUjrVQRyyO?=
 =?us-ascii?Q?27s/sgDNORRi8DYcK1Y4U2xmEXZKhU/Rk97KVLR9dS/ret8JYJg14GCukf0h?=
 =?us-ascii?Q?rG38WnjgpYhVaA2lOBaHdaIsk6W1BedxpTfoAv1BhQ3CD4URTNDn1/i/I2EG?=
 =?us-ascii?Q?IM9523Te/FWGuOO33qA9XTHhocmkAXGW+ZyQ/U1OmqrrVantKU1T+bq3MiWP?=
 =?us-ascii?Q?4CbiIGnyJHLk+TvPmD8rahApMExsaq/HScgPefRjZwOxNBcsug/I67kR5jLz?=
 =?us-ascii?Q?OjZFygpYVroHGxGnJkdPlfQRHcKJnNjTBpVhZikwJTAo1xvErqHaCdE08xpS?=
 =?us-ascii?Q?5noZHeQ4lvpb5U/OrRxlhRgddz3xrslKfOgi+LYIw6VYnLNWe6Pd+gbdRvE/?=
 =?us-ascii?Q?HVlF7Ekmsl1Lk4cLJOG1XvSBNSSUIHngIrPRs5dwbk5yc5ZWkf9o0GuCMrp8?=
 =?us-ascii?Q?hMqkg3sw+Euv1yANdF5aIOakPepq0+TcIBT2OKkSWHfvHIPNOO6291KTAXke?=
 =?us-ascii?Q?Lxzc4OTLax0WqQGic2Nmp9rR0Q/4MBBl9+LeoKMqLkQ/3qNjstS7ageWiizG?=
 =?us-ascii?Q?nfdqVS6+x5Biz8KFgYuHO7xqgQeD/cNev+xVt6Ni3KCU651xCOze8lroQ6Gz?=
 =?us-ascii?Q?x5PY4MLpr+1YT0A6dxSUt0z8DeDjADG3CqFqRikk1VPL432aOMxZs+oPYfsW?=
 =?us-ascii?Q?MdtMNJa+C/XnNR9ZPQWOw5wAM1AO6bRJ0HbCPq5owH1nWv4nvMasq8Zdy5B7?=
 =?us-ascii?Q?StPq93bdwAE39Ob6eu5q9UFpwMc+reBBhU+EWzCMT6rwTL6Qf2eOEJ3Pk2rb?=
 =?us-ascii?Q?R25t1lYc2LSB9zhIdVcHwwuAW+SJkjNIe7ci0Q+Ocy4YswbK2VcLXWwBG014?=
 =?us-ascii?Q?XMFK/cSQ2t7M+pIUcThx5HPkOlKHMgoOhBXMqn2DiQTPMQvWdjqwpyzLebDK?=
 =?us-ascii?Q?mAUeWKzCUyWDV/Tf3rxNXzoZKx1yb/E1tk0QVL70y5LDU0SQaU94jdF2CAWl?=
 =?us-ascii?Q?gDCQeSP7YTjorsc9YIXp017M/HVOQtJnmDsguRxUDbL2IfAWzd9GUOeEVzpg?=
 =?us-ascii?Q?2TP+FfP+XWKak9cAYjQHBL/l54ChTQqz/D9VoWIJEb4OnVlWTQcHPPq298/g?=
 =?us-ascii?Q?GYkB96HUaYpC7kEpKiR+jcZSEgY8Z3wPtkdPDzB9e95bjd8ggbLOkpDFUGAr?=
 =?us-ascii?Q?xxNio36hmgWjpBeNL0f1h3r+uQ+NjRwQQIsrWp+OdbimJ2CoNgDDDwuqLmZ2?=
 =?us-ascii?Q?riACegYdlj6Cvj8gL00jRdn0pbzdRpNwIzlSnsAXgeBQAqbQMae0jLlxAS/J?=
 =?us-ascii?Q?wXfrKPqhbu9xR/jTn0ZnzbW1hkAdc61hEvD1sFxsWMuPlMXTWTeJ0nMj0NPa?=
 =?us-ascii?Q?/GToo/pTJPnogOhIvJAEohF1E8WltLckGXYBL39ZDiJoTU0tIO2Rt5XnM/fE?=
 =?us-ascii?Q?O7wq7F+u615v7V6V2vsOpTPX8zCVbEUxILeRl/ACQudKozzWl9Nzp5ij0Mdf?=
 =?us-ascii?Q?xLRYtGZIW+8OXHzVF/IRPCrLqs6bEcR3yhxMJ/WUIitFCoz3bcLdCqubKrI/?=
 =?us-ascii?Q?xr5fDUxzHyOBaCaeeghsHBBHHG0e6PE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lT78MOtQzoWZ12Df05HzxHuJZtjtS080y+U2xwZlmbBHy0yjSTlWrmGlSmCD3SbIpz4YIMEVQXcAZs+Th2Z1LgRPe49yKKbVB5+Iw7KJMES4KE5YgfHwu0TT42M7DGhg07WlBycvF4/s0mmHb6QgMq3HfX1gS/wA6ick+9bv+2+G2xN0u7r+Q4blbHVijgMop3+Nu3zJHUkSaV1NaOjIezLpa4sz6XdDEpUxhXyVhJJQQwW4zFX44i3cGq95F9YnrLKCjVKjIyTvc0WGfTuJcnxUJzxCZMIfiZChjcNzISJ3WIMcY2XSNZi+bD5fUb0EdZ+fWs086hH71X9mvPICpg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4ea098-884e-426d-0816-08decb09f272
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 18:14:31.5392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEkvy35KNBrks/Zh+IpnNChzD3hcAi8VT9jXCmBojj/PtOkO8iCYEJm4I7s3C2fdDRoeJ0Nn2m4Pg4IlqQGU8GfNsMQKZurW4Nodl1Na7QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299560-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arkadiusz.kubalewski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:pmenzel@molgen.mpg.de,m:linux-doc@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:aleksandr.loktionov@intel.com,m:anthony.l.nguyen@intel.com,m:zoltan.fodor@intel.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:vgrinber@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sunithax.d.mekala@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PH0PR11MB7522.namprd11.prod.outlook.com:mid,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunithax.d.mekala@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCCF46891CA

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
rkadiusz Kubalewski
> Sent: Friday, May 8, 2026 4:09 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; linux-doc@vger.kernel.org; netdev@vger.kernel.=
org; linux-kernel@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalew=
ski@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Fodor, Zoltan <zoltan.fodor@inte=
l.com>; horms@kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com=
>; Grinberg, Vitaly <vgrinber@redhat.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v12] ice: add support for unma=
naged DPLL on E830 NIC
>
> Hardware variants of E830 may support an unmanaged DPLL where the
> configuration is hardcoded within the hardware and firmware, meaning
> users cannot modify settings. However, users are able to check the DPLL
> lock status and obtain configuration information through the Linux DPLL
> and devlink health subsystem.
>
> Availability of 'loss of lock' health status code determines if such
> support is available, if true, register single DPLL device with 1 input
> and 1 output and provide hardcoded/read only properties of a pin and
> DPLL device. User is only allowed to check DPLL device status and receive
> notifications on DPLL lock status change.
>
> When present, the DPLL device locks to an external signal provided
> through the PCIe/OCP pin. The expected input signal is 1PPS
> (1 Pulse Per Second) embedded on a 10MHz reference clock.
> The DPLL produces output:
> - for MAC (Media Access Control) & PHY (Physical Layer) clocks,
> - 1PPS for synchronization of onboard PHC (Precision Hardware Clock) time=
r.
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
> v12:
> - remove HAVE_DPLL_ESYNC ifdef
> - guard ice_dpll_lock_state_set_unmanaged() call in health event handler
>   with test_bit(ICE_FLAG_DPLL, pf->flags) and pf->dplls.unmanaged
> - add NULL guards for first/second dpll in ice_dpll_deinit_direct_pins()
> - add comments explaining intentional continue in
>   ice_dpll_init_info_direct_pins() for unmanaged pins
> v11:
> - rebase and fix conflicts
> ---
>  .../device_drivers/ethernet/intel/ice.rst     |  83 +++++
>  .../net/ethernet/intel/ice/devlink/health.c   |   6 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  12 +
>  drivers/net/ethernet/intel/ice/ice_common.c   | 136 ++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |   8 +
>  drivers/net/ethernet/intel/ice/ice_dpll.c     | 314 ++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_dpll.h     |  10 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  11 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  46 +++
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
>  10 files changed, 604 insertions(+), 23 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)

