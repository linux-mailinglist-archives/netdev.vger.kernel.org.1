Return-Path: <netdev+bounces-162011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E53A25504
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 09:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1886F1881621
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 08:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1C1FC7FD;
	Mon,  3 Feb 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="acxbLm6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88B5336E;
	Mon,  3 Feb 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572941; cv=fail; b=T3oZieCcgat0CvG588nJrArzSv6fdWp00ccdpHlPAJzROGaoLgiCBwcccleqBYmuyvLKmnuQ3sdpIGfxaYPqbPYSPWNKQgxh+NOGTZBJwDhfoWglOXka7z6mkEfEklF0xYYTspr934VhaVlX5Zl6CzRgW3FUS8EkMv6oXuxFuxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572941; c=relaxed/simple;
	bh=YxBZz8y+sX/hxZKVUr3CVuuWWtOWd9u3NVtDN+ydXb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IET9O3peiIjlEb6cIQ9uFHJ4zFsB7b4OAM4dBQYbsiSaQcTuKUQZbONKTVxcf4ImVKssqbEFXRFatEUs/nfxWB66Tgnovv5TYmdSx4GYrfqJ06rTavSb/LwNmoJyTtqGntHtLzfhmI2Pp/+eS7Y+6ggsXAh5Y3lG806K3Sml5vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=acxbLm6Y; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5138dnrO012269;
	Mon, 3 Feb 2025 00:55:28 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44jtfvg0kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 00:55:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXX+efcnQAUIaMqRBujTII8g0XYmOP0DqIMaMmb13qb2WpLCIks+FRvPqmnFtFuADK7przwyj3PCe6M3w05d4YCRpzOBBXnsFnGRmR3VHh1jVDHg+//QjphBoOIPDTmkJa+XVvmSU2NUlfF9o9oomDDYRV//7ffgFh4eeksJQ5QaYuQE51RZCRXa8x7AVmogjkT+r6LsEBwakI5cLpuYEAKHNlDl8pedSUzA8E8rnpsS39fq6P8flRYvie5CxE6MPMbJfJzR5EuM5mp4SiKI5jez8Ulo+vc/BOG/hfx+E0spe45x0ctrxjtAVP3Yud0nsQP6kpYDYRqVp4OY+UZGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxBZz8y+sX/hxZKVUr3CVuuWWtOWd9u3NVtDN+ydXb0=;
 b=dwpyOzyk9OOMGrBp3GZBV9B6K5Dl+Gj363toayJ5jPXYLDmg5+qcnAyFBkqhkW5K7xqanQXe7MM57BfAlq8bwc0aai24zAn5nTYS58XaFLpv08JhZPEZzRgPjKUzic099zK8//FAharzrkITdPlDxdS/9T+LUNuqpuTyjl5ZaKZp63lvpVBSZoTyu+qFsnkfF9LKts0Zekj/Bhc0iwYOHBv7xjNZv+Sqs/QAZ8/yQINZhEPvOcX1b6D4CH2PdO/9XzAErH4w786mFkkF+P66Mm23PfA2nMGcam7plyQVyl4pqU3z+fi+qrisox8B6rdkg/WWBLaNxlxLhdOwRzDpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxBZz8y+sX/hxZKVUr3CVuuWWtOWd9u3NVtDN+ydXb0=;
 b=acxbLm6YGrn0CfSuFIi83P9dn32bYP4hzIITfvhpU+6jMo8DuKWSpqy2qRaZZkLXFXUp4koZFLHnxzQSBqDTrEcyfpb0ud1ZKG/Y1fYEVXALC7oqH6cLNsnlJjfj/2JsdVzeDHuSbUc/mYmWr1H+T4iOd+0s+zvgwb6JzNJbhZg=
Received: from BY3PR18MB4708.namprd18.prod.outlook.com (2603:10b6:a03:3cb::17)
 by PH8PR18MB5382.namprd18.prod.outlook.com (2603:10b6:510:255::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 08:55:25 +0000
Received: from BY3PR18MB4708.namprd18.prod.outlook.com
 ([fe80::6f9:3adb:ab46:9b20]) by BY3PR18MB4708.namprd18.prod.outlook.com
 ([fe80::6f9:3adb:ab46:9b20%4]) with mapi id 15.20.8398.020; Mon, 3 Feb 2025
 08:55:25 +0000
From: Igor Russkikh <irusskikh@marvell.com>
To: Jacob Moroni <mail@jakemoroni.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net] net: atlantic: fix warning during hot
 unplug
Thread-Topic: [EXTERNAL] [PATCH net] net: atlantic: fix warning during hot
 unplug
Thread-Index: AQHbdb9Oq+K+sFxG2UOb6eX82Jla37M1Ro9Q
Date: Mon, 3 Feb 2025 08:55:25 +0000
Message-ID:
 <BY3PR18MB47088FFA08160AA078E2CB1BB7F52@BY3PR18MB4708.namprd18.prod.outlook.com>
References: <20250202220921.13384-2-mail@jakemoroni.com>
In-Reply-To: <20250202220921.13384-2-mail@jakemoroni.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4708:EE_|PH8PR18MB5382:EE_
x-ms-office365-filtering-correlation-id: e9bef4ff-0e92-4b0d-0b97-08dd4430805c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWROVVF2VUpGSk82OVJCcSs5dVM0NjB2Vndna2IzNHcydUQxaEZqbjF2M2xS?=
 =?utf-8?B?ZWxaQ2JHU3FzWUZERTR3eG9ocEFVd3UzS1ZGbWJ3WlFyZlFIU0Z1bzlMT0Rr?=
 =?utf-8?B?ZCtXT2lSK1ZiUVVFY01qVHFyUCszdis5YkljMzZzMHE5MW9BVkdCdEFRZjJk?=
 =?utf-8?B?SUpHcWNrWVExeDBOaVdtcEpnOEZKM3haMTI3enZKQnFkS3lnT205WmRaSVEy?=
 =?utf-8?B?R0szK2dld1NHVUZhR2grTmdFUzlFQituby9LdmNnMnhkOVFxVXc0WXhmdDNN?=
 =?utf-8?B?ck5jREVjL1k5cks0dWtSSjNrRU5jUzBNNWNtekdpaU5EZ2NSa21VREJDSVFW?=
 =?utf-8?B?S25GZ1Jwc1NLakxTa3ZSMGNCUGRaeUt5OStPdnF4OG42c3BDK1dyMmlIeXdM?=
 =?utf-8?B?QWlOS2hWalhUUi9ZMGFna1VoZXlvQUNndTY5anhmZmhKWERITDhDbUZJeXAy?=
 =?utf-8?B?b3g3SzFvZGtzbjZ5RkR4UnA0QW1QZFpndzV4dFQrbXQ1eVUwSGdhOGNodzNz?=
 =?utf-8?B?ckh5SjlydVh6NUJudXdvdmxkeUtEZUJqY2VNUzVqb0JGZEY4MURWTmxSaDBL?=
 =?utf-8?B?aC90RTh5OGE3ZDA2eHFXRmVOUUpLM0NyeVVHUXBTS1lwQlo0WWRlcDVvaTds?=
 =?utf-8?B?NFVJOUlOUVNDUmNCYnYwMUk0QWhQWWUyOVE5ZFBid1FieHROeHRkRVYwcUpx?=
 =?utf-8?B?K3pidG1BZ2Y4SUgwYnJCRWNkVXJva1BHdUphVTREQlhOZ2ZKMk51alFaRWdv?=
 =?utf-8?B?ZDRVTDJDZHZNQVBlMHhiamoxU0dpT0Vub0g2N3FhODM0NGtwSFZrVDdrNHk0?=
 =?utf-8?B?K09KTTdIRzdwekw5bmdubEJMRktDbGRCK0JLVkNPUnYwSUY4cVYxUXdQd3Aw?=
 =?utf-8?B?WmhSeDJsMTVuYU50RXVibFJPMFgzcXZ6b2RHSlZiakp2MDltRU5rWEZneVhY?=
 =?utf-8?B?ZERTUVJyN09CNm80M0x0T2xYUC80bzFVL3o2VHJYY3JkT3FVb3R1RGVvcVo1?=
 =?utf-8?B?UnlPQ1RmdWNzNjVUVzR0c3JiK3RiRlhKbnNKdHBRRTNuLzZvVXdGQ2Z3bDBk?=
 =?utf-8?B?MUNWRjE5bFM4Nk9JWmpneFI1N0J4MzI0aUJ4eUhzZmJNL1hiVnp5a1RJY29D?=
 =?utf-8?B?ckxsZnBKb2JGUkVaNnY3ZUxRVG1nU0lqRWV4SlBhZWlNRTNpb2tONHJQa3Bj?=
 =?utf-8?B?YmFkMm90QTh0Y1Y0VlY2bk0wR2hCenhCSEw1YUFVMDBtZmtjNVhNanlvZng1?=
 =?utf-8?B?UGxxb3VQejNxOUZiM0NVWi9Kd3doc1V0azNJRUYydkQyWGRWYnJpNUFJcmZV?=
 =?utf-8?B?VEJycEtocEFza3FrekE3WEFrZUF2N09VZXVDRys0QXB2R1VQK2VHVER0Qllv?=
 =?utf-8?B?eUViZ2V2WXo2bXJjaDhUT2ZZbUhnMTlSUmMzdS9oV1hDMzQ2cmxCa09vZ0k1?=
 =?utf-8?B?TnJhR2wwb2pjTjJJUEZmR1dOUXRnT2k1bVBvUVZjRCtOZGJWLzQwSzlKdFpn?=
 =?utf-8?B?L3R2elpQS2t0M1BZektlOE1kMWViYVhBN0xLaDhlbGVTNExnRDBVQ252alEw?=
 =?utf-8?B?UWtqc0xZS1RRMFdLR2oyeFQyMXdvQXVDQ0owYjlFK204QWs0YWNLaWRkNzZ6?=
 =?utf-8?B?b1VVaWs5ZnhRRG9Ba213S1Bpd2IyZFQ3UHcybldTUkk2UHcvYk5Lb1N0a2Qz?=
 =?utf-8?B?MzBpbEpTTUN6NitIM3BXeU9zV2pQQ24wMzkrUkZ2eCtHd1JkRVR0SlRyTW5Y?=
 =?utf-8?B?NUVOeWFJelAydkpCYjJFaHBNUGVKbm9pMlE4dlZvZGcyTkZ1UEFKeDAyUkVZ?=
 =?utf-8?B?R0RKQXFLbklNc3RpWW83U2FWNllpOWpuempNOUJZUTZDeWxRNHUyZDEwZk9z?=
 =?utf-8?B?OTVIZHYvZVVEN2xjaXAzYk5kbmZ6TFZkdW5JRGNabDB5N3JGVlY4WnliZ2gr?=
 =?utf-8?Q?tmGs1iVILNmzgRGsw7gu6kbyrpQ4tIhL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4708.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wk5yV2RPY2ljUmNSelBSaWRiSEtkMHNvR1VuNzc4aDFUcnJjaGRJQk5DQ2lE?=
 =?utf-8?B?RDR0amNsWGZVekFmWkgwN2pjUWwwNVlMczhKRU42NTlRZ3MzbnlSeWFnbGRs?=
 =?utf-8?B?TDFyLy81a1VBSWt1V0lHK1d4emlHOVFnUjdzU0dBdWZrOS9PTER4S2ZtdHlx?=
 =?utf-8?B?Q3VpWlFpSWRGYWxYR3U3a2ZqbHExV0FxcGtDMktwc0RTOWxOWVFLN0U2bWxO?=
 =?utf-8?B?S3ZCN1FRK3pnbG54d3pYejdReWFsSnhQZUtlUXM0QVJNYWs3NGlVNUxvMHgr?=
 =?utf-8?B?UFVBZHIyaWdVMlJ0aXFyRnFGajZwODFTY1ZKSHo0cTBSRSs2VXlzay8zRE5j?=
 =?utf-8?B?YmJxa1EyQXJJUmZzZlFBbXp6a2ZmbzQ3cVRkZ1RaZUZkOWFINDR5b3pNZ0wz?=
 =?utf-8?B?bTdUMmlZd05URzJvbmlhRHp4RmpkVllMZVlkR3NhQ1lrOVpqaWcySElqT0ty?=
 =?utf-8?B?QS9Cell1QlVzdU5udHpFZm5GTExkOUpmUEhnbXZTWGdIK0dDNmlTYkxTbEZ5?=
 =?utf-8?B?cnZIVTAweEVwcjJndlJxdFdYRnZacUdWMVBCWDE3Q1hzTFlsaSt4aGhwWnFK?=
 =?utf-8?B?OFkvczhYV3pOVzZhSzl1SURISk1sODZnRmhJVTlYZWZIaDJrZ3FnWldUT282?=
 =?utf-8?B?OXZyMjBTb1BTZE1ZVHZFK05WaGVaOTFnRk5YaVp3Z2hNTyszWHRibENSaXph?=
 =?utf-8?B?RVVnWUQ5SGE4dm95NWxLTEE5cTllTWNaOFNObW9GRGJUTUpjelFSZVZ6Q2FG?=
 =?utf-8?B?blFGaFU0dHVtSjNKYWI2RUw0TnZuTjUvRWlBOHVxeHpYYTNLbFJ0YjNVNTc0?=
 =?utf-8?B?ZmJMVWdyZlNFb2s4dEVkeXE5VnNaWkVnakF5NzU1Nm15bGw5bUMrQnhseVRG?=
 =?utf-8?B?SHhsVlJnSnJnNFFrQ1V0aXR6WWl3bkZmWnhtdm5GNEpsUjliUVZIekJ4c3A4?=
 =?utf-8?B?N29NNzFiRFM5SWtjdW9zTlhhRkk3aENIeUxEeXFETm94OUltRStKU2I1Tklu?=
 =?utf-8?B?YmIxVmtGWUwrVnZIVlplQ0JpVk9INWw0S0k4cWY5NS9PQ1RoNEcwd2FmM3JF?=
 =?utf-8?B?cEVTaVo5elp5a3JHRFZuU3pTdThraHRaSHp2R3VOUldORWxEUGpYZFc5SGhM?=
 =?utf-8?B?R25QZFpyZDBmc3hjWDVlSnNYb2NLdFNSSTF2eXJnUWZBdFh0MEJJcXVrTmtk?=
 =?utf-8?B?bTBUeGVHZDUrYUpaMllXUXpjeWl6T3Rld2llclc3c29xZ0hEY2tlVXJMeXNv?=
 =?utf-8?B?bWQ4eHZGQ3FuMGVYQUlVTnNUM2FneDFZZXU1NEYxZ1l2UUFCRnFLUUE2VnR6?=
 =?utf-8?B?R0JUTlJZV1ExS2ZxWEV2dUpQNVo4R1Z2THNRMWQ1cU8wM3BzSStBOFZIb0FQ?=
 =?utf-8?B?MU5POUFzYlBQZjRFWjU4elFvTVJScUQ0M2RqMFBpTzdNaTBiNEtFaUpOdSs1?=
 =?utf-8?B?TVdsUElkMUF2bDF5dUhyekR3QUF6SlZrbjNTNHBLZmh5eElucVJJeVAzTHdG?=
 =?utf-8?B?RW8rU2lhaDRyUWlMbjdUbDM5b21PaWJHTlNlUmtkakpVR1hjNGRsZ2h4OW0z?=
 =?utf-8?B?c2xnOGNtT2RiWW4zZEpnbFBaWTMyOFV1eTJEVEhwQ0tGTUtQOVFXdXZjOVUz?=
 =?utf-8?B?ZWdOellNZENsZUlIcStqeE9xSk91bDE4TStZTkpvMDFhTXVFVTRVVnBXaXZ2?=
 =?utf-8?B?ZFl6cDc3M3lPYTA4dFBibmhsNHpJelRLN0lCN3NMSlJsOUtERGtvbWJGNkE3?=
 =?utf-8?B?RkFYK29PM0pJaGxFbGZ1OHVDbDFrbXQ2NGxVYWR6VlhrWVpPY2U3WEtEWDE4?=
 =?utf-8?B?cTdYcXg4Yk93Q3lpMUd3cFluY3gxV3VKa0dLdkZ5N1JwNkoyVTd6ZGsvdmsy?=
 =?utf-8?B?WWs0aXUxbWpqYmk5NVlrNnNTRkVHaStadnI5QTdIWWp6LzNGRU1Ma1dBUk9C?=
 =?utf-8?B?VmxDMXBreFNJc0VXTWZ6d0pJVFlCR2liZHQ1YVB3Z05vbkUvU0hEaWMrYUNW?=
 =?utf-8?B?OFM0T3lVVUZkak5kaktxZkdSd3dweUlzVlJ5QmNuUjBQK05XdFpGTW94dE9K?=
 =?utf-8?B?b2VyQnJTcENSWEUxS0ZFTkRtZXBVOERsRFhCcVZyeHRvWi9wUmtTWXpYQWdD?=
 =?utf-8?Q?qVZXqnxfcZ9/YTu+d/aSSS+PR?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4708.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bef4ff-0e92-4b0d-0b97-08dd4430805c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 08:55:25.8718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdPrpXr59zs0q9j0MM8jcsY3emuOK+BIPw6A7thn8e0sCLTYqJwwmUHnM/lZWKVTUCE52lVvJuDD6E2HOMu3Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5382
X-Proofpoint-ORIG-GUID: usQTzU0L4bc5VAKwihlW6wlVG0TTkoLe
X-Proofpoint-GUID: usQTzU0L4bc5VAKwihlW6wlVG0TTkoLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01

DQo+IEZpcm13YXJlIGRlaW5pdGlhbGl6YXRpb24gcGVyZm9ybXMgTU1JTyBhY2Nlc3NlcyB3aGlj
aCBhcmUgbm90IG5lY2Vzc2FyeSBpZiB0aGUgZGV2aWNlIGhhcyBhbHJlYWR5IGJlZW4gcmVtb3Zl
ZC4gSW4gc29tZSBjYXNlcywgdGhlc2UgYWNjZXNzZXMgaGFwcGVuIHZpYSByZWFkeF9wb2xsX3Rp
bWVvdXRfYXRvbWljIHdoaWNoIGVuZHMgdXAgdGltaW5nIG91dCwgcmVzdWx0aW5nIGluIGEgd2Fy
bmluZyBhdCBod19hdGwyX3V0aWxzX2Z3LuKAimM64oCKMTEyOuKAig0KDQpIaSBKYWNvYiwNCg0K
TWFrZXMgc2Vuc2UsIHRoYW5rcyENCg0KUmV2aWV3ZWQtYnk6IElnb3IgUnVzc2tpa2ggPGlydXNz
a2lraEBtYXJ2ZWxsLmNvbT4NCg0KSWdvcg0K

