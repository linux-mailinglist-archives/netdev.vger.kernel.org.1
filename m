Return-Path: <netdev+bounces-277319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIryBDjO2GngiQgAu9opvQ
	(envelope-from <netdev+bounces-277319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:17:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9103D58CE
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35B66300EF95
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BB137CD5C;
	Fri, 10 Apr 2026 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="anEshKQp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDAE344046;
	Fri, 10 Apr 2026 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815928; cv=none; b=RspgfXYj94EuK8/P7Lc28AyvnIDYG8TpRNSE1LJzWfxv2rM+tevgkLuaHfTJDiKsrFT5boTgQbWiXoehOofBhpFwkNNyVZZ3rcXKmEwmSAra8FUccU0C4xfjnIdMHn75Ug9SQrZS7bJpaHU3LEsqzkhZqf/mR3UEIoQvq0J9wSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815928; c=relaxed/simple;
	bh=vU/l+dFKnn5XMjAc1+toVkwca3moNMoLHRwQo+nZEcA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN8lLpu63jvaGQNkgS7R5ujIxTtS0j6eoB4ssGe/6QmlqaxplQb9c/OpZw/wJB8UMXeITt70fXGi1ULCSba1a0wEqXw9xwYwEcV/8S2zyDQy2jC/l/3M4HOD1b+XhvjR6BcZReikheW2e9xgQp9Ach4JxI7NOll6P5bIKwr8L0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=anEshKQp; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A7f2KT2130827;
	Fri, 10 Apr 2026 03:11:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=yiM8IOjpKF/P2nOnRCDnmNC0L
	hM6dZQggM6BDhKwLLY=; b=anEshKQpvWPOvu1XD7T7SU1Vrqn2IpXyz7BeGcVqc
	ggLglV38nY9y+BTYKgm2EWr8AD/qRHTsxezefVlIILUBIqFvmopgnVeM46NNTSY3
	uBSmbDoJpij5S+JlS7wzXQHUBoguk/Gr8P1bFUdy69tRvR1jwfhziISVnFo1eYes
	PHfKPHW8Nt5UT2VZ/WXBxdqTrHXDnDfOvnEHhBBeZ+tWIUyvlDfZxtgrp3wsYLdQ
	Vio8SJXTEsPhOAl7+Lxtr1Pjqepc7RH1l5HO65vtwqpXgfF8c4/STzFo0Xbw7bAq
	XjUBfdDfZYG787eCcglBZ4ut03A37+6CJRSEIsxegD1cg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4de0u442e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 03:11:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 10 Apr 2026 03:11:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 10 Apr 2026 03:11:55 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 7566B3F708D;
	Fri, 10 Apr 2026 03:11:51 -0700 (PDT)
Date: Fri, 10 Apr 2026 15:41:50 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>
Subject: Re: [net-next PATCH v5 1/4] octeontx2-af: npa: cn20k: Add NPA Halo
 support
Message-ID: <20260410101150.GA1783722@kernel-ep2>
References: <1775728404-28451-1-git-send-email-sbhatta@marvell.com>
 <1775728404-28451-2-git-send-email-sbhatta@marvell.com>
 <00fc6c1e-638a-4e80-b3c4-14e4dfa3651a@intel.com>
 <20260410093536.GA1783667@kernel-ep2>
 <1dc56269-d6d5-48da-a4c2-0686ce4fd1f6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1dc56269-d6d5-48da-a4c2-0686ce4fd1f6@intel.com>
X-Authority-Analysis: v=2.4 cv=KpN9H2WN c=1 sm=1 tr=0 ts=69d8ccec cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=QyXUC8HyAAAA:8
 a=M5GUcnROAAAA:8 a=RjYgwcD2tLfXtkcG9QgA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: _Lk2KkFGI9YOaNfqEIEkpzHCw0j-_t_s
X-Proofpoint-GUID: _Lk2KkFGI9YOaNfqEIEkpzHCw0j-_t_s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5NSBTYWx0ZWRfX9NUYqR3LXdNv
 WYSIwTsDfD1lUOtOtIyGHRTlODgUWR5ADdbrC3HXi5FfjkH2dayhSuSN0hKgxCAy2sgVoH4+xEy
 t15wSjYB3S0VeiIhX6Hyh96/ZDw9eUyffHR2HcgkkEIVfWiNS3ocAGjH9ke7E8+iiBGJSAwz9T0
 t7ZkfhXkXwqU5mWAmW9PYEffIXuCQD89DgNQDZYpA5iWCocUuAbd4INuLrPYyHd/TVUBngw1rOy
 ZndsA5Gj/kSzu4+0ziBAhhKuMo4lJIkV8100IyvOvmxgkU4DNHvt11MRbzH7XGNx2KvdVRErkSL
 GygQQGxnjF1SRrYwUfwB41HTd6oUwKdFmMe7SkLYkt6glEiymwXc4vHhaseQZIbkfBoQz1xyCwq
 Okr9lCZnPNnPP9476ZjU81Q4xA6ONSw+zEZEEgy9tYctYl6rKOCqgqX5JuiWYGgEGQPo07gZsxc
 iSw6M3NvBcea4hW/dTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277319-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6F9103D58CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-10 at 15:06:56, Alexander Lobakin (aleksander.lobakin@intel.com) wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> Date: Fri, 10 Apr 2026 15:05:36 +0530
> 
> > On 2026-04-09 at 20:39:02, Alexander Lobakin (aleksander.lobakin@intel.com) wrote:
> >> From: Subbaraya Sundeep <sbhatta@marvell.com>
> >> Date: Thu, 9 Apr 2026 15:23:21 +0530
> >>
> >>> From: Linu Cherian <lcherian@marvell.com>
> >>>
> >>> CN20K silicon implements unified aura and pool context
> >>> type called Halo for better resource usage. Add support to
> >>> handle Halo context type operations.
> >>>
> >>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> >>> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> >>
> >> [...]
> >>
> >>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> >>> index 763f6cabd7c2..2364bafd329d 100644
> >>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> >>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> >>> @@ -377,4 +377,85 @@ struct npa_cn20k_pool_s {
> >>>  
> >>>  static_assert(sizeof(struct npa_cn20k_pool_s) == NIX_MAX_CTX_SIZE);
> >>>  
> >>> +struct npa_cn20k_halo_s {
> >>> +	u64 stack_base                  : 64;
> >>
> >> It's redundant to add : 64 to a 64-bit field.
> >  Agreed. But this is for readability, it helps when checking HRM. For
> >  instance HRM says [703:640] and we define as u64 reserved_640_703 : 64;
> >  so that we do not have to count bits in mind.
> >> Moreover, on 32-bit systems, the compilers sometimes complain on
> >> bitfields > 32 bits.
> >  This driver depends on 64BIT.
> >>
> >>> +	u64 ena                         :  1;
> >>> +	u64 nat_align                   :  1;
> >>> +	u64 reserved_66_67              :  2;
> >>> +	u64 stack_caching               :  1;
> >>> +	u64 reserved_69_71              :  3;
> >>> +	u64 aura_drop_ena               :  1;
> >>> +	u64 reserved_73_79              :  7;
> >>> +	u64 aura_drop                   :  8;
> >>> +	u64 buf_offset                  : 12;
> >>> +	u64 reserved_100_103            :  4;
> >>> +	u64 buf_size                    : 12;
> >>> +	u64 reserved_116_119            :  4;
> >>> +	u64 ref_cnt_prof                :  3;
> >>> +	u64 reserved_123_127            :  5;
> >>> +	u64 stack_max_pages             : 32;
> >>> +	u64 stack_pages                 : 32;
> >>> +	u64 bp_0                        :  7;
> >>> +	u64 bp_1                        :  7;
> >>> +	u64 bp_2                        :  7;
> >>> +	u64 bp_3                        :  7;
> >>> +	u64 bp_4                        :  7;
> >>> +	u64 bp_5                        :  7;
> >>> +	u64 bp_6                        :  7;
> >>> +	u64 bp_7                        :  7;
> >>> +	u64 bp_ena_0                    :  1;
> >>> +	u64 bp_ena_1                    :  1;
> >>> +	u64 bp_ena_2                    :  1;
> >>> +	u64 bp_ena_3                    :  1;
> >>> +	u64 bp_ena_4                    :  1;
> >>> +	u64 bp_ena_5                    :  1;
> >>> +	u64 bp_ena_6                    :  1;
> >>> +	u64 bp_ena_7                    :  1;
> >>> +	u64 stack_offset                :  4;
> >>> +	u64 reserved_260_263            :  4;
> >>> +	u64 shift                       :  6;
> >>> +	u64 reserved_270_271            :  2;
> >>> +	u64 avg_level                   :  8;
> >>> +	u64 avg_con                     :  9;
> >>> +	u64 fc_ena                      :  1;
> >>> +	u64 fc_stype                    :  2;
> >>> +	u64 fc_hyst_bits                :  4;
> >>> +	u64 fc_up_crossing              :  1;
> >>> +	u64 reserved_297_299            :  3;
> >>> +	u64 update_time                 : 16;
> >>> +	u64 reserved_316_319            :  4;
> >>> +	u64 fc_addr                     : 64;
> >>> +	u64 ptr_start                   : 64;
> >>> +	u64 ptr_end                     : 64;
> >>> +	u64 bpid_0                      : 12;
> >>> +	u64 reserved_524_535            : 12;
> >>> +	u64 err_int                     :  8;
> >>> +	u64 err_int_ena                 :  8;
> >>> +	u64 thresh_int                  :  1;
> >>> +	u64 thresh_int_ena              :  1;
> >>> +	u64 thresh_up                   :  1;
> >>> +	u64 reserved_555                :  1;
> >>> +	u64 thresh_qint_idx             :  7;
> >>> +	u64 reserved_563                :  1;
> >>> +	u64 err_qint_idx                :  7;
> >>> +	u64 reserved_571_575            :  5;
> >>> +	u64 thresh                      : 36;
> >>> +	u64 reserved_612_615            :  4;
> >>> +	u64 fc_msh_dst                  : 11;
> >>> +	u64 reserved_627_630            :  4;
> >>> +	u64 op_dpc_ena                  :  1;
> >>> +	u64 op_dpc_set                  :  5;
> >>> +	u64 reserved_637_637            :  1;
> >>> +	u64 stream_ctx                  :  1;
> >>> +	u64 unified_ctx                 :  1;
> >>> +	u64 reserved_640_703            : 64;
> >>> +	u64 reserved_704_767            : 64;
> >>> +	u64 reserved_768_831            : 64;
> >>> +	u64 reserved_832_895            : 64;
> >>> +	u64 reserved_896_959            : 64;
> >>> +	u64 reserved_960_1023           : 64;
> >>> +};
> >>> +
> >>> +static_assert(sizeof(struct npa_cn20k_halo_s) == NIX_MAX_CTX_SIZE);
> >>
> >> Now the main question:
> >>
> >> Is mailbox's Endianness fixed (LE/BE)? Or is it always the same as the
> >> host's ones (I doubt so)?
> >> If not, these need to be __le{8,16,32,64} (or __be if it's Big Endian)
> >> and you need to handle the conversions manually.
> >>
> >  Yes endianness is LE and fixed. This is NOT a host side driver for an
> >  endpoint card. This is driver for on chip PCI device of CN20K soc.
> >  Hope I answered your question wrt host.
> 
> But the mailbox is shared between the SoC and the host or HW or not? Is
 In hardware it is just shared DDR region between two on chip devices and both
 devices access shared region using their BARs. 
> it possible that one client of the mailbox will have LE and the second
> will have BE?
 No not possible.

 Thanks,
 Sundeep
> 
> > 
> >  Thanks,
> >  Sundeep
> 
> Thanks,
> Olek

