Return-Path: <netdev+bounces-136905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4429A394C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2180EB226DF
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2346519005E;
	Fri, 18 Oct 2024 09:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD91188CC6;
	Fri, 18 Oct 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242025; cv=fail; b=tzpvVJCsrJO3oQk5A3SRXIe1koaJ1VNr0dOdIamnYZvHXqiJoVhJnuaEYc0g6KebDymPUdH8zjn77nnERVSOas20TY9g26u7Vn3OxsdwCgEZPwjsC0kyNOVcrCXPzTL2eJEhsAGoCMRTXfg9pQpHxnT2c6RzRQCxm/KArtIphpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242025; c=relaxed/simple;
	bh=CKLxGgJ/PokJ9+NBoPQpjDjAOLx1n1kpJQBTodlYiuU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b9H0QSgyC1Lpy/qbWjFC724zlfLAzagKxPP1+/3T1i+ev6RcJbtmRKYnxjPPgwCDr+R/lFsgHHuhsj7bu4KEI07id/D+PrjswG7qqwYEX3ai3PYvf7jKTSecY5V+rIlKoMgQumBF6pEgEsSPR7XJTf/TQviYNXbuXVRIGSBWioc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KC502fBS6jK6lTVw+Em7OMHe6EociXweHoN3pMgXepNH1vvRkh6Ab71TOjiNAjsqUHwinh/2y1FaWsW8HrQ0vQhphaXMr13qN6f6aH+xY+S+DxyBDSYRjdJVMtpuEs8iSDG31NVNlFSinXDsbisiJXR3CKtmZA9CcZ7WqyaE+TA807vJj4UimQ5q9KE1P0PI7SrCy1YiWz6j4+d1JhZC1t57lOrG/k04cmtLAmkahjDbYNNGKu6lDT8F+aJjPefOmbx9ZxHqpg1Jpi3q0vb3fTgOK/7h5psIOccZ64Hut3nZkoL1fmXmx+pfuARDFu9uyjms9xBcUW1cRHolHrVy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKLxGgJ/PokJ9+NBoPQpjDjAOLx1n1kpJQBTodlYiuU=;
 b=T+gWOJAVUMv5yCJGGLL8Tbqn9noNZ/I5jRZD1NER1wSMQisPl6Qje6B522wLmQzCMXfCkH5moGM+VWCyF5XiaZQeZlksu0oM2+088KqTv/ZCWgGo7im2b/YOZc4zrlO1rb8s1iYgdf/wuTF6YWjTSec7PeXt2NI8ZB6YQpmZ0zcsPvndAZnVP0kL4MTbOP0ahlNXfke63B/zLRfbC6tj3ozOyd8ZXh3IXmYS0e7ySB85RPV7Le9uFI2ixQz2L+ICDXmHVYSnpk66hAC1kY5oKXUIxyXePrfB/MY6gft2FnMh65IKIuw5JAl79Qt3BP9vP7TauCoWg+lENGhIHh0UVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1027.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 18 Oct
 2024 08:59:51 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8069.016; Fri, 18 Oct 2024 08:59:51 +0000
From: Leyfoon Tan <leyfoon.tan@starfivetech.com>
To: Simon Horman <horms@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lftan.linux@gmai.com" <lftan.linux@gmai.com>
Subject: RE: [PATCH net v2 0/4] net: stmmac: dwmac4: Fixes bugs in dwmac4
Thread-Index: AQHbH3ogQBh3KGlZPUyf1AdF9m6oWrKK/XuAgAE6zSA=
Date: Fri, 18 Oct 2024 08:59:51 +0000
Message-ID:
 <ZQZPR01MB097931B757AB6481F16BE2D58A402@ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1027:EE_
x-ms-office365-filtering-correlation-id: b73b5826-33c2-4cb7-ab83-08dcef5339ca
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 gO15a14EN2+X5EVujtBpiesoprhYKKTFfuDP8UB1jCbXhahZgi0vyITqmtf6JfS+SltQwQAavYGzPD0Aastva3wG8T66Hlfo2rVLBQvTgneAqtl2BbWUyexZW+MVbM6pVXaPF2gf1ua7BPL6EOaQc4dBjjoo4LUfvFnaxbqFtfJwpnEJvq0URcU14CBS4pi1pl8Jun6xFTLKYkxmdTFP5x3GUbbixXDWyE7Ec4VjP5yL+80HSftzJsYGL3UIO5QT5XUxX3uzSKhLui2iXE4c8XHaWdqkRUMD9TfOaWmqDzoGQkmNbhMO9h5OcXA+ceRvd87vIszo/dA/dHVF6YN1SLnVvESpbGWaP2xb40Vi4MbWwqQhLo7RdzoBLgFP5uJ/NBjXJ6drsv5T929vJ2zDzXSOP12rCs1jvPq6gLsu+DZIw73MZeO3hE9fHRf9HD5kMI/JtTWE0lMgLU2RddWmF4B8horMKh6YcKEkFCOc4+E/eTrHK5QpXc9aF7JmuD9hbEQk2HhFuu9lOK8Nxr0m3evv78LEIG87ei+BmkzNNEhXw2VA3KPTmaMPJuxrt0UNSN4bc5McF0Whrjc5XErog0R9XIipG0lHHDt0lDi2ud798khaqb50FbKmDwJiro3Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/CV4FmZDRYeA/ehO1ot9/qB9pX5XL32YoukOTFVA2wwFmLsauXosowGGYlAE?=
 =?us-ascii?Q?TixPQVU2S0i99cfWn/obNQ1aPa3+mro5Gjb+3zzi0orc3uOmy16CQ9UBo2N3?=
 =?us-ascii?Q?z59InetuhJEqPRZ3BwrQAE03Qk2s371A0TQuCUfJ4NoaUPVHN5uoNqR/FRdo?=
 =?us-ascii?Q?iI4BPXUIgrNHvTcqM5dHwrILCrV3AXIRX4HY/wqzDsILhI2Mugj2vAqx8mCR?=
 =?us-ascii?Q?ueHcB35ts5Ekhr78YxOaqCPPHmxUM/AgEGkUJAdllz30K+Nv2YnPpdQFJAnc?=
 =?us-ascii?Q?C8WEJ/UZMKfrVj3J5ZNjEy0eNLEjGwLh/yXQz7bcVttrvL9XUQ6i/sWcl1ib?=
 =?us-ascii?Q?0eUSwvAXpy4LnooNaFUhi0+A8R7TS3NM9bcYKpZv2BEgDZyrvSa5yMSq/i+8?=
 =?us-ascii?Q?0hYgbmOTdHRinoXdof0Uqh805jasR6lhdW8On+XTx36RNacTFaPVJ+K9lvyf?=
 =?us-ascii?Q?8dD0prAkgsjKUADXuaSVE41H1FTFq5FbIriSvDmKnjHHiQeXIefFMlUh4rH6?=
 =?us-ascii?Q?jxXfKFqCiottF1yQiIoKfG5jOHs5K5b5jFDmeg/KJecQ82M8l5dmawx5grvF?=
 =?us-ascii?Q?VV2hloq/xOV98MBcoSRYEp5euWmC3ktiVjpvrk9W9Q/6HFKQ4yU4kF1qaukS?=
 =?us-ascii?Q?1MuUv3Av2Puh6FvkUcjzIJGPDP2GiB3EDUrKaZ2TPskcuqCf/EqfTlVfAqKJ?=
 =?us-ascii?Q?Uhbn5c97PXqQZSAjkZ6/UTG0yzZ4U0ROoHoK0Qn6N6ZlxHrULlFwD77oFf7W?=
 =?us-ascii?Q?4kU33xtmcirNhB+++9hYaC+gt8cB77WdH0GgGs94+RSzw07zbctsPE5J4fht?=
 =?us-ascii?Q?8Wb+avj7ifHA7flFNZ5PRNlGJbcsN8qtYUU6NbhKooh+GUcGnwvh+IB9elMV?=
 =?us-ascii?Q?C/KgE3aVcdtBOLd/rbQuVMAn54BG6LKM7TST76KFVYWMigLKI9e6o81HR+P1?=
 =?us-ascii?Q?8rkoyBsw+q0GKay9yO2+942WkJnWwqa4EY52oYAXXgp4ZKlbkNacGxCAoIZC?=
 =?us-ascii?Q?akK6ODmGfmH89X5l12er+IuTe/m2Mqc3FOWzeylpqbaFXkiuQwCLAkaB/SbX?=
 =?us-ascii?Q?vMhkSssCL/RopDRx3uBZLqt/l/BzwaoZ4cYdeauJx8Yqb4lO8ZvUkxJJ7INY?=
 =?us-ascii?Q?BXFBCqotF4GP0EiGEqyvxMdfmeb33/m9UEBivzl2Z78H3/svoyDfT8YSpBYP?=
 =?us-ascii?Q?50GYUqjqKITf6D5HTb9MQef+sKDNh0bR2RdO88oi8d7IQcUW8It5Qq3WLTTV?=
 =?us-ascii?Q?XY+DCE/3V2y8BLIeZ59jA+ErQ6zEZeQKdI3obaW6fcPSMtv7GyV0SHX6BKkX?=
 =?us-ascii?Q?gs1JI9YdNaKQbiWnO3ClF7hl3mtRqTBZeSAkOLtg47CFXEg0s7Zm9M0oRZ5i?=
 =?us-ascii?Q?ikUzFlY+/fuxADqx4EBDPVAgTuT4LnIWD7KQuWNSy7c/ToAmFf031eE6kxVZ?=
 =?us-ascii?Q?lb+eaKb0ciCA5wOEuwWvjbet51/NLIf0jIhN7RCbRAgZP0+JTwPmeRG6Jpur?=
 =?us-ascii?Q?+GxDiatBEMxGq7CnY7bHdRMvyHWamVz1TcsM+XzOygc0eKct6qxfinsgfOCH?=
 =?us-ascii?Q?L5aPiSxiH1/4EcqD02cvhtydxEesPyy5+NUhHJGFS0FnWwb2P7hCb4ixI2JH?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b73b5826-33c2-4cb7-ab83-08dcef5339ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 08:59:51.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iXk+XzR4TFqvOk/GlTlja6VGygwVKLAwZWv7jK4oD3DiD1kYE5EZnVT9kHcKJTf0pYwGtVvpxDMWkV5sBTRYgObXLS4S9Sq08kF4luyU1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1027



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Thursday, October 17, 2024 10:10 PM
> To: Leyfoon Tan <leyfoon.tan@starfivetech.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu
> <joabreu@synopsys.com>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; lftan.linux@gmai.com
> Subject: Re: [PATCH net v2 0/4] net: stmmac: dwmac4: Fixes bugs in dwmac4
>=20
> On Wed, Oct 16, 2024 at 11:18:28AM +0800, Ley Foon Tan wrote:
> > This patch series fix the bugs in dwmac4 drivers.
> >
> > Changes since v1:
> > - Removed empty line between Fixes and Signoff
> > - Rebased to
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
> > - Updated git commit description for patch 4/4
> >
> > History:
> > v1:
> > https://patchwork.kernel.org/project/netdevbpf/cover/20241015065708.34
> > 65151-1-leyfoon.tan@starfivetech.com/
>=20
> Hi,
>=20
> Thanks for the update and sorry for not providing more timely feedback.
>=20
> I think that the code changes themselves look fine. However, as a rule of
> thumb, fixes for net should resolve user-visible problems.
> I see that is the case for patch 4/4, but it is less clear to me for the =
other 3
> patches. If it is indeed then I think it would be good to explain that mo=
re
> clearly in their patch descriptions.
>=20
> If not, perhaps they should be submitted to net-next without Fixes tags w=
hile
> patch 4 and any others that are still fixes resubmitted as a smaller
> v3 patch-set for net.
>=20
> ...

Patch 1-3 no user-visible problem so far.
Patch 1-3 will submit to net-next, and Patch 4 will submit to net.

Regards
Ley Foon

