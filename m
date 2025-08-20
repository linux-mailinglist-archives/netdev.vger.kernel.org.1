Return-Path: <netdev+bounces-215398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF7B2E6B7
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA28B1C857BA
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18C42857FC;
	Wed, 20 Aug 2025 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKPVho8n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CFD1DB154
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 20:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722162; cv=fail; b=qYgvAuMpZbd5ygOz2MYA8EO2IPjHNrfSavdFtbGdbHso3SvlQJH8Y5VsPaCGrY9Vd39PYkTfrMbaoSCYsOAm6AOLD/C95L3ZVlN84Nu/5MFYNnDhgZFDUd8ztQyGwt485MVDVqIGHaSjFXl8KR/f044MVJ6MossQNnaleAFPqGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722162; c=relaxed/simple;
	bh=+QbVeFXmZa12E7s5k2hvFI1dT4zmHSgNZLvN9s9Q7RI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LB7QiqGw6x7Lw3QE8ifEEB+RNarCJ7vZkap8/frt/7tQY5/5OyEehot8vvfNDjp7MuYGGd8plgHvBfK2+l0KHzOUkTP1jYycQ6Cla44ghfCWdgsY1+HpZzSaDRbOqWH7UQlIsJphIfT3v91Pmb55LbJFXs2M9KqXQcJUbudTKys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKPVho8n; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755722161; x=1787258161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=+QbVeFXmZa12E7s5k2hvFI1dT4zmHSgNZLvN9s9Q7RI=;
  b=aKPVho8nzS3j9ypFJDmW3qKZ39FQVsJhmcu1cZddjPLXMyN/ttk1y2JT
   hbuV82b57Ok7tRgqStVtVpF74oIle+pkGISMunYrqERNmGGK9wRmiXP2G
   evelRFDLDJY4f6K0kJsfN7klKnCZJ2TEFOEpwyp3oO8MCM6SnLZG31ZiY
   VXJsk4bQDelO01EiIu8bdzQT0cQgVaXCZwURTeUPIA0TYaNqVWGnHhOWW
   E9hS52bRkkThvWCwTPq11hluTgzoAMTYbwDssPvQesFQOossy6MMwBIzl
   GWQEC3f8hFQE2f/BCGgsSG+CObswt74QP6hGPNcE0lnV5SuGp/28ohD2M
   g==;
X-CSE-ConnectionGUID: +zsG3Z2rQeWyHgHOhOfGpg==
X-CSE-MsgGUID: WD7IKpo8RIGnHhmKJA46gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61829695"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="asc'?scan'208";a="61829695"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 13:35:57 -0700
X-CSE-ConnectionGUID: gmeC/fCcS0Ghs7040OJG+w==
X-CSE-MsgGUID: PLMOfeh+SBuJKQWUqXWfZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="asc'?scan'208";a="169013252"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 13:35:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 13:35:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 13:35:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.64)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 13:35:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaw1fo4WLbcMYpORoYeroxIg/M3RjDJwAogkECX65oZkvi8f4Pqokn20U4Ki8WI/LgrG4/JgBaKJXu7acme+ViFptUvzVWMKBAkuCozreSAbbJUg7PuAjdgL45y2CYLtkOJXXtibN/9VNUaY6gftCsNKfEeVAiPuxbcYDDmxjFLMgXz+BEqgy+G4OWBO05YrwvnPi7aKXB0w8xLjTc/bqlsvCzNCRuLkqN8OPOO5JYIE/MA4CM9QG5gxD1/Yy6ANQCm4vvAlac0Kpa5z27UvJKBhZ+c5huNpK7TQMBE/hA1+jXSB4Pqa5gQFSAsWpjH8hHgQ2Nn9PfOLV0AYVxVk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QbVeFXmZa12E7s5k2hvFI1dT4zmHSgNZLvN9s9Q7RI=;
 b=bAngJKy1KyMqf0qYtu2w0uqWMS4oKjv40xmf7ihm8deCqM4MdgmZPvaWGe2IIVILrT/6jCVXdbnme7dPCkG/B/kAGUL4XB/Bn6NDF0xsQBjGWdNkOxDD1q+Ui8Q1WtTPlsSCPHeFRWaw/+QuuK75QXsjken7lBWBagOnBDRn7++VCupWwr+aS1uVFg/ARj+H1EbTVlhF++jno+merHRkEY3N5yFoBR6F9+ZbDjDwXXU073LaY3+DeP16ZNaDED64NE0/xAvFoRvB6hWigdNY1VUU2a1ZwPa3nTq57fBeYqwAPzYQmLqgkZs+ZmpPmhxwb1inibIgwiBSyqyUg9Nn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PPFB266726CF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 20:35:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 20:35:54 +0000
Message-ID: <6d7fdf16-3ed8-47b2-a872-164f1b6d5937@intel.com>
Date: Wed, 20 Aug 2025 13:35:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PATCH: i40e Add module option to disable max VF limit
To: mohammad heib <mheib@redhat.com>, Simon Horman <horms@kernel.org>
CC: David Hill <dhill@redhat.com>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
References: <20250805134042.2604897-1-dhill@redhat.com>
 <20250805134042.2604897-2-dhill@redhat.com>
 <20250805195249.GB61519@horms.kernel.org>
 <6133c0c5-8a1a-48c3-9083-8cd307293120@intel.com>
 <20250808130115.GA1705@horms.kernel.org>
 <CANQtZ2wffk6jUTTMYFgTYxWQBc=hmw7nAkbYB2kxt-1ihUP9Rw@mail.gmail.com>
 <f5c3b451-0a8d-4146-8e47-be2c7e2d6284@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <f5c3b451-0a8d-4146-8e47-be2c7e2d6284@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------01hFdBpyvE8lVfYhzN0LcvCt"
X-ClientProxiedBy: MW4PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:303:85::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PPFB266726CF:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d44766-90cf-4fd8-60d9-08dde02928d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzNtNWNNK0drdzhLVUNpNjZVeGJITlNCeWZqc3BlYXlPaGlWdEljdXV5Y3pq?=
 =?utf-8?B?VzZud0JwbG5GemgxVmY2MFZaMkVkMlpMMkdDNEVaaXhWVnNxWkt1SjJmcjQ4?=
 =?utf-8?B?S2JjMkdqYU5hY3RDRWZKczBndXdRS1JxYzJ1UUdZQnVrbFQ5M2NrcHJlR3Rt?=
 =?utf-8?B?bncyTERJTjBOa25yc1ExVE5DSnYzNDh4bW1XMGxRSm94Q1hKU2N6TG1FYW1K?=
 =?utf-8?B?ZEM2dVFLZW1SNU1kWHRCdWtUeitsZ0V4c0Rrc3BkRjNXaHd4cVhhNDFrcHB5?=
 =?utf-8?B?Wk81WTZ3U2k4L054bVZuN3AzUHprZTJjY3hQTkpiSHg3WFUwZFBkcmJGczVO?=
 =?utf-8?B?dEUveDdRUFBoUnRiR2hRNWQ3T202NHlyZjA1cDFZUi9IOTRpeVhwSFU1Sjc5?=
 =?utf-8?B?Nlc4bEhGQTZVNlMxOEZSamNFZk1oOUlqRkphMjRCbjB2VHNybTcrSUN4T3Bi?=
 =?utf-8?B?WWRvWk9ZWDVqUW9URmFIclJIS1RPV1M3OGVpVWRZeXdZbzdOZVpqUWVwd2hk?=
 =?utf-8?B?bEYrMEVEVEdzd3Z4SVY2eEk5MGtMUHFpZWx3UHp4VTJVdGxxeXhnN25DQnNF?=
 =?utf-8?B?dWJaT0paWjZhM2lleU92T0xRLzBHa01rRkIyYityMFE0ZmNsOUhMb0Z3RWRS?=
 =?utf-8?B?elVZWGI0cVZKaE84VFdyUzVYS0J1REZ0WjkwMUVpVm1TZEFPTml3WkcrM0lu?=
 =?utf-8?B?Y3pOQ0NnQXJpRnV1NGJhOUJSM1VQQXowZVlRRHV1bmNvbFh6N05UVjQrcjFX?=
 =?utf-8?B?TTFieEJSVU4xVEpUaVJuT3htbk1NcWNPeFIxckVsQUlwY1JmMTJRQm9oV0d4?=
 =?utf-8?B?NnI5dDcvbzVtcjlaUGFSeXN6bVF3VmVXaWJBS1c3QU9NQW5JYXZ2cENweXpJ?=
 =?utf-8?B?QlA3SmZSaVB4V0puSCthVTh5YXZQWnVWMDNjeVdRRmR4WEdJNnlDL2d0OGFr?=
 =?utf-8?B?SUpBOVBsZmZXVlJ3VnlKK2hxOHpsMy9NdGNLK0NBYzRMTjFaalFnNWdZejdv?=
 =?utf-8?B?VlJpU2xRSGNocW5TYm5GQjlHWXp4czVMUFpCcXRpeHpadm90M2orT2Z3dnZ0?=
 =?utf-8?B?N09yZWtIbWVHVnE3WCtudHBCVm5mWHZiU3NmbFdsa3hBazRONjNvZWZJK2FS?=
 =?utf-8?B?N0c4MHVhN3NRdk1nODJQcDdzdFZCNVA0dmVzdWkyb05QOUs5MTJBY1pSTHFt?=
 =?utf-8?B?OUV3ajZtemlsZHFvMzZXZHVyN083bk1yRkNlS2owL3FsVzlsaTA4Sm54clhp?=
 =?utf-8?B?Y2EwMjNpQ1Z3c1ZQZ3dvSmZRa0FqM1hBNDZkemYveENnOVBpU2UrOXpvdk1n?=
 =?utf-8?B?bnRNUnE0ZjE5eXBYRjlWV2xoU2hGb250enByNHMxRmNPZWpXOGVyY1BycmRX?=
 =?utf-8?B?aWI5UzRUdW0xYmRqZVZaSnk3cVYyNVRKbkNSZVB1alVteG03cmtSVXc2VG5R?=
 =?utf-8?B?b2MrNURFcUo4Y3ZjeXZTZzB5MytDMlI1b29sTFZkc2Jqa2VVWklwVmw0TmpW?=
 =?utf-8?B?RzF1S2xtL2ZKdUZFY255VWtMbzU4RzJzbURCM1dpcWtoODNCd3ZjS1lWRDhh?=
 =?utf-8?B?TFRNeEZFdUdndmVhcFVuQjFkU25QRGlqMnF1R2VVSE9lOHFEalNTR1BaVEFT?=
 =?utf-8?B?ZlVwVE14Y2tpUDM1dVorLytIV3hETisyZWd3MkovOGtwRk1zUDIydGJmS3FT?=
 =?utf-8?B?R0ZCQlJoalpWZlF6anBOMGliWHllTlg5enZhbHhjZnhOZ2V6YVQwWVl2NkJC?=
 =?utf-8?B?YzJUVWNHd29wTEx3Z0JLVmRLYUltQ0I1blVrY1M1NHhTajl6a0E3WGVDSWNl?=
 =?utf-8?B?NGNTVjJFRVVneWtQNWpMUzVXWTdWQmZSS1V4bXZGSmRlaitYeUlGNHEyc3FF?=
 =?utf-8?B?d0lodWhsMEVGRTZBQzNJTVJVRU9FS3hNRy9KRmtDUHZ1aXdicERZVERIZmxI?=
 =?utf-8?Q?F1JFoO014qA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1d2Wm5pa0FmcjBNcy8rdmRTOU1naTZnQ0kvOWRtcW1NaHNiTHpFeVJHV2hX?=
 =?utf-8?B?Q3NialNUUi9XcFM4UndhcUlCWGNCMWxhaW1MNW16a2dWMjJqNWFnd3Jjd2Uy?=
 =?utf-8?B?QWhSaWZ4d212ank0eTkxQlV4RWpIWERvbU0xcldkc095VjhGSGF5b3l4ckpQ?=
 =?utf-8?B?ektRclJvQjZPMEUwNkVYVXNuKzUwVU1nSHUwVmRqZUxBMUg5WGN1YzgxR1F0?=
 =?utf-8?B?dGtqdVNhR1UvYmZZUFRodkRaSXFkd2Z1aXZXM3Z4bkE5WkltVmxFVWpxaGlF?=
 =?utf-8?B?R09PMWJveWdlVGxPM3AwbGMyVldBbG1NQitxUkk2UjhDYUdrdGxCM0prQ3NT?=
 =?utf-8?B?MkF4VlFseEZhTktQakFUTHRIdTJpVHBvWW5rNXpNeTAzOUdVRkRHQVViQzkx?=
 =?utf-8?B?M3pxbFdCN3RnTXN4N08zNzZaY2dzL3dxRVJkTWtlMEdxeVNhZEh4b0trcGFt?=
 =?utf-8?B?aGVvdTVOMFhNVEE0OFVaWGg1SW9LWWs3Y1MySlBlOURTZDM4MktkZktreU94?=
 =?utf-8?B?Tk1hM1VsVTI1cHp3d3NOTGxjOEZIc1l3ekI3b0k2QllocnlKbUVFbHhhVGk0?=
 =?utf-8?B?MFlJTE9kQXdodVl5RDFPL1BmQXJzZVFWeHF0bWpmRDcrWDhrWENtZFVMQ1V5?=
 =?utf-8?B?cnhJUEkvTmwyWE9QU2paa0FyU2FPQjBudVRucG5POEFvSm1iZVg1K00vREVD?=
 =?utf-8?B?eno1RVNHZmtzUHo3QXdadTBQdHp3OCtlRytSaDQ4V3pEa1p6bHdBbkJ4NVp6?=
 =?utf-8?B?bEdRTVdrZHhheldQYklhKytwNHdWbFVQVHoyVndISGJsVERNZXY3NkRsblZB?=
 =?utf-8?B?S2FlNUtZZ1AvdGtrV0NVc0cyazhjcGFXWCtVWStzQ0lnMXF2dVdnNlJpbDlZ?=
 =?utf-8?B?bFRKajNDV2xVYlhCblpoT1RDTnJ5VGQ2TkVFM25CMEZUMkN0MXpDTlEwYTRT?=
 =?utf-8?B?cmZxOWU3eHhLdGZmNjRzbWFtanBaMlBQYVVRTzR3WFNJVG5tZkdqM1FOdGhW?=
 =?utf-8?B?U295Vi92UTZHMERheHZOYUZkNml6dEhxeUEyeGlUQm1ud05hY2lTNDkzR3dL?=
 =?utf-8?B?STZUMEhpM1d2SW9aL3lITlpEem5EOURXME9icTdTdExHNldZWFpnOCtUSUF1?=
 =?utf-8?B?MUlyaGwxMFpPSGRYbFUwNVhlWStJdHZoaG9rbDVMRW52a2xJZitIWlZSMUQz?=
 =?utf-8?B?NDRWdDduWTBoaHJGTEhlbGhCSk5qWDVqeFE2RW9NMDdJOWV1cysrSEdJZHBH?=
 =?utf-8?B?ZFhtNUNOMkk0U3VwNGJ5clUxaDJHN2Z1UmF4M2NuMWM2bkpEbytYZGhKMVZw?=
 =?utf-8?B?MFVHOUVFd3hVTHp4dWw4ZFJYNWRQcFJEUllDOWM0Qis5RFY3WkhXeUZGeUl1?=
 =?utf-8?B?dXlVajJTM2VwRXp4aGtTNms4TkYwSDVrc0EycFk0TC9VR1JQdU5sUGk1TEZ6?=
 =?utf-8?B?K2Y3c2NjQ3RWUzdtTkhtck9Ba3RtSDJuN3dDRHZTUFVyMy9xeVNtMHg0dUI4?=
 =?utf-8?B?VG1NTWR6TEZZWkJCdWlqTGVOblkxdjcvd0tnbHVjcEtNZFNrN0o3RmIwWFRR?=
 =?utf-8?B?OTFQRkUzKzFyRXQ2eXk0UEIwZXRPNXpoQkxBZ2EvTXZST3AzYzZMQUJQTHVo?=
 =?utf-8?B?YnhPbUYyTDlhdUd0MnBNVEg2OE1IN1BXak1YeVc5Q1ltMWtYU0ZEYjVTQTk2?=
 =?utf-8?B?dWU0QXQvWDFwTE9KTmNzNy9EMkQ5RkdLRG1kRm1jOW9SWUR3YlRpQ0tpdS9L?=
 =?utf-8?B?Nkk3NTlnTTl5OWh4MG5KZXpBc011RnJwaU9nRUhlVitDMHRHalMxWTBNV0Vn?=
 =?utf-8?B?MWQrdFVjR3RSV1RSay8xTDY3dE45UGlGQm9RNmVkZ0pEa3B3VjNrSDVkLzhi?=
 =?utf-8?B?V3ZLMTNwVzNqeHA3RUp4MitjN3k3UzJ6RnpBQ2ZGRi9YNWdMMGJIaVFSOGhT?=
 =?utf-8?B?OWE0b0d0SEtUN0RSQUdKN2pRaDlFQjQ2czJwU0I5R0JaanpQL21lRncrR0pi?=
 =?utf-8?B?aEZaalp3anVRYWViMDkwbC90SlRVbTJwYTZGWDRtUUFqQkZiVTlvajF5MDNm?=
 =?utf-8?B?RUxuUUJjTXBydzI4cERML0ZnM1g3MkVlRjNVeWFpaXhvaEJWT2tWUmpiRk5l?=
 =?utf-8?B?U1l0NEZvNDdMeGJMTlk4QzhlZTdDL2ZmRTU5ekwxRHA3Vmg0UUxiRHppUXZa?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d44766-90cf-4fd8-60d9-08dde02928d4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:35:54.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6qa+ZLmIzkvQAdWJDUd1SxYuuU+oXX3jJFrUdVF/Vxa8CjfbZuK3SBqaHD1DI+RrBCvgcGXOnGdTFyOP3ZR7UOlntkPl03mCFjCdJyVHOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB266726CF
X-OriginatorOrg: intel.com

--------------01hFdBpyvE8lVfYhzN0LcvCt
Content-Type: multipart/mixed; boundary="------------4JAHLGZ6qA0Ufl0m4rjOlNbx";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: mohammad heib <mheib@redhat.com>, Simon Horman <horms@kernel.org>
Cc: David Hill <dhill@redhat.com>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Message-ID: <6d7fdf16-3ed8-47b2-a872-164f1b6d5937@intel.com>
Subject: Re: [PATCH 2/2] PATCH: i40e Add module option to disable max VF limit
References: <20250805134042.2604897-1-dhill@redhat.com>
 <20250805134042.2604897-2-dhill@redhat.com>
 <20250805195249.GB61519@horms.kernel.org>
 <6133c0c5-8a1a-48c3-9083-8cd307293120@intel.com>
 <20250808130115.GA1705@horms.kernel.org>
 <CANQtZ2wffk6jUTTMYFgTYxWQBc=hmw7nAkbYB2kxt-1ihUP9Rw@mail.gmail.com>
 <f5c3b451-0a8d-4146-8e47-be2c7e2d6284@redhat.com>
In-Reply-To: <f5c3b451-0a8d-4146-8e47-be2c7e2d6284@redhat.com>

--------------4JAHLGZ6qA0Ufl0m4rjOlNbx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/20/2025 6:09 AM, mohammad heib wrote:
> Hi Simon, Jacob,
>=20
> I=E2=80=99ve also been examining this issue, as it=E2=80=99s affecting =
us.
> I agree that handling the number of allowed filters per VF as a devlink=
=20
> resource is the best long-term approach.
> However, currently in i40e, we only create a devlink port per PF and no=
=20
> devlink ports per VF.

Cross-PF interaction of a global resource is also tricky. Hm.

> Implementing the resource-per-VF approach would therefore require some =

> extra work.
> For now, could we adopt Simon=E2=80=99s devlink parameter suggestion as=
 a=20
> temporary solution and consider adding the resource-based approach in=20
> the future?

I do agree that its a much larger ask to implement ports and such in
addition.My only concern is we would then likely want to support the
parameter in perpetuity. It is generally preferred that we don't remove
things in the future since it is a pain for software compatibility.
Technically, I don't know if that truly falls under "user space API
changing" if a single driver changes behavior.. but its definitely
frowned on if done without a very good reason. Perhaps there is a way to
make sure parameter works ok even once resources get added in the
future, to mitigate this concern?

--------------4JAHLGZ6qA0Ufl0m4rjOlNbx--

--------------01hFdBpyvE8lVfYhzN0LcvCt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaKYxqAUDAAAAAAAKCRBqll0+bw8o6GyG
AQCvVsyd2sPSCUhMlo0S3BpQ92eX6WMKpOX6yTZdJgZmPgEAoJ2+DMpC7nezrVvbF5wfMTGp28zj
NLYhTrDNn/XS0wg=
=xyhC
-----END PGP SIGNATURE-----

--------------01hFdBpyvE8lVfYhzN0LcvCt--

