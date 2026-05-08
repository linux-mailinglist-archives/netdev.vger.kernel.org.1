Return-Path: <netdev+bounces-285722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJLkAYKi/WmwgQAAu9opvQ
	(envelope-from <netdev+bounces-285722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:44:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F9E4F3DBF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AFD3300D464
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA0C33BBAF;
	Fri,  8 May 2026 08:44:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19B37C11E
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229886; cv=none; b=UuTRrVeEJfuazLTt+Vl/WRXOaUJXBBDyN90ZSkXmQawnPnRjpr67BihIvc0qP/uP9zJrAcqiogf3kH4/Qni7cwcZPt/pDkAhp5OZUPzfUSItzwGVOlSPKX1zdazT4l43QZIwRA4tn8x1LpDYfOb+tJvClRGX/pvif0ghu1FI+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229886; c=relaxed/simple;
	bh=hF2cY836LJIpXS4vQghwyB9jREEaQQyS14SxfqBmIOU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=nLeT3hM9ikU5byWdFP8L5qvq03Y6snlgsCpjVdP2dN+TdJV3cQrDJLlor+gGAtczSrQgefNxP1E4C8BtFds5smp1M2ytm2they1B0F21NRtRmxgVTAV3XZBd137C7lBtacitlG8mNFZJWYBmDBxdUkJWLTlxnnFYO0pH89zxYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas10t1778229841t201t25828
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.244.4])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 5630249792012590739
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<kees@kernel.org>,
	<larysa.zaremba@intel.com>,
	<leitao@debian.org>,
	<joe@dama.to>,
	<jacob.e.keller@intel.com>,
	<fabio.baltieri@gmail.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<kees@kernel.org>,
	<larysa.zaremba@intel.com>,
	<leitao@debian.org>,
	<joe@dama.to>,
	<jacob.e.keller@intel.com>,
	<fabio.baltieri@gmail.com>
References: <20260430082517.19612-6-jiawenwu@trustnetic.com> <20260503021536.4127361-1-kuba@kernel.org>
In-Reply-To: <20260503021536.4127361-1-kuba@kernel.org>
Subject: RE: [PATCH net-next v2 5/6] net: wangxun: clear stored DMA addresses after dma_free_coherent()
Date: Fri, 8 May 2026 16:43:59 +0800
Message-ID: <05d601dcdec6$d0c58a10$72509e30$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQLpQ8cnx5tQgpavr6X+xPHX+BoRmgEzKPP6s+FrQVA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N30UA4ZiPg7fDw0ifkn/6G4Swpeqbkhg2oxdOpnFPQrGvZ7ZQGW51P+z
	XjK101bH0QCNzY/XJPQO+EXOZ40yJX7rBv1LydDQXNoTjrFJ4cwKB8B+an9B+1184hHNz8Z
	jgGIXXGJdQ60avpNBS+S13WUPdbI/IsT4XkEqElIvjv+v/iXWntJX0XkUjtVTD5A6bGOngl
	A5CeJ2dWekMgvTUpwxm1X4UFtfaDu0rbp+CqJTw/NGqZ+A4kX7GnRphfi0kfh1MkZXyUe+R
	mnh4Me6iFUOJwjzz1o24KrJLOIGTZouWXfQdYXKSARPbfSsLgD4BNQ79uuGIVsJ5qXoLzci
	NNZFU3Zzka+MYApHaa+Fb5ZjCy72Fktiq+VEqG+IiCvXVDbt787ZXkex+t9UE1v6MiK/pR0
	lKV0Z29cMHK5x7tMz5ukTMPVhHcrM5MjYciRucUNWayjiYSUMtFAc+9j+LtDjxze6OxmQW6
	Ca3o1pEdw6g/fAmgeOTOd54RYDhv4jUH+Ogq/JtlTmBMIqoZmfRwEnTyBKYPSJ/vtcOKtkq
	C8fegSNmiXrhrotEuAJ+VFHy3uZASHSiL6A17JhyQK06dPbT3aJ4RcRD+UrqTRNyPFYieRl
	KurQzZD6OSIvTnQhG26IzqkUPoPY47Y3GLsUwPhTbEvoMfQlSKKjL6+Yh2rI+vYdi0G5chy
	3wjDPLh1h8XeTNATtxPytAjAzJ/Pc6pFcVavWSKRNUdkS8dCF3877QrBXidzpyP8B+yPuAc
	L0pfQ5CA7P5nM1JJjIMFK/RuDCF+5/2hJVo4iOKriFHX0+RPfTrGP+BFRBILDwmev4iMSLS
	FnWEpWKhJvSGcNZqbPsQkGEtUbpGvDYtTSulHUsE0mD8it1WwPMMSHBi1/GaqjgvzgKf+u1
	6o6X8n4alO+OK2G/Tfu72s+Y4Ow6NHXARert23sMt1kFR71njg0xXEIdBoW+xMrzTUGmP2C
	1S0lkEQfJtf5prZpUVmK8WP/TLmPlafAJKBbzCPH4JwHkLl0lR3S2wJUg7vM4UHdyeXXCuz
	lUt/yde3LHI6EjllppiGc1jhFGkgSI+EMdwAul0pR1aGnvm+soF69zxfAlTYzqAvyTVN+Dd
	w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 54F9E4F3DBF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285722-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,intel.com,debian.org,dama.to];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.889];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 3, 2026 10:16 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: wangxun: clear stored DMA addresses after dma_free_coherent()
> 
> This commit clears the ring DMA addresses after freeing their resources via
> dma_free_coherent() in the wangxun driver. It aims to prevent use-after-free
> of the DMA rings at shutdown when WOL is enabled.
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > index 3216dee778be7..51599f6b878e7 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > @@ -2462,6 +2462,7 @@ void wx_free_isb_resources(struct wx *wx)
> >  	dma_free_coherent(&pdev->dev, sizeof(u32) * 4,
> >  			  wx->isb_mem, wx->isb_dma);
> >  	wx->isb_mem = NULL;
> > +	wx->isb_dma = 0;
> >  }
> 
> This isn't a regression introduced by this patch, but can dma_free_coherent()
> be called with a NULL wx->isb_mem virtual address here?
> 
> Since wx->isb_mem is only allocated when the interface is brought up, if the
> module is removed while the interface is down, wx->isb_mem will be NULL. Does
> passing a NULL virtual address to dma_free_coherent() cause a panic here, and
> should it be guarded by a NULL check?
> 
> [ ... ]
> 
> > @@ -2678,6 +2679,7 @@ static void wx_free_rx_resources(struct wx_ring *rx_ring)
> >  			  rx_ring->desc, rx_ring->dma);
> >
> >  	rx_ring->desc = NULL;
> > +	rx_ring->dma = 0;
> 
> If rx_ring->dma is set to 0 here, and Wake-on-LAN is enabled, does this result
> in the hardware being programmed to DMA directly to physical address 0?
> 
> Looking at ngbe_dev_shutdown(), it frees these resources and then calls
> wx_configure_rx(). Inside wx_configure_rx_ring(), the driver programs the
> base address registers WX_PX_RR_BAL with ring->dma, which is now 0. When a
> WOL packet arrives, could this cause silent memory corruption or fatal
> IOMMU faults?

For the hardware design on this device, WOL packets are handled before DMA ring.
So programming a zeroed ring->dma does not result in DMA transactions to
physical address 0. At this point, the original code is fine.

> 
> Additionally, this wasn't introduced by this patch, but does the shutdown
> sequence trigger a NULL pointer dereference when WOL is active?
> 
> Earlier in wx_free_rx_resources(), rx_ring->rx_buffer_info is freed and set
> to NULL, but ring->count retains its original value. During WOL shutdown,
> ngbe_dev_shutdown() frees these resources and then reconfigures the RX rings
> via wx_configure_rx_ring().
> 
> If wx_configure_rx_ring() executes:
> memset(ring->rx_buffer_info, 0, sizeof(struct wx_rx_buffer) * ring->count);
> 
> with a NULL pointer and a count > 0, won't this cause a kernel panic?
> 
> [ ... ]
> 
> > @@ -2906,6 +2910,7 @@ static int wx_setup_rx_resources(struct wx_ring *rx_ring)
> >
> >  err_desc:
> >  	dma_free_coherent(dev, rx_ring->size, rx_ring->desc, rx_ring->dma);
> > +	rx_ring->dma = 0;
> >  err:
> >  	kvfree(rx_ring->rx_buffer_info);
> >  	rx_ring->rx_buffer_info = NULL;
> 
> Should rx_ring->desc also be set to NULL here?
> 
> If wx_alloc_page_pool() fails, the driver jumps to err_desc and frees the DMA
> memory, but leaves rx_ring->desc pointing to the freed memory. Since wx_ring
> structures can be reused across interface up/down cycles, could this dangling
> pointer bypass the if (!rx_ring->desc) safety check in wx_free_rx_resources()
> and cause a double-free later?
> 


