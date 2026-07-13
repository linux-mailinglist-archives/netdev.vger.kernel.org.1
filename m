Return-Path: <netdev+bounces-307258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7VDwGZckVWrNkQAAu9opvQ
	(envelope-from <netdev+bounces-307258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:47:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DFB74E1FF
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:47:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=mYZR81fQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307258-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307258-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7AE43002E4F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28553264D8;
	Mon, 13 Jul 2026 17:46:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC17C8CE;
	Mon, 13 Jul 2026 17:46:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964818; cv=fail; b=RwzbUoRR6cqMzjPvGbEezerAYz9Zat3gG9GobQj3J+0klPPoYu2XD30TGJtPidF+A+BIWYvOLiFHdXmP1WDoM9pBz7CXGNtXGUzRV9sUzLZ5QD32dvJXdsdUM87uvswgo/gXMR1L9vtZnOV19AkwBoYzvt+8cqnDnjeDH/Kc/II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964818; c=relaxed/simple;
	bh=Q1jRyTsl8aUMNrcN19wzY9ghHUzthq72eCpypgXhNXA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U5FNQRk0/FpeG/dkVhHcYbNulXrHHfgjTnwCfth8yadSeuEaqr+RuzXQAuOElLF3Cdw/6LAWqT7PwYQg+EKEZNHDoHVr8eJdQMI/pEyrZ2GZRW9E6kpuICRzT2m8YSd68zKyo8eKetjdJ9UViec85lquh7wvA445xcJxDyPXpzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYZR81fQ; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783964817; x=1815500817;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q1jRyTsl8aUMNrcN19wzY9ghHUzthq72eCpypgXhNXA=;
  b=mYZR81fQmGJ426A+djPFoLepgp0eTI4woACN1j7Cp8MwGyE25MgXyzur
   6JKa/A+JO5x+nV4O4mH7KfUp2meFa59KSHErRW427C7N5txACCDwXaDtj
   p4uwsrNeZnJcdz7VPYZSJ7N4N9m+KPvOJlzIefWMXv6Kn1EX27oK2I0k2
   g2vFor3pWBme0Zvh+8QNJ2n4xOfgesGUPgMhWlxS0D5nD33Ma8rdw/2J3
   Q+XhuMEKY0P6K2e2MbEww5bBvDqqHqGkLf29L3cDbb+7Fwhu/lqbSQeWi
   XOyfeBAU6i47m9GkNUj/EBBQqF8a+DSJB+XCPv+i0orZsu+PKs3Yjt+Vl
   A==;
X-CSE-ConnectionGUID: xcJ6WTlnT86LSISzpfvDpA==
X-CSE-MsgGUID: U9cdffGbSaiAcnRqPsdUAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95224128"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95224128"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:46:56 -0700
X-CSE-ConnectionGUID: xQj6VIPxSX2JFDdGWBz8rw==
X-CSE-MsgGUID: gzPxPK0gRJOwvVgpWNu/8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259462067"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:46:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 10:46:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 10:46:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 10:46:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcdkOLgrwO/Tbda38zBpqxpNsXFkya3h/5Fwi+YpD+uo9w8GH6oKVC7fzAsvN17id/ByCX8qoqM7hoBvjss7oZCEcszmTmYFXrfQwrYcyPmFRDhYLtG5r5x4vcWsQwV0b3unUj95SN4/oQrleQZ78O+yNsoJ3l4Vsebhm8TMbTKDjc9JTycpk1031vSxzgIz7mszwzjzmWBlm3Ju6A+cIcbWurdLy23PIjwUJuJFz9xH+rQ1uA+X2bDYYVUrGvuAdMYebAZ2ub9Ens/VSndyqXwhTK5HALgldV1Dw/3oB9S2NyHVJ8E672aiMONXc2/kSzrRtnGs/DmGMvKTK8RiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiIeACTAPzv3dqgUrZO2wesbdTJJE2+N7JhoOG4VGfA=;
 b=p7IpE/vYaFaeH0TZ+vVpmR7CHtgunUHMx3naAkkjNZlv9RySPv+3tlgOmi+ik/Qn0q/Qw2r2JCf6uXTfYY8MW0XEGLDoRxsprrQ67hJ1x3GwoWlBiWzz39XO7Bft5TSB4WNtsj0h/P6wjfnJvKT8k2Slc3b+MBgsH6OMM0BgVFNIDZhO1wkfGGG8mctWuw8c8K9iam5gedDWMyyRpyyMWcKKAzkvG/oBwzgPrquGCgzB4PaqiCsv53gRodwz93oAujI+Cx0PgrYypuw4GVj2yrBtG8uYN38FrANfesf8T9Rxim2pUdNdMRWHAUAfVt8JNkLfj8pxCKCYZxbdiv3VPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 17:46:53 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%7]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:46:53 +0000
Date: Mon, 13 Jul 2026 19:46:45 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Pavan Kumar Linga <madhu.chittim@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>, Samuel Salin
	<Samuel.salin@intel.com>
Subject: Re: [PATCH net-next v4 08/15] idpf: refactor idpf to use libie_pci
 APIs
Message-ID: <alUkhWTMGNsytX4J@soc-5CG4396X81.clients.intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
 <20260710215313.1475803-9-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710215313.1475803-9-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: WA0P291CA0009.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::9)
 To MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 95588790-f551-4827-b399-08dee106b94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|376014|7416014|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: aic+nNAhMu2ZHVPtPJqGxaaK0WwAqgmkhlRM3TxzUJp1lKGDvurPbdMzSyU8SRX19inUtJjERqYWIasg11XwkhZ2lgt57lYMO9Xh27oti3jHb++dPjmFiyp2xfa6zjDhQ9mtMf3cXz8H+6zZlcvYjGgO+N9CBFNVVma15mAjd2CkT85tCwbcv4uNqqPaCgBr9fHkGGHEq9Ihulua7kHrQ7KhpBKsqzWfzLgSsyopxbxsrcDPOTalqY6dtxktbYfT8gn4NMMrhkrX8DnoN5MJdaoSYPYgVN0qoOgj5LxR10uoNnOZYl7XeB7AcOVvfzWYxOTghHEzTYIrRF1fAYoEwQEir/JikV0O7NcWlOKzjcgHL3oJQUWQSRZJXitchd1sPjFmNAYD3UaZNO6ao1evsA6Fe67qCp3OWJ8g/BKfW1HvdAvCg/6jdexdlMApesgQKUKibL8Vc7y3cMANIs+o1WXLPoNf3Qr5EqjsUKj9UoDJSNIIRpuDc8QyfD1SMZeA3J/u1vqnHZRYq5jWMIf9XWmKEjgF1BG+KniEvmJZPa2vrqNUK0t8r7o/lt/FhgGbLmX1rQHz3L5lWvY+UBwfVP93hJCSKoYo5LFRi0WLA4B83VjYneARdI+X2kzdiSSNERBMW/3ugVPLs3seOopcAQRt5zJ73OV1eoo/GWAXSGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(7416014)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/QIAOg4EGg4gv/Tuuvc1wmbAPYwdeiZRyld2WhFlvcV1+TzZHBr20IGYSX5U?=
 =?us-ascii?Q?FACgmYdrcOqi0QzYgzLOxggEKsNgK4z66T36A3iv97Ryp+cbSKkQYW/ODJs4?=
 =?us-ascii?Q?MKat7R2FDLWE/x0fg7mFiIqzr9Yb0Mu7YTFczX8Dv6sPCsza30//6pkkEKUS?=
 =?us-ascii?Q?OWDTA/uK14TaFasVeazTysVnyeeickiASMwJSmzT8hTxTGKb2kCYFGVFX9DH?=
 =?us-ascii?Q?Bk91HM/XCyOCYNhzVXEYmewLS33wVs8lK2ISIAH2Q9BvANo0uxP52iiwiErZ?=
 =?us-ascii?Q?jbVWkKY/z9FtZ+HdJadxYeSdnWU8pFrSfaiyPjUDxh2qD/rLYkob4GRtIOru?=
 =?us-ascii?Q?mtDv2QDJNFrA8QUxGje04BVOEe3k21GLj15li77au1yah8F/RZTi7LdhsPhQ?=
 =?us-ascii?Q?HuBNDzPln6ileGEFwbZIpMFuyLC7AT3DgWrd8CX9p6VvJkfn42Rel0DTC5Q5?=
 =?us-ascii?Q?1ZU+ow96Fy6LHTR4+JIrKfJ331IoHDw7DvcZLPTjf8gqKWCLKAimEzyuxECG?=
 =?us-ascii?Q?wqTW4E9UUoNnK4nqWqQHe0woFxn2O90NssTYD813ZaZFgQTyLODRGi5NrQjG?=
 =?us-ascii?Q?fUsHQb/rvONNOnkiY6f//I6tIBO9Cval67fxWDejmT10NTLnEOYqepa5VRZq?=
 =?us-ascii?Q?UuTE8HZgq711lytv9/6pEovBbHeJP48J8BETI8l4mAW3xTlAAy4iAB1Q7o+G?=
 =?us-ascii?Q?t3JRLNKPq/5dORrhscfSfgbaMlhdPzivVRJwR4oPzfqoCwYRj8rpHPSYG0bX?=
 =?us-ascii?Q?8rUTYK1U6RrDhVWvCMLPSWocVmJQ5pRVqlAHpm9j3Bin1rielTOy3mstNJmd?=
 =?us-ascii?Q?JVx/09EwBjl70qmyST8wzU+BF1QQRkefZObfXEzh2ZqoM2qzRCjaj+8CcG5p?=
 =?us-ascii?Q?jl+Ohl051H5HMRlmJTAeV+MPg8M+LCOrxpJGfxT3P6QmzYs261aBFIZsytJm?=
 =?us-ascii?Q?dpOKvxpZk418qSXNkBkAUA5zGfew6i483ceHgRcdsc7wpr+TTAzPuW1ywMrV?=
 =?us-ascii?Q?rPvnfENLEXD8OLzR5dYZlrvSD5AkL8W+M4GAXQL/IMdOs969K3QEqbUoYbAC?=
 =?us-ascii?Q?ap8VFRgfbwf8eLcfMTd89KpNPbkBS5JGt2opmT5RnM56YZSqRGSuG04gQ28I?=
 =?us-ascii?Q?hiZl29Mtfh/B+e39zB0NRis0DEdaIDskeFnGEmiQvHXyYkjyFaTlQaxbTwVm?=
 =?us-ascii?Q?oVpmPZI1LiyWQrv8IFMWeHrT99gsYcoOpBTGSMowJ13b6ZIBktn7ab1+BdDX?=
 =?us-ascii?Q?wbZ43w0vT7fU6Sbz/pIt7CyLr7QsFWRGUTzTYx2QfTHIhKC6Jomu8wFtSB+s?=
 =?us-ascii?Q?HyqFnkylFV+Gtn268g1Yz5IeNmC/8htv7j5KkasYQo0trCaLPiGkSeQ9vHLw?=
 =?us-ascii?Q?EVVUUHmO16JuXtMVa6fnYDjak7WEjN+GXpPF1EiZRJVldHZGOXilOxzbLUQp?=
 =?us-ascii?Q?KcueBZDGON/qohOeoIodFZMusyhfEUUYsgYOI7lCppJt47JYlu/LC+tyvwnB?=
 =?us-ascii?Q?iJDHCKrMvyfrcZgaH7S7kpXqFDcXog0zkGgBYwE6niF8Cnh3GNnKWECBPM+x?=
 =?us-ascii?Q?OpiS7+BPl5vx5Ft5tu1IlyXy44ILptWNihrJQLBPio0dL0+1S3wBh/RAYCuL?=
 =?us-ascii?Q?LIiHwTieZmfy1eizTtPEoqXqy8JV6bd6+AT3vNvnkJAxV1IUXuzhdaQ3CyTC?=
 =?us-ascii?Q?tH9Kl/k+B6KCeSr3udpIsoF2y0U7jC5VLzTQtHH/FUsNcz6bi6TH9pnCnJIV?=
 =?us-ascii?Q?hAM12r3Cy5Cy5M9ZfC54FMyn3+RZ8Sizs9B8b3IWi87upP4MJVMHH7RrfMC9?=
X-MS-Exchange-AntiSpam-MessageData-1: BXXhegXsuDpWiepJ9CrTZ4myMfh4pKio7RI=
X-Exchange-RoutingPolicyChecked: LHDhyOO/DtKQFdINB+C42gI8O8nuvS1U2VP3jakBROZVvVgOAXEK3XNFdLq5Ko6g3+oRk4YTN2ywcQhZWYcoSKo1mqKoAld0Ct7lyqybm81k/0qHEDOFxiwA/pCuJoFgFsXLDcKkR0TtOtNd6bXHw7sT+vs1mFWaN7JEamMdF+GgydLIfCQvYz82Sbg3LoslAPdJhKzfiPMD+Tr8eSTq0rm8sdmUfpiiHJidREJCzqIbGVZrzDuzr1KoyQNU0Et5JK3NSpShvdbLPPCV9+7caD/Qk6oUrlEgYPh87DIEG89MFtZiLcGM1XihU93/FJamg8r5vck2CcCoqO1byyujDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95588790-f551-4827-b399-08dee106b94e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:46:53.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ORp+1GkgYko5/fWC6L7dmkSaF6wqdeCF0ui8sCyhSBcxtM0s9Iw3P3p2ICUDwv5rK90fK5eGnAqeTUFqG5yK6wZK2MsW0e7nBrZUlDDp8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307258-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:madhu.chittim@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:Samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02DFB74E1FF

There is one nice-to-have change that came out of Sashiko's review:

commit 5238b5986775c0c76881ed594a7b09216ee20107
Author: Larysa Zaremba <larysa.zaremba@intel.com>
Date:   Mon Jul 13 17:07:10 2026 +0200

    fixup! idpf: refactor idpf to use libie_pci APIs

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 5a191644b28e..184d30c12abb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -265,8 +265,9 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

        err = idpf_dev_init(adapter, ent);
        if (err) {
-               dev_err(&pdev->dev, "Unexpected dev ID 0x%x in idpf probe\n",
-                       ent->device);
+               dev_err(&pdev->dev,
+                       "Failed to initialize device (ID 0x%x): %d\n",
+                       ent->device, err);
                goto err_free;
        }


Everything else:

> commit 461758d19f17656a1ed2f88e0867b4610ec38b43
> Author: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> idpf: refactor idpf to use libie_pci APIs
> This patch converts the idpf driver over to the shared libie_pci init
> and MMIO helpers, routes mailbox and register accesses through
> libie_pci_get_mmio_addr(), and adds a struct libie_ctlq_ctx to the
> adapter for the mmio_info list. struct idpf_hw is kept around because
> it still houses the control queues.
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.h b/drivers/net/ethernet/intel/idpf/idpf_controlq.h
> > index de4ece40c2ff..acf595e9265f 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_controlq.h
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.h
> > @@ -109,8 +109,6 @@ struct idpf_mmio_reg {
> >   * Align to ctlq_hw_info
> >   */
> >  struct idpf_hw {
> > -	struct idpf_mmio_reg mbx;
> > -	struct idpf_mmio_reg rstat;
> >  	/* Array of remaining LAN BAR regions */
> >  	int num_lan_regs;
> >  	struct idpf_mmio_reg *lan_regs;
> After this hunk, do num_lan_regs, lan_regs, struct idpf_mmio_reg, and
> IDPF_MMIO_MAP_FALLBACK_MAX_REMAINING still have any users? A grep of
> the tree shows only their own declarations in idpf_controlq.h with no
> readers or writers after this commit.
> The same question applies to the mailbox helper macros in
> drivers/net/ethernet/intel/idpf/idpf_mem.h, which are left in place
> but still reference the just-removed mbx field:
> #define idpf_mbx_wr32(a, reg, value)    writel((value), ((a)->mbx.vaddr + (reg)))
> #define idpf_mbx_rd32(a, reg)           readl((a)->mbx.vaddr + (reg))
> #define idpf_mbx_wr64(a, reg, value)    writeq((value), ((a)->mbx.vaddr + (reg)))
> #define idpf_mbx_rd64(a, reg)           readq((a)->mbx.vaddr + (reg))
> Would it make sense to drop these together with the field removal
> above so that any future accidental use fails at review rather than
> silently reintroducing dead paths?
> 
struct idpf_hw and those macros are dropped completely in the next patch
> 
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> > index b7d6b08fc89e..0a7edb783758 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> > @@ -416,9 +416,12 @@ idpf_idc_init_msix_data(struct idpf_adapter *adapter)
> >  int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
> >  			       enum iidc_function_type ftype)
> >  {
> > +	struct libie_mmio_info *mmio = &adapter->ctlq_ctx.mmio_info;
> >  	struct iidc_rdma_core_dev_info *cdev_info;
> >  	struct iidc_rdma_priv_dev_info *privd;
> > -	int err, i;
> > +	struct libie_pci_mmio_region *mr;
> > +	size_t num_mem_regions;
> > +	int err, i = 0;
> >  
> >  	adapter->cdev_info = kzalloc_obj(*cdev_info);
> >  	if (!adapter->cdev_info)
> > @@ -436,22 +439,37 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
> >  	cdev_info->rdma_protocol = IIDC_RDMA_PROTOCOL_ROCEV2;
> >  	privd->ftype = ftype;
> >  
> > +	num_mem_regions = list_count_nodes(&mmio->mmio_list);
> > +	if (num_mem_regions <= IDPF_MMIO_REG_NUM_STATIC) {
> > +		err = -EINVAL;
> > +		goto err_plug_aux_dev;
> > +	}
> > +
> > +	num_mem_regions -= IDPF_MMIO_REG_NUM_STATIC;
> >  	privd->mapped_mem_regions =
> >  		kzalloc_objs(struct iidc_rdma_lan_mapped_mem_region,
> > -			     adapter->hw.num_lan_regs);
> > +			     num_mem_regions);
> >  	if (!privd->mapped_mem_regions) {
> >  		err = -ENOMEM;
> >  		goto err_plug_aux_dev;
> >  	}
> >  
> > -	privd->num_memory_regions = cpu_to_le16(adapter->hw.num_lan_regs);
> > -	for (i = 0; i < adapter->hw.num_lan_regs; i++) {
> > -		privd->mapped_mem_regions[i].region_addr =
> > -			adapter->hw.lan_regs[i].vaddr;
> > -		privd->mapped_mem_regions[i].size =
> > -			cpu_to_le64(adapter->hw.lan_regs[i].addr_len);
> > -		privd->mapped_mem_regions[i].start_offset =
> > -			cpu_to_le64(adapter->hw.lan_regs[i].addr_start);
> > +	privd->num_memory_regions = cpu_to_le16(num_mem_regions);
> > +	list_for_each_entry(mr, &mmio->mmio_list, list) {
> > +		struct resource *static_regs = adapter->dev_ops.static_reg_info;
> > +		bool is_static = false;
> > +
> > +		for (uint j = 0; j < IDPF_MMIO_REG_NUM_STATIC; j++)
> > +			if (mr->offset == static_regs[j].start)
> > +				is_static = true;
> > +
> > +		if (is_static)
> > +			continue;
> > +
> > +		privd->mapped_mem_regions[i].region_addr = mr->addr;
> > +		privd->mapped_mem_regions[i].size = cpu_to_le64(mr->size);
> > +		privd->mapped_mem_regions[i++].start_offset =
> > +						cpu_to_le64(mr->offset);
> >  	}
> Is a semantic change to what is reported to the IIDC RDMA aux device
> intended here?
> Previously idpf_calc_remaining_mmio_regs() always reported
> IDPF_MMIO_MAP_FALLBACK_MAX_REMAINING (3) regions, including any that
> happened to have addr_len == 0, and firmware-supplied regions with
> size == 0 were forwarded verbatim.
> After this patch:
> - idpf_map_remaining_mmio_regs() skips zero-sized regions via the
>   !size || short-circuit before libie_pci_map_mmio_region().
> - idpf_cfg_lan_memory_regions() skips zero-sized firmware regions via
>   if (len && !libie_pci_map_mmio_region(mmio, offset, len)).
> - idpf_idc_init_aux_core_dev() now fails outright with -EINVAL when
>   list_count_nodes(&mmio->mmio_list) <= IDPF_MMIO_REG_NUM_STATIC.
> If a valid platform has, for example, the mailbox at BAR offset 0
> and rstat abutting the end of BAR0, are all three fallback regions
> zero-sized, and would that make the RDMA aux init unconditionally
> fail on that configuration? Would it be worth calling this ABI
> change out in the commit message?
> Separately, is the count/write-index invariant in this loop enforced
> anywhere?
> The code computes:
>     num_mem_regions = list_count_nodes(&mmio->mmio_list);
>     ...
>     num_mem_regions -= IDPF_MMIO_REG_NUM_STATIC;
>     privd->mapped_mem_regions =
>         kzalloc_objs(struct iidc_rdma_lan_mapped_mem_region,
>                      num_mem_regions);
>     ...
>     privd->num_memory_regions = cpu_to_le16(num_mem_regions);
>     list_for_each_entry(mr, &mmio->mmio_list, list) {
>         ...
>         privd->mapped_mem_regions[i++].start_offset =
>                                         cpu_to_le64(mr->offset);
>     }
> The loop increments i for every non-static entry, but there is no
> i < num_mem_regions guard. It relies on exactly
> IDPF_MMIO_REG_NUM_STATIC entries in the list having mr->offset equal
> to a static_reg_info[j].start. If, for any reason, fewer than
> IDPF_MMIO_REG_NUM_STATIC entries match (a future coalescing in
> libie_pci_map_mmio_region(), or a firmware-supplied region whose
> offset happens to coincide with a static offset without being added
> as a duplicate), does the loop overrun the mapped_mem_regions
> allocation?
> Would an explicit if (i >= num_mem_regions) break; inside the loop
> make this invariant local and enforceable?
> 
Static regions are *static*, we can absolutely rely on at least
static regions to be valid
> 
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> > index ab3c409e587b..93b11fb1609f 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> > @@ -246,32 +265,21 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  	adapter->req_rx_splitq = true;
> >  
> >  	adapter->pdev = pdev;
> > -	err = pcim_enable_device(pdev);
> > -	if (err)
> > -		goto err_free;
> >  
> > -	err = pcim_request_region(pdev, 0, pci_name(pdev));
> > +	err = idpf_dev_init(adapter, ent);
> >  	if (err) {
> > -		pci_err(pdev, "pcim_request_region failed %pe\n", ERR_PTR(err));
> > -
> > +		dev_err(&pdev->dev, "Unexpected dev ID 0x%x in idpf probe\n",
> > +			ent->device);
> >  		goto err_free;
> >  	}
> >  
> > -	err = pci_enable_ptm(pdev);
> > -	if (err)
> > -		pci_dbg(pdev, "PCIe PTM is not supported by PCIe bus/controller\n");
> > -
> > -	/* set up for high or low dma */
> > -	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +	err = idpf_cfg_device(adapter);
> >  	if (err) {
> > -		pci_err(pdev, "DMA configuration failed: %pe\n", ERR_PTR(err));
> > -
> > +		pci_err(pdev, "Failed to configure device specific resources: %pe\n",
> > +			ERR_PTR(err));
> >  		goto err_free;
> >  	}
> Does the "Unexpected dev ID" message still accurately describe every
> failure mode of idpf_dev_init() after this change?
> idpf_dev_init() now calls libie_pci_init_dev() first, which wraps
> pcim_enable_device(), pcim_request_region(), and
> dma_set_mask_and_coherent(). Failures in any of those (for example
> -EIO or -ENOMEM from BAR request, or DMA mask failures) will now be
> reported as "Unexpected dev ID 0x%x in idpf probe" instead of the
> prior specific messages ("pcim_request_region failed %pe", "DMA
> configuration failed: %pe"). Would it be worth propagating err via
> %pe alongside the device ID, or letting libie_pci_init_dev() log its
> own reason?
> 

Valid, look at diff at the start.

> 
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > index a3c17f0e14f3..357ff3e86b2e 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > @@ -3445,35 +3450,30 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
> >  	}
> >  
> >  	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_LAN_MEMORY_REGIONS)) {
> > -		err = idpf_send_get_lan_memory_regions(adapter);
> > +		err = idpf_cfg_lan_memory_regions(adapter);
> >  		if (err) {
> > -			dev_err(&adapter->pdev->dev, "Failed to get LAN memory regions: %d\n",
> > +			dev_err(&adapter->pdev->dev, "Failed to configure LAN memory regions: %d\n",
> >  				err);
> >  			return -EINVAL;
> >  		}
> >  	} else {
> >  		/* Fallback to mapping the remaining regions of the entire BAR */
> > -		err = idpf_calc_remaining_mmio_regs(adapter);
> > +		err = idpf_map_remaining_mmio_regs(adapter);
> >  		if (err) {
> > -			dev_err(&adapter->pdev->dev, "Failed to allocate BAR0 region(s): %d\n",
> > +			dev_err(&adapter->pdev->dev, "Failed to configure BAR0 region(s): %d\n",
> >  				err);
> > -			return -ENOMEM;
> > +			return err;
> >  		}
> >  	}
> Is the mmio_info->mmio_list traversed while it may be concurrently
> mutated?
> libie_pci_map_mmio_region() calls list_add_tail() and
> libie_pci_unmap_fltr_regs()/libie_pci_unmap_all_mmio_regions() call
> list_del() + kvfree(), while __libie_pci_get_mmio_addr() traverses
> the list with plain list_for_each_entry() (no lock, no RCU).
> In idpf_init_hard_reset() the mbx_task workqueue is kicked before
> idpf_vc_core_init() runs the memory-region setup:
>     queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
>     ...
>     err = idpf_vc_core_init(adapter);
> And idpf_vc_core_init() then reaches idpf_cfg_lan_memory_regions()
> (which calls libie_pci_map_mmio_region() in a loop) or its error
> path decfg_regions: which calls idpf_decfg_lan_memory_regions() ->
> libie_pci_unmap_fltr_regs().
> Meanwhile mbx_task -> idpf_ctlq_post_rx_buffs()/idpf_ctlq_send() ends
> up in libie_pci_get_mmio_addr(&hw->back->ctlq_ctx.mmio_info,
> cq->reg.tail), which walks the same mmio_list.
> Under current code the mailbox entry is the first one added at probe
> time and is never removed until unmap-all, so iteration terminates
> before touching the tail being mutated. Is that invariant intended
> to be relied on going forward? Would an explicit lock or a comment
> documenting the read/write ordering constraint help protect against
> a future addition (for example a PTP or ITR register lookup from a
> work item) that would need to walk past the mailbox entry?
> 
This is fine, we can rely on the mailbox register to be valid
while mailbox communication is going. MBX is a static region,
so it is expected to be unmapped only once we are shutting down for good
> 

