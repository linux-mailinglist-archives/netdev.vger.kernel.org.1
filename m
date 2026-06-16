Return-Path: <netdev+bounces-299955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R0QkAnO3MWrJpQUAu9opvQ
	(envelope-from <netdev+bounces-299955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:52:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7A16954FB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:52:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=Vvc3IpuL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299955-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299955-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F2A13056503
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 20:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097AB397342;
	Tue, 16 Jun 2026 20:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87175396585;
	Tue, 16 Jun 2026 20:51:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643118; cv=none; b=q6u77E3PRj4ocQcu4IjIW+/PNWM7mwd83u3fcWmwqGBUmriV1SHSrDRkcTOIwffIHrUbWfp8HGNDaPKGnBJ7eFFARH4xVyK58ZfrxQiroEqjyFTV6yCvBBMAJ0hBeJ5Jm26fXIJ4vbtyfFk1rHD5vzWnDjzzxr5YgZ53zd6CrFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643118; c=relaxed/simple;
	bh=7CDzUoIKVcaQFt2vUecsujFT39HmD8Zz3VZ+pNZDAXw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsQFttWOf9eul55UA+s3MIAkUZrV7PDhXwB3uEZ9WBf9dLpIhxkwEcP90FHr/ssm0g2NP61kKW240oyWyke8OlrnHIQsufNRGjh6LBUjjJoPqvy5yzt6DVExdxWtNBPWVupb0uVG/AtoMPTj3gSIO79vsjkntYlL/KqOWj1H7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Vvc3IpuL; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GIRxRE008962;
	Tue, 16 Jun 2026 13:51:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Lox1i4S0pcVg/JZYMGIWtJ6rD
	9vZL/fpCWpf9hMyyQc=; b=Vvc3IpuLW/YwbTt1vfnzJ7XEDTd0v6bQPwYNmzuI8
	WRAKN/wm/dazmp6HbPDSPlR44TBEA9ZFXIMsUVSi7NT38dXwXdv8wENFUo34cEwN
	UXzQJ3vDr/POAJxRFZM1SMKeHdU/ua3PJ2nFaFykRqlHjTLLGsYZILDKBN6qFI8J
	pvCI9JXUxkoc2nSGI3xy8mmficy30YOjbFseAF0XQ+UluMhO8R1uqUjSDByzTr8c
	orAzWTwEUIDtJ7BpNWopREwyE2yNTeB5CC71yKSbShvPBxjp/p6HEUMvLT4x4aAl
	+v2oHI5SY62E+Dk5ITieFD+iusuaIgrZLCAfB6W871DBg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eu46a2fyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 13:51:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 13:51:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 13:51:48 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id A979D3F7048;
	Tue, 16 Jun 2026 13:51:44 -0700 (PDT)
Date: Wed, 17 Jun 2026 02:21:43 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] octeontx2-af: Validate NIX maximum LFs correctly
Message-ID: <20260616205143.GA95144@kernel-ep2>
References: <1780054645-17142-1-git-send-email-sbhatta@marvell.com>
 <20260603165945.3828939-2-horms@kernel.org>
 <20260603170759.GG3766816@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603170759.GG3766816@horms.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIxMiBTYWx0ZWRfX4NjEIVlvWAAE
 Q2v28xTxS2u3iu3x7OcJvnaOTv4StzybxAqtP1V5jOsMCoWURDFszna2uh/88l3RGdDwVzFUbpE
 y+jE7Sew2vtUph/zqCEVXXs4v2OOChk=
X-Proofpoint-ORIG-GUID: GXyjkaSDv44cpDGFqPhGVQvL-nPQN2ZQ
X-Proofpoint-GUID: GXyjkaSDv44cpDGFqPhGVQvL-nPQN2ZQ
X-Authority-Analysis: v=2.4 cv=U72iy+ru c=1 sm=1 tr=0 ts=6a31b764 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=9HhEp9MGe9DMhZqqVBMA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIxMiBTYWx0ZWRfX2K8Oqg06+/N1
 I/ykOriz5FDu63fUTeE1/9fKhNbtR80mjQCEe/sIc8sIxwGEItDU30VQ0lI8FI2aue24KST4fQo
 3hWw5EtmUwHxp8P4ZON5FnfVRVW4DLtgn/fVgcCK6VMzslAohEZ1hDtyYyewl3KFT7/5n/RRir6
 4WTVGgMkpQwNJZOBIpT8//NPA/0zyFFBo3b0ksJKCuHwDwh4KRs6e1fIhoQRixvULgRgUYSXFAK
 Jp9q33X0DixswYgwBRsGierTTutyiIR7VXTXXXT34HeIFvYles00DG1ATsYe+uUx93vfbY7+FED
 qKwwYU/GqhjUWcA1V5JN5lvTpF6E7Z7HZfXUpLxfS4PvAc7zzFYz6tfDBUn2O0yzfpoDzIms/eQ
 h9Gn3duI7Zb/xbVKaUMi8cwnk26XldsFZ0JNAIDhyNCmruJYMOpxdEaofGtnXyF6SobBuMyJvGf
 WHiJWK1y9DeWp/7I53Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299955-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,kernel-ep2:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C7A16954FB

Hi Simon,

On 2026-06-03 at 22:37:59, Simon Horman (horms@kernel.org) wrote:
> On Wed, Jun 03, 2026 at 05:59:46PM +0100, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> 
> Sorry, my tooling isn't helping me much today.
> There was supposed to be some commentary in my previous email.
> Let me add it.
> 
> > ---
> > octeontx2-af: Validate NIX maximum LFs correctly
> > 
> > This patch changes the validation condition for setting the maximum
> > number of NIX LFs via devlink. It replaces the check for assigned MCAM
> > entries with a check for assigned NIX LFs to determine if resizing
> > is allowed.
> > 
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > > index 6494a9ee2f0dd..8ba4b5ba9d2c7 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > [ ... ]
> > > @@ -1521,11 +1523,18 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
> > >  	/* Do not allow user to modify maximum NIX LFs while mcam entries
> > >  	 * have already been assigned.
> > >  	 */
> > > -	mcam = &rvu->hw->mcam;
> > > -	if (mcam->bmap_fcnt < mcam->bmap_entries) {
> > > -		NL_SET_ERR_MSG_MOD(extack,
> > > -				   "mcam entries have already been assigned, can't resize");
> > > -		return -EPERM;
> > 
> 
> The issue below looks like it should be looked at in the context of this
> patch.
> 
> > [Severity: High]
> > Does removing the check for MCAM entries allow the devlink parameter
> > set operation to silently destroy active MCAM tracking state?
> > 
> > The .set callback unconditionally calls npc_mcam_rsrcs_deinit() and
> > npc_mcam_rsrcs_init(), which frees and reallocates the mcam->bmap. Since
> > MCAM entries can be allocated independently of NIX LFs (e.g. during
> > rvu_switch_enable() or default switchdev/PTP rules), could this cause
> > resource leaks and use-after-free bugs when untracked rules are later
> > accessed?
>
Some background:
 Say NIX hardware supports 128 LFs then
 1. 128 MCAM entries are always reserved by AF to receive unicast traffic to each LF
 2. PFs/VFs request a LF attachment during their probe via mbox message to AF
 3. devlink command to set NIX LFs is added later upon requests from customers/users
    so that if their system uses only 2 PFs then they can use the rest 126 mcam
    entries for additional traffic steering
 4. The only execption is user has to load PF and VF drivers as modules after
    setting NIX LFs as first command via AF devlink.
> > 
> > > +	blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
> > > +	while (blkaddr) {
> > > +		block = &rvu->hw->block[blkaddr];
> 
> While the one below seems like it can be assessed in the context
> of possible follow-up.
> 
> > [Severity: High]
> > This is a pre-existing issue, but does this locklessly read the resource
> > states?
> > 
> > It appears that the devlink validate and set callbacks execute without
> > holding the driver's resource locks (rvu->rsrc_lock or mcam->lock).
> > Could a concurrent mailbox request allocate an LF immediately after this
> > lockless validation check succeeds, leading to a race where the .set
> > callback frees structures that are actively being used?
> > 
As from above background this is not possible.
> > > +
> > > +		free_lfs = rvu_rsrc_free_count(&block->lf);
> > > +		if (free_lfs != block->lf.max) {
> > > +			NL_SET_ERR_MSG_MOD(extack,
> > > +					   "mcam entries have already been assigned, can't resize");
> > 
> 
> The one below seems less important. But perhaps it would be good
> to address if there is a v2 of this patch.
> 
> > [Severity: Medium]
> > Since the validation logic was updated to evaluate NIX LF allocations,
> > should this error message and the comment above be updated as well? The
> > message still states that "mcam entries have already been assigned", which
> > might confuse users since it's actually evaluating NIX LFs.
> > 
Sure will modify the message

Thanks,
Sundeep

> > > +			return -EPERM;
> > > +		}
> > > +
> > > +		blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
> > >  	}

