Return-Path: <netdev+bounces-212131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF7BB1E284
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E208A0008E
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BFC214228;
	Fri,  8 Aug 2025 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deWGJihT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE871A2381
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754635949; cv=fail; b=TO4diB/rVsP1/GLBv7vftXRRlMvBnod5IA+zXiV9IeW3dUeKvHmouUzkzBmArHyUA6pDQZZ38wKtjX1IUBlvmCtSvl6dSh0MC3SR+YrVpqZ9Yo/xKB3n+ZR0PjcnOeGbc9v91eOrAaTnPoxaf3WSzUOTRtLgnt3txTzTvfra2ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754635949; c=relaxed/simple;
	bh=D+wBmfVPcCBhGWZ+PBuy6kLdCuOCVFXW9jQIlZWwrAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kh5j+lDKL+r//0jN6kWqgFjzONWXGvqBABoA4Kwk62nAa3N1pPIGDpF8hTcPEgiMLriou81DNttmtHBYBGJ2O2wQ6rlmmqFmilUbcW79iNkCrwTYRLB1p/aUxjKaKO3DUVVpoLZvflJIaaqrCOkxCMw3FCsSfkHdfi2h3uqgCGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deWGJihT; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754635948; x=1786171948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D+wBmfVPcCBhGWZ+PBuy6kLdCuOCVFXW9jQIlZWwrAI=;
  b=deWGJihTRqNymVcQ/fC301H/5ahh5VcVwuaKRag3dGAmtPh2dzRwWz4A
   Ix8fCIn9qVuMdUt38fNvolgdLGAziQzgO7EXyaMA18F917OWnIvBYgUu2
   uZhwkFZoh0P9GCK9/+bikgTkbDu7JRdKaBRPWCU9DtSn08nbJD8bGbDfl
   MlPveIJqRiEuIm5GRF8AXLIcWIMAppemanrqJnKJlrpLxRrB5QlSH0L68
   FDxQ+HT+1IsBCGUL/jMa6zpTZLKVTVgGceXleBf8Pv/1+Jfw12XuVq2ye
   aDkwKUnw19NUjYzhueEg93LlEZQDVjM+q+YfXFlV1NTe6Kz2iwvzV+s6H
   g==;
X-CSE-ConnectionGUID: M16U6bMuTtSxnQB3rr5fyA==
X-CSE-MsgGUID: CPjG4pE3SSmt1x2UYnSerw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="68350416"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="68350416"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:52:27 -0700
X-CSE-ConnectionGUID: le2SP3XyR8afRIOP2W3iuw==
X-CSE-MsgGUID: 8WS+oRfCTZytQj/VwEPUWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="196243859"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:52:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:52:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 23:52:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.86)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:52:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7UDK9CUDym1bBBkHfqsV/79KgDjZoer7ot2s5FfjWcdzk9HYD9p4I4zcIpZm6LOMEAm/2pszxztH0GA0Ua6u0Afq3qsnVR4CPqAXFoMNwVM0hr1M2WUo9CV/EGaPCV/VJINb8HW4F3NJMVaINhhP+41rVqcLTzgZ9++A6TQkAGcdlOJFASeVesjDZ8JPah1ADLhjH1R4PGF+LDq8t2GTsoOW7u7ulIzC9x+ly3bzeQTjlPJDxlviO/l/SoUPkz7UDr2q6bXMCqRZhp8Wu8cVaK47wrhSOam32rblHBS5CExCUXEOamL3AjChl6gZh85t11mLKBpSFdC7ZYVbUZpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+wBmfVPcCBhGWZ+PBuy6kLdCuOCVFXW9jQIlZWwrAI=;
 b=xGl5XZXrGr8M2ktL12ARrUeRf8nL884McI1F+qjQTLSQ1XzlLZ7LajHd1ahpHtl86JAZ7AF2IohyZSYeL6RlDghC08G7r48jR2WsHQasdjBVVsYe8bDR4zW7GbH7lrCrfreMel7N6Z+b/JKFIho0DlmlMyY5xIDybMyYpTKeyrdPs9JbuqEBWnLc6JN3VuKlLAIIGd8ehoFK3MCgsjQFS5ywWmh6muoC3XiGz/iC7UlcWm0XyuI8RAEeZtC15zdSmsuM3yUc3SuzHfpq3qQsOpdyBPVF63DjLA1uABzfO8XPeZEwKUehQKTmdBTmgdmesC1wqTHKZPC4uSGtag+ESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SA1PR11MB6869.namprd11.prod.outlook.com (2603:10b6:806:29c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 8 Aug
 2025 06:52:23 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 06:52:23 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Kunwu Chan <chentao@kylinos.cn>, Wang Haoran
	<haoranwangsec@gmail.com>, Amir Mohammad Jahangirzad
	<a.jahangirzad@gmail.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH] i40e: remove read access to debugfs
 files
Thread-Topic: [Intel-wired-lan] [PATCH] i40e: remove read access to debugfs
 files
Thread-Index: AQHb+2brPjmJbxS2mEikwoDdSHCBaLRYZCyw
Date: Fri, 8 Aug 2025 06:52:23 +0000
Message-ID: <IA1PR11MB62413FF99537CABA9383AEBF8B2FA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250722-jk-drop-debugfs-read-access-v1-1-27f13f08d406@intel.com>
In-Reply-To: <20250722-jk-drop-debugfs-read-access-v1-1-27f13f08d406@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SA1PR11MB6869:EE_
x-ms-office365-filtering-correlation-id: 43f697bb-462b-427d-e224-08ddd6482100
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VjlTd2orQ0w4bmhJL1FaV3Iwbnk4UGVhRytSK1dsNkFPNmlLZG52aFVabThI?=
 =?utf-8?B?N1NjSmhZTTQ0aFNIckNCQkRkOC9KaGVtZ2hLVkZVekJ3YitPZW5qRGRuOHQw?=
 =?utf-8?B?eTAyUHJROStlY2JjZDJZTGtqdkZhNldndVpQS3pkNTlTUjQ5L0xXVnBDcVFq?=
 =?utf-8?B?UlN4OGlvYkJxRnU2c2JOQkpTckt1K3IvSjlqcnhnaHl1VHZDUnh1L1V3bmJX?=
 =?utf-8?B?eU9qWkJCMEtDZlorRkozY3NXMTJleTBoTUpnM2VIV09rQ3lUVkw3a29BZ3J0?=
 =?utf-8?B?T29BaG5BRVRGMEhIQjd3aW15c2F0ZXU1RjVaMURMQ2xidTVxRHJrYkxhcm5O?=
 =?utf-8?B?ancrTXV1RnRvZ1F1a0xCSzRLR1FUYlhoSFIzVXI3ZE9ha3FQVHgxRVE4Unkz?=
 =?utf-8?B?SjZLZ3lvOU41L0xLeTJHcjNPQ2pEZEZUS2VhU093ZkgrdEdOMEVXdERETW5a?=
 =?utf-8?B?dnZxWlVhMEFIUEtSdkRzYVZsSDNRWmR3em5aQ1dLWmpHaFQ2a2M1Q28vMVBs?=
 =?utf-8?B?WUtqbEF3eU54OXdPY2UwWFRBcm5Wb0N3MmtCQUNEZDZtZjMrS3dJczlpek1O?=
 =?utf-8?B?RDBOd0pVZG8zSkNSblVsUEFJRHE3OHo1Y2JheUcvb3pKeGdkclhCUHRyQ3pV?=
 =?utf-8?B?ME83dlRlc21LdkRxbnVvUHlNYWZTMnpkc2lTN1lhUWRleWpzM0NPaTRLdjF2?=
 =?utf-8?B?SkJtS0Q3QlV6Mi9qOERDQ3htWGNYMkY5NDlxbXB6cVJiQmNscUdxVEtWQXhR?=
 =?utf-8?B?cEdDLytLQThvRDBydGZTaGNmY2NMakVXMUR1TEZCRE94MS9LblpPaHlONmpK?=
 =?utf-8?B?VkJVSzd5ZDJsQThoL0tMSDZ6aHdCOXVTVDM4NWNHVTFxdjlVV2NkcHM3aTNP?=
 =?utf-8?B?V2tIQ1NaQ01KRkpxY1lrTVBLM3Q2RXJjS0UxeW1wMS9hemRUL1o0NnQ4bmF6?=
 =?utf-8?B?VnQ2cjhGMUg1MktmQmFDUWsrQzFnQ3FPaTdJNHhwRWZwcnJTdnF0Y29mL1lz?=
 =?utf-8?B?UzU4eW1xellSaHppS3hpVFhxVEo4NnpVK1pOUnFSeHE4YWRSMjJ1VUZmYkZV?=
 =?utf-8?B?dXNvTVpsWTdmREl2bWRNKzVaYUhLY242b3RRQXpFdjA2SVhFSFk4cWM3NDNS?=
 =?utf-8?B?OFR2Tm9kZVNFSmdyRGhyQVlLNWMrMDhtSDJJbE02UmRGT2cvVVdtL3FvaEhO?=
 =?utf-8?B?TkhuZklmWTRkc1J6QjlFNWNTVytyNjltM29vM2FBMzQ3RmsvVFpFd1FuTnhD?=
 =?utf-8?B?dEhUNzhhT2t1ZVNFNTRlcXNtNlI1VXA3VDRHY1NhZW14c1pkZ3d3ZWFDd0RO?=
 =?utf-8?B?WHlHV1JxQjZEaDF5czR0NzgyYzZOelNoanZwb0FnSWNEaWp4djUydk9PTjE2?=
 =?utf-8?B?U2Rtd1E2NGc0TmJMQk0xLzNBbU5aU3hRMUFGbGIwRUVQNVNnQTlUR0xyakFC?=
 =?utf-8?B?RW8vTTZDV2E3aUMzeUR2ZzFRU3dGcVh2dTJPeXFNNWdtTEs5MTR3NWhhMkZQ?=
 =?utf-8?B?TzlyOHBVSlpXeEloQzFXbStLc1lNNjVmM2ttRlBhN3U5Q0pKS0VmOVNmTVIv?=
 =?utf-8?B?WSttcTNsNldCZ2ZEdENHdTlyTDIwNkpqNG1wZUV5bkNJK2tNenBoKzR5MHJM?=
 =?utf-8?B?MUdmams0dW9US0lwRWdFTi9iRnhDRWJ2RHNqaTlUYmZzczE0ZExLaDFnNm1H?=
 =?utf-8?B?cDJVaUllN1IzRk9GaUNqYnYzRTlwOG5PcnU1QUZmSjZuMFpPWE8yMjFmTzk2?=
 =?utf-8?B?NWF0RDhncG5WUjNlMEhzSUd0d0NYMmkvWm44d0FicFp2NnZwczhUY3FyU0J0?=
 =?utf-8?B?cWdQK0g5cFpVT0JJUmF0VVBhZzZzNEdGazRPK0hoNDQ5MHVoOUQ5NGVmZ0oz?=
 =?utf-8?B?MHpoOUhrRFNSK0lqeXpCQTRqUE5SQVQ1K3RCSS9pRnBndVhzU1lpdVh4aWIw?=
 =?utf-8?B?UnNRVmdYbnJ6VG1YM1VOaGdpdGszdXVIWE1ZQWNQeWllbnl4V3NTcElOMnNF?=
 =?utf-8?Q?2V7ShE6seT2L3pMB8505XE7sZ4eSKk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3V6MEJJUE80ejBJOS9KZ2JHKzJzUUVjVHcxb0lRYmp3aUZVbmhoODZvS3dI?=
 =?utf-8?B?Yk8rSFlNODhzMDFjeWVmeSttVURjY0lLMXRaNG4yVVhUSWR5c2pxVkFFZVlk?=
 =?utf-8?B?eEl0QmZEdnlVSmlUVTN6U2ZXeGhtTDVNZUJlWStFSGd1N080TVRWUWJrOVJx?=
 =?utf-8?B?Q3hIUlBDS0tnRW1DWEVzSjE3YlVqWXBsNzRCR1laRmFzRnNjdkp4dGVteng0?=
 =?utf-8?B?ek1tTHB0NmNxR3V4aTR6VHpDRExYUDc1Y1ZuWHJRWjlQTEdaTFRRZ1kxeExm?=
 =?utf-8?B?RzVoTHU3aXZLUGxhWEdIZldvUTIvSVJJZ2FhUHdsRjUzTEhtazRVL045T2lT?=
 =?utf-8?B?Z2J0ZGh1NkE4UE1kWjJFeXhVaWt3ZldXc2NHVEgrSWllc3p3b3lFVDRwOGIy?=
 =?utf-8?B?MmxSV29ROEVDVzc5NkthWnlOQ3kvLzUwbHFEN2lOME5MbGhkd0xUTElRcUZm?=
 =?utf-8?B?MFFKYlZ6eEFESjJmZUxxejBaT1Y0ZDVDRDBZM2N0NVBjVWxCNnYyQmIwbWV1?=
 =?utf-8?B?SG05cmhLMFg3N25hMVNXSnlDN2lXQUdyNVN4cEd1K1hZc0dEVzM5aXZJbGoy?=
 =?utf-8?B?dGYxdzRDK0xlQi91aURDbUhoNmJqekdJWVloelVoUkNsaHJhZkMrU2VDMDRu?=
 =?utf-8?B?Z2Zub1BvYm1qU3B4QXI5MG9xa2Q5UmYxVzRPbFBkWElxU2JtQ3RSQlIxVE5D?=
 =?utf-8?B?Vi9aWVRZb2lxQ3hSTXYwY0NqOWRLUlNWazBWbnU0T0V5QnlKWUErWWs1R2Yx?=
 =?utf-8?B?djNiWHhVTTdkM0VvN1NCTzJRN2d0NUJNdllSSDdXWU5PTkdSSGVMN0EyWFZp?=
 =?utf-8?B?SUkxeGJ2bmlSdWQ5YkxFcERKNE1udTNVL3N1NXUveERNbVhtZHBvL1dudHFZ?=
 =?utf-8?B?SWYvemxLdWpKMlBjMFNqNUs0SGd5aU9NdmNyNkgwOFdRalhzZWtyQkJldDV1?=
 =?utf-8?B?cUhGcE4wbmVZYnNVemZwS2diMVo1WnFWRmpCZkxFWlIweHpTcDJTWHE5TWtq?=
 =?utf-8?B?eERQZXFaZ3h0Z1cwaCtmeExPTkFhZ1VNbldKTnptV2lRbXRqcmRicldvbjRQ?=
 =?utf-8?B?L1VXY2w3emtmMnAwQTVpTzhqejYxNk5wc0xYTithYjd4TG92OHRXNmNJeStw?=
 =?utf-8?B?bXdqb3pYNzM3M1MybXdqdXU4M2g5QWRheno3Sjh0VDU1RWljOWlYSk9zOFdG?=
 =?utf-8?B?Um9Wa0phMi82REd5N2RTODh2Rlh5MVpaTlcxWVVLMlFjTmViVzZydzZPZjVB?=
 =?utf-8?B?Nm5hTW1GeFNZaHlsZHBENTU3NklneUhZdkppZ1daV3VBQjNkWmJLREtCcDU5?=
 =?utf-8?B?bGNzUG1SUnlPZk9wNW5Mb3RiUnZUUm1sQlE4a1h0VkF0WXk3NG1JMUtweFBO?=
 =?utf-8?B?ZDJOb2ExWUs4MkhjTy9JQUJ3dVBwZTA2QkZPbXhoMzRyRXJIS2lmVGVmYmpl?=
 =?utf-8?B?dVIwekI1NmV2MG5HbjNzeDFvaEVHV0p2MUhJeXFncXF0SlRoZnZvVitFRlov?=
 =?utf-8?B?YlA2Wkhxc2htaUtXbU00Y2NxQ05iR3JINlFtNG1hNklML1Ztdy9FQkNhR3Rw?=
 =?utf-8?B?MUNmUEhmeVNnMEFIYk9NOFJ6OC9yWTVUcHNBb2VHcVZnSWUrcTZ3Y043a2R1?=
 =?utf-8?B?UmNIeFBYM1E5VFBESHNKeFFxOEswdldaWXNEeWxuK2Q0M0loZHZtNmlMS0tV?=
 =?utf-8?B?ZHgvN0RPVFBPZXFyZzI4bUNNWmxkaGtkVER4S3ZZNDZ5Q3VEck81cUZBemNv?=
 =?utf-8?B?S2NCcHdTZFd5NExkeVJtck43VVVPcHd3V2toMjJUTkJDYS9MY3JyL21HZ2I4?=
 =?utf-8?B?d1h0eDBqVHhYeDI2QWNOTTg2YUJMUEVuSDF5NnU4UC9QK2lnUE0vR2VnUFI4?=
 =?utf-8?B?ZHlUOVo4bWFmUDMxbkJtTzBPdHN2bGpQcU45dWlOaU5WTTdSSFljUm10WlpR?=
 =?utf-8?B?WGdSSHQ5czFOdTBYKzlQRkVtYlpzc0U1Q3U3eTc2YUdGNTA1cEppZzdtdmFL?=
 =?utf-8?B?YzZPVVdId2cwOUVCUkNObVphRDZCY3dYQlR6NmFtWmpiWnNDNThlWXBRRGJh?=
 =?utf-8?B?M2NzYU1udldRUkVuQW1vNk9SZUNZeVJuMjZUTnBKM3gzUjdrZGVZS0J5elNu?=
 =?utf-8?Q?I30Wc5EuW0fUXgi1EvlwG4YQp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f697bb-462b-427d-e224-08ddd6482100
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 06:52:23.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMZWICz+NFkcyHemSi4SyDoLjXFXl336IwZMUTW2atlzKw7cLp9ep84EpyHQJkPXFZXU03noL5B2OBOlzhAftQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6869
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMjMgSnVseSAyMDI1IDA1OjQ1DQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4gPGlu
dGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0K
PiBDYzogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPjsgTmd1eWVuLCBBbnRob255IEwg
PGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS3Vud3UgQ2hhbiA8Y2hlbnRhb0BreWxpbm9z
LmNuPjsgV2FuZyBIYW9yYW4gPGhhb3JhbndhbmdzZWNAZ21haWwuY29tPjsgQW1pciBNb2hhbW1h
ZCBKYWhhbmdpcnphZCA8YS5qYWhhbmdpcnphZEBnbWFpbC5jb20+OyBLZWxsZXIsIEphY29iIEUg
PGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0g
W1BBVENIXSBpNDBlOiByZW1vdmUgcmVhZCBhY2Nlc3MgdG8gZGVidWdmcyBmaWxlcw0KPg0KPiBU
aGUgJ2NvbW1hbmQnIGFuZCAnbmV0ZGV2X29wcycgZGVidWdmcyBmaWxlcyBhcmUgYSBsZWdhY3kg
ZGVidWdnaW5nIGludGVyZmFjZSBzdXBwb3J0ZWQgYnkgdGhlIGk0MGUgZHJpdmVyIHNpbmNlIGl0
cyBlYXJseSBkYXlzIGJ5IGNvbW1pdCAwMmU5YzI5MDgxNGMgKCJpNDBlOiBkZWJ1Z2ZzIGludGVy
ZmFjZSIpLg0KPg0KPiBCb3RoIG9mIHRoZXNlIGRlYnVnZnMgZmlsZXMgcHJvdmlkZSBhIHJlYWQg
aGFuZGxlciB3aGljaCBpcyBtb3N0bHkgdXNlbGVzcywgYW5kIHdoaWNoIGlzIGltcGxlbWVudGVk
IHdpdGggcXVlc3Rpb25hYmxlIGxvZ2ljLiBUaGV5IGJvdGggdXNlIGEgc3RhdGljDQoyNTYgYnl0
ZSBidWZmZXIgd2hpY2ggaXMgaW5pdGlhbGl6ZWQgdG8gdGhlIGVtcHR5IHN0cmluZy4gSW4gdGhl
IGNhc2Ugb2YgdGhlICdjb21tYW5kJyBmaWxlIHRoaXMgYnVmZmVyIGlzIGxpdGVyYWxseSBuZXZl
ciB1c2VkIGFuZCBzaW1wbHkgd2FzdGVzIHNwYWNlLiBJbiB0aGUgY2FzZSBvZiB0aGUgJ25ldGRl
dl9vcHMnIGZpbGUsIHRoZSBsYXN0IGNvbW1hbmQgd3JpdHRlbiBpcyBzYXZlZCBoZXJlLg0KPg0K
PiBPbiByZWFkLCB0aGUgZmlsZXMgY29udGVudHMgYXJlIHByZXNlbnRlZCBhcyB0aGUgbmFtZSBv
ZiB0aGUgZGV2aWNlIGZvbGxvd2VkIGJ5IGEgY29sb24gYW5kIHRoZW4gdGhlIGNvbnRlbnRzIG9m
IHRoZWlyIHJlc3BlY3RpdmUgc3RhdGljIGJ1ZmZlci4gRm9yICdjb21tYW5kJyB0aGlzIHdpbGwg
YWx3YXlzIGJlICI8ZGV2aWNlPjogIi4gRm9yICduZXRkZXZfb3BzJywgdGhpcyB3aWxsIGJlICI8
ZGV2aWNlPjogPGxhc3QgY29tbWFuZCB3cml0dGVuPiIuIEJ1dCBub3RlIHRoZSBidWZmZXIgaXMg
c2hhcmVkIGJldHdlZW4gYWxsIGRldmljZXMgb3BlcmF0ZWQgYnkgdGhpcyBtb2R1bGUuIEF0IGJl
c3QsIGl0IGlzIG1vc3RseSBtZWFuaW5nbGVzcyBpbmZvcm1hdGlvbiwgYW5kIGF0IHdvcnNlIGl0
IGNvdWxkIGJlIGFjY2Vzc2VkIHNpbXVsdGFuZW91c2x5IGFzIHRoZXJlIGRvZXNuJ3QgYXBwZWFy
IHRvIGJlIGFueSBsb2NraW5nIG1lY2hhbmlzbS4NCj4NCj4gV2UgaGF2ZSBhbHNvIHJlY2VudGx5
IHJlY2VpdmVkIG11bHRpcGxlIHJlcG9ydHMgZm9yIGJvdGggcmVhZCBmdW5jdGlvbnMgYWJvdXQg
dGhlaXIgdXNlIG9mIHNucHJpbnRmIGFuZCBwb3RlbnRpYWwgb3ZlcmZsb3cgdGhhdCBjb3VsZCBy
ZXN1bHQgaW4gcmVhZGluZyBhcmJpdHJhcnkga2VybmVsIG1lbW9yeS4gRm9yIHRoZSAnY29tbWFu
ZCcgZmlsZSwgdGhpcyBpcyBkZWZpbml0ZWx5IGltcG9zc2libGUsIHNpbmNlIHRoZSBzdGF0aWMg
YnVmZmVyIGlzIGFsd2F5cyB6ZXJvIGFuZCBuZXZlciB3cml0dGVuIHRvLg0KPiBGb3IgdGhlICdu
ZXRkZXZfb3BzJyBmaWxlLCBpdCBkb2VzIGFwcGVhciB0byBiZSBwb3NzaWJsZSwgaWYgdGhlIHVz
ZXIgY2FyZWZ1bGx5IGNyYWZ0cyB0aGUgY29tbWFuZCBpbnB1dCwgaXQgd2lsbCBiZSBjb3BpZWQg
aW50byB0aGUgYnVmZmVyLCB3aGljaCBjb3VsZCBiZSBsYXJnZSBlbm91Z2ggdG8gY2F1c2Ugc25w
cmludGYgdG8gdHJ1bmNhdGUsIHdoaWNoIHRoZW4gY2F1c2VzIHRoZSBjb3B5X3RvX3VzZXIgdG8g
cmVhZCBiZXlvbmQgdGhlIGxlbmd0aCBvZiB0aGUgYnVmZmVyIGFsbG9jYXRlZCBieSBremFsbG9j
Lg0KPg0KPiBBIG1pbmltYWwgZml4IHdvdWxkIGJlIHRvIHJlcGxhY2Ugc25wcmludGYoKSB3aXRo
IHNjbnByaW50ZigpIHdoaWNoIHdvdWxkIGNhcCB0aGUgcmV0dXJuIHRvIHRoZSBudW1iZXIgb2Yg
Ynl0ZXMgd3JpdHRlbiwgcHJldmVudGluZyBhbiBvdmVyZmxvdy4gQSBtb3JlIGludm9sdmVkIGZp
eCB3b3VsZCBiZSB0byBkcm9wIHRoZSBtb3N0bHkgdXNlbGVzcyBzdGF0aWMgYnVmZmVycywgc2F2
aW5nIDUxMiBieXRlcyBhbmQgbW9kaWZ5aW5nIHRoZSByZWFkIGZ1bmN0aW9ucyB0byBzdG9wIG5l
ZWRpbmcgdGhvc2UgYXMgaW5wdXQuDQo+DQo+IEluc3RlYWQsIGxldHMganVzdCBjb21wbGV0ZWx5
IGRyb3AgdGhlIHJlYWQgYWNjZXNzIHRvIHRoZXNlIGZpbGVzLiBUaGVzZSBhcmUgZGVidWcgaW50
ZXJmYWNlcyBleHBvc2VkIGFzIHBhcnQgb2YgZGVidWdmcywgYW5kIEkgZG9uJ3QgYmVsaWV2ZSB0
aGF0IGRyb3BwaW5nIHJlYWQgYWNjZXNzIHdpbGwgYnJlYWsgYW55IHNjcmlwdCwgYXMgdGhlIHBy
b3ZpZGVkIG91dHB1dCBpcyBwcmV0dHkgdXNlbGVzcy4gWW91IGNhbiBmaW5kIHRoZSBuZXRkZXYg
bmFtZSB0aHJvdWdoIG90aGVyIG1vcmUgc3RhbmRhcmQgaW50ZXJmYWNlcywgYW5kIHRoZSAnbmV0
ZGV2X29wcycgaW50ZXJmYWNlIGNhbiBlYXNpbHkgcmVzdWx0IGluIGdhcmJhZ2UgaWYgeW91IGlz
c3VlIHNpbXVsdGFuZW91cyB3cml0ZXMgdG8gbXVsdGlwbGUgZGV2aWNlcyBhdCBvbmNlLg0KPg0K
PiBJbiBvcmRlciB0byBwcm9wZXJseSByZW1vdmUgdGhlIGk0MGVfZGJnX25ldGRldl9vcHNfYnVm
LCB3ZSBuZWVkIHRvIHJlZmFjdG9yIGl0cyB3cml0ZSBmdW5jdGlvbiB0byBhdm9pZCB1c2luZyB0
aGUgc3RhdGljIGJ1ZmZlci4gSW5zdGVhZCwgdXNlIHRoZSBzYW1lIGxvZ2ljIGFzIHRoZSBpNDBl
X2RiZ19jb21tYW5kX3dyaXRlLCB3aXRoIGFuIGFsbG9jYXRlZCBidWZmZXIuDQo+IFVwZGF0ZSB0
aGUgY29kZSB0byB1c2UgdGhpcyBpbnN0ZWFkIG9mIHRoZSBzdGF0aWMgYnVmZmVyLCBhbmQgZW5z
dXJlIHdlIGZyZWUgdGhlIGJ1ZmZlciBvbiBleGl0LiBUaGlzIGZpeGVzIHNpbXVsdGFuZW91cyB3
cml0ZXMgdG8gJ25ldGRldl9vcHMnIG9uIG11bHRpcGxlIGRldmljZXMsIGFuZCBhbGxvd3MgdXMg
dG8gcmVtb3ZlIHRoZSBub3cgdW51c2VkIHN0YXRpYyBidWZmZXIgYWxvbmcgd2l0aCByZW1vdmlu
ZyB0aGUgcmVhZCBhY2Nlc3MuDQo+DQo+IFJlcG9ydGVkLWJ5OiBLdW53dSBDaGFuIDxjaGVudGFv
QGt5bGlub3MuY24+DQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvaW50ZWwtd2ly
ZWQtbGFuLzIwMjMxMjA4MDMxOTUwLjQ3NDEwLTEtY2hlbnRhb0BreWxpbm9zLmNuLw0KPiBSZXBv
cnRlZC1ieTogV2FuZyBIYW9yYW4gPGhhb3JhbndhbmdzZWNAZ21haWwuY29tPg0KPiBDbG9zZXM6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQU5aM0pRUlJpT2R0ZlFKb1A5UU09NkxTMUp0
bzhQR0JHdzZ5Ny1UTD1CY256SFFuMVFAbWFpbC5nbWFpbC5jb20vDQo+IFJlcG9ydGVkLWJ5OiBB
bWlyIE1vaGFtbWFkIEphaGFuZ2lyemFkIDxhLmphaGFuZ2lyemFkQGdtYWlsLmNvbT4NCj4gQ2xv
c2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA3MjIxMTUwMTcuMjA2OTY5LTEt
YS5qYWhhbmdpcnphZEBnbWFpbC5jb20vDQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8
amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4gSSBmb3VuZCBzZXZlcmFsIHJlcG9y
dHMgb2YgdGhlIGlzc3VlcyB3aXRoIHRoZXNlIHJlYWQgZnVuY3Rpb25zIGdvaW5nIGF0IGxlYXN0
IGFzIGZhciBiYWNrICBhcyAyMDIzLCB3aXRoIHN1Z2dlc3Rpb25zIHRvIHJlbW92ZSB0aGUgcmVh
ZCBhY2Nlc3MgZXZlbiBiYWNrIHRoZW4uIE5vbmUgb2YgdGhlIGZpeGVzIGdvdCBhY2NlcHRlZCBv
ciBhcHBsaWVkLCBidXQgbmVpdGhlciBkaWQgSW50ZWwgZm9sbG93IHVwIHdpdGggcmVtb3Zpbmcg
dGhlIGludGVyZmFjZXMuIEl0cyB0aW1lIHRvIGp1c3QgZHJvcCB0aGUgcmVhZCBhY2Nlc3MgYWx0
b2dldGhlci4NCj4gLS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9k
ZWJ1Z2ZzLmMgfCAxMjMgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAxIGZpbGUgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTA0IGRlbGV0aW9ucygtKQ0KPg0KDQpUZXN0ZWQtYnk6IFJp
bml0aGEgUyA8c3gucmluaXRoYUBpbnRlbC5jb20+IChBIENvbnRpbmdlbnQgd29ya2VyIGF0IElu
dGVsKQ0K

