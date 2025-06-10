Return-Path: <netdev+bounces-196346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D8BAD4510
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8923A2B53
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 21:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7139275846;
	Tue, 10 Jun 2025 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfo+Oyry"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8521FF5B;
	Tue, 10 Jun 2025 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592416; cv=fail; b=DbCOlT06/6u8roKotrnstkBiVpylNvazAOuDBtkAwKYTcHA1FRRCSbFe1qIjKu8F6T341zjSPSznFizayqnotJ3iu3sXEBHHxzzQGfdxB6u7ncesqLxQB5LkhCCIsJjz67ELnR+p/wdKpVxPqQ2V35Pv2ZKIq1HJSeeQqrhXJvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592416; c=relaxed/simple;
	bh=k39kOF+ueSYLVLC/lVXD9p+zpwoPDdv7mXgVCGZtsbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aIt3hAB/pIYq/4D2g18G3k5qM5qtL5rlzt9Gu307kj3ZugT9lVMgtDrR44SXVmI0GD31D8uXChDCmsRY//0YRlVXL5RCynVdEvynRp1X3h25EyimSD9HBFyprLhHJCvzjyEahZK0Ow5SkVdX05m44jyv0l+h2HxhKFaA7kz1IxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfo+Oyry; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749592415; x=1781128415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k39kOF+ueSYLVLC/lVXD9p+zpwoPDdv7mXgVCGZtsbc=;
  b=bfo+OyryJfzZryl0LK13w9FCEbSIHEOxshpWIXSuHzI/7eZCcJuojt+a
   2svyhtEZI1QoTX9wfm6Sa4VRMa0lgMnqQBDGpARgW8iIjShnF48eJRYPC
   3ANPBnmajWOrVBwX9GFnt9p/VlRzYrKokHENzcoq4L+D/hoIvkLOP5ox5
   O9hFEtTZfAeR6XUrqQ5kG/lwsyjCw1WwUr5E+WUmIlSW9+v0ijauhkVBH
   1N+C3wKiM7D5ZZfujJf96TdRaJSDLEtquLHNBJeZvb5TE9AmBuKcYqVYr
   e2qgd3GfvsSyncB7Uo7J5rwDc/EYOP0JRvG/mn7Rr4rhYTVdY57WgLgoL
   Q==;
X-CSE-ConnectionGUID: EjBfbZdaTyKEemdTZz5/hA==
X-CSE-MsgGUID: KcT2doTHRw6NIxHzpNBz0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="69282897"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="69282897"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 14:53:26 -0700
X-CSE-ConnectionGUID: mqGd0atJSuO/5/ve2quwIw==
X-CSE-MsgGUID: LyOVNuwtQJmu2gCNPBHeVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="147904147"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 14:53:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 14:53:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 14:53:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.88)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 14:53:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdcHJ+WIjRkVsFFAOlkc8cXQFvLzu63ZOh2dTAwONRDBkzhZwHqiJENfz+jFJo7l9W5S7AGF2HZaSkFPiUE6boZdso6KpxXyKw4K+WXSMi3x1r1tim9SljgoA6YD4ZepEeG+cyQhTwWFihJl4xEfb+2L2PeTNCMp0IbHtwNncjHqHBdx38L7A1ec2mszKS28O2M118ZJY8z85FkLA+sd+PWZq0IRRi/f35C4HejIhQGJ4/6tsYtYFUYHW1AKRr+uxligen9LkemnOBIG9/s8AMf6whzs20YcM5SX6Oo7O7HGo/o9qvA6e+9hh6PV7VVKkQ7lIILE8jD4TnP3nSO0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k39kOF+ueSYLVLC/lVXD9p+zpwoPDdv7mXgVCGZtsbc=;
 b=fomNinm8c9TLQruumtQYw2HIiH/U87zJO+z7h3ym2n2GtJg0G0OAXN5+xMctU1tHDy+K2VCV2OmaqXOqU/ltn1eaXV8Gdy7v68t30LXQlAPUaPHVjn6CxkFTs4vm+4K6vD+YOspqJo3yV95cfnHRXPivU1n8AjCz8XrWWLE+xwL1RbSsZqNu8Bp8+naxgJ4alzFOcbNZYhR986FN5k+XnKUZ3kmXV6o+cds7Njk4euVYWmQNQ6XYxEr4ZULNTeNct/k1HSWOK+3ARVCaD6Zwu5o4SgZ8tnsNRbRkeMZRpsWm9jpHBkbsvNnJSlKNdMwrpheZOYMO5FuY1eS3aoRmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by LV8PR11MB8488.namprd11.prod.outlook.com (2603:10b6:408:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 21:53:22 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 21:53:22 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Jiri
 Pirko" <jiri@resnulli.us>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Michael Ellerman
	<mpe@ellerman.id.au>, "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Zaremba, Larysa" <larysa.zaremba@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Polchlopek,
 Mateusz" <mateusz.polchlopek@intel.com>, "Zaki, Ahmed"
	<ahmed.zaki@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Olech, Milena"
	<milena.olech@intel.com>, "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	"Singhai, Anjali" <anjali.singhai@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 11/15] idpf: print a debug
 message and bail in case of non-event ctlq message
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 11/15] idpf: print a debug
 message and bail in case of non-event ctlq message
Thread-Index: AQHbxnMj14g/9Uv6n0aDvSfOk9QmILP9Fw9Q
Date: Tue, 10 Jun 2025 21:53:21 +0000
Message-ID: <SJ1PR11MB6297345F22F504AC2BD337969B6AA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250516145814.5422-1-larysa.zaremba@intel.com>
 <20250516145814.5422-12-larysa.zaremba@intel.com>
In-Reply-To: <20250516145814.5422-12-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|LV8PR11MB8488:EE_
x-ms-office365-filtering-correlation-id: b2a09f01-6165-4a03-8873-08dda86937e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?om0OT1KfJDwrEIZB2LVbj/VOR/yCXikh8hzrrmi2NHenT6QT1bGzfSFLEyR7?=
 =?us-ascii?Q?iMgj11m+aGVWwfypkfrXvBJio266g2u7YTJ2UXLuFA36e+6+GQqHru1lVRrv?=
 =?us-ascii?Q?d5Ge/h0M6T+8p/OKkH9KiEDLBmVz4FvBKgM8fl7M8shlROioVtsYbqJqmxC/?=
 =?us-ascii?Q?b0FkSUjDqH9mftd8hflK/56V2je0LKskzUFHj++8UuJ65Zk8V63bg0fkNKQX?=
 =?us-ascii?Q?gLjREgjhKJv54Hb40DuWakHSXcHRmqmEOTLp+IECfQibrH1y99tAd9AyRH+x?=
 =?us-ascii?Q?n+RfUvAuBQvL6cXgKiptQioSmGqJ/Ne+8KApYC+xVBNi326Y9MNWQWSzOPNY?=
 =?us-ascii?Q?/1wy9pliY3vXWLZo8yhrub+fTiqjPKsJ7Ipn5Ol2tiWf71i23M1qyCtLK7eF?=
 =?us-ascii?Q?bqlTaRfj7KIqANBWLv9R+LIFQEw0GjsypVS8zHV1Fx69uT4QmVsRx8v4pd9y?=
 =?us-ascii?Q?OGCX5yZWke7TBDsKjeE+GUeD+bBniCT2YPi8eaqsxtHtxx+T46dhVlQD/yzD?=
 =?us-ascii?Q?FMu4x/nMQ+DiLB1fMcUV56OK6H8iE6lNSAxFu3amNlD8RFOVjS2o7D6+x/14?=
 =?us-ascii?Q?/aTVGDRgZxkbq16g3EgTYdI05ngDInTlQJX3DmMqtgYB+4kYm1GqNFBGjafM?=
 =?us-ascii?Q?ViGtQNSbvPBDlJ0/Wkr6+cYDYA1KkgOvpz1fZ2xcy77Xs+ZhnRznDGf8jHSf?=
 =?us-ascii?Q?kWHYiei2WJJPSF0iT3Gwo/brYLOpYBaQkiYzbKsedSi1YM7wRzp/4Ddc2t/H?=
 =?us-ascii?Q?+1t6FT8kbagyKIHU6D62J8FmlbQ0kzqNjEy4xBktl+J68mOOB7Li4sZYgZFt?=
 =?us-ascii?Q?Vu9zEFxSfPbEuyiiOUsXuN73j+SDQxTW5KdIfQYLkmx8rm60MqVvAluQ3cso?=
 =?us-ascii?Q?PERArkiu7Sx9jb3z7JX8pa9+NxQ0WTpAhMfHHrsdNlMBuFOtDwlyCrSoGuTT?=
 =?us-ascii?Q?7fD1cA58OjR/dUfxlitmITlqXpZu+xJa4O4g2uWkLxxiu/VBq3LbfgdB7Aga?=
 =?us-ascii?Q?CBvf1Si6yY4taU2eCCRDfclNdG6w2toJZhhvoG8VgPuXEaFE+wL4ZvRGbs9Y?=
 =?us-ascii?Q?Hjbmaq/VhCrb9LnPhDGutO0CdP2PwGq1XyXt4gfRXOYBHUViyAXoQZu8eTfT?=
 =?us-ascii?Q?fPkMBl3bkZKPv3DWcwuj4joudr5GV53OeSREZlFcRxKlfix83GBxz5V25AUI?=
 =?us-ascii?Q?+KhZrCiPDv2vkqigRdihzEwRJqVqzqSZoFYTYWHLi+C4q/pfe0aSSyphC2gV?=
 =?us-ascii?Q?4OoNQXObFhqBYXPCPzPqbdTwFDpeVZUxxHqd7m/kDrkEWUICzxPu6PY0yUm7?=
 =?us-ascii?Q?ZROPNes9/OSR6TUOZ+UQ0Ed05makfzPwVyKNzhXa2aHke2TYhPCqJk8mMmHT?=
 =?us-ascii?Q?fdRcAZ3NoP6X+zwD78uZWGc4Mp2CIAfku0REIuiPRuwJex4+s6bhC+19QHgT?=
 =?us-ascii?Q?nSLl97PrGe7rxp5d0H7aAy9hHbS5ixcsEPQViyF2N5aRNMUKvQydBrXzMyrd?=
 =?us-ascii?Q?EY5zVSbIa8d78Ig=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mg+0Zasb+bAax3k9cSKDAY/PgKNwEDoXvGFVcF9qChRGCyhyGPcaHMKbEkUy?=
 =?us-ascii?Q?d32liV0gegrWI380KJo8n88s5xK2OLlYAvlPWIuyM4KonhJAaxLjWy4F6nKV?=
 =?us-ascii?Q?7zjY7KJmw4HF4SS3buARMxDk1vg9eB0MYWrubQHebg/gaiYdZpwATzxp9WG6?=
 =?us-ascii?Q?kJraa+BKkXEuPwKn/9VVNmuBRPJwSh4tkwqa98SmqFNCsiHxffi1DQPEw5he?=
 =?us-ascii?Q?kTlDh88PLE6QRhc/OVCV1Vxl3Ir1qZGa8GDkF738aVtjo9/6Mw7aDqB2sFLa?=
 =?us-ascii?Q?msV+in+8/xECkaPPTmbAPPRL7zHQlze50D+FmuUV98sTXBxfLEzC+HOB39jo?=
 =?us-ascii?Q?JRIZ9YexPn3oKbo8PvuMpUscyh8FAztwYKOSUnGlpy3egYfeIsVvVo8JGc2a?=
 =?us-ascii?Q?r/SRnAs5/OUnsA5pIrCMHP2UfU+tCMPOD/R9aOkRNwBWhdAc+NyyVO440tQj?=
 =?us-ascii?Q?aioEbdXodD2BJpFIWr9tfApPCRsKaBlRTGKfgL4xHLQgdToAdiG8JMrNlZiZ?=
 =?us-ascii?Q?1VB7Pv3YiB0wLdyOcfjunVno6BIGTXakHedk7fS5USH67xW+NIiTNYjiz6ZZ?=
 =?us-ascii?Q?pNhhHEN4LXV+5kzUca6Vh8xivzr2L5wvCKnubaRPQqIO9oi1N/+X5AenHgc0?=
 =?us-ascii?Q?y2SwNIrgoxjJNDkEMSR1nsLLulhI9mA1QEU8tzSkSG4dDsCmfHUgkGxcxOIM?=
 =?us-ascii?Q?55hJQo/Nyec+ocZkJKv8sU9daLc+YM6ocVgarOEt1TSoyrEznbK2Uox6vWif?=
 =?us-ascii?Q?VNE2tP20z8Gns18xZ0KrqPA1rajFAy24M3/e2U62Hp69ZqlOubZQUbn4jml7?=
 =?us-ascii?Q?TCRuYVri9muZUJ/ll4vlbCJetd6Vxw6otGGNLO4mPzJwgJDda3OfT+kBRl4Q?=
 =?us-ascii?Q?nuaNLc/ySbILX3Df8TWnIW9/0m7dtlShobshF389PT9fDmebylqt324O8ZGh?=
 =?us-ascii?Q?Vvb68kazwkgWAQfy3BEpVlWNNqRfr1FBA7AQNtG1MMfFIwXo6m98ViCLOH3S?=
 =?us-ascii?Q?lJlHg3RhOVdG/5XBfkOQwBzokALRkaX/o0Ooou0vr8Di9XERKFh84m1v/WW6?=
 =?us-ascii?Q?diOvbXFzIP3xUL5Cnckrm+D/VLPJbvMvoI4jxmcKGBKMrhb97bDU8kK5b/P+?=
 =?us-ascii?Q?sn51cZ06wJoKPpH22YNr5dXYRn8PAdjl7TrA35oeANg9VNokCsguTbmkEgfD?=
 =?us-ascii?Q?2pKwlRJmeLGNA9RoYgaFepHv7mtdlQpmE8xqHBB7YUh7N66MgiluQPtPs/RY?=
 =?us-ascii?Q?6vK+CqdrT5ly3Wqr4p++kFu+/HFyxL4U0opyCDYrYKmbjJDQAgyVU3SE9mHl?=
 =?us-ascii?Q?dXPMbCmv8CqSWvRBILEFj8WKGDAa3+D+r+NDE1UMM/xBLj0dFBsQ2/vDOih5?=
 =?us-ascii?Q?AvS9e7wIMENn4S8GN6hL4GkZAD+ccDKuo8h0iHTtR5stBu4lJZayQjptiwia?=
 =?us-ascii?Q?E5TnCQTfPwlvxUkdBhxlQjU1l8ewN2Z7F8qzGjNLOWdJB7mYSRqSugv5hIJP?=
 =?us-ascii?Q?nR7sIGH5OrY8tGcxylsqlyurRfwBq+fJBpUqTI8OL3LM/LXxfHaxzQra13rO?=
 =?us-ascii?Q?zrlungwV7ux5UM0yxtjlOLZja0p6vMXgSoG01XEd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a09f01-6165-4a03-8873-08dda86937e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 21:53:21.9132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbU/0vsLJwM8S1VW3ku79LUFEjBnL4p/nL2gDY5lzC8CUPlUY3FCYQ5F0wgFpyWU8erPn83CaiqHkFzu+UGQGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8488
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Larysa Zaremba
> Sent: Friday, May 16, 2025 7:58 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Jiri Pirko <jiri@resnulli.us>; Nikolova, =
Tatyana
> E <tatyana.e.nikolova@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> Lobakin, Aleksander <aleksander.lobakin@intel.com>; Michael Ellerman
> <mpe@ellerman.id.au>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> Lee Trager <lee@trager.us>; Madhavan Srinivasan <maddy@linux.ibm.com>;
> Zaremba, Larysa <larysa.zaremba@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Polchlopek,
> Mateusz <mateusz.polchlopek@intel.com>; Zaki, Ahmed
> <ahmed.zaki@intel.com>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Tantilov, Emil S <emil.s.tantilov@intel.com>=
;
> Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Olech, Milena <milena.olech@intel.com>; Linga,
> Pavan Kumar <pavan.kumar.linga@intel.com>; Singhai, Anjali
> <anjali.singhai@intel.com>; Kubiak, Michal <michal.kubiak@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 11/15] idpf: print a debug
> message and bail in case of non-event ctlq message
>=20
> Unlike previous internal idpf ctlq implementation, idpf calls the default
> message handler for all received messages that do not have a matching xn
> transaction, not only for VIRTCHNL2_OP_EVENT. This leads to many error
> messages printing garbage, because the parsing expected a valid event
> message, but got e.g. a delayed response for a timed-out transaction.
>=20
> The information about timed-out transactions and otherwise unhandleable
> messages can still be valuable for developers, so print the information w=
ith
> dynamic debug and exit the function, so the following functions can parse
> valid events in peace.
>=20
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
> 2.47.0

Tested-by: Samuel Salin <Samuel.salin@intel.com>

