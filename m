Return-Path: <netdev+bounces-20633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B1D7604AB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688DD1C20C65
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CC810EE;
	Tue, 25 Jul 2023 01:28:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A67C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:28:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2102.outbound.protection.outlook.com [40.107.94.102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30B31712
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 18:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0UbI8h4GS1c0kDZ9EHfgHkx4wRDsMUUwTTnOUIlBK6AZ6kEydCkS3hkB/BTcIJ7Co3NmLB0uiIwaUufTPquKlFhe1dZvdJbEp7kIZVRORqVudBUBCXWYyzb3HUAeMZS+0opLnPUIqdHgqXdH4Y9O4SIX9nataQibvSHVLkDgqxn/hT9YV8c+/GsNwu0DdRxWH5jwGy7jWti37sRmBs8tzuO08DFMpedCFi1xjMLyaHQbdGbYCE0nbVk8wk7jIKbK3Bk3ri2325wYRi4pFZ0GvozxdyBOJNlz47+wJN5LHiRubecgF/iOgN34h21CvrPoPqAa1Hs4cSr3+VHeY5sTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy7XvCygUchGStp+pk6Zbx+wsWvPN1DGwzr9UpAI6Ts=;
 b=MuxK4kqfRtYf+hXnkLJsdM+LvC/XQS+MYsFiobYVaca7RazotjulpXuHB1ptB1Q+IyVR7Vur12p4hlbM5MToD8rtFAWYNvMs6SvVvTPwsGHv65oH49aF3dzVelrqJIomzYkFV1keDCbZDssk73MUifmDrEbtE4pRRG1spU9W1+Mh2QAX8US7HBlfPtqXGxasVXNhXJeUSozvX7PEY+Nn7zToG8fjCwOM+hFysrqeI/7rx1sUEDFNrpjbyELBvRy26L3uJ7ANm5U8XAzngfWlU8SJpznM0QGqN/ubpvLhO5xk4W3pBi+dxyaQnrelkTz7hWPZntko32b+2Nt0FocuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy7XvCygUchGStp+pk6Zbx+wsWvPN1DGwzr9UpAI6Ts=;
 b=vHE/UXMoWCEs98CU6o2gRyTMaH3MNI0Ye0l7s1FSQyA3JF8xr39X2w/NFnpsfGHkj7VHgWgQzVPhHUhd7FZBlCp556OI86bfffQcFy9HdGUnkrG1/B+BdV7TOv+wRYTX7FE9/qOfS/MYryIrXRO55IfILtOPvGd+u5CjtwK1ppU=
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by CO3PR13MB5816.namprd13.prod.outlook.com (2603:10b6:303:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 01:28:34 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23%7]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 01:28:34 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>, Louis Peens <louis.peens@corigine.com>
CC: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <simon.horman@corigine.com>, Tianyu Yuan <tianyu.yuan@nephogine.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, oss-drivers
	<oss-drivers@corigine.com>
Subject: RE: [PATCH net-next 00/12] nfp: add support for multi-pf
 configuration
Thread-Topic: [PATCH net-next 00/12] nfp: add support for multi-pf
 configuration
Thread-Index: AQHZvhQOyhJJYaAxoECPRxnGLmndE6/JmggAgAAYBlA=
Date: Tue, 25 Jul 2023 01:28:34 +0000
Message-ID:
 <DM6PR13MB3705B9BEEEE2FF99A57F8559FC03A@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20230724094821.14295-1-louis.peens@corigine.com>
 <20230724170100.14c6493a@kernel.org>
In-Reply-To: <20230724170100.14c6493a@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3705:EE_|CO3PR13MB5816:EE_
x-ms-office365-filtering-correlation-id: 2d9e21c8-22e4-4680-c192-08db8cae769a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S9kaMqWcF1uDtLsapoDps859Q4rC4TcBzas8jGSCs2jp0nqumz1dE85nNRCXFBCsVo9C31VAyyiVJ/SAVAo5JGyhNzGAWer+vRWaBMJB3qR3ItntM7bLBOtUTMU9nuxw8Ay+80vWW7eq0tqphoD4WUIpHkmUdq6KpiDdT3V23JNTmTgQwrNou2NLK6YVo5o1+CcAckD6hwq9/7l5YUhmhp8P7oUnHB4fJjW/CSiOCjVnrIUwi8w4fxvxiZnQtr9XE5tWXpWGoag7LrHfEAwK+OcqrVKgfvTnOe6jSwrHjg6n/FSz4ftz+bKIIf/Q2fwU9jKpc5nw3fm5WfQwRrec5PvYd/DIDNOHkIQqfq+eSMn2A9xxGxR6sxUV6EyXSjO+g1aYHqNNW7pX3vTGeTTE20GF8Jf54GMS/6RVXjU18z6gkowjqObRgoYdZNQzP8ywSWZd7Hdaz8ltF0KrkghDHDlR2kwW4lfUGycBP7bP+hquC+iHHJWBCa1JSQzYIYK1WBzEu14meKi0kDQHJEhril1FNK17lmEN+p5Qq9+DMnfB2tXVWbmvnweIEvgdU7y2lANsOq5ek/wFeeeZz2wGQq7XlMRRYoA3DqG618Wp0dR36TuIgN1Gu7SfuW1Zf1Al8M0UsX8KB3AsCpDp1U9/POvhX1fbmoSNiEmYnl+m34o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(376002)(396003)(136003)(366004)(451199021)(6506007)(110136005)(7696005)(71200400001)(54906003)(478600001)(9686003)(53546011)(186003)(107886003)(26005)(44832011)(2906002)(41300700001)(66946007)(4326008)(6636002)(66446008)(76116006)(52536014)(5660300002)(8676002)(8936002)(316002)(64756008)(66556008)(66476007)(38100700002)(122000001)(38070700005)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9awdKHVg0YUdCLu1wRPVTlAm16ZBNvCMftmknAbUFGtSZoxLcy7af+SaDr14?=
 =?us-ascii?Q?gHMZKKNxrtpttX5aDkjixghhGj8A/HhVRAC4k0ojxrSEBGAvhjXkNxSCRXhb?=
 =?us-ascii?Q?NL2dSYYrZmpIUwJDQJnQzYPpNVYDIzDuu61cB/84pYm0gfspcyNzU/WMiaDM?=
 =?us-ascii?Q?Tc+3CpUXRkw+qnSY0YU2B5EuXCjOkXm4C2Yq4XaCn33Uyl39G55qne7/VvVB?=
 =?us-ascii?Q?o0/RLkszhbDZbkJ5L4N2Q+fZ7tu/tIaSvzokzhRJDcqmFFOP5DW5EZWV+iD4?=
 =?us-ascii?Q?1RYhrPoJpGA46BVdhRMdBsVS47B0E2wvO66IzkYXIBX1Y9cSTbGAsYlmPBAt?=
 =?us-ascii?Q?VC3USxSOzMnZ+38tFB+HtSvMC2TUgFZFkrxEE50Gdqjxc4J9wqGjlZBeTbXo?=
 =?us-ascii?Q?oynIgu0xj9A5Jn7jQbQ4a0EV2KprUhTaqbEUd25SxjJzF8cFLh2+7lWL2ljV?=
 =?us-ascii?Q?9t1HrzLXfbZBKoWJaLtUMr1G/YHXADcckc5vqAZIPIkY+VZLokFhQ3qbK4YB?=
 =?us-ascii?Q?rwNbzQ8eTqxNvkSgJrnsIPFw49foslGZbYgNviKUAV5MsNNwzN87YbIxzQGQ?=
 =?us-ascii?Q?fQUZApGeKFioToPrLajo//Rf1PhuOfaVUaxBgoMPfIcDWNH7rhCdO3CFnyJd?=
 =?us-ascii?Q?VWrr6iTpDtap8by+6QulzEhlSz0BPpINVFOsm+XuUUtPdy2CVB4M/VrxriT7?=
 =?us-ascii?Q?1eyG0wi10P/gVe0gGvYlvya9RwDTlEcn9Yx7PEWcHsnX7+vi/SMKZ90DkJfq?=
 =?us-ascii?Q?ICiliFlHkQt93czqDhmf2adqx4hdScxvxhB+PkgKiPHJChDJD4BW7UPQaJui?=
 =?us-ascii?Q?SEU51xw1g2LLF/1G8NU8+JTSctBlvIrfeaJHYXYpzsKCS3vTiTDY7ntI3Ww0?=
 =?us-ascii?Q?Ey1vm24o8X1zpLqeF6tt8jg5qTEAW8kWKNg12cndls751dDkXISI9Y+4YDYl?=
 =?us-ascii?Q?Jyp9THqa5jOCdY7um4V1PIJza3PDFkbxvim4RxE/BC8P5SwNMD4oTr0dPrj1?=
 =?us-ascii?Q?yFMKoXLaIVILPBT5LXjEIehjCAYgHR0ffCyLNPriowHCVVVCEHgdiffRAwtk?=
 =?us-ascii?Q?clv29ynd9FlK76i17EyLrXTaQCsU257I/XOsUkk3e3oCn+6shhW4VvzLld9t?=
 =?us-ascii?Q?eFGtOKLQmKO3ZYqeVaummAOwSllqUifF06z32dmlRc6e7Glqa0GsokEQnl2L?=
 =?us-ascii?Q?ZKUOAdlb2kG2EjQMrFzYtCKddPZXC1yfyBVOMbVk7rERTNsjZ+PAkIr/VRa8?=
 =?us-ascii?Q?yMs3v/QE711LUIP+cPnSHMGu36QONmOG7pPuKX93fNNuhydueWh9CYixSpZs?=
 =?us-ascii?Q?KUzbdo4HYkEXpqTw0N7hoTU5JRAY1XR3edjLSvmopMKC0djhGg0XQLXHQ3ua?=
 =?us-ascii?Q?0j85583S3MfNpnW+ONlypIsU9Jav5dhPLObYdrPntp31JJe/dtAyNEBidbKe?=
 =?us-ascii?Q?8kCu4Y6BeWMPPD9+UzpqXM/vHzQQ7AwJ2QhxT8xtZon9or2v2BptdeT4fSRM?=
 =?us-ascii?Q?nEWsGVsV98JHRqjlXrgnWY5QVowT+BF9Qc3273TkHcZx+GgE1lvET6RavtsC?=
 =?us-ascii?Q?1rZCrzxJhGU/zaW7sGz0XiVIEowGoAkMcCHRIXxJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9e21c8-22e4-4680-c192-08db8cae769a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 01:28:34.4673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1lYLnvUGTk8cLDtkGOyqcB7EoexQOw2HS/Vt49ODPozab4gkWJuRunfOkXz25iWxizwtjbpoxCrbU3XQK6UUdknHixzDkfks1V6cnfbOOVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5816
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tuesday, July 25, 2023 8:01 AM, Jakub Kicinski wrote:
> On Mon, 24 Jul 2023 11:48:09 +0200 Louis Peens wrote:
> > This patch series is introducing multiple PFs for multiple ports NIC
> > assembled with NFP3800 chip. This is done since the NFP3800 can
> > support up to 4 PFs, and is more in-line with the modern expectation
> > that each port/netdev is associated with a unique PF.
> >
> > For compatibility concern with NFP4000/6000 cards, and older management
> > firmware on NFP3800, multiple ports sharing single PF is still supporte=
d
> > with this change. Whether it's multi-PF setup or single-PF setup is
> > determined by management firmware, and driver will notify the
> > application firmware of the setup so that both are well handled.
>=20
> So every PF will have its own devlink instance?
> Can you show devlink dev info output?

Yes, here it is:

pci/0000:01:00.0:
  driver nfp
  serial_number UKAAMDA2000-100122190023
  versions:
      fixed:
        board.id AMDA2000-1001
        board.rev 01
        board.manufacture UKA
        board.model schubert
      running:
        fw.mgmt 23.07-1
        fw.cpld 0x1000001
        fw.app sri-23.07.0-0
        chip.init AMDA-2000-1001  20230321150349
      stored:
        fw.mgmt 23.07-1
        fw.cpld 0x0
        chip.init AMDA-2000-1001  20230321150349
pci/0000:01:00.1:
  driver nfp
  serial_number UKAAMDA2000-100122190023
  versions:
      fixed:
        board.id AMDA2000-1001
        board.rev 01
        board.manufacture UKA
        board.model schubert
      running:
        fw.mgmt 23.07-1
        fw.cpld 0x1000001
        fw.app sri-23.07.0-0
        chip.init AMDA-2000-1001  20230321150349
      stored:
        fw.mgmt 23.07-1
        fw.cpld 0x0
        chip.init AMDA-2000-1001  20230321150349

