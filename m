Return-Path: <netdev+bounces-21826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BA764E79
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6401C211BE
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4379F9FA;
	Thu, 27 Jul 2023 09:03:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B7C2CE
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:03:07 +0000 (UTC)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CB9449C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 02:03:05 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R4VkT8002905;
	Thu, 27 Jul 2023 02:02:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=WSmhuup3by9fuNM+XcZ77PVMNrnwnBskYNO/bJWuDXw=;
 b=UhjIjAlnVnTFmbQCDDp5sCYcKw6iOqcbjQu439830oI2zl8gxe1jabVGW9DyGH8pruMe
 tdceYObyYd25NbVWd7asIs5BvBuDxbaPCSDix3eRKZslyjlDnontaji4ka0JET78lYog
 MoLNdozVCFVcveQvEyiN6GrZbOH2piJEWCIWyRwnvx6sXZWnTqfAo80J7MvWzPMVqutX
 TrGP3p94zlkKgXoM/FAvfJdFXejfCzQQTrByzbJxYGxdmFTggRqZQ72xkeosMz14jSow
 A3yhggWzGtJ/3HO4dFV/9DiEndG1o2uXAmsjQpiaGwpYpuYEzX53rQwsqU2Q/9t6Agpk lw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s0e1ufjep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jul 2023 02:02:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1690448547; bh=HdGB2zGzfh0IpvpDzKSeoLQdD/Iq1SiRSxO+kc9hsFM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=W6fvnvB4MgeJj4g0ANFoYe8Z1hUCfjnIrIvWrFMUwLReHTpBY5acq5BOboPo0T3IE
	 RSXxSNph8Z85lkllkt9DQoETdmkus1VjhXV+lkI5k6Rn8l9gm2FNw9/cTD80NcpL0s
	 d0UYe6y3VrOdjGUSrROTznEcWeSpH4r1UiigNNqL6i9EinoH66jCetpBp5aSsXSEDv
	 eRu6fzIhq1BmnzZJcQ2YPC2rcblTR2jACyGe7a/yJ9cb2e1DgpLU3fscfvM/3N/po1
	 oES5jxvqb3keLhxg9t+KgRKZql0erit/mUzRiyoAppDmbiTsFHBMZjazLf6t9mjjdR
	 iKY3QQNbQtyTw==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3321940644;
	Thu, 27 Jul 2023 09:02:24 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CDC24A0079;
	Thu, 27 Jul 2023 09:02:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=iUq8L41k;
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7712A405D8;
	Thu, 27 Jul 2023 09:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/9ClNCz1Vz/a27asD00m19pFX+ONo8qT0VXD5XQogkj38yiHVDBw6AEWf8ufwag4cXZum5CZgGpgrsrgYWeFRPlpWxfbqNPaytlK1cZdwSxqEoHzTAayJSUiELiMqEBjZLVfps+sSZ7Fmo5xs5ZW/2qXypfHx5/zEPC8iz/8YNDwHlT1YFniteO49FqPrJRswwov+AakyNpR/zANz2rp3oWQ3fM4Gpmv6ZcfXTWe2kxNmVf8trrM0Vg5sDrBjCVOPH8Dciob+jBUkvRtF5iYtaL+hGrnxJFwzSpcp5RYRQjuFTZvftHuM58IaFzBu5XYBdPRF7TtknAUWZQuX13zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSmhuup3by9fuNM+XcZ77PVMNrnwnBskYNO/bJWuDXw=;
 b=bSvLT2k8O3CNz3xa6V2Lx/DlZ2DxkpqbgbiXPXez0E8AMM0oZ8j2hJj6LEO22L1q0FyyfK7Q2nzbHtpHRvIhbnqF2XRD3chLSM+rdFIfVvXqs4RsIWxKWX2MlCeNTYn0KmL84AjUNhSCP6C5zxubBZEWrv1HA6t+OjH3+dNieCp6xU+s4seSUTvZj2OA8cd9FRIPEI8EbdxzKIMmmKsTIu3R4RP3FlB8f37g6MgT9RsDIdB5SegdVumolQ/DKH5VdO6fOt+R8RmXmE7TnK/m5ynWR3OiZrKVPOEmrLGk00dIyXT2ivbwuWB8AFTd12mh42aGT3ntvH4OHS9mbVWcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSmhuup3by9fuNM+XcZ77PVMNrnwnBskYNO/bJWuDXw=;
 b=iUq8L41kwCQxoPijOvHvrarWvN4eTeWys0kWCG0CZXpCOb+lLjcJLvx9vNLS3fPZ4FlUXKeks59qFOUiyTEHZRqxxKB2SXevygYLjHSGcsx6+USVdZ/C0OzMmMXfHcwZy6UUvMfGxYyB+n8N/DlN9i4rB7n2EbjoNnbn/LXuvWA=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 09:02:12 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 09:02:12 +0000
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
Subject: RE: [PATCH v2 00/10] stmmac: Add Loongson platform support
Thread-Topic: [PATCH v2 00/10] stmmac: Add Loongson platform support
Thread-Index: AQHZwFo/VQkfX2vpMUGx5hHuTWlBma/NUK3Q
Date: Thu, 27 Jul 2023 09:02:12 +0000
Message-ID: 
 <DM4PR12MB50880AA9F0C93F86B0A7A308D301A@DM4PR12MB5088.namprd12.prod.outlook.com>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
In-Reply-To: <cover.1690439335.git.chenfeiyang@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTQ0ZTVhZmUxLTJjNWMtMTFlZS04NjJkLTNjMjE5?=
 =?us-ascii?Q?Y2RkNzFiNFxhbWUtdGVzdFw0NGU1YWZlMy0yYzVjLTExZWUtODYyZC0zYzIx?=
 =?us-ascii?Q?OWNkZDcxYjRib2R5LnR4dCIgc3o9IjEyMjkiIHQ9IjEzMzM0OTIyMTMwOTY4?=
 =?us-ascii?Q?MDU3NCIgaD0iZzlPY0hTVklqTm5zUmtyR245U25xVnpSNDJRPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBSFlJQUFD?=
 =?us-ascii?Q?K0N6MEhhY0RaQVk2WHhpZGdYMTNRanBmR0oyQmZYZEFOQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQUdDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFGVmFXcEFBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
 =?us-ascii?Q?QmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2tBYmdCbkFGOEFkd0JoQUhR?=
 =?us-ascii?Q?QVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BWVFCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QnRB?=
 =?us-ascii?Q?R2tBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZ?=
 =?us-ascii?Q?QWJ3QjFBRzRBWkFCeUFIa0FYd0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6?=
 =?us-ascii?Q?QUhRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElB?=
 =?us-ascii?Q?ZVFCZkFIQUFZUUJ5QUhRQWJnQmxBSElBY3dCZkFIUUFjd0J0QUdNQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCbUFHOEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFk?=
 =?us-ascii?Q?QUJ1QUdVQWNnQnpBRjhBZFFCdEFHTUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R2NBZEFCekFGOEFjQUJ5QUc4QVpBQjFBR01BZEFCZkFIUUFjZ0JoQUdrQWJn?=
 =?us-ascii?Q?QnBBRzRBWndBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3QmhBR3dBWlFCekFG?=
 =?us-ascii?Q?OEFZUUJqQUdNQWJ3QjFBRzRBZEFCZkFIQUFiQUJoQUc0QUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUdFQWJBQmxB?=
 =?us-ascii?Q?SE1BWHdCeEFIVUFid0IwQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFITUFiZ0J3QUhNQVh3QnNBR2tBWXdCbEFH?=
 =?us-ascii?Q?NEFjd0JsQUY4QWRBQmxBSElBYlFCZkFERUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VBYmdCekFHVUFYd0IwQUdV?=
 =?us-ascii?Q?QWNnQnRBRjhBY3dCMEFIVUFaQUJsQUc0QWRBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQjJBR2NBWHdC?=
 =?us-ascii?Q?ckFHVUFlUUIzQUc4QWNnQmtBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|IA0PR12MB8974:EE_
x-ms-office365-filtering-correlation-id: df653fd1-f0db-4370-8d0c-08db8e802a94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WSwW4obMrA9FGHlrx46RpxMLUL3HfhIQFglrMmCE4CHODZTfak5uBgub/6ngBTh8wSsbNFv7cBry2YiTAlFhEe778YH1KxvNqH1ikCPBWH0lwsV6Phr65T8nAzhygq+B3hjo0E62ARNZn9OupJ73yAtais7+TLQrMcmrttF9g3XogzHOr89DGBl0eltuHzaV7G3691fD7MB7X0tfcS8bstulzc45NaZ0rINIHkqvb7qeAJQgF2t9jdhEUVib//wKJH387fMTPvlx2yu4E9wEKU8SwH5z90K35Amih6FQTN86wnnMbLud7g6AinNW83FMEC3QrHW54XUDbZQuQxoMi/tE9af7DN8PtQ68bSLBZ/tKDJlveOZ42JPJq4f1bINGrq+lsCf0xf83ALiZmMqUd7phyLYKfGWn6xGF3J1wuCCUpqY4YDtSmIYn84hcf7To4c29chyHRqRrNWOx82MotYu6KTdiCddzPLUPT6wXn+45pLxMelLGfFHfQvz60rajo0ruezlIrtMYNr+G+Nt2M1ZuDlovWke37SuOPDaWIIbLfh9ngpT7him/e0bgM5H0PyaI/zoB/ZcjC68WCY3DU8fpaYML3aBWu7ijJ/QnJ1dejWE9jbne6velK8yjkv7o
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(76116006)(66446008)(64756008)(66556008)(66476007)(122000001)(478600001)(38100700002)(54906003)(55016003)(110136005)(4326008)(9686003)(71200400001)(7696005)(8936002)(5660300002)(8676002)(33656002)(2906002)(86362001)(6506007)(26005)(107886003)(66946007)(38070700005)(186003)(52536014)(7416002)(316002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?I1IbeFzmrKC6Jd7yv0/PrTRecPr4niP7lsRO/EPuOBM7reYq/YeDK0zum8RU?=
 =?us-ascii?Q?FXiovbJlwEFebKbBlt1iU/P0BU5ZoLRztCAsDTuOw+dixE1Hmp3Vumi50Mrx?=
 =?us-ascii?Q?SVceDnrckWrgjuVLChA0NoLzWSOnuR4RAL/9fEt76gT7lOHUkV3yh5t/UeoU?=
 =?us-ascii?Q?Jw850czeMhe6hVFOUafJNpTmOVMMSrA2cNfUtDAb+CcaCTgKdRN3WOMpC3Av?=
 =?us-ascii?Q?eOxos2hOtIzjYCgo3PLRzCfOgjVvdLwfcA5Avw6ZBZEc5eJW5CxHyDSIdFoO?=
 =?us-ascii?Q?hD7TL/TUQy2SmiszuBC5tBA1+1GqGDwL7289qVmzPnfJFX0pcUkp7Qml7Knz?=
 =?us-ascii?Q?NRvTAwPbbZZ85rff/gMK9NEAeMFx6k76esXBJS26z2qEGw7AcrR3h+rKHjVc?=
 =?us-ascii?Q?BDMnyTdy+c84HqZc9U3rSvN3derevndPqXrDUyt/e2R4wHJVosl3FuV3U/tA?=
 =?us-ascii?Q?j81VwfYnBqhJ4JIkoDfEVTQrStV90u1ChPGhjYyQcR/c/KhFzS/8342/o4VV?=
 =?us-ascii?Q?OLAzQzSwI9d/YFl9cfsj7O4Z+YDWQPV1I9TgA5nL2Lpe57hZXnnCx9bo4d6d?=
 =?us-ascii?Q?QqqUIqpFgpcW5I1sMzJa+86XeyUw39Unuhs3IaCVcx0ZKfv1N4/KL/YVaLV6?=
 =?us-ascii?Q?JwPH7XN1QbU7iA12xXKH8B6E/CT+2+mmZAVhgILUoSTRx/5AHxb21+hsjWpp?=
 =?us-ascii?Q?mebFuHF9fSvlk5XpTQeGnkat2yPyC4Pt8xC+400SUDy20PJKxAN/hlAaeiro?=
 =?us-ascii?Q?rjZ7g60Rugd4fbKJlcFnnIYyr4F1VzNNAtLo+osUpWdiE33nRm+5/+RuA2I7?=
 =?us-ascii?Q?iCvBnHywZV4zTunMe78xulJJ2ZybziBO114/N+EXrntHsOz8ZNpK28bnPOhZ?=
 =?us-ascii?Q?3k33qsuVmfVk9WWVTZ2dTRUCIuqqEUqQFLHY+CbhPByQR0D542F9Z38Kmgj4?=
 =?us-ascii?Q?hozZMYzuVXM1h4MKbuQuFlioMBTE4e6UH5itYDBNas0319+7CkqZV3nJY4Bo?=
 =?us-ascii?Q?vQo8dt5PGizgCvB2eOvxh7MKCA5G+4QdBzR0bW9EqjtEJZacPteALjKW8PAf?=
 =?us-ascii?Q?aPjT6oicGvY9V8Sao3Q0ncGTkzE0UpEHIS+MVrWdhHTNt/qDIfeSNYHUtiLL?=
 =?us-ascii?Q?xgEMLN29HOUYmkLA917r6MY4hxD6WFbwrgySjJep+6UG1H3bNOugMJEVyyNa?=
 =?us-ascii?Q?LhM5pqsO7P8L3TxyTdYwfIzBpahXzoT+1H4Vr0hiZ0GzBqRzCdlcYFjcE8NH?=
 =?us-ascii?Q?MDWPbfCbaOr5lcIbjywRA5lynXnMSsNiSjT8HpSteApBdCY4ggw44g7qIF4k?=
 =?us-ascii?Q?scFphSQInwklWDBvErtqa6RrP0OjCxcC3bDgIrOvG6Y3MNwq04L1K6A62b6Y?=
 =?us-ascii?Q?XzBKHehvWsqESBExwfdfrv3jOhrX/GC4XBRbo/zaSUdV06Dr41cDbbXnUq/W?=
 =?us-ascii?Q?w7QYozEa3YW4IjL5GEAMCWo0AhwmqP0FCtZ8oEWaZzVbD0Op0E/HbhB+LDdQ?=
 =?us-ascii?Q?8APcNzBuFy2oor5qlHHErLfK+rjykAbrKW5HF7Z/RomYEStpzx7+Q6oaihyH?=
 =?us-ascii?Q?tlRNvn90fP17fzRpSY7lqHQzu1bRVcI5WIfbfBaa?=
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
	=?us-ascii?Q?NRF7ftHK/p3Dz4YpCuHelFBiEvxP6NHEe49GAM/qKUIoX9QYjRbJm1hg/Gnn?=
 =?us-ascii?Q?Qh68MR7TMOX5yUTrWU2qfNa3aLindLBdoS63ampr2O2QUY03FMTBM0PdbeTe?=
 =?us-ascii?Q?BGaUWIV01DhzJ0R46HOZ3Mjl4/j6QMEmGqXOx3Ol59009twkvKwLlEQTRKep?=
 =?us-ascii?Q?Duw/+iK/64JLC+xMuaP3z30MOMYd45j5iKrkSPwmDdo4t0tUSihrQiWW1PIR?=
 =?us-ascii?Q?qMNmUw76C2Es5oLpUhCbT+tiiG8kOP5L3Oicde2wEGoVq8Bka1uzPstNbQc8?=
 =?us-ascii?Q?j+CYgN4qHOkY+mLHQ0y1D7PEQvL9pPzQM8ijo8bR6WbavTWFG1G+6nlYCUSN?=
 =?us-ascii?Q?3Pe1vrb69djZvjTeY3kLlctIIGwTYg5bIVpleRfN34/jwX7RxdmFDudzIUJ1?=
 =?us-ascii?Q?P5Wf5mWwYevPtmcj3in6qmLS6HRyfWtD9t7X3YdnVHk0Dq2TWUdCpErNmxPF?=
 =?us-ascii?Q?jRJR3JJqAnUzU4UHn+N/Zrk1srEJNyqfd445klGedwYpcQgAupSpH05eRcJw?=
 =?us-ascii?Q?PALt4a/NUDJpURLyu2SUCZGVE30kflYZwCq95xIaaQJMRVy2hQN/X081xV7f?=
 =?us-ascii?Q?lqF05D/DGbSwjs72wQUFpdJwa4sP1492tEweBQ1qa3C/SiGzhzkPnMTo3BWI?=
 =?us-ascii?Q?dDdN2jgVSsqu0SILwpkBjy92LodA/sJjfrh+nXFZ8IO8RPIreV5z8jgjYTbD?=
 =?us-ascii?Q?Jx/lmBaYjqgxDKXqE5MzcNMg5HsZxGg1+/YNjz31/3Sss9AHSlpIMy9N4bI2?=
 =?us-ascii?Q?mbu3qaFqK96MZqW0reOVa2O70ErV23rd/jTtGpvr+3Put1yDNZ3I7L52Ce2X?=
 =?us-ascii?Q?LNYdVgOBdJ2RTSP2KkHA7xhYMb032pK5U2CT9y4aumz00NCfYEKc3DNYVgSI?=
 =?us-ascii?Q?ErJSUkuNMA5AnVIX+CwsOyzayAUfoWz3dbBOvqmXs4RUv7/myAekNC8bRACA?=
 =?us-ascii?Q?11Ir/2xQJ4RVJco9aUixeyIgijYQwFpX+kl+lgRk5/ddbe+WRHaDJgk6lrGD?=
 =?us-ascii?Q?ohVJ5AvBHwM1zuA3mOiu66/KPKn1zTWDAz0ir41ruKzTX3ywgTs/H/DL5qvu?=
 =?us-ascii?Q?RsKOlAJl?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df653fd1-f0db-4370-8d0c-08db8e802a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 09:02:12.4175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsQ4oDvFPqRYnc54BzxymM8EkV/vqxG40CkjE0dzaRvFuGEv5yG2OWLw2+Yk529uEHEoHzMkhAl2ykhI+BAdGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974
X-Proofpoint-ORIG-GUID: n5A57jbbbCnf95dhNphLv28MWtMF5VZC
X-Proofpoint-GUID: n5A57jbbbCnf95dhNphLv28MWtMF5VZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=807 suspectscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Feiyang Chen <chenfeiyang@loongson.cn>
Date: Thu, Jul 27, 2023 at 08:15:44

> Extend stmmac functions and macros for Loongson DWMAC.
> Add LS7A support for dwmac_loongson.
>=20
> Feiyang Chen (10):
>   net: stmmac: Pass stmmac_priv and chan in some callbacks
>   net: stmmac: dwmac1000: Allow platforms to choose some register
>     offsets
>   net: stmmac: dwmac1000: Add multi-channel support
>   net: stmmac: dwmac1000: Add 64-bit DMA support
>   net: stmmac: dwmac1000: Add Loongson register definitions
>   net: stmmac: Add Loongson HWIF entry
>   net: stmmac: dwmac-loongson: Add LS7A support
>   net: stmmac: dwmac-loongson: Disable flow control for GMAC
>   net: stmmac: dwmac-loongson: Add 64-bit DMA and multi-vector support
>   net: stmmac: dwmac-loongson: Add GNET support

I took a quick look at your patches and I'm thinking whether this is the co=
rrect way to go.
You are mixing up the stmmac generic layer by adding the Loongson HWIF entr=
y.
The whole idea of HWIF was to have it independent of vendor specific logic.

Can you devise another alternative without mixing up the HWIF?

Thanks,
Jose

