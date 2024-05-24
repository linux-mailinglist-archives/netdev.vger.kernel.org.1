Return-Path: <netdev+bounces-98033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7C8CEAFC
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 22:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2307281D56
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 20:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6D874E25;
	Fri, 24 May 2024 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="UIzha8at";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="TfUmUWMN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00183b01.pphosted.com (mx0b-00183b01.pphosted.com [67.231.157.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B91DFFC;
	Fri, 24 May 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583614; cv=fail; b=bgE99gaMPALjapfKeuJy5QSLChSj8u4Ieidq9RArFILhh6RAF0NgebkBQQBJr9JL8jVHTMwP0Xw0NabTw4aDBiv4pjuojR+RkDRl2bIYswU13Qd6gnAG6AKMFMceqvm5ITDsDPPWUXqCKo6jKtjqAJIsUs5S05HUeJk09e2CGTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583614; c=relaxed/simple;
	bh=UEaQysZnUyRFW0CPW3Da9Dnr6AC/FllHLpLZvZaICBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XjWgJtDQinRAAxYoaQyJuLXK0tNFne+GPih/VbXoIWfBjbSGIYWdK/HqRyE1PqONW6rou0KTy+CMNr555zluFa96LAYj67pLomxOoYgYI1gky7WHA9lygni1jrZZnJKOMEv+bBgFV/mGGV0fguhjDw1Ifs6zNNerYzmFzbHajC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=UIzha8at; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=TfUmUWMN; arc=fail smtp.client-ip=67.231.157.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
	by mx0b-00183b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O89Pwc001582;
	Fri, 24 May 2024 12:49:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pphosted-onsemi; bh=Gdu4UmICKMITtqluEw+wQFt37qBBlTxr/ecAP15p+H4=; b=
	UIzha8atLyNG/1VfFAtfYwfQFF4aStxN00d+Fc8zqMkPYydaGg9NbEn8AHWTXkdg
	JjlUOQdahdE2B68QKzHE8ggJIhvpPE9JsBdOoDZ0SVX/y4XGXI8VMYQIDn1mPXtN
	XDx4B3/NFRjDJBL94A8NAYV877nmwF647GFyme/fXkJLH1+QF50BjfDobWJEhO6A
	LyGiUF4/O/QcYcFZgsXSXWNaFxWmC1av2lpC31XLcE2kFMpg/J7DsKK8/fXaFpfm
	zwH15rW8p+DD5H4NhoiYzk5dml+YtVXpnji7hKYeY0R2qIH34ZEnwnNud9SJOQGZ
	7TwIAwR1nWud2ooKxkP3RA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0b-00183b01.pphosted.com (PPS) with ESMTPS id 3yaa9xjqwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 12:49:17 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcNDkd4B4VnpHiW5u/i5t3eEnCHlK7XkRFqbk4VSBPmMuDRIBkHlJxFcsvqK4NhMfQUc4pBQeRJLRYZPtpeng1edshKC2K3w4Kam4Imv72tqfUG04KJLbOjVuAoq3nSq+RkyJx5U+LNEMDusHBCbCYfoiU68vGc9N6I0tnLY8cqZcues0HB7ZOGznGAIxK5FeTneansUxqxDIYRJt6i4es3f5RwOFSHK/kUOVJT5hEm2KcEuiNZbgwn65c6eflSKuT56ZlmzGOPzryqAPi7qjW/akPkrbYd572hgD+HtkSu83gvQn3Nbh6qra6CKQLbjU8GVuls0Qc8XcSR4+IcdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdu4UmICKMITtqluEw+wQFt37qBBlTxr/ecAP15p+H4=;
 b=iKG7FkkTbafecxcVtVugZird6azfmEcEoqtrOpERxrvTWbhlWD49gR9cNPy+92VbROQYPFyIBdrKOoKbPDBOWqB2oSAWeOdujMozpbW5w7k2D0rBiaNh9T1m3LD7Fh1Or45fKsUcYDDzTGwPcoxKOgLdix1yvYZXJJ7617GqHV/u+0UZDppIQcUFoXq8ayPel8CzeQcBDVjVZKmx3h92dyuMBI9u48jnK5SxZidYWd1T7K8SzuHLnCQoJjgxYit6lt4OmoGwNgkObP08YIQSOL7UrdgxjBOfVgppH1RFscZDPGq4NP/Xs5mZI1CM3N1epSmLLv34EY5A4voqD2C65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdu4UmICKMITtqluEw+wQFt37qBBlTxr/ecAP15p+H4=;
 b=TfUmUWMN31W7w3y0lB6UG65XGZr82YoqKmarPANk/vGIfNEv1R5Qn23azrleyNPsGVGMJOgGhW/yN8hoSzx2fbEtx/C3KCC9ERLYcaSAiYFd2yBdTTijXBwtLMcVFm4YUXAt5HpF+vU9dX0Kt6T5fm9Q5IO9vqHDV1JePVyVRqw=
Received: from BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 by CO6PR02MB8833.namprd02.prod.outlook.com (2603:10b6:303:144::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 18:49:12 +0000
Received: from BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47]) by BY5PR02MB6786.namprd02.prod.outlook.com
 ([fe80::5308:8de6:b03e:3a47%3]) with mapi id 15.20.7611.025; Fri, 24 May 2024
 18:49:12 +0000
From: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>,
        =?iso-8859-1?Q?Ram=F3n_Nordin_Rodriguez?=
	<ramon.nordin.rodriguez@ferroamp.se>
CC: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "saeedm@nvidia.com"
	<saeedm@nvidia.com>,
        "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "Horatiu.Vultur@microchip.com"
	<Horatiu.Vultur@microchip.com>,
        "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>,
        "Steen.Hegelund@microchip.com"
	<Steen.Hegelund@microchip.com>,
        "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "Thorsten.Kummermehr@microchip.com"
	<Thorsten.Kummermehr@microchip.com>,
        Selvamani Rajagopal
	<Selvamani.Rajagopal@onsemi.com>,
        "Nicolas.Ferre@microchip.com"
	<Nicolas.Ferre@microchip.com>,
        "benjamin.bigler@bernformulastudent.ch"
	<benjamin.bigler@bernformulastudent.ch>
Subject: RE: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Topic: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Thread-Index: 
 AQHakZAC89gsXFcqv0WhzhAN3HgiZLF8la6AgAAX2YCAANNtAIAAVU8AgATxiYCAAQbggIAAAp2AgAFdb4CABFWKgIAAWgJwgAr/2oCAAGnoAIAADcgAgAD6kwCAAq/cgIACWJOAgAuQEwCAAAVJgIAAAGDQ
Date: Fri, 24 May 2024 18:49:12 +0000
Message-ID: 
 <BY5PR02MB6786D2055597B136585E90A29DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
References: <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
 <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
 <BY5PR02MB678683EADBC47A29A4F545A59D1C2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <ZkG2Kb_1YsD8T1BF@minibuilder> <708d29de-b54a-40a4-8879-67f6e246f851@lunn.ch>
 <ZkIakC6ixYpRMiUV@minibuilder>
 <6e4207cd-2bd5-4f5b-821f-bc87c1296367@microchip.com>
 <ZkUtx1Pj6alRhYd6@minibuilder>
 <e75d1bbe-0902-4ee9-8fe9-e3b7fc9bf3cb@microchip.com>
 <ZlDYqoMNkb-ZieSZ@minibuilder> <7aaff08b-a770-4d93-b691-e89b4c40625e@lunn.ch>
In-Reply-To: <7aaff08b-a770-4d93-b691-e89b4c40625e@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6786:EE_|CO6PR02MB8833:EE_
x-ms-office365-filtering-correlation-id: e7c49969-edae-4396-6752-08dc7c22340e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|366007|376005|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?b1ieVIiOAYjGhMvIkSKQVo+J89mt2QohmVJwHVAr/CiPGewRmzWAlmrFLj?=
 =?iso-8859-1?Q?+QEukbPofCxiC0ltZ3KQ0Yuc4iLUP64bNGZ0QflWpTxkrwC2qt+W2r9z8q?=
 =?iso-8859-1?Q?TAS4RvqhZbsrZmkDkJhg6i0GUualsuA+gQvTRfB1jcxGfKkJJ446UcqdAi?=
 =?iso-8859-1?Q?PgWXQrnn+1L4hkvLC9UKdt0vzMPtPCqdDZhAFPP4ZaiJ6G2+aWBM41QTXy?=
 =?iso-8859-1?Q?H/uuS4LgVxW/svwXOpb7RpSoR/Zr+VTjlHNKqRjrE3GRbCDUKgiyxBWVNi?=
 =?iso-8859-1?Q?MHie4u96eJ0QtXb4uHk075lAw/q78bsJ+no1mEjojvhYGc7g3r75ugNSJ3?=
 =?iso-8859-1?Q?8+dHBBpKIRjlXTpjjWMNv0Ib6bpQsJgFtefLp+UGDjPOVzA76XDcfBWIVg?=
 =?iso-8859-1?Q?hnLTu1rby2QQXJlgFRMexS1o3DOZ9FBPncp5DqYD4k1cXhvk+jVE+RXDkr?=
 =?iso-8859-1?Q?5NT9sstmT9xdqCJk4NSppynR3tqttt8q/Mjv6tsOLE1xuBlnTQP3ZKTg83?=
 =?iso-8859-1?Q?Gk30CYTx+YQPC493SorNxWSCpXuMdaDxRdM7Up+sO1iCOeYSxgcq+2C/Te?=
 =?iso-8859-1?Q?kkIayeQ8JTDuVjOMt1JOxO7JRPNAZIds4FU+tn3OuRwgfe/MrMreosgP5Y?=
 =?iso-8859-1?Q?9jZmaMDeRMdqX90B4mtrE8/hILxILh93s27OB+ZJQMBZIMJSL1mW0sdQgN?=
 =?iso-8859-1?Q?4Ep2jE75K2jqT3/dpZcIaIsGzZdirCQJO0RIrRKMWIgRjue5TxAjuVnnyI?=
 =?iso-8859-1?Q?rUMKp3A0St12c5exs22Y0LoRV2RwESKzLKshvwP15Y/ZDStZbgrSXcFJuH?=
 =?iso-8859-1?Q?f9Jtx0gBbn3095zdC5SAN2jLo+P1ahhcmt9iu9ZStEeo2mhsC88mnbV63M?=
 =?iso-8859-1?Q?HvHOBfDUfAxQHRTUF6jXOqK9zkehhXgnKvY3+3DyOeYEhmuOfRlhSOXNUD?=
 =?iso-8859-1?Q?/iYTcMAV+x8xApiX1wYIZQSyLl6R4dLEBx8PSmeoR11Y5J/v36YlYu3PEI?=
 =?iso-8859-1?Q?iSE+nvp9deW/H4SFRgfYzaza34o+dDSkVoRFbLePXiGS0ZjvIAh/19ht8S?=
 =?iso-8859-1?Q?MaGNcQSnnLwSTaYDKtQ7TVUgZhXCb7DsFxE57pQ/juph7WfuCbQ3uJGzl7?=
 =?iso-8859-1?Q?5OjMgWFmWRvtGW85IpyIF7QXH39utr7sbq1rOkXgHBCOFztqXeBADFrf1W?=
 =?iso-8859-1?Q?g6rbsA1M5uGGvuELWmI2vi2yQFS6VqUSYOy3ve3bt4cpMinSgk1wpyWUh8?=
 =?iso-8859-1?Q?sNhqbAfLrDA0tggKTUpM9Ymk00VPahwOlT3inyIg0cA4HsH4lufy5yqHet?=
 =?iso-8859-1?Q?s57y75LEFIiyYaGrtX/dG8+WO4dVB11WW2JLag97BqSVQ+1k+pbZsoJ4kx?=
 =?iso-8859-1?Q?swb0vEo54H+8sQsWAxwGc6VqbIGLmXow=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6786.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ZWKd1/pMdyjqtBsDDBJkrpSPw+XmxKb72RyETbrxinabMaoDDhW68HpLR+?=
 =?iso-8859-1?Q?IMm2inkBk7j269q8DqwHV4Cnbz9ofdNvhoRjY5HocvTQLilOtbA9LvMYv6?=
 =?iso-8859-1?Q?vEiDMC7ToVYKdokXlDU6Z7zbpAW+hEKPUzIHzZVF8klGX2T303Lr7qUhUF?=
 =?iso-8859-1?Q?TFkjXvjnlXfdUYBp94EEwRe5zmK+FhndipyBypj5pEzCQm3hv6KJyfPBhE?=
 =?iso-8859-1?Q?OTvYntrdaTwCVop5hxaTvPNlew8uiRwwUQJbhq7vmOJnye9/PpyenPOkfs?=
 =?iso-8859-1?Q?SObhbASYcU6Det9lXyjmbmnZt5keTCrNN6sG0R+fbS2Gf4qXTMQEHJGx+2?=
 =?iso-8859-1?Q?9dMOKNafOqrBFgZktmOqhH/ZPRBZDgQwPAIIvuwYBDLz5NfSjmbMX91+iH?=
 =?iso-8859-1?Q?kkrT1W51Fv1h0chzQhscuHOBSxzrG9aDGu9HDZKCNiJpdBCrTHYo43QmjG?=
 =?iso-8859-1?Q?+fJbAXMYQgnd211YGEDivmFgIMhadQ2Yu0oAv6/H1WAkxHrkJts5r7x+tg?=
 =?iso-8859-1?Q?Rzp4/tZYAOlBpVQ2q0TdlbdBsFzBeBUJSIfyZ9VP+b22iu4/QnWOdG04fL?=
 =?iso-8859-1?Q?e33Wx6wFM6ueGN1o4A0Wvb960b7i76oCpuYTdzmj2AwN6i/FPPkqze3JUm?=
 =?iso-8859-1?Q?ux20sdW5+3kO0hdi8JTkG0XWbXtYlQBX5ZunR30qPo3d52BvIjDuejke+S?=
 =?iso-8859-1?Q?4DQhoWaOq0GYgiXpUC3KI+1jzK+Gimj6nZDNvod1EQbOThMVNwnc0dK1wg?=
 =?iso-8859-1?Q?icMXuGso25iQKzloOK6Tjaoc/wn+3bIse3G6dPOdFcMyPwAaenHiIhToSi?=
 =?iso-8859-1?Q?C4nP6Iuc47R6mstKV50SmwgYP1VBwJ0kxVbrS1ThVPuQ+gaGn1iZ4LDusc?=
 =?iso-8859-1?Q?mBXdkZb5h+zY8Rn2ioa/GmdH8q69+uhVVbGUb9YqsaYNp3v/Alvr8cfws6?=
 =?iso-8859-1?Q?OrUemsKqYQJjH4xzu9ysGikUfVOKY4iSZqXdQblqsMs4fKu4NNiMViuPi3?=
 =?iso-8859-1?Q?PtwAa+LHnsHwcaxcYx+y6CxwJKZhGyx/zwgSNCnwhEStysD0JmLVWKY+4u?=
 =?iso-8859-1?Q?Dr3WmA/gx1DrdOSU56fCienJwNyaU3V8JfRXw+rU4z2vmZiO9woFMBxd+C?=
 =?iso-8859-1?Q?xpcz++N0hTriE4GFP9h8Mmn0mbCW2l8HNvmMm3doGUM1ZRivwShgSW6Apw?=
 =?iso-8859-1?Q?pjC42dqYaIDbSdYujIBNeT1BQlhm+JkogzBjCNhWxvOFYPNtmTBf1wgQNi?=
 =?iso-8859-1?Q?j5czHNa30PmdEZ8Av7QCSjBdGYmWHalhdKqAIe6W0urHWJQ8nY26DgJ/oA?=
 =?iso-8859-1?Q?RUDQUCGXuljgudBLBtmb3MALessBNVcPEoHhEYu1dN3YM2Wx61hnGT6UXp?=
 =?iso-8859-1?Q?sbSiKW+2Ez92rHC7PpyCWk15/eqVNxY1WyQvT33jd7TvlNOphUFPiaxUGA?=
 =?iso-8859-1?Q?ywRzyOolcEpdIQP0b6zaHFXou+4lk8h3NveerDV8AKaJ9Nw6eBd1K5F68j?=
 =?iso-8859-1?Q?cMir89hhhJL1J2SSnNjr8nncATRe2N0aIJ/8jzqp3K4bR95yTfDHHICMB/?=
 =?iso-8859-1?Q?4+hbLgSpUMWqTQIEc3mvXaWE+IEVhFQf3t+44ByVscur7TyDY+DNmeTaXF?=
 =?iso-8859-1?Q?KiR3PAzh+QN5mujhB769yUf6JIEX7p2u7n?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6786.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c49969-edae-4396-6752-08dc7c22340e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 18:49:12.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WygkUoJqu0hSe0qr08HVv5QsymO3+/G8eAHKql+C5dYW0dSPxp2+7yBHMvACKdjT0mxXrbPl8Lgic4ZFKvvTvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8833
X-Proofpoint-GUID: OGgDni1e6rR_JlUvl4TnHAvvoeyWsQlk
X-Proofpoint-ORIG-GUID: OGgDni1e6rR_JlUvl4TnHAvvoeyWsQlk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_06,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405240133

Hi all,
Just my two cents here...

Collision detection is a fundamental building block of the CSMA/CD mechanis=
m.
The PHY detects physical collisions and reports them to the MAC via the COL=
 pin.
The MAC is supposed to perform the normal back-off operation: stop the curr=
ent transmission and re-transmit at a later time following the exponentiall=
y increasing random algorithm (See IEEE 802.3 Clause 4).
** Therefore, collision detect shall NOT be brought up to the user. In a MA=
CPHY system it is supposed to be handled entirely by the PHY. **

With the introduction of PLCA, the PHY may report also "logical collisions"=
 to the MAC.  These are not real collisions as they don't happen on the lin=
e. They are part of the normal PLCA back-pressuring mechanism that allows t=
he PHY to send a frame only during a specific transmit opportunity. So once=
 more, this kind of collision shall not be reported to the user, it is just=
 normal behavior.

However, physical collisions (i.e., collisions that really happens on the l=
ine) are NOT supposed to happen when PLCA is enabled and configured correct=
ly.
For this reason we have a standard IEEE register (PCS Diagnostic 2) which s=
till captures physical collisions (not logical ones). This register is supp=
osed to be used as a diagnostic information to let the user know that somet=
hing is misconfigured.
Now, some PHYs can be configured to provide IRQs when this kind of collisio=
n happens, indicating a configuration problem.

Additionally, many PHYs allows the user to completely switch off the PHY ph=
ysical collision detection when PLCA is enabled. This is also recommended b=
y the OPEN Alliance specifications, although no standard register was defin=
ed to achieve that (maybe we should add it to the standard...).

I'm not sure I followed all this discussion, I just hope this clarification=
 might help in finding a good solution.
In short:

- Collisions are NOT to be reported to Linux. The MAC/PHY shall handle thos=
e internally.
- Physical collisions are still counted into a diagnostic register (could b=
e good to add it to ethtool MAC statistics)
- Disabling collision detection is allowed only when PLCA is enabled, but i=
t is not a standard feature, although automotive specs recommends it.

Thanks,
Piergiorgio

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: 24 May, 2024 20:32
To: Ram=F3n Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban.Veerasooran@microchip.com; Piergiorgio Beruto <Pier.Beruto@on=
semi.com>; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; paben=
i@redhat.com; horms@kernel.org; saeedm@nvidia.com; anthony.l.nguyen@intel.c=
om; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; corbet@lwn.net; l=
inux-doc@vger.kernel.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro=
.org; conor+dt@kernel.org; devicetree@vger.kernel.org; Horatiu.Vultur@micro=
chip.com; ruanjinjie@huawei.com; Steen.Hegelund@microchip.com; vladimir.olt=
ean@nxp.com; UNGLinuxDriver@microchip.com; Thorsten.Kummermehr@microchip.co=
m; Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>; Nicolas.Ferre@micr=
ochip.com; benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement err=
or interrupts unmasking

[External Email]: This email arrived from an external source - Please exerc=
ise caution when opening any attachments or clicking on links.

> After a considerable ammount of headscratching it seems that disabling=20
> collision detection on the macphy is the only way of getting it stable.
> When PLCA is enabled it's expected that CD causes problems, when=20
> running in CSMA/CD mode it was unexpected (for me at least).

Now we are back to, why is your system different? What is triggering a coll=
ision for you, but not Parthiban?

There is nothing in the standard about reporting a collision. So this is a =
Microchip extension? So the framework is not doing anything when it happens=
, which will explain why it becomes a storm.... Until we do have a mechanis=
m to handle vendor specific interrupts, the frame work should disable them =
all, to avoid this storm.

Does the datasheet document what to do on a collision? How are you supposed=
 to clear the condition?

       Andrew

