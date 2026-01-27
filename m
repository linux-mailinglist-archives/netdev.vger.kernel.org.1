Return-Path: <netdev+bounces-253799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNkWFWiPeGmqqwEAu9opvQ
	(envelope-from <netdev+bounces-253799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:11:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD24392834
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF32A301440E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9B92ECD32;
	Tue, 27 Jan 2026 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Kq7ZwJnN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4B5464F;
	Tue, 27 Jan 2026 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508709; cv=none; b=DMgQoPHhn3Uji1w0LbYijhMFddimgkuXddciQT9JKgaeVwVHWVUY32/EwL/7BxE7wrOxtF1Bb2JhB8Cy18zJkUQCVWFCYpDUakdAlLn2DAm06R8naVcyQdcoE6mFnomCYMsfIib/WwNTqYctLEjeS6W9Ef2+GEUbiCvUu6/7MvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508709; c=relaxed/simple;
	bh=e3zoIeoT01TxqHxArm9WvDDZyPFKmRbP4ykSy1sYcMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAvI6vnN4LT+vty+mzNm//pgmcNu8gnuwHGlJ32Eg4+LF1rZgnZRcYu1hQt1jiYCfgiJlyjEOkL44jhdIWhvVyrDXoLCjzprXC+v+Zkge/3bmmgh2XRpQaE2fPpMKuBJAv/Sxnz5LHPEnssI63ZpQk2XGef9x5z7CWcFUZBkGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Kq7ZwJnN; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3220d02a0;
	Tue, 27 Jan 2026 18:11:38 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jianhao.xu@seu.edu.cn,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	marco.crivellari@suse.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	zilin@seu.edu.cn
Subject: Re: [net,v2,2/2] net: liquidio: Initialize netdev pointer before queue setup
Date: Tue, 27 Jan 2026 10:11:36 +0000
Message-Id: <20260127101136.960753-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aXeN1EsGgr_YQi8s@horms.kernel.org>
References: <aXeN1EsGgr_YQi8s@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bfeeff79103a1kunmac595d87490c7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT04aVkoaTU4eQkpOHR1NSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Kq7ZwJnNVDeIqqWiZDxIBnoBBDXxFf51oSklyHEyztkVTYahcqs7RjgOl7UylBDPK0dGiFKmylO4d4YbJv1wu8DH5Vi4eyryqXMC6OHvxi3pMTRPq07sn5SIUHdu9TKNax4yq6FMlIOlszzGHkj/bNUW5lZmS+l9F/17uskf/Ks=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=J9SU9aT17Vm3BnXpbgBFOLpKYQ3y6Jcs3WDE4zpdw4M=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253799-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,seu.edu.cn:mid,seu.edu.cn:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD24392834
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 03:52:52PM +0000, Simon Horman wrote:
> On Mon, Jan 26, 2026 at 03:49:41PM +0000, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> > ---
> > net: liquidio: Initialize netdev pointer before queue setup
> > 
> > This patch moves the initialization of lio and props structures earlier
> > in setup_nic_devices() so that props->netdev is set before calling
> > netif_set_real_num_rx_queues() and netif_set_real_num_tx_queues(). The
> > intent is to fix a memory leak where the allocated netdev would not be
> > freed if queue setup fails.
> > 
> > > diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > > index 3ba2806f5d1e..2383f0173a54 100644
> > > --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > > +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > > @@ -3505,6 +3505,16 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
> > >  		 */
> > >  		netdev->netdev_ops = &lionetdevops;
> > >
> > > +		lio = GET_LIO(netdev);
> > > +
> > > +		memset(lio, 0, sizeof(struct lio));
> > > +
> > > +		lio->ifidx = ifidx_or_pfnum;
> > > +
> > > +		props = &octeon_dev->props[i];
> > > +		props->gmxport = resp->cfg_info.linfo.gmxport;
> > > +		props->netdev = netdev;
> > 
> > Moving this initialization earlier fixes the memory leak, but now if
> > netif_set_real_num_rx_queues() or netif_set_real_num_tx_queues() fails
> > below, the cleanup path in liquidio_destroy_nic_device() will proceed
> > further than before since props->netdev is no longer NULL.
> > 
> > Previously, when queue setup failed, liquidio_destroy_nic_device() would
> > return early at the "if (!netdev)" check. Now it continues and calls
> > cleanup_rx_oom_poll_fn().
> > 
> > In cleanup_rx_oom_poll_fn() (lio_core.c), the code does:
> > 
> >     struct lio *lio = GET_LIO(netdev);
> >     struct octeon_device *oct = lio->oct_dev;
> >     ...
> >     for (q_no = 0; q_no < oct->num_oqs; q_no++) {
> > 
> > Since lio->oct_dev is not assigned until much later in setup_nic_devices()
> > (around line 3602), it will be NULL after the memset above. Would this
> > cause a NULL pointer dereference when cleanup_rx_oom_poll_fn() tries to
> > access oct->num_oqs?
> > 
> > > +
> > >  		retval = netif_set_real_num_rx_queues(netdev, num_oqueues);
> > >  		if (retval) {
> > >  			dev_err(&octeon_dev->pci_dev->dev,
> > 
> > [ ... ]
> 
> Strangely the AI review did not pick this up for v1.
> (And neither did I.)

Hi Simon,

Apologies for missing this dependency.

I will update the code to initialize lio->oct_dev alongside props->netdev
to prevent NULL pointer dereference in cleanup_rx_oom_poll_fn().

Thanks,
Zilin

