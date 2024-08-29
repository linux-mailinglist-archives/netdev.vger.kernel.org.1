Return-Path: <netdev+bounces-123325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ABD9648A1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC61F280A8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4861B0102;
	Thu, 29 Aug 2024 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+SCvApK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED81917C6
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942196; cv=fail; b=IQTaVEZFgSYyZQ8dJ2gZhRXWsuEqDtlQ6VAoX2A6Rx+0Z0WMSr8LxXcC0GZoDQwzdCsj46jZ1hH/bDUCBqt61+WZZsts8mxrJChRdu73+3bgW95nviFkuzdwVg7/F/CnsnWYFcEf35e9hSmfBd4LX6mQSWpxCc9glKB5pmF83Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942196; c=relaxed/simple;
	bh=H3Lu1wSX1k4u2f0GCHQ0Cr7Pt1P0wN/h7HPIUWPS9uI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lB+DosZtg9XQTvAyVgirZr529dpe7KAwWLCu2ImLrVLI0C1wTXVNwBMeu6vaCDBMAdDidiHwsUtRspwn660PHeEC/6UHsWP9jYeb//ECRDk7hRPxWx7Rhgt31nEG/XFB5vwjallK61AmMG6kja/uT0ZgASjrYmdR/YYVYDpSE18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+SCvApK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724942196; x=1756478196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H3Lu1wSX1k4u2f0GCHQ0Cr7Pt1P0wN/h7HPIUWPS9uI=;
  b=N+SCvApKu3q1TnAdnyUpFIrMO+i9xg+QvnDF3UAoUCgqqUZMTZwbFUyF
   j7NvXQZnsUXnfhJc+y9is63hSCno9CVPE8jkP1Juc9bs1xMWjPnN9LCsQ
   45LHyTjKUTEr4JMH+iNInCA+5/6vnr3f/S09rbx+b1Naao1par/zw5lZR
   PK7n6oWlkabzAqCAKJP/i7r/dfMNgPN09fMfhfFXnMnvnGU8cpC0VzPDi
   va71f3dRePvqT3jh05b1+QtRqChiZarb5CRDeoceGidlsEc5LSwG6/h50
   unJ42aNFUYtTzk5pUPs1lp48hdK4IEilq2Ybe0QqUyw2EvPZFqQTHz+01
   w==;
X-CSE-ConnectionGUID: vd8hXhydQPenLBZS7RlPHA==
X-CSE-MsgGUID: s2xwJ+xIRKuiO/3uNkHdig==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34197188"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34197188"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 07:36:30 -0700
X-CSE-ConnectionGUID: xnrG1ohWT3a7d624g/6Gtw==
X-CSE-MsgGUID: 9sL4R/usQuSQ6/xkst22PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="86828439"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 07:36:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 07:36:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 07:36:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 07:36:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 07:36:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzkbpb5soNX49oPH/f127TVPiYiOczRBiqmeTuKrmJ22fYZS3V4RBhG+/3rPuIWhGazpau1kBj/UUmRCS6bUK0/O9R27R5CsAMiKP9QUjjRRAYcotnOioPKkiMhY2GmJHUem+DKUUwrprC/RhTUEQE4aFQogSh04pfg/EVmluj5I3QMQC2bfXrvMmdsrHEneHsPLJAZBSF4ovQZv5T38hPvfIYNoqNTWqolTApykGOdL7TtrRO2hoL0CKbnD14LA+vEtNZrPS67/a4XnSaRLaRcSK6SFFZdqNEpp2lE7I9K/f/uAGR1gtLVjfFupM8zJVKXw9ZRaM1A9XnREB+AsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkmbFk4McElFTEMLXv1a6RjQcG8pjGA4cc2ENiKPKyE=;
 b=NzHfsJ0MP5G2NILgSFUrq28CuyA5sUoD3ALI12aUWpuxji3880wS8eDJnDtTDNBOPp93PDWzIuL3Lnp8mRFIyUE6O6AEBio7bOfTUFvjpiNb9TWNa3QSJ+mzh49H2p1B/GjMyt7IK+zAOws4/CdN+Hhz34pSLDQnGDoaYg1r0EV1O3ow48vuDSBaCTPjdUdubk4iT7H82HF5KOv17yTc+0E3EtVvWkZ7XSsIBHjX5UTgGGEP1iVLj586+czq47MJHH27jNcg37fvzfjuMIrHwUo2W2OcuDdwL1d4JtnFpuhYfTIqACTdQhw++YWupsiiudEHOWgEzfHhbtmtSUFWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SA1PR11MB7038.namprd11.prod.outlook.com (2603:10b6:806:2b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 14:36:22 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 14:36:22 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Jiri
 Pirko" <jiri@resnulli.us>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>, "willemb@google.com"
	<willemb@google.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>, "Shelton, Benjamin H"
	<benjamin.h.shelton@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "Bagnucki, Igor" <igor.bagnucki@intel.com>,
	"joe@perches.com" <joe@perches.com>, Eric Dumazet <edumazet@google.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Simon Horman
	<horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "apw@canonical.com"
	<apw@canonical.com>, NEX SW NCIS OSDT ITP Upstreaming
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 6/6] ice: Add MDD logging
 via devlink health
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 6/6] ice: Add MDD logging
 via devlink health
Thread-Index: AQHa88+QI6BmSfZt406+hTqqnifApLI+WbzQ
Date: Thu, 29 Aug 2024 14:36:22 +0000
Message-ID: <CYYPR11MB84290676961FBC1E3C33EF75BD962@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
 <20240821133714.61417-7-przemyslaw.kitszel@intel.com>
In-Reply-To: <20240821133714.61417-7-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SA1PR11MB7038:EE_
x-ms-office365-filtering-correlation-id: b788df26-1bce-4e21-3a11-08dcc837f465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?th3i38WeuetUo5/gWCYcq2OfgqY1B8voJmGaOvRIKq+ck+46wIuzkuw1IcqO?=
 =?us-ascii?Q?KX6gVvS/HyCaD47rXe8mpjV1A4frpCYuRJnu5F416ASQvggCl7efaRSbh8Xn?=
 =?us-ascii?Q?jsRSw78ghovNIhmOifD+a1slq9f3ERdr3fYIXbmvCdTsSLf031WeE3Yu+oPh?=
 =?us-ascii?Q?Irrh5a1KF2zcwbya937lPNe3yjoUruKAfzYblF72dD1JFjC+Kf/apci7Obic?=
 =?us-ascii?Q?IY7OwhqiZVWNxuz56gVuSD3CNch6F5uk/nrCmNXS2yPdprQ2ofGtLFb3w7Ua?=
 =?us-ascii?Q?stB0EttAiL3CbFhNmXl61dAlNv94LMPVVbZ2/GtootlBgivqngQUVUTI9ZTG?=
 =?us-ascii?Q?a2/7L1IjpKyfGT5NOKWGpJYToAa36iG4ojo80Qhqz1H4itNEQDTgd9+15F74?=
 =?us-ascii?Q?k9QTs/1l6AyiDGo7gA/RfFJfoWCXRsXIC1+A/xFaMnyMnHjLXkXvsrL/D07r?=
 =?us-ascii?Q?2B0S++kt87gxJ0C4WF/kppj2dPGzwJRZ7x2ldw24UhUontmbscG0M1KvS6Sy?=
 =?us-ascii?Q?x8GTaWCJqJ3rOYzGIcoU+K1XbGj9jIdbQyEIaejxCMNbWcN7eqC3XGYr2m90?=
 =?us-ascii?Q?brmITDMiyUMtSbQXtxqr7cHeuAN/VAE2AOlfmwns0e6me1kGayhraq8vmkXu?=
 =?us-ascii?Q?FxsX7KUbGv+yA13LRY2531nVLEm+WHApYhFDDiYXFiK81oQU9o3hNIKjuXPE?=
 =?us-ascii?Q?m9WRDPBWoC4pOphCteDhwFgewqKzkYgaiHdoH4jgLRRfFqidpSQXwNNoW6pu?=
 =?us-ascii?Q?JpSPGb9yw9fG9pQ7ufsAc9GMCg04Ti36Nw+VaFuGY//7fTQ4I6NjB3e4j7TD?=
 =?us-ascii?Q?enGqNRjPtkxdBEU57gzLFg7AvUlqvGZFnxg3W/mcAoeE9SXTPEM+ocM6Phez?=
 =?us-ascii?Q?SuF4iqH9ThOC8hnRmap7qGRZkvHZB0C/aWTJKaue2qCqv9bsUjTI//g0Do4y?=
 =?us-ascii?Q?Z3INeXwXljbz/8ycUNW6P+Fb2F+f9ZGEWtGk5h8tK5PCRnSZgCPIDvzOVwFu?=
 =?us-ascii?Q?+ZeoCUkxHe6cKfpUMsAZJCRRWCatjXW790lx6mewowjhCZZjwEufanxug1PN?=
 =?us-ascii?Q?dsAdI1lY/NisVhKlacGEjaSZWrDAs7fwbHg0LWYVFUgUUbYxVjC0WqJdlGql?=
 =?us-ascii?Q?e3vgeERUkrgTdEFdgposFyuH8FqzSqoJ0+CCfCPkGoX5pEl+vrjukSbOsYUn?=
 =?us-ascii?Q?9kfRHMU6PXNqfjuPRbai9BIgBEy95+sAWSLF2Pa22rPK3Vltpvq5j1WGGWPp?=
 =?us-ascii?Q?hG0/iG5a354ZCNHj9f187YCMDzinHTvxWV1Wdkeu52ke1G8Ovbkrd5iNzLRM?=
 =?us-ascii?Q?NXTkaC+tDfz8nuMau25aekS3B7i2a5vIQC5DJ1gfR9+JVf9BH2GbHKbyCeTJ?=
 =?us-ascii?Q?m1Ly1Ln72rrSUxoRAZ/zz3kLscmR1vXGKprBE6CGxmizeBDxpQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m1Jg9gFZEGNTljgh0EHn6qMAhsVmLS1mVywjytLdwrgvsX9Oy3+fmRn1Dpf1?=
 =?us-ascii?Q?K2GLKiWEEjOtciD7SzstAdu71HRJINMED9z5S1VSke8o3frEifmetTQIyiYa?=
 =?us-ascii?Q?8AYDDx2Rb3wwsYuv/XjFohOj/ovZtrrXOpivHGinoVkOc6JnwipsuynJZAWJ?=
 =?us-ascii?Q?NzZETgJH+dL6+C3MeCnD1pMxXpvAx4Ob1Jw/PNkgteCPtd48WT/z+b1n2m0O?=
 =?us-ascii?Q?S4VoOeAIe5QIh861T56X6wOPBGSr+dPuf9Z3pk0kbkvO6cbKDQbLbAKmccTt?=
 =?us-ascii?Q?KpI1yz5Ogzk/kQvaZnWtiBoeSCBbpdWQTfQZZ7c4C+iFegaOdmqc+H0jUpWs?=
 =?us-ascii?Q?fMl/6Qy+k++17anNeRgtbxO+WbTrq9Vjn+k541uBPb+gNIMTgc9nC0+6S2Sz?=
 =?us-ascii?Q?Ujs91xWyRfXFIgc8u+Dsh60w+pabrXLjaFp30l+Bg94MLP84vSXo7RiQAq6X?=
 =?us-ascii?Q?YrDLMKEBWCIp7W0ElKGwIITpdWWKxzdmhnKpQC9cgeCN0kUT4c0EOAZrOCpB?=
 =?us-ascii?Q?6oLltGhPvPS8HnLVVFfoLftQEXSIE7HkuwJ7EiQMKgOI6XAdEONGChsbRaLr?=
 =?us-ascii?Q?W0C8S+iek+hmY2p/yBg1SCSgJe5LPEZdMtk8jur+gCm0qPLYvqBLoDHjCbud?=
 =?us-ascii?Q?t51UxidzLQehzKiCvVD6QgJHz7QdgBxcMqK6N6+dg/CwbeufQj1nz/0EDV+g?=
 =?us-ascii?Q?DuJ95LloBXlGrK2H5PtJPZULQocjpPZRrEbN/AKV2Npms0yQvJm8CUSiUpwz?=
 =?us-ascii?Q?C6b5rR8DgxCU5SnnONAEVP34sqK3wp3cXAFXrPXDag+/lDv2YHG7z34KHQ1p?=
 =?us-ascii?Q?fPoe0Wo2gFBBCFFgRqTnS0Z8PZ4J0c39BNoAbZXYnNlzBO9RkAPpEKLPt/av?=
 =?us-ascii?Q?8jMM33j7GMXbA7K45eY43H8NpQWi9OSc8XdSQscW0zDrrp0RnKfJrjujmFr3?=
 =?us-ascii?Q?EcPZ9Hfa+HBmiia281FrkGfgSS7AOpKcqY4wg0mJmhJdCrEq2m6GVJN5m1og?=
 =?us-ascii?Q?R0xcYbWfG83btUU0+cp7wS+lH24MeRPQ0ExAubn85w0XpgrYqvlL1nH6IjWA?=
 =?us-ascii?Q?LkzXxeKJ+5OXbFxpmx3+sgwDlJ3l1c8EZN2WDMC1AHjyfY1+qr3gutHptSWL?=
 =?us-ascii?Q?NoHjnQne76dK46FHp3RzCnbctLEaULLu0CxMDqxjhQLNlZLhM6WH2McnAGmn?=
 =?us-ascii?Q?1ZnYv6vDJ3TC2m23g6gMp6bKnJ1lcxuMRqrjGzzb83TMPVmBlI0G32sxgPM1?=
 =?us-ascii?Q?4c8HVc71IYgQ0eddPOFHh9I/L/ofVi8IP/vYFe7K9oE8pkqzWzHkV1TqXW4f?=
 =?us-ascii?Q?eyA0f7pcGqPlmHFWLR5noLtqUvwrCK3KCg6qq/lANdGhYxK+gkRuo+7b6qLR?=
 =?us-ascii?Q?Ws/0TXXIYtmELlh3/1pKxk7sQUmauhZfSUCgH0fe87KqqaPqG8BWxRQKptvs?=
 =?us-ascii?Q?Hyw1V/WRXKraTN8jlNQ29RrXmea+XMpUlBrgtG0sH5TurHcQWBgVuu0chVQO?=
 =?us-ascii?Q?L14pcYxLVOraJ0giV9vRjQNIERcWtIgI17ZARLQy/R/j+sdQZBURAL0CnGgE?=
 =?us-ascii?Q?I2yNUGhCcegjKroSkUu24DlBJAoePOSfRqtEy+tjCX6fRwl7zst/uXJV2qzk?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b788df26-1bce-4e21-3a11-08dcc837f465
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 14:36:22.8635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6atl56vQMzX3sHXISTyDxA8aZsvjUJA0t5gPnRkj7RmHRCE9ESbJjKbEN11Fokgo3ULejI77yE6vtQKaKJbAgakd32li4mcAyCd+Q4ROIUevNYIPs6o7TGMi6alsFW6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7038
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemek Kitszel
> Sent: Wednesday, August 21, 2024 7:07 PM
> To: intel-wired-lan@lists.osuosl.org; Jiri Pirko <jiri@resnulli.us>; Nguy=
en, Anthony L <anthony.l.nguyen@intel.com>
> Cc: lukas.bulwahn@gmail.com; willemb@google.com; Drewek, Wojciech <wojcie=
ch.drewek@intel.com>; dwaipayanray1@gmail.com; Shelton, Benjamin H <benjami=
n.h.shelton@intel.com>; netdev@vger.kernel.org; Polchlopek, Mateusz <mateus=
z.polchlopek@intel.com>; Bagnucki, Igor <igor.bagnucki@intel.com>; joe@perc=
hes.com; Eric Dumazet <edumazet@google.com>; Kitszel, Przemyslaw <przemysla=
w.kitszel@intel.com>; Simon Horman <horms@kernel.org>; Jakub Kicinski <kuba=
@kernel.org>; apw@canonical.com; NEX SW NCIS OSDT ITP Upstreaming <nex.sw.n=
cis.osdt.itp.upstreaming@intel.com>; akpm@linux-foundation.org; Paolo Abeni=
 <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 6/6] ice: Add MDD logging v=
ia devlink health
>
> From: Ben Shelton <benjamin.h.shelton@intel.com>
>
> Add a devlink health reporter for MDD events. The 'dump' handler will ret=
urn the information captured in each call to ice_handle_mdd_event().
> A device reset (CORER/PFR) will put the reporter back in healthy state.
>
> Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  .../intel/ice/devlink/devlink_health.h        | 11 +++
>  .../intel/ice/devlink/devlink_health.c        | 77 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++
>  3 files changed, 94 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



