Return-Path: <netdev+bounces-208389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B1EB0B42B
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 10:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F1217C6A6
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68EC1DE3C0;
	Sun, 20 Jul 2025 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+96liej"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658271D9663;
	Sun, 20 Jul 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752999223; cv=fail; b=qUm6DMZVMcje7Oym+VGVhV9RuAtiwCXLGWcStVO3SJYgxe2YLbFmtKvJhuFPFeTwJ1pS3DkJ6oxg00AYzkZd6e+lOSlzFHcAanULpzTVyjx4G0raFndHN2rbsRneXa209N0+jvn/cYrYimmRoljv2upLNyoWweoyr3uf5JO5/qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752999223; c=relaxed/simple;
	bh=WA8gJyDGVYQ3eOj+S5b2HY37M0CwyNbNb1S/lj7g/p0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=jFXQFT55onUIKXu3XYP07J5Bm9MG2xA8EwWwqF1gSHCU8e9d6bSTQN2vFhvPhfOyOUk7+UED1dObYho9FG7IIeiUfB0Pgmfe9ubZ9M1hMK3mVi+0SBhY/B1uD7IcHyKh4GjjCw9hiI4STTuluA85w+TwI5oqjobqAn649J3Eves=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+96liej; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752999222; x=1784535222;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WA8gJyDGVYQ3eOj+S5b2HY37M0CwyNbNb1S/lj7g/p0=;
  b=e+96liejFGoWngxTY9H2zc4LmYx8Nd5AaQlr9CfXusxsW2oS1b+y+tKU
   j800qkmaWuEXCIe3O01hlPS3VeupeddoUR8vfggyOo4GvQ9H2TDm1zoHK
   6uv1c6yy763LaieIpK1LGD9VEQ80lxOT5CDMCiM5saRiZSMtS2naav1TI
   1yzZhYhw/+X2QmXD8odmUMJmkYRwjpCAOtEgFJ8Na1uGghH7I3A2Fvm8V
   Il2SH47DNuCZwXvjjY+XkRLeB5v60/u87UC6KlZbVmTR/gs55C1T9XZm+
   8opABykosgkTMHX0V4cqMTo5l7JIjE5rT64gPLIVD2Nh/musxUGGkU/Vi
   Q==;
X-CSE-ConnectionGUID: yBosXtgCR2K8oulxPHRerw==
X-CSE-MsgGUID: B/Yb84+7S9COWwKXJlpS4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="55360033"
X-IronPort-AV: E=Sophos;i="6.16,326,1744095600"; 
   d="scan'208";a="55360033"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 01:13:41 -0700
X-CSE-ConnectionGUID: LjzlcRaKTtKB/wogWxJPMg==
X-CSE-MsgGUID: Krap7cEpQjKhTaRLieYbFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,326,1744095600"; 
   d="scan'208";a="158235102"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 01:12:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 20 Jul 2025 01:12:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 20 Jul 2025 01:12:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 20 Jul 2025 01:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAsQEW8lxKoR6aao6O2WihL/3On9dpJJ/iD5ve1PPcpfYOX9iLW29ZYtSVE9eLpyRKvJXbCf06K+9wfLE8HrIbpKfrQ1bHnbsb/+Ys1AxCr32ZpwUI1bHPocoBr7TGZoGh8CikQRfgmLVsXbiKyPdXY9Ldp+EaxhjEYIefL5cYdoIIJ6+iyr0eHezTHA3GlS31suBNWIYHJ3pmbqFZpugCgBrWaONxLx/p0F2/jTT4puoojDTaCAhE9Tn59w5EtbDLBXTuVAPBV4T7YM+jtajUb+vxz7lMmQ6TlAoUn17v9oZVZ6zXwgSS//PQS7gI7ITwWMkrGOFL3iExAQOng6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVAJ/yRHOpi/KbA2JSgsq7uEok/aUuEIqbO3VM57mKo=;
 b=dQcAa3DspDWzR4XNy6P7WekOs7lv9z4Qji7+4cw6jTgHzZbCxU2owGVjZucp+D9yDzreOC1vs+ilRczp+DuzTIBkt3WWE1QFITIdTAK29bELQKev+rz4x7zJQvwhUt4ztdLEXRDYc4wz6QPu4a+Z7R5KWaF9Q3VpsSq/zVfS+u/yXff509VgKm65MdrHtUNvDwCTeWtEf+Sc+l55vIRDfWZEGHSgfN6EXl4vlI2ZRg4asK6SU1WycHIWPnlMEYpQK/NioHEGnSp45FmF7pH7Yhax7/4M+iNdjuhZ+AvmJhmmgrXN6yZDbHgrXbQ/55hLrK/6pZLHLMyQ+9h+3rpfIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4579.namprd11.prod.outlook.com (2603:10b6:5:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Sun, 20 Jul
 2025 08:12:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Sun, 20 Jul 2025
 08:12:16 +0000
Date: Sun, 20 Jul 2025 16:12:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Gilad Naaman <gnaaman@drivenets.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [neighbour]  [confidence: ] f7f5273863:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN
Message-ID: <202507200931.7a89ecd8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a4552d-2af2-457c-7f09-08ddc76523a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5/XREz+ESxbhJIUkL4CmTZws5ZiRl7xcFaZlJ7gFFJY69k0uvTr5XLfTpn8n?=
 =?us-ascii?Q?RrbzAh1MPH5QwG6l20bu4P6bSR3PzDuFjW/O3CVCERabfd//wUf8mQXJNvmH?=
 =?us-ascii?Q?m8M9uzGV55Nio1pSxu48gH8GbKNcwkchaURK/TjYhTYph4qX6WIBsYCVSuYv?=
 =?us-ascii?Q?1h8M1T2FKVMcNjdAT4amAMA3sJK1s1RlSErlNBUb3aemErESXCr0Maem2LdX?=
 =?us-ascii?Q?RcRQzj2ighBF+9L+XA0sS5pvWAl0HV9RWdp+FrHv8UasrmrDakaN+DBOQObP?=
 =?us-ascii?Q?dPwukWoXfnfnbv4X8iRIEjdFnkKdwpT9dxkWZ8X8200cJVN9T1RgIGFnpBVk?=
 =?us-ascii?Q?xIFSkZ4pXbghISCoanM5ZoB5yMjEJiKHHkomrOxcNZ3Di3U3ScCFHZtSCI57?=
 =?us-ascii?Q?KqJyOZfNsVog8T1eTuD+MvcqSHhm+n7C0axgJSETyQfiIDtBKVD4qUf9NM4q?=
 =?us-ascii?Q?5QqxAuyIPMdIAOgsz7YWu0xo06dj0T8ujOyD2ZJlDhTklqYUBPN+f9j/MU33?=
 =?us-ascii?Q?T6r8QNBV2i0Uu08mzhaWCAjNp3FKMqG4sZae4tnDlxi7cABEPeY7ML9gvT1w?=
 =?us-ascii?Q?p4LV+W1GmMpbPTntKPB9+f7uyYp0bieLz7KH5poAH3gbJeEgKtfhNbI4IbgZ?=
 =?us-ascii?Q?bfyatbcNySZkN/rpQCKnZX1TSzjomLSMffRbgHjv4JyGwUP/sDJXWs4Rea21?=
 =?us-ascii?Q?CeEkjBF4Io1+9Qg+fEjGv07YKb7swS8XOIOHLqMpkwCGHXHgwnOHCmoej/dm?=
 =?us-ascii?Q?qGxEBwRgcCCcqaCWAHlLpXtFv0JYRXKi6Ufknm01sKyKbM/AbntKBP8v+zR0?=
 =?us-ascii?Q?8W6g0CvdJ7PNbjfX+l0loRs3f6IQQYMEkVuvtg5WkLqk13P58tUIqe+zLbP3?=
 =?us-ascii?Q?wy8Aeej7D6l1vxELMqgTvlwrOF8qECRg3Xr6FLU89WExycjAkR8Cox71eK+S?=
 =?us-ascii?Q?/Qp2OHi8xNTYuD24NuT/1PMrexyiNh7u1KAXUnn1NkbT1/IddvLhb6xPG5W7?=
 =?us-ascii?Q?jnLrXrBRP1xNZn89Oimaf8Lpo/xMGzgx0Y9qpG1pwKN8zPK5j+LPmpS8GkHm?=
 =?us-ascii?Q?osErpWjPJLqhy94FtfacXuWWfjxrfGTSddzofpzX9XOq5SH6n7wfx2HdfYyu?=
 =?us-ascii?Q?W7woIt9eYT+kcbNmpyPfAn2Tu2ON7SA6nLlh+uhjhpUGOgVYFutrx+yEPwX/?=
 =?us-ascii?Q?ftwN3AUIPopG3G80YY2YCdtuylblZnZR6VlCB/3CEWyS7hvcUHnA18v9P0Cu?=
 =?us-ascii?Q?tcyexljT/w/LfeKPgWf2v85AMcPJRZFChirvhghHPchFaIZ+P2VtXEwPFzw9?=
 =?us-ascii?Q?gpuiRd9igjOZlm83S29iVFvnPVf9FnjJiqr4bbdT54A5q1K4mxAO2DjqTgIB?=
 =?us-ascii?Q?OqZVXAbvc+NuDY95j7wVUZqR5Ax6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YRtNa7r98jsmTENPX4ZFezrHi10SQc3SJzVbutV4DxBQ7OlvLx5R3GEKilJK?=
 =?us-ascii?Q?/S9M/83t5scPRXVSeLyWG3AM17Cbe04OwahvjwucF2PaCK7Qk6voNQ0O3jKg?=
 =?us-ascii?Q?Qk/PLkqArOT2sgLxMxhSEyxqvRVAqDNdhsv/IT/4DrAzgHa74jcd26Jbpygy?=
 =?us-ascii?Q?C70uFMiLgo2p9FYVpKgSnNhiuhYCbPGNNc9eCh/EFmWjU0QIV/yp6AAZ05tY?=
 =?us-ascii?Q?04N5gJZXWyrKPnGPa7Opf91KsNIrmJcrKoFOLWXCzfLQCJwdE23bfu8SZ8f3?=
 =?us-ascii?Q?n/2UNv4ybKlPNGiQ0Y/kgKKMPX6TTK0B/cqfv59ypAVIRi5F96btZG8TYMYx?=
 =?us-ascii?Q?p9xhYT7pvObNtPxgcY+mJQyai9x907/3uoBClrxYxbTBRVLNFfmFFW/pzqux?=
 =?us-ascii?Q?drKkAdfv9pNjKZm0FIxHKfbmgDSgezUSmklpD1I8HzQBnhRg+Zd9CAwKStkl?=
 =?us-ascii?Q?N+99zKnAe03YoFotRcdqns9Y7YbOA+FKp0oJA6Fo9y1J1WE/NaqKpyfxIhvU?=
 =?us-ascii?Q?m3TEWECqVLctPAbgOkPE8iuKoKa03EyjBLO1c5lbx8lAT/bGmjFu8tmpOZGf?=
 =?us-ascii?Q?XbIiiXHsFgC+qjp+WmkkU1OsxkCiMTSqge2UcHp1yD7bKAothqiXPs+CRx9U?=
 =?us-ascii?Q?h/PucDtsrlWfmg54FEaiQyEXptXKI039TClWFjtDCvv3zRhVZQ0RQwa+aR5D?=
 =?us-ascii?Q?39V4aFwrlDudRJUkprjw7Eb/fcFArlamqAYPU888WXG2EFyzA6Xu+H8X9dco?=
 =?us-ascii?Q?/CRIjaHy/0ZGGIoe0cqeujvTFqRSTrbRbhe8yz2yLcFe7QB34Vz5PSSPEsA/?=
 =?us-ascii?Q?s+Q3aAbntIxoHAtoYhTykDfQXXx2VxDIazr5ldcg7hkUhsJdvC09eyRpzY+h?=
 =?us-ascii?Q?bt+XTx2t5gxvvCVv6mCAVF62WaS/t9KxsKYsOBXyBZSMIVgHcNCkxKttZyDD?=
 =?us-ascii?Q?m0hEMzqPK1yxTevjosAfMiqo3ppj2hYZixZWXEDwthZmA2Y7vkhP/TzRZneO?=
 =?us-ascii?Q?dzUvMdHdzf93Iq1casg3bNknn4AXzARlzaBsGGcjO3zbQjOewvz4G5pK4khQ?=
 =?us-ascii?Q?vIhIM1xQyxYvq5QOq57iE6QGEgFc3I+3QLjgrXrjHMDJMZT+FpHAv0vI8GBN?=
 =?us-ascii?Q?CVcprBQ1VqSh6X6WZhK7L9d3F2P+TFh/cB27zdfFT9F+jU7t8DQE2d7kYbhi?=
 =?us-ascii?Q?UoE1X0Rw941cSFDlXGRTqkO7ljIhxu/FLSnSV7JDinbhUYJZzbyIZrfi7WGb?=
 =?us-ascii?Q?C4sEzL+lJYvO1UqXXre8NUUGFSFM41kXzJo1/A6sb1iT63srkDUjuM1R1/j2?=
 =?us-ascii?Q?1qWVJYYLnYQ1x1vCppA389/JEqw9i7BLnC5UzOt4GKEUmQM1M4kZPSJXRR4M?=
 =?us-ascii?Q?KPmcTQmF++ipJLndyjMRfxxFPwOhDj4lXU9DmwXU3N1xeuVya+LwkcKltlNf?=
 =?us-ascii?Q?NLVTeT2yqqYkuoRo6z2zKcvU+olrf2aFtEGPocBUc4l1KXXIzB6Kpc7T/O9j?=
 =?us-ascii?Q?e47ZR0LZqUfACAmA39+Nd7MvS3WC3LbZgW+mHJXDb/hUFCLmL5SxJku7zswF?=
 =?us-ascii?Q?bItxhG73I99pjvmT/gMEsHXmQOoXFn3be8aEw+bu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a4552d-2af2-457c-7f09-08ddc76523a4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 08:12:16.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+SUv6PdPW3HEIqoEmYsWz4kQ6FoXAhHP31yXy9Ajh8IzjE6j48oFF/oZHGvD3nwxKABk9LJt6XrrZDEopsCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4579
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN" on:

commit: f7f52738637f4361c108cad36e23ee98959a9006 ("neighbour: Create netdev->neighbour association")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      f4a40a4282f467ec99745c6ba62cb84346e42139]
[test failed on linux-next/master d086c886ceb9f59dea6c3a9dae7eb89e780a20c9]

in testcase: boot

config: x86_64-randconfig-123-20250718
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | a01a67ab2f | f7f5273863 |
+----------------------------------------------------------------------------------+------------+------------+
| BUG_RAWv6                                                                        | 7          |            |
| WARNING:at_mm/slab_common.c:#kmem_cache_destroy                                  | 7          |            |
| RIP:kmem_cache_destroy                                                           | 7          |            |
| UBSAN:signed-integer-overflow_in_include/linux/atomic/atomic-arch-fallback.h     | 7          |            |
| Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN | 0          | 7          |
| KASAN:null-ptr-deref_in_range[#-#]                                               | 0          | 7          |
| RIP:neigh_flush_dev.llvm                                                         | 0          | 7          |
| Kernel_panic-not_syncing:Fatal_exception_in_interrupt                            | 0          | 7          |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507200931.7a89ecd8-lkp@intel.com


[   21.205230][    T1] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
[   21.328503][    T1] NET: Registered PF_INET6 protocol family
[   21.412618][    T1] IPv6: Attempt to unregister permanent protocol 6
[   21.433405][    T1] IPv6: Attempt to unregister permanent protocol 136
[   21.443410][    T1] IPv6: Attempt to unregister permanent protocol 17
[   22.737430][    T1] Oops: general protection fault, probably for non-canonical address 0xdffffc00000001a0: 0000 [#1] SMP KASAN
[   22.738764][    T1] KASAN: null-ptr-deref in range [0x0000000000000d00-0x0000000000000d07]
[   22.739736][    T1] CPU: 1 UID: 0 PID: 1 Comm: systemd Tainted: G                T  6.12.0-rc6-01246-gf7f52738637f #1
[   22.740972][    T1] Tainted: [T]=RANDSTRUCT
[   22.741513][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 22.742641][ T1] RIP: 0010:neigh_flush_dev.llvm.6395807810224103582 (kbuild/src/consumer/net/core/neighbour.c:380) 
[ 22.743530][ T1] Code: c1 e8 03 42 8a 04 38 84 c0 0f 85 15 05 00 00 31 c0 41 83 3e 0a 0f 94 c0 48 8d 1c c3 48 81 c3 f8 0c 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 f7 49 93 fe 4c 8b 3b 4d 85 ff 0f
All code
========
   0:	c1 e8 03             	shr    $0x3,%eax
   3:	42 8a 04 38          	mov    (%rax,%r15,1),%al
   7:	84 c0                	test   %al,%al
   9:	0f 85 15 05 00 00    	jne    0x524
   f:	31 c0                	xor    %eax,%eax
  11:	41 83 3e 0a          	cmpl   $0xa,(%r14)
  15:	0f 94 c0             	sete   %al
  18:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
  1c:	48 81 c3 f8 0c 00 00 	add    $0xcf8,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
  2a:*	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)		<-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 f7 49 93 fe       	call   0xfffffffffe934a30
  39:	4c 8b 3b             	mov    (%rbx),%r15
  3c:	4d 85 ff             	test   %r15,%r15
  3f:	0f                   	.byte 0xf

Code starting with the faulting instruction
===========================================
   0:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
   5:	74 08                	je     0xf
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 f7 49 93 fe       	call   0xfffffffffe934a06
   f:	4c 8b 3b             	mov    (%rbx),%r15
  12:	4d 85 ff             	test   %r15,%r15
  15:	0f                   	.byte 0xf
[   22.745585][    T1] RSP: 0000:ffff88810026f408 EFLAGS: 00010206
[   22.746292][    T1] RAX: 00000000000001a0 RBX: 0000000000000d00 RCX: 0000000000000000
[   22.747239][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffc0631640
[   22.748176][    T1] RBP: ffff88810026f470 R08: 0000000000000000 R09: 0000000000000000
[   22.749092][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   22.750004][    T1] R13: ffffffffc0625250 R14: ffffffffc0631640 R15: dffffc0000000000
[   22.750956][    T1] FS:  00007f575cb83940(0000) GS:ffff8883aee00000(0000) knlGS:0000000000000000
[   22.752016][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.752799][    T1] CR2: 00007f575db40008 CR3: 00000002bf936000 CR4: 00000000000406f0
[   22.753770][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   22.754687][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   22.755620][    T1] Call Trace:
[   22.756076][    T1]  <TASK>
[ 22.756491][ T1] ? show_regs (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:?) 
[ 22.757025][ T1] ? __die_body.llvm.18112809324785033505 (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421) 
[ 22.757760][ T1] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:?) 
[ 22.758289][ T1] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:751) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250720/202507200931.7a89ecd8-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


