Return-Path: <netdev+bounces-252231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGOfMFfUcWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:40:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 562C562967
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BDD0722A33
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAAD481FA1;
	Thu, 22 Jan 2026 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KqAJs3JQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083D480DD6
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067217; cv=fail; b=g37Nv/h0zGFp02s4jiLY5Vp9dCei8ZWnVB5lYgl5odredsSrMWIUByxvPOeecF8HwtYz31vwRe77Zuc2PLXLNHpPGEpVfpwSuKSoRgzR4hHmI4g2yKuZiW0ZQEW1wVyZi2obXlm5HapTYu2DJmZg4HFPMy1vuP+3RxTxctLh8dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067217; c=relaxed/simple;
	bh=DtqMzkjeo9pbaAHHCzLJE2Sp0OTVo8HqfczvxMSu1bU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oygMnypdmm9u65TycSmHA7ff0KNBeXlArZZnmEiOYPsDWBS3LYYq5Hg/xfwb/tOr5k6dTJXhdZrfLXKxpjP0Lt2NSrboL2vm18GEqzQB4FD3yKiISAwxvQeWZbiZosOlhehCf3TcE8hvsKkVqX+u7jyADIx9psgJg+XcY5fVTn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KqAJs3JQ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769067211; x=1800603211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DtqMzkjeo9pbaAHHCzLJE2Sp0OTVo8HqfczvxMSu1bU=;
  b=KqAJs3JQ6jsXsCRPf/4Jal9ukt1Nzm/M5mW6cH+b+oF0nK1tFG5RZtJV
   5Ene7BYfX8rGE9Fo66++nnr0a27ln/nBzNjY8WQd7wG1t70ChcFjPK8gN
   6FJjAaL6QiGnC65IEj96oapAznxZMl7i3N4TUlm8xNsD28SJ1r4kMO3+H
   MFY15yZsPOc9IbCL1ahocQ/tW7NqvsphWoX/u5MXKnYiqZUib9qImUEqC
   VRF5P6FlePJynRqpXEY5c2Ov971Ewh2wHIZNJnqZiyI/b5G5reaG74T/1
   OoknQUO5awsZFQj/H+Ai2n2/l4gYBULjuwUKkHfFiOuzzf5cKlhfyvchM
   w==;
X-CSE-ConnectionGUID: T/Ih4Sb0Qd6hvxdYRi3V6w==
X-CSE-MsgGUID: 9kqvnvg+Rnmux2pWkqLbcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81676049"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="81676049"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 23:33:27 -0800
X-CSE-ConnectionGUID: fT8SjE+NS0GamNECoRdajg==
X-CSE-MsgGUID: slW3MSACRQ6SMgvdIMJxZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="206478783"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 23:33:26 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 23:33:26 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 23:33:26 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 23:33:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osfOZKhad7bheMSmUzP7LIJcuBlCmskEz9Rfs75knXTXhbIUk2VHWCC4V/BRZVDbYwu41hUsURcQ3iiHqjOiAUoJ/njK8YFgiHVRHMotB8hiCanu+UUUtTHwe+OthlJVm2j6NOZ1VQzjwPo3LGlqaflCjhAgv/EvE2hwCcRb9/xN2Muq97UcnWk/lbUoqZ49c01ovZSKjoEKu98mdYk/WOnUbbzzvv/4hAyXyJIC/S4hRkupQEfjuRE88bWWxMHJbR3dWoB2Nuj3w7FJRGbL/SzxYtfJCOsSexHsS9P4fvPNqVYDm1BDmt0QYUDD0JmeqdXMuM3fuCd/sdqPicRdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12nOLKgsaGUw6CIvqAJiSsY1KawYRwDPZ/NlqF6d2iI=;
 b=wOPX+Wm8wgeVSs+lf8CuEcXfIPKkDLBvjK8UjHLjcAgCEjQoB/DTUKkLcvgpMVM0K7+MGWQ/hmubU2qEooe85QRFqggOM5wzA42eOU5EDJ7kLs8Tu4qnlSUo/Zp27aVa11aQY+UpPfS3rQMO9MmpZSEa1KI3XVIkwj1jOHnkje9mDhJ+4YMWI4shIiIq7fDQc2WLhgOj31vGk/QjAkYeqfSuzoOWDilpJhtXnVj0hPwPJA8XjApQAh2Y1ldvVNhBJywIaQwW8/JqUREDIlwQhzpZy/BcbXNETX3Zvn6CX41tDm3WvJPwoEKKbAcK0oPCokYxNWCfT7VippMTIR9rcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 07:33:23 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 07:33:23 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>, Takashi Kozu
	<takkozu@amazon.com>
Subject: RE: [Intel-wired-lan] [PATCH v1 iwl-next] igb: set skb hash type from
 RSS_TYPE
Thread-Topic: [Intel-wired-lan] [PATCH v1 iwl-next] igb: set skb hash type
 from RSS_TYPE
Thread-Index: AQHciimVvfOf9ZL4B0GHSLh+xNrIgLVdy/BQ
Date: Thu, 22 Jan 2026 07:33:23 +0000
Message-ID: <IA3PR11MB898633484D0CB77105D1B9A1E597A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260119175922.199950-1-kohei@enjuk.jp>
In-Reply-To: <20260119175922.199950-1-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ2PR11MB8370:EE_
x-ms-office365-filtering-correlation-id: 4a1a7d93-e2f3-4b08-c24c-08de59888642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|7142099003;
x-microsoft-antispam-message-info: =?us-ascii?Q?YYrHQ8yuVPLSnOeMEa2ndbA+3eIwRjUC2YkVAe5kytLrz1MEBqfar2Bu6VKd?=
 =?us-ascii?Q?u4RjMIhJYQ0Ezs2juNoTYX7afJySEa2j5ps6FynE8Il8tj7rsX7EHNtvBt0h?=
 =?us-ascii?Q?n+ciVwD0fEpW4AxWtKIprBWQx2nO7Cnqz0KT39pOwnMUNjwqAlTy5RkzQZni?=
 =?us-ascii?Q?QJjzu83JBvA/AaD7ueksSlbYPt/tqXvIES0BsgKl+HZOmpsuFXkOmZLDoPhk?=
 =?us-ascii?Q?nf/KQBecR61PjWqtDyvmP7Gy3h9RqpHIt4kcn3E3MEGB7DRmW+vLTVLbMPKJ?=
 =?us-ascii?Q?2l18MQfoCcp6P+3JiDQcV810ml1cDarsngY6wSEsWLywb73r2qRB6StWCfGS?=
 =?us-ascii?Q?KAii5HBs/SJUEjTIEMLrDYQRVoM4qRDRmrVw3IxQemGfN0MNTW2Vsud572jU?=
 =?us-ascii?Q?nf5GMdC+6+1xAghcSlHWEoAh/URO0jM3glLkqblPdewVMG91X3kS+cYbf4/Q?=
 =?us-ascii?Q?Jn+u4wRolwMHfYSFhWcbxtMAW3xCwEBEYx9LqIkij7PUKMp9VOWPsUFlj6q+?=
 =?us-ascii?Q?HXeEqV13nP5+dM1D2W3IsBPAIKaiDnglW15U2EQjPbtZi4KchdGTu2t9uNsi?=
 =?us-ascii?Q?X5U33SxnKMeeIrtIfzxglk+aYvtwhdMDej55Razrl1rmZdEJZtWZTsEmuKun?=
 =?us-ascii?Q?SqwviZEr6Mk6x/RV5ia3P+EvYexTuSEzx4gAz5iuv0ZsOGncEwUDP417wbTJ?=
 =?us-ascii?Q?S/5ni/1kSrfLGu2419FMwrudzRbZugS8RJtFVJoQbtTvtTniTRYPYfRXa0Xv?=
 =?us-ascii?Q?q6RWSxGoQj8BnMvr3I2eT31epbADENv7MrwHJ9QZtgzcxCzAJS6OltILeN5x?=
 =?us-ascii?Q?tPrie4one+rjgsaxrBLgtAnh4Ys98vktcSJPxrz6iKVLSg52X79lTmRnAK7A?=
 =?us-ascii?Q?sXRQepSnqlKAuGE4gh3OgU3Mc0s0CkmJpg+wS1vghMLCyRJzp1+81wAmPXxx?=
 =?us-ascii?Q?l2ly46cN/G2qPFNYbfX1aIY86q0GsOxS31XIsdxZoak1jVbgwrksZj6FBWLd?=
 =?us-ascii?Q?6yZOEdGOFwJwXMjOVRWy4yfo7IihTKBTUK8nPBFPZM+j5y2IP6CvkjbBX7gC?=
 =?us-ascii?Q?7XkJ9bGRiQSZsLqy8/alZ+gxEinjeNVlEKpZD9ZxLPeaGjJcpVFwfIjilERz?=
 =?us-ascii?Q?nP+Wwd6bxfLRFiChhNWoeAjIjiHWh+yr3nFvNERfUf8gRGASM2ITRzKKjed9?=
 =?us-ascii?Q?3Taa76lPq3xFY07lapdCiu5oY9W2bTlE9vuW4Z/eEGRdfda4cphBC0qEObxU?=
 =?us-ascii?Q?Ea5C0Vq9DvqtKiBC/GOHqUuYYYVoQuj9mVhcMJLunHeB5nKqMkq6feHmzEIy?=
 =?us-ascii?Q?VfJlJyK/F7bxHbzvJUERVxdnZBs6e5AvUqRIfU4hUSFh7LzXwUfM4i9m9Ztt?=
 =?us-ascii?Q?CnEdlrFeCbbEgHB4S4f4Sdy6dMv/awRTbITTJeOAcmc0JdG25gn06M6NyI53?=
 =?us-ascii?Q?yw1ID9+q3XMim4B2DG4WYuPRPTB2U1mJtbEE/gnhYO9eqU0niEZOtYruinjw?=
 =?us-ascii?Q?7/UjLpTUSmS5h7Yo2FErEzGY3qGaTYOkEOGixEyGTGFHN3nkaUxXMjwRZhnv?=
 =?us-ascii?Q?KFKyM+QUn8/XpEhs+/ogLGSmFWJoeublQ1q+kcThZext7FMhWu8hgeBGRV5l?=
 =?us-ascii?Q?PQhEudIPS9gzr3ebgYF1GwQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(7142099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yYiS9MAMRFGh+vmNMcJk1MqFQzlHyYcLRZnPKFzkW2fQtgQaPrPcqIlPmd9b?=
 =?us-ascii?Q?6On4pSB7VI2LM7oFM4sBtPDIj8BCw9dmuKS+6BNwSlHpkc7FGl8osHhSuaeW?=
 =?us-ascii?Q?6elSmqtDuHh7Mkp0zhAt59STmF5PAdSm8C93mhDsv7NUKTe4YN9XzqB4fUW/?=
 =?us-ascii?Q?iCQSni+EbM9zNgpAI7ncE9ujx1JgPtYPHdVQoBGfxUo8p/2xbKuAIwXnc4RU?=
 =?us-ascii?Q?pvmNf1jI96SZ04Cx9sDezF+3qmcihE9hOjq4peUfZD3GW+qAMte4Vwlk6BvZ?=
 =?us-ascii?Q?4uAYF3LWxJLyQnt7zbmxeKl8CF4cNeJa4ZdztVfQzFRVhysacnIcLskqrzhA?=
 =?us-ascii?Q?mnz/9xEIYIyYESI2bdpHG0SKORMklTjgyJCj4QVVICCu8nEJPhbfnVWP1nW7?=
 =?us-ascii?Q?Faf4lU26nAaCa/M995znFvX+PmNMNff+1WtFEbuG5big7euuMgo3GeHgaTHl?=
 =?us-ascii?Q?vTFrNLtxDMautrgSSjfGcyNR6M5jy0AC864zbu393UKZy2E+8H2G30MKdS5l?=
 =?us-ascii?Q?vg8aD7WXy084KZ9ptTquKuUeZVzF4edeP/Agk8xXZzul1a8FqQX6lscsMx8Y?=
 =?us-ascii?Q?IPVyTXDwG2CtBCKl2LIWzkEMD8KsmWlg9jiffh/VDiEl5bDo51CV2a1xF79U?=
 =?us-ascii?Q?LPcQGiOmhm1ghL+ss/NzLphi6C3PsRR3WnhjmkZIU2bGDhAMMdJ3JjI9gmpF?=
 =?us-ascii?Q?zEcPTve7VqTUcbivJdsrE9nzTglCC3frSeYP7niwHETjRR3pVge4HacIVxQZ?=
 =?us-ascii?Q?Vfx05zlNqbLxYlRYrj9knlwGRI/dZOWPjYvca9IiGPG0pqJYlZHbNnQt8x9E?=
 =?us-ascii?Q?fccMI6HGP8pZLAYiTjnJuIvwOjKQAHe1adsnGlLjJ8WRWviZYWSsj8bd9YPa?=
 =?us-ascii?Q?L2WzWiBxrSkalgjTTnyDinAArw51Ef9Q+c0COoFjOTW4Gst88BHOD6yamP0W?=
 =?us-ascii?Q?lZ0Q986wxAtfJSgegeO/vxHfCeNLqXertmBnk83XwGN5VwlyrUCrKr1VUZEW?=
 =?us-ascii?Q?9avPFt0CsV/gJqJAfRNLvY/G72xwWKtdD/LPRbcKt4uYxAT82gREm/7D0aZ+?=
 =?us-ascii?Q?4g9QcAVYsjoUy9GP83aRr1nmdvr5FU7lm2DZ4A/sn3Dps+zxaUHyDAgw/eLl?=
 =?us-ascii?Q?ONIa/+nVO67XFazO3/lup/Kf3NBftVUdL61/i/7BjDOX37ZKoBh7QLNXW+6T?=
 =?us-ascii?Q?dmxtel2QOwB8SWSclVT2Zp9bWSnFb4Qutsm8mCd08lQJv1B2sxnOrOJxyrEr?=
 =?us-ascii?Q?Vb+59fGdJ5XqrpEAdKx/SB/ccxIWIJ8KVN5fIV28GGUb5vieILL2VBy4th76?=
 =?us-ascii?Q?tNvWIuswU4wde9thl7jT90LToHHTm2iYQLFmjLXs+8cPLBfwaV0XgetD9nww?=
 =?us-ascii?Q?7dscnzL0LGrXiGxWuQjbrY9Jgt222IN/+VDez/UptuL0XlzzrRDsM9VBz/wm?=
 =?us-ascii?Q?1sVWc8MSoJwg264rfq6MyHYsN50l1I+JpUXJBVBzsNBV4VIOZ5sBTLqnz/Hf?=
 =?us-ascii?Q?FlI+Dsb5++AdIRvfKjYrntrykrTbCih8q7yuCV7dzC9lm7Y7XEpJUHmV4xIS?=
 =?us-ascii?Q?ZQCtHjvTzr52EvXhIX0pGFi+EoNjnTeVIwM3g8FQSYvAhL08937gh0g4GlBe?=
 =?us-ascii?Q?IzrbcEIHN42gpO4sThVPb7Wulabr61n6TifKbJ2JnkGd98tgIxV1RtHnlRHT?=
 =?us-ascii?Q?0K4DMKeGf5ZW7HBrT5NIbmKu2baHmb2GFBHsyTYO7yiMb47yFo3zjncsTZjg?=
 =?us-ascii?Q?gYJD5xvyIEhvEcv8cyW7O5JYn/6NLwU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1a7d93-e2f3-4b08-c24c-08de59888642
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 07:33:23.5534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JoT4fag/2HxmVPpfneGF2LDId2ZzU6iJhQi+qFsCbSpHm82Rnbq6Gzvsq1uUYAdFbdhtOYBRawOPUlZVFQguu0DBWxx4JG7ujSzVgJHDdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8370
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252231-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,toeplitz.py:url,davemloft.net:email,intel.com:email,intel.com:dkim,osuosl.org:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,amazon.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 562C562967
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Monday, January 19, 2026 6:58 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; kohei.enju@gmail.com; Takashi Kozu
> <takkozu@amazon.com>; Kohei Enju <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH v1 iwl-next] igb: set skb hash type
> from RSS_TYPE
>=20
> igb always marks the RX hash as L3 regardless of RSS_TYPE in the
> advanced descriptor, which may indicate L4 (TCP/UDP) hash. This can
> trigger unnecessary SW hash recalculation and breaks toeplitz
> selftests.
>=20
> Use RSS_TYPE from pkt_info to set the correct PKT_HASH_TYPE_*
>=20
> Tested by toeplitz.py with the igb RSS key get/set patches applied as
> they are required for toeplitz.py (see Link below).
>  # ethtool -N $DEV rx-flow-hash udp4 sdfn  # ethtool -N $DEV rx-flow-
> hash udp6 sdfn  # python toeplitz.py | grep -E "^# Totals"
>=20
> Without patch:
>  # Totals: pass:0 fail:12 xfail:0 xpass:0 skip:0 error:0
>=20
> With patch:
>  # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
>=20
> Link: https://lore.kernel.org/intel-wired-lan/20260119084511.95287-5-
> takkozu@amazon.com/
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> If a Fixes tag is needed, it would be Fixes: 42bdf083fe70 ("net: igb
> calls skb_set_hash").
>=20
> I'm not sure this qualifies as a fix, since the RX hash marking has
> been wrong for a long time without reported issues. So I'm leaning
> toward omitting Fixes.
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.h | 21
> ++++++++++++++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c    | 18 +++++++++++++----
>  2 files changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h
> b/drivers/net/ethernet/intel/igb/e1000_82575.h
> index 63ec253ac788..a855bc10f5d4 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_82575.h
> +++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
> @@ -87,6 +87,27 @@ union e1000_adv_rx_desc {
>  	} wb;  /* writeback */
>  };
>=20
> +#define E1000_RSS_TYPE_NO_HASH		 0
> +#define E1000_RSS_TYPE_HASH_TCP_IPV4	 1
> +#define E1000_RSS_TYPE_HASH_IPV4	 2
> +#define E1000_RSS_TYPE_HASH_TCP_IPV6	 3
> +#define E1000_RSS_TYPE_HASH_IPV6_EX	 4
> +#define E1000_RSS_TYPE_HASH_IPV6	 5
> +#define E1000_RSS_TYPE_HASH_TCP_IPV6_EX	 6
> +#define E1000_RSS_TYPE_HASH_UDP_IPV4	 7
> +#define E1000_RSS_TYPE_HASH_UDP_IPV6	 8
> +#define E1000_RSS_TYPE_HASH_UDP_IPV6_EX	 9
> +
> +#define E1000_RSS_TYPE_MASK		GENMASK(3, 0) /* 4-bits (3:0)
> =3D mask 0x0F */
80columns violation, it's not critical, but I'd suggest just remove redunda=
nt comment
Otherwise, it smells like AI generated...
#define E1000_RSS_TYPE_MASK		GENMASK(3, 0)

Everything else looks fine.
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> +
> +#define E1000_RSS_L4_TYPES_MASK	\
> +	(BIT(E1000_RSS_TYPE_HASH_TCP_IPV4)	| \
> +	 BIT(E1000_RSS_TYPE_HASH_TCP_IPV6)	| \
> +	 BIT(E1000_RSS_TYPE_HASH_TCP_IPV6_EX)	| \
> +	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV4)	| \
> +	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV6)	| \
> +	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV6_EX))
> +
>  #define E1000_RXDADV_HDRBUFLEN_MASK      0x7FE0
>  #define E1000_RXDADV_HDRBUFLEN_SHIFT     5
>  #define E1000_RXDADV_STAT_TS             0x10000 /* Pkt was time
> stamped */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index 8dab133296ca..ef0cbf532716 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -8824,10 +8824,20 @@ static inline void igb_rx_hash(struct igb_ring
> *ring,
>  			       union e1000_adv_rx_desc,
>  			       struct sk_buff *skb)
>  {
> -	if (ring->netdev->features & NETIF_F_RXHASH)
> -		skb_set_hash(skb,
> -			     le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
> -			     PKT_HASH_TYPE_L3);
> +	u16 rss_type;
> +
> +	if (!(ring->netdev->features & NETIF_F_RXHASH))
> +		return;
> +
> +	rss_type =3D le16_to_cpu(rx_desc->wb.lower.lo_dword.pkt_info) &
> +		   E1000_RSS_TYPE_MASK;
> +
> +	if (!rss_type)
> +		return;
> +
> +	skb_set_hash(skb, le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
> +		     (E1000_RSS_L4_TYPES_MASK & BIT(rss_type)) ?
> +		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
>  }
>=20
>  /**
> --
> 2.51.0


