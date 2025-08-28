Return-Path: <netdev+bounces-217699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D471BB39943
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6153B1A86
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818523081D6;
	Thu, 28 Aug 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtUaF+BD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAB3019A5;
	Thu, 28 Aug 2025 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375986; cv=fail; b=Bg1fQhTQyr3GUir3a/UTrApoUK3Vigi7+cJBRYt+cwsNnEi+oUGLjgtJKpE6wDKvIiTDAbcMTYOwXda4Jr8AYIt4UCpZ0ioDkTa0DGIcz1GKrXDGEfJ4RRAZhSFadqYnsG2ZyTyiwsw64KVI2x91Fcmj6eLtWZ75tFCJj05/Nrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375986; c=relaxed/simple;
	bh=ekKz+Hv95LqvSjRO65D8m9PbfMsxlgWipZHUKHzyJBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fo/tYyNwAH7oQwiZLkWYZApDvZq8uiDWtPh+NKec+as0iYTGHLBVYSI892NXLXfT8NA4X2NCtyUXPt/JpXKNiONzwHgMt88OXil+VYNzDU4qtdu1QHPQekkN9sOExnUKAU0yl2YkAfs/oUj/WsCIOYNb1aS1hjznIQoPDWI8s5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtUaF+BD; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756375984; x=1787911984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ekKz+Hv95LqvSjRO65D8m9PbfMsxlgWipZHUKHzyJBc=;
  b=JtUaF+BDAU3MzXawNTLDgNkBFUtTiWYE4Z/CD8o8nJNMBYAm6kvA5+6k
   q0Dr/EneOfc3yP5qF6Fjy49kpWei3n/IO0ADBdnq/W+iieqVds4CFWeXo
   xholeDAsJcx27GnmTDjc8JK3xa45/jIF3aXusOasSPGNPCTupcmYJm1dT
   Gx6yxDqIhwNlxmUp1PoCKBz9gTclofoGfDrcAPfUqmqw0HEZBt+upS/Ve
   rWxJCEc2eBTJNosQ8wYxK3IngvG2VDEemsQfraMethABFq1Y2KqYvoy+a
   CZL08vM0hq24KUTwiy2u6WM7DT4YBU7oQXXswQV9LCYb6zzCyVbLHFgY+
   w==;
X-CSE-ConnectionGUID: HBWDGYisSJqNWxJK2jffzQ==
X-CSE-MsgGUID: NseoLxXcQuaVBYaVM8CBLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58740960"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58740960"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:13:03 -0700
X-CSE-ConnectionGUID: 6YmtWAhUQlGZvgvbSDt91A==
X-CSE-MsgGUID: ChrILDteQVekpoU0z6ZX8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="175370226"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:12:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 03:12:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 03:12:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.42)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 03:12:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8Z2npgwk/XslPpFgOuYO6IcUe7eEAv1RAY4Ft2mISBnlFCOjW+BjgBxqomCM+nA6ha+w/dfmRAqEANFY9igwh3h9mzoEWc9o1WbBhyADpbHhNjqQGHqo9j0Z6d7XzMEQU2EfiqS+PcQTM/5xNRHeOz8KlIeapUeC/36SPjmYoaigSm0ADZqugIqrPzOxT7YvcCnsv4YN8tkXm422vfdwiJWAtMdj71kYpL2EZI1HzMRdix9pII0DXF3WEQLASBh/32KRisvFKa70iGcwziv3WbhAH6RSbwlD0RQx3sy9h0NwiY0EGkUxyEsOxUc3RpOSblXppmHOq1zvSTp8guBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stMDLxavVX3A3CYCcMqO6TQoxzyA4TfNa+h0BJUQrmQ=;
 b=vCOdXQClWtPKG4ylUOJuLDx9R65U10EcijJNC9L9sAfuByKXJwHH7/0KauE+GkWsDL9C7DaWnsssAjiG903UY6p4DRMKBL+uw7GNCaXSdJ56l7q4a4jU8EAOvFu9lm08ZAId+LQy2BI6HflQ+/srTu+VKfxXU/CRZodKqc2HVGNtqWqpePBKMDvYzvpT6d2SvUoCblG9hE37S9P+sxmUdhAcsAWReRWJoFV7IDrEyRFOUocm9DWpDIVlHowwC9E7Yk+Y2CNhMLJhOCHuudygc0u0WHqDyCqJpIPrrAqGuXwTyxKgBNjxGz/t/LD1FhgYyghfSoFOjMVGPDvx0KqkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SJ2PR11MB8322.namprd11.prod.outlook.com (2603:10b6:a03:549::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 10:12:46 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%3]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 10:12:46 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, Kohei Enju <enjuk@amazon.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-next 1/2] igbvf: add lbtx_packets
 and lbtx_bytes to ethtool statistics
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-next 1/2] igbvf: add
 lbtx_packets and lbtx_bytes to ethtool statistics
Thread-Index: AQHcEFOR/5nP6iL4AkKvvMLak3QJDrR2eywAgAFstEA=
Date: Thu, 28 Aug 2025 10:12:46 +0000
Message-ID: <IA3PR11MB8985A48DCC9AC13F4970757B8F3BA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250818151902.64979-4-enjuk@amazon.com>
 <20250818151902.64979-5-enjuk@amazon.com>
 <20250827122712.GA1063@horms.kernel.org>
In-Reply-To: <20250827122712.GA1063@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SJ2PR11MB8322:EE_
x-ms-office365-filtering-correlation-id: d3706bb4-1425-4c04-eff7-08dde61b6f93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oq6IvEQzxlC86bQrE6QkEgobzDwv1Rq5UdCgK2ZJ9yCNITWFTjmoavxGfmpf?=
 =?us-ascii?Q?BexRs1Oq8ftiR4Z61Sd973/CQqGUV0roWnXp+XcYKs17XcX0FAD5dD2skapX?=
 =?us-ascii?Q?OkQksh2KXC932EcpOXY8xMqkqGSTUjp+/2i1wgDzTj82Dz7SAST1KViAUrSh?=
 =?us-ascii?Q?XZkcnGSDUTUh6eAg+sNmWYcGlPefjTosEDXA7O362sgFLUUHdBdMAeaLA2L9?=
 =?us-ascii?Q?OD/mPWAmZZLQ7jsyoKMGl7PbDRDLDu+8qDSqT/3zJVh9jfnjdB11L/m8kQXe?=
 =?us-ascii?Q?d5GzWL9d1NcEOZjIs8AYqEFW+2G8Ai2KJyqKv/eOetzkGYnKB8PATrp8O2UU?=
 =?us-ascii?Q?PNZbMhrVDRw84jCaZNOoSmFV8IgdLEM7guN6yVVXMYe2oANrtTP8rNeahzwy?=
 =?us-ascii?Q?+Fk6JcALFnDv4K1VbkWX36x7SdvSYzar9BpMgWrEYtTUbepcs9MaR6DDo+Ut?=
 =?us-ascii?Q?m8LsQVoP1snQc0RMdbD0xUYJmplaqaxh9FhT/2YdxK7pdj2ycWFXRfyrexSJ?=
 =?us-ascii?Q?0v0yQ4K7rkoQsAk9WLVyZdbAqxOp1CfX57HRH2T55+zdazw66nMptOLfjWux?=
 =?us-ascii?Q?wVS4XSAN1A3q80xrVMMDeeQiWfD6SGTfVeXbxprGvSYozbmVkJZaj0eGO+io?=
 =?us-ascii?Q?fbh8CO0GXoGO7ZaaMH8Qzyt8KWZ4apLXYJ5w5CiFg9fi6jSMJN4TXHLOZvd7?=
 =?us-ascii?Q?kaoUclhCDxsboqm26JLZcT+d2X3k5kHjeXU5/pK/1IInuTstNKdDfKWXJRZR?=
 =?us-ascii?Q?YCeQiGjUqzBM1acjc5kf7hnXxT+WBlo8mfEdc+JLEeLGGFrm3T5vkvpdZoOi?=
 =?us-ascii?Q?0aXKScgVkN0sypVdPp9iRpujzA+9GABN8GsDgChw5pmYY7M3yN0Wk2QK2jds?=
 =?us-ascii?Q?O8oKGuY6sdcqatPDnCDx+7FqFepxKPT2WnCofdVdV0Sdpft/Dy2GekrZTv3Y?=
 =?us-ascii?Q?V5OsAZiFodDcvF83OWtP48ojpqK4SHD3hmb9spsIi88UHRseq7QhnY405OzG?=
 =?us-ascii?Q?PtJvNl5eb0MQ9ae5euY42H/pnlaPv4FiZr92uVMQRBNKLli3mGEA02rW11YY?=
 =?us-ascii?Q?gw7XtObI9hJeAjxdtCm97b0hOIigKFD0V2ZiuYnid30wez9NlBPRbcCmD+xo?=
 =?us-ascii?Q?ZOKNckzdhlS8maldOlEK8PpoEvYu0qJOFYt8OjiWkmQ7KJN6HgXVuCAYv4vz?=
 =?us-ascii?Q?0q4cc5ZD/n/oJRmfdGr4uDdf9HzKAAvVjQc8Z+KgEMHWJz5/5C2KBVqJ7V6R?=
 =?us-ascii?Q?4B+RXTYt5xBmJri/AXauuIrFgNcOvI/p3I/B+rzHNZgdUJitzCrq2YBaU/iK?=
 =?us-ascii?Q?1ep4QcuhY15H8WEW+AZGnIxXWJ6ZpAHxHaQzYRKJxuL65q1n9Mp0meWwKV45?=
 =?us-ascii?Q?qKZca+Mz4XgL00jnSElxL5Un2NmiHqn1t+37713iLNFrJ9SsTw5YahjorxfM?=
 =?us-ascii?Q?N/lTRYMkZCswNsTRYf3hUZe+/BosGHWVmRsKxscTEYYaSotiKOFkEw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FtKqyWf3H+37hXj2bnd2BCnFxvblMlMq38n0JCPW1dGBClsv8AFzkhWOi98D?=
 =?us-ascii?Q?T9BqMbSKFRBHp/Guqc5EgVXMP7elAzVSbOmP0J6N0CiiV7lb5O8WzpqlhnUG?=
 =?us-ascii?Q?4q69KgpbrI0ZoFpoPH2NOijbLIIqz3bPEOW6hbTNRvlXOe+CDAWOmQkruxgl?=
 =?us-ascii?Q?35TNFLE/N9U2xuhyN2e3l/KpSxgEsNPAg1eXW9XaOmHIlR+yrM+0fTy07ToD?=
 =?us-ascii?Q?6uAtP0LrhNG2CfyuHL6hWxbcBnc55DC6xtlCukXhUviewu/VFgOWonXjY8pd?=
 =?us-ascii?Q?1D2W9G1VZfw5uIvg3H4pNcIC03na4BxCs7vzZfP/mDL5YOWkumodqOqTbc9a?=
 =?us-ascii?Q?Nf+4YvsDdjp6hNBC43VnTNAX3Kfk7Ka0Ky7apW5mPq2SStqpXasO7cprkQBT?=
 =?us-ascii?Q?qvsLM97y/q9C5N0epbOUU6iXBrp1Kyi+vsHVEjxVNWSSeSe7rId8e9gJVWQt?=
 =?us-ascii?Q?OA5WzTbqKfKEXXc60laVIU5z9dNTTmxO2fGKkj5RhLPYROwItcQYK2lia0tL?=
 =?us-ascii?Q?2iAEIjadEiWLnyx2o9owbihntY73MonCDBJ+h+EhwtkMfqdx4Oc7c5mPw0QW?=
 =?us-ascii?Q?RZyMh0cUo4Krq8Nu4wOAn3HDRVZzHMKnvhB/lxe+cE9+ehQSXbt8CwnD/yjN?=
 =?us-ascii?Q?XPTl9iZ+g6uNNBfSwzqymAMtO4viunCMeKuc+oJyuM2T8eYe3y0xp8wIQbB2?=
 =?us-ascii?Q?hRkv4uyKdf7Ytv8wZjOtxuHqIX1tBvDFxX/fLYiv4VsD7uOyqMRoZoYYEnye?=
 =?us-ascii?Q?cRAuJhPjgXa9S//7iUS2i+wNlRX7y94NFab1iO6pg+NbLlDxcgi1csvZCghE?=
 =?us-ascii?Q?SeOgs0UMAC/crEObPOBDLC1+nvoyMNF0SK6T6DYgVIjcYxHjwcgBvfLhHQ7X?=
 =?us-ascii?Q?SgCC3y4gAnpPmQql/Bfe1uvPl0+i28K3mYriHnHtd7mHlqcgG5fjEmTfJ9Xd?=
 =?us-ascii?Q?C1xk4tKJJyO8N5OH6JAlgvgScQ9FoQMcfgd1bhYc7SCtw8p1QcpPP3s0K4M4?=
 =?us-ascii?Q?PtYaTn6pofzSjizyAutxuhC6fWnl17CNhDnbQ/uA2Wb0P2tGSnAUqFyeqRMr?=
 =?us-ascii?Q?/bZZe/GrFD/d8hkquXonOzWzZq9It4c8aQPm3NvN34Qaa2whQyf8c6WlrHU/?=
 =?us-ascii?Q?fBQ/bBu55rdh3ZzgadNLQdj00Sc/zrdvHxz+KQOwGsH0Xmb99Ilbc0WGM3qF?=
 =?us-ascii?Q?F7VdMpT7GVP8hziwFeEJqaDhRKYwuTmfN4nHFfiebpv3zeQ0KA46qYCJ+bAJ?=
 =?us-ascii?Q?JV9voz+J4MiExXrf11ug7+cABAyz4sfj8YomjoUfB2xHTaRyrAOwx0cVBMLF?=
 =?us-ascii?Q?EyfEXzpM1lD8ErIgtgJcDlALIaP8pS14l5YEn5aycXBwQ7XX5Z1Qx1sb4rot?=
 =?us-ascii?Q?KEVUpS83Ok6XhXZ74ULM5WRk8zsdoFA1g2P7fRM1vUz4n1dMunRrm7vmIpLk?=
 =?us-ascii?Q?61D63PQRvG8Ui5ELhC4GWFRBUnyWIH46wrerutwG8ezJawFV4lac+LjWu52x?=
 =?us-ascii?Q?zDJYQIWK7nqOaNjXV/ZdjtPEZ3z3n+Br+IY/ulb39ko5d5/pIr7bHKKnZ6Jx?=
 =?us-ascii?Q?ykSwpxrlXc9noCzFRxGdvZBmWk7F1aJ+5kXI3qlOwobKeYhihmPB0IJmMcqK?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3706bb4-1425-4c04-eff7-08dde61b6f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 10:12:46.6925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6qzqwwBdXQ0MOmLTm57PgsbfwOymCnkIaN9YmLIa3FioN2kbvzEHP9VOdgprIE1BWH8UBh9gQKMNhzF2F6MXHwVAWbkMvNq84kMN3c8Ws8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8322
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Wednesday, August 27, 2025 2:27 PM
> To: Kohei Enju <enjuk@amazon.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; kohei.enju@gmail.com; Paul Menzel
> <pmenzel@molgen.mpg.de>
> Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 1/2] igbvf: add lbtx_pa=
ckets and
> lbtx_bytes to ethtool statistics
>=20
> On Tue, Aug 19, 2025 at 12:18:26AM +0900, Kohei Enju wrote:
> > Currently ethtool shows lbrx_packets and lbrx_bytes (Good RX
> > Packets/Octets loopback Count), but doesn't show the TX-side
> > equivalents (lbtx_packets and lbtx_bytes). Add visibility of those
> > missing statistics by adding them to ethtool statistics.
> >
> > In addition, the order of lbrx_bytes and lbrx_packets is not
> > consistent with non-loopback statistics (rx_packets, rx_bytes).
> > Therefore, align the order by swapping positions of lbrx_bytes and lbrx=
_packets.
> >
> > Tested on Intel Corporation I350 Gigabit Network Connection.
> >
> > Before:
> >   # ethtool -S ens5 | grep -E "x_(bytes|packets)"
> >        rx_packets: 135
> >        tx_packets: 106
> >        rx_bytes: 16010
> >        tx_bytes: 12451
> >        lbrx_bytes: 1148
> >        lbrx_packets: 12
> >
> > After:
> >   # ethtool -S ens5 | grep -E "x_(bytes|packets)"
> >        rx_packets: 748
> >        tx_packets: 304
> >        rx_bytes: 81513
> >        tx_bytes: 33698
> >        lbrx_packets: 97
> >        lbtx_packets: 109
> >        lbrx_bytes: 12090
> >        lbtx_bytes: 12401
> >
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Signed-off-by: Kohei Enju <enjuk@amazon.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



