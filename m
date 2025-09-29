Return-Path: <netdev+bounces-227159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C621CBA9439
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 15:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766261769B9
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD640304BB9;
	Mon, 29 Sep 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLLKI+x7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259F1301713
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150840; cv=fail; b=VwIclaLFpmqr3hqQY6MZDa/EzriXgHoyUTlCkyUyGwsmJE47bqe7ZSzeZkP10ZkU3rFuFrWi3K88tqO/A5aKTkk7sNnhXiz0i0/RE1wRB9zMxZ55jk8ufONV6rqomK4BI2ChLYHmHCtDLXIg7sWUTnCZQHTxLpLjxfujt6Kyl4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150840; c=relaxed/simple;
	bh=Ww9hy/YwHIPAeuAsjJ4E5E5GU9QCmUSsLVmAHAygtOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mn4VGsnJZoqfwRCNOYqXKloUYUnrv7wt8HdWL31B/UYVVn4fmdOafD0juG8R3KB4y0ymemiCaBDUwAp74tUQAmKv77cd6EwvYCb38GKbwI9K6XwlZQBoQdU/guNjOkoHyu9byJgDvUccP7hRV7PfgJ+it2e28BQVCm5VldvpNZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLLKI+x7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759150838; x=1790686838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ww9hy/YwHIPAeuAsjJ4E5E5GU9QCmUSsLVmAHAygtOU=;
  b=gLLKI+x7rvUarZj+LaJP29eUnavgZifGGTQCMjnJ0vzIXMDZNbNKdmse
   UxoexPxmBqVb/Kb3aIxwwcuEqSUp0duOy2gqX2FgyU7E2AB7MxwxLUmM/
   BBCr2zpW9AjScgSKsUp1Xhphzg7ZbcFJMi+q8q9uCJIvErNFodJx63ij3
   lCqV2yT8GG2VPJ0TpoTZRLcrLTKDIEkmPOhry/akigEuL9/LTaqoXN2x2
   TB5j+vfzR5T243jZhQoije2DeKggJps/8SeGoYMkZxg38CcbXoqnCcc1L
   dW5lyV7IaXf2BComIs585fhZL4DnvtKCzNGuHiW8/nlpHbmjTJrS2XEfC
   Q==;
X-CSE-ConnectionGUID: +mip4pD/QB+G1h+E++ZjMQ==
X-CSE-MsgGUID: ix15JTVeR9y/Zwif+66c6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61306388"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="61306388"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:00:37 -0700
X-CSE-ConnectionGUID: kDNo03vPSCqRIWA2eAK95g==
X-CSE-MsgGUID: FlHTqQtoS9yY8InFg/lVIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="178284324"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:00:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:00:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 06:00:36 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:00:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8BaHcCc5FTdlHn7CoPoSIF+i9bD1mCSB3/1YkWpqhISmp4Wj8nJG1RMQXftGEjXoBojCry+HmTcpfAhWDM/QtjAoCtgq1iAjqDiFfuGBMdF22H0ZE7lF7oEO07bvATSaCFv2C2sviuUKzeW9bUzXn2ueanSVF8/lR27wQkdb7Y7pR1/zdEfukOAVgxCvlNMsxySXYyf3O8Sbw2WB7AzfsjY4T3qJaUjDcBYOnQ4EP/Je20c1piql6nqKCwa411C0y1c/6ZDDcnORthy+YUYjzGvReOcPdMr+o9AVFRxXpKwmYSBart7IA6+TCQR9Kk1THxmvE8uhWF5/QlzLH/krQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHLqAooNfI5qB6HChJtFeLRiSsY+lTBS5yj/3RerLeo=;
 b=P3hVXfIz6M4oegXXuBFrIdMZubwfGWLnAz/hrkqma157WEhFcBAHpJC9l8aCPXVDt5XLqMbNp3zKJT6CRg0Ahxo7rRrZCbDfk4ecswuJyOKSskPCFZtVqg8XWA2S2Zw4FWsFceCHtaIgFZw27DNvAe7mZRwC+SvUGILhcXtBUPrknCyicQLLgoKllLHn+5Cx6Mq1dL5uzWvWehnls89QtOTZYjJxifp0kNqUWWMAkuF9XD3BjK/BCAtmiJ8h1tCLRcKTv0CC+9eoZNIVxO1yeM9F8SNDpiNZie1SmV585SnrKJv2uXaEHUgbLHn9pEQ7OyNqkrHxbxjk+hLghWFWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by MW4PR11MB6934.namprd11.prod.outlook.com (2603:10b6:303:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 13:00:22 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%3]) with mapi id 15.20.9137.018; Mon, 29 Sep 2025
 13:00:21 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "przemyslawx.patynowski@intel.com" <przemyslawx.patynowski@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, "Keller,
 Jacob E" <jacob.e.keller@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next, v4, 2/2] i40e: support generic
 devlink param "max_mac_per_vf"
Thread-Topic: [Intel-wired-lan] [PATCH net-next, v4, 2/2] i40e: support
 generic devlink param "max_mac_per_vf"
Thread-Index: AQHcH979BgTQVXRp3UStaCf9BDyj3bSqQi2w
Date: Mon, 29 Sep 2025 13:00:21 +0000
Message-ID: <IA3PR11MB89851031CC3D724AB2C0D2E88F1BA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250907100454.193420-1-mheib@redhat.com>
 <20250907100454.193420-2-mheib@redhat.com>
In-Reply-To: <20250907100454.193420-2-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|MW4PR11MB6934:EE_
x-ms-office365-filtering-correlation-id: 70b591a0-488b-4705-defe-08ddff582618
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?gUGrDKGppTlUUBQleK3KUjvh9HszfzcAegzpFJCHrasD/lozyO3oK5FNYlQO?=
 =?us-ascii?Q?97groY5ToKvNak1QZHy56g8HIPC4Hzk/nO1T6VgpcCM3FsPsz1VO6DyHtD5J?=
 =?us-ascii?Q?jN10S8qLC+NYUY+CaCKfspoRbpegNDr+0qJh3MTv2xleS130KHsghw7Ummtn?=
 =?us-ascii?Q?xDtAmhXe2e2sKSV3U0ttUVixpcnodLBLENBm6Lx0CXMFkHeBgbcmH3tzg/hU?=
 =?us-ascii?Q?NOwTDc/SIuJCG1d449LC6adFWmAAE9FsrSatWv8XttLYB0LKHB5CBjuU2wfO?=
 =?us-ascii?Q?XksMRPOhA1GPHK2o63GrFtKCkceQH5+xgzKaZ6s1vDBNXFHPvFZN9dETOPN3?=
 =?us-ascii?Q?op3l/Z0GBgC6UB3lKZOAFRNRfU3ADy6RAOCPf06w8k04JmJ5nN+I6SHc5h4f?=
 =?us-ascii?Q?YDess2GVVIAf8HVnSgJWWdNx8yah62RSE3JRCg0pq9O71sMlyDPuQuADUfrV?=
 =?us-ascii?Q?4F0X+93Hi1DYDNeTq2Valgno8NM6iSPc/yBEj47MTwr/gDQq1MJwTVN/9eyC?=
 =?us-ascii?Q?g+2uyCW8jkvI7SgSsuqLSBmfr6v9rXlMYyvGVbmFQm/nKBaLerzeb7MhYKdr?=
 =?us-ascii?Q?diohTFXlBP2YBZRNODd0UHGkk9fF0aDfb8VjBMIRCCdpn+4sRsw5qZx+QI1c?=
 =?us-ascii?Q?9Z9pYRibWvWZHf6KQ+SGGGFrdbJIlFqWBmUDdHqwdoqcfdwqMSEoy/1XFua7?=
 =?us-ascii?Q?8Gl4x0eT6GshCVfuyeL3gos+bvUYMAeRCUI5plAFt79rkWSwnI8E9lUw3BuK?=
 =?us-ascii?Q?EfIt6RiLJMX4L9UFDE6opam6SX6DU80LSLvwfBIILwz69uEETIUb4JN9kVGq?=
 =?us-ascii?Q?6/1l0pYYkoQSsnZQi4SQ4midZ0q0fqGapWHO6hRwS4uPXSu/c0/1Exw6UpCA?=
 =?us-ascii?Q?IZtXFZlALHuQIBMZsk0BgE2mBwlVyY36cNDRT51n3Ljc153OGbjOYrRHXaEH?=
 =?us-ascii?Q?jZmVmACWSp6i+aZlRxDpDuUi3hvEzhrBPDg8J9+5/Q6A6BEuGGmZuS2xeaX+?=
 =?us-ascii?Q?2HUrSnxnLMqmZgVn1maCGVHatiR/JGIezmRliVP+XjZVN4pUfhETGsyLFduV?=
 =?us-ascii?Q?B8zQ8xP3SNVXTchgv8f52t8XP1Qj8+ZH50P9C3Z0NQaID/EM0k9lNUm2KhBg?=
 =?us-ascii?Q?rUd4ee+x3nXGyw3Fmt0LyriP2+Gwl6tyIyOBw6WSc3t+uQP892CqB+VtJz5n?=
 =?us-ascii?Q?b+/dgnLb6vdSdNcjgVXd+LrjWcQB0k27IAuUIQmurkBEG79P/Ni4aMuHZEmX?=
 =?us-ascii?Q?kWcvxny4/DUWqByoL7lCtxbGZkSn5nvOlGIsYdYX7XmNwPentdixhwkHgfaY?=
 =?us-ascii?Q?0/5xx8Mv+iEix3pJ+vY2W1rA4oKByjj2/cwubpfdJ/Urmme9lYYYh/hh0Sz+?=
 =?us-ascii?Q?rqVq7+N+EMNFPi/vkgmC/46GO/BC3ME31CABICKRDCV4t8sKQla0OJOYGAS6?=
 =?us-ascii?Q?yKmB11ZbNnqjsp2T9AwU9HbtmvHb7WNH/zv2jkVZVMawFdAUOgc4J4PHRG/C?=
 =?us-ascii?Q?aimhHrDHy3ofyQoyUCOGIID27Sr/0hKDJDbMfRBJ2+bTvh21k3l5Osbw7Q?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QN1uLT+0pEJZ9Nw/59A+ghAWaJg8twkk12qzjsBk2+H3n/jRQyhP1Se0NwxT?=
 =?us-ascii?Q?ICtFxS3mZpjD+9POI8M2j0XHyfax0tZJOdQq0+J0jPQyg5wt1WcYxygAEyNj?=
 =?us-ascii?Q?pstSqXxKeVZM+CSA0Lve5V5tonTu9deoi28DSHzgc9DXu88tB1CtOP9pXgpP?=
 =?us-ascii?Q?9vBpzQSK6Cq/Mb9KSLOkeKEc1aT6op8LfGFCJn5vDNYV3WvCZarX06uuZx/8?=
 =?us-ascii?Q?7Rhx1K1xL9jRu1J6Ggbp7QTviz1pJy9QOqgHi9TgLlhuk01QD5vSzg3rNsJy?=
 =?us-ascii?Q?mB+0hbYSplHNnk+fdYqCwYrGypv2MqaS+ehfiiOyIKzjBTLyRah0MkKcmNau?=
 =?us-ascii?Q?/6unI9vMbS0UPvttXNNMaXxJIpcAa1W9FnC2fmhR7CZcLydNHPtkQVC9qbfK?=
 =?us-ascii?Q?FmReOrguspcYIvfYngL1w/g7XQm+5GjoQ7fyQVjxghljVatbb66iBceAbHux?=
 =?us-ascii?Q?0+Z9aTZ8B9erHI86hSBP0ua2ZwoWJmlkQzZhUL78+66gfERUcdaD5MKVM7bb?=
 =?us-ascii?Q?FqN01cq6FLIkYR3FsN0C//M++oMipRllfjYMWQPyN1QHGFwV0I96V5EOqWSB?=
 =?us-ascii?Q?8sSFc+NFPhLsTs0AsKFnk/oyu91P+gSvdcFEAdb92hDnReo5uTEOyIJ2DR/K?=
 =?us-ascii?Q?5l9W0PxfGWknpsQJy3Q2jl2e2RdCEifUHftINnAR0ITZoXNvsvr1Ioo5RYI4?=
 =?us-ascii?Q?HlN6on/aoT3+YaKHlfIwmwjKSUHixNxQ+N4oemyMtARmJmnl2LKi6qQ0cW7Y?=
 =?us-ascii?Q?UCtNdmM/hCtXOwhHDZ+ymjB0XXBJuLRY7uYlkiK1JqBl+bQR72n+dzTPN3/Q?=
 =?us-ascii?Q?EKAVOplyVFAHTcWsXuQS6kwlwDNgXLd0lrrbo00C3LFUj30rRad/hPBjbqo8?=
 =?us-ascii?Q?yjYKS5zV7B+lG8Eny8VIGL+gFyEyBg4eXcdSzRmKmx3yXI9KrjTMRd10kwbc?=
 =?us-ascii?Q?CbQILz5eItwOl9NGnhOdihRu3VP1yy9iBcBhfS+LhqWABkM8ujJSX2ymvx2k?=
 =?us-ascii?Q?1CsfpULPPD4CNZPbhtZ3lCErNc0Zu0Wk12loNk0tgqRU+wx0wc4ZCFKm8z87?=
 =?us-ascii?Q?CU/+N91aGIIaDx0kQKUQcVtVGRC6W7+bv8ssHxNmEl+63qItM4lb/NK05QEg?=
 =?us-ascii?Q?6uwJKHLzKtjx/SF6kklXEM7EaIs6l3dj7LrrWMEWtYJ3xHDW1OEQVDsrZLzB?=
 =?us-ascii?Q?a+2SiSFE7p1tnsWbs93LhgvlZ+chofgZp+E7P/uaMJzaRJlZejl3cXmsTzs+?=
 =?us-ascii?Q?acWyWlbx892nwu9qTQPiNklhufkDANaTZYxC0DyOb1IK5bIc4iAgWLlWtc/S?=
 =?us-ascii?Q?tGjBegZwVo1o+agjKeUti/gi2hIbt8b3ao8fvsGDmL6XclJ/GyW+52FifEYX?=
 =?us-ascii?Q?KiPpN5yKwCNzGPsVGdhvxpnlNsH3q0atedWY59Vdb7wLlVrRGLSdoxG2an/+?=
 =?us-ascii?Q?g/Nxnt3MOSr24HdiJbBZGdw4P9obnRYO+zdADLjlu6l0ozu2YC5qvRX1wy5E?=
 =?us-ascii?Q?QtcDX7xtwXXp41JIOn1JBRQbjuG7YTsKqyRsO1+kleKEpWxnW96SVR7vBpYO?=
 =?us-ascii?Q?IXCCAhCoNDVDGDt5gjHInJkta0A9fKbYvrBwraoNdJtsHR6Yxn3KinHffnOL?=
 =?us-ascii?Q?ww=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b591a0-488b-4705-defe-08ddff582618
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 13:00:21.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTCtcch17cobpats4XC2bb0ou/zTosqw8masItZWJWQSZt3LVlb5IAOs26QQPGEetoLS87Fqt7I1eMCJS/nJpzUGdO5ADWIs3hQJcaFNaGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6934
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> mheib@redhat.com
> Sent: Sunday, September 7, 2025 12:05 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: przemyslawx.patynowski@intel.com; jiri@resnulli.us;
> netdev@vger.kernel.org; horms@kernel.org; Keller, Jacob E
> <jacob.e.keller@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Mohammad Heib <mheib@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net-next, v4, 2/2] i40e: support generi=
c
> devlink param "max_mac_per_vf"
>=20
> From: Mohammad Heib <mheib@redhat.com>
>=20
> Currently the i40e driver enforces its own internally calculated per-VF M=
AC
> filter limit, derived from the number of allocated VFs and available hard=
ware
> resources. This limit is not configurable by the administrator, which mak=
es it
> difficult to control how many MAC addresses each VF may use.
>=20
> This patch adds support for the new generic devlink runtime parameter
> "max_mac_per_vf" which provides administrators with a way to cap the
> number of MAC addresses a VF can use:
>=20
> - When the parameter is set to 0 (default), the driver continues to use
>   its internally calculated limit.
>=20
> - When set to a non-zero value, the driver applies this value as a strict
>   cap for VFs, overriding the internal calculation.
>=20
> Important notes:
>=20
> - The configured value is a theoretical maximum. Hardware limits may
>   still prevent additional MAC addresses from being added, even if the
>   parameter allows it.
>=20
> - Since MAC filters are a shared hardware resource across all VFs,
>   setting a high value may cause resource contention and starve other
>   VFs.
>=20
> - This change gives administrators predictable and flexible control over
>   VF resource allocation, while still respecting hardware limitations.
>=20
> - Previous discussion about this change:
>   https://lore.kernel.org/netdev/20250805134042.2604897-2-
> dhill@redhat.com
>   https://lore.kernel.org/netdev/20250823094952.182181-1-
> mheib@redhat.com
>=20
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  Documentation/networking/devlink/i40e.rst     | 32 +++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
>  .../net/ethernet/intel/i40e/i40e_devlink.c    | 48 ++++++++++++++++++-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 31 ++++++++----
>  4 files changed, 105 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/networking/devlink/i40e.rst
> b/Documentation/networking/devlink/i40e.rst
> index d3cb5bb5197e..7480f0300fdb 100644
> --- a/Documentation/networking/devlink/i40e.rst
> +++ b/Documentation/networking/devlink/i40e.rst
> @@ -7,6 +7,38 @@ i40e devlink support


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>




