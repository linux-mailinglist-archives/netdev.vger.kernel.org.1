Return-Path: <netdev+bounces-295583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YcQVKZcvImp+TgEAu9opvQ
	(envelope-from <netdev+bounces-295583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:08:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A31076449B9
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:08:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=ILUzFQgG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295583-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295583-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC2F9300C7F3
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718173C3C14;
	Fri,  5 Jun 2026 02:08:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DA3B7742;
	Fri,  5 Jun 2026 02:08:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625296; cv=none; b=nEHkeI0NLtw5NRQHOsQZtBVwSocxkNNrjINbz9yuymGVHS1RxZBS9EYXc3M5QgyqFNTEdlFPNxVPVonSExeCgiy2vh87/j4xGU3F09vnuOEGrVwabG/K0cmodT3iXIWlV6BT0qf+tTsSGxrYLrfRzKGaNKR33SC06QYNfFF9oDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625296; c=relaxed/simple;
	bh=RP+KK3kTvtjU7y6vN6ZSR1dsVfQHTDuokW9b9l+umKQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRa67EDm52QIuB1jR1HW6ZppSMtwdwDrBjM0eK7wuXwLx8ceSjAOVhMMoVQZa9g2wGWeleD6EpWF8xnld3H58lKxeMVTpWtQSj0jxSbK4v/GQtPDzyw5IeWf2aUPYjHIn88csDsvT9oTyqj0X2fT31hEvMn0KR2fwTJBWzU3ITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ILUzFQgG; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654Mw3dt3656299;
	Thu, 4 Jun 2026 19:07:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=RP+KK3kTvtjU7y6vN6ZSR1dsV
	fQHTDuokW9b9l+umKQ=; b=ILUzFQgGt7VgGByMTqJ/Nasvkbgx58ZQMruQJWl8d
	yHQA4UeN9h17Tt4bqF/mjvUEZXUiDSw50vOAIK4grVG19JsFmgbbaE0w1NRxZI6h
	bl969Ga+PTI5w0QoSNA42A2HQ/dBBPMBTRr0CO1IuHXIN7a57JtZY4/N/dWK0Tr5
	MHocwRnEMF0pp9zpiNvio6JbpQY9yysM9+ClrK10JvbZj8+sJhLsyoeIeYMj6lN6
	mGleXvL+c2YBKEA6apKzBYdufnHhg/yA9hp1Z4pGa+j6XZWRhTjk0UOeYbZHKojv
	Lv0XBO4WQfBePan/6LjVF8CkGHpTKZTXjbgozCKJwjUHA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ejgsp7mkh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 19:07:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 19:07:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Jun 2026 19:07:26 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 325273F70A1;
	Thu,  4 Jun 2026 19:07:22 -0700 (PDT)
Date: Fri, 5 Jun 2026 07:37:22 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <jiri@resnulli.us>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 1/8] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <aiIvWtAqpZjVUcys@rkannoth-OptiPlex-7090>
References: <20260602060359.1894952-1-rkannoth@marvell.com>
 <20260602060359.1894952-2-rkannoth@marvell.com>
 <aiDgvzA2pe8FXJOL@rkannoth-OptiPlex-7090>
 <20260604074527.702f7a3c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260604074527.702f7a3c@kernel.org>
X-Proofpoint-ORIG-GUID: h27J26t6kaDnvKS0u-O65gFqvOl-DmZm
X-Proofpoint-GUID: h27J26t6kaDnvKS0u-O65gFqvOl-DmZm
X-Authority-Analysis: v=2.4 cv=FJkrAeos c=1 sm=1 tr=0 ts=6a222f72 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=DFV-F9x1WN6VVSyra14A:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAxNyBTYWx0ZWRfX/7RcIvPACr0D
 V+vb9mzB3aqjCzhKVuhhRyY/BPrb1FkNwK7GARK1PXpkOepwsXxxG216JyM+GCBPoEte7Eiuncc
 fi3Q+zwmPkZ4kNeFqL15yIHUDYxQ2F0ErfdhE1479xuIAqmbGf+3s7VfJsRTIY0iL5+NklyKcra
 Cn9Whyh8KZmdGad71jzhlpsxk0cO1hNCD2rsE5ysb6sioi/R8qRNfJ1IR1GyvXyfys3MCo9IAwN
 sk3oMoE7OvL0193rOPJpLelqYvG7dMdxRaQ84BCcdVih9AxQfBMa65KHB+/fsu14PMC3Fr3s9ND
 7YMBBm4i1ciB4euQbvgHuDTCYi7gUo34MxBAUNirRSn8YqBn04ti0+65Yx7n8gLwbFkaEpGxMWL
 AC9c6R1UovOJFPAVi4WcQrOUaNDS+yvN43H+NYywrznueiQbhDnGs1UJkcOeEf8FfEp+4T7b7ul
 UpcD0ijUH8kJbedcNYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295583-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:from_mime,marvell.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A31076449B9

On 2026-06-04 at 20:15:27, Jakub Kicinski (kuba@kernel.org) wrote:
> On Thu, 4 Jun 2026 07:49:43 +0530 Ratheesh Kannoth wrote:
> > There is only one AF device per system. So this case wont happen.
>
> Can you explain why? I thought this was a PCIe card, not an SoC driver.

This is PCIe. Firmware creates only one AF device. I will add a patch to
reject any additional AF probe with -EBUSY so the driver model matches
hardware and automated reviewers can rely on a single bound instance.

