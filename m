Return-Path: <netdev+bounces-263329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE4hJr8Rp2k0cwAAu9opvQ
	(envelope-from <netdev+bounces-263329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:52:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B7E1F4251
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DE2530C29FE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954FB3E3DAD;
	Tue,  3 Mar 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7iZo2GQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5316E370D73
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556429; cv=fail; b=h32nkc1QlXF7Qi4LpIwWUFbMrRfaS90/Y/FItwqT8cbjE6AkPpX4d4bg2HlscQqFzfsRRU5yZmxwEOartLNJ2BajRGXWOaUHha2Z9+d2ByCwg6v+d3vVvb8AtUPLsUdMqngd8jfLbZ6o24+d52qZ7EBdp0h5GEl+6iNsIXRWHvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556429; c=relaxed/simple;
	bh=NJJo43r0t+4D9R3ESS1HPkHUsc/akBil5ks+nBcUFWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ONVbITEq9a9VmcXA3UGnb4gYY5zJt6Oqw6HUsw92fmw7EZSSeZukXr8+6VsfFmXXjjnk4qUynRD8gIvuwbNfh49oJtsa7qWee5wKUzSVNNl5wQsuqNOyjefgxF+qs/HWD5G1H78f7yzs9zKUJwaEy96OtzyO8chU18lGhPv0RX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7iZo2GQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772556429; x=1804092429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NJJo43r0t+4D9R3ESS1HPkHUsc/akBil5ks+nBcUFWM=;
  b=U7iZo2GQQg6U4th9q5Gu7p/Z0okJFePDULPl+P2WPmVE7WeSxOJ90H27
   3ECZp4WKPgfx1F7cwk7EM9YeaOaO+HM4jutZAZoMwvkLZvUTXtDN2uf8l
   q9dSp93TYoHryI4yrfAktwjYi3VlD8a6JG7ia98q3llPH+tXnKQz5bPwB
   CAXicgjqGXRKKhuDVwrptBSIQN9Mztfr8WXiqHiENenF7TIlOAaxESbKx
   BtBtVLqg2kLL/ykYfrEY2etiO124CKzdSLaLOxsJWjYDJkqsUoyQVGSud
   F4eITXYM+zIsJWKObY4LO94E8L8Y2jF0H/EyuSZ0lFZaPAR5zuUszfrQu
   g==;
X-CSE-ConnectionGUID: ImSg+lnwS7iUm5ntmQEHAQ==
X-CSE-MsgGUID: L1Rb1kBoSs2v/fo/ym6e2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="96211988"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="96211988"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 08:47:08 -0800
X-CSE-ConnectionGUID: lYazL9YuQhuldy+DVil0bw==
X-CSE-MsgGUID: K9Ew5QOISJuwxddyqhGvTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="215957716"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 08:47:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 08:47:06 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 08:47:06 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 08:47:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ted5YBr5HtUQQWEkHRS3XycTdJ9oXMZOwNZiwvAk7OVIPi0FDXICYyqr6MLPMVWaaW5OUOvnUVBG+64rwo4LuJ9KHPJfCWyhmf7E56dxaUA4TTzDRpvPKQj1JlMGkzFjiT4HdqGNTRmEDRfst5iFBKFtMwdhWNDUlxhKc6b+1gftyOEUG1eFRp1Xw7FIfcVuBX81+xZG57qpGJFOYMY3BXejR+P6vL61Tg6qbjM6/++5h/OmybUO+27xX8qnJK942PlZCVBrya+dUB8kxkXlpA03DOQJ9bR2e/an/dtsFH7CIALbtMaV6q+mk5FKv2w4DazBvXd4ewkAgLLKD7+g4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeZ309igHUAl2fxxss3ZTWcZCziMbuHEpzg1v7slwAw=;
 b=V7hrD4U1bpswjaXVu3o9LLoCNSugDKsMMS1wRrEbX5UmOeBxCiRVSXHc/nf7ztcMk5OLsBWIi7sSf2Dcua0Nf3TL1srR2rE40Ic3fuN5A9pQWxH7ChetNsQM/ckAtMx9EKLMe77o8PstXt7hzxtHlwx/gWv8WVFosF2xlkR0EbUcH4dk87UBS4SCMexXHQfDlUYDxsRIL8+5uRYVpH/wdZPDYkbcZDNMlBWms5jMu0aCkSHB7Gin1Yup6vzBvK0bpnRJHg1Mc4wSeQdG7W/kb4oHTOE0zO8aDlthBKDufsuVYSZb6BsgZdmTkI0azyH/b4dCz9WMjfnvnl3doaDtVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SJ2PR11MB8513.namprd11.prod.outlook.com (2603:10b6:a03:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 16:46:56 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 16:46:56 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 5/6] ixgbe: move EEE config
 validation out of ixgbe_set_eee()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 5/6] ixgbe: move EEE config
 validation out of ixgbe_set_eee()
Thread-Index: AQHcihWIcnjT/nEZFUiK+O2pBgeg9LWdI5UA
Date: Tue, 3 Mar 2026 16:46:56 +0000
Message-ID: <IA1PR11MB6241E095015DECF0FD46C3608B7FA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
 <20260120134434.1931602-6-jedrzej.jagielski@intel.com>
In-Reply-To: <20260120134434.1931602-6-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SJ2PR11MB8513:EE_
x-ms-office365-filtering-correlation-id: c6a7840e-7ec2-4411-3793-08de79447b66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: 4eUIlTFW48rlhsAn+Ir5bUsWiOZ+GNfXDHZyrzketv80tryQRQIA/r3sAkGUBDLMo8Fd6unFB35BZW6KNH/hzVNKNAzDvk0w9cu3Q+IP7Jap81Kn6R0kvwdgREGbfq8KVYKPlGoBnigm5hKNbtHEFTrMvq/ScAd45mpHVwqhs8mNYJBhcfj6c8IgFbBijpZ7VxJLwqhF7Rnw/9AwJz0pZbIugIdrRiNczoOrXR+GGtjhLGpMSEglCVbLVf1Hhrz/oSBDfqDWQSU0qLP5lKxrP0ahFdg65B1nOmjy9vQFOg1nVaEjHI6EIo7ksuafR7mtykmodGPWBnlJ5Yb4Y3r4V3Dsl6O/b9Y13n57Vin7FrXqlKS7OTrWx2FdLIq5EdbZ8NJgewm4Nl/FflDChTJTHLvCIwxBlsj2aLZ0IMrGmK9DvkPf6BmWN8KGmpPXOKOePavqyPES3kKh9swU5oOLu9hScEGW6lCZqV6meM7jsA0Piun3qHl67WDCjDHzwX6UI+EL6iRQvZdLB7H2vvdlQGirzMJRdAbBOgR7bkBWSnQ0edWvO+xy1h/HuMHwu7WnWFC55wdQ6M3pccjdSpWBnC2pOfryNYk7eT1XsePhGPzhoO+f5OdmtWyjEvzSVxkru4eBTN/0ih/1J160VlrKYL4bQHokRCC3dOb0ONIkuio1XDMyY3sbfNnHl1gli3PUeqTI3dmo4YBUe3AmPfdq950Hj4f59wyziFTrj2OZ+kEdhUFwNyMnbazkPUeKovqCZdc3cyIX+q06HT37/HUjTVAf015gP7QLx6PhJ7hU2Q0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZI3G13hm+nM+nzAi8aK9F9rPR4nrW1jK8Tobc7c+ulQWuiaW0iFDfe1kDxfz?=
 =?us-ascii?Q?xGTfFrLngX2vnbVbiVZJqGkaCxXzWabLH+2hrT55Fq7Ex0cT9uKrr+bKWIXe?=
 =?us-ascii?Q?0a24myNM2JuWCp+XT9K8q96t9o0lCA8W+ABgA5g5jC4O1qTk+ufhB3yFsBX3?=
 =?us-ascii?Q?Ri+KX+1JTGMmTsw/j1P4E42saAQHPJwLL96u8ZtpyjHgxMtkZIXaiO2jQp/M?=
 =?us-ascii?Q?k9ZuaMVqqgBaQF2C/RMPvNld0HGAojs+pfTcYlsCQPm1jKntE93FOZbdc5Od?=
 =?us-ascii?Q?yF/miHj/NqDwnAShlrUJpKsUltzj+o5wfy6wG3KgvDr6fzXYOlDb3UQM9EBU?=
 =?us-ascii?Q?bKO5CS+JEvZbJq4oYeAEEXlfsozQ9OAcDl5AXdf4UeA5eGuyxUsDhrs9LjXW?=
 =?us-ascii?Q?P7ZssBEwukl66+M8h+mcDdVJOKUbq/Xlnr1yABj9ec3jQOwrV46oAPWu5G+g?=
 =?us-ascii?Q?EK/PH+LmUX1zPdVqT1INJAcC6e1l3sDrranhheyRCBBnAXYVFJRq2USI48cL?=
 =?us-ascii?Q?I0hDauO09xlYsTi3axR1XTgDGqtOPtiLq5rKKB9oqej1rKUx037VRlQdjFef?=
 =?us-ascii?Q?uXixogQVWSo4BG/dGxnPE1fna6ZMXGMdD/7i1QDGlbJ0dqSALWEMxahcXo+A?=
 =?us-ascii?Q?6CKtf5+QTaZK81uQrfKIXzbRUztKj/jXzrcCFA5rqx6C8neIITw0ePLIffho?=
 =?us-ascii?Q?WX5ucrL9QJYl/yhWgCNR/8fO9dpCjOpDBazEZdvZgZN86X69u8ZGpgit3lG2?=
 =?us-ascii?Q?c1RH005MHEG/1zf21z8/NHPPv3lCDrB1wEtI96cKlfIQwsEw/iFdi4stiUPM?=
 =?us-ascii?Q?leCLbBwhpT9TIyU8xDYpUqLy5nrSjBXlofsPpRLXF7SSN2qUUj2azJa2U7Ym?=
 =?us-ascii?Q?z6nsuPOkequG8fqcquWU5345nJpW1Ely/F9RzskwB2MrCFOYybykOzS+bAcD?=
 =?us-ascii?Q?9XFBy4BJ/XLGcy+8/Rgl9ynRcu6EjNSwz1tp06yJExCLbQAB1PhZOMEUqep/?=
 =?us-ascii?Q?kbPuKP34rgg9QktNYNZom/sh/V8/KLyZcCNDVR2O1Bh4ct0LD4WAxMNV/aeG?=
 =?us-ascii?Q?bCg43edXtKmuNsoeI2WDsKEoj1VUIAXbsCHJSjVRLK10QzX1jn2biHLBMvHv?=
 =?us-ascii?Q?T4wIlo6qmpXZbKoEy43csPD5hj2NxPxUp2Axx4SM4tC2GRdb7s2LyJthJpbS?=
 =?us-ascii?Q?F8d4T9pJWCeN/8NzUm5BjsaQWdfM9prqQLaC76Y++zUrUdKIWQbXwEgfP7WZ?=
 =?us-ascii?Q?TiCz9WD9brfOGu2ap153g29zTVeSCBYN4Fs6/1tuUCZp8iwB2CJ3iTmnn3z8?=
 =?us-ascii?Q?m3Qne6CNPzWhwRLM64wUOBfTU2PSe0HvOohbmNuYPVorKFGLoaU7Cxc7+4mr?=
 =?us-ascii?Q?3XTTYkE2HeaJaSzHSwoi3OGgQnjFi0Wj2usDdWKJIketCwAm+1lf8tRIVPMN?=
 =?us-ascii?Q?bEZpFq8s2oWI7HJpoz4WssI+EKN0Xj1UwxwG38Qj3PZILxfE5e1Nb80d+BQK?=
 =?us-ascii?Q?BNt8IY7nPn77zGX5cwR6PJwAWMcnJKCz+HnG9HwspjHN0oThAMBpmyESr1NP?=
 =?us-ascii?Q?fB82n2mS25vJ37YKsKZ7qRi1WklrboO5GLyfPWC+a0utiL0UEXlA83VanOJH?=
 =?us-ascii?Q?x0I5mjNQxzBaSK3Kj4xRWLXBZzOYiOoItBUPt3UN3qBq7wZT17uyBN+Dx+u6?=
 =?us-ascii?Q?sn1VYjxvQdV9IgaupCLqTdodaJwXY8+smzcSk52NdT1C9nKI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a7840e-7ec2-4411-3793-08de79447b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 16:46:56.7147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fUUOl8YzbdGXHysYMCdmA0kd6jxgsvluE7xGUaHH94d7snfRulGFN+XBLAK/WrjOflo21K4NexPQYjkAoYdxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8513
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: F2B7E1F4251
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263329-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: 20 January 2026 19:15
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 5/6] ixgbe: move EEE config=
 validation out of ixgbe_set_eee()
>
> To make this part of the code mode reusable move all EEE input checks out=
 of ixgbe_set_eee().
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: add comment on returning EALREADY
> ---
> .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 98 +++++++++++--------
> 1 file changed, 57 insertions(+), 41 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

