Return-Path: <netdev+bounces-24520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF6B770721
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FBA28104E
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCE21AA92;
	Fri,  4 Aug 2023 17:31:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801E1AA68
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 17:31:36 +0000 (UTC)
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C8D49E6
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:31:35 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374GjXs6021601;
	Fri, 4 Aug 2023 10:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=tXGOcxUZDMfUQWhUM0I4kf6k2BYpaDDMpMvFTXBGUek=;
 b=ju5U1n7KGdeKHxS4Kopy2Ihvcf3IFcxVPk3Ng6b13fvEPabs/X5pewfOhHE5/DzbGAAt
 ITi7CQV6kZHdsHNRr9DO/PY2YajP4LU8uy7+/NYr1k2/f3Dd1mx9QWJdq4Rqp6uFczHl
 yI6Y3p52+RXz7rs9SdkNcyyGiphRn1AGq2YN/4i9iglBAB6/KprMUGTHh7UB889lKki2
 oYH7tKpAgU0wJpDOeJIk5NuKDyHsoUKMeFEivBpyt6hUSjPs1BXyB2hiRPOjMMPPyq3h
 iE6ybHS647oXKpgLUCmtWfPyLDdlnpiLydfWu/0jTccmccgfu7h6tOlJqUXp5MCwhEoy MQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s52144rj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Aug 2023 10:29:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1691170149; bh=yYKRaQpdqPhqclT1WTX6FZ09UF5a141MXhotH5nuPvc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=lzutIqkhsCHE5MCJitVQZmYtKnyWTNz3IUYYpBaUzyxCjAp3TyRiOMiFuSbHYskf8
	 xWgsZq6T9895Q/LNjWsTFYMBt/F7gR2ImIpnSXj4gg7zUumg3SdCPzdygKBe2uL5yo
	 A4xiOoIN8rnLWEm/07HokZ/429zlLCAqStD96ZYsXp/3TxrknmrrOd2iuSN8m1ji9s
	 JH4UyuO7RUUcl9rsYeoYITjmUQ76HlnxRZG5uhRLalgkDe4Asb48XkbN93WvdMeX85
	 g4g4XVMUzmjWrbD/XmxVNHOnR7Jd2u1r9+xnK7j1etr5sPkr4zAA8MDQ4KECiM8Bq+
	 4dfz0F+/JqIBg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9BF91401CF;
	Fri,  4 Aug 2023 17:29:06 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 17F4FA0080;
	Fri,  4 Aug 2023 17:28:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=GreiwjsN;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 59F4D4034E;
	Fri,  4 Aug 2023 17:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya6mb5TNIzDgH76nyR1DDGKsuB0jhDZQbaC78SsdHIVJRSCwL+G1gDT2mrscJ97HcizrXixEaln3hpOL19bdns3rnlf+WoXM64hVvEUnjbQuFtItasKp0lQSW3B3WScfyzeOUCM4qwqsd9mGovyh7DQKTbcJ7mLhAqiAIqz0q+w6r5FCM6QO/n2tswxTI7GqyQD6SjUFpijVed5OVnjnBn55qhukztv+ctv14xLRdT25Y+/M+Y+35OXPn1lCoZAAJWw6Jh1jpw9oww7ZY3DfM/oPsXx8sKJFPe4BF02i/cMCbz8p4c3OObfuLwUcUzUb+h63X9x/GNUQndyMpOOmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXGOcxUZDMfUQWhUM0I4kf6k2BYpaDDMpMvFTXBGUek=;
 b=HLyZRzyWBRTSukR2Q58o0kLxkcVw4mgPB9KgUSABWcQ/RIJiVoHdM4/X4xuO7m63vZ5pS6TA7vf7ykOwzZ3NrSZ/1Ye+kOxwUHuK2ejbfZ6kYvbef0slLVpYTT/nuHXJRIadDvcjqRI9RIs0mTpsVdTWMKiTfDXUchTQSzOMVFteKa6rXtccNrQUTsbMsEebj3yKKC/cLCjIAr8uoQHtVy/D8EpUxzz7GISIeXgs2n35Kt1YkS1nX0OPKuWb215F3SdH1ePCyoUZlLNb1motS7OhTLDuRLFPVA3gjg0Xy3kj+J90E0j9LEMPW6S5vMXo4dzlrHG2WdTTBDaY9dWoWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXGOcxUZDMfUQWhUM0I4kf6k2BYpaDDMpMvFTXBGUek=;
 b=GreiwjsNTCopRl0hAmaykTFteavK5E0jNP5RXRZyvduDMhboJuREO8YuZ2wkCsOrHX3lW7nq9RZaNxIlOuuR2/gn5QRiCpKNgmHwuqPJXR8MeahjVBjywKPGBltGVx1+IazcJR2foVYPgqoc59kY5kis5tQscn5ocGLQwGQmgpc=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.21; Fri, 4 Aug 2023 17:28:49 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5%3]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 17:28:49 +0000
X-SNPS-Relay: synopsys.com
From: Jose Abreu <Jose.Abreu@synopsys.com>
To: Feiyang Chen <chenfeiyang@loongson.cn>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "peppe.cavallaro@st.com"
	<peppe.cavallaro@st.com>,
        "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>,
        "chenhuacai@loongson.cn"
	<chenhuacai@loongson.cn>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "dongbiao@loongson.cn" <dongbiao@loongson.cn>,
        "loongson-kernel@lists.loongnix.cn" <loongson-kernel@lists.loongnix.cn>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "chris.chenfeiyang@gmail.com" <chris.chenfeiyang@gmail.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: RE: [PATCH v3 14/16] net: stmmac: dwmac-loongson: Disable flow
 control for GMAC
Thread-Topic: [PATCH v3 14/16] net: stmmac: dwmac-loongson: Disable flow
 control for GMAC
Thread-Index: AQHZxf37mgIOG7jnYECU88zaKkTNRK/aZdYA
Date: Fri, 4 Aug 2023 17:28:49 +0000
Message-ID: 
 <DM4PR12MB50880DE89F513EFED10E2B95D309A@DM4PR12MB5088.namprd12.prod.outlook.com>
References: <cover.1691047285.git.chenfeiyang@loongson.cn>
 <021e4047c3b0f2c462e1aa891e25ae710705ed29.1691047285.git.chenfeiyang@loongson.cn>
In-Reply-To: 
 <021e4047c3b0f2c462e1aa891e25ae710705ed29.1691047285.git.chenfeiyang@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTVkYjhlYmM2LTMyZWMtMTFlZS04NjJkLTNjMjE5?=
 =?us-ascii?Q?Y2RkNzFiNFxhbWUtdGVzdFw1ZGI4ZWJjOC0zMmVjLTExZWUtODYyZC0zYzIx?=
 =?us-ascii?Q?OWNkZDcxYjRib2R5LnR4dCIgc3o9IjYwMCIgdD0iMTMzMzU2NDM3MjcxNDIx?=
 =?us-ascii?Q?NTg5IiBoPSJCOWVtOGpUc05ZNDFBMzMzVGFaVUZJMVMvZUE9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIWUlBQUNW?=
 =?us-ascii?Q?SWhNZytjYlpBU0tmcmxDNTA4SmlJcCt1VUxuVHdtSU5BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFBR0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQUZWYVdwQUFBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCdEFH?=
 =?us-ascii?Q?a0FZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lB?=
 =?us-ascii?Q?YndCMUFHNEFaQUJ5QUhrQVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpB?=
 =?us-ascii?Q?SFFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFl?=
 =?us-ascii?Q?UUJmQUhBQVlRQnlBSFFBYmdCbEFISUFjd0JmQUhRQWN3QnRBR01BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJtQUc4QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRB?=
 =?us-ascii?Q?QnVBR1VBY2dCekFGOEFkUUJ0QUdNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?Y0FkQUJ6QUY4QWNBQnlBRzhBWkFCMUFHTUFkQUJmQUhRQWNnQmhBR2tBYmdC?=
 =?us-ascii?Q?cEFHNEFad0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCaEFHd0FaUUJ6QUY4?=
 =?us-ascii?Q?QVlRQmpBR01BYndCMUFHNEFkQUJmQUhBQWJBQmhBRzRBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpBR0VBYkFCbEFI?=
 =?us-ascii?Q?TUFYd0J4QUhVQWJ3QjBBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUhNQWJnQndBSE1BWHdCc0FHa0FZd0JsQUc0?=
 =?us-ascii?Q?QWN3QmxBRjhBZEFCbEFISUFiUUJmQURFQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdVQVh3QjBBR1VB?=
 =?us-ascii?Q?Y2dCdEFGOEFjd0IwQUhVQVpBQmxBRzRBZEFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCMkFHY0FYd0Jy?=
 =?us-ascii?Q?QUdVQWVRQjNBRzhBY2dCa0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|CY8PR12MB7169:EE_
x-ms-office365-filtering-correlation-id: 03db4506-91e6-4d74-f438-08db951043c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vAqg8I2NEopf4dN0uX/BGfYVmZ9y4XkOlnnot40cB/MFJsfGje9w4YuZ/td/cLLnpOKh6WfyfgagFE5sAqrYLnEYndJitr2S/dx48VfBt3N1lP4bVRlblqCBiaqouYkGvI6Nim7PFq9lsKDTteWwgJZ5A9qBEqKPA7LIYmIYkOcHmqlo+UVLxWQi+9uCkAu7d2r8Qu7oOShUQjgeBqShNntgvPiLw1I5jf1OGO5M++8EDhmhOJuDhraW0/yNovLayF5dkZt/65Sdye8XPgoz5rTDJacMZvkgc3T7//RI9whNn8lwtZ4BTJn3gWxbW8suezjj9mLxXMz6owIa69tGCrqzAx/dAmwKh4mld0bLijDSsjBHzpM0cjq9OQpI0EVZ2eXIvxw+5jLbSASrrM9j34DGWehF7v2qrMvj5eL6G7Q3xR48zMI8lspKOp958hM5Zqs8sVELAeBrCbScNaU6xPLojzcIke7Rl1RKadgAwu3CJZDLa9vHOJzs1+JWuqH1WL4IkZzc8Y5xfmi0HNXlE7+CgzJDbex52AbVJG3zaUgHE8ojmn4DIim1osAqE1k36JX/6sKW2qIYvrxPALqiM1m/A5t3w/MMDBoRyxZ3RHpnzuCJvF4HHhiBkxTstlKz
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(1800799003)(186006)(451199021)(8676002)(8936002)(4744005)(26005)(478600001)(107886003)(55016003)(86362001)(9686003)(7696005)(33656002)(71200400001)(316002)(41300700001)(5660300002)(64756008)(4326008)(66476007)(66946007)(66556008)(66446008)(52536014)(83380400001)(7416002)(110136005)(54906003)(2906002)(76116006)(6506007)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?akCBCkbyAnLqwg5wCpn35WFXCaJZpIYNQQPgFK8jWf53v5Xa98Kva+rZ+qR+?=
 =?us-ascii?Q?fXYW2UrAeM5jvV4WQujSF39WYYE91SHT9PRFfOac8gHEciHm0WosMoRtFzXo?=
 =?us-ascii?Q?9r+dGFQHf1LSe/IVlM6QPkFL7WbQbuQjxAafqZe5/S8oF9Ec+6YyJo4zhJar?=
 =?us-ascii?Q?cXDm9hhvUESra/UiD0pl3Sjl46rCV6KT0foD0FIxrbHMoyqXG1yjaOOuQdLd?=
 =?us-ascii?Q?kGp1T6yQpsnvKt8V/3FIbqElkwwlpttmAXCR4KU5UOuBCflCNnUHxMy7fiqj?=
 =?us-ascii?Q?lhQlmVhvjY/aWPNHZ5mUbk525GasNjcVcHDiy9Hx4UqcgWYBsT7jHXV8jgQv?=
 =?us-ascii?Q?LcIE+em32fzhfzKqUN8WStoS1XN/8n4GgMFISovADlbRq/PQmDicC5FVGaJF?=
 =?us-ascii?Q?hh/U+XK73Xz0balVrlI7ErdZC1G/5nxW2uVh8EYhDwFIw6GCxPEtuUs4yyn3?=
 =?us-ascii?Q?8Ga6sfKcOB2wqBBBioolrlh6JevEu3gAKDXJmmVSBYSX+0wIlRFcW51aE8UN?=
 =?us-ascii?Q?FKnntjGXo7qsq5cqZNxJJL4wKH7W+Zy4hkeBHUrxGnwolmUKrvT5ZafHgbNo?=
 =?us-ascii?Q?KrI0FanADM6s4wx5CcQgvUZcVphl5X4SfNRKTbCpkczeO00q1+5EodxymU2n?=
 =?us-ascii?Q?F3p022KteZj5tpXAe6Q3SPFOpv+w4o3MIdfRfmIVSJFWeNYPJNuiFOY18Dgt?=
 =?us-ascii?Q?8KGpLipdb/QHsi0kc/nUsQTXvHPXT3wfJ4MO5cCEfmVB60F3sTsTu84/Ew3s?=
 =?us-ascii?Q?qI6gcHEtQiZGIF/xABY5BzjBrkNd2dyVn2cEJtaa30saMBjdtIj5pJmvXeRi?=
 =?us-ascii?Q?0A5eP24tbUDZHsRafWmzz3qL4woLv3ZAjBUF+ESNFZBV5qt115iBZMFFijUf?=
 =?us-ascii?Q?g6y+T199BP7t5cKJXRDfW0iGmJMsWTqDYBhF8ed4ir4q2NkCBeomP/VqpSKD?=
 =?us-ascii?Q?qXbwFzwKYQNsaCyyWONQsDUD1bSe7U9G4OvxT2a1tzNulmyJCefGpLzWJr9B?=
 =?us-ascii?Q?/Ukz4rBF2t3wgDV4aTZNrLcTmmcNJbcsM9s8MvHnJdVAw7xCR6Xo4vOV+0z4?=
 =?us-ascii?Q?FgSkfFafsmYi3Zx0sAM0GGLA0f8ww7GiKbAeGenVPYiIM9L9x8t5cZjl1GGo?=
 =?us-ascii?Q?CedhywiUh+31v9osW3nSFyImtbRW5dtsXhqoONRvxgyitKUkoCu0ZiWeaxWe?=
 =?us-ascii?Q?gnxMkxVE5U1DD87iRghQn25uadPpfG4zhr1sZstqy8NnCrt0Mec78LC2BJkl?=
 =?us-ascii?Q?Z+kobZYq/L/92+YuQ2o5226kCSQbXJRKfeldLxG4TaVNovWodSV2CSj5sRwU?=
 =?us-ascii?Q?rw/Ty5sK0R+LHNwm1Dt4YygUtZfXlVCyFu7CV0PkSf81Eiezf4JCs13N3u1W?=
 =?us-ascii?Q?nUWbc2saW6YWXxWY5nZrrRoQBAm54y/Rz7s+nIYfnRjtyx8GsezeRhrQVuRF?=
 =?us-ascii?Q?xaS8dw2zHRdw1W14F+nV1owEYBThcAmUW27r+fqSlXKgo4Cf0UE3jo+ZaISp?=
 =?us-ascii?Q?PZCQCPBDSONWFkHgkLp87apO8UMN6M0RsVbrtHO755C5YVHnEEcxuQFMBBYI?=
 =?us-ascii?Q?NFa0ajdKUy8WHdljst95AsedJduNnuQc5DagROe5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?qXqg0CWm2/Rac8u2oBtv2LmFhRcNO3kvj2i2ufSU02UArLzsLr33FVSw29vC?=
 =?us-ascii?Q?rSF0y1ZYgLhmVWJ2fzljf7xvsIcqA+6/iLu0obTKVoZLaqHQKtaL1RCmrW5X?=
 =?us-ascii?Q?UsmUi9URz0WcqebHGHxPg+fXvSe9WVN2YUy7wJPOF2WC35AFetO9OA+ey/ES?=
 =?us-ascii?Q?chOZnG15maqyrSfeZcTatEt/gfGP64/XsvJw5SWeOWH+2VMOyrTcHoirj3S+?=
 =?us-ascii?Q?J2gXIb9r3uqDibQlJOD9uAURH+FGeYmSqm44NLkNHd3yXCExni7i2JuHl5j0?=
 =?us-ascii?Q?phTsInOVCLuiVGN0gY+9oX3isqyLh+OuONn2iFbp/Oi41KB09EFeRxK0qWzK?=
 =?us-ascii?Q?R6x1qXGO3uQDq5E8M6nVR5ShG7QP85kCo9N8usYKXieVXMD4XQnGaka91lhK?=
 =?us-ascii?Q?j6nUnTQaGmmukXgWztYBAxQLE0LODBXa/PmzNSIIpW6XncLvNdSC+QxqpPOY?=
 =?us-ascii?Q?PwADNLhkU5wNGJ6YY36Sba3a+5pKlJ1UTOHPQZwLLI9P3gOaREERHILO9LSY?=
 =?us-ascii?Q?G31r1ej0Mbai0FKqb4ekDUasyxtW2q9z2jqZfu2PRqinEVZHM2CA3SUgFvEk?=
 =?us-ascii?Q?nfd5mM+K2HpW9qFYq+SF9GxRQWYWhFYVtXsJGYFVqGU4HB7zi+ZuSk6SUgZG?=
 =?us-ascii?Q?HKohiWPT/2TYH+IB2h9yVTCaapTarp4c9y8F8U2u2/ALT4E+63eD3rDalsb/?=
 =?us-ascii?Q?BS6x19/4WeTBjdico6bJAHCLjaDkIc1LyM20KqyieSc0yHC976jO6riDucnz?=
 =?us-ascii?Q?j6tlVWcXcBl/DZQpku0xyVtFIn+jIrp2FyLvXcUTUWQZDw+k/hB4AlqztXpd?=
 =?us-ascii?Q?BRDbg456vyRvcE9FiEEBkck0HoJey8DMmQrU3tcXeJkZPABRZqS3pi8eMd9r?=
 =?us-ascii?Q?CnObpgV+X/VNCH6l8orHF0WG52lrfnv9pHPUFSb9W4r4EtE36qDw8sS1Y8Fr?=
 =?us-ascii?Q?KFIa8MKaMb50fKgIh05QAxnd8EndraM15CTeSd6d3TZ2xw8vCNv3alNQXFq8?=
 =?us-ascii?Q?w3E04UCosK2geBUdPW/yKZoZIPym+XO1w4LwmC5VYXNa5EZZ/sURglI6gdvM?=
 =?us-ascii?Q?ZLJJ9AVs?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03db4506-91e6-4d74-f438-08db951043c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 17:28:49.1830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbhnG8BFGpfdrutvrx73grAcR94Pj04wfccs1eRaPYureQDAQxO6hgmtAtPC3/CSZj56aTSoqBKT61jlpnNhvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
X-Proofpoint-GUID: HjdulneAM_aY53v0utK38u5xUD8QNIuE
X-Proofpoint-ORIG-GUID: HjdulneAM_aY53v0utK38u5xUD8QNIuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_18,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=933 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Feiyang Chen <chenfeiyang@loongson.cn>
Date: Thu, Aug 03, 2023 at 12:30:35

> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -360,5 +360,6 @@ struct plat_stmmacenet_data {
>  	bool dma_reset_times;
>  	u32 control_value;
>  	u32 irq_flags;
> +	bool disable_flow_control;
>  };
>  #endif

This (and other patches of this series) use a bool flag instead of the
Recently added bitfield flags, can you please switch to the bitfield flags?

Thanks,
Jose

