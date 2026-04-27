Return-Path: <netdev+bounces-281216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCUcGRbc7mm+ygAAu9opvQ
	(envelope-from <netdev+bounces-281216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 05:46:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B79CC46C90B
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 05:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 630F6302BE0C
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 03:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254436604B;
	Mon, 27 Apr 2026 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D5A2/YjF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2983603ED;
	Mon, 27 Apr 2026 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261492; cv=none; b=XLRBZwVDKCKB3BZ8aebZAXkh/DCtr2MzgH9x/haxoslCVvwbDKL3VJMngAdrm3G57O9+Xw67FPCiN8UC9Pc5V7lYuYZuEGML4wNqHMc1QW+6cw0BbsB94capOeJs6VYxGJRcXZRgpvc0d4uH1dLvH/5T9DUX2XgwQMmvauOKMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261492; c=relaxed/simple;
	bh=DjjzljK6QCfYTk7i6ALZZdWaKoEwThRKqqwyezTAAk0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pppzrlW+xgvaBXlWGF1RvZhM8ldjpC8XQoV/YH+wTFYqAdcgDpIMr1+F3JpbmfwxDfmP9YpM8KBwklEgd4WGHHK7Mr0QAERBgYJxhM9FKes+TotRAEksCgfwdIT3GJBq0pIXZ8zQ7mu/SbMLwjlDUyDgV31kZcGw7zz6q6iTkBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D5A2/YjF; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QNRP5O3361154;
	Sun, 26 Apr 2026 20:44:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=jmXzW/9ergVVXxnR4i8fLtQap
	6Wk7wEIk/MxXvipDkg=; b=D5A2/YjFKXiRXaC1iVjY7P/cVuoKWXWq92J/jpYAl
	gdTVd04umy7Tmsq7EMdDQvruiIatUdoC+5gD12TA+0olhjYlWFnlw8+G8imXoAOo
	x8wp6cMYk9REdfRnv8nntDXEzsdWYJ7lLZ4N1OGIRG2HadIjL2PNWWsMv7XaSQMx
	1ub+wLe9ze+OA2I/ZZNXBIu3YgMFowNqUNVfjndFzxKnhqvZYEsSG8tCN5JMcPTb
	kN26DxMj5UhVfHWoI9vxQkXXGPXNltSDUb7pHsReO3QLIv1xnho3HgGVAnXZJ36u
	/o/Xixaw8eYjIP9Psf7V3bBNNrOKw5dJg53UvEDGeLHSw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4drtypatw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 20:44:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 20:44:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 20:44:39 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 4ED493F7041;
	Sun, 26 Apr 2026 20:44:36 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:14:35 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>
Subject: Re: [PATCH v3 net 06/11] octeontx2-af: npc: cn20k: Clear MCAM
 entries by index and key width
Message-ID: <ae7bo7eygVdO2Nn-@rkannoth-OptiPlex-7090>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
 <20260423104317.2707923-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260423104317.2707923-7-rkannoth@marvell.com>
X-Proofpoint-GUID: wzq_6hbU1_Qggug6IMh6wPKMnGHz1usZ
X-Authority-Analysis: v=2.4 cv=UfJhjqSN c=1 sm=1 tr=0 ts=69eedba8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=DcqBr4A31Lbc6qTczfsA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: wzq_6hbU1_Qggug6IMh6wPKMnGHz1usZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAzNSBTYWx0ZWRfX2t5vnF2vVv0C
 oUNDuHF3BRbwEvOr9TDwoyKkN09FWtrVl6bM7RQWXh42+YYuzxbhZvVqOvc78aFXR9kHkHTp/Rw
 kC759pM3f+wkMi+O696ZypAzuopGhvgiCTTHSUByYky2FaM2bV5f0Yd3SDQVPE1+HrU1Um9xBSu
 qYqpow2Ok3/aydaHGp1tWTDg2JjiWw17iEPqyB4rtqQ7ZM8bkacv0UMcOjlJL9eB++Iz0OPFgOM
 BoOQqoFzGl+PAtSMFfVDnRBjGX+k6kLf3aPPSlT3oSYb1gEGPQxTksIjjt8VGzD/mE7/2Ck64Bg
 R9hD6SSxGZBeIRU00Vc5nBAmY5K0yiYXfdTNU+IUpbRlkUpbwscPWYZ6uB4YkBA3sf5tvy2bH6Y
 B+EYoJuOMGj1HhYPAPeQ7H6A24B3PpwLq/Eb1BoUKXmZW88nI4aJ5ET+N6Rr5jk563ZOxa7YZlb
 1pibE8Z9o3GrObuHeKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: B79CC46C90B
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-281216-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,marvell.com:dkim,marvell.com:email];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-23 at 16:13:12, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Replace the old four-argument CN20K MCAM clear with a per-bank static
> helper and npc_cn20k_clear_mcam_entry() that takes a logical MCAM index,

https://sashiko.dev/#/patchset/20260423104317.2707923-1-rkannoth%40marvell.com

> @@ -755,9 +762,15 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
>
>  	/* If the corresponding PF's ucast action is RSS,
>  	 * use the same action for promisc also
> +	 * Please note that for lbk(s) "index" and "ucast_idx"
> +	 * will be same.
>  	 */
> -	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
> -					     nixlf, NIXLF_UCAST_ENTRY);
> +	if (is_lbk_vf(rvu, pcifunc))
> +		ucast_idx = index;
> +	else
> +		ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
> +						     nixlf, NIXLF_UCAST_ENTRY);
> +
Should this LBK VF handling also be applied to rvu_npc_install_allmulti_entry()
and rvu_npc_update_flowkey_alg_idx()?
It looks like rvu_npc_install_allmulti_entry() tries to skip LBK VFs but uses
an impossible condition:
if (is_lbk_vf(...) && is_sdp_vf(...))
Since a VF cannot be both simultaneously, LBK VFs proceed and call
npc_get_nixlf_mcam_index() for NIXLF_ALLMULTI_ENTRY and NIXLF_UCAST_ENTRY.
For LBK VFs, npc_cn20k_dft_rules_idx_get() only populates the promisc pointer
and returns 0, leaving the stack variables for mcast and ucast uninitialized.
These uninitialized values might then be used to read and write hardware
rules via rvu_mbox_handler_npc_install_flow(), potentially corrupting MCAM
rules.

Agree, but this bug is introduced by a different commit. But the change
"Patch 6: [PATCH v3 net 06/11] octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width"
is a bug fix and is for another issue. So dont want to club it with this and will be addressed
in a followup patch; that will be posted once this patch series is merged.

Similarly, rvu_npc_update_flowkey_alg_idx() retrieves NIXLF_UCAST_ENTRY
without checking for LBK VFs, which might lead to the same uninitialized read.
Even if later commits in this series initialize these variables to zero, could
that just cause deterministic corruption of MCAM index 0 instead of random
memory corruption, unless LBK VFs are properly handled or skipped in these
functions as well?

Agree, but this bug is introduced by a different commit. But the change
"Patch 6: [PATCH v3 net 06/11] octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width"
is a bug fix and is for another issue. So dont want to club it with this and will be addressed
in a followup patch; that will be posted once this patch series is merged.

