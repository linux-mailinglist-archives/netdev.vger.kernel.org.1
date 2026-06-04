Return-Path: <netdev+bounces-295042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ge6ILd/7IGqh+AAAu9opvQ
	(envelope-from <netdev+bounces-295042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 06:15:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 023FB63CCC8
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 06:15:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=f5QvlZMo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295042-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295042-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8B4B3024142
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 04:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F03AD503;
	Thu,  4 Jun 2026 04:15:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04443B1EFE
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 04:15:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780546525; cv=fail; b=Egnb6sIfRy94MCiqk4h/bVXc1XjBIJQ8tLmh/OhDCf9gQIUbQaMWkji9ZsmKte/F5nKb7j+WNHVSJWLw1W45PqY457Rp4Wz7LhxZP5d+ENK9CfEM5u1frpeeX7LJ2aW1NM+jKZjVGXeBSt3PJQLNXVo28OpgC4JFvotQWvPvGFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780546525; c=relaxed/simple;
	bh=Kd6/K/N1uQa8hAPy96AVKxQLw3tawq72MNWaIg0Nsz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZ8aJBmA40ydNOTgFhhig0nzBFApNAppYu/y2i6+yE3oAZbIyRuqnBd9zvgezOUoMRJMd50Tkg3sDT+zwv49YUe+ojTIFLImC8tytP+hkMyEXwJuGUDKfv4x6Yfl6Lfs5/NWiKpw8EZp+GuGSR+WcVqwn5tT2q45HPLmfBGwgQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5QvlZMo; arc=fail smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780546522; x=1812082522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kd6/K/N1uQa8hAPy96AVKxQLw3tawq72MNWaIg0Nsz8=;
  b=f5QvlZMoeX09kY0tyr3oVFUTyJ1zpxcjxZFBMZFJ2n3wvqQ/X7ti8bHn
   9D/N7taZSOFCqTurY+71DNE357qrzcBdDNagTdMzh4am9Ora+Egnw9sHX
   XbzUm5dNTHqxnnrJPvbHeSBD5Gz6V0UhdXH/7ytB/7g3mNp5Roi6YJ+Ac
   txeL8r6p1clOT7f6ElGaDcPBoGVYdCaeRniNCgowEhG+JZFvmzUnXaIsB
   s3gJLuWutEg/crcPcx+2KtdYySeUPdtYWdU4jDOfcN9b7W4smh5GebMch
   pAVzlOFBqmIEmovx6IHWGYDtSbdTth0dsTilhIKa6HUAR0ZrrNlmSd3Dh
   w==;
X-CSE-ConnectionGUID: QBmwhimoR5ObVbEAKkcDpg==
X-CSE-MsgGUID: HwYg4tfvRgOwLrwlATNE4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91940656"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91940656"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 21:15:21 -0700
X-CSE-ConnectionGUID: knHemkziR6KAonUoStgu4A==
X-CSE-MsgGUID: dfFf9MaLTVSCd3UunJE1IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="238097473"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 21:15:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 21:15:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 21:15:20 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 21:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0LUn3/e3r6Vk7KiC/gie68Ea6gpkuFQFVIy7A/eaPxsqAJ8gEaZ5nim+Gdxz0L7nOaQUTuqJmx8tlbgSxRsin8B+NmpfoKf9HrSbcyNIr3ZRBmWILnjpJsmXJ3kWmxT1MwYeNyci5oEWITvTJnlbyHoaYZMNPOm5hV1mK4V2rWh+cAwXMeje/B4sPxTkF9+K12uUWkPTgK/2fbiHkslQPAs9MHupXsqJ0lYXn3CuhVH9a3Fxd374/2oCJ7NWglSEC0ujoIkTAszChREULjt4Ym/Kco/dwuRLklvuzfMVZWa7W1G9emCnXAT4EH2p3VOd/N+dWHljsYwF1txtaKLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQS7w4W5hRC7eBorJRwO8o0GJ6aJnRXuKexAqBWfj5M=;
 b=TG3cTZPhvRzJFErRBIMlZrdj/VSrAq+FKGveWD240uFZ7FMGspT0l3Yw7PiQNH+qNTqdRL7fJHKuNgcNWyEUJF2UylFn4b0hpglv1nybDqMEmuzuK1KQc856BQ9NeB3w9ijhQc31C+1Op8v7Ptw30UFOhDzymJxbOaolJOOB/QaNfaaDWQCrGTgL4Y83z6wRXmKk7jtEZdeiehgt4T5IRCuKX1T6QqKzbzbB03V5mav/+x6HziUmg42e5fdKygzVuXaAnipKxT4qa4urv8NoY1tTJpu8937bStcyoox4J5eS7Cn8g2ODQ27LYkQ5RHhmiB25sOKqctzI92IX5xGZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 04:15:13 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 04:15:13 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: check cross-timestamp
 timeout bits
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: check cross-timestamp
 timeout bits
Thread-Index: AQHcvbqJz4vNCbmtMUqL4KLPqAFYeLYuM8+Q
Date: Thu, 4 Jun 2026 04:15:12 +0000
Message-ID: <IA1PR11MB624128C89EB7693B7C484A578B102@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
 <20260327072236.129802-3-aleksandr.loktionov@intel.com>
In-Reply-To: <20260327072236.129802-3-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|MW3PR11MB4666:EE_
x-ms-office365-filtering-correlation-id: ac10682b-d30b-400e-f9f9-08dec1efdfdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: sZu0h2vOv8oj7m6tAKfOOwxTK8sr5BExwZIxQdBi8i0G25DSRb3GAjp9hgN2vl9s0f55AmZD9aL6mF42aodK9D8h91/gJz0AydzESoplbe6y8eChB5JwZm4DhwoqeJ7PqBLgsAbj1TYfMx3CSI+OXndJYtllSlht59MKCPbrVirWWKu6LvU6RO73KgV4lTHeQBoNiQKLcNv8LVyV5IWOr9mNfLr8+S1USuFn81cZJCMjeBBBymjZZNTwQ1i3Pki+Wq2Mywf/jhwZwS5FDJrW0DKqya3C8RDF6jJPofevL54tMLFBzGOIMPZVvK3NlEmqUvDDdcaR9/EQRzW1PD8IoUfumTZSw/8TzhBjTYetkikC3NGoZy4ye9r4J+QqxEvStSslf/n5BnP/cEZruGlfbx88h+YznqGrwfRglDQ8doGzoSQLOxeFaw0UuweyfZAkcWqGapMyVW1xvYKw6qjm6E56LglUIStHDM2ReJaRjfEfxU4FEOrk/s8Mnk6BS1e9wo0MqQnI4O9nAziF+AwgmEReDQ9GFFlWn7ETy4fq6q+VTg5db5/0iwJY8+nH1OC6B1MpkZaW/MZrEBpFoJScjmDeDgONEHKA9nMOGLsbpmjIo24nLLzku5zNnuXEjLNRC6PUIPFDKndlOlYhxvK5+s1K0K0u3hq/vsxGSmuGc33KtQ+EElwGnsZ6XMunm3bcw79Vca350EGmy5CRIIZGSuMDbZgm3dm+I5KG/z5yHxZi6/yZKN6POagAfLsiWD3q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3RG9vWldYz5Cg6wDIUJqurgx6JRFTn/OXyNN34zvtY1hwLIs8olgAuqGtNqC?=
 =?us-ascii?Q?hpwTUTLt/z51603NYmDj8c5j0jHULohtViNo3XUl5ruCHLnqYFde2zqhHj0p?=
 =?us-ascii?Q?3ahGz5FEA0gH2yS4mig234Kz4Zb1LETyeB9y36v0uZ5GkY9ZlT1P59zmrKKm?=
 =?us-ascii?Q?pMbaQRyolxhZEqJeCNHFD9HipdP7jkdVNrr3Y4baRxr/n7AE/Nw5xFMnGHeX?=
 =?us-ascii?Q?WpOd77Qusm3C7HHAQGcIvnJGBjzft+EdtUL0tVQdgPfN2F+jXJYxkYzCX+Tz?=
 =?us-ascii?Q?ALIvpb9lJOmpKDv/mLteIwwloMp1hahRafljGUlYwje8GO/tsLs7AgbERhOS?=
 =?us-ascii?Q?S0ijf1vybD1DfSjxSdtvGrS7btpBrEw6VsyAf+UE2q1ZoG/RQT8aRwt3TRx+?=
 =?us-ascii?Q?JYFDMjOicpbTOYd7DsWOOVtkKA315RLeMoKCXfxsSErZGBMDkuvMI/EVoAr9?=
 =?us-ascii?Q?W7oj/uoV2yADiWuyxd48syfLKjE51x4D5vXhoPR55MVZJXcSRhbIl91pKOrh?=
 =?us-ascii?Q?Ou1UcIrkE4tAAI6lHQsYkWc9NGapvWkuEureQf8Nq61RS411b66mzLaerUWY?=
 =?us-ascii?Q?cfUQI1PoIn+tgDba3UJQD2lEO288oI4Yu3OwyeIRjQ51f/cnPbMynDXRj4w+?=
 =?us-ascii?Q?aWdZcKeurqImHhLSL01y8b6/axyDa5TP5Okg0cPAjVrdZtvQZDamLa4x9Kz9?=
 =?us-ascii?Q?1YCkjNDsybvW4/p6MMAoY9dY0p03hAWh+ct0d97tp3/t38iMMoh3ZLhgSAtK?=
 =?us-ascii?Q?UGqinglETFIFOsQ24+kJevKj/u5nNR2fiZ14BMb9BWI+Wli5ydYdSButw1gY?=
 =?us-ascii?Q?EcSq2P9pPHwed6coc6W3GWToUx4WZbQpLt+TRKSBENcc2Cf2lU0brUPWiKhm?=
 =?us-ascii?Q?lvSVfO8GRe9RwRJOvZ8Twd6JJ/pAHzebRcMJEpSXtnvLIyVKSk1E8nIhiR0a?=
 =?us-ascii?Q?U6sfgVbL3n8MJAkAys/Jv2YUh47dR30w79mz+qUD3FsPsBDsZDhn0Ri0WUnV?=
 =?us-ascii?Q?Qyf4aaJzv4uMypLZclRYZVmGzgiiRevZTXoDQCjZvFTrCEPaxoZVzGMx54B/?=
 =?us-ascii?Q?4dkrnviXYHb1AqVa0zzJHwtFAVwq7PflWG+AUoof/M6pb1eAYB25KI32DtPt?=
 =?us-ascii?Q?rpJ4eRQIYSLdyBMn3opgtRSBYIHk5y1b6Z50slnKIJ+toVgCT61126FCAanU?=
 =?us-ascii?Q?IlgPy4PHNQqN2oiGsQ+ltZxQG3wdaZEvDLNfG1+DwEymvRFs+a1dG7KQWAzv?=
 =?us-ascii?Q?yZicwB2sIda7KFXXiyKj5qL4n4meqmyIsXP071YfmMiLo6/VzUd78UJt/7os?=
 =?us-ascii?Q?8ahY+geX4fyy0cu8BB3Dzl83m/XfaABOnJhxBjXcUQznuSqB+BBYoKcvfmdX?=
 =?us-ascii?Q?WB2lHu1SIx2AYdkiA52g+MWU3tvwAEfHMprLUODSzERFHr4FktgnoTDpLToO?=
 =?us-ascii?Q?4is2G3C1x+qYuhF1L1tJY/3JZhYDk8uvl563BzHXDEIzwKsZxQqFhr8MHyMn?=
 =?us-ascii?Q?GkuAFOPmAoxdOTNQvdlqXzVLEN2XSHbp+nI5DBC/IMUkPeTrU/rNHI+mN2bM?=
 =?us-ascii?Q?coFic0SNz23haxi8mck2Ormqslz8RGjsWzWFjDbgHIYwh9Y4Llby+asCaB7C?=
 =?us-ascii?Q?25Ujsyb+qUeJ28oPy0ri5QKBl5MpFryfoB6gU3UF5NC/Yyl+xAOnwHoggVaJ?=
 =?us-ascii?Q?tGsHo9Vn7bcZe1yLIcevzXKg4cXe+SsfUuKhI7RUJuPTxP7o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G5GcRWHLgvarwzJhjRYpl0HCGEyZrANeEY3UwYu/VLseDukDPwzb072McZ/+2kP2K2AP9YCfUn/He7LyXKmNCShKWjzpfCLD3zWnJoJ3D8WkKFiD7TP96sZzXNhhefrdEDaOrkgzOrN/i95wT0K6pMS40aw4vBPppnPN6kqQTwI7kQAMvkYIecssI07UkevhahTe8Ep6xav3X7W9PHIuiRW47Z3R0KQ0xXuPRXXtPIgwjWvvKWF/WVwk3HiLjwn2vuAL6bg7oX23O9L5gQXgpyGBcpvNA9V2o6v0fHkIW9Y/HD4GEF0jRRtCCK8U/i8oG5H8l1OdJriZRnjgyW3gig==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac10682b-d30b-400e-f9f9-08dec1efdfdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 04:15:13.0321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Wqn8D23IjpD7bEwqD3UQkvspvQrLgH+ALMUHB4Z/09KjAnsk/wC09+tvfu9PbyrQBukGQkCiFVxXmzp//Bn5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295042-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aleksandr.loktionov@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:from_mime,intel.com:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 023FB63CCC8

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 27 March 2026 12:53
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: check cross-timestamp ti=
meout bits
>
> From: Karol Kolacinski <karol.kolacinski@intel.com>
>
> Polling for cross-timestamp active bit depends on HW scheduling and actua=
l timeout may happen before the driver finishes polling.
>
> Check cross-timestamp timeout bits to ensure that the driver finishes the=
 operation earlier when HW indicates timeout.
>
> Fixes: 92456e795ac6 ("ice: Add unified ice_capture_crosststamp")
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>
> drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  3 +++
> drivers/net/ethernet/intel/ice/ice_ptp.c        | 12 ++++++++++--
> 2 files changed, 13 insertions(+), 2 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

