Return-Path: <netdev+bounces-30741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29868788CD1
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1251C21077
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F01B125A9;
	Fri, 25 Aug 2023 15:49:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9811CB4
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 15:49:57 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05hn2248.outbound.protection.outlook.com [52.100.174.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2665E2697
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afB2JKuORhK2PMHPyow4wJMHjMxJ22bwlpcww/B/zUiNP4tr3sQT7fx6wij4s0JonGBNnGiEs+s2HGKOm/rhzk9pBptpoiQ6e5E4Fqn3DPV+Ad82IIH6nlJvHBCkaYA9Cv1J4NcmAjbXqVqfbMt+u0VmjcRwx+3a32UpYvOx+BQoFUJANBjjThyeSMbitWMxN3eomjRRSLk7fN793lgafdPKH5U10YpUo5bq4Zus5bRSOT/XsWU/f98P5xlpnT3SI/r1j41/QFG1VzpzC7lPSF3l2Uwvx1dYwFzu6KQntHVNh7aWU8H0Yu7Ajpe+J8I4c2nwhOJa2WSboopQlWnVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7YYq9/qeiuFJXztJNOnyknc8cQqAUDDEczxbfvGTOI=;
 b=hYn3a0gTj+0DPgfDzeehu+z4dKKLEDsX+rrIFX8GtdOBuSNBsagQ0LUy6ANafcESnClvfy0Negx2+gTlfUPGeV3LyZAR49T8eDstomMwaHqiW5va9o2w/LRxvklJU1N24B5aPmILem1+weMNIJyIi/tyzWfB9zWNrnLx1vCnneeLJm15vNoqj9OITunaUlZVjDLpw3jf9W9hPHHvuPU9RKVVC77dcfI+0FQDT2I2JiyNWeCJDuNQnkFbxFVzElvIPuHznbSmMkkc3qT78SbUwuZmFF3fos1NfwY3mr5LY4a/79FpF/DZQcx7J3hao8MoR5Hz42ojLiMm7UfiCp2UmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=none
 action=none header.from=arri.de; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7YYq9/qeiuFJXztJNOnyknc8cQqAUDDEczxbfvGTOI=;
 b=kfUHuJrA3hlJtYRUY5zlINyU8gpdWd23McD1DQd4RCgAkJgpHYRPMxPXTAB+2ODYQwTntTEizZX47HgJsSECFRZghn2PKRYpgq9IjdxgivQ50vEFov6UHcymTNGsGILN+zhJWgR5ldpRPhopKjo13IxUDAwSSujQ9yt9OV7ekzA=
Received: from AM9P193CA0015.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::20)
 by PAXPR07MB7727.eurprd07.prod.outlook.com (2603:10a6:102:135::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 15:49:46 +0000
Received: from AM0EUR02FT019.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:21e:cafe::cb) by AM9P193CA0015.outlook.office365.com
 (2603:10a6:20b:21e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 15:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM0EUR02FT019.mail.protection.outlook.com (10.13.54.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.17 via Frontend Transport; Fri, 25 Aug 2023 15:49:46 +0000
Received: from n95hx1g2.localnet (10.30.5.31) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 25 Aug
 2023 17:49:45 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Hutchinson <b.hutchman@gmail.com>
CC: <netdev@vger.kernel.org>, Vladimir Oltean <OlteanV@gmail.com>,
	<arun.ramadoss@microchip.com>, <rakesh.sankaranarayanan@microchip.com>
Subject: Re: Microchip net DSA with ptp4l getting tx_timeout failed msg using 6.3.12 kernel and KSZ9567 switch
Date: Fri, 25 Aug 2023 17:49:45 +0200
Message-ID: <2259373.iZASKD2KPV@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CAFZh4h_ueji_KucLdPx9PtTQP1g29PbcjNDFGzLBJYpYK8Rt3w@mail.gmail.com>
References: <CAFZh4h9wHtTGFag-JDtjqFEmqnMoW4cTOr_CF3GQwKLb5jigrQ@mail.gmail.com> <CAFZh4h-0PBrFh1pDr6Jfg95rF6wUt1o=k=-EgG+8MxN7pnyiAw@mail.gmail.com> <CAFZh4h_ueji_KucLdPx9PtTQP1g29PbcjNDFGzLBJYpYK8Rt3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.30.5.31]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0EUR02FT019:EE_|PAXPR07MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 5306f122-a973-4c19-e250-08dba582e817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHpaZkRRRUFmbXhVRGtudmtxL2Z6RVk2SHJwSm5CMXNQWWw2MVRoYmlhbjJB?=
 =?utf-8?B?a05UOVZ4dFVHRUlBaGYwWW9rSEtrREZ3Q0JjS2Qva1gvb1Y4dk8zdDNVQmxu?=
 =?utf-8?B?UWRRVllqRitGSzRRSE9IVXFQdmovUHRMMWZPRWdhc3FVTHdxdlE0Sm5wY3dt?=
 =?utf-8?B?c2hHUGxzcExKMWEyaG51WllubzJKK2ozMFBIWmxnWGZINTludjBydndRb1Q3?=
 =?utf-8?B?M1FaTExUeWN5cFRCVjlxSkQ5VDZ2aFhCeHBwL1pKbUMrK1UycENyS2t3cFVJ?=
 =?utf-8?B?bi9FWkE3ckI5bm9oWHcvcWkySU8wNnFYZ2haSTZoMUtyb2phZFVsbGpEMlgr?=
 =?utf-8?B?OThPRWlaOE42YllvSnFrUlpKMEowU1ZBclh5VmJVYjdITEExcnlQcGJlLzlO?=
 =?utf-8?B?WkNFbHB0SGVQUWZKN2NPT2pTSXV3UTlYYWNoblc2cDFmelNQUUtjUzNoU2tV?=
 =?utf-8?B?bUNXWHNMMjFYVmd0MlZDK0J4L2JQbGRHb3J0MWNHVHl1ODVZcWVGa1E3YVBu?=
 =?utf-8?B?YVlSWE9acTdjbVhGYS92UW9WUkU3RVkrZFdCbDlqMSsxUE9RT2drYUQ5aEF1?=
 =?utf-8?B?L3dKYnBVSTFLRFpRMVcrT0dmaDVuM2RMZER1cExDOFpubWpPVVhpRmwrNXB5?=
 =?utf-8?B?eTFxTTl4MFQrZEw0cTFHYStNbDVGR2d1N1k2Q2pZamkzOGtkUDVBQW5KOWVX?=
 =?utf-8?B?OVV0RUJ2VmtQeHlIQU1oZUp6cHQ5UndlRzFyUU92YnVCa3ZxOVdOWnl1VzFz?=
 =?utf-8?B?ODBFbDJydlhGQUhTdko1UjFrdVJqdStOL3d0dUdnTklTUWsrclFUeWVVUXVK?=
 =?utf-8?B?V2NxWGtDdURjblM4YVlESWVDTFluTEQrNUpUbDNmQTVIUmJ6dTM5L0ZqRWFv?=
 =?utf-8?B?bnAreDRCOWFVbHJBb0JRMjAzTUNheHMzZWxEMUVFY0kyd2wyVCttcm9BWlJO?=
 =?utf-8?B?NmI5UHBZeEljNUV1MFpxYWFPUzZudHl4Zm9KYXhNd3VwWmhyVlFCK09QcXR1?=
 =?utf-8?B?bkRQUldpdllGc3hiU1pPSG56dkx3Q2FRWGpYRTFQYVN3ZjU2ZE5Od0hNVjdm?=
 =?utf-8?B?L0NyQktNRXVzeW5JcHE1dWdCUjlOcDBzV3VxOFhuSCs2SFFiUDg5cC9kaVNl?=
 =?utf-8?B?b1haWVJBejRCSkFzVVhIYUpFSWhzUXRWMXMrSlErazRvR3VUb1hFd0kzSUZ5?=
 =?utf-8?B?VkJHUXBCSVF0WjNwc1F2UWVhSnZHUnZEOUNISWpZSE4rSitYaExKa0s4K1M1?=
 =?utf-8?B?akVjNEN1Qnljc0hiWkVwcVZ1NjVzb3NaZ3FJbXl4d2RpalIrSmhLWDJ4dE1V?=
 =?utf-8?B?RkNMUUVIcWV2TzhscTZkSjhwbjk4OWdBbDlrYWF3dUVFSXNlb0Jaelkwc1Zo?=
 =?utf-8?B?WHlqajkyYmlIQnEzeXZUd2RPNjdScEdnVDBzZGZTWVpQb3NQalJuVkRhbGRu?=
 =?utf-8?B?L25hcitCZ3NkdFkvNGZQMmxTSTVQd2lhTzFxYW9UWVlJMzNEZ2hzYTVscCtr?=
 =?utf-8?B?SGhScEdlQzdpWGJIbWViazlCeHVDVlg0cEk2VWRZR2VBRkRXcGl0WmJ6ak52?=
 =?utf-8?B?RUd5MjFUNWlOdnE5R3lSLzc4U0FhSkVHcVNFOFhrRm9mR1RlQVJCd29nU3Zi?=
 =?utf-8?Q?I5QhzqU+yye3PD0ZTkZHhEptjc990LZtkma24smmz7bo=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:OSPM;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(107886003)(5660300002)(9576002)(8936002)(6862004)(8676002)(4326008)(426003)(47076005)(2906002)(83380400001)(336012)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(81166007)(70206006)(70586007)(33716001)(54906003)(316002)(478600001)(12101799020)(9686003)(41300700001)(53546011)(86362001)(36916002)(39026012)(42413004);DIR:OUT;SFP:1501;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 15:49:46.0799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5306f122-a973-4c19-e250-08dba582e817
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM0EUR02FT019.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7727
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Brian,

On Thursday, 24 August 2023, 21:03:32 CEST, Brian Hutchinson wrote:
> Update.  Top posting because I think this is my issue.
>=20
> I dug further into my problem.  I'm using E2E and it looks like the
> mainlined Microchip KSZ DSA PTP code is only supporting P2P.
>=20
> The 5.10.69 kernel that I was first able to get working with
> Christian's early pre-mainlined patches had:
> 0016-net-dsa-microchip-ksz9477-add-E2E-support.patch

sorry for this, but I forgot that you use E2E.  Unfortunately I
have no up-to-date patches for this, so you may try to port
the old patch yourself.

regards
Christian

>=20
> ... which gets into the "sticky" bits of why these patches weren't
> accepted in the first place due to some Microchip specific
> implementation if I recall correctly.
>=20
> Regards,
>=20
> Brian
>=20
>=20
> On Thu, Aug 24, 2023 at 2:26=E2=80=AFPM Brian Hutchinson <b.hutchman@gmai=
l.com> wrote:
> >
> > Hi Christian,
> >
> >
> > On Wed, Aug 23, 2023 at 9:29=E2=80=AFAM Brian Hutchinson <b.hutchman@gm=
ail.com> wrote:
> > >
> > >
> > >
> > > On Wed, Aug 23, 2023 at 4:22=E2=80=AFAM Christian Eggers <ceggers@arr=
i.de> wrote:
> > >>
> > >> Hi Brian,
> > >>
> > >> I just return from my holidays...
> > >
> > >
> > > Hope you had a good one ... I need one too!
> > >
> > >>
> > >>
> > >> Am Dienstag, 22. August 2023, 23:49:33 CEST schrieben Sie:
> > >> > Getting this tx_timestamp_timeout error over and over when I try t=
o run ptp4l:
> > >> >
> > >> > ptp4l[1366.143]: selected best master clock 001747.fffe.70151b
> > >> > ptp4l[1366.143]: updating UTC offset to 37
> > >> > ptp4l[1366.143]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
> > >> > ptp4l[1366.860]: port 1: delay timeout
> > >> > ptp4l[1376.871]: timed out while polling for tx timestamp
> > >> > ptp4l[1376.871]: increasing tx_timestamp_timeout may correct this
> > >> > issue, but it is likely caused by a driver bug
> > >> > ptp4l[1376.871]: port 1: send delay request failed
> > >> >
> > >> > I was using 5.10.69 with Christians patches before they were mainl=
ined
> > >> > and had everything working with the help of Christian, Vladimir and
> > >> > others.
> > >> >
> > >> > Now I need to update kernel so tried 6.3.12 which contains Christi=
ans
> > >> > upstream patches and I also back ported v8 of the upstreamed patch=
es
> > >> > to 6.1.38 and I'm getting the same results with that kernel too.
> > >> >
> > >>
> > >> I am also in the process of upgrading to 6.1.38 (but not really test=
ed).
> > >> I cherry-picked all necessary patches from the latest master (see at=
tached
> > >> archive). Maybe you would like to compare this with your patch serie=
s.
> > >
> > >
> > > Excellent, I will check it out!  Yeah, we needed to be on a LTS kerne=
l so that's why I'm focusing on 6.1.38 as it's the latest in the yocto/oe u=
niverse.
> >
> > So I checked all of your patches for 6.1.38 vs the ones I had.  I had
> > all except 0002 and 0003.  I didn't have all of 0001 but I got a build
> > error on diff_by_scaled_ppm and back ported that function from 6.3.12
> > to make things build.
> >
> > I applied the missing patches I got from you and rebuilt everything
> > and still have the same result with tx_timestamp_timeout.  Which
> > didn't surprise me as I mentioned before I tried 6.3.12 mainline and
> > get same result there too.
> >
> > Regards,
> >
> > Brian
> >
> > >
> > >>
> > >>
> > >> > [...]
> > >> >
> > >> > I tried increasing tx_timestamp and it doesn't appear to matter. I
> > >> > feel like I had this problem before when first starting to work wi=
th
> > >> > 5.10.69 but can't remember if another patch resolved it. With 5.10=
=2E69
> > >> > I've got quite a few more patches than just the 13 that were mainl=
ined
> > >> > in 6.3. Looking through old emails I want to say it might have been
> > >> > resolved with net-dsa-ksz9477-avoid-PTP-races-with-the-data-path-l=
=2Epatch
> > >> > that Vladimir gave me but looking at the code it doesn't appear
> > >> > mainline has that one.
> > >>
> > >> How is the IRQ line of you switch attached? I remember there was a p=
roblem
> > >> with the IRQ type (edge vs. level), but I think this has already been
> > >> applied to 6.1.38 (via -stable).
> > >
> > >
> > > So that's one of the first things I thought of which is why I provide=
d cat of /proc/interrupts.
> > >
> > > I also do have a /dev/ptp1 (/dev/ptp0 is imx8mm)
> > >
> > > My device tree node is the same as before:
> > >
> > >          i2c_ksz9567: ksz9567@5f {
> > >                compatible =3D "microchip,ksz9567";
> > >                reg =3D <0x5f>;
> > >                phy-mode =3D "rgmii-id";
> > >                status =3D "okay";
> > >                interrupt-parent =3D <&gpio1>;
> > >                interrupts =3D <10 IRQ_TYPE_LEVEL_LOW>;
> > >
> > >                ports {
> > >                        #address-cells =3D <1>;
> > >                        #size-cells =3D <0>;
> > >                        port@0 {
> > >                                reg =3D <0>;
> > >                                label =3D "lan1";
> > >                        };
> > >                        port@1 {
> > >                                reg =3D <1>;
> > >                                label =3D "lan2";
> > >                        };
> > >                        port@6 {
> > >                                reg =3D <6>;
> > >                                label =3D "cpu";
> > >                                ethernet =3D <&fec1>;
> > >                                phy-mode =3D "rgmii-id";
> > >                                fixed-link {
> > >                                        speed =3D <100>;
> > >                                        full-duplex;
> > >                                };
> > >                        };
> > >                };
> > >        };
> > >
> > > And I have same pinmux setup as before.  I double checked all of that.
> > >
> > > I noticed new kernel /proc/interrupts now has a bunch of ksz lines in=
 addition to "gpio-mxc  10 Level" which is IRQ from the ksz switch.
> > >
> > > Here is what the old 5.10.69 /proc/interrupts looked like:
> > >
> > > cat /proc/interrupts
> > >           CPU0       CPU1       CPU2       CPU3
> > > 11:      46141        127        127        124     GICv3  30 Level  =
   arch_timer
> > > 14:       5260          0          0          0     GICv3  79 Level  =
   timer@306a0000
> > > 15:          0          0          0          0     GICv3  23 Level  =
   arm-pmu
> > > 20:          0          0          0          0     GICv3 127 Level  =
   sai
> > > 21:          0          0          0          0     GICv3  82 Level  =
   sai
> > > 32:          0          0          0          0     GICv3 110 Level  =
   30280000.watchdog
> > > 33:          0          0          0          0     GICv3 135 Level  =
   sdma
> > > 34:          0          0          0          0     GICv3  66 Level  =
   sdma
> > > 35:          0          0          0          0     GICv3  52 Level  =
   caam-snvs
> > > 36:          0          0          0          0     GICv3  51 Level  =
   rtc alarm
> > > 37:          0          0          0          0     GICv3  36 Level  =
   30370000.snvs:snvs-powerkey
> > > 39:          0          0          0          0     GICv3  64 Level  =
   30830000.spi
> > > 40:       1412          0          0          0     GICv3  59 Level  =
   30890000.serial
> > > 42:      55291          0          0          0     GICv3  67 Level  =
   30a20000.i2c
> > > 43:          0          0          0          0     GICv3  68 Level  =
   30a30000.i2c
> > > 44:          0          0          0          0     GICv3  69 Level  =
   30a40000.i2c
> > > 45:          0          0          0          0     GICv3  70 Level  =
   30a50000.i2c
> > > 47:          0          0          0          0     GICv3  55 Level  =
   mmc1
> > > 48:       3003          0          0          0     GICv3  56 Level  =
   mmc2
> > > 49:       2565          0          0          0     GICv3 139 Level  =
   30bb0000.spi
> > > 50:          0          0          0          0     GICv3  34 Level  =
   sdma
> > > 51:          0          0          0          0     GICv3 150 Level  =
   30be0000.ethernet
> > > 52:          0          0          0          0     GICv3 151 Level  =
   30be0000.ethernet
> > > 53:       1417          0          0          0     GICv3 152 Level  =
   30be0000.ethernet
> > > 54:          0          0          0          0     GICv3 153 Level  =
   30be0000.ethernet
> > > 56:          0          0          0          0     GICv3 130 Level  =
   imx8_ddr_perf_pmu
> > > 60:          0          0          0          0  gpio-mxc   3 Level  =
   bd718xx-irq
> > > 67:         23          0          0          0  gpio-mxc  10 Level  =
   0-005f
> > > 72:          0          0          0          0  gpio-mxc  15 Edge   =
   30b50000.mmc cd
> > > 217:          0          0          0          0  bd718xx-irq   5 Edg=
e      gpio_keys
> > > IPI0:        29         14         13         13       Rescheduling i=
nterrupts
> > > IPI1:         0         41         41         41       Function call =
interrupts
> > > IPI2:         0          0          0          0       CPU stop inter=
rupts
> > > IPI3:         0          0          0          0       CPU stop (for =
crash dump) interrupts
> > > IPI4:         0          0          0          0       Timer broadcas=
t interrupts
> > > IPI5:      7959          0          0          0       IRQ work inter=
rupts
> > > IPI6:         0          0          0          0       CPU wake-up in=
terrupts
> > > Err:          0
> > >
> > > I'll check out your 6.1.38 changes compared to what I did.
> > >
> > > Thanks,
> > >
> > > Brian
> > >
> > >>
> > >>
>=20





