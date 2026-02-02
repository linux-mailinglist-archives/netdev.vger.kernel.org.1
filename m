Return-Path: <netdev+bounces-255834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCbRISyCgGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:53:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1334CB41B
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6814300E61F
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF81F35B142;
	Mon,  2 Feb 2026 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Uuy+MpB6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA763570B2;
	Mon,  2 Feb 2026 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029609; cv=none; b=S0QgL7FXxBXUnD47jpvKX72MsLUj1FCGOkS6wFhwnVhzX6T/z5d2GTZ22tGUelXG70kRk7khE076oEHmaVZ0gsCgg6AFSHqQZnuFN5FHlNbdemlyDlFPTIVbDvHlX4RC2538y8dzMzWWNqeiQKrsxr9XJP1vc+NGo4T6ODX6Y3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029609; c=relaxed/simple;
	bh=HyRFau/B4PvpkUmXjRWTSCugbqWxZrtnQbv5mnBLvMU=;
	h=Date:From:To:CC:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nK9a5uNeXubw373VbGQpjeRM4W28yMcLuYjuirfP+YYDaDGNzBTa+EQ25L5pcaXfFDiqsF3OE/QMRCNl/2iVy3Cxlxf06qxag41R4pca1gIcFaRXnXU0siEWiVTspxYYWCS+SboyanBCE1aBIkIGqPVcWp+xqCMwhG2KY1UpkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Uuy+MpB6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 611NhMSK3444759;
	Mon, 2 Feb 2026 02:53:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:to; s=
	pfpt0220; bh=RvbaCQYqi0+TU5bKUnmjI23R5nhj4Bsy1HU1n0lVaOo=; b=Uuy
	+MpB6479MXpcRzN5u5WAvCsFggvTrhJe/u5CL5KxFPIXxjPxO6nBrOVLvBONVW5q
	xFNpqO6g+ADPok9ppJBTK8/IVPxD/Tr0uqPchY1dT3WA51eq6vkS78neJpe8pqrN
	RzjWKF2V+Zh5NktbyhFgTfjM3EZrc6P+1FmBukXmEdycF8kUQOoSpTuvo9jtemyy
	huN+tQdPxyyVCYnR7PXbjZ+gOZDdkRIEcsHssqdjrHnoR8Z9KZgjZpUHnUrrgpkj
	33qmb4lkr83Z7rKudzeUTWIAEz+ilyh2UlpjByJWFBFXV4GVji9QUiJvfVttMjh0
	UZmiupWPpPryRKLubuA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c28mvsjvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 02:53:17 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Feb 2026 02:53:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Feb 2026 02:53:32 -0800
Received: from ccs-coresight-hyd (ccs-coresight-hyd.marvell.com [10.29.40.42])
	by maili.marvell.com (Postfix) with SMTP id 372313F7054;
	Mon,  2 Feb 2026 02:53:11 -0800 (PST)
Date: Mon, 2 Feb 2026 10:53:11 +0000
From: Anshumali Gaur <agaur@marvell.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Message-ID: <aYCCFw3cTeyA3p8R@ccs-coresight-hyd>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Authority-Analysis: v=2.4 cv=MuhfKmae c=1 sm=1 tr=0 ts=6980821d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8
 a=NDRoTk8RXLtyl5LrLHUA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 0D4climlWH_y_tOVQX2UyuYN8Kl0GX2s
X-Proofpoint-GUID: 0D4climlWH_y_tOVQX2UyuYN8Kl0GX2s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NyBTYWx0ZWRfX40eaDISd/L2U
 nrUYeUg4CmP0wxlQSnreKgGJC/AtomWr7FQk7pzC/q7Mzmgq15ylLanukXaO65EqymQA6sU8OPr
 dNuGmGivfkroKv2dXcOlweRGx4i8T1ooZ9y511WemSRcTm6TuBIK7xLjwGKa3E9uKUOXFJg8skD
 Nk5uDhWDUkSDaqwimPkZjWLP4foroWqfrk5QszITbDq4Auv3Ag9HTClz5ep7wTOrdrDEDk5uxnv
 Sz+MQ+YJ53HjGYsu6VaJ/nGtmUc3lLMo3fbhymrTQgX2t7HZlkxujI5/p7xWGJY1Iq2HuaH5QW6
 UrKJX7bXnmthTTFTnJ1NhafSZCr7vmgbF9dZPXXkcGmRakxXJjLoKtw3yjiXAQCuIT7dtLr+b1h
 Mr+v+rdJ/JCPz6f7J6ZAD2cZJE81RcVhMhVGRQFJcBjtJr+LXYyWBJQE+L5dKVUNIHKnUqbDweC
 /Qi/1eJmSpG0crQlDAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	MISSING_SUBJECT(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255834-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agaur@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: F1334CB41B
X-Rspamd-Action: no action

On 2026-01-29 at 23:02:43, Jacob Keller (jacob.e.keller@intel.com) wrote:
> 
> 
> On 1/29/2026 1:19 AM, Anshumali Gaur wrote:
> > When both AF and PF drivers are built as modules, the PF driver in the
> > kexec kernel may probe before the AF driver is ready. This leads to
> > a crash due to uninitialized hardware state.
> > 
> > This patch ensures the PF driver properly detects and waits for AF
> > driver readiness before proceeding with initialization.
> > 
> 
> To me, the patch description is not sufficient to describe the what and why
> of this change.
> 
> Could you please provide a better explanation of how the addition of the
> provided shutdown handler fixes initialization?
>
Hi Jacob,
The issue being addressed here is specific to kexec and persistent AF
hardware state across kernel transitions. When both AF and PF drivers
are built as modules and a kexec kernel is performed, the PF driver in
the new kernel may probe before the AF driver has completed probing and
reinitializing the RVU hardware. In this scenario, the hardware state
left behind by the AF driver in the old kernel is still visible to the
PF driver in the new kernel resulting in crash due to stale state.
> > Fixes: 54494aa5d1e6 ("octeontx2-af: Add Marvell OcteonTX2 RVU AF driver")
> > Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> > ---
> >   drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > index 747fbdf2a908..8530df8b3fda 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > @@ -3632,11 +3632,22 @@ static void rvu_remove(struct pci_dev *pdev)
> >   	devm_kfree(&pdev->dev, rvu);
> >   }
> > +static void rvu_shutdown(struct pci_dev *pdev)
> > +{
> > +	struct rvu *rvu = pci_get_drvdata(pdev);
> > +
> > +	if (!rvu)
> > +		return;
> > +
> > +	rvu_clear_rvum_blk_revid(rvu);
> 
> Here, I guess you are clearing some data about the device status. Does that
> mean that when you initialize later you will wait for the AF driver to
> finish probing and configure this? It would be nice to explain how this
> change fixes initialization.
>
The RVUM block revision field acts as an implicit indication that the AF
driver has completed its initialization. If this value is left uncleared
during kexec kernel booting, the PF driver may observe a non-zero/valid
RVUM block revision and incorrectly assume that the AF is already
initialized and ready, even though the AF driver in the kexec kernel has
not yet probed. This leads to PF initialization proceeding against
partially initialized hardware, resulting in a crash.
> > +}
> > +
> >   static struct pci_driver rvu_driver = {
> >   	.name = DRV_NAME,
> >   	.id_table = rvu_id_table,
> >   	.probe = rvu_probe,
> >   	.remove = rvu_remove,
> > +	.shutdown = rvu_shutdown,
> 
> This is the shutdown handler:
> > 
> >  * @shutdown:   Hook into reboot_notifier_list (kernel/sys.c).
> >  *              Intended to stop any idling DMA operations.
> >  *              Useful for enabling wake-on-lan (NIC) or changing
> >  *              the power state of a device before reboot.
> >  *              e.g. drivers/net/e100.c.
> 
> How does this have anything to do with initialization?
> 
> >   };
> >   static int __init rvu_init_module(void)
> 
> 

