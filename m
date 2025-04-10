Return-Path: <netdev+bounces-181434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC45A84FBA
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F976188F4A7
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E132412CDAE;
	Thu, 10 Apr 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnXOgiHp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8C1EBA03
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744324580; cv=fail; b=nRcn4Ea9jiGzTV+3z0RlyMlMp7kbyhQ9Ccxh95AitRMRu6rw0yX1epG05qESWsFZNReld6PnWMFuSDR/YGfd1z7ucVyYkbGL0+voPOk8Wn5iFWNj/tDkeLCWa5epJdRhP0YAxJffVn3sZQbqgIn0eNkzC7WlmRpSZ4MZvB93wSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744324580; c=relaxed/simple;
	bh=abe/RxXy1UTPpsHR+miICHh++MtcWGgkQxJgWjQ3KdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nCL6qEbngWreRokdcdhZty+bh3d+O9deJWiJZAr/OyJpYMBtAMQEdI8J/h+oAk1w+mjQpNKTFmccj2L+W3qmzVIy9IRO8ga/QLiO2WTJiDE3f239r4ocelLbKlabI0CpVKZ9NzSG6p8Ls60dQl8565jvHlQ7/MIGoJngxAl7upE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnXOgiHp; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744324579; x=1775860579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=abe/RxXy1UTPpsHR+miICHh++MtcWGgkQxJgWjQ3KdM=;
  b=lnXOgiHpzOrCTYjI9wpvXMSi+F+2G3pJGmc/rU7JYJoWHHrtcRPXxuVk
   wdMDkK0yflcmQvm2KVZFV+Vr39ItqxqxvmLY6cIstvFyuxDV6a/A7o6n4
   T3QXRuRbhq4f8Jcl/CJyK71qSfA9PPRBjiMvJZ6qalRB5I3yDL9IMTYw8
   CSqpgc92zfk5PXtPVBB3Nf5ERM3BpyHm3VSocwE/oRyY00ZzEfWY976qV
   O9DIQisXtciay52ytbKQoBoQDvj9Huw6esu5ViVvd81sAlqlxNu7h1WmT
   +KHRMf4eBT0v2HchF1e/RHp2OY8XV9twhg2CqW/88f86hD78yZboTUOGD
   g==;
X-CSE-ConnectionGUID: PuTfekmBSAG7HCUcvFLUNA==
X-CSE-MsgGUID: 1rNpzbbxQdCGeJwmn9MLPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="63265485"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="63265485"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:36:19 -0700
X-CSE-ConnectionGUID: j1NEhmReR2WyMS1e8usQ0w==
X-CSE-MsgGUID: LNv198M7TbmjXIWIdv3RvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="133761545"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 15:36:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 15:36:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 15:36:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 15:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMh+nWIOGrRw8B67THElWKqIoM29PMg74eZD2zZhWjdejWLkKuwiZuELIfQ8+AoFRklEbuftjdm47tvwOwJk26aM0qUntlC/Lfm03P1P6F6ngQ853hXp9cScnJux7VutBpeAAgyxjpQaEdcy26uSHdwGp13zuNJ+bKhsWDOvp04gwcWXFDCwRL+5TLFTAJd6v9mbx/wBa5cMqbHztEjHOd1p/tSSGLWnney0XrNaMU0ejZd4nOWoz/e2qboSPy+IqHxT97QP1nKb1nOUz0NSuqrCUhxEm12Ei6rZ5VGAxFbAkmILYADCO5EU33i4mR1FSbcp8j+4Z5Z+rGtg4YhbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abe/RxXy1UTPpsHR+miICHh++MtcWGgkQxJgWjQ3KdM=;
 b=sVY/C0ACuh0taSv51zyq6fEss/feyiq1BPvw+SIvBurYNGbU2KwN8zm5oETiG3uIj6xqGE5T/IUpjk5tTMqBoCi66z2EfSMVPqBuCtuXsKQzfPdkT/neW+4wucetbNsy2eo1M/XKw3PoPI7iKrDBz7vcYIUOp1dr+9xx8OZcLqZVjv+73X84x8RaBaYi7ryDmXf/vIBOh3BznaMxG5sf3AqQ+Eli0R8yxXAB6j433YXyXvkMGMJQmiTjik4DKZ0ipXe85CH4o+C6SSKcWyGAUrXbRm5wPm+GwocKG+VUunjXE1p29uA5h3U4aZVZUmaugmQf943fqVmgMJQq/bP/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8676.namprd11.prod.outlook.com (2603:10b6:408:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 22:35:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 22:35:44 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Dumazet, Eric" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "hramamurthy@google.com"
	<hramamurthy@google.com>, "kuniyu@amazon.com" <kuniyu@amazon.com>, "Damato,
 Joe" <jdamato@fastly.com>
Subject: RE: [PATCH net-next v2 7/8] docs: netdev: break down the instance
 locking info per ops struct
Thread-Topic: [PATCH net-next v2 7/8] docs: netdev: break down the instance
 locking info per ops struct
Thread-Index: AQHbqMFC1vciC7HfjEuApSrPD0rnwrOcanAAgACphQCAAGqoEA==
Date: Thu, 10 Apr 2025 22:35:43 +0000
Message-ID: <CO1PR11MB508998C288EEE2BFD2D45F44D6B72@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250408195956.412733-1-kuba@kernel.org>
	<20250408195956.412733-8-kuba@kernel.org>
	<119bf05d-17c6-4327-a79b-31e3e2838abe@intel.com>
 <20250410090802.37207b61@kernel.org>
In-Reply-To: <20250410090802.37207b61@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|LV3PR11MB8676:EE_
x-ms-office365-filtering-correlation-id: aabd0bbe-f07a-4e22-144e-08dd788007e8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HLgbML4mnlvlx8UMxRBRdINWlS2s1PkI7Xk4nq6Xzue5ASQBsFpZaK3Y5mCL?=
 =?us-ascii?Q?YH2pXqLPCyTwMlseJ0OW995kpOtlDYRvwUa9PyZ2Cjtttw3qzidUMwjelf0R?=
 =?us-ascii?Q?c2lL6f4tYThYlVNVoI1aD5KHSzU+v7htsljXj8uBgwRp3hhzpXxa7i+vdaPg?=
 =?us-ascii?Q?EzBy/AS4aVTJCp7HPCWW43IVKNaoF5EkvD3dBrlOZaweE3FKmD8DbK5h8EoF?=
 =?us-ascii?Q?+NiqYqDOw9JIRZOtgFG1YZB/L266JftbmdAE71djAEeI1MXv8401OtdsTJWE?=
 =?us-ascii?Q?yEdJtfvAFzI+AbWcdxUKP23ruW0PP32ShF0Ch2rWwmXi2tcMdnuTkVkueUQn?=
 =?us-ascii?Q?xyDVfh1dngBnsBrc2dfYj+PjdB4JEZEmWVV8NwfMrszFuiDN+tO+XEy4Yn0Y?=
 =?us-ascii?Q?eRW9lCG1lgp7H3XFGYGCkY75xNFPREBHVyUUMfUf8PtXksmvHCtQ6E1OHNwC?=
 =?us-ascii?Q?NOsVsYfSHzyXMmNH8/x563VepxEEDz52N/F02kS88U1WFYYJSPROVSl82PS3?=
 =?us-ascii?Q?Se7lzTNJL6XjwRIbsqIj6zNjA1Ln98pT6ONRPUoqszvH1rSW8dAeLIsZQfmN?=
 =?us-ascii?Q?/rBcTPeufohLyagNpre/tfnDrOIZ4siWE5XlV3BTcdjjaCUEmJWOvGtzlgp2?=
 =?us-ascii?Q?A0M9fwppd+ku8v2Tsi8wuOqyRnABWS6VdTkaq11Dh6XM+trO0JU5GJaBM36b?=
 =?us-ascii?Q?xEs6sx1mcJBq27EepcMa8J1CiZ8jEtlBNpdJekj2nHBDGv/RsFO3Nv4fFaDA?=
 =?us-ascii?Q?piZLIADK0C4hHqy0fov+6hBWiAE+c8HFZtaw9NFaEQGdSVZwzifuz4oQSKaV?=
 =?us-ascii?Q?gFWJ7rASadofOczwi4GCGuy1QRJmSI5ZJvy6100KznaxUWCSjHJ1mNKV9xPl?=
 =?us-ascii?Q?FLfz2cNNOEAyfSa5jLiYKribZ5sxV7vFw+j0l1Zy4+zpTSn5nHZ2UEtH8T27?=
 =?us-ascii?Q?ymE4LpJk/8XtuVI60il+9pur/ZNBnn7/snzYMJnxxKcASNQO9mhkbBAj+Q6m?=
 =?us-ascii?Q?KekiE6IoMxIyLcJTIJgHMxtvzDemW5m49dnENF9jvW4IHPNYh7Kcinlyzbyd?=
 =?us-ascii?Q?TGfLWlbUbnQUiQNmGhwiBmEN7zgiQej/D1Od9hCgw0BZBv7J0CgzbHbTT2YR?=
 =?us-ascii?Q?sErluql+z2S7QFIf07NxQhZGU56w3C7u2aMEB0cqOB5neLyqMVIjMb3GCv4T?=
 =?us-ascii?Q?6kO00r5HORF7beHVdpnfAFLdmnI4rV8HlNyo6AIfH65SMcVp2aqxPNJMID25?=
 =?us-ascii?Q?YvFW1EGbbhKuEzhjWmbLrlUtarNYZJuerxbyjStO+i1bv/8Zb3WwXiRuQF7d?=
 =?us-ascii?Q?22+WkjvgJNsya57XTNtujh+0ZETA1X+LglrjX5epcrFoDGu1cPmz2lM3lBnf?=
 =?us-ascii?Q?488nQ587N9TpwgdiihwCMl/QjjiHOZAUFBCl72+lFP24YInuvYuKzTomPlt4?=
 =?us-ascii?Q?7CY/s5l4q4bPRmbIqlp9nuSP4u8cY3jhPFtHq6rNQla6jI0u3HIyJw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?imx6/BwwIst2hzp4Hy0fRolC6e5AqIArSR8w7t9X7tdv9HuyQt0jtCuLx2PN?=
 =?us-ascii?Q?J5E9j6nbLUSnZcsliFx+PN6P9WLdRLje3RDqT4bJHWjnZ8cRVPLhliLBznI5?=
 =?us-ascii?Q?3O4V2NWBKFpXf3tz0bhMI+gwCb5AAKOgN53jJmYty9keQ5Aa4ZDgdU8VAtud?=
 =?us-ascii?Q?NULJpaT8lleulmvh6EjjtHU8i++azxizU6MAZpRPaydTeMnRXISJ/kxGx/jN?=
 =?us-ascii?Q?tGLrBkaUYLujie74StOXuzHbtmygmJ++1t9W50kfZUiTuU+9RTk965q+Mim4?=
 =?us-ascii?Q?Wkz9mj9I5QXY8ZJTSh48bZb8U1GS0IO7WtCmjIlVXEh3vDuJl9wGQvCHKNLY?=
 =?us-ascii?Q?QYWrWTsf/vLYy8oFIRqmBqYl1kBoPLV2T/NguxRPn/Cw6krKJkCnlnuWfmua?=
 =?us-ascii?Q?zWiT7yQVMAcuuyt7y0fBV6yFP1eXIMEoAwHFTejH8beC7+jH6kQPZgwmZUeO?=
 =?us-ascii?Q?2ERjmnhWjt1NEQqrFr8090agQtYkMyZ4caifjARGgjsM8bljfw4Rx6lB27JT?=
 =?us-ascii?Q?ni/0YKY6eN96fSqDpyVzR3qRrJBfmKEjm6b0OSNKHN1ASfA7x1/c8Vbc62rz?=
 =?us-ascii?Q?ROtCt8QAQJTmJTIL1Y3gK7mtdMuIaoQRo3fFgMQr3jCqEZjn3laX7k7zP0Fn?=
 =?us-ascii?Q?Ot1FUD9XYJ4nplyHkgHtTKYV12PHy/MgnBhQX5AT5jaOG9KltrQ0t+DckuCg?=
 =?us-ascii?Q?jV4+Vl9gBTYV/tcsB477KlJ61gcF8oWXK9LcicSPvS8upIdLg3pgeHpkxDCG?=
 =?us-ascii?Q?a8PJJcs853NbEEE78nYufBWcF5pevXyFXaKTOTk87pHzR5nuP9MziYImsmzf?=
 =?us-ascii?Q?7j6jVMIqBKBG3+mmO3zs1NZrNnNplEBZF9/JGsc5GE5gsK4/1DlTH7xBy5Nc?=
 =?us-ascii?Q?Kpho1hUFakGpGJ7OGgJbiso4UL9bHi+TypBXOzhs4/Vhw1lJs5YlSJU5qKvJ?=
 =?us-ascii?Q?tWfT65gXQioyFgHcaB2EbuOMvnXwSqVV75o8vDLB7MXiheraj1W3wCQgZN/v?=
 =?us-ascii?Q?JJ6MGNGzPrZtwfbgNruQw1qfX27MtW3AMmGCN6tBsx7KYOe8w9g94PetAy2G?=
 =?us-ascii?Q?sT0Q+bNVMa+cs/F+Uddvg+W5oQtg7ZiF/2y5fjnutLeV3N8w1wttoasfpX6J?=
 =?us-ascii?Q?6tGaGzwX/JK8fIkozQMO2kc+tZ001USCFEOD7eX41xqZ++bIHWVjP85IIbdg?=
 =?us-ascii?Q?uheS8JpZGWwY8hLuSw0cNNhBSJveZT8Tsx9WEwu+9il5b4Djqkis/CVI8Rbc?=
 =?us-ascii?Q?ekcRcpLo7zbOVC4WI2Uy3pqn+B+jM7MLBVu566tJ/dHtqr5vowaGmPMkrFJm?=
 =?us-ascii?Q?1fPZBURS7FJOcs443hEzxh5iucngbWfxXKX80SUkmPvR523wza2kLXrTeo/2?=
 =?us-ascii?Q?RlXjLklvyidfntn1d/oUfIkGBORdT+JoD+AOoYpxAevTB67adu0u1sQuGXDU?=
 =?us-ascii?Q?DbLsYmxUIVTmWcFxK6eEePRsSZ/wSV9hkke5x25aAdVhwIBy2g2xJ8VawB+c?=
 =?us-ascii?Q?B7LZvRy1oNP/J3uvPC0tA72m6/J0CRdqrDrYHd94QPAUij/pGnjHWrG82P7T?=
 =?us-ascii?Q?JGmiWizDX7KDbMTbxycBbuqsgq+fkYUUMElvjpnu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aabd0bbe-f07a-4e22-144e-08dd788007e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 22:35:44.0186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPPywq2JZM6Og6fO1PlIG0xUq6X4iKILAv/rBsHtU6Fm31Myq8f66xiNzw/OqE9ObBcKldhxWFz+2tB6nGCgJXxMyAaXNwL5ncmNkNUQ0S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8676
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, April 10, 2025 9:08 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: davem@davemloft.net; netdev@vger.kernel.org; Dumazet, Eric
> <edumazet@google.com>; pabeni@redhat.com; andrew+netdev@lunn.ch;
> horms@kernel.org; sdf@fomichev.me; hramamurthy@google.com;
> kuniyu@amazon.com; Damato, Joe <jdamato@fastly.com>
> Subject: Re: [PATCH net-next v2 7/8] docs: netdev: break down the instanc=
e
> locking info per ops struct
>=20
> On Wed, 9 Apr 2025 23:01:18 -0700 Jacob Keller wrote:
> > > +All queue management callbacks are invoked while holding the netdev
> instance
> > > +lock. ``rtnl_lock`` may or may not be held.
> > > +
> > > +Note that supporting struct netdev_queue_mgmt_ops automatically enab=
les
> > > +"ops locking".
> > > +
> >
> > Does this mean we don't allow drivers which support
> > netdev_queue_mgmt_ops but don't set request_ops_lock? Or does it mean
> > that supporting netdev_queue_mgmt_ops and/or netdev shapers
> > automatically implies request_ops_lock? Or is there some other
> > behavioral difference?
> >
> > From the wording this sounds like its enforced via code, and it seems
> > reasonable to me that we wouldn't allow these without setting
> > request_ops_lock to true...
>=20
> "request" is for drivers to optionally request.
> If the driver supports queue or shaper APIs it doesn't have a say.

Which is to say: if you support either of the new APIs, or you automaticall=
y get ops locking regardless of what request_ops_lock is, so that if you do=
 support one of those interfaces, there is no behavioral difference between=
 setting or not setting request_ops_lock.

Ok, I think that's reasonable.

Regards,
Jake

