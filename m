Return-Path: <netdev+bounces-234636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C38C24DB2
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 828E34F369A
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8C332909;
	Fri, 31 Oct 2025 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUoXLZmt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08710343D9B;
	Fri, 31 Oct 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911494; cv=fail; b=WBu5P77Tb082XfMiHDLENLVy6kEnljeFA8SpYlPtCtqcGy2f00RHbLVd8ognPd4y/Pd8lI9w976y2ACO8voSiKYcM7GMSRCTny70SjNxU2e+n0eX4BZGwcyrqDU6G9BlO5hksDFyE8VFcohZ2wsQRObkLhG5Ysphr9QRfVYv40k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911494; c=relaxed/simple;
	bh=n2WumxR6zLDuF7Gp+6zF6RTt8/P3Ic1bpeh5EcAcuWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxQeR5lI7cfCOlq34KD/tq2ErYA+icS4eRglKFyuMU28wJsCvyCW0aCLSZU6DiQ+rwStTniO3/cFxZAghYmhBc/UY2MO0zIkb6d7ya9HSsl5fJv8s7aifZMSXyJ9pkiYVfOl2/V/iWhqAAfbXP3MBlWMRxyWy7WHURqUvpzTzWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUoXLZmt; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761911492; x=1793447492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n2WumxR6zLDuF7Gp+6zF6RTt8/P3Ic1bpeh5EcAcuWM=;
  b=WUoXLZmtz0nbTwTu4BCqADb/KNGMaeh0R0lbEdvbbDNkzGi14yjRnwY8
   63gBwuqN9D2hCglnCSNfVL9ALnmNnw+kc0oIfHmm9opYyTPKmqYyL+vYO
   2LAtm7YcY+mJd5z6bwa0nJh8GMbfW2RzBieYrPnK6Fk2deW3v9B4s6DM9
   Tx+YtvUv3ckto09yfeVyAw9tjNbR6+7P0BPDi0JRbvvWVAlAIZEmXOcHa
   ITxlKUaf8UxVoWE9mgRt10SaycD3ar1OqJkZq6b6JEkZBblBxgaRCMsIr
   C78ceL2r8+oJSH8rmUTsYRZql4GDs7SQJ/nALVaOPbmb+dO+u0BiPB5Uz
   g==;
X-CSE-ConnectionGUID: jzQ2nPmJQoa9ifWjOLNNkw==
X-CSE-MsgGUID: T+v4SVFpR+y9F9qsy1DS2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63767304"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="63767304"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 04:51:31 -0700
X-CSE-ConnectionGUID: tVgyIUuWTcuQ7WRunIZthw==
X-CSE-MsgGUID: 7KSWIwuYQ/20nJ7wCX7VLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185491179"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 04:51:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 04:51:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 04:51:31 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 04:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crJ9F7txDZDVeX2IT7kM+32l4aT13ZF51OOy17MMBQBMHfavhz4MQPX2pANCCrgSErTX/wS1FFUlRx6KO5E1WktAvBYd2/7j80XFn4FMgsag5q80sjrdImVJZnOJ0qM1MmvR0KYWOqvvZnkqxrDCoPkntYN85F99sWhemE8DocU9AY1ar4tp9WOi+jPctiNyQ4v83Ef6f0V/LCsbdWazBZtr0D4NVeH4jqhpr+pDX2jWreQiSg6tRHZI82hxLSJ3mtwugeOWr1Qawa65M59G7+cuIo8Rl50VlWnS09R/X3GYE3ise7gYYtXVkKVyJ8Rvo49l3pTu0GU93awm3CB7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/AkUgcGV9QDQtjQh28lsSac8ofhx360lUR55L7oLk0=;
 b=tN/qhIJJCMTO64JwK3d6zoAGy0Ll8oWl66VbQG42YkiFh/ZG7xpWES35XWHX/Ek9nNgTEEuiOvEbgy1O3sRLyxAn8Civ9X13LOFW3pJskUCTuxnnD0JeQTrbNwtP+96dj6H/urTPC/UkaGeYPNJ52M4WAwUwNX07j9Escol8GnSJYzGCKfZQrdCF35xaRRCRLiigya29uJLX4G3zcjJ2AE9Uis3Ex5ufr6J7zksmutMNoV6enZNpid+oINWFhQ8CG8HfKrOM11LsD3s55QXGvWjrx1At8MKXTQrY80gKV4leKV8ufrjsTytKyJJrwt4oUngBnUzgVKwbqHKZSCKNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by DS0PR11MB7651.namprd11.prod.outlook.com (2603:10b6:8:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 11:51:28 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::f110:9a4f:b4cb:2eeb]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::f110:9a4f:b4cb:2eeb%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 11:51:28 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Schmidt, Michal" <mschmidt@redhat.com>, "Oros, Petr" <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	<donald.hunter@gmail.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/2] dpll: add phase-adjust-gran pin attribute
Thread-Topic: [PATCH net-next v2 1/2] dpll: add phase-adjust-gran pin
 attribute
Thread-Index: AQHcSOlDv1iZzscYA06G8ARudBg3VbTcJmrQ
Date: Fri, 31 Oct 2025 11:51:28 +0000
Message-ID: <LV4PR11MB9491743B4984EBA5B192E0449BF8A@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <20251029153207.178448-1-ivecera@redhat.com>
 <20251029153207.178448-2-ivecera@redhat.com>
In-Reply-To: <20251029153207.178448-2-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|DS0PR11MB7651:EE_
x-ms-office365-filtering-correlation-id: 7562d081-6842-4792-140d-08de1873d380
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?KMjBkGudRzhWUKRXJUyHimibSBVywntbCpwXZFV0a3+5NDhe2xxoBZPtQMw8?=
 =?us-ascii?Q?aLcsWj3wxx/K9luRkWF/sNqSw5ljLL0lf3rDoUyk/dmx93uNyeeAwuyipkCX?=
 =?us-ascii?Q?c8/t8iMM+va6RE+PkmOcDuRztl7WMR7LI16w1MMp6n9skTB2X32kRjXucwyo?=
 =?us-ascii?Q?0ZonxBruUn6NkWlTmEDfFYXWrqHw06Qmd1zdhHeKYpTT0IvbiTZVXLT65+Tb?=
 =?us-ascii?Q?XWsvCtImXy6NEgDEM8SOZJoZE6K/lNCU8PMLW+Orc3u6GeqHWKIkyegrt1jR?=
 =?us-ascii?Q?F00PCTGiiW4OkUY8v/l2aZrdWU32TCMJ/b49cSI9LXH2E0o8u35kAtwFYZL9?=
 =?us-ascii?Q?CVjbuCHgkxqvVy4l3jHBTL9yz1qnX3c5xmP6SjH5Dbho2dPtv6HYkHyXqPij?=
 =?us-ascii?Q?bi0nq3AlsTZWIhpMt6uLMBHRVOBSlIwk3evBAeu2Q5F9oC9L10Mgk8bEZeaL?=
 =?us-ascii?Q?hNEzHIZ/N+OdKgM8hIr762dOsacvHi65EsQR4dfmPBiR6LzsMI/fXrTmC9VM?=
 =?us-ascii?Q?yV8K0NJgrlyPBFTpeiNSZfyE2mV3VSfZf7dj0TK0bHUgqPzKH+ZxLZvTQWzF?=
 =?us-ascii?Q?P6Nvow1uYm7ElSqj8HV/aQB5An6vo1+/O62KnlwJx3PkgIQGbzme01TfBmRU?=
 =?us-ascii?Q?akRTdfVF6EhkwCK+PXAtzehd76fiFHDdJVG1tTaO8AFu6CKuab1JtPNV5Pzz?=
 =?us-ascii?Q?/DjsAOENr6VgcR/Gm/l5ZAr1b9Ppu8xox0KF34gLud/DPAk4PEllBktjPW3y?=
 =?us-ascii?Q?OUMz3T4p+M3NomJ63F0iqBNExmUXFrRnZTaO6q4Bbjh/Ld2KkEVa73eja+tY?=
 =?us-ascii?Q?E+CMhY7bJ+zsOFjXxjzNQce9o/w7XW8aTJxZa48XJR7xzlR3ZbW9sqaGazjW?=
 =?us-ascii?Q?xS23u/qAq1adswfN7lS3BRu/D2+qrHsQwoN6olxp+CaZfZnEh5rjokwQojwv?=
 =?us-ascii?Q?WO8/00s2pX3fBtJihkQQsQkeDGVgL+EhdGY9rPtdAJ5EUPSdLSeELhAGnQmJ?=
 =?us-ascii?Q?dqEjWQTrau0rGGM/8NNbNZmlw8sQUmIDuB2O3ThoTlBMV85AbRa6vjUfQBOR?=
 =?us-ascii?Q?YNRD1GVNHgfCBkm7Po3KQkD5SIvb0SleMIGwP+6ajiFVF5AR4X6bRJbZV1/F?=
 =?us-ascii?Q?1Sl5osqDNC0el7ruN5YUsoCY2QUX8s3oz/u/OmtXkmwsHAJ0gcaEMq/vArK+?=
 =?us-ascii?Q?MJnsQ7aLDaiCrGiuvXdTUzPuTqrw2ULmKG/TDw8K0D7IADgDpg4jMqf2QMi1?=
 =?us-ascii?Q?HtjPAaxyjYeMGArR2S5nhxGeDLH6HAl4Wfysd+QfaPITqiSStBcOajE5MYD6?=
 =?us-ascii?Q?NyISkogE7FTaqksvbybSS0WKIszwr1VJmr11XYhbR9cxQelYSKeauDwweNRX?=
 =?us-ascii?Q?CvON5r1M1TrlLuk/BWV6jAlGrU6dq+K3CuGnQVPNhwGzCaj1aJV03asgkL4C?=
 =?us-ascii?Q?tasSpxB3LhPukt6Wrzshi+bmo2JNG1+nyMOyEWe7vY2jRjDeX2/tFLAXqYAZ?=
 =?us-ascii?Q?QvIRgUxySywecU90qTatM3dVR5SZe/gy3De9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WeiYF8U1If7vPXIeTfWC5CY+m+G7bOckDBDyvkOXu4Q/M2hWG4IRC+FwMhMi?=
 =?us-ascii?Q?9fgISRpu9vZF+Aoeu46hDAOoIw3+ui6H8+cEvCETcPBH4nD2bMDGvyMYUoPS?=
 =?us-ascii?Q?fdfXpi1DZhG7zYjrjGxLAP497xiCz19xPv8tMGgfNS7M7D9egJn6cjI87/Iy?=
 =?us-ascii?Q?cZ0TnANW8+eOXYnAhGOX4Bje3RTzHneANY0lrhLautftQmcpHapn48AWyedC?=
 =?us-ascii?Q?bb1whpusB1veSlprDl4pj+cbwota1dysy5HVrmbg7pbqyKH/LOe05i5aJIDR?=
 =?us-ascii?Q?t01y2BBQkXHMrmZxJYxJxEjWZczVvf6MdKoa381ZTFumpAEKYbC84EwjujUN?=
 =?us-ascii?Q?2sJ579iot//A9LM8yiX3R27Z+sin6zkStZdwZVaSsDLx9CrJNeuUJRdxt4Q9?=
 =?us-ascii?Q?ifxG/BxLZiVB7OA8tO+slpiuaX6H+AUQaVvdpnSJkYqNaah+h+PlNopBYBAC?=
 =?us-ascii?Q?7pRNKT5bKuAf8fkvgAzRN7W6OaxuS+Lj4wPY0z6v7hyAoz16oBEo4Vm7b2tH?=
 =?us-ascii?Q?9GiaqcrFo+6kxEhXPAgM1FcA1bKlNt4IoAa6oDkQ9uEFxt4vroE8GkMFWMPT?=
 =?us-ascii?Q?WSBk0NmV1FKrLbInv7NczHEnWixA22+H+Q2jp2r8CgyflInvPKxHznoeo6WQ?=
 =?us-ascii?Q?zTmPZjiC36F/3yejj+Arpu9RGfVYmBn2bJZCgeu6ZUyCiDB3qrQXdiKTAxjc?=
 =?us-ascii?Q?RtA0e40/WNh4cdGvDLgvu9CzDmKwNA/wll+dgLBC1ftHHpceXAZ0kJyt+h7/?=
 =?us-ascii?Q?KMwWpLWxZT7i+Po0ZloBgK/aTlrvmEdHajpYs0biborseNdFZpVsKB0fVroO?=
 =?us-ascii?Q?uGfrtoAWruk2Knh+r/rQvp52wwu/fcIRsCBma02WywhQXkV5rUQmRoGWEFGK?=
 =?us-ascii?Q?8dV1FuDveSCv9GCqhhRxmf7wUxGsBMvNPwKUd1WE3zx40aGpB9g0CnYc5dch?=
 =?us-ascii?Q?uH+alaUdY2ww3DTnPBxVHFHcvOb6LXdiuRhEsirSRpzGzouSGu50QP2y5Htk?=
 =?us-ascii?Q?Hfnpzu1QRyvugTeYpLWpX+nTA9BsBcaKFey1zMzwz9F1Tdq9YTqWpseh9f2y?=
 =?us-ascii?Q?DB/VNtAEd0GkOAwKYajp66xcNpTRqvhQ23OkmDC6sIGVIgq+sRzZpgCkocBJ?=
 =?us-ascii?Q?VRLOGNAYJpNVgoB6PFWdtH0SwBRGMTd9s3q7coqrjdoSIPVo6xuqPlB3/THo?=
 =?us-ascii?Q?MLdeyc9IWQkk5Mzyl+u/+SKOknjd9mpvb2dLnWD1jJ2OnvepvJYWisoH3eAs?=
 =?us-ascii?Q?rks1EuVwbFfaVsF7BNvhu3XxgyvDcPhIOqnwFaAN+wgemYrxTSj/Sya7/0Cu?=
 =?us-ascii?Q?NF5IUq1uEHjfNuYeh3KE3mpbhBodNqKukIr/gC7ZsFxaECOLOou0SEBVO8u0?=
 =?us-ascii?Q?NWhSqxZ7Mpb90KhFjpeTV6+GQZIERP/AqrPYmATXkyhX1bdBmwje6CcY/Uhg?=
 =?us-ascii?Q?L8EaklcNaBMl6GEBiuxvQnwatTC1t88YFaSHqTitglIuAIGQEkRkBqDfKdbj?=
 =?us-ascii?Q?cG7dbTSWuFa+Os9LSgQK8Quc2S97Axb51RQ/rwlFEOKD2BeK7sY456yEtNxp?=
 =?us-ascii?Q?mAKa2asgNUloLQfTp8TMsvh5HDGZrdq65NirSJfnZnAEEp0KuxMXZwtaBPzt?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7562d081-6842-4792-140d-08de1873d380
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 11:51:28.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8INt2ZIiiEB6TBhnqhqHOliZssFKdmxKZXtK+dAdENUNsIr79w7tJkkVPYO2ScFRGL8NFhQDDRRl4W3YWqCF8LgymPCVi8NI8Tog2cvDl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7651
X-OriginatorOrg: intel.com

>From: Ivan Vecera <ivecera@redhat.com>
>Sent: Wednesday, October 29, 2025 4:32 PM
>
>Phase-adjust values are currently limited by a min-max range. Some
>hardware requires, for certain pin types, that values be multiples of
>a specific granularity, as in the zl3073x driver.
>
>Add a `phase-adjust-gran` pin attribute and an appropriate field in
>dpll_pin_properties. If set by the driver, use its value to validate
>user-provided phase-adjust values.
>
>Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>Reviewed-by: Petr Oros <poros@redhat.com>

LGTM, Thank you!
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
>v2:
>* changed type to u32 and added explicit cast to s32 during remainder
>  computation (per Jiri's request)
>---
> Documentation/driver-api/dpll.rst     | 36 +++++++++++++++------------
> Documentation/netlink/specs/dpll.yaml |  7 ++++++
> drivers/dpll/dpll_netlink.c           | 12 ++++++++-
> include/linux/dpll.h                  |  1 +
> include/uapi/linux/dpll.h             |  1 +
> 5 files changed, 40 insertions(+), 17 deletions(-)
>
>diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-
>api/dpll.rst
>index be1fc643b645e..83118c728ed90 100644
>--- a/Documentation/driver-api/dpll.rst
>+++ b/Documentation/driver-api/dpll.rst
>@@ -198,26 +198,28 @@ be requested with the same attribute with
>``DPLL_CMD_DEVICE_SET`` command.
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Device may also provide ability to adjust a signal phase on a pin.
>-If pin phase adjustment is supported, minimal and maximal values that pin
>-handle shall be provide to the user on ``DPLL_CMD_PIN_GET`` respond
>-with ``DPLL_A_PIN_PHASE_ADJUST_MIN`` and ``DPLL_A_PIN_PHASE_ADJUST_MAX``
>+If pin phase adjustment is supported, minimal and maximal values and
>+granularity that pin handle shall be provided to the user on
>+``DPLL_CMD_PIN_GET`` respond with ``DPLL_A_PIN_PHASE_ADJUST_MIN``,
>+``DPLL_A_PIN_PHASE_ADJUST_MAX`` and ``DPLL_A_PIN_PHASE_ADJUST_GRAN``
> attributes. Configured phase adjust value is provided with
> ``DPLL_A_PIN_PHASE_ADJUST`` attribute of a pin, and value change can be
> requested with the same attribute with ``DPLL_CMD_PIN_SET`` command.
>
>-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>-  ``DPLL_A_PIN_ID``               configured pin id
>-  ``DPLL_A_PIN_PHASE_ADJUST_MIN`` attr minimum value of phase adjustment
>-  ``DPLL_A_PIN_PHASE_ADJUST_MAX`` attr maximum value of phase adjustment
>-  ``DPLL_A_PIN_PHASE_ADJUST``     attr configured value of phase
>-                                  adjustment on parent dpll device
>-  ``DPLL_A_PIN_PARENT_DEVICE``    nested attribute for requesting
>-                                  configuration on given parent dpll
>-                                  device
>-    ``DPLL_A_PIN_PARENT_ID``      parent dpll device id
>-    ``DPLL_A_PIN_PHASE_OFFSET``   attr measured phase difference
>-                                  between a pin and parent dpll device
>-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+  ``DPLL_A_PIN_ID``                configured pin id
>+  ``DPLL_A_PIN_PHASE_ADJUST_GRAN`` attr granularity of phase adjustment
>value
>+  ``DPLL_A_PIN_PHASE_ADJUST_MIN``  attr minimum value of phase adjustment
>+  ``DPLL_A_PIN_PHASE_ADJUST_MAX``  attr maximum value of phase adjustment
>+  ``DPLL_A_PIN_PHASE_ADJUST``      attr configured value of phase
>+                                   adjustment on parent dpll device
>+  ``DPLL_A_PIN_PARENT_DEVICE``     nested attribute for requesting
>+                                   configuration on given parent dpll
>+                                   device
>+    ``DPLL_A_PIN_PARENT_ID``       parent dpll device id
>+    ``DPLL_A_PIN_PHASE_OFFSET``    attr measured phase difference
>+                                   between a pin and parent dpll device
>+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> All phase related values are provided in pico seconds, which represents
> time difference between signals phase. The negative value means that
>@@ -384,6 +386,8 @@ according to attribute purpose.
>                                        frequencies
>       ``DPLL_A_PIN_ANY_FREQUENCY_MIN`` attr minimum value of frequency
>       ``DPLL_A_PIN_ANY_FREQUENCY_MAX`` attr maximum value of frequency
>+    ``DPLL_A_PIN_PHASE_ADJUST_GRAN``   attr granularity of phase
>+                                       adjustment value
>     ``DPLL_A_PIN_PHASE_ADJUST_MIN``    attr minimum value of phase
>                                        adjustment
>     ``DPLL_A_PIN_PHASE_ADJUST_MAX``    attr maximum value of phase
>diff --git a/Documentation/netlink/specs/dpll.yaml
>b/Documentation/netlink/specs/dpll.yaml
>index cafb4ec20447e..4e5f0b7c41492 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -440,6 +440,12 @@ attribute-sets:
>         doc: |
>           Capable pin provides list of pins that can be bound to create a
>           reference-sync pin pair.
>+      -
>+        name: phase-adjust-gran
>+        type: u32
>+        doc: |
>+          Granularity of phase adjustment, in picoseconds. The value of
>+          phase adjustment must be a multiple of this granularity.
>
>   -
>     name: pin-parent-device
>@@ -614,6 +620,7 @@ operations:
>             - capabilities
>             - parent-device
>             - parent-pin
>+            - phase-adjust-gran
>             - phase-adjust-min
>             - phase-adjust-max
>             - phase-adjust
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 74c1f0ca95f24..017999beccba8 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -637,6 +637,10 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct
>dpll_pin *pin,
> 	ret =3D dpll_msg_add_pin_freq(msg, pin, ref, extack);
> 	if (ret)
> 		return ret;
>+	if (prop->phase_gran &&
>+	    nla_put_u32(msg, DPLL_A_PIN_PHASE_ADJUST_GRAN,
>+			prop->phase_gran))
>+		return -EMSGSIZE;
> 	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST_MIN,
> 			prop->phase_range.min))
> 		return -EMSGSIZE;
>@@ -1261,7 +1265,13 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct
>nlattr *phase_adj_attr,
> 	if (phase_adj > pin->prop.phase_range.max ||
> 	    phase_adj < pin->prop.phase_range.min) {
> 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
>-				    "phase adjust value not supported");
>+				    "phase adjust value of out range");
>+		return -EINVAL;
>+	}
>+	if (pin->prop.phase_gran && phase_adj % (s32)pin->prop.phase_gran) {
>+		NL_SET_ERR_MSG_ATTR_FMT(extack, phase_adj_attr,
>+					"phase adjust value not multiple of %u",
>+					pin->prop.phase_gran);
> 		return -EINVAL;
> 	}
>
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index 25be745bf41f1..562f520b23c27 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -163,6 +163,7 @@ struct dpll_pin_properties {
> 	u32 freq_supported_num;
> 	struct dpll_pin_frequency *freq_supported;
> 	struct dpll_pin_phase_adjust_range phase_range;
>+	u32 phase_gran;
> };
>
> #if IS_ENABLED(CONFIG_DPLL)
>diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
>index ab1725a954d74..69d35570ac4f1 100644
>--- a/include/uapi/linux/dpll.h
>+++ b/include/uapi/linux/dpll.h
>@@ -251,6 +251,7 @@ enum dpll_a_pin {
> 	DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED,
> 	DPLL_A_PIN_ESYNC_PULSE,
> 	DPLL_A_PIN_REFERENCE_SYNC,
>+	DPLL_A_PIN_PHASE_ADJUST_GRAN,
>
> 	__DPLL_A_PIN_MAX,
> 	DPLL_A_PIN_MAX =3D (__DPLL_A_PIN_MAX - 1)
>--
>2.51.0

