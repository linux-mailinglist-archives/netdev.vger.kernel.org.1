Return-Path: <netdev+bounces-25481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC18177439E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967FD28179A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E4F171DC;
	Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6214F7C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674B9166A
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQabZOBpE8/1sW9kqNjvkdzOM7v5opgf54ReOM9pZH/Sca+OoCas5Fjk4T3w50LgyeUG2ZzAptJ6xfNgVQBRTex+4gs+9HxSUfbb2S3RVbHm4N1ZvF81jOhkAjkA6QlVIxkyQu2qrXsVuOvk/OnZKzWT3uuI3Q9sIngGNun5brHYsXsx/DqMkFoqiXaEilpMg4nlDGM1tgIIQV8O5c51Ztnv4i80l9zcRxMOZyqda8V0GhcPuHC0z9KxDIzq4CzBwrZyGWcnqSbaHHY6nB4T3gcqDmoUqYNsAX5kDxIR/MnNt/wObfhPdkaREVWiUFk+gRmE95r6Gc4uT98xJ7DjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XOPdMu/adh2rhL09QI3+RGINyj4iPH91b/dRxAxMmo=;
 b=UObGRG2QOhKIRFbjrcbceokEFZimF8ZbztXkBvoYFVj5JaXi43HS2+sFdqLjIxxU/GkGouaI2kOeU5GRKOqTP7E3HZCd2okNLvZQwDbE5eEX+qrqbp273Kkz32UaAS7CA1qy5fjvEMbqSrt7Ur5hisIMKzHDVJSpGmY/2UwwyWIp1wZUienU2Mnhy5JK+B+ysOTG3pzOJQ8OECj0dQy6VWkciLVhMovQ4RrbDMJep/cG2hWPvN6kcDMa4e17DKmRFNXEsCLT7vE6gkIdAToHzyOTQj92XR7ORAGcfJwmHS2Rj1sNlvGEwtYbqgbth0I4JJX06fKxt+AaxIiQ3gQ3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XOPdMu/adh2rhL09QI3+RGINyj4iPH91b/dRxAxMmo=;
 b=aXsnBii5SxBUzKcCAuKNcFkvDxfBfBP34bgxScdo74q877u8Wuix75NCYMKdi3YlJcxuOkr10tgvWr/qoKgmqUOHddllGKARz6e4mhN46oHdoxMp9esQUME2wzAAsvfhQX/ybZQyP9VfxnwsXwBZCfZiEIgt512YIXtBQ1VPXXckeKH7WKJ0W0Jw4pYXcR4Pq+T480/vzAsa7HwbyA0SP/xomsp4HKTtKg/QcAXkbRlVJ1bRqtyek/B14yvacmG8X0tvqzYoSCMS4S/94QtZCuD9hOx00ScRwMeBm50i66XNcC9GBw16aoX3rEPWfsb4T/QCLYWOW6R0CkmBu97Gdg==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 17:45:20 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 17:45:20 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, David Thompson
	<davthompson@nvidia.com>
Subject: RE: [PATCH net v4 1/1] mlxbf_gige: Fix kernel panic at shutdown
Thread-Topic: [PATCH net v4 1/1] mlxbf_gige: Fix kernel panic at shutdown
Thread-Index: AQHZu95yT+g5xckp7kqGosWbtpbJ16/MRF4AgBSDmLA=
Date: Tue, 8 Aug 2023 17:45:19 +0000
Message-ID:
 <CH2PR12MB38952C6DE4FB7856DB426A23D70DA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230721141956.29842-1-asmaa@nvidia.com>
 <20230726092722.649a15ef@kernel.org>
In-Reply-To: <20230726092722.649a15ef@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|DS0PR12MB8070:EE_
x-ms-office365-filtering-correlation-id: d1ac1789-7fce-48a0-0070-08db98373bd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2sy6D4kmfzsUnL6KPICthPOUFWkj2mytpWIas3DcAg8f27VzoWc9isSpE6wUR9RhxB6fikuJBI0g7+CyVHdPd8rMTydnqoD1rP59DHInrPgml6PiytOxTBpZYwLG301Rv7/u3vwkP3UhpXecYtDEmakawnbc3BcGagle4j6hr/KUN0alGnZ0rDP5rYopCHjEEfpYHK7ClKk+RL+1roJ5bG66VmkKeL4RrtRwisrO+gdXs7A9JEOGSObGG7sbxiR5o39jMVyvGt+bYwpnWiVySRfURvQvInMkDWXSrTGFoqI9rJFiLVPfddeh0zEvRO+mmmby8ELk9PMw97ReQKPR0quBowzgfPto8fX+nSVEShaopiHjbS7fzq1RIGRQ3hNv70XlvFaAVGDqm6MDyJaIcX8VMC9yQKZA+5jeYGPbOgMlQBiCpof/QUR3CLwUVgk7ktSCbmY/+hvTQ6Ru17zoDPxlxUlgsJUU2Z+NLEgWcpE7k9Q4Qj+Uy4ib7QlGinUVyoP8j24xgJdBaPbjq7oaCuePndNB0DYvlZ9h0eovBKC+yklc4XxfpFWcPQZvwChKXfeWmlbA3rw7kIflyCnviS3Ru4FCyfmbXVP5/w9/DF27W6P1JhTi++DlLm9hBUn8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(1800799003)(186006)(55016003)(4326008)(9686003)(6916009)(316002)(86362001)(122000001)(54906003)(76116006)(38100700002)(66946007)(478600001)(71200400001)(66446008)(66556008)(33656002)(66476007)(7696005)(64756008)(6506007)(26005)(107886003)(52536014)(38070700005)(8676002)(8936002)(41300700001)(4744005)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uyv171Q5RotRQS7LZ98B9Mr2fuEhcPtkdp4FXD4qYrIBFtPxEVztPVfbrxn2?=
 =?us-ascii?Q?CoOCKVn7QKTcd7DqiR5e/mmUxT0uL4xJ3QpAOvso+Jusr0Hic7k5UvPdgp4A?=
 =?us-ascii?Q?daee2NHK7OiRv8ZqIxStbuIJUaFC7jqDABys/UxQ4ZZWDX5JYeFmsB0saMBq?=
 =?us-ascii?Q?hodmkrknW02kgdo7vvXAlAgStfd6exCtGCwmPH9PfIiLvj7h7OpgLrDcQ3wz?=
 =?us-ascii?Q?O3Yn0gD4KCh0rrsHAVcp2u+hZ1Rg/MlA9u8/tPUDMDFBaP2n+VNyAqHdLv6M?=
 =?us-ascii?Q?xq5OoArE9yrUvYG9n5Jh+jeuylTlTL9pZ5lD5MqoEjoiHugceqE799sI4L2x?=
 =?us-ascii?Q?EgwLVk2AXM1gl2LZ77sbTKLW2IwVrrQyWdXpNf14N0OVrLAZ2ZC24GWBtgBh?=
 =?us-ascii?Q?GZ/f3bxEfzDLiNqBA7LGlvytseKfA+SENed5MTjwDsjh37OWNG7UFyijTyYT?=
 =?us-ascii?Q?ofNGPdNi0cfpMN0+00/eIycTLuKF4dofcUOtlTWrHRMhL6OR5UMALETU9dpG?=
 =?us-ascii?Q?MTou+zOkEZQ6P2Hxz+kFFCaWGyc1+8ln3i8gqIbt5v6BbcamHtdcJIDdSe6w?=
 =?us-ascii?Q?nwguijxrCrPdpyQXvD16d+jczXpGJOLyPlie/IZWBpCEl5/wMJuQrZPjVqRb?=
 =?us-ascii?Q?WcjqHe9SO2uXGrLG/k0u0zh5UYaddfVK4jjj2Cxlarc5EGURN1WXAYd9F19Z?=
 =?us-ascii?Q?xV84xou1oRvEuIWJxPhUDb/EtH0S35WW6z6VejUTry9xGdYfFQA7aVX2Li3t?=
 =?us-ascii?Q?bxejgEZ45Bs8QY3x8r9Do9MTXBBLBkCA6m9E1r4r75jXphB3QBHbkmr7VMh/?=
 =?us-ascii?Q?FiOwoquPoS5z59iMpGItO/9fI5BLasCiIsh6p+wHmwe0Nf8ocwfoq32zzUtP?=
 =?us-ascii?Q?crdzLJOFf9xkFQe6vIdtv/qvs9LYg+jaJSlmcubmBx6AcB9M9irZVYaWhoI0?=
 =?us-ascii?Q?+lUkh4fTEYeQZP1W1N4ek+dDeudLge61lAvDoeI6LXofeo4FE4fQh+HMleKt?=
 =?us-ascii?Q?Vh38U5zjYWPakeeapZf5SfLrqAmeco/D/dJNvAx6aTAVvSdXr3nsGkdONRYd?=
 =?us-ascii?Q?m0LXuayAUNgROdynFwuHEKq9e1OOlZOl/cCW6fXXWfcyI+2fagwgobM9fH7f?=
 =?us-ascii?Q?ja+8tpsVoLiVfbRPRrJAAH01AxDouGaueZp/wemUskMQ7pjt87qArzjJu8/2?=
 =?us-ascii?Q?g0GGZ1y4HI1lo6J6D0dQUxvED5bmQFW2VdJ1JTpxS00LYWKgF8G+tOAa3mkN?=
 =?us-ascii?Q?PsghzwpUwYXVN4XtK8DuA96P+CAfJYcaweMCnUlJDqGbmSrPiKqEdkoIC8KC?=
 =?us-ascii?Q?qqcHFOw4zkJ3kkKN82wkGtipbhV5/42UEq1GD3LzAe3ITd/WGJjJ7iriJbxP?=
 =?us-ascii?Q?LJZmrihhlSxJJLPtGQ8qrnFU+OPoDT3xhhdf+MBt/eog/EJoVZTGy+AgItoG?=
 =?us-ascii?Q?YqR7bgt+5+mefUOZyrGdk09PyfxQzeAa+K1lUUGdwKPXei7kIYbLC5wQrWcn?=
 =?us-ascii?Q?rXRKOkMKCUsgTUKYv44YbeX6OIknqIucDNmLqgP1Fp7DC9QQHR29UAwXLzYy?=
 =?us-ascii?Q?sGz5v/7xeZ31arR1VaI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ac1789-7fce-48a0-0070-08db98373bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 17:45:19.7363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YajsxwZDGiPcefuXnxORxZjZFWqWersx7zXYJAGnJGNohHTE57h4hlmPSAGSc6pzElRCQryWDFsKeiiAFvy9SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> > Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
>=20
> Asmaa, you need to reply to Vladimir, I'm dropping this patch :(
> --
Hi Jakub,
=20
Apologies for the delay. Actually this worked out for the best, because thi=
s change caused another issue on our systems.=20
I will submit a different patch once I test it more thoroughly and will att=
ach the panic as requested previously.

Thanks again for your help and feedback.
Asmaa

