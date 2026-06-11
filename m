Return-Path: <netdev+bounces-297895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pyxuMI4dKmrdiwMAu9opvQ
	(envelope-from <netdev+bounces-297895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:29:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFD66DD44
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:29:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=MFnPN2Wn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297895-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297895-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4782A30D218D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC72DECBA;
	Thu, 11 Jun 2026 02:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AF27280A;
	Thu, 11 Jun 2026 02:21:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144486; cv=none; b=nPcw7OS9RsH2vMksyE9VNPlGdV2kbYzVaeWeslkvaO/4H6Xeo0kapY2zutn96/UaF77pXD2TmmgyOEhEZF/VOGB7I9ubaz3ZDY8u9I91I210SMoobriHfJ/sm6TzS2IrB3v6zT4gE8rFnYiPGOruGObNFWIDUC8t5uHWkfpXsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144486; c=relaxed/simple;
	bh=tYk23MUAo/OLs76m8Vgozo8ADt9rfsnI7DjIGL+ccT8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDIVybkahpR4dAuwOk+qmQ9ayyz59Irm+wukJr9y/HY19M3zNcsr4FgL17TP7s8ADdkx5HxaFhgeGwJeDmjgw8JvK9CxPgEHKLIxeFX2G2FnguLrYO2wd/3NvS+zDTaCoY9A1eDcL3+/cgERWxBcgXGBoBww8Lo4ZaZi9sbN0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MFnPN2Wn; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B0QieJ856212;
	Wed, 10 Jun 2026 19:21:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=gPWOTvOaeU3vMfl5HZn3Vt/iN
	KFzOk4MRZ3or2O0h7Q=; b=MFnPN2WnkkygpF2lYDi6nvnLlr0igV72Sr78lT93c
	aLuM1OFTjpJM9xFQUvcG6WDvck6u1nSp41LZXCJ5jGUcoyRcaCHK4Fxh/2GOeLqi
	5vai/5bdDHrZdIyfgpBxydFAkSA5qn3lccIEAuTaVK3ynwtvpHU+suBe6xD82E5n
	MFEPwaVu6Hh1l1ybo4lAqmtDf7ohbGlgRmtwCM6yPC5KeUFw9OMqSS0PY7IC52XQ
	f7nYnlEDWSch9hSkyAzpZ4G3hLjLbk631fP2o3e0VuqKVGug5tV2C0DLARorJyM3
	JV8QCv8yRRCQ4+b6fAJuFvwr4Tnj3CjPOvQifrGdO8cyw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5r95r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 19:21:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 10 Jun 2026 19:21:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 10 Jun 2026 19:21:13 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 45DB93F704D;
	Wed, 10 Jun 2026 19:21:09 -0700 (PDT)
Date: Thu, 11 Jun 2026 07:51:08 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Yuho Choi <dbgh9129@gmail.com>, Sunil Goutham <sgoutham@marvell.com>,
        "Linu Cherian" <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nshettyj@marvell.com>
Subject: Re: [PATCH net-next v2] octeontx2-af: Fix PCI device reference leaks
 in debugfs
Message-ID: <aioblJqQctA_9U8y@rkannoth-OptiPlex-7090>
References: <20260608165546.61347-1-dbgh9129@gmail.com>
 <20260610083544.0da95356@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260610083544.0da95356@kernel.org>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2a1b9a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=Z95VTZn9w-Wqrz_X0bUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: UuTf4h-mrskwgUx58izXDYx4QxcRFjCR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDAyMSBTYWx0ZWRfX8xhScaJhbvmh
 S0hKae0ZxFLaM46+HzBnwE3PHjo3iyiUiggC58BSN0lHBm38qPpHKeTg3BArRuoZKgbZWq3ezaq
 OlhbL1zEQchZZVJOsOr2hx1X3l4WDd4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDAyMSBTYWx0ZWRfX4f3XyLjlTnsz
 /5Mtc1r0ejnJxTKX0mbtaKkbk02E633Sv3zG1BPqXf3clIOkAdPQKo1X+LW4rTbU18k55d1folI
 /PrR09yaueTifzgDs1TBVZ9FJALxAKDNHmio9roQpnK0J8QMmBZSGd86RCTdFjFenhLAmZSPW7h
 fSAeHBL2/CIEKX/LEbR2llJfpXlKIkDqtdiYeuhLHc7DHlWJtdqzRsBAXfzdgHAJIPIlmtXKqhS
 /PMNXwpkd9aVZxpORZzPTORx1bnFbKw0R6BjgaWaX7wNq1xHc3jcj26LxV2garHf7hfk++phKhI
 KmincD306/OKc38vzFvWrkcar5JdFxdsWk1Ky1GTTUmqduuRdJ2uZmAB93V72wyeA00gD/uSJdq
 OD2e8vN9n7j4id8u4fFma7BYkEvbBTGA4qLn2tbWd68GdkwddBs+kg6xRodKkPICyrxmtX40k+D
 zHqJTvKVzzk4FG49zMQ==
X-Proofpoint-ORIG-GUID: 6iB_G-eA3jfqs8dT9K6P3UBj8b1lgNHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297895-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:dbgh9129@gmail.com,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,marvell.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CFFD66DD44

On 2026-06-10 at 21:05:44, Jakub Kicinski (kuba@kernel.org) wrote:
> On Mon,  8 Jun 2026 12:55:46 -0400 Yuho Choi wrote:
> > cgx_print_stats(), cgx_print_dmac_flt(), and cgx_print_fwdata()
> > look up the RVU AF device with pci_get_device() and pass the returned
> > pointer directly to pci_get_drvdata().  pci_get_device() returns a PCI
> > device with an elevated reference count, so the lookup reference is
> > leaked on every debugfs read.
> >
> > Store the returned PCI device pointer, check it before reading driver
> > data, and release the lookup reference after pci_get_drvdata(). In
> > cgx_print_dmac_flt(), release the AF lookup reference before reusing
> > pdev for pci_get_domain_bus_and_slot().
> >
> > Fixes: f967488d095e ("octeontx2-af: Add per CGX port level NIX Rx/Tx counters")
> > Fixes: dbc52debf95f ("octeontx2-af: Debugfs support for DMAC filters")
> > Fixes: 49f02e6877d1 ("Octeontx2-af: Debugfs support for firmware data")
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
>
> Marvell, please review patches from external contributors promptly.
>
> Review question sort of based on a Sashiko comment - this is part of
> the rvu device driver, AFAIU, does anything prevent the AF from getting
> removed (via sysfs for instance) while this code is using its priv?

RVU AF driver's teardown sequence prevents the race here. In
rvu_remove(), the very first call is rvu_dbg_exit(rvu),
which calls debugfs_remove_recursive() on the debugfs root.
ASFAIK, debugfs_remove_recursive() will block until all active
readers (i.e., any in-progress seq_file read callbacks like
cgx_print_stats(), cgx_print_dmac_flt(), and
cgx_print_fwdata()) have completed before the removal
proceeds. Only after rvu_dbg_exit() returns does
rvu_remove() proceed to free the rvu structure.

A better approach would be to pass the rvu object(rvu structure has pdev field) while
creating the debugfs file itself, e.g.:

  RVU_DEBUG_SEQ_FOPS(cgx_dmac_flt, cgx_dmac_flt_display, s/NULL/rvu);

This would eliminate the pci_get_device() lookup entirely. We
will post this as a code clean-up patch to net-next.

