Return-Path: <netdev+bounces-287297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E07J3qUA2q37gEAu9opvQ
	(envelope-from <netdev+bounces-287297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:58:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A073C529BCA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94201306FF11
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95C13AD50B;
	Tue, 12 May 2026 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6PzgKFK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF913559DF
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618984; cv=fail; b=UZkxdl5n9oB9RcCkkQfOD3/kSxUg9ll6nRate5SljjLh5v2fOaTm1cuE5U3dFZScw+w3+sAJmqtt62ZfpQVXexDIR8gxx4P9kmvxppK6nbvKf6QVwsOc2uTTRDLy6dgrvydrDCj97ExcfqkHO0OQKFMuDvxhgB0QNc5YroaBbcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618984; c=relaxed/simple;
	bh=Ij0tK49vNZDguv61F1sBuae81qLTCXi617pRoIJktnU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WgaaoZfgO3F5qReZ5idGO9uIOp+NoGr/Ct4ZukZ/w2wAX+lwC0OIBARCU6XEO4kwKTOGaYAqYBMq91D2RU34w9fQ6GQSOc4slp0FAwUn33ORNofDBD6zV35awKGL74ckDEgYPyE0IU5RYcgyqNiwqeKv1i4Hs94QKgxyVwfR5Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6PzgKFK; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778618984; x=1810154984;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ij0tK49vNZDguv61F1sBuae81qLTCXi617pRoIJktnU=;
  b=E6PzgKFKoOI/bLzGT8paHJUrUJChO4TCQM1IjGcNJWYFZ/OFZVwLI7fV
   RBmnN5lHiLp+hEs/FBatDqg3rfzwJzPai1GcE9km8ps7g26RfDXksZVAn
   nBZpOI7mUUVTf8nVmi73YwnLsyrjgOdGvwdVY6wrXSjBx0TS8ARAQ2BVV
   YGJGDeEY38lSM9hnrSdNxBmYl2wTpav8e0xJQWhoLsuJJYZJllnVPcalL
   wizGJisc2Bq5Skp5nspoBRIdOQmlR9nnXoLPU+2W7+9/T5eFudimYO6YP
   cF06lHjB27iJoBhK4wYFQCp7Mt0oQQUez+BT6eG1MLjvPlG1LyUo+rVhv
   g==;
X-CSE-ConnectionGUID: wR3UJR+tTw6ld8D8IsvwCQ==
X-CSE-MsgGUID: QaVnDw9HRxWlSoBkvr70TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79522147"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79522147"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:49:42 -0700
X-CSE-ConnectionGUID: DohZLROyQiiSYzZasyQzkQ==
X-CSE-MsgGUID: hkl5ZSc2R9OTBWIRX+g3ww==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:49:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 13:49:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 13:49:41 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 13:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2YEvDeGEa+lB5nceaEoZKVFOc0qK3mWbNHlCxtX/ccTDnUk9ODiFMamQSyCcfJo/p9242sV6D+vtzf2RQRTgZCT53z6bJZZxM3WPmu6mYRzVKgX5eYRDzFAHB6jo56VOuGEdvORaznPVvl8w0iAM0UhGQz99IHkotunKFRmwhQoXkrHGfeGYIHXhdWRqKkZmhkYzsNhY3NdmP/mG69eN9cUMDFwEUv6RJED6mLkziRBU4jA4D00AGnQZ5VAnFE+IeU7SnXsFjsyzw/JeAbWx0P++twY2iBKi1SxdtcOngZeKa6SRql2leEuyLexluIEncLO1tCNcB90MrP+bsW0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP2SPYo2+pbdbI+71r/A8YeKBe2zJsZDp8ju8aVRaF8=;
 b=W+BZM31Z0g1c3eaMhqOJM27is7z9UnynpgKekxoBlsN2hU4zDPVxBBnUMrl3lCPG7NKyyi0OPAhpfH4n5RW++aqZB4MEjmHMFycq9T67NFRaRFQK+9oBrZjL0+HYCEVfr64QDbxmtQebGLOyQ63BUsOZsec74GDvxtO0WeNsfT9x6qUE3iNvahn7KntOsqsehVyClsMicmJh1Tnv4Fgvu0joOLEalY83U3reswYj021tU7++xNhoNDLzb/dnf9zfX/e7+6rVpZq6mD38CmR8P8BbWqlUxcXoTihvvBhF3rJQhtHDssrHNwuA3YvUzDyCt1ewo3jwucKFztHijQbsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by CYXPR11MB8731.namprd11.prod.outlook.com (2603:10b6:930:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 20:49:37 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 20:49:37 +0000
Date: Tue, 12 May 2026 16:49:31 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
	<kuba@kernel.org>, <lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<maarten@lankhorst.se>, <zachary.mckevitt@oss.qualcomm.com>,
	<riana.tauro@intel.com>, <michal.wajdeczko@intel.com>,
	<matthew.d.roper@intel.com>, <umesh.nerlige.ramappa@intel.com>,
	<mallesh.koujalagi@intel.com>, <anoop.c.vijay@intel.com>,
	<aravind.iddamsetty@linux.intel.com>
Subject: Re: [PATCH v2 1/9] drm/ras: Update counter helpers with counter
 naming
Message-ID: <agOSW70ZR59ubyP5@intel.com>
References: <20260512191610.1817578-1-raag.jadav@intel.com>
 <20260512191610.1817578-2-raag.jadav@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260512191610.1817578-2-raag.jadav@intel.com>
X-ClientProxiedBy: SJ0PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::13) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|CYXPR11MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: b6acb596-b689-4bd7-92c2-08deb067fae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JXr9xbrdDWxfQVAdUM9eAS78mWyJh0FLO9xot2MUWYqpGpUYWjJHVUmMaczFQaWT2EZr6NFdrIH3RE20z05oMmjOGOFIDQ8h1rGJ1ysAhNzi9V0XnebBiQ3x5hNp4Y0Z05y/5oFx2pbOhuxbrrdh1ixMN+yhhasxEPS0qlu2/b02BoCrrAR6G+JDL72gLho8rVh87XtqbbS7MfT2jwhtW9wcuZ/+xrzFl8gAJHo/7ZVQLxjG8oemhFvhlqgTMJi6OsDQNZFkg367fqmwPhi9XNUtSkQxwmEsOzmY/Vgd7gOB8sUJdG7BYJxpqfOdw7Z3Fjhj/oewPlh93XlMjDh+3kMRYOvMtY3aDGlNDh6jLUcrWMxr8/89Vudo0emp6NiBrDxhwtkRonrDgyPpFw8ccj2COm8mF+LaALQz+/a9g/nv5ZwmxI0D0asJnFBN/Qg34J6x9iaCH9058NpP2BoeYaEDQF+hDP+1MHY2ADLFjhZyLQXG9uAUuBF7Il6Q+FQwHQ5Ll8mxcy2uNoU2156E0suvCkPc+CLH8h+b7QwRLfst+cQENNb1AR7KOnvUK71JLRvH7truPQuqgf9kIaIig6Jt3mXLuos098H7486DthBmhbJj4sIfJ1jESdoMftShjK2m6MCm4wu34yRteD1ZnxaNT6f8MGB5qtHpqZvLxs0GIusN7205dYg3cvIJrFez
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i31WNTVkyIKT6x3zshc4kmxPbLnqJw5EdnlRBNCVdQ3hv1AHKl3hVv2miw8A?=
 =?us-ascii?Q?o7vRYSNEjiHXSO31BLX4CRoaOf+hEm6e8RAf+MHJwzHAPblV+gJvk9sswlJ0?=
 =?us-ascii?Q?5DyFXfz5gStbz8rqktKiQRnPxvlyjUcel95tP/mhqaDwC4HW8eq26i8G1BxC?=
 =?us-ascii?Q?rzYmkB3ocRwVFZnzy8RdVvE9ezjg/DeLnQOqbhuQnSiUT98TxiUO7U7qn1id?=
 =?us-ascii?Q?6RZq74yPEVJkdLI8jwGa4Em92vcdSdFmm9G8IujoEBGa0ZSkwHtGOz15JXp5?=
 =?us-ascii?Q?tStylP7QlNpALJEmaRVh/EKinw2t8AvEAfZYUtTZ3dwDqQJngfYI1GT9zepK?=
 =?us-ascii?Q?A1Z0Z47pJOHrmaP/XdGqGC5fyE7gImLTjqEcewDqGhuRIEMjvDUXe7jHOO1p?=
 =?us-ascii?Q?1bi2vO4ImKPQlaPR+Lw4MBBWmP1Ab768Xo4ASfLEk/noi1UyXmVpgZB4srqU?=
 =?us-ascii?Q?svhOC+yh80JNfv/dwbPHFcp7GxxPcGm1S2pPkftkHSvdoMKi+s4i7TZCqaRx?=
 =?us-ascii?Q?N6/OXOGwFHkLEFxVz5NxYvAeluAMJF9I68Ts99sEYSmHNjdqQOmZE/uqwRL9?=
 =?us-ascii?Q?s3h7ZadYX/cV1+CMbJZJ+EvPAMfdfhHZv3/mBEFy93MbG8BDfcgv/Y9wmW2t?=
 =?us-ascii?Q?YZ5sT0q+S9Umb4jFj7Xgyx7HlL6KD1QbbiBwBC1sHnHidFz7p1pxUCek3gfO?=
 =?us-ascii?Q?HFG0/vF6RPXqO7hYgrX3gNVKgAGxPgWDEC/J/Meo/lpgDdxelgXXtctq/kZq?=
 =?us-ascii?Q?C936Hyi7MtYtiJZCiCU7GYbnupj4pQR/9pLPxuxlgHJbcfzRr4QJbLKafRXn?=
 =?us-ascii?Q?FSU3GmEHLmA+W4uTPFSdoRBWWJmwmRP03NyS8imgrNyefioJr9J2V/t54g7V?=
 =?us-ascii?Q?zaL+ubv3O5fC1HLwwdtBA/qM8DlI7SDgDuPzf84WS5A89X9CMdR7vA3g1rWp?=
 =?us-ascii?Q?koZ+oVea0Tdt+sVof7/olcorEvSl79zFua2fTgLKrnZ8UUWlmxnmhjWVlhoR?=
 =?us-ascii?Q?o3iEmxqX4xthG8t39eiQDtrdIc5EYxpAG5KhvAzQc9t1reWQ7G09cX9xkXSi?=
 =?us-ascii?Q?YtnnaQ4FktS3yp1gB5kih9YNNWvulWRHql1siYkQEbdLnqjbCxI2wKBvmSvz?=
 =?us-ascii?Q?UvHILKqeoF0zOftC+GB4poceNAivlGRkSnZvCyza0jNI6f6GabMrhDZ9waoX?=
 =?us-ascii?Q?yBzfbyKwpXsKPzMLdo/bTV+hIZe27a0IHnu6JCDXc1+EBFTEoLagYfyE4BR9?=
 =?us-ascii?Q?FRarRt3oP7cZCFHLEHU6EJYH2TjVYQkuyVNbL+3BxedqPDCOoqG+EFCUwUX2?=
 =?us-ascii?Q?ceAkLkP4L2YqWUqr2boBhgYLbj0DhrXhIwUQKOH067CchW+Ri4EAGtkXev5S?=
 =?us-ascii?Q?aqH7IiPmFpvOxjG0or4kq4zqeLL+U1RaLF49WNkmuJlUsv79MWFUj39AkNW2?=
 =?us-ascii?Q?ngUONDKXs7f7u1Blz1+bAd3nlgquzDRnQvhlvRq0pcvuacEnc8bkoRLL1FtF?=
 =?us-ascii?Q?2SGFkid5ttQAhNN6XRoHK9k2xUoHyq7fQHzIK0zME1uh2tKCBIPcpQKfHmOE?=
 =?us-ascii?Q?4hYeNEmc9VJ5R6dMQV5X3/QBCLNcrOjCRm7QmdotOJAPuwR0QNzDp0vGnBZC?=
 =?us-ascii?Q?k5RU/ulNies8ti8rBTuAVxCDkf12yE+Kzb+IHeoKB45aVphfdze892z949Os?=
 =?us-ascii?Q?4S/WKIcagI+cSZWriGWhoqV8F2VinNsEZIz+7LmtG8q7WlPJFdgjXXy+4uw4?=
 =?us-ascii?Q?QBvTGPLcSQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: P2hvtxB77ojqBXwluIoE3IcrTEbNoSUhTHq3QntNEJWrTSDsvYxuGoX41AtROaIsdjZojZdEuqxgToturg6wOh3miUHdXpaVu9mpr7HmO5ucCUzA+cxAWiBzZs2kutcLkVPa+l+DNffPaEyxtzBb5BT77eodOovXCEB1St03CQjX8aYsEDkyZ469XpDAKDtCs7Uc2IFi9fciZ4M4ToJIAgWsCPHTnYtZ+jZGq+FPBAt107f16daBr/oN7hY8cPvAsxQZElp3igKgwHOVZkI3emJKvXznP2NLr44x8SY2yu5reudiS/tq6LoD/1QBmunos9eugwge+o1Rxu2wSHGLDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6acb596-b689-4bd7-92c2-08deb067fae5
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 20:49:37.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mApWimxfPJawZ5mDf/jfhWm910dA5FrhM0+85k5knQWi9JFFxhJf/EPPEL1lapcbChXeWFqyuXxpV2rbVXCbeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8731
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A073C529BCA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-287297-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rodrigo.vivi@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 12:46:02AM +0530, Raag Jadav wrote:
> Counter helpers deal with counter values. Use the appropriate naming to
> match with their functionality.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/drm_ras.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394..03db53d03329 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -168,8 +168,8 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
>  	return node->query_error_counter(node, error_id, name, value);
>  }
>  
> -static int msg_reply_value(struct sk_buff *msg, u32 error_id,
> -			   const char *error_name, u32 value)
> +static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
> +				   const char *error_name, u32 value)
>  {
>  	int ret;
>  
> @@ -186,8 +186,8 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>  			   value);
>  }
>  
> -static int doit_reply_value(struct genl_info *info, u32 node_id,
> -			    u32 error_id)
> +static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
> +				    u32 error_id)
>  {
>  	struct sk_buff *msg;
>  	struct nlattr *hdr;
> @@ -210,7 +210,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>  	if (ret)
>  		return ret;
>  
> -	ret = msg_reply_value(msg, error_id, error_name, value);
> +	ret = msg_reply_counter_value(msg, error_id, error_name, value);
>  	if (ret) {
>  		genlmsg_cancel(msg, hdr);
>  		nlmsg_free(msg);
> @@ -278,7 +278,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>  			break;
>  		}
>  
> -		ret = msg_reply_value(skb, error_id, error_name, value);
> +		ret = msg_reply_counter_value(skb, error_id, error_name, value);
>  		if (ret) {
>  			genlmsg_cancel(skb, hdr);
>  			break;
> @@ -317,7 +317,7 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
>  	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>  	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>  
> -	return doit_reply_value(info, node_id, error_id);
> +	return doit_reply_counter_value(info, node_id, error_id);
>  }
>  
>  /**
> -- 
> 2.43.0
> 

