Return-Path: <netdev+bounces-260349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJscLxpEnWkMOAQAu9opvQ
	(envelope-from <netdev+bounces-260349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:24:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C05418263F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6AAA304E330
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359642DB783;
	Tue, 24 Feb 2026 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JOaL5E3R"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134653EBF1A;
	Tue, 24 Feb 2026 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914255; cv=none; b=ll4WtdSne9Iwsa6F//KocZu9LY95W7LIdGMFUPkoo1gztwtmqWZ6RctN4ObDgU58miNbcl1feFUlkTTHJ04LjZNQ26YwEFV2VawT3rUoQ/72tpw3EL5KEkDib9GrYvPEq0OTUCUQ7+G7LIZ5BYgm/07yaPzWboq6ckTQQmosCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914255; c=relaxed/simple;
	bh=nKLnHTavugGbir7CER2T7zO2lMEVl9bwHIddpa2F5ng=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ4cYyRX6BcFgAtC10tg+WhVppZI01iRDxtqc5iJnOrXO3iDv6OO22Id4c+c2C4J5PK9jEw3ctapwRWiZnQd9A99w9CkDoUQDQ/AmRKlm55On+pqVeuixhjWZPaXWui1eiwcgevhG2PfmhguJXK9yPLDe6MNn7TNKVuDcTLz8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JOaL5E3R; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NH0C2B4068859;
	Mon, 23 Feb 2026 22:24:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=yQ87mrpjiyT3jYubyaOk+T3Ay
	nnl5M7ryJPNqTqcMPM=; b=JOaL5E3RNRnLli8slTDmW58KHujrxPsuxHlWGu7X7
	p9RUrbnoFIy3SCDgK9BP+xgw8qKQ6I/J1qoxf7MG2wuJZ2pmBAhGfqhm/tBWPpsQ
	yt61+D2n5KnqGbFNVIyq6Ape1hqlPeKsWOiqB6txGy68zgONyNMukJpNsoUuX+P4
	eptYZOI1iYuMDXpP5glqTGSKZyXRdGOn0EPY1R3v7RHw75otShHWB2gD2bp0L6O/
	ER3Xt0x2Ni+WFeHKHnN3n9VvmyTyUtxv1mNtMRu6EE1lhnB0CzSY9cdcA668v1sS
	tllX3Ca1WXN/qU+xR37D1xCzTOWY5tHrQCN6UZqWKXs6Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cg1ubbys3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 22:24:05 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Feb 2026 22:24:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 23 Feb 2026 22:24:04 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 9C9553F7099;
	Mon, 23 Feb 2026 22:24:01 -0800 (PST)
Date: Tue, 24 Feb 2026 11:54:00 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <edumazet@google.com>, <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sumang@marvell.com>,
        <sbhatta@marvell.com>, <davem@davemloft.net>
Subject: Re: [net-next,v8,10/13] octeontx2-af: npc: cn20k: Allocate MCAM
 entry for flow installation
Message-ID: <aZ1EAJN7tDu-xPl9@rkannoth-OptiPlex-7090>
References: <20260202074607.2535569-11-rkannoth@marvell.com>
 <20260205022527.2271205-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260205022527.2271205-1-kuba@kernel.org>
X-Authority-Analysis: v=2.4 cv=P7Y3RyAu c=1 sm=1 tr=0 ts=699d4406 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=BwxlUtVFPHS1Afr9MAEA:9 a=CjuIK1q_8ugA:10 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: z_J5ehGgnZkkTwWFEIs8Obxz2u6LKu0f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA1MyBTYWx0ZWRfXwu9t7G+kIWHa
 XMUee1+rJGLIHWSjGuRR4DZsXQaHWMvviwMa5n1OyjRIXvi45utWODzMhN31YLlvQk2O+GVec+Y
 yFB5xmXW3WyvKvw5xFGhMYs62/ujlXvOwS8bOB502Uoi4ZSe6LYr5xsi3HTMaEQelJ4pC2Kfq9u
 RduAwkKGnTBuTMxZlqAosgjKnVHqNHkcueMozAZpoHgAYP6tXyE9R0MI5zeg4hT0YuuZ7DT7bTw
 L4JfSvjV42pxybTMjOu65+qpKDihdK5nXNao32M/s2ASKD/0Ihk6XpefGmLevCM0K7SCAXb8MCQ
 rlYGhHlplUdDZ6LYOpicqTQ9Jwo9E9QaM/ynQ+k9M8UgH/dWh2z7sLu+96RoKRyBP4qd7u6LvI/
 kg4x8FXOrD5j9CzGyQJZyWeE+HOpUtBoSiVw8mUtWc3hwU7EZTFBl7URZ0mG+jr1LlMmXcwP8pb
 KnZxVenHfs+lT1SjVKw==
X-Proofpoint-GUID: z_J5ehGgnZkkTwWFEIs8Obxz2u6LKu0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260349-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3C05418263F
X-Rspamd-Action: no action

On 2026-02-05 at 07:55:27, Jakub Kicinski (kuba@kernel.org) wrote:
> >  	cn20k_wreq.hw_prio = req->hw_prio;
> > +	cn20k_wreq.req_kw_type = req->req_kw_type;
> >
> >  update_rule:
>
> Looking at npc_install_flow(), req->req_kw_type is copied to
> cn20k_wreq.req_kw_type, but is req->req_kw_type ever initialized with the
> computed kw_type value?
>
> In rvu_mbox_handler_npc_install_flow(), the function
> rvu_npc_alloc_entry_for_flow_install() computes the correct kw_type based
> on the flow requirements and stores it in the local variable 'kw_type' at
> line 1746. However, this computed value is never assigned to
> req->req_kw_type before calling npc_install_flow() at line 1887.
>
> As a result, npc_install_flow() uses either a zero-initialized value or
> whatever the PF driver sent, instead of the AF-computed value. This seems
> inconsistent with the commit message stating "the AF driver determine the
> required NPC MCAM entry type." The incorrect req_kw_type is then passed to
> npc_cn20k_config_mcam_entry() which uses it for hardware configuration
> mismatch handling in npc_cn20k_config_kw_x2() at lines 956-960.
req->req_kw_type is used for different purpose. I believe, this comment is invalid.

