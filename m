Return-Path: <netdev+bounces-127103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BFB974220
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9940C1C254D9
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130FB1A0B1E;
	Tue, 10 Sep 2024 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGDcUYjg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715D16F27F;
	Tue, 10 Sep 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992870; cv=fail; b=B6tULsdNaZz2EH/9MqQbBuYtM7iRkmVzPbIvDuD0EmwTymjbk3lY6Szm95w9cayDLHp/AMohhjsIZYUDcxQJp1T1a530SGxRPOtZX7TFb5mPTopk4Ou+/dJgRCb/JbwHuRqHXgjZiQKQtDJ8y8upKl3+xsaUHYtElWcmwMegmLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992870; c=relaxed/simple;
	bh=pdUz8/g32mnpJq2VgoagGtAmQRlQ4sluMb2qq5isOvI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l8R9BgADxaS0wu7IWVbHayXivG5tlF2R5LhXKGZtDgGKu2ypRnAEg4d9KEUhZAz4PLWljk+4xiUeiuv/vfEEAtuhB5XaAclI+lcS77OI+Os/Wq7YPJO9gGmZyTVeYMtt4uveD5M3k5XQiry5wnBGcKjWLwYH3H2PFd6VGWnM09E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGDcUYjg; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725992868; x=1757528868;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pdUz8/g32mnpJq2VgoagGtAmQRlQ4sluMb2qq5isOvI=;
  b=jGDcUYjgzRxbaYPvDVp6WgbtOwmaM0e3NTrFxKQnamdQdO85llXjd0bW
   iD/0o/MNphB36m75ahlO0HgmB4Phg0DbY0jRsk7hXnRYFHD/qpzGQ++lA
   WmETizxX4TOzC1pikYOQzuhN9AYJznqsT2fUObRxUYpwwq1ZQfCchz7Y4
   ZbzxoZzrT8fET9gvKL+GgJlZ0btr7HWQB4BXnbYCgpOUkFva0Z3K5NYvZ
   ca2KiNZG9yhPX75jKQzOQff7t6AjzVYLaH9txqYgJHcVpU3GjvTC2ZHqW
   7tB8mlbzQSiR0YAmUd5gP+UgGeSl6CIdWkyoktS3w62gvzKYzFKUg5CF9
   A==;
X-CSE-ConnectionGUID: JnDr6MFdRzeqvOTcUR9EyA==
X-CSE-MsgGUID: QyaAL6KdQDuDs8jt2AqhDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="36117579"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="36117579"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 11:27:47 -0700
X-CSE-ConnectionGUID: //mimWq2QyCXExrBi2V5xQ==
X-CSE-MsgGUID: GwerHO5uReSUIaGGEetPog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="71492472"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 11:27:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 11:27:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 11:27:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 11:27:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 11:27:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjVQwQ3WonfZic8evhKz/00bsqIJak+xABONt9AENEJzb27G+tlfFbHHROj7kuaUSDoA/jxKz8SQRj3PPCWUzMjIO2HJVX7VS1togBXfNl+h1ENvJS1FqokhRI+Ehg66on8w9ke25e3wFm8HbtmZvq2umO+X2TMUg5c9HukZ7o+fXuOURNFd1QE0tWWrv1p3yFNv2Mej6PDhomFZC9EQ/D9TTDRBGKPzdAseUIuUgvc1v40bqj9nmNJQRLtnb+vefh2YUXoeLeOQHmAKiPPzW1VOAn95FiT9b+kuavDEn7uTngh+CGTVkx/qjtflTkoijNu5okjpicSPJ5iD2+DdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEboFd0HM45QNYSBv0ad2nnzXRNHJsbjonzm4O4R37I=;
 b=qJo2PQ/UIg8fBHaTMOve5PrUQiIjpjl/9/KAlclwo4k2oM82ukUcNBRdizW1a84V6PspnnHWO5G1KuhxTf5FhkTBiTRkQPHhU5+F2Rq+VaEg6WY+jZScfdS3gxCeIjK1nH6MrDLnphQK4G/x+uB/MOYBAeuGNDnQPNCOJOA/BesMd9rmxuL1/NJyKvGwSShZa2aTwJ8vniCxfmdROPgYWoVSwHgP+UXiruwZaAgC18gkQNPj6uBtFz9w330XZcFZ8qtevz+cV8ODjc8yFLfhMgrzn/f0BwHGh5Ylk7SaSvIoZDvzF9mGNfL/aZDtatboIPsiSlBAmr+PMVWivOex6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DS7PR11MB6294.namprd11.prod.outlook.com (2603:10b6:8:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 18:27:43 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 18:27:43 +0000
Date: Tue, 10 Sep 2024 11:27:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Zijun Hu <zijun_hu@icloud.com>,
	quic_zijuhu <quic_zijuhu@quicinc.com>, Ira Weiny <ira.weiny@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Timur Tabi <timur@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
Message-ID: <66e08f9beb6a2_326462945d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
 <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
 <66df9692e324d_ae21294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <a6dae308-ff34-4479-a638-8c12ff2e8d32@quicinc.com>
 <66dfc7d4f11a3_32646294f7@dwillia2-xfh.jf.intel.com.notmuch>
 <e7e6ea66-bcfe-4af4-9f82-ae39fef1a976@icloud.com>
 <66e06d66ca21b_3264629448@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66e06d66ca21b_3264629448@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:303:b6::22) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DS7PR11MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c8eee7-fa2d-492c-f939-08dcd1c642b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vy8m33MxDWd6VT9yolhDTzPymkUsM+Suamn3jqEo1p6sg4cJWBW/veuj++CW?=
 =?us-ascii?Q?c0Jq5jArEUc7Qrbd0mO9slr4DrlnYTm2uGunKmCYHhPJ3Wt2WEXBal7RZMQO?=
 =?us-ascii?Q?p226vmkIT3CxWOnIcEr1MqjQH6TYLZun1Ups66HT7OK9nJdHSsihSHwdzepb?=
 =?us-ascii?Q?fGDy2C2UFVKANoZEeudmTNREmYmSFb4qjWri1Ly5sWDSmn2SDHX98IMOmx16?=
 =?us-ascii?Q?ketGJE/ib3amuHC/UaVFmyVKtWNpJsLmIiDMKlEitwMrUKNzFjwHajSYbJ4E?=
 =?us-ascii?Q?lmQbKq/L6tpGUb45NbfrzqwMO2GfOATmAiMEGRsfB0YOeanTgjHUEYw++V0U?=
 =?us-ascii?Q?uTu3MrjwOv5Is4LYbiNdn6K3QPGC1O4vsJRfMmsT9ZFY5hXdbZtwtz5uwjMD?=
 =?us-ascii?Q?ilH3t/AmtzMyg5TWlKmBP5jJ72eVvjteSklJlJcG7QOT8fSu3CSIeEc1PZnZ?=
 =?us-ascii?Q?eGHXTqaMp+Pli9GaSEMyCu9WsFpcS8/7bsvJ3HRfPEBk9DTK8LjFiozugbEv?=
 =?us-ascii?Q?bKGvwByErKBGo/P87S6ZXTTM8FEIDI8xo2V3KFjG+jlOKyXYjnXRvQ6iAw/M?=
 =?us-ascii?Q?iq6cHuquvgoZlfJSFOz3hNYI2RkBGlGIgL0QOxPL24OPYETJOYDYK6r/OcPV?=
 =?us-ascii?Q?+7P/pwUlPfbyLhzS0RQCqdJDBeY18ohi0GX7d2XIJGaG+7IqLrgPqD4GFyLb?=
 =?us-ascii?Q?YWqNJakD0jbcQZDfb0RPkzcpt92DnwzSRWQmWMTUS2Kp7Tjc2Dc36U3deTGo?=
 =?us-ascii?Q?7/44sTC0YCKYQv0Y5lBtItk670YJxX/g8Rc5iFbHqoezZt/ZAKq4LQyR7ROP?=
 =?us-ascii?Q?aOTVWfygpem5g6CstSAgCDWPZK+nVUzNzIm61OUfjAZt2URfWhtgvMQSlTvl?=
 =?us-ascii?Q?bEzmpubVjh9OaQBS29mfx5fjtoy7oe0hX3hX7LoS45rDtpDHjwub3fCfmGIq?=
 =?us-ascii?Q?53xRIKyqFV3zkvXtv2N2IbuM64ZNt/0wnRMnzkgFZ34crMdnr9TkSWvig5O6?=
 =?us-ascii?Q?ZOscBmeWCi8Ml4xRi6FApIyUtQO7VlCba3j6FWEgIqXYnUqvJlJhUkTLPCoh?=
 =?us-ascii?Q?02iqm3xNcLwTj/7LNsNZu6B/3HewwLPN2RUEB83n5KveMCyq/R4Xngpvzlnm?=
 =?us-ascii?Q?bobUkiZpMaKQwUXITDdEY+flsJbn+i1HRTvsbDYBY98khOs4wK7Ac5pbviGy?=
 =?us-ascii?Q?cxCWYfgtR7zIX5FCi4h0mfVW8EDwTs8eRUgOKHjoebVRv92Wbna3Dwm36KO5?=
 =?us-ascii?Q?7itObRUZ12MzXU9XQA2e1NuKahn2T+Imn5BQ7tqTnXyK8VRj8HeGYpq6qqi6?=
 =?us-ascii?Q?y7DovjbqhFq3PUDWBTicbFeYMcQ9N002X2D7q+5FwHWIow=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HKbjf7uFdWkoNnLnwaSfYy6A2e4POyRwzEXtE8dXTofG5NBIT40/HiNAupk0?=
 =?us-ascii?Q?oXFlZYO1tiLPDC3min80V1yVLqjFTbUBmJWcGfnF0UrfkjEqqlI5Scil63iB?=
 =?us-ascii?Q?gNaWyh3wO5zH2kjJEP9DHOFI8YFZgUOA55WmqQ836A5DGLp8CEB1ovmRKgto?=
 =?us-ascii?Q?Z0eyKYngj4aHwSw+whqqLGqhJXiqIk86Fx/08DdA//VxnE+mrk5LbdUukP2I?=
 =?us-ascii?Q?NIcIFWfgv3goDJyTfydBsognTS531rLFANRhADJxGpv6K/IO9x9RZ+htuuqV?=
 =?us-ascii?Q?C3JTYozCxwTOW1yxkZvavcWYRpDqi0qpnq+LyUupZMjjysDajqW1Zwn5XjHf?=
 =?us-ascii?Q?oOSUpAHFkPilzNA0r6GVteZxwNv07GzOIb3Sn5hMKosVn+rgoRxyYa2rXFK2?=
 =?us-ascii?Q?ShZZNilUs6EonAJ2nyu97M4PbOk4zbJ0b2jJ0p3Kz5Uv2k7pYxxP3hEIszGT?=
 =?us-ascii?Q?z31m+zLHeIV0ESNxgUAikhFx0puvF0wv/stqJguWJxzMcXrax3iDQRkGdO2E?=
 =?us-ascii?Q?UvDGEa/P8qT7fnpJlaopPbtM1gh04qfOMoVkWWB8dStXaAre2VMxOrZ5em3v?=
 =?us-ascii?Q?fU4SiHg3yVPbSzoVql3T4dWcidxoNFGpcRD1QVGalvDhThXrQwxLrvwTDzcw?=
 =?us-ascii?Q?8ORKc/19Y1pScJ4US4HMqwPE+jz2T7TQ39sl+Om8ohZGahi40uoMeUtVGogq?=
 =?us-ascii?Q?kNIlbMQCAjLplklOlbEV97iIWQ1E0iR9TvNHLiXNRLPShoERro/gjhOI/3DY?=
 =?us-ascii?Q?d1bT6LXb2ilH1rhLJlcLpexNb0yLXCmEpUBGWGyCToC+/YpefAkuKeTIMwbK?=
 =?us-ascii?Q?sljdulzF3xae3UaBE7axzRnY62Qasb/gr2DaQ5KWe1CjRdW3zhpHgv2xcYZJ?=
 =?us-ascii?Q?lRzvKe9CztDcmTNjDPB9r0ltydRdOVI3X6f/YYNQjnojO8VKM/NzYHTBQsUn?=
 =?us-ascii?Q?bN1q+JdslKk4f/HjEGba2zFpUmARohDpzIZmf6iIWwoe7IhFhO7/LepKk1En?=
 =?us-ascii?Q?nViWPk3Yll0r1pN6VTvOoDKh5JoP/ofrxkB7pM75yQpricZtOs183U73Q0Zd?=
 =?us-ascii?Q?83TyWhK7hAohlhNUlzIL9EE0qfxmGr9sKcbVZpV6i0/nIOAqEROgYBraFl13?=
 =?us-ascii?Q?zfvIYxifV4QltW6O1r2+vvQa0c50gn6QakqsUW8XbXwlhZbSigPl2su5nnCA?=
 =?us-ascii?Q?AbqZuBrRCSo9mt8DFn7jlMpnE7rLOpE4iHHd44iWED+izDGKBahw8bq4qCXH?=
 =?us-ascii?Q?azRDeuk3Ngyai9Nc4wzVg+Da4Ar2mEjnMsLfISO6InOUh2Xkf9XHY6NpM5+e?=
 =?us-ascii?Q?gTok/knwEsQyqquc8tZxrw/FntEJeUDG9kzHYRFceIW5j5i8YBEZV0Azqjo+?=
 =?us-ascii?Q?Z61wKqiXxRpee3caUSQZAUNxX02vEZHBsH+nJG2cFQa1fA1tvlOfkOtsY6mw?=
 =?us-ascii?Q?wM8q7IFDwt4O8LzY/ryWke7J4LuztHxFroEEtKZcSS3xYl6RmFB5f7QRaqoE?=
 =?us-ascii?Q?Z856zFHuzU8cnL/o7C1lApBaqu4zpAgCgmpr4imdsgUM4XPqAeuxuyqtFDnI?=
 =?us-ascii?Q?dagMbQlnOf9oBPzKTDC124G21vYhWmISrhmny2ME1O00rAWds54Zi+rC/rO3?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c8eee7-fa2d-492c-f939-08dcd1c642b7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 18:27:43.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDm2srHHB/X+hmUEhXO9cdgiw0m2x0QO1EHA1sXAxZNUD27hleT71rxxC+9UCF0Q+b/svesN+rYQHljr7v/V0JseGh1x8/0TRl3wZu1aNSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6294
X-OriginatorOrg: intel.com

Dan Williams wrote:
[..]
> So, while regionB would be the next decoder to allocate after regionC is
> torn down, it is not a free decoder while decoderC and regionC have not been
> reclaimed.

The "simple" conversion is bug compatible with the current
implementation, but here's a path to both constify the
device_find_child() argument, *and* prevent unwanted allocations by
allocating decoders precisely by id.  Something like this, it passes a
quick unit test run:

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..749a281819b4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1750,7 +1750,8 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
 	struct device *dev;
 	int rc;
 
-	rc = ida_alloc(&port->decoder_ida, GFP_KERNEL);
+	rc = ida_alloc_max(&port->decoder_ida, CXL_DECODER_NR_MAX - 1,
+			   GFP_KERNEL);
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..1f7b3a9ebfa3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -794,26 +794,16 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	return rc;
 }
 
-static int match_free_decoder(struct device *dev, void *data)
+static int match_decoder_id(struct device *dev, void *data)
 {
 	struct cxl_decoder *cxld;
-	int *id = data;
+	int id = *(int *) data;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 
 	cxld = to_cxl_decoder(dev);
-
-	/* enforce ordered allocation */
-	if (cxld->id != *id)
-		return 0;
-
-	if (!cxld->region)
-		return 1;
-
-	(*id)++;
-
-	return 0;
+	return cxld->id == id;
 }
 
 static int match_auto_decoder(struct device *dev, void *data)
@@ -840,16 +830,29 @@ cxl_region_find_decoder(struct cxl_port *port,
 			struct cxl_region *cxlr)
 {
 	struct device *dev;
-	int id = 0;
-
 	if (port == cxled_to_port(cxled))
 		return &cxled->cxld;
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
-	else
-		dev = device_find_child(&port->dev, &id, match_free_decoder);
+	else {
+		int id, last;
+
+		/*
+		 * Find next available decoder, but fail new decoder
+		 * allocations if out-of-order region destruction has
+		 * occurred
+		 */
+		id = find_first_zero_bit(port->decoder_alloc,
+					 CXL_DECODER_NR_MAX);
+		last = find_last_bit(port->decoder_alloc, CXL_DECODER_NR_MAX);
+
+		if (id >= CXL_DECODER_NR_MAX ||
+		    (last < CXL_DECODER_NR_MAX && id != last + 1))
+			return NULL;
+		dev = device_find_child(&port->dev, &id, match_decoder_id);
+	}
 	if (!dev)
 		return NULL;
 	/*
@@ -943,6 +946,9 @@ static void cxl_rr_free_decoder(struct cxl_region_ref *cxl_rr)
 
 	dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region mismatch\n");
 	if (cxld->region == cxlr) {
+		struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+		clear_bit(cxld->id, port->decoder_alloc);
 		cxld->region = NULL;
 		put_device(&cxlr->dev);
 	}
@@ -977,6 +983,7 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 	cxl_rr->nr_eps++;
 
 	if (!cxld->region) {
+		set_bit(cxld->id, port->decoder_alloc);
 		cxld->region = cxlr;
 		get_device(&cxlr->dev);
 	}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..750cd027d0b0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -578,6 +578,9 @@ struct cxl_dax_region {
 	struct range hpa_range;
 };
 
+/* Max as of CXL 3.1 (8.2.4.20.1 CXL HDM Decoder Capability Register) */
+#define CXL_DECODER_NR_MAX 32
+
 /**
  * struct cxl_port - logical collection of upstream port devices and
  *		     downstream port devices to construct a CXL memory
@@ -591,6 +594,7 @@ struct cxl_dax_region {
  * @regions: cxl_region_ref instances, regions mapped by this port
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
+ * @decoder_alloc: decoder busy/free (@cxld->region set) bitmap
  * @reg_map: component and ras register mapping parameters
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
@@ -611,6 +615,7 @@ struct cxl_port {
 	struct xarray regions;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
+	DECLARE_BITMAP(decoder_alloc, CXL_DECODER_NR_MAX);
 	struct cxl_register_map reg_map;
 	int nr_dports;
 	int hdm_end;

