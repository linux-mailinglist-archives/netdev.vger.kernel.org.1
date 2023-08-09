Return-Path: <netdev+bounces-25848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A1775FF5
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87490281C56
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AD118AE4;
	Wed,  9 Aug 2023 12:57:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562158BE0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:57:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774D1FF6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv+ZajkctAuW+pbz8fzYaW1SKBmt4Dt1lxVqNroKdUW3IOgrz3EfvXH/u2hNZ+vLcn2XGQEaeOprxnBaAoBX9KMjmBXln2Zl31PQMlhhr196eBKYStgwG7KHG+sUxbkyatfhJxDyj8kMiakMY4Lw82ExNmpgzEEbxawSy/PcK7DVPqgO4D5r6hBJXOyhYK+X/M+2PzJux+x0dCoh0qHWvOWbCvtAus/WNc7P1R2xoVPXuI4NDFeQZgrfYHL5lTYwPv32Hk2/x7oPDFwujc6Wf1uKsAojCH2GsBd1mIopUfmMD3hYTO0BefMyJApiQ/H+wKaeiMcU/9pRDpm5kjEAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWhmSsSYnggHOjl8e7urbm8kxY33wYvvct/ADaj40o4=;
 b=NV8g5OwnUC2ECUAMpZj3MeGlfnfjJbkZbK5asZrWpUlSz7lITfhPKGfox7pGCZBU0fBOIBk/r15vxK9NHlEPkh94kybp0qAMMeQO7p6RriVYd+gIwbC3RFMblDNoHT6jo+0q8oz+iAj18nocqhJkisqkouMxl9GO46XQUBcRnNTEEaQY1hniTjWX1Dl4BcsdAOuLGJesbSk+SxryEGAWMKQ1E/2oyQaIhcwR+kT0dYl6qAC4lWzMLKM5k1jvbmBK6XSpF1V9Bi8yfaEoLYfJLSoaUzmpTVrCQAiaqSapBPSmGUtYEfns9E8V0QY7gA+b4rl4Oj1tJyKqwYywEVgLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWhmSsSYnggHOjl8e7urbm8kxY33wYvvct/ADaj40o4=;
 b=o88iV+wC2CMf76L+6keaFzAbrr7RB5Ph2m3GyIELXv0fKAl7agtF21P5Htr53bfF4GJsr22Bvs+dpPAOOpdM6N7G2VaOFm6HDhww5fAFQeHok5d1pDZUpgj8hK3zmHJ1fYyzkCqReeRzd4p+HQbIxpuv0jFH1sPmdWTiSgTnv+l0qxhBGhx5cIy/q5N70wW3XH3l/BWoVs+v4FHFavUG/oDkQGp/qDYv5K4XYqcqsEpitXS+e9DDqLap9HnKVvkDMAayKrMjafRhVMvW2zGM1WfjBcn+xEEW9xFJGSIOCcVQsIGB6lwemakmoxSr80E79JUq/fdA29cBcND0lvt2DQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 12:57:02 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 12:57:02 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Simon Horman <horms@kernel.org>, Yue Haibing <yuehaibing@huawei.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, David Thompson
	<davthompson@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] mlxbf_gige: Remove two unused function
 declarations
Thread-Topic: [PATCH net-next] mlxbf_gige: Remove two unused function
 declarations
Thread-Index: AQHZyggFfIkB/45hIkSDICsiNzmJVa/h6rkAgAADE0A=
Date: Wed, 9 Aug 2023 12:57:02 +0000
Message-ID:
 <CH2PR12MB38958C27976F334D42023CCED712A@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230808145249.41596-1-yuehaibing@huawei.com>
 <ZNOKcA6flZf7Fuxv@vergenet.net>
In-Reply-To: <ZNOKcA6flZf7Fuxv@vergenet.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|BL3PR12MB6475:EE_
x-ms-office365-filtering-correlation-id: 5cbd53f6-6ffa-498b-a411-08db98d82047
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Crpc4ZpcS9xrifFxJVB2Q8zuCammy1QxYFkA2Oe6VxdLAsKMPRyX+6tt+/QS91D0eqxJuUgNiDXG6iOIaxzrA4MFHS1DWI9hyK/I3Z+2YLM5+3gHjSprW/t/gjRWVvqHJrysg7bwTRTWsv7lgrOS4PeCyzPksKO0aaYy33BjUN138mt1h6TZ+JlHzhvx/HQPz3UCrLiAIOoYmC9KELIczJOBE3l+ooCvVSXj/qimpytjQi/ltVN82B/SgAB96tY8fH4OYB0jlM5jSoPiqeA0reIdQnTIjrohntn2bDGhdAF1lqKFB6ZNO3PbetJPMh6KPrU2VqkJt7wkvl0p2g1Lcppw4W/Pc2ILl3PNy9S72n6kyMJTHS2jitZYGF/PoyoSqY8k8dbzoFzVtV9AS1HNG4P+W+s+bryfNFUFcdMSG6qAcLvq/WKlVQgVv6lRETJMIWxbBWYk0vKhTfL/J8oeDWWEdc+ZhTG3+EVYgXxIEy5Zu55uNh65xTay2CYxAuqqBQbsdZHUXpZq2jgJ7hvUOl8N12bwDRxOWjFMu+R3k16I/b9ehlgxmmZBjQwYsxepn15+Rpc/DBy6E/ONwgV8iSHhNMoY+PIA0eLn8VD7w7ZbxXtnUr0qai3Sl+dL+wc+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(1800799006)(186006)(9686003)(55016003)(26005)(6506007)(110136005)(54906003)(38100700002)(558084003)(5660300002)(52536014)(38070700005)(86362001)(2906002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(33656002)(8676002)(8936002)(41300700001)(316002)(71200400001)(7696005)(122000001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UWzD0paxIOaED9KVMltjwDR1+bnJuBqSYetNlSTnCyatqeWcfdYO7Gu4Pzo2?=
 =?us-ascii?Q?Jju+7+PK0ZyvJHtb+tjF7c9MPMiYh+KDqOkI1EyjAbJ8Oft2oS5X7wL68R6o?=
 =?us-ascii?Q?4QG/4XyFE5K8+oXu4GkumwxNNTC6RoB/4ky+EDyGq7QCWRyRIe2iW3/+RlGp?=
 =?us-ascii?Q?/oYElbU2+4/zy588mgqZeYhFOVTzSVZXmoV7gheYvdv3W92fD0yrtOEWC/m3?=
 =?us-ascii?Q?uHEo9qhLfU/IZ4Yda9o4tH9vWpx9tVLeaH6X54KD0yf+U3D6BqicrsHQx4Qy?=
 =?us-ascii?Q?3Hfhc5x2vsgYvpQk0xDexRybKMn/kmGMJeCR5T/ghocFsZnZ5czIszk8SZw7?=
 =?us-ascii?Q?u+TEHAIjYQAh5D76OTy0gHA1hZjFbXpMvUPhYge88tAH89R6OkZm0MYr5Rmg?=
 =?us-ascii?Q?58Eo//s2bFK5TlcunFIbYVFvAYP2hi6V9TnljDvOzEqZWd1dPKjR1CyCMUOZ?=
 =?us-ascii?Q?OmfRyHTtRGdCUJYnc/NDgBxrcDEmmIFyt9qocCroAMKXgFYwINEmMMIgf1eq?=
 =?us-ascii?Q?0QfJynqCUqGCya4EZpy7y5jm1eL7GTxn5TEmPYfanL9p1r2QUKufEv+GYiCC?=
 =?us-ascii?Q?nLEakDn93SaGeodkVWB1I9DfVh6MqMLOxFicRgzYtMydJeXIGcOQL/f5IATz?=
 =?us-ascii?Q?yIaLmdkhAwMcbV8fbhrI/j75KCfb4JlY+cIVsoNQmTzWqVARfCOjsH0KRFFx?=
 =?us-ascii?Q?nHvzrDr+hD2I1MYqQd0QsFk1mqjZ9Us8sZcekFWAAxD172i+14E4zgKZkPwP?=
 =?us-ascii?Q?1ogLLAoQ9OrM0Z8JHg4NXt/LV1tMoTpuSPRN56fbg4IaZn8N4FV3ifg/+sVn?=
 =?us-ascii?Q?b/4s4D6y4mISnwuaOzWxiIMgHpsKIx/DkpcirZHJUSqY2Vp2yHoftZSzNut3?=
 =?us-ascii?Q?x1AZrsHMcV1B5a9PtKFGL9y/Mz1CxfE0S7g6CIj+IFaYkwMoZJzNCTYpDY4x?=
 =?us-ascii?Q?PwKINKjJwJh8mbuh6dYeYhw5rTe5U1FQWKKsCEDz1twnDdZKth5gba0WXZ70?=
 =?us-ascii?Q?8/XfZ3sfGPXRIzzwyuvs9TqNOcFkl/NtJfYr64m0psyod5PfI5HHQiULpiVS?=
 =?us-ascii?Q?D798Ix2LEbdAtoKClpAlLNciV2DJokmIshOxuMqu2+BDxKYOqFrS9zhPNpTs?=
 =?us-ascii?Q?QrZOkNW+vjt+Vasejkr8r1lxobI1DkcIPq+WKleU//NxjaX5/4G2G5SIQ/ak?=
 =?us-ascii?Q?N8s2k8ci5mUrE3o2HBIrSQ0NlJM0duRXusyhFbO18lhHRrW+dhDDh76OOfCk?=
 =?us-ascii?Q?SmRDb8EdzRvGM1iixC72iWwVwp3JOtnwbnTYdLaIcx4veIkILAQiq8T7CZAb?=
 =?us-ascii?Q?V7SmrmQ5y8qt0qIzrRIdLpEagBJ2jBaMZ017+oaRG3hXrxHc6Buz7d/hwnW5?=
 =?us-ascii?Q?gSb0DynTjwUUlhf2di1pXveYXrCeu6un3eqJQRrbgfuGZ5USmgWDTErSRN9Q?=
 =?us-ascii?Q?E9LiJSk7HkP29wwsGq5RXpcyIgGWIyBcHSDSU0AMpTY/HmRPkhRddSZKLPtG?=
 =?us-ascii?Q?i58gjjcVBgF1zTlVHBnycbbCLTcbaIEI+3yVvmY/h3cUkSSFdMjvJdlGni2F?=
 =?us-ascii?Q?uu6U++5y0LVVoK9e5no=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbd53f6-6ffa-498b-a411-08db98d82047
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 12:57:02.4915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYATGqbaJkbG2XjNu8f2D6uW9yGFkzfsdCWKbCniBgeTxmENsnBzC0ix2xR8Uiqn9UcFBQ+pYF1bknFKzmKABw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Tue, Aug 08, 2023 at 10:52:49PM +0800, Yue Haibing wrote:
> > Commit f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> > declared but never implemented these.
> >
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>

