Return-Path: <netdev+bounces-268037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDl9NKKwt2l3UQEAu9opvQ
	(envelope-from <netdev+bounces-268037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:26:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E25295944
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C37573013D6F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E597834EF00;
	Mon, 16 Mar 2026 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9cD/DvB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904034CFAB;
	Mon, 16 Mar 2026 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645962; cv=fail; b=MUkLtBQm1zOs1qFCk8My0ra395J1EqGilqAbWIXvpJh5nRrTl9ugM+/NNqwy34EUHF4bA2rKiyBvpCX/s3yi5A+DBsPodX6gHyc4cXgtdUh3hQLOBd0e0W5N4ApED6BkKoe8I4LTDlk707/GHaCmIt+94461hkRgzQTQFeS5CFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645962; c=relaxed/simple;
	bh=ZF/vO7TMWmIHg/+8Jn2/6sN+rk9fIDB88A/cmbDQhdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pzSxD7uJLhi9MC7GBWhkAccH57CXOLAQSP+oEChc7xbHSkJgh5brnrlhN5F6NIbDX/g+KaffX3SBzggQKbrSNWvUjjZRzsCWL9AXRtKxtE+ZTaGFetKJXiSRE4OI+QGGfB0h1ME+/ErpP/ZT9itKxV/rDOr+xfgjtVLsk68fCLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9cD/DvB; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773645962; x=1805181962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZF/vO7TMWmIHg/+8Jn2/6sN+rk9fIDB88A/cmbDQhdI=;
  b=O9cD/DvBTqA6mfqP+eq1GwZVYJwLbfMr3p1zVzC86mMZHzWeqcbynrNg
   3jNAtG5VUvl/3qDxjpB52Lef81F16rIP89i02fjYJpBGlyrJ1ICZRA2AI
   KbUyJdjBOMOf9SEDanelBExX/xRx6QSDSki8onPOX2EovYPp3Uxbr2B9D
   r764fw2gGZKP08MbiXzlVN/wNt5NKVOi6oNbvqouWIyfMPhYWjVDfH2zc
   9Q5JRddQisDgnYh44/jt+55IMRlnFx0ze1z5wlRyEYVIxgeAQT0Zi+RZQ
   LOYv7t0nCtI69/8yE4Rvr2LXRZ2yadMBsVfV7LyKZ7gh7n9Zxiqm/gVCs
   A==;
X-CSE-ConnectionGUID: Bi5/SBFxQp+yW3zlxj45cA==
X-CSE-MsgGUID: qvMWgJq+QJebOkqT3Bcxaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="85283165"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="85283165"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:26:01 -0700
X-CSE-ConnectionGUID: WF7SVTqCSoOz9EOC9vVfBw==
X-CSE-MsgGUID: hR3nG9LmS92lGxLbtS991A==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:26:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:26:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 00:26:00 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:26:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aif2vWcTxSJ9ZnHA9FqhK9B2pVTztX0I4I9LX1ckG4WUFngnBlaxvFvpXom783FyRjRSNKkUcYUnAIlYpvVwc0Tk82uRlEMSzub8/N5s6kHnZzfkT8deW7J5WOVGkPaMc/Zm0q8mXf0TX9Mfag24wQGlvRmnI/YtqZNY5MYRIgrevkBnuJZBJIIfL2rQNO+a5rj+MTocjD1ffEjVBv3VEZ3MXRfIppp5/m11FiMqBN/gQ0VmFPsiP5v40KYM3wQNHvAtx5WB5CHUwGwaSffLo065LLIfKhmfIPNpyIrkARKhvrBttkN6GIcptAbwVHO5MTN/uo6lirFghqv8wBKExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF+cf1e59odYBtvAmrdu65Uq99AusGHl9tVwYo9Zxvo=;
 b=LdCZSOuWO2CXHD/dq+BbrVx6CNmAVCmDkGpzncRxaN0rid1CitGuALDnUR/yNwXPT44VzFTLt35Ed2ndtxgI9lF/DAZ45stHodAQRVWbKqKAfuy/QwfvCZG7yRr9nJWjm0yVF+ANdMP9/8ClMOXW5/wbrOYB9zoodkbL82rtRCXKCGzE3yilMGxNBUtsnYwGfKWhe+J13ykkFO1U92vZW5pCR2xgUajEe6twpzvZN2GSQ7H6sPoRVnxCShsTvfFlM7lUP7/8aCoJt5GM6pLev7tpPE9VESNobk6JIuKlTAD9TmOM3YgkrMJSn+wdVPyFvQKm8IkihS5WrR2P0IUfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8560.namprd11.prod.outlook.com (2603:10b6:408:1e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 07:25:57 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Mon, 16 Mar 2026
 07:25:56 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net-next v9 1/7] net: core: Add state
 tracking for async netdev ops
Thread-Topic: [Intel-wired-lan] [PATCH net-next v9 1/7] net: core: Add state
 tracking for async netdev ops
Thread-Index: AQHcs+B5Vv83qZlts0mFkt06H5BusLWwxGXQ
Date: Mon, 16 Mar 2026 07:25:56 +0000
Message-ID: <IA3PR11MB89861B6B53E0C7CDF3AA3470E540A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
 <20260314182809.362808-2-viswanathiyyappan@gmail.com>
In-Reply-To: <20260314182809.362808-2-viswanathiyyappan@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8560:EE_
x-ms-office365-filtering-correlation-id: 19ca8586-9ba5-489d-31fa-08de832d43ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: krdbIBRmlJVG8czkL98QgQ3Iec77w1Vtaf70PfG63sWrdLyqicozvx47WmSDRyaaQRjvcGU6ndWctsOnpHfRB6ECoJLyhOCuRsB8HOhLgDuDKJbBrP4WrSdokZlOhlmoBV5FgwkzI3YY5lXP1ZGfFq2N1PPVcHjetQr9ysdZJhFMpcz5hElIe3AdYollK79v9PedATCf42W9N+to/yh2D68I7hBBffYVqk+vKGcipInB4cr4nLauuoy5ALQh9h3+kmhB9Ob8PFntcSp/fqWVX6rgYs43a8xvqWcNQYMGf1uMF67Om3kWdGi3aREagqIAejNd0+VqoSX6TM/0wQDYg7N0NEQkmtT5vLdhbCeNdSns+LA3TX9N5um1ZoEmovcIjC3hNQ5bXdFu7lvGp0TeY7D4wn2l+0V3VROwfMRRkL7mLHDxI4VKnTOzVpeHGvtNewjwClBgWLeerRseMysDqUwFUU8qquBd4qtyCCNv7ftC7cVuDEtHaYYkmw6RfWWPZMMhARyuOW9CCusmNDxYtvl1xlUQQusAxiW5wUhtjgYOxjX2Q/IZlFsDQocGLy01ZdA8spx1h8LG4WjqpIbPsfLrPoaJj1rxWO6SQvQkclRsRpJ2mb6U0mhuyfggBmYeyxh8An7qaQenPcNTfHkxqNAy/I8zJW3w+tKOE80yafXqEwY7JGWQFwJgEqPU9xE4OU+oqMg6y4aSleR/3DWauGaGen0Ujre1rZl2dCRrhl+MKH1DshJP2k4lr6DiJ4IdyRz3qhET6F2hcDSCA8FmEoYiWeO71Uf1rt3RpJ3fah/kvZ2x7myUYNmagJNIsCQ5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZiTmqFA62qF5dkAPOo2nvZq/uGwTRX+4y8Sjr9FAL6TDvtsBb4fJaTM7d0j7?=
 =?us-ascii?Q?PuiZtf5HXqM6orzhCh06YlQCDHRMlcNx7WKR6QxVZIe/fDabz0LQXAx9tAuS?=
 =?us-ascii?Q?HhlI1ad5ZjJNbJ2+Z4nV1ml6lTIi9sVnqDAuMIPejqEoT/P0jRjj3SP7DHso?=
 =?us-ascii?Q?cYb9ZxbdezQAYMWeHGCBXhWJJ8mwuZV1muKbE5WS4faf8kWvmscq9AKa7aQN?=
 =?us-ascii?Q?q+veeBxh/eHoYEEFYvDC9Qp90HaohMTL0Aq24UPYz+VIlnzvLs18VuWpPuIZ?=
 =?us-ascii?Q?uhWL9bgqz6/kcs2cDE71POcrwIFFWypjVMpqlpavdOaxP9DC2w2lxuZkwolZ?=
 =?us-ascii?Q?8cPLtEOFlmOKI68g0ZPyfNGfPGCsuSdaZnPs4zVR8UaNT725qKEectGjsdE+?=
 =?us-ascii?Q?4l/B9bLw1HDyxkWdOusyoQSEUTmsLUbjzcttfloaFoBAV8+kFpyS5Og9jDVU?=
 =?us-ascii?Q?5ODeKK5myFJYrvt7WWQXx7omjob55YnF0opMrX1Eb40tnF3/hUcrCgfNgaB6?=
 =?us-ascii?Q?jAg1riDROC3JxzUW8FVN2MIumUuj/FKrz5wvKDpbJHvomX6KGxQrDtFZEBda?=
 =?us-ascii?Q?gLLKrBme69xvq2oevHR/p5iUJHNye4vP2JavOQipjLmr3FvGweNKZZvAR10w?=
 =?us-ascii?Q?NxiOaNuB8JGKhRSva2eZxKKVevDXjJESuwkk2w5Halh6ELPbXEOZLpwqvR00?=
 =?us-ascii?Q?NW4tDUn41MXxM/TDBAgR9PAQwQdxSNn8mQFZkrygq+yVibR+XZTamvXW+V5A?=
 =?us-ascii?Q?sSVQNQTTAtHv4i/4ERRtpBhv7SrvIcKXB5Sx9HCttz+f8pf5mGiUFlYiUuC7?=
 =?us-ascii?Q?EMKpljkjYK8hzDO1iiNS1Lk9HipQA6wkI4DLC+qkF4xsd5T4YUI3slKHK3q0?=
 =?us-ascii?Q?WiUf6mqJYzQ/LJfcYCneqDbpYxJ7biWX4n9sVPGJQz6r44CmOhrB+I1Pc7j2?=
 =?us-ascii?Q?sIxhTEqcE9jc0Z6k5ad0MZhHdJ0vdFsNg8PsDEEOONIxI5Tb3XK/01RU3u9l?=
 =?us-ascii?Q?CMI0TCVCAgq5VLfJ384p6I/BzYNbGS+IerVn9rdxZT7xg/HhcaIX2Tq/r8oa?=
 =?us-ascii?Q?aM5gV8FqMACWpvS2f0DBSGoRxbxm982uKBHWlwAGbbHQPR7dHZL6NkWSnLJR?=
 =?us-ascii?Q?g/ogpPF4q5TmhEqLuJvVjcTtSQAF4FckFmFCptXTfJ11xwcTohUb0Zpw7s5K?=
 =?us-ascii?Q?woSOw8J1Hpv2LnojoGn7IfGuNi6P7OSZSZtCze5SdujkybamHG5LlaD7cw6Z?=
 =?us-ascii?Q?Q1IkauyouJDXN4XV/g3ULumwHc0rgcYtYwIaDA3cl6xYG+HY9aQ5gMoXR+lz?=
 =?us-ascii?Q?x5FgnAYQ6lP+GO56jN+P+AHeUHDSCtf1raP+H6i/ZeJWrVCkGKDMq+WFtYDg?=
 =?us-ascii?Q?9CgIhBDfyjUqtX7GpVNzzQmSefKPU6re7PcKVhqfUJUE2zjIndWus5s+3mrt?=
 =?us-ascii?Q?YA8WGHWsAaHNkPT29LFDwbSaRnDD5r0SAwCGygryBrWte+UBmLoL84cYnyKr?=
 =?us-ascii?Q?0DJjejqWusalc6hfPjqp7HerwZIN8/Uq7PwXZEPaBVEK4b8ys+uq7WbdDmpz?=
 =?us-ascii?Q?/f1BxN9V810Ix1mh8jywG45+X2DuLO1fkGz9ClOLQGuwikdTiZ/lO3T5r6Iz?=
 =?us-ascii?Q?IUtGQPkF3ocg+gvMbntzwt0okk/HGNS8ca76zSPO+ERLoDblYPdrn5+sFTFZ?=
 =?us-ascii?Q?RqonWOwYiJBuE7zjO9Bjw9s+x3jc3/OOgywUXX1ICJPa7DOr+MiFpbvXGDL4?=
 =?us-ascii?Q?1Dyiq/20YgZz6AIhMnz4Enm3w1GPwN8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VCNqUa+wxADywak8zD1SwrzNyAiZ8JJ59/A69TeuPak8Pc/Pbd0xJbHcrNRZwTydSgq8HMB5bi4dQndyxSZ20Xma2BKOnjaSBAYNJyxXpfL1H1OQqkJ75LDzevG4vBIB9vPBJcVrfUDmkEAZMRoGPrODwwYOH1cfSecNwTvXDf/c/3glBxl3INGKmQIfpI6JjuK9DeUR8fsjPvUApLws9VOI8qs0f/yIPLsWuAHh4Vg3F/Ivsjq+isdLm7fq87QxNFdtjsjp/EWy5gIVkuJIPcMnHwhgdqxViM1EecH1gG2bAGfasKs2KlJ6fWvYy7yNuUd0FuX8QhtctpFyvy4jBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ca8586-9ba5-489d-31fa-08de832d43ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:25:56.7179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: usjg7QDrcQE01cy4AapHvk5uPa987QxvJu1573ur8wTdoiohz8cqz58TgdAr/+vmq7+n+okrEfHt6WLk+M66XE/A2JIsq20U9u22Bg8t67I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8560
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268037-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 35E25295944
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
> Subject: [Intel-wired-lan] [PATCH net-next v9 1/7] net: core: Add
> state tracking for async netdev ops
>=20
> Async netdev ops are tricky because of the following problems:
>=20
> 1) Freeing the context associated with async netdev ops might require
>    waiting for completion of the associated work which might require
> the
>    rtnl lock or the instance lock. However this will deadlock in
>    __dev_close_many as the cleanup is done with those locks already
> held.
>=20
> 2) We need a way to enable/disable async netdev ops depending on the
> PM
>    state to allow/prevent hardware access as appropriate.
>=20
> We solve these problems by introducing a state variable to track the
> current state of netdev. This can take the following values:
> - ACTIVE (up and normal operation)
> - DOWN (down)
> - INACTIVE (in suspend/shutdown)
>=20
> To solve 1, we set the state to down in __dev_close_many. In the
> associated op handler, we check for the current state and return if
> the netdev is down.
>=20
> To solve 2, the commit introduces the following functions:
> - netif_enable_async_ops  -> sets state to ACTIVE
> - netif_disable_async_ops -> sets state to INACTIVE and cancels any
> 			     pending work as required.
>=20
> The op implementation can use the state information to do the required
> processing.
>=20
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
>  include/linux/netdevice.h | 29 ++++++++++++++
>  net/core/dev.c            | 84
> ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 111 insertions(+), 2 deletions(-)
>=20

...

> --
> 2.47.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


