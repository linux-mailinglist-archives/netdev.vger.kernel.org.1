Return-Path: <netdev+bounces-285478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG+KEKfv/GlKVgAAu9opvQ
	(envelope-from <netdev+bounces-285478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:01:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C53B24EE352
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92AF53006458
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 20:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E1D3469F5;
	Thu,  7 May 2026 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="kicT/rUk"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB32E62B4;
	Thu,  7 May 2026 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184099; cv=fail; b=kzNkqsGBxALy3olBnSUutKzo4NUxH9stkRnhAb5g6guUGwJzaezi8NpkHssSxmbxDT2Cvbl3nVH87KrY3HPGLQnoqpEnWxHKpFlAeUWdoJrVsxLkpxrbpzhhJEULdpkdl7wl0J2EkY+N21YYCRM82f/eiF6zwXX8m1+dlfga4fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184099; c=relaxed/simple;
	bh=WCP/t7uUv8P+6yJG1YvcH4dkAPbC8Q4XKJyOfXFU2WA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgxF2MsOiCukuziiXYFDHOE6HX5CrJ0wxTdjt3mNZjiSngbZpxK+vH0p/fRfyUHyc6chSBVVfN1PPH6+XlxEZEQvll/4u0A6ADi6+dESkPo3m7WwbSZ9iA4ipQgHEVqDyOtfYzlosLyzHGgJrBuU0zydrHSVlDCzj2YxNn1/04w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=kicT/rUk; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyVS11n3jsVaahVl5Jyj0axE4cg85CcopjSW8PTsp4+h+J+TLlpvtd9okICAiCCwj8L8qLlj+AYHDau/rMJB++rqG5AlUgOEbv3RFb7WclPSAT1MZC4oqlvhBICS+v9q9LoF71jiUDaDFfuZgrTWhdW422DK7IrDv4LQj+g1oxU7/mDpJEUFSWms8UME8bQ44vy/wvVW3pq4i1fnNLD1lTXtxPonRKRPxKqsubTsFqPWImESXYp5AJizxTqDfiQn99FV8o6JVSYln8I88gckRBLpDWfNPWmBW7ME7DQqUF9qqGTdKzZQ+SKVCyPcVBuab7Tv/486Lt6FMx5Juyq/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHkHczDMtIv/UUY1yxo5hUfCNufR3AcfFOAB9N1AkdE=;
 b=cZNaoX7tE7OiENrOs958li1uMTNiDAa5ZG9KCin/l4koOLJNdaeyYCJwmx+bzROj+U/0+vuYvsvnsyywCG0Mpb4aXwBur3wquURcEGyGnI97D9B4ylGhhhJ60DGTd1CQax7pZoj9Bw8O/0dEROtBgEqHEgWVxqYeAgkRpO9ZO4O/dTwWGkuGgevmFURur7dD5P9s186mMJoh/CHb4hhgfj221V/S7/88J4jZGAs/SoAKbAJ9ad0BowTSO1P+GUX+XC2GxdyygO+gjRd/3qOK+5GL8TlIY0aoHSbu+ZhB/sgrAJCzDIk9sUNgS/d7ZK/izbn57sSb0UR86upr9GJwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHkHczDMtIv/UUY1yxo5hUfCNufR3AcfFOAB9N1AkdE=;
 b=kicT/rUkEbxOexgFuxmiZ2eNMQz1rKdLjx/7B81LdP7GHU2vl22dLfcLee1lsj9NWJAjFGYb06ggKNs4AIiEoUx1cYS68WvavfV3a/qVP/0FSwbDZUx6VI9xwi/c6c/DnscPn0qSB8TaNGwdQeU/oSZ0QhYWkQmcQ5Z2zAVN9bTdzWw6lcr3AbyGW7hby59GYSoyHzlts1+AsXSf6jzSNLIsjn4G1+CgKTAzHTIu916Y1XD/ZIN7rwMludZuaNMo8xIIfd3O5C6iu1qOmRw3kVnZwAUZzGR5RFesahw7UCtpOZF58EKIDgLCtuYuVByteLo3oTPZN0C7WYwMJhR8Ng==
Received: from AM8P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::34)
 by PA1PR07MB10245.eurprd07.prod.outlook.com (2603:10a6:102:4eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 20:01:33 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:20b:21a:cafe::a0) by AM8P191CA0029.outlook.office365.com
 (2603:10a6:20b:21a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 20:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Thu, 7 May 2026 20:01:32 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 7 May 2026 22:01:32 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 4D3C74020B41;
	Thu,  7 May 2026 22:01:31 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 377491005C88; Thu,  7 May 2026 22:01:31 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <marek.behun@nic.cz>
CC: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.eckerman.ext@ericsson.com>, <fidan.aliyeva.ext@ericsson.com>
Subject: Re: Re: [PATCH net-next v2 0/2] mv88e6xxx: SERDES on mv88e6321 letter
Date: Thu, 7 May 2026 22:01:09 +0200
Message-ID: <20260507200109.3726627-1-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <dxxmuzte6ntiimozgmafsx75at7zf4mm3kg5k5dgsnlnrfl3eh@yurunqpyb33p>
References: <dxxmuzte6ntiimozgmafsx75at7zf4mm3kg5k5dgsnlnrfl3eh@yurunqpyb33p>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|PA1PR07MB10245:EE_
X-MS-Office365-Filtering-Correlation-Id: 946ba447-af53-419d-0c94-08deac736f78
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EazdjrCXRCa+aJweDLD01ED+/QTmMURx4TpcQNPooC+Sf2dLetAjE00r9qdYLJEcvXPYk6JXcGIeVfZYOeIKrzCdMvA2d0X2rEJr34VvRziJYEDkt/t64AjuMmGDx8gFGUu/ZKTOUGsUOf178Gb+K1/C8Ez82MA7yQtMs7oAyduumDNrtJ22lkyIV3aApwTPH2PWi4fMdJJdmiX6X7A1uVreM/02f0vJkFxacLdeqdN0KF1V512ysu9IUjkgXE0mLoJQ5JTir2ZnN5nyrR4TSm5Wx4ObfF2LqVqob38hyRGp4Qy1any5llvEB2XkZBJgyEjrtVWv9a9OSIB/hMeH+kl4pg7XD6XPpbuvLJb51bp9oMqxJhufF053gYAErcK+2AdKBiLVzt1thJELQzF1366TN/DtIjhYsqzP/YjItaMS1+eRMU510zgYfLmFdhEdqJUZygUNivpVwSla+KIuWRh+cwaWR/Ug7Kcju/rTSCBFBgkjcQT4Pr8cZDFaYTVkTZL00ZxepQCILMA96bJeEp3OLpC4J5GzVco4sEUxEyOQfr996t6edahQx4kdFQYiuhPIU113m5gqCCfm4hwwiOLpPCu9OyHMo8pPQd2BArsB79QRpVg03ohzkkH+teWLNAAbs9nz3ilg9zLgvlaV34Ps8qL7F+l5ULKNvtTpUuujkMEi7UDhVSw5UIgWtduo
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c59fPNdTEbl/RR959DoIA64i+e9IS2u0AIoHCtUlVYvIm4CQQYJTyXbSNOJnMUDIPbLdwwgPYdE87t+GOt7M4FPh4RzzHuV6cwd9CuYjz+cezpfsZVL0EJXgPZOrH23pbEs3LK5GYNWcheOLAL7DFh6sTyfImNzmYa+XrlOegMB7pj137oqy6EaxnskHp47IHSZVF+6EXgsStcHfNjzuQ3VnOweY3xJ9unCYrdib6aPpjfN/1VbEzgt+PQ/5jJnPg2SxjxySy0pXLMLIxLq/jMccUydPkOcjtqiUWWCcSEmuGkZPr1L1toGmjN/iNGuZzCc1DHHawZ490NrsqKAiVeIx2bVLsT8GDD6HF3SbbAYmDHNAZNF4DWsO/u35lmNz+Xjpue8pH85irp0fK42jJItQ5lJnMLzhr0DS8fGOiqhhwxBXSnC4zY9VINmzpIHs
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 20:01:32.3977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946ba447-af53-419d-0c94-08deac736f78
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10245
X-Rspamd-Queue-Id: C53B24EE352
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285478-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,ericsson.com];
	DKIM_TRACE(0.00)[ericsson.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi Marek,=0D
=0D
Sorry for the late reply; the email has ended up in the secondary inbox.=0D
=0D
I am interested in your patches, actually. But since your patches add=0D
further features, I think, it is better if I push the patches, first and=0D
then you can rebase.=0D
=0D
Best,=0D
Fidan=0D
=0D
> Hello Fidan, Andrew,=0D
> =0D
> last year I worked on 6320+6321 serdes support, but never send it due to =
different workload.=0D
> =0D
> Quickly looking at your patches, there are some things I think are missin=
g in comparison to what I did - I have 5 patches:=0D
> =0D
> 1/5: drops serdes methods for 88E6172, which does not have serdes=0D
> =0D
> 2/5: is similar to your patch 1/2, adding serdes_get_lane to 6352 family.=
=0D
>      The difference is the implementation of mv88e6352_serdes_get_lane(),=
=0D
>      which does not read scratch register. Yours is probably better in=0D
>      this regard, but mv88e6352_g2_scratch_port_has_serdes() is also=0D
>      called in mv88e6352_pcs_init(). So maybe this is redundant?=0D
> =0D
>      Also, I rename MV88E6352_ADDR_SERDES macro to MV88E6352_SERDES_LANE=
=0D
>      to be in line with other such macros in serdes.h=0D
> =0D
> 3/5: extends 6352 serdes pcs for 6320 family.=0D
>      In addition to your code I also implement .serdes_irq_mapping().=0D
> =0D
>      These depend on other mv88e6xxx fixes I forgot to send, which I=0D
>      will do now.=0D
> =0D
> 4/5: Add hidden register access methods for 6320 and 6352 family.=0D
>      These can be used to change SerDes modes.=0D
> =0D
> 5/5: Add support for changing between sgmii and 1000base-x on 6320 family=
=0D
>      via hidden register acces.=0D
> =0D
>      This was done by reverse engineering hidden registers (trying=0D
>      different values), since it is not documented correctly.=0D
> =0D
> Would you prefer for your patches to be applied first and then I can reba=
se, or would you rather like to look at my code first?=0D
> =0D
> Marek=0D
> =0D
> On Thu, Apr 30, 2026 at 02:49:05PM +0200, Fidan Aliyeva wrote:=0D
> > This patch series add code support to be able to use SERDES feature of=
=0D
> > mv88e6321 version of Marvel mv88e6xxx series. mv88e6321 has 2 ports to =
=0D
> > support high speed SERDES but the support is lacking in the driver.=0D
> >=0D
> > mv88e6321 version has a similar architecture to mv88e6352 version =0D
> > making it possible to reuse its pcs functions. That's why the patch =0D
> > series consist of=0D
> > 2 parts:=0D
> > 1. Refactor the serdes functions and pcs_init of mv88e6352 to be more =
=0D
> > generic 2. Add the SERDES support for mv88e6321 reusing 6352's pcs =0D
> > functions=0D
> >=0D
> > The final code has been built on top of net-next tree and tested on=0D
> > mv88e6321 ethernet device directly by ip ping tests, performance tests =
=0D
> > and also verifying the switch's expected register values.=0D
> >=0D
> > Referred document: 88E6321/88E6320 Functional Specification=0D
> >=0D
> > Code has been built with allmodconfig and allyesconfig. checkpatch.pl =
=0D
> > was also run=0D
> >=0D
> > ---=0D
> > Changes in v2:=0D
> >   - Removed 6321-specific pcs_init and made 6352's pcs_init more generi=
c=0D
> >   as suggested by Andrew Lunn=0D
> >   - Added the correct mailing list=0D
> >=0D
> > ---=0D
> > Fidan Aliyeva (2):=0D
> >   mv88e6xxx: Refactor 6352's serdes functions=0D
> >   mv88e6xxx: Add SERDES Support for mv88e6321=0D
> >=0D
> >  drivers/net/dsa/mv88e6xxx/chip.c     |  8 +++=0D
> >  drivers/net/dsa/mv88e6xxx/pcs-6352.c | 12 ++--=0D
> >  drivers/net/dsa/mv88e6xxx/serdes.c   | 87 ++++++++++++++++++++++------=
=0D
> >  drivers/net/dsa/mv88e6xxx/serdes.h   |  5 ++=0D
> >  4 files changed, 86 insertions(+), 26 deletions(-)=0D
> >=0D
> > --=0D
> > 2.36.0=0D
> >=0D
> >=0D

