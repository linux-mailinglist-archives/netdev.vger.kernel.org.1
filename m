Return-Path: <netdev+bounces-273870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPeEBF+QzGk7UAYAu9opvQ
	(envelope-from <netdev+bounces-273870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:26:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C487374574
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EDF431558A3
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 03:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D235AC36;
	Wed,  1 Apr 2026 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oa67UzjF"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1B1221F2F;
	Wed,  1 Apr 2026 03:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013488; cv=fail; b=VksAwcBCqm9MxMdENFXowUql5BdMIvguopQC1la/fLvoE7a+ENIkOF6rPVUoJxxB8eEhOEdzlIsjHRLKOlUdBuMC+2sivD30/aq0RRXKuF4DOhHZPwaJIIAPbLt33J/NgTWKh7gYT+chBXLrf70moeXif1DQbVa/L/WFBymKTek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013488; c=relaxed/simple;
	bh=Lx0sYs4vCB1OP0x6AgjQzkjjXSI0xeloMLUHXdGU/vk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I/jmR3kWi51Kbxn6VyR7nd80dAz7ppXAsTITgIV7MuiVdMrN3Mj8JVELW7IR8HsmJQ52AFcvU3bylgDWfY+67pEJqdAHWrOMHwxNDkdjL4ortkKbw+rQtpgNaV7FiSxecli9o+kvBWiFeMxBTa8Wbnj8h0GLB79NI2jYolbrcsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oa67UzjF; arc=fail smtp.client-ip=40.93.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uktu22BS0xs/AlQqKAxAvk6gGL53Q5wKJWZ+X4zoYH6PuHyXw7YxMjvhsiqRQhc7IWGKlxvvk8lGcSGQOPff5V2JECZ6h59tURxK2DEsxECWgLGVN8TFTFg8LsTd01v4TosLlCmrzPAp4Mcbio6zZIH6N5ivg+4W4oZCdQFfg3zcnhVibT0COHzQ/ECg2zB2HiBlYmgMSnEPiLjkaP8wrXkllZ20FvjIaW8a6r8j6mml7q/DU6fyk/rvnFQlGBvd+BTjmUYAcVolU+H43uCdEtMiZN4A2pWzneHR2Z7l4PtFnLzY5JVV+AlrMz4Dfx4pTljU85W9AXwZLPJ1QKI93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx0sYs4vCB1OP0x6AgjQzkjjXSI0xeloMLUHXdGU/vk=;
 b=DFGZD3dBlgtv216692TUhazR65A6p+1sBAMz1+PoYfF/xW09Yz16qSODkqLiYPdn5zHEjZtePyU8RBlUHJaanAAHnJ0UAw/UJhMPUPHc3j4hW1145raxD80yF0EySZVBNqHrAEDtCIWHCSl6IW2WPiCor8L06c8DyCVN2azq4n2RGDbto2tsO69EM0GcjsxRyhxsrWC35ZfQom4f98J84vyyOcvTfjgPStC3KmFDisms+knFdcZIMX11hN75DAKCi7F0U9kbF8PcZcu0NY1Vh9TcMjtJrCswe2DEaW8Oa+dPNSrT0AB+bCKRLlbcpWD8gDefu/GLIMpjC4jDz50tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx0sYs4vCB1OP0x6AgjQzkjjXSI0xeloMLUHXdGU/vk=;
 b=oa67UzjFnbsvmJGYBgB9ThiKi2i+yQwMNhxMsNU6gkwp1qexF72z2O1QhdtkgnyOne4xrqr03ZjZHRtikkSt0w0Wtbz71zgutkYzykkp8E6vWkXXHKa0Rf6cSOUfU8rM0dzIwcUDW6Rnxp7SdUwCZVsWguddmzN8L9YPB9Ah3yKQVkj3ZLhORFjFQlYjM0qi1wwUbkpnaBZ5HGVXseh0Mt3jmNgwK1PyN0NsDbilfS/C3FGjSGueYRFHJlhZvSwIArtRz00lIAw2KI7NkWbQhw028gyCk8jUQ5DuB7HJKvrGfChS87W4D1Km32bS9XICHgFnBSgt5kNeNP7SxiTElw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH3PPFD01EAC3BA.namprd11.prod.outlook.com (2603:10b6:518:1::d4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Wed, 1 Apr
 2026 03:18:03 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 03:18:03 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <oneukum@suse.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<piergiorgio.beruto@gmail.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <steve.glendinning@shawell.net>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next 3/3] net: usb: smsc95xx: suspend PHY during USB
 suspend
Thread-Topic: [PATCH net-next 3/3] net: usb: smsc95xx: suspend PHY during USB
 suspend
Thread-Index: AQHcwEsZPbqT+3/6KkKOeVqXzFK8F7XHV8sAgAIz64A=
Date: Wed, 1 Apr 2026 03:18:03 +0000
Message-ID: <2e9bc390-c870-46a3-b673-c7cdb5187cc3@microchip.com>
References: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
 <20260330134222.67597-4-parthiban.veerasooran@microchip.com>
 <1c660862-de30-428d-a772-8bee9b990a59@suse.com>
In-Reply-To: <1c660862-de30-428d-a772-8bee9b990a59@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH3PPFD01EAC3BA:EE_
x-ms-office365-filtering-correlation-id: ff2245ab-c400-4e3e-e3e9-08de8f9d494e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 6kl4C4fOnMjVrZYI8ckiDQLbX3drsmYKleAHK4a952u7ojiWNbDn3sBTrwap9H2OJwfcz8z4zu+S/60UI7janKM9n+g+dwjxDSQixMjs5hEzDLCb+9Zviufn8guW9ptL6eiC+dHwDIiK4Tmqg4GfxeugSR1uyzuWAYwZZZBxqetZ6DCohfs5VK7G6Q1WhQLyMB3bJ7385OlOziPYJwlfcdwB86wgKPsREZhPsEPX8Fvbo5VPjEJqqQTZG/IjTGEB2+/XADbbiqTwRlWza2vOWzVGy3Q/kgxJCzObTgr9oD+KKzZJY/kG9MWvEtP/5NlVeyHzxpFATWE8ySLmbKoHZZ2ct6OOBLpwK6jYhULStbrwVdGU6EnEld8VZX/P73AhBv1KTIgtHTsjIFluEPUcqq7HwsQj+gkvqY1ZO/Gcf3pPv/tJFLIzT4VIjoVh6KccgjIrIYwbrXskPhMOaVoCihFNDizTteGfNjJAZjvYetXbCUCPYU+z3/MJEu3yiI28vOOeYGHviY9vo2+n1cVJssOnpavDlQsJn8q2UYkacdW+OCj+nM7lhyyNP452eWaJunEx4Derxl+TfNuWnVUZZwo2/w4LWjz4KDYONdu31prv1jyGixT5IOnyV/T06dx7hjTXfnVQvaRJvDanugf0KbQUbaXLtFJ0/0LjBn//qPq+qddnkt8lYVajHlOw0p704EYxWxSfCcWkcS2xwc1yaoFokwR/0YyauUmsRnZMFlPMxnEE5LVSj7ivWMm+YP9LxGBXXDOJ+xVkA6hSjcPKPLBNjWIVdcY7UjWVI/CQyyM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmFaS0p1TjE1VFJ5bXFuZEFWdys2UE9oQU85S2dOdHpNVm1PSXJUazlBOUpS?=
 =?utf-8?B?UExsVHMrbXA3YktaUDZWVkxtQXh0TUZtWWVsd1VYS0JOZmJYaEFjRm9vRkl6?=
 =?utf-8?B?TWN4VWpBOXUxNmwwdWZSM29ZOWJKN1VHc1lzZFl3Y3JNK3NheGNVZXllYUdJ?=
 =?utf-8?B?WHYwcWlPTGZxVjJ1WDFBM1J1UFpaWXg0b2tyQlRhK3NmN09ydjV1MDJ5d1h0?=
 =?utf-8?B?R296MkpXUG1mYkpYZWpGLytOelVLWTdGNytYY1ZsWVllcG5mSGt0c0VjMHA2?=
 =?utf-8?B?TFVHb2dRa29McWdKa21selMrblpzdStiTGxMUmYrT2hIYnp3cjZvWWdESFFK?=
 =?utf-8?B?RkI2bmJEZWxqeFlYMm5rdkRBM0dVMWJEeHdiMzJuMHVCcXpVWmhrRDNKSUVH?=
 =?utf-8?B?c3F3Zk1kWUpGdTdkNnk3OVJHaWVGclM0VnM5R0pJZ2dRWE90NXVtbGpodmpW?=
 =?utf-8?B?RzBOd2xnSUd2UmZsUDZKVmdtS2ZtMGpCWGJpU01lZ1FKeGFxTnY2UW1nMVgr?=
 =?utf-8?B?MnNOTzV0V0p1UDVJYlRwZEJ6eEtnN0ZCWDhiT1N1Z3hBM3dDVUplbXNEYk8x?=
 =?utf-8?B?WVFXSTV6WGRObjI3Q2k2VTBpZFJWOWxZaDBQUzBrWVBzdGtjR2hkc0hURlVr?=
 =?utf-8?B?eFg3ZnRFdUNiMmFvMTBHeSs1KzVTeXRVazVubXdHU1ZxbnBwL2dzdGIrdTJw?=
 =?utf-8?B?ek5meGgwT05nb1ljVjF5dk9KZFpBYnczSTVRYkxHZUcrbW11US94WjlFSlFS?=
 =?utf-8?B?K3B3VGJ6K1g2MUFNWDU1S0pNS2t6d1pHM2dCR0RzT2ZjZ0RuSndrbGNHUWVa?=
 =?utf-8?B?RlZpdGZSdmVMajZ2V3NBNE8vU051NDNVN0MxMmorUlE2NGlLSzVGMThtMnFv?=
 =?utf-8?B?WjV0SGVIMkxpM29aVDA3UHRpMkZvTHU1Z0IxZURCQU1LVEVPdWlmTHFHVTBP?=
 =?utf-8?B?L1FEYmU3ekxudDRsaHQ1UVNEZTFIbHZiZlVqZDJaeC81ZHhlOWlLamlsUHFi?=
 =?utf-8?B?RjlmaU9rYUwzUFZRRUJnMk1SQkdnUHg2d3cwMHM3V2Y2NnhrOGJxeitiTW8y?=
 =?utf-8?B?eXlKcWhWTXBvVFFCL2dBNyt3SVBubWJyVlUwanhXWWx1UFc2ZjZFSDZ1cjFY?=
 =?utf-8?B?NVhzY0J4ZVp3VzJVNVEyWHlhWWlUUVkxcC92UkltMFVuTStyZC9Fbk03bFV3?=
 =?utf-8?B?VlZZazB4blViUTMyc0JsWk5mUngvOFhUK29DZ2dveHR1YU1GRjNNR2xxTEZ0?=
 =?utf-8?B?emd5NFhmN0g0Z2x3SENiV3NidGQ2N0IwRUVpbU05MjhESlpVSGZpT1Zpbjl1?=
 =?utf-8?B?b1FKNmMvZS85TXVvZHdzdmlYTkptclBtN0h1NUwySGRWZlp0K1RCTXcrZVpL?=
 =?utf-8?B?UFJLUDhzUVN3SGIydE1pNDlMM0thVUl4VnJKU2tKZ3YvWUVOeGd3NmZkbVoy?=
 =?utf-8?B?M1lVNExNZ0RNVXkxMzM2TE8xZVVVeUpUTWV2Zk1pUXZzdXordkNuaTBaUWdl?=
 =?utf-8?B?c2JUOEJNMVo4ZXFCZUJQbnV1YzVOTFNvbDdJcnlQYXZDd0ExSmtmUDlaN2VK?=
 =?utf-8?B?bHBVVHdCbE5aRzNtN0JNeTVma28rZWNHV2dGUCs4VnVkVFhpTjB1eENXVzZD?=
 =?utf-8?B?d09BQVd2NHArVnc3cjJoUjlrbE8xdSszQUNSZkdZYUdHdWJqNHdSK29WMFFT?=
 =?utf-8?B?OXVNS1FZdW1uMUt4RzZ5NnViTHZKRnc4ODBzbXJwUjZpcXBNSExFVmZ2UWFK?=
 =?utf-8?B?ZVkrUThFTkVSUVcvSGhxUytCZ3BpNXQ5Z2tXTFJOSjVvcHE2c2ZONlNjTzBi?=
 =?utf-8?B?MGdpVzk4YWpIdHFnMU0vQnh0UnpFeVFnRGVURnk2UVNKMFpxR0F5ZHFEVzUw?=
 =?utf-8?B?bXdML0YyVkw2RzJNTHQ5d0loVFFJa3VYeEJGeEZ0dDBMRGxkbCt5V2Q3REow?=
 =?utf-8?B?UUlyQ0ZMaDl4YmJ5MFZOZ0lvR0tlSWVhaWN3SWF6N2FxZ1pBMXpoUUk2TE5p?=
 =?utf-8?B?WXdpSmdadDVZTzdTcDFmL1ZZeUJZNmdvZVRXdndjUHdpVFFiU1BKVnIxY2JM?=
 =?utf-8?B?enNGM2s0WEFEM3lYRVJxdFd3YkRSVEFKOFpkWXBoTWdLQi9PbTNsTS9MR1Rw?=
 =?utf-8?B?Q01nNTdVYXBSVTFkelhTS1ZZeHU3TDU3aHBXYjJyeE5ZYlFvR01UR09oMkNa?=
 =?utf-8?B?bE5jelMyVWMrdlA3WFpIdUZ4ci9aYit5UmVhNHJLL3NXZDJKM1QzQTdyOTVB?=
 =?utf-8?B?TXhEejZZRGVNNEl2MFkzWFFFZ0VPUnp5ZzlIaE9LSGYweWEzL0hNckt0QVVZ?=
 =?utf-8?B?RWxQSWo4dnZRbXZRK2Y4WWJxY0RFWEVjclBsNC9GVjFpK1lDMEJaOVgyZGVJ?=
 =?utf-8?Q?+Ancl8pQefpQnuAs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C34978354A85BC47966BED9828D3F4F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2245ab-c400-4e3e-e3e9-08de8f9d494e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 03:18:03.3933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMz56UpsGaeIMPclC2W5U7ngmVkA7Deyz4C+PKIVJTK89/o5km0U4wDQAz4iF1f/pOlk+zqxnqKDK2fazgWvgFyReXbDCnz0Vpsc4ZF3e9jJig0hWhX0gPqY/O/SY/AE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD01EAC3BA
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273870-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,shawell.net,microchip.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Queue-Id: 6C487374574
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgT2xpdmVyDQoNClRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaC4NCg0KT24gMzAv
MDMvMjYgMTE6MDkgcG0sIE9saXZlciBOZXVrdW0gd3JvdGU6DQo+PiBAQCAtMTU1MCw2ICsxNTUw
LDEyIEBAIHN0YXRpYyBpbnQgc21zYzk1eHhfc3VzcGVuZChzdHJ1Y3QgDQo+PiB1c2JfaW50ZXJm
YWNlICppbnRmLCBwbV9tZXNzYWdlX3QgbWVzc2FnZSkNCj4+DQo+PiDCoMKgwqDCoMKgIHBkYXRh
LT5wbV90YXNrID0gY3VycmVudDsNCj4+DQo+PiArwqDCoMKgwqAgaWYgKHBkYXRhLT5waHlkZXYp
IHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gcGh5X3N1c3BlbmQocGRhdGEt
PnBoeWRldik7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4gK8Kg
wqDCoMKgIH0NCj4gDQo+IEF0IHRoaXMgcG9pbnQgeW91IGhhdmUgc3VzcGVuZGVkIHRoZSBwaHku
DQo+IEhlbmNlIHRoZSBkZXZpY2UgY2FuIG5vIGxvbmdlciB0cmFuc21pdA0KPiANCj4+ICsNCj4+
IMKgwqDCoMKgwqAgcmV0ID0gdXNibmV0X3N1c3BlbmQoaW50ZiwgbWVzc2FnZSk7DQo+IA0KPiBU
aGlzIHdhbnRzIHRvDQo+IA0KPiAxLiBkcmFpbiB0aGUgcXVldWUgaWYgeW91IGRvIHJ1bnRpbWUg
UE0NCj4gMi4gY2FuIHJldHVybiAtRUJVU1kNCj4gDQo+PiDCoMKgwqDCoMKgIGlmIChyZXQgPCAw
KSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXRkZXZfd2FybihkZXYtPm5ldCwg
InVzYm5ldF9zdXNwZW5kIGVycm9yXG4iKTsNCj4gDQo+IEFuZCBoZXJlIGl0IHdpbGwgcmV0dXJu
IGluIHRoZSBlcnJvciBjYXNlLiBXaXRoIHRoZSBwaHkNCj4gYWxyZWFkeSBzdXNwZW5kZWQuDQoN
ClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgaXQgb3V0LiBJIGFncmVlIHdpdGggeW91LiBJIGRpZG7i
gJl0IG5vdGUgaXQgDQplYXJsaWVyIHNpbmNlIHRoZSBpc3N1ZSBkaWQgbm90IG9jY3VyIGR1cmlu
ZyBteSB0ZXN0aW5nLiBJIHdpbGwgbW92ZSB0aGUgDQpwaHlfc3VzcGVuZCgpIHRvIHRoZSBhcHBy
b3ByaWF0ZSBwbGFjZS4NCg0KPiANCj4gQW5kLCBhcyBhIHF1ZXN0aW9uIG9mIHByaW5jaXBsZTog
V2h5IGRvIHlvdSBzdXNwZW5kIHRoZSBwaHkNCj4gaW4gc3VzcGVuZCgpLCBidXQgdGFrZSBubyBh
Y3Rpb24gaW4gcmVzdW1lKCk/DQoNCkluIHJlc3VtZSgpLCBJIGRpZCBub3QgY2FsbCBwaHlfcmVz
dW1lKCkgYmVjYXVzZSB0aGUgcmVzdW1lIHBhdGggYWxyZWFkeSANCmludm9rZXMgcGh5X2luaXRf
aHcoKSwgd2hpY2ggaW50ZXJuYWxseSBjYWxscyANCnBoeWRldi0+ZHJ2LT5jb25maWdfaW5pdCgp
LiBUaGlzIHJlaW5pdGlhbGl6ZXMgYW5kIHJlY29uZmlndXJlcyB0aGUgUEhZLiANClRoaXMgaXMg
dGhlIHJlYXNvbiB3aHkgSSBkaWRuJ3QgY2FsbCBwaHlfcmVzdW1lKCkuIElmIHRoZXJlIGlzIGEg
DQpwcmVmZXJlbmNlIG9yIGV4cGVjdGF0aW9uIHRvIHVzZSBwaHlfcmVzdW1lKCkgZm9yIHN5bW1l
dHJ5IG9yIHRvIGJldHRlciANCmFsaWduIHdpdGggdGhlIFBIWSBmcmFtZXdvcmvigJlzIHN1c3Bl
bmQvcmVzdW1lIHNlbWFudGljcywgSeKAmW0gaGFwcHkgdG8gDQp1cGRhdGUgdGhlIGNvZGUgYWNj
b3JkaW5nbHkuDQoNCk1vcmVvdmVyIEkgd2lsbCByZXZpc2l0IHRoZSBpbXBsZW1lbnRhdGlvbiB3
aXRoIGludGVybmFsIHJldmlldyBhbmQgdGhlbiANCnBvc3QgdGhlIG5leHQgdmVyc2lvbi4gVGhh
bmsgeW91IGZvciB5b3VyIHN1cHBvcnQuDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+
IA0KPiAgwqDCoMKgwqDCoMKgIFJlZ2FyZHMNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgT2xpdmVyDQo+IA0KPiANCg0K

