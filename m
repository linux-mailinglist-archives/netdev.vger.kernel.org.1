Return-Path: <netdev+bounces-256964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLJmHxsnhGlRzwMAu9opvQ
	(envelope-from <netdev+bounces-256964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:14:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D582BEEA87
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76A50301BC21
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76630C611;
	Thu,  5 Feb 2026 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="d/DwcIkV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661F30CD81;
	Thu,  5 Feb 2026 05:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770268424; cv=fail; b=kkCRnLDpPwZpG7OWpNB8LEe8dRbMN17wNlvEU4JQQe07USXV0cysSe2B0gbkB3GJz0z8tX3rP1zOj6u+aQzaxCpcjL6kgbNxdJQRqJOBOJM44w/K45uMI6LvJxrzkQZmVn9I0B9m6tkdMZnaGdnCVoQmanH6qqy5VbEXdHKSkpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770268424; c=relaxed/simple;
	bh=+for0yiblDRz4VQ+emedsthaat+ltaj+d1/Ul4Ylq9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=LsPK6Q2mYmweJKCMSDlk2y+ixWMw1CuhWzP1JlSboXzoTdFmDjBzPqAdUv/cgedneIcdslYxZcYjNbdCWJnBLGISCwDs6SHgNcu6VP0aTXJOEtBTBwS2F2mTJg0UNHwTTY7cz+xrzI4U0XMrPupK68hhiRVaUko91skEHuM7zHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=d/DwcIkV; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6151H9sw2434899;
	Wed, 4 Feb 2026 21:13:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=yo+yaFVzG4mV8SUM6apXkR0T5eIgQePwXSFdiKJtLzI=; b=d/DwcIkVWgTi
	U32XmxJjJ4xzt7+7VYOsJR6/QGS0XOFQTeNEvZe6L6GQE7sGmUQjfpVa/zQXyc69
	fDTFPRz4zgLQMjPvJFfSch07XyXowok0htqV8+PdZM3YaTTAAFxrdrOB5F7HslUd
	BbxTbGhVL+cDmOhp273MrJgEPLfW8uC9F34cAddPL9Mo4YI9fobhhsZOgVgJ8RMA
	oD10InCp9WSV43gyXiFyEDVeF+tg6kuz3Kd0CMD5VGVaSSdwVDKL5yuaN19pC08W
	iyE/pqmSU4hqUxueayWMrJ+99xC8IaC2zz9KIo7j2azbDLUoT+3yV6eM5shPD811
	ZD81DMFjXw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	by m0001303.ppops.net (PPS) with ESMTPS id 4c4bt0wsdw-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 21:13:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEpIn64jljkK3S3qUyPRLyaQyR9QsbYtDXfDmR8w5HOrnGIVHV99ucg4QQ1c2Rl8ijyM+/By2ba3xFm1EH3kpSrOsCbaJZmiQyRzYxesAednyxH2fm4mBt/aXr8Hu4SNJ1vTAtn7WPQDs3dWPnppvAJdNBWEHa3ktoVlX9sWOSNiUp3q9GP5oMpvxj++4rWhbeEk97dHZ5vn12WGCug2+UxoHlHQbvqiXARVPn6dzJjeARnDkXGlLrcud31vWZHu2+ZqkgfjXx/hLKWrXkR/1Jzfopy3kNAlxntvqULtqGOrUK5QVj6Dw6nvqJxwqOHY0HiUDpze0IyQnyns+nh43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZnfWZg9h6q6GT9LGnq5Qr66COHBFNzq1PPnBalyDP8=;
 b=uieynk+voKsNQIQW6FDSoEiRj2oRdw9zvMpo4JjA5T0ofQuoSF59J6T/Gh5P0VBb4t3Om5zk9LIldyfgEKs29apk++pagd2915Sg7YGWIplBweQ+SaL7GPjWxdvwoARe246WZIsJFsd33X629MTkTLSzH+W4NVOFEJOWbqHaBgF8GsZOFd5ZdFQ2R+xt29mqqFD263JFAV6fzMSeIAPTbCp68k605JO8iwx0PYGGMtngS+1Xm65e0oS8BMG8mruQ0Dzb0ZQSaCKURT94HiBdMkjngiu6ExAaqC5fBANOa5UzwXsOtNbH1zlmDpI883rnyrxBxAMTK7PzDw6TMAhWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by PH3PPFB7DD68BBC.namprd15.prod.outlook.com (2603:10b6:518:1::4c2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 05:13:26 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 05:13:26 +0000
Message-ID: <c924f14c-b098-40c0-ab09-85421dbe1932@meta.com>
Date: Wed, 4 Feb 2026 21:13:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] selftests: virtio_net: add buffer
 circulation test
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20260204193617.1200752-1-vishs@meta.com>
 <20260204193617.1200752-3-vishs@meta.com>
 <CACGkMEtMgNpoSeUUFt10LJZqtTpi1atbPJwpXDf94AyzVKxvqQ@mail.gmail.com>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <CACGkMEtMgNpoSeUUFt10LJZqtTpi1atbPJwpXDf94AyzVKxvqQ@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|PH3PPFB7DD68BBC:EE_
X-MS-Office365-Filtering-Correlation-Id: dab9d092-8487-47e8-0e47-08de64754953
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eC82bnVEUzVtN2Q1OEppbi84M09YTkc3TlJwMi9ZMHhDcXRjVGFzdnNQU0JH?=
 =?utf-8?B?Z1hYVzVrTThOUDFIcmMvUnVBeGVUU3padURtRU16NHBNSE9DNXV2KytBSkg4?=
 =?utf-8?B?TnFXTXdOZEcrbDZST1FTN1dzbkUxK0pLY295ZEZ5RlUwUGtDdHdxQXA3Y3Zh?=
 =?utf-8?B?d0RSVVJZN25hNTV6UHBId2NJM2lwYUN5NU1LRVZyaEN4K2NnWkt1NzBFSTBx?=
 =?utf-8?B?cHRCSnNNKzBacWJpNWZxb0VJcWZNbnp1Z1A5NU9FUzBhQk5sNHJ6N05nWWlz?=
 =?utf-8?B?YW1HRDVHbG9WVWhrYVl2c25ud3NQVG1FTlN2aEZ0em9QaHdEYWJDLzJrREtL?=
 =?utf-8?B?enlqZWRnYXd5WStRWjBKZXJnYm94ZGZyS0xiTDJMZnFXQnBha3dlVkNlWGdJ?=
 =?utf-8?B?TDF3bnNibnk0eTRqQitTUnNJMGg3YldQODd2WTBoelZLUnliVWx4YUkvNVd1?=
 =?utf-8?B?Y0dCSVRpQTdEcnF5R3BGeCtiU3MwTjhRZzQ2bUxBWXk4SzIvNG5uclpSZi9p?=
 =?utf-8?B?OTJ0U0V3L0ZGZUFFZDBLdXBmSGR0TWx3L0xISCtTZ3lTYWtDK2JWamdZVEo3?=
 =?utf-8?B?dTFvNUZzQ2hTYnk5TUVSajFxOFVOTWFWYVhoVjVHMjJvU2tQMitjamwyaU5Q?=
 =?utf-8?B?MjRVNmNaQ3pEbDd2NkZQZWpzMjJKTTlXb2tKVUJZUnAra0prWEY3Ly9HZ0hQ?=
 =?utf-8?B?bEV6OFl6OVk5VnRCSGJOemZoVk1zOXBZTmFkZUlVbUtwdFhidFh2Y3JrSkk2?=
 =?utf-8?B?Uit1cjRtVlU2TGh6YUpYV0VsVW1QZTBNRkMydTVERHJ6ZlVENXRQQXIyeGRr?=
 =?utf-8?B?QjBKSlFJTG56VkVaeGYveXUrNEpiWnJBRExwVXRlb3U3NEFUdWNqNGsxWVhP?=
 =?utf-8?B?ZkhsanNucTN6cnI3NGdzRDI1OU5lWVJhbnpFQTJSY1Vaa0RqNjltMk9CaWNm?=
 =?utf-8?B?YTJ1cE5BR2NxdGR3Z0ZxVVpxMWFPV2FiMXBTWFdXZWFXSmYrWEhsdlFDNmMx?=
 =?utf-8?B?OWZSTnB1Qk9UbThkNzBrVlNEL1EwdUJrRVpjWE1nZmZpbnhWUldYZ2R1dDVq?=
 =?utf-8?B?TGFjTVFHWUtDTGNJR21KVHZ4NlpuRUpTNC8vZG9sK2ZEWEhkTzFRcU1leXBz?=
 =?utf-8?B?Qnc0M0FzbURwclhUbUtoZDE4MFYrY3kxSzNGbll5ZlZRYTlCQmZPQWVCMm9p?=
 =?utf-8?B?TThKa2lEbDdSV1U3UVRkOER3Q3JzWnJ5Qmh1M3hJUFVITzkzaExDVW9rUlFt?=
 =?utf-8?B?NWhaQ3NXQkNYcXJVRlRMdEcwM3cxNG1FVW9SMDk5MXZJaVN4aUFaVklvcENK?=
 =?utf-8?B?N2Y2MkJzSUdjblB0Ym9oNDVET3ZhRmVKb08reGFQWEZtY2k3bkxKcHVSZzI1?=
 =?utf-8?B?NWN5Zi9NcVR2RElLaGFSMWlWckRvUGF2SlA5ejlmODdubzFVMlFlY1JPZC90?=
 =?utf-8?B?S21rT3dvK1ovZHA2WHhoS0cvT3BkSnNpZWZqNFNwN1ppeU9aUnd1UWZUYmdQ?=
 =?utf-8?B?WnRGUDJIV3dlc3dSc1paNE13ZmdkNFdWZXVXSlF0QzZGdU1YMGpycjd6a2Ft?=
 =?utf-8?B?Sy9kZzdFR2pjbkJDaGlVSTdBU2xmY0lTSHh3UGt0OUxnZmsreHZWNStpbElG?=
 =?utf-8?B?c203Mnd6MWRlUFhlbkxYNGpPK3NNWGFZQ0dXd0lKdWE5eERJL3I4OHpMTmUr?=
 =?utf-8?B?eHJFbWYwQ1dTejQ1TkJhYUdHa3RGdHd4WGw2NzFYUkl6K2hOWk1jK3FkSm83?=
 =?utf-8?B?UEVSVTNJamxMTGt1V0ZyWDNYT29BRXpHRnczdGdMNUNLeDZlbExpejhxRXdm?=
 =?utf-8?B?anpsbXRoajY5TDBvbjdpZDhoSE8wWmFvV0xnNGJjYnM1Rms5cEYzYnl3Zlk2?=
 =?utf-8?B?akVkNGRkbjNFVXNTdDg5MVVOdzV0YXhNSjFpVlJPYndnWXNEbFJWaG1aWW5H?=
 =?utf-8?B?M293YW1GZm4wV204S3A5S1RQU2F4bWdBUGdoRllKQWlLMWFiek5WbksycFRk?=
 =?utf-8?B?VHhXQ3hGaEo2b05rRnJsSk1FZForbk00QVlZM3ozeGdxTzF1OWo4NWhsc3VE?=
 =?utf-8?B?dEsrTnRaTVJheks3WG5vbkdUcks4REd3eGtJOGFVRUVXM29WMzRyQktIY1dD?=
 =?utf-8?Q?q9Dc=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MHQzb1AwMzdJT3hnK3R1VXlzN25OVWc2VWNBRjkyaDNMSGFJaFIvSW5DRUJ0?=
 =?utf-8?B?QmNnYUlkTWFmSldQcVVKQnhTRStDVVNNWjVDQVB0MUptajM4aytLSVkyeXVG?=
 =?utf-8?B?aTQ0MmdpNlk4aTFUMDZJRnNmeDFtaDljd2k3VE1COUZtYlo2cDQ3TFBhaWpr?=
 =?utf-8?B?RzJvM3d5T3BnZWYybWxCdGN2eDNEZVdvazgwSlZ5bHA0T09ReGlmQzMwcU4y?=
 =?utf-8?B?UmZIQ2pvMytFMjRkZW42c2FnRnBaWDNGUHpKdkNrb1d4MWpUbzRFcW9zSGZS?=
 =?utf-8?B?bWZYQ0I2YlFQNERLa0Y1YVN5RVBtb0haV0NFUS9WeFpzVHFsaWtyUnlaRERw?=
 =?utf-8?B?SFExMk5POE1yV28yakV0Y05yNGdkaVA1TEtRekNVWHhxRFdEL1BHTnl4WnJJ?=
 =?utf-8?B?VzdoNVFHRVUzS1NuWFBwRmkxNXhGVGRkdUJBRFNsSGw0Nlk1KzdNSUgvZm4r?=
 =?utf-8?B?QWk0L0gwdWlwd0sxWlVvdGMvNW5lc1NkV2U5YURPLzE4NGxlemdHOVdjM1l1?=
 =?utf-8?B?bTRTaG1BcnlvUE9tbTJheVVBWUJmQ3MrWHk5Uy8rb2doeURnSklKUFUrVkxu?=
 =?utf-8?B?Y05HQnNwYUZNZkNMZlc4U20weGFkMVlocmxuMGVpQmFrVGJZWFRrOE16cytp?=
 =?utf-8?B?ajJPRW1VS1BqZGVXODRTMEVqM0xjMkZjcWZ0WWE5bFRXL1lNc3FLQm83WVVa?=
 =?utf-8?B?M0kwOFFhQ1JQMDhyNjBlaGVhRmdDcFJHdmFuaVRRVDFoZWdxVFIrV0toamhk?=
 =?utf-8?B?Ti80OWhBYVZQWnBzRys2VGRFVVlYNmZ6STZQc0ZMZTh5YVhMci9DUDFzRjUy?=
 =?utf-8?B?Z05NRUNMWkFFQm5SbVViUGlqeDhrMW1XcDFvenBxSUF4ais0TFluQ2p5VUl3?=
 =?utf-8?B?S1pydngwWk1IWEN2Mk1nOVh1SzN5NW1VZ01KVEU2VFdGTXY3aDlMbVh1VWNI?=
 =?utf-8?B?RGwrbmVwc1pxS3E1ZmNoWmtIR1RuaThjUklwS0JONyt2bUxGdjYxSE9WWDV4?=
 =?utf-8?B?Z0lReklEek1pV1FFeU44UzM1WTIvVEpsUEdzU0dLWnBWRVpvTjVLKy90THVi?=
 =?utf-8?B?NnRVZWVML3dnQmNMVmJuMkZvQk1DcXdoUlpsZVlBN0ZlekFIUXpyWHNWZlN0?=
 =?utf-8?B?MWM2S2I2QWk5VzNxR2IwaFdMSDR4Y01YK3NLVXZuMHRFeDVrWmZvdmk3a1dV?=
 =?utf-8?B?alpJTU1aNWlxMytKWDY5ZHlCZVFyL0hCWStaMkNtejl6cnA3VW4vRWd1TG5E?=
 =?utf-8?B?Smg5cVNvSEVaSUg2TWw4cTdJZUNlYmhGTkdrRjhTb3B2TUxpNm5hZGZjQ0tj?=
 =?utf-8?B?VDVObWd2cXhjVnZ1bmJXSGpxYVRhdFZIRTdVZjRieEtoQWJ1Q3F5bVp5OXo1?=
 =?utf-8?B?NUNzSTYxdWVGaHNvMzFDWkxXN1MzNUlQcUlmSE1YMVdOZUJxMUh1SWhMaU00?=
 =?utf-8?B?VVhLWU5pcTlmSDdUM2M5dmpjSnZOSUkzZnhqVVl0UEJ1QmcxVnVmdUdIOW5h?=
 =?utf-8?B?QmRXd3RmTGFpakROVU1HZlBTR2N0aStFSTRleEhyOFk2SHhwai80UmpodWov?=
 =?utf-8?B?alcyYzRKbmV4Q2xWbVJ5Q1MrVGRNa1dLT0hSa2VkSVpmdFE1eUxabGg3SFF0?=
 =?utf-8?B?OWczdkdPNWNpSGt5K3BvenFpWVQ4amFXVVQzOWszcllFa2cvREUyZ01FQnZQ?=
 =?utf-8?B?QmJENWQ5bktYR2R6TGNpSFpjZWdLdHEyYnRodXZIK3VYbEQyV1ZORDRsczhK?=
 =?utf-8?B?WnVId3N1K1pLVEJxV1Y5SFM5bjYyUnBjY1UvWTFSSHc1UHVGeks4M1NleWVY?=
 =?utf-8?B?cUh2YTIvVGkzVDlQU0tUV01qcVZaS1BtZnQ3SDZ2NmRSejVGcnh6MHROc3p5?=
 =?utf-8?B?YTZMS0UxbTdseHd0aS9Wenl5ckNaQnEwVkFxY1ZscStmY0x4aFFBeHlaMWRv?=
 =?utf-8?B?UUtoTFFtS1JIZ0l2dzVNeEROZE1PL1hQYTcvS0kvaVM3bzhPSWV2R2xsUDNV?=
 =?utf-8?B?SVlHOFQ1c3M3RWMxWTJEMGN5OU83Qk4xRDlCaFc1UDU4MTIyeFFqZDlzVDgx?=
 =?utf-8?B?b2VGVGlOODZyQ0FVV3R6YjdGb21RWkpiZGlQYWk5YWhIdlUyY0NqZU1yTU1l?=
 =?utf-8?B?ZVQwaXpSL0JnRG5mTjBMQ0d2U3l4c1Bwd0ZNQ2MyaW9GN2M2ZG9ibnpYOVNq?=
 =?utf-8?B?K2JFRnBVVFFnSXBldzV5dUl2MVdVaXd5SlVrZ0dPSlA2QVZnYTdxQXpNMEZI?=
 =?utf-8?B?WU1SOHJsUVE2SjV3cm4rSy90K1JGY3h6Y3ZjekhEc0t4TTJHUW01a282QmlC?=
 =?utf-8?B?SnpyWmxzbThzSTBhNTZjK1pJSHRhNGRVWk9BMHc0NmNOZ2E2ZDNRcUduRzVY?=
 =?utf-8?Q?rtSZ62QJvVi6wbpdLAE2fg6c77unGC8MgQ1+L?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab9d092-8487-47e8-0e47-08de64754953
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 05:13:26.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drxjcpuLn+LB8aL++NlNZEPz/HJOMbZETUe6iRYivLq49UPGcRhqJa/wVtMF2jiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFB7DD68BBC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=JYqxbEKV c=1 sm=1 tr=0 ts=698426f8 cx=c_pps
 a=zHP1L1ZDY46t+2XtVYLmoA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=PwrI3bVlJpkBSoHJLqsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: Evy_brqLc7qiVX2_XhZnE14fvDqj1qsu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDAzNCBTYWx0ZWRfX8bqWU7vXwv90
 b+VTB51REk2NmBz7INfmXYTo3dh1eEc5ellS7vl6K1XsTun7OhS9+ENeLT09Ci3zU3gGI1YbHOX
 jUOadvKMW5/9eF2hPCahkRfDNFDeCiohZx6DcMLoMN+wWu8aK+vIsLy7JyKZugpo2RA9u/Zkyuc
 tisau8MvHwEonJhoSoU8mIjHnxdZsvHOEpW9bVHu2A4fgbbHrHFtZMczhX05U9PGEG1ddeABSKg
 Jjq9a2oFbMXCtKiGUowAJixVyLHuUGQ0BvBXDTQjWir3a0JDmnbFjbGcH/qshI5VadePt9a59lO
 igvK1V8yZWTmM3vJI40+eghNACuQZxWGdRziM4HDElhHVKhTetZJfMiVpGxKez0tPdGZ7ipzxr4
 eb0//j+nwTOMWBuMKq8tcOO1f/GlFnkuFqnfc2yyidbVOHcGLt/2mEhpi7mCutoVBXSEdaW1WU1
 LW8jXC7QFbujjTMyMzw==
X-Proofpoint-ORIG-GUID: Evy_brqLc7qiVX2_XhZnE14fvDqj1qsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256964-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtio_net_common.sh:url,meta.com:email,meta.com:dkim,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D582BEEA87
X-Rspamd-Action: no action



On 2/4/26 8:12 PM, Jason Wang wrote:
> >=20
> On Thu, Feb 5, 2026 at 3:36=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.c=
om> wrote:
>>
>> Add iperf3-based test to verify RX buffer handling under load.
>> Optionally logs page_pool tracepoints when available.
>>
>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>> ---
>>   .../drivers/net/virtio_net/basic_features.sh  | 86 +++++++++++++++++++
>>   1 file changed, 86 insertions(+)
>>
>> diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_featur=
es.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
>> index cf8cf816ed48..fa98505c4674 100755
>> --- a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
>> +++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
>> @@ -6,6 +6,7 @@
>>   ALL_TESTS=3D"
>>          initial_ping_test
>>          f_mac_test
>> +       buffer_circulation_test
>>   "
>>
>>   source virtio_net_common.sh
>> @@ -16,6 +17,8 @@ source "$lib_dir"/../../../net/forwarding/lib.sh
>>   h1=3D${NETIFS[p1]}
>>   h2=3D${NETIFS[p2]}
>>
>> +IPERF_SERVER_PID=3D""
>> +
>>   h1_create()
>>   {
>>          simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
>> @@ -83,6 +86,84 @@ f_mac_test()
>>          log_test "$test_name"
>>   }
>>
>> +buffer_circulation_test()
>> +{
>> +       RET=3D0
>> +       local test_name=3D"buffer circulation"
>> +       local tracefs=3D"/sys/kernel/tracing"
>> +
>> +       if ! check_command iperf3; then
>> +               log_test_skip "$test_name" "iperf3 not installed"
>> +               return 0
>> +       fi
>> +
>> +       setup_cleanup
>> +       setup_prepare
>> +
>> +       ping -c 1 -I "$h1" "$H2_IPV4" >/dev/null
>> +       if [ $? -ne 0 ]; then
>> +               check_err 1 "Ping failed"
>> +               log_test "$test_name"
>> +               return
>> +       fi
>> +
>> +       local rx_start=3D$(cat /sys/class/net/"$h2"/statistics/rx_packet=
s)
>> +       local tx_start=3D$(cat /sys/class/net/"$h1"/statistics/tx_packet=
s)
>> +
>> +       if [ -d "$tracefs/events/page_pool" ]; then
>> +               echo > "$tracefs/trace"
>> +               echo 1 > "$tracefs/events/page_pool/enable"
>> +       fi
>> +
>> +       local port=3D$(shuf -i 49152-65535 -n 1)
>> +
>> +       iperf3 -s -1 --bind-dev "$h2" -p "$port" &>/dev/null &
>> +       IPERF_SERVER_PID=3D$!
>> +       sleep 1
>=20
> Nit:
>=20
> It's better to use a more robust detecting instead of a sleep 1.

Can I make it similar to wait_local_port_listen() function in
tools/testing/selftests/net/lib.sh? It proceeds as soon as it is
available, but checks the port every 100ms.

>=20
> Thanks
>=20


