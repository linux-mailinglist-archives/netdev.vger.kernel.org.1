Return-Path: <netdev+bounces-253718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKVNKxFceGkupgEAu9opvQ
	(envelope-from <netdev+bounces-253718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:32:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E20129069E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C35E300845B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A529A30E;
	Tue, 27 Jan 2026 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hT5XgYAG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD4227BA4;
	Tue, 27 Jan 2026 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769495563; cv=none; b=OXtbhu6ZWnnpPHosw2p5ttcGQkfEiZnHgrMIFLauS7t39WYz/HGs6GqsFxVez+2NxVqK5tKZjwQgePFfTUS85TUjo7XfsjGy2Tc//PLw9NerM9uPUlJ3zKe+bMY85BgmcEaeARpKvA4GGEZSZqKCwL1NC8cxhXDi7+N3sGUCZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769495563; c=relaxed/simple;
	bh=8w4CPGEvc7t+CmAt+3IEgYbYBOA/2MelGC9jLPHp0bg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLxf+xWsAnW1FKmNlg5Y+XgFaApl1fZfz/tYsXpzt9CgT+e+GQVEf2kXziahhVBkszBG24dDOx4zjJui4nY+I2X2FobC4AO7FFZeYxxqBp//FZ+l5sMkj5mdmdEJCC6m5F2OxBV6tZ1ozeOHBTp5mAdKubqPMkMZFutFvn9iulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hT5XgYAG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QEUFAb380323;
	Mon, 26 Jan 2026 22:32:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=tpkRTpawKAYYxED8L6kAasuS9
	3UkRTtR3eHoDFF7xf0=; b=hT5XgYAG84J9omhiieWEOCBIJWGYNcAYulsj3eMpj
	AVSh01othNbhgzjEDcvgaXkKWr+inwEaKSPT+aa1/agK2kSVnWeQmtN1bk7VYmFz
	96L0J76VshZC/5fVw9xTUTLXHNQPVbUIct/KRiVRoc1fDLAnmErwqfRR2Qwq/9qd
	Mbyi4YVHeQiNEziRot3cR9G5A+0b4Ml54ZZ8oh1s1h4UkzeMdf7+XQUA/2TQ0Upn
	YGuOI5uUOL/7tWqUuitzaDyJztdJtjHYADiE7ysRXLsOAe5fAg0v31um0avFnTl4
	8silH55c9aNNrV0ymWNbMbFZDPBKLYrVB1S/yS4EOfEIg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bxa2y9u77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:32:19 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 Jan 2026 22:32:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 26 Jan 2026 22:32:35 -0800
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 6F6333F70B1;
	Mon, 26 Jan 2026 22:32:14 -0800 (PST)
Date: Tue, 27 Jan 2026 12:02:13 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sbhatta@marvell.com>,
        <naveenm@marvell.com>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <bbhushan2@marvell.com>
Subject: Re: [net-next PatchV4 2/2] Octeontx2-pf: Add support for DMAC_FILTER
 trap
Message-ID: <aXhb7fZHRh7kB1fd@test-OptiPlex-Tower-Plus-7010>
References: <20260123104731.2710019-1-hkelam@marvell.com>
 <20260123104731.2710019-3-hkelam@marvell.com>
 <20260125142412.20b37981@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260125142412.20b37981@kernel.org>
X-Proofpoint-GUID: mfTZjBaGwnmIEoY7qOyL0TmoWgfrEGe3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA1MiBTYWx0ZWRfX5Ke/3ROdie94
 vHKrKEO6Qn0YFcG2C51eKHUHvnrhrJfzeMSlzxr+Y58Zp5Slju5ejlTKpyoNs8xJSOx/sbHBbUz
 mLHL9Jo/BYK4VWeT/xum0dtGba3yMZwdn3I9d26/ZaNiaPnzx0cRzpOK9mXSUYFqCfYAfAEzi0S
 i4vbaLSQhNRHw0wMP8civk00dDm9dG/z/mGdffZ+KU9FoyztX9Nfwk37TV5tzHkX11mygjumX0I
 nNlOmUjvbdt2oovC2chxzyFpGXnB1Z+qg86FkWFWXRDCtXTE+qmNs8C4z7jf3LvX37MWS7v2iPr
 54i8qVUVo86T/x23UPg0vJsaKBOtmJWiBkNcXTmbaG+GbJOsxJ5xnyv/cS9IS+fh5AHshlQsral
 io2Nwjx9cbErQA0VR3dlGyhRFZLASJfwete6aTYcjL9F6kJ6X4J3OeTLYXMGU9zMXuZ8hxYPco5
 IWSAFyUUwZNrnKLxQBg==
X-Authority-Analysis: v=2.4 cv=CY8FJbrl c=1 sm=1 tr=0 ts=69785bf3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=UKaYxVDTM21LO6YuAbgA:9 a=CjuIK1q_8ugA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: mfTZjBaGwnmIEoY7qOyL0TmoWgfrEGe3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253718-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkelam@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E20129069E
X-Rspamd-Action: no action

On 2026-01-26 at 03:54:12, Jakub Kicinski (kuba@kernel.org) wrote:
> On Fri, 23 Jan 2026 16:17:31 +0530 Hariprasad Kelam wrote:
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > @@ -3282,6 +3282,10 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (err)
> >  		goto err_mcam_flow_del;
> >  
> > +	err = otx2_devlink_traps_register(pf);
> > +	if (err)
> > +		goto err_unregister_dl;
> > +
> >  	/* Initialize SR-IOV resources */
> >  	err = otx2_sriov_vfcfg_init(pf);
> >  	if (err)
> > @@ -3314,6 +3318,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	otx2_sriov_vfcfg_cleanup(pf);
> >  err_pf_sriov_init:
> >  	otx2_shutdown_tc(pf);
> > +err_unregister_dl:
> > +	otx2_unregister_dl(pf);
> 
> Hm, you're still not calling otx2_devlink_traps_unregister()
> anywhere in this unwind ladder. If the missing otx2_unregister_dl()
> is a pre-existing bug please send a separate fix (to net?) to address
> that, and then this series on top.
>
  ACK, will send "otx2_unregister_dl" as a separate patch.
> >  err_mcam_flow_del:
> >  	otx2_mcam_flow_del(pf);
> >  err_unreg_netdev:
> > @@ -3514,6 +3520,7 @@ static void otx2_remove(struct pci_dev *pdev)
> >  	/* Disable link notifications */
> >  	otx2_cgx_config_linkevents(pf, false);
> >  
> > +	otx2_devlink_traps_unregister(pf);
> >  	otx2_unregister_dl(pf);
> -- 
> pw-bot: cr
> 

