Return-Path: <netdev+bounces-132892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B00993A3A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6357F1C21457
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9EC18A94E;
	Mon,  7 Oct 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgKvGBKW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EAF155C97;
	Mon,  7 Oct 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728340249; cv=fail; b=dDymzfio1NgS0Nm11lvdmgfcon2eloZL62CX/gZMEJJIh2QqoGReTJ7qOZfAgJQrxOhDBCX23u3wcblHzoY14kkbUc0g+V40DrD/EvdF7+Y6PFq3VqdxB7Yzl1z3g17cEsmtaEa/zYqaomJhjeoEsojQ4oahahjVSwQqNIhkLKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728340249; c=relaxed/simple;
	bh=dAgQq+JbUjRvFwV+z9fE3cG3u9FdFG63hQL++OlByOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M5+SflmOflnT2Dog5nJEC0ly26KhWboiOe6d6sCx274ej8+ZceArp1GBuLangvw4bL7JN9eWmL4DGp9YeruVT5lZlQoD51pgWeImJktfIPpwcFf+kwnkW+eb7B0kFxG0C7BmCZYc7XIZvejq8xEd8T0koMOJk1NPpZFfZ3M6wjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgKvGBKW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728340247; x=1759876247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dAgQq+JbUjRvFwV+z9fE3cG3u9FdFG63hQL++OlByOs=;
  b=CgKvGBKW+12av3axDuNskzOTaGg0N6TOvIQRMPd0sHp02+fbB9HyCkrL
   rvcm9vhbKU/S7pzTb9wwkSNA2aEr2j33PjcSo6kyJJbLx+kX6SHNu+0D2
   cma/U3jCneGhLdxZ1jUuRi23ReCFuleTKPmWGRfOjog8VGdhO5vo4RfSD
   A4tn8U8Fojk97o9iALu28v44ZBSgxWbwy4aZJgVnBjtO7S846KGQwK8YC
   lvAI++Bv+wx73BZtpI+z3FTKe5W2noHBld+65YBy/U/n4HxP4qAd9EX+e
   q5IebFrwexKTu309NwYZGc/KCjPodpteWP+5A2L98ybcSvAJnkAEncayx
   Q==;
X-CSE-ConnectionGUID: fJZdcScRSiS/ABcxS0i7vQ==
X-CSE-MsgGUID: n58Fp4jsQemF1cJj9fmYbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="52911003"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="52911003"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 15:30:46 -0700
X-CSE-ConnectionGUID: UiUyc9AbSb+qM/t856Z1Mg==
X-CSE-MsgGUID: kziRl3W2RXCrezvMLZbgRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75871453"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 15:30:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 15:30:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 15:30:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 15:30:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 15:30:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz4YilXSUdTUfYbgX6z9ZXkoEsMpNUR2NKkOBvbYE+timDzo2449fQGGcOAQFxhatGlJAAmhsyAKd0XsODlWRENwUlAQKzP7ZbIJkRrEfUJziQK4uFNeFcj5LLcqDhRO4pE7+nVa3nywMPuhGrX072Qk38A3Sly9yg7rCJnqYcoVDnVyHvJNqJ+rx3doCie2xMvfJQ4Hfpvdilz5TXeyvTZDglAoJk0Aw3yN1XmJYSab1Hj5JuUWH36yzCgCNpvOSS8L7wVl43VMFXXWOzWIbMMyE4gTyM43XaXzzzR4m19/AcScUp0HbcF37h/9Joh/EgG8/IQy+azo9oz9r99Ymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxvs5DMwDIra7Yh8PgyOvFCnIU2yP7G4+LZnpdmpyA0=;
 b=Mx5wyoQ1QRgsOtuPMc3LoEPqxrHeHmSK8kaROItBkQN0bG2JSMVEEf30ummpaDaC30wBCTxIz8qo5+X0exQQqC70xYmGlExQocDCCwutQaF3YyyWMUJ71sUuBJMezNb839MUcD3nSLa6B6V8UXS1fD2w7o3v3NIBAb+98IkIuX2vLYgu6lFGKSYAoCTZMu2lLA/zJEo+WBPNcxjtjSr3+VZejcidRGO4RxoA8JYBNkEQcKPibqZBmuPXho94xRsuWCelyVgm1I/gQcdMnotbFgzqYqknf4oAROI6Q/wbzQM22F2vNrRv9tpvV5gG+f05cc6EwvuuilOnpsu5vKvzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 22:30:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 22:30:43 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Rosen Penev <rosenp@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "sd@queasysnail.net"
	<sd@queasysnail.net>, "chunkeey@gmail.com" <chunkeey@gmail.com>
Subject: RE: [PATCH net] net: ibm: emac: mal: add dcr_unmap to _remove
Thread-Topic: [PATCH net] net: ibm: emac: mal: add dcr_unmap to _remove
Thread-Index: AQHbGPkIlyOl0I18fUmh+v6XtCCKgLJ73xWQ
Date: Mon, 7 Oct 2024 22:30:43 +0000
Message-ID: <CO1PR11MB50892D82561D2A4308A7226FD67D2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20241007203923.15544-1-rosenp@gmail.com>
In-Reply-To: <20241007203923.15544-1-rosenp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|MW3PR11MB4553:EE_
x-ms-office365-filtering-correlation-id: e8f36487-702c-4ea7-467f-08dce71fae13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?grOwG2zdFr0tx1+BFfFGlUc7jkQjsOiaI/kScUtqn2pIdzs8cKBLQSzK0iN/?=
 =?us-ascii?Q?uwqAgd5eMgT4KoDFTJYYlmM1X9N2BwL6etklSX0mEVAxQ4Qz1dI19soIP14B?=
 =?us-ascii?Q?OpYcXBUK6hmaKCzwq1Gj+KMcMBMXcqb+PiJHYl1pqYugDENJ3tyJzFsaHygV?=
 =?us-ascii?Q?8Vd4o2ABQ19zmN89nXw64/RPiAxg90F9g/HNfEceF6TJcNajAwIaAhPo4A+u?=
 =?us-ascii?Q?/5dQoKJkAnJiagNT85XBgSA1QT1YcB+0IdZjoPrxFBUpPdLUaQD8Ro4pG+XE?=
 =?us-ascii?Q?nZjXRQp0g78tov9al1m4PbFbI6Fa9VITQA0QD+zz0HVaBqjSOz4VNea++XB0?=
 =?us-ascii?Q?hnNYg9kK+csn3dvJfw5G7hZppzfa1N5jcKtP+ycch6z5cTdF9YAYbUhCTf49?=
 =?us-ascii?Q?m3w/rvj2v8q9pAa4ky8lRNC8gF58RNs9VbJp6l36a3hj2vUBjJkTPso0y7+c?=
 =?us-ascii?Q?xGMqpzVORYf5JR/P+2ezYdCji6S4j4dZTYC0GUq93kLFG1Jk+1UsXq00Rvtg?=
 =?us-ascii?Q?lq4E26nlxAxy7Yb2Nb3QXTGyZOKdtJB0KOH/ZQRXTMZqTQeMeItqb2Q9l32O?=
 =?us-ascii?Q?w7ZAabKHTK//aFa7F95Vvrgt+DfQ7tnvbr6ZapEsiOqMKN/GE+drTZvnZlqq?=
 =?us-ascii?Q?TIX2+MjMRyhFwpgdGdwrium6Qs/3/InAsYqamWVaZDJP0gyIqWIxdatGIhr3?=
 =?us-ascii?Q?NVr2Jh8eAgHpoEkAu72ZhUxLFNsYsvN1vcU8zeSLOGDVI6JK6JwTLeAYuZVW?=
 =?us-ascii?Q?YsRRfckjNwjr1+qiGBml8t/bB1b9uppMC0m/8MWpWA9Fxm2r+htWrpputzgW?=
 =?us-ascii?Q?fuaB+K+WQ/FGFyDGk1RUPBzSIgVERhpVQELkSUxf2T26k6pBCzPD9fYumV4B?=
 =?us-ascii?Q?jy4A+SWmRAZ4Y8OZVotZAoocRBzDNCZ2hjFs9wdiWJOwze+xVJQ/41LaDyH+?=
 =?us-ascii?Q?6fnom0JTE+9r6l/ZvtaLV7OO6V/vG6mDK28K31kcfyIu0w8VFCLAIhRXdgP8?=
 =?us-ascii?Q?3H2+OrdP7UevALAGAzy+ruBpGEGsCieyfGTMmewqGOfmlkWFmb8MZSZ++0PV?=
 =?us-ascii?Q?YX463iQUbfppMhrKWx2VAxEJQtrRw1OIntlbLKYg7WK57nNXCUqGDeBi5UrA?=
 =?us-ascii?Q?i3/uULnwMekmRKuQSZtEGB8aNuoR+aXSoUPcBZEtIcimyV1ztiRIh7ihzBBH?=
 =?us-ascii?Q?Mf7jXnTleSfICxymfEgTdlwQWeprnjXJmslvoncFG28CFfzCGnd9rRc1yawF?=
 =?us-ascii?Q?hkVxmabZ9jNC/3+RjD7WQdJwOGZadv4LQNmmGXnm1dbFySWJDvqMDRcJY7bt?=
 =?us-ascii?Q?SlNjTzHvTxRPwblu49Pe/2TroVR5w4mHNONPdQPrtrBIkg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0GkGflwGHM6xUu5w41IEZzsv6VexNfECt4Na/lx/cThjNogdtQ05IlT+rfij?=
 =?us-ascii?Q?yhGOIh1Isbdvu6LfFl5G78jpuJtUC1FwY71m6kYMSPi5fEw6vpNKyMIcZ7d6?=
 =?us-ascii?Q?EblQBKxiMP5y+Se8q2DosejrWEjWjG9SZtGeTBrgNBE70wm5jy3WYXIqnJih?=
 =?us-ascii?Q?AswBmG+aTSGDDJa/uYvJry3kWs0VNm0TPpi3qcXbiUS1SBhpEWsxgkd+ESBN?=
 =?us-ascii?Q?mnzjeWRESbA4W0RLHz7qiHgxXFNUK90D2ko5mnjfbZwvJ7usn3MQKfJodZt0?=
 =?us-ascii?Q?7NDLBD2RqWQi7Fjaasrl91pbUhYK3aCHwnU2NPD8zoxtewAwKDVt7tkWCLFf?=
 =?us-ascii?Q?52sPb7GxvlF4CGfY4a1lQnh+m77nhPzbk5/yc/kCiMr2JlH9B2GzfdFTrvg/?=
 =?us-ascii?Q?JhdhqBnc19kOzhtXFf35tgz6ftD8+6Lf+iiEn0r8Glu5c6Zfj85EWIwbvTjz?=
 =?us-ascii?Q?dyriKXqWpQzLfrJpqIe9RbByDD6q5fC0mSCVrznAYm3HrJvyNslXkLEO7iyZ?=
 =?us-ascii?Q?lC+WEqv4Ykf2xU438ydN70kTE7UGaJHYePxxLTrrU7etkCpVpHCp0x850cEf?=
 =?us-ascii?Q?5YaXoXTbTX8tgibxzw54jzr9qjSNhebMwbloXB7DVj+vNIF0Yjjwb3XxPzeA?=
 =?us-ascii?Q?+gFxagCf0Y23W7SRL1ujn9cRlUMAhNp9xX7rdmv3g9QA+54R09NaXmHuxoBq?=
 =?us-ascii?Q?YduHbR3qwdOv9IOUGjQb8WnbE0librIBXA5knmP5VD6UH1+IjcENxVFZHhFX?=
 =?us-ascii?Q?0xA9Yj2+ycX3m2jEw5iIFeao0tQFBmMyeUVeNyydw/EH7JYorySbYutxgCHg?=
 =?us-ascii?Q?qYv4e9qlCIztLgFYf93UfFEJgghhA/Oe4rWQAMqGRil9Os2wygO6fa3SyTfo?=
 =?us-ascii?Q?e1Ov2j/ztZktTqgdOZF/LIMFXn7mPCLFgkYmrxxuAioDfoTjP59+XonlVaF+?=
 =?us-ascii?Q?4FAbwGtEQ5akS2zThKyPLR251ymUd2opUULGlzzZzfumF1PiZAOaKFcZ38uz?=
 =?us-ascii?Q?RYFS4Ub7U4Vqy25rKZYdyh79wI+fS6lsl1fkvHGd8dAoItbHQG4st5gTlxkd?=
 =?us-ascii?Q?sS0QO4UGMy46wWRYB9VlpsVUuP0K3ZQhtPAiVSfgM4uKH7rjPEAewdSplF6Z?=
 =?us-ascii?Q?zRIpw9NNjHAHWH+mzL88+30EwGvazySecBMVagW+kRzzHE6JERtmZEMlWsLE?=
 =?us-ascii?Q?7Ta1nK8jc4voGB8o5NYfB7XZ/Km7W/9xcT+LAdYoTXRuYmvpootBShFHgRGm?=
 =?us-ascii?Q?uJClpdssMh9bB8VOWIVDbOFG/LB6h8XzWMrtoWAjeQ51IlgEtWdx/WYo7Uyq?=
 =?us-ascii?Q?VzN57a2cAYfx3jM5Q9jp4mBq7KjT/WcXBRYl8XUZKOP07vqn8UNUxdTcSAEm?=
 =?us-ascii?Q?2j1IXFcohCAHSQo4WPx8lQLBMtQkkwTZPwqEB9zOrOqlOQIps+dsjxsYbddx?=
 =?us-ascii?Q?W+FpMhac/X7KAbn7xAlHbiU/MoczLyTOT8uKQ5eSoDhEFRI8CtXj7Ai9Yv9l?=
 =?us-ascii?Q?+BdkdIkanwrgpiE1xy3eEumP5Ce+/5D1rXjvYNOeCSexeAwlsWwSDw4wIyne?=
 =?us-ascii?Q?VCYuOYWHlJFipfQLBrgmQPD74hMJpSa8wd3mJOY0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f36487-702c-4ea7-467f-08dce71fae13
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 22:30:43.0241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbNT0lRtAshlam2TZtGgihp7OazaqsZrX4XEjvOoeZKbxctMdetwd3ayTRGtshzZInF2rIRGGQozbVXidhR8sR/VMPeNN0y/5n/jOJsNxUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Rosen Penev <rosenp@gmail.com>
> Sent: Monday, October 7, 2024 1:39 PM
> To: netdev@vger.kernel.org
> Cc: andrew@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; linux-kernel@vger.kernel.org; Keller,
> Jacob E <jacob.e.keller@intel.com>; horms@kernel.org; sd@queasysnail.net;
> chunkeey@gmail.com
> Subject: [PATCH net] net: ibm: emac: mal: add dcr_unmap to _remove
>=20
> It's done in probe so it should be done in remove.
>=20
> Fixes: 1ff0fcfcb1a6 ("ibm_newemac: Fix new MAL feature handling")
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/mal.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/ibm/emac/mal.c
> b/drivers/net/ethernet/ibm/emac/mal.c
> index 1e1860ddc363..b1a32070f03a 100644
> --- a/drivers/net/ethernet/ibm/emac/mal.c
> +++ b/drivers/net/ethernet/ibm/emac/mal.c
> @@ -715,6 +715,8 @@ static void mal_remove(struct platform_device *ofdev)
>=20
>  	free_netdev(mal->dummy_dev);
>=20
> +	dcr_unmap(mal->dcr_host, 0x100);
> +
>  	dma_free_coherent(&ofdev->dev,
>  			  sizeof(struct mal_descriptor) *
>  				  (NUM_TX_BUFF * mal->num_tx_chans +
> --
> 2.46.2

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

