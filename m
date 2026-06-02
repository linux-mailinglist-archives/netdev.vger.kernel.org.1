Return-Path: <netdev+bounces-293984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLKuKpNGHmomiQkAu9opvQ
	(envelope-from <netdev+bounces-293984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:57:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341062774F
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16FEE304C2C6
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF7360ECE;
	Tue,  2 Jun 2026 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DzPx4Non"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7A2DEA89;
	Tue,  2 Jun 2026 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368871; cv=none; b=XP4ggh7yX9TMvIntqYJGWjK+wOvxilMOWTBy/C/jO8b8vU3OBVZm8vP0C+GwEyDSCxQeLJkCOckfxQ9HvWjj+xlJQkIWsCIoOqH2sFx+dBDa8r1BdceMrJfmS/4uWZ5pzl/MBM4NEWl8QxcExKVncXq/HgMmesb7FfnhKUeLz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368871; c=relaxed/simple;
	bh=m92JCDq55l9Jfq5JX0ZnwN78RnMoLGL+kEjTMhaNmxI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjdwUg2oz184IwpsEt+PPTWIF28tzplqX1V2bY2YKSqRDekkqV4TlxdSwYfQpS1iuif/Q1LY15sLKKk/DTsq2dmnm1JGovv9cXWApFFAx0WJZcX/FkTjdpu0j035UztRGuCeZ4cHkXAipwEIUCyQL16qSCr8TNVyPdU4Qo48ZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DzPx4Non; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651JkUB52671925;
	Mon, 1 Jun 2026 19:54:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=oiO2WibNLkMUKaFSyIV44WkfI
	LsbtZAPQqWOyLYOgLY=; b=DzPx4Non456lBZzVPHSRnPVyepM45IiEGJa9W0cJH
	u36DjFqcH8vu3ldk1bPzjeICuuxvl1p24wlL/0cq5Tv6ZmSrMozWMPPqTuq5GhWK
	V+s6VQ+eaCUBWww1OorOQ31BWXWuRgb16mNgtvhLR2jtBt59Jxe5/NK4S1yZxBQR
	EeaxCDfWHUqe3eCRb2DHJsCRRLPfINzZb16KTTIhu/ZdRPJLOG/QyvyPKUx5o1iQ
	Y/OcWpd3yM6bCgWEHuLQjSdSgc99NGl9oye5YZbvRe78xeJ6ts/AWuNJheEd7pkq
	GZXNGT1+QQotcvZWJvtkibbvKG+8bB9G2Lz6piCCpHbLw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4egm56nqgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 19:54:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 19:54:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 19:54:07 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id AEBB23F7081;
	Mon,  1 Jun 2026 19:54:04 -0700 (PDT)
Date: Tue, 2 Jun 2026 08:24:03 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <naveenm@marvell.com>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Nithin Dabilpuram
	<ndabilpuram@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: npc: Fix CPT channel mask in
 npc_install_flow
Message-ID: <ah5Fy5HDuMOOnV8X@rkannoth-OptiPlex-7090>
References: <20260601023221.858168-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601023221.858168-1-rkannoth@marvell.com>
X-Proofpoint-GUID: cobwClBDzRyDMsN6X_WqJ1DABhSz9AkG
X-Proofpoint-ORIG-GUID: cobwClBDzRyDMsN6X_WqJ1DABhSz9AkG
X-Authority-Analysis: v=2.4 cv=ZeYt8MVA c=1 sm=1 tr=0 ts=6a1e45d1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=L-Tot5tVp8rV6VoGPfcA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDAyNSBTYWx0ZWRfX7TaN4l+i1hwz
 wRYqlG2h2Kg8mR0gDh+ki41BDY7/vq9tEvwUkgT5yW6E3KG5asqhRVth4/fLbnkPhqxEGNgjRbp
 g69qQJrIthM5d8chFqtK/NX6i01oel4A95Nqo2rH7jPXsbCUslWGnPI/pVeAMov3kWVPoElKYwT
 P7BW7CMG+oQu6TIUUUVVTFgSukIRINlEbU1uyGLgnRkbFLfA9bTAtqg77Zhjf2FlZ61H8KgrDX6
 DyWmXzMQkj48DpAYQTMLw8u6sjiuOXLG5zvci1UALE4LljVTTeoAl8RwQ1XH6wj1ISvE1wRoxB6
 o05Gvbx7fsVrlvGLkpD0LYWpdoaO3vBC98WoBd3pY+0RmtDpldgKKuuz+VkMvY/RY+jOskcZOil
 w3/9C2ldfPlDrYdCFX3rSFL2DP/uUnD29Sb1Ntz9YKkyWBIqjYqMcAyS0sbZ8X7RoM8kcgjb8xC
 BO9ICK5xhtX/9sfeNPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293984-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,req.channel:url];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0341062774F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-06-01 at 08:02:21, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>

>> -	/* For cn10k the upper two bits of the channel number are
>> -	 * cpt channel number. with masking out these bits in the
>> -	 * mcam entry, same entry used for NIX will allow packets
>> -	 * received from cpt for parsing.
>> -	 */
>> -	if (!is_rvu_otx2(rvu))
>> -		req.chan_mask = NIX_CHAN_CPT_X2P_MASK;
>> -	else
>> -		req.chan_mask = 0xFFFU;
>> -
>> +	req.chan_mask = rvu_get_cpt_chan_mask(rvu);
>This is a pre-existing issue, but while this update correctly applies the
>CPT-aware NIX channel mask here, is it possible that other default NIX RX
>MCAM steering rules were missed?
>For example, in drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c,
>rvu_npc_install_ucast_entry() still hardcodes the channel mask to 0xFFFU:
>rvu_npc_install_ucast_entry() {
>    ...
>    req.channel = chan;
>    req.chan_mask = 0xFFFU;
>    req.intf = pfvf->nix_rx_intf;
>    ...
>}
>Since these are internal requests (req.hdr.pcifunc = 0), they bypass the
>override in rvu_mbox_handler_npc_install_flow(). Does this mean inline
>IPsec packets returning from CPT could fail to match these default L2
>steering rules and get dropped?
>Similar hardcoded 0xFFF(U) values appear to still exist in
>rvu_npc_install_bcast_match_entry() and rvu_switch_disable() in
>drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c.
>>  	req.channel = chan;
>>  	req.intf = pfvf->nix_rx_intf;
>>  	req.entry = index;
>

ACK.
pw-bot: changes-requested

