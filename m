Return-Path: <netdev+bounces-270098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NAgfFx3QvWlOCQMAu9opvQ
	(envelope-from <netdev+bounces-270098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:54:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D32E21F0
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C4C73026143
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1EC361DB0;
	Fri, 20 Mar 2026 22:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="OeMJcdEB"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023098.outbound.protection.outlook.com [40.93.201.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5C2E65D;
	Fri, 20 Mar 2026 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047258; cv=fail; b=kaJBhkOOy5umkFS+bUKK52ig84PgYA3da9InoYeCSOQwhK4KX3OtlLPNRYBtre0vF4wy9hoCfxTuh7BbaMMU1m3fnePjOKhQMkoOYCLYRV4UfFVAF382yEPfYdbKwFU55vTxxDzDHc09ERB3dPGhtysUFLAuxly1h96Qy56y/Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047258; c=relaxed/simple;
	bh=/4SE9zcN28NoqowniCCBAAWv7YF0Keni2alzHuyf5Y4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T0QguXCy8HWAHChmO9JD6yDNs2e3M3o998MjuU83+/99AkPpvdKAWo7j9IJUxH0khdUrXyo6bALwaeS9OmoYhHmVsxUiICFDRx/yMYM4xJ/XcuQG9wfn0Jx9tor6jViIqLyRu28rIgY03FKVjyrdOujmJsw4JgZk1hT2FmhnOgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=OeMJcdEB reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.201.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiGOjjJ2KnPXJ3bEdnK903Lanj/9SzGp4MoGs1SCKCZ66Ex0dRKASF6UOr083ZlkbSNy/eEGv+sS8ODwaeTkXikXkdPYx5eETQ6Djeo/1Aft6hfZM/iv6lQCq7tw3JBq5MPSP08ibVqoQJj3XPKwP9MDDN/IoVRI8DQI0hNRGjPsUVLoYvpn4a/RTSmMx8WKIgknG+nkQDEcSoK+CsEq8clOIJ5cSL3q+yyLxNSnpfbEsBjKM+So3/BaFouzAOfQTQtiACVWW6C8FXxmI2f3AcaJcAcGNt3v365PAhZ71SSYb09tkAP5mZU8B/kqe6zXCFGSVZWU/kY2heNDKR7Ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaNfWtHtLc4M/0HJ078CLlBHiUuBdJLNNsHbna7768o=;
 b=sFasZjBjfq5a3d4Fo/l8xvM4OL8d7J67doA2mG9DogmEAujm2EkADmGaEDQx8NCPLDOd1zijoLwzB+/UWK6nci6RN2uQEIO6+3njkl1aqbBnrjrpkotPlHyngMHkja31W/OkP+ZYSVRwcKyw8wJoEF7N4zTYNWOWlz9ul4APqRqLZUMu/52kBen188C2IP+20CYMqijbdcywOEVhJhqeMlwyRXfe9PbE52loSEVPJZ0oFSsdVbvyiZjC7gkDO+MDQTsuXSY/TOQ6S/jQ5sONeBL0MJtKqd13kPsr3XC1GyWqmiQ0TeVXaMzQbcXRlwYu9zMPC+cUvlvMsOZwEULWsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaNfWtHtLc4M/0HJ078CLlBHiUuBdJLNNsHbna7768o=;
 b=OeMJcdEBgInRhBVP66a1vsWIvQirylE7TS/n038Pvxxrxu0bTPwQbp8eWuMOgpBgT3eBwfUCptTxOiLjhPaYF6yiHD6w7mEpenZ6+x4KlhsSnmnJ2H+6INB3sBFtdV5YZ2gld9sc1W3v15bZJCw5gFOO44QQdfX2WKeWr3/KDr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CO1PR01MB6533.prod.exchangelabs.com (2603:10b6:303:f5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.25; Fri, 20 Mar 2026 22:54:03 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 22:54:10 +0000
Message-ID: <000a30bd-e78f-419a-a5c3-59469692058a@amperemail.onmicrosoft.com>
Date: Fri, 20 Mar 2026 18:54:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v34 1/1] mctp pcc: Implement MCTP over PCC Transport
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
To: Adam Young <admiyo@os.amperecomputing.com>,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260317224309.645480-1-admiyo@os.amperecomputing.com>
 <20260317224309.645480-2-admiyo@os.amperecomputing.com>
 <b0b0c9f2-d6c4-4cf8-b17e-76e73683484d@amperemail.onmicrosoft.com>
Content-Language: en-US
In-Reply-To: <b0b0c9f2-d6c4-4cf8-b17e-76e73683484d@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0019.namprd15.prod.outlook.com
 (2603:10b6:930:14::31) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CO1PR01MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: a808896f-b403-4191-e52b-08de86d39975
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|10070799003|376014|1800799024|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kJY6Xc+n3V8Y4u/VFHOXLoemwfu8CVHFewhWiEeC17He1kw9Of5EoNPsuLaBK+sZajFa7mi3NZbMv+chVTpgt8HcSHGN6NpkR8C88cXhSVyAvk0WJqIrJqLOc9OgEneb2RXKQDhiIoSjm1f+iAnOmGyVVHzKmV3iR4POG9uQynKR2/fbDaKkDrPlXiiO3IUaD+sOxsBC7ULaDXugjU6Vus+4agrSzoZYHj6ipiVGXOxxqVorI0tt+oHvKy6qng0KelApeS8NXSRGTFgrzoVnORxf5hu4q6ghSJSYE3SgcolcvqrTOzaLx4fRdpam/Y9aCR1gkrnfyaHRm4jUtqESnseHKIaPZrdhcOi2hXxZSN3qCQN0u+zD02rnxb2nZ0Nl3hvst7ZND2ArkBX+LcFMkNd/e1c9M1RGmnw2IK4fIOA7ycM5N2ZycV8JSv3XccvqmzHXRfvuwf7nQpIliinb2LTs61SYLfh5PDS3HbmPTat7V5ZzARqPV1aGHvNrp/BAhexf1PDwbx+Mc2cdGVP/UH5VCLdsjmINikZyduzskjklGcC+ce8MrFt5AAc+wF8QCMzdYzizNxW4rKu8ijLFP3utVx8KzKIESddgnzo2aPmAGY2J7Xglh/80ZtqMQq10PyEKTPeUfv+FHzafpTiiMuuuHEbhx5YiSSI1Uj8Ui+uahNdKUCKF3DYzA5ue/q79
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXpUSVlpRTAyRjhhalJVd0wwa2hsYlVWcWZneDd1OFRkdWxGb0J2aFZVM05Y?=
 =?utf-8?B?WUo5Q05hVHQ3akY2bktJSmxBUmxFMnJpRXN4YVlJSjlHRlAzYnlOUkdac3Mv?=
 =?utf-8?B?b0Vsc3VPaHFrV21zb2dHZG9iK1hHT0xVWWVUZG1YSTlJNTFMdmVneEZtZHRM?=
 =?utf-8?B?MDJOc0EzL3UzcWdBQ3A4ZDEwelpRMFg2eWJML0hpT0R3aHNqbVhabVJOdlVn?=
 =?utf-8?B?ZXNGZkNFZjFKMWRMNm85ck9idEF6a0hBa1lPdk1iaThkb2wvTXRDb1ZDZmkw?=
 =?utf-8?B?NVlySkF5QlpZcXVYQUJTOWhKR1lYRS82RDF0TzZjWWdHNTg2blR1Y2hjTUdN?=
 =?utf-8?B?L0V0aXBCN0pFNWp4d0FTRTlSbXphMzFFNVB4b3lpY0hYR0tnRDM0RlpYTEN6?=
 =?utf-8?B?Um1TZUxlaE5rUmFITkhlK1E4c2pQR1cvUkxpcitQYzdReUJJdDRNaDh6djJy?=
 =?utf-8?B?NFBweEo5U3o3Tkg5UytwckhRVTRHUFN3RExhaWNCUytlV0VzcmhNOWtlNFRX?=
 =?utf-8?B?YjN6Z2o1UEp1UDJYZGp5SzJGUjhNK3hpNTE3ZDhIM0p0Y3VmekRMRzBvK0FE?=
 =?utf-8?B?YUlrVlJoblFzcEM3c2dXNExCcENiN0IwMkx1Ym9EdHllQmxRa3ZQUGFON3RF?=
 =?utf-8?B?NyswTWpaMlNWd1krb1U0VXl3T25oa2tsdDFBMDlrWS9qZHJLWjNKN0JmQzA4?=
 =?utf-8?B?eVM0VUxYT0VaWGQzd2pIMDg4QXdTNnIyaVgwSHpQUnNwSlZjQm9YNWVhQmg2?=
 =?utf-8?B?VmQ2aHpEZWhGNzJvUzU1YWFJVnB1NldacXo3UEdWaUpVVU81aHh2Um9SZ0Ft?=
 =?utf-8?B?K1hraFo2ZC9ZTHh2RzVKSGpmYjZicWtLTEREOXZwbFJsY21ZYVNjQmpmaWpF?=
 =?utf-8?B?NWZ4b1l1Z0RLVU11RGFOeUREMkRxMzhJYlUvMkgwRVFHVG5BSWoxdjhrMEFV?=
 =?utf-8?B?VGE3MFh1eEJqN21jMEpWK3ROV1ZSVVpOOU5vWTQxcWowNnFtSXlvRzdqK0Mz?=
 =?utf-8?B?L0xlT1RMUWg5UU9MQ1lhT1RjU1ZVQzBNWGN5K0JRWmFrNmw3RjliUjRGZGE5?=
 =?utf-8?B?MmsyTWZxMG1aa3NUclNUcCtCdklHWkxydGF6VUk2Mnora1R3Q2R0alFXcWRY?=
 =?utf-8?B?cHIxRHlCR3ZnSFEwRlV6MWM2V0hVdWc5d0thZ2MzSEpNdXBoRmpuOWFrMVJa?=
 =?utf-8?B?ZVl5ZTlHeUs0UVBhWXZuaFdKam0xTDdUMnArNXJBUmVDNmVDMzZ1K01WTHpK?=
 =?utf-8?B?djR6Z1NqaUQ5NW5oQ2tkSkdydThrS3oyYi9kM2hwUCtOVGMvNW9FdGd3c1lj?=
 =?utf-8?B?bi8wcHByWmFPWlRQZGd1ak01a1ZGd3Era0pYcmhWWEcxaUlmUHhqSFE4bjYw?=
 =?utf-8?B?ejFlUGgwaVFTaWRjQlZ6cFBvbUZHamhoUkFkT3hLb0NUNXQyVTM0Z2t6U3Vz?=
 =?utf-8?B?NnVlWnpPVXdlQXM5Q0dzSG5pTVYyM1ZxRWoxRmo3eVpXQzhhVHJYZi9oblNV?=
 =?utf-8?B?emVaak42VnJ2NUFuZUVMUGVaR1o0MkFOZDNMaGVCNUkveERLaHkybEhRMnhW?=
 =?utf-8?B?dFFDVDkvN0k0bEtXTWVaTjV6U0ZmM25pWEc0SHQ4WHdCd1pRNmtKcUc3UE1r?=
 =?utf-8?B?YnI1YmZUdHhnV1NCdkdBVHV4REp3dmJjS01lV0ExYVdwQlN1V1JIemRjOW9I?=
 =?utf-8?B?RE1jTC9OZTV5dkFjZjJVRzdnY2ZRZHNRMHI1QWNhU0xnNS9nb3AxRUNwUFp0?=
 =?utf-8?B?N050c2xVeFlNU3pUN2Fnamd4Y1NvaysrUVJ5ajg1c2V0MXZPMFRoYmxwMm5l?=
 =?utf-8?B?ZGNsV1VCUHo2eVBTcUtkMlU0VWQyZmxIaFZMWHQ3ZDVOOUxEaUpBdjdMZGV2?=
 =?utf-8?B?aEp5RkYwREdjUkRaWHdTa3QrMHcwNG9OSUI5ckVaRnpySUw2ZlFjaEw1NEJT?=
 =?utf-8?B?Sk5qTnN0VUZESEFrbzRvREtJL0xycGgzU0pLeHZ4MDlsYWI3bzhZMFlxR0pC?=
 =?utf-8?B?Y2NwdWs4MmhhMFEyWmtOYzBMYUJlc0VKcC9BbnNCeTAvOGR5NWJNdHRITjVi?=
 =?utf-8?B?NXZvZHdxMHVjS0xhS0xQejB1cFFmMUlCOEpmbU41MkREKzUwbUpURDdoNWlM?=
 =?utf-8?B?a2ltRGhoTFppQ0JxTzhDZW1kUjFoZWJEY25WZEc4cHV3MitCWVVmS1VFNk4z?=
 =?utf-8?B?aDdYMUtrS3Q2czZFeFQzM2NCaFg4Z0JUWHdIL0MvUW1Dc3VmVTNmYkRuNnk5?=
 =?utf-8?B?NCtwWUtZQ012dFlXNnhPRVMrVVM3QjV0RU40Y2RIc1NuWGpyd2VHWEU0cmxl?=
 =?utf-8?B?NzJVRDVjd1R3dVQ3aEllL29qRENWd1hqWHVCN0ZrTFd1cTkxYUpFalcxRUlD?=
 =?utf-8?Q?3VhUJ1RazgmoVvF74esIWZ23RtQBaHi7azFcIVKA/5NH9?=
X-MS-Exchange-AntiSpam-MessageData-1:
	RpWptWZf5W3eX3v9ZkC1jNaxIW+iTzG6hRxEVEqqkhQEoAktfx0mtZf9
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a808896f-b403-4191-e52b-08de86d39975
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 22:54:10.5629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieqeGRFWMq8ajl4SdUnEegGRZscrXus1JevvdUrtjdNvGcaM/MqNo3WAYYSsnWTOL/rjiL28Jn0BCav9/AtSG1D4gpBZ8KV0j6q5d+HZstVofHQiKMfUYDTkKOZ/TAw5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6533
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270098-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.999];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dmtf.org:url,amperecomputing.com:email]
X-Rspamd-Queue-Id: A92D32E21F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The "flaw"  is  not in the driver.  It seems to run fine on 7.0.0 and 
only breaks on stable 6.19.8  and .9.

It seems to run correctly on net-next/main, but I think there is a 
breakage in  mlx5 which makes it hard to test.

Regardless, I will resubmit with the cleaned up commit message once I do 
more debugging.


On 3/20/26 12:59, Adam Young wrote:
> I just discovered a flaw in this implementation.  Withdrawing it from 
> consideration.
>
> On 3/17/26 18:43, Adam Young wrote:
>> Implementation of network driver for
>> Management Component Transport Protocol(MCTP)
>> over Platform Communication Channel(PCC)
>>
>> DMTF DSP:0292
>> https://www.dmtf.org/sites/default/files/standards/documents/\
>> DSP0292_1.0.0WIP50.pdf
>>
>> MCTP devices are specified via ACPI by entries in DSDT/SSDT and
>> reference channels specified in the PCCT. Messages are sent on a type
>> 3 and received on a type 4 channel.  Communication with other devices
>> use the PCC based doorbell mechanism; a shared memory segment with a
>> corresponding interrupt and a memory register used to trigger remote
>> interrupts.
>>
>> Unlike the existing PCC Type 2 based drivers, the mssg parameter to
>> mbox_send_msg is actively used. The data section of the struct sk_buff
>> that contains the outgoing packet is sent to the mailbox, already
>> properly formatted as a PCC exctended message.
>>
>> If the mailbox ring buffer is full, the driver stops the incoming
>> packet queues until a message has been sent, freeing space in the
>> ring buffer.
>>
>> When the Type 3 channel outbox receives a txdone response interrupt,
>> it consumes the outgoing sk_buff, allowing it to be freed.
>>
>> Bringing up an interface creates the channel between the network driver
>> and the mailbox driver. This enables communication with the remote
>> endpoint, to include the receipt of new messages. Bringing down an
>> interface removes the channel, and no new messages can be delivered.
>> Stopping the interface also frees any packets that are cached in the
>> mailbox ringbuffer.
>>
>> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>>
>> change 1:  size may be negative
>> change 2: use constant for checking MCTP signature
>> change 3: put PCC data into the skb
>> ---
>>   MAINTAINERS                 |   5 +
>>   drivers/net/mctp/Kconfig    |  13 ++
>>   drivers/net/mctp/Makefile   |   1 +
>>   drivers/net/mctp/mctp-pcc.c | 366 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 385 insertions(+)
>>   create mode 100644 drivers/net/mctp/mctp-pcc.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ff6f17458f19..43bc37f859d6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15288,6 +15288,11 @@ F:    include/net/mctpdevice.h
>>   F:    include/net/netns/mctp.h
>>   F:    net/mctp/
>>   +MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) 
>> Driver
>> +M:    Adam Young <admiyo@os.amperecomputing.com>
>> +S:    Maintained
>> +F:    drivers/net/mctp/mctp-pcc.c
>> +
>>   MAPLE TREE
>>   M:    Liam R. Howlett <Liam.Howlett@oracle.com>
>>   R:    Alice Ryhl <aliceryhl@google.com>
>> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
>> index cf325ab0b1ef..77cd4091050c 100644
>> --- a/drivers/net/mctp/Kconfig
>> +++ b/drivers/net/mctp/Kconfig
>> @@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
>>         A MCTP protocol network device is created for each I3C bus
>>         having a "mctp-controller" devicetree property.
>>   +config MCTP_TRANSPORT_PCC
>> +    tristate "MCTP PCC transport"
>> +    depends on ACPI
>> +    help
>> +      Provides a driver to access MCTP devices over PCC transport,
>> +      A MCTP protocol network device is created via ACPI for each
>> +      entry in the DSDT/SSDT that matches the identifier. The Platform
>> +      communication channels are selected from the corresponding
>> +      entries in the PCCT.
>> +
>> +      Say y here if you need to connect to MCTP endpoints over PCC. To
>> +      compile as a module, use m; the module will be called mctp-pcc.
>> +
>>   config MCTP_TRANSPORT_USB
>>       tristate "MCTP USB transport"
>>       depends on USB
>> diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
>> index c36006849a1e..0a591299ffa9 100644
>> --- a/drivers/net/mctp/Makefile
>> +++ b/drivers/net/mctp/Makefile
>> @@ -1,4 +1,5 @@
>>   obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
>>   obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
>>   obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
>> +obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
>>   obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
>> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
>> new file mode 100644
>> index 000000000000..f8d620795349
>> --- /dev/null
>> +++ b/drivers/net/mctp/mctp-pcc.c
>> @@ -0,0 +1,366 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * mctp-pcc.c - Driver for MCTP over PCC.
>> + * Copyright (c) 2024-2026, Ampere Computing LLC
>> + *
>> + */
>> +
>> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
>> + * 
>> https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/if_arp.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/skbuff.h>
>> +#include <linux/string.h>
>> +
>> +#include <acpi/acpi_bus.h>
>> +#include <acpi/acpi_drivers.h>
>> +#include <acpi/acrestyp.h>
>> +#include <acpi/actbl.h>
>> +#include <acpi/pcc.h>
>> +#include <net/mctp.h>
>> +#include <net/mctpdevice.h>
>> +
>> +#define MCTP_SIGNATURE          "MCTP"
>> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
>> +#define MCTP_MIN_MTU            68
>> +#define PCC_DWORD_TYPE          0x0c
>> +
>> +struct mctp_pcc_mailbox {
>> +    u32 index;
>> +    struct pcc_mbox_chan *chan;
>> +    struct mbox_client client;
>> +};
>> +
>> +/* The netdev structure. One of these per PCC adapter. */
>> +struct mctp_pcc_ndev {
>> +    struct net_device *ndev;
>> +    struct acpi_device *acpi_device;
>> +    struct mctp_pcc_mailbox inbox;
>> +    struct mctp_pcc_mailbox outbox;
>> +};
>> +
>> +/**
>> + * mbox_write_to_buffer - copy the contents of the data
>> + * pointer to the shared buffer.  Confirms that the command
>> + * flag has been set prior to writing.  Data should be a
>> + * properly formatted extended data buffer.
>> + * pcc_mbox_write_to_buffer
>> + * @pchan: channel
>> + * @len: Length of the overall buffer passed in, including the
>> + *       Entire header. The length value in the shared buffer header
>> + *       Will be calculated from len.
>> + * @data: Client specific data to be written to the shared buffer.
>> + * Return: number of bytes written to the buffer.
>> + */
>> +static int mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int 
>> len, void *data)
>> +{
>> +    struct acpi_pcct_ext_pcc_shared_memory *pcc_header = data;
>> +    /*
>> +     * The PCC header length includes the command field
>> +     * but not the other values from the header.
>> +     */
>> +    pcc_header->length = len - sizeof(struct 
>> acpi_pcct_ext_pcc_shared_memory) + sizeof(u32);
>> +
>> +    if (len > pchan->shmem_size)
>> +        return 0;
>> +
>> +    memcpy_toio(pchan->shmem,  data, len);
>> +
>> +    return len;
>> +}
>> +
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void 
>> *mssg)
>> +{
>> +    struct acpi_pcct_ext_pcc_shared_memory pcc_header;
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +    struct mctp_pcc_mailbox *inbox;
>> +    struct mctp_skb_cb *cb;
>> +    struct sk_buff *skb;
>> +    int size;
>> +
>> +    mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, 
>> inbox.client);
>> +    inbox = &mctp_pcc_ndev->inbox;
>> +    memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
>> +    size = pcc_header.length - sizeof(pcc_header.command) + 
>> sizeof(pcc_header);
>> +
>> +    if (size <= sizeof(pcc_header)) {
>> +        dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +        return;
>> +    }
>> +    if (memcmp(&pcc_header.command, MCTP_SIGNATURE, 
>> MCTP_SIGNATURE_LENGTH) != 0) {
>> +        dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +        return;
>> +    }
>> +
>> +    if (size > mctp_pcc_ndev->ndev->mtu)
>> +        dev_dbg(cl->dev, "MCTP_PCC bytes available exceeds MTU");
>> +
>> +    skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
>> +    if (!skb) {
>> +        dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +        return;
>> +    }
>> +    skb_put(skb, size);
>> +    skb->protocol = htons(ETH_P_MCTP);
>> +    memcpy_fromio(skb->data, inbox->chan->shmem, size);
>> +    dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
>> +    skb_pull(skb, sizeof(pcc_header));
>> +    skb_reset_mac_header(skb);
>> +    skb_reset_network_header(skb);
>> +    cb = __mctp_cb(skb);
>> +    cb->halen = 0;
>> +    netif_rx(skb);
>> +}
>> +
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct 
>> net_device *ndev)
>> +{
>> +    struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
>> +    struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
>> +    int len = skb->len;
>> +    int rc;
>> +
>> +    rc = skb_cow_head(skb, sizeof(*pcc_header));
>> +    if (rc) {
>> +        dev_dstats_tx_dropped(ndev);
>> +        kfree_skb(skb);
>> +        return NETDEV_TX_OK;
>> +    }
>> +
>> +    pcc_header = skb_push(skb, sizeof(*pcc_header));
>> +    pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
>> +    pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
>> +    memcpy(&pcc_header->command, MCTP_SIGNATURE, 
>> MCTP_SIGNATURE_LENGTH);
>> +    pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
>> +
>> +    rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
>> +    if (rc < 0) {
>> +        //Remove the header in case it gets sent again
>> +        skb_pull(skb, sizeof(*pcc_header));
>> +        netif_stop_queue(ndev);
>> +        return NETDEV_TX_BUSY;
>> +    }
>> +
>> +    return NETDEV_TX_OK;
>> +}
>> +
>> +static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
>> +{
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +    struct mctp_pcc_mailbox *outbox;
>> +    struct sk_buff *skb = mssg;
>> +    int len_sent;
>> +
>> +    mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, 
>> outbox.client);
>> +    outbox = &mctp_pcc_ndev->outbox;
>> +
>> +    if (!skb)
>> +        return;
>> +
>> +    len_sent = mbox_write_to_buffer(outbox->chan, skb->len, skb->data);
>> +    if (len_sent == 0)
>> +        dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
>> +    else
>> +        dev_dstats_tx_add(mctp_pcc_ndev->ndev, len_sent);
>> +}
>> +
>> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
>> +{
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +    struct sk_buff *skb = mssg;
>> +
>> +    mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, 
>> outbox.client);
>> +    dev_consume_skb_any(skb);
>> +    netif_wake_queue(mctp_pcc_ndev->ndev);
>> +}
>> +
>> +static int mctp_pcc_ndo_open(struct net_device *ndev)
>> +{
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
>> +    struct mctp_pcc_mailbox *outbox, *inbox;
>> +
>> +    outbox = &mctp_pcc_ndev->outbox;
>> +    inbox = &mctp_pcc_ndev->inbox;
>> +
>> +    outbox->chan = pcc_mbox_request_channel(&outbox->client, 
>> outbox->index);
>> +    if (IS_ERR(outbox->chan))
>> +        return PTR_ERR(outbox->chan);
>> +
>> +    inbox->client.rx_callback = mctp_pcc_client_rx_callback;
>> +    inbox->chan = pcc_mbox_request_channel(&inbox->client, 
>> inbox->index);
>> +    if (IS_ERR(inbox->chan)) {
>> +        pcc_mbox_free_channel(outbox->chan);
>> +        return PTR_ERR(inbox->chan);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int mctp_pcc_ndo_stop(struct net_device *ndev)
>> +{
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
>> +
>> +    pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
>> +    pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
>> +    return 0;
>> +}
>> +
>> +static const struct net_device_ops mctp_pcc_netdev_ops = {
>> +    .ndo_open = mctp_pcc_ndo_open,
>> +    .ndo_stop = mctp_pcc_ndo_stop,
>> +    .ndo_start_xmit = mctp_pcc_tx,
>> +};
>> +
>> +static void mctp_pcc_setup(struct net_device *ndev)
>> +{
>> +    ndev->type = ARPHRD_MCTP;
>> +    ndev->hard_header_len = sizeof(struct 
>> acpi_pcct_ext_pcc_shared_memory);
>> +    ndev->tx_queue_len = 0;
>> +    ndev->flags = IFF_NOARP;
>> +    ndev->netdev_ops = &mctp_pcc_netdev_ops;
>> +    ndev->needs_free_netdev = true;
>> +    ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
>> +}
>> +
>> +struct mctp_pcc_lookup_context {
>> +    int index;
>> +    u32 inbox_index;
>> +    u32 outbox_index;
>> +};
>> +
>> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
>> +                       void *context)
>> +{
>> +    struct mctp_pcc_lookup_context *luc = context;
>> +    struct acpi_resource_address32 *addr;
>> +
>> +    if (ares->type != PCC_DWORD_TYPE)
>> +        return AE_OK;
>> +
>> +    addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
>> +    switch (luc->index) {
>> +    case 0:
>> +        luc->outbox_index = addr[0].address.minimum;
>> +        break;
>> +    case 1:
>> +        luc->inbox_index = addr[0].address.minimum;
>> +        break;
>> +    }
>> +    luc->index++;
>> +    return AE_OK;
>> +}
>> +
>> +static void mctp_cleanup_netdev(void *data)
>> +{
>> +    struct net_device *ndev = data;
>> +
>> +    mctp_unregister_netdev(ndev);
>> +}
>> +
>> +static int initialize_MTU(struct net_device *ndev)
>> +{
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +    struct mctp_pcc_mailbox *outbox;
>> +    struct pcc_mbox_chan *pchan;
>> +    int mctp_pcc_mtu;
>> +
>> +    mctp_pcc_mtu = MCTP_MIN_MTU;
>> +    mctp_pcc_ndev = netdev_priv(ndev);
>> +    outbox = &mctp_pcc_ndev->outbox;
>> +    pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
>> +    if (IS_ERR(pchan))
>> +        return -1;
>> +
>> +    mctp_pcc_mtu = pchan->shmem_size;
>> +    pcc_mbox_free_channel(pchan);
>> +
>> +    mctp_pcc_mtu = mctp_pcc_mtu - sizeof(struct 
>> acpi_pcct_ext_pcc_shared_memory);
>> +    ndev->mtu = MCTP_MIN_MTU;
>> +    ndev->max_mtu = mctp_pcc_mtu;
>> +    ndev->min_mtu = MCTP_MIN_MTU;
>> +
>> +    return 0;
>> +}
>> +
>> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
>> +{
>> +    struct mctp_pcc_lookup_context context = {0};
>> +    struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +    struct device *dev = &acpi_dev->dev;
>> +    struct net_device *ndev;
>> +    acpi_handle dev_handle;
>> +    acpi_status status;
>> +    char name[32];
>> +    int rc;
>> +
>> +    dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
>> +        acpi_device_hid(acpi_dev));
>> +    dev_handle = acpi_device_handle(acpi_dev);
>> +    status = acpi_walk_resources(dev_handle, "_CRS", 
>> lookup_pcct_indices,
>> +                     &context);
>> +    if (!ACPI_SUCCESS(status)) {
>> +        dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
>> +    ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, 
>> NET_NAME_PREDICTABLE,
>> +                mctp_pcc_setup);
>> +    if (!ndev)
>> +        return -ENOMEM;
>> +
>> +    mctp_pcc_ndev = netdev_priv(ndev);
>> +
>> +    mctp_pcc_ndev->inbox.index = context.inbox_index;
>> +    mctp_pcc_ndev->inbox.client.dev = dev;
>> +    mctp_pcc_ndev->outbox.index = context.outbox_index;
>> +    mctp_pcc_ndev->outbox.client.dev = dev;
>> +
>> +    mctp_pcc_ndev->outbox.client.tx_prepare = mctp_pcc_tx_prepare;
>> +    mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
>> +    mctp_pcc_ndev->acpi_device = acpi_dev;
>> +    mctp_pcc_ndev->ndev = ndev;
>> +    acpi_dev->driver_data = mctp_pcc_ndev;
>> +
>> +    rc = initialize_MTU(ndev);
>> +    if (rc)
>> +        goto free_netdev;
>> +
>> +    rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
>> +    if (rc)
>> +        goto free_netdev;
>> +
>> +    return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
>> +free_netdev:
>> +    free_netdev(ndev);
>> +    return rc;
>> +}
>> +
>> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
>> +    { "DMT0001" },
>> +    {}
>> +};
>> +
>> +static struct acpi_driver mctp_pcc_driver = {
>> +    .name = "mctp_pcc",
>> +    .class = "Unknown",
>> +    .ids = mctp_pcc_device_ids,
>> +    .ops = {
>> +        .add = mctp_pcc_driver_add,
>> +    },
>> +};
>> +
>> +module_acpi_driver(mctp_pcc_driver);
>> +
>> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
>> +
>> +MODULE_DESCRIPTION("MCTP PCC ACPI device");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");

