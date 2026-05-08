Return-Path: <netdev+bounces-285716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHlrOieb/WkJgQAAu9opvQ
	(envelope-from <netdev+bounces-285716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:13:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B0F4F38E8
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E7030177B6
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 08:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C28381AEB;
	Fri,  8 May 2026 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frKX9XCG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26F37B02D
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227854; cv=fail; b=spHBCZBWGXDECK4amVd01TaWpTElH0wrcHH7HovBWzkY+bGEFQOoiRbT1yCt6JeIoNRFvTyUpF9YDtzeTdiwOmbM1okq96VUMwb4XsBZ9O4pujJCXzfpQw+eUrhKyb4mw7fIWHhGuwmAc50uiynHUYq0UCAK/hcWgVca2+cbslY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227854; c=relaxed/simple;
	bh=krmSBRNmeOKi0aFLsfJf9A96YDdI8eq4Yo7vLznxQ8c=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=IHduiBJrr/mn6gWTZqt4nxhQRMWmi/yJY50qKejuH5shyO3JUFAB0+db4ZW371mtmpMns/v9gm5n9Ag4ocx5V6taWpTJ7rJUUHqRLsePholsHs0njHYfkgAA8wCHA2rBJ77jzf6I9qVVTHM4m8jkXvF5n8L8/rALTxSHGC/g0cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frKX9XCG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778227850; x=1809763850;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=krmSBRNmeOKi0aFLsfJf9A96YDdI8eq4Yo7vLznxQ8c=;
  b=frKX9XCG793+8VIZaZ/dVk5IIxq7E+wgyBT/s8gyFsZWb62LUqBlwGsE
   Y7/VNLUhx0KNMwIGT++vgobr/eHkUdGVUWykJXKfgOb2wciPx6SPS2IVS
   k39oaeuJQdCwO6vhvBqzSQNCqrB8b67NPLXQxRG6FjIHzVfvPEkcHQOmt
   fgWX2mvuDPJeopDRPE/4rJ+xJjfezNf3skBynVmA8DnLpi9BMfsr2xgy7
   iEv4tdRk5gWTWBlifkr5euy/htb0FNdWqVT9wGxB/4VU46cC0l9/a6wWj
   WczkwVu+JJPrgfpKyHK0uKZPpy0Gy+4rqx5AvLyhBLpOECKKFTMsOSX0i
   g==;
X-CSE-ConnectionGUID: cOtDjMXnQjuWNi8MGOkp1w==
X-CSE-MsgGUID: m7DoTxlIRr+Cdm3epe2CxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89500564"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="89500564"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:10:50 -0700
X-CSE-ConnectionGUID: 85wz6d8tQtqtAZzWTx1ZNA==
X-CSE-MsgGUID: eH1OzPpfR9GL0t+OdidRZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="236640214"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:10:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 01:10:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 01:10:49 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 01:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAjKoKE8bQPfqWs+bV/6I/u8ZIcZFdCi3yztFlbud1FDOo+QE6lDgiTDCxgilvdI3Z2PvusH+s0/7BjKYHarfHIkAdo91l+MFJtr4+0hJ42MD3D04bsNgRs5DJV6m+iEcopGZ0+rbdtDaG3KAKhE01kltiRdoIj1348fFT8on9QQ7otCva9SfHAzgRRfLnfEGrIkEeR1phn6lNx8mI/hd3BrG0XqSvC0HpcHNzGsyGpfaScxXehlft0JnS4N/BqBjarbIaucojJ8zfNLp+sYpNoUwJ7bSClzsvRjwY6USkS4VN3PKQW3yDJvD/VIog+k/ZVoaGDwPcwFcGa0Kt/XTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emypZBu3k/PkXHvBLDUO8VyUF8q0eULNsX79DcAPq4k=;
 b=D+CujmcozUB9M8B14A1T/gWZPkejlK+JxO8VIRke5m7NAYMj047GpI1ukI8eOtKXD/OG8XEh5Xf4NTfHSX10pYexNjvNUflXA79zQ28tICfSVuF/9BTPptEBwNh0Pn9uGHMYyIFcg4629tA4CcSy2faI20XlL+GxxHUYaq+OZ8+kKpfUvEf5zQZk5fJwjdKmJoQpqxPGJRqwkGjiMfzk7UMxcbtP+9oez/jgJ33O4ojjTcFS/QSW7n/F/OGRWj8V64ydE6zLRYcejm4S8J+LAtyXcxQ8pd26wgzrGdLpC4SFHdfFq9rJAbhjqfp3Prkb/EyfOi6edqoJJpaAdJzgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CYYPR11MB8385.namprd11.prod.outlook.com (2603:10b6:930:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 08:10:41 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 08:10:41 +0000
Date: Fri, 8 May 2026 16:10:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Eric Dumazet
	<edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [tcp]  026dfef287: stress-ng.sigurg.ops_per_sec
 7.2% improvement
Message-ID: <202605081516.e48509cb-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KU2P306CA0046.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::12) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CYYPR11MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be9699a-298b-40b0-7c07-08deacd94bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: KX2axokjsQE193D15AzZK5UjVMTkJexFp1q9CLA7VMqkHswibX2XxRbvVFIuxK4h68pWzdoq+myLvyHG2nq4XykiKQrDX0ebPEUf8Qzx9H99NqdYnB596gtT1zvvFOnmsK19fxw2hP+/7F26fGtdXkR6gpZrvXZ8S9sNiN381MKENiqFWNtFVVaFyXuTlvFpLQStzJLRVBB3UWjbous4ooxKDqy89MsAqgRBqlbEfOvWZl71497J4W1MnzCMUfGk/pJdljbe0wChZ9qH4qqIHcOka9G9auiPSiAWYJ5M9Wf/U7AFpYazhcxh+FVwabNeANJxMSqwq04NZKdskgIS5pUmpjV3m1FI5ORMQh8HnPl6ete0B0aJaqjtDB0rgd8CK5klbXTRwmWPWg9dZ2k/BKd3X446RGf8f8Gm3SvGKhiNKHyqHBXRK8L7fZomzrAZ8JHqrMJfEJ7o8wU8k+reZdOMcKGm/G/dJuj80l1IY85CpIWbA+L3+rYfgrOpFAaoXxjTM2CL0qhhOoQtrvb67tVobNMc+9gvdSpD66iei19HH+fOtsCgJw+i1ZN4VpAEUao8Au8+14tojIoKfJgESFOzbaHqyZ36AGM9RGFi8rXcut11eSQ+PBQtmD+oLJwNp7mFXKWKde3zmRInTWsMXFpjT4130D2UTRcygI25jphh4RRyKjZ605IQxW54ccm/5xQO4c2neStn2aszrlZm8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LxhHM+7gYnTWjHR2anSxLtwJgpwc/1jF6OI/8DHChuyHMN5pNKnRYp3QlT?=
 =?iso-8859-1?Q?6VTbMtRjHy+m/t7kGG1W3mb1WxrO6Jq1I45XQHNFEa2DjIGW3H8KcXtu+a?=
 =?iso-8859-1?Q?g4ionvrEIxzWRnXrWKAJ2e1w0HEFxiWHiQCvCgKiTOqAvDaz3ZFsMia7+R?=
 =?iso-8859-1?Q?PKj2a34p7BdpWr3//dgVl91uDfD4hxGZ7Y/W1pbC9wYZj/iw+NJl0cvLUT?=
 =?iso-8859-1?Q?HE9es3A+BdVmQMa/9S9hbL5IajccfaHm0qvFviVkDMakDoWAMWsH/xdh1q?=
 =?iso-8859-1?Q?oIiH4cG6bx6vkmLIl28jybBS1IsUd/V5AtPRNVLNXeaYL7fjhJq+Scz8wC?=
 =?iso-8859-1?Q?VKWWKAA0mEAwNVQqlAY//bhqwhS++XOwAIB97oNGg6LA0N85PtezK5j9Gt?=
 =?iso-8859-1?Q?n0PQ+kQw+rs393AC4HgKOZ3eLtwHPP/CtOMFORnAYxG8qHbGC3v9Tl1Aq0?=
 =?iso-8859-1?Q?WnS0S1c3myOHyZx8D72HaVqbv6JVwns35WwM42yYe/icumZ5UxV3nvKZaC?=
 =?iso-8859-1?Q?JumDQvKR8TWc972mnILg9irPn1ULOODJNan1/a3cVnMPjxx0+tdV7iPxWm?=
 =?iso-8859-1?Q?C10/zz14mNLQNXEAyOcleGzwITBusnlH4fdgH4aDdIfxmVWAhrUekQVEX0?=
 =?iso-8859-1?Q?6QwvzqbYiH7J5RhOhVsZfuBl9VDeOM27mV27v4dGIYAsrK+//uEcGFiIuV?=
 =?iso-8859-1?Q?RPX3XIwmpWWkAvavu1M8dnbNzjhoGL9QH2UVUg0qFyAKQ4a/assT+TcNUa?=
 =?iso-8859-1?Q?+aHCxl1Ai0bHJGo2+CgX7yhodcr9fYn8yoBnBQvgWGZMgSH9WeM4rYstjk?=
 =?iso-8859-1?Q?3AeOOPS9KGWzE6WCZxhBmEzQhzWeqVtci9aInvq0nrOXWnDirFD/C9sQ2V?=
 =?iso-8859-1?Q?WG9NuMvEjl6dZW78Bsm8jxEMLraxYBlHwj91Em37sxyp2SGf065WnEKhSw?=
 =?iso-8859-1?Q?k/YVZsj3Ti5T0J1AQD7O43KVTCIYzZtfPBlEYXg7dXkNJm5ReVUnBZqcIL?=
 =?iso-8859-1?Q?mziSU4ytI/oiVtSXvNWsC/UqdFaYHqMQZZgGwMj9xelBlJKjXTlHX5+4Ky?=
 =?iso-8859-1?Q?34F3J9sfOoWb08FR0t/o8PAoU2Ww+7YNTlLEXTFw9Q1T7bniS07Sxl/Ogk?=
 =?iso-8859-1?Q?KaZNXih/rkeCNiLCO50uGta27lIcZrfnXZvritzHZpN12RnmvuVbP5Bc6n?=
 =?iso-8859-1?Q?3PZiZTgZKOgcMdhEkYdRPmWFHbTEyK5j7fL6MHqQoDhPj+pFBbQd+TmFxf?=
 =?iso-8859-1?Q?YPB3QzNspDwEwRdqcVWtVkXL1idcg9NlmaTb5nFN/TF5tVCjNY2V+JQCOS?=
 =?iso-8859-1?Q?DJUGSpIl9hBLD6ZRALA3E1YUhaiKLwN5k/mcIB8Ijxawoc/uGMyhsjYcAx?=
 =?iso-8859-1?Q?GkPb89atEDLahLVnGS11wrYFRsAY+X/jjVPEPxF62sfd6VxxaeeHmL4SEF?=
 =?iso-8859-1?Q?tFYYojhueIa5kgs0JbW3z+jKGRESXTVzCKwghgdprBl3j9GwF5JHMgrfxl?=
 =?iso-8859-1?Q?1GlMXqY7mHxCbEBtj/IS9+lfzsk6mymbUKP0TOa6RymPwg9VJS+0BZit+S?=
 =?iso-8859-1?Q?QTL8wSoBj1iAU151FKgsfDvbwNVXWPuT3O0HJ9kYTOVe6+Wnja1zNf+VN2?=
 =?iso-8859-1?Q?ebBSH7G6y/ZyAiujVWK8GpFoRz8vlkVaqStiBpnCnbxOSbHQ/UFfEq6iuE?=
 =?iso-8859-1?Q?I2UUXa8F14igwAFMHpSxZR4c5ZMwqHXtUmJK5KO99ANaqldiywAtBrRJ8R?=
 =?iso-8859-1?Q?kAK0YC+SqTDJVw4AdWvXI5yeYkvSF1FmeaXPS9/5Zhdol84V1lqIY5iPNM?=
 =?iso-8859-1?Q?ON32yWi/Dg=3D=3D?=
X-Exchange-RoutingPolicyChecked: J3+S/pmhKskA+YDiQdxu7oA1xzSeE4avQW2te6Ou+wkEh1ImsECUrA5cGV1Nct+i6KU93Vzxme6N9tyY3iC/YJTPqpyA/PK6X3WLo75jAHrk5cX0wDz/4RhT7WFkXofhsn7SqJdsVDyBlVgb2SFmRYig/nbbuRL97Nk31NbK9fKhaFqfUr5pqAEX9Rg9bmSwBeDVp7jflzoNsjfN7DY1nNlfQYP4r83If7weo9WZ/q64h8EEHmMSSjzsmZ5oWBvsFLgL90NUOyfS5eHA4HOyTDrPdr0uzblo66Aej1A2bTjGy5EKVOoMqeq85fGr1YqoyT4WA4Nb/tJUMojLLMvDIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be9699a-298b-40b0-7c07-08deacd94bbd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 08:10:41.4738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho7lqWLJDYYN9sMhNzROjbXJVWY++/n0LtmfcpcBeYy79sCR1CW1iRwTpIE7TtONjMBrw3SmuGMk35PpUfDXAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8385
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 19B0F4F38E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285716-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,average.ms:url,01.org:url,hitm.total:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



Hello,

kernel test robot noticed a 7.2% improvement of stress-ng.sigurg.ops_per_sec on:


commit: 026dfef287c07f37d4d4eef7a0b5a4bfdb29b32d ("tcp: give up on stronger sk_rcvbuf checks (for now)")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sigurg
	cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260508/202605081516.e48509cb-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-spr-r02/sigurg/stress-ng/60s

commit: 
  6996a2d2d0 ("udp: Unhash auto-bound connected sk from 4-tuple hash table when disconnected.")
  026dfef287 ("tcp: give up on stronger sk_rcvbuf checks (for now)")

6996a2d2d0a64808 026dfef287c07f37d4d4eef7a0b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.161e+08            +7.2%  3.389e+08        stress-ng.sigurg.ops
   5270683            +7.2%    5651486        stress-ng.sigurg.ops_per_sec
   2111132            -7.4%    1954920        stress-ng.time.involuntary_context_switches
     17103            -4.9%      16270        stress-ng.time.percent_of_cpu_this_job_got
      8621            -3.8%       8290        stress-ng.time.system_time
      1655 ±  2%     -10.3%       1485        stress-ng.time.user_time
    233661            +4.6%     244480        stress-ng.time.voluntary_context_switches
   1187968           +10.0%    1306428 ±  2%  meminfo.SUnreclaim
   1337542            +8.8%    1455830 ±  2%  meminfo.Slab
     21.62 ±  3%      +3.4       24.99        mpstat.cpu.all.soft%
     12.33 ±  2%      -1.3       11.04 ±  2%  mpstat.cpu.all.usr%
    297818            +9.5%     326144 ±  2%  proc-vmstat.nr_slab_unreclaimable
   2652433 ±  4%     -10.1%    2383573        proc-vmstat.pgalloc_normal
     40509            -5.8%      38147        vmstat.system.cs
   5072202 ±  2%      +8.6%    5506325 ±  2%  vmstat.system.in
     18227 ± 11%     +30.4%      23763 ±  8%  perf-c2c.DRAM.local
     57496 ±  9%     +21.0%      69555 ±  6%  perf-c2c.HITM.local
     72755 ±  9%     +19.8%      87175 ±  7%  perf-c2c.HITM.total
      7586 ±  2%      -5.0%       7209 ±  2%  sched_debug.cfs_rq:/.left_deadline.stddev
      7586 ±  2%      -5.0%       7207 ±  2%  sched_debug.cfs_rq:/.left_vruntime.stddev
      7586 ±  2%      -5.0%       7207 ±  2%  sched_debug.cfs_rq:/.right_vruntime.stddev
      0.84 ±  2%     -11.2%       0.74        turbostat.IPC
 3.193e+08 ±  2%      +9.1%  3.484e+08        turbostat.IRQ
    110.21 ±  9%     -20.0       90.16 ±  6%  turbostat.PKG_%
     28.31 ±  2%      +5.1%      29.75        turbostat.RAMWatt
      3.87 ±  2%      +8.6%       4.20        perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      3.87 ±  2%      +8.6%       4.20        perf-sched.total_sch_delay.average.ms
     20.88            +7.1%      22.36 ±  2%  perf-sched.total_wait_and_delay.average.ms
     17.01            +6.8%      18.16 ±  2%  perf-sched.total_wait_time.average.ms
     20.88            +7.1%      22.36 ±  2%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
     17.01            +6.8%      18.16 ±  2%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      0.48 ± 10%     +30.6%       0.63 ±  3%  perf-stat.i.MPKI
 1.106e+11           -10.4%  9.901e+10        perf-stat.i.branch-instructions
      0.09 ±  4%      +0.0        0.11        perf-stat.i.branch-miss-rate%
 1.018e+08 ±  2%     +10.0%  1.119e+08        perf-stat.i.branch-misses
  2.65e+08 ±  8%     +16.8%  3.095e+08 ±  3%  perf-stat.i.cache-misses
 8.252e+08 ±  3%      +9.7%   9.05e+08        perf-stat.i.cache-references
     41977            -5.5%      39685        perf-stat.i.context-switches
      1.17 ±  2%     +11.9%       1.31        perf-stat.i.cpi
      2435 ±  8%     -15.0%       2071 ±  3%  perf-stat.i.cycles-between-cache-misses
 5.489e+11           -10.8%  4.899e+11        perf-stat.i.instructions
      0.86 ±  2%     -10.6%       0.77        perf-stat.i.ipc
      0.48 ± 10%     +30.6%       0.63 ±  3%  perf-stat.overall.MPKI
      0.09 ±  4%      +0.0        0.11        perf-stat.overall.branch-miss-rate%
      1.17 ±  2%     +12.0%       1.31        perf-stat.overall.cpi
      2431 ±  8%     -14.9%       2069 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.86 ±  2%     -10.7%       0.76        perf-stat.overall.ipc
 1.063e+11 ±  2%     -11.1%   9.45e+10        perf-stat.ps.branch-instructions
  96467947            +9.5%  1.056e+08        perf-stat.ps.branch-misses
 2.552e+08 ±  8%     +15.9%  2.957e+08 ±  3%  perf-stat.ps.cache-misses
 7.926e+08 ±  3%      +8.9%  8.633e+08        perf-stat.ps.cache-references
     40211            -6.1%      37740        perf-stat.ps.context-switches
 2.175e+11            -0.7%  2.159e+11        perf-stat.ps.cpu-clock
 5.279e+11 ±  2%     -11.4%  4.675e+11        perf-stat.ps.instructions
 2.175e+11            -0.7%  2.159e+11        perf-stat.ps.task-clock
 3.161e+13           -10.6%  2.825e+13        perf-stat.total.instructions
      5.34 ±  9%      -3.0        2.30 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.27 ±  9%      -3.0        2.29 ±  7%  perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.73 ±  8%      -2.6        2.17 ±  7%  perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.60 ±  8%      -2.4        2.15 ±  7%  perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
      4.49 ±  8%      -2.4        2.12 ±  7%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     48.77            -1.7       47.03        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     48.46            -1.6       46.91        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.74 ± 10%      -0.8        0.94 ±  4%  perf-profile.calltrace.cycles-pp.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      0.53 ±  2%      +0.0        0.56 ±  2%  perf-profile.calltrace.cycles-pp.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.53 ±  2%      +0.0        0.57        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.53            +0.0        0.56        perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.94            +0.1        1.00        perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.arch_do_signal_or_restart.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.81            +0.1        0.86        perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.arch_do_signal_or_restart.exit_to_user_mode_loop.do_syscall_64
      0.59 ±  4%      +0.1        0.65 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_reschedule_ipi._raw_spin_unlock_irq.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_loop
      1.14            +0.1        1.20 ±  3%  perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      0.66 ±  3%      +0.1        0.73        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_urg.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      0.70 ±  3%      +0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg
      0.77 ±  3%      +0.1        0.86        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      0.68 ±  2%      +0.1        0.78        perf-profile.calltrace.cycles-pp.tcp_schedule_loss_probe.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      0.64 ±  2%      +0.1        0.74 ±  2%  perf-profile.calltrace.cycles-pp.skb_defer_free_flush.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
      0.87 ±  3%      +0.1        0.98        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg
      0.43 ± 44%      +0.1        0.55        perf-profile.calltrace.cycles-pp.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.60 ±  3%      +0.1        0.71 ±  3%  perf-profile.calltrace.cycles-pp.loopback_xmit.xmit_one.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      0.69 ±  3%      +0.1        0.83 ±  3%  perf-profile.calltrace.cycles-pp.xmit_one.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output
      0.45 ± 44%      +0.1        0.59 ±  2%  perf-profile.calltrace.cycles-pp.__pcs_replace_empty_main.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.tcp_stream_alloc_skb
      0.74 ±  3%      +0.1        0.88 ±  3%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit
      0.83 ±  3%      +0.2        1.02 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_unlock_irq.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_loop.do_syscall_64
      1.36 ±  2%      +0.2        1.57 ±  2%  perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.34 ± 70%      +0.2        0.57        perf-profile.calltrace.cycles-pp.skb_release_head_state.__kfree_skb.tcp_urg.tcp_rcv_established.tcp_v4_do_rcv
      0.35 ± 70%      +0.2        0.59 ±  4%  perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.77 ±  5%      +0.2        1.02 ±  3%  perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      0.78 ±  5%      +0.2        1.02 ±  3%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      0.78 ±  5%      +0.2        1.02 ±  3%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
      0.78 ±  5%      +0.2        1.02 ±  3%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      0.78 ±  5%      +0.2        1.03 ±  3%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      0.60 ±  9%      +0.3        0.89 ± 28%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      2.27 ±  2%      +0.3        2.56 ±  2%  perf-profile.calltrace.cycles-pp.tcp_event_new_data_sent.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      2.46 ±  3%      +0.3        2.76        perf-profile.calltrace.cycles-pp.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto
      2.73 ±  2%      +0.4        3.09        perf-profile.calltrace.cycles-pp.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      0.09 ±223%      +0.5        0.55 ±  2%  perf-profile.calltrace.cycles-pp.__pcs_replace_empty_main.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      0.08 ±223%      +0.5        0.55 ±  4%  perf-profile.calltrace.cycles-pp.tcp_try_rmem_schedule.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.__inet_lookup_skb.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.sk_reset_timer.tcp_event_new_data_sent.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
      5.83 ± 11%      +0.9        6.78 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_loop.do_syscall_64
      5.74 ± 11%      +0.9        6.69 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_loop
      3.41 ± 10%      +1.0        4.44 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.do_send_sig_info.send_sigurg.sk_send_sigurg
      3.86 ±  8%      +1.1        4.92 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.do_send_sig_info.send_sigurg.sk_send_sigurg.tcp_urg
     13.97 ±  2%      +1.1       15.07        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.ioctl
      7.66 ±  9%      +1.2        8.86 ±  4%  perf-profile.calltrace.cycles-pp.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.19 ±  8%      +1.2        9.41 ±  4%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigurg_handler
      8.25 ±  8%      +1.2        9.47 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.stress_sigurg_handler
      8.21 ±  8%      +1.2        9.43 ±  4%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigurg_handler
      8.24 ±  8%      +1.2        9.47 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigurg_handler
      9.01 ±  7%      +1.3       10.27 ±  3%  perf-profile.calltrace.cycles-pp.stress_sigurg_handler
      4.36 ± 15%      +1.3        5.63 ± 10%  perf-profile.calltrace.cycles-pp.dec_rlimit_put_ucounts.__sigqueue_free.dequeue_signal.get_signal.arch_do_signal_or_restart
      4.36 ± 15%      +1.3        5.64 ± 10%  perf-profile.calltrace.cycles-pp.__sigqueue_free.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      5.53 ±  9%      +1.3        6.82 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.do_syscall_64
      4.07 ± 15%      +1.3        5.42 ± 11%  perf-profile.calltrace.cycles-pp.sig_get_ucounts.__send_signal_locked.do_send_sig_info.send_sigurg.sk_send_sigurg
      4.06 ± 15%      +1.3        5.41 ± 11%  perf-profile.calltrace.cycles-pp.inc_rlimit_get_ucounts.sig_get_ucounts.__send_signal_locked.do_send_sig_info.send_sigurg
      6.12 ±  8%      +1.4        7.56 ±  6%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.12 ±  2%      +1.5       25.59 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl
     22.82 ±  2%      +1.5       24.31 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      7.12 ±  7%      +1.5        8.63 ±  6%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      7.10 ±  7%      +1.5        8.61 ±  6%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
     35.18 ±  2%      +1.5       36.69        perf-profile.calltrace.cycles-pp.ioctl
     11.85 ±  5%      +2.1       13.98        perf-profile.calltrace.cycles-pp.do_send_sig_info.send_sigurg.sk_send_sigurg.tcp_urg.tcp_rcv_established
     41.17            +2.2       43.37        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.55 ±  5%      +2.2       14.75        perf-profile.calltrace.cycles-pp.send_sigurg.sk_send_sigurg.tcp_urg.tcp_rcv_established.tcp_v4_do_rcv
     12.61 ±  5%      +2.2       14.82        perf-profile.calltrace.cycles-pp.sk_send_sigurg.tcp_urg.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
     41.05            +2.2       43.29        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.77 ±  5%      +2.3       16.11        perf-profile.calltrace.cycles-pp.tcp_urg.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
     40.22            +2.6       42.84        perf-profile.calltrace.cycles-pp.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.58 ±  4%      +2.9       19.50        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     38.33            +2.9       41.26        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     16.89 ±  4%      +3.0       19.86        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
     18.40 ±  4%      +3.1       21.53        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.__netif_receive_skb_one_core
     18.57 ±  4%      +3.1       21.71        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.__netif_receive_skb_one_core.process_backlog
     18.64 ±  4%      +3.2       21.80        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.__netif_receive_skb_one_core.process_backlog.__napi_poll
     18.69 ±  4%      +3.2       21.85        perf-profile.calltrace.cycles-pp.ip_local_deliver.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     19.88 ±  4%      +3.2       23.07        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     19.95 ±  4%      +3.2       23.15        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     19.52 ±  4%      +3.3       22.82        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     20.79 ±  4%      +3.3       24.11        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     21.33 ±  3%      +3.4       24.72        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     21.41 ±  3%      +3.4       24.82        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_output
     21.45 ±  3%      +3.4       24.86        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit
     24.01 ±  3%      +3.8       27.82        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
     24.28 ±  3%      +3.8       28.12        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
     24.52 ±  3%      +3.9       28.39        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
     31.62 ±  2%      +4.0       35.63        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     25.77 ±  3%      +4.0       29.78        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
     31.50 ±  2%      +4.1       35.56        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto
     27.22 ±  3%      +4.2       31.42        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      5.36 ±  9%      -3.1        2.31 ±  7%  perf-profile.children.cycles-pp.__x64_sys_recvfrom
      5.32 ±  9%      -3.0        2.30 ±  7%  perf-profile.children.cycles-pp.__sys_recvfrom
      4.77 ±  8%      -2.6        2.18 ±  7%  perf-profile.children.cycles-pp.sock_recvmsg
      4.61 ±  8%      -2.5        2.15 ±  7%  perf-profile.children.cycles-pp.inet_recvmsg
      4.53 ±  8%      -2.4        2.13 ±  7%  perf-profile.children.cycles-pp.tcp_recvmsg
      1.98 ± 17%      -1.8        0.22 ± 23%  perf-profile.children.cycles-pp.tcp_recvmsg_locked
      1.80 ± 10%      -0.8        0.98 ±  4%  perf-profile.children.cycles-pp.skb_do_copy_data_nocache
      1.19 ± 12%      -0.6        0.54 ±  5%  perf-profile.children.cycles-pp.__check_object_size
      2.17 ±  5%      -0.6        1.59 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      4.11            -0.4        3.67        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.54 ± 16%      -0.4        0.10 ± 14%  perf-profile.children.cycles-pp._copy_to_iter
      0.86 ± 12%      -0.4        0.43 ±  4%  perf-profile.children.cycles-pp.check_heap_object
      0.82 ± 11%      -0.4        0.39 ±  6%  perf-profile.children.cycles-pp._copy_from_iter
      1.83 ±  6%      -0.4        1.47 ±  8%  perf-profile.children.cycles-pp.lock_sock_nested
      2.26 ±  3%      -0.3        1.92        perf-profile.children.cycles-pp.arch_exit_to_user_mode_prepare
      0.78 ±  8%      -0.3        0.52 ±  3%  perf-profile.children.cycles-pp.ktime_get
      0.63 ±  9%      -0.2        0.40 ±  4%  perf-profile.children.cycles-pp.tcp_send_mss
      0.34 ± 13%      -0.2        0.11 ±  6%  perf-profile.children.cycles-pp.__tcp_select_window
      0.51 ±  8%      -0.2        0.32 ±  3%  perf-profile.children.cycles-pp.read_tsc
      1.63 ±  3%      -0.2        1.44 ±  3%  perf-profile.children.cycles-pp.release_sock
      0.55 ±  8%      -0.2        0.36 ±  4%  perf-profile.children.cycles-pp.tcp_current_mss
      0.40 ±  9%      -0.2        0.23 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
      1.24 ±  3%      -0.2        1.08        perf-profile.children.cycles-pp.fdget
      1.38 ±  2%      -0.1        1.23        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.96 ±  2%      -0.1        0.83        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.17 ± 13%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.import_ubuf
      0.16 ± 11%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.tcp_tso_segs
      0.96 ±  2%      -0.1        0.88        perf-profile.children.cycles-pp.x64_sys_call
      0.13 ± 13%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.inet_sendmsg
      0.32 ±  6%      -0.1        0.26 ±  3%  perf-profile.children.cycles-pp.tcp_established_options
      0.11 ± 10%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.tcp_push
      0.15 ±  8%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.ipv4_mtu
      0.11 ± 11%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_release_cb
      0.12 ± 10%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.sk_page_frag_refill
      0.09 ± 10%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__send
      0.08 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.skb_page_frag_refill
      0.42 ±  2%      -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.stress_sigurg_server
      0.39 ±  2%      -0.0        0.37 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.__get_user_nocheck_4
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.raw_v4_input
      0.10 ±  3%      +0.0        0.11        perf-profile.children.cycles-pp.__copy_skb_header
      0.14 ±  2%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__fpu_restore_sig
      0.11 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp.netif_skb_features
      0.09 ±  4%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.enqueue_timer
      0.13 ±  2%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.check_xstate_in_sigframe
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.refill_stock
      0.09 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.tcp_send_delayed_ack
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.tcp_measure_rcv_mss
      0.12 ±  4%      +0.0        0.14        perf-profile.children.cycles-pp._raw_read_lock_irqsave
      0.31 ±  2%      +0.0        0.32        perf-profile.children.cycles-pp.fpregs_mark_activate
      0.13 ±  2%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.detach_if_pending
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.ip_send_check
      0.11 ±  3%      +0.0        0.13        perf-profile.children.cycles-pp.tcp_wfree
      0.08 ±  6%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp._find_first_bit
      0.20 ±  2%      +0.0        0.22        perf-profile.children.cycles-pp.tcp_queue_rcv
      0.37 ±  2%      +0.0        0.39        perf-profile.children.cycles-pp.restore_fpregs_from_user
      0.14 ±  4%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.tcp_event_data_recv
      0.24 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp._raw_spin_lock
      0.16 ±  2%      +0.0        0.18        perf-profile.children.cycles-pp.try_charge_memcg
      0.18 ±  2%      +0.0        0.20        perf-profile.children.cycles-pp.native_sched_clock
      0.07 ±  8%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.netdev_core_pick_tx
      0.35 ±  2%      +0.0        0.37        perf-profile.children.cycles-pp.prepare_signal
      0.28            +0.0        0.31        perf-profile.children.cycles-pp.sock_def_readable
      0.22 ±  2%      +0.0        0.25        perf-profile.children.cycles-pp.sched_clock
      0.49            +0.0        0.51        perf-profile.children.cycles-pp.fpu__clear_user_states
      0.14 ±  5%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__ip_finish_output
      0.19 ±  3%      +0.0        0.22        perf-profile.children.cycles-pp.__ip_local_out
      0.26 ±  2%      +0.0        0.29        perf-profile.children.cycles-pp.sched_clock_cpu
      0.25 ±  3%      +0.0        0.28        perf-profile.children.cycles-pp.rb_erase
      0.22 ±  3%      +0.0        0.25        perf-profile.children.cycles-pp.validate_xmit_skb
      0.62 ±  3%      +0.0        0.65        perf-profile.children.cycles-pp.native_irq_return_iret
      0.52 ±  3%      +0.0        0.55 ±  2%  perf-profile.children.cycles-pp.fpu__restore_sig
      0.23 ±  3%      +0.0        0.26        perf-profile.children.cycles-pp.ip_local_out
      0.22 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.54            +0.0        0.58        perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.18 ±  3%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_sk_uncharge
      0.35 ±  3%      +0.0        0.39 ±  3%  perf-profile.children.cycles-pp.tcp_rearm_rto
      0.35 ±  2%      +0.0        0.38        perf-profile.children.cycles-pp.irqtime_account_irq
      0.44 ±  3%      +0.0        0.48        perf-profile.children.cycles-pp._raw_read_unlock_irqrestore
      0.25 ±  3%      +0.0        0.29 ±  2%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.22 ±  9%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.dst_release
      0.29 ±  2%      +0.0        0.33 ±  4%  perf-profile.children.cycles-pp.mod_memcg_state
      0.28 ±  3%      +0.0        0.32        perf-profile.children.cycles-pp.netif_rx_internal
      0.63 ±  2%      +0.0        0.67        perf-profile.children.cycles-pp.restore_sigcontext
      0.23 ±  3%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.ip_rcv_core
      0.32 ±  2%      +0.0        0.36        perf-profile.children.cycles-pp.rb_insert_color
      0.30 ±  3%      +0.0        0.34        perf-profile.children.cycles-pp.__netif_rx
      0.31 ±  3%      +0.0        0.36        perf-profile.children.cycles-pp.lock_timer_base
      1.16            +0.0        1.21        perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      0.34 ±  3%      +0.0        0.39 ±  2%  perf-profile.children.cycles-pp.skb_clone
      0.25 ±  6%      +0.0        0.30 ±  4%  perf-profile.children.cycles-pp.barn_replace_full_sheaf
      0.36            +0.0        0.41        perf-profile.children.cycles-pp.mem_cgroup_sk_charge
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__xfrm_policy_check2
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.bpf_skops_write_hdr_opt
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.skb_clone_tx_timestamp
      0.34 ±  2%      +0.1        0.40        perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      0.32 ±  3%      +0.1        0.37        perf-profile.children.cycles-pp.tcp_skb_entail
      0.30            +0.1        0.35 ±  2%  perf-profile.children.cycles-pp.complete_signal
      0.82            +0.1        0.87        perf-profile.children.cycles-pp.get_sigframe
      0.28 ±  2%      +0.1        0.33 ±  3%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.29 ±  3%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.kfree_skbmem
      0.96            +0.1        1.02        perf-profile.children.cycles-pp.x64_setup_rt_frame
      0.68 ±  2%      +0.1        0.74        perf-profile.children.cycles-pp.__refill_objects_node
      0.68 ±  2%      +0.1        0.74        perf-profile.children.cycles-pp.refill_objects
      0.67 ±  3%      +0.1        0.73 ±  3%  perf-profile.children.cycles-pp.recalc_sigpending
      0.34 ±  5%      +0.1        0.40 ±  4%  perf-profile.children.cycles-pp.barn_replace_empty_sheaf
      0.37 ±  3%      +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.__inet_lookup_established
      0.55 ±  3%      +0.1        0.62        perf-profile.children.cycles-pp.skb_release_head_state
      0.76 ±  3%      +0.1        0.82 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.47 ±  4%      +0.1        0.54 ±  3%  perf-profile.children.cycles-pp.__pcs_replace_full_main
      0.50 ±  2%      +0.1        0.56 ±  4%  perf-profile.children.cycles-pp.tcp_try_rmem_schedule
      0.44 ±  2%      +0.1        0.51 ±  2%  perf-profile.children.cycles-pp._find_next_bit
      0.46 ±  2%      +0.1        0.53 ±  2%  perf-profile.children.cycles-pp.__inet_lookup_skb
      0.53 ±  4%      +0.1        0.61 ±  3%  perf-profile.children.cycles-pp.ip_rcv
      0.56 ±  2%      +0.1        0.64        perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      0.77 ±  3%      +0.1        0.86        perf-profile.children.cycles-pp.skb_release_data
      0.60 ±  2%      +0.1        0.69        perf-profile.children.cycles-pp.__sk_mem_schedule
      0.70 ±  2%      +0.1        0.80        perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.88 ±  3%      +0.1        0.99        perf-profile.children.cycles-pp.kmalloc_reserve
      0.68 ±  3%      +0.1        0.79 ±  2%  perf-profile.children.cycles-pp.skb_defer_free_flush
      0.62 ±  3%      +0.1        0.73 ±  3%  perf-profile.children.cycles-pp.loopback_xmit
      1.05 ±  3%      +0.1        1.18 ±  2%  perf-profile.children.cycles-pp.__pcs_replace_empty_main
      0.93 ±  2%      +0.1        1.06        perf-profile.children.cycles-pp.__mod_timer
      0.98 ±  2%      +0.1        1.12        perf-profile.children.cycles-pp.sk_reset_timer
      2.46 ±  2%      +0.1        2.60 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      2.50 ±  2%      +0.1        2.64 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.70 ±  3%      +0.1        0.84 ±  3%  perf-profile.children.cycles-pp.xmit_one
      0.74 ±  3%      +0.1        0.89 ±  3%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      2.06 ±  2%      +0.2        2.22 ±  4%  perf-profile.children.cycles-pp.__irq_exit_rcu
      1.36 ±  3%      +0.2        1.52        perf-profile.children.cycles-pp.__kfree_skb
      1.48 ±  3%      +0.2        1.65        perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      1.41 ±  2%      +0.2        1.62 ±  2%  perf-profile.children.cycles-pp.tcp_data_queue
      0.89 ±  5%      +0.2        1.14 ±  3%  perf-profile.children.cycles-pp.__release_sock
      2.29 ±  2%      +0.3        2.58 ±  2%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
      2.50 ±  3%      +0.3        2.82        perf-profile.children.cycles-pp.__alloc_skb
      2.74 ±  2%      +0.4        3.10        perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      1.74 ±  2%      +0.4        2.13 ±  3%  perf-profile.children.cycles-pp._raw_spin_unlock_irq
      3.20 ±  3%      +0.5        3.66        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      3.56 ±  3%      +0.5        4.06        perf-profile.children.cycles-pp.tcp_ack
     81.40            +0.9       82.32        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      6.26 ± 11%      +1.0        7.23 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     80.20            +1.1       81.27        perf-profile.children.cycles-pp.do_syscall_64
      7.67 ±  9%      +1.2        8.86 ±  4%  perf-profile.children.cycles-pp.signal_setup_done
      9.03 ±  7%      +1.3       10.29 ±  3%  perf-profile.children.cycles-pp.stress_sigurg_handler
      4.39 ± 15%      +1.3        5.67 ± 10%  perf-profile.children.cycles-pp.dec_rlimit_put_ucounts
      4.39 ± 15%      +1.3        5.68 ± 10%  perf-profile.children.cycles-pp.__sigqueue_free
      5.56 ±  9%      +1.3        6.86 ±  7%  perf-profile.children.cycles-pp.dequeue_signal
      4.08 ± 15%      +1.3        5.43 ± 11%  perf-profile.children.cycles-pp.inc_rlimit_get_ucounts
      4.10 ± 15%      +1.4        5.44 ± 11%  perf-profile.children.cycles-pp.sig_get_ucounts
      6.18 ±  8%      +1.5        7.64 ±  6%  perf-profile.children.cycles-pp.get_signal
     39.09            +1.5       40.61        perf-profile.children.cycles-pp.ioctl
     11.90 ±  5%      +2.1       14.03        perf-profile.children.cycles-pp.do_send_sig_info
     41.20            +2.2       43.38        perf-profile.children.cycles-pp.__x64_sys_sendto
     12.61 ±  5%      +2.2       14.82        perf-profile.children.cycles-pp.send_sigurg
     41.12            +2.2       43.32        perf-profile.children.cycles-pp.__sys_sendto
     12.65 ±  5%      +2.2       14.86        perf-profile.children.cycles-pp.sk_send_sigurg
     13.85 ±  5%      +2.3       16.19        perf-profile.children.cycles-pp.tcp_urg
     40.28            +2.6       42.86        perf-profile.children.cycles-pp.tcp_sendmsg
     15.38 ±  2%      +2.7       18.12        perf-profile.children.cycles-pp.exit_to_user_mode_loop
     15.35 ±  2%      +2.7       18.08        perf-profile.children.cycles-pp.arch_do_signal_or_restart
     38.45            +2.9       41.32        perf-profile.children.cycles-pp.tcp_sendmsg_locked
     20.61 ±  3%      +3.1       23.72        perf-profile.children.cycles-pp.tcp_v4_rcv
     20.75 ±  3%      +3.1       23.87        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     20.81 ±  3%      +3.1       23.94        perf-profile.children.cycles-pp.ip_local_deliver_finish
     20.86 ±  3%      +3.1       23.99        perf-profile.children.cycles-pp.ip_local_deliver
     19.64 ±  4%      +3.1       22.78        perf-profile.children.cycles-pp.tcp_rcv_established
     21.99 ±  3%      +3.2       25.16        perf-profile.children.cycles-pp.__local_bh_enable_ip
     19.95 ±  4%      +3.2       23.13        perf-profile.children.cycles-pp.tcp_v4_do_rcv
     21.69 ±  3%      +3.3       24.97        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     22.08 ±  3%      +3.3       25.42        perf-profile.children.cycles-pp.process_backlog
     22.12 ±  3%      +3.3       25.47        perf-profile.children.cycles-pp.__napi_poll
     21.54 ±  3%      +3.4       24.94        perf-profile.children.cycles-pp.do_softirq
     22.99 ±  3%      +3.5       26.47        perf-profile.children.cycles-pp.net_rx_action
     23.53 ±  3%      +3.5       27.07        perf-profile.children.cycles-pp.handle_softirqs
     24.05 ±  3%      +3.8       27.86        perf-profile.children.cycles-pp.__dev_queue_xmit
     24.30 ±  3%      +3.8       28.14        perf-profile.children.cycles-pp.ip_finish_output2
     24.54 ±  3%      +3.9       28.41        perf-profile.children.cycles-pp.ip_output
     31.64 ±  2%      +4.0       35.64        perf-profile.children.cycles-pp.__tcp_push_pending_frames
     25.80 ±  3%      +4.0       29.82        perf-profile.children.cycles-pp.__ip_queue_xmit
     31.57 ±  2%      +4.0       35.61        perf-profile.children.cycles-pp.tcp_write_xmit
     27.28 ±  3%      +4.2       31.49        perf-profile.children.cycles-pp.__tcp_transmit_skb
      0.87 ± 13%      -0.5        0.34 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      3.99            -0.4        3.57        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.51 ± 17%      -0.4        0.10 ± 15%  perf-profile.self.cycles-pp._copy_to_iter
      0.76 ± 11%      -0.4        0.36 ±  5%  perf-profile.self.cycles-pp._copy_from_iter
      2.91 ±  2%      -0.4        2.51        perf-profile.self.cycles-pp.do_syscall_64
      1.00 ±  9%      -0.3        0.66 ±  3%  perf-profile.self.cycles-pp.tcp_sendmsg_locked
      0.39 ± 16%      -0.3        0.08 ± 12%  perf-profile.self.cycles-pp.tcp_recvmsg_locked
      2.08 ±  3%      -0.3        1.78        perf-profile.self.cycles-pp.arch_exit_to_user_mode_prepare
      0.35 ± 17%      -0.3        0.07 ± 15%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.32 ± 13%      -0.2        0.10 ±  6%  perf-profile.self.cycles-pp.__tcp_select_window
      0.38 ± 13%      -0.2        0.17 ±  5%  perf-profile.self.cycles-pp.check_heap_object
      1.90 ±  2%      -0.2        1.70        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.41 ± 11%      -0.2        0.21 ±  3%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.58 ±  9%      -0.2        0.40 ±  3%  perf-profile.self.cycles-pp.tcp_write_xmit
      0.27 ± 15%      -0.2        0.09 ±  7%  perf-profile.self.cycles-pp.__check_object_size
      0.47 ±  8%      -0.2        0.29 ±  2%  perf-profile.self.cycles-pp.read_tsc
      1.32 ±  2%      -0.2        1.15        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.38 ± 11%      -0.2        0.21 ±  5%  perf-profile.self.cycles-pp.__sys_sendto
      0.37 ±  9%      -0.1        0.22 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      1.04 ±  3%      -0.1        0.91        perf-profile.self.cycles-pp.fdget
      0.96 ±  2%      -0.1        0.82        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.23 ± 11%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.release_sock
      0.89 ±  2%      -0.1        0.79        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.38 ±  5%      -0.1        0.28        perf-profile.self.cycles-pp.tcp_recvmsg
      0.14 ± 14%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.import_ubuf
      0.18 ± 10%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.tcp_current_mss
      0.14 ± 11%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_tso_segs
      0.28 ±  8%      -0.1        0.22 ±  5%  perf-profile.self.cycles-pp.ktime_get
      0.15 ±  9%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.skb_do_copy_data_nocache
      0.69 ±  2%      -0.1        0.63        perf-profile.self.cycles-pp.x64_sys_call
      0.29 ±  5%      -0.0        0.24 ±  3%  perf-profile.self.cycles-pp.tcp_established_options
      0.11 ± 11%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.tcp_sendmsg
      0.09 ±  9%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.tcp_release_cb
      0.13 ±  7%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.ipv4_mtu
      0.07 ± 10%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__send
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.tcp_send_delayed_ack
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.__ip_local_out
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.skb_release_head_state
      0.08            +0.0        0.09        perf-profile.self.cycles-pp.__usecs_to_jiffies
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.irqtime_account_irq
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.netif_skb_features
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.tcp_event_data_recv
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.tcp_inbound_hash
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.tcp_options_write
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__copy_skb_header
      0.09 ±  4%      +0.0        0.10        perf-profile.self.cycles-pp.refill_stock
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__ip_finish_output
      0.19            +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.05 ±  7%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.qdisc_pkt_len_segs_init
      0.12 ±  5%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.barn_replace_full_sheaf
      0.07 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.loopback_xmit
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.lock_timer_base
      0.06 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.tcp_stream_alloc_skb
      0.08 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.__inet_lookup_skb
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp._raw_read_lock_irqsave
      0.30 ±  2%      +0.0        0.31        perf-profile.self.cycles-pp.fpregs_mark_activate
      0.29            +0.0        0.31        perf-profile.self.cycles-pp.__restore_fpregs_from_user
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp._find_first_bit
      0.08            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.ip_rcv
      0.08 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.inet_ehashfn
      0.10            +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.validate_xmit_skb
      0.11            +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.detach_if_pending
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.tcp_wfree
      0.13 ±  4%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.08 ±  4%      +0.0        0.10        perf-profile.self.cycles-pp.tcp_v4_do_rcv
      0.17 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.tcp_urg
      0.13 ±  2%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.try_charge_memcg
      0.22 ±  2%      +0.0        0.24        perf-profile.self.cycles-pp._raw_spin_lock
      0.17 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.native_sched_clock
      0.08 ±  7%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.xmit_one
      0.11 ±  5%      +0.0        0.13        perf-profile.self.cycles-pp.ip_send_check
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.06 ±  9%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.netdev_core_pick_tx
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.send_sigurg
      0.18 ±  5%      +0.0        0.21 ±  3%  perf-profile.self.cycles-pp.barn_replace_empty_sheaf
      0.20 ±  3%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.net_rx_action
      0.34 ±  2%      +0.0        0.36 ±  2%  perf-profile.self.cycles-pp.prepare_signal
      0.14 ±  2%      +0.0        0.16        perf-profile.self.cycles-pp.process_backlog
      0.18 ±  2%      +0.0        0.20        perf-profile.self.cycles-pp.__sk_mem_raise_allocated
      0.17 ±  2%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.skb_defer_free_flush
      0.37            +0.0        0.39        perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      0.31 ±  2%      +0.0        0.33 ±  2%  perf-profile.self.cycles-pp.__send_signal_locked
      0.06 ± 11%      +0.0        0.09 ± 12%  perf-profile.self.cycles-pp.eth_type_trans
      0.26            +0.0        0.29        perf-profile.self.cycles-pp.sock_def_readable
      0.18 ±  3%      +0.0        0.21        perf-profile.self.cycles-pp.handle_softirqs
      0.24 ±  2%      +0.0        0.27        perf-profile.self.cycles-pp.rb_erase
      0.62 ±  3%      +0.0        0.65        perf-profile.self.cycles-pp.native_irq_return_iret
      0.31 ±  3%      +0.0        0.34 ±  3%  perf-profile.self.cycles-pp.tcp_rearm_rto
      0.22 ±  2%      +0.0        0.25 ±  5%  perf-profile.self.cycles-pp.mod_memcg_state
      0.32 ±  2%      +0.0        0.35        perf-profile.self.cycles-pp.skb_release_data
      0.24 ±  2%      +0.0        0.27        perf-profile.self.cycles-pp.skb_clone
      0.27 ±  2%      +0.0        0.30        perf-profile.self.cycles-pp.tcp_v4_rcv
      0.51            +0.0        0.55        perf-profile.self.cycles-pp.__refill_objects_node
      0.45 ±  5%      +0.0        0.49        perf-profile.self.cycles-pp.kmem_cache_free
      0.30            +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.rb_insert_color
      0.32 ±  2%      +0.0        0.36        perf-profile.self.cycles-pp.__mod_timer
      0.22 ±  2%      +0.0        0.26 ±  3%  perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      0.20 ±  2%      +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.complete_signal
      0.33 ±  2%      +0.0        0.37        perf-profile.self.cycles-pp.tcp_ack
      0.26 ±  2%      +0.0        0.30        perf-profile.self.cycles-pp.tcp_rcv_established
      0.22 ±  4%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.ip_rcv_core
      0.20 ±  4%      +0.0        0.25 ±  4%  perf-profile.self.cycles-pp.tcp_data_queue
      0.27 ±  2%      +0.0        0.32 ±  3%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.44 ±  3%      +0.0        0.49 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.30 ±  3%      +0.0        0.35        perf-profile.self.cycles-pp.tcp_skb_entail
      0.28 ±  3%      +0.1        0.33 ±  3%  perf-profile.self.cycles-pp.__inet_lookup_established
      0.28 ±  3%      +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.kfree_skbmem
      0.59 ±  3%      +0.1        0.64 ±  2%  perf-profile.self.cycles-pp._raw_spin_unlock_irq
      0.66 ±  2%      +0.1        0.72 ±  3%  perf-profile.self.cycles-pp.recalc_sigpending
      0.42 ±  2%      +0.1        0.49 ±  2%  perf-profile.self.cycles-pp._find_next_bit
      0.88 ±  3%      +0.1        0.96        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.93 ±  4%      +0.1        1.03        perf-profile.self.cycles-pp.__ip_queue_xmit
      0.80 ±  2%      +0.1        0.90        perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.94 ±  2%      +0.1        1.06        perf-profile.self.cycles-pp.__alloc_skb
      1.15 ±  3%      +0.1        1.30 ±  2%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
      1.48 ±  4%      +0.2        1.67        perf-profile.self.cycles-pp.__dev_queue_xmit
      1.58 ±  3%      +0.2        1.82        perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      4.38 ± 15%      +1.3        5.66 ± 10%  perf-profile.self.cycles-pp.dec_rlimit_put_ucounts
      4.08 ± 15%      +1.3        5.43 ± 11%  perf-profile.self.cycles-pp.inc_rlimit_get_ucounts




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


