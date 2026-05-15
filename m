Return-Path: <netdev+bounces-288357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJxnDTxNB2pZwwIAu9opvQ
	(envelope-from <netdev+bounces-288357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:43:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DFA553CF3
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A8FE3219972
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854CF3F928C;
	Fri, 15 May 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="cKh/yH1a"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE823B9D91
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861643; cv=none; b=o/wFHeclCn8fyWnsKgIDcvMg+lbuLTnrui63/nbC1VWrctQ17PV/AIXIuZEEWvKeLbcEd5JENoTRMqR+7A/X20X5tmcvFFEFwC6OM+cnv0/4aVHhvY3BE6MV7EdprtQYSTdYSslAWrI9PmQmN3HLb1aTvAADR1EOK1GalH0JzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861643; c=relaxed/simple;
	bh=hlqx0IArCVCJS0VVXrNSTa0iEbowYvlZUTUW2ut888k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O7PP4BhEUw2Zua2hG5FbxhRVpR6TlH2jNhusJ0DuCHbDSv3zADvr48uQFW2+C8cbEbcNhr8sIrioKFVjwCECTFgyoy43+pAB5dOQpYgmvUJEo8QuaeLx1MNfbmR/zt6R4A9sfxrStL3Am4FWfIdRyxE0XHQXyqLiB+w2KAqWouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=cKh/yH1a; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778861635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6yCF4b87ORz1ujILfjB/A2yR93OOR0LDBmz5f8GgQDo=;
	b=cKh/yH1a2vL90ri1JdjfolvdkB10BdMP3mXqy1wHY03AOGXEVcs3+49pg6K5de/ZVzzEMs
	piYdcVqaxT50t//gvNrL1oK9xL8nc8YbBVnL1QvR9BVixWhaLemMANCmKBsKyLDdd8FgHR
	Jv18WOb8wVJkg1gRrkawzkw4Pmkkah8punyevMZUgmW95gA+gzEO+VXw5qual5XI8U/Dme
	asbMPttownpiIMHvt0ChcHbAonbXkR6jCGtZzS+7eFTnzP9ET5RSz3+cL4SMADqgaQn9Wr
	Q5NDb0aANh0X3thfgq+SDEydhGIP4ghLn5D3FFW2FGdZJn5yYDVnJszHnLuNZQ==
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-34-ocDaMeZcMsisERXXFQxjow-1; Fri, 15 May 2026 09:13:53 -0700
X-MC-Unique: ocDaMeZcMsisERXXFQxjow-1
X-Mimecast-MFC-AGG-ID: ocDaMeZcMsisERXXFQxjow_1778861632
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DS1PR02MB10490.namprd02.prod.outlook.com (2603:10b6:8:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 16:13:48 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 16:13:48 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net 1/2] net: ethernet: oa_tc6: Interrupt is active low, level
 triggered.
Thread-Topic: [PATCH net 1/2] net: ethernet: oa_tc6: Interrupt is active low,
 level triggered.
Thread-Index: AdzkhXWsBfjk9r+8Rfiicwso7Mkzrw==
Date: Fri, 15 May 2026 16:13:48 +0000
Message-ID: <CY8PR02MB9249D2392242AF27988B9C0583042@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DS1PR02MB10490:EE_
x-ms-office365-filtering-correlation-id: 46999798-b2b8-40b5-312d-08deb29cf251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|38070700021|11063799003
x-microsoft-antispam-message-info: WdQ0/H0RnKslHifQO3iseXUlKfFkK8e4ToFuXijrrRseADIoFA1MVoNiVmBI7p/T7pP4TF0PWB+6DLSxfzQwefunmYPMlVclOiLwAqc/MsSAelpCjYsnD3ZaS6Q5N/Zx248f8wyVO9IRat3txs7w1gTy2S1U4ZlkjrGDSC2TJxlyfxuttJ18R9jtk310z6+sLHoHpgVh8+4Wh7lNPfNAQYo0Z+EBUlfNF14f2f0Sh8ZZpsSJgjmtF32I+pypy5Fv2lasYqg4MYUteAU5qHkuDP4U5KXxWqxc2Ucb63tOnSAHd/Hj9pMZkdmv9pUBRl3IW6pbIMOdowJl/R2lNNMZEofw4nwOrg9WUn2fLn1sopyJqdKviKY+N241Ft4a3m1LdgAQgd/KbOTdYOSgxSU6UhETTZrkLMqh1HdgwrHE7kpLpH77ihh0e/Wuie4AGuUmKQLLhgPf0HPpsbAB4mFmQ3RVeZItz7wMrja5X9St6FH7bqHPhIAdD/Cz0DbR7ahhYT8bH9Wb87VbRo/LJymBjBevIAF1nrHq7qPl69Ns5Qfhsyw933z/Sbz/yRqar/0qbdksbjtQNE7YRrzJlKZHVhqZBdIObzXUTTyuu6Mj2kkVW/cCmanEthgWxLYiyGSPj3SCYYIOjN2M+KXh4gvrzOo61c4oB9EfVOkz1K1kmhejDNnPXvrsq3a5gSkCwZfbVIo1zp7FyymkbvhnZSPY7hFQQjQLItb4hrSQhQZYS79EF5R5WgBVLYeoL+eqtLs5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(38070700021)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Co4MbYzaVPegZkEGAK2/0jJhMNTNeskQc1UbJLtQ4sSPvXDxD5nQ2wGG82io?=
 =?us-ascii?Q?O3Ck4b3A9GHvgvmAoC+8GqiqR2w1mEyqIa6PXYna+TNdHm3dzGM0MFZlybWr?=
 =?us-ascii?Q?Uc/s5TlmFnHv35eW+Fas6sCDfe7lfiV9Odmjl0toJtTfoavN/wxU0c/W+i5+?=
 =?us-ascii?Q?dgY2Lupy5QuZysFxUJ2fM7M9j5HWzdbpz9LMAgE5VJrzunDm926SoyxKlpNj?=
 =?us-ascii?Q?XoQ6OfDMFThWeD3oAi6BHZAfdTAoTMvvZpigclKRQhIYOGE6762VK//QOu/y?=
 =?us-ascii?Q?/p3vNXeDot/6QSj5UZ8lXsJsPdOmXY7sKeM8mMMfPirqClFqUv4iS+s+ZecK?=
 =?us-ascii?Q?qj9f4JHtyko4hwsP5kl+5Pp8rXyJMR86ZFe1INUl3nBaAy3JBqmhKH6J9oSe?=
 =?us-ascii?Q?1W3gzbBS3uWC7CThzIk6TGOKL4jbYBPP6lq1EwOgJnAk7hnn6CZSLNP9fGXN?=
 =?us-ascii?Q?6jQfP0wzPN415/PIn06Ku0riM2kYWiQBPktFqntcUkbxYkN0/esKmHfp2ZKP?=
 =?us-ascii?Q?0CNAjNrkLtvvNiwMBd5hXXXUiulmotAUb+4v3L8bTvzSNuIdw2b7XT2nybOo?=
 =?us-ascii?Q?KfVHATtLAbwvE4d3PGi14wREK6wjzyjytRV7NRBs0hm+zxFd8UyF7oHUsneJ?=
 =?us-ascii?Q?Jl9IhhljEwe7s7+Wyye3og1+/A0sodfeP1o0DHngqfS1/0FDDBi1g+EBCatQ?=
 =?us-ascii?Q?oxSmUjOId8eRQh1bnFpFgAI30TYP/FDlgL/DgwNkgJlH4U4qFC+HA1dQDZ/g?=
 =?us-ascii?Q?upZF5uLjjp9g37bODksmd7nDIAk/DxXDVi7KwCfC4vPKB09xhCZ8cutzLFuL?=
 =?us-ascii?Q?EUXszBea2NoBkoq4m8efMkYXRhge7qGjWUfdtih+zGgju9qCxlITcJiSwjcI?=
 =?us-ascii?Q?n59A3+Qq6nATmtmd/s5o/bBEu4LjVBVA9GhEg+G/w1HnOHdNaYvSIwoy7SZD?=
 =?us-ascii?Q?yaVMIj9JFWH6GFAxWZJMtMPBBIMXcpq+0H2dS82YUx+1yiqIdDQVwj4WmUSk?=
 =?us-ascii?Q?JxVHVUPBMQPeHVzFOb0QvmxYcsiwVt92t3lpd5Lh7MGXzOxlgE2NkJb7K8Np?=
 =?us-ascii?Q?jiWiCsQbxxRnr/PCNig/qaPzIQabv0zBMaGNvwt1vx7KHmhRw1RlFc1kE5Vu?=
 =?us-ascii?Q?A5ZZABZk725V8a4nxoQRGHcYah38BP4Y5dk3wbdQWqJycsKMikIVo4U64C/L?=
 =?us-ascii?Q?ui0JI0Bx76l4Edk9gf/fcpenvnz/RqCiqgaEyDNztvuy2lkXooLDxXYheTA9?=
 =?us-ascii?Q?BSgrTjf2gfxdDv056WmVVmuj9cwN4JVI67pEva+mNeeo0p7X4ewVnmaNlwoP?=
 =?us-ascii?Q?FiPB1al8qO84nsBM25M4ms1u387IzI/mNnJq/wmWXccYZYr53//C8bVvvACy?=
 =?us-ascii?Q?onVcP6ewzYFM96HnYSKZ6GzZinn8DQDB1UKJxQUK0+jTvkFiqyMp9SXaGona?=
 =?us-ascii?Q?wmCLgYFoEo7vvGHosjn7WfFr58TRcGsB+91EFoIqaAo+46Igzn2bSFw9CR15?=
 =?us-ascii?Q?VZr2hKVDGKStbzpiy03sYCobWcF3QMnza/tbyJ35kg0JdfqmARAsWfiLOwpx?=
 =?us-ascii?Q?rcZ+LPpzoAeLmyGMVHtKx94a55Fsl713XsVA7qX1KYnnGP9I3MxzDl9iaQJe?=
 =?us-ascii?Q?AXD3pspkx5LXSmuMLO7IceFmZCgs9lFlpyUEFpV03Lknz3DHmG+j0tKbe6lu?=
 =?us-ascii?Q?8KYrFQgUu8wHQ8SGdAJ2TNkGQM/a/xqevqZ8BI7+cNwJVeUgobgupnrcga0O?=
 =?us-ascii?Q?mEjPSwM76HCrhVrCytw7kyT2wMc8BoA=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FKvTo8pEPfaBWLitEkxDpbRtYSX8K7cqaRXl0fVtBWL4jvHtAuol627o48/zS85ummncpPUUvMDGN7jgu+wMk8GEUugNY9lnaHv4xEj9kBxTQLONOJ7ELdRZB5RwRI9ZuJG+OUVlw4zDmNPkAXNZiY9EQm1vVAvSZLL2gqlgtDASofEVEqE72a6dvKj6Irnz1THD+7jiuXQg4sEhjZP4KMR5aCgs6/MNUxigBbMahgVq3b2KfbLPZRWjBrFvUpPEkEjXHnfo7s+wB8dJNe6yKUNzjPg2NrRIXSFe57KG/3vorMiN1cOLDqA3exPomShs0NKz3CtC6RbERqAMqMlVpw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46999798-b2b8-40b5-312d-08deb29cf251
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 16:13:48.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApHoFtqXIUWAUQ3XnbWww47J7/y1IuyMXNDAV6nuFotqsNMVYe1MPqzgj1qGhKAppmn116FUPO7Dm0q+huwyZ1gYVCjE0/whAR7jXMdTooM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10490
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fumsDL2FeYxMW_KvebmCAKNA3p9Y9Txu4N561P9pgtE_1778861632
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A5DFA553CF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288357-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,onsemi.com:email,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

According to OPEN Alliance 10BASET1x MAC-PHY Serial Interface
specification, interrupt is active low, level triggered.

Fixes: 2c6ce5354453 ("net: ethernet: oa_tc6: implement mac-phy interrupt")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 91a906a7918a..667faf155405 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -1323,7 +1323,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, st=
ruct net_device *netdev)
        sched_set_fifo(tc6->spi_thread);

        ret =3D devm_request_irq(&tc6->spi->dev, tc6->spi->irq, oa_tc6_macp=
hy_isr,
-                              IRQF_TRIGGER_FALLING, dev_name(&tc6->spi->de=
v),
+                              IRQF_TRIGGER_LOW, dev_name(&tc6->spi->dev),
                               tc6);
        if (ret) {
                dev_err(&tc6->spi->dev, "Failed to request macphy isr %d\n"=
,
--=20
2.43.0


