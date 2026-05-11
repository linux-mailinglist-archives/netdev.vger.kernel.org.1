Return-Path: <netdev+bounces-286635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I+iFBPMAWrRjwEAu9opvQ
	(envelope-from <netdev+bounces-286635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:31:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD06C50DD7F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96E02306366D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457273939B0;
	Mon, 11 May 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="WouqVEfs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE13637701C;
	Mon, 11 May 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502402; cv=fail; b=CnnVNoRzymaj7JclN8NqeFOHWXfjx12ot0HOABenfs6T2uPyA3XunBda9b+Gu8xv+vgnR1KyLIYT4bcsqTYBzXlrKMApzo/L04Fj1mWyKiobX10Si4D+EuRRy5XxOy6kPZHBkmpl7OE3yojloogSHp1isOC5H0FYZ8CS1YKJJKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502402; c=relaxed/simple;
	bh=9a+bHnhXKbfXq1yQawMPcVYEbWGlYLhcbMIGfZfP1F4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MVxds1TSER4NtEBN2ejQvVBYHa77TBxuorDO6cUVdF02mZXwWK0N4LyM+7s19N/MUD4F7w6wTYKFBSlkRy3PaNl2eoq/t6PUlBnl8h3vyuf85n3ZIjesydo9XNIo0i/Q1z7cG9f0b3KK+j/eQwxWODdmcklxB5ktXPLnjuuIfxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=WouqVEfs; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ANhiSP2277095;
	Mon, 11 May 2026 05:26:26 -0700
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020128.outbound.protection.outlook.com [52.101.85.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e2s68t7ur-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 05:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XP56uNc4+t7EjV1NX4bkfHJQ6/aEko3aOEG04799ljnymKddrxYvzfTv5lTHPyTZ0KfUtzIjpAPS5RF+9ZR4FMCRZysbFZEeUbNaLAP0SHhcIIgSv46w7hFMd35HrY4LDbTuqIkI/xx635A19k2MEeeAHRpbzOMLLaQhJsnP9/aNzJ0dn/ephK7M0agvRn5M4xldK09BZTqIUsb+DpjF4dZlg5BhlYfAhPU7EXh95W7vugrjV9ilP8EiNMkeuKEvrYRm/cwlNLqThmKgBBbC5uZi26fYjKqIc9nlLSGe7LqCmLFAGFVRGX+blVy9pifQ+oS3cLNRchh0D3aJmnVIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a+bHnhXKbfXq1yQawMPcVYEbWGlYLhcbMIGfZfP1F4=;
 b=QoMQ0eGxd6uMUPShipiCPkBc29R/QdA51YZSZlBthKbV/3JccKjNcV9oF586mklgwX8i1xxogxNgHnhX9mzOjsQTU/2mk70T2AIMv3aRZznaQdvMEp5wneuNX+5o47rASa15E/or2enSfbiuHK1ECEyhTIyo0sDFDMcJGsZyPL+JXkZO/9+SA0dhP4xHO26xw0UYQ704Jwa1Tu2KOoBrM69nTrizdcRHFk0XKPJUp93NQQ3aJmFlEcS/+0zmYAYSNB5crflU0mqUkrXrWvcGuvRDNUakazY2934PUimMtmW3wD4YAd90FCSyhIZ9GDXze7Y8TOxyFPtp1eAzGzp3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a+bHnhXKbfXq1yQawMPcVYEbWGlYLhcbMIGfZfP1F4=;
 b=WouqVEfsYNJdiLcVyRwqqmyJL37o2nB3RwSH6+dL3LWkDKN7q1gD3iQk8R2kmYR02T6OvAY3SIBCci7ifZzgge8xvgAthetYgoOpgBmosGyKgM6UTbSVwCzjnXF9bLImlPrCqvqFsDaeaFKN/bbWmolT7cyPOypTsjI0xVwxOBM=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by CO6PR18MB4388.namprd18.prod.outlook.com (2603:10b6:5:344::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 12:26:23 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%5]) with mapi id 15.20.9891.016; Mon, 11 May 2026
 12:26:23 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Igor Russkikh
	<irusskikh@marvell.com>,
        Egor Pomozov <epomozov@marvell.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2 0/9] net: atlantic: add PTP
 support for AQC113 (Antigua)
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2 0/9] net: atlantic: add PTP
 support for AQC113 (Antigua)
Thread-Index: AQHc3uKdcgd5G0oo5k6pxB8g7qhGELYEwPUAgAPAAzA=
Date: Mon, 11 May 2026 12:26:23 +0000
Message-ID:
 <SA1PR18MB4600B9CEB989661CFCE73DDBBA382@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
	<20260508120156.3060-1-sukhdeeps@marvell.com>
 <20260508160656.2a318b34@kernel.org>
In-Reply-To: <20260508160656.2a318b34@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|CO6PR18MB4388:EE_
x-ms-office365-filtering-correlation-id: 08a67613-a729-46be-784c-08deaf588384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|11063799003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 dTUx36JvvqySwHrCOitE3jJsNJ3kb+3chYOq4EQrWYzxC9XENmBIVhIl6riOZvE6L1/HaBHQgxEQ6LiAiLR2gkE0bICJAlOauScZgaESehkFIQfvv49/0RXgxT0XmrD32pAh9X7XsDkuuoAqlro4f0RwNNyQN39gUd06g3H0X0ZkZkPIUfWasPhYzbgemVyt79nfjUZv3SicrD0AtmVcPXs/iNDGwhZrojZCabOZX3W63TBnCpIWC9aOdCNwCIXb9m3pAXsdDfSTOeTqaERhot7LU62BvN5Ny4aVDjxGUy0NUxZ4nt0B54KfyHqG0e0ut5pKsTwvXntm06czJ7JDm2LGmEbgxdnZ3N/hAUZ5KmZruoUVS9rzDOqGhucdJS2WCM2nDKbPsss730AZsVKrjKgx4MHXpLgauRDIOFaJjAbiwwxGrJBZls0Qm5EfjKuYY7H9qJ2x8qtWaFjg3V0/AimbcpbdpJQ7DvOh1IgMMJvvQrIv5YiRN2Ytyqwal98ewK+MAs0pwE0HFeEL2Z6UzeBXOQMmNnZOYhB1C70f4SE0oopK15YMmpfOAtnjgZ/t4XTQkL8XzEH7ROB0mdALNp3c4pMLo6GzgmtPkY6utPVDWDnvlqhrTs8LeEgZcx5rCgXGCXhuUR5IZmJbsLoBd+RFkcC0YHIQMwr4dwrqeHiW4xAn77TsnsLonWCr9OeJijdI1C7C+HpEQG1vQ6VQvG+Yd+L1R3kvDB9Nm954o2KNTA6gKjUPnKcoBHuNoMRK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799003)(38070700021)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zk00Yk90WXRSUEo1MlNDS3ZCQjBpdHRzZ25mTSsxNWRHNWlaaVhEbU9EUnpm?=
 =?utf-8?B?dVFqa2VmYWYrRFhjTWVaTlUzK2dhaFBaaXpqQWdwbExJU0J2RG1mZUZ5L3Q2?=
 =?utf-8?B?QkpVTWxmZ2tzb2w0Rk1Md01rK3c1d2xxdjBEbTZXU0ErSzhwbU5qR3ZKQVlF?=
 =?utf-8?B?RlFCTnEvLzhId1hqOE5BcGEvWk0vY29vNEMzQktxT0dTeldTYzU1aE5GWFdu?=
 =?utf-8?B?QW5LbUxxRTdONXBVeTFaMW85cmY1bk5pMHdtWk82d1k5em9oUlRCb3dwSUlF?=
 =?utf-8?B?T3UwVGd3UVRJZ2UwSTdRWmZLbUR3RHFDM2ZzR1Z0a2lUVnlPVXBaWUk2Z1NL?=
 =?utf-8?B?SytFVmk2dXVjSC80Z3l0T04zQVA5Vy9SbUxYb3VJVjZtb3k4ZjJTQ1Q3RVJH?=
 =?utf-8?B?bEFlRlJhSDZuemNwQ3ZnT0dNYUtpWENjSDFNLy83VzVjbHJRelZhS202b3Ny?=
 =?utf-8?B?bzYvanFNZm1wOXMyLy9ISUlpV2tCL21zRS9FMmJhOTBreWs1OGUweUdhcWRW?=
 =?utf-8?B?RDZreXpldWh0Q2JHc1ZsKzFjWklLNGdBSk9HZUdiMGRiU0ZrVEMvR2haTzU1?=
 =?utf-8?B?TUtvNll2SG13VW53NWNRUGZDWXN0WlJLZVJ2MG95SlNEVTJ0clVxYm02UjVk?=
 =?utf-8?B?YWFhTjgzZlJkRTVtcXJRVFlTdUVBWEZLZ3piNTJHeVNxdXhYVjlpSWxYY1po?=
 =?utf-8?B?MTlrcTlkM3ZxaTFhSFdjendHdTZ0RGRIOGJVaVQ2SkYzUnZCRHV6eVY1cVh4?=
 =?utf-8?B?RGh1dDFubWNTS0RTajdaRWtXTTJUNldpY3pFTlgyQ3pNTnBROW1samdZaEJU?=
 =?utf-8?B?UVc3blZ4VFFsL0pnQXpaM0ZLNXRTOGRpcDJoRThVdWdVaHdBTUhydU82eklj?=
 =?utf-8?B?Z1NMTWVWVFdIR0kyZzFhRTFyWUREbzh2NHhLWmhPVXhCek03Yml3WVFCV0Qy?=
 =?utf-8?B?U3FaVW0zd3BLM1o0VzRhaXl3azlHb3U3dmlsVmdiblRRbG9TL2s4empqM2JB?=
 =?utf-8?B?alhtOUZ3UUtSbnRsL3R2NmFuNTdRNnMwTVFTN1NJL0JyVkw3dUVXc0lVMVdX?=
 =?utf-8?B?SktyUGtDQkIxdXpERFN6STFSQ1hDZDBGdm5uRThyK3dsTGtscEZSa1N0Vzg2?=
 =?utf-8?B?T3I5Um5SYWNPZnNMOWZTTDUyaGZWTGJsTG85TjhZekF6eEdSc1BWNlhMdDZl?=
 =?utf-8?B?a0FzbWpsQ0RLMHVFRUlLYm5KMDF5T1Avck9BNHZhN3IxWjNmNjdlVVpsTnNN?=
 =?utf-8?B?SG9Id0hlUEVuTFN5R3NKOXNWZFdqd0lJOEZ0bGRjbWJWUFFYb3VtM0dHaUFL?=
 =?utf-8?B?cWRKaEE0Vml4SFp3SlNtWnExTVpZVGYvSnRlRjU5ajRWcjRuY2dENyt2aVZB?=
 =?utf-8?B?L011cllYRzdhcDhKWWZrUXhxekVqN1ExazN4S2VKWnVKMTQrVDF5ZmlpU0lU?=
 =?utf-8?B?cldXakZWdDV4WDQraDdEaTVqQWkyV3JyakRqSlNPMUN3Mk5lakM1d091SUtp?=
 =?utf-8?B?QUd0T0d3cDgzNGo2U3YyUkhWNjlCSlNnL1BEOXNqNzlrMVkwUEc5Y1ZlU0lN?=
 =?utf-8?B?dHcyaHg4VTZBNDdWdnd4b2NDZzFtRk5PY0dlaTFQMFBLMzNnekhYVjJXakhm?=
 =?utf-8?B?Z2pPUDM2VnFVRVI0d2s2NUthQ0FSaEpYK3NSa2R2dnZwRGVkbVRqR2wzVUFB?=
 =?utf-8?B?eXJENGhuYm5SemIzNlArNjlDNTFqNGE5N3BCTzdHdFRIdWZOekRBdVN4THk0?=
 =?utf-8?B?cytEUDFQSnlYRnNNb3RXek9JZUFRNFhNTE4xM2xTM3NDU1RTbTU0MGhjRkF4?=
 =?utf-8?B?aTBTVi8xU3E5QmIwaUU2OS9McXkrY1dGOC8xUHkvMDRGcXdPVEVZQW95R2Vo?=
 =?utf-8?B?SFljdFByNkZ5VHdPMUNqNWNHSWlqcHpOMy9CTWlBckY4K0FjNzN6TE9KNW55?=
 =?utf-8?B?TkVOc1AzbmIzcnJvcUVZcTh6dFlqUW5VY2lPTUF1dDlBK2c3a2NNSnhJTEV6?=
 =?utf-8?B?Sng0MWs0R0N4a2E1WmY0WWJkMnZwbDI2dVh5MFo5RExrMmk5Z1hUak41a2Yz?=
 =?utf-8?B?bDhPV1lKbUNOMWZmTVl2Z1RlRElQUDgwTUVjbVliN0pxUkhqalM2aFA1YnJ5?=
 =?utf-8?B?NjJCOU9UYWFhcFJ5eVFJeFQ4Skt1MkUzQ1F4MzF4WVp2RVRwWTIvWkpIV2Uy?=
 =?utf-8?B?SnNIOTAxbWErNzdxRXlvZHljUFBHK240VnZpWnZZemVtUWNqTGdJS3VXZW5a?=
 =?utf-8?B?UUF5ekhpVFJSQTl0d0l4elVWMisweHNOdFhHRG5xeWZ4QTY4SjYyNGJWTDhr?=
 =?utf-8?B?dWk2MUxwMU5BWjZ4NmFqMTgwRnE4Mk80V2N2NjNnUHFzdHUveE1WQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Z0zEmwz6ypSDFpu061wXQrhGA+gzhe2Ux55oyyynrSVxys8smsqn/Y/Mm0Tk2moyLxC/yUar89h8cc2SSOV+Plth9wW7u3OClcZAKxKz89c5Nkc3nG5Bd+pr1yLkpRCFhBp7g5GzrRD9bsU8IaSdJWfxuVcihA0kMjGv8uPq6DhgmgatZ5nB8ROj4liwaV9ltjOdu0QIHYHkxg9dhuytbOD1Dk39kIInps4eOsxKWtxUzxBH/cyhkSKHj3psMSC2aeKFuTawudeFPauFhHIKU/o3OwEEXOHV2B/dgN+HOas9kKQMj8f4GigIY6jsmMJNbKnuOIpN1oErh77wtc+rtQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a67613-a729-46be-784c-08deaf588384
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 12:26:23.1464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0WwiFSbZfcDDROBxZ/XDAaHYBdnJ+HEBa7jol9+MbtPKMBHyUlKuPYD3aSmll+CQQNwxfDdRJnw9FN2qrQAig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4388
X-Proofpoint-GUID: JzvltyVhSyy2qL2uRz13R-4Ljfldr0oq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEzOCBTYWx0ZWRfXyMz5dmEnlELJ
 v098xg/4fksBTauHJjmnxIFOpLFClvgBbEl1gZ73vYMddBDBYpU1Cp71LF+hvB82n6b8wM5U3yj
 saz1yGPkYMKQrI+7cUSK+aoFncA++B6v+W3fTvA3w1ItA3D3hiy+8zXXC5tYlvjV1malOBt1+ts
 0xBD0fBfnSxLmT/n6elU2lF2zEV85Cxkz6lJ7sGm2fnPluFlWLHBz+FaGGlBFoLUOR1AF6fAk3s
 nlWovO6htPkmFwKWd4fpUAgSyuAFnuTZE8J04O/5LHynpVOcEpLhhl32ZhnIkpeVRxrhd3WjgNY
 roGfiRKTeHaiH0Q+bxeiGZQCN963osDJ/kejc+d5Grm+UI5aJHFwPULY/C9c41r9CV0anYGSlqT
 ZlX9g4yPH+hWztwxHedvSDakFy2RzSivgw8cAYyUlgNXLnGH4ZHkwD9LX6orqq1KFYLRQSbkT8n
 78xW9EYJ/nDX2JnOIVA==
X-Proofpoint-ORIG-GUID: JzvltyVhSyy2qL2uRz13R-4Ljfldr0oq
X-Authority-Analysis: v=2.4 cv=Y8rIdBeN c=1 sm=1 tr=0 ts=6a01caf2 cx=c_pps
 a=rJ76FBf8UdibaoD+N2q2jg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=oaKmgr--pvBPtWvGvdMA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: CD06C50DD7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-286635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,SA1PR18MB4600.namprd18.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

RnJpLCA4IE1heSAyMDI2LCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gT24gRnJpLCA4IE1heSAy
MDI2IDE3OjMxOjQ3ICswNTMwIHN1a2hkZWVwc0BtYXJ2ZWxsLmNvbSB3cm90ZTogDQo+IEZyb206
IFN1a2hkZWVwIFNpbmdoIDxzdWtoZGVlcHNAbWFydmVsbC5jb20+DQo+IEkgaGF2ZSBhIHByb2Nl
c3MgcXVlc3Rpb24uIFdobyBpcyBtYWludGFpbmluZyB0aGlzIGRyaXZlcj8NCj4gTUFJTlRBSU5F
UlMgbGlzdCBJZ29yIGJ1dCBoZSBkaWRuJ3Qgc2lnbiBvZmYgYW55IG9mIHRoZSBwYXRjaGVzLg0K
PiBPY2Nhc2lvbmFsbHkgd2UgZ2V0IHBhdGNoZXMgZm9yIHRoaXMgZHJpdmVyIGZyb20gdXNlcnMg
YW5kIG90aGVyDQo+IGRldmVsb3BlcnMgYW5kIG5vbmUgb2YgeW91IE1hcnZlbGwgcGVvcGxlIHJl
c3BvbmQuDQo+IFBsZWFzZSBoYXZlIGEgcmVhZCBvZjoNCj4gaHR0cHM6Ly9kb2NzLmtlcm5lbC5v
cmcvbmV4dC9tYWludGFpbmVyL2ZlYXR1cmUtYW5kLWRyaXZlci1tYWludGFpbmVycy5odG1sDQo+
IGFuZCB0ZWxsIG1lIC0gd2hvIGlzIHNlcnZpbmcgYXMgdGhlIG1haW50YWluZXIgb2YgYXRsYW50
aWM/DQoNClRoYW5rIHlvdSBmb3IgcmFpc2luZyB0aGlzLiBJZ29yIFJ1c3NraWtoIGhhcyBsZWZ0
IE1hcnZlbGwgYW5kIEkgaGF2ZQ0KIHRha2VuIG92ZXIgYXMgdGhlIG1haW50YWluZXIgb2YgdGhl
IGF0bGFudGljIGRyaXZlci4gSSBhcG9sb2dpemUgZm9yDQogdGhlIGxhY2sgb2YgcmVzcG9uc2Vz
IHRvIGNvbW11bml0eSBwYXRjaGVzIOKAlCBJIHdhcyBub3QgYXdhcmUgb2YgdGhlDQogb3V0c3Rh
bmRpbmcgc3VibWlzc2lvbnMgdW50aWwgbm93Lg0KIA0KIEkgd2lsbDoNCiAtIFJldmlldyBhbGwg
cGVuZGluZyBwYXRjaGVzIGZvciB0aGUgYXRsYW50aWMgZHJpdmVyIG9uIHRoZSBtYWlsaW5nIGxp
c3QNCiAtIFJlc3BvbmQgd2l0aGluIHRoZSBuZXRkZXYgcmV2aWV3IFNMQSBnb2luZyBmb3J3YXJk
DQogLSBTdWJtaXQgYSBwYXRjaCB0byB1cGRhdGUgdGhlIE1BSU5UQUlORVJTIGZpbGUgdG8gcmVm
bGVjdCB0aGUgY2hhbmdlDQogDQogSSB0YWtlIHRoZSBtYWludGFpbmVyIHJlc3BvbnNpYmlsaXRp
ZXMgc2VyaW91c2x5IGFzIGRlc2NyaWJlZCBpbiB0aGUNCiBkb2N1bWVudGF0aW9uIHlvdSByZWZl
cmVuY2VkLg0KIA0KIFN1a2hkZWVwIFNpbmdoDQogTWFydmVsbA0K

