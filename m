Return-Path: <netdev+bounces-268370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPOPKrSnuGkthAEAu9opvQ
	(envelope-from <netdev+bounces-268370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:00:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B872A268A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B88B130053CF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FD9242D84;
	Tue, 17 Mar 2026 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EKB39YTl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fgqoxq9G"
X-Original-To: netdev@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEC137750;
	Tue, 17 Mar 2026 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709216; cv=fail; b=nBuz9uXLrRm5KUA3ZFBBy1c+kQjhgeedAFLsnkcbp2h7ez/fMkZBrgmv9wtahDngn8CiosPpZI9U6p/BV7h/uIU2zEk6qSKxBrSnW9TSSGVig7rDZB41lUtrNa5WIs0Zva/++K7cybUISjo2NPYoBYD0Krs57Yqib4bUfyh8Grg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709216; c=relaxed/simple;
	bh=+5WPCvzl3+1itPma+DplauGFkICAUit1Oh0UFP21Ssw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Emp1HpO+K28f+VJHlPDeJz5L+aH5dqv78/sdD7xwEJalRvdC4tSIJPyB47Ox5slpsaa/R7GKmQBgj/tIO0unFAG/r0Gnyk6QEwftml2/ufHYKIm2Im5vm8vbrvpo+cPL3qEQXfqWxr36bOqseCPCC87mIY+LDD5Lx8fYbRBwvSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EKB39YTl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fgqoxq9G; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773709214; x=1805245214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+5WPCvzl3+1itPma+DplauGFkICAUit1Oh0UFP21Ssw=;
  b=EKB39YTlT4fyr70hmab1Qoo3sr9pkEUW8C8uYCsUFd9pgzfzGUq7yeN2
   U3FW9f1EIWXV9O4MnEn/BwIZhWl4ZMEuaBEe2YeGugh8rR+NEuxHdG6MX
   tGomYEcWANO+2STorxZHVQHXp8meECpU8IjKkgD6vsVbOgH/XTT9c0+CR
   Zmzwxz69misS8UO4NfylVkTVo22VAOqYMV7uRw7HNquK5zFDwbA8jr9NA
   b+qbFDAyggVapN47DDI3NWkghC7Ep+hhbqL5dOzb6XYGl159Ue9y+Vv45
   Sv8Q/Aa7Zwn6iDI9V1FDtFdGLS2FpnMXxwu4L4fZmpG/Sah1EqBSkcIpS
   g==;
X-CSE-ConnectionGUID: lsWrWX4jSAWkfMFngBfRsg==
X-CSE-MsgGUID: lmwJ9zQ/SjWzcBGqiyCgiA==
X-IronPort-AV: E=Sophos;i="6.23,124,1770566400"; 
   d="scan'208";a="143171544"
Received: from mail-centralusazon11010045.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.45])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2026 09:00:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ne8ivJUU5A6FN7GFaDvciPtyzkZ8j0Udrz0SEz8MbfS1p6qDIchaxYazyReYAkrTvvV4uLYSvTNP58Gnu/LbXpL0/1JqU4iOeMk7sufHEul1MDTiora5zoXncNpamFyDCcyZhTIhFIzQSdBPMXL2LbX8ntG7o/EVK2cGlXd27NnmyfaYcY7slJnCrTJwUjbQlhUzAPpJoyPlHwreONdMqyVk26MnDF2ahS2ZhL82UDafUefKi8aXLgzVzV1t0+GjFXfivXLjXXUdquDy0OHTtgWVYIE/N+TGB6iLlzPtbgOy2DzYsa2vO6qe2QmlL7KSX+MczgO5ooQsVmfSDbgfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5WPCvzl3+1itPma+DplauGFkICAUit1Oh0UFP21Ssw=;
 b=pI62afxksKBWofDfuLqP2T0qNgvlw1d2XdtltPfLept4NZMmWKM+Gc3F/lltQSc91az6vZFVNpFUCPiwa9HZr7MpkBJQqiHJhYN3c2vXxZU0Jd4x/wa4/ztlqXx7O+XP1ddIAhFTQp+xY4UAZPEZbCUe0nKCxs1oL+TDlgatPqLZV4fNYRmvdVyWGXhPUX/pPgbSRFV1OH/MIS4pMBrDiKDnbbUkwPV2MD2NUFXRDt43AX9QoEAgB0vfjl+dyOu+dufT3+Uu1Gr4LRbHZ65JOMfWAjTNC5UCPUzHrIL1iLIDb2lGWzzBZ9gZAtIfxhma3mt4RufIIt8wuarW9ZdHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5WPCvzl3+1itPma+DplauGFkICAUit1Oh0UFP21Ssw=;
 b=fgqoxq9GhyD5x/emWre9AOC6Y+79L0ZlvdIFqv0PkZI1NsSix2RYGeYSq+KK3r+7JQPFiAYpMxXfZng6hHtuEqzRO8cy4uv5PhZwu5CZYFLor9BLHFriI+EMM56OmyRM6B6gLQjoj9dtqQ8ZLEpXPUv4PRnzQ/g+fTNCRIWWrD4=
Received: from CO1PR04MB8300.namprd04.prod.outlook.com (2603:10b6:303:157::22)
 by CH4PR04MB9385.namprd04.prod.outlook.com (2603:10b6:610:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 00:59:54 +0000
Received: from CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a]) by CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 00:59:51 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "corbet@lwn.net" <corbet@lwn.net>, "dueno@redhat.com" <dueno@redhat.com>,
	"ssorce@redhat.com" <ssorce@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Alistair Francis <Alistair.Francis@wdc.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC net-next 0/3] tls_sw: add tx record zero padding
Thread-Topic: [RFC net-next 0/3] tls_sw: add tx record zero padding
Thread-Index: AQHcr4k2AUEz4KzynEq+L3ew7am/6rWsZoQAgAWNL4A=
Date: Tue, 17 Mar 2026 00:59:51 +0000
Message-ID: <2225767d4d7da2bba49fe0a85f2ba9253de037cf.camel@wdc.com>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
	 <abP_Zvrgd5TDKsUP@krikkit>
In-Reply-To: <abP_Zvrgd5TDKsUP@krikkit>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR04MB8300:EE_|CH4PR04MB9385:EE_
x-ms-office365-filtering-correlation-id: e7682587-a6e5-45ed-a317-08de83c07ec9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 9HLRXdlmg/Kgl501EychbEMfwIo6eHXGCtvufAHTVcqXRGEW0JTEiN3aNAsvmDq5XGFiTwNV0yGz8IF1NZ5BLiPNgrXGTp5lnKBxCGrkQfyYnrHAJ1uo23XR4AQ1hQ1TvNC/kBmDM1g8jX9PLqkmp2StHW2fPDQ38bxYaZ/4KelY5qAZUyCc7PTieRB6mr+v5wuIjw7FEQG0ibB1wx5WuRZzSCr6Jufr8sa7/6paC5f38UpTGfHa7fUlH0/j3o0oOX1tmw4SvyEo+TzYpsrqHXawv6eTpPNUJRU/hKhPuPFx4H6xvFmXF1QvfUg/ggM/aCqZk32QRdhYSfm6xqmaZFguugdyEbNlDRPH0pt0vdFRZh/uOUyjoKkxKV+N3q3sO5oct2QR1Iub5+ndwNUubIUatgJCz1pobNktZcVGuFCu2dl6+AvRnKpg5AK5rbH1XIA/iMcmyIWGoKHG6ZJHR8uKR9zw624vuqRGTJSlA1p5LQNUoU4hN6+J6X1xOXJiScRZMOEb+zbom9ketTDob+7T8YVVqmBJtKUbsJ3a+FN3QeJClf7ighDRnL/ysqRpQaIw9y1xBqqY2NtzQk6uuDTixtDpov1H74yvnSRJTsubZTOMcI+xjEoGzOYEJS9kTaGw9BG0NxbF3zyHIUnlryVzrlw6lE9xuG9YgZl1uGTUoc5S58EZYLzuP3sWjyY0dKygsaQ7dQeuNy3LhLN4wzyoiWXsnZ0d6vg+1qDnkJDb8AEw7Oj8C5VkKpq5edKhK8WXvMAGgArcDtAEaP+vOieP3MF8y9DEsAUqc2L7zGY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR04MB8300.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTZTcmxGOFV3eTJZK2VSWWpoS21jZkZUaUltMnMydW95Z0NHcjl5WHkvZkJz?=
 =?utf-8?B?RndBajd6RmJCMS9wU0Y5RURUQUZKWi9JZTlVNm13eG5CRHdhS050aTFsek5M?=
 =?utf-8?B?U2V5ZmdLUWNtR1YwK0NhNHBObERhTkowOHlEWjlDYVZrSkJWN1pmc2xOVU4x?=
 =?utf-8?B?S2lqL3JRK2l4L3BLTEVWZ3ZWSGFoc3U1MUxRV3ZLcU43TUxDT2Q1YXNaeGg0?=
 =?utf-8?B?cWkrODhqWWVNSFo5dytWUnE5Skh5NUxucytFVXRJVjJwK1FzNXp4Sk50emF0?=
 =?utf-8?B?QmJNS00xYzRnSFl2Mk9KVG1mMjhTTmV4N3dXSDM5K25xdW1sTm1JQVhSaktl?=
 =?utf-8?B?VVdSNTJCa1JLODU5NmQ1RWhnVlUvTkJqNFVZSHpiR1FmM3V0bnpKMVdaRUxE?=
 =?utf-8?B?YmpvdUQzYUJFcmhhRGpSWW1Gc3Y1bklwbzRWazdmUE56cXZRTjNHUnA0U2FQ?=
 =?utf-8?B?ejg1YldiOUxJdVp4d3NTU0F3NG5pbUhmMmFwZFlha2lONVpZbUN0R1E2MEJN?=
 =?utf-8?B?RkFVWXlWMFVMMDg4aVcwVmxVNGpDZ2Z2VkxGN0lQdDUraW9BVTltZGlVTjkx?=
 =?utf-8?B?VTJGRXlHQTFORFZyUWJzWW5HeEFMaExXK29YallXY3BvdkNrNFo0dEsyL0JW?=
 =?utf-8?B?aEdpWTB2bTVUTlVDSEUvNCs1d3RJaGZ4WXRwVEE0U1czbHdUcEdRdldja01u?=
 =?utf-8?B?TEF3VTQyalI2RlM1THFXTjVtRVp4RzRBaG9EdXRmMVA3dGRxT1ZWV3AzWjFi?=
 =?utf-8?B?KzFuVDFOUS8zTzZZSWl3MjJjemZoNElLNmU3TDE5VGFQTlNBa1JOMFJWSU5z?=
 =?utf-8?B?dGY0eGRRVWhYOHpUTFRRRE5FRGNWa2xNKys3bDFLT3Z6ZzdLUlUvTHVyeGYy?=
 =?utf-8?B?R0lmRWhpbGw1K3g5dmFDYTlYQThnelJ1dXNEK3NENm1RS1Vqd1JhbUFhSFNa?=
 =?utf-8?B?K200WkFLaGNJWWtzblF6a1d0NGZ2bFZvVG5RemNkRlBieldaOWV1ZE1KMnA4?=
 =?utf-8?B?MVFJbEh1RUVQSnN4WFhXendLL1pFc0YvSzd0THVWbmtBVzl6dmhnbmRhTE5w?=
 =?utf-8?B?MnhLWTI3aVRYR2RZYmE5aG14T05mck1qbmYxU0dwMHFKdDQ4OXArSkg0akZ6?=
 =?utf-8?B?c1dlakR6MC9velFSSjJuRW9jeE5kdmF4NWNNWHZWdkhYWGYvdm4zN2tUWEIr?=
 =?utf-8?B?TUk4YXVHaGlGSHVYTG8xVi9sL2RWODVWblNkcW1SK28xMmt4ZkN6ZUFmSlRn?=
 =?utf-8?B?bXFUZzJMd0oxb1YrVHZKeTlKUjhhVDZ0OUFnNDRDSmNXTmNyU1lEU0NNSGNh?=
 =?utf-8?B?NHA3WTVFUkd4M1RGWjF5WVZiMjcvdktVMFY3b2x4TXVTY210QjcybHEwWmZr?=
 =?utf-8?B?M2QxNzZad3hmUDJydDUvRXlRZjh3elp3RlpFUjd4QzVCL0gremZnamZENTcx?=
 =?utf-8?B?dmw4c1A4MDNKbFNkUzRjYmZZNUE3M1FZT2l2Wkx3Wm5HRHZmajQ4NnFXWWFz?=
 =?utf-8?B?d1B1UUYrTlpVSDh0bFprS0pjMmRyellVNFN3RUcyNGVWUUQvYWVDdWh6NElO?=
 =?utf-8?B?MlBVdjNRWDU1anBqUTNPbFQzL3ZzYVVIWGZtV284UWEvNms5Z09uQXR1OEhj?=
 =?utf-8?B?Ynd2YlRHRXF0THRQeEhsTy9jalkxaThtZmdKYWhsMHlMZllsYUgwVENyaFhK?=
 =?utf-8?B?Y2lyRVdaWStpY0tKb0IvRGlNZDJBbUNxTmxRVEZLOGcyMG1RSGovNzR0azE4?=
 =?utf-8?B?VkxpaHdENDFFSVFKa2JrRnFHOU5SaXVZUXMyUENHNWdPcUVlcmh4dlFiVVlP?=
 =?utf-8?B?U0VmRWFrRnI1b2hDUlJ0TkZPNm5rcURnSjE2Q0JoMXcwTGJKdE04STRmNW95?=
 =?utf-8?B?ZklHN25VRVR1NmNnOHZ2Zk9uc25tZWRJUVlhUlVXbE8vWndqc2dFUUR6QndD?=
 =?utf-8?B?eHFMQzBZZXlDcVhVa1RGdlBVWS9HekorYUZNMzA5UEJVUHdSVXRCMmhmdUVM?=
 =?utf-8?B?STg2WUp5enNXZm84YWdZWU13TFZkN05WR2paNmdVNkpIZk13VlR1SnpPOGZa?=
 =?utf-8?B?dGp4b2dveU9iNE1iWnp6NHcvck8xS3hUT0ZCVDIzeHgvUjQvVSt0V3ArRGoy?=
 =?utf-8?B?RGxuWW9wWkFabkc3MjdwWGRxdEtyaC9PQUtaN0NBVFU1TllYZksxM09hbThi?=
 =?utf-8?B?NUY0WTF1UkRNaHk1ZkdqRzU4ZTNtNzY3SGJWaGNYc3RlOVg0MlpjSlB5bkdZ?=
 =?utf-8?B?SG4xOWlTSWVtc2ZtQ1B4SXNWbEgrQjI0bTlWQ01tWWxod0gyZEE5RTVFaXNx?=
 =?utf-8?B?ZWRBbkVJZkRsYldWMmNqZUdZTTVReFd0bTZHdVZsSnNMakhiRFp1QmZ3MUxQ?=
 =?utf-8?Q?+Rcxad358YltN4bk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD74AFAA8F301A4FB242D5A3B1AB72BC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	HCOI7r5d1s0yTVCyNNhRCIwwFidqvegm6ev8fuDnkX2zy3zIDW4pzGOD4eWCfPyMx88Ukmt+yI/oUU1ip2b+YdmsrScZvskx/LlaOtPVR2rkpxGq15swXok+th5EU2ikdn6nYex80CKujnEe7LIsKX89w7AJoF4I9MhSNChPo7DAmTwJKhA2qqpOM1YteemH/2OyMtc5cmt3b9/GxNVs3aOVAVx9LvKYSJnAr5tz/lxtYP8S8GW4mCjbDd4OHFcSr0+IB3pYfSvzwtx9IVtkiPc69dP6cqsidjD2FS2Ktm0ymhqZivI+NNNwrqJJbIGuSWw1jbCkIex/yRcyqSkZeg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	InYhX67cxF2YUC7ximLyNWNVeovfUlSIVHFrPgKhMxxQUW3kHrv9bj/FRW282oCWLhkxJyOq/iaiItKh9bcEdKqU6IFjKLRc4Yz7g5ZTVG24pRqtUdoQ2G390ZXx/y/L6hznpn7yq0ZA1GXJ+tn5J+njHlLKdKnb8diJW2CSd7b4AfFB0dAmmvgIQecy2+vhFQVoyYNN2E/gQ/jtXOWZ7/B6IFl7hDp/o2nqben9XPKj1CpCk56AsikLt/D9BOn4s+PEPnVirUNVllSfiRqE8cd5A5MINDpkIsM8vtIvzRcV3fVtUM1RFN3p499ddLZAKuq3ROKPCwP4WSuPjhM3O5u/7bjyFCgyEd6le9z4sEZ9kdE/Yn3jK8XeTCKJ2H0sgiEot8YPcc0Kj6Iafe7E2zFSTYkz7rIWYRYs20XtOhV0CgqEMVJGRvW6qgyHvojDA28u6VQbTTbxMBEp9kksYODoA7RIrzZoKH1aKcs/5W5noRzsHJ5hUxKWwdsfU57zsHug+tO9846Oz3Uc13ix/t602ywbH7+vDqZ2ncuhK/kian765RwX6Xwh5YbNzIGYxtJwz7UrmGUfuqqf4RqVI9a8fNVORkoX3FxQbGKJKvlFA3x0eG96CV0ZkWretJH2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR04MB8300.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7682587-a6e5-45ed-a317-08de83c07ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 00:59:51.6827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTs9SkN8P5YnHjTvxHuGUMUj2NK8CX74LxqyMzUh7V/VZXWayTO4sisFjPyFIRWcZgG7igKR53b5lat4vP1HUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9385
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[lwn.net,redhat.com,davemloft.net,wdc.com,gmail.com,vger.kernel.org,google.com,linuxfoundation.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-268370-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[wilfred.mallawa@wdc.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:dkim,wdc.com:email,wdc.com:mid,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 06B872A268A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

UmUtc2VuZGluZyB0aGlzLCBuZXcgbWFpbCBjbGllbnQgc2VudCB3aXRoIEhUTUwuLi5Tb3JyeSBm
b3IgdGhlIG5vaXNlIQ0KDQpPbiBGcmksIDIwMjYtMDMtMTMgYXQgMTM6MTMgKzAxMDAsIFNhYnJp
bmEgRHVicm9jYSB3cm90ZToNCj4gSGkgV2lsZnJlZCwNCj4gU29ycnkgZm9yIHRoZSBkZWxheSwg
SSdtIGp1Z2dsaW5nIGEgZmV3IHRvbyBtYW55IHRoaW5ncyBhdCB0aGUNCj4gbW9tZW50Lg0KDQpI
ZXkgU2FicmluYSwNCk5vIHdvcnJpZXMsIHRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrIG9uIHRoaXMg
c2VyaWVzIQ0KDQo+IA0KPiAyMDI2LTAzLTA5LCAxNTo0ODozNSArMTAwMCwgV2lsZnJlZCBNYWxs
YXdhIHdyb3RlOg0KPiA+IEZyb206IFdpbGZyZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdk
Yy5jb20+DQo+ID4gDQo+ID4gQ3VycmVudGx5LCBmb3IgVExTIDEuMywga3RscyBkb2VzIG5vdCBz
dXBwb3J0IHJlY29yZCB6ZXJvIHBhZGRpbmcNCj4gPiBbMV0uDQo+IA0KPiB0byBiZSBwcmVjaXNl
OiAib24gVFgiIChoZXJlLCBpbiB0aGUgc3ViamVjdCwgYW5kIGEgZmV3IHNwb3RzIGluIHRoZQ0K
PiByZXN0IG9mIHRoZSBzZXJpZXMpDQo+IA0KPiA+IFJlY29yZCB6ZXJvIHBhZGRpbmcgaXMgdXNl
ZCB0byBhbGxvdyB0aGUgc2VuZGVyIHRvIGhpZGUgdGhlIHNpemUgb2YNCj4gPiB0aGUNCj4gPiB0
cmFmZmljIHBhdHRlcm5zIGZyb20gYW4gb2JzZXJ2ZXIuIFRMUyBpcyBzdXNjZXB0aWJsZSB0byBh
IHZhcmlldHkNCj4gPiBvZiB0cmFmZmljDQo+ID4gYW5hbHlzaXMgYXR0YWNrcyBiYXNlZCBvbiBv
YnNlcnZpbmcgdGhlIGxlbmd0aCBhbmQgdGltaW5nIG9mDQo+ID4gZW5jcnlwdGVkDQo+ID4gcGFj
a2V0cyBbMl0uIFVwY29taW5nIFdlc3Rlcm4gRGlnaXRhbCBOVk1lLVRDUCBoYXJkd2FyZSBjb250
cm9sbGVycw0KPiA+IGltcGxlbWVudCBUTFMgMS4zLiBXaGljaCBmcm9tIGEgc2VjdXJpdHkgcGVy
c3BlY3RpdmUsIGNhbiBiZW5lZml0DQo+ID4gZnJvbSBoYXZpbmcNCj4gPiByZWNvcmQgemVybyBw
YWRkaW5nIGVuYWJsZWQgdG8gbWl0aWdhdGUgYWdhaW5zdCB0cmFmZmljIGFuYWx5c2lzDQo+ID4g
YXR0YWNrcyBbMl0uDQo+ID4gDQo+ID4gVGh1cywgZm9yIFRYLCB0aGlzIHNlcmllcyBhZGRzIHN1
cHBvcnQgdG8gYWRkaW5nIHJhbmRvbWl6ZWQgbnVtYmVyDQo+ID4gb2YgemVybw0KPiA+IHBhZGRp
bmcgYnl0ZXMgdG8gZW5kLW9mLXJlY29yZCAoRU9SKSByZWNvcmRzIHRoYXQgYXJlIG5vdCBmdWxs
Lg0KPiA+IFRoaXMNCj4gPiBmZWF0dXJlIGlzIGRpc2FibGVkIGJ5IGRlZmF1bHQgYW5kIGNhbiBi
ZSBlbmFibGVkIGJ5IHRoZSBuZXcNCj4gPiBUTFNfVFhfUkFORE9NX1BBRCBzb2NrZXQgb3B0aW9u
LiBUTFNfVFhfUkFORE9NX1BBRCBhbGxvd3MgdXNlcnMgdG8NCj4gPiBzZXQgYW4gdXBwZXINCj4g
PiBib3VuZCBmb3IgdGhlIG51bWJlciBvZiBieXRlcyB0byBiZSB1c2VkIGluIHplcm8gcGFkZGlu
ZywgYW5kIGNhbg0KPiA+IGJlIHNldA0KPiA+IGJhY2sgdG8gMCB0byBkaXNhYmxlIHplcm8gcGFk
ZGluZyBhbHRvZ2hlci4gVGhlIG51bWJlciBvZiB6ZXJvDQo+ID4gcGFkZGluZyBieXRlcw0KPiA+
IHRvIGFwcGVuZCBpcyBkZXRlcm1pbmVkIGJ5IHRoZSByZW1haW5pbmcgcmVjb3JkIHJvb20gYW5k
IHRoZSB1c2VyDQo+ID4gc3BlY2lmaWVkDQo+ID4gdXBwZXIgYm91bmQgKG1pbmltdW0gb2YgdGhl
IHR3bykuIFRoYXQgaXMNCj4gPiByYW5kKFswLCBtaW4ocmVjb3JkX3Jvb20sIHVwcGVyX2JvdW5k
KV0pLg0KPiANCj4gRnJvbSBhbiBBUEkgcG9pbnQgb2YgdmlldywgSSdtIG5vdCBzdXJlIFRMU19U
WF9SQU5ET01fUEFEIChhbmQgd2l0aA0KPiBvbmx5IGFuIHVwcGVyIGJvdW5kKSBpcyB3aGF0IHdl
IHdhbnQuIFBhc3NpbmcNCj4ge2xvd2VyX2JvdW5kLHVwcGVyX2JvdW5kfQ0KPiB2aWEgdGhlIHNl
dHNvY2tvcHQgd291bGQgYmUgbW9yZSBmbGV4aWJsZSwgYWxsb3cgdG8gYWx3YXlzIHBhZCBpZg0K
PiB1c2Vyc3BhY2UgZGVzaXJlcyAobWF5YmUgdGhleSdyZSBvbmx5IHNlbmRpbmcgdmVyeSBzaG9y
dCByZWNvcmRzIGFuZA0KPiB3YW50IHRvIGhpZGUgdGhhdCB3aXRoIDEwMDBCKyBwYWRkaW5nIGV2
ZXJ5IHRpbWU/IG5vIGlkZWEpLCBhbmQgYWxzbw0KPiBhbGxvdyBmaXhlZC1zaXplIHBhZGRpbmcg
aWYgZGVzaXJlZCAoYnkgcGFzc2luZw0KPiBsb3dlcl9ib3VuZD09dXBwZXJfYm91bmQpLg0KDQpJ
IHRoaW5rIHRoaXMgbWFrZXMgc2Vuc2UsIGFuZCBJIGNhbiBsb29rIGludG8gdGhpcywgaWYgd2Ug
YXJlIGdvaW5nDQphaGVhZCB3aXRoIHRoaXMgc2VyaWVzLg0KDQo+IEJ1dCBJJ20gbm90IGludm9s
dmVkIGluIHVzZXJzcGFjZSBsaWJyYXJpZXMgc28gSSBkb24ndCBrbm93Lg0KDQpPdXIgbWFpbiB1
c2UtY2FzZSBoYXMgYmVlbiB1c2luZyByZWNvcmQgemVybyBwYWRkaW5nIHdpdGggTlZNZSBvRiBU
Q1AgKw0KVExTLiBXaGljaCBtZWFucyBldmVyeXRoaW5nIGhhcHBlbnMgaW4gdGhlIGtlcm5lbC4g
TlZNZSBQRFVzIC0+IFRMUw0KUmVjb3JkcyAtPiBUQ1AuIFNvIGluIHRoYXQgY29udGV4dCwgdGhp
cyBhcHByb2FjaCBtYWRlIHNlbnNlLg0KDQo+IA0KPiBJJ20gYWxzbyB3b3JyaWVkIGFib3V0IHRo
ZSAoc3RpbGwgV0lQKSAxLjMgb2ZmbG9hZCBwcm9wb3NhbC4gQXJlIEhXDQo+IGltcGxlbWVudGF0
aW9ucyBnb2luZyB0byBzdXBwb3J0IHRoaXM/IFNob3VsZCB3ZSBjb25zaWRlciB0aGF0IGFzIGEN
Cj4gcHJvYmxlbSB3cnQgdHJhbnNwYXJlbmN5IG9mIEhXIG9mZmxvYWQgaW4ga3Rscz8NCg0KVGhh
dCdzIGEgZ29vZCBwb2ludCwgSSBoYWQgbm90IGNvbnNpZGVyZWQgdGhlIDEuMyBvZmZsb2FkIHBy
b3Bvc2FsLCBpdA0Kd2lsbCBsaWtlbHkgbmVlZCBzb21lIGRyaXZlciBsZXZlbCBpbnRlZ3JhdGlv
biB0byBlbmFibGUgdGhpcyBvbg0Kc3VwcG9ydGVkIGRldmljZXMuLi4NCg0KQXMgb2Ygbm93IHRo
aXMgaXMgZXhjbHVzaXZlIHRvIHRoZSBTVyBkcml2ZXIuIFRoaXMgc2VyaWVzIGRvZXNuJ3QgbWFr
ZQ0KdGhhdCBjbGVhciBhbmQgd2lsbCBuZWVkIHRvIGFkZHJlc3MgdGhhdC4gaS5lIHdlIGNhbiBt
YWtlIHNldHNvY2tvcHQoKQ0KY29tcGxhaW4gaWYgSFcgb2ZmbG9hZCBpcyBlbmFibGVkLg0KDQo+
IA0KPiA+IEFsc28gYSBzZWxmdGVzdCBpcyBhZGRlZCB0byB0ZXN0IHRoZSB1c2FnZSBvZiBUTFNf
VFhfUkFORE9NX1BBRC4NCj4gPiBIb3dldmVyLCBpdCBkb2VzIG5vdCB0ZXN0IGZvciB6ZXJvIHBh
ZGRpbmcgYnl0ZXMgYXMgdGhhdCBpcw0KPiA+IHN0cmlwcGVkIGluDQo+ID4gdGhlIGt0bHMgUlgg
cGF0aC4NCj4gDQo+IENvdWxkbid0IHlvdSB1c2UgInJhdyBSWCIgdHlwZSB0ZXN0cyBhbmQgcGFy
c2VfdGxzX3JlY29yZHMgdG8gY2hlY2sNCj4gdGhlIHBhZGRpbmc/DQoNCkRvIHlvdSBtZWFuIGFu
IFJYIHdpdGhvdXQgaGF2aW5nIGtleXMgaW5zdGFsbGVkPyBTaW1pbGFyIHRvIHdoYXQgd2UgZG8N
CmZvciB0aGUgcmVjb3JkIHNpemUgbGltaXQgdGVzdHM/IElmIHNvLCB0aGUgemVybyBwYWRkaW5n
IGlzIHN0aWxsDQpzdHJpcHBlZCBpbiB0aGUga2VybmVsIGlpcmMuDQoNClJlZ2FyZHMsDQpXaWxm
cmVkDQo=

