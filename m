Return-Path: <netdev+bounces-250954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9552D39D24
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 04:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 802C130057D9
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 03:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA624469E;
	Mon, 19 Jan 2026 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D68ww/gx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16111713;
	Mon, 19 Jan 2026 03:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793966; cv=none; b=gKPpzpc3tzFGr2llSvYbIogcm01UgfWvkGSSOa8NNKLwo4UKdijHN+UEOFf786aIfKZrYmJTeN1kvDugtgUidTRzBVwaWshVuMStpe2qVIrYz5m9TWm53+mJhiIX0okQVdQvRnqgJS2hXztGWgw78zVBoXe2Lr8M4j9y9QTZNkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793966; c=relaxed/simple;
	bh=zVq0maY3neFZpTw+zdDvRC2+G9U6U24qoQ/GiHsS9gk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueeHcK5cB8uNVoZncfk3boKQkJj0OCpEea0pM63f6bujFj+ghMiC+ywWmnojWMqeGzO0HUTmSenm5co71gNKuWWUrgTu1UyoXRAfE7FUKxGkaiiHyEc9ehtOUaIx5qg05Dz1Mo3rAsm+hiBG/oHhBzUOTXhzJ3v4STUzJZ9wSG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D68ww/gx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60IMts753045362;
	Sun, 18 Jan 2026 19:39:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=IsV9PdzD/S19kr6ZhTykXDEUt
	0+r2vPiYGoNnNfUDLE=; b=D68ww/gxCjAzcFbKu00zp5qaEIQXG4Vq1+PrdOH3u
	oS+wEo4rVX4AZtsLxpAPPN+81Oijnl07LKzD5Ev3YDEhapH+CfWOey1uFEnBLLQC
	Vol/tG1J1cZ7gD8FStwrRJZCj52oobxpYz6S7TOZO56UjVRF2aZAtEH6kd7yNUX1
	khPMZMgKUBB4dj9oPsujl7NHBfAjTZ6hTIIxTTfyk/N6x3OBxC0gQkUsjVqIgbQ1
	+YM5J/1nPJHSlmZtswYfYYT2ExYMbG5QircVqkpuVvP0rUh+1yQm/uG29ONQD2PU
	MFlNKkHWZfe2acbseehIxp34lEMjhXmh0C5oRA6oKrxRg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4br8nnag73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 19:39:11 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 Jan 2026 19:39:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 18 Jan 2026 19:39:25 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id F0F433F7041;
	Sun, 18 Jan 2026 19:39:08 -0800 (PST)
Date: Mon, 19 Jan 2026 09:09:07 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [net-next,v4,11/13] octeontx2-pf: cn20k: Add TC rules support
Message-ID: <aW2nWxWzIShdMGNn@rkannoth-OptiPlex-7090>
References: <20260113101658.4144610-12-rkannoth@marvell.com>
 <20260118004028.1044419-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260118004028.1044419-1-kuba@kernel.org>
X-Proofpoint-ORIG-GUID: EH5_MJ9g6Ox4u-JAYAzL9Tf1I16QPSZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDAyOCBTYWx0ZWRfX3RqVnxa/xaG2
 m58sW8kETd/919Ynodi93kbPi0PFm5rM9yg4YNw9QIZDQkvUHsevH5vYQWEbbKJ6qvWYQh53Aa5
 yhDfnNGVuVKTM4zLY7C9hgsmEokW8T/ADG2ny7u9c+C4hRa/39UOqXQc+zZGwVgc253B0vTDOnF
 wKPVPljCGbraBBc0jNrGAKzTrNSGQLAliToPMLFeoFIwHkIiSo+D4vs/PNyyXwFGN3gLDL9mV/D
 bCWVevHhzXyre0U/14Sip/KAjBTC+VGGosx8YKCXIiwHBoIZadj0QyPf4vIPf5ndkuT2XourRML
 0I8DEwBWqslOIcySNVdCzs9WlQmQGKktwWlXRH2Xnnklwbcgfvfx2MoH8l2ZRDhrVk4D5u8MG7e
 nkKhmJHUlqVhpWt2qidK96nQngxBFIGpQKZ0grt1b6uStkm8COsPbq1oiV6pZthnwB9SDoyoMkU
 MEuwxIZxFKDxJNBR4xQ==
X-Proofpoint-GUID: EH5_MJ9g6Ox4u-JAYAzL9Tf1I16QPSZp
X-Authority-Analysis: v=2.4 cv=FcM6BZ+6 c=1 sm=1 tr=0 ts=696da75f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=FUywjqrfPLAny1KmV_UA:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01

On 2026-01-18 at 06:10:28, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-pf: cn20k: Add TC rules support
>
> This patch adds dynamic MCAM entry allocation for TC rules on CN20K
> silicon, with support for X2/X4 key widths and entry shifting based on
> rule priorities.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > index 26a08d2cfbb1..866d9451f5d6 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>
> [ ... ]
>
> > @@ -1292,7 +1277,23 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
> >  	if (old_node)
> >  		otx2_tc_del_flow(nic, tc_flow_cmd);
> >
> > +	if (is_cn20k(nic->pdev)) {
> > +		rc = cn20k_tc_alloc_entry(nic, tc_flow_cmd, new_node, &dummy);
> > +		if (rc) {
> > +			NL_SET_ERR_MSG_MOD(extack,
> > +					   "MCAM rule allocation failed");
> > +			kfree_rcu(new_node, rcu);
> > +			return rc;
> > +		}
> > +	}
> > +
> > +	entry = otx2_tc_update_mcam_table(nic, flow_cfg, new_node, true);
> > +	if (entry < 0) {
> > +		NL_SET_ERR_MSG_MOD(extack, "Adding rule failed");
> > +		rc = entry;
> > +		goto free_leaf;
> > +	}
> > +
> >  	mutex_lock(&nic->mbox.lock);
> >  	req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
> >  	if (!req) {
> >  		mutex_unlock(&nic->mbox.lock);
> >  		rc = -ENOMEM;
> >  		goto free_leaf;
>                 ^^^^^^^^^^^^^^
>
> For CN20K, if cn20k_tc_alloc_entry() succeeds (allocating an MCAM entry
> from AF) but then otx2_mbox_alloc_msg_npc_install_flow() or
> otx2_sync_mbox_msg() fails, the code goes to free_leaf. Looking at the
> free_leaf cleanup path below, it calls otx2_tc_del_from_flow_list() and
> kfree_rcu() but does not call cn20k_tc_free_mcam_entry() to return the
> AF-allocated entry.
>
> Is this leaking the MCAM entry on CN20K when these error paths are taken?
>
> The cn20k_tc_update_mcam_table_add_req() function does call
> cn20k_tc_free_mcam_entry() when it fails internally (due to X2/X4 mix),
> suggesting MCAM entry cleanup is expected.
ACK.
>
> > @@ -1304,7 +1305,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
> >  	memcpy(&dummy.hdr, &req->hdr, sizeof(struct mbox_msghdr));
> >  	memcpy(req, &dummy, sizeof(struct npc_install_flow_req));
>
> [ ... ]

