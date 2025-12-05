Return-Path: <netdev+bounces-243879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFFACA957B
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 22:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E09D8300FE3A
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 21:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BE72EAB6B;
	Fri,  5 Dec 2025 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqYcGwMB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447D2EB874
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764968503; cv=fail; b=Au4cgs4KdU6DAmezVpUVBWHluNoSj2scy21noPZscxn/nU4aWcQY4ubQE0B9Ay4b/3Ve7gvW+7zT34PJfdQxslX7vpifgO4IaRkK5UZMz6tA3Vr0lf2kL/r3nI6eIsp0F/d9u1O0d+xsG/3GHxQIzfeh1p0R3V5qLSTen2pBuNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764968503; c=relaxed/simple;
	bh=ZXBudQqkLaEFgTiN/hV/YSpODVo5GXkLwXQpDqLyjJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=huQ/AXvQ2PvQCGJhrHbBvakGeNXzLqm93dMQGNNgQqPGJ6Ux3n0GGkHAtHDJX2kjwEG7KuYRWfup+wHdPMFZoy3F6uiWX9EVuMKf5+AZnzBEMgHLKqm9MtPw1iYMHoQtoF/2Vcqth0GQwwEO3XyZs9C8/sblxNglZPbUfcM+Fw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqYcGwMB; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764968502; x=1796504502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZXBudQqkLaEFgTiN/hV/YSpODVo5GXkLwXQpDqLyjJA=;
  b=TqYcGwMBiSM796BU82YkuBU20g5XH8s96gciZD9/+oEA3aun6WHYGU8m
   vUTdHzL+TdGWWWXQtTbzmh90YKeS7FWmEh3UmhtlLMeW8M8tKAVml11s+
   SBth5MJTPj42CzTvfvf9ezjQBqoourhbE1ICS5oYfOcwicBP7+LFvuBzh
   A/S01dSLvvS6AHEmGygUS45cSyvc1J472yVc5eDb8ddbwygoGtJ6zsE3Z
   RQIRiCrv0hgBJDdqv2BsSoqvsF4Bw7sefWVkLHbPCl9x3ZqcPGigqe5JO
   wLNJHwy36Yszd/o+Z0oGewV7zm3fVywdK6fG6S2jrplKvdf+YBNslwQkc
   Q==;
X-CSE-ConnectionGUID: lFXvlQFgRISdJ9Z+WBg/Hw==
X-CSE-MsgGUID: neA7VHwmTSaY0lqKkg5MIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="70856189"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="70856189"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:01:42 -0800
X-CSE-ConnectionGUID: k13kbiF/Sve4htuz1Cyf0A==
X-CSE-MsgGUID: 0kPyCpesSBuBrMmo+OzNjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="199565888"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:01:42 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 13:01:41 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 13:01:41 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 13:01:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zA8NA05EzZTZwDiM3Yb1uDMzHUKj1SH+mumivntXBsG5BIzfnkLGoYi57QMsd2R5vLbYcRT8t5d3KhlblGrIY3//ZpOoEcPrEKaPrJKMJymmvV8kbUPK7PdnNbwkmuVc7vN3h1y3ypCz63ToKxN46yCcAuxrj3RZrMP9twSgX/CE0GB4enSRHShVLn+4amHvfAiqyOos2E3IKmkDT8E1DShV3PkcH/VOiW9V/TcD0wqOId+QJGttB2C2/Ylka59JeKn6SP5vaKPIhsOFfjgOGfACFtGBSS+e9pLv6z7VHYWVaXOnrgQJif7+ND3v3dkKwGho4DwQL68Pab5qd+SuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsD+Kyj2lZ/lPFTZ+ksRJyKo6+jhUVYV6yT6h5ShbSs=;
 b=UT90FapjpLxjgjL8yHfgPQVd32OnFTEdfGhs/jVRqwEqJD7rUGXPXmcj+redxwHxYY07zwTfCMzLxY4Jhv1SnYZtHg+90neds5L789Bw+WSQS0VMwh7i6MuncGKYJdmd8fOu6pL4NaXv1W8Vd9rI68aTTNmOJRAKnQ7NDMKFf+Cbgu0Pb+MZoQX3FVC/J/4PE7Xu11+9VdsO166PbcaA2JI0UNRalh9+oic0y2iyWOgPi/4f+qdqSttPP+rWNbJmegbVWg3r2znOurUGxdwKvqqdkWyONekijca/Bi4mEK9xRdI9RLwebJ9bjAcP6iIgo0ahCH/61gmEX26IT+ALaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 21:01:38 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 21:01:38 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Takashi Kozu <takkozu@amazon.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Kohei Enju
	<enjuk@amazon.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 3/3] igb: allow configuring
 RSS key via ethtool set_rxfh
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 3/3] igb: allow configuring
 RSS key via ethtool set_rxfh
Thread-Index: AQHcZggc2HlsR9hfS0et6LNvqZdNBrUTiFLg
Date: Fri, 5 Dec 2025 21:01:38 +0000
Message-ID: <IA3PR11MB89860A16782937C7E8C2E2DEE5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251205082106.4028-5-takkozu@amazon.com>
 <20251205082106.4028-8-takkozu@amazon.com>
In-Reply-To: <20251205082106.4028-8-takkozu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN2PR11MB4743:EE_
x-ms-office365-filtering-correlation-id: df96e456-4fca-4d5a-16b3-08de34417b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?zm/5B+YEE9zh+JrQV8af27D5jLp3xkBBeFhJAnSBZuCT8nLlBu0IMO0+AK/7?=
 =?us-ascii?Q?NUoIj/pugcDJI2hUPWyIoVHGks5TdGGglvQww0gZbMVME6a2G/clKVb6aQ+H?=
 =?us-ascii?Q?FcFjZ7KXbHJx6fKyFV7RT+ke4SRW0fv4QR9OM7gIr8qs99+x7mMtqpxyCIz0?=
 =?us-ascii?Q?pSTno6kWO3zWisEh9cShkM+CvPX6xTM83bCJDNRRy1Hc4eHz24w2qrIHbyBM?=
 =?us-ascii?Q?FcAyhMfw33MhIWr7rAGy6aPjC9gZ+fMbhPqaA67GXKpNvHcFJk4vneORI9LB?=
 =?us-ascii?Q?3Xbhl/PQqkTSrMx0UVJYtG03lco5JGV2RetXhMN0UTqmGf22PHiBs8yeCKGw?=
 =?us-ascii?Q?6PzmxtQLSQnB3QDc5SYcai1xF22YkObC45OeOYVXPL7NYLOOcYdY3vM3rHbb?=
 =?us-ascii?Q?YaDuJuogTPmpJvZ1lvaP81a/wkeq/7++ncRWyEr3l5JoRs9EqX6vAsMjW8KQ?=
 =?us-ascii?Q?kL+4oqCKR+I2Nc54oZjeAdEJKxq1Yp2l6fiQs/ZAOv+khVAas/yqUy4GB90O?=
 =?us-ascii?Q?2AVYGzbNPoA4cergpjxBpphHKosVy4HV2+bXgBofjpkc4d+JXBsXun2MeZOA?=
 =?us-ascii?Q?CUIK2HD3YzmuSEFp5au+ficLJ7YR3tix5xEp93sLIIRBSGbLkNDF0mVQr9bX?=
 =?us-ascii?Q?zPrcYD8pTeha3bDgYsWdvYZ5QZElru4Oig3sSwBSR6PeHrJkmNZiHvU3ZiOn?=
 =?us-ascii?Q?YsilshiNoFkdfytLFlqYhtRnJKlW5JfAvamM+6B81b9bYHs+jysXXAPn86XU?=
 =?us-ascii?Q?geYGeb2ZL9SDJnfGLVoyptEcLEtGdxz/Fs33RNtSxyUzc5gJZPe+fLWhUBrJ?=
 =?us-ascii?Q?EnW+TkVxMwjhVTRN4ZrwZxBETzduP4mbebN8Q+LewsPLEU8ZqFtqVcND/hzs?=
 =?us-ascii?Q?qCJAhwmHNaR+FAGQDkd70cAFvGbuCN1KdBn0YIk2CQIQi9Ku0Xbi/3B8fDud?=
 =?us-ascii?Q?haqPCumqqwjwoOGQRBinzn76znsJLfufOtHCKjL8jrUvxZWKDyvaIpZXGQ5S?=
 =?us-ascii?Q?IOPEYj6mSu3uBtay91cMslfYRZY+ER5ObuVStdwctH3PoQmzJVPbq2zLjTBK?=
 =?us-ascii?Q?OU3NanW7iMgP95etb1lhGEfNrQYQWBjclg3tznVFdlvWiF00GWDvo7E6Po4D?=
 =?us-ascii?Q?/1svchyngcWv8k6fjymI2n4t9mcfuRJVaPGGRpv2JDDxxoNNJxPkZyeyQLt3?=
 =?us-ascii?Q?FsfI4JMDxUpGjE40+blO/NnWlQaAm+1pXdqqN1HZTfFsm+jsdbHCHXEV6KRa?=
 =?us-ascii?Q?hIskDj5aCZ1n9Qy/fgmR58vovfN0bF1b1uxReJBbVnZISahKp7Pzwrr5jjUV?=
 =?us-ascii?Q?vQfVIXvbsFrAha7ouV2GdI26MczLp04STPW2+2kvL0i4cD6aNFWX+y3ljFdK?=
 =?us-ascii?Q?JIoW8wUCtGxgL2HSlTGZsLttatYQavJvqdWgxJIMgnwHiAReh6PrJtK7gks1?=
 =?us-ascii?Q?FDbXcqHH1atBk4nSVxXRhWogIQgLSYz9cxbFQ1HY8AJk4RMej4YcoddyLnPl?=
 =?us-ascii?Q?V8AaLPZfOiT2cR4xdTVtKh3T991rDfg0CHJp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pG1yJePHOWtuB4T70/PrvGA3pWH9+Ki9d1rl+qdMksG5iN6bg1xRdu+CYg3C?=
 =?us-ascii?Q?PfxWt6X7YuW2wYClji6lcv3Q5pGnFAN0wXbJAwMjuruEMAuqLmx1hHcmOBLc?=
 =?us-ascii?Q?QICEPpJyIb/OBkzzmzRlxio2W8ln/FOth0iuI0vxeLxM5qDJAOz0L2pTCncx?=
 =?us-ascii?Q?FkdftepfxtNouCjZa/jVR5vVUHA7MEmj7Wp97i2H7aagzyzgHeqBnyLkhHEf?=
 =?us-ascii?Q?N2qlnhcr8UFKoh7damGwV9l/TwbHAQhWTEhZhL9uOvdxTETJWCdfAcz+Blml?=
 =?us-ascii?Q?ywn5zQ4Rz0IuwmwJ2F9df6AMDwb9DrlZdXtO/BZCovvVxrZx2jNEvvIxmutH?=
 =?us-ascii?Q?ccnhlylC3uepvHwz2AFNmSn9gjmNHK9yOgIAcJTWSVLaq+0QlvPUmDCDrMFw?=
 =?us-ascii?Q?3c9U2VDgyc9JFPXqY1sbt8/JGbFgW2b74b/Rp5pBVxa8WAHidCEdSAOV3vom?=
 =?us-ascii?Q?K6ND6rNsZB0A6ZFtAGkl2n5FZ43KTpP/od1/1OeBBefJedKtVMwzc+E9AjKl?=
 =?us-ascii?Q?24OhBr8JMxTl4k9yEzdPEOSMpAgjfoCTrd66HzcJ2OCUz5iEE/nan2+OO6/7?=
 =?us-ascii?Q?Vm7GzAPx63vIDCAphWHr7oUXcxdK5LdMBeJ7UnQ0vIzRzaPoDHOz9++ORh1n?=
 =?us-ascii?Q?GuHVc4bFw9JUSXvoTYEOjc3TCDSC+GljkfpQCrkMZonWNZJq7kHF7OMZatpd?=
 =?us-ascii?Q?wsikqvFrO3qrQr3PaGcqeGdrWX4ss5KOQ1opZ0ELOyrpQRNNJebMy/7XIZEG?=
 =?us-ascii?Q?YuEi8KRJkxPeVU9RzCGfz3Z3dYyWeLwiDMuLdDRXqTBJ5d5VAD5HEMahbRXh?=
 =?us-ascii?Q?8La72WJZOq+wIw/lEsYIZ2DpjkNijg+V0gTA6qLQM+gUMHeFsuf3idZYuxof?=
 =?us-ascii?Q?oY1vSXBugTuKU+jbU15mgaiMO+GaD5L9cC+bd5K041lkH05ZXdFhhMR2G8Q3?=
 =?us-ascii?Q?1vwaJ4i1tqRzs5y+XHHDPKxHe3OT+nUgZwqScBkSNkeWr5mZZPJ4eiFBCBHe?=
 =?us-ascii?Q?9LEX39tQpa8FATgT7sNa3t715xIr9uMjGLMkex/ozsGjuh5rQj6oTAgMA07L?=
 =?us-ascii?Q?GEqplx/Wp/aLmkB2asrL+lwWyvGcchNF5uvN0WaFFmkVHw3uZ7w0jOpK+RaF?=
 =?us-ascii?Q?JL53hltgLebbCkB/rIIhD5eVoO8XGFxtgcJLPs1LVIZnabGHeyi/ebnJu101?=
 =?us-ascii?Q?f0voAtrqdCuekCGI0zAcdhF/UpQzKcvsH6iXN7IaFceB5mWVSr4qje8tsCCx?=
 =?us-ascii?Q?oaZGcIkv+1kkyMX7zDLU+dvZ185BmaAjORGa6y1h8r30UJqy3qLPRQ4wWlmW?=
 =?us-ascii?Q?XGKW9gWnKbYnVbyOEt4Vd89/86poXf2pfe4QF0H9kvg2uPwTdE3UDJDBCH9f?=
 =?us-ascii?Q?nCoclfqFbbtzc+DP6QQNoXSPM9Y8p7Fv7KSm5Tg59Tv9m8T9zaxk9b8dKKNp?=
 =?us-ascii?Q?m8iydPIT1HAByT02VyALuAiA4hXHmCAOuw1aU8Elju83H3kHSOP1nHuY1n/N?=
 =?us-ascii?Q?i4XF23IUcq//HR2kIcicBP5bgIo5ukIb9Dvdero8AocAmiA2T6DSYfjHIr8N?=
 =?us-ascii?Q?+/sDirNO3pYhF88bDB/cjSjdYvhRGavOnQ8ekVBCCsHnkQ6dfIXFD8hZwYfV?=
 =?us-ascii?Q?NA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df96e456-4fca-4d5a-16b3-08de34417b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 21:01:38.1886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuEDC87wFrcwBCxKWaAGQWt5A45ZBKpU+yS+DCOxSKy9F2XOMtrc+o+285wTtxGm2v2dkypTE+4lASxVuxwk/CnPqHKW9DuoCcs+FDa0/eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Takashi Kozu
> Sent: Friday, December 5, 2025 9:21 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; Takashi Kozu <takkozu@amazon.com>; Kohei Enju
> <enjuk@amazon.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 3/3] igb: allow
> configuring RSS key via ethtool set_rxfh
>=20
> Change igc_set_rxfh() to accept and save a userspace-provided RSS key.
> When a key is provided, store it in the adapter and write the
> E1000 registers accordingly.
>=20
> This can be tested using `ethtool -X <dev> hkey <key>`.
>=20

nit (commit message): s/igc_set_rxfh()/igb_set_rxfh()/ throughout.
All modified call-sites and symbols are in drivers/net/ethernet/intel/igb/*=
, not igc.

> Tested-by: Kohei Enju <enjuk@amazon.com>
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |  1 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 49 +++++++++++--------
> -
>  drivers/net/ethernet/intel/igb/igb_main.c    |  3 +-
>  3 files changed, 30 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb.h
> b/drivers/net/ethernet/intel/igb/igb.h
> index 8c9b02058cec..2509ec30acf3 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -657,6 +657,7 @@ struct igb_adapter {
>  	u32 rss_indir_tbl_init;
>  	u8 rss_indir_tbl[IGB_RETA_SIZE];
>  	u8 rss_key[IGB_RSS_KEY_SIZE];
> +	bool has_user_rss_key;
>=20
>  	unsigned long link_check_timeout;
>  	int copper_tries;
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 2953d079ebae..ac045fbebade 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -3345,35 +3345,40 @@ static int igb_set_rxfh(struct net_device
> *netdev,
>  	u32 num_queues;
>=20
>  	/* We do not allow change in unsupported parameters */
> -	if (rxfh->key ||
> -	    (rxfh->hfunc !=3D ETH_RSS_HASH_NO_CHANGE &&
> -	     rxfh->hfunc !=3D ETH_RSS_HASH_TOP))
> +	if (rxfh->hfunc !=3D ETH_RSS_HASH_NO_CHANGE &&
> +	    rxfh->hfunc !=3D ETH_RSS_HASH_TOP)
>  		return -EOPNOTSUPP;
> -	if (!rxfh->indir)
> -		return 0;
>=20
> -	num_queues =3D adapter->rss_queues;
> +	if (rxfh->indir) {
> +		num_queues =3D adapter->rss_queues;
>=20
> -	switch (hw->mac.type) {
> -	case e1000_82576:
> -		/* 82576 supports 2 RSS queues for SR-IOV */
> -		if (adapter->vfs_allocated_count)
> -			num_queues =3D 2;
> -		break;
> -	default:
> -		break;
> -	}
> +		switch (hw->mac.type) {
> +		case e1000_82576:
> +			/* 82576 supports 2 RSS queues for SR-IOV */
> +			if (adapter->vfs_allocated_count)
> +				num_queues =3D 2;
> +			break;
> +		default:
> +			break;
> +		}
>=20
> -	/* Verify user input. */
> -	for (i =3D 0; i < IGB_RETA_SIZE; i++)
> -		if (rxfh->indir[i] >=3D num_queues)
> -			return -EINVAL;
> +		/* Verify user input. */
> +		for (i =3D 0; i < IGB_RETA_SIZE; i++)
> +			if (rxfh->indir[i] >=3D num_queues)
> +				return -EINVAL;
>=20
>=20
> -	for (i =3D 0; i < IGB_RETA_SIZE; i++)
> -		adapter->rss_indir_tbl[i] =3D rxfh->indir[i];
> +		for (i =3D 0; i < IGB_RETA_SIZE; i++)
> +			adapter->rss_indir_tbl[i] =3D rxfh->indir[i];
> +
> +		igb_write_rss_indir_tbl(adapter);
> +	}
>=20
> -	igb_write_rss_indir_tbl(adapter);
> +	if (rxfh->key) {
> +		adapter->has_user_rss_key =3D true;
> +		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter-
> >rss_key));
> +		igb_write_rss_key(adapter);
> +	}
>=20
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index da0f550de605..d42b3750f0b1 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4526,7 +4526,8 @@ static void igb_setup_mrqc(struct igb_adapter
> *adapter)
>  	u32 mrqc, rxcsum;
>  	u32 j, num_rx_queues;
>=20
> -	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter-
> >rss_key));
> +	if (!adapter->has_user_rss_key)
> +		netdev_rss_key_fill(adapter->rss_key, sizeof(adapter-
> >rss_key));
>  	igb_write_rss_key(adapter);
>=20
>  	num_rx_queues =3D adapter->rss_queues;
> --
> 2.51.1


