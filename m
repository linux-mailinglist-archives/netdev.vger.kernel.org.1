Return-Path: <netdev+bounces-280981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G/0FQNM62lhKwAAu9opvQ
	(envelope-from <netdev+bounces-280981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:54:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D845D684
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E20833007962
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04423939A5;
	Fri, 24 Apr 2026 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dg9VV/bh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA2038644D;
	Fri, 24 Apr 2026 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777028092; cv=none; b=XL5mwkygTuH8YxWS8oAuSB5Q7TcHzTrFVlmdcxF2T7y5k+UhLJh7VYi9Z2kC97WLi5fRSwfofJP152rv+QQlMobKn3hA32MXFwm1P3tMRlrBCHrQXFyXK2unU9b4SVjyCu2ks373FuH9oxcwDgkibJRDgJeCSArpG0EnrS0BW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777028092; c=relaxed/simple;
	bh=o6kgTCpfZQKeHUDILYtheVAzzWc56GfLEOMIzrt0oDM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X881z7xasnMjqV83zj1aULoyGp54rsxV+OnYF/XJ8VWash0x9GakUDuvbVng7u4yhB9eJkvudTettVfNgviF3aQAimGoXDZOV4lQLvmcoCk058rWnVwF9IeE3vlLBXHIJDQcsJ8XBxsxpaKa0/YwM2MogY/pFYnFKy7L/3oUGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dg9VV/bh; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O7R1Iw1922920;
	Fri, 24 Apr 2026 03:54:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=uNMxRlI0x78NwbEMdS854AI88
	Su5pYYwGOy16LaRS2s=; b=dg9VV/bhEgMLFMHhJfBg+wLHMvMIF2bIP9W2Rsccv
	/cZCOnmAJ5ecS3fm4/NS+NHzL5JVjqNfxXKjegqEVQ/A1aGcgUhkQpTQyCMnptuD
	p03w8ZrWyR9WhxtnHj/sHmPzPvP1iV2u63e/EXdT/cu3vCWY6xmwnq24Cp70RspN
	W9PzdYsKEEDn+Jb0YPNDfVKHzKt6pTaknT8jofGZQzweh2tLDwZcBekIptrqh3LR
	KmaHvnTktx73ZtOluf/TrgHUeLFk3HYtgUZlOfdHHlGdK88sZu/+artB2oaMlvVm
	m3BKqLagPYAi414R0UXI+V2Uarwrw304aAUfJPcN+HWAw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dqc06v0t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 03:54:29 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Apr 2026 03:54:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Apr 2026 03:54:28 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 053303F704D;
	Fri, 24 Apr 2026 03:54:24 -0700 (PDT)
Date: Fri, 24 Apr 2026 16:24:23 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 net 01/11] octeontx2-af: npc: cn20k: Propagate MCAM
 key-type errors on cn20k
Message-ID: <aetL34CBNu2_dQfg@rkannoth-OptiPlex-7090>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
 <20260423104317.2707923-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260423104317.2707923-2-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDEwMyBTYWx0ZWRfXw16wXOhR8k2Q
 HyAjrCI4ciaP2ZnySDZrjo2aNPggAB4SD0/OPIQoRr1tD8VWE45QjLQWwolYxx6qRMdJPQtThqf
 wH4wB8JSpk4J+uBSFZq21LOtFvAxToEb+ttqCDDBbOM0XcrAx1iA5vssOaeDbqGidIZRRmsrzoA
 8ILu8Ci1hmuc8ccUmi4OrJ3nAT4SidWCdxZQxUMmH/A0EWZ2WL+zX2zi6nVEQABW0EPBiSG11Ga
 8+5AszPtNSv6+XTnabFXLQnhUdoxM9dT1Q9pi/qKxfrtq2h15D/D6i/yhagowjihPe9HugZotuH
 7NYKwxI5iJvPIEI9dTtv8qRScq573Xedwd67iVPTMTsAbES2xE3FntCFOU3K1LaBz6WJyU74vkA
 9bDeuLhhJnf5tjsCn5Ol29+F26J5TLXd0Et9LK2NE5uZnPPlLyyQouTwml9vV7+MsAn2xXlia9i
 A2Sl7elXzN/cqtE48HQ==
X-Proofpoint-GUID: wlnSgo6Dn7M3fuPGP6TRpIsrfMwBR7BO
X-Authority-Analysis: v=2.4 cv=N84Z0W9B c=1 sm=1 tr=0 ts=69eb4be5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=pBen3iaBBKK4QfoPqk4A:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: wlnSgo6Dn7M3fuPGP6TRpIsrfMwBR7BO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: B02D845D684
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280981-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-23 at 16:13:07, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> npc_mcam_idx_2_key_type() can fail; callers used to ignore it and still
> used kw_type when enabling, configuring, copying, and reading MCAM
> entries. That could program or decode hardware with an undefined key
> type.
>

>https://sashiko.dev/#/patchset/20260423104317.2707923-1-rkannoth%40marvell.com
>
>> @@ -1415,14 +1435,14 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
>>  	else
>>  		nix_intf = pfvf->nix_rx_intf;
>>
>> -	npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
>> -				    &req->entry_data, req->enable_entry,
>> -				    req->hw_prio, req->req_kw_type);
>> +	rc = npc_cn20k_config_mcam_entry(rvu, blkaddr, entry, nix_intf,
>> +					 &req->entry_data, req->enable_entry,
>> +					 req->hw_prio, req->req_kw_type);
>>
>>  	mutex_unlock(&mcam->lock);
>>
>>  	rsp->entry = entry_rsp.entry;
>> -	return 0;
>> +	return rc;
>>  }
>Does this code leak the allocated MCAM entry if npc_cn20k_config_mcam_entry()
>fails?
>Earlier in rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(), an entry
>is successfully allocated via rvu_mbox_handler_npc_mcam_alloc_entry(). If
>the configuration step then fails, returning rc without rolling back the
>allocation leaves the hardware MCAM entry unmapped but still reserved.
>Because the generic mailbox framework propagates the error code, the
>requester will assume the entire allocation failed and will never send a
>free request. This could allow a VF to repeatedly trigger this failure path
>and exhaust all available MCAM entries.
This commit is to address a smatch error reported by Dan. To fix issue, raised here
by sashiko, we need to change multiple files to handle all errors gracefully. it will be an enhancement change.
I will add a follow up patch to net-next. Ignoring this comment for this patch.

