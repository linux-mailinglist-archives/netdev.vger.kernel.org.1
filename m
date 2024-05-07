Return-Path: <netdev+bounces-94091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE868BE17A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4221C21435
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA784156C6E;
	Tue,  7 May 2024 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="KAoj+F7X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626D1509B0;
	Tue,  7 May 2024 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715083040; cv=fail; b=jYrU5XVV3KgE7eZHqrBZYF0Levul6W5y8SdPgWanRnPL/DhoXAyvTqartDM4+KAEcbzX2+rDE79Vt2FgAvej5IGXHL4jbT0VnPkxPbVjRDE13GeWiH0M6v4KFq+x02ZCZQhOaO5Ju6OMf7BqQMcpEyrkovL+KwtWqER/TIfhODM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715083040; c=relaxed/simple;
	bh=83sEkrG4JfWoR15TkNo8VHTlD1LMNUNIU6NOWA9Z8UU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bq4nX3381dEDm5Ay8wyEUQVSel4A9lUXTiXbibH/05eU/YXjmPf4eAtIe0VHgktSDfanS8SOrApM0gsdioesvRa7/lgdhWJAPDLD+oejDajgrpr1NMuo+OmmxGVha5cVixJDDEm/9RlqiW6VgRZvpBBGjdblUyvW8Qd8IzmWHeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=KAoj+F7X; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4479a5ui006958;
	Tue, 7 May 2024 04:57:10 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xwmhggdd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 04:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2YhFnrogW1FJbu92oViQT3k9lp/wht5IMEfcjUB6W6+wvYCAScPl7xgrsFz/5I4H5cMD3/r82cx1+G93VphVFyq3+c7QW03kk3FisNZ6d0gkFnQpJ3UcBddolfrDyFfP1wFZdKYEggepyiLapf2K0MB/QoGOREsabx0f29ndqlpCroezNuJg69aSaxkNasyzvcySQPB/RS7iCg8JmoGHSvNch7l9Ab4Q1vte2lhDzeXag1DlthQ8WSWyco4L2bsTi1VHrbjp53Anj6MLRlkowrH9zTcj5Re61uL5VWuyIV5OjqLuFXxteGEoxMQDinpvdSdGpl/quEpnv65AUwSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83sEkrG4JfWoR15TkNo8VHTlD1LMNUNIU6NOWA9Z8UU=;
 b=V5si/z9SEM9GqtX4XlPjB13yM7HmwDYFGBBsStPYafcZJ1MP0KBXEPInfI39E51qeDHMHF4ByC6RFyIn+E9QuSXatHbXWpjigjc2tWRWHI3++vhcUol4VSFr+nURiv2HR1fTL1rhMi0yDBbrPHHIaw/szb/lVhEr5y10DnesJqtc18WRxSYaoU/CU/inP1yBpR3KICN8x+10OHWmJ0F0uQF2wiQEkkb2Lfh7t9HW8PztYAsRte0L7b7YBfwdSDsSR+yJIs2Xi2a+QQg6bjs4KeoDPDRz+lYAjXZor8zUDyuBOtgaf6rLi5UBPvJaEhEw5Q+k/Rg3l2EYpjDY9tX6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83sEkrG4JfWoR15TkNo8VHTlD1LMNUNIU6NOWA9Z8UU=;
 b=KAoj+F7XVjq8Q3iF2/R2ryIo+rvOUA2C+7Za/cNTBtmuFAfexBJAMDszEkb8+g+phItJV4B07RRB0pcKom3bOkBHxmJq/1jmuqOYY57ZMqkFTyRSS5rQ+2j+TUpHJW0N4honQTk5kARPDt7bMH1IfMOhzoppaM3Lt+pZ0PJCVMc=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by DM4PR18MB4304.namprd18.prod.outlook.com (2603:10b6:5:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 11:57:05 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::86bb:c6cf:5d5b:f3b0]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::86bb:c6cf:5d5b:f3b0%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 11:57:05 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Felix Fietkau <nbd@nbd.name>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn
	<willemb@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next] net: add missing check for TCP
 fraglist GRO
Thread-Topic: [EXTERNAL] [PATCH net-next] net: add missing check for TCP
 fraglist GRO
Thread-Index: AQHaoGPJEB2DdFr3+UCCiAc99tDRbLGLo4vAgAADJ4CAAAO94A==
Date: Tue, 7 May 2024 11:57:05 +0000
Message-ID: 
 <SJ0PR18MB5216389F757AC86BDD144612DBE42@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20240507094114.67716-1-nbd@nbd.name>
 <SJ0PR18MB521604310B1F7DC297C2870DDBE42@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <4bcb2be8-d769-4972-be9b-c7798f50f207@nbd.name>
In-Reply-To: <4bcb2be8-d769-4972-be9b-c7798f50f207@nbd.name>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|DM4PR18MB4304:EE_
x-ms-office365-filtering-correlation-id: dd9c8b91-84f5-4646-dc98-08dc6e8cd0ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QW1oakh3TnpPeWFDdmxoUEtLbFk1SjFhSktIbWlkVloyZXkyb1piOVpsc2NV?=
 =?utf-8?B?UWFKM0lLT0c0N1Q5NHJ0a1M1WXEvSnEwRjFyZEM4bmY2dDk4K0dCTTRHaUJi?=
 =?utf-8?B?K0dnMEorNDJXd2pOY1h0bkFzbm9mUUZmWVhwakp4K2lJTGRiRVU5KzhpeG5s?=
 =?utf-8?B?WThEZ2R5N1NWam95QXNvYUYrWHZKeURGQlBKRE9Femo5elpZbnNzczQxOElk?=
 =?utf-8?B?ZVIrVUJxNWtTRVh6alIwdWpLODRtYUhuMHl1L1Y5ZXhVcHZpR0JSSFE5RHJh?=
 =?utf-8?B?ZnZGdE8xd01XVTNjWUVNNC80elVVWitUalRkT3huSTFlQXVvcXdQSWFmZTll?=
 =?utf-8?B?a1liZjNxUTZyUFlTeEZLSmlxRFVqSnp6bjZ0Q2RNejNGU0ptT1NxcHM1UDAr?=
 =?utf-8?B?WVZQaDQwR2k5L1ZPT0lGVjVxOURvT01PSzhPS0UxTjhNNUNPandBZzBSSGVt?=
 =?utf-8?B?Tm01WGFiYUZKTk1RMnZsK0RLY2RHRmp6YzhnT1BYbmVpbk1OT1NFMjEwZGhh?=
 =?utf-8?B?dktqeXN3OENzcmJtZlFMREpxOFdXMk9MdGF3T1NrY1JHSUszNHhPWnc4Rzlx?=
 =?utf-8?B?WDdVZXlRNWFwY3hEKzNTYlo0aE8wdkZDWlhnbEcvclBkam1rWE56Sm9BOEd3?=
 =?utf-8?B?SlRBN1Rsb1Fzd1ZCb2lZN0dVQ3BpR1RHYzJqWDNwV2NXdndJSkh2SDZUNzJo?=
 =?utf-8?B?bWJrQWd0SEtJVHlJWVhqMkRic0hiYVZSWnlyZHc0Ri9zd2ZNV1M4N2UwR21M?=
 =?utf-8?B?WTYzQkNxT3BqOUFMNjA0SWlVR3pZMXRPc1lYYUVjY1ZEMFhrdWpESWFIZjhn?=
 =?utf-8?B?OTBMOCt5WmROZlU4ZCtKNWFhQnZDYmpsSFpzQkZKemo2ejdBem1aSFgvWExn?=
 =?utf-8?B?dnJZT3B5eEFrVnliY1h4Nm02NjVKdmc5ajY5c1FISjR2amJHcW5SNWdCTVNN?=
 =?utf-8?B?Mi9uZ3RDbG5CWUlVWS8xV3F2dUhmRmM5M1ZKbEJPT2VPK0ZheWw1MG1DUUJO?=
 =?utf-8?B?aWJTV0NFejA3VFlqZXhrVnBaMC96dXpTa096c0tCQVMvYkJieWVmNGFpajgx?=
 =?utf-8?B?WXNWejY4MjI5bWZmYjRpT3NZYXV5b2NQNlZ0S08vS3lQT0hKQmR6dWc3Y2Zj?=
 =?utf-8?B?bFpMczkrbjdVWEpFVStRZy9xZEdXQzlxVmd2bVpHalpSYTREc2ZtSC90QW05?=
 =?utf-8?B?VEExN05pZTBIcTZHdStBT1lSY1FrZ1J4ZUZmYUpKSzZYMkJLUkdZYXRGUmpq?=
 =?utf-8?B?WW1uUDRaV01ybXNyODRsaWVNOUJPc000aUVsaUtUVUI5N1VnN3JuQTBqRFU5?=
 =?utf-8?B?MkZmZ2tOMnk5MzlJUE1UeG5HeUR2T1pyelIzTWN0US9GbzdjeFVHRUxuUUI2?=
 =?utf-8?B?UGNaNng1eCtyNEZuUzNQNSs5Q1daVW1vWkJoSHFQazRPQVE3SFlFRENqdEp1?=
 =?utf-8?B?b1lYYTdCRThGY0plNFpGbjZMWXIvbjVIb1AvVXF4bHg0TjNkL01sd2hOQ1Bk?=
 =?utf-8?B?VHE5MitBcGJLOEhYZ3VkdGorSEJCYkJDek1lVG1FUmpOeGt5dGRoSFJHTWhz?=
 =?utf-8?B?YW91QzFGRHlTcWg0eC9jRXQrZDBlTmlOMERzQ3dVRUVQT3ZFaklHdXlmbnhn?=
 =?utf-8?B?MmZEakdiSW92bjVGODFXcEpBc1ZaM2RLa1hLS3hoYXJSY0E3RjZpNjZzdHo0?=
 =?utf-8?B?N1pEZGhibzYyVTJOeVo4T2hZSkd6UEJiZ2NqSCtramxnTi9vakRJbTdwWmVN?=
 =?utf-8?B?Z3N4UGRKTWRTK01tcHI2MTd6cEpFYzdCR2tUSnl3VE5lSkVlVGJWRFVyY3hk?=
 =?utf-8?B?TzJFSlFFNzBMd0ZDNVk1UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RC91Sm95a0xLbFFQcXRucGVaNG83MjhTRmh2bWl0dmVjRTlBRnQrS3lLYWxC?=
 =?utf-8?B?SnF0NWN1czlsZXpWMmVlMGlqUmF3RldBeHRaQUF1NnBWOS94MkVsWExDbWpX?=
 =?utf-8?B?dGRMc1U4QS9kNitpMTdZMExjelZYVVFOV3RFalJKeXE2bFdRV2Rxb1ZFYm9Q?=
 =?utf-8?B?YWYxV0ZWa3hoU2toMnBLK0t5SHdBQTJCYzRmQS8wdStNbXdZbG5paUloUXVQ?=
 =?utf-8?B?LzNCK2dJNm5xZStqWm8vYmIrRHRPdWhEazJ3cnRIdGh3eUZZTTVLSUhyS21q?=
 =?utf-8?B?d1MrOHhpZVhDai8vN0ZJV2VMdnhHR3pGNXc4dFR4ekVOOW9pZnNXaDFsOXo5?=
 =?utf-8?B?S1Q3cEhRamc1Z28xQnB6UFdsRkMrdmltaUVjdGVabEZMMkRZNlA4YXEyYzhW?=
 =?utf-8?B?VEVRTU1vbHI3V2V5b3lvV1BVZzNwR3lwR1FHV3JINTZnZFJzVEFCNzRsU01V?=
 =?utf-8?B?VktESjlTWlRUVUpnNmx2cFJySlViS1RNSnEwV2RpQUh3cWFLblZlamxkSWZ0?=
 =?utf-8?B?R0ErelJ1OWRQM2JjWFlubElIUmtoVEVSQzFtRVJYeU83VjFEZkZRMVM0SlJ5?=
 =?utf-8?B?Z0QzbnNTRWZBMDZtUTVJdGVCSXZQYS9Na0N0RjZzTm16UTRLUis1cW1FM2d4?=
 =?utf-8?B?bzg5QlZSLzdzRTdtQ09YTVpJNDVIYU9KWFNSOWdtTDZScDRqeGc2dXdSNFk5?=
 =?utf-8?B?V3NoSUNQcHlUTC8xbi94bXpsQzIvRnUyc0hjT2dDQnRXbGZ3QWJFeUVJQjAv?=
 =?utf-8?B?SHUwcFlsSXkxb0NnWWRMMk1FaU5ERWtqVUlEQzd2VG9jMFZrU0Q0OUx0dUFG?=
 =?utf-8?B?L1hIWHJNaWh4YjZlSUZ0U0ZLSjdVdUdrOUlHM2NTV2lxeis4THBEL2x4Wnln?=
 =?utf-8?B?d2s5N3dPZytRcmp6MFNDUUNyU1hpT2IzdkhwNkRRSWRhZEhVVWlzWUlYalg1?=
 =?utf-8?B?d2U0b0d1cGxidDdIVlVoMVJCcDNqeDc1UnRWcHlFbm9IdWtFczBOSE5OREhC?=
 =?utf-8?B?UVF6Y2xTRUtLMTR5NUdLU2JxRERveGJ0dW5maEptRlcyR1ZQcC9mSDJlWUR0?=
 =?utf-8?B?N1R0eGJpT2FkT29KYnNPWFhuOGZlVWFjck41aUZmZHN3ZlRodFhQQ09WN0pI?=
 =?utf-8?B?Vmk3R2o5czgvU3h0MnVhSnhXT0tCeFpPb0xYdExrY3JuWlhRYzN6NmFPTFdm?=
 =?utf-8?B?OWRoang1RzJkL2VtTVhDYmlzYTRSRnVueitrSVlaQ1pDZGsxSFpCMXUxcWJs?=
 =?utf-8?B?aU5HaEwzbThOV1FEQ0tvbHN2RExWeW1kc21lN2lNZGtEM0EyTmdrdVg5OTFv?=
 =?utf-8?B?bXFiRlJnK3ZpS01LMDU1VnI2c0dHeHZnSU9SNks2TG5RUWR1dEU4RGhaRysz?=
 =?utf-8?B?TVJXRzIrMjdpSC95VzRJVDMzZUQzYWQ3eVlhM3BiL0IwbXBuODNuYjAwOUJ2?=
 =?utf-8?B?ME8wK0JKWEVhVGxINmY5SDUvcm1wVWJCRHlLbEtIZ01tT3h3MHlLVXE1dExl?=
 =?utf-8?B?OW92d0dKSmJveWJDaWt6QlhudkJFOEkzRS8yZ1g3cTBHUVFxS1Q0YzkxZkY5?=
 =?utf-8?B?YVdmbzR4dGdYcjB1ems4UkdlYnUwNVdZRUZJK291Q0VuNkUvUk5aamtIVHVx?=
 =?utf-8?B?aHFaSDVEV2FTZmtCV0VrR3JZK3c1cnRIeHFrUWM4RVRkWmJNT3FPM3RzMTVF?=
 =?utf-8?B?U2dEM21rRjhJcUxRQzZZbXNoVFdJSkI0K2IxbHBmUmRCaFlrTHduSWpEb1o5?=
 =?utf-8?B?eTRPbWk3V2dwMGZrOXUwcXFNeVNhbXZ4Nm9UYVpqdGYwVG92WjRNcCtWZmM5?=
 =?utf-8?B?bFZJeVlWTUFqZHF4MlVpN0xzZGNRUlJYNEExNTBmL3k0bHVyTVBxM1A5UHdW?=
 =?utf-8?B?UUxZUlJsK3o2RWlkMSs2K2VYSzdkemRWaUF4TjViaXFlVkFjZVRvZEZ4eGhl?=
 =?utf-8?B?dGpqUGhxZ1RTRllpeWdyYmtPZ29ZQW5ONHlFWXpURjRFaFd6SUhpcVRmeUh1?=
 =?utf-8?B?UXpvUGFvbmlNS21kejl1bjFydHFObG9sZnNzbmR5c2FTeStsc1ZJUW9lcXNJ?=
 =?utf-8?B?OXZqb0ZhZDZ1eEhwU0c3c2dQVTZmWEpJU296bUcxVGxzakFCVFhTbFRUS3JV?=
 =?utf-8?Q?3c1ndxk0nhh499ShjYGhzXIcv?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9c8b91-84f5-4646-dc98-08dc6e8cd0ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 11:57:05.5076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PwNqf8oNiCshAvDe0QNltB+/UIk7yEv0G7VrsxsqTIR8gjBIv82IytLFZJkNjg0CrE/Iwkyl9lhoKOQtLQboDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4304
X-Proofpoint-ORIG-GUID: sCNSN-WzA93Ipxv3T4eIHDQ1QpC59IV0
X-Proofpoint-GUID: sCNSN-WzA93Ipxv3T4eIHDQ1QpC59IV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02

PiBbU3VtYW5dIFNpbmNlIHRoaXMgaXMgYSBmaXgsIHRoaXMgc2hvdWxkIGJlIHB1c2hlZCB0byAi
bmV0Ii4NCj4NCj5ObywgaXQgaXMgZml4aW5nIGEgY29tbWl0IHRoYXQgd2FzIGp1c3QgcHVsbGVk
IGludG8gLW5leHQuDQo+DQo+LSBGZWxpeA0KW1N1bWFuXSBHb3QgaXQuIFRoYW5rIHlvdS4NCg0K

