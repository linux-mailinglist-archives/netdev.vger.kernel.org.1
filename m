Return-Path: <netdev+bounces-304383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MN2wNLReR2qmXAAAu9opvQ
	(envelope-from <netdev+bounces-304383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:03:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F76FF568
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:03:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=swjjrzeK;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304383-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304383-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC077300B980
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C42357D02;
	Fri,  3 Jul 2026 07:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3C3019AA
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 07:02:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062154; cv=fail; b=ATE7mU0nt/eFvVm+0wEiyg0nE6cmVaoZDlO2SPRFGhi2Jbj4U4VJFRimb7BO3KeGEqK4xOWU5JjFsBvV1rMJlCAHlR5muuIsqvDvFMoPjrBw0tJQDJat2yCS5nBa7m5gsbtVRM5uI7i7DB7pf/OLdOiZRuNZ55TP96T0CWOYdyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062154; c=relaxed/simple;
	bh=e86GEBP5hyWV/XAUVr7CL0qjc62sSNzwyhULw4QyLlM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZUUdOQZs+UwPJbrTTdMN+PvXIm0qveFchE6f86CqpeMw6Ifunra4UiKJxeNbFqRsSb9OCcHTS3ldKX/OLck/CzusF2Ivb18UcAf2MD9QvKhG2L1J7N4eFJY4zJDARTM0LKemWkYds9kocJ3wsvUoaPFbUz5Aw/UJ1EZ6DOYjys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=swjjrzeK; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFeztrrQCsA4Xz47HMrWz6GQchI0p9wgWybxiZTMO7mnacz7duEmqaufOuFb1CfuVPFFj7e0Kje+AgPI8Z9VcevmgIXHuPDCPjCCDNGtsavfk+FqxOrQ+MSdi3gMyAUNXDlTGKNAOR8ueANFzjtPDsSKp0XYiRwfCvg2n36inXb/dbFtMf/9UVRE/gtnQkTVIEFhgL0cUdzOnIpanXolNvg3keGqB/fAmmUHhKLBoEyM42bTwzOiMCqAd3wkMuGS3zGYxMdlf+92homYLHkr6WXHsW6em348BvlWLS7ZbKEtrM+b2jUTQHfFvFlwFy0JVa/cLJtMN+O6G6UNr1R2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e86GEBP5hyWV/XAUVr7CL0qjc62sSNzwyhULw4QyLlM=;
 b=GzPsoKZv2PVpf95oLQEKFYNICbbi9U2Ml3hS5x1V1xySiaaxVBRCXyy9bSfzbY0EMyLhlE4UaNsGFHmbD1hF8sckOonVw0UuHvRmg9F0FFXFxIor6KHbQLAhE26mbtqaVhiUKCfM8QhDCK/GgHhi5UGMhpzGq7oclj6FAqVxrWfvsjXBabpArg7F81YP+j++Ov+o4HeJLQZuzJJ8Ir519UOpIe5hnqQiULzW1TkAHC7r7E3ppPhAKL+sEPy6Elg9txTIyQI9ehXsW6EfixBj4rocm+iSeLlrCEivGBFu0EKVvHWwye13KbJk/6Sy2zZCthcFzv01aterJyjWrOQkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e86GEBP5hyWV/XAUVr7CL0qjc62sSNzwyhULw4QyLlM=;
 b=swjjrzeKPTrllIjxuIxftms9TAGv/jOwpTne7Y/T03zhMPZUQrWICWqpYa9x0aYgv7db+431ZTVlzBojRIzlRav3zuoZ0EF1YAhSEO85YX9ERPhDWJEfJUidPH5I8iSm2SoPUs7moorMiP3MuJTDr3+ugBasK8rUMH8UOpzJgXYUgX1RXgCeHHjs0oFeGyiLr15vzvdGFfpIRhTOky7hZUCM9UBT9gr3nYBHHi0QReZQUTPyv+J0XNBObh30gZNRIIVqxAWufDFXGEnDCnIvfVDNoLrmt7I/qo9ygNKfpKwC/bHXriCuZV4kIrA/QLcU3C9yexfxPxWruhtcaq0mvw==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by AM9PR04MB8098.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 07:02:28 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 07:02:28 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 02/14] net: enetc: extract common helpers for
 MAC hash filter configuration
Thread-Topic: [PATCH v2 net-next 02/14] net: enetc: extract common helpers for
 MAC hash filter configuration
Thread-Index: AQHdCdJscQ7yQ+nFnkeMdV2GJPpe1LZbI/qAgAA8LzA=
Date: Fri, 3 Jul 2026 07:02:28 +0000
Message-ID:
 <DU2PR04MB862909648244773F8898068E88F42@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
 <20260702025714.456233-3-wei.fang@oss.nxp.com>
 <20260703032702.231E51F000E9@smtp.kernel.org>
In-Reply-To: <20260703032702.231E51F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|AM9PR04MB8098:EE_
x-ms-office365-filtering-correlation-id: 1fb5dd89-4f95-4067-15df-08ded8d10b74
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|19092799006|1800799024|376014|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 HQGn3V+LHOBczJ2lMsSiijk6nik16qozhtV1erOKgeGq+vTSeeIXDKVbUv43BQrlhIpmhg77+MHBrucBLvBtUlys3Us9qFQE1AuR9ku5Ce6kMbkWkVI7dAS3b4JdoAwABlNUOUhqLvDr+dDmsFBNvT/6Oo/1SsCJsq9Vk8n6PmcbghmSCmIVEgH71+PIrKh9OhUHf5CV6ZOKfpbQ1em3P1PGuK/aUDs50S5+QzwR6TVPm3ngN5XJAtRBUGN+Nk/ml0RD6ehQ/9Egyw45wrIiaDRMSZMBqBYpceZf+CZAjSLF6sRSh+1l0DwmbFGdSFZmSKQ6HnkkNff5Q1vKKnWPuBmlCybS82nqKtZmQcI+ruQejPIIcvKUY95FAKopcyIUNZPz/B8nzzNS2qxR5YtgnZI66jos9TTlhKcAZnFylJZmjJ6puv8OSZcAUKEYqPMX4EKhZ5JuN2tgStMMRZ322t6DLG+FV+NIOmpC4aDqIwJcpP3Qv8/0H8ewoyABQ0JC8NS8Bnxyza+fq7+4JrNU7BrXX6ZWSe8K7ImD10uEaNlYPbTdupKwIk5prAr4720+davDPPOc7S7TFP2xOQkXuIstaaNuI1esc9QuO9qV+4MHey77BJthJnfPYi2NXpN1khzh+ID4ECMoYht1lZWpvTPrs9WbiUSBm4DYFbWGa7ba7W8BJ3Xf/AFNnNnl4nvFC6dKRg2XuLNfJ6cY3HZdgBO8ewxUOOGlx59TdoNCjq8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWxZdkpUOE02L29mNndMQ0FGMVRWTFNpVEw0SHVBc3UxczJVNVRaREVjM0Rv?=
 =?utf-8?B?Q1dPYytNN2lteHpLMHQ2VzBwM2NUMExyMUlSYmZYcUFNbXE0THBDN0ZYeWg2?=
 =?utf-8?B?UDVyZ2dVSjk4dHhiM0JqSFY2dnUwYTNUaVN1YUQ1ZXA4K0VWa1NKQTdEWHk2?=
 =?utf-8?B?aWl5M2ExcnM5ZkRBWWlxYTVZcDFVSFp4S3BzMVhldzZLR3hiMkJWYTFySXV2?=
 =?utf-8?B?QzlUVFhrc0tMbmpuaTh1QVlNRzRBR1JrU1ZuV3JVaGd4TFJpWjZiQ0V3U1I4?=
 =?utf-8?B?dERlam03WFZHTU1NNmQxclNtY2k3RGtiQ0dxZjVKaVU3SEpEdDM3cURiSGJN?=
 =?utf-8?B?WUZLYUs1ZFFrcDVYWmNMZzZoUCthL2pxcmd1b0wrQ09qRlA0Ny82WWZjeHFi?=
 =?utf-8?B?QzdXZHY0a0FOenVmR0VjQUErQ0FGZ28rVUo3ZHF3bmVNTmtZejZETThNbU56?=
 =?utf-8?B?N2RhQnVXM3hEcEpFUUpjRHRPRzBnbG5Pd3Z1RXZiZUVqN2pMZlpFYmJ6MEt5?=
 =?utf-8?B?R29vMlVHRXlzYnJBcTFPZ3RrL2xPZlZuMElOU0J2Zk5hT2p3MWxQQlRDU0VQ?=
 =?utf-8?B?OGxqaXZ4ZjRNa1g2QTVJekEzVmlQSEVmRjM1VTlHQ3c2REFITDk0MjFHbzNK?=
 =?utf-8?B?ZzBDTkN0ajVCTzV2RnF3bkdUUHpCRUcvTmt2Y2dsdGV4eC9aZmpuV29jQWdp?=
 =?utf-8?B?UzBSNjZKSExHYWxpNCs0NGxNc1VVV0hPR1BkNVZuMTRkamRpcFhwT3ZoSmZW?=
 =?utf-8?B?RlpGUEhlZC8vL1FBMFRnMHNTbnJ4Q1dFdU9hSmtSNjQ2WDJ5UXdPRnp0OEhp?=
 =?utf-8?B?N1hCWjhDa3BQZmthcWlUc1NEMVNER3ZRUXN1bSthTnVUbVVmYWlDdlJRckk5?=
 =?utf-8?B?VmVKZ1dnUW9xT1BMZFVJK2sybHY0Nkd1bnhLeEJjbmw5NFdEY0V5Rld4NUxl?=
 =?utf-8?B?NHp2UUtCNHFvVlFQZmtWQlUwbVFhOUZGZUk2Y1VJL1Q4N2VCdXZzMEkrWGVT?=
 =?utf-8?B?b3BYV1JleEVicTlXRmZnc1I1OEp3UnUydnh6MlRoMmZ4MnBZcElpbnFPdGpy?=
 =?utf-8?B?ZFhkOXl0cy9LeDZrNTJ5VDRWWWNXSmZvYmYyTWFzOWlBSXpZZkxFb2VKMUcy?=
 =?utf-8?B?bWZiOGJGL011clJua3ZvOFBNYWJ2OWdEa2t5VEhNdzdDM2RocHJaZXFYcWZa?=
 =?utf-8?B?eHEvODJaY1AyTlUxVzBMbEZtZ3h1QzlZeGl0Vm1RdWIvSzViY0x2bWl5TWlV?=
 =?utf-8?B?d255K1ZWRkV0MGhoUVc2M3phUndDMjNmWW03L3UwdU01d1hJOUtJT0MwS2pX?=
 =?utf-8?B?RHkyVW10TlZxNnpGaWFhZy9tL3o3U0daMnVtcEU2Um1ydmlQVE0yQ0hTN2V2?=
 =?utf-8?B?aUU0TkUxMDZhTEthTVdaV21zeUZPd1MwUHZDL0xCOEdSTDdCeExzYmpqdjgv?=
 =?utf-8?B?ajFXbFpMS01Ea2J6K243bHBpdHJiZnlIVVVXQ3gzNUk4Q2Zpb2xpOHo1elF0?=
 =?utf-8?B?ak0xN29tUlFodGQrazZ0TDdOaU12TFc5N1VraUxkUWZkdFc2S3dOcndBZUxl?=
 =?utf-8?B?c3hIaDgyQkt3SzZJcDh2WDBDWG5YOUtaU25NTlRjMlNwNExSR2JIcWhGTGpp?=
 =?utf-8?B?YlpCYjl5UzFsdTlMb0tpU25iSHNTUWZFZXk1cWE3OGdNNkxKYkZPNXdlMXZv?=
 =?utf-8?B?UUxLUHl6bEw3TjVRSzd6eVZPVTJranF3Um80aHB0TTBCQXRQUlhBTnpzdFA1?=
 =?utf-8?B?YnF3R295QW95MFVWa3dsSUlQYTlxODFkTDRwaEtyM0dqOFE3QSs3SFJKZGZr?=
 =?utf-8?B?eVhraHAzbU1vcHYxRjRHbElmYktubUFic0R4T0o3VUtsNUtJcUkyWmxCaXBw?=
 =?utf-8?B?SW5sSVphNGtYN292b1dYd1NOU3FZVE0yamJKTU9qcHlpZmpyMnYxU0t1S0pI?=
 =?utf-8?B?bFJJZG8zM1Rjam9JQ1pPT2JGcGE5Nmd0eEIzQk1XL2hXL2o1NlVYZFBzOUQx?=
 =?utf-8?B?T0RIWFd6TE90ZGRTUS8zditIQ3hDWVFUYUt3aUhwNC92RFB3M3NhckRlSkdj?=
 =?utf-8?B?aVlOcHRHRmQ5THpWSXUzaGVLRnFZWDVrMlFnZ21nNXlZTCtWMmRmL1IwYVJV?=
 =?utf-8?B?ZGthVEdXK0p1cGZ4MzlrM2RKY21CSStVcTRORkdpQ0ZGdjRsTU9BQndDVGx1?=
 =?utf-8?B?azdEVDAzWTdzc1M2cnp4VUs3THNaNDJwcVVZbHN5ZW1jREw1VEtPTWJqcThD?=
 =?utf-8?B?WjgyZmN2cUlqS0orK0o3SUNHWkNpUXZ0Tk5QdEowRFBHY2o5UXh5UTdpMTBu?=
 =?utf-8?Q?pynyfDJNJ5HfZOc9IE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb5dd89-4f95-4067-15df-08ded8d10b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 07:02:28.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pu4mFFwD8sNcbYpySHfscFInl9rR3A2s1OgFVVJos7lKsN07mvqWMoSR/XpRtfgvFkmLHx1sp+cnYziEoYkG0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8098
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-304383-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 355F76FF568

PiBjb21taXQgMDM3M2IzMWFiNGU3YTBiZWI4NDYxZDVjZWIwNWUwOWQ3ZDViNjFhYg0KPiBBdXRo
b3I6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBEYXRlOiAgIFRodSBKdWwgMiAwMjo1
NzowMiAyMDI2ICswMDAwDQo+IA0KPiBuZXQ6IGVuZXRjOiBleHRyYWN0IGNvbW1vbiBoZWxwZXJz
IGZvciBNQUMgaGFzaCBmaWx0ZXIgY29uZmlndXJhdGlvbg0KPiANCj4gVGhlIHBhdGNoIGV4dHJh
Y3RzIGVuZXRjX3NldF9zaV91Y19oYXNoX2ZpbHRlcigpIGFuZA0KPiBlbmV0Y19zZXRfc2lfbWNf
aGFzaF9maWx0ZXIoKSBpbnRvIGVuZXRjX3BmX2NvbW1vbi5jLiBUaGlzIGFsbG93cyBzaGFyaW5n
DQo+IHRoZSBNQUMgaGFzaCBmaWx0ZXIgY29uZmlndXJhdGlvbiBiZXR3ZWVuIEVORVRDIHYxIGFu
ZCB2NCBkcml2ZXJzLCBhbmQNCj4gcmVtb3ZlcyByZWR1bmRhbnQgaGFyZHdhcmUtc3BlY2lmaWMg
ZnVuY3Rpb25zLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJl
ZXNjYWxlL2VuZXRjL2VuZXRjX3BmLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2Nh
bGUvZW5ldGMvZW5ldGNfcGYuYw0KPiA+IGluZGV4IGE5N2QyZTJkZDA3YjcuLmRiMmE4MDBhN2Fh
ZjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRj
L2VuZXRjX3BmLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5l
dGMvZW5ldGNfcGYuYw0KPiBbIC4uLiBdDQo+ID4gQEAgLTEzNSw3ICsxMDgsNyBAQCBzdGF0aWMg
dm9pZCBlbmV0Y19zeW5jX21hY19maWx0ZXJzKHN0cnVjdCBlbmV0Y19wZg0KPiAqcGYpDQo+ID4g
IAkJaWYgKGVtKSB7DQo+ID4gIAkJCWludCBlcnI7DQo+ID4NCj4gPiAtCQkJZW5ldGNfY2xlYXJf
bWFjX2h0X2ZsdChzaSwgMCwgVUMpOw0KPiA+ICsJCQllbmV0Y19zZXRfc2lfdWNfaGFzaF9maWx0
ZXIoc2ksIDAsIDApOw0KPiA+DQo+ID4gIAkJCWVyciA9IGVuZXRjX3NldF9tYWNfZmx0X2VudHJ5
KHNpLCBwb3MsIGYtPm1hY19hZGRyLA0KPiA+ICAJCQkJCQkgICAgICBCSVQoMCkpOw0KPiA+IEBA
IC0xNDcsMTEgKzEyMCwxNSBAQCBzdGF0aWMgdm9pZCBlbmV0Y19zeW5jX21hY19maWx0ZXJzKHN0
cnVjdCBlbmV0Y19wZg0KPiAqcGYpDQo+ID4gIAkJCQkgZXJyKTsNCj4gPiAgCQl9DQo+ID4NCj4g
PiArCQliaXRtYXBfdG9fYXJyNjQoJmhhc2gsIGYtPm1hY19oYXNoX3RhYmxlLA0KPiA+ICsJCQkJ
RU5FVENfTUFERFJfSEFTSF9UQkxfU1opOw0KPiA+ICAJCS8qIGhhc2ggdGFibGUgZmlsdGVyLCBj
bGVhciBFTSBmaWx0ZXIgZm9yIFVDIGVudHJpZXMgKi8NCj4gPiAtCQlpZiAoaSA9PSBVQykNCj4g
PiArCQlpZiAoaSA9PSBVQykgew0KPiA+ICAJCQllbmV0Y19jbGVhcl9tYWNfZmx0X2VudHJ5KHNp
LCBwb3MpOw0KPiA+IC0NCj4gPiAtCQllbmV0Y19zZXRfbWFjX2h0X2ZsdChzaSwgMCwgaSwgKmYt
Pm1hY19oYXNoX3RhYmxlKTsNCj4gPiArCQkJZW5ldGNfc2V0X3NpX3VjX2hhc2hfZmlsdGVyKHNp
LCAwLCBoYXNoKTsNCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gVGhpcyBpcyBhIHByZS1leGlz
dGluZyBpc3N1ZSwgYnV0IGRvZXMgdGhpcyBmYWxsYmFjayBwYXRoIGFjdHVhbGx5IHdvcmsgZm9y
DQo+IGV4YWN0IG1hdGNoIE1BQyBhZGRyZXNzZXM/DQo+IA0KPiBJbiBlbmV0Y19wZl9zZXRfcnhf
bW9kZSgpLCB3aGVuIGNvbmZpZ3VyaW5nIGEgc2luZ2xlIHVuaWNhc3QgTUFDIGFkZHJlc3MsDQo+
IGVuZXRjX2FkZF9tYWNfYWRkcl9lbV9maWx0ZXIoKSBpcyBjYWxsZWQsIGJ1dCB0aGUgaGFzaCB0
YWJsZSBwb3B1bGF0aW9uIGlzDQo+IGV4cGxpY2l0bHkgc2tpcHBlZDoNCj4gDQo+IGVuZXRjX3Bm
X3NldF9yeF9tb2RlKCkgew0KPiAJLi4uDQo+IAllbSA9IChuZXRkZXZfdWNfY291bnQobmRldikg
PT0gMSk7DQo+IAluZXRkZXZfZm9yX2VhY2hfdWNfYWRkcihoYSwgbmRldikgew0KPiAJCWlmIChl
bSkgew0KPiAJCQllbmV0Y19hZGRfbWFjX2FkZHJfZW1fZmlsdGVyKGZpbHRlciwgaGEtPmFkZHIp
Ow0KPiAJCQlicmVhazsNCj4gCQl9DQo+IAkJZW5ldGNfYWRkX21hY19hZGRyX2h0X2ZpbHRlcihm
aWx0ZXIsIGhhLT5hZGRyKTsNCj4gCX0NCj4gCS4uLg0KPiB9DQo+IA0KPiBCZWNhdXNlIG9mIHRo
aXMsIG1hY19oYXNoX3RhYmxlIHJlbWFpbnMgZW1wdHkgZm9yIHRoZSBFTSBmaWx0ZXIuDQo+IA0K
PiBJZiBlbmV0Y19zZXRfbWFjX2ZsdF9lbnRyeSgpIGZhaWxzIGluIGVuZXRjX3N5bmNfbWFjX2Zp
bHRlcnMoKSwgdGhlIGRyaXZlcg0KPiB3YXJucyAiZmFsbGJhY2sgdG8gSFQgZmlsdCIgYW5kIGZh
bGxzIHRocm91Z2ggdG8gdGhpcyBibG9jay4gSG93ZXZlciwgc2luY2UNCj4gdGhlIGhhc2ggdGFi
bGUgd2FzIG5ldmVyIHBvcHVsYXRlZCwgdGhlIGRlcml2ZWQgaGFzaCBpcyAwLg0KPiANCj4gRG9l
c24ndCB0aGlzIHJlc3VsdCBpbiBwcm9ncmFtbWluZyBhbiBlbXB0eSBoYXNoIGZpbHRlciwgd2hp
Y2ggd2lsbCBzaWxlbnRseQ0KPiBkcm9wIGFsbCBwYWNrZXRzIGZvciB0aGlzIGludGVuZGVkIE1B
QyBhZGRyZXNzIGluc3RlYWQgb2YgZmFsbGluZyBiYWNrIHRvDQo+IGhhc2gtYmFzZWQgZmlsdGVy
aW5nPw0KPiANCg0KWWVzLCB0aGUgY29kZSBiZWhhdmlvciBpcyBpbmNvbnNpc3RlbnQgd2l0aCB0
aGUgY29tbWVudHMsIGFuZCB0aGlzIGlzc3VlDQp3aWxsIGJlIHJlc29sdmVkIGJ5IGFkZGluZyBh
IGZpeCBwYXRjaC4gVGhlIGN1cnJlbnQgcGF0Y2ggZG9lcyBub3QgcmVxdWlyZQ0KbW9kaWZpY2F0
aW9uLg0KDQo=

