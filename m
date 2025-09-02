Return-Path: <netdev+bounces-218999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CA9B3F513
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19171189F166
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 06:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6642E282B;
	Tue,  2 Sep 2025 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5YUsUvd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEF2E1F10
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793638; cv=fail; b=sEAkVrEKljj5ThnqWtpepR5/jdDfmB8/F4xPCfjMVpHmnVIIGLP1+zwoSINNbtCJurNydpPGQtfx/E78N2tfc25k2OflyTOzYoPUzoYvGav93Oja2au2RF9qQNJcwiumMEcO2n11DkSIXOvrZnj+aVYLoH2A+VQ5bohBjVKrZYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793638; c=relaxed/simple;
	bh=UjE8+Wn9tae5pS9mPUFA225wIZWdctfQW9oEQiHELYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hR2LunRXXIFqqTPAz8lh0N6CF8BJ3vZQ1NaNq4evEqHJg++vGJG0sLM1uBQVYPmhNNfTrw7Y7McxVbHROFAPYUPYaMi24tfGCuVbH27uuj5scHjZ+ppPMi8StgKBNczoYzviY5v/WsXgQgrrWXh/m6b0r6PBPQh/ac5P/lXvxBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5YUsUvd; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756793637; x=1788329637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UjE8+Wn9tae5pS9mPUFA225wIZWdctfQW9oEQiHELYc=;
  b=e5YUsUvdQi+p8oG9Wrs3PHj5XzMrApI6Nyo2D38ub1YIM2tXklIaZ7n9
   lI2ul2+e+ZXh1SGdUv0euaG19KVKkIVwiCnCoChAS3QlHAzYVfFsijtCt
   iuQQ1/xzlG/9CSfBeXTrEa+ntCMVngRx4Y5OHU84/yD7+x2Lz0Y4SnE0N
   5x1Kc056TJ/pZAnCzubXfArRKvPHEJ8kcwTNmeJbXpsD6ZpAcN+3Ms8LP
   Q+UqmFSrm7V/dyAFIhPVC/Soc+k5zu4zeA+rCnWWhq+xL7zM3szRzU72X
   Iw9eZ8VpKWBx3yxFhpqiml+gJBhTws3Yhd3NyP7mzBg5fq+/cDk1gLD1O
   w==;
X-CSE-ConnectionGUID: PqlHf08qSOSgoD6XXHu1kA==
X-CSE-MsgGUID: eu8fsKeBQaOMMWLuc8+pRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="59190313"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="59190313"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:13:56 -0700
X-CSE-ConnectionGUID: DLKOtqCcT+WCSqBeo0S5/A==
X-CSE-MsgGUID: 53qILzQFTA6Toy5yrBdcYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171552081"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:13:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 23:13:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 23:13:54 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 23:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfhU/xNsYIeuin9yMfe1RNgENiMBI9sm1Gg4mk7Zr3aYdwvDTwqp5pLE+J73vT/B9V2bPflmgVG6tsCFldR08wbnvvaNzcotkwPqXQ/4pKYfbdhl9gJkW5GmdhEAmO5uctpOgX/HGR7G4E49g19g+NQ/tbcybq0HBHRcjpuIhM94vrpzobb3NBswi6s5kL022gFmWoEE1eUc69SwRZVKJV8y/OJ0vDmKj4VTIF5JSAA1zeYN+ZRRlzjMDidL3lbndeVO9gigBvDwqVbcmjkRTCeeQH4qbH0ao8YW4EfMektaqAcs8yKFQM9n2lGSUFVDZ3arh6fxigDhkvXDQq8Aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ryhC7HruEhUQq8KLhW5Tt6KQrUA9J8l2Xv5Msdj79A=;
 b=FHAb2j9gpb2Tkdqy8Jx6IwQUmPDIwzq9ZE5UXMlDJinPs/hCxZVNLPzyFT3SGQ0yFMASZQT0J+MQQ4DH9NJeSwULe3WFeSvpBCqGtk1pb+T1lk02xW3VdaHG1V5g4NH9UrfZbHxZ3RmQ+KvAsDsp6CmxlGOjKv4P8hFIwA9JWG5J/exkyWBwrHqcPCq/pzlOJ60yaVWw8/3vtOCIYNZHbLZDCi1qsKureukTtj+kL5DJz12854R52ofab9/+jSLkYUz5Z9Gr7QliZu3BxYVoygBS4ku3cIkMPpGv3D1Bo6gEoB9N+gfqgAMbHgRYBNuax0S2p3RX25SwEeuG9yY3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 (2603:10b6:518:1::d28) by MW4PR11MB7104.namprd11.prod.outlook.com
 (2603:10b6:303:22e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:13:52 +0000
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480]) by PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480%7]) with mapi id 15.20.9052.021; Tue, 2 Sep 2025
 06:13:52 +0000
From: "Singh, PriyaX" <priyax.singh@intel.com>
To: "intel-wired-lan-bounces@osuosl.org" <intel-wired-lan-bounces@osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/3] ice: switch to Page
 Pool
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 3/3] ice: switch to Page
 Pool
Thread-Index: AQHcCH01M/icgVqGGkGNwBWqS/igJLR/gCxwgAAOZKA=
Date: Tue, 2 Sep 2025 06:13:52 +0000
Message-ID: <PH3PPF67C992ECC2B85C5436B969773E2759106A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
References: <20250808155659.1053560-1-michal.kubiak@intel.com>
 <20250808155659.1053560-4-michal.kubiak@intel.com>
 <PH0PR11MB50137E847BF9F0BF2FBF127D9606A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB50137E847BF9F0BF2FBF127D9606A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF67C992ECC:EE_|MW4PR11MB7104:EE_
x-ms-office365-filtering-correlation-id: d54ec67e-fc60-46f5-5b60-08dde9e7e399
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?X+81mdy1E/32dLwtri+gh0lDmsFGz0fXcnYbb7Jb8G2RV3AxIc6sfTZFee8S?=
 =?us-ascii?Q?k61TUGS/TvLCopynrTA+K2t3iXqajLWpjKYxp2tQIVas5rqYdelfPYc4KWLn?=
 =?us-ascii?Q?7vZt47V36KTUMnYxb5GgeQqUlpK3dMthANmQwIEQUzEALkapkrZ5Oht2sSqf?=
 =?us-ascii?Q?rRH29coiixDe7ZEjNs7vWGFlBtLshSv+k2nTzvMjuy/HhviobcyAKosqGM9y?=
 =?us-ascii?Q?XyihE587PlWeVWrmUMGq6Tvz+YsDu7Ro4p1QgayKHkpoq8nKRb6TbYnVYd8n?=
 =?us-ascii?Q?as8BjT07JuKo3cTZ77uviI2plF3i9dJoSzE7O6vWULA/XRqfEQkNj0zaaMh+?=
 =?us-ascii?Q?RM4eNliSWCamR1RpXf6OAvqSe4wRutQreeNMub/fdr/Flza3Bb+/qI1lixMZ?=
 =?us-ascii?Q?xCYjVC8zITqYmtBZMKNwGZBlMWSbazUasIFuIH0d1k65xMkUARdeWcMW3MUO?=
 =?us-ascii?Q?+dasgsG9/VC5zv1nZs/ZP59vgYfhTVICOqijf/RzNW/c9sw28hvej66HzBBp?=
 =?us-ascii?Q?o5O0p/B945Uohgjx9LrZzCm88nlRgPX3O+Cs81L+8qTpNAKhw6MBXh1A5PPK?=
 =?us-ascii?Q?kV2ZNuvRcDYxIk+6GlTLr0PYM9LbzSSvFDab5NYSJXlscmpaWIbirWjji2Rd?=
 =?us-ascii?Q?UsjXzB0q2kE9KV/czYQcON25y4oPF9fyyY4its7vuaRxJjaT01/MKfhb8wmo?=
 =?us-ascii?Q?77YDL52GfVF0Jul6GVW2ikZ2ABa+u+Hwac1L/kV0YX/WEcj51E5XGIr5rq/Y?=
 =?us-ascii?Q?X0NubuN7sHs/VYtKI2V5TUjya89hc6Yy8o1hfreLFFMOLJtxRM4cCA4XoZHS?=
 =?us-ascii?Q?zo+PGcm86Go/aFlFc6Hkq0DtZDVuQJKEJnwgVb/uEfdIReIzt7AozxO5f6wC?=
 =?us-ascii?Q?/x5QrG3ebf9+orSTY2FXHh7g8S0F8zk/Z3gvhidhz3p67Y4fQCCC6mTR5IQ0?=
 =?us-ascii?Q?IYLSiUVZrtEghOMZVOs3uuSeREbEew5dzG7yOAM35lT3fK885fkcsNr7eDW1?=
 =?us-ascii?Q?EXTtQKLZMlgOmlZkvNbliYggLoigqcdw52CBHMRPAvI5sWHaj9wxR7qItZcm?=
 =?us-ascii?Q?sLJnEqgvp+2vLEcJUYrUpl6nqnxAIPrBHzJo57L/0XXBuuAnPzaj4iiQUGP1?=
 =?us-ascii?Q?qc940HzwjdTX8r9cuiHJNOEPPxkEwIJ2dXN5MQRRryP4D4wgz9oVkZ4gE4SS?=
 =?us-ascii?Q?2s4GrdCoCcvjlJRaUUfyp+yN3gnaEvFSHgpyHZ1tQAvfi3fFAIRlNleRL7cJ?=
 =?us-ascii?Q?IDOsbl1Yqrpt9RPc0KEjdEbkm6D+t79Y/Gj7k1v+Nk4WiPqCgqGwkl4iSVcm?=
 =?us-ascii?Q?pyMoQ5Xw848Sf8EyDcUtPL93etV1+7YKm+BkIfF6+59TYY40lwpASV+c5aZT?=
 =?us-ascii?Q?XWvPy+k1XXircfjCgedvra9MndVYqZU7Lu7H5jCawww43Iukrx3AB9ybGitD?=
 =?us-ascii?Q?0tscse4u+jBd4BvHo25YPoXm3CU4qyuw0w4ht8wrO3IV7Em5y463xASsAYcq?=
 =?us-ascii?Q?cs9qik6EnI34w8Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF67C992ECC.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BoS8tI5/ZnxDN7MIzeWtpqA1B53miSrIcs53iCPkD701+MI996dfDt59YOjm?=
 =?us-ascii?Q?3Syj/JdYGbaXQ5mt7COKaRPI/nmvtJwyYQ9idBX0jgH+ZmRcipMGva0GC6YF?=
 =?us-ascii?Q?TfFryt8Xfvaoblfnb2ww23VMxVpp8IYMBtoufgAjDKxh/9I3UkYWLtzy3tzt?=
 =?us-ascii?Q?SJNlqSHJLyOBXP6y7o2d4triJfkhhG6i66ji9l6V1IcmnNghac8z/RAWv8dL?=
 =?us-ascii?Q?JxW0czi1bv9+O++unNxAlE/+d8FUSa+SK0URxKRR4eqjcCYT6B/MAB9RvrwI?=
 =?us-ascii?Q?OvrWoJNAl2beBF0zmqGcK5W4cs1hIzkyj196Ft79/ZugrrH7UBjpukFMUsHQ?=
 =?us-ascii?Q?khYPtjm26t8ML04JNP07BiQuiZgqJX1CG7/+hdJt5TgWhWGuxKkxw+Drw49E?=
 =?us-ascii?Q?gCw63/k8gFv3JYaLChEwBacp9thxwnTFCXvcj33HFMsA8ty8sY6Oe6ooBsNu?=
 =?us-ascii?Q?Off59ITyyS6yvISO5AuYmsAUYKAepYSLvjT2ysNh8o1GkkaxyqQA0PtScSC2?=
 =?us-ascii?Q?FePfhLibfsDh4HJbNE/S+jk8M1X5Flrn3MMvQUzEcAO3dU4Q+bXnnXStDPPT?=
 =?us-ascii?Q?GbfVQnHGiLCHKBNEY0vRrsIE8mF5eJ+5up9pvtfdA43/5ctom4RJtaMNu5Bd?=
 =?us-ascii?Q?g4LzK4DsfF1fd6FPCNfuqE01Agn6tTphWMn1tWvY7z6giBZSo1uSAviBvRGa?=
 =?us-ascii?Q?F63qUJvAJF1wWaTszVZyulUVdzEV7OHk1U598AYNhHd794Nb8y3fGYBQyuZJ?=
 =?us-ascii?Q?5HQlAxd7VjKgLz4WD824AnKgVV57i+UHeSRgxh+vzaNIq6SDu5F5O2UzVtzq?=
 =?us-ascii?Q?2JSzDDBIErhysHbKlShFIiG9lOgOijhPZ5KBYhu4XZ9o6/Ub6uRuZxXOPPrq?=
 =?us-ascii?Q?+CYCg8rjSMjY20qApDR23dtCX6TOTXg9zkpNBVlZ6QnHR0vAoTHhkWAQCiyT?=
 =?us-ascii?Q?GHnHiOVp/YG73K4b93b3LPFVgKXwzBFo+Bu+VPl23tAFFa7hNJJ/1LThkPqA?=
 =?us-ascii?Q?g1OeJZX6nu157U5Nb5kMyjZHi0A8tLalcY+0InTM+8FOT3tlr0NrMb2hPwZp?=
 =?us-ascii?Q?+HtMPRAO9otJwvrvT6ii8kWYcukibXLPNlrrQRQKNx4LMWN4hgsiCI++CuOb?=
 =?us-ascii?Q?1bD4MO6ey/YzMRc9O9c1nhsIvbvGLTwMTHmy6eO0Fd+vlyKQTUYXqwYTSmOe?=
 =?us-ascii?Q?LBt3EfbFsfBduE1MHwqgBAgosurGS6Ie/J0ufHBVxEf6o8NBf8drnc3O43It?=
 =?us-ascii?Q?3dAmqHQbZ4ZWrAua+hh/7h+XZV3tjVZfur+jWDMAZr2pd0OSRFAdxX4Ecvem?=
 =?us-ascii?Q?KQqzPoALNISipPDu0MK7ArRWQFCpeEsLR2MtIht1+mUK6jjHaaj6D9de4FcI?=
 =?us-ascii?Q?o+25p+jKyUlPwOTkuiFhHMskg0xufI6kgrEHI2KtRCXxzFScQlrO43W4VxM9?=
 =?us-ascii?Q?enw+Jta0Mm2y17NE/rJCgyzowZ3Rc1y3b9/RTJtWbxeDpYAOK62xXXB096h1?=
 =?us-ascii?Q?FW3yn7MD5egz8qJXpiE8RkfhP1CXHSJsZalcUBP8zsdoEp/ee6db7JuvTyvg?=
 =?us-ascii?Q?/c9uo4W5UeSOrAGNc1WlTuu0iC38OfMrqusDnQBX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF67C992ECC.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54ec67e-fc60-46f5-5b60-08dde9e7e399
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 06:13:52.1531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: id9bsLUuC07kJq1DjjeLY1pBns986AJttyyQdxtP4JojrOumCpBPH4dm810dk3z/Y4DNIC/szdx5u51UduI7kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-OriginatorOrg: intel.com

> This patch completes the transition of the ice driver to use the Page Poo=
l and
> libeth APIs, following the same direction as commit 5fa4caff59f2
> ("iavf: switch to Page Pool"). With the legacy page splitting and recycli=
ng logic
> already removed, the driver is now in a clean state to adopt the modern
> memory model.
>=20
> The Page Pool integration simplifies buffer management by offloading DMA
> mapping and recycling to the core infrastructure. This eliminates the nee=
d for
> driver-specific handling of headroom, buffer sizing, and page order. The =
libeth
> helper is used for CPU-side processing, while DMA-for-device is handled b=
y
> the Page Pool core.
>=20
> Additionally, this patch extends the conversion to cover XDP support.
> The driver now uses libeth_xdp helpers for Rx buffer processing, and
> optimizes XDP_TX by skipping per-frame DMA mapping. Instead, all buffers
> are mapped as bi-directional up front, leveraging Page Pool's lifecycle
> management. This significantly reduces overhead in virtualized environmen=
ts.
>=20
> Performance observations:
> - In typical scenarios (netperf, XDP_PASS, XDP_DROP), performance remains
>   on par with the previous implementation.
> - In XDP_TX mode:
>   * With IOMMU enabled, performance improves dramatically - over 5x
>     increase - due to reduced DMA mapping overhead and better memory
> reuse.
>   * With IOMMU disabled, performance remains comparable to the previous
>     implementation, with no significant changes observed.
>=20
> This change is also a step toward a more modular and unified XDP
> implementation across Intel Ethernet drivers, aligning with ongoing effor=
ts to
> consolidate and streamline feature support.
>=20
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig            |   1 +
>  drivers/net/ethernet/intel/ice/ice_base.c     |  85 ++--
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  17 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   1 -
>  drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 443 +++---------------
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  33 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  65 ++-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   9 -
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  76 +--
>  drivers/net/ethernet/intel/ice/ice_xsk.h      |   6 +-
>  11 files changed, 200 insertions(+), 546 deletions(-)

Tested-by: Priya Singh <priyax.singh@intel.com>

