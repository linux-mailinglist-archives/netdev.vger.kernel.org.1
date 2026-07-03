Return-Path: <netdev+bounces-304527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nkE+BLeoR2pidAAAu9opvQ
	(envelope-from <netdev+bounces-304527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 14:19:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5715270249F
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 14:19:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=JJYKNb+u;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304527-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304527-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF3D730166D2
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 12:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7973CF213;
	Fri,  3 Jul 2026 12:12:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13037282F05;
	Fri,  3 Jul 2026 12:12:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080741; cv=fail; b=R4te2sJsExUBHtsZC7T8cAfNmEPk0uW9tB3svudfvVWUuJK1etYlRSQF72cqHTlgoclp4Zzc4CevaZlMQtGPYVh6jz0/6un/ylfOI8Y6hlZbdNIocUi3gceMoYmVDQIAvPAXD+U5wCVXUQ5NluCAUBGUj6JKXR9LxaYY41Fv3Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080741; c=relaxed/simple;
	bh=LhSvblKXytrwaSFyDjumYj8vBeZF0XUVsWJHqfsgk1U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mhMdZPycLQNBlg4V1DNBHLJdOX0k6ZwwXNZ/J0jrP+cdoF+ZeIS3Lr2UpMDJGNZmmWaPr1n1cyKWyXe5W1j0+T+c32h/Fnw3qx2wPcI77Ehk+vaSFhzltfV8zsXEC5ejACRKHDUfD3wM/3E5q0RWbV6H9akFROMsRsUtk54KhB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJYKNb+u; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783080739; x=1814616739;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LhSvblKXytrwaSFyDjumYj8vBeZF0XUVsWJHqfsgk1U=;
  b=JJYKNb+uc/K4LHbgQ+Z+YZ5Jv6qxZJBq6cQq9CPoSR8VwoLc+8CtNz+p
   f/7jxxQ3yuf/RW2RHz0b5MLJm2HklmD0H0G4F7BEjup5R6gCZAWil1jZM
   p3EqTUgU0ZzkFGfAQtdw+wJj+VD36XSzNh8ArhQHhojIFM9uvqZlrlJfh
   WAUKfpBozxPSK7ftjDrdPyX4jNWLQNFT8bwGrPZgMWp0+PaSbqN2+JYI8
   hcEy//0x3dA0rdEXKY5mEMIuZWrR3hHASnAorLsN8MGqgy5/0yMSv3fIj
   xqxkRdONiyAW3yJXPvlX8ztiMgncKcA1Iz0QGmTficppZ4HmPzNKCgy8P
   A==;
X-CSE-ConnectionGUID: 6curT2z7TRCdBFpnDkN7Ew==
X-CSE-MsgGUID: Gg9dMkleS2WOMqYsayGyvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="84025005"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="84025005"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:12:18 -0700
X-CSE-ConnectionGUID: oSQTxIcGQleoeKtW6eLqOw==
X-CSE-MsgGUID: WGh/cs25TU+a44dHj3LJuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="252042935"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:12:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 05:12:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 05:12:18 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 05:12:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKVuqbmBAkdg+0iuKYm/LnZfrW0Eny8BG0DtEwv5pTgtQK8E8oJL5oqKewyP0su/KTNS0/mB8VN16K7HJDVHhnJ/adY5kEFLXraJfs6v89IQz2sEbWgO38GsSh0NTUWFSCZKXOrQfF2WWGPocirV/2kaRvDcvbzW80egum+zlzVOhmOJVJS5o3bHWhiPj8wqQ6x11NfVNNgQnrmFE0kwfK7pYYX8KWHTcEWMwFJg+PEg57/wNq6EHwxuEw3Ir3lrEx0cINRFCJEQBlvUuJDV7GV12ERnYIaCzPdD6yAWPBAe3DqOHWvDy2iXphF4CdfAoFuBDZ36lNzT4oYCbC2MNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcBn6VcWp0ssB5wO4nvCf9WuzAHvS9R3ZwrpAkwwghc=;
 b=JgorStDSaOx8+YnWH3OrB5pVzYO8Pa69kleOg8Lc0txMaj2cijb4SqjRtoLUPe4gOxHjg8yPVlrzxHm6nyZgl1wLgQNyo2OsCc/jYeiqERx6RlBjqXGuePZSWZFjG7pfNDQfPLmpQpPNW2St+fwZrtP5f/84BxqtnQv+ZE+KyUX1IwROxZ9QJwu3qldrokDI2Px6Jwo1vEhJjuJgJnmqfKI9Xk9UYbresOUEnL/imIEOAA3JF9uSAcDUBR0bNrDVs3XCRG54Rym1VjBtlvDBJKhv4Vdr5vXelEuFvwQ1GclZywowagBHUoWj6Rpspd+9Eb2oVOeDZN1e+XHiN9s6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 MN2PR11MB4647.namprd11.prod.outlook.com (2603:10b6:208:262::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 12:12:08 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 12:12:08 +0000
Date: Fri, 3 Jul 2026 14:11:57 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
CC: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
	<sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 2/2] octeon_ep_vf: fix skb frags overflow in the
 RX path
Message-ID: <akenDYH/th9rDwW1@boxer>
References: <20260702180518.2013324-1-maoyixie.tju@gmail.com>
 <20260702180518.2013324-3-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260702180518.2013324-3-maoyixie.tju@gmail.com>
X-ClientProxiedBy: VI1PR08CA0265.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::38) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|MN2PR11MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ebb354-16fd-4b35-8c27-08ded8fc4e08
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|7416014|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 174DV6SEFZZxJ6jttAGfceVAn5FowIYbt4vXeO/V25R+ujmArmsbYBiniGSw97Y1w8V5jiuP17YeCNEkwFdjK1PYvOxolZ+j3RbhfqQkWR9pNTm4nBVIrmY9BksdNR9tK7tBB1KPbFkOvGIPs23UziWnn0oiBzJLKP6cNUZ8wS2Uz/ajVh7NmNcRTIvW/x+yLa7LqdOzkc3BOmgP8V3B64rePbfBkfHNGQARNiKxOqM0xyI2uK9qg2x0BKYyqFIUSz6y7efQIpAxNFFZTP94i0M3MjlvvE3vJwjtm7ztFRP3GbEwHbd0sLM2AST4Oz5OP8N6AnKBUMVrLh6OOu3KeoRCydNtb0pXD6K8rc6lI7kmmN3yFpm+Yl61m5Q4F1R4VXvUkKsSE/M8pyvbf+aLkooddGLbl2BW95cf7dwg0iGr0+otCJRNAY34Y962IBlzSvX3xxVpq6IKmyobb/l7GH9y1wUZT6vvFoLExkO5QuHHgg4sOElK4JO/s0SPnf2VsX5U//4c81NVG3CwhrJjv9ubaDt5RvPSYi5uQKv9u2MK2yV08eIHPxodCd3xGtnyVQml7ZLySO3OXx/9txLhpQPouICYqdL3lc2p1bbbTiRtKz6Li0dwlK5dYxXJTDB1kcXEb/E9txa3N+QFs7jykwcX9I9m2V3unQYAaEzfZR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(7416014)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7IphUNRn45JwUq546BKKMOZaQCLaZiKWQya/z2JzaMtFoabuzZxza5jriHPJ?=
 =?us-ascii?Q?Y9+Q5u1aP8YrnHZFvRAKVC1CbnDTfGn7Aa/PT9ujyCzUIg4iFR8BPS9qhUv5?=
 =?us-ascii?Q?lb2QlZRFn3sgOuYTIvtVrhW5+48mAsd5QpNXPfUPe8+f3rPu87B7ebU+aKwS?=
 =?us-ascii?Q?tLeupQH9XRkt2hL5HaVamVKO3dacuqcF6OZWXmums+31uNDI54bVz7eMKsj+?=
 =?us-ascii?Q?L4MBjQJFHzNpOf22puuibTOykVLEImEN7atYeTLdaWh8l5a5iD114mTztp8Y?=
 =?us-ascii?Q?SuCoy/kd7awaWC4FP9GQv2bSCQ7T7utSa2XTOt9Ox5JaebUo+Bapn4LuCtmj?=
 =?us-ascii?Q?A+qG5Xl71rSPO6AcWkaHfwGPd3MgmPel/h9ZgFWRc27WGE6CvXP+YSWI4vwO?=
 =?us-ascii?Q?nMxWDJsiwiPGcmTlvKbVyhB7IE6uIqFlowmkAHiTPlcx5XR5UHAr0YQLypnj?=
 =?us-ascii?Q?RjAwsrohA7AxNSJGRHTQyQD1tnRuyI7HWoI0CkdHZYKy6k23wXDownWdgkqZ?=
 =?us-ascii?Q?mBiJ4ir8JMz68FrGuJ3cynpPi4aOuYbe1YLEts3oFO+VDUIsc+q0DwN3qjRY?=
 =?us-ascii?Q?K45+71kHgQM2Zf2SetQH0gTsYx8MWC0VRLgL7DXHNhnwzIgDrITlLDurgS8V?=
 =?us-ascii?Q?lMS+dMjng31vWSBwtJZEWBcl+IWd2ODFpkcfYcWT7wUsJJn6kIbr1J9R7AYo?=
 =?us-ascii?Q?Jw0gTbU/1WF9GzSG7qJDF94+DwTg2PYHUlLSmlwaoCKOxHv0+XaPnpJglwNU?=
 =?us-ascii?Q?jrYUneXLiL7UUBqDPeSh0OljQbwT3BSK3oU8fGpCx07VfW4hWVLhvwSYCdl9?=
 =?us-ascii?Q?tQAatTk7yvqxhP4sVwncuqJt2T9zhWHmPWuoVp1YUcg52h3H1yvtR4eYQP8b?=
 =?us-ascii?Q?NPbfDPND400hXTCKPxjsZzc5uwDL6b7q1Xrd2X0zgUVePdEpKjSy5Y7bYxJa?=
 =?us-ascii?Q?EahGI248mSC+Eb9eaVEuj4e3UP67zqi866CEK+ArUEEAJy2L8zv1KXf8vVa7?=
 =?us-ascii?Q?BENmjt2MSUa5ngd1EUbjfPGi5DYcCW/FXlgNc+9CE46qnoyFysKpCZGZ9qyV?=
 =?us-ascii?Q?XQ2eQnRITlP6Jb0oMtHhmIQEpL0N0t2urRKh1JbDnRG1E+qya0oSIVNheQ3b?=
 =?us-ascii?Q?n4V4NY3wg2/1R8qwURK0mOqrawmIrC2S5DpxF3CVK2Yjn9jkJSaLQe7obyzY?=
 =?us-ascii?Q?WRXplNCPeTUtxeS88vAArZfMxCDY475KOILhUIZd7Evsvt64Z6TV70jrqmzo?=
 =?us-ascii?Q?7ntLl7AUaw3hkYEmBZ0GQ0HPtyLi/XDJB+y4olTrs2viK/o7w7Uw8hLtXMhy?=
 =?us-ascii?Q?3D8r2zEJ2i6KeabtdnP2mTIRrIV53SeA86lfe4hT1ug0oVci2uxc8prtgH0G?=
 =?us-ascii?Q?I9Vx77cJp6lKFGy0UWI9pnof+i229sYqLrPZAZKtKB02J8DZXFIRTjzAnfw5?=
 =?us-ascii?Q?O6i8Pxh8KG1EjJY4hmIINxu0qn8DZDWS8b+tWqT2hMix92ioTOxdiTpV8FMb?=
 =?us-ascii?Q?nK7Z5oj2FRZP/omAw5iZjcQuDmCtDYiFs9I0/Q6XK/9+LhW02/4eFHLYbVsM?=
 =?us-ascii?Q?UWikd9Vfx6GIPFWN74bVg6esQRCcU+xCsgW1LUFkRsJ2JjkkBDas81ZrolBh?=
 =?us-ascii?Q?d31jL+fYZhuaNZcb7YRqmdGOXBSaQYTkTULymS2llwCTZAFfvS3XBBrtR+JS?=
 =?us-ascii?Q?GWe0yWS/mcl5NSGPyvVb8MezJDwOnKifNJr6hjOYoxRO75CI/hgTgk7R1reJ?=
 =?us-ascii?Q?nSSV/jONfiyXV7ep6rivEYBPzqMJKT0=3D?=
X-Exchange-RoutingPolicyChecked: EPL71Nt9WubjyOeeC92GL7Ui8JOsuNz89lUeyo2iAvwf2CPI1VDlG6FiHE6gWZSUMZTqJeKik3PXJBC85KmVNcT1nVYdk4wvfSc+KJBkDWPNp1LJk8H/rAB8XF2aFATU6HIvXvKYr5m2l8xb+DjKUHwD4zQE3AvnvSjaJiBTqqqHHFN5lvhQsecykHKeo8Mh9WnMHN/yKWRVepPaSV4o+9Z3cryJ65falGl5u3VfHSO5iBTt5Hs9QLrA/S3S0EXH9EB/1uInhkj+/Kt3nvSGvnmjEUMg77g8SbQgx4DGFZd9UVYRdm3i+U98sOxL/9P9ThcFIwEqhuKnKCMiWQLNKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ebb354-16fd-4b35-8c27-08ded8fc4e08
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:12:08.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZ3xuNCg1JqB+/v2T0QN2RUNLXoINt7G7HmESQyhzF8vp3f0TfSx9bO6qRBVa/mB40ytF0aideCTNWNLIPr+KJqhC22uAKqUw0BtvwYUs30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4647
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304527-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,boxer:mid,ntu.edu.sg:email,intel.com:from_mime,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5715270249F

On Fri, Jul 03, 2026 at 02:05:18AM +0800, Maoyi Xie wrote:
> __octep_vf_oq_process_rx() has the same unbounded fragment loop as the PF
> driver. buff_info->len comes from the device response header, and one
> fragment is added per buffer_size chunk with no check against
> MAX_SKB_FRAGS. A long packet yields about 18 fragments, one past the
> default MAX_SKB_FRAGS of 17, so skb_add_rx_frag() writes past
> shinfo->frags[].
> 
> The fragment count is now checked before napi_build_skb(). A packet that
> needs more fragments than the skb can hold is dropped. Its descriptors are
> drained the same way the build_skb failure path does.
> 
> Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  .../marvell/octeon_ep_vf/octep_vf_rx.c        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> index d982474082..7af6a80671 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> @@ -431,6 +431,26 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
>  			struct skb_shared_info *shinfo;
>  			u16 data_len;
>  
> +			data_len = buff_info->len - oq->max_single_buffer_size;
> +			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
> +				desc_used++;
> +				read_idx = octep_vf_oq_next_idx(oq, read_idx);
> +				while (data_len) {
> +					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
> +						       PAGE_SIZE, DMA_FROM_DEVICE);
> +					buff_info = (struct octep_vf_rx_buffer *)
> +						    &oq->buff_info[read_idx];
> +					buff_info->page = NULL;
> +					if (data_len < oq->buffer_size)
> +						data_len = 0;
> +					else
> +						data_len -= oq->buffer_size;
> +					desc_used++;
> +					read_idx = octep_vf_oq_next_idx(oq, read_idx);
> +				}
> +				continue;
> +			}

This is exactly repeated code for !skb case below, right? Please pull it
out to helper function then.

> +
>  			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
>  			if (!skb) {
>  				oq->stats->alloc_failures++;
> -- 
> 2.34.1
> 

