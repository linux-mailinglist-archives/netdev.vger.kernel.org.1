Return-Path: <netdev+bounces-24517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2E770713
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E911C2191B
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7AE1AA89;
	Fri,  4 Aug 2023 17:28:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14344C2CA
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 17:28:45 +0000 (UTC)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57276212D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:28:44 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374GjPqZ028767;
	Fri, 4 Aug 2023 10:26:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=LJK4suhimLkD+muWe60rvYbfXvv9IzmIfOjEJhkIsh8=;
 b=eFjTFxw1wPkD3XJwUNzch2GEmmBdP0GhhroiEZtcz0RW7/8+qpWo8Nf4Z6mIftbqivKX
 CaalxRbtwCDTTgW1/+9b9lh3xT0bLxKFdMbdjIys/BfHwLgESEc7wJUYTBPAHA5KxPFG
 cAEqzK4u4N3+12B+OVyrnnbJQhEBRg0L4u1wrUIPy1iGV8G9y5BymvDVIWFnLnHgbxyZ
 mrR9Cytbu6Bgr2wYnFU/mHsbm3ZBCD0ptWCoSAEvwg3hsLw2O9NIeWDfvWeaDrgnIUsj
 hxtBCuDhP9wfsE1S2GtyjV0Wl0myPuQAs/2lajbYtVgCbPGjBDtH1+3Yg9pf+Knn+bHi gg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3s51ddfqku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Aug 2023 10:26:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1691169972; bh=LJK4suhimLkD+muWe60rvYbfXvv9IzmIfOjEJhkIsh8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fsG33fcE5SXSQYPkkz+cH9ZPHWBJxHDkVpOIFS3XKeleBaD41cKHjsUUU3LMvEKc8
	 aN2Kkr/J+xZ42PobW5dNCxpDLhWq7Vw2xMOAW0fzm9jCCx5ZQJ9pjgHNqPE7MegEIS
	 xxQVihTEPTHywYcttCwQxtaq3kdFLzWHjRimRuRi95p0ggnF/14N761ERU41MtiG5n
	 zBBgZUUuEFV1pHZ7YyUPvyL7+rBAmWOg+vniANxGqBkuWXuyrnBNfOF56W060/TAOG
	 r7wAYdubd/MnUrhDwpCQmE6R3lsYMMcuMtEBoyhahA+/rBaF7dwAW8gXY/cSCe5h4/
	 gv3VqzRYrxrDw==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3504D40352;
	Fri,  4 Aug 2023 17:26:08 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D5363A0071;
	Fri,  4 Aug 2023 17:26:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=PHRpIjDt;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6AC8A401CC;
	Fri,  4 Aug 2023 17:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKBgjm+SRYkx33GWqUfC9F82aD5mSmr6FlLyY29Ctq2Zw4L8PoYBT3MUgTY5cqP6wu1BCUk//bpz0aQQeAZezhydhQeGou+6LUX/gkCBhxLoj3dPBbU7P2SNn8E7X64/+OVVKgbl9LjqXGaUzRORJztRikbvNSxOSpFB7Pi2MtJ1g4aQ3/0O7W3BP2tGWLCtTbQvyxm4YcPU/poarxW7NrWMOjxvwfJNlGP9S75RC+dfLH+LmHWhRCr6khUHigcJelTICo1kkUk/AsdDpkx69EiroEUYGw8Iopr9HYK/5vaaKSPyfZj7Gr6NFSMmTZx3QxSNqqgpzDqWCXfOsjcZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJK4suhimLkD+muWe60rvYbfXvv9IzmIfOjEJhkIsh8=;
 b=XNqNDE7gCyUDcb3KfMUjZJBg+wJqD6arR+fCpK+Xv3A8vnfv3/ztA9IeJl48+ODLVo0ilG4wOUh48VEMTwnOCh9dbKtLp5Ra8MnOQt+PD06lL7ey/EIgpbtOjHsw7gThlIcqI7588QfycjcX3cfhZC51jWeQRHhcZXBs7eGWwoIBGvJYnvKOVD+0S4BMjO8P6uT/S6VFDfeMsKraiBBPWHvdanFQEkt1NqySpJsSFIxIWJYTROL5KpZOk2RWNvgivbNtu5HDv1za+AgJkOIRu/x3zj7MKC54beTbUZYCSAJKg2fq+0ML/+bbxtBqpEUPAICOARxRSGWX0HEY3rm9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJK4suhimLkD+muWe60rvYbfXvv9IzmIfOjEJhkIsh8=;
 b=PHRpIjDtP7P16xIr4QsgNAveccGC13GBmlKssGrrmKEVaySv4+fYndo24U3/61thu21BcvUmLBBqbU6KepoE2lTVqQ0LHH3L0p/K4+onyazDBPlSNcnDF97SsJseM4CYN6YNaXRWNd4KEtNtNn0/bm9qRAa7rq3bl9cWCUymbbo=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.21; Fri, 4 Aug 2023 17:25:55 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5%3]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 17:25:55 +0000
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
Subject: RE: [PATCH v3 00/16] stmmac: Add Loongson platform support
Thread-Topic: [PATCH v3 00/16] stmmac: Add Loongson platform support
Thread-Index: AQHZxf25oQcYDyHU9Eqfz8gpBoBkJq/aZBqQ
Date: Fri, 4 Aug 2023 17:25:54 +0000
Message-ID: 
 <DM4PR12MB5088C3C2209B392C9CED2C9ED309A@DM4PR12MB5088.namprd12.prod.outlook.com>
References: <cover.1691047285.git.chenfeiyang@loongson.cn>
In-Reply-To: <cover.1691047285.git.chenfeiyang@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWY2MDE5ZDkxLTMyZWItMTFlZS04NjJkLTNjMjE5?=
 =?us-ascii?Q?Y2RkNzFiNFxhbWUtdGVzdFxmNjAxOWQ5My0zMmViLTExZWUtODYyZC0zYzIx?=
 =?us-ascii?Q?OWNkZDcxYjRib2R5LnR4dCIgc3o9IjkwNyIgdD0iMTMzMzU2NDM1NTMxMzQ1?=
 =?us-ascii?Q?MjI4IiBoPSJtV29EZWMzWVovZG9HdG5hTklZN05rbjhwd0U9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIWUlBQUJN?=
 =?us-ascii?Q?clZ1NCtNYlpBWTdwSmRkMnFlcHpqdWtsMTNhcDZuTU5BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: f2fa409f-6262-4e58-1d1d-08db950fdbed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zWtHbmpFsVX560wKwCuLq7Y//Pg370P2ECelhBrCADPb3Ia6h6N3evkMVRhCe126thAi975nEd46vkteDn+aCLIcJWdQd6ucNfGoq4+BN+cbDmnUZRvvsd50/nxs/PjXiE0Bu5caryxZ4lXp6Vm26HwioN0Ql2HHgomBCHkDAXTyHr+WeeFSIwHaVn/M1s6pgQhLAqIVR39dP+GRfOGCLiNsKpy4WnyXeiAKbu393nIyJ4WgZqACKEcXQonZbBfwhPfeXv7A6ckeFupbPOQapPSjkM3pYZRTFz20VKeqTf6hQvRg7dVRagcsXNzIpd731wWikAR+Adb/IMq4kUskM8MGbUBaU9BvSUHup+Hmo49rkgxIc/N3QCSCz6goNGw174cDIAgcFOssBKuwvS3WuaWypYVUmUcffvA4FGw+nUjicyqcBpia++oO3VuN+h6mh9D78p7zD1GA+QEpSKFmRavf9JxZDVSyIyHgE0J8I524BOSNR3Xyln8NUDPSfMn9OkcVYfbKPSeGgnt3upNhuwdxmKMDeqjsw+mj2hs7RAWTw6O4iMDiTYGDeQtGVJ28W2tAwqnw5fppQXWUYoy8Cxs9th7ReveJwXCwk83F4isXQG2LBbawmhJYzyOUr9lw
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(1800799003)(186006)(451199021)(8676002)(8936002)(4744005)(26005)(478600001)(107886003)(55016003)(86362001)(9686003)(7696005)(33656002)(71200400001)(316002)(41300700001)(5660300002)(64756008)(4326008)(66476007)(66946007)(66556008)(66446008)(52536014)(83380400001)(7416002)(110136005)(54906003)(2906002)(76116006)(6506007)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?RaxY2J1YXW+rYe6oKtbu4EJnkmfJKRKATc9mJV5T3G9KwV1u81jmX9ksgtqa?=
 =?us-ascii?Q?daijZj7AiJl3SvsLJbZ4B18g9S26Y3EQQP6hDnAHSr2U4J937Y4KYfTNIX4b?=
 =?us-ascii?Q?39HTAV8MbDjq2ynH5kf2FHgGZdvmeAiyI85HMTZoGPReeOH6/dZyw0o3x/bG?=
 =?us-ascii?Q?mLP1qhrtVEHh9+tmPzkRgU0A01cgUvXUnWle2hyjFwBkRFwN6zYCsWbe6CXy?=
 =?us-ascii?Q?Z2XMmNGUr2lZHRpyq1jVAeG0mHmyyUEPXlvmLPec8cbmdAIgzOvZBnMRG83a?=
 =?us-ascii?Q?N43sNYxB9OkROg/7WO9ghB1pfba88HdseZ2WgYDkChY82uuL6XG2zMWGF8Kn?=
 =?us-ascii?Q?yqObp/KKell/VFJKJn4DbUvn7Tl2NhZoWhc9w6wqTSBqZ0H16vB7a8qE7t/7?=
 =?us-ascii?Q?IPnnSC0YHpN6nsVNJLwEl3e/skEstsRUxZ9FLobhUDXFNKofTwjRe/VkMuup?=
 =?us-ascii?Q?eMv6ZK8ZGBpHm1ytfjs/aCRouQygGK32gAXrIAXfT7N9p9KeRFUyRLutDEsU?=
 =?us-ascii?Q?DNDw73A/rXPkIzRf+zZaP54uvlmCJDgfwhUTBhddEXRXBzG6a0HOwIEWQOob?=
 =?us-ascii?Q?IuvzTwCeAfPS2WHy3HMv8h2NiERbi3fwqfWm95/qJ378eml+ksQADeB/p6Fx?=
 =?us-ascii?Q?A90ZvI9umxEqWUNTqQrCLwh+8eYhV4GzXfpYyAOm/quC3ooV+qtLyjVbqNSr?=
 =?us-ascii?Q?s3Z3RrFs/ga4EBtQDvydpY2YJretwrRq6BG9OJQ195B1owhHEI2VMoNGMchf?=
 =?us-ascii?Q?pljrqON8m75gzrlZGtvDO/ltat/w567h3Ar5emPDif2gYFBiWU0phr/aTbJH?=
 =?us-ascii?Q?DQskOqL+aF6MKResJEBBHeDyd2aPWCB6FEh7+SEz6+eRCqXrqcebd56Ldm/i?=
 =?us-ascii?Q?RP0SnCJsFfgFdU6KgwNCB05Tersv9mG8x647n1uxCjQCr3SRJKYBAHv89tiJ?=
 =?us-ascii?Q?h25f6bdIpoNWy7qEUnmJ1KGyVzsjJcHsGlWhZ45yxMqBtNf3R7JhcCxiUwal?=
 =?us-ascii?Q?T9eQfQCzVJ2deG29A07QMUep5g4BQ0dDFwspoMBQd8yW8sDxdRtK+AWp0jQc?=
 =?us-ascii?Q?aIyYG4XuktQfLfrMcQngAZ33NY9zrh5VZp0WLopMS1JixEhGF/If1dvixDDg?=
 =?us-ascii?Q?XDdOwSSt/ACNxka7j9o3/JDRZAf6yHGLxpC/hcfGhY0Qa1uF8pEfyfuFt4Db?=
 =?us-ascii?Q?eti5r+/FygZI4rA4vllRS1YVYFJK3ROaWhalkbeBgSZrTTw6cWlJX6xn/TS4?=
 =?us-ascii?Q?jz34yn1QymVLDTcRb5vR58NLwyspa+a566SRHg+FoM6LYAEelB1nJ1vzuuN3?=
 =?us-ascii?Q?DAZ3mHb2USlV9NRbadxwY4L7yKuzsozfwSdqQumKpxi+2AF0EdlnE3Mt7nph?=
 =?us-ascii?Q?PCF9tpnweNvFhQ7J+OUcrFecugtszt6X7bPoSUZS+VTUK//o2H5Whxo1eWnz?=
 =?us-ascii?Q?XfjJfZ1c3s9EesjOL/nHjE0osRCOCgE22yCq1VHiNvi/nUsF8ePDnElwCigX?=
 =?us-ascii?Q?6G+VjlKvqhDe4DRFIl2aUUi+bPeWaD9V26Gg1D5VtJSVO9wuV6rHOrCI2qH3?=
 =?us-ascii?Q?9mK1b/6Q/tcbmfFFlCb6rCgsnDJ3LwyiW/QKYB5B?=
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
	=?us-ascii?Q?anCWXZHhmUDvzeyi2txZZ+3yaH/5L06X61Beeyj1gd2jIyazi5C8M+pAj5lD?=
 =?us-ascii?Q?61kHV82WcuokiHcZEaFmMpk8OT4GTtxHLaAD/37U1pTpwFDGt71yd2JO6ImQ?=
 =?us-ascii?Q?evOZf4enwoXbP7k16c7TMVPwNeBW0hU8ajl/AEB6X3OdEvCq8cYCWeTVRkU2?=
 =?us-ascii?Q?S16VcvL4WiqjNAMW5qvi4/plnH4en1bPvvV/oMwBLnNOJFouxwxmgA0r4CSk?=
 =?us-ascii?Q?hhSUdy752A2bccPts5aLDT+ybQXsjqFFcqw+nBHeuiQgieW9a49/utgKtnwt?=
 =?us-ascii?Q?movMTjRog0aMJNs9iCIe9f7BJwoi+o6FDMY7Zaa4nuzWqqeWhiGTlAtW7SHz?=
 =?us-ascii?Q?+XjqhX+Rb5hARQukgxxNBwn1V8s4lApyWDNBRxzTdeqnIpZ7U5go0LbLaDgm?=
 =?us-ascii?Q?fYMMd3OzX/6FA5G+owYf0Kt72wQ/soBXGUzAbZcl2vlxaT4HTMfM3KTOLald?=
 =?us-ascii?Q?nrLtp6vjv4aZw9GVBM8UHmeUqPkZgCckMquzX+I4k08FtNgyxp0SviX0osL4?=
 =?us-ascii?Q?aFyvQYz5BlrER6Rs2MhRlVNygXFrRwQ0rFtq+FOhtRbAhQZtwsrC/XUX6fgu?=
 =?us-ascii?Q?hZByLynlIuVqcpcJ02hd0tCQEOUz167Jlx4J3NKepDuzZz2a/C8UlnCGjBEn?=
 =?us-ascii?Q?q9nR24kU9E2XvUKqNUTubt/OsQ8tP0newh4TIxRlW3+os4cOLNWhOBJP9MJm?=
 =?us-ascii?Q?/yrtJlzQVqUWNLefhQQ3+oVfnphUCaAJpDqq0elk4VyQ+dwQaYYGtQGbcxYZ?=
 =?us-ascii?Q?ny1dzgBB8UreDMIbTSiglMXGpycp6x9aRNxJDh5YvNrfNV+jjLq3yJzdTWxi?=
 =?us-ascii?Q?kzErvEEMgeDOwXMmmMP3lo6Jajca6AsHUJIwL9G1UUsGmHVOuq2Ppcm/9RGu?=
 =?us-ascii?Q?qD0ei0x+QlnpLUlTyJfEpOD3GlkyhO8KN5OHI4l2C1bedqG9oa4pM4seV5T4?=
 =?us-ascii?Q?zRXlIBaxcDLyFJLntKZAeen8DowXvWbzfg6x7LhX3ZHjfHiJTRM0M8xGtMtF?=
 =?us-ascii?Q?WP5VWGz7HPc+wjR+X+5xCkfI/XG9/9OgzdnZR0vslQ0cKFHiGlr9ekMAqA+7?=
 =?us-ascii?Q?t7Yl2JrY?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fa409f-6262-4e58-1d1d-08db950fdbed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 17:25:54.9757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kk3lQUGtJgSfPw99YI1/z2JsJ1xDxVZsMbg4dh5Tzf5Bl+TACSbHen84/0NQxrv1PfEytzYRepfBpb/I9QDOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
X-Proofpoint-GUID: k_TDXIdTyVB8YBgzfqyvpHGfsbFzmERX
X-Proofpoint-ORIG-GUID: k_TDXIdTyVB8YBgzfqyvpHGfsbFzmERX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_16,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=971 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308040155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Feiyang Chen <chenfeiyang@loongson.cn>
Date: Thu, Aug 03, 2023 at 12:28:02

> Extend stmmac functions and macros for Loongson DWMAC.
> Add LS7A support for dwmac_loongson.
>=20
> v2 -> v3:
> * Avoid macros accessing variables that are not passed to them.
> * Implement a new struct to support 64-bit DMA.
> * Use feature names rather than 'lgmac' and 'dwmac_is_loongson'.

This is still mixing up with HWIF.

As I tried to highlight before, if you are using a custom IP,
you need custom callbacks.=20

As far as I saw, you are mixing dwmac1000_core with
Loongson registers, which is not what I believe is the best approach.

I understand that stmmac is confusing and needs a lot of revamp.
Perhaps we can switch to regmaps first? This way you would have
a lot more flexibility.

Thanks,
Jose

