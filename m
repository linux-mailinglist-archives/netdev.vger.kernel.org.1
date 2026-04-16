Return-Path: <netdev+bounces-279093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKUHCQwR4WnoogAAu9opvQ
	(envelope-from <netdev+bounces-279093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:40:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 783D5411D60
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19F63317D53A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573227AC57;
	Thu, 16 Apr 2026 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="C8UIpZKE"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011005.outbound.protection.outlook.com [40.107.130.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA11130EF7D;
	Thu, 16 Apr 2026 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357395; cv=fail; b=B8LMuZuadpWZSOq3qIRmMnSFVe0tDKKrvVCbLF3fps1aQuRoBAeHosWHd6Mbo350WmFUMsvNWDis9P7vZomGWdROCse3v6l3zHLr+uA6rA/AMqdJHQnJhLK//2dAOGsP7rjsO7IjmnHQsrwF1rQrz1epX9D1jpGvN9Q3UY/qCF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357395; c=relaxed/simple;
	bh=SvSVIXUFTrJx9MMMjK9+dMiz5yi23mr9NpXbvjdGxlM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFS3/iEF2AlYQQ9ij7/tjcnjWYrQPj3AdrjYO+10zV9piXP7FI+06X73rOpoO3ctWyPz3EO61TyVZ/SRFTYFRUeGw8HAQw6KqPvcsGKUajRAXANiTzLfL9ARNXHEeteUpoO1TsPQ9HSNlHIUKIF3ejUOQ9ALu9R0lLzkpVm0iB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=C8UIpZKE; arc=fail smtp.client-ip=40.107.130.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhHhp3CjUvmUbEY8bWAfCOpSWj2J1YXmyYnSQgaptDEo6kT/bmlpOmCWS6oRhd9F57HJfkwQEpo7j7PZKkOpczNVSIwcmEISuDmdLuYnhKgJDhr4oCdW+lY+VejmSNC8eQFJqB2NOQJdu8elBxIwFpZo89cPCMDF3UBDmuyQTAHQ4Kn0K1C+3AEJyAHm/3Thwo1XK//PtnSl7zbRBoyjnJlHWhl0waSwnM2i1IlsLEYMvEBJWcupDeBtBPk1iHViZAgzisFEyHaPqEdKtAZJU/mvnugO4rXMLmWnQuKdDUXU7bWPNzmY515jlMGTCKSYLT0UtS2R4uqn2/18pnnwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv+jxA2UW+ytGIU/JerO/8j9k4XleuycdI9VLRfHDew=;
 b=hwBjEoOm7SPMD+NDIZeFw+0pN0mGSpMLMywBBa6ydKhmYuhrFhSsHS1k5BChZXPmpw05QH1sqgf5buBLR6nv5GzGBe87FF9i0CB6mVN6mn/FgN42bIBwJ3EAuCr5FWueevEMB8/E910bT5f7e+9hkGKRM6JkAhrKcxlaEjobCDp7lLMw1536N2bbfqSHE6URYR3eGhYLXLtgIqOaEJBGfiN59lPQoz4b8b8lLXqkU1aL2naMvuhGHCNZTAi1rIRrHrVkYKGtHcR00r1N6uIxUUsdd9K4ptKOCQ47Us/CwBCeAQePjJIRWYDZf7C4qrBh6be/CtQNAozw1nCA0Mw36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv+jxA2UW+ytGIU/JerO/8j9k4XleuycdI9VLRfHDew=;
 b=C8UIpZKEySXQWnXVcx+WwLSYmN4YUJO4rjDwC06Bdei2erm930OJvdV1G3Q6C7DKil/2/XS+aTuI2+KjjYqzIrI+dX4u5v5px55m2YtETAy5JnKbBsqIZF9bepRTYbqqdCPRvs5HLln8kB3GlRvbu5SCZdEYH54SiegZtPfRoaWBTtuFdzT6kHYLdiw1YG3NsJXcK5v6/D/i5Ck/+dJR9uuGzGqh1pzJaGao8Hg3g4fU6RXa/9LhERuG5jD5GWB53aad3BLwbeo07VpM1vWpRoOiNtj+4zt9RXlWqWohzGvrPct0o0+6v5pDp6k8eTZnqgpaAbjmWa1xSB/h806niA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by GV2PR07MB12344.eurprd07.prod.outlook.com (2603:10a6:150:342::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 16:36:27 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%4]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 16:36:27 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Victor Nogueira <victor@mojatatu.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v1 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
Thread-Topic: [PATCH v1 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
Thread-Index: AQHcy2PbTaK4pMw7dECxmKB8O6sJv7Xhw0oAgAAL2VA=
Date: Thu, 16 Apr 2026 16:36:27 +0000
Message-ID:
 <PAXPR07MB79846268934CDA45981F68C7A3232@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com>
 <8070149c-87c8-4d9c-ae12-6b9a956fb763@mojatatu.com>
In-Reply-To: <8070149c-87c8-4d9c-ae12-6b9a956fb763@mojatatu.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|GV2PR07MB12344:EE_
x-ms-office365-filtering-correlation-id: 3b0cddae-3fef-4d1e-e298-08de9bd64eab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|921020|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 hL+VbeNDxE7tOpZGH0k15ZHEr3A/pL4b5dR1cMUt1a5VTH+ISKTfJfFsD6hEO+VlyYbdVDpvrNu12ek1JaGi203DCTsccui6dEGrKxg7QsTz08QlCx/aMvU8oLahqjr7iLR9+JOHW5AwszTcM9wYT4WrnYpUYVzU65vdrGxD6ZQX1+cHyYXF93KdGPUEteSHk4sY99QtHyb8wNFix2t/OpK4QyiEg6DYn22im+bKd2m27pfdcYh1QRCuj587UmZnCq6pM5Sdu7F88HWagLEwYiCBVsoCjnUgMhUhmIMQCtRr+zvCHuvWGa2BKpmU/k8imi3ROk6KUfE10uU1+59Ov5qOCLBTr9sbdbirF11x9eCzUHZK3cvVCLHZuobh2hqgYT1w/RAq4EQLgCmBTpcRMzlX5yPyNgVFFYED2Gugs8m35F9ALGHnzCKnRldFZFhpAiLB3cFP1wOOaaAeRg2JZkZ/zE3W1kOsxxvV5/o57hOKWwdT50Od8Hu/C8psDyRXH1EP9EjCg2BczC4e00LZCsDfy1ojsGk3oHNmX/Hj6VfZhzBl0aiJrdcE818wUKPnYtmzfOfu08v9R4s0N2WFZIyXQF95hetoe9/eYdapnOcuQI9iSJablDI7rZ+dwmb4IRPcQ7k9D2uRCMkxms+tLgrbVreJt8T/0YHw7V7bhVZfC5LhGQiy5PtvXrU6EgoQ3cQ+giSEOUCP+CwyXEY1/JL5SdvlUF9iqEJb9EVBUxMfIxL0vpdAEHPvQTkMyhfcxwDZxqzPbxdPBxy7oBhyyProWydU+iVE8zcvw6VFnf/ky1pcujaqwXRgmvE3CMRl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(921020)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HfI/sjvaAxRElivGqSrWjN0hg8Y73zKqgX9HClz+LEvZGcOY8Ch9Zdt0Vy5T?=
 =?us-ascii?Q?k02guKKZBxe7L2qMKZd2hdLl7VkrG44jwCqwBJB7pzg7T2wZewNjXcaf5RiD?=
 =?us-ascii?Q?VrM7u/9WGoXM59r1Zm96Y14VlDDLkDqFJTOTB0dx0EwBEutE6ie0Pd9ztOWH?=
 =?us-ascii?Q?bwU8w3f2T47+N6lo6Jv2XTe+Xe6ZM+IB5OP9+MoHGmXk9+CIq00YDMum1iNu?=
 =?us-ascii?Q?pvU2y2IKrZ900eaIN4plqF4WNdsxFhA1ImFDBHzIM9SUS/WfhQCf/Kn/DARj?=
 =?us-ascii?Q?MUTMfFBFDnTYhCLJtkhO1dHwlUDw1e075YefpToEmWFkjaPEEQkvcRt9qIUa?=
 =?us-ascii?Q?MFXYlz85x53E0MfpPfSOwnLtEjmF/PtOUzxO3kGTSgcOpqKVLrWmso0ulQ/t?=
 =?us-ascii?Q?Y1wrneYjj89R5g+Xbz8bThixbT+wr6MTCCaVOFHtUyzpoBd4ThmTFG8OMa8Q?=
 =?us-ascii?Q?X6FDlesAsvRxItw+L3NNt3JLAOVLicgRKXGkLm1MVbSqihygCkJIpzEm0RDf?=
 =?us-ascii?Q?i04XbB0KRDrhvltVXpPK66sAqkzqAy4rWyobBjwQjNDqUKy1/d0XCIEGNVhE?=
 =?us-ascii?Q?AsOfPCokDMhrT2aI5zO3mP6hBAS5jjIKRmdH3RHMoVDDuK2+6EfjQvTIljR2?=
 =?us-ascii?Q?xYi2kfoXjgCreVoc3T3kVg9I0liOE8VTOQpz442Mv/oQluG6BgCl2maiFiW/?=
 =?us-ascii?Q?Ekl4nkfA87q30siQM4tUdBiIWM8Yos0S8PFNqZfzERsRWg6UhgCgPlC4mwPm?=
 =?us-ascii?Q?tcLJe6uuI4DMIgJfkCcmSr0NcEvUTZ/1dVq456QMj26jGhhzuFDPEO90M3ZF?=
 =?us-ascii?Q?fuooeQU6h5jjC7HDh57unvIGIm5vTkqKXULLMoKwCAoD8+AddNCAo3xFRKDN?=
 =?us-ascii?Q?/CGvh4ebaby3Tug2gJflpjg+tYC8KqdQeOwo51qhcWcDHMdnILrZDl9b6/Gl?=
 =?us-ascii?Q?JO+wYnC7XA7JSekQ5CNAIxDvPaidaRDtLGhJYp3HljooRilggA7TvE3ltCFK?=
 =?us-ascii?Q?ATH6rwMqTxm2fpyfnS/UQTaOv++NdRBsEi8JUurxMEqHZ8kIHn9IMbpwmyU2?=
 =?us-ascii?Q?gM1vJZCIQ7WOG5Cayu+ZauJGeMjZgPblJfknqfkZWu7+noSnyFKqKd7qrXOJ?=
 =?us-ascii?Q?KIJt8n5vKotUOFqK6sjJHj1nOD8EHqYEWDsrcduF/+f68lBNGC5DYZQxWQMn?=
 =?us-ascii?Q?Bo06yTVaFxc8prbK5F41BcaXsRR6atHBo9ty8ztYuVLc4rV4jhDlS22xtMry?=
 =?us-ascii?Q?Vi0cOzJZS6Hm1+8ePEf1EqdHyPslguWQ803i0vz0xMqpj6Cm0/RSJrcBdnBR?=
 =?us-ascii?Q?Ivfse5D5bECAtNJFhWn7k0tjqwxiZwN55u8tSIs91KGhr23GKA1NE6dJi5vv?=
 =?us-ascii?Q?2pONZVW/0++MhGTUuhgZAm23C7i/piYyIlBU2PwkUxWMdB+1TqWLDyWUp/4D?=
 =?us-ascii?Q?qZ6NYcq+wMF2Y7AJybokqTjBrYRxcg1VJmcVvGRmUSLnbrM8pIdaU53CT3bA?=
 =?us-ascii?Q?mZnPu3JZjE/PQwsXCwUM9UF6MrF53KtGtmxwR25uIOrr6yhZDC0PGKalj4m+?=
 =?us-ascii?Q?ykFwcXuQ9AMBTzZ+mUdt6wGwob84z2qcWtuUb1EFQhZ4iFwX7CGYB+6Y266f?=
 =?us-ascii?Q?MbMEbCd+5bzrRIRiYSom2zJ9wKluEtRlglxtXCOagPTcuKGOGW0LTl7Mp7ov?=
 =?us-ascii?Q?ZU9r0kYhdqNPrOLbxAeZkUglshF/DT913RUXmUZYQ+/JzamnbWaIl7kVM42e?=
 =?us-ascii?Q?5JfDnyYNbMQUvtW1q7F9b9lKu3WEWSc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0cddae-3fef-4d1e-e298-08de9bd64eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 16:36:27.7828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTmRnbpcXkjiJrHzbqNGiLhnrjf67wLIs0yBdwU34jFhNTPrU3lEpBAk0oxtJpFyie03QrmSFjrjAfZlhfFkI9JYrkxfeLOOvppXzxAw6w5yhbMAEbvKTBv5sFYr2D4A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB12344
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279093-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[mojatatu.com,vger.kernel.org,kernel.org,resnulli.us,davemloft.net,google.com,redhat.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:email,ericsson.com:email]
X-Rspamd-Queue-Id: 783D5411D60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Victor Nogueira <victor@mojatatu.com>
> Sent: Thursday, April 16, 2026 4:27 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; linux-hard=
ening@vger.kernel.org; kees@kernel.org; gustavoars@kernel.org; jhs@mojatatu=
.com; jiri@resnulli.us; davem@davemloft.net; edumazet@google.com; kuba@kern=
el.org; pabeni@redhat.com; linux-kernel@vger.kernel.org; netdev@vger.kernel=
.org; horms@kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepp=
er (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; i=
ngemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@ap=
ple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v1 net 1/1] net/sched: sch_dualpi2: fix limit/memlimi=
t enforcement when dequeueing L-queue
>
>
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>
>
>
> On 13/04/2026 13:37, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Fix dualpi2_change() to correctly enforce updated limit and memlimit
> > values after a configuration change of the dualpi2 qdisc.
> >
> > Before this patch, dualpi2_change() always attempted to dequeue
> > packets via the root qdisc (C-queue) when reducing backlog or memory
> > usage, and unconditionally assumed that a valid skb will be returned.
> > When traffic classification results in packets being queued in the
> > L-queue while the C-queue is empty, this leads to a NULL skb
> > dereference during limit or memlimit enforcement.
> >
> > This is fixed by first dequeuing from the C-queue path if it is non-emp=
ty.
> > Once the C-queue is empty, packets are dequeued directly from the
> > L-queue.s Return values from qdisc_dequeue_internal() are checked for
> > both queues. When dequeuing from the L-queue, the parent qdisc qlen
> > and backlog counters are updated explicitly to keep overall qdisc stati=
stics consistent.
> > [...]
> > ---
> >   net/sched/sch_dualpi2.c | 24 +++++++++++++++++++-----
> >   1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c index
> > 6d7e6389758d..56d4422970b6 100644
> > --- a/net/sched/sch_dualpi2.c
> > +++ b/net/sched/sch_dualpi2.c
> > @@ -872,11 +872,25 @@ static int dualpi2_change(struct Qdisc *sch, stru=
ct nlattr *opt,
> >       old_backlog =3D sch->qstats.backlog;
> >       while (qdisc_qlen(sch) > sch->limit ||
> >              q->memory_used > q->memory_limit) {
> > -             struct sk_buff *skb =3D qdisc_dequeue_internal(sch, true)=
;
> > -
> > -             q->memory_used -=3D skb->truesize;
> > -             qdisc_qstats_backlog_dec(sch, skb);
> > -             rtnl_qdisc_drop(skb, sch);
> > +             int c_len =3D qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
> > +             struct sk_buff *skb =3D NULL;
> > +
> > +             if (c_len) {
> > +                     skb =3D qdisc_dequeue_internal(sch, true);
> > +                     if (!skb)
> > +                             break;
> > +                     q->memory_used -=3D skb->truesize;
> > +                     rtnl_qdisc_drop(skb, sch);
> > +             } else if (qdisc_qlen(q->l_queue)) {
> > +                     skb =3D qdisc_dequeue_internal(q->l_queue, true);
> > +                     if (!skb)
> > +                             break;
> > +                     q->memory_used -=3D skb->truesize;
> > +                     rtnl_qdisc_drop(skb, q->l_queue);
> > +                     /* Keep the overall qdisc stats consistent */
> > +                     --sch->q.qlen;
> > +                     qdisc_qstats_backlog_dec(sch, skb);
>
> Sashiko is hallucinating saying this will cause a UAF, it won't.
> However it is good to maintain a consistent order here.
> For example, see how sch_choke is doing [1].
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/s=
ched/sch_choke.c?id=3D1f5ffc672165ff851063a5fd044b727ab2517ae3#n394
>
> cheers,
> Victor

Hi Victor,

Thanks for the pointer to sch_choke, it follows the order: (1) qdisc_qstats=
_backlog_dec(), (2) reduce qlen, and (3) rtnl_qdisc_drop().

But I've also checked sch_codel, its order is: (1) reduce qlen, (2) qdisc_q=
stats_backlog_dec(), and (3) rtnl_qdisc_drop().

So, the key is to place rtnl_qdisc_drop() after the reduction of qstats_bac=
klog as well as qlen.

Then, I will follow the same order for dualpi2 in next version:
1. qdisc_dequeue_internal(q->l_queue), including (a) --q->l_queue->q.qlen, =
and (2) qdisc_qstats_backlog_dec(q->l_queue)
2. --sch->q.qlen
3. qdisc_qstats_backlog_dec(sch)
4. rtnl_qdisc_drop(skb, q->l_queue), which will do "qdisc_qstats_drop(q->l_=
queue)"
5. qdisc_qstats_drop(sch)

Thanks,
Chia-Yu

