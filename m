Return-Path: <netdev+bounces-62932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6C0829EAD
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FC61F250E1
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E258B4CE11;
	Wed, 10 Jan 2024 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A3ZJ7n8N"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9AC4C600
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQgKoCtG+jcy1ard8GXwoFfIO2GY5AxWcyrdCn62bn54VIFb6ZgeC7QI7MNwnNBcIp/uZwTGWFp6IepVUjXg48s1PU/RC+s58Hq0GbGArANNZjAB6eVfF8eH9pErNkMfylCW4PdtXGbzLkh8kyq6e1K1FKgK4bNXlWPtXmbyVmOzI3guSEEhlmrqvOyuXfDX+OUYI6YcON/n6ADLuANscdKFH/hQypTjOGWAiY1PMOGrqxujroYGd1ihnmyHD9Zk39noiCxKCpVRIkaO0BlnLsdpDXWPjAXE5gUzW2kjwBu72NTzXG7JMcQESDDcVGV9c/brve3qfWhC8zocaHHNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aArhjpl9Px+A3L7uvpJDeRN5Ifua3hcG8VQ9J7NdB0U=;
 b=Wl/tZElW6QKk1L0JRJeWXG5RjDxf2EbcPWa04tfwd3Cu/ekkRUVqsGeEfRv5b4Jg59tOCImqZsgthCDyMMJov7E2guHy0S8XVTuAk+gRZpvsJIJ9vnASYiCZr8IqkQ0lfZxxW+deVuqzDsKu9cGo1dqmJz4UO1z3qBfYDO2UfjQo8IwShXfpPMpZevDstpZ2mLFtbCWCiiD9VoRGt2Srw6VS5g9rpCsYcGwGdBEzbuR/AjmUo6ztwUz7JiW3NCAf6LNo8dGSe0Nxi+Vn1nHGMSN4iQLAcmZudY2q2qdwHmu2mDuR4+b5FHAk69h4BnJcvAd5up9sGrrq65xxWU3OfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aArhjpl9Px+A3L7uvpJDeRN5Ifua3hcG8VQ9J7NdB0U=;
 b=A3ZJ7n8NPg/mWLWkYl5UTAvBTNW5YhlGL9IUbAu4D1F70hFfu7sekiJrlJGOpPe76vNcuKeZm8rTM3d0L05RjSw34SIdPuNgRFDRoAaf+cxHrTBaWQjOd8ExX+Jaq9e48G2QqSnq/JmgZ5LEYXyMqyehCjj4lQjSfgx+P13oR6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by VI1PR04MB10003.eurprd04.prod.outlook.com (2603:10a6:800:1e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 16:35:55 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 16:35:55 +0000
Date: Wed, 10 Jan 2024 18:35:51 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 05/10] net: dsa: qca8k: skip MDIO bus creation
 if its OF node has status = "disabled"
Message-ID: <20240110163551.ceemrjwfvavmodqi@skbuf>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-6-vladimir.oltean@nxp.com>
 <CAJq09z4--Ug+3FAmp=EimQ8HTQYOWOuVon-PUMGB5a1N=RPv4g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z4--Ug+3FAmp=EimQ8HTQYOWOuVon-PUMGB5a1N=RPv4g@mail.gmail.com>
X-ClientProxiedBy: VI1PR03CA0053.eurprd03.prod.outlook.com
 (2603:10a6:803:50::24) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|VI1PR04MB10003:EE_
X-MS-Office365-Filtering-Correlation-Id: 99400d09-6192-458f-c94e-08dc11fa3762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3c4mX8EaSt8GUpV5GXQeFzc0S1ZImRat/r2/mMP4+5emifBH7zYv5jvJWUZdJxJSx8Uzlkympj4vSoMPUyFBqR2qmVpwiavbl16Wt31ebtWwy9ThNru6YoSd6WxYczLB8VRHFdNr7a4YMP6jQWhGuapEL3fEGz4maFsf+IOZbgYb9l8Z/zFRBK9cFeJGMhMmmXJ5ANbGKtLFXG8Dzzb+t34Y9X6qXM0324m/vQ+mZgf1eexaERljk7yZTm8h6uBU5F/IBgh3c7fWbupn49gYfTDqlpeT0KV6gs0vpOLRI9gGNOmAa3E5TNp+lr95txRRQNNHhnKC1OqYeuXdOlDbX25J1xRTdaDWHVjF7Z1KntV++PvIorbyrdMIApsQtPzYBc2I0z2RvUeBEmHfUkX53Z61ImJ4NXNckqArthaHrJ9D9IfEIQMr3fQJsiLTeSA1HOMtwQ3wcDXo4x/sMkUw72Ke0cEWYOxjY0nCUhO9nb4Vrd2aadbFi9h2lxzeDOWJNRcs1O/KW6c5tZDrJIg6hJFjoIpgrwC12LCCoXokDPMflaa2UBDEu/QJcQZDgndJO2bKFpYXgLOSM9sHCRsM6pzS/XHCFiXYh+UuHXlKscc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(54906003)(478600001)(4326008)(6916009)(6486002)(83380400001)(1076003)(66556008)(26005)(66476007)(6506007)(6666004)(6512007)(9686003)(8676002)(316002)(66946007)(3716004)(8936002)(44832011)(7416002)(5660300002)(2906002)(33716001)(41300700001)(38100700002)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dMY8Wsm+Qa2DamdERNe/233PQGXfvblSIz2GmOG7n2FUsNANSLPakPIYqtLR?=
 =?us-ascii?Q?Jmh0/JEaLMGpMz182tLyMzg+hMZUFmbrpSJJULEFRuCfevzicVy3PcW/CMGW?=
 =?us-ascii?Q?vSgL3cd/HYb9x2UwaXDIupwMsQLLQM02+7RAbxVIFD8FkACeEnUi/KnIFA3+?=
 =?us-ascii?Q?oAsGXhTSDhRv536Jipr1y34xNV5AYe2Nng4aE+HNOpIReFx4g9A7Va672SCQ?=
 =?us-ascii?Q?jTLgvPX9d3iuxB3rajlxamyPFNaxAhpIj37Dskx9y04Gd/gVX8gtfP6lvFLS?=
 =?us-ascii?Q?XM9KEQ12oV4r80l+ozkufxSa2oKpeA6l7+to30ZYOJi6o5MUaHHVOAszU/uz?=
 =?us-ascii?Q?EB3GW3AB7xh8qvcjP9HcFxfauWYXeJgOO0OsqroZsq1E6UIMlaE2qABD72JL?=
 =?us-ascii?Q?fd+Dbfe5AKjLwTE8G9kCGRg1CLIaDOZQdLT6FV61Zfh9dEGMkL9pttH3gkwB?=
 =?us-ascii?Q?UQK7vx+7gE17xlSkJcqDbsaZ1bovQitZPVevd1PyDvgaeKQ2GxMHOC6FyD8C?=
 =?us-ascii?Q?JXwK9MbXlJR2xMPfz/gITEIxjq0mrggyXpiCmGMb8cbQrHvyJR6FsnKM+fSi?=
 =?us-ascii?Q?zfGAhQFlGP7QJt0cUBYwKWl/taIAduTCF2fMnwHwWxZ3t77E7HnndL2eDuWI?=
 =?us-ascii?Q?zQdwH9oX+1zHfyLlCaRmA7HDtzY+wTgnCg2JtTHjXfbJwROopv0QqLga+UL9?=
 =?us-ascii?Q?Ibk1TI4EcsyW1nRGywmoGwe5Bc8FI5X1T2erp1HkE7QCRm+QpNE68F0YSEa1?=
 =?us-ascii?Q?S5M671oe1dC5SlvVEVNwQE0ZNwKIEooJLwm6RIBGUL76KW2mXV1y08L7Jhsi?=
 =?us-ascii?Q?8ycjVwPvZ0ERphCmJ3gBsVLtbUIks4zX9ZDSd+SbR/mRo4wO4HsLRlC8/nGt?=
 =?us-ascii?Q?SQGuVUdz84sgWH77K/bImSbejkRixmRT4JjNV6yQH3XuLm3MaKDfn1Fktgqw?=
 =?us-ascii?Q?Pk0vHSdYq3/r82aXRK5JuXJL0bC0XZw0SdmFk2cAqXvcMiklKEbX2lwmak90?=
 =?us-ascii?Q?CgEnDYHohSs8DtWApMJcSFqQCu63YWEZrc/93gjyS564npxeCMUCph2nzCwi?=
 =?us-ascii?Q?Zz5HTasxZwTRmVe69HcGrQw7AG+jkA3X4ueNf5Fo/6n9orqBp8Qx7XAq2pTu?=
 =?us-ascii?Q?Sm1KF/y0alUzECmtZ7lLqsMX8wSyfsbFk/mGny6fHJ7dvE/TXBL+i0KignuL?=
 =?us-ascii?Q?G57W13qp6DUCWZvn7aJFTgcUUM8QfuHUqFSTnfSPCSiq33lYvu1AKnNL14o4?=
 =?us-ascii?Q?C18OKRieZJGXhhJ1OqRFIaQ401oTOO8SUR4bSkXheZMVixttRBAWw/sBcp+N?=
 =?us-ascii?Q?jmUyHbklwFjOdAKHs21n0WFoyCgNV5adh1e5XRsq0RsKY9kLZqejYLtPbl2f?=
 =?us-ascii?Q?rr4ubujiO6zWtkI+2PgGKlcpnpNRWLFo8U7I40Jo76MEFRW2K3TTC/2WuMRt?=
 =?us-ascii?Q?ikp3ZSoIzJbj8xb3UOSW+bIs2yGMN9gc9+XibE4p5OUxqGYKNgnq7HUd9VnZ?=
 =?us-ascii?Q?iYFj+JD+3QOx8qTBh2Qt1l5/7zy+Nq6zHtPta71uf9fE0bO2RmMtHh7eqJEN?=
 =?us-ascii?Q?W8QpY1Y+y3qFMokPFNsn3FPcYcsMd4P7+YZ+d0RvNPhmi9HLZU7EuWLejtrz?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99400d09-6192-458f-c94e-08dc11fa3762
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 16:35:55.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDpiU89OJTrU//Js3BMU65tkLOQ65u6TxaAGNft1AhbtssAL/uhircaY5aV6+tyKyZBPlOHuLw1x9bXkVv4N9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10003

On Thu, Jan 04, 2024 at 11:19:20PM -0300, Luiz Angelo Daros de Luca wrote:
> Don't you still need to put the node that is not available? Just put
> it unconditionally whenever you exit this function after you get it.
> of_node_put() can handle even NULL.

You're right. I've prepared a patch to handle this case correctly.
I don't think it's worth sending to 'net' now that 'net-next' has
closed, because as you say below, it's quite possible that the
!of_device_is_available() code path is never exercised by existing
device trees. So the bug is like the tree that falls in the forest but
nobody hears it. I will submit the correction when net-next reopens,
together with Alvin's suggested "err" -> "ret" renaming.

> I'm not sure if this and other simple switches can be useful without a
> valid MDIO.

Will that always be the case? As implausible as this may sound, I've
received DSA questions from people using the sja1105 as a two-port
adapter between MII on the CPU side and RMII on the PHY side. It was the
cheapest way of adapting their SoC to RMII, using a switch as not even a
port multiplier. I see that AR8237 has 1x RGMII and 1x SerDes, so maybe
somebody would want to use it that way, and sidestep the internal PHYs?
I don't know.

> Anyway, wouldn't it be equivalent to having an empty mdio
> node? It looks like it would work as well but without a specific code
> path.

I guess you could also express this that way too. Although, in case it
matters, an 'empty node' has to pass schema validation (has to have all
required properties), and a disabled one doesn't.

The idea with this patch was to deliberately change the status = "disabled"
handling that the driver already had, to make things more consistent
across the board. Each driver binding has its own unique interpretation
of an absent MDIO OF node already. Some consider the OF node optional
and thus register it anyway, some say that absent means it's not needed.
But I think status = "disabled" should be an unambiguous way to specify
through DT that the hardware component is disabled. This is not how
qca8k was interpreting it prior to this change.

