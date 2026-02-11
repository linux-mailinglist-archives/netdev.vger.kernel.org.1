Return-Path: <netdev+bounces-258233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP8yEkxNjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:35:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8173122C86
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34A9B302A6F0
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC63563EF;
	Wed, 11 Feb 2026 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="pe76Ldt1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0372355816
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802424; cv=fail; b=OlowUN/TjNs9vCDgNrUHVITsgE5Jc4oVgUcTEu07c2i6P+2Ygvql6qwNXWwMAuKd3oVUEi7tjAwMIg0F71mxcTL94IPeFBf8W6SUxqVgfWXSAhambchNfffPElAJ6xAxWMCaE4jiV/bQCECGPFdQVvuvneubdbJVEIUSv7umjPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802424; c=relaxed/simple;
	bh=h4RLUe5mUdkc2KCBwlXVwGIR5geKUU7iCUOgFgaV0iM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dqlDtU108Tctne1+bAyObudYNbuhFXfWvG2Ek7FB5Ysz/6d5NeCEvcVmz67a3qvwoWOC7+UQLECMqCusU591NzC+Mygj99CjNJlQFt71WyLPG1ePRcY2inm7mbP0ozSSdhCRJwpd6F+hHu0hriOmCCCEbj3YppRm78KocmKeQKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=pe76Ldt1; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B8PAXr1273921;
	Wed, 11 Feb 2026 01:33:30 -0800
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020095.outbound.protection.outlook.com [40.93.198.95])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c89g1j0r9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 01:33:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jR89nQ0HApvxdxlNzC84yyfB3/C8ZUYBIT8CO8WIXeSOsBVOZxnMJu1nISwCi2+NnyUcpUMpzLpEak9Jbwg1brU/dWBV4fawV316eWcUcviDLxuFheKbonzfV4KTL2zyIdC+r6LIQssz+nEqGGFGF33KYbF8gv44D8QCtoiqxleE/nXYClFlZ6mHfxjunb0kgsvcIBbp0emx7KNtjhKePKXUtKvKPNcj3etellP7ed8q3R/e+S4k6qipZC9pgpPJO997EKnTJhuphkxh2KNvTBPtaoMzHSHZtWXmMPZ8/5hGrDGnmSAZKbpLSklLKBCeiywhHUVC6RrgS0W6oAbhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4RLUe5mUdkc2KCBwlXVwGIR5geKUU7iCUOgFgaV0iM=;
 b=H3mWRVN3nIQ5mj4D3bGGcTl+8otBJ89Arzx+yyH1BtFTWDe8Coj6twEZ0SYNw52j48px8lk8Sg70XaLNj2UTTTOn8H6e4ZS+PYl8yRcxhTvooM37yTQtfQDoXMbKgZ2ZBJtHxHe99ugHJJGRlOrd8VBTB3sj7GHLuVM0ODxaB2h7mV7vvY7bFecLTUMvRGfRf+8APq4MWw3AexKxoCg5uIr5SIJ3kB3T1dfdxJERw02iKUhuuNyH2FrTguJj/xZRw1qvUWLIWhgVb6ejegUBaU03ZM/dbmlaFcj0stuAjafOVNs7svfFHd7+vZ88t1ybq2Ybje4OcKSPVA4L3sy61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4RLUe5mUdkc2KCBwlXVwGIR5geKUU7iCUOgFgaV0iM=;
 b=pe76Ldt1DFBWNWhhjrkYa2ylGD7RVN0CHRlXT/bsiydPTe8Z2sWw5g/PbRkpQ7+j0UXFuVEsqecHW+jV4RSM4YKXZU5bdlSoRGRrEW+37w746e1RbkJ3Y72+PWP1j+8istfX1iIrZ00WkM+RL9YHez5pddhOK5uJyAx8Ju5lMMo=
Received: from CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13)
 by PH0PR18MB4428.namprd18.prod.outlook.com (2603:10b6:510:e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 09:33:26 +0000
Received: from CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac]) by CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::a4a5:2144:64cb:7fac%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 09:33:26 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula <kshankar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 net-next] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH v2 net-next] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Index: AQHcl2Bnnph4NcKMQkKIjFDXE6aND7V2kJwAgABwn4CABiDWAIAACokAgAATjjA=
Date: Wed, 11 Feb 2026 09:33:26 +0000
Message-ID:
 <CH3PR18MB637977B15CD77E0884DF56B1A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206191308.7fdbfef4@kernel.org>
 <20260207045416-mutt-send-email-mst@kernel.org>
 <CH3PR18MB6379AC9DFA09E80668BC0BF8A063A@CH3PR18MB6379.namprd18.prod.outlook.com>
 <20260211030643-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260211030643-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR18MB6379:EE_|PH0PR18MB4428:EE_
x-ms-office365-filtering-correlation-id: dbcfb1b3-fcb5-454b-32ab-08de69509bd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmVDd3dBSmQ1YkVtQW04MExxY2pyeDBJK2hYVGR3ZXltRHpTSWpBb1F3V0JB?=
 =?utf-8?B?NjFBZ1RHOUp2anJNWDJ3amZ2R2JrTVYydWJnOUtqdktWU2FEVnAzbEUvL25Y?=
 =?utf-8?B?aXdZSGwzSkh5TmZ1Q3FSd3ZMdWFOd0JFUG1lNzh1VCsvV3dBRWU5d3ZDTWxx?=
 =?utf-8?B?Ylh4a0V4WlBxMWZpNHhLMFBpc0JpbGZiWmpPdnA5QVlDNWFzanZKUGk3MG1F?=
 =?utf-8?B?YW1wMStWZnBIRnN0UjY2OEhKUC9Ba2dYVEtJODRwd2NKQWZsSG42K0U4eHhU?=
 =?utf-8?B?QUFOUHp2ZUNsc2xJd0VKK3BMYlJncTF3SWtycG9YSnlWZE11dEJEUk5KaGh0?=
 =?utf-8?B?eVpvRUVQbCs4UTByWEJDY0JmcTM2SUJFVUFtemN2OU5tSDVrNnJFUnlJSUJS?=
 =?utf-8?B?OHFNNm9ySVdmSjdTUE5ZK2RBbDlyOVhpcTdsaVlFdnlHekhXTzcvS1U5SGRG?=
 =?utf-8?B?b0U3OGdPU294UHV6ME9nV1FJcmdreTZFdXk4NEtCVTRpbUQzMURFcjJLeFhn?=
 =?utf-8?B?aTN0TzQ1U3hjNzJBUXV0SUZlWnkvMjh2ZDFNYXdIdEtMOGdmZlJqZ0h5a1Nl?=
 =?utf-8?B?UnhsS1hMTGs5VlA5dUl2YlM4ejgzVmVpYlF4MWdXZCtiT09KQStYTk96d09G?=
 =?utf-8?B?WFYremZwbzliQUFMd0NoSXJPbldMVHQ2V3R0QzVxcXE1ZXRhS2s2akU0VE5h?=
 =?utf-8?B?U1FQTG9LSVE0ZEx2VDUrLzRITVJvN2JRTWNITDh6TUQrV1AxT3ZLNDdZMmJm?=
 =?utf-8?B?SEJVMEJQbkNBMjRxdFJvSEdTN2NJdWExUUdHYkJhQXBkWWZaYTR1bm1nZXhN?=
 =?utf-8?B?eUxJVzBxS3gzbHI0blBHV08vdDdKR1F1ZDZXQk54UnJTWmVKSzAxMnlFM0I0?=
 =?utf-8?B?Rnl4RkRQU2JDVTFXYUJ3cys5cTZtZkN4cWE4WVBPWVVpOFBUaUxmVEExc1A2?=
 =?utf-8?B?OVJ0cW9vSWxHZ21Pa3NsZlE1UytTWkpqMFVSM2E3TFc1eFlrYXRnOFM3bG51?=
 =?utf-8?B?K1RCVXZHYTFNUzlzb0RlSXB3Yk1QZFRoUWNnZXB5S1REN2tVQVFTbExzbU5w?=
 =?utf-8?B?SzB4NHVSU3pIaFN0N0E1Rmx4WHVpL0ExaFRpdG5ZazFYMHZsYkpNSXFBcC9n?=
 =?utf-8?B?cTFBeU1rNWZqeThLcnR6dUNvODZxcUU4ZFJzWjJsOEdaR0pQTk1vVVY2bGJx?=
 =?utf-8?B?SjIyRCtHYVlvMlJYM0hvZmFEVHV1TDlmV0Vncml5K1Z1U3U0Wis0bWFBRUdn?=
 =?utf-8?B?WFA2RUhlRjFyTW9aRnpJdXRQenlCQmd1SzVCYXB1VzQxSTJMeDZ5aTlSYkdn?=
 =?utf-8?B?Y0ZJd093VVRMUjBROHF6cVRzSjd2ZnROS0RnTThoTUdVV3JnTGIrN3ljMWsz?=
 =?utf-8?B?Q1FCcXAwSXNWbUVDMzl1N0l2Q3lBVUNZbTNjMVd5aHNWY3BZQ1dJN3M5VFhn?=
 =?utf-8?B?a0ZTcUxTTUFhdFpiTndrd01sUTFqRFdzUjNOOWlPdmVkbStZOWJLYXJNdlJB?=
 =?utf-8?B?U3VicXd4aDBkaFp1d3V2djBuQzlSZ293WU1CVXh5cGI5UjY2NHFramxPT0tP?=
 =?utf-8?B?YjJ6djFNS1F2Yk9pM2RuN0FzaGxranQwN2Y4ckxxanFlWUhQbWx6azBBejZ6?=
 =?utf-8?B?UmlHZkhHSFRSNHNzWWlhMERIRGo3VmE2eDA1cFJsaDZlSXhxV1hmSDlFZmdR?=
 =?utf-8?B?ekVlS0hVUG9KSlhhMUNLQUZRWFR5aituNWFvWEVpT0VENjB2MmpsVTFrdStm?=
 =?utf-8?B?YnhWTUJodmVPTGZiQWVBbitNRjMweFF1WU1ya0FZUy9keW5zdHNic2xRNTN2?=
 =?utf-8?B?T0IzbVROYlZXRmYvYkNRU3plZ051TmNFU0RYcGRqcjJ0djNyaTFiQnJDS1NX?=
 =?utf-8?B?Yk1LUXF0SS9tZFdWSVBGQ1cxc2hZTFU3MG4wLzZ1cXVvQXRPTXd4cmVVVWRX?=
 =?utf-8?B?UDVTK0FRS2t1ZkRwcDkxM3drSlp0VDJCNnhiQytQc1l1Y3BFVXd6d01WWTJY?=
 =?utf-8?B?NGlHVmJnQWN6UjJYYUQ0UUhzV0VaMkFVUC9RT08wNHFzUEsyM25JblcxV0tJ?=
 =?utf-8?B?dmtRc1EvRmlGVFE0aG9nU0d3V0Q5L1FscjNjSTFtczc1Q1I4dTUrQVJ6NlNX?=
 =?utf-8?B?Q1o0TWQ4RmY5eVhBbFQ4THAxNldyTFVidEthZ1loUitXWGE0R1dBUmh4MDZO?=
 =?utf-8?Q?jc3uKHbFkFAqaO3QMVED3Ss=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR18MB6379.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFU0Nit3YjVyN2F4ejVudFlpSy9neis1R2o5ZW0vQUFXK0hPZ3h0V0ZneFBw?=
 =?utf-8?B?TGVuYTVYU2NTT2IyU1FGcUxKS25leFFKbnhnT1NSZkxhSFdKODNXWUdXR0po?=
 =?utf-8?B?TlBKb1ltN3prUXR5RHVuSGlTS2hTVDhkRUg5OW04VENVYXI3bmlTZmtvZ3Zx?=
 =?utf-8?B?NWtYZW80YzVJUmQ1Z09EYk5EKzN5bzRVbzY0RXYvMzFGeWMzcEszU0xiSmFu?=
 =?utf-8?B?THlad0FqLzJlZGtxWkUwOTBibllrTnB6UnBVYzBpVyt4SUFMSHZZTUlzOHZR?=
 =?utf-8?B?Ym9pN0FYMHpwMlNoSGJobGwvNlJwOXpDNm1Jd3RmdGN5YmVWdEhmTUcvR3Mw?=
 =?utf-8?B?c044WG50Q3hHQ2dFWlJKWVk0bm9jRU1nTUg3ZDN2WjV5THliV2JUOVg4RmVa?=
 =?utf-8?B?TCswbWZWMzAzbERCUUYyS3dyc0tiZTZBcXJBVmdiR1hLenZSTndvMUxPNDVr?=
 =?utf-8?B?TW1xVHFBYVE5RUlXb2JheUJSS3FaVTIzbmxJWHRTcXdHdXN1ekhYdXVmS1Vm?=
 =?utf-8?B?T1ducXJPamkxSkM0cjNXeGdheVhqcHloNE5qbWcyYlcvOENRUVUvZkR0aFpn?=
 =?utf-8?B?bEhmczYyQ1ZndGtsUXcwOUhjbzdzWFIra1hpODJOcXRxRlRJQllzdUJMS0Vu?=
 =?utf-8?B?V0lsV3NKUVhPWlRpZjBOQjdRdzcySm5nM0hXOFQxcUI2TEtrL0dVMXd6KzhD?=
 =?utf-8?B?N2RNY24vV2dEQ2k5aHltVnVEVW1CRGM4SlJYTUpvTU5lL0JrL3BlUG5aVlJE?=
 =?utf-8?B?UmZNZjQzdlZMYmhQYjdxaWRmV055aExZNXphVzJ4RDdzbzdMdzY3MXJSRXpG?=
 =?utf-8?B?VTl3T0dLcDdwYWVOTGY2UXlUK1JIYzg5b3V0RGtZTUdhV2FYeitXaDdyNHh2?=
 =?utf-8?B?NnhET1hwbW0rZ0FxRTMwNnNNVVAvem1BdDRQM1pVa2ZUb1FEMEtLQ3hMbUVH?=
 =?utf-8?B?ZEROS1hhY0tiV1FzVkZsQ3pBdXVldnJ5Qk1oUWhzNitrdEVSZnZHTUVjNVZJ?=
 =?utf-8?B?N2VOT0lRaG94dWdvMTh0bzE1cVpya0hXdmdvNHpJL0s5RDZGRUxCVjBDYmhn?=
 =?utf-8?B?Rm91a3FCSlByR3V1eXI4QTFVL1kyZ0sxWndXdk9wclBHUVNsa0p4bHU4RkVM?=
 =?utf-8?B?TFZwUC8xeFJGcVFQWTR1TzE0RjZiUnVCZThtbzdWOGp5eXhVbkYzLzNDWFlO?=
 =?utf-8?B?Q0FBQk9pZFlZaThUOTJKdnREN0xNRnBXNzJiN1pYUUZRcDBnNDdBZlFUMGwz?=
 =?utf-8?B?ZWFreGZHNHRDMmNQQTZnNHdMMG8yRkhJMUorRitGTHV5Ky9adVlSNjg5bWUy?=
 =?utf-8?B?VW9nWUp5Y0NWWTRONVBLcndWWkhXS09HeFdLRGdsNHRhUE1kWnVUT0pOS1I0?=
 =?utf-8?B?ODVkdTlkc29USHU2NE1JTXNUNnlzbzBGaFFIVVVvS1AwQUNhcTZrUlJ6VTR2?=
 =?utf-8?B?N0JLQXJwV1lHYXlkNW5HeU1QVXRMdUZ5TWk4TUxheEFBRGtzT0NDSnVqb0M1?=
 =?utf-8?B?UktucjBtNFN1c3N3dHgzak5sME1salJiR2xyWmVSOTBGVWN3WFFrL0NZNzRa?=
 =?utf-8?B?N3JNUnZHY25JOGFmMjJock1UUGRqSldscURKcTJzMkp0OUh5ckFENG01YlNO?=
 =?utf-8?B?TkRFbHR1WTNLTzJndXUrUEtRUldOQ1k0ditLUGlVVlFHbmpRMGhIQUJQdU9u?=
 =?utf-8?B?akgxZ0w1TU9hUkQyOWlxeStxY2I3SHhNNTh6b0VnWjFqbWFUcHFMdFl3a0Ru?=
 =?utf-8?B?SjRaenJkejJOVmJnTS9PdjdsVmVZRHpiS3ZnK0swcThJdlllOWpROXB1NXkx?=
 =?utf-8?B?YWNGN21nYlNVV1dNQ09FSDlrMElOaFluQjlkYUJuTDRybEdFMEVoMU9UNUM4?=
 =?utf-8?B?UlNpdG1wK1A2ZEk4NUwyUWtnWktMamR5YVZjcVJNbnFETmRFQ1ZtblBCY0xj?=
 =?utf-8?B?eWNmTW5wMUJYVXhVSzF3a0FyeXUvUzMvSUwwcnpUUWgrOHlTb1BNbEhQVTdR?=
 =?utf-8?B?VFlnenpKNUJpQVJUUXc0YnlMbkRGTUs1c3FKMTUxUTR3Mm43TnJKdWM1dW1m?=
 =?utf-8?B?S2MyYVBXclgxTjBXUm1mVEJkZTVwTklBVGpVL3M4Rk1WcDZ0aUd6RzA1WktW?=
 =?utf-8?B?WTUway9sc1VwTkhlNXlBeFBPVWZOR2prYUZSTVMxNlNmcVhmZ0Q5YlZBUGor?=
 =?utf-8?B?c3VJTDlXdGJwWktwcDVQMG9lbG9NemJoMC81UWdxQ1ZPRHhyQ3FTNTFkelc2?=
 =?utf-8?B?OFYwOXFvYkN0Y1dxODRlakJXU0VmVFRzbXloaEhGeVZQU1ArQTdFMVRkWTlw?=
 =?utf-8?Q?59wiisvKfQ8/PthRHD?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR18MB6379.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcfb1b3-fcb5-454b-32ab-08de69509bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 09:33:26.5348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NukvClnttAL74wR0+SiOrbMcxeFARTalTDrgCxveGIJd/Azx6UhxxVASrmJONW1/Q53sjnRKIbE1YlU0dw51zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4428
X-Authority-Analysis: v=2.4 cv=ELgLElZC c=1 sm=1 tr=0 ts=698c4cea cx=c_pps
 a=gm/QZ0ERG918agb7PW944w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=kzw1KIlrhMkXbWlypUgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA3OCBTYWx0ZWRfXyn2R3ptgRUfg
 c23XWq1LZkZCgJcGlgi/9C7ItJskcVEZg3NFFRt3hX6tBx8LXpiA/IW9xpLNVmLqI/JbMtNbGet
 lXTzJ3RO6i6mQKEjj/qkjEy/HckxaXqzYnqV0QeevUHYuJq1bdkQhHInPDi3ySBP6pJaQzZOcw4
 Jo7QpaZoh+COr1KkUQmF+rfe5LDaH1krpYVLh54bx6nwOQP4rNQAlnEek6DtMdiXJu7OJrTe/bZ
 rzmXeFgaUVfkyRDHuuffGHv5ezQBfgxHjDO/bxGRl9SfmcCBXs3qrvr/zfyAy4bkj0fWW1bhc+r
 rPEIhhfFwHirwLgdxi3MexjMoObWcYrg858B5BspP6u920eiYuw38dktwHSSfuIWBiBcVM+u9RR
 6aLWkTTCDg0jj/j/bEY2mqXzwn1bdsxAGmaKWZQOz0EEbH38CzKg4OxUgTuqOeA5G2Leg06l1GD
 AKZs+HSZwCy6K587T/g==
X-Proofpoint-GUID: HMFpSsaOikWxTPBei7x7fYhi9P58W0gL
X-Proofpoint-ORIG-GUID: HMFpSsaOikWxTPBei7x7fYhi9P58W0gL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258233-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B8173122C86
X-Rspamd-Action: no action

PiBPbiBXZWQsIEZlYiAxMSwgMjAyNiBhdCAwNzo0NDo1NEFNICswMDAwLCBTcnVqYW5hIENoYWxs
YSB3cm90ZToNCj4gPiA+IE9uIEZyaSwgRmViIDA2LCAyMDI2IGF0IDA3OjEzOjA4UE0gLTA4MDAs
IEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiA+ID4gPiBPbiBGcmksIDYgRmViIDIwMjYgMTc6MzE6
NTQgKzA1MzAgU3J1amFuYSBDaGFsbGEgd3JvdGU6DQo+ID4gPiA+ID4gUmVwbGFjZSBoYXJkY29k
ZWQgUlNTIG1heCBrZXkgc2l6ZSBsaW1pdCB3aXRoIE5FVERFVl9SU1NfS0VZX0xFTg0KPiA+ID4g
PiA+IHRvIGFsaWduIHdpdGgga2VybmVsJ3Mgc3RhbmRhcmQgUlNTIGtleSBsZW5ndGguIEFkZCB2
YWxpZGF0aW9uDQo+ID4gPiA+ID4gZm9yIFJTUyBrZXkgc2l6ZSBhZ2FpbnN0IHNwZWMgbWluaW11
bSAoNDAgYnl0ZXMpIGFuZCBkcml2ZXINCj4gPiA+ID4gPiBtYXhpbXVtLiBXaGVuIHZhbGlkYXRp
b24gZmFpbHMsIGdyYWNlZnVsbHkgZGlzYWJsZSBSU1MgZmVhdHVyZXMNCj4gPiA+ID4gPiBhbmQg
Y29udGludWUgaW5pdGlhbGl6YXRpb24gcmF0aGVyIHRoYW4gZmFpbGluZyBjb21wbGV0ZWx5Lg0K
PiA+ID4gPg0KPiA+ID4gPiBIbSwgRldJVyBjbGFuZyBzYXlzOg0KPiA+ID4gPg0KPiA+ID4gPiBk
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6Njg0MTozMTogd2FybmluZzogcmVzdWx0IG9mIGNvbXBh
cmlzb24gb2YNCj4gPiA+ID4gY29uc3RhbnQNCj4gPiA+IDI1NiB3aXRoIGV4cHJlc3Npb24gb2Yg
dHlwZSAndTgnIChha2EgJ3Vuc2lnbmVkIGNoYXInKSBpcyBhbHdheXMNCj4gPiA+IGZhbHNlIFst
IFd0YXV0b2xvZ2ljYWwtY29uc3RhbnQtb3V0LW9mLXJhbmdlLWNvbXBhcmVdDQo+ID4gPiA+ICA2
ODQxIHwgICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAodmktPnJzc19rZXlfc2l6ZSA+DQo+IFZJ
UlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSkNCj4gPiA+IHsNCj4gPiA+ID4gICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+IF4gfn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQo+ID4gPiA+DQo+ID4gPiA+IFdoaWNoIGlzIGtpbmRhIGFubm95aW5nIGJl
Y2F1c2UgdGhlIHZhbHVlIHdhcyBpbmNyZWFzZWQgaW4gbmV0LW5leHQuDQo+ID4gPiA+IElmIE1h
Y2hhZWwgd2FudHMgdGhpcyBiYWNrcG9ydGVkIHRoZW4gd2UgbmVlZCB0byBrZWVwIHRoZSBjaGVj
aw0KPiA+ID4gPiBhbmQgZm9sbG93IHVwIGluIG5ldC1uZXh0PyBXZSBjb3VsZCB0cnkgdG8gY2Fz
dCB0aGUgdTMyIGF3YXkgYnV0DQo+ID4gPiA+IHRoYXQgZmVlbHMgZGlydHkuLg0KPiA+ID4NCj4g
PiA+DQo+ID4gPiBJJ2Qgc2F5IHllcy4gdGhlIHdhcm5pbmcgaXMgaGFybWxlc3MuDQo+ID4gPiBz
bw0KPiA+ID4gcGF0Y2ggMSAtIHRoaXMgY29kZQ0KPiA+ID4gcGF0Y2ggMiAtIHJlcGxhY2Ugd2l0
aCBCVUlMRF9CVUdfT04NCj4gPiA+DQo+ID4gPiBidXQgaSBhc2sgdGhlbiB3aGV0aGVyIHRoaXMg
Y29kZSB3YXMgYWN0dWFsbHkgdGVzdGVkIGFnYWluc3QgbmV0LW5leHQuDQo+ID4gWWVzLCB0ZXN0
ZWQgYWdhaW5zdCBuZXQtbmV4dCAoYmVmb3JlIE5FVERFVl9SU1NfS0VZX0xFTiB3YXMgY2hhbmdl
ZCB0bw0KPiAyNTYpLg0KPiA+IEJVSUxEX0JVR19PTiB3b3VsZCBhbHdheXMgZmFpbCBhcy1pcyBv
biBuZXQtbmV4dCBzaW5jZSByc3Nfa2V5X3NpemUgaXMgdTguDQo+IA0KPiBCVUlMRF9CVUdfT04o
dHlwZV9tYXgodmktPnJzc19rZXlfc2l6ZSkgPj0NCj4gVklSVElPX05FVF9SU1NfTUFYX0tFWV9T
SVpFKQ0KPiANCj4gd2h5IHdvdWxkIGl0IGZhaWw/DQpJIHdhcyBhc3N1bWluZyBCVUlMRF9CVUdf
T04gd2FzIGludGVuZGVkIHRvIGNhdGNoIHRoZSB0eXBlIG1pc21hdGNoIA0KKHdoZW4gVklSVElP
X05FVF9SU1NfTUFYX0tFWV9TSVpFIGV4Y2VlZHMgd2hhdCB1OCBjYW4gaG9sZCkuIEkgdW5kZXJz
dGFuZCANCm5vdyAtIHRoYW5rcyBmb3IgY2xhcmlmeWluZyENCj4gDQo+IA0KPiA+IENhbiB3ZSBj
YXN0IHRoZSBjb21wYXJpc29uIHRvIHUzMiBpbnN0ZWFkPw0KPiA+IFRoYW5rcyENCj4gPg0KPiA+
ID4NCj4gPiA+IC0tDQo+ID4gPiBNU1QNCj4gPg0KPiANCj4gZm9yY2luZyBjb21waWxlciB0byBn
ZW5lcmF0ZSBjb2RlIHdoZXJlIHdlIGRvIG5vdCBuZWVkIGFueSByZWFsbHkgc2VlbXMgc2lsbHku
DQo+IA0KPiAtLQ0KPiBNU1QNCg0K

