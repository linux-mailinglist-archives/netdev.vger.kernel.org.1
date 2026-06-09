Return-Path: <netdev+bounces-296864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T30pKkd6J2oWyAIAu9opvQ
	(envelope-from <netdev+bounces-296864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:28:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4384265BD9C
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:28:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=LuAcPZL4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296864-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296864-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F0103014241
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FAD3148C5;
	Tue,  9 Jun 2026 02:27:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF641E260C;
	Tue,  9 Jun 2026 02:27:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972024; cv=none; b=BccSaQ2rjpLCGc7tqvlqqbj8dHCJHue6ch98YpNZFozFAAAeke2Hud6s8cMhGSkQWiGqpGR1sdwsJR3G/O/+Tq09g/RT6jgeRdi3X+D8rQEnteb8paidlZJloRhkcOHbV6fsLDk7bD+zdpyC9g03QhkYetQ8WuAajCs1AY65bPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972024; c=relaxed/simple;
	bh=vko80nOW/jMybQS4ARcXFWtsM9umUeBLTZLxgrB/uxE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFcKdqUIDpELZcBay2wNJI9TdZUIFDZPG45NSMr2/OKNizH6q8M/rmNJfe56SgR80NWCLjH+wK+dO1WDPP84RdJ3CnYl7X9M2eoKP/+rC6C+ybd6nR4MheZufpxCdShWLrgQuyTsd9aVrqqSTIS42wYQZx2qa6zcmU/TIa/zn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LuAcPZL4; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6590vabm3832576;
	Mon, 8 Jun 2026 19:26:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Z
	2c59WmhOpR7bb1PKFE9ygKMq1yPvDYcul93vePgmQg=; b=LuAcPZL4LJznsiK35
	HzCnn0IbNfMS2Yn0Hzr5H6qmcxaUqkSQPMZqMHAIUeNEiu3j/+8yy65x52K0+8o0
	jZUkmTmMM6r+IeTLnDFKA9Nv0kvCGy9GTmGoZeXX8tUNvmMPIUoRXETkbOMe3KYM
	ntj62DGDs0n1RBmzZyeZCGeL6xMiFBYydtTPYZ7kcHm6tl5Pszj4GLlQ2NquomKG
	b+EGeKFWihIlCcA+evcOcCpFSz7rgewe35Jmd9Gad8/1yC/eZhgFNZnPR9inxam2
	j6/3YdsRPQOZzbmstflVH369dKS7y2ESa2Ci7frznNauRjxbhVTsHeyAd66+XuVR
	S/fpQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4emgwj21xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 19:26:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 19:26:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 19:26:50 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 1E5403F7043;
	Mon,  8 Jun 2026 19:26:46 -0700 (PDT)
Date: Tue, 9 Jun 2026 07:56:46 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <jiri@resnulli.us>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 1/9] octeontx2-af: Enforce single RVU AF
 probe
Message-ID: <aid55liiG7bcuZ3f@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-2-rkannoth@marvell.com>
 <20260608154014.1b7c8be1@kernel.org>
 <aidvzJEXmeS6Wuz7@rkannoth-OptiPlex-7090>
 <20260608190249.03f4d6e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608190249.03f4d6e7@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAyMSBTYWx0ZWRfX1j0GszHybpio
 rXc7zgufooRrch5cpVOxDo4MrR+hYFJ6s0CrxdV5Rd+ZE97r69p0fmyMn/hw9LQmdrOPOX7WoJg
 hRE5kAOUxZ81vme0OR9d6aiah7YTZ4fy+RR3DohVvNn4WCFCHnXZUpkoyBN+Pva+845T/QkKP/W
 3rUs0nkB9ggq0cFcx41QLTXwsFCDK3fMzs2RPSFEdKPvq3l/pV3yMRKeFE7A+9G5txJQNdgg6nh
 11bEbdwR1S3TX/RqaT3MQSkZ0MIi7yS79s69uIf1iSRnz727PTYnqvz08/5OgGRkuTo0jIVSG4v
 S9O2wy35hPmkfD7Tbjid+HsQ738XRPkZFexYSmVxmfbxZ3BLMfuc55IZVXCtppfhovVxJEMZzoB
 cO761sMw5dKoXD7sGUiTPmsv6a7vbkIck84TL1qMz5EmIlPUWLbhPQQ7n9PhZujzkaTc7VFPx4E
 2OLntKVg9i9gXToB74A==
X-Proofpoint-ORIG-GUID: zTIdb1Wi4HcmFcoMvyIdauDhSsDokeSS
X-Proofpoint-GUID: zTIdb1Wi4HcmFcoMvyIdauDhSsDokeSS
X-Authority-Analysis: v=2.4 cv=Pv2jqQM3 c=1 sm=1 tr=0 ts=6a2779eb cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=EHrT-NBUB3HtyIssriAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296864-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rkannoth-OptiPlex-7090:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4384265BD9C

On 2026-06-09 at 07:32:49, Jakub Kicinski (kuba@kernel.org) wrote:
> On Tue, 9 Jun 2026 07:13:40 +0530 Ratheesh Kannoth wrote:
> > On 2026-06-09 at 04:10:14, Jakub Kicinski (kuba@kernel.org) wrote:
> > > On Fri, 5 Jun 2026 12:02:37 +0530 Ratheesh Kannoth wrote:
> > > > There is only one admin-function PCI device per system.
> > > > Reject any additional AF probe with -EBUSY so the driver model matches
> > > > hardware and automated reviewers can rely on a single bound instance.
> > >
> > > Could you point me to a PCI networking driver written in the last two
> > > decades which would have this sort of limitation?
> > >
> > > At the very least you need to explain in the commit message **why**
> > > correctly handling multiple devices in a system is beyond your
> > > abilities.
> >
> > The comparison to a generic PCI networking driver isn't quite applicable
> > here. The RVU AF (Administrative Function) is not a standard NIC PF —
> > it is a system-level resource manager that owns a single, shared set of
> > AF registers across the entire RVU subsystem. The hardware spec is
> > explicit on this: "RVU has a single, common set of AF registers.
> >
> > This is fundamentally different from a multi-port NIC where each PF is
> > an independent, symmetric instance. In the RVU model, there is exactly
> > one AF device per SoC, and all other PFs  communicate with it
> > via mailboxes rather than accessing AF registers directly. Allowing a
> > second AF probe would mean two driver instances racing to manage the
> > same global hardware state — provisioning LFs, configuring
> > NPC/NIX/NPA — with no hardware arbitration between them.
>
> I asked you before - is this a driver for a PCIe devices?
> You said "yes". If so what prevents the user from plugging two such
> devices into one system?

The RVU AF (PCI device ID 0xA065) is not a pluggable add-in card. It
is an integrated function inside the Marvell OcteonTX2/CN10K/CN20K SoC.
On-chip firmware programs the PCI configuration space for all RVU
functions at boot time — setting device ID, class code, and BAR layout
via RVU_PRIV_PF()_ID_CFG — and the Linux PCI subsystem then discovers
what firmware has configured. There is no slot, no connector, and no
mechanism by which a second instance of this device could appear on the
same system. The hardware exposes exactly one AF PCI device per SoC,
and that is the only device this driver (rvu af driver) binds to.

