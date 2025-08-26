Return-Path: <netdev+bounces-217095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54BB37595
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C51E1892A1E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FF122E406;
	Tue, 26 Aug 2025 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bb9rYvvl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3573074BC
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251329; cv=fail; b=UlBdVx4TGo6EPCIixvilo5GDd654ZXurYssk7Z36UHug6xoxpvmk6ZhxtkqbdCE1LK9489bIXbzbxKZKmxzs+fGOoJ+kmNNsb01kDtAMfxa+R9E5zjrNqJaz9EeNuB4ej8z8Y8K0N8zA966WRXc2IE+Jy9wAn+mAwgJnitVA5Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251329; c=relaxed/simple;
	bh=/TcrNOxSfKYtdJjS6eSAjGl36iR/1DGF0uBQxazZEW4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AVQoUqV301+khN87caGtQjXj4d0mFd+wDKufxNnmIApz/7BVjkYgjpBDtWZbj0k96uWYg2RSKM5yPIlaNX0Nuhyw45klsA0e4HW1acw5tGIch6CarJo9GAuTH/xNjxzsA3zwweG17C4Uf8OYXbEPkQwrDig8HXy6NHrvry4egRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bb9rYvvl; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756251328; x=1787787328;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=/TcrNOxSfKYtdJjS6eSAjGl36iR/1DGF0uBQxazZEW4=;
  b=bb9rYvvlOPGhQxaAjtjqlVxoNm8tI6sZzzV8uBuehQS/8Sv0BKFsihnD
   R1QoCGbTiRWC7QfD/Ws0gAgdpn1ZtxxzrQacGFc6KZAUyDbcIG5D4tXqZ
   vv3SlbgNs5MZAv/pxWrdteC8IExaJnNxIljVtL8XiRo4b37PFFxpFfNJ7
   3cLVZcdE7kOH3IvhtQaAV7UKuKM8SZZk4jC0NteGiiGk81G6exmryW4BP
   tO+dLUoiG4sFVCjlAo29XQTupDCdCy5xHdGmTZa6DZAElbQ5rKlL1deXA
   5cbKEQHWifysjV6hDCv8nKvHeTxg/ULdOWS/9dYs3RB/R4CQVRuDVKwGN
   Q==;
X-CSE-ConnectionGUID: DvhbKQtvQnWdIBMqneO8lw==
X-CSE-MsgGUID: pEJVEUmESn+RB80fgxUczw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58211173"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="58211173"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:35:27 -0700
X-CSE-ConnectionGUID: XZ03sLXrT1amMQB6Y47vPw==
X-CSE-MsgGUID: vRVdWJdASziQiDkSvb+BZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="174107670"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:35:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:35:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 16:35:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.50)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:35:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luu1s7S55m9UdBtSXd1gY19N3uozsp3BVpvV4YCmMG8pJ/HSQMsjZzuXX/dlgcQfScxTsOY0PbJsCKqhRNZN984yOMwq+/fj7uBQMavPgspiVZSbrEGlVRrDHQ5p/+GdRPslwMKqjxtBOEuY+Qa5A9nVUsh60k74L+/EjoFfiw5cC33UfX/e72hiURR0JrFOTILP68aE0fmWcR3rQ3Gl5kCqEYe9AVS1Qx1pu8Ul4aXVIPX2v9VBlqahjzUAPZjEXDw41HOTh2iHYp8RuCMX04ZCYiiMHbdC9oLd6Wrlf3m/IcceeS8w+nKWIwDKHrKPmYLU5tCD8xvAJhjn9XsROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TcrNOxSfKYtdJjS6eSAjGl36iR/1DGF0uBQxazZEW4=;
 b=NagQgIXfcD0N2aQoqDar5gD6PqCnlptVn3D88bbvrvqBIdWKj6XOKg4kfVgPNXtlk4Wp9qSba8q75ZGUJWjrFDt/MvzpBPOI7kbUSJFXNIkGuKkitMM201S/c82WwTVpQn6MlMI2Pcw7lW7uvUNalnJmrB3En4AbaICrerDVqYm49W9FgfFPK7MvOJRxbp5dr8jFKCtcCjJGM5+bNMzIPdqt+H8G8oAKp18nHoNiBAr2BXPNtDY7XUntScOS8zWvjyZSkRQLl5uvwKOl79tne012p1hMa72jeNoIryC9KcSOn9J2KEXPW6UjvX7uTsq3LPcb18rdX+Us5tDMH3cX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6128.namprd11.prod.outlook.com (2603:10b6:8:9c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Tue, 26 Aug 2025 23:35:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 23:35:23 +0000
Message-ID: <670c145e-a70b-4bc5-9450-dd590e162143@intel.com>
Date: Tue, 26 Aug 2025 16:35:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/6] eth: fbnic: Fetch PHY stats from device
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <mohsin.bashr@gmail.com>,
	<vadim.fedorenko@linux.dev>
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-5-kuba@kernel.org>
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
In-Reply-To: <20250825200206.2357713-5-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------WiTCis2QOKj3F94SQHdiRC7p"
X-ClientProxiedBy: MW3PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:303:2a::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a05826-c6e8-4a6b-e7e7-08dde4f939cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVh0TmdpMEFEMjNqYlZ1aUZnc1AwaUI2cnhFU0pGMCt4b0dDNzNUYkJZS2No?=
 =?utf-8?B?bnluUXBoNzFlN2lPM3QzU2ljSlVjU2FZZXFiU3F0Y3Y5bG5mdW5za1dhVXF6?=
 =?utf-8?B?amk5VDRtNmpTaW02d29iaXQvYjd0R2p1dVEvVEtaNVZPUUw4WDhNZkU3VFBv?=
 =?utf-8?B?T0RkZG1tcEswNlhnZmdyNnNqSndJYzBaSWd0VHhCektwSld1UWYyQnIrWjVu?=
 =?utf-8?B?V2FHMDNqb2kvM1REcUtoM3I3RVhrcjhYT0lKL3dQMStLdGFlMDZpcUh1OE9K?=
 =?utf-8?B?NVJrNVNBYUN2MWJidmNyTXFKd1VHL2g2WTlJMlpNUXcxRldmcHc4bDY0Zmo2?=
 =?utf-8?B?eXpselBlWEFnM1d5Tit0TFVzY202KzIrNThHSFJWN01oVTZMYnNaR2wxRG5x?=
 =?utf-8?B?TEF4a3lQTU9wOFJOcDc0TFMxd2plNHArV0IySWtnZ1lSS2lUQ1VIcDF6clJY?=
 =?utf-8?B?Y0NCTzVMcWhrWHowai80RWNaajFnVG5hRU0xNWRmRU9SSVNDK2tPV2w5c0dH?=
 =?utf-8?B?czdMOXVzOUkvR3NaYmFwZDVHVVhCZlZKdTFTLzRXS3Y0b05jNHJoUUZQTjVt?=
 =?utf-8?B?UnpvdTFDNng5S3k2Z09SU2pxUWVSalpNK2IrTS8vQU95enFBUUU3V256UnJS?=
 =?utf-8?B?TEdGakgyYzRGZFNyM2x6ZWNmUE1PeDBCbFlsUzd0SWhlbUdzM21neUZXSVZM?=
 =?utf-8?B?SExoSDdTbTJ4UklkcjRObXpiMXg4OFlVOC9iTjB6c1R4U1l2dVdWdDFJb3VX?=
 =?utf-8?B?K0dXVFloRkM0MmpENy9reENoc0JtMXR3V1ltd1UvbmI2QW1rR3JDSXV1UVV5?=
 =?utf-8?B?OE1RQXdRTjlzNHh6Vml2RjZjTGZ1WkNhQjJuamVJUkZvQ3hwQllwR05rTnQw?=
 =?utf-8?B?QXQ2RDI3aU4vTWtaY0pDS2QxL083MXJCSFhRYjcyd05KMzF1MFpkWjM2SWI0?=
 =?utf-8?B?R1Vab0RaNFRwYVp1NlhxSzRBUmtpcXFlVFd1Q0lmVVZWMnQ0dHNSZXpUdDJW?=
 =?utf-8?B?V2ZCTFlpNkM0ZVJnajErbDQyT0t2T3lzS1JabHZPZ2V5UXZtK0pOeS9Ic3p3?=
 =?utf-8?B?b3NOd1RwV0VuRUsvbHlGSkErQ0trUm80clg3Y3YzNkJRczY2eGVoSU4vMjRm?=
 =?utf-8?B?dU84UnBobDVSR0dHaE9kMytrN01tWGlQaXVndmxSMDN2a2xmaEtDYWlWMTR3?=
 =?utf-8?B?cFNEQnZVWlBtWlRMMDZRUlhHdFhwNHp1cjdYQzRBSk50UVhZaWVzZ3VvYjhl?=
 =?utf-8?B?cklRZ0RkWTlTKzJOcDN1b3lnY0Y1UzcyRlFjczJGcDdJT2wrVVNBam5zaHNj?=
 =?utf-8?B?c0ZobHRoUVd0bzMyWGRjc1J2SUNIN0d0VmMydmVKSmV2Y2xZV1RnV3ZabUcx?=
 =?utf-8?B?LzViZXJDcVdHNmZ1ZXRidDEzVjBkZm9yb2I5SGtEMC9ZSlZvZ1VFVEtGZkNZ?=
 =?utf-8?B?UkhsN29Bc2RzSDAvRE5qYm52T3RBUTg5anFwQVJpbEZPWVFCWFpOTWlBazZm?=
 =?utf-8?B?MnBwejNIZmluOWg2c2pWQTkvTWN3OEJGbjM2M2NoeTR3bitqeWJKKzJSZ2Nw?=
 =?utf-8?B?ZjlNWUsrMUpLeHQ5QytKZk5MelhRUmJmK2tTTGtBRGJKRlBBOG1oTWcxNzhx?=
 =?utf-8?B?Y2wyVWN1SGNjU3JtZWRibjhzNy9VMmxnaDc2cHhkcS9FNzJmVVJKcGN3ZlRO?=
 =?utf-8?B?eGFEcm9NK3dScGhwNDA5V3orYVlvRy83b3N2dU9BeUtWUWhVQU45RUl2NHVr?=
 =?utf-8?B?TE9Dc2ZxU2REUml0bjNaVSs0SzNDSG5xUG1hSnd1cENkMTMvZWpoZ3VYcmdv?=
 =?utf-8?B?a3NZSHVMQnpCRHl4cW51bjdIU0FwWlVJZExWQUdqNFZZdXhqRU1lU1cxK25i?=
 =?utf-8?B?V0hSQjhGVzNmTGlqUkFzUlBRaklrL2VEZzNvMlRqSGYxWk4zV2kxdzFJaVds?=
 =?utf-8?Q?+TQHBKVbYbY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVFXbzZvdkZSUFZ6YjBVSUtsTHBPcjNTQnRyOElhQk1sWHJRRC9XTHFDT01l?=
 =?utf-8?B?MlhaUDluVm1IOTdpNmhzSjdVR1YrRTdMWXZhWitSOTk0Uk5tTzhCMFgzZ1d2?=
 =?utf-8?B?ZlVRWjlNOFpFVkRuQ0VTT1dWaGp2TDQ5dllvRU0vWXkxcTZsaU1Ic2lSZlpQ?=
 =?utf-8?B?U3RreC9qelRrTG5BcWdoYmZjVWN2cm5IaUlrYkFreW9nRHpJZ2M0a2ZHenVR?=
 =?utf-8?B?OVVQd21uVG83V0FBTUViZHljMmxhNnl5WjlvenJwZUZiTlZ0VU9pQnYwZmYz?=
 =?utf-8?B?L2JqdWlTV0xFMzNhRVNxT2Nhb3BtWVkxQmVmTWJhaXo3THRQcUFnRHAzcE5q?=
 =?utf-8?B?TmtNZlFWTll5SGxIdmpmaFNDUFYySXIybURtVFZaUTNmTU1idEcwWWl6K0s4?=
 =?utf-8?B?L0ZlaXlQRTZHeGJqN3RpYUhZbFd1RjY2ZUVuTmpKY1lRUzlTZmozdWd5V1Uz?=
 =?utf-8?B?NTVNSDNSU1Z6S0R6WTNNMk9YY0VaUkUzR0ZOMHVPdVVQQ25xb1dBSm9hNkhC?=
 =?utf-8?B?Z25NRFc0aVVMVHVVL1JhV3VkTndna01KNDNjcGJLdmMwV2R1UkgwT2tTRW1C?=
 =?utf-8?B?SkVqelc2NURtQkI3ZFl6cS84dHUyQjZWd1pmMjF1MXdwaHpGT3U5dnJDeWJC?=
 =?utf-8?B?QjRNN2tIQzJ4NU8vQm5NamMrM2h3SHVIaG9FTGZXZ0RIV2ZDUmlHSjFpNlo2?=
 =?utf-8?B?LzYyTzQ1MDE5NFpSVnFjVHd2VEVnOTR3NzlYRzRyVTFZcUxoZ3RiUVd0VmFP?=
 =?utf-8?B?Wkk4TXI1SUN5ZnZqdi9ibXpReFdaZlBlYzlLbEtlV2s5bzF6Sm44S1NxNWtn?=
 =?utf-8?B?NHNpSnZtMjVReEZhZlkraXlnQVpGZno2NHN0alFMSUtKNkhqOWVUenc4UVRC?=
 =?utf-8?B?OGRnaUR6Q2xqendUK1diV3ZkMTZkWGN1S2FMWFluajhqUW83b2Vma3NnMUhQ?=
 =?utf-8?B?akNiMENxMm1SbDRpQ2VzOGNiN1J5RVN5Qmord1V0blNwcUlBbE5lS2lOemdK?=
 =?utf-8?B?L2tVTGtKTGNVR3hBRkowUkNhVjVJWXJpdmhROWxHQS9BSjEzWWFya2lHWndv?=
 =?utf-8?B?cVMwSnZlTFhib3lCNUx6WVIzMk5ZbS9ycGNtQmRPczRPMlo0aSs5UnhCTUVT?=
 =?utf-8?B?blJxMTdnRzZtbGxJN2w0R1RvUDdnNU0wL0hZaHpUQUF4Y1VkK09GSmFLWEFq?=
 =?utf-8?B?MEdLTGpjVDkrb2JGMElEZ05VcG5sNmtnMHZrWUtVQjFZSFZ0bGxjelE3U0p2?=
 =?utf-8?B?VFhvYzMvMytZYW5MYXR2dENuK2k0dXJSYTlSWWFZWWw5UmFCZ2NiSTlrRm4x?=
 =?utf-8?B?VTFlSXdIK1FqdmhyV2VSdWVzTnRzOTZNdExoQzVRSHlFR3RiNmRQM3VHSnRl?=
 =?utf-8?B?aS82UHdzQW9VTHRnZ2U3aVRWUFJQV1QxOUNvNEFkRFE0MnpkYVIrdTVEY05n?=
 =?utf-8?B?d3VIZk4zZi93eHc3L3ZkOUlha09jdGN5dzZhM3dibitpTkZjQk8zVkFuQTVi?=
 =?utf-8?B?eXZOUUhVdWZoem1xZ3g1aTJRZ3pIWlQxd2JNOEFrcXhwWTdQMjRObTBXZUZU?=
 =?utf-8?B?RTZwOFlrc1dpWndtK3VDOWtmcy9uNVFLLzdqWVI3eWNRZWpkSVM5bHo4UVFv?=
 =?utf-8?B?bGwreVErMnNubittWU1kaUhMM1V1RDNuMmhvaGV4V2I0SmlWWEI3QUxjZTVS?=
 =?utf-8?B?UWRRS2Frd2Qya052dU5QSjFMS3o0eGphVGtudjNIbFA0dEFTWENQTnNXb2VW?=
 =?utf-8?B?TU8zdFgzWVh2NmxoYmMwclc5dk1Fak5sUml3SmdVOTYxRVEwNlNjNDFpcVIr?=
 =?utf-8?B?VjR3QnA5QmNPNGJVRDQzRVdqd0szNWFwVnlIbE9hWHNEWGw4MFcvU2l3Vlky?=
 =?utf-8?B?T0ZaMFNsUElJdUtJVzVtaVFGMEJGVW9Qa042QTZPVjJ1WHpVTU5OMk0zeU9P?=
 =?utf-8?B?UGg2bGlhR1RQd2prM0JWcDhGRGZHVXhVZGgwZXBWa2JqeTBZajRZbFBFdFZl?=
 =?utf-8?B?Qmd6SnJVN0ZGZzVtTG1rU0tEY1Q5NzZlNE9ONi9ETEQ2YUsrSTBxNlJ3RFFl?=
 =?utf-8?B?QnVTc1hIOUs2NnVUMWVuZ1lQZFBXL0QvSTFjTStGekRaem9kc1ZTWkJ6Rk1n?=
 =?utf-8?B?TXFjYTlQaGRWaEVaRFh6bkZsTzZaaDlBZmpkYTkyZG9uNFlFK1NDeEUxMkt2?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a05826-c6e8-4a6b-e7e7-08dde4f939cb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:35:23.6554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FI5F28u4hHqqDOzUmlGdfwtoCyaRMM2JpWV1WeUjjPEKlTsOKXhf8cXYlJ8y5bAowVJTGXuliguqD5XQ5hunnCRQztEanKgcjiItCqYOqiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6128
X-OriginatorOrg: intel.com

--------------WiTCis2QOKj3F94SQHdiRC7p
Content-Type: multipart/mixed; boundary="------------nGGofN0FKUVmzhbljJkzUcXj";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, mohsin.bashr@gmail.com,
 vadim.fedorenko@linux.dev
Message-ID: <670c145e-a70b-4bc5-9450-dd590e162143@intel.com>
Subject: Re: [PATCH net-next v2 4/6] eth: fbnic: Fetch PHY stats from device
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-5-kuba@kernel.org>
In-Reply-To: <20250825200206.2357713-5-kuba@kernel.org>

--------------nGGofN0FKUVmzhbljJkzUcXj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/25/2025 1:02 PM, Jakub Kicinski wrote:
> From: Mohsin Bashir <mohsin.bashr@gmail.com>
>=20
> Add support to fetch PHY stats consisting of PCS and FEC stats from the=

> device. When reading the stats counters, the lo part is read first, whi=
ch
> latches the hi part to ensure consistent reading of the stats counter.
>=20
> FEC and PCS stats can wrap depending on the access frequency. To preven=
t
> wrapping, fetch these stats periodically under the service task. Also t=
o
> maintain consistency fetch these stats along with other 32b stats under=

> __fbnic_get_hw_stats32().
>=20
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------nGGofN0FKUVmzhbljJkzUcXj--

--------------WiTCis2QOKj3F94SQHdiRC7p
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaK5EuAUDAAAAAAAKCRBqll0+bw8o6Kxj
AQCrNY905krvw1aYEefV0ujqv+PTQClxDVJpna8ygV9kcgD9HnHwZDTvEVpCvsJ0jNkynBU57lQy
8l9LHhpSshyupQM=
=6ysb
-----END PGP SIGNATURE-----

--------------WiTCis2QOKj3F94SQHdiRC7p--

