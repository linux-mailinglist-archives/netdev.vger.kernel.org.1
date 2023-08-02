Return-Path: <netdev+bounces-23688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A2476D1D5
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5A11C212D0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975429466;
	Wed,  2 Aug 2023 15:23:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3C8C0C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:23:55 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D5630C3
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emCsrdXFaPWlSiF/dGAHsvVnnbn7c8HnxIIt3yyOEXTma+1m1fQaE2/ZIc6S9phUPt05Ord0rc18970x7zOGohiiMSmH8KUnzkJdinoSVUPY/XpGgpTKp/G9KexC9JzBWiCaZyHDUBHhW38iP7jgogZLSMqXZmNhpZCkgM2hkwypYdbk+4WRugamHiT+v9cb38OJcNAIHYaIaxdDb+W1stzpflLmw449cy7Z7Gm+M8jSFzoKW+Pw8lAt9fQJjnd0BL6gIb4+xoLhwq7Ls7i2bLmMUkFMoMzzT0inxrwTjQv4wJKnvICoTQ9YQkXSAMselpcZbJuHtW7EDOnv6ri4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ae8JW3SXCCjeTvEn8XJrUEgvnOW2BssvMDJ2Zf+SKw=;
 b=TDAUzc7hkcy3kha8zu/KABSA6YCJ3O4QZ+2kBBA4eswoMp6deBi9yOT/jMwaMHtKwUkrEtHHRMVzSG/MxDnNDryCB+XItk8rT2rCEFLmtp8jxNiWYiyzdcdXzsb7iLkjPaaG1aGr6yV/WuORYfCHIk/7O/isy8iwFK60C5DXkT9cBkpgEgsfOwfUUtRuA45MTjTpk/8ClcSxznovDK45R6LBsIz5koNYItpZlUwfafXq8DRlPtG4ICCsBElkoiHhZZI7enKO5UJm3BZ1cQmGhSIZoyrqMtv4Q5IVoC9mJWRzyEcG+A4KT9nKh3R8JtNqg4ofF8fb7ZH9e6ZK7Ko7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ae8JW3SXCCjeTvEn8XJrUEgvnOW2BssvMDJ2Zf+SKw=;
 b=o4UU9SCRnmRQh0KfBIIgbCFrAuVuuNgtZvLEqeu0cM/pebzLS0hRFR3ABf1lJ31GTP+n5jf4xacIRfuFy0/s9ePZAoXGDSJTl0SlNz9WxXsBMUXKoQ4o5YLV8hkrZdr7ffQtWZ6A7rhhdWiueqhqM/V5pXPGaOI7FRvSEDyu3tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8175.eurprd04.prod.outlook.com (2603:10a6:102:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 15:23:02 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 15:23:02 +0000
Date: Wed, 2 Aug 2023 18:22:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org
Subject: Re: netif_set_xps_queue() before register_netdev(): correct from an
 API perspective?
Message-ID: <20230802152259.uwmstxftdk6wnjfg@skbuf>
References: <20230802145736.gp4bbudizpk7elk3@skbuf>
 <CAKgT0UcDXUFDzVjOj4EkVRoz=zdro+hQx877dvhACMwVnjAagw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcDXUFDzVjOj4EkVRoz=zdro+hQx877dvhACMwVnjAagw@mail.gmail.com>
X-ClientProxiedBy: AM9P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::28) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: e51eeca4-aadc-4ff4-0946-08db936c5cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oC3hbB2Hqf1ochMmVvOJVl81qxnlHkioE+NXBbIIkN8SlcrSpP3JzWtvXRciMvVjUO78GyRK4I+bW4uo7KDZc8eKngiq43jLBkym5EeJPAQwKHWAkgSRg6UTMX6xuolpfVmWJAQpE70uhsBH1rYHW58ENcrKNosW9v7UToKKidDK+JC9NINVkh4DO5k+LOK4t9KlpDxr+6gCJCsZpf4ZyhGlsUmXYkQpZdMa3T+APx1fvHGd4haPz+L4c8SG0Z9/ezBMK0PIgW/3Y20KSXGAl5wdJ2O6J7qN4DbYNeyfMED4QOmi4jSuDWrTc0zb81xnVQVeJJHR6gADL0kQPuE7AVSk2RH9w+jcs5P1DzWwBfwTfD1XQC6TJlhs8GutCRTb0gB70HccslxF43zOLmFrCajBpfJdW27+2RV/BxATOd8vVCtdBvUSvlan8nUHsWU13fzcL2dV/fn0PPxVauGONsDyiRsdVliUqVBG7OC7IjlZmtNV/pGfbCysAj/ObeuwND04K2PxsBJJUANinre1fCRtJ6MbN2XjLVIvsv+d/vtf6BenCkqcWSdJf5N6oHM1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(4744005)(478600001)(86362001)(9686003)(6512007)(6666004)(6486002)(316002)(8676002)(8936002)(41300700001)(5660300002)(6916009)(4326008)(44832011)(66556008)(66476007)(33716001)(83380400001)(54906003)(2906002)(38100700002)(66946007)(1076003)(26005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4poQFQQ/4EpPKrsTFTK/MNPKDNWuP3IIBW+Abdba6ddRfG/IEDF770qQikC/?=
 =?us-ascii?Q?hVG9TspR5VfJK0F2mmUHjYNaOEsqYF8kbIIOVtw4XLcxSgNM5TMt7HRIJdFC?=
 =?us-ascii?Q?rxaDy8RyVuHr/0c1nqctv06vdBsiuvlyU90jgOlt8VQNfsBE+B3kv54lm7O1?=
 =?us-ascii?Q?5uW45oSQWhioEabl6Xx5PAZaAWU7ofvMIJhvrY1pf4Ps5C6AqbA6AuxmeuEW?=
 =?us-ascii?Q?dbSd6NvQneDwpt2HCUsoMRnfJeaErxLTrsCufo55+eHrt6K0t8VL5d6iA50g?=
 =?us-ascii?Q?d0AfAbxqqx0jgkvyXX/L5KSnuyZgAlBCeUXTOFnQ5fhkn18QRZfv6GB1L7Qz?=
 =?us-ascii?Q?tCrkYb7/gC8yFoi8Df/ctavy1M8GMprJSvv9dF3U5tihUPDS1B6yhDSy8KAD?=
 =?us-ascii?Q?HRjhnSmqhqi8wZq2KSzHkadWP7e2ifK7Vzwrt2+OoKsLAP7F8uC1JYl+Rg8Q?=
 =?us-ascii?Q?/qoNL9hTazYN/4yvgL/WA2/zH3Rk9hMjHX4/fa125FT4/vHX3DzTxtZFwSzp?=
 =?us-ascii?Q?G9uyRiRnocg66JbM8BjiPdHofX46lVdvGNW2Ia29YrvCKrehTorekwMXJco0?=
 =?us-ascii?Q?Y2d2hYXadGgesFbaqeQug9riWH+Xjj7aSs84KYXJll6vNozB1hO+lg9nAqkG?=
 =?us-ascii?Q?br4TAC64zqJAB36tFzLwE2kLaMJqkaxsaqhAPmGDb/193SVeEgyAvcb/kSxW?=
 =?us-ascii?Q?VCSTC3OycnZyYdOlSiu3QPOQIs4NpSD2buhyoXhLiMDGwjiNYyADDCGHlgXK?=
 =?us-ascii?Q?Xv5Af6SuqOXCRnV1KBY+hW2qXzs/wk/WH4kLTWKlkKXD8xn2vDh8/2McPO/Q?=
 =?us-ascii?Q?ydKb3qe05tSSUREs4IMNEUUyDhcj2mnUjdOfea7qILUSncRggXsZkJDng0qC?=
 =?us-ascii?Q?7GdB0K86uhfJOK+fZCXL/+HleTCJ6OGgIz4/2GoiLeuS4pTa2Mj78QGjQVIm?=
 =?us-ascii?Q?RzT0EOF9bwrYxWVLTV3hmxmQrLqOSehJgkEGnjvEcjrMqH7UT/V5RG5GoCzx?=
 =?us-ascii?Q?vfao0pHdbfmpk0mOGjuGzVYCKpeQyiLFQGx/KxZCDaJCscPSMhR9Il6nFDrg?=
 =?us-ascii?Q?W1KuQYKrGs/wq/gm3/wm5drGieHwEXdrXr+vATzueViGv+YYXWs58JLL3h0f?=
 =?us-ascii?Q?CZDt4u8k879C+WWA/DSdujplL0PvE5VzbXqaRP4GdYbLkHp/zv6zYDwc7++2?=
 =?us-ascii?Q?Ddu+axyFCbji5/9r+IbFHfndmUDYti2h5Vgqp4ibrNN5BQ8tNn3mofcRxc4B?=
 =?us-ascii?Q?EJQhMA+x9bJyoTqWJpQQr/HQt1xfT7xwKfZppf381vDksvWIj7fqnuknKBlZ?=
 =?us-ascii?Q?LENk/9hQVMzU1iAu5YAxLdP8RViUMMpdyhjU8LxI690sX/qV7gz/0Dss/eis?=
 =?us-ascii?Q?rRW4Us/ULoN0bja+tJpM5ySx+h5vjiKjRBcSE4Q/VMW4tY3XIld1K5yY8+HC?=
 =?us-ascii?Q?G58/0Op0/t1SEx6LBYbmdwXN7JbGOrMW/wE2gPcE4exeIqN4AQ4sgnhCXyNH?=
 =?us-ascii?Q?CBBN53CxucsbJRnSWH8nbdDMXxsP0/BElF9ArB59yIRea9He3nZYNZuXCYhh?=
 =?us-ascii?Q?0SS61m98VA1xI0S/aOGlmshaygCAPhmji3w/U4mLnIwbV8/h2TFx+nsevxd8?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51eeca4-aadc-4ff4-0946-08db936c5cee
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 15:23:02.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sBj7/WsTLsKcXAxuI/INK0xDW6hLwbXrj857d3IYXn0sSyhzOHYNl/Sw+4byCj+qRNtfSRl2uFKUI7zL94klw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 08:04:01AM -0700, Alexander Duyck wrote:
> We really shouldn't be calling it before the netdev is registered.
> 
> That said though the easiest way to clean it up would probably be to
> call netdev_reset_tc in case of a failure.

Thanks. What else will happen that's bad with XPS being configured on
TXQs of unregistered net devices? The call path has existed since 2017 -
commit 93ddf0b211a0 ("staging: fsl-dpaa2/eth: Flow affinity for
non-forwarded traffic").

