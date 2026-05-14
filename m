Return-Path: <netdev+bounces-287840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MyzDG1tBWo+WwIAu9opvQ
	(envelope-from <netdev+bounces-287840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 08:36:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E2953E682
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 08:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EDE7302A7FA
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 06:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EBC3CCFB8;
	Thu, 14 May 2026 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LSEVhgqT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20038E5FE
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740550; cv=none; b=X37VcV8CsiynhCzlSBiK20UdT8hBo51njYc2KpjICYhnE9hy+JFnjlTBQR/jDEWFT5Y7mWutjxhNsi77h31iqFGUCsqovgQl7Oq5MropGg+4K7o7FGpmTMJk0Ep7/npJH8QqByJ2jjaTstxbClK54WN59K2B7KqCI5qHj+A7uLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740550; c=relaxed/simple;
	bh=/Mm+npK7CVli2K6x/1su4fYDELPLhv2MW4SfClLkOTg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgoA5LIh/YGE8yC/3sqovPTE/wPIJFG7qG6ec0adGirfC9PX9WUMUhv7wlmop0ZgIjnRlSwiWQP6Z/63DZJWNiGMlJtyVxn+hrd6iz0th7Ho0zNvchQzPWEKeI7UyQ0zIeZEfwiA6UPUYR1I9Jy59jtu3ywgtmOPXSbDl5Ez80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LSEVhgqT; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DIJwfK1649770;
	Wed, 13 May 2026 23:35:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=tbiBElxPfon8KLfJQomgpmrLk
	4+onqYXjy+zmJNxIbI=; b=LSEVhgqTx/m/VeddIcdzSKF3NWbioW3GVE/WDYozM
	eJwpOiZlnzazoMtQUjCK9CMF7jCeS7REjpV9e3nC5Fli5bUdSIy7s28rJow0a58d
	m8wWg9sxSf+o4OSG9LTtslilR7xFltPVyTyo+plytJaaiSZ6KqPU22lD5VZxjWaS
	6geUz4COq7tUhacNWKQTINvpcCDCXRi6rZma1OyNmDpcErdVmixsnD+eaqocxAlj
	6320u/xHXWNyzVEiAUZig1uk0e9kbFnaQBDpq8NXM5RXQTK/26KJgArkHPv2NW9h
	sTdKg24iwio9hQJGbk5JhcJFm4+XS68VfCKHKbuLoPClw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e4xg11ktv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 23:35:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 May 2026 23:35:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 13 May 2026 23:35:38 -0700
Received: from hyd1lab5-269YN24 (unknown [10.29.37.83])
	by maili.marvell.com (Postfix) with SMTP id 85EFF3F704E;
	Wed, 13 May 2026 23:35:35 -0700 (PDT)
Date: Thu, 14 May 2026 12:05:34 +0530
From: Anshumali Gaur <agaur@marvell.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] octeontx2-pf: persist netdev stats across
 routine operations
Message-ID: <agVtNvSM4eE7tOvK@hyd1lab5-269YN24>
References: <20260511094205.1422268-1-agaur@marvell.com>
 <bf626b44-efad-43f2-b8b4-509934f4befa@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bf626b44-efad-43f2-b8b4-509934f4befa@nvidia.com>
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a056d3a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=5j9fDHNIZEKhxtqjiUMA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 7efKBolA-Dn5PBOtNhOZcmtRVPRdHizP
X-Proofpoint-GUID: 7efKBolA-Dn5PBOtNhOZcmtRVPRdHizP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2MyBTYWx0ZWRfX0Ei7+EQUO0vX
 Lfcg+2g6CLBGug8spksjOxHoxEdY/S0BBboJ1TWYDKMTFMRNv5ro3QqDd1wh2ttp23wtnsLz39C
 7aH05JPFIN/PjyLiX+tLQtIwborRN4vRmCGTZkdCvTq6mTTgY2FYImUbDsqk9jGrYzpJtA6X1H3
 KXf75PWl0XOxKs8scNBYvgdPMrS5LIvMqSHAwwSDYL96mM6q60Sh8ftlZkFWfUWGbHcwOMMdl4F
 4REEL6QXZlRcGN/cZ8+Lnrqoh9z7pyueAVEQzAllp093Gm/8Fl7/IhrDHsJP0CQqxiBo3Y/jo3x
 tiLU8cn8uTLI3yWoIIXEN+WwRiT6QErKrP4V5MPG5MeVbT3ady3ayq2DBWvKFvXpjTDdPNanFMg
 VNIg7hH3olf77vlHv5B9EnWkb5w5YT9VvDrRUX4wPFhVhtrFmy2F4Ve/4u9mb/OgxfcyOLfY/er
 e7Z0cwMgnsAimx08sKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: A6E2953E682
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287840-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agaur@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 12:03:32PM +0200, Dragos Tatulea wrote:
> 
> 
> On 11.05.26 11:42, Anshumali Gaur wrote:
> > Currently netdev driver is not retaining ethtool stats during
> > interface up and down, as per kernel driver standard netdev driver
> > must keep stats constant to avoid race conditions with user space
> > trying to read them. Stats must persist across routine
> > operations like bringing the interface down and up.
> > 
> > Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> > ---
> > v2:
> >   - Fix subject prefix to target net-next
> >  .../marvell/octeontx2/nic/otx2_common.c       | 20 ++++++++++---------
> >  .../marvell/octeontx2/nic/otx2_common.h       |  1 +
> >  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 18 +++++++++++++++++
> >  3 files changed, 30 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > index 971fcab1c248..0ffcc613a4b2 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > @@ -139,19 +139,21 @@ void otx2_get_stats64(struct net_device *netdev,
> >  		      struct rtnl_link_stats64 *stats)
> >  {
> >  	struct otx2_nic *pfvf = netdev_priv(netdev);
> > -	struct otx2_dev_stats *dev_stats;
> > +	struct otx2_dev_stats *dev_stats, *old_stats;
> >  
> >  	otx2_get_dev_stats(pfvf);
> >  
> >  	dev_stats = &pfvf->hw.dev_stats;
> > -	stats->rx_bytes = dev_stats->rx_bytes;
> > -	stats->rx_packets = dev_stats->rx_frames;
> > -	stats->rx_dropped = dev_stats->rx_drops;
> > -	stats->multicast = dev_stats->rx_mcast_frames;
> > -
> > -	stats->tx_bytes = dev_stats->tx_bytes;
> > -	stats->tx_packets = dev_stats->tx_frames;
> > -	stats->tx_dropped = dev_stats->tx_drops;
> > +	old_stats = &pfvf->hw.old_stats;
> > +
> > +	stats->rx_bytes = old_stats->rx_bytes + dev_stats->rx_bytes;
> > +	stats->rx_packets = old_stats->rx_frames + dev_stats->rx_frames;
> > +	stats->rx_dropped = old_stats->rx_drops + dev_stats->rx_drops;
> > +	stats->multicast = old_stats->rx_mcast_frames + dev_stats->rx_mcast_frames;
> > +
> > +	stats->tx_bytes = old_stats->tx_bytes + dev_stats->tx_bytes;
> > +	stats->tx_packets = old_stats->tx_frames + dev_stats->tx_frames;
> > +	stats->tx_dropped = old_stats->tx_drops + dev_stats->tx_drops;
> I don't quite understand why the additional old_stats is required.
> Why not accumulate dev_stats in place? Either directly in
> otx2_get_dev_stats() or pass a local struct otx2_dev_stats var
> and then accumulate that into dev_stats?
> 
> Thanks,
> Dragos
>
Hi Dragos,
Thanks for the review.
otx2_get_dev_stats() reads absolute HW counter values from
NIX LF stats registers and does direct assignment to dev_stats 
(e.g., dev_stats->rx_bytes = OTX2_GET_RX_STATS(RX_OCTS)).
These HW counters reset to zero when the interface goes down.
Since they report absolute values, not deltas,
accumulating in-place with += would double-count on every stats query.

Thanks,
Anshu

