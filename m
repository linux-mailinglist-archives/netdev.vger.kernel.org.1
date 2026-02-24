Return-Path: <netdev+bounces-260619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK7aDITlnWlDSgQAu9opvQ
	(envelope-from <netdev+bounces-260619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:53:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8345818AC46
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35D1D304EA8F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509A39E6C1;
	Tue, 24 Feb 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7cmqWQn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366234CDD;
	Tue, 24 Feb 2026 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955381; cv=fail; b=TvMlPVkW+I9t57PQ6dkEaWiOLHbdSufNc4lAnXNl3dXMiA40EdWAFPANZyzo+VEgld0YRUb3rGRBVeHLSjbIJONo9GpIjaN2BE6038Ud0ovMmFPeyJNUPVe+djvfXVPuApeG7nDSNqpsUAsLn0EYpct1NEiVml8OKD2X3+yQ8YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955381; c=relaxed/simple;
	bh=3U7Rjoa17vLFD4dxJ3H4HvOxaJVmqMRfkQGJu0+19UI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQyvFjsBiBNkJsLqy/KvJCcAXfWsBcNZg0SX8hI+aRlK6fkNBwDWxnpEr2ZTv5SE6uBxywf+4BrIyJQv8wEvkM/FvS03AEUZfrwHOzLclLEzI5zKUOUPpw6ky5SlaBcmkOwcj9D/AgESKF1C8nDTyfPCxayEbyLifCmY7agquQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7cmqWQn; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771955380; x=1803491380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3U7Rjoa17vLFD4dxJ3H4HvOxaJVmqMRfkQGJu0+19UI=;
  b=W7cmqWQn0OyRduNZTfUNeJe9zfwAPEL845M4fUzU73T7UHCGZEd4+s72
   Bk8lmaG7jJlMN/FnzPrwcXhPPtNSycVMjK7CMYztKZxB2LEQLD/8ALuw4
   gACDo7xAVQSMHh4aDYp7fei9cr28LI+UYyxj4Qr+DaD/1zKcj1lNZkDwE
   iRKay8XoKH7I+N2sdVZg/2ozXf3t4SXnbaaEr36nR5yQ+E+13F3Jf2jU/
   nG4OrPycT0mtFN1P3K3IrAjNMpv/D9s+d4IrFs53f0KXQBEMJL2Xnp9QG
   NmVcKt1WaNep/93he9Ybq/NjTtgdOAZoCbtFiDE+uALKR6eCeDmL6ZELG
   A==;
X-CSE-ConnectionGUID: 3SNRY4c+RsCUpOV2SAJGJw==
X-CSE-MsgGUID: I/Hyqz2ES5CmS261UMsVlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72883454"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="72883454"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:49:40 -0800
X-CSE-ConnectionGUID: szUqkOP7TnaBL/spUxFxHA==
X-CSE-MsgGUID: KMfHl3dzTBuHVmiDWGa/Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="243892141"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:49:39 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 09:49:39 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 09:49:39 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.37)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 09:49:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzGyVJhX8epfQgAVsuHtKPe35NYUp5v/0Yc/21tMZ5rtA9Cf9I6+7n7Ic58sujxwVzF0uA6RYW1I5VImOEe15OIqPeZvqWpiKrmGzDpvrrrvI/PU1tuCdQlyRKlFz/wBipMJFlehQ4EGUe1CE6nN/9UnbzG6Av50/aKnE1W+eVdaaJX0tQ7X2ZpZudvsnd2Zd++AnKiJHDDDHuUil7T+ZHEHUgl6Rbpm3rsZMIVNx+XHROY687KXW2YVvw4n39D9FXegJZth7tUFosgkO4EXSMlOYXigpDLW1T8akJqlq1NfjsaBuibsPTH1cx0J+jfeRiMRjhJgfiM2096KIvS2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U7Rjoa17vLFD4dxJ3H4HvOxaJVmqMRfkQGJu0+19UI=;
 b=gGHQsaFRIQiwHHkbSVBuOtEUlTfeACol/YFc8PHtHe20wXZXcrybc14wTeo2LEKBYuhCUybqFlaL0SmGuhJEkJuwkl2krMpvQt322kRg+Wc2vep3ZV6n+47ayscUA2yKbXXrtilwfRVoXHFwjZqfD6c+thIaThF2GCg833QfodZEiDnEtFrMoDZQrz3Hy30rpf4/ohdxLNYFbahfN5N1zNx6LCBIyd8Lnxdk+zJd1YhHBSyqI9f89+e7RSRa15tfOcCujdgxh9QRyARm7Jn3XRt/aaoh6qP5LZ4Pme1qwm0R3EpApnBz19oAJvaS+m4lC7d0Z1yghvv33Wt8gTkR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by PH8PR11MB6729.namprd11.prod.outlook.com (2603:10b6:510:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 17:49:30 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 17:49:30 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, "Wochtman, Natalia"
	<natalia.wochtman@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Czurylo,
 Krzysztof" <krzysztof.czurylo@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 01/15] virtchnl: create
 'include/linux/intel' and move necessary header files
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 01/15] virtchnl: create
 'include/linux/intel' and move necessary header files
Thread-Index: AQHcV8kGWRlKP/yRUU6aQZTp2FpGa7WSs5qg
Date: Tue, 24 Feb 2026 17:49:30 +0000
Message-ID: <SJ1PR11MB629759DE8E81FA48568ED7269B74A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251117134912.18566-1-larysa.zaremba@intel.com>
 <20251117134912.18566-2-larysa.zaremba@intel.com>
In-Reply-To: <20251117134912.18566-2-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|PH8PR11MB6729:EE_
x-ms-office365-filtering-correlation-id: 3e97db68-e5de-4641-aeff-08de73cd0fc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?4E+RIJ3qPaImuHEgWHVNvjJtPT/pfb9eqUPs1z17YcmXVmq7090sNndNJYUX?=
 =?us-ascii?Q?xZGmhtbW99CGxx9Jk4UoVGvFbiu3r1hos/1/xJ1NlAy/BSg5Rso58Aq2clDk?=
 =?us-ascii?Q?xjvplWA4BP0b9GMu++SOR49djVxQoKVKSLUMVO8bhk8mBFu7ROHRIhULWNtQ?=
 =?us-ascii?Q?cIs/ar3dKufso/6LqSvbXAKPMCVHm3ic+Bi8sZEc2DcqX0Ge/UZp5JEtPsL2?=
 =?us-ascii?Q?usuT9nPN8ufVEtJ6586eeLWkd1A1J+sLUXWxURSww+FnyFlhVfUCAtJOwwEU?=
 =?us-ascii?Q?ysLpSjeh5YyGb18O/nKgD6Cud9yf79KiVdNTXRd472+OwOUrT4qtIrqec/w9?=
 =?us-ascii?Q?ax3dT2SGE2mpQUv6O2wP7NRt4NrnZgMvQurUwm+nHuR8e71677WcXbP2GbLz?=
 =?us-ascii?Q?mS0ms2+9wlpArA6fwx7f4hPvkd6DVEdu+Rr9Dm6vsswtmfs2uj8k7slG/RC3?=
 =?us-ascii?Q?olKYarGauDSTEx9CgiXjYzs1HGoFQNBFx09tk+UFlR1sfMN85lVLSlfnB1fU?=
 =?us-ascii?Q?gG4HXttG4wWkCmG8MMzfsNY9pU8LBieSBD0dHLBO4InleStBwhV/JKuYaD9c?=
 =?us-ascii?Q?X7rCq/2K5LUBxIGm/R6n5HkNODcyA6KwKrDcpTjguC3lWeZJ8HlUU+zAUteU?=
 =?us-ascii?Q?6ePQz0FLcsW1fidMdOnRomJIk++44epyVLssq6i2On16QXoJxQq/iTeE2gES?=
 =?us-ascii?Q?XKXmBfTZCjA0vfmALfbJYHn0Ew0jAnth1rudJFcYyGnsvGpPB+S5f8vNVdtW?=
 =?us-ascii?Q?bxiDNqo1DLXMDg8SuGpreN/8uHHW+qo9YVse+YivC7y+++tulAmc5QR4y7zN?=
 =?us-ascii?Q?1WxUCtiRkb8GBT8Zet0UINLx5+MTdicKujqVZXasHvlL3mxTH41ykSvGe1j/?=
 =?us-ascii?Q?NdTJVLtymFHqv8C7QZpLhiIwibMTkkr+lPLuRmgNWvTgmoSd0xEt94fEeAW5?=
 =?us-ascii?Q?YsS55sRDcU7xWtGWLUfyFyy1NI71EvqYfhcqLwKzrHUY4rKUubFM7SQHlgda?=
 =?us-ascii?Q?N6xRt4PWMFxZsAkYYdDQV8U+bZQ5x0/DdRuU6wsBtRSWr3+ihR4KEcXIjmIQ?=
 =?us-ascii?Q?ILB4k3gUVkIu0tdIIlDLgtq1KJDcmVl52yGWNnkiACgmiIRdKHpd6JjDSGLl?=
 =?us-ascii?Q?jAknWnBIPGeNhsypEugftawWC6JO0LbDxLhasLQqJ4QWXQknyCqrOS/E1w6p?=
 =?us-ascii?Q?v8hHoAw1AOiIdz+PYgmLnml7CS5Orfeki3Y5aqM0nBzJnAUK2BHcAIjRVmNq?=
 =?us-ascii?Q?MuG+FbIcD3OhKA5Y1YBLWxGh5wBGdN2KkeojbBPrt3i79lGQDiEkORnOcB3o?=
 =?us-ascii?Q?8j+HgZZKARnDpAMA4yBHppgvpOHhnweN8e42gV2P3fjXCjfOvBKfjwahvGmE?=
 =?us-ascii?Q?AfMFvvFZy/0VE26M979pj2BDaDWeaTkKQaufXcQI/Jf2oc0OYJ+ZjBdEC5D9?=
 =?us-ascii?Q?LgiUBprb8NBzf8SanQhPcpsnaSkHSMIK5iuMtLvusXWpvX2PkjxVXVNDsWvm?=
 =?us-ascii?Q?lLWUzn12JA6Ay88wMncpq5hUNuBsCbCjW4+8Mw1GYFBOxKL1qOQe8AucOZQZ?=
 =?us-ascii?Q?G3/X9NZ5jOyA3XF8SzY7xcS7q/KzdhH9QYnvRcGuYi2dqwBIazYOyKw10a1w?=
 =?us-ascii?Q?KYu9dG97aKJ4b/OBm5EhyN0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uk9OEsXYAk6H7o0SQKAmv6rdeuo85JnOsisr42MqRCY8biChmWVJKzLmtL3v?=
 =?us-ascii?Q?ke4CWq5H1mbA7qfusCcW//j493KYXczEWUxquN7Sqf9skBaylSFBjY+QQ/yA?=
 =?us-ascii?Q?u+ah82GYUT0GEic8XkhHMAZOnIEjqngQD6+k0ZSSE3ImPFC2XLGw9ZtsRfWQ?=
 =?us-ascii?Q?HLLN0KdYP6NEmSJU3oQ7zTJJjEOSATFQl/J0FN6kW/o9ghwtweky1qJCTzfO?=
 =?us-ascii?Q?7WAFhGyD7L+X4WYrAD3VGM1iJUotPyS0t48mdtVNl2RZfmM7bEATnYz7TwC0?=
 =?us-ascii?Q?FBGq1l+/BLJL/9d8l1FWXmK49blFgzJdeK+9bsdQwFbaYycAKAetV9S4c5eN?=
 =?us-ascii?Q?vLwoebHzVMM/XlHI9qqBcimDS80ZnsuTMEvTxDG4RY29W3vFepO0enYbFxj5?=
 =?us-ascii?Q?fCgKqWB9ViuO31qy2csRm2BFW3K4q0vgNALCR3ug/w6pT/oF6+RpVN96To5B?=
 =?us-ascii?Q?Wl8ZR3XVns49EcMDmdccu9q2WG8CQhDQnrBXi0a2we4eZl4qoFLgLNDV5Wix?=
 =?us-ascii?Q?0Gg6hFBzCdaZ9/ETB87l5TsxCHkgGQObENGoVKaF4JikD1uRZJ7v0sG/youn?=
 =?us-ascii?Q?1N/ZSyzFXiNeQQbZGZnjqUxrmsUK3+IQx/W+8vpiu0hldLlLQWjyH5RL/RlV?=
 =?us-ascii?Q?8aMe1R1XW3eHJ7yqq4T6bIwAty6BzclPuEV07ILP9conW/k0R+F9drUBVKmw?=
 =?us-ascii?Q?jcFnIIiy3/Er1OG3f9Q69KabI85jLJUSMsM6exbFMyIQL+HoEwIvGuBJrVti?=
 =?us-ascii?Q?W0fmb7KbfhVtsqGJfcaP9ZdVzmWAYL4uXws9+OHLqZ8TpaIPAZ0bdh6I8XIS?=
 =?us-ascii?Q?VSEp8VlRe1InLWgAAMRT8hYzX7oZXh4Xtf54g5byBxpTNlWYX4QKwtK0jwSc?=
 =?us-ascii?Q?SMMEg00isj9S14oEAu0N3eBul/K4aaOYZn+w5y85VovDdTsZVE3p7spl+5np?=
 =?us-ascii?Q?jOBcyYrANpHuXE5Wopaeb/wnauTVzLBbliogn3SbH8kA+IxEYJYCGzHC7ZJi?=
 =?us-ascii?Q?okErYLcTj+EefRmApmI4PnwkwbqkX9c0Sbjq83NqnAbNlV67/GRCad5PIWZy?=
 =?us-ascii?Q?mXSC06BQzL6O9eSTULvWtIk7ZXb6cRdjBdebQmSJe2RYYNgpxktdY5Vu1J+n?=
 =?us-ascii?Q?kqLdy2pZAaOqP+hrnBi6OL+UIWKdP5YffK7o4uO/OyGkU3W5a6GDEU2U7jEN?=
 =?us-ascii?Q?uiQmek/7FVQBvOWGJv2cLi2Pskf/zLuQ//6V8YuA1zBkU3Lk/4qSkY2e+dfs?=
 =?us-ascii?Q?M+zHAR6+ifVMYxRLi5U401EleRJOxQZM4Yeq9dkagUz74w4sznlsiWdT9pQD?=
 =?us-ascii?Q?Zg5GSg62wdf9Mr/zOyKSDqnaSNX4EBzYQRvUfq5uKN70fUV5hOpTad19a2jx?=
 =?us-ascii?Q?SIjy2rQntQ0W5hueFuLRvWY4entgt5DuoLmh77CVha9RWzDT1E6taKr55ASQ?=
 =?us-ascii?Q?41RfruoWfLTA+4/o1YSHNvDj/qhiR4tGdw1FHDdSUPC6/sPlLf752EYezkqk?=
 =?us-ascii?Q?MlCJ3FpDxsNJ4x2FZKMKnFoHYW/c/tuBX9RcMfnFyB3g6lkBQ6Vvc9oJOl5b?=
 =?us-ascii?Q?4uOBFx4BJfkM8Y2es6yV9UqjqbW5QUxoMXFB93ery0pc7SWKImVWviS4Iaqr?=
 =?us-ascii?Q?RkpmsfS/vRzEArJCGvQQda24xDBuFshpyLPNrAtuYC4eDXnycGV5cNvscOsj?=
 =?us-ascii?Q?s8/yYD/Fylws2MYvyV/IO8BuVkM78U9e4L6bVJpJHqDjREveun1eM73w2g9n?=
 =?us-ascii?Q?SjZEb4Ge8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e97db68-e5de-4641-aeff-08de73cd0fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 17:49:30.3394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /v+CuGxjzcvt6+v6KsJQLIf1ColfEFnp3rSIXTYeH6NbuMX9Ny3Bw7+jeOSuXmNMghQnvv3Hao5ojlJDYQ/rWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6729
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260619-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.salin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8345818AC46
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Larysa Zaremba
> Sent: Monday, November 17, 2025 5:49 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala, Sridha=
r
> <sridhar.samudrala@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S <emil.s.tantilov@intel.c=
om>;
> Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Shanmugam, Jayaprakash <jayaprakash.shanmugam@intel.com>;
> Wochtman, Natalia <natalia.wochtman@intel.com>; Jiri Pirko
> <jiri@resnulli.us>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Czurylo, Krzysztof
> <krzysztof.czurylo@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 01/15] virtchnl: create
> 'include/linux/intel' and move necessary header files
>=20
> From: Victor Raj <victor.raj@intel.com>
>=20
> include/linux/net houses a single folder "intel", meanwhile include/linux=
/intel
> is vacant. On top of that, it would be useful to place all iavf headers t=
ogether
> with other intel networking headers.
>=20
> Move abovementioned intel header files into new folder include/linux/inte=
l.
> Also, assign new folder to both intel and general networking maintainers.
>=20
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---

Tested-by: Samuel Salin <Samuel.salin@intel.com>

