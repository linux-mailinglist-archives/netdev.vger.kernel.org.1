Return-Path: <netdev+bounces-281775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBY7ETWL8GkRUwEAu9opvQ
	(envelope-from <netdev+bounces-281775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:25:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8193E4828E7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DB24302C853
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AFF3E4C86;
	Tue, 28 Apr 2026 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZ0IIlvf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F89340293;
	Tue, 28 Apr 2026 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371074; cv=fail; b=SqN2tRBu6mbJhMEOBxtcjHJtOMYxdOHwGDGL72GuVTcy21oYRyTntnYAeoQaA4O6S/V4UDgNRWQ3dIEhzsCKtbIczOT7arM10oH23P5rFJxCvm+xbLV/Rqm6WZyL5N4fKaLgkKe95As9BInSIcE/35RXwKKG5zX+siCa58Hk99c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371074; c=relaxed/simple;
	bh=l5QUm4Y1s202FcEEA4cEHU/FJFOX+2Satc4BiwuKv4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HWJPb/Pfz+74d/8dOmqWZ3P/um6GszrVvATA6I+HmIeoSgkX0xO6cnb42aXYJ4GIUGILBUuKen7/w+Ek76OjVlw9PMUHVWet0WPEXvZfMBmIBDeXMvENUhk+QhOAfMBwh//t88jfXDCDv+MoYCw3g5AhASXYl9al2hUHP8nqrFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZ0IIlvf; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777371073; x=1808907073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l5QUm4Y1s202FcEEA4cEHU/FJFOX+2Satc4BiwuKv4Q=;
  b=eZ0IIlvf3p7ff7k+Zk2uUngHo09WJo8Axo0kt4XeHI2l2ABadujVDF5h
   Yu4+LooSd/DvfQI5l54F6IWKtXzvwZ/KUCqu52bhE1NOqgWwrdevh9hzR
   9bLbggjwwD0VUFfWAdoQi0vLKGRs8D23/6YRMlDWlYGcMEq8xLpCiiWXY
   L5tyRD0q92fC25S775B+I5gvUbVUOqw8IewPxgijCRWiRgYfTzjADs5kJ
   kRUWy+YoMG7yRk+shKAPxzz/Ip2p8nI/P7sh702SZmBU8umgoCicjp7pJ
   /NpxehI1xQ5cK1EWshZyS6iGGBTM40OPa6S8sldDih1RLVTrKRzDWvrZ7
   Q==;
X-CSE-ConnectionGUID: jAdJjyxqT1u9cGY3293DSw==
X-CSE-MsgGUID: LmbBf73fQdOQOlyz+5/yTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78164919"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78164919"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:11:11 -0700
X-CSE-ConnectionGUID: v/BTXjIGQjuVMBWqnCwpwA==
X-CSE-MsgGUID: uIMB+aI2QS6Yjzuvqy+DVQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:11:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 03:11:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 03:11:03 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 03:11:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciV+Be4hmAJTFNHaoYRp7EXE5grV5dfEOVgHin3zbnW4mQNY8umCHaw6AWp36vpiwVU2lMSNwP6cVA6p4BiaBkQn7ZkgVMMqv9yLXT+OAKpLMtzfhPV3jn/5UDi3Ji1nSM14bMuiHDqw96V8Y7lJf61b/1bPOpZgOb5qJGD8vcbmoenHi+6UHlqT7ZQmfAaJW9YzaTU/Q17nFMOA8YODqTbM6X4Fu2xawZjEoUKgz3Wgk9adcDXst28ytTtHyRCR1D2yRFAP3DuYqKIGYtaGzaP3Cf89EVF5S240uhgW07sZTuVBBZaof6KBWxUW6uXyq6YyRvE9kNzjeXd6BhRRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9zvM3GhoM55MgzMoF+/H2tCuc6SRloClfVElITX0jg=;
 b=CsnNWyxQzt2A/NS+d/+zqQtnamZfxQOP5A6Yph0ABmWJ/+0spb+0hzRX6h3H3XbKq0eeB03z2j+9Oq1n0vtSDQU21KsCTBTiIGEefJ9esVfPjGI5Obr1VZ7xyijlIu1OTAfUgxoxFF67imwD65ydZ7nEyPdiJgykdOXsVCmUl7qFsmFG3NFG3rdhrKne43ag67xqNm+EpoYsPOMj3+WnUmCyHkp5mZ/B1buqFD/+UZfqRWT1QrkQNiIUOMf21kkdQmQCvXvhAyOpnvEyhUZge0ZuGawzaVS7NxW4Fl/vI+Pg4Ga3a5XbSZxv5uTW1mteKfhyKhdtQHPMq89ugo+9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Tue, 28 Apr
 2026 10:10:55 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 10:10:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Salin,
 Samuel" <samuel.salin@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v7 06/14] idpf: remove
 'vport_params_reqd' field
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v7 06/14] idpf: remove
 'vport_params_reqd' field
Thread-Index: AQHc1ujnWsQmks+91EC4cd7R7x8KULX0QKyA
Date: Tue, 28 Apr 2026 10:10:55 +0000
Message-ID: <IA3PR11MB8986E95BAE8B10013F50B8C3E5372@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260428082654.44364-1-larysa.zaremba@intel.com>
 <20260428082654.44364-7-larysa.zaremba@intel.com>
In-Reply-To: <20260428082654.44364-7-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW3PR11MB4716:EE_
x-ms-office365-filtering-correlation-id: 2917c3ec-b9d3-420b-83e0-08dea50e6f7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info: MUPzqmD4Q9mP8ymNWLwm3wQuHjsY7IvOZB07Ck5+kX1jTHmuFaV/1TqVfsnrSzgljYnA86xaMm/+kpQRv41/zMX4KKYaoT/Du/pi9k3/d8Yyhfp77NisCVI0QRBInxu1ZfgyR7GYbIuE4ow9s49XJcFa93M5RR1y+O/LByC0OZjqzr6cWo9fxmxtXrsHS+ZgHBSP0Ij7iOmg2Za27If1Mdy5PvITJ3XF4nR6xVHR7AFMsQVx7mqo7/o+dcKDwGfzBk3yUPDycLL+pNV/z+6iRl1K0XcJ2pyg5OYsF4eEAlTkNXhRp1jA9XwkeIur7df+1gtpboDkNXJ9ZYhgP7p0vf7HN7n0i8URA0loDv8ojm4tY8ejbif0M7yWXe3/+dWtPsDpuH5T+Qc8LDKObKyCF362RR/832S12qhhg5EUtdex6qqAfXvKYFd6ZMeZqXLPrpuONTb0vMMgL/DoNg1M/PupJwf7EDSXvqgMLJTKFckqK3be9yBhNAmYemdDjc8gSHiphWf4bi4v5PKercwqs0feeLPWO7e1fkLiHJdKas+YIhXqQo2RmisZObzV9y2Dw4FyG9z953pSMN5594lyTm6U+VUfJrIn+9A5pghZDVdblUDo0qERRWeP/PUo6UPTyUq5f0LMDXXFLhIdwmwn2Va8fYZS3NM5QoziGhJEKFUxQYI5kBYOhiauvXfmRvrS8zEukR38vxhn0/C9BYx7zvaHNez4Um69vOjKhcxVopHkHpvEu6V8XaL0x1gnoH9FFiPOBmsdfll36A7l7UauwU3eL+70d+khamZNiOLLTYk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bqwY19psqApEza/cQYzMw2EmhsIZpwpboICV9igs3RLhVib9wsN8ydgvgzoE?=
 =?us-ascii?Q?ktnLGVKUujjDtX8hwjjVeospyEyqX7OtfGsajYLicD3PwlWu/LqZripWxQSz?=
 =?us-ascii?Q?0Pg9mE12ENSVoQhucQF9Uj0hCtZzqx9zwiWCOueaFRCmM8XipMBqh2kuznRz?=
 =?us-ascii?Q?7FNe2pPBXgHYBYQvTcxfaglluePFZhEo5ELRJyMA1yuqc5pHUIy3bG7u723x?=
 =?us-ascii?Q?KPK3h0J+eZ17tllz1AEUZyTskUG7pi1UWkjLnMI7/ROuFHPEq96z5F6SMK7F?=
 =?us-ascii?Q?0zbq6V5xMGjzaLYPNa3mtSyAnNuFwiAVhojWdy04esWDNhVFS4gXQlP/O+El?=
 =?us-ascii?Q?Jfr/zR13AUh6CKwaBOqBzuYUh16QW4/AC7s41xf1nXUdPTP5cCfqVbcuTlv4?=
 =?us-ascii?Q?Ppj03fszsdyF9iiWcIWKwtyve7PS4g8M4liuEoWHZxLdohyoherkC6oIb2J5?=
 =?us-ascii?Q?XPJ+gOAPtZhDUVjN4AdBQ7HQ/r9Us/B6MiFzLy333Sl1jYk6crwk/zEipP1C?=
 =?us-ascii?Q?i+F5VwFS3F/aJPq/zuKDoQwvCr7J+flm9Occ/Xd2MaGBdQEmqG9SAvYJY+Fq?=
 =?us-ascii?Q?DhHvfJIqasBmvL4cDW53jxSYP/IxJuCVWfbNAaiZH8lTaTIiMFpU+pXQni2M?=
 =?us-ascii?Q?4zgdnDYoRKpcsNuOdIBqZvkDk/Kc2Becx7Fb9pgeyqxwFQmFHz9dJNCgaPwK?=
 =?us-ascii?Q?K74ry+B5uvld47iedBNUneUOVIKgHocqgx4G5OgVCjF9WjCWL7gukrlZGfnM?=
 =?us-ascii?Q?vGS/1hSo7yiPWlWOBnd3y19VeFD6HhG0MUCKAGnFibGHdk1Ix/a1lImk7tP0?=
 =?us-ascii?Q?NeqUXjKVXBtL8KVojQKDyiRzyn7xO/xpT0NFlWVLBTEMjmJH2Uxatigdv32l?=
 =?us-ascii?Q?t+NizjDaiRwUtHPuKvgEW9q5qWVZJx3i9OsboV1ryRTeU4x56uxB4S7A//KA?=
 =?us-ascii?Q?GsTbML28XqMQbhIEcHUZ4+uXW8ZVRv6mG5bru+i1ki6ywteQcLPsm5TBM8rB?=
 =?us-ascii?Q?FotkpUjFQEWi+XMmrgEgwL5TDlSHcVMEOHahuGoKwyHGaG4parsZd/7UGRB3?=
 =?us-ascii?Q?yB1sCTuzrEJX1+QGhtjVeBBuwl+tixkCgEYm6vQz0x3zJieMiDI6OgsK+PbJ?=
 =?us-ascii?Q?Hb+Thw/0KmLURjSnmJ6eoR05HKpCimxHVVzeGsCeEMTcSy2r7LR3z9Pr3BfV?=
 =?us-ascii?Q?rjMwVtTcozNyQDgK2TLING/m1eC2jiQgx5a5L7l2gKM0+/RvPtfY/czlyO+M?=
 =?us-ascii?Q?id23GumvMGyxsQ0owP2nr4cjhI3zDjWCCaigDYbJZRrGge+EIUDvYc4RpxNh?=
 =?us-ascii?Q?fSHqV7AJOBncQXFtO4VwSoaJRf+oSXehJChryysygjZnuqqwyNwucedi3JZP?=
 =?us-ascii?Q?mekGa8RvZWQicvLHIeL7KmBVKtd3JUXOm6wt/KToYspXouLIiuKEiqtltbVg?=
 =?us-ascii?Q?Xvq7CTh/f4eFJTJKJIzdZwMk48v/Y1sk2+Sb7ZN+hxY7QGB5WyTw9BPxI+9M?=
 =?us-ascii?Q?rHZHoiqmFezh+mWscoX4K7BJWWiGOR1Kf9QU5LlaguhUQIml8xlwKc036F8v?=
 =?us-ascii?Q?cOjzilW8VzqkdiDVBi8vq9pnICxQz0M2paxJliKC+3Rgly3jsbLySSJsq10a?=
 =?us-ascii?Q?lKz1MEJZ6aQZfv3Q7Zpg5AZsr6yXY6Ko6jpk+BK6qPmc/Wizj3gNgzIUfRE3?=
 =?us-ascii?Q?cfgYGHsFeixwty4S5j8G4Z4EzG/UX8Ok3m6F3qmAqlhzJx8Mi33WFNBngtyx?=
 =?us-ascii?Q?DXJa7dJOG7DjkF1zE/LdlzY1VzcClRM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fF+a4M7oOQx77CjCaKVulAwA7n4M5Rh5SokFVAS4NBszHhs92t8a9BonDh5mQ9J3sca108xFmwPlIsKTd2rMhXPkSRftsQHtQy8VAjHsst077Z462wSYgrbNASvEppApl1jYSbPyT9hCrO6E4W5RLZl4uAM6j5mW1pX+3yr+WQbWHHBCoZ7U6PIvxxZtcOHtExSFeBEjrknEkPKgNbFrO2QlYq5cGGeE8KpnJen6S27eOzLrqSljVZk0wp4XaMrWZhtFbN8tn70yE32W9f1Dm8uo+I9loawjRph//vD+AsIK60o+snpc82V6IHAtXpAx5UuefLADlX9Bcmx6vHWIbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2917c3ec-b9d3-420b-83e0-08dea50e6f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 10:10:55.1111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwkRs353RT7FPcJ11nZxfbtcPfWYKvQXvKEUKMhQO8t68ytNMEOEgv6gNHkb0sdrddZHjhGPT9zfT5LYOsk5bdaTe6oJPpoE2EfmgAmNfDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 8193E4828E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281775-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Larysa Zaremba
> Sent: Tuesday, April 28, 2026 10:27 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Salin, Samuel
> <samuel.salin@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v7 06/14] idpf: remove
> 'vport_params_reqd' field
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> While sending a create vport message to the device control plane, a
> create vport virtchnl message is prepared with all the required info
> to initialize the vport. This info is stored in the adapter struct but
> never used thereafter. So, remove the said field.
>=20
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        |  2 --
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 --
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 30 +++++++-----------
> -
>  3 files changed, 10 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index 3a3dc9892d16..0d08f51be7e3 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -638,7 +638,6 @@ struct idpf_vc_xn_manager;
>   * @avail_queues: Device given queue limits
>   * @vports: Array to store vports created by the driver
>   * @netdevs: Associated Vport netdevs

...

>=20
>  	adapter->vport_ids =3D kcalloc(num_max_vports, sizeof(u32),
> GFP_KERNEL);
>  	if (!adapter->vport_ids)
> --
> 2.47.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

