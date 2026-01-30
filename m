Return-Path: <netdev+bounces-255090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAKyIHaDfGmBNgIAu9opvQ
	(envelope-from <netdev+bounces-255090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:09:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23189B9399
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7338E3004604
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D234253C;
	Fri, 30 Jan 2026 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MoKNSfz1"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525C33C53B;
	Fri, 30 Jan 2026 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769767796; cv=fail; b=gWxpU85stxXDQDTCSxtK9/Sokl9RPJgXRbq+QYRnT9ip5l47GmSAiDJ8+Cpj78qa9GXshiKekzti6p97FLQ8O/p1SIWMqwFQJMrWMVSkm+7hHyJ1oiIa/QpCps3tXHS0mdIrH/qQWg2Jl6GH/APVcYAYL4zdrBr4mBPkv+frgnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769767796; c=relaxed/simple;
	bh=l56156XkDYrqI88cnYDplNk/TqQhDzzp0kypmAbcEoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=llqfVt3jVeoDfABbfDxgJBLaGpNzgzdWbH16iXhVUtPjDHcSIIrr+2rHEo8w43Pc3MaW9SzF9mtjAWMdoOWRk6pCY1RKCA0rz2bf7dZXazg1Lg3W3Ghsx04FCq+YanXISbnirSNhsj2RKOUqo2eKhwRwLz+R2/yjfrK31qKgt0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MoKNSfz1; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TU0ei2+E0LNaZ+APzgKPTFBx4xH/JP8Zr2v/Eh9GbssFhAJ/uVvcwsUKI7awkUeelXmWkGGWKSLgneQGIuORu4FpPAmr/IunvIm324iAemxfXlSZW9/jVvfecfUjKgCXVMsaK0VmDo9eNk7oWOdjtFL5kzUIipqaW1cOgiW1Kbb04bImYvCkx7ql4FizN8IU1ERPqg0M/DYTP2/q1zeQU7oS9RwYzz6g6vDVnQX8MYXblK0MOH9Bq4v/wJe8iiQZTrd9rqFEtGzqXDmN0nMaW1unTdo4ejN3pc/VX1wVqgBbbD2O7HZw/W79xrutAF/WAclNCxq+2F27fb/Qew3muA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l56156XkDYrqI88cnYDplNk/TqQhDzzp0kypmAbcEoI=;
 b=UggC1wkwS5tcKfryLsEByc94M7IhbbYWDThniQm0TQv944gLFqt2moc7DRMzolqD18kyWBs0aqjAUFoiIxFqh3jSjiedddZcBE67JqLEsTMVRmqfDn2ipfheBPYnCXEae+M8f18YzM+UGCPXsnSgJuaqjNfhMi0KBbGgz9TYhu74lFuAnERv+pO5UKRa01Ubv00ad2YjG8fgli4MLq5DCIBCC9l6MhHpCumGnO/+XQhN8s47LVw3mtGsvl0ZQdbXs/P2Xuxo1aFyF+NZ0J2Oe9uXUHtB8kttRNgsG+Xzs/hyXFYOm3HYh/Tg5SVEcPvh014LmtybBCa68YFLgR1y/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l56156XkDYrqI88cnYDplNk/TqQhDzzp0kypmAbcEoI=;
 b=MoKNSfz1yLIieOQ6HjbWmBAjsT16Rj5jRrP4E0SJDNH2aRPeseO5+K1PozC1cCMolT6gUYFY24RlYfYFqETJeS9LPKR5wxgIRcWlG5WpjrtKcDc6yvtqq51mq3OlDTg96UqZlZ9BJ4RzvXFaPdKZnObxJOG1tMIHImRkAeMojkkv08au5hGSACH7wK0Pwg5N8HIEd//B9uIC/UYt6ABp2tVSRLM/8E6WxVHrn3qfTBp+yhBi9Cf9F/UcdKp/OjR7Mmcu5eeppdW5SN9GpXC6xbDLTQ9wtApAd4HvtNQwtirgc79aghfwCGrd1BeXsXskFq9K2U4iWRtfYqcQ4rmHwA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 10:09:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Fri, 30 Jan 2026
 10:09:42 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Russell King
	<linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "florian.fainelli@broadcom.com"
	<florian.fainelli@broadcom.com>, xiaolei.wang <xiaolei.wang@windriver.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"quic_abchauha@quicinc.com" <quic_abchauha@quicinc.com>,
	"quic_sarohasa@quicinc.com" <quic_sarohasa@quicinc.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: phy: add device link between MAC device and MDIO
 device
Thread-Topic: [PATCH net] net: phy: add device link between MAC device and
 MDIO device
Thread-Index: AQHcjrC8X7fZpJnZe024lfTnDwQHCbVojkqAgABiM4CAASQWMIAAXzYAgAAA2ZA=
Date: Fri, 30 Jan 2026 10:09:42 +0000
Message-ID:
 <PAXPR04MB85107041E1D00BBC92A33D69889FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
 <20260128201501.04bb6e5c@kernel.org> <aXsxJa0D0bohafRs@shell.armlinux.org.uk>
 <PAXPR04MB85106B63AF43DE0830B4C362889FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <7fc065e8-c85b-4faf-9104-1b6b54327a02@bootlin.com>
In-Reply-To: <7fc065e8-c85b-4faf-9104-1b6b54327a02@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8676:EE_
x-ms-office365-filtering-correlation-id: 0d689af0-8b31-43b8-e408-08de5fe7afe9
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmpjY3JoTDFWUkg2cDRtbkZGNVZSTytiaFkxaHQ2b2UydmRvZG93MHZEV0Yy?=
 =?utf-8?B?NDZzaStqSWEwWnAwOU5SNUNLcEttNW5Kd2JIaHZUY0pCdks4WmZyeVllbzdr?=
 =?utf-8?B?YU1yUURoNjJTS0tYcEZoRjNXdjFYendWNkNLT3pWV0Z3YVNCNGtuVjR4V1U4?=
 =?utf-8?B?M0svTDd3YmZab2FHMWhVeXNKcnVQNVZtSW53YlpyZzVGdURYUFo5K0VSdFNh?=
 =?utf-8?B?QTA5MmNDSy9FS3pCTlIyY1U5TENnNVlIWTZ2VHF0SEpJQnVyQWZKd2cwL2xo?=
 =?utf-8?B?bGNBaGlwQ04wWi9CT3lzbnJDaWhQSkdyYnY1Z0dLSWludXhzYjlMK0xOZC9n?=
 =?utf-8?B?VndUN0Z1ekdLeVdHZmhTTUxVdzF5NzhNdlIvcVBDblViNGhlTkRRSWRsNUZx?=
 =?utf-8?B?VEs4TUhzRVo4QUkzRXBxN2ZydElBbDMyMlVUQlYwbmEwK3NaeU5JUHMxK216?=
 =?utf-8?B?MzZRQ1VGTmpmTDBGc2xacmpiZ2FiRXJ6ME9WYlAwS0Q5RG9jWGRRd3FYdndt?=
 =?utf-8?B?enllYndQSXFkb3NpUzlTNmc0bWNBMWF4ZVBHODZla0t1MGlrSWlIcGVrVTVQ?=
 =?utf-8?B?bklnTUVicjI1MWMwREhaSURWbjFKOGl3SXlLcmd3cHNhaVorVldLSFl1aW9F?=
 =?utf-8?B?NHY5VW16VC9yWVYxU1dUbWNQRFp1YzJ5MGoyTmFnbkQvVy9KNHVmWTU4UWE0?=
 =?utf-8?B?YlVwS295M09pb2FNRHpoTGNybWtmZzhVU0NkNW1GdzFPU0diRFltalpFV0JM?=
 =?utf-8?B?cnZQM1duVEduM0lSRXJWclg1cnlLUE9aSmY4ZGV5TEZEVndhSHN2bERxRVpv?=
 =?utf-8?B?WGJZb1hRdWdyNVpCMEdrZzI1V21SZk1xcmdpVWlFQ29VNWhTY2hRZnJLRWNz?=
 =?utf-8?B?YlVqSUtXa2xLSE91YUtzT3R6WmRYV1BPd1B4WFRnLy9qNzNqZnVEQUtoS3J1?=
 =?utf-8?B?WUxJR0VWUDNJcXBnUlZmU0hKYURXSVg5aEVVSUZXdDRsdWJoWGpGemNvVEdQ?=
 =?utf-8?B?OWE2a3FjdmtidUxxK3Nwak95U1VMWDBHUWJBUzMyVDNFbVpsY3NRUTMzMzdx?=
 =?utf-8?B?RC90TEtuT2w4SWVFSFpYMkY4RSthZEtQMTBqWEFDamRiZEZualdXQXFnOWg4?=
 =?utf-8?B?KzQvOG5ZSDJ5QzhJNUZsbDFiQzdKTlFiKzF4cnI5MndiZ2orT3FYUzBXK09V?=
 =?utf-8?B?bjlsVkZIWGZZZERMYW1zd2dzYUVWWEdaMnZXd2hQRHJFdnZnNjZ5TWdHWENU?=
 =?utf-8?B?ZGxKNTBOZ0xtcjlyYURNZjFjVUFUc2tKSTU5OGRJdGd3REJrU3FMeURNTFFs?=
 =?utf-8?B?MzEzd1pmMXArdkM4azQzSVp4SVhSUmk5cVVpL3B5QUxJY2xBWnJQWThWZjRr?=
 =?utf-8?B?S0VNdjRNTDN3QU1iMzhyQ1JZK2JNdkJLMnVvbHRGTDJWK0F0M05XZ0xldUM2?=
 =?utf-8?B?YUV4V2JrUWpVZDN1M2J1cU9QMEJaM3FiaE56eGNaSFRoOXBPZ1gybmNmbUtM?=
 =?utf-8?B?ZEpqNWMweFlUNXc0Y3RlRXdiVjc0dk5ZWVhkTWp5emxvdlRCMkpHa0hoVytm?=
 =?utf-8?B?TmkreDhvblY0cWFxdE03V25nMHhPNjZVK2hybjhkZExKZlZhMGhKWVJ1ejgx?=
 =?utf-8?B?Tm1yUmtvYSthNTIwKytzeUZEa2RJNUVjVDQ2NkNRNFZxZlMvYjNJYTBSSUNt?=
 =?utf-8?B?aEhlK2JMc2hMN29mb3luQitDTi9VelBNYjhVay9nRzU1d25POEw4TmIwN1lo?=
 =?utf-8?B?SFlScWJuQlhNN084ZWJzbFBQNHB6NEJtRTZLazhoSXQ0Q3ZPL0dML01GbzZU?=
 =?utf-8?B?UGNBZVlzZlNNYVdselYxTEcwYncvcTdjdU1FWTk5Yi9LNG5ZN2VienBvekI5?=
 =?utf-8?B?bnIveURwcytVN0hHUUJMdCtVRUg2QkdTMnRZcVh6SDRjWStmUkpqUXpGdVpw?=
 =?utf-8?B?MStqTWFpK2tKYUkwdmVHOWg1a3RKaHNXWFhwYzAvRUVMVVJXZG5keEhTeE5O?=
 =?utf-8?B?SHloWE1mZlRlaHd4KzJGOTAyVzl1L1JmYWI0YkN5dDM4RllFcEs4Q2Jtd1Yx?=
 =?utf-8?B?OGZHd1M0YTVmVVlVNEltcmNJT0VNVFhKWTVNeWs5T1RUSHN3REJtZncyODhj?=
 =?utf-8?B?dEtlbFkwMTBmZHNlaXhOTVhsOFNzNkFHc0UvNzNpVkhJUHE0KzZESUZOVFVp?=
 =?utf-8?Q?qUXy6BNyJpgzcoeBvUyOFMU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzJ5MnNnYmVXaGNVSUtvcW5uWEJCcEdMSk9VcnEzd0hzTVNsS0lNczZLbU1u?=
 =?utf-8?B?V3JqZzRSNGRiYmtBK3A1QkN5M3ROa3gzVWcxc3JCOEpwNnNzVjJ1S2dHSzBK?=
 =?utf-8?B?Z1pjQTV2VE5wa2JjMDY3VWovcDAwcFhTMWJpYjdVQUV1aFF3cTZFNHVPWHV3?=
 =?utf-8?B?eWNxS2RuQUxzMVFuUUtnYlA0RHc0MCtKV0piWjZVQ3JyTzZrcWhZK01rYjdr?=
 =?utf-8?B?QzlZNlpPMDBubXVTTkdJUEU0L0J4ZU1iR0UrYkZYSk9teHNYRWtmU1h0SFBT?=
 =?utf-8?B?Tm1IeGtvM0c5Z09KRU1wcjdCRnlNR2VNV2lEWVMyNWh3SmUyMStsTWNYRHM4?=
 =?utf-8?B?UUl4T3BQK2xBOXFaRjNwRWRUOUt6czlPa1dmY1E5bmFSTkxDWFpJWkllR3kx?=
 =?utf-8?B?UEViNXdtem5IaXMvV2p5dDVyUWVnelpJRkZWVzRYY1pFamtIMlVjYVRtY2VH?=
 =?utf-8?B?bkNFMFJ3M0pERkN6N3FSaW94cDZQd25lVGI1VENXeWNIQjRxSUpseHh0cUdv?=
 =?utf-8?B?ejBWeDZ2UFpBNUtpY2xDM05VejJzU1pyM1VlaEtCVnJ6c0daYlk5aWZpN1F2?=
 =?utf-8?B?RWN3Tm9ONHJUSWJQTExpKzB6OCsrdkw2eHZlUmZ6cGVWM1daL0lFYWl0dlZZ?=
 =?utf-8?B?eFY0UHpNWXYyYVNrZjhlc1lyNDBXUDBxTVpxQWdvMFVLRjlja2hkbVExZkFr?=
 =?utf-8?B?M2ZsdmFBN2xveTNadjk3bTJXd1RibTRwUW54eW51WkM2RERBaE5scEtIcXlF?=
 =?utf-8?B?NklMUVNqMzV5Z05SaXpWd0N2QzRGcmdOLytYVzVYS2lrQVFVd1hMUW5heVIr?=
 =?utf-8?B?VTBLTzhBelRnT21YczZKeHM5N3BjdmFUeEk0QjhmVTJVejJXdjMyTmZJY1N6?=
 =?utf-8?B?VmtEbit4aTQwTm16L0dWNVExTUdzWTBoRVV6NG9sbmN3SjRMNHo3UDZNSWxw?=
 =?utf-8?B?WE9ubVFLZWZRbzdFSklqV1ZnNXkva0ozQk9ZcUlqSmk3eDFaMDNQaG9ZZ3ho?=
 =?utf-8?B?UytIcEZsRWsxVDY2RVc5OFc5ODFUb3E4RFZoZzlWa04ralU2eVZ6VWxKYm4w?=
 =?utf-8?B?ckYxOXpOWXAzQlZwKzVrR3V1a1Q2TkNzYnV4bFk4VE9pVEE1cG1VYlpZUWhT?=
 =?utf-8?B?UXd4ck1meTM4dUFjMEZ4dkNuTXI3cVpjMXZUSXJnMlNsdGpNSHZDVjNlR0c3?=
 =?utf-8?B?OWwrUitHMUF0K1ZiVHZiOXByR1JhMGNreFY0RWhOd0YwT29QbE1TMXdWSmUv?=
 =?utf-8?B?eUpITkdMQmY2Mnh1c2wyQWV6R2tmK05tcy9NZVpSUXdtUWZRK0VKU1B1QVhw?=
 =?utf-8?B?UDB1OVVZL21LclBTMVRJQmorZzg4bWF4bWVjWGJkQXk1S2J4dmlBL2hGWUlQ?=
 =?utf-8?B?ei9aK0RRQktTOThBcXBETXhTL3pTcE9Dcjhoa0Zab3FWWjJwd2c0eDFPaG9v?=
 =?utf-8?B?Vm1tS0psano0YUJSTGcrRFRDc1orYzgxRjhwMmpvQWk2dWZSb2g1WnBnVHpm?=
 =?utf-8?B?d0U5VDI5ZGVjc0RIOG52UEwrN2s1SklLZUNNakk0YzVSendEU3hucHZWaTdL?=
 =?utf-8?B?bVJVVmRsemUwOU1tc21qRW4rSU5SUnpIOUNBSXFXeU9GbWdUMzNsazlrWk4z?=
 =?utf-8?B?RGhZV0VMRDNDRTNpaE9sR245YjdUUkhFTG9LL0RuR083YVEzNUZrWG4rZmFV?=
 =?utf-8?B?SUtNYmV4WTBFY1E3SVRtSVlRb284R3RjUk9LbUVVWmc0a05QNXpkZ2NHbTBI?=
 =?utf-8?B?Sy9EU2xud0svYlZUQjU2SVQveVpzRDVpeExHMWEwOUEvejh0c2ZDSmZNeHkx?=
 =?utf-8?B?cFpsN2NQL1o0eGE0VW5WbmxBOEV5VEs5MmZHVzFvaDZzWWl5TTY2NXRTcjlR?=
 =?utf-8?B?cnJjbDRkOHJkMk00Q0hLY2IyNndHSlIyZUgxVzVuTERPY25EWGJTaXZQOXRM?=
 =?utf-8?B?TFlhSks4L0thNFBaQ0xzYjMzVTVHWitGK0wzQ0hIazBIN2xJZEx6NW5zMXdj?=
 =?utf-8?B?NkE1V0h0ejNGc2dwSk9HMUw4MXdLdWVpbFlhRWtVTzVSczV3SDlvVENlSFdD?=
 =?utf-8?B?TEZTcTJXS0Vtb3AyVVBYbkRMMG1idENRU3lrT2FIdzdCU1ZIckdyNitid05s?=
 =?utf-8?B?UmdZYy8rdjJ0N2NubVVCNkI4VnU2YW51Znk3R3IxQldJY3RYUlh6R3lhNWFR?=
 =?utf-8?B?bG9aZ3N5Vm1YSjlDM2tsblVVT3RUbWdYM242WTJwdlBnWnJ5UnBpRVd0dkxC?=
 =?utf-8?B?Z00xWmZBazhKY3BtOUxxZXlmTHJucWdsUEFidWtkME5KS2prSlJEOUhDVS9F?=
 =?utf-8?Q?eITN0pmGTUCi5BNoNl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d689af0-8b31-43b8-e408-08de5fe7afe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 10:09:42.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQOs4ETwXyf6Cl7XYxiMj9Bk8g+lmz3tCHQtkwe+HVpGoJFQkq6gCidhkhkxFYtEJIrrPeS8zO2ATjBFJDF/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8676
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-255090-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,broadcom.com,windriver.com,davemloft.net,google.com,redhat.com,quicinc.com,lists.linux.dev,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 23189B9399
X-Rspamd-Action: no action

PiBPbiAzMC8wMS8yMDI2IDA0OjQxLCBXZWkgRmFuZyB3cm90ZToNCj4gWy4uLl0NCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvcGh5X2RldmljZS5jIGIvZHJpdmVycy9uZXQv
cGh5L3BoeV9kZXZpY2UuYw0KPiA+IGluZGV4IDgxOTg0ZDRlYmI3Yy4uYzQ4MzM1YmZjN2I2IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9waHlfZGV2aWNlLmMNCj4gPiArKysgYi9k
cml2ZXJzL25ldC9waHkvcGh5X2RldmljZS5jDQo+ID4gQEAgLTE3NzEsOSArMTc3MSwxNyBAQCBp
bnQgcGh5X2F0dGFjaF9kaXJlY3Qoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwNCj4gc3RydWN0IHBo
eV9kZXZpY2UgKnBoeWRldiwNCj4gPiAgICAgICAgICAqIGFub3RoZXIgbWFjIGludGVyZmFjZSwg
c28gd2Ugc2hvdWxkIGNyZWF0ZSBhIGRldmljZSBsaW5rDQo+IGJldHdlZW4NCj4gPiAgICAgICAg
ICAqIHBoeSBkZXYgYW5kIG1hYyBkZXYuDQo+ID4gICAgICAgICAgKi8NCj4gPiAtICAgICAgIGlm
IChkZXYgJiYgcGh5ZGV2LT5tZGlvLmJ1cy0+cGFyZW50ICYmIGRldi0+ZGV2LnBhcmVudCAhPQ0K
PiBwaHlkZXYtPm1kaW8uYnVzLT5wYXJlbnQpDQo+ID4gLSAgICAgICAgICAgICAgIHBoeWRldi0+
ZGV2bGluayA9IGRldmljZV9saW5rX2FkZChkZXYtPmRldi5wYXJlbnQsDQo+ICZwaHlkZXYtPm1k
aW8uZGV2LA0KPiA+IC0NCj4gRExfRkxBR19QTV9SVU5USU1FIHwgRExfRkxBR19TVEFURUxFU1Mp
Ow0KPiA+ICsgICAgICAgaWYgKGRldiAmJiBidXMtPnBhcmVudCAmJiBkZXYtPmRldi5wYXJlbnQg
IT0gYnVzLT5wYXJlbnQpIHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHBoeWRldi0+c2ZwX2J1
c19hdHRhY2hlZCkNCj4gICAgICAgICAgICAgICAgICAgICAgIF4gYXNzdW1pbmcgd2UgcmVwbGFj
ZSB3aXRoIHBoeV9vbl9zZnAoKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBoeWRldi0+
ZGV2bGluayA9DQo+IGRldmljZV9saW5rX2FkZChkZXYtPmRldi5wYXJlbnQsDQo+ID4gKw0KPiBi
dXMtPnBhcmVudCwNCj4gPiArDQo+IERMX0ZMQUdfUE1fUlVOVElNRSB8DQo+ID4gKw0KPiBETF9G
TEFHX1NUQVRFTEVTUyk7DQo+ID4gKyAgICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBkZXZpY2VfbGlua19hZGQoZGV2LT5kZXYucGFyZW50LCBidXMtPnBhcmVu
dCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRExfRkxBR19Q
TV9SVU5USU1FIHwNCj4gPiArDQo+IERMX0ZMQUdfQVVUT1JFTU9WRV9TVVBQTElFUik7DQo+ID4g
KyAgICAgICB9DQo+IA0KPiBJIHRoaW5rIHdlIHNob3VsZCBsZXQgdGhlIHBoeV9vbl9zZnAoKSBj
YXNlIGFsb25lIGZvciBub3cuIFRoZSBsaWZldGltZQ0KPiBvZiB0aGUgU0ZQIHBoeWRldiBhbmQg
dGhlIE1BQyBhcmUgY29tcGxldGVseSBpbmRlcGVuZGVudCBoZXJlLCB0aGUgUEhZDQo+IGNhbiBi
ZSBwcm9iZWQvcmVtb3ZlZCB3aXRob3V0IHRoZSBNQUMgYmVpbmcgdGhlcmUsIGFuZCB2aWNlIHZl
cnNhLg0KPiANCj4gVGhlIE1ESU8gYnVzIHRoYXQgY29udHJvbHMgdGhhdCBTRlAgUEhZJ3MgbGlm
ZXRpbWUgaXMgdGhlIHNhbWUgYXMgdGhlDQo+IFBIWSBpdHNlbGYsIHRoZSBtZGlvIGJ1cyBpbiB0
aGF0IGNhc2UgZXhpc3RzIHNvbGVseSB0byBkcml2ZSB0aGF0IHNpbmdsZQ0KPiBQSFksIGFuZCBp
biBjYW4ndCBiZSBzaGFyZWQgYmV0d2VlbiBtdWx0aXBsZSBQSFlzIGV2ZW4gaWYgd2UgaGF2ZQ0K
PiBtdWx0aXBsZSBTRlAgcG9ydHMgaW4gdGhlIGVudGlyZSBzeXN0ZW0uDQo+IA0KPiBUaGUgbG9n
aWNhbCB0aGluZyB0byBkbyBJTU8gaXMgbm90IHRvIHRpZSB0aGUgTUFDIGFuZCB0aGUgTURJTyBC
dXMNCj4gaXRzZWxmLCBidXQgcmF0aGVyIHRoZSBNQUMgYW5kIHRoZSBQSFkgYXMgd2FzIGRvbmUg
YmVmb3JlLiBBcyB5b3Ugc3RhdGUsDQoNCk9rYXksIEkgYWdyZWUuIEkgd2lsbCBvbmx5IGNoYW5n
ZSB0aGUgZGV2bGluayBmbGFnIHRvDQpETF9GTEFHX0FVVE9SRU1PVkVfU1VQUExJRVIuIEFuZCB0
aGFua3MgZm9yIHlvdSBwcm9tcHQgZmVlZGJhY2suIDopDQoNCg0KPiB3ZSBjb3VsZG4ndCBzZXQg
RExfRkxBR19BVVRPUkVNT1ZFX1NVUFBMSUVSIGJlY2F1c2Ugb2YgU0ZQIFBIWXMsIGJ1dA0KPiBp
ZiB3ZSBhZGQgdGhlIGNoZWNrIG9uICJwaHlfb25fc2ZwKCkiLCBpdCBzaG91bGQgbm93IGJlIGZp
bmUuDQo+IA0KDQo=

