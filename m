Return-Path: <netdev+bounces-256591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB18IH7kgmnXeAMAu9opvQ
	(envelope-from <netdev+bounces-256591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 07:17:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA4AE242F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 07:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 896C8301CCDB
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 06:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1232A378D8B;
	Wed,  4 Feb 2026 06:13:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F983793D7
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185602; cv=none; b=GavhUA+CxyhXX+gvS3gHEHiBasg093qkgwZuUzLn0sHtt3x3wX4tt0P3JYN5FptVyhKQHYflUSIVAUBKuRPR9ZzmSeiX4xqL/8+qyGxKU3mJqDdLGogOiiqjG2363LpB5LLLYFlZXj/6RsSE6VHiH3Oz29NxYwfjISamvukXqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185602; c=relaxed/simple;
	bh=gOJUfU9ZwUTUcvErmB8eHjctaHK7MjKDvR4OoAmrEEo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jh4zyGxW5qSF72ZGFAieR6OpfvAItNIgkhox8fjJiejS6fo8wgQW6LHk9NnkJ+lIHSGzb3FJwiDxiBPKJAyAw0Sz99BPOaCSE5uOay5ZBJvvoclQ2/NS+uvUJj5uXH8mqKaAb6TUp8VlOFsvFdaqRfYkJtqTOMrIsq3wQKcOmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas8t1770185544t125t30793
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.47.234])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 11256689284959278636
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <mengyuanlou@net-swift.com>,
	<horms@kernel.org>,
	<netdev@vger.kernel.org>,
	<edumazet@google.com>,
	<davem@davemloft.net>,
	<andrew+netdev@lunn.ch>,
	<pabeni@redhat.com>,
	<mengyuanlou@net-swift.com>,
	<horms@kernel.org>,
	<netdev@vger.kernel.org>,
	<edumazet@google.com>,
	<davem@davemloft.net>,
	<andrew+netdev@lunn.ch>,
	<pabeni@redhat.com>
References: <20260203075759.5852-4-jiawenwu@trustnetic.com> <20260204022237.1572988-1-kuba@kernel.org>
In-Reply-To: <20260204022237.1572988-1-kuba@kernel.org>
Subject: RE: [net-next,v1,3/7] net: wangxun: move reusable PCI driver ops functions into libwx
Date: Wed, 4 Feb 2026 14:12:23 +0800
Message-ID: <06f301dc959d$3a2af490$ae80ddb0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQI3Gzvaa9GsNIIWYYXMH7iDxO0L5gKFEN8CtKja+AA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mf+wQkWJ2TuY/dJighpVIdcxA3NwexssY/Qp4XG4h0iWccmsY/gwtH1F
	LNg28245+2lWz6fxICAItQgsQQ5hizcYxbIvkA+KkPwUnW19AM8HKMXrKD+OMeGK7HZ1rre
	h4CwsXxBGbTbE7qrBbgHSSIdqQs4lWGjTOrBh5lgbOzdTiqzEJJU3QbfSLwUxAO2MeAi9T4
	mc+3JqoM5ApaDwEKr+J7mSmapxOZZnO43yocCmj7XhgU5/IN2ii7wOZ0YRrPkJc//tkFjFU
	lMR3xoK28xvAZr3I1IA3hQOPwloLrOo6djaM/ulcgDHoTvUZg+b8xNNljOjRKM/42knxnKC
	wdtJmoYjBdSrIcJN4D0p8tvbIMqnUXLVcSqHUG6bzKIY8d1I8h9LgdDQu/rig5cpFrfI1Vz
	qU4vUCrqipGpAHOWKQ/WAVZeL1BhJ8KNm1elq4b89TMutd6Dz0XVGnwlvbwaGk610uuzM1Z
	GsaxIGiw8+ayx/mf8/c5ZjgRpPaQZTtOg+l7TkZM4YT6xX7plTH9sr9sxWnGQ/FJD8vVnzP
	xMlHpoGGq1yOiNP+8SJwmukc9PBsfmcCSbiyBKJ+uDTVyAt49BDsv76qUccVpA4sL87tV+y
	NeHDhQk7pch8Jsik1XR8X5xyVcK1NoIOuIULZuD1gOhODqaqB78opSytPL1/lqxpghsy5eS
	hqu9WjlTcTAeEk5eLZIXWK1fL5GcykZSSjPNsS+AGVIKnFifhQoI1Szaz1GGOP5C+nvzxCw
	Ectpp+GTAQRiU+kYz5sWYGftF2GPOIsVSOnQxofgRmOgEUh5Gz9+wZq+01znosMYzZ+WZoC
	sAqn9muBEOtvtzsIVtP8nWNf4ixsVB8VkV6fwYw+F7uhJYbmIEDNmzR/wKHsGgTedzxldJU
	U8Bz/3NbWR32OEbvKpuy1cZhwSJG8zdxxfJtEvVm0ntY/6WdP3KCEi/9mYsuRsHAQ+Xi6Gh
	oBZD+BhJKF7NPpF7gyYJPXE5PSrQtA0poX5mNPTkLNRsRmJobXSbd9h+zaU02vIktu0QaI+
	doR3Aj7FuFNPC8/Dfhjog674Qv5Ey2ArP5xFggV9cbs5hU5t4dDiJwAOugtIO/MpilXjum1
	CAUBtH3BnExVZckH1oBOiw=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256591-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDA4AE242F
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 10:23 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Sending this out without checking since you have to
> repost. Please note that the AI code review may be wrong especially
> around defensive programming (which we recommend against)."
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: wangxun: move reusable PCI driver ops functions into libwx
> 
> This commit refactors PCI driver ops functions (suspend, resume, shutdown)
> from ngbe_main.c into the shared libwx library, adding function pointers
> wx->close_suspend() and adjusting wx->do_reset() to support this.
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> 
> [ ... ]
> 
> > +int wx_resume(struct pci_dev *pdev)
> > +{
> > +	struct net_device *netdev;
> > +	struct wx *wx;
> > +	u32 err;
> > +
> > +	wx = pci_get_drvdata(pdev);
> > +	netdev = wx->netdev;
> > +
> > +	err = pci_enable_device_mem(pdev);
> > +	if (err) {
> > +		wx_err(wx, "Cannot enable PCI device from suspend\n");
> > +		return err;
> > +	}
> > +	pci_set_master(pdev);
> > +	device_wakeup_disable(&pdev->dev);
> > +
> > +	wx->do_reset(netdev, false);
> > +	rtnl_lock();
> > +
> > +	err = wx_init_interrupt_scheme(wx);
> > +	if (!err && netif_running(netdev))
> > +		err = netdev->netdev_ops->ndo_open(netdev);
> > +	if (!err)
> > +		netif_device_attach(netdev);
> > +	rtnl_unlock();
> > +
> > +	return 0;
> > +}
> 
> Does wx_resume() need to return the error value stored in err?
> 
> The function assigns errors from wx_init_interrupt_scheme() and ndo_open()
> to the err variable, and correctly skips netif_device_attach() when errors
> occur, but then unconditionally returns 0 instead of returning err.
> 
> The early error handling for pci_enable_device_mem() correctly returns err,
> but errors from the later calls are lost. This would tell the PM core that
> resume succeeded when it actually failed.

OK. I'll correct it.



