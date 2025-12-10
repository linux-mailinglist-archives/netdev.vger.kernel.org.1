Return-Path: <netdev+bounces-244305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D20CB43D5
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 00:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92AE2302E1F3
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 23:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA97306D49;
	Wed, 10 Dec 2025 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hViMTQOD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8223B62C
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765408939; cv=fail; b=fzi7Z6X0UD4ZGCOhPqwRGH6/0DvzopeN/QQQ0eoN+xi0aeD8Q6P3GC7jhfJNugWXsQk5yFa/FdOQ6hqHMOsU0syo8L8T42kCBf68X+cHqdfsCYUtQxGY4GqnJYzoqrFD+76Hczey+2TlhSMn+abokzJNM50rJIM2QuU0PyLWn7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765408939; c=relaxed/simple;
	bh=5XJC8rmzg+DEKhS1TClhp6a4TuA2Vqq1gb6rq6sxA2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rhkgg1n62y7riC16LqVSCCAaUYSvBOU262mo09nWkNudEoAeiscyKjhLJm1lTa8aNKova2QigramfS0qJzLq7KJx6rUCDC1w3w12J5D6ZyqG4K02se4nV9nF1tJ0nsmDMbUWlQmIGP8GW18WJ/6Z/p4xVFDF4MKYerJZ1efhFuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hViMTQOD; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765408931; x=1796944931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5XJC8rmzg+DEKhS1TClhp6a4TuA2Vqq1gb6rq6sxA2g=;
  b=hViMTQODdfBbq+fm2o7tf+O7algqK+z0KX9GPi6YFkPcqJAtjzQtUPGk
   2xTHTOUHLSgmKjsem/WQ0CkwJiW0USWD6qqj/bXmR4A2Pg7g4OQXFVvI5
   yxMtHpIt6hdqzHMYyif6jvo8xpLrk13GZZFimqwqE0nBKYUgfPXMQLBa8
   HK/hnRgJYqaIty/vS87ra7qbwD5NGsBQFPeWsRRTFm5CZTVZVdHMpUOnc
   IacN88xUiroCUXha4sfMiWBQn6RgbGb8kjLQK2yyQcjiv9aa8Szc1YSvY
   +j3GBThkdSm1EzM2pI1DoQqy3Z6juxrqQUAnidk1izuPYUJufObCQHCMR
   Q==;
X-CSE-ConnectionGUID: /AQ+PCe/R8WVX4nLKTLssw==
X-CSE-MsgGUID: jyUaTrDEQ4mM4ttbHiGobA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="71236368"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="71236368"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:22:03 -0800
X-CSE-ConnectionGUID: Mj+yOpbvQd6dUCCpiz1MPg==
X-CSE-MsgGUID: tWokdDwERMiS9ncGmWt7ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="201566897"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:22:03 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 15:22:03 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 15:22:03 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 15:22:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BP71truZZMzwjtnBBNhQo1tBd3h+UHPHVAlF+EAFEua63D9U8vy29Uq7g/B9Ru9wCSCWf36GALD9hYtJRbP6u+T/stPUZUfY6JTkhzK3N0tcFG7l1KuSG7wg937Wh+DqlQjPJJqQmHMl9QOzgN20VoCITQ5W3VVHukhI+mZENC44IbdJb/Z6bxebmZZPr4O2O0DlSLcbCj8d007Pcu2nNWzPxe0brrVNzjpAZjN5JjSk4cbK4bf0uzg4Jdx0ZkwN+Gk5XyoTfWIocbZRCA+dHa2hGAbUO+lZXjMchMqFqbKdZI4Y+Fw0XiUMpVIyIxVNwoOw9QzyhsBVGxFNz+pEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XJC8rmzg+DEKhS1TClhp6a4TuA2Vqq1gb6rq6sxA2g=;
 b=PqzWBB0lLVe3V5c2oVoHCU+uU//m7JhKibStK0Q5HIaW2UOhqrkOnYwET7zSYAjwqeR4B1M9tOka9hs+0lbFXvTT5MSJ2/LW7NttD2kYOIYZExwxVseXM087sq6OKzVHvpDBcVxPS7EE8IgVMxv/0aFAgUf7G8G5KZ3YDAa5Ho07vQZTnNxor5jWLECEpvFL+CFvnLWbO6XWTymvOQ/l6+pxhnstIOjz1UvchYCUP9yOJz6ExwIFX7lOopClcmfadBShGQHYHqrrlXU14c4KzJPNOAl9adtxQlEeOs2wQEsoydf/n08ZveTYGH4brdiQD8h0RcK3RhvIEUHv/sUdAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 23:22:01 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 23:22:01 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v10 07/10] idpf: remove vport
 pointer from queue sets
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v10 07/10] idpf: remove vport
 pointer from queue sets
Thread-Index: AQHcVDThmxJI76FWokmp6B/gHUs6c7TwL/+AgCt+EgA=
Date: Wed, 10 Dec 2025 23:22:00 +0000
Message-ID: <SJ1PR11MB6297511D744E6EE15E81F38F9BA0A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251113004143.2924761-1-joshua.a.hay@intel.com>
 <20251113004143.2924761-8-joshua.a.hay@intel.com>
 <IA3PR11MB898661799F6FAA57927D1A45E5CDA@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898661799F6FAA57927D1A45E5CDA@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SJ2PR11MB8451:EE_
x-ms-office365-filtering-correlation-id: e2b1a9fa-392c-4785-8052-08de3842ebe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?OVBPSbV6Qd5cMxasuXwiDe0CwgOQuF5LgqQYxHY/nuzlLRyn+FcOBZi4pkg+?=
 =?us-ascii?Q?8EKBM/bKEse4qQg8Vj66U00K54tH5jCnmGYWFbjl2hxjnRz7I7I7zeoegKTG?=
 =?us-ascii?Q?v/PuaknsGPDmKvTo7oWbPeHik51KKnzA718ViitpTKM8L6mgl+1k6G3FfmJH?=
 =?us-ascii?Q?HWPzlfmcjv3+T61dMPhD8zthzipz5hC3zGCZCVLiS/rh0YluOXxsBh9Z+fW4?=
 =?us-ascii?Q?D+sYaOHFm4MwN3Aq3BsmH0pbpSYUKs+iscPpGkaESPt2QFIa5EFwtjQdrm+l?=
 =?us-ascii?Q?eYbarOHQxFiogaBTmURcSYsPIziPFUqZk1dAdnwnp+0AjOjI4LPbjVclk42s?=
 =?us-ascii?Q?h8/7osGb7BcjNZ7vytLBgyuSI6g9phGxFs6ZP3+mqA8R1ekX9XDYPDPz0/ps?=
 =?us-ascii?Q?m534rzQjk99MLxd7iLjQB2Fh94igeMChsUgy73v+ubF40C97avXa+o9FRQZZ?=
 =?us-ascii?Q?qGupOkurdLogVyTArb08tFtERGQ6rscU/y9hBdHNWrhadWphhH85zPoJC2rT?=
 =?us-ascii?Q?NZ/nneKojA4u6I0Rm8MMKP7L2aX7e1VKVMWo9hzJrDyIOkoQujCfY5AyeX30?=
 =?us-ascii?Q?exC6GYFoJy1gMWjmPaYj5UxpoabPD1OQrBfplZMGJSzJn29dR/hgztI+1Zfp?=
 =?us-ascii?Q?ufhnz8fFY7esUbkaTCs/F8E2C2bnLSaovIwvRAoMZ0oL5qUouj8RsfTiMnek?=
 =?us-ascii?Q?LQEjRmyS1zYDS1sgJgmNhh7w9rjgkCEGxJl0dvdZgmWokuf1BU4+4YIFsjew?=
 =?us-ascii?Q?g5dp+1t8ujVt8jezk+fVsifj/fZQFRX5AvVdb0MHeK/Ykslvl/OyA0PXRYCU?=
 =?us-ascii?Q?VHRyg/GWTC/dUbXaAt/89QiNv9BoXla597PBl0ZLV/IgNyXYxbymjCrHszwM?=
 =?us-ascii?Q?hK+wZQBV6LzNutk+y7cqFPOQTulaWLmlt3rd2j5HitMuILxqUS3je/nQxSZh?=
 =?us-ascii?Q?9TzAukCypMkbx9N1s93xnjDsdJ4m5aTgp0P3pcsTCzWmfoODx6bcy9Dy02fL?=
 =?us-ascii?Q?JmEgujTYvYphSzfwhht2mhLGWNhkdIiVGZYmNt1Jq03y6JQE+7THBzUZxSlS?=
 =?us-ascii?Q?xDawArspb2Bm/Yg0tTUflTIsQC4WiZcVZpis1gNG8UjHuoxC04N3YpSFjBvW?=
 =?us-ascii?Q?CYs7m3I8rmumc6E8haeFcxk4XGjQmhw6ndnw1GAd5WvzCU2OIJyNCLihzRXo?=
 =?us-ascii?Q?65zD5wQLyduMCKpLDJbLdDBjhxlqV+YR0Q2BFonTeTcIpHAnJCxqrZ/DqWFz?=
 =?us-ascii?Q?xqGsDZ1RpkbEt41fzbPhtULPrrgPgn76LZpqJdeK6R1NL358V3t7ia/GLEwJ?=
 =?us-ascii?Q?tvNH/BBlqxdKTt5H3TuFJS25IjufG5rVKienCcnI9dHGsJQoFV9fGpQCRTPv?=
 =?us-ascii?Q?/7Fo4NZ+8Y5qqNLo61x6GE3ykmPK1T1aEaihu+Qz56C2VjzycHSMyX8EFSrx?=
 =?us-ascii?Q?5k8W7oF3FfGPEaEIbmv2/BLdA2X6zveMnmvxsrmseaNGZdrAadiEbx545N1K?=
 =?us-ascii?Q?TfCA/FOMKWYfwTjC4om1x6f3bpZbPrct+hMo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UVpg5S0hJokcVDbCGfbz5h/6F4Pi9cMQG4GrY9h8JKQVUBsM6UWfXYfaCasN?=
 =?us-ascii?Q?yAWwM6k6ChgtRn9C5Y7tvEsyjF3SXGa1nyJYJS7Wc2TVqP3RHb4cS96C/3sx?=
 =?us-ascii?Q?2dcNCZM1TR8lBOLt02cRhZo0758A1oQExRx82UJmvqGIiOFnGxktV0K2GfRA?=
 =?us-ascii?Q?IhCGwInVvJ6eYYfpCeY6NOmTCGZmAG9XmvUl29/rfYofyzGA3SUfJwYAAwz9?=
 =?us-ascii?Q?M30DmCfR6Hs0320fPK1GOnt0n+FpsHaKUxVzSmIXycJ5soW9gMJ65A7jPMjN?=
 =?us-ascii?Q?Jr+a6ljZ9uVPWpzMIHKxX+a7GDsl9TEzbE2/pZkhkzMYev8BG7fsd4XyT8js?=
 =?us-ascii?Q?iH8bzIethPthegSl+WlqlEmV+cij/ZKChO8+ESzz6rdlXEa4n1PcvvV8JM56?=
 =?us-ascii?Q?OuYRNtG+c1+u2tJcTVGagwfUZazmC75GAZen+CaiMGONgxEX/5ikQ6alE6WN?=
 =?us-ascii?Q?vXUlC+HE6dB207kDjHIZWFqtwzhusRoGcEPFWzlNwFzo6VY2fBL9kRPgpXio?=
 =?us-ascii?Q?4xXohu/3NBUFXTaw7z+VI5DTSWq9cK+EIQxA5Pr31KQ1embrnoBdDpZXqzwF?=
 =?us-ascii?Q?JX25rJRWKFrS5jzNPL/Hp4Fls8RHIG8WjfDniJrJzUHMY3XF+QaUuVVb1Uqe?=
 =?us-ascii?Q?h4ppXDMTkHV6z2bvKGgOQQS/BjpuIavvHkghtDqXlrh0gYqXb0MVGljAodeM?=
 =?us-ascii?Q?npZtOLm8vt2nQ75HhYO5im4bwYn1NSEV9cB0rrkrOxCQ7akUbZmeFrkQv3pN?=
 =?us-ascii?Q?Y/x5L20lKu126qaA3bgSyCTgW/pwYrPhWjH2jkRCCuWbteBJzMIofr9L3OlJ?=
 =?us-ascii?Q?8pmUyowfI8ZpPESJqpXAoC6COe+GFclMw4/keAbdT8iy6AlN3jX8k+uZKLQ3?=
 =?us-ascii?Q?VltdIWzryTPTGQF9fZifN+zeQ2JrQy4QRWXwBmOM7h4mM24BMDedCzJLppIY?=
 =?us-ascii?Q?vB9eaCXQcpl+8JjIcI6w826M4t0w6q5YoRt1cq+ixNUT1Z8nR1FIOrfVMgxr?=
 =?us-ascii?Q?THwoTsUSDop+Aq/jFpj7i/ak76PyWsi3A6mgsS8KfqQeeOPXqIWy4q2sSh1a?=
 =?us-ascii?Q?Mx2Yhd5Me8qMiRBd8Vz9r2jgbrEWenJv/xfAh0nkyJ5JdQ2Pjjx32rYgLMGn?=
 =?us-ascii?Q?ATd2fCkruunivoZBwAPkoTa8Wd1pTlQNUa1w2d36zo0ODbnkH5aA+UUlc8gW?=
 =?us-ascii?Q?VFvpjxDbY6IK0T15UxVvjv0rXMVHGF1+PKbusVT3kS6Mj8NPyP+p7SvJ7+uq?=
 =?us-ascii?Q?Xa+K6gJTsMupBXezfvrbN8rT027ZJ+tJb1PddJ7fapEmHZ0uNWu4o0PglnGv?=
 =?us-ascii?Q?luQ0B/ngyRSW+3wVV5AO6TB4R553+7Qz3kTLQPcckOxtTa8jX4ObTNcxNhKC?=
 =?us-ascii?Q?QKMKEjnDhdkaxjHja/3UEITakCtBoY+aBgVPSN+LHRkY54F6/LapDI4z0NVS?=
 =?us-ascii?Q?uLSL3YuYcUNJQZeKxeg2k3dx4TrzSOHjxPbMlNgxlku/pAN3JTjaR8exqklO?=
 =?us-ascii?Q?/wtk/zJ5D5JbxP+TUesoiTSvVFreBh2/WV8ksz3wvtIeWHPghoDg3o6aSQIU?=
 =?us-ascii?Q?pZv4nhxRfHRFPQn02avFLSEee14NRhNvO9JuuIQs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b1a9fa-392c-4785-8052-08de3842ebe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 23:22:00.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmD6gdf9WkvWy1BsRDeGKwqxo5KiRpSMWf2FGUe+3+EWenKd/y19XzKwsCZNbM3Olhk6an5Xw2uOj6lYw2pbpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Wednesday, November 12, 2025 11:08 PM
> To: Hay, Joshua A <joshua.a.hay@intel.com>; intel-wired-lan@lists.osuosl.=
org
> Cc: netdev@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v10 07/10] idpf: remove vp=
ort
> pointer from queue sets
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Joshua Hay
> > Sent: Thursday, November 13, 2025 1:42 AM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH iwl-next v10 07/10] idpf: remove
> > vport pointer from queue sets
> >
> > Replace vport pointer in queue sets struct with adapter backpointer
> > and vport_id as those are the primary fields necessary for virtchnl
> > communication. Otherwise, pass the vport pointer as a separate
> > parameter where available. Also move xdp_txq_offset to queue vector
> > resource struct since we no longer have the vport pointer.
> >
> > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > ---
> > 2.39.2

Tested-by: Samuel Salin <Samuel.salin@intel.com>

