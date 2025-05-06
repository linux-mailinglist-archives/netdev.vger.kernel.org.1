Return-Path: <netdev+bounces-188374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ABEAAC8AB
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C3627A894D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68982283C90;
	Tue,  6 May 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrHNmjx8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263B28315A
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543086; cv=fail; b=n23jttZowD7Oh8LdwoI+ij1o9IOd7I+tYZMt3mMR+lXh/6uBcduIdf/NerU8vA4ax7T31rI8kuNoJ7mjCkpq/awU5Zan1EEDGGeqEuRBtKZmwnGyl0DkmP6BrXSBA2MKNJEqPpigo4pD4OQZjthKhyEGl+PWUorc7RzfYYq0OmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543086; c=relaxed/simple;
	bh=IAR625NTb4UHTxpCXn5UaJ51WAR5zobgKJGHdvduHSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a2fMcUDaHRBB4alELBbdUnMJH2ekfAtCnvKZdxVXtRTwHIABfkz5mh+gb7q+IAwJv20RqM21ZkFdH+68d1EbTmhY3UNJFdn2qsKC3x/dsVEefrJQqscUmVqEKaFb0XzAP6rTxiKQq0sqEvq4qoKHngsHFGqXqdW2NuEwCFcgFlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrHNmjx8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746543084; x=1778079084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IAR625NTb4UHTxpCXn5UaJ51WAR5zobgKJGHdvduHSE=;
  b=WrHNmjx8afHS96l4O7YzwnDM6/fvjat4Ipy+1yrldJQHkUt/f9m0GQ7V
   SlxZVAEtIahoVwcuh+xkMem1WG2fVuHGtKBn/2Fv0T6N1Ve5h1Ylj2waQ
   R6OQ4FQqMBQ+N5DjkA83enbt2RwPXjgArJSNicbpuG2aTeSC76PTWr9AV
   miZMDeFlszZFUy/YdNKtXArpapiwNDWyizQtuYP8RcXJP808nKJ0MX4an
   G2qLJQcueNDGmnDGCTTogOnJyyMsQIpMO9M0dsVsc7SwcbdHn358QPg9W
   Y+9rgj0N/gvbXH1vheIGSdJvdJTWn/Az6OLt4eH8qXWYyJHlYffyQQTTO
   g==;
X-CSE-ConnectionGUID: RC63tnMBTmSdQJ+WjF4xAQ==
X-CSE-MsgGUID: hCfZWAuhRWC4x6Pq4cuAUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="50865913"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="50865913"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 07:51:12 -0700
X-CSE-ConnectionGUID: ll0nrZ3sT9uqZiz6gQKOxg==
X-CSE-MsgGUID: 93wEurU4SvmdGsdmuCVeeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="166570855"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 07:51:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 07:51:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 07:51:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 07:51:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbWqMbGx65ev6J99o0krmc9/G3Y2PtlsE2c/cTcHqajCGQ6lH/T6ygndhKXSU5JC6oK/rnSOn/7JUpazrZ7mTL+rOMYJfc7ly3TrJ5QsIihTBIjD9qa/JUPlx0g+lIcFZMEylHlNYFHnHA7M3trcAIZA+8gEyEjB9kfi2Dc/Hj5FGzDrHGvgb0ESl99pDDL6p9D2/d/5Tx0QbQCe3gZsA4QPa8OiPfin1bW7jNvKcvQd0tfhYhBFCjVZHkgQoJ7AHlbpXrqHGD/lSp9tPKEwISZMmCkS0vCNbfpIY2uRvjf3VAglqzA5NNsMn1K0lP4l9wxygNm+97cXwrywdILKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAR625NTb4UHTxpCXn5UaJ51WAR5zobgKJGHdvduHSE=;
 b=BDuphW5C4RoMEbasI2rUBf4S8zvvCpK1OTaKGb4h4tRyVKjrwJzIll6HCQRTJSsAhB0NrTgp2/lG5DkxpEKaLLpyUqZ1lSxgtFeBby2YmVg7/+cvpJN32EyBgJnQv8hOvN3J9sE/2HjJvEYfJIldp4MNkurtO4jTNyuZwGubY6tgqIx/eABw/PvMqZ8uQVp2uNqALTwRV5bJDWPTdPB65uCqu5yjXcelLuKOEoUL2IuLILgQfKwQgpWBs0yMBGeh6HhGeRoREOL3k3MiTziUKZo8ugzZchO/rwlsi4it6r3IW+zyki/yQFptdwFKhMDXHNMKpyfHUnXOmvKX2X7xTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5885.namprd11.prod.outlook.com (2603:10b6:510:134::22)
 by CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:50:37 +0000
Received: from PH7PR11MB5885.namprd11.prod.outlook.com
 ([fe80::b1f3:809e:5b8a:c46e]) by PH7PR11MB5885.namprd11.prod.outlook.com
 ([fe80::b1f3:809e:5b8a:c46e%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 14:50:37 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>
Subject: RE: [PATCH net-next v2 00/11][pull request] idpf: add initial PTP
 support
Thread-Topic: [PATCH net-next v2 00/11][pull request] idpf: add initial PTP
 support
Thread-Index: AQHbtixghtBT1IyYJEugZ4El30KEQbO50eAAgAFgtgCAAAMSgIAJHzlggAAfKoCAAUo1AA==
Date: Tue, 6 May 2025 14:50:36 +0000
Message-ID: <PH7PR11MB588530D6A52A68552C859C298E89A@PH7PR11MB5885.namprd11.prod.outlook.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
	<20250428173906.37441022@kernel.org>
	<17fe4f5a-d9ad-41bc-b43a-71cbdab53eea@intel.com>
	<20250429145229.67ee90ea@kernel.org>
	<MW4PR11MB588916A3C03165E0D21B73528E8E2@MW4PR11MB5889.namprd11.prod.outlook.com>
 <20250505120207.704c945f@kernel.org>
In-Reply-To: <20250505120207.704c945f@kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5885:EE_|CYYPR11MB8432:EE_
x-ms-office365-filtering-correlation-id: e2cdc29b-ac11-4fda-19d7-08dd8cad5cc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xGSChhtq5rY6YtU+iJIhdgjUrfzMMLedNYW+oRcHXiaXq2gxrDMCigg2IvU/?=
 =?us-ascii?Q?IEnFBdKBAtpKegb3NiM/OWrzzp2QhXFJCICrU695G+mh7AEt0mB4zTtyxaow?=
 =?us-ascii?Q?pxSwtjsGGDy+LB2di3NAUtUybN7i9yL7t1Hgr3cyYhP0FnoTsTh703bcjNbg?=
 =?us-ascii?Q?i8S6ieJSRUbOnA/Xe13A2zN/VBTc1ZY/FxzmYnUClSgB1g/cSKpsXc6o6euD?=
 =?us-ascii?Q?kxGBjOZXNrmsMLYqezKuNPHAoqYNWXYUVaoh48/I/XuEXtDysbqyfvoBukYu?=
 =?us-ascii?Q?K1jEBb3PZXcS+HGQslfzWUNFDeVEdl3w+tzLUfsYL6sWrX8sHFzyu5nh86/5?=
 =?us-ascii?Q?58Bylp3XsQI70EJr1ANV5wHASknY3wSr6Lq1P50hgdXcXVv7xWUBM5jaJTy4?=
 =?us-ascii?Q?5hiyl+UzvBZNpHzF02FxRP57CvT+UIiBMiuevFoKUrQ8TnVn93H6gxLkUFeM?=
 =?us-ascii?Q?mnUvIDeZGHNbg0SYTjHyJd7pS8GAH7nb7NJ01lM9VxWwBi7wF/aC6PtyGLm0?=
 =?us-ascii?Q?BXesALdheWXWBcENM1us5km8pf6gWl+kmZ7FjhOgR9hkVX0JL9Gw/1nlg7mM?=
 =?us-ascii?Q?WwuRHcFHaFl5wU/1fTI0bwgq18SxqI78Zz9NH9InC6uoAKzS5AcKtFqc+CS3?=
 =?us-ascii?Q?2NQcIoCaQMkFTqPCiQNOw5Sawm8f4ltdONUkf65lwx53e3UCmSpdPvP3lr+L?=
 =?us-ascii?Q?sqFNu1RvhuFRQdxeucJWhAc9TPiNTANw5Pve9RU1ZzktfIFELvN/bNkFigQG?=
 =?us-ascii?Q?dZIgRyR3vNiyVcdDg/L1IeOIPLh0WrQAtilfS6XYn6Yob9Cr50Eya39yFGbK?=
 =?us-ascii?Q?S/X5SvgLjEulTCrmAq7/mwwGwRxDahVvbmzeD/QtpQHBBCz/IRFWPJ0rU3Zf?=
 =?us-ascii?Q?w3xU+SW3udzBaL87B3amc2JddSI+cs5snu6W7J3ZZdqgux0N7rey2tPtDOvU?=
 =?us-ascii?Q?C4ovEY0IHgxk1hBjE5f8GXBpyzRqjirXpUm8Xr7tUyfWkf/O3Yfcx7OiIGku?=
 =?us-ascii?Q?Ng4eUsXR7FpRG+82lZzAUyL82iHQAHEeaLbjh1D8kIiBUz2NdaCy44EPnT9m?=
 =?us-ascii?Q?xrxjUL5jyRDD9MhYzeeLzl0tywBqjHxHqJexZF5M+ziqtA7Y+TXyn6b2/ClE?=
 =?us-ascii?Q?sJ9ImO0xHMaj/kA9G1k3CpWIj2MinyXVvQMr0ZITbtuZXsPjwQPxgLaiGUVO?=
 =?us-ascii?Q?7x3DQyN0aOQbgkqnkTAcYPdmH441wJBhq96ssLZ8EoAymIgPz51izHPtVXtq?=
 =?us-ascii?Q?KJ/IT7z0+wUCcYchvPVYYn8bBVlSPY4K+BI0LVlTwCjnw4Y/QTnzF4BTFiHq?=
 =?us-ascii?Q?jGwfeVLNpPq6sieGDMMJ4s8tZbq86rKS9whpQyilkfpLjDfpyfbpR+VVCocx?=
 =?us-ascii?Q?q2EO+lURZ4up/hN5kOuvIyph2nrmlDLEyEG5BjYTD+b1cIecHIaGoXDqSNOo?=
 =?us-ascii?Q?MBQdfAjwjjIvHMmH0gemvbgnOE9LVZRnZ3FXjcFYC+sQJbD27H9uDP2Vl93k?=
 =?us-ascii?Q?ig7YmkjyDpIM2sE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JZKzZTkr89MtqjwjHivO6KnymypzLX4ZsHTXe1off9XMIzkqCUPFH7O1QlXS?=
 =?us-ascii?Q?aeB0IcyGb+R8b5rw5W5hIMmKzipEMcBU0IM/FP1Ez0WNr5FVOFFK18pF8sr3?=
 =?us-ascii?Q?wYWiXZiUD6r8b5QyOJLEDt5QLT7SuL7gUDLDU5XA6p/vSG1XeQ8DknPBBUnR?=
 =?us-ascii?Q?xdaFZ38WJsRhJoNqwmDoBBMjA5pKie/crC1xBoINS4nAlZB1fH83npIskbte?=
 =?us-ascii?Q?ljsg+lOda88fbuSBuA+wsrA1Gx0g1Fpca7/6z+tl1DRZfK/lqlj0IO4Honwq?=
 =?us-ascii?Q?D3mmwb21XtzRQfoODMTXEnpb0HRB8+oTI4zOwD4xRBZi48wshAsJgCCPxZjG?=
 =?us-ascii?Q?2w3/ONxV8YJqkLBwJUHro0/tkqGIicZG3cnwxtQxsB+Q/IiVhuvqD2ICuEZD?=
 =?us-ascii?Q?qZ00wklzgVvqY4HIjNicwpmqS8UNo4opkk7CmRrvgolp1eWflW6C0N4fLETW?=
 =?us-ascii?Q?0tKV4U22xQ0sYcsvJ/7WN0IJiRAhWoGBztbhdHpZV/lpF5ICI5OQKoiK+9A7?=
 =?us-ascii?Q?cWk3nN9lVenjphg+eWoQsmO25VDj7Ds/OU8zzbeWVdb5/14vjdeYscrSwzIx?=
 =?us-ascii?Q?GNYYcoTXTKRh2HMW7o2Km09+u+cLgpM38AZ9QQ72oVTXYjlDPrcw8509vGlt?=
 =?us-ascii?Q?G3W9cXP7YqsIHg01VTxNB7Lql+N4bVdWyYsbjuR/tAQ1dpOa7mgNlEuHkO/q?=
 =?us-ascii?Q?zl3itscdp+wCW3P8+X5rfiVh4hRNA0w+S4ZxGT6eB0eed/0cSY+JGLR3+84f?=
 =?us-ascii?Q?d+ryrfGPMjVmyLsPk6wXEl8NLDxq6kOb1tn2ckR3OJmOr6bSjSkQsaPpkfHh?=
 =?us-ascii?Q?FS/oGIwhMYzwo6lEEjMal2KyVea+G2sZYksz8Fjqm+FoM77bP0GFKp3oZyW/?=
 =?us-ascii?Q?H1khsoGHLEKjWjq5zX0J6UlR8o/JgXPfGTU3Po7AY5l8PSbC0W3pKnI2EYA+?=
 =?us-ascii?Q?mHrCq+6aa/VXOhLqDEXihC41f50jVL9ggCSnrqP3SOIt8WIcj/7fKR/C9Ynv?=
 =?us-ascii?Q?t/UJLWPu+l14FvR/TD2nKyqzIcqVStvyWSFngL30NTeSOo0YSN41YRLzP6nt?=
 =?us-ascii?Q?usrTNEFNV5fX1MG8iNjPh1/nTb+o6YXPEemdxcsKCqpvnnPojC43AP6KoM3a?=
 =?us-ascii?Q?WwDdRKLxDb1l8Mb2t0eDN/hykZqtjtRjehdLsRg9uJtO4MembAFMHAmeCH9f?=
 =?us-ascii?Q?nn5nC9PjsKmNbw27YZRn8tb/zayy9N43IDB3XhUT/23EP2wGPyxxxTZEPGoS?=
 =?us-ascii?Q?OQ6uPc82BG6djfwGRJmNazMAJnfNoYjp38yFy44WiAV9hfCgCk1v5g6eh9Nt?=
 =?us-ascii?Q?2Grna6WG6zVN3WN34aR/fLM2lxW8voiMGhapeBBeRpvkKzGLE0jAptlviMyZ?=
 =?us-ascii?Q?XG5WYypqsGjHtnlW97g84D34lVeIjnBaAccio4oaXOloce8lOKohOuxjmNVp?=
 =?us-ascii?Q?4yo3EOEscxNidI4fZp/6YkO4WetPONzuUzCrGHAHacj0mnne/pDR0tAYrSI0?=
 =?us-ascii?Q?d8tFYUuSzCyEFICvv0nTD+oUFM8JIebmExrsPVdQ1eUOZGj8KN4H3F9ScRnR?=
 =?us-ascii?Q?XGqPqNvkL/5A5/LsclDwHvt6y60Yvchrm4ZEHgdx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cdc29b-ac11-4fda-19d7-08dd8cad5cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 14:50:36.9856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /t0xlTAINdUcEis13TZBdxotpG6BQaWq++IclxHJwICVInf390kLzGmwuKvhegpO58UnQV7XgjMcNCQVtALn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8432
X-OriginatorOrg: intel.com

On 05/05/2025 9:02 PM, Jakub Kicinski wrote:

>On Mon, 5 May 2025 17:20:11 +0000 Olech, Milena wrote:
>> >Right, nothing too obvious, maybe cross timestmaping. But it takes me=20
>> >30min to just read the code, before I start finding bugs I have to=20
>> >switch to doing something else:(
>> >
>> >It's not a deal breaker, but I keep trickling in review comments 2 at=20
>> >a time, please don't blame me, I'm doing my best :)
>> > =20
>>=20
>> To have fully-functional PTP support we'd need clock configuration +=20
>> Tx/Rx timestamping, so it will be challenging to remove something=20
>> logically :<
>>=20
>> The only ideas that come to my mind are:
>
>No strong preference, but
>
>> - Remove tstamp statistics and create a separate patch for that
>
>yes
>
>> - Split PTP clock configuration (1) and Tx/Rx timestamping (2)
>
>no
>

Is it ok if I remove tstamp stats from this series ~50-60 lines, and
won't add more code (I mean get_ts_stats) ?

