Return-Path: <netdev+bounces-281662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD/TGmlQ8GlNRgEAu9opvQ
	(envelope-from <netdev+bounces-281662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:15:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDB247DF3D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D24B302BA3A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 06:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B756D343D8A;
	Tue, 28 Apr 2026 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTqe5+t4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99751344D9F;
	Tue, 28 Apr 2026 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356896; cv=fail; b=Iu2NFoJXf4Ci7dMpbO7qf/kAnNssp5luA4e4bNfjakgb7NPOYcEx9voPqhyJcQTTplh7phO5OTroRMdg5PDVn0I39401lxHJYoSHduk7byi+UdoJYPPxzDmRThjrFzzl4niTID0jTcu67R7kZHFMm/8LpD79Mi4tQ9YHGe0Es2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356896; c=relaxed/simple;
	bh=LHniwvC7Hnyi9q6/ojTXP55MDe01cAcUmCgQHRTsEwI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=T0FXry6o6Y4Ui+zgWVl6+44xiWDpgASYeCuupiDSoKQG/2M3SPdVXd+v8zpoFjwizF4gA7OFzTTzgZiGxL6v/WLHTUC3SXvSQcMP7ERIrIxxtXuw4HEtHUK9IMvNUbtloU6fyfFqH/4/nnzgHGiGgwhpYtrr1g6Kh5glsHgaAs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTqe5+t4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777356893; x=1808892893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LHniwvC7Hnyi9q6/ojTXP55MDe01cAcUmCgQHRTsEwI=;
  b=GTqe5+t4eWjuorm12kdwBKTfBUHUaySvvd9d8nQBIHKUGoEML3V0cKZd
   HdvjI1KV8RCa2MPtrlEx8clNlB9wDO4qQKFRBfAJWXJbC+WKMgYVmOFUy
   /fQUWOGhm6k55R2BQk8gLSXl5dmikmMZXd/Vy0HIt4qovISAV6t7Zx7J7
   I5g6IaZgMcHVLf5bwL7D7uaO9irwwcVxbkstRllWLYYT+Tk9hGWRvuYym
   KkWC4ajlcGX8Qi0/IlwEJ+3CYkLNqr/cIkydYmfhMKAtvd4vBXiZUu1d5
   b1jgsg4vfiT5x16o5WQdBR48uIG91Nt10wBvUQI/bwA8p1/YRQxbZ/WOd
   w==;
X-CSE-ConnectionGUID: koBpFAeIQECfeJ0Lah+q1g==
X-CSE-MsgGUID: lSMT5QKhQE2MyCNspft2XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78240716"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78240716"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 23:14:53 -0700
X-CSE-ConnectionGUID: GJ8TRwg6TsSJAoRs79eiGA==
X-CSE-MsgGUID: 1//NfwnsRO+ke0irg4qTRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229293856"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 23:14:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 23:14:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 23:14:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 23:14:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/DpTOHVxV6/WKn/WAOn+X9VJo/SwyRokIPfIOAqRd/iTEfN8CX7PA3iKtd1Dnv9O0LkIFwReoDuKdf/T9AOreERgin4isGZMaYA+3RJYkc6q2G9H6z0qjeBniGkAXe9VQzi+hfmJDZTZ6Sha+xk485R0XRdfF+3e4P0FpkK+OyHeNalGoLrxuwSRPIRl8sseC9e7fQxILhaCuLZK2uk68HcJvvPHZhg9vJ5YFRozYkY33voYj/oW0gxWzKF6F4fmpNlPlrEY+kGRtqZjb2a8wYyfws4+hzu5x0z8G2JUbfsyriovmmY57fB1L1HaVQVPSJB1Rt4K2/p4JxlqODVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGFGkZvY2wv/oscGfn5Qxe5QuCRpugGsU+jtryc8kmg=;
 b=Js7KozvhlwT9ggFeOjfpmIwlKJ5fPXVFAFxqONcYfSFgr0xn3z5REjEGHQP3m+JJaL4yzs4/KWFzcjPr9H4MWdX9935PCtFLPWSy3HtuJpIbvHmyt6cx00w10mNZal9VE2/4cpkHixFbm82C0j8IG0pMLbIEvdqnRB9LZbNzoQ+DLmJv7+E9V4U5xO1D6JdV66NlHjzLN2JVLrCecb28ntlpUlWyjqjklgEky4ihM+z0TzK/gbuym6AKteDns+ZL6QwDiG5FKKU8pvCKghys10pBiCOElrIoo4Fd6VPl1gk3aX19nZmpgEAiJjttT6gLvXJzypkGP3cdx4m8AcN/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by LV3PR11MB8693.namprd11.prod.outlook.com (2603:10b6:408:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 06:14:47 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 06:14:47 +0000
Date: Tue, 28 Apr 2026 14:14:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [net]  22cb45afd2:
 kunit.mctp_test_bind_lookup.mctp-route.fail
Message-ID: <202604281320.525eee17-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0031.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::12) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|LV3PR11MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa78f0f-685b-4362-88a3-08dea4ed728c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4NUQ+4kNSHjDtZ04h5Crlo22UX7orcTtWeKzihLRpGE3jGpIkYAwedq9y1gtuKE/6iywcWMCXDG9XyaVOtUfTlqTCQw8QkoYROaq5Y1mXPiWIiyuQY8u3KcrkX4MI+R43KWzzAo44XkWZ/+ADZoGT6qh9/ga9LRQ0sH0GMH8soW/oCML1eZLYMjr/TxUpfcHNQMyJ49N5cEooHOIaMC9QH1TJM1/aEhPX63Vq1BJbd9Yolw63s0xxgpeIbESSI5Fh/57byY1dKElB/vL4Og6PKxSsH4syLXK6rYqKTV+iwusJ8usoEU3mMmiyL5pHCOE3iTFEyk9rSPpqBGYp8quq6sj7AOgXF4k8xoHh81xzHufRT4YQoGuuPrXW9WDThTOX++0VoHJjPRPUI7WghpMwPVWytibfc/4K72Po8M69nUCgTKEwfv8m73o5kfOs5+O3l3iXO7OTz7we4o7RmOv+cZkmdp5/W5hvfvkNZCDNbRGPrttAD0uy+fv3xLMt8dVWwhhIRfaJGy5iFDkuCSh+eGhUEc6rgxLitLwCdS79LwaC7wrdKIzKpTI/MbNZ71aaq5VO7l2sa916Q16xuBQ3KAtFFg+RDrxqt5/9NF+d8FIhI3bzTtkLSWblNNCqK0klVBklrn/+XzwAx5VRXUkPJoGDhGv74cKuL0HQBX05GHJY1v5TtvHNd/SFBL9GdKU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rHQOtCTeGhU80eygOmEOMCr5cbidGoTeHeokw3gD4FEHQChMExXcmJQtkXK7?=
 =?us-ascii?Q?HPc0ynPUeDOVv66BMM16Pla467GpZZUtrbLm/8upi0XugMeq3o6pfxA2n32v?=
 =?us-ascii?Q?MUuPReYrBPYWaQxTHUfc6y/b4/yUDqHb6BJ0MCM6nAuRJto7e74pJHaTDu6g?=
 =?us-ascii?Q?ykxgRP2SDTcXHZRRussxiiNIrSloCgJ+VzDZ3vF7eKHaC4DR29OlnjJivUdT?=
 =?us-ascii?Q?h2tSL2+fv+rfI99ElWZFNEjh1phvGUGxthA0rNmIN4Qp7F/G2aPnOPUDI+BQ?=
 =?us-ascii?Q?fPrUpXa1mixgEsP8iUrfGhYbvHLLplyeS5azOPRRaUyvdmC3rHVyyw6Hvqqh?=
 =?us-ascii?Q?f7P3Tf8PPE+n0BxkNRxYrWaBuRWKgdKCx6pf3BhqhyzatuNgTExV6Q/Iz+Gi?=
 =?us-ascii?Q?V/VCAXaaVb5yZVIC7Rywq/xsMXZFxwz1X6h67c0cOPx+yEzcDVO1b1CWULE3?=
 =?us-ascii?Q?WUd1sX0QUXGxHneziF6DWLCVvC9O1zQPFwWFwjlumeIKGa3xa6uTPlF1hUPj?=
 =?us-ascii?Q?tdmaXlDnjVX+VhAIn2/54TE3JubUZ80OdUbDqkLb4bwmMoT7J8OTDQ0Xeuqi?=
 =?us-ascii?Q?OCjHBF5nX5AvVXz9cSa8afNHwfji12q1ICIAVC3WxtlHTrOslAJh7yAyqiTw?=
 =?us-ascii?Q?/BhjF1cnIRaVtxyKVBKMWJ99Un02edVOPslm1LdH3zqh1zzQgkicw+RKFggY?=
 =?us-ascii?Q?UUORBEr9+LGUm6IvWmyvqZ8Qfs5+xUqSWgsT3VZJX7wdvdaVT9auj384zwBx?=
 =?us-ascii?Q?Ch1PWfkJ+9+mCEd07Seo/oSDUF7rHwxte5CEYVQYzwEmU1wDsXinsAQ9ZlV5?=
 =?us-ascii?Q?S2SclD3YULnzao5i2KHFL7C+LDzxTUI+sssDjDy2ZUvUUOG1Ol9KJb5lNHE1?=
 =?us-ascii?Q?1kMTOqvBN4lD5oRUNkulno1feaE9ekwVVWYhlAUAhr8asVPzzzoM9Zvj40kY?=
 =?us-ascii?Q?or4Ie/Vb+pEULH+V9AJsjRjG8tO7JORLkfkk48I5k0LrGaNdAnQMhyCSuiwd?=
 =?us-ascii?Q?YGBjnDVihqnbZcl4F0g39XtoKwZzQQAIo4vyYujTY8rNbP/DpYJSSjnmPM7+?=
 =?us-ascii?Q?3rXEnM7VGdFciKROtsko+dfquNgjQH+UwZ5S9i9CrCh/FjH4HDEnQmbMnqoR?=
 =?us-ascii?Q?2rm73E6AwNF/ixZjV1fWXwO5R1d+Qu/w/iDnEOgPVXC9zTxKLNHNvvrw2nBO?=
 =?us-ascii?Q?f7eVBomQYzyir5y4jXVlb43rRYf04YCwnzfH4FqQetTTHIjFQBrGxtjlL0K/?=
 =?us-ascii?Q?mYZL9WFIYzPDEiTBaMl4wW08CEMOT+5wk4ndPw5A1mM5I0+M+2GHGRe0XoKD?=
 =?us-ascii?Q?Tz+A9S+56fmW0h3lhKgwrxUaZOto36gDaJAbJRNyYoN40jEEI3BWG2dZqWyu?=
 =?us-ascii?Q?4uuP6XIYVHDlhWNBhsM8ZmFTUNET2CKb3uKAkBdPH5n+2nHjTwV/ljStHd4A?=
 =?us-ascii?Q?unkbu/r1O637W4xAX1N2CKoRZrHIDrciWK6Bn9AvcVrOIY+E8kSmzUan7B/W?=
 =?us-ascii?Q?KfXoERESlyu5ZLQiQbrjipttp6aNNuCa0R+BV3KgTM0dle0NfByBlOD6TC70?=
 =?us-ascii?Q?neuODJrsWG12alzR/roSxUOnEtu+SH6aMqziXhndk5mdH392Vayz9diErRGo?=
 =?us-ascii?Q?bOMbZmViQENUQ3uzuk+rlysmOjzVT5t1hFi6KifQE5L2ikk3c3NiIPDDrIEv?=
 =?us-ascii?Q?IWYnxJTsHp/rqdd0sOF8bfHFhjIp1lWoygvGIyaQLE36Sgj3qQoa7GfPXr/3?=
 =?us-ascii?Q?0ISceVckeA=3D=3D?=
X-Exchange-RoutingPolicyChecked: K76ThHk6fvfoni5nKM3zuIWbOuKr1H2lCoQZyMFRp+yV6um1lii+diOg8ymhKXYcDIPdaL3fZSQ5HDYHCIooUwTdZtnfX3IGA3iQmxPqWIvq1lw9RfNkONXqVVYw/k/uJh9kHey1wxplJWEGRF/EtI9/5mSsa9HNkFO/PS4MtXgHQ+QmbiMSkA/23FnoQaxf672gVUGs7gHpmkHs+oDvVYvGKwlz9EbaYCjXtrm8d5dGgj9ZrOkXDmPqCYSnW+0v90e3hXa6I79W8p92o0JEjzqIJXWnMkX7e3iCzdSPvhiuNQq3RguegLrunxRFLxHPu4ZrFp8Y6zwBiPsDDFVx8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa78f0f-685b-4362-88a3-08dea4ed728c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:14:47.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wqb/QaCJ0STHV+n1gycq9qO85YLBGwd6neYl462/oXHGZ3XdtZ2uz0/99ic+EYAevg4fJQr+yz6E6QHGk5HnfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8693
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: CFDB247DF3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281662-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]



Hello,

kernel test robot noticed "kunit.mctp_test_bind_lookup.mctp-route.fail" on:

commit: 22cb45afd221b9e4f2a1dcc74a8ff645b7293aa1 ("net: mctp: perform source address lookups when we populate our dst")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      27d128c1cff64c3b8012cc56dd5a1391bb4f1821]
[test failed on linux-next/master 7080e32d3f09d8688c4a87d81bdcc71f7f606b16]

in testcase: kunit
version: 
with following parameters:

	group: group-03



config: x86_64-rhel-9.4-kunit
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202604281320.525eee17-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260428/202604281320.525eee17-lkp@intel.com


[  106.860555][    T1]     KTAP version 1
[  106.864350][    T1]     # Subtest: mctp-route
[  106.868745][    T1]     # module: mctp
[  106.868755][    T1]     1..19
[  106.875556][    T1]         KTAP version 1
[  106.879697][    T1]         # Subtest: mctp_test_fragment
[  106.890234][    T1]         ok 1 mtu 63 len 68 -> 1 frags
[  106.906337][    T1]         ok 2 mtu 64 len 68 -> 1 frags
[  106.925359][    T1]         ok 3 mtu 65 len 68 -> 2 frags
[  106.941407][    T1]         ok 4 mtu 66 len 68 -> 2 frags
[  106.958384][    T1]         ok 5 mtu 127 len 68 -> 2 frags
[  106.977373][    T1]         ok 6 mtu 128 len 68 -> 2 frags
[  106.994362][    T1]         ok 7 mtu 129 len 68 -> 3 frags
[  107.013411][    T1]         ok 8 mtu 130 len 68 -> 3 frags
[  107.018966][    T1]     # mctp_test_fragment: pass:8 fail:0 skip:0 total:8
[  107.024500][    T1]     ok 1 mctp_test_fragment
[  107.031420][    T1]         KTAP version 1
[  107.040595][    T1]         # Subtest: mctp_test_rx_input
[  107.041403][ T3326]     # mctp_test_rx_input: EXPECTATION FAILED at net/mctp/test/route-test.c:151
[  107.041403][ T3326]     Expected !!dev->pkts.qlen == params->input, but
[  107.041403][ T3326]         !!dev->pkts.qlen == 0 (0x0)
[  107.041403][ T3326]         params->input == 1 (0x1)
[  107.056375][    T1]         not ok 1 {1,a,8,0}
[  107.092428][    T1]         ok 2 {1,a,9,0}
[  107.108379][    T1]         ok 3 {2,a,8,0}
[  107.112553][    T1]     # mctp_test_rx_input: pass:2 fail:1 skip:0 total:3
[  107.116698][    T1]     not ok 2 mctp_test_rx_input
[  107.123635][    T1]         KTAP version 1
[  107.132711][    T1]         # Subtest: mctp_test_route_input_sk
[  107.142400][    T1]         ok 1 {1,a,8,c8} type 0
[  107.158435][    T1]         ok 2 {1,a,8,c8} type 1
[  107.175423][    T1]         ok 3 {1,a,8,c0} type 0
[  107.191371][    T1]         ok 4 {1,a,8,48} type 0
[  107.207403][    T1]         ok 5 {1,a,8,8} type 0
[  107.223383][    T1]         ok 6 {1,a,8,0} type 0
[  107.228165][    T1]     # mctp_test_route_input_sk: pass:6 fail:0 skip:0 total:6
[  107.232922][    T1]     ok 3 mctp_test_route_input_sk
[  107.240378][    T1]         KTAP version 1
[  107.249616][    T1]         # Subtest: mctp_test_route_input_sk_reasm
[  107.260439][    T1]         ok 1 single packet
[  107.277410][    T1]         ok 2 single packet, offset seq
[  107.293393][    T1]         ok 3 start & end packets
[  107.310433][    T1]         ok 4 start & end packets, offset seq
[  107.326458][    T1]         ok 5 start & end packets, out of order
[  107.344381][    T1]         ok 6 start, middle & end packets
[  107.363465][    T1]         ok 7 missing seq
[  107.379399][    T1]         ok 8 seq wrap
[  107.383744][    T1]     # mctp_test_route_input_sk_reasm: pass:8 fail:0 skip:0 total:8
[  107.387830][    T1]     ok 4 mctp_test_route_input_sk_reasm
[  107.395826][    T1]         KTAP version 1
[  107.405584][    T1]         # Subtest: mctp_test_route_input_sk_keys
[  107.415461][    T1]         ok 1 direct match
[  107.435415][    T1]         ok 2 flipped src/dest
[  107.452419][    T1]         ok 3 peer addr mismatch
[  107.468402][    T1]         ok 4 tag value mismatch
[  107.483406][    T1]         ok 5 TO mismatch
[  107.500436][    T1]         ok 6 broadcast response
[  107.515346][    T1]         ok 7 any local match
[  107.520298][    T1]     # mctp_test_route_input_sk_keys: pass:7 fail:0 skip:0 total:7
[  107.524969][    T1]     ok 5 mctp_test_route_input_sk_keys
[  107.547442][    T1]     ok 6 mctp_test_route_input_sk_fail_single
[  107.566385][    T1]     ok 7 mctp_test_route_input_sk_fail_frag
[  107.592302][    T1]     ok 8 mctp_test_route_input_multiple_nets_bind
[  107.620369][    T1]     ok 9 mctp_test_route_input_multiple_nets_key
[  107.637337][    T1]     ok 10 mctp_test_packet_flow
[  107.654395][    T1]     ok 11 mctp_test_fragment_flow
[  107.670351][    T1]     ok 12 mctp_test_route_output_key_create
[  107.676335][ T3388] pkt1 skb len=7 data_len=0 headroom=0 headlen=7 tailroom=377
[  107.676335][ T3388] end-tail=377 mac=(-1,-1) mac_len=0 net=(0,-1) trans=-1
[  107.676335][ T3388] shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
[  107.676335][ T3388] csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
[  107.676335][ T3388] hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
[  107.676335][ T3388] priority=0x0 mark=0x0 alloc_cpu=1 vlan_all=0x0
[  107.676335][ T3388] encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[  107.731299][ T3388] pkt1 dev name=mctptest0 feat=0x0000000000004000
[  107.737635][ T3388] pkt1 skb linear:   00000000: 01 08 0a 88 00 00 00
[  107.744146][ T3388] pkt2 skb len=7 data_len=0 headroom=7 headlen=7 tailroom=370
[  107.744146][ T3388] end-tail=370 mac=(-1,-1) mac_len=0 net=(7,-1) trans=-1
[  107.744146][ T3388] shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
[  107.744146][ T3388] csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
[  107.744146][ T3388] hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
[  107.744146][ T3388] priority=0x0 mark=0x0 alloc_cpu=1 vlan_all=0x0
[  107.744146][ T3388] encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[  107.793084][ T3388] pkt2 dev name=mctptest0 feat=0x0000000000004000
[  107.799417][ T3388] pkt2 skb linear:   00000000: 01 08 0a 18 11 11 11
[  107.805926][ T3388] pkt3 skb len=7 data_len=0 headroom=14 headlen=7 tailroom=363
[  107.805926][ T3388] end-tail=363 mac=(-1,-1) mac_len=0 net=(14,-1) trans=-1
[  107.805926][ T3388] shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
[  107.805926][ T3388] csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
[  107.805926][ T3388] hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
[  107.805926][ T3388] priority=0x0 mark=0x0 alloc_cpu=1 vlan_all=0x0
[  107.805926][ T3388] encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[  107.855103][ T3388] pkt3 dev name=mctptest0 feat=0x0000000000004000
[  107.861436][ T3388] pkt3 skb linear:   00000000: 01 08 0a 68 22 22 22
[  107.867952][ T3388] pkt4 skb len=7 data_len=0 headroom=21 headlen=7 tailroom=356
[  107.867952][ T3388] end-tail=356 mac=(-1,-1) mac_len=0 net=(21,-1) trans=-1
[  107.867952][ T3388] shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
[  107.867952][ T3388] csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
[  107.867952][ T3388] hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
[  107.867952][ T3388] priority=0x0 mark=0x0 alloc_cpu=1 vlan_all=0x0
[  107.867952][ T3388] encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[  107.917055][ T3388] pkt4 dev name=mctptest0 feat=0x0000000000004000
[  107.923394][ T3388] pkt4 skb linear:   00000000: 01 08 0a 88 00 33 33
[  107.929901][ T3388] pkt5 skb len=7 data_len=0 headroom=28 headlen=7 tailroom=349
[  107.929901][ T3388] end-tail=349 mac=(-1,-1) mac_len=0 net=(28,-1) trans=-1
[  107.929901][ T3388] shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
[  107.929901][ T3388] csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
[  107.929901][ T3388] hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
[  107.929901][ T3388] priority=0x0 mark=0x0 alloc_cpu=1 vlan_all=0x0
[  107.929901][ T3388] encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[  107.979015][ T3388] pkt5 dev name=mctptest0 feat=0x0000000000004000
[  107.985354][ T3388] pkt5 skb linear:   00000000: 01 08 0a 58 44 44 44
[  107.999421][    T1]     ok 13 mctp_test_route_input_cloned_frag
[  108.012254][    T1]     ok 14 mctp_test_route_extaddr_input
[  108.031407][    T1]     ok 15 mctp_test_route_gw_lookup
[  108.047439][    T1]     ok 16 mctp_test_route_gw_loop
[  108.052738][    T1]         KTAP version 1
[  108.062009][    T1]         # Subtest: mctp_test_route_gw_mtu
[  108.075426][    T1]         ok 1 dev 68, neigh 0, gw 0, dst 0 -> 68
[  108.091437][    T1]         ok 2 dev 100, neigh 0, gw 0, dst 0 -> 100
[  108.108425][    T1]         ok 3 dev 100, neigh 68, gw 0, dst 0 -> 68
[  108.125591][    T1]         ok 4 dev 100, neigh 0, gw 68, dst 0 -> 68
[  108.145398][    T1]         ok 5 dev 100, neigh 0, gw 0, dst 68 -> 68
[  108.163355][    T1]         ok 6 dev 100, neigh 99, gw 98, dst 68 -> 68
[  108.182396][    T1]         ok 7 dev 99, neigh 100, gw 98, dst 68 -> 68
[  108.199373][    T1]         ok 8 dev 98, neigh 99, gw 100, dst 68 -> 68
[  108.219414][    T1]         ok 9 dev 68, neigh 98, gw 99, dst 100 -> 68
[  108.226096][    T1]     # mctp_test_route_gw_mtu: pass:9 fail:0 skip:0 total:9
[  108.232757][    T1]     ok 17 mctp_test_route_gw_mtu
[  108.241018][    T1]     ok 18 mctp_test_route_gw_output
[  108.246044][    T1]         KTAP version 1
[  108.255451][    T1]         # Subtest: mctp_test_bind_lookup
[  108.266474][    T1]         ok 1 {src 20 dst 10 ty 1 net 1 expect remote20}
[  108.286226][    T1]         ok 2 {src 20 dst 255 ty 1 net 1 expect remote20}
[  108.304517][    T1]         ok 3 {src 20 dst 0 ty 1 net 1 expect remote20}
[  108.323456][    T1]         ok 4 {src 0 dst 255 ty 1 net 1 expect any}
[  108.342230][    T1]         ok 5 {src 0 dst 11 ty 1 net 1 expect any}
[  108.362457][    T1]         ok 6 {src 0 dst 0 ty 1 net 1 expect any}
[  108.380442][    T1]         ok 7 {src 0 dst 10 ty 1 net 1 expect local10}
[  108.400473][    T1]         ok 8 {src 21 dst 10 ty 1 net 1 expect local10}
[  108.419438][    T1]         ok 9 {src 21 dst 11 ty 1 net 1 expect remote21local11}
[  108.439449][    T1]         ok 10 {src 99 dst 99 ty 1 net 1 expect any}
[  108.459437][    T1]         ok 11 {src 20 dst 10 ty 3 net 1 expect (null)}
[  108.479478][    T1]         ok 12 {src 0 dst 0 ty 1 net 7 expect any}
[  108.496453][    T1]         ok 13 {src 21 dst 10 ty 1 net 2 expect any}
[  108.516440][    T1]         ok 14 {src 20 dst 10 ty 1 net 3 expect any}
[  108.534409][    T1]         ok 15 {src 21 dst 10 ty 1 net 3 expect remote21net3}
[  108.553454][    T1]         ok 16 {src 21 dst 10 ty 1 net 4 expect remote21net4}
[  108.571493][    T1]         ok 17 {src 21 dst 10 ty 1 net 5 expect remote21net5}
[  108.592509][    T1]         ok 18 {src 21 dst 10 ty 1 net 5 expect remote21net5}
[  108.611431][    T1]         ok 19 {src 99 dst 10 ty 1 net 8 expect local10net8}
[  108.631413][    T1]         ok 20 {src 99 dst 10 ty 1 net 9 expect anynet9}
[  108.651448][    T1]         ok 21 {src 0 dst 0 ty 1 net 9 expect anynet9}
[  108.671424][    T1]         ok 22 {src 99 dst 99 ty 1 net 9 expect anynet9}
[  108.691466][    T1]         ok 23 {src 20 dst 10 ty 1 net 9 expect anynet9}
[  108.698495][    T1]     # mctp_test_bind_lookup: pass:23 fail:0 skip:0 total:23
[  108.705506][    T1]     ok 19 mctp_test_bind_lookup
[  108.712890][    T1] # mctp-route: pass:18 fail:1 skip:0 total:19
[  108.717837][    T1] # Totals: pass:75 fail:1 skip:0 total:76
[  108.723895][    T1] not ok 34 mctp-route

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


