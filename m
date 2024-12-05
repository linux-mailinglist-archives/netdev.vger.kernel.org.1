Return-Path: <netdev+bounces-149324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E509E51FE
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1427C2834E6
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72811C2323;
	Thu,  5 Dec 2024 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="idPJenJA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC182F56;
	Thu,  5 Dec 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394067; cv=fail; b=bkWT0IYOcMEYri53lYSoxEZxFGH+uY0L6N0CsmSmz4AjiiUmpADmqYI5xEQ6QLybWGqdWuqGwZ7+g9QVl695jiuhcydg+0xSnxaYPKd3J41qdy28oLeJNua6yusYFuNo18SfL64GxDC3eGScU9FoH2I7Inja3cPxAry09kBbdNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394067; c=relaxed/simple;
	bh=Skw86wqmo+TdvWgeXtsNUMC16Kj9UXzC8ypNlOkDwog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XQrH8EEA8zOye7wirAKHmoe3UiAEZpH+2gmKI2DFBCidrxYDY4fCidElt+7XkmcKylg384R9ao8/3gwEBjMKO3gAMSFerRE9JeQtbS4n/GGFAdKmPz6RBawrIhLBX2of8VLiHkpTgqorui32ocYlTCO5iTs/PvyC+LsrS0QP3yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=idPJenJA; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B593b2C026874;
	Thu, 5 Dec 2024 02:20:52 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43b979r49s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 02:20:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jfj0rxUWljsfp0F28pi9eR2/FYaFfKFGeOyOsSHrvNG3oML5e6RTeL/V5p38bCbXFlE0RCKYqxGNBBg1seDPysC+Ao/iv1sXpKZUlUblUOzHmvQ/0CFrR+Z9WnV3Sy0UuvCj6S2bWxGmOJh56lbmWnqggU7Wj/x8gUyQQoQRAU9wbw0ivUU3PjMX1dZH18EGXVvUbTvj4NI1rjWbSg4Y048s+RtoydFVfFNYrbyXd9T+h0jTq/vXWgq/Jlp8TDTSINUVi3ZyjI5KYQQ0Q1Uy4Nf38aphGhUtTFR2phbf5rMbVwWPKmb82HclEszTNncH1jdoOk3PqsU9UZ8vJu0sMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Skw86wqmo+TdvWgeXtsNUMC16Kj9UXzC8ypNlOkDwog=;
 b=moOdDKiEkI5Ul1hx48H5dnBvus9l7GmkR+zNQeEn6OqT25twkSrBhbV7HImZSbDg8XGbc8mO99GvMeQdEERDQD6rUX5YDN+eh+EtwIaHDknH5IguPzjLIsQ2ofM1ETFuGE7XNWAVM8DJkozuiAlNs6cFscnd6vZw4p1EpQMvJXuG1VkuxvpsC7AkXgc/VFwoaTAdrQuS4tnp7V7Uz1HbWidilbh3l56W8gchmxesuRxsqVXKV02XLq0bQrTvh44WMKrVggSpj2+4J0U1hv5RhQq6xAVtZDNt6FQyx2RbARyhY+Ggx7y+kuP4wqaT1QqTk8+i6OJVyiT+S5HO9hn92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Skw86wqmo+TdvWgeXtsNUMC16Kj9UXzC8ypNlOkDwog=;
 b=idPJenJASaIR7jMOwkaB9JgLyNyH5OS723YjyhaQcWL1yw1l+5klsLGEBoNsvjOMKStbXAY8YXa7/7z0x3qajqO0mKQl34CwuZ4tC2N03tWTlU+Ysj+0ovw45rQrUnVPRpKVsQuBxw8UasoEcGHD8OjRm8cuYp+gLzyDHAW3Lfc=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by LV8PR18MB6047.namprd18.prod.outlook.com (2603:10b6:408:226::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 10:20:49 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 10:20:48 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "horms@kernel.org" <horms@kernel.org>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "edumazet@google.com"
	<edumazet@google.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net PATCH] octeontx2-af: Fix installation of PF
 multicast rules
Thread-Topic: [EXTERNAL] Re: [net PATCH] octeontx2-af: Fix installation of PF
 multicast rules
Thread-Index: AQHbQMJcpRtKgiG/4EeYSqUREkMcH7LUTUwAgAMvUXA=
Date: Thu, 5 Dec 2024 10:20:48 +0000
Message-ID:
 <CH0PR18MB43399A15FB4322C391E79B4ACD302@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20241127114857.11279-1-gakula@marvell.com>
 <96747b28-1548-4503-838b-e7a994be4647@redhat.com>
In-Reply-To: <96747b28-1548-4503-838b-e7a994be4647@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|LV8PR18MB6047:EE_
x-ms-office365-filtering-correlation-id: f0543a1a-627c-4abf-9fa1-08dd15167d0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFg3TVlNNGhTRjllbENVdWw3Q1grcGlraFhTNXRBVjZFb2E2K2dGK3RwYUtk?=
 =?utf-8?B?eVNTTWdYWmpTK2llR2loVDNHY2NuMk9jQXBtWStwUHRTVWg1WGRBMW9pK2sy?=
 =?utf-8?B?STRCNS9xb0dTOHNsUGtNZlBIOU5KSXZhL2hoZW5oWEd5eEVSQlA4RFlHci84?=
 =?utf-8?B?QmRTUmsvQmhsaUhMRnRXZGFLK0JDNUJ5dVdIVy9nblJ5b043enBVK0h2QmVJ?=
 =?utf-8?B?ZzgrTmtXZGY1bnRnWDlnQUZzZjl2eUdENlRlSWlDSHU2aFgvcmsza0lXbWlq?=
 =?utf-8?B?S0FnNk1KNW8rNFI3WUsvTkEyYVMwSnpickVDWVdZOFVlYkNlUHo1UG5JcTJG?=
 =?utf-8?B?bndrN2pJS09VOXI5SkZFVXNGc0NVeXlhUFpqaHA0R1orRXJkby9oK0tqbEZ0?=
 =?utf-8?B?NFBzQW5UMnNTV1Foc0VmNzcrRDFTWURPQ1ZQZkJmd1N2SXJCeDlaRnlBek93?=
 =?utf-8?B?ejFqRy9LWnhUYm1JWnQ4c3M5WXhUa0ZFN2QwZkFRTzROQ2hiT2hHOU9DU05K?=
 =?utf-8?B?S2ZoNndrenNLdkpXbHRNNUY1dmJyMjdwSUNDUUk4b2lESjVvVjB4ZUpHcXZr?=
 =?utf-8?B?bjFsd1pWU2ZwaEo2amdlM2YwZG5vT3Rta2FrZzFod043TngrbzVCdUVRVS9B?=
 =?utf-8?B?bmp4VDRhVWZWTGtaMWJCWFBEanBWS1c0WHplOXc4MHkvRm9jUGt4RXlqblhv?=
 =?utf-8?B?V1J3VGsxMkxvMTBWZWJhSDhkYmlOVTZEZjlEeS96cWpXWHAxVUlrajlPeGJ5?=
 =?utf-8?B?T3ZMMHgwU3NWMEVJR0ZXcWlOb2k4TEZzVUo5N3czYUNUejBqaVRTOEVyR09t?=
 =?utf-8?B?b2RoZWpVTUpTMldMZVBid01uUUlkNU5rY3huK0lSTUdjS1ZMdFdRV3N1Z0Va?=
 =?utf-8?B?dG5oVWxGN2NEOWM4Wng5MVprSWNSWW1ZU3RrWUJtZXdQUVVPcXc0ZFZHeEx0?=
 =?utf-8?B?WGdWcW5lQ1BRZXpkLzkwS2N6c1VKd0VGTHRZak5uMkRuL3Jmay9CM0hySXFN?=
 =?utf-8?B?YjNZeFFNNUFaN2VOeW0vbnNLSWJVYjJERmlxbkZNOXBTVFh4WlZ4VVlrWEFF?=
 =?utf-8?B?UTF5cFdqSFp5cnlhWXlGcjhMZFpVMkNxY2M0NDdud3FxS2ROSWhiQUU5YUNx?=
 =?utf-8?B?VzdSaEdxZ2h4N2FUNGlzUU14ZzVWRVlOSG9TUzlia292QzVILzhjNmNKUEdV?=
 =?utf-8?B?cXZWM1VTa0FleFduczNnYjIzd2Y3RytZd2FsN3B1bm9PcEcvUnIyMzNIdHgz?=
 =?utf-8?B?NmhCNEpOS3JwNDh0dWhKQjRERG90ZHVLUWpSaUdlQXZORTFaeFRaTGZ3cGdX?=
 =?utf-8?B?UWFqK3Zkc0FmK1JTQmI2bUUzai9Fd2wwZnhFMEplUlo5aE1iYTg2SG5BZysy?=
 =?utf-8?B?YzBDekxTWG85Rmp6ZTBCYS9sQVRzN25ZOCt5RHFhclRxNWQyWjdkQW1Ld0k4?=
 =?utf-8?B?QWtuMERhQUpiTWpVS2lqOWc1c2RBUlFMQ1RBTk5Lem5WNmNyc2U1eTlLV251?=
 =?utf-8?B?S2U2Uk1jM2RmQytBeWJwQU1WTFlqdTRMRVMzdU92SnN4Z0l2bm5RMHkwN0p4?=
 =?utf-8?B?VWRjR1k4WEtoaStFTEtRY29xSEJLbTU3QnBZYUlZNXQ1cmVsa3lqS2c5WEl1?=
 =?utf-8?B?N25xU3J2RC9CUCtwdTdXUEduNXJublY5cTJtZjJDL2d5T0I2SXhwOEVNQlIz?=
 =?utf-8?B?aFl1cy93WStrdko5cFVBSU5YbDFaMEFScUQ4SXRoWDBYbFkwQklVQlVGQ0Fu?=
 =?utf-8?B?c2NwOUk4K3cwcG9iQ1NoY2ROQ1RoME0wY2psN2E4dUFCNEFnY0hsMm9tM21L?=
 =?utf-8?B?eUhtbU9JenJIVy84NzhTQ0NOcllsc3ZyM1l3MjgyaDN4ZFlmZ3JjQk55Rm9C?=
 =?utf-8?B?QjBvb1FMNVprSm5QTnpQU2g5UHBlaU5nRmxnaUtGQmxtV0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDNvZndDNE4rbk55Nm5FR3BoakN0TGNlZG1uSzY3Wll1b29kQ1IrSU5qZTg4?=
 =?utf-8?B?UWt0ZXgrbXExbHl6YXlQUTlHbHpqWXNtVktJeEZ2ZFA2djBnYTYwNmtsaXI0?=
 =?utf-8?B?SWoxcDlmczRVMG1ReUdOQXcwb2Y0S0hrMXFJd2h0OWl0dk5ZcGVMRm5MZ0du?=
 =?utf-8?B?QkhUSWp1MjVaOUtrcjJEcnJIZXdZbVc4ZjBCKzBwYXVteXd3cXIyMXA5K3kr?=
 =?utf-8?B?R1NqWVVsVHRnZXNEVzU4QTc2dkxJSUtsVHdYUGllbmpMVi9UQmhwRVNmcTZJ?=
 =?utf-8?B?VE1nNHJuQnovMmFTTVl1YWxBL1RNbEswM0t4VGJkdEJDWXR3emxtQm04Vm92?=
 =?utf-8?B?Tkd1dE5Nb0N5QTNxend0QUMrQzJkV0hJVnErbndxY0dOTDJQTDF6MjFaUE1r?=
 =?utf-8?B?YTduamVtc1FVVndvN1UyQUVqaFRuZkZiQjVDRjRNM3pIZ25EQ0JyTk9OcGM4?=
 =?utf-8?B?ZS8reDlKenp4dTNmNUxQOTlPRm5ZeW1QVmVtZzUvR3M0T1FCRERSMG85dm45?=
 =?utf-8?B?cWRYQUtNUW5ZV2pnZ0xIOUxTSStMdFdZTmt4WGxoZEZUSUs5SkY0RzdoSnAx?=
 =?utf-8?B?d3BkVEQ3L0pLUTRTUTNEZTl6T1ZJRGhUMjF1TXBsU29oUjdDN1RTZTBCdkh5?=
 =?utf-8?B?bmFoazRLN0s0bEEybmJWelYyTHBaZlBpL0hmNi9XWC94S2pBRTZiYllCL25R?=
 =?utf-8?B?QTlOYi91MzhZdEVBbUJSTkRuWEIrdk4xQzdTUUJ4ZXk3SDY0d1JzWStVV3dp?=
 =?utf-8?B?WTY1U0YzeVNlMElDUnFSeTdJeXRmVjJhcHFMMUtmTTRBRUgwNnNxdS9nb0JP?=
 =?utf-8?B?MUdBVmVPTVhSYjhDazl6ZEVERkdVWFJVbDBWUkhPT3F5cjJnbjFXWXcyZDZq?=
 =?utf-8?B?dWhwSVdEY0xCOWFBS2pQMkR0alhHVG5qN2VEYVBzM1dnMjh4YWtkbHQ5djlh?=
 =?utf-8?B?Ylg2SmRSK05pYTB5Y0ErZU9jcmVYU1pRNVZnVHBwejhWbG03Y0ZGaXk5ZzRQ?=
 =?utf-8?B?YldSU2dLdjVYS3J6TzhJY0Y3OVlob0NFWk5VeVlLNU1uRmF6dXdnc0c3MEta?=
 =?utf-8?B?UUswQVNaYlkyTWxLMllRSFFwaTh4a21iL2tyb0tRbjRtU0NGNnUxK0lyU3ZT?=
 =?utf-8?B?endUcWE1b2x2a3hhT1pjYXhLTUE2Wks1N2JZYmJINHRwaDZscHoyZmF2VnRn?=
 =?utf-8?B?SlZzdFJVWTVQRUhCaEh3YWpFVlpadUxKUEZibFkvQUV1OGovOEZoeUxOUkhv?=
 =?utf-8?B?RlVCR0t5NHFIcUt4cDdoQTM1bHBRQkxmdnVXSDJvamFmbFJSS2JEMi9Rc2Jy?=
 =?utf-8?B?K1NQV0ZZNzdrM2s2QjQyRFVBWlRVUnh4eVFRQXRtYTliUzBINGVLSUNwc1Vv?=
 =?utf-8?B?dmVDU2Y4Uy9CN1NjYzBvLzB2Q0JCMWdVYk9pcFFZYXNYKzBXZVdKMFByVG9n?=
 =?utf-8?B?aTlTeklQQ0NWeC81NE4yQ2tzdEFtREhNeVhvT3FwOWM3eTZ3NkpWVDF4dXBS?=
 =?utf-8?B?MWEyL3hmMWh0cmF2Zm5xOURxaWcyVEI5SjFzdVdnRFFIWXpkejNGWE9qRVE0?=
 =?utf-8?B?Tmw2RnJZRytLY1VsS2psaEFQaUlZTGxvRkx2dzhkVUZZUU1DZ3dmUnJTV2RD?=
 =?utf-8?B?VmtUKzg1VzlvZVVpclhDRjRzaWJjMENDUDhNcmIrMXQxcjdidkxvM1d5WGRJ?=
 =?utf-8?B?aFBBR3B1SElKTlNObG4zMEJGMU5GdG51Wnp2VXlkNWtQV0JNVDFnK1ppbWVy?=
 =?utf-8?B?OGpjb3hNMGo2Vkp0RlhNZ3liNkNZT3JDQWR0dml3aEdITVdHTGI4ZURzR3lO?=
 =?utf-8?B?MGNPZExKSjBBNEI1QUVSRUhJRDBrdzh0Vi93T0JnMzNhamplWDdRVm9lMHo1?=
 =?utf-8?B?TlFENjZ4RTA3clQ5dFBnM1o0NUtWQnk5RVQwSlZodmdhbm0yWFhpVk03VmNk?=
 =?utf-8?B?Q2QvZTNIazNGVlZObHBjUStpY1c1QmlmdjU2YmdOcXZiU1lxSzZsdkIreCtC?=
 =?utf-8?B?Q2Judko0bmQzN0lSOHBlNlJzbzJtaXRIbnhFZU5NSndjUVhBY3BHZWxyZHpm?=
 =?utf-8?B?WVB2UmU5bDdIQmdjOHV2cmFJSmpMZUJia09NcTVXNTJTVkNGTGNmS2tSR09j?=
 =?utf-8?Q?oyp8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0543a1a-627c-4abf-9fa1-08dd15167d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 10:20:48.7707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28SapsQD+NMN6rL+zTMYyCXjA1+PA8B6NiJ+6DVlIQxr6mSkwKU5qdlLDtds/JLY5Pt+dcyRi2Yqx1chai78sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6047
X-Proofpoint-ORIG-GUID: 1HDJo2rK-yj-MV_ZsWwgkW7odp727Unq
X-Proofpoint-GUID: 1HDJo2rK-yj-MV_ZsWwgkW7odp727Unq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBEZWNlbWJlciAzLCAyMDI0IDM6MTEgUE0N
Cj5UbzogR2VldGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT47IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPkNjOiBrdWJh
QGtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGhvcm1zQGtlcm5lbC5vcmc7DQo+YW5k
cmV3K25ldGRldkBsdW5uLmNoOyBlZHVtYXpldEBnb29nbGUuY29tOyBTdW5pbCBLb3Z2dXJpIEdv
dXRoYW0NCj48c2dvdXRoYW1AbWFydmVsbC5jb20+OyBTdWJiYXJheWEgU3VuZGVlcCBCaGF0dGEN
Cj48c2JoYXR0YUBtYXJ2ZWxsLmNvbT47IEhhcmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxs
LmNvbT4NCj5TdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbbmV0IFBBVENIXSBvY3Rlb250eDItYWY6
IEZpeCBpbnN0YWxsYXRpb24gb2YgUEYNCj5tdWx0aWNhc3QgcnVsZXMNCj4NCj5PbiAxMS8yNy8y
NCAxMjo0OCwgR2VldGhhIHNvd2phbnlhIHdyb3RlOg0KPj4gRHVlIHRvIHRhcmdldCB2YXJpYWJs
ZSBpcyBiZWluZyByZWFzc2lnbmVkIGluIG5wY19pbnN0YWxsX2Zsb3coKQ0KPj4gZnVuY3Rpb24s
IFBGIG11bHRpY2FzdCBydWxlcyBhcmUgbm90IGdldHRpbmcgaW5zdGFsbGVkLg0KPj4gVGhpcyBw
YXRjaCBhZGRyZXNzZXMgdGhlIGlzc3VlIGJ5IGZpeGluZyB0aGUgIklGIiBjb25kaXRpb24gY2hl
Y2tzDQo+PiB3aGVuIHJ1bGVzIGFyZSBpbnN0YWxsZWQgYnkgQUYuDQo+Pg0KPj4gRml4ZXM6IDZj
NDBjYTk1N2ZlNSAoIm9jdGVvbnR4Mi1wZjogQWRkcyBUQyBvZmZsb2FkIHN1cHBvcnQiKS4NCj4+
IFNpZ25lZC1vZmYtYnk6IEdlZXRoYSBzb3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0KPj4g
LS0tDQo+PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1X25w
Y19mcy5jIHwgNCArKy0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFy
dmVsbC9vY3Rlb250eDIvYWYvcnZ1X25wY19mcy5jDQo+PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9ucGNfZnMuYw0KPj4gaW5kZXggZGE2OWU0NTQ2NjJh
Li44YTI0NDRhOGI3ZDMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2
ZWxsL29jdGVvbnR4Mi9hZi9ydnVfbnBjX2ZzLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dV9ucGNfZnMuYw0KPj4gQEAgLTE0NTcsMTQgKzE0
NTcsMTQgQEAgaW50IHJ2dV9tYm94X2hhbmRsZXJfbnBjX2luc3RhbGxfZmxvdyhzdHJ1Y3QNCj5y
dnUgKnJ2dSwNCj4+ICAJCXRhcmdldCA9IHJlcS0+dmY7DQo+Pg0KPj4gIAkvKiBQRiBpbnN0YWxs
aW5nIGZvciBpdHMgVkYgKi8NCj4+IC0JaWYgKCFmcm9tX3ZmICYmIHJlcS0+dmYgJiYgIWZyb21f
cmVwX2Rldikgew0KPj4gKwllbHNlIGlmICghZnJvbV92ZiAmJiByZXEtPnZmICYmICFmcm9tX3Jl
cF9kZXYpIHsNCj4NCj5UaGlzIElNSE8gbWFrZXMgdGhlIGNvZGUgcXVpdGUgdW5yZWFkYWJsZSBh
bmQgZXJyb3ItcHJvbmUsIGFzIHRoZSBlbHNlDQo+YnJhbmNoZXMgYXJlIHF1aXRlIHNlcGFyYXRl
IGZyb20gdGhlICdpZicgc3RhdGVtZW50IGFuZCBlYXN5IHRvIG1pc3MuDQo+DQo+SXQgYWxzbyBi
cmVha3MgdGhlIGtlcm5lbCBzdHlsZSwgYXMgeW91IG11c3QgYXBwbHkgdGhlIGN1cmx5IGJyYWNr
ZXRzIG9uIGFsbCB0aGUNCj5icmFuY2hlcywgaWYgb25lIG9mIHRoZW0gaXMgdXNpbmcgdGhlbS4N
Cj4NCj5QbGVhc2UgcmVzdHJ1Y3R1cmUgdGhlIGNvZGUgYSBiaXQ6DQpPayB3aWxsIHJlc3RydWN0
dXJlIGluIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KR2VldGhhLg0KPg0KPglpZiAoIXJlcS0+
aGRyLnBjaWZ1bmMpIHsNCj4JCS8qIEFGIGluc3RhbGxpbmcgZm9yIGEgUEYvVkYgKi8NCj4JCXRh
cmdldCA9IHJlcS0+dmY7DQo+CX0gZWxzZSBpZiAoIWZyb21fdmYgJiYgcmVxLT52ZiAmJiAhZnJv
bV9yZXBfZGV2KSB7DQo+CQkvKiBQRiBpbnN0YWxsaW5nIGZvciBpdHMgVkYgKi8NCj4JCS4uLg0K
Pg0KPlRoYW5rcywNCj4NCj5QYW9sbw0KDQo=

