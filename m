Return-Path: <netdev+bounces-19654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F3575B961
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F521C21497
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF3168B6;
	Thu, 20 Jul 2023 21:11:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B47818B18
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:11:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75DF2733
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln+nDaA5sX/EqWA3gx61R8tgDmIA3jk9u2DKIOzVNMpnsJL1J6pJAV8kIMui3V8PTbPlFR/uRvzLpF+2XVlYcwezfHnHbgE8i/T20SfCUeyQqnBtyJtIpEEty9XaKefHJa26A4Q8b1EE7N0Mqo4dbe5hj5DC7eZBhEemqYp6DGc4YxWucLoaWY6cgnu7rfu0wRpK9uXW0PcT25Hn3EwHK6l3K8nAExc+uNl4KxeLWFyPGDCQ4iQTL3+kDpoO/qZPWlRzD+Tqg4+eXFC7O4S9Q3CS93TEpQM3+C389ALWtm0ZXNEya0r7vGaGspZBiNa2xUnrPW2FTqYy+vlPoeNjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSCLMv76+/iQ8/X4g1XgUNw8eLUr38q2oDeGsxIm0+c=;
 b=ncoCr8mthLTuYXdEj31H4pux3YzXj7FKf0kRPnhmGfiZ9Q5pFF9D+YeFqxzbv+Q/QamKa55PMew4bux3nQd1i967NHTUci+o4jTBLTyVIXa2qD8YYgZW4uLHl8dlmJ1Q6WnmZ93z+XzQv7rcBRy4nKag/P3m2aQq7gxE2HcMr9H1P994CFWtVtK4rQUk103J8B81nW9MhiLyK++dR7yGcrvNKwofoe9k6rgtmyQz0op/dzh35ZifYJPcBnvhggMVfUFmCSEnyaMzTLDtkt3x5DkYAmLKYOHWFoayTPYXaZc/20uLvnz63VPdWFByM6LsDoHu0IaP7t7OWVsLvMDBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSCLMv76+/iQ8/X4g1XgUNw8eLUr38q2oDeGsxIm0+c=;
 b=tsl4vBER9UEKS/VMCinTw/1ldFVEnLrNkCjt3vIhnZoiy4Ej/oEldQO786J2YIYIRUb7p5cSBhBONCo2NCEj7M2dKlprDzoGZjnH2Sn5p7fRyTRD7bKy7xdLa1iXq4X077QICXQ6o/fC0e2xKrX6v8D5SJ7vxP4cD2LfYIrTrmJnG9F5sCzDOTlpDwct2zpErLgts1UsGT7J1VHAJgmGGQNEOeEdrO8JGqV4DfLfVSCSZy93OMxCrUKSm3geb5lp4YVBRm6mi9BKHafCM1ulbUOH9M3ic8UFzgNeremYx9lC7YYCetWjvXDWlU+kbi0u+R7fv05t/HGgwnO1AOqX5g==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 21:11:54 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::e3bb:fca5:70a7:9d25]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::e3bb:fca5:70a7:9d25%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 21:11:54 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, David Thompson
	<davthompson@nvidia.com>
Subject: RE: [PATCH net v3 1/1] mlxbf_gige: Fix kernel panic at shutdown
Thread-Topic: [PATCH net v3 1/1] mlxbf_gige: Fix kernel panic at shutdown
Thread-Index: AQHZu0yxbZJrwJVkPUmz+kiozIIdaK/DJj1g
Date: Thu, 20 Jul 2023 21:11:53 +0000
Message-ID:
 <CH2PR12MB389598B6D2C1EFA43F7B8936D73EA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230720205620.7019-1-asmaa@nvidia.com>
In-Reply-To: <20230720205620.7019-1-asmaa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|BL1PR12MB5125:EE_
x-ms-office365-filtering-correlation-id: f09b963d-3934-4887-b142-08db8965f179
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2r0nLl1yzc1dgQnNu4UM7piC2TnwV/oVp19DXY9WB7haFy7hiSG88nEag54c2y3RQ9hemHRExKJUjg2FrXLwFVFAQvBNTqdEShtQtY4nu81Qc27GSx8Ms5NCsy7y+iLmrrtK32E76Wm+jbazI47tNVbFcs3tnHcTOALtecmZzXJOIXngPtePeXoqUZOU1C0WqxZsd3oE4T4s+yC8fnaUr1ucOLTtVqykaPgvw1UjSYsMSQP4k58V9evNzmlIER7F2/E2m1iyAplR2d0AQ/dvHDPK8NIVZBPQdqNlHLYjK6TwlWYcYyvG/n/yn/TFORUAQ9RBXXVOHbgnJDrOhFPb0TOtiQuMvKBumh7qqEEyhwxLPRHgLMaMAw/PRKed/zDpj9hla31kZtFebDAxH39qUhnxRYFPf+j+ZJMPCodZm1LkNV2XW1SBH6SqpEJiNNTVF3qJSX8nwwjqfqieBoCtRUtf/dzhDOHaKgKgwZBfbTIHfR7AMrIGfbn4VdwvKFndKaoX+Kz+FxgoNncNkqWAluvKQ3TrLq9Xg88tYxMKBznJzzjsVRVSmomo9nu6Kw4ZeEjx8ceeSF8JJGErF7Vw8heQETutLTkh/OlW03dNtGkMp64B0mNC+J04SMQ1N7Z1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(54906003)(478600001)(7696005)(71200400001)(9686003)(110136005)(186003)(6506007)(26005)(107886003)(4744005)(2906002)(41300700001)(66476007)(76116006)(64756008)(4326008)(66946007)(66446008)(52536014)(8936002)(5660300002)(8676002)(66556008)(122000001)(38100700002)(316002)(33656002)(86362001)(38070700005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CPSeAZLabc7z6Fg1RsHT0vkBZFtFMqY/UXzJptllJSTMyfSiojezwLSIlkqR?=
 =?us-ascii?Q?Cvxg0wZdH4dlx1iwx8F4kMMmqnSTpxQypWq4K48NSM5hOvRyT2RdAFOqbtUB?=
 =?us-ascii?Q?jHuDJFdhufXVRnvfv8J7xR/kPoBgTyVuc9x1cto8blAfPJEqGhPekYawjxwa?=
 =?us-ascii?Q?E/96YMgdVa+jAqtgaL1Gk3T0u6Q4nPTJW3OFTVdakO8YF6YTUC/oOAM+HAER?=
 =?us-ascii?Q?8LKW4HfhOpzWyhYTJz5RdfoIxZ3tNG/iQuSc3M6ceG/6vwtJa4QmtNv64r/o?=
 =?us-ascii?Q?kW3Hz/zHfeNFVsrDy8K6c0S32K5NxqdIu7R5fNO9EcVcidXE4OJJUtzuPRDS?=
 =?us-ascii?Q?b+aalCCJnsPOBkPC/dqJzRGM6/VY/R3H3EWyH03hPyQVgKG0Z9yzVbKlnn+a?=
 =?us-ascii?Q?JGgZ2t49mH2G0q1oyDgvH800X2/F5CZflGolR/OwGq2s0bKN61iNUVWL3Q5R?=
 =?us-ascii?Q?PGTEgiNGpS2uSJ/FO94ena1cHeC0IX63ZeT9KkQyEBYp0syekBBBILpAua6l?=
 =?us-ascii?Q?xd7sDodOpGzPIMHyKcrhdFO8IfHSu+eQQSUV1hMJ/r8MRZN9lJF7Yvn24/9s?=
 =?us-ascii?Q?AdpJCWBJZEZqkAawUaO7YLx48A2i80bUs+rMbCq3Ti7lVCR8U0x/Z6pqUXWR?=
 =?us-ascii?Q?9dmUVPfHCo/aY6XA9HohW7TMXNbIkj+t3RDMpJJHnu6i1FKxUVsbvdaf8STT?=
 =?us-ascii?Q?bhBAOWXxCZCnHMTgWl9qAywV3L3tqZbeLP0DAylhBGUyq+SX6dapPh/+uJvh?=
 =?us-ascii?Q?lLrF/S0BmtpPKrrm9DF4rUSp3Our2TSpE5n+ABecscqJWjgePG1WAQAwGrEA?=
 =?us-ascii?Q?Mnj32Q0nxRkaGj5Z3zYtUJgWvrSHKBNaqzeo70J+RY+DuxIPIx0AHcThFz5d?=
 =?us-ascii?Q?z7nnSYppteKW/Zvh5LlKvk9a5VEGF8stl+yubKUmej48FCQGlVM3xjH+7WAD?=
 =?us-ascii?Q?w2U2c/u/J4Sw3zbL72RKqZIMuL3R0c0eAlZnH3SZGI7E/9KLqN+YbSxdFvzp?=
 =?us-ascii?Q?g/VMXiJVPZLh2zTsa300Mf5op0eyMZEZ1OAyem/XA6UHcwlFrFoZUppZIWeu?=
 =?us-ascii?Q?ycmYESm6y/cCgaTv6o8mOEzAzXfh6Ee5sFscg8QORvVkwQJHg0zXFxU5gLyQ?=
 =?us-ascii?Q?9AhzokSzp+5uVPqfy1eacH+aPXVmV/DUa90pNA40kOfLFDb2iRA2YOJ1bDCQ?=
 =?us-ascii?Q?fDAqXqbbtFjAEfCV5uR8cb1QFDNtBA/OmCnbyBipWKOlZrqrgvnBxqffN19v?=
 =?us-ascii?Q?kYInLTG5vLb0yeJjao7OjWn3pC+U6fT3blre5/oqt4qNn8rj9LxDKZkDRNBz?=
 =?us-ascii?Q?dzISwHO0MwRd6xmd5PKlHO2nqc6y8ApWcwpMtgFskjvclyOf1MXgvq6oCaij?=
 =?us-ascii?Q?aDEBYYZmZV3bNeVBGjrZfF54xWdT/KC5qXs1jtPSpvhKpaK3ggYKepk6azfr?=
 =?us-ascii?Q?rXYClJOZo6LJ20Fgg6K6tYZqTvQSBOQxOTuoKsAs9wqDfgWBdttMU4bHJDh9?=
 =?us-ascii?Q?cuASJIX2d6WQx65zFGfV7UpAw2zucmJao2w+kKRlvdvB8H1pcWfZL0Csey0D?=
 =?us-ascii?Q?7tT2w4su0bpQAWyX1BU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f09b963d-3934-4887-b142-08db8965f179
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 21:11:53.9032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xsBWfOWr3RIx8oBi7cbIAy1pYVszaaaSDm89tR0Z4uPuHqUADGPsb8rwxv/mUQCMldXI8tmZfAAe2pYpHhFmeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>  	.probe =3D mlxbf_gige_probe,
>  	.remove =3D mlxbf_gige_remove,
> -	.shutdown =3D mlxbf_gige_shutdown,
> +	.shutdown =3D mlxbf_gige_remove,

Actually, apologies for this commit in response to Sridhar's comment on v2.=
 This will not work. Mlxbf_gige_remove() returns void while ".shutdown" exp=
ects to return an int.
Please advise on how to proceed. Should I send a v4 with the same patch as =
v2?

