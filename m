Return-Path: <netdev+bounces-254704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEycNwQ4e2mGCQIAu9opvQ
	(envelope-from <netdev+bounces-254704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:35:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 626D4AED67
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7EFA309AB02
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D123806C9;
	Thu, 29 Jan 2026 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVi+XtzG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A4329E52;
	Thu, 29 Jan 2026 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682635; cv=fail; b=XCad9MrhrWJjJoCRwahEM1z70+mhNaN4kQzKXHjzahhyKwsWDsNLBPN1JePHdEM2afaobqK39RwSGJioJ17YI6OwT0bMAx/f1YJ/TgT8gTndn6TydYjQCliRB9qRKTOe/pRNpUkephq8JehGoN+tm4AWk4QgnKJzBGewKt4Dm6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682635; c=relaxed/simple;
	bh=R0BsXXFqdsDTQCdbpFxm9DV1ItJySEH/oMwKnsIBrSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e+n+u7FOt9+KE6G8AJ7ILAX0XUs/0Y1Hnb0Cy9U9KBLRVmFP7U/ZLMub8V0p/5i5kwbJf6mwCjKYjZDMHwBp9Fu7NkkOCsHdT5PwUgxShV2tpZmDsmuWEFcd6n6vcj7jqv1sK2sWCuyxGX9f68G7IOjTqH0op2pagvIVCt2OrYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVi+XtzG; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769682634; x=1801218634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R0BsXXFqdsDTQCdbpFxm9DV1ItJySEH/oMwKnsIBrSY=;
  b=SVi+XtzG8y1LKTpKJ6OkqNuZGtB+vimY3DEk+FiRKRYnKTPo9gEUacp/
   UCbYrgWEvZqS3akJxh0lN7t/i9D/xfSxAJagzCEuDX4O0iSmVMtRH8ymg
   K3LtODvYsjF3fv3y97fHT8QGsqe10lsbNSp3wn159O4m7ZA3bumiV4TDe
   ioXe6z5mhunW49NgJBsI3ISYHHWrtrpsCnWA2ReCodglI/r4dJaJw95FL
   zfZc39Mp+iziLipfS4GWWvig/W0gnK7K0bPv8BbzysRodXxR1wpKOWgx9
   2+aBBsRt3Ez5Hcefw+Tn0W5eksr5za7WXk7rEsBakeWlxCPLvuZm3l/k0
   w==;
X-CSE-ConnectionGUID: Lgr66CeiS3uyiziOdnWa0w==
X-CSE-MsgGUID: i3XpGMQuSz+Vx7hxiTzwtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="93578803"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="93578803"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:30:32 -0800
X-CSE-ConnectionGUID: OjJuk+eNQ3ajTRTUQtr36w==
X-CSE-MsgGUID: 19+m1wlXTsCbq8MIbIhzTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="207657241"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:30:32 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 02:30:30 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 02:30:30 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 02:30:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lICZiusJNgLk5usT4VtanW6qJItbSy99fECiYAqBFkaKM332GQv9BQ0hJUwf5OEQS+3mEYb22bBtNeDKlv0WC+eCUdlnG4rptisXxxI1wdh7ig25DNSW5NRn/vi8P5wXwPojtNvBYV2Aou+HHmWyRvkqYGDrp6NylOLB7AbSBC+TL8k04L+GiekVW8mf4aJjodO22ZbTVAnXHov5VmjMg9mptJKUDSOBzTXPAoVUmALtmVVxt1p7EuGN2+1ssZbhhfewj4a6Aneo9PWRYUocIWHqF5B48dTKT6TXgjH1WC0xGZSgYneL2HGRgavqFreywuwS92zvOwoC/irK+zUhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0BsXXFqdsDTQCdbpFxm9DV1ItJySEH/oMwKnsIBrSY=;
 b=M16WbXYxLXpYJs3us5UQS40z2giwrzzMwoqxarPWLmkmdu+6GNqY++93bby5ZK+fl+3WFRvJlw8W8MfgQ5ozvY0DGjzzOJRNvQmSno1I0dS7VfT1Zc+Tr4ZxPbmGejUtHig5ZnxH+dDt3Q8+Q6bVSfm6DKyehwaKsJODHjmSJ8daLmIoV24LzX3kHkgWOQn5SEwgHLIFR2jH80ZgGdNE3jf730w+KXzz63BeIMzgfLn9BBICCxQnbiyBdfaRSEiOh408F9kxiSgxpH/xfSYQIgc1B9vnLx2Ch+IYRx00tn+ccBOu5O7WsceF9tebpLYguCY9E0cml3ku77DmwiNvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB4956.namprd11.prod.outlook.com (2603:10b6:806:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 10:30:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 10:30:29 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [Intel-wired-lan] [PATCH v3 13/30] docs: kdoc_parser: add support
 for LIST_HEAD
Thread-Topic: [Intel-wired-lan] [PATCH v3 13/30] docs: kdoc_parser: add
 support for LIST_HEAD
Thread-Index: AQHckPaGQv4yvrP94UWge+MIZW8oN7Vo8qBQ
Date: Thu, 29 Jan 2026 10:30:29 +0000
Message-ID: <IA3PR11MB8986B259533EDBC92DE2E430E59EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
 <4f024c9e51d9354ccbf24443c88e1eb0bb5087c4.1769673038.git.mchehab+huawei@kernel.org>
In-Reply-To: <4f024c9e51d9354ccbf24443c88e1eb0bb5087c4.1769673038.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB4956:EE_
x-ms-office365-filtering-correlation-id: aae31799-cd53-4405-e706-08de5f216c75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Zk1Fc1Y1TVdFenA5U0M3bjVjeFlKNGNxQXRDUk5zNE9IZDM5WVU2MmRYVUZp?=
 =?utf-8?B?WEdOV3JvZUdtVVFTeHJCcSszRXNKM2hsRUpQemVic0pNdmwvTzJDMGIwd0Vr?=
 =?utf-8?B?ZE1KazFTemM2QVBRbjlkdDBVck9QTjlDMFJneURqbU9acFl1elU4WXo5U2Qw?=
 =?utf-8?B?RnhlbVQ3ZG1ZamFwL1lQMEVLRjBobFUwaUxEbFU4VVZEMUYrelNrdWFFTklD?=
 =?utf-8?B?WnVUYWdQVkZPZ2dzYXJkZFBUZnBQUGFTdTdERGRmQjRraFRyQml1ajYrL3F0?=
 =?utf-8?B?Nk4yclcveE5WMm81WnMyeDdEL1NhWlpBWm9xSXQyUDdnM3U4VG40bllzWElw?=
 =?utf-8?B?VGdwQ2xpM0Y3Z3NwTTIwaktQKzBZOWJvWnk4SDBhU05XZEtoQXVWUDAxVEY0?=
 =?utf-8?B?bWtJY0RQL1ErSDhyNW9uRi9lbW84Nm85S3JLa0dRWTlKS293MUtBOXZEK3Fs?=
 =?utf-8?B?L3VISzFZZWRxMTJVQXk2dnpXS09WSUFSdkNmSndwQWQ4K3IyM3k4MUpVd2RS?=
 =?utf-8?B?L1hLQW1RaktuNXhxeG1Fdk4wT2p4ZmJsbTlGSXltVG9jejRySWJaOUJPK3A4?=
 =?utf-8?B?Nk5TYlhrMnBsMWlXemliNGdSUXkvOUU5d20yYUFaVW00SGJwdTVRZkp5bmx1?=
 =?utf-8?B?a0NlOVc3eFpoamJ0UTM0RXlKZ3pIZmxvcnNkSUxJZ2d0Z2cvVURtZ3o4Wmxa?=
 =?utf-8?B?ditZUkJvTElTUXJQZXZZdnpCQjc5YUZLb1NCZ3dWZVc4czNSNXdYMzBmclhM?=
 =?utf-8?B?VHBjbnpSaHpjTGM0VXpIRkZyZ1JmOW5YNHltNE40SFF0RVZKK3Z4WFczbVd2?=
 =?utf-8?B?cjUybmtKV1JEK2d0OER0dk5ESks1Sk5ac2pHRzBaaStLNHNVTnNiVnN2c0lS?=
 =?utf-8?B?VGVPUm1ud2pkeFdWZDhiQVlyZmdSQzJmSVJ5M0NvZHlIcmNHT0UyVjdBdGJQ?=
 =?utf-8?B?V05iZzFvOGlER3A3VTJQbXpkbi9YS05XanlpbkRDNko5Y1NJbHBvTHMyakFQ?=
 =?utf-8?B?MUs1VWdXWWJvZGJ1Z1dRQ2RTKzBuMUtpQWVXejczSEthclJub3lrQTgxemo4?=
 =?utf-8?B?Z2h1YUExTXdneGx5bXI5MXFZeE8zcUF4ajNwNjIzUWp6RTFFZzdpb0hWclRm?=
 =?utf-8?B?OC8vdCtZNUZ4NysrVFNQZVp4NUs1VTNDQzVBQkkzaHZiREc0bUhqb29UQk9C?=
 =?utf-8?B?SWhyODlZRHNaWSt0OGVrVEd3SUh6R1JWemN6WUFoamowMVRmM29iWkxlaXhq?=
 =?utf-8?B?ZjdZM0R1SnVDQ0NDTVBEWHdUWHJRVkZJVlZIVnNyWlJFSjZQVnVLaXVZNWJC?=
 =?utf-8?B?N01JVFZuS0lqK2hlL1FyQ2IydWJBTnFVUUY4VUpYZVFyNDFxc2RQOVhCZW9U?=
 =?utf-8?B?OTRueVp1bGNaVjBkMVMyL3NjSFQrdzAvMCtnSjl3ZTh0REpDK3pOQnAvV3RI?=
 =?utf-8?B?YkpDelE0L2VFcjlHdHFMcWZBU1NudWJzZjVOYkl2NEExUUdsRFlMdTVwTER5?=
 =?utf-8?B?MnZObnF1Zm45VXV1anYvem5KOTgyd3FnYnlHUDVEb1hWNmR5RmtBcjhZNERX?=
 =?utf-8?B?eDFHQitDMXVFUFRCQU1HczdjV0RNeFNaeVhDdERSbjBzMzJVaGZIWmk2aGJq?=
 =?utf-8?B?YXhENG53ZzdVY0IxVjA5VGhIQmwzN041NEJreHN1aUFKaHVjd0ZMNVRVYjFD?=
 =?utf-8?B?bi94MXJ5MHA4ajljMVF5Wm1ZTllyVmpHaUVvNHVzQWpwb2FrZWhJaTJqNitq?=
 =?utf-8?B?UDI5bXczRWl5V0NqTjhja09xN3p3TzNjMmNDTSsrVkRnNEFXZC9EYUhUbkdT?=
 =?utf-8?B?bnhINXBnMDhjQkFWZ1FPV3p0WVVOOEdIZ0hRMUdjNEk1eE1KU09xUUcrQ3Zw?=
 =?utf-8?B?YzhPVFhvdnNLdHp1K24rQmx4dkptTFhOVEN3eTNzSW9OZE51Y0U2QnZRYXcv?=
 =?utf-8?B?M1RSZWhjNkhWTVNpQzFmdVdKNEc2Uzl1eUlWMzhKUDVBNi8remZXVVhxQWtr?=
 =?utf-8?B?RW9XQzdrc3hqMklFcUZMNCt0YVFaUjFsRmk3QnF6VmhiRlZjM1VidmQ0NWpJ?=
 =?utf-8?B?MlRGNmNnUkJGdEdkU250ZVQ0bGtXL2w4VEo3aU1pSzAxRTRlOHhNM0FFaTNU?=
 =?utf-8?B?MGMrTTliKzQxK1J4Z1FKVENTWVVFWTV0MzBxRTZHZWs1WFZtZktFSTcxQnQz?=
 =?utf-8?Q?IvAOPSzbxGRcjJD3t3phhdA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWoyVjh0RmFnOVZlL1ZRZUlxcE5MM3RVZ3NoWXdzWXgwdEhwZlRIcS9BYTNK?=
 =?utf-8?B?VW9mVXNzUFZDQUVsUHZDV1JXcWdzVzFVbzFpTzRPMmNReHZKZDZKQ3k0ZWh2?=
 =?utf-8?B?U2FVNUpmRUxvOXRsaE85RUg0ZXNxVWJjVDhvT0lueWhIbUIxVVBmdCtOMGlZ?=
 =?utf-8?B?OFQxdnpZK0xJR2FnVXdXOUZOWkh2QS9hNzhyVWhGWUZOVmlqTlZyTDNIYzUw?=
 =?utf-8?B?WS8yNGM5TnZBZlpyZ0pHQUdxYW10ZlF1TlpsNXZvVEtaK2lXUzVxWFlvd3hD?=
 =?utf-8?B?TlBJbE9pVWl1dG5hTTQ3cDZJY21nR0wrRCtZMEtOTEt0MHRreThpUWhmSnJn?=
 =?utf-8?B?OExCOHFORkQ2Q1JVUFVaOVBhdnNsanM2QTVyVG96NVBMYTdsa1hBSmJHblZN?=
 =?utf-8?B?L2VvaUMvbG5MQnZEb3p0YytkV0dCTnhrTXkzNEh2QTVPRkN0SkZkWkpSa1E3?=
 =?utf-8?B?Rk00SEl5NkRJL2lEUkxrTy9GTGw2Uyt2U1NyMFpONGJHeUxwZ0dYQ1VHSjZP?=
 =?utf-8?B?YWo5NTd3aE4zbkU2RXFHRFJGOExmemYyTkV0VlB1MVo1S0lReU1nZGpLOHVF?=
 =?utf-8?B?ZzFyV0tCTGFJNGt6aU56SGduWXM5c1N0bzdDTlFqTUtCTnhOV2FjZ2Vqa3pK?=
 =?utf-8?B?bkNPc0ZxTmlpbTRBbk1JQXdGOTlQeWt5SW5vNkY0M3p2M0VqZUdFb05YV3V0?=
 =?utf-8?B?WEl3SWxoc3pMcWRHQVdjVWhBUnFTSmVNNkVLMUpmN2ZFQTRpZmNOakkyWFcr?=
 =?utf-8?B?NzQzdXVkYlNhamk3ekVZZUEycWtIRjhweXRJY1ZGOWVIaUk1Tm5wZGtLeUIr?=
 =?utf-8?B?d1hDTFBvTEV2ZnNNMURiTlFjM0llWkFCOXpXNCthVmdqVnVOaXRpQjgvWGhq?=
 =?utf-8?B?UUxMbys4TjM2cFRmVUUwcUNjN3FkekdKZGNRS25meERBOE4xUi9iWkc4RXI5?=
 =?utf-8?B?anRSTXVMK0RyUEpnOGRTUWZXYVhBckJHcTV0anhPM21iTm5QcjV3U0RkdFRq?=
 =?utf-8?B?SDBVaDBWa3Mwb1Q3STVQYlZFWHBKWk9ZVTNEVjlVa09UYlFVb0lIMHdRQUZI?=
 =?utf-8?B?K3doYjF0WlJ5cWdObUdyYmFLS2hyYTkvalNDcTlPMUdsaWtrSktVSmlCYkVC?=
 =?utf-8?B?eWlhTjM3djJsZWlLd2I5N0tMRzA5aXk3RjcvTXBxOEFhUEEyOHZScWNiRjli?=
 =?utf-8?B?VHZrbm5aWlFuNkFxYkFNQ3FsZFZpRENDQUF3anVNTHZnbDd5NGNTcVJvK1d3?=
 =?utf-8?B?Ri81YlhPaWpDSjBJd3haNzFocjZTajZzb1JHR2V2KzR0Y2lJZnJUaVB4N2hG?=
 =?utf-8?B?U2JLZDdONWRMVzJ6d3drUWFaNXR4Wjc3bHJkbE1qdXJOL2YxZHpPMVFSOTZN?=
 =?utf-8?B?d3NmcWxycENUSDJ1dis3MklVQWg1cjRiTFhtV3plS3NRQjZpemxYTnRjZlZa?=
 =?utf-8?B?V0w2WGp4MFZYZXBkWVB2WlczbUN6VUkrYnVBRTlnZzZ5YUc1aUZ1OFFXTUJ5?=
 =?utf-8?B?TXVRc21SblJUQS9zUzZIcGtYN1ZnSzMvbVNNYzZBTkdJV1l6bDlsYkp0Q1Ew?=
 =?utf-8?B?dTFqT0xGdjVwMXdxQ09FbmwycUtpaDhQZDV0NGMwNEZaWnZTMzVOM2dDRkJV?=
 =?utf-8?B?Y3crNDdjUkJnc3loSTM3WDVTd3VWQjFDaGhaMUZ6eUhWZnVCdXpFUy9jSk16?=
 =?utf-8?B?U09rZmRuYXREaDJuRml4S3Z6V0YwcGZNbHhZZGFBVkJYRVNKa21HWVpUT0Ez?=
 =?utf-8?B?ZGNjRHRNamdqdkNpS0xib3pVVTVUbER5RnJXMGcvbWxlT3dwci9TTDZxS1VV?=
 =?utf-8?B?bTRSSWlQSmlHUWJTSEowVDVHRU12bWF1clBzRjN6V1YvUS9XYXltMlRYUHVk?=
 =?utf-8?B?aWhmWnUxM1VaMFBXMzVjKytQYmw0elg2VGpyR3BzUDV0WFdqQzRxVWVwQm10?=
 =?utf-8?B?MmpMTXRoYmRGQW1wdUQ2elRGSVl3UUpqNy9MYmx2MDNEeXlKUTl5eWtQaU1k?=
 =?utf-8?B?MjA5ZFJxc3ZMNkM0WlJCR2tiNXoxd3lnRm1Ic3hveWZSbTloSldLay9LUUd3?=
 =?utf-8?B?bUFuQURiTHBncDE2T2hVRzJ2ejhCUWZtRjFaLzdNanpJMkxzU0IyeE1UeU9G?=
 =?utf-8?B?STZQbm81WWZzQklKdUw2UGNXWVloMFZkM1dSTzBpN04vUzdKd1pyME1SQ3g3?=
 =?utf-8?B?dERHMkNkcisvSmV6YmRDSURxL3B5NklVUTZ4QU5UZ2RMMkQwRFlZTUN0V0tZ?=
 =?utf-8?B?QmpYV3QwdU02T3RzQTVXU3FXYVVEckVMN214c0g0MmFRTjI3Y2dmcXlQK2o1?=
 =?utf-8?B?VmVKQzJzcFU5L0xySUFHV3hKUzlSS3dPT3ZaanppSlQzNGVSOUt3dDZCZnJx?=
 =?utf-8?Q?bij0aoW1QMfi2azM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae31799-cd53-4405-e706-08de5f216c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 10:30:29.0840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OAYOMMVeTzZEstXUP/Imzahs6yEEfyKr0wJLezmmw2anE7JxWPQ9pRTfRVZvdIdQxqkomvCmWGbwrUk5qBGKCsmBh2sD7RL4osWeAV6KMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4956
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254704-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,osuosl.org:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,lwn.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 626D4AED67
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgTWF1
cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDI5LCAyMDI2IDk6
MDggQU0NCj4gVG86IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBMaW51eCBEb2Mg
TWFpbGluZyBMaXN0IDxsaW51eC0NCj4gZG9jQHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6IE1hdXJv
IENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz47DQo+IGJwZkB2Z2Vy
Lmtlcm5lbC5vcmc7IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBsaW51eC0NCj4g
aGFyZGVuaW5nQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFi
QGtlcm5lbC5vcmc+Ow0KPiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIHYzIDEzLzMwXSBkb2NzOiBrZG9jX3Bh
cnNlcjogYWRkDQo+IHN1cHBvcnQgZm9yIExJU1RfSEVBRA0KPiANCj4gQ29udmVydCBMSVNUX0hF
QUQgaW50byBzdHJ1Y3QgbGlzdF9oZWFkIHdoZW4gaGFuZGxpbmcgaXRzIHByb3RvdHlwZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYitodWF3ZWlA
a2VybmVsLm9yZz4NCj4gQWNrZWQtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQu
b3JnPg0KPiBUZXN0ZWQtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0K
PiAtLS0NCj4gIHRvb2xzL2xpYi9weXRob24va2RvYy9rZG9jX3BhcnNlci5weSB8IDEgKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
bGliL3B5dGhvbi9rZG9jL2tkb2NfcGFyc2VyLnB5DQo+IGIvdG9vbHMvbGliL3B5dGhvbi9rZG9j
L2tkb2NfcGFyc2VyLnB5DQo+IGluZGV4IDkyYjU1MDE4OTk4OC4uMzM3MTBjNGJlMTQ1IDEwMDY0
NA0KPiAtLS0gYS90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19wYXJzZXIucHkNCj4gKysrIGIv
dG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2NfcGFyc2VyLnB5DQo+IEBAIC0yMTksNiArMjE5LDcg
QEAgdmFyX3hmb3JtcyA9IFsNCj4gICAgICAoS2VyblJlKHIiX19yb19hZnRlcl9pbml0IiksICIi
KSwNCj4gICAgICAoS2VyblJlKHInXHMqX19ndWFyZGVkX2J5XHMqXChbXlwpXSpcKScsIHJlLlMp
LCAiIiksDQo+ICAgICAgKEtlcm5SZShyJ1xzKl9fcHRfZ3VhcmRlZF9ieVxzKlwoW15cKV0qXCkn
LCByZS5TKSwgIiIpLA0KPiArICAgIChLZXJuUmUociJMSVNUX0hFQURcKChbXHdfXSspXCkiKSwg
ciJzdHJ1Y3QgbGlzdF9oZWFkIFwxIiksDQo+ICAgICAgKEtlcm5SZShyIig/Oi8vLiopJCIpLCAi
IiksDQo+ICAgICAgKEtlcm5SZShyIig/Oi9cKi4qXCovKSIpLCAiIiksDQo+ICAgICAgKEtlcm5S
ZShyIjskIiksICIiKSwNCj4gLS0NCj4gMi41Mi4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIg
TG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

