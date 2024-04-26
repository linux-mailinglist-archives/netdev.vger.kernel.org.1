Return-Path: <netdev+bounces-91559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC08B310F
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE2A28405F
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7718313AD25;
	Fri, 26 Apr 2024 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjJW0HXE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5113A898
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115277; cv=none; b=bb96k4nhK4HLaiHvRDyoEbtunifWjksH50Q9o98M9UeCgjDhxNNUcX/8Yic9re8V3j590BShb+mCIckwzWbdg/d//Bo5SvIp3BKS563Vqe9mwwQC/9q5Oh/Z7vQ0viIE7xJC657Ujc+ofmwHnUQxhT0pC0XVRbwbFv2JXwOkhlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115277; c=relaxed/simple;
	bh=PPvH2xbbFgjgGBgcSBRDQ8D93s+yuimaROP0xwNz7vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogoDMESCvaBgTupdrfJ64YHrU2T+H3kxQwCVNV1IJT6ZQM/a7z5OLOAfbHxruKHX58dJ+U2zhdOjofdhnOz8lG1+KMfEQRQQEXvDwSlQFSb81Stz4IL8rzrWKgvEx0ch3oJ+G11kT4to/yODDdSNxEnFaAywiY2+FkJdiVO0WKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjJW0HXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC56C113CD;
	Fri, 26 Apr 2024 07:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714115276;
	bh=PPvH2xbbFgjgGBgcSBRDQ8D93s+yuimaROP0xwNz7vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjJW0HXEct1eyBr46W8ZfNYkpFLS2s9cEUgVEi804KmkPhnfJbdI68BU8uRI2QiQP
	 top1vIr3ww/h/hK4e6jTUOMTBkF79U1okCJRL6fiHbu84ps3MlYWvzbxkNEbP4bjna
	 Xp9H9puj5b1R6vXP5IuHiy/x8RxTDdfyGL9CrsGWqdzkzxDjj0iSAYbgXvlldvfuTm
	 iCYIUonXH3mutwAtsIsNTGuwv/NsmBaPZ/R7Bo6cbvZmt8StBWRhYbslwmFCJwX1AT
	 N0loFUm6zHXjgkuRBjB6mWHUT1D4SZnWqxFsoGCr405bc9stOPsDXTzwqyjbwgLzZj
	 NMf7AwOCu+zYQ==
Date: Fri, 26 Apr 2024 08:07:52 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net 4/5] net: wangxun: change NETIF_F_HW_VLAN_STAG_* to
 fixed features
Message-ID: <20240426070752.GX42092@kernel.org>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com>
 <20240416062952.14196-5-jiawenwu@trustnetic.com>
 <20240418185851.GQ3975545@kernel.org>
 <057001da96dd$44b592a0$ce20b7e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <057001da96dd$44b592a0$ce20b7e0$@trustnetic.com>

On Thu, Apr 25, 2024 at 02:53:24PM +0800, Jiawen Wu wrote:
> On Fri, April 19, 2024 2:59 AM, Simon Horman wrote:
> > On Tue, Apr 16, 2024 at 02:29:51PM +0800, Jiawen Wu wrote:
> > > Because the hardware doesn't support the configuration of VLAN STAG,
> > > remove NETIF_F_HW_VLAN_STAG_* in netdev->features, and set their state
> > > to be consistent with NETIF_F_HW_VLAN_CTAG_*.
> > >
> > > Fixes: 6670f1ece2c8 ("net: txgbe: Add netdev features support")
> > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > 
> > Hi Jiawen Wu,
> > 
> > I am having trouble reconciling "hardware doesn't support the configuration
> > of VLAN STAG" with both "set their state to be consistent with
> > NETIF_F_HW_VLAN_CTAG_*" and the code changes.
> > 
> > Is the problem here not that VLAN STAGs aren't supported by
> > the HW, but rather that the HW requires that corresponding
> > CTAG and STAG configuration always matches?
> > 
> > I.e, the HW requires:
> > 
> >   f & NETIF_F_HW_VLAN_CTAG_FILTER == f & NETIF_F_HW_VLAN_STAG_FILTER
> >   f & NETIF_F_HW_VLAN_CTAG_RX     == f & NETIF_F_HW_VLAN_STAG_RX
> >   f & NETIF_F_HW_VLAN_CTAG_TX     == f & NETIF_F_HW_VLAN_STAG_TX
> > 
> > If so, I wonder if only the wx_fix_features() portion of
> > this patch is required.
> 
> You are right. I need to set their state to be consistent in wx_fix_features(),
> this patch is missing the case when STAG changes.

Yes, agreed. The case where STAG changes also occurred to me after I sent
my previous email. Sorry for forgetting on follow-up on that.

