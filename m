Return-Path: <netdev+bounces-275351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBfAAMTj0GmIBgcAu9opvQ
	(envelope-from <netdev+bounces-275351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:11:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D32839AB8D
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D523F30055A0
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B43A874B;
	Sat,  4 Apr 2026 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9tf9uyn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3D3A5E7D;
	Sat,  4 Apr 2026 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775297473; cv=fail; b=o84IRqQMds/mF28WOD6JsO8Ljli7sYunuWTGASvbWMb2MlAwG5ZCTuK9Bo7X3l6mBVQckbLbkbfgq7f5ruh5VuHtU6juz4+8/cAFDo77pZ9Bak+/XB0eN8yA+HxvpE8navMUyXHxgl3KsnurtyET7nNaCpZu0cl2IZ0mXei9Kxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775297473; c=relaxed/simple;
	bh=XuscLxGbkO5j4gFDlC7mJIyqidZ+PNg0+qnwEbA79/k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QcvMq0do1YQ4fIs5yueaAZwrGykfYYjIvSl2dvEISe+VkqtW6QuhuCkh5YiFbAk++4WKjZQgawUPZB7sH21xngF3Tpb3zgkd7rsnnUvgxAcr2pb7+5M5jkEpawNYJ+xdpDhIY8YWHYGsXnYsMUBIdRvdABD9aALL6LuPMnd11TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9tf9uyn; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775297473; x=1806833473;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XuscLxGbkO5j4gFDlC7mJIyqidZ+PNg0+qnwEbA79/k=;
  b=h9tf9uyny6OYeiCofpTlkvhgRQyZsDIuQq3Gsh1asGZVzG3PIZcLvmBk
   KpIGPMZIGqle9lc09Jums/T4zZdSuwLYElS9gfRjxeDGZE7S4aE0NwWyo
   yYCyf8Q19mymufG6AghQeBBS1fcNKEt6aFOGk+J65+o+8mpAUi6Kuz/+Q
   BK+rL2Zw4ihBlPLNl+SvVLCmbY3ZvrbZQuysvlyhrcdQM41rnihrQkoPP
   ichfQFpjzYK9sNlSRajt+p+t3ktroCR3BZ8d2YvX3WJ/sfzkK5zddz+vF
   rvovBN+zqJL3pHhitK14hSM3PxbjSUCDkD8OQ2ML4+sx9rAWiaMMFbpeO
   w==;
X-CSE-ConnectionGUID: JPkAx1VDSkGGwaZLUdwkMA==
X-CSE-MsgGUID: Y4hgltS4TcmacF27Ayyzrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76528732"
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="76528732"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2026 03:11:12 -0700
X-CSE-ConnectionGUID: V0ypWoqgQlS1ge68yThfmA==
X-CSE-MsgGUID: su04fwtEQDK3zmCLruKtfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="232260875"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2026 03:11:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 4 Apr 2026 03:11:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 4 Apr 2026 03:11:10 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 4 Apr 2026 03:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Inr7ltxauM1tkBi7d+WsNVY7FUb0zt6Wnj8EenZRIzXdFHlSx8ariMSzNuGT462+IjDcrK/H9OKQEZ7qsxFS05wQDt8zqpWBmCcrYU+0+984sR94dM5j14ud1OjRC05am8SeVtcbr1ysdDdcBLQIo89R/Wnpn/xUI2sUgyHxjz9f0I0jlYtEntFMM474/lYI2quNCKMrUAqPusk6sfU+BZt9Bx558/IfNc6LV+ciyjTPtJqWKCQmIwaWfvh0qJayWYzpIxDmVrdbyKJee6RoYNupr1ZdmxyNBYQxCojsdm49AjkdNZG4flphkLG1Bu1VXiFhXjyc38XNwHKCfbPfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbff+dxBK1qFlNYKW3gzdzPunaTDbdEGzKTKmbaq9es=;
 b=VMudvtnKwRa6ao/QxmlVDNrG0FJu3d92t90emES8EJoa4/cVPJAykZ2sa23bi+Z6VszgrMrX2EzELnhcRwVt6/QKiaGYvQKh8WY+5dgL5Xr28n51CtMGhBLtj8WvzfDremigViyi+1wOknyRlDw4+3OBfLa0I/tNZkRUh1Z7dk79b3LTi1Wef4SCXxSJAT8XGCraVMeG6wKUZ2E/SZnWWHcx8KZVXhwbe8+D+kzuO7Zti+ibiJowHGGEAs/kj42U+9wdmITCFyTQX5SxhPv+rttVfNjf+VB4XmifpmpxFs45P83B6A4sP2kWp1qHviLnYqzGdaCx05zze9AyGwHueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Sat, 4 Apr 2026 10:11:07 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9769.017; Sat, 4 Apr 2026
 10:11:07 +0000
Date: Sat, 4 Apr 2026 12:11:01 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <larysa.zaremba@intel.com>,
	<aleksander.lobakin@intel.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v6 net 3/8] xsk: fix XDP_UMEM_SG_FLAG issues
Message-ID: <adDjtUbNPSjffLSm@boxer>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
 <20260402154958.562179-4-maciej.fijalkowski@intel.com>
 <20260403165636.1f4ee958@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260403165636.1f4ee958@kernel.org>
X-ClientProxiedBy: VI1P194CA0029.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8a0db4-a43a-4bee-2c37-08de92327cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: y7D/8ygS28JHOxrSGRsZtQPTQzWUTicUyvmDRYCRs0XMa6p5uE8ff39aK3faqsA4PrLv0jRt7CzyQsQBHgvWPssZb3qc91IvSmgn0dzav7ahL9aovn13/50OyNBSjA+LiSSl3STDWOVeu6urCB3LIuxuBWrdGdXVtokpVFW0TmIge2x3N+v6r6Oso0FY7C7FUtJnJ8m+3XxOUacJgPK+DagYfCkajmNrHEVMJZDocWa2p+tQxlQxyEdxDOZspvkbc540Do1jAU63J/uTk4V/6RyYOpzJlX/jrABjdvPkXG9Dgdzsq994+OxI8Qu1AXJ3/IViIiXl+FblaB+Rj0dCe2xLfBrGLOye+nqrmpLkH95MFhOJ0xna2SdNiz1m3gjs6D5UdZcYdwtjJDvbBH3a5jma75WAUO3tCzRgEZluyKh7PBGCZHYK5NGfwHUFXaXfcRGSAnqEpNFh6rQ+2nxAOo17ZbNv5HcXuxDS8Vewp+5DREwpRXZFIo9FcUSmlT2NLFk62W0Kbh/WLdkx5eXSxxQZJU2qCsDBOxE4HwviSNS/5fvZwzMh8Gt4E0/JCDVopZ11jn5vuqwYLl+T2Kz00ILavV/EO5tuWpoB4DmAXETJTYe6CX/u7/JTzu1d/Kj5sXOdM8IEdt6tlQTgTA96CDaveDpvKHvg4xfZ+EZjA/yr2R7bkAIfyLMWSQWCHzKLS0T/DGsUwz+VSfao4IbwM8nT7vdzYem37tENhVVqrAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2HH6bZ9xznEC+m+U/39ClC692XYzByG4/vFL6oOLhC20KF9Yv7Aj10mfBpMt?=
 =?us-ascii?Q?QddkIBZkYgxWjPRR0JVw98ymqRPXkp/eKXrivaFChHzy40niVLSnmo6x8KLD?=
 =?us-ascii?Q?68f+dENKGdjag0zcn+3gVVwSzCnfmY6RYZrzjoGNqa88V7226OoPK8EJM1uq?=
 =?us-ascii?Q?5BcWrK5WbZgEgTcv/sH5DZBzHOgCgV+GrfKMfRs9PoBysJz7uepl/QB0CVub?=
 =?us-ascii?Q?CWZNm1F9gYgAbQ62ztvoshPWQqZaO5+nSH2P81BKAw6E0AUlcN12zsKZU30v?=
 =?us-ascii?Q?5IS3JBI011xEXJLN2R6N2kLWTcyZeXnlrvE3XtBqxwSurwWZuQ98STmdN0lD?=
 =?us-ascii?Q?PcRK0UgUusK1HhbvavnmBg7ukZNdUJH3CdYnQCNvb0S2Q/R1o3gXaLPdZkMj?=
 =?us-ascii?Q?L8lTZ1PCYfmNCdEJnEx8W5QHHp9FA4Dmm9d26pCpu2htXGJ7R8vRDW/sUjNq?=
 =?us-ascii?Q?TWzD8d3oT3i3GzHo5jKjvSNoZlRer2KVzrP4ITDo3wku6zVmcWO9BlJjfjNc?=
 =?us-ascii?Q?i14NNa2+U36HDflb/xIDUqbrXsOV5yGw5y/EviFm3Hbp6ZNSMt9K69K7hUNO?=
 =?us-ascii?Q?k0v3qSJYWbvQnXJkNMvZP9wJg8GpAsO3MXNd3ldlSA/dYu5F/xEfzJInRsOg?=
 =?us-ascii?Q?7A7FdMnWySzIBukGuJwTvxHslgvDvAg9x1Y3aPaT/0geqBj5AQhWiT/gduUQ?=
 =?us-ascii?Q?EAg25atIJVO1BEaKSySAz8koj/5sYs5K2mmxvU0jqTJtPSruxdAFB/40zVZx?=
 =?us-ascii?Q?db1cHCeLh8V/o+gFu5/2IleChY2YVqMKpIR+zkSvcnw2HotFY2QPlckCQTgq?=
 =?us-ascii?Q?dCYtAHcZc6mxGIqQVQ2WGBTRaMByyu3VNdpwCxmmtFl7kviFwW/66luk36w3?=
 =?us-ascii?Q?A/6cJttNmIGnSN1byFYePMA0iTfWSA53tKT6j/GbgiONBE/xyI9HRpb+pHsd?=
 =?us-ascii?Q?okY2gjNro+HwZMLDsyMDcw4NUy7fXst6D4MgDPXSa6dayHAV+5R7lTeOH1/x?=
 =?us-ascii?Q?866qZXTM0rM6YwtZrxVb2gDzsGwAENXGiJV22pg0TWNkUHhDq99cQ/AcR75/?=
 =?us-ascii?Q?uZIIhbr5G7SzD5PozJgDXs28wR/V23coxBVtRLEf+XbvcRwhGTEZQ7yXLbwK?=
 =?us-ascii?Q?UADjsfbi1RzdH6/HGQpZ0XB/0VmflzaoTrlpnrM1XYZHstnLnbP/w4ql+EA5?=
 =?us-ascii?Q?qmAP0atKOYPF/SYDp+fBHGBo6hYYoUYjSwysdxzJeHysdzXd0mr7d4t1Nnvi?=
 =?us-ascii?Q?rO9aPf205SK04vHof8p5Cey6rFE3X6dDVCCNCr8Xuj3dUuAX7bbB1eycRWH3?=
 =?us-ascii?Q?bN+Qyg/VrEt4QUAmp5EnFivF4xsWFfNi653ojh4T//t9WZie53LBgiOEuyJM?=
 =?us-ascii?Q?QmVeyDg+KESNMrA73uMgrbv799g5tcDveJgzkMTXNAIlE4/QToXMpkOAfoAJ?=
 =?us-ascii?Q?3TzJsPMrD07/aZ1ssg9KWtdpbXjdrQykGsFPDl++163nJr1Dr5mfagPSCqot?=
 =?us-ascii?Q?2OF9ZXXMdtWr/3z1AlqzIniMJAiacWqiuK0j/ltW1iZ89ORpCgxKqUlf8Paw?=
 =?us-ascii?Q?TXcmVm4F/YlbD90zQFydhaDMvrRJp5ZFLUGhu47nftpNF04CXuBfn7vSQh5E?=
 =?us-ascii?Q?KrSXxaoqxz86ERoa21Dc6GhWL71t5mBuiW5B96/aV2ooOtZcGIgxT9YEn8Ko?=
 =?us-ascii?Q?dGyl75Y9FHKjJbyjP2mzvA/2t7XWe9Df8osIbIrcHQApVTU/+lBbbtUhFNaH?=
 =?us-ascii?Q?ikGz8C9iwavzbr0FP8zgzSAP6r7xTx8=3D?=
X-Exchange-RoutingPolicyChecked: CjzaUDexsC7/AbAj+aexZ7jLCY+eq9io7l2qz+ahssCQvJCUWHaaOOgDGiVF+67AAm8U1Z7BZ9eRUYa0qfgt5006bzyRwwgUjnkXtXKTdtRT5D03JDvdsR6UEqh8i8b6kD7NNnV6iYgQ0avzrD9kO4eVSJKrQycuBW3/Wmngmv2L7W/xSd2HBq1lWi4eJ+wfWpynf+XgHTdq9YbYbZedxLH23C+z2xpmfQh7wufKKFqGYfJPjKYGnPjguEGtG4VTgGDT4ZglKzA53GkueIgzctR5H0J0aPIohWyCB4H9yj6IWkSUqaDaJlE9p8xyUD2N3SrzMiUTNuQe1tVor95mnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8a0db4-a43a-4bee-2c37-08de92327cfd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 10:11:07.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nn86Y5TEgMqTQdhrKX+y4qfT1Q/VpM6qyJ94Ioe34rbdNHBZW/sHAG+BuQ1HpcHvO18r2vH5aJZTRv2QJQ4PqJjLcB8POsbwRIwNEW8tFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-275351-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9D32839AB8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:56:36PM -0700, Jakub Kicinski wrote:
> On Thu,  2 Apr 2026 17:49:53 +0200 Maciej Fijalkowski wrote:
> > Currently xp_assign_dev_shared() is missing XDP_USE_SG being propagated
> > to flags so set it in order to preserve mtu check that is supposed to be
> > done only when no multi-buffer setup is in picture.
> > 
> > Also, this flag has the same value as XDP_UMEM_TX_SW_CSUM so we could
> > get unexpected SG setups for software Tx checksums. Since csum flag is
> > UAPI, modify value of XDP_UMEM_SG_FLAG.
> 
> should we maybe add:
> 
> BUILD_BUG_ON(XDP_UMEM_SG_FLAG & XDP_UMEM_FLAGS_VALID)
> 
> somewhere or use a hack like this ?
> 
> #define XDP_UMEM_SG_FLAG	(XDP_UMEM_FLAGS_VALID + 1)

Good idea i'd lean towards the latter version. I can send v7 after easter
or if there wouldn't be other issues related to set maybe maintainer could
adjust it? ;)

> 
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 23e8861e8b25..ebac60a3d8a1 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -14,7 +14,7 @@
> >  #include <linux/mm.h>
> >  #include <net/sock.h>
> >  
> > -#define XDP_UMEM_SG_FLAG (1 << 1)
> > +#define XDP_UMEM_SG_FLAG BIT(3)
> >  
> >  struct net_device;
> >  struct xsk_queue;
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index 37b7a68b89b3..729602a3cec0 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -247,6 +247,10 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
> >  	struct xdp_umem *umem = umem_xs->umem;
> >  
> >  	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
> > +
> > +	if (umem->flags & XDP_UMEM_SG_FLAG)
> > +		flags |= XDP_USE_SG;
> > +
> >  	if (umem_xs->pool->uses_need_wakeup)
> >  		flags |= XDP_USE_NEED_WAKEUP;
> >  
> 

