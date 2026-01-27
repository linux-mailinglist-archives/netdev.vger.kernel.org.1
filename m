Return-Path: <netdev+bounces-253852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFt6Jky2eGlzsQEAu9opvQ
	(envelope-from <netdev+bounces-253852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:57:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056B94955
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 140DF30583AD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CEF355802;
	Tue, 27 Jan 2026 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufhEVLBC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6A3557FD;
	Tue, 27 Jan 2026 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518421; cv=none; b=E7fM6tC6n+oXsQlyyqgibcR/x5ewSTW0UGI3wdbW+3ft7sByeYmC7FfW8z3ALup81se9mGXvjtFxEqSLbFfdN+8FvKtEVS+XHqqwZSZ9cHhl4WKObYL0wQy8OPa/VFHdNSSc6YSmtgU73+HMnkodZ0Zz99SP482W0shc4KkDPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518421; c=relaxed/simple;
	bh=P2fI4zhGmSG3w1JBfh1j1ADfoI8Gq0YRrnXr1JCDZWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4X500B084fHGRoSZMrb4CCN0/XYGMCoyYB1wBGhL3cLwZdcJlO01cHokS2XRf2GDtnL9kbx8iZJ6xDVGG7EtcCGup6kXQ/j6YLyYwu/KbTXJv3FC/ylxHUvJETTe+1q5wu3DqElzB6mUm7yi9SxNGxOpctGbY1tpWjlWz9TCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufhEVLBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A68C116C6;
	Tue, 27 Jan 2026 12:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769518421;
	bh=P2fI4zhGmSG3w1JBfh1j1ADfoI8Gq0YRrnXr1JCDZWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufhEVLBCkT8kChpNyO2l75fdZicFtbglWgVIE2SbMLNQmpm0DK4SSJqXjXOkOxBZw
	 541fWTC8Ad8JspJhyRRY1d8j3DTV5wkznFaCmBvcqttOHl3eO47OLwZJQ0+3AnWLqc
	 np0e+bOSnVOaozQxFtfuLzIek2b4BZWXFt6XwO/ndE+JDMbRrFwfdeuidP4rEJ65QR
	 TWLcygY3sDeK94c5GiQ2W23dJhbSLHtv5jfGR1aTuQB4ARr0NjB8IZ28/d6+nDuYf4
	 8ipQtPoBLrMSSAmd2n2ZMiTYTMI+PDgJ9VDiuLSAnui3YTOfn44A2EwXPtNMTYLees
	 hW2XdXpp47FMw==
Date: Tue, 27 Jan 2026 12:53:35 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com, lantao5@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] extend bit width in the flow director of
 HNS3 driver
Message-ID: <aXi1T3WUmc0QvlN_@horms.kernel.org>
References: <20260123094756.3718516-1-shaojijie@huawei.com>
 <aXd0QSip2AcefqT2@horms.kernel.org>
 <acbfdba6-1590-417f-8bf5-f5ad44e1c294@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acbfdba6-1590-417f-8bf5-f5ad44e1c294@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253852-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0056B94955
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 09:50:21AM +0800, Jijie Shao wrote:
> 
> on 2026/1/26 22:03, Simon Horman wrote:
> > On Fri, Jan 23, 2026 at 05:47:54PM +0800, Jijie Shao wrote:
> > > The bit widths of HCLGE_FD_AD_QID and HCLGE_FD_AD_COUNTER_NUM are
> > > increased to support higher specifications.
> > > 
> > > Note: The hardware already supports the specifications.
> > Hi Jijie,
> > 
> > Are there any compatibility issues here?
> > E.g. new driver with old hardware or firmware?
> 
> Thank you, There are no compatibility issues.
> 
> The chip and firmware are supported in V2.
> However, the software does not support the extension due to
> consistency with older versions(and the customer has not used the extended bits either).
> 
> The queue_cnt and counter_cnt specifications of the software are directly
> or indirectly queried from the firmware, and the extended bits are not
> used in the V1 version.
> 

Thanks, I think that addresses my concern.

The code changes themselves look good to me.
So, for the series:

Reviewed-by: Simon Horman <horms@kernel.org>


