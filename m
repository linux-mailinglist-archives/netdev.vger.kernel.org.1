Return-Path: <netdev+bounces-170883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B3A4A69E
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 00:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AFF171248
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 23:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D71DED57;
	Fri, 28 Feb 2025 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lXUikDD7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386DE1957FF
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740785896; cv=none; b=olimYjdYDLOaNPTZnu6Yb6m79ktCv0tXCLlmh2k9D8/lk3xpJkpdQbNjxnxPgGxhV9KkC5E6kGmnGs4AcatpMMKYU2FrNB02TWtnlZiDFL2ZK7hhc6yVvOf6vTavcpg0zgbkZ1nLbKDLPUE/AnwpEXNHgBoW/2w0kN65fBYcSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740785896; c=relaxed/simple;
	bh=3cAZ0CGMAVQnGeei+IdQgG2KLXPDt57fm1GUaEDqBCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLcw55YX+yda+7YeNTfsZbmujmtZG1p2vwC1U2tecpeUNiK+z099gwInu5VmmuNoQaxBKzJjWBq5FdXyKnkF1BOApsgX1Uvq7CS4T6CwRAVlNrB1gmsL6h76XJW4MiU+usD9exUrM+vJgjudJ51IL7Db7Ox8miEulAkwRNZcyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lXUikDD7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M3q83vim65uOOsrl52ESalj8QuJxcCSm53AiMCKTXjk=; b=lXUikDD7KrLYKNLM7mmfe8F90G
	4bUoncyKg6jBAGiP2RH2IBnkX55q6lwu4TghSy8w0i3/W/1N+G3wDmZ+lDCLdASDbaFK+4KDD4wwF
	0jt55gwPnmKaQimL4rgmL1E2nIsHzLj0Tk1BZalKFGWjrRQzPYWv+RRv8ohbjzUwt+c8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1to9vg-0016RL-Hw; Sat, 01 Mar 2025 00:38:04 +0100
Date: Sat, 1 Mar 2025 00:38:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev <netdev@vger.kernel.org>
Subject: Re: [QUERY] : STMMAC Clocks
Message-ID: <84b9c6b7-46b1-444f-b8db-d1f6d4fc5d1c@lunn.ch>
References: <CA+V-a8u04AskomiOqBKLkTzq3uJnFas6sitF6wbNi=md6DtZbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8u04AskomiOqBKLkTzq3uJnFas6sitF6wbNi=md6DtZbw@mail.gmail.com>

On Fri, Feb 28, 2025 at 09:51:15PM +0000, Lad, Prabhakar wrote:
> Hi All,
> 
> I am bit confused related clocks naming in with respect to STMMAC driver,
> 
> We have the below clocks in the binding doc:
> - stmmaceth
> - pclk
> - ptp_ref
> 
> But there isn't any description for this. Based on this patch [0]
> which isn't in mainline we have,
> - stmmaceth - system clock
> - pclk - CSR clock
> - ptp_ref - PTP reference clock.
> 
> [0] https://patches.linaro.org/project/netdev/patch/20210208135609.7685-23-Sergey.Semin@baikalelectronics.ru/
> 
> Can somebody please clarify on the above as I am planning to add a
> platform which supports the below clocks:
> - CSR clock
> - AXI system clock
> - Tx & Tx-180
> - Rx & Rx-180

Please take a look at the recent patches to stmmac for clock handling,
in particular the clocks used for RGMII

For the meaning of the clocks, you need to look at the vendors binding
document. Vendors tend to call the clocks whatever they want, rather
than have one consistent naming between vendors. The IP might be
licensed, but each vendor integrates it differently, inventing their
own clock names. It might of helped if Synopsis had requested in there
databook what each clock was called, so there was some consistency,
but this does not appear to of happened.

    Andrew


