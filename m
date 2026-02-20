Return-Path: <netdev+bounces-259672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFCXGRkkmGkJBwMAu9opvQ
	(envelope-from <netdev+bounces-259672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:06:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7A16602E
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA02B30091EF
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E0931AF3F;
	Fri, 20 Feb 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="u0vuPVtd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAFB31A556;
	Fri, 20 Feb 2026 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578387; cv=fail; b=R+/OeaPOsbzNA47wexJl3ou2g3f5i0dNN57+XOAATTs89gmCmuO54o6i8zKNy1NSOzgRsLzQzH3pmUoIOXmhwSRifVwNtJuwHV0c0IF7WNdXJiiTqlr0a78NcSKk6ENqqrjUQNgfmEgGV8KixIt0lz+ziqh6tcdMp2Wl+bhifB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578387; c=relaxed/simple;
	bh=+OpE3V+O1YXP4i0PjByE0FyTFWAZekHEzTbppn0+KVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YtiN5moNVGauEAH1g7C3mUl6wzcS2Ao/TJrK2aZPXSD7VIISQotKW0euCGnoghWMIcjiWrbsr9pEwoSfNKncSkk56nzRKdF+xgqdR+V8sSvw1Dt6YxaEHxQMWyBbS7w5y4HaaMFKhlgp4wkNxXCC1u6iS7f8I0WQu04IXj29mAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=u0vuPVtd; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K3RYIE273357;
	Fri, 20 Feb 2026 01:06:03 -0800
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021078.outbound.protection.outlook.com [40.107.208.78])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cdkmrcc1r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 01:06:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1VWcaKCuPp+jNMcawRm83Aj5N8QEfgkafuzsPe40+zwTfgmVzoMjvwDbbcskZZymY2jgH7yxJoONKYs2UZcepqLRb4vTh7hQB+n7wF42MT9Jrmhja2Axs0M3LRAYI/2E5p08F4p8TB/eKKuCXjWsMbijM0O6dSKYMgiMxfmZ3fQLmNmJvrMbm3DE+LdPwdKp52whEB7DDsyrCb8qAe2oGBwAi6PvsjE++81JJyRHIaM7dNcwD+EEJCFwFQf1KNYUc0IAAgNYqCSoczGFQRJOXvhFkBvXfXcgW5DRHSf/xOJxUclP33iyB/uoHwTzJAZGDxVj1QcJoeFO6bPO1+rGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OpE3V+O1YXP4i0PjByE0FyTFWAZekHEzTbppn0+KVc=;
 b=FZ0xBRUuWthkxfqVTDa2jJLXcfDaYQhpG25dXlcyMWyqM+jQu3NYdFpHhvRdquj5/nDLLId+XBuFJ1kb4CCK/4+OMm0ABiQz25aDEUzW6gxSJUjtBqZ19Tw1tSoVvV5NuLap4Pl0mQJK6ZPwkVAYgGb93I8ta8BR3bLmgiG5kNfQPnhQeLgn0ofUE1uOI1hI1bah0TCHVVQzDHcTTj34H3ppKu1SUnElLiFl+nxox61Qj1xviVCToEejU2IgdC6leWa7VeRqie/l1LDzA9+d14F5S2/RHUu9Ds4weLRD0FYz9ng0zxTRrMq5LlNjuuBUC1NmlaqMrh2WXtonLHtRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OpE3V+O1YXP4i0PjByE0FyTFWAZekHEzTbppn0+KVc=;
 b=u0vuPVtdpjRAgiTEpSeRZbdIDMt7QY5qKClOVwhVLseA3mOs/jxJClgwsVsd7aibeVSWFOfArMHIv1lIx9KZks/bozWpIYMw1FdbQMJ1VWK7uc1cAwWueCZnRB//NxEQ5cYrjJQDxesrD9HosNsqka5bCEzzHu19xYM81M5dflQ=
Received: from MN6PR18MB5466.namprd18.prod.outlook.com (2603:10b6:208:470::21)
 by PH0PR18MB4800.namprd18.prod.outlook.com (2603:10b6:510:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:06:00 +0000
Received: from MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2]) by MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 09:06:00 +0000
From: Vimlesh Kumar <vimleshk@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Sathesh B Edara <sedara@marvell.com>,
        Shinas Rasheed
	<srasheed@marvell.com>,
        Haseeb Gani <hgani@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Satananda Burla <sburla@marvell.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH RESEND net v1 1/2] octeon_ep: avoid
 compiler and IQ/OQ reordering
Thread-Topic: [EXTERNAL] Re: [PATCH RESEND net v1 1/2] octeon_ep: avoid
 compiler and IQ/OQ reordering
Thread-Index: AQHcnBl07Klr5ZH480KsQlIHfeMNhrWGrz2AgASe4VA=
Date: Fri, 20 Feb 2026 09:05:59 +0000
Message-ID:
 <MN6PR18MB546630F1CE06DA47FC801747D368A@MN6PR18MB5466.namprd18.prod.outlook.com>
References: <20260212121634.360252-1-vimleshk@marvell.com>
 <20260212121634.360252-2-vimleshk@marvell.com>
 <4e07f6b8-5225-46e0-b3ac-d02495392835@redhat.com>
In-Reply-To: <4e07f6b8-5225-46e0-b3ac-d02495392835@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR18MB5466:EE_|PH0PR18MB4800:EE_
x-ms-office365-filtering-correlation-id: 00b31602-c494-45ba-ba30-08de705f441b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OG9nQ2crTTFNa2hlMDlZRWcxdEF3YlBKYTlDRG5ZcTZSb29IVHF4UldvSkgx?=
 =?utf-8?B?d1BNRmJjd2RTMTZhL3RMMUNkTU9OZVB1NzFJNk1FVG9abzF0ZWlKOEl0WU4v?=
 =?utf-8?B?Q3NKWmo3aitId01UaDV0N0FTOWU1L2hUYUo2dHBuZXZ2cDJBWVNzWHpLcWlk?=
 =?utf-8?B?QVlPcUhtQzBuMkdvbnNTNmVPQlUzbzFza1dKTkx3TVBmckl0eW1Ybk9qN3Mw?=
 =?utf-8?B?Unl0ZTA2WHFTNm9PSHd3ajdKcGREdktEaVZoa3VQYjNVUGVaUzN0bmRXbmJM?=
 =?utf-8?B?WlJPZ0FnV0tydUR3cWpqZjdrdjB1aklmMHpBcEpJZjdzSU9pVS9lRFFUQlRL?=
 =?utf-8?B?YnVPa2lQdVE2MFl1UWQwb1EraVlrOHUvWEQxdjRXZndkcXdtWGZENlJ2dmsx?=
 =?utf-8?B?VmNuMUdobzllRjk0Ui9ReUYyNzF1SnNVWklQTXV0VE92NHRQeGE0anZZR2ox?=
 =?utf-8?B?ekh3M2lXSGFHcmVLTjRWanpOOU9kamRyZjVaVmVXdktSbFRNZSs4L05wM00r?=
 =?utf-8?B?ZTFnOWJlTk15d0VhMXdOL1RUeU9FbTZCWTFoNzVGb3JUMjM3UDk5NG1lN2Rj?=
 =?utf-8?B?OXVJajNuSi9wWjFNcWFSYUNzUmJrVGFsWDFwRjNpRkpqeG1ReEsySmtxUmNi?=
 =?utf-8?B?QnFldk05alk4eHFzYjMrOGZDdUFFN1lRelh1cGk1MDlCZHgvM2s2YWo3WWlj?=
 =?utf-8?B?SFdtOUxjSFhvZEFMVGtzblIzazcrcUNHdnEyc3V2b2ducHpnQVo3Q3hIMFdP?=
 =?utf-8?B?bUxIL3ZHc2N3Rjl2bW9JVTMrc0IydzlyUWVJd1Z6a2p4Y2Z1blRCcmJUYTFZ?=
 =?utf-8?B?M2hwK2djSDk0UFZuN1ZtUVY4RkgyMTBXYTRIV2VmY1lGTzRpekoxbGVoRjF5?=
 =?utf-8?B?K0h6dHlzVmhIREtHOUpRRng5aXFSMmRUUVhXTXh3VkdIenA1ODFRWWVCMDl5?=
 =?utf-8?B?K1k0WHRRUW9PQ0VIblV4ODZ5MlhxMlJNTkpad3lDMmVTSkl0bURwUThUcjAw?=
 =?utf-8?B?U2NFOEI5cTNqMVNjUm1tUC9xNTE3aG9oeGJpMUVVbkd3TGxobFJZdlRaN1lC?=
 =?utf-8?B?QWF1TTd1RjF4T1NMY2NsMEZhOWdTUkoyc2RldTVCUUtDWDM5UkpBeVdnR0Np?=
 =?utf-8?B?L0Fud05HUFdHbUkwcnZ6Zmh0dktQSm5TZDNZR3FnQmJIbnVnUTNwdU1ISE0z?=
 =?utf-8?B?V2xvY0pBNFZ4a3V1eXVPdFBvQ2w0YUtyUysyc1RvNXg2NDVtVy9zV0FYMnFJ?=
 =?utf-8?B?dkVFM0t2aXRGVEVEYWR2ckNZSUg0ZG9Bcjh6azg3MEd4NFRzUy9xQzBRQTM4?=
 =?utf-8?B?bjRuR3oxeUhSY1g4SDNYWUo5Z2VPVXFCNEVBa3dFUXp2MVA0ZjlkWUZHd0Mz?=
 =?utf-8?B?ZndvTEo2elZnaGZ0TzhGUHhWcUdlSVFVMmJkbEFUMnBmK2RIc2VrVWJQWmth?=
 =?utf-8?B?bUZWdkNKUWk4dFAyeXdYekdrTGNlMERxU2tPODFzWkZIL2tWQmZhc01zVG5h?=
 =?utf-8?B?bVNKK1BvbGlLS2dKY2JaU0tYOS9yTU5Vdkx1M0xGMDRzMjRJUk5wMTYyK2M1?=
 =?utf-8?B?Y1JYdW1OSldxUnR6bWZJeTAxcnN1V241VC96WVpBNHlSVmlkZVl6dGZZbUJS?=
 =?utf-8?B?djdkeU1DemdPMkM2eTUxY0VSL0FaTDhUZ21qcm12WmYzUUhLWXhjckhWUlF0?=
 =?utf-8?B?WFhQbHJmYzhFNll3YnBwdEFlZXlKMjVLaDdGLzRZY2hhZVRaNW9qS2IyVnpX?=
 =?utf-8?B?NnFaWS9HQ1V1MCtKcmFjZ0dCcVprUFRRYTNhRHRxeHJ4TjgvTmVWa0w2UERK?=
 =?utf-8?B?d1Nnd3daUUVBbG04Yk5aTUFoTTZGZDl6SitwNGpYaGdsNkhPSFgxSFFIeE5r?=
 =?utf-8?B?L1BnV3QyUEhOZDk1cjBtb3lmYnF3SXY4UC9FT1FLRWN0V3c0dFJHMVJhNXRK?=
 =?utf-8?B?ckNwVWhwZHI2Y3VpZWV4OE5ZVVhtSmpIOEFIZFRIOUxOUFhtMzY2YUlrMUNj?=
 =?utf-8?B?aDJrQ1E3WXhpWitqT0FhVHh0OCt3c3ZoNjZoS3dUTHR6ZHVBSnFwd2t4ZUw1?=
 =?utf-8?B?NFVQVFhMcFMrbGF4cjBFVWxYU2lxUGlXd0VXdWV2SkhzcmtnUzF0MEpJWFkz?=
 =?utf-8?Q?UpJKg0uMymV6eL77IAb0/rSpF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR18MB5466.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDQ1aGQyY3hEeVpqaThncFdDQ2QvdmhyTWJPaUVPQitKZGVuS09KV0IvdE9k?=
 =?utf-8?B?NTZJWGNVV0VhdFgwOUlrVHpGSWdrbmFzODBTS0tVR2JyUU9XYWNoNVR5ME1j?=
 =?utf-8?B?VFgxYUJTcG1ScE1NK3lValVaUzJnSEM2MG11cTg3aFdrbEk5cXNPL1czU2tq?=
 =?utf-8?B?OE9TdUpPL3RIVFIrRFBGK0xSejZ4SXVvUDZZR0JSaG91M1NEOFhIanNhVDJp?=
 =?utf-8?B?elkwek45S1lKL1hHUkhzNmtxczhLQkFBTXZySjlKOUFMZ2FvYnVvRys2aENT?=
 =?utf-8?B?NFZ6MW4yY3k2bmt6LzZHN00wT3ZhM1VIby9zNG95UVIxb3JMMjhZV1BaR2ZV?=
 =?utf-8?B?UlFRQjJUVW5PdVUwWGVuTXBYZ1ZEYzdZeUJadmFEYmVqSEF5V1dGWkduQ2tl?=
 =?utf-8?B?UkhqMkU3QWgvbDU2bDRNcUpsaEJPMXVLVTRrYmRlV1NjY1ZlMUNlQUhmL1N5?=
 =?utf-8?B?anZtRWwzL3lqM2paSWtiYjNxV2ZCSWdBNDQxL3R6ZCtpUFdkWklIMk0xRWxP?=
 =?utf-8?B?d1dET2x4cysrVURvQnJyMVhtVWQ5NWZTUDRlQzdKeVRjeHMrZEFqZWRwUm0w?=
 =?utf-8?B?RkZDLzRVaUY2QTcxdFk3QUFqK1dYZmd0bFZBNzQwQmc0SUxNMWcvUTd3elRH?=
 =?utf-8?B?NGZYekVJRDR4VGF3SkgrUXNBSDYyOVFablNtbkxUekJRRDhzSVU2V1pYMDZH?=
 =?utf-8?B?NWxIMldSRGo0cHcxVklYS2xzZ0pLMEZwazhlVzVNVHRmZlhuWHpSOWZjMC9Q?=
 =?utf-8?B?a3h0TVYzQUpiMitnbFB6amJNeVNjQXFvNk5IZmpJcnM2ckY3WEt6dVlMb3A2?=
 =?utf-8?B?M3RxRkkzQUpvdk13UytyYjRFL2U3elIzdjhVbzlxdGcwaVBQaHFzRS9Panhs?=
 =?utf-8?B?enlaQlFVS0l3ZjhkU3VxdnBYMHc1VVhDMFZ5VFRkdDZoTWk1TzlPQ1pSMkVa?=
 =?utf-8?B?ZnhtZW1CSENwQTBFb2JNMk5KWXZiNllld09CK2xFeitZZFQwbGhEaVZIaHVo?=
 =?utf-8?B?ZFVPdFlES1BMYzRIWThQRjg5ZDVDZWlPMUt5aEhxUjZaOXUwejI4cnlwampu?=
 =?utf-8?B?RDVnVS9CZ1pZN1VCMGRoa2tuOU9ZT1lqajdBZ3ZuZVgzR2pWeEFKckhPSlVs?=
 =?utf-8?B?emxmZ3JZTHFLL2RHeW1qWlo2Zk05T2hqTkJINkpVbGZxbnJHam1yRElMdlJS?=
 =?utf-8?B?c0FtZklRRjBEd202cVZpaXBOMnlTYlZVSTNZd2V2Zi81OHU2YVo0TlRQZkRF?=
 =?utf-8?B?eUZJZXd4UWpFK0FtZWNPQUhWVzlDR1pqR2tMZWVyMEJHNDdCNTl3MTMxR3Vi?=
 =?utf-8?B?OFgwbCtXOHNGbUplZmU1SERqc0QxYTBWOWFaWTF2bjhONEVCOCtDNDRhNDZW?=
 =?utf-8?B?U0FabnBJY3AyNkdzRTJaY1pmQTB5T2oyaytuTWp4VTFLZnZJdzdpTFlLTGlL?=
 =?utf-8?B?SHZNWTJ1Z09FOEQycmFTbFhqUFVLV3ljN2JSZHl1UFhEK2UyZVdtcnpYQXB6?=
 =?utf-8?B?OUduQnVmclJiS3djUk5ya3NCU1haOXNRZExLMHE1U2tyVW9nWlVvTDNSbkh4?=
 =?utf-8?B?TzVqTUYyR3ZjN2ZydEJYSGxhenE4eXY5OGpadUhzc3E1NjF1NUNoSkJ0WHQ2?=
 =?utf-8?B?UkNFRE9LcjlBV1V6ei9XMWdXM1RtWTBDUmRDU0xUOGhqQlNyWlFqVk1TMjdV?=
 =?utf-8?B?MTUybVljNUVXZ3N6MU9MUk40NTB2RFljZVFHOXNnWmZVSlY5MGgxMlYyZmEr?=
 =?utf-8?B?a0p4NVVKbFBwZm8vblpPSVBzTkJsZnhEOFNHd0QwZ3FnTGNuVG1QRnB5VEds?=
 =?utf-8?B?Ri8vc2hkYmV0eW5XY1NuRWY2bzRCSjM0RmkvcWp6Tm9GNFpSSVhib3Y2cDFM?=
 =?utf-8?B?TmQxc1NNU0hlelpzbEZqMXVRZktyZWw3ZUJiSlhSa3VlQVdJNFFIdDQ0ZjQw?=
 =?utf-8?B?TG1uS3VNMTdLUEwyNjFHYmd0aVJyUjZPMjFIUStSMDRGeWhodWw2RnRubnpH?=
 =?utf-8?B?OXRVTmxiOE5Sc202R01CRW5jS3BHU0dLck9uR1k0MVFGekwvVG5zZjJmSFZH?=
 =?utf-8?B?VW1qR3VSakpZN0dHbVo3cktwUmZFc05MRkgxU045QmJTeG8zRHRsZkRIdXdY?=
 =?utf-8?B?QnRkTjBtQWs2b1pIY2M4b0tzYSswUnBJRVZOWVcvRFlYcHkzL1VpazlDWlpH?=
 =?utf-8?B?RDZXbGFSR08zcUJISkpud3BBckV6N0Y2YXlaSWFrV0JDKzNIQ0NwSC9qTUp2?=
 =?utf-8?B?Zi9UNjdrR0VpZlFLVzVGaGROUjUwcXA5WGNjdml0QVM1MzV1b0lESFFiaDN1?=
 =?utf-8?Q?uRGmkwI8iggbV+OsBH?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN6PR18MB5466.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b31602-c494-45ba-ba30-08de705f441b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 09:06:00.0020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpOyLsm1xhhCRyqScYNLyfwV1qcTei6obFxqo4k0O/v1A7zCzFh7XufcXCsHZNFwxiBPq4m/V1ov16J3Tvctow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4800
X-Proofpoint-GUID: MRw4qFKMc4EF3sehz5byicaSNd2rYoH7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA3OCBTYWx0ZWRfX5lDeq2CPRhe0
 OvDzbobcX59UoUISROZPQXo7uqwg5cza00JmuNSNUcQShJ//0qkm3Bo1O/G2kta7EHfuokHij5j
 EMa8IrkGSMNVtjCQDft4mbawNsFAekuS4K6d3HXh1jjCt3CIjv0XZYnTWR6pmitc52DjJwUgzWq
 Xh+CrE3fSgwQAlMnXhNBsr5s+XR+oYln/pHuBZhYqaOEL6+/tFK6rRJc1+g3YWqqZA+yLfMOZsi
 4pAxhS0vtTZVkzvpezF4fDEufz2wwIwJCeAqsf6Q9pp65MU9xizSwsKU7Er0R/YjxTNq08GiMJ/
 iby7zpljysKvn1SBaeeV3yVVW41aIF0io6Z0UiZiQ+QMTwJmL+P2wDkYz9QTBFdd1DpnTUutmFX
 p1+0d6gS6l4Va67JIWB/W5iA729kp9fuH7Ci7cWtluyj6R1/qjS1Rd5vut/CEil4lCZM+9htKOx
 o4v2z9uVJ6lOX8fP7Ow==
X-Authority-Analysis: v=2.4 cv=J76nLQnS c=1 sm=1 tr=0 ts=699823fa cx=c_pps
 a=EX0Xkmt19mXnrP5bPG/VDQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=20KFwNOVAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=RpNjiQI2AAAA:8 a=_LCPpSgGwic_pmgPkV0A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: MRw4qFKMc4EF3sehz5byicaSNd2rYoH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259672-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,MN6PR18MB5466.namprd18.prod.outlook.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 69E7A16602E
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxNywgMjAyNiAzOjI3
IFBNDQo+IFRvOiBWaW1sZXNoIEt1bWFyIDx2aW1sZXNoa0BtYXJ2ZWxsLmNvbT47IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBT
YXRoZXNoIEIgRWRhcmEgPHNlZGFyYUBtYXJ2ZWxsLmNvbT47IFNoaW5hcyBSYXNoZWVkDQo+IDxz
cmFzaGVlZEBtYXJ2ZWxsLmNvbT47IEhhc2VlYiBHYW5pIDxoZ2FuaUBtYXJ2ZWxsLmNvbT47DQo+
IFZlZXJhc2VuYXJlZGR5IEJ1cnJ1IDx2YnVycnVAbWFydmVsbC5jb20+OyBBbmRyZXcgTHVubg0K
PiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxv
ZnQubmV0PjsgRXJpYw0KPiBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2lj
aW5za2kgPGt1YmFAa2VybmVsLm9yZz47DQo+IFNhdGFuYW5kYSBCdXJsYSA8c2J1cmxhQG1hcnZl
bGwuY29tPjsgQWJoaWppdCBBeWFyZWthcg0KPiA8YWF5YXJla2FyQG1hcnZlbGwuY29tPg0KPiBT
dWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggUkVTRU5EIG5ldCB2MSAxLzJdIG9jdGVvbl9l
cDogYXZvaWQNCj4gY29tcGlsZXIgYW5kIElRL09RIHJlb3JkZXJpbmcNCj4gDQo+IE9uIDIvMTIv
MjYgMTrigIoxNiBQTSwgVmltbGVzaCBLdW1hciB3cm90ZTogPiBVdGlsaXplIFJFQURfT05DRSBh
bmQNCj4gV1JJVEVfT05DRSBBUElzIGZvciBJTyBxdWV1ZSBUeC9SeCA+IHZhcmlhYmxlIGFjY2Vz
cyB0byBwcmV2ZW50IGNvbXBpbGVyDQo+IG9wdGltaXphdGlvbiBhbmQgcmVvcmRlcmluZy4gWW91
IG11c3QgaW5jbHVkZSBpbnRvIHRoZSBjb21taXQgbWVzc2FnZSBhDQo+IG1vcmUgZGV0YWxpZWQg
ZGVzY3JpcHRpb24gWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0IFByaW9yaXRpemUgc2VjdXJpdHkg
Zm9yDQo+IGV4dGVybmFsIGVtYWlsczoNCj4gQ29uZmlybSBzZW5kZXIgYW5kIGNvbnRlbnQgc2Fm
ZXR5IGJlZm9yZSBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nDQo+IGF0dGFjaG1lbnRzIDxodHRw
czovL3VzLXBoaXNoYWxhcm0tDQo+IGV3dC5wcm9vZnBvaW50LmNvbS9FV1QvdjEvQ1JWbVhrcVch
dGczWkgxOVVTTFVRdFF3Y0daMGF6UnhneExUWnoNCj4gMmNOa0d2Uy0tX0tPLUlvZ3N1eGl4WHd3
YWVXVEg4WDRtUWs4SU9xTzRPQmFubmNjLQ0KPiBhSGlXaUVhMWZpY2RPNm02UG1vMGskPg0KPiBS
ZXBvcnQgU3VzcGljaW91cw0KPiANCj4gWmpRY21RUllGcGZwdEJhbm5lckVuZA0KPiBPbiAyLzEy
LzI2IDE6MTYgUE0sIFZpbWxlc2ggS3VtYXIgd3JvdGU6DQo+ID4gVXRpbGl6ZSBSRUFEX09OQ0Ug
YW5kIFdSSVRFX09OQ0UgQVBJcyBmb3IgSU8gcXVldWUgVHgvUnggdmFyaWFibGUNCj4gPiBhY2Nl
c3MgdG8gcHJldmVudCBjb21waWxlciBvcHRpbWl6YXRpb24gYW5kIHJlb3JkZXJpbmcuDQo+IA0K
PiBZb3UgbXVzdCBpbmNsdWRlIGludG8gdGhlIGNvbW1pdCBtZXNzYWdlIGEgbW9yZSBkZXRhbGll
ZCBkZXNjcmlwdGlvbiBvZg0KPiB3aGF0IGNvdWxkIHBvc3NpYmx5IGdvIHdyb25nIGFuZCB3YXku
IEFsc28gd2h5IHdtYi9ybWIgYXJlIG5vdCBlbm91Z2g/DQo+IA0KPiBBRkFJQ1MgdGhpcyBpcyB0
aGUgb25seSBkcml2ZXIgcmVxdWlyaW5nIHN1Y2ggYW5ub3RhdGlvbnMgdG8gY29vcGVyYXRlIHdp
dGgNCj4gdGhlIEgvVyBhbmQvb3IgdGhlIGZpcm13YXJlLg0KSGkgUGFvbG8sDQoNClRoYW5rIHlv
dSBmb3IgdGhlIHJldmlldyBhbmQgZmVlZGJhY2ssIHdlIHdpbGwgYWRkIG1vcmUgZGV0YWlsZWQg
ZGVzY3JpcHRpb24gYWJvdXQgdXNpbmcgUkVBRF9PTkNFL1dSSVRFX09OQ0UgQVBJIGluIGNvbW1p
dCBtZXNzYWdlLg0KDQpUbyBhZGQgbW9yZSB0byB0aGUgZXhwbGFuYXRpb246DQpUaGUgY29tcGls
ZXIgY291bGQgcmVvcmRlciByZWFkcy93cml0ZXMgdG8gcGt0c19wZW5kaW5nLCBsYXN0X3BrdF9j
b3VudCwgZXRjLiwgY2F1c2luZyBzdGFsZSB2YWx1ZXMgdG8gYmUgdXNlZCB3aGVuIGNhbGN1bGF0
aW5nIHBhY2tldHMgdG8gcHJvY2VzcyBvciByZWdpc3RlciB1cGRhdGVzIHRvIHNlbmQgdG8gaGFy
ZHdhcmUuIFRoZSBPY3Rlb24gaGFyZHdhcmUgcmVxdWlyZXMgYSByZWFkLWJhY2sgYWZ0ZXIgd3Jp
dGluZyB0byBPVVRfQ05UL0lOX0NOVCByZWdpc3RlcnMgdG8gZW5zdXJlIHRoZSB3cml0ZSBoYXMg
YmVlbiBmbHVzaGVkIHRocm91Z2ggYW55IHBvc3RlZCB3cml0ZSBidWZmZXJzIGJlZm9yZSB0aGUg
aW50ZXJydXB0IHJlc2VuZCBiaXQgaXMgc2V0LiBXaXRob3V0IHRoaXMsIHdlIGhhdmUgb2JzZXJ2
ZWQgY2FzZXMgd2hlcmUgdGhlIGhhcmR3YXJlIGRpZG4ndCBwcm9wZXJseSB1cGRhdGUgaXRzIGlu
dGVybmFsIHN0YXRlLg0KDQp3bWIvcm1iIG9ubHkgcHJvdmlkZXMgb3JkZXJpbmcgZ3VhcmFudGVl
cyBidXQgZG9lc24ndCBwcmV2ZW50IHRoZSBjb21waWxlciBmcm9tIHBlcmZvcm1pbmcgb3B0aW1p
emF0aW9ucyBsaWtlIGNhY2hpbmcgaW4gcmVnaXN0ZXJzLCBsb2FkIHRlYXJpbmcgZXRjLg0KDQo+
IA0KPiA+IEFkZGl0aW9uYWxseSwgZW5zdXJlIElPIHF1ZXVlIE9VVC9JTl9DTlQgcmVnaXN0ZXJz
IGFyZSBmbHVzaGVkIGJ5DQo+ID4gcGVyZm9ybWluZyBhIHJlYWQtYmFjayBhZnRlciB3cml0aW5n
Lg0KPiA+DQo+ID4gUmVsb2NhdGUgSVEvT1EgSU4vT1VUX0NOVFMgdXBkYXRlcyB0byBvY2N1ciBi
ZWZvcmUgTkFQSSBjb21wbGV0aW9uLA0KPiA+IGFuZCByZXBsYWNlIG5hcGlfY29tcGxldGUgd2l0
aCBuYXBpX2NvbXBsZXRlX2RvbmUuDQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgYSBzZXBhcmF0ZSBj
aGFuZ2UsIGFuZCBhZ2FpbiByZXF1aXJlcyBhIG1vcmUgY29tcGxldGUNCj4gZXhwbGFpbmF0aW9u
IG9mIHdoYXQgY291bGQgcG9zc2libHkgZ28gd3JvbmcgYW5kIHdoeS4NCg0KWWVzLCBpdCBsb29r
cyBsaWtlIGEgc2VwYXJhdGUgZml4IGluIHJldHJvc3BlY3QuDQoNCk1vdmluZyB0aGUgSVEvT1Eg
Y291bnRlciB1cGRhdGVzIGJlZm9yZSBuYXBpX2NvbXBsZXRlX2RvbmUgZW5zdXJlczoNCiAgLSBD
b3VudGVyIHJlZ2lzdGVycyBhcmUgdXBkYXRlZCBiZWZvcmUgcmUtZW5hYmxpbmcgaW50ZXJydXB0
cy4NCiAgLSBQcmV2ZW50cyBhIHJhY2Ugd2hlcmUgbmV3IHBhY2tldHMgYXJyaXZlIGJ1dCBjb3Vu
dGVycyBhcmVuJ3QgcHJvcGVybHkgc3luY2hyb25pemVkLg0KICAtIG5hcGlfY29tcGxldGVfZG9u
ZSAodnMgbmFwaV9jb21wbGV0ZSkgYWxsb3dzIGZvciBiZXR0ZXIgaW50ZXJydXB0IGNvYWxlc2Np
bmcuDQoNCkknbGwgc3BsaXQgdGhpcyBpbnRvIHR3byBzZXBhcmF0ZSBwYXRjaGVzIGFuZCBwcm92
aWRlIG1vcmUgZGV0YWlsZWQgY29tbWl0IG1lc3NhZ2VzLg0KPiANCj4gL1ANCg0K

