Return-Path: <netdev+bounces-182361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E38A4A888B5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BC9176B70
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E02820AF;
	Mon, 14 Apr 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ky/a9jrL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0945E27F736;
	Mon, 14 Apr 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648764; cv=fail; b=hEn2DdkUP+bkgGJ4K3urLx95X+K+Wy4WLhjcf54rdxP19jmnst9S0IqMJIYXyjNWBs0a+TKqUkH1LcomqpG6SBJyRe9g3w6NnPi5OQHpCKj9Abg7wgvn+kACSSrxHV56VUcmHHpAqoVFS4vSmt5tqRaYoWL4nQ9Kzs+idWrO77E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648764; c=relaxed/simple;
	bh=cJMBKtMmdkhaL2x33rGhyPfAclJZ5sN9b/pIdTH5Hlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pSrI+buXGjm8yhgWc1GkG33/qHsdAPQfaDpm3Pt2UsCQ42KNMeOqBoxzl/INlu2aTKCqsfqQID/a8G9v9Ov5mBS8nd7ohYmGrX3U7PU+x1Oa/wFJD9uhASjQahw94dmT3bfAu+rCeygb6gmudc4wb2S69wnjNk8nKI3OjTqARn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ky/a9jrL; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E97Cpi028776;
	Mon, 14 Apr 2025 09:38:57 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 460cebjt1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 09:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqY08rEpjiCUXCroU9/WpXHqX8f7KWqx7bSk7gCqbnVnmHMMMrXFfSnRQ9UaZz3VybU0v76n86kG5E9yeAkVdnH1NepjxSuPybfjOacCtPrEdOy9ujb8VNmRS4+Nilr3mOjINJgsv2V00DW6UdzlDtyRjqXTZshOwr7A8I0k2l3EkQrczJHjh49PWnLIgd0DGfZJdiMBNUnhBrYYxH/oPk3tP8gXCHFfUdRL/5+QEWyLqnrX/Rg94VxUh4AtuJhtBKgAoTxczOc+ThdE3vFlgyO+T3KyoW4ENVt+TSamaUX/8XWS1YN/hgZEpPqfeHjppynZaJZMkOpEX+dpOEaIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJMBKtMmdkhaL2x33rGhyPfAclJZ5sN9b/pIdTH5Hlg=;
 b=ojB9S3SjusW0V8fHkLnWD128a5Ov2EIswcuowZjSG686dtgsGsXC7Toagapf9/tzEpvosekWn4Y9bl7WtOsOe6IR12Lew7GXZiqocyGtWpxqHAliR0lTGzH/HoCQUMQWBBl0VLv53tkFQ/94WH9/v/WcIK3idXnY94HN1hUbdB3YrcZay/1gxmkBPQjUDjjW91gS9ZwsJSK06U1J8O87kY4x32c4eRIvJVxYkXAE6wYTJampajSzDUtIDiKrQD5Of5LUulKm7Bvrql6za9lK4BVIJp8zcfuRuPN3eWqq3uLAq77klMS3mE6p0NkiEgR5tz6zMeKhBaOYj+kki29yPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJMBKtMmdkhaL2x33rGhyPfAclJZ5sN9b/pIdTH5Hlg=;
 b=Ky/a9jrLTAtS0dc9b6wv+wBWTiFBaoPpIXLttZrF2C7+GhUVIlDL19lmKipyEfoGCR11ffJN5LUUAfGbV1dqIJNgMVx8gvcLh4qcWQQlgBQ6yTk753FHRdI7Zuf5t4Q78wRBoArVUiOY/Cn27h6FjvrsoYIpCCiVAoz+YJcANWk=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by DM4PR18MB5473.namprd18.prod.outlook.com (2603:10b6:8:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 16:38:54 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 16:38:53 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "morbo@google.com"
	<morbo@google.com>,
        "justinstitt@google.com" <justinstitt@google.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "horms@kernel.org"
	<horms@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH v3 1/2] octeontx2-af: correct __iomem annotations
 flagged by Sparse
Thread-Topic: [net-next PATCH v3 1/2] octeontx2-af: correct __iomem
 annotations flagged by Sparse
Thread-Index: AQHbrVu13cAnHQN0uku9wDcKk6B7jQ==
Date: Mon, 14 Apr 2025 16:38:53 +0000
Message-ID:
 <BY3PR18MB4707C3348715B237C0A95C47A0B32@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20250311182631.3224812-1-saikrishnag@marvell.com>
 <20250311182631.3224812-2-saikrishnag@marvell.com>
 <7009d4cc-a008-49ea-8f50-1e9aec63b592@lunn.ch>
In-Reply-To: <7009d4cc-a008-49ea-8f50-1e9aec63b592@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|DM4PR18MB5473:EE_
x-ms-office365-filtering-correlation-id: 30f1e0c6-52bb-4c07-ab80-08dd7b72d807
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REJYWFZNdjlWNUt1eGFjSlF3YkdoUTU3SGJsVlpJZ292UElqS0F3UlJpTm1Q?=
 =?utf-8?B?YXdnSFlKaGowLzNMTm5CallyRit2anorQnVqS1Fucm9XSGVEeUJFZk8vdm1x?=
 =?utf-8?B?d1l6Z1BzaHZZbitIUFFIS2JlNVpSdkNORHBFeG5rcHJmZjZscGpxK0taRUVE?=
 =?utf-8?B?Wk9BbE1lVzEwSHNVQ1ExUWdzdUhOdkdZWnAxNVBpb040ZUl2TXhEQkxhZEZO?=
 =?utf-8?B?QU9lRUtpYnY0QVM2eldGWCtCUjBmUkpXcG80YklTbjN3UC9TS0tLZk52SjdK?=
 =?utf-8?B?NW9laEVaY2JKRjhVY0tMVUxVY1VUL0hrdGxRdzMwZXJrSnQvNElhVEM5OWZu?=
 =?utf-8?B?OE1zWnA3M3BLQXpNRXRqOTRuZHhpbFNNY1JIa1ZnSDZNWFR0OTc5L0lCWmdV?=
 =?utf-8?B?SXAzNDI0QXRISnpmQS9lbmpvWk5WclNoS050Q2FEY2E5Y2JCSkhaYzZ2Uzgz?=
 =?utf-8?B?dlg2QVR5dnNFcExMa3hLTGxEZGc5UWdqVzZsb2g2ajZON3VlU3ZpdEtHVUFP?=
 =?utf-8?B?L3BCcEJlQi9SR0ozUVpyRHR0UzFKakpsMG5FZlhlS0JiUXZWeHBLQjRzSXNG?=
 =?utf-8?B?Y2p4aHNJQ1N3RytqMUYwOENBSkdHVGN1MWptZnhkU3g3Z0dmZHJPU1Y4Vk51?=
 =?utf-8?B?NnI5UUFRZllPZjJMT21DRCtkc21BZkpDRjFXd0w1Y3hEL0V0cFFvUWhBc2tm?=
 =?utf-8?B?c2diRURid1VjZ09iNXN6UE1BRTlLL2V5SmN5ZnRUcHdzNlpxbE53VklRamNC?=
 =?utf-8?B?SGFBUVdtY1QrSUYySlRmQkpOVjBZcXZlUnZjcnMrTWdrNksxdzZqOE50NWQ2?=
 =?utf-8?B?WmZiK1ExNzc0WTNtZ2k2S1VwcGZwZEpjMmF4UFk0NmpVeDRGNGFVNXNFNDdh?=
 =?utf-8?B?aWVPT1pnUjlURGZnd1V6RURUU2UzV2FCWEtWWXpNdVB6dERaYXYzSU05Q0t4?=
 =?utf-8?B?bHhpZzM0TVlMaE1BeUxIUktWVjJFRGp0Wmp6VmlacTFIaFhiT0xlUmFORXE3?=
 =?utf-8?B?Sk1McitCbFNWVlNzajMwamh1azhTNWkvU25oNlpCK0p1OXlRSk9HTHR0K3ht?=
 =?utf-8?B?SUhlaGNKWkRESVBxYTRYNDl2N085OTh0YjF1U0ZxY1VJQXB2RGN3UExMTkJW?=
 =?utf-8?B?enh2MklVUGJGK3V0Tnk0d25aVG1mZmxDNjZHdDdzOUFYOVNZeHFZdmkycm1v?=
 =?utf-8?B?YXZsT0xCOGNOR1VBK29RczhBdlQ5bU5ZUForenJ2eWRVOUZnOTBFQWIrSHlY?=
 =?utf-8?B?RVJmTXlCbE1MTEdRZHdMd1hDVTR4bEs4TWdTS25TMHo5RlVrc2RNelVSTG5V?=
 =?utf-8?B?eFhXcVQxbmFZNjExUkJFdnBjUE1Ra1dlTWxjQXNxS1JqTzFXUFJrTzUzcHBC?=
 =?utf-8?B?STdsSUM5VHJ2cFF5NndBcXJzN3VNODdXMk1JZm0yMVc4L25iMXVCUU5xd09Q?=
 =?utf-8?B?YWowdXF4cVdaMnJ2UVBEOUwzUUQzelVEMnQ3TWtEQWh0MkRjQWplSVk0TlYv?=
 =?utf-8?B?YnJaMVhscUdoVVBPN1RkeHk5UnYxMmtmbDVmZnJKc2FDWlk5Sk1zNUVsdHlq?=
 =?utf-8?B?WUVYQXhRMVFIM01ZVVIwMkgvblBpMWZVcy80TGl0Qjg0bk1QbmNFT3ZjeFEv?=
 =?utf-8?B?ck9oWE5uTEFKaVdmTE1DQ3BlSTkxSjNJZmRkS2ZGSFNZTWMyb1lyWFljVC93?=
 =?utf-8?B?WVpGNFd0NVJpS0tsV1BVZFVCYzBkQ2VoMHMycHh0RUliV2JxbG05cmJjOVNw?=
 =?utf-8?B?K2VVdlpKMmM5WjRodTBsUFRhZ3VaTGZTSWFQcGxnOURjSEdZYk1ZdUV4eXov?=
 =?utf-8?B?ckRrZDdOWjFFN3RJL0hUSFFGaHhlNEdJdEVDd1BxbzZJeVRzcXlUVmlkd3hY?=
 =?utf-8?B?OHFWQUxiL0pIQ3dOOG84dzhxUmVmUVVJMG9jb0JKalh3TDVDOHZ2SEpxbjNv?=
 =?utf-8?B?cGRaU01oMWRBRm9MMzlzZlc0V0hvNEphZi92KzZZRU9xOUhUU09QZG9Ha0xw?=
 =?utf-8?B?blovdkErWmxnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SElPYzlQMHNwNGxRSVZibUFrYlo4VUwrUktzbm4zSGhnaVRXYWtiaVJBamtr?=
 =?utf-8?B?Q3huSUtxNkVhbXdpL2JMVndjTVZEQmRHMVkvMEhMaFQwVXdMdklqaG5ZaDQ4?=
 =?utf-8?B?NUtsUnVoMW8xWVZLM3BXMHJQY25vNWZWc3JQVDZhUVAyc0JYS3JhaStUV01o?=
 =?utf-8?B?L1gwZjRSVnEyUGJHWWg5cTJ2MlI4QkpPQnU1eWVCcUZsdTQvb21EdnZKYVF3?=
 =?utf-8?B?dXBVRlBjNnZ6cEhSR2ZtalNJQ2hGQnljSUNramhZV0dqQ3k4TitDVVdCaDJp?=
 =?utf-8?B?dHZ3SExReEh0VEhGS3RqS2M4SWtpb1VOUHRWMEE3bUoyQmt0ZUlDRW1TOGZO?=
 =?utf-8?B?VzFyWStCV1cvdGY1ZXdmbFBlS1Z5YWQvMEorMDdjcWJGVDBjS2V5dzU2V096?=
 =?utf-8?B?S0tDRklOYTZrdkIyOEp1NVdtM0FQdDhJZTVSWWJLTHJRWjRubXVFV25wcHZ4?=
 =?utf-8?B?MUc4RzFaSFdBZnpLeGtBRHFkem5SVVRNSS9Fd3dvTmZ4aVR4QVM3Wm9oM2h0?=
 =?utf-8?B?N0RRbGF4ZDZibVhHU2FsM2FBK0xBbmVEK3A5RUlCWjJHK0IxT1VsSWdDb3FD?=
 =?utf-8?B?cnB2ZTRhUm53N3lhaWVrRXZFVW1ncXE1TlVoNzdYK2dYVnJXV0k4MzduVXZw?=
 =?utf-8?B?SFpvaDRoeUlwQ2xCQ00wdkNCdFV0UVlZVlpFV3BybHF4cnVrcDVzR1RxanVa?=
 =?utf-8?B?QkpoZ1JYQ0MydXNGYTZmSWxuLzV3a2xvZi9CeTY2ZWViSnJ2RGkvaDM2QWsw?=
 =?utf-8?B?Z3ZLMHQ1Sk1mYmRQVlBPUFFCWkYyK0lqaHdJV0twd0Zaa1hNdlhlSGc4TDdF?=
 =?utf-8?B?cUorU05PZXYzendPeWkyWG9vQ0VqUTBxQS9XbjF0aWVPT3FQWUo5Q3I0cm1j?=
 =?utf-8?B?Z0hxRlgwY2EyY014ZHVGdG52ZGd1WlJhNE0yRk9qempkL2ViNFppQkR2cTZl?=
 =?utf-8?B?cWlvWGFCQ0Vkc3NHK0NJSTZMd3pRem1LNnowTlRDOFJvc2EzS2NNK3ZBOERq?=
 =?utf-8?B?WmtTb0I0MnR1Y01IOENJemFkR1Byb3kxdFZpTENUZXErS2M4b0gwb2tEcWdE?=
 =?utf-8?B?TlBkcmJxRXNyVEtlcmd1Mms2cW45WndWVEVteFdDb2g1Wjk4d2VtN3F2WFgy?=
 =?utf-8?B?dVoyWDdEVjdoS0xhN3VMMCtoWUJJRDgvRGNGL0szK0M5NUsxTUdSeFc0Y2NK?=
 =?utf-8?B?bkRMNjhMQVlPK3IvWTBpRmRMTGo2WXN6bGJaZUJucGZzbkI2S1oyVUlsUG1t?=
 =?utf-8?B?ZE12aWRSSUlETkY4cWkxWVNIMDdUbk5Kc2hMbitqRTl3TSs1S0dYWkloaXpw?=
 =?utf-8?B?S0hxNFRrVkNzVnErN3R1OEcwTVdIY2NpKzRCeWNWaHNXYjNZc09SSjNDYUYv?=
 =?utf-8?B?UFpGSE43YTNHbWFyTmJzRmpmNkd2RHY3bS9FWHhBZnhtMCttbFBpbGNocktx?=
 =?utf-8?B?dlpCSWdWMm1PcW5lUDFiWko3WDNzRWthbkJVVmZSN1o0N1Z1VHNveExFZElR?=
 =?utf-8?B?QXpyNEhoUTFXVjl6NVViaWlpcWszWVVOMDZXNUJNcFYweUZBMnF3VEtCWlRJ?=
 =?utf-8?B?UXlCOUZjSGdYQWgxS3l0YUhXS1NDeUg4RXJ2S3dGeWR3TE45YjBvTU5Yczgx?=
 =?utf-8?B?N1VmTTNMcTBySmhwTDBWa3Mya3F2bktzUDhlS0lzeDlWd2N3MlZhN2IwYktt?=
 =?utf-8?B?REhZUUoxSGtkZDVOelp6emdsUVRsaE9Vc0JOWXgwN05MMnk5YUZXQUFuRmNJ?=
 =?utf-8?B?QUJSWXlheXNwZDA0VVREdjE1UCtWRlptOXkxeUlyRWlmVWZ1a3hodlRTOXU4?=
 =?utf-8?B?Q1prMkE5WWhIOXUvcWpPRXROSnRZMXZPd2VYaDd6WHJ1R0FmUTVxOHVkSDY5?=
 =?utf-8?B?VjJoUG02aGI1dHQ1YUYvQUxtKzBJM2l5clRHeEpEaU4xeXhPN0dvMzY2akhV?=
 =?utf-8?B?Mm5IZ292NmR4L2Z2OEVabkN5b0NBeEQxVkQ1cUJDNGQwdkVwZkF5SUp6SU43?=
 =?utf-8?B?K0lUYkxKalZXY0x2S0tHTFVSY1JkNHIzSndoRm1nSkJsUkFSdU1tcEFBMTU5?=
 =?utf-8?B?UmFMQ3JlbWRHS28veEk5MUFpQURYSjM0eDJBSFpYZ1VMY1JwY3hGaWxlQ3VR?=
 =?utf-8?Q?MALftMR3cK2DytRZkR0rie1Cx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f1e0c6-52bb-4c07-ab80-08dd7b72d807
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 16:38:53.6949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shB4Ld23ubQrXHbWF8iZ9Sise3nm5HO0GJxQtORz9A7w0XLgMBMnYA/R80duZNaupgGuDxJp/Nizv8iutdM8nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5473
X-Proofpoint-ORIG-GUID: W2UbALCNEb1Nyt2KsglBLcd6bTZR_JlU
X-Authority-Analysis: v=2.4 cv=UJfdHDfy c=1 sm=1 tr=0 ts=67fd3a21 cx=c_pps a=gHjWyi4SN+6fNgZLRl0D7Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=ye7vx_Rie9caM8oHyrgA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: W2UbALCNEb1Nyt2KsglBLcd6bTZR_JlU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_06,2025-04-10_01,2024-11-22_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTIsIDIwMjUgMjo1MiBBTQ0KPiBU
bzogU2FpIEtyaXNobmEgR2FqdWxhIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCj4gQ2M6IGRh
dmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsN
Cj4gcGFiZW5pQHJlZGhhdC5jb207IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IFN1bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFy
dmVsbC5jb20+OyBHZWV0aGFzb3dqYW55YSBBa3VsYQ0KPiA8Z2FrdWxhQG1hcnZlbGwuY29tPjsg
TGludSBDaGVyaWFuIDxsY2hlcmlhbkBtYXJ2ZWxsLmNvbT47IEplcmluIEphY29iDQo+IDxqZXJp
bmpAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+OyBT
dWJiYXJheWENCj4gU3VuZGVlcCBCaGF0dGEgPHNiaGF0dGFAbWFydmVsbC5jb20+OyBhbmRyZXcr
bmV0ZGV2QGx1bm4uY2g7IEJoYXJhdA0KPiBCaHVzaGFuIDxiYmh1c2hhbjJAbWFydmVsbC5jb20+
OyBuYXRoYW5Aa2VybmVsLm9yZzsNCj4gbmRlc2F1bG5pZXJzQGdvb2dsZS5jb207IG1vcmJvQGdv
b2dsZS5jb207IGp1c3RpbnN0aXR0QGdvb2dsZS5jb207DQo+IGxsdm1AbGlzdHMubGludXguZGV2
OyBob3Jtc0BrZXJuZWwub3JnOyBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtuZXQtbmV4dCBQQVRDSCB2MyAxLzJdIG9jdGVvbnR4Mi1hZjogY29ycmVj
dA0KPiBfX2lvbWVtIGFubm90YXRpb25zIGZsYWdnZWQgYnkgU3BhcnNlDQo+IA0KPiA+IGlmICht
Ym94LT5tYm94LuKAimh3YmFzZSkgPiAtIGlvdW5tYXAobWJveC0+bWJveC7igIpod2Jhc2UpOyA+
ICsNCj4gPiBpb3VubWFwKCh2b2lkIF9faW9tZW0gKiltYm94LT5tYm94LuKAimh3YmFzZSk7IFRo
aXMgbG9va3Mgd3JvbmcuIElmIHlvdQ0KPiA+IGFyZSB1bm1hcHBpbmcgaXQsIHlvdSBtdXN0IG9m
IG1hcHBlZCBpdCBzb21ld2hlcmUuIEFuZCB0aGF0IG1hcHBpbmcNCj4gPiB3b3VsZCBvZiByZXR1
cm5lZCBhbiBfX2lvbWVtDQo+IA0KPiA+ICAJaWYgKG1ib3gtPm1ib3guaHdiYXNlKQ0KPiA+IC0J
CWlvdW5tYXAobWJveC0+bWJveC5od2Jhc2UpOw0KPiA+ICsJCWlvdW5tYXAoKHZvaWQgX19pb21l
bSAqKW1ib3gtPm1ib3guaHdiYXNlKTsNCj4gDQo+IFRoaXMgbG9va3Mgd3JvbmcuIElmIHlvdSBh
cmUgdW5tYXBwaW5nIGl0LCB5b3UgbXVzdCBvZiBtYXBwZWQgaXQNCj4gc29tZXdoZXJlLiBBbmQg
dGhhdCBtYXBwaW5nIHdvdWxkIG9mIHJldHVybmVkIGFuIF9faW9tZW0gdmFsdWUuIFNvDQo+IG1i
b3guaHdiYXNlIHNob3VsZCBiZSBhbiBfX2lvbWVtIHZhbHVlIGFuZCB5b3Ugd291bGQgbm90IG5l
ZWQgdGhpcw0KPiBjYXN0Lg0KWWVzLCAgbWJveC0+bWJveC5od2Jhc2UgaXMgaW9yZW1hcHBlZCB3
aXRoIGNhY2hlIChpb3JlbWFwX3djKSwgd2hpbGUgaW5pdGlhbGl6YXRpb24gaXQgaXMgZGVjbGFy
ZWQgYXMgX19pb21lbS4gQnV0IHRoaXMgaHdiYXNlIGlzIGFjdHVhbGx5IGEgRFJBTSBtZW1vcnkg
bWFwcGVkIHRvIEJBUiBmb3IgYmV0dGVyIGFjY2Vzc2liaWxpdHkgYWNyb3NzIHRoZSBzeXN0ZW0u
IFNpbmNlIHdlIHVzZSBsYXJnZSBtZW1jcHkgKDY0S0IgYW5kIG1vcmUpIHRvL2Zyb20gdGhpcyBo
d2Jhc2UsIHdlIGZvcmNlZCBpdCB0byB1c2UgYXMgInZvaWQgKi91NjQiIGJlZm9yZSBleGl0aW5n
IHdpdGggdW5tYXAuIEFzIHRoaXMgaXMgRFJBTSBtZW1vcnksIG1lbW9yeSBhY2Nlc3Mgd2lsbCBu
b3QgaGF2ZSBzaWRlIGVmZmVjdHMuIEluZmFjdCB0aGUgQUkgYXBwbGljYXRpb25zIGFsc28gcmVj
b21tZW5kZWQgc2ltaWxhciBtZWNoYW5pc20uIFBsZWFzZSBzdWdnZXN0IGlmIHlvdSBoYXZlIGFu
eSBvdGhlciB2aWV3IGFuZCB0aGlzIGNhbiBiZSBhZGRyZXNzZWQgaW4gc29tZSBvdGhlciB3YXku
DQo+IA0KPiA+ICAJZm9yIChxaWR4ID0gMDsgcWlkeCA8IHBmLT5xc2V0LmNxX2NudDsgcWlkeCsr
KSB7DQo+ID4gLQkJcHRyID0gb3R4Ml9nZXRfcmVnYWRkcihwZiwgTklYX0xGX0NRX09QX0lOVCk7
DQo+ID4gKwkJcHRyID0gKF9fZm9yY2UgdTY0ICopb3R4Ml9nZXRfcmVnYWRkcihwZiwNCj4gTklY
X0xGX0NRX09QX0lOVCk7DQo+ID4gIAkJdmFsID0gb3R4Ml9hdG9taWM2NF9hZGQoKHFpZHggPDwg
NDQpLCBwdHIpOw0KPiANCj4gVGhpcyBhbHNvIGxvb2tzIHF1ZXN0aW9uYWJsZS4gWW91IHNob3Vs
ZCBiZSByZW1vdmluZyBjYXN0cywgbm90IGFkZGluZyB0aGVtLg0KPiBvdHgyX2dldF9yZWdhZGRy
KCkgcmV0dXJucyBhbiBfX2lvbWVtLiBTbyBtYXliZQ0KPiBvdHgyX2F0b21pYzY0X2FkZCgpIGlz
IGFjdHVhbGx5IGJyb2tlbiBoZXJlPw0KU2ltaWxhciB0byB0aGUgYWJvdmUgY2FzZSwgb3R4Ml9h
dG9taWM2NF9hZGQgaXMgYSBzcGVjaWFsIGNhc2Ugd2hlcmUgaXQgdXNlcyBhc3NlbWJseSBjb2Rl
IGFzIHBhcnQgb2YgZGVmaW5pdGlvbiwgaGVuY2Ugd2UgaGFkIHRvIHVzZSB0eXBlY2FzdGluZyB0
aGUgInB0ciIuIFBsZWFzZSBzdWdnZXN0IGlmIHRoZXJlIGlzIGFueSBiZXR0ZXIgd2F5Lg0KDQpz
dGF0aWMgaW5saW5lIHU2NCBvdHgyX2F0b21pYzY0X2FkZCh1NjQgaW5jciwgdTY0ICpwdHIpDQp7
DQogICAgICAgIHU2NCByZXN1bHQ7DQoNCiAgICAgICAgX19hc21fXyB2b2xhdGlsZSgiLmNwdSAg
IGdlbmVyaWMrbHNlXG4iDQogICAgICAgICAgICAgICAgICAgICAgICAgImxkYWRkICV4W2ldLCAl
eFtyXSwgWyVbYl1dIg0KICAgICAgICAgICAgICAgICAgICAgICAgIDogW3JdIj1yIihyZXN1bHQp
LCAiK20iKCpwdHIpDQogICAgICAgICAgICAgICAgICAgICAgICAgOiBbaV0iciIoaW5jciksIFti
XSJyIihwdHIpDQogICAgICAgICAgICAgICAgICAgICAgICAgOiAibWVtb3J5Iik7DQogICAgICAg
IHJldHVybiByZXN1bHQ7DQp9DQoNCkFwb2xvZ2llcyBmb3IgZGVsYXllZCBpbiByZXNwb25zZS4N
Cj4gDQo+ICAgICBBbmRyZXcNCj4gDQo+IC0tLQ0KPiBwdy1ib3Q6IGNyDQo=

