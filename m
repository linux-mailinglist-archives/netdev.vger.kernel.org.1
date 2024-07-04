Return-Path: <netdev+bounces-109316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12F927E14
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 22:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4655E1F244EB
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 20:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5EB13C813;
	Thu,  4 Jul 2024 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ilU4XFaH";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fVlX4uwO"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59745976;
	Thu,  4 Jul 2024 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123347; cv=fail; b=OzbxvbE8k9y05PmraCg5LZiYDvshRgwdU1Kz+EtYT2OtEW80fYTF1BSoz4fRv5mfkSgzeMEaT0717qzeuBl8UTxlFgLYOyCCUKxoGa6dGffQJWYHptsPHQDv7g/L/giNv7wU7IsrRAUTqn82MvGQauEM0A/WCKU1ETWqLdvT6Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123347; c=relaxed/simple;
	bh=bpl50F4PARkQYTi8/B8VBUf8G1/l8XHP+iEvcaqHbLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ne+8A5eLhwbHyPDvC7nBxIqQS0X1ap3cYDUm6bAQDCmc2wLmDUuay74EELKmInRhqFLbLm6kTRQN15pfTzhUTxUsgRHJfvFP/0sOnHtBNkquUEuiNUtz0uWRdd3x3vdnv2NIc0dEZXMQ5epj15b35+zfogVuz6XLoCSq4BMcdgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ilU4XFaH; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fVlX4uwO; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720123345; x=1751659345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bpl50F4PARkQYTi8/B8VBUf8G1/l8XHP+iEvcaqHbLc=;
  b=ilU4XFaH9dyLp1SAW2O7FcikivT/wHYkBCXAZk5ZFt16Pdh1/8RH2xtT
   S1cCKD/lFbMuF02ergXRk7DcTaR9FLEQ87g3uV3yI4g2nK7ClWa1p5ZWz
   TLBM3UjL1TcKJlxnLB85c+oRZr//Bs9Textxz3vo1a7EuAziO9Rvy77Jt
   mt5IrvIqexAfc80AKJqVDY42/HWeVlRvojs4xtynQ2glfSjuJfggmYMCD
   9UuiXv3EoWj1aR4CbNQyuyMTS1ic4rA7L1pzeNv5msZ4JZfagX74CEEyF
   ByEVpgahkWVw8JA0tv1zk1THoMYqeaTTOibzYv3PFUOyyevneMwMyv7hT
   g==;
X-CSE-ConnectionGUID: zMecV7zqT5KOVWFE2yW5uw==
X-CSE-MsgGUID: n015tLOgSsmWQXFujC7WoA==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="31495347"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 13:02:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 13:02:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 13:02:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhwiC1aigyKPo91ONwkJ5SAdnwetSypx4ERJqGsE1DZNMAvmXTpEC97gvt+US92wDPBoL8NaIV98+A1Jo6t5L8S9x1fff6HIl/MdX/wmOCAuD7zVef7x7R+MiYer4b+IMJc3iHSt7ZHh/DlBSeFVw61R9L+bcUNNm4AmVrqdX+TZDzccQPPlCuasIkOUlkh1uj/B9XJuNViUAei/Kj+oxwZYu/Wg1spWl7hztbCh8XnQPL3ooW3tWpqMrYbFUaDMBo8eog/HscBbtjzqh598gPxxRZJ8szjuM4Y47dAej4nrxrN8j2gCwS/l8oSbEujSzh/Fcd056XTt0k2TU4ZBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpl50F4PARkQYTi8/B8VBUf8G1/l8XHP+iEvcaqHbLc=;
 b=JxU9A8KnBq4s+tiFoHDV+ND6bASTIt3CuxF+dya2ABFcWPqJYHOdR2+/hmqS64Xw3sF/v8ISRev9Rblck3Emb3cQ6udwnDaizu0vDOByRnvkBBT4wTQ/m13qvqtYQWEk5fku/ANm4o3qVGMviTvBCJUVyaqe1spOn1tKfentfa14afTwCQHmpjxCFWiGb313rUE4sLC82HIOlvi909wHr+HHaOM6KiscOyrqg5keuam63Yq0Rb7Mix5Ruq9588WtSmeelREuA/QwVqeaLBW3BrhFAk3kay2H4dVpIfhCAKb7uQ0CNIZf58IU0HSw19rF7U0O4k7XHFlQbze6Iy2bZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpl50F4PARkQYTi8/B8VBUf8G1/l8XHP+iEvcaqHbLc=;
 b=fVlX4uwO8pJdBf1NwiEAw4FJliI3fOpQT9DV+CYiHD8SciqHE5YL+/weo6qWFNwqWnVRIcevkLuQ8nqheQQsvnsufzU4YUNDczb5Z58pdMhTcmJIb3g8MgjnpzjEwxBbVVZBOt2no15GmKCOwEmqQrWfUXT6oRN3z5N9y02hcVfbAadwGm61xy6nzr0MGlUoEp7RXjsMX8ZrV7g3TTPGEyChQKjIdIj67tgamBgtNyWtPIzmro9RqCzIG97XM0RGO95MyK2tvJjl/7IDLIlM7o8Ax3dS7V/s/MfEshUows35KyHp/pJILPUHatkExovII/qV3NdgZJU9AxwQfzIfRg==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.26; Thu, 4 Jul 2024 20:02:00 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%3]) with mapi id 15.20.7698.025; Thu, 4 Jul 2024
 20:02:00 +0000
From: <Woojung.Huh@microchip.com>
To: <o.rempel@pengutronix.de>
CC: <davem@davemloft.net>, <andrew@lunn.ch>, <edumazet@google.com>,
	<f.fainelli@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<Arun.Ramadoss@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <Yuiko.Oshino@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>,
	<kernel@pengutronix.de>, <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v1 1/1] net: phy: microchip: lan937x: add support
 for 100BaseTX PHY
Thread-Topic: [PATCH net-next v1 1/1] net: phy: microchip: lan937x: add
 support for 100BaseTX PHY
Thread-Index: AQHazhpnRTNboJbIQE2PiY5dbV/LyrHmtZQOgAA4RgCAAA9RUA==
Date: Thu, 4 Jul 2024 20:02:00 +0000
Message-ID: <BL0PR11MB2913A0855BCD3EFF290F8018E7DE2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240704135850.3939342-1-o.rempel@pengutronix.de>
 <BL0PR11MB29132F1C667E478728BCE4ECE7DE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <ZobyTGbbzXlhTBbz@pengutronix.de>
In-Reply-To: <ZobyTGbbzXlhTBbz@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|DM4PR11MB5971:EE_
x-ms-office365-filtering-correlation-id: f276dbce-2f7c-4eca-c8a1-08dc9c642aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K1JXTENQSzZGaldWZ2tDNUtFV3g3djVnZ3VMeVREZnphcG9OT0ZEREFERFp4?=
 =?utf-8?B?SFZ3ZFNkZWQ0QS9kSFp4TW9odzB1RTJENmx3NnZKUXNRcnFhR2RPUDZrVVYr?=
 =?utf-8?B?WkN5d0tES3FTVnFWL0wydTEySUwyWjRaeE00eTZoTHJVd29QM1UvNGdsYzhr?=
 =?utf-8?B?VWhOWCt6YkhzYkdwaitnMCszcUoyK0tZNkVIVE5nMjVxdmZHOEsrVEJXMmM3?=
 =?utf-8?B?VUx4NnZNc2p0Y1RuaHBEeVBsYW13eGFmaFJkaUZnSlpZNjUxbWg2UjFDSGhh?=
 =?utf-8?B?dlBvNENwN1hwR3lsWHdydVpJQU5NdHBpRXlQMmdpQjMyaWthMU50K1JNdGts?=
 =?utf-8?B?ZHlkZU1tSmltTUtGemNrRDBoeWR0UERMUzA1eEl0SHM1TFJOOFZkT1NtNGZQ?=
 =?utf-8?B?QXdZK2JBYXZHc0hJRTJvZVFaU29ZYVVtRXlvOHd1Sno5K3ZRMTQvTVY5UExI?=
 =?utf-8?B?R043RlRDVlU4RU1ENnFGcHZUTDd0SUZTWWFOd2I2NndReUw2RU15U3p3UTN2?=
 =?utf-8?B?eTlmZVl6VndoSGJJUkIxZUhwVFlqWENzQW5RUHRWS2pEaSt6SUh3cWFnNkM0?=
 =?utf-8?B?aThHS1BYb3hIWm1tOUozSUErSGttWWRvcW5FOTlIaGxVdGVzMTVGalB2Q2xn?=
 =?utf-8?B?M3dYaG0yWkpjWFIvZjA2aUpOTjg0bUNyaTNvT05hekhoOXA5UDIrQWxDVWlD?=
 =?utf-8?B?QlB6WDlUYzhyWWJQV2VDcGFab2FyMjdDMm9qdHF3K3gxOGgvZ0hjYzZvYXRZ?=
 =?utf-8?B?U2Yrc0IyOGZEcGlPdXlWZkRBa3Mvb2RpekxldjlNUkp2Ujd3cGxsN2F1ZHJF?=
 =?utf-8?B?QnUwMllNNXVDNXBTTEpjYWlZd1BQdDl2VG11L2M0VDFxaDZoQUYyVDg5M0lt?=
 =?utf-8?B?YXBPcGdGQm9JbHFPWDE2R0Nuc0JkYTMxenRpbE1DLzBWdnlId2Q0N3cwcHpY?=
 =?utf-8?B?OTZGcHE5VUJZbGdMWTBRWENjUStVZ3plVmlQUER4MjFNVGR1S1pDTjNxVDV2?=
 =?utf-8?B?L0x1OFAvUWpHY1JmV0w3by80ZWxib09IbmJTZElEVzBYdUVicXpid25TSzZt?=
 =?utf-8?B?bXgzZ2NOb3RhN2VjM25jMlZtWlA1L0p2N2JsZXlmblRvMG8xc2tXRHFaSFpI?=
 =?utf-8?B?QlJTRC84VS9NUHhINjY3aEo2TkpKSFJnRHd1SjhGYktWVDQ1bm9WSURqdzcw?=
 =?utf-8?B?RjYxdTJHOFJNenVPa25Sc0Z0WnphRjU2UCtub3JpaW5LUkZHb29JR25JdC9o?=
 =?utf-8?B?R0VCU0t1cHFHUldKNmI0RFpBeEFVU1MxcVhLVnFMK252cmxuSnRZN1A5SmJt?=
 =?utf-8?B?MWtER1VSWENGenpJZ2Izbm4yWXRBa00zQjhiblZOdGN3QnlwbzhCRGVlYXdi?=
 =?utf-8?B?TElQTTNxendsQUpNdEh2WmR1THpMaE5VbVRmKzJ4UTg3ZVFhT2pUUVZDOS8v?=
 =?utf-8?B?MDJVZEkzaUNOMzBUV2pnNVdkK0FVUzlrdzRjb0dySGwvWEc5aFlIdkRWVktN?=
 =?utf-8?B?QXRXajNjd1loTVluT0ZmMm5LUlRHTlR4VGRJcmtBWk85UGJhTmVRZEQyMWRL?=
 =?utf-8?B?L0l3b0Y3U1d1MVFhY0IxTEtibng5Z094ZWtWWVBKaHI5UXA0eVk3elZvUlp3?=
 =?utf-8?B?ZlRZdmowZ0dqRzM5QTJXanJQS3Z1NzBOYlJUTmsvMHViQ3dMRGlFYjBxY3Fj?=
 =?utf-8?B?emlXYW56L1dXbHFkVGd6VndWRURIdkgvRWZLSWdxQzhvaWdNTVgyMmYzQVYr?=
 =?utf-8?B?MmFFcXduOWNhb1c4RHdCRnFXRWkrOEdvR3dOMytoV2ZGWndTckwwUXI1SGR1?=
 =?utf-8?B?ZzlXdTJ1VzlZWVUxK1ZjQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3JhSjF5U3BtNEt6SEQrb2V5WW1PYnBNM3dqQldFT1RvV0tRZWpNMDk5OEQ4?=
 =?utf-8?B?c1ZBYlMrWWdZMmVOd29FSmlrODJKdjdCMjhHRytyNEM5SDBZeDZxNzk2eFRx?=
 =?utf-8?B?OXQ4SXYzYThmaEMwQUUyWExuN015djRhNXhkdnc1YzY4Qmt3WjJObnlxVEM0?=
 =?utf-8?B?MlV3eGlmcEtKNFRqMUpDTXk3dzllSmY0M3IrSE9DUzQ0ZG9MSWNwRU1KVzdP?=
 =?utf-8?B?ODc4VGVaWm96RVhoZWE3NFpxUnI4MmJnTElHYTlVZ2lReHd4Si9uaHlCUUxw?=
 =?utf-8?B?V2VRdVE4STNTeGdmM3k5OWcxM3Q0ekJ4bW9SZjRad2dodkc3K284T25wR2xp?=
 =?utf-8?B?dy9rbTkrLzJZc2tTSWphZ0tMUngzcDRDSVdIU21GbXBTMkRxZk90Y0xTd3dH?=
 =?utf-8?B?V0wzMVZRY2hMNjdsZGR4Y1h2RmRUSkFRZXZST1pEMWJxY01oVnRlR2pKQXlv?=
 =?utf-8?B?NVJVQW1HbUtLK0NMYmFodDNMZ3hqM0ZFaVlTd2s2RDNSanEvSGt4TDNlVnpF?=
 =?utf-8?B?MnVCSzdaMTkzTlZxMTZPMEpOV25vL2hheUl4VVNjSXVjU1dOYjJXdFlEMjFh?=
 =?utf-8?B?UFB0Vmc3TU1qZUJDUUtoMnhqWEZSRGMvYjE2QkxmSTBDQUNoNHBrRjREb1Aw?=
 =?utf-8?B?WkFMQXVaNXBSWGQySzJCNGdXNEVRcUg0RjhzQVdDZXdwWFNEazN4ZVg0WFZr?=
 =?utf-8?B?UEJTajNXOFhkY1J4TjdjeVFRU3VJQVNuUHd2bWU5b3R0aENublAzOXY5U0NO?=
 =?utf-8?B?bGhZRS9GRFFxZXNmbUgweFpWZDRuZGdIckd5OC94aUlXdXJMTXNUZDUzcFA0?=
 =?utf-8?B?VUdYYmpUdm9RRTg5d1hZL3hOM3J1Wk9RSkFSREFLblVoMWNlOHB0YzYzcTRR?=
 =?utf-8?B?WlpaUjMvMUw3b0tuKyt4bnJGWitqMUNZRjVRdCtRUGQxMWIzVmJzMnFMM0xE?=
 =?utf-8?B?TS80RXBidzRXUnZMZFlHd0FmZGFScXREbTdjbUg4TFE2S281eE9CZDBTWlVY?=
 =?utf-8?B?eFpWUzQwSmQvbUMwRjRwTTZHbHZjellEY2s3eE9MYXdrVmtUcGxiejBVSFZz?=
 =?utf-8?B?Yzk2cGpYZjVOWkh6d3JEd0E5TUM0R1VPQUxjR2ROYzVibngyVzVIaFhmQXZL?=
 =?utf-8?B?dTJNMG5KMTY5QkNTTVVaZGtnbkw3a1pwT0JvM3JVN3F6b2tGUDVwNWxwK1Vm?=
 =?utf-8?B?cFFjQ2Vvbm56cElZYXMycUdkb0lqZy9UUXFLOWtLd3pycHpMMytSN0trMmQ5?=
 =?utf-8?B?cStYUkRWUWpleFZxeWVDeGhCem9aNTQ3OGxpYmM2aXhBVm4rdzBLZ2xrMSsz?=
 =?utf-8?B?Uy83VTZUcE83ZjVvY3Q4VHZObDBZWGpEUXZ4ZXJ2MHk4eG1GTEVvSnRiWEdS?=
 =?utf-8?B?dHRvdGd3aFZsa1djYW0vc0dHbm4xbHpjbExJNzlkaXZoM0FEZ0Z0Z3dRQThx?=
 =?utf-8?B?WkdUR2ovazJKODZBaFp3dU5LSVJuT0ZLTDFKZStsUUg4RDRUUFpqMGQ0Rks1?=
 =?utf-8?B?dDlTQm92U1paeFZVS1h6U0JkbWhBV2l5RHpGV2xRalJvSWVIOUtjWndHaVVN?=
 =?utf-8?B?SURqOFhqeGRBcnpxczVyUVNtTksxL0k0ckwrZWQ1dW9SUG9qOFNwUlNsMmRY?=
 =?utf-8?B?YUFpMksxZWpWQWdUb2JXTG91Mm9pZ3lad2U0TEQzZkl4YVd5emU0NlRqczJW?=
 =?utf-8?B?OTFoK2RBUUFFUE9WQnhUbUNQRG55NTNWTXZvZWlBUjZtU0xZZFkwdWVxS1Fn?=
 =?utf-8?B?N0QzTXQ1c3ROcjByQlZDMWRBNDY0dC95b1AzbEh0bVJ5Q2J2N3dsYlA5d1V0?=
 =?utf-8?B?Y1AycXlGTU80OXJwYXhWTFdWcUNYSStNbUs5a1ZmSzY0bVU5bVIxdlQwMWRw?=
 =?utf-8?B?UXpVcHNDK1ZpVWJlNVFzcS94R1EycFcrNlhyczdQaWpiNzU1bXhZd3RzYVpV?=
 =?utf-8?B?YWNWVlExemVYZ2RqdzFDYVJEYkt6bTN1a1BZUC9TUmVxSExBQzRJd1hMS0tV?=
 =?utf-8?B?dW5PdE1YME1wdFV3eWVEei9zUlp3LzlUL29uRElUQmc0aFhZY0l3L1dOaVEv?=
 =?utf-8?B?SzhZaERFSTFuT1pZSjlyWWJPeTBTQlRzcGxUbnBLU2plT2tGb3RRYmhYTkhJ?=
 =?utf-8?Q?SQ5t1kUa9e/CG2hC3Zi4Yvx0l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f276dbce-2f7c-4eca-c8a1-08dc9c642aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 20:02:00.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nS0gwZoD58hlfF3gwxBIpfkmc7v/5Wra6LZ9GB90xacV/S42bDotTRM4N/oU+nphs9xxsCfDquxPIhCvXIx1kj26IakiYZzE4TvCJTwtKZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971

SGkgT2xla3NpaiwNCg0KcGh5L21pY3JvY2hpcC5jIHdvdWxkIGJlIGEgZmlsZSBmb3IgdGhpcyAx
MDBCYXNlLVRYIFBIWSBvZiBMQU45Mzd4Lg0KDQpUaGFua3MuDQpXb29qdW5nDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBl
bmd1dHJvbml4LmRlPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSA0LCAyMDI0IDM6MDUgUE0NCj4g
VG86IFdvb2p1bmcgSHVoIC0gQzIxNjk5IDxXb29qdW5nLkh1aEBtaWNyb2NoaXAuY29tPg0KPiBD
YzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgYW5kcmV3QGx1bm4uY2g7IGVkdW1hemV0QGdvb2dsZS5j
b207DQo+IGYuZmFpbmVsbGlAZ21haWwuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRo
YXQuY29tOyBBcnVuIFJhbWFkb3NzDQo+IC0gSTE3NzY5IDxBcnVuLlJhbWFkb3NzQG1pY3JvY2hp
cC5jb20+OyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBZ
dWlrbyBPc2hpbm8gLSBDMTgxNzcNCj4gPFl1aWtvLk9zaGlub0BtaWNyb2NoaXAuY29tPjsgVU5H
TGludXhEcml2ZXINCj4gPFVOR0xpbnV4RHJpdmVyQG1pY3JvY2hpcC5jb20+OyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2MSAxLzFdIG5ldDog
cGh5OiBtaWNyb2NoaXA6IGxhbjkzN3g6IGFkZA0KPiBzdXBwb3J0IGZvciAxMDBCYXNlVFggUEhZ
DQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93DQo+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIFdv
b2p1bmcsDQo+IA0KPiBPbiBUaHUsIEp1bCAwNCwgMjAyNCBhdCAwMzo0NDo1MlBNICswMDAwLCBX
b29qdW5nLkh1aEBtaWNyb2NoaXAuY29tDQo+IHdyb3RlOg0KPiA+IEhpIE9sZWtzaWosDQo+ID4N
Cj4gPiBXZSB1c2UgcGh5L21pY3JvY2hpcF90MS5jIGZvciBUMSBwaHkuIENhbiB5b3UgcGxlYXNl
IHB1dCB0aGUgY2FzZSBpbg0KPiBkaWZmZXJlbnQgcGh5IGRyaXZlciBmaWxlPw0KPiANCj4gV2hp
Y2ggZmlsZSB3b3VsZCB5b3Ugc3VnZ2VzdD8NCj4gDQo+IFJlZ2FyZHMsDQo+IE9sZWtzaWoNCj4g
LS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gfA0K
PiBTdGV1ZXJ3YWxkZXIgU3RyLiAyMSAgICAgICAgICAgICAgICAgICAgICAgfCBodHRwOi8vd3d3
LnBlbmd1dHJvbml4LmRlLw0KPiB8DQo+IDMxMTM3IEhpbGRlc2hlaW0sIEdlcm1hbnkgICAgICAg
ICAgICAgICAgICB8IFBob25lOiArNDktNTEyMS0yMDY5MTctMA0KPiB8DQo+IEFtdHNnZXJpY2h0
IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICAgICAgICAgICB8IEZheDogICArNDktNTEyMS0yMDY5MTct
NTU1NQ0KPiB8DQo=

