Return-Path: <netdev+bounces-268040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UET/G/qxt2m9UQEAu9opvQ
	(envelope-from <netdev+bounces-268040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:32:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C56D9295A46
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B09CB3010144
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A5D34EF0A;
	Mon, 16 Mar 2026 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4sDbgib"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8291C862D;
	Mon, 16 Mar 2026 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646262; cv=fail; b=BPnNphDKf7LmWyJAgbXcuk0ijX0sWPK9GYJD7/UWXx1t9OYuJONNZSNf07opPcrrnG1uLuT2TRNsvJ9jxATcyS6mzNCo3YWFd4HYFpSYTHjhHspXYWqTJq6w57YeSE0tTAimElLeBCk2DgalkaDligdAvuzSwwKgWiVpDkKwjWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646262; c=relaxed/simple;
	bh=HQnBzOnfZUb0VylK5U8oTjv1+Phz6m0YyXpymzDj2MI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=peUvQY+qbcDx/eypaRqd+u1EPwnTxrpHu2V3Ia1pe5ba53OBlDotTFEuGoIUoW+SMtutwsD0bhfWyXFPqJq+h7Xt5GEsu/nS2xmzpAvUeD1IFCM24v6mVDKPvoDfpkPY5nmg5FR9YYMWbnYc8uftj1TcfIj50u2wVUgjLsR3RNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4sDbgib; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773646262; x=1805182262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HQnBzOnfZUb0VylK5U8oTjv1+Phz6m0YyXpymzDj2MI=;
  b=X4sDbgibHf5FwsaYvJUqaPgcuO5afbFfPe2vprAx6rtNFwdoWmfyYEJV
   lA7XzpSkXgnlCdwKkwBbhcWJuVDZ052XXoNHRG9k14SonYRUiJlgxpNH+
   PUdG8seMfI4tf2WK7AsfqH9NLIQwnsZSDCR5+6UkUsSH2iVPATeeETZef
   BxnY7scuCcuSaSi7qLLCBrIgPJxypCH1DMykDbMb+1a3LG4BPNpKuCD3y
   2N+WuravTu1476vVqy3NvUstxp8FNKIloZ7TBcwf93ttim7UXajdJklPZ
   GJQCXP4Hlp2+WEhx5oLjUzKjbAZ2KlRjSmMe0r7EfAtlmp33rgxG33qEV
   A==;
X-CSE-ConnectionGUID: h+Bkdi67RWiDde7GrgpNSg==
X-CSE-MsgGUID: J8htGHImS0KFV7q2ualwuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74548393"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="74548393"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:31:02 -0700
X-CSE-ConnectionGUID: NVn1c3juRF2vZOwzbJPk3g==
X-CSE-MsgGUID: sSIvY73ASx28Fu3adDE9Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="219428644"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:31:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:31:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 00:31:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:30:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTparikYhG28qccgcecOZuYn5Q/zMJcmzypQ1D/24fZfDuE7K0c7Cp1ejFHYYyJUOeHxdgbbJ2jZNS2OWz0S5XSWvwde9mt43YUqd3Z3xNWDrUhXgaHMbKqbV/EE6P4SUKqBWnm8M19RmlVs4VD8RLLu7uLp0i61xuktsQMY+9b6K36r+B1cno7upnDNIdutxWZRsGZnUkQuPh3nzKuwIukyD6tFi+B6zAlzQxKoitJtJFD+BBUZwIzPx6B0EQdCq9B39OBCbCeOmldfTGCZJhGgUOauAlRdwrXJdSBfxFu6YMcfDFrnjDLSW79z8O8FB4Dr8ZX+afK7c8W+j6lxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Izv3sV7V8t/2XblD6nIZy2Dee2wqP5wpHku0BUXl7m4=;
 b=g0vHUNdiaTcDNZ9XHxocuifQ7yYm9U5PXiRqe+OuSDTP8Zk7drSgOM+ifEunBFf3VrPljZAiaIbFnShorh+F7QhrrhRcDm4cqzKRd4cRhngodV6Jfto9OaWRVilZhyVhM91EOdoQHJ6k/JYxFodjABVgyu/NzX2N4qheOfsd4RJyaMc3yTpV99QjLmi4LjSjRxGV4a0NcRAsmhQXfqnZQcZnGOfPEDDUWXmb8UJQSzBBlyXsNMy3ATQT10siK3EnZAwFhjuWaDOMGHnZyusGrNPsLB3l/xauWTw7cTY6xK5yH6nHbdiNG6mapi7zDEPrO9oPuqrc2DdqKa6kEY/COw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF263E38237.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 07:30:55 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Mon, 16 Mar 2026
 07:30:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: I Viswanath <viswanathiyyappan@gmail.com>, "stfomichev@gmail.com"
	<stfomichev@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "ronak.doshi@broadcom.com"
	<ronak.doshi@broadcom.com>, "pcnet32@frontier.com" <pcnet32@frontier.com>
CC: "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v9 4/7] e1000: Implement
 ndo_set_rx_mode_async callback
Thread-Topic: [Intel-wired-lan] [PATCH net-next v9 4/7] e1000: Implement
 ndo_set_rx_mode_async callback
Thread-Index: AQHcs+CEbYEltiRCMkqShlS+0oHta7Wwxc1A
Date: Mon, 16 Mar 2026 07:30:55 +0000
Message-ID: <IA3PR11MB898620EE4E8B4D2D75E9A7DBE540A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
 <20260314182809.362808-5-viswanathiyyappan@gmail.com>
In-Reply-To: <20260314182809.362808-5-viswanathiyyappan@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF263E38237:EE_
x-ms-office365-filtering-correlation-id: 84095011-bd90-4250-208a-08de832df5b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: HjLXjs74RvYBc49PigOliRlLkRTIMU+YUyB+kN+0KEZJ0wtnX7ZqWrlFtK++U/bDcpk3YyyO80X0cQEHiIhtK2vphHU5PxOIBiRxAdwigb7kX9JBkr81C5e5142WvFQXa/pfTEd1Ng9ZGMgS80b8H8tJGP+StUy/uCg9OJfvOrd5xDG9cbySRrNYT2QR81E4EtGYoYaKA8Xdb51VfmzOSWiIq5BGJe3Bn0ICKvjyHJtdRR6wX0c4e5l+p7wnyZruqltP9aj1BjXX6Kc2SKrSSHDlI99zK6S20YD6oNFv5q+kVxWQTzJTtAdR5omUmh376Ioh4Eq4WhgKYZkUND6+8Rn5xUlnC+A5s2pQVZys5u+TGhn4cgVZaxgbi+Kb948RdKtme14rO9FkwNOqxxrC5b3OigjdHVITHTbikIDjYF1G7rOlHgnpw8wqK6TiY9UOnAZdtaJyD2nSNtYGOLHYwNkIPei9ufadiVWY1wAGYLecXBreHLvJ3X9Rq2XUOhl27Q7Hy0fmuC9GB++vVF8bb5/yGDqdzL85qZv10b5PpRU27+lW2xCcWPcdcQNEUaN3p5GvVjW1Y0YQAZPGCFCbubYt6WY0scVNjXNuqs2E1pYM56YxCNa+qwPw3we28xWxh9BXN9dPXbWfyfeiLRW/oyAVIw2XSYo4Sz4S4gHfDtxAIhP5gPE2nXv8LcF0C0i784bn7+zp2sZf/aA5K4D7IfeRNmzvrIC+Xtu4/qEAeipo2m+52lEbNCr+cU/9R8CxZbrZuzzK8CTILwhyaBb1QnqV/xyLrProO+1BaTJn3Mh7SApmQZop/F5bzCZmXDgh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5hQa8AhU/4xX0UdXz5ctNwoGqruwvyZvbJkbHuNeP0kcyuJ8aqZEwQoTyw8m?=
 =?us-ascii?Q?wwOpg9oyuJjSAa3Ax262bX/cdobniB4305WXBikDzT4dqsYgcuLn95IFASNc?=
 =?us-ascii?Q?DKTwqonohc9DKH5Pc5OOUCKOTaRmiwIBgYfcM0Tsih5FaGiAN3LyxZIJZ0iA?=
 =?us-ascii?Q?VuvaF01Cc20N0T8PK2YUdraOukPN6FKSdrEl9bMBLvl+py9yePec1XDVIWVe?=
 =?us-ascii?Q?zjdwveu68voKFbsHi+KK0msR+wyxD0+B518oiQ70e9BGVrlWGco5Cddhnfhx?=
 =?us-ascii?Q?jUReglEXiKE9BfPIL9IcUzHU7E8K8C9susyqs/ZV8LNRKUiNWqOKmRo5dDMs?=
 =?us-ascii?Q?0R0VNksLNly8BZfa66czY2fPZU/1+SzPT8C+UYUQgqaqwzFCWj8/cyWluLxF?=
 =?us-ascii?Q?LOZGiSJKv8BTlcBs5Coxzz0thuZidqQQzLTkB8MvNRKd4X2gQEBYU2grV2iP?=
 =?us-ascii?Q?CCRFRa5uWiKG92WqdebxITJPX7OrbF/vYILjBnV05wTG1ovP2FMX3iOR5Qtf?=
 =?us-ascii?Q?r1vtGp/lFLx60pixGXIiVAQwDd+q66hn5cZd7sx+QwGyoaC7JV3YrE1/OfoM?=
 =?us-ascii?Q?wKtmcaoEjkKnkeE9VXj+yAg3w8pfXGjYWA5PqWrwrme9jTluDYWKuXloniXn?=
 =?us-ascii?Q?+Y8ZrYzhEG03wafxUxCnzgaUn0hqNKju4ckHA2L7hwQMZj892eGUM3p7M0kC?=
 =?us-ascii?Q?5ehq9VDWyLN9uuQ3s6fEtPz78+DvgqCdPyJfaxLf+2p9SpZC+4c0ewTzJhdt?=
 =?us-ascii?Q?OO+b3nIaa06/43Li4GbG1FKKuP37bB/2yT23bLPNHUeBIVvTrQ39BY/5tmZl?=
 =?us-ascii?Q?U+JHzbjIHTrg9DreHTgVtvCLVc7gXj0EpzO50GcTDnvT9jUmAMz6FX2xydbu?=
 =?us-ascii?Q?scb95afwAbaBu9rmNE+brLjS22zwVv+pnfbdJi1d0Kt9Ak/i1zi7SmrAp1nS?=
 =?us-ascii?Q?AzeMVe5KhRoau5kEX4ofST5Wd7F+50sM9DJhfLsFSwmbx8nVWfLiJDVWSFsi?=
 =?us-ascii?Q?EMpioJMMCFV4gtLYb+Vuq/1VP37yMYWUpcm7kUe+fsX4mAavAyfgqQar44/e?=
 =?us-ascii?Q?++q37+ZeTTeMUXPV5mLp55TA7pPKpiFxnszsQGzNvkIrsB78QpFu4CDhtpcD?=
 =?us-ascii?Q?1qV2Z5zCDkHWP3U2QLnOb3wGGNWPBCXiE5nJx0xQ9xsjq5bPQszXrovvFP7D?=
 =?us-ascii?Q?fsgpVD9xaH0mWEygcZz/bslzEWMbRCPc9ilYgpU9FarLWnKnirEqTPmHUqyr?=
 =?us-ascii?Q?xXs36yRC3RcR1MAVaKqB4fs8dKQ7QWLo+jRJz2Z98Mb1G9htb76ERG9O/Jxt?=
 =?us-ascii?Q?tntKGad1ajjbWlHILRsstKgjDHS0rkjl3r4Zxhudv4wpzXYSWbKYx6dSgPrP?=
 =?us-ascii?Q?NomnR9308ebsf1JD1z4wt7mMBcjrznYyC+3sAavSHddALUXbE9RPlYrCaLhP?=
 =?us-ascii?Q?S98e+lkPd7/KuSQx2qJsF8S7cZZ8Hi9vWP1xMnuDQa258mYYZFuVU8+Plqkv?=
 =?us-ascii?Q?0zbyHMgezeYk4wtYa89tLty5lII7Nv7YA7lAIDIDkwwdbe/gUj4eyNnhd0IL?=
 =?us-ascii?Q?QLcvL2NoahkosoBuoZVjlMlVp44sZhLmTEWozUollYv/n1Nsme661Uzcd052?=
 =?us-ascii?Q?4CWrVRnPIMAMEOVn7j9QWE9tQ+Eg2UWixKfccuSYNMBtophO/QNkTzkDFMtC?=
 =?us-ascii?Q?lRIzR1T3krQeesAilAx7He1xGMEOSTTPTTOVmhn6frGiAL/Rpl8SerAmcL+Q?=
 =?us-ascii?Q?65QmujgM2241eZOpWkNeOHKYgS8j5js=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U8XoieyJAc4c3h/8STWi3PYg2BdtLJ5tvoyC+m1deLXlrz1mMtxzK0/mwycxxVIENs4qG0wJC+E+fz0JDdXENT2nSqTnsD/QOJyRse99WSkUQy0ymfhOloGSEVzmkDoVIZ0azkcV7dBgTkdkm9pmyCk0rM5xhngaK7bJU2SbfdMPfmraJzDlBhj9/Xc9BiOdFPBKgEzxRQYqbGZGe8iVW+r3heaZJxFgpYQrZAqmI/Yc8kYE66/MSLisI6RIVZvEiP75T00f/+fqQxS4hyuy5LrlFAsTRaCH9b2/IdAU4QpHXqAB9/3NnHvgsgDq6cKars1nKTul4+I8V9StsDcWWA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84095011-bd90-4250-208a-08de832df5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:30:55.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xO2douLY3XO6DLG5gwDX/lUlcAMYNaqja32f+2ZtYYJPNncOyr9V099RZhQ29LdV2l4UZWaJ4GUrY97/pemuH47TrM2l4Gl0bMaVLf+7fcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF263E38237
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268040-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C56D9295A46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of I Viswanath
> Sent: Saturday, March 14, 2026 7:28 PM
> To: stfomichev@gmail.com; horms@kernel.org; edumazet@google.com;
> pabeni@redhat.com; andrew+netdev@lunn.ch; kuba@kernel.org;
> davem@davemloft.net; eperezma@redhat.com; xuanzhuo@linux.alibaba.com;
> jasowang@redhat.com; mst@redhat.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; ronak.doshi@broadcom.com;
> pcnet32@frontier.com
> Cc: bcm-kernel-feedback-list@broadcom.com; netdev@vger.kernel.org;
> virtualization@lists.linux.dev; intel-wired-lan@lists.osuosl.org;
> linux-kernel@vger.kernel.org; I Viswanath
> <viswanathiyyappan@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net-next v9 4/7] e1000: Implement
> ndo_set_rx_mode_async callback
>=20
> Implement the ndo_set_rx_mode_async callback and update the driver to
> use the snapshot/commit model for RX mode update.
>=20
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
>=20
> Call paths involving netif_set_rx_mode in e1000
>=20
> netif_set_rx_mode
> |-- __e1000_shutdown (lock added)
> |
> `-- e1000_configure
>     |-- e1000_open (ndo_open, takes lock)
>     |
>     `-- e1000_up
>         |-- e1000_reinit_locked
>         |   |-- e1000_set_features (ndo_set_features, takes lock)
>         |   |-- e1000_reset_task (ethtool callback, takes lock)
>         |   |-- e1000_mii_ioctl
>         |   |   `-- e1000_ioctl (ndo_do_ioctl, takes lock)
>         |   `-- e1000_nway_reset (ethtool callback, takes lock)
>         |
>         |-- e1000_change_mtu (ndo_change_mtu, takes lock)
>         |-- e1000_resume (lock added)
>         |-- e1000_io_resume (lock added)
>         |
>         |-- e1000_set_link_ksettings (ethtool callback, takes lock)
>         |-- e1000_set_pauseparam (ethtool callback, takes lock)
>         `-- e1000_set_ringparam (ethtool callback, takes lock)
>=20
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 77 ++++++++++++++----
> -
>  1 file changed, 59 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c
> b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index 9b09eb144b81..ec25b41c63b7 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -99,6 +99,7 @@ static void e1000_clean_tx_ring(struct e1000_adapter
> *adapter,  static void e1000_clean_rx_ring(struct e1000_adapter
> *adapter,
>  				struct e1000_rx_ring *rx_ring);
>  static void e1000_set_rx_mode(struct net_device *netdev);
> +static void e1000_set_rx_mode_async(struct net_device *netdev);
>  static void e1000_update_phy_info_task(struct work_struct *work);
> static void e1000_watchdog(struct work_struct *work);  static void
> e1000_82547_tx_fifo_stall_task(struct work_struct *work); @@ -359,7
> +360,7 @@ static void e1000_configure(struct e1000_adapter *adapter)
>  	struct net_device *netdev =3D adapter->netdev;
>  	int i;
>=20

...

>  		}
> --
> 2.47.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

