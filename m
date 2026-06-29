Return-Path: <netdev+bounces-302504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V0E5BwswQmrc1QkAu9opvQ
	(envelope-from <netdev+bounces-302504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:42:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AFB6D798C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:42:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=V5FgjRno;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302504-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302504-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F9E93009F6E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947643F6601;
	Mon, 29 Jun 2026 08:42:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3F3932F7;
	Mon, 29 Jun 2026 08:42:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722567; cv=none; b=F7dhLk5cvIE06BuqG4CIdKzy+uRoIP6aVAx9NC0qJaiQ92fs6jLHJPJUelTK1VcPd5xcYbyjm80/maR2zahBr/4Fpr+LAn6ZbuaMQV326MENGrO0lq17CG7aTIgBsquA2fDwfXF9P1AG6JxDRnlvFLztPT+Ze9vCYHJhvNPweZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722567; c=relaxed/simple;
	bh=gfMza753RM+Sgs4g7JOufLY9aHqXgYgvXhTLsoiLBTs=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BEFR0p7rHJ+kwgp90jzib77Sz0vvcBsiPuQeL3EmrduOftsPrSS0RH0i2SOpRvWidMN6KnNqReUsayO/8Ls3KKriuuXFSQWyYGdf0Tdy26rZPJTBrJI2MPUiN43oUiJYYUyibagLiD7luof9e3a1ZSf2yyKTtR9bXl/Q+ej5jLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=V5FgjRno; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6nloK1394548;
	Mon, 29 Jun 2026 01:42:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:subject:to; s=pfpt0220; bh=W/GoQNafB/zp
	Wb5OHmXJISvIM2LO7pyd3eg6UmSja5I=; b=V5FgjRnoYGCYRHHX4u97tYDx6fnv
	WmbeTF63ioY+4DSfpNQJamfNaSBOfMPeTmp7oQymwM4uc3AsIOuGaqW+742WbWqK
	bhMhm1AAgRm/MQBpsytSXuY3QvvSmXKH7ftrsk90hvN76Rd6rUUY5i0uHIsobbtO
	bYBNQD5xukubtLLHz7ql9HmnKgZyIpn8dr5bHouetvR97yqybRl6BSHaHdmYeOKH
	K1+C0Mj4d/6xX/1xHBdIPx9giNe0U5SjIyAM+8PqgrjTqiDYxBXFREvOYU6DdZf6
	Jdo7Kfg1JnfT1E72JQHQMZ3TnDVgFY8mntOBXms2RtsvvKtr9mK3HbwgMg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f2e1h4psf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 01:42:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 01:42:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 01:42:21 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 0CC963F70BF;
	Mon, 29 Jun 2026 01:42:16 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:12:15 +0530
From: Nitin Shetty J <nshettyj@marvell.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <naveenm@marvell.com>, <tduszynski@marvell.com>,
        <sumang@marvell.com>
Subject: Re: [PATCH net v2] octeontx2-pf: check DMAC extraction support
 before filtering
Message-ID: <akIv55nXYRFvdD5T@kernel-ep2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626062329.871990-1-nshettyj@marvell.com>
X-Proofpoint-ORIG-GUID: JIRsocmBsJ8N-xAGR_jTTJAONf5J6ODs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2OSBTYWx0ZWRfXyzeH3xLh7kiL
 MrGweuNOznYKFuQOLVDaZmp14G5t9HWpAm/NBCWtFZdPVT3iJVMOD9m21wCFNsY4dFSvkO/iYTr
 IC4HdWrgRZots1X30Qq/HZIxgMD9r3k=
X-Authority-Analysis: v=2.4 cv=e802j6p/ c=1 sm=1 tr=0 ts=6a422fee cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=M5GUcnROAAAA:8 a=5vcvyFUgBKbe-d_LTDEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: JIRsocmBsJ8N-xAGR_jTTJAONf5J6ODs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2OSBTYWx0ZWRfXw0z4yHit8eJ0
 gSF+74OCICCJhdTb88qezoyTwpG7trAXrlMiLv8IcxE9olK5FpDzbbFYUo2jlvshO9UGtOkyebs
 6oCOR1Rz6CBnEwn7ZtM1rDiS5RNGgu9XfcK1sDHQhXkRQTXTUra1SEQDd4KJcuxtpLjJ7P6zUkp
 XxkRFxs6pL/0ixGUA4xDyMHh3ez5Da5+ljF34tjfEu1PBwqKzXn4qsqSyg/Ybs6po/yn5MUGYDx
 y8VZuEv66Js6jUze/sz6u99zrxDcFk1y2FxH7Y/fIqiSjdNutM9vNF/wJDWH8KjWcQ4I8Tr77RI
 8y3+Bm5lxuYcKSKhPr5gpEHPqkjRxwcDjq+oSG6mh7PwdBfwE9msmlN6tL3xP/OxjjNAU6x34d1
 ltewSsTKgK0ioICbiMRkAd/gj37u3l9giCO4bTRSwxiUqHzRJYw/OPKua2bpRBUfNOWS7/P0bY3
 0p01fpERvMj1wfAvPqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302504-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hramamurthy@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:naveenm@marvell.com,m:tduszynski@marvell.com,m:sumang@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2AFB6D798C

On 2026-06-27 at 06:20:38, Harshitha Ramamurthy (hramamurthy@google.com) wrote:
> On Thu, Jun 25, 2026 at 11:24 PM <nshettyj@marvell.com> wrote:
> >
> > From: Suman Ghosh <sumang@marvell.com>
> >
> > Currently, configuring a VF MAC address via the PF (e.g., 'ip link
> > set <pf> vf 0 mac <mac>') blindly attempts to install a DMAC-based
> > hardware filter. However, the hardware parser profile might not
> > support DMAC extraction.
> >
> > Check if the hardware parsing profile supports DMAC extraction
> > before adding the filter. Additionally, emit a warning message
> > to inform the operator if the MAC filter installation fails due
> > to missing DMAC extraction support.
> >
> > Fixes: f0c2982aaf98 ("octeontx2-pf: Add support for SR-IOV management functions")
> > Signed-off-by: Suman Ghosh <sumang@marvell.com>
> > Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
> >
> > ---
> > v2:
> >  - Move the DMAC extraction check from otx2_set_vf_mac() into
> >    otx2_do_set_vf_mac() which already holds pf->mbox.lock, so all
> >    mbox operations are under a single lock/unlock pair. All error
> >    paths now use the existing goto-out pattern, eliminating the
> >    scattered mutex_unlock() + return calls from v1.
> >  - Return -EOPNOTSUPP instead of 0 when DMAC extraction is not
> >    supported, so the caller gets an explicit error rather than a
> >    silent success.
> 
> Please ensure a minimum of 24 hr gap before posting a new revision and
> also don't post patches in reply to a previous posting as documented
> in:
> 
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> 
Apologies for the process oversight. I will ensure a 24-hour window 
before posting v3, and I will submit it as a new thread.

> > ---
> >  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > index b63df5737ff2..dc7e4a225dd0 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > @@ -2517,10 +2517,43 @@ EXPORT_SYMBOL(otx2_config_hwtstamp_set);
> >
> >  static int otx2_do_set_vf_mac(struct otx2_nic *pf, int vf, const u8 *mac)
> >  {
> > +       struct npc_get_field_status_req *freq;
> > +       struct npc_get_field_status_rsp *frsp;
> >         struct npc_install_flow_req *req;
> >         int err;
> >
> >         mutex_lock(&pf->mbox.lock);
> > +
> > +       /* Skip installing the DMAC filter if the hardware parser profile
> > +        * does not support DMAC extraction.
> > +        */
> > +       freq = otx2_mbox_alloc_msg_npc_get_field_status(&pf->mbox);
> > +       if (!freq) {
> > +               err = -ENOMEM;
> > +               goto out;
> > +       }
> 
> I noticed that otx2_set_vf_mac() copies the MAC address into the vf
> config structure before the programming is successful. Is that
> intended?
> 
Good catch. This is not intended behavior. I will fix it in next V3.

> > +
> > +       freq->field = NPC_DMAC;
> > +       if (otx2_sync_mbox_msg(&pf->mbox)) {
> > +               err = -EINVAL;
> > +               goto out;
> > +       }
> > +
> > +       frsp = (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
> > +              (&pf->mbox.mbox, 0, &freq->hdr);
> > +       if (IS_ERR(frsp)) {
> > +               err = PTR_ERR(frsp);
> > +               goto out;
> > +       }
> > +
> > +       if (!frsp->enable) {
> > +               netdev_warn(pf->netdev,
> > +                           "VF %d MAC filter not installed: DMAC extraction not supported by parser profile\n",
> > +                           vf);
> 
> Would a netdev_warn_ratelimited() be better here to avoid spamming the log?
> 
Since this block is only executed when we use the 'ip link' command
and does not sit on the runtime hot data path, the potential
for log spam is negligible. I prefer to retain netdev_warn()
so the operator receives an explicit warning when command fails.

> > +               err = -EOPNOTSUPP;
> > +               goto out;
> > +       }
> > +
> >         req = otx2_mbox_alloc_msg_npc_install_flow(&pf->mbox);
> >         if (!req) {
> >                 err = -ENOMEM;
> > --
> > 2.48.1
> >
> >
> 

