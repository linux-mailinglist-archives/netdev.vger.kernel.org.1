Return-Path: <netdev+bounces-230643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F1BEC37D
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 03:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D5424EB86E
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 01:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321FE1A00CE;
	Sat, 18 Oct 2025 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuH8G0SF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02C14B08A;
	Sat, 18 Oct 2025 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760750644; cv=none; b=b9u7nb6LEKgEIbJIP3JUeY07rhe/XcVBFvEGswMjQONLUD/I0jnLddbydEY/p+e7E/gUEFEK7BA/ODHs2t1it5kYr2tnvf4XegHnYl0viNj49/Gwwxw27z9oPxo2xTgVbb7pEKNw2Ux4sEkUEqp8rGFGd2e2SDqR5DgJnZ6Smbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760750644; c=relaxed/simple;
	bh=VZ+0PK7Xowje368lQGozH1qMIaGZqErCNscmB4ue3mY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9goqx6sm2wsTFvJXkfjqe9qfFlSk/Y3KZT0coM1/pcTUREbbRC8o0VSR2SgeH2BJ89dDOBjIsBAHw+jmZ7x9Ij0LGFSBQqAgmClsrOxl24G5ZgMxIQNpnRhI9QXWNHbxi8aJqka88+CBob86hs3rdcmAGyXo5XHysK0e3GMFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuH8G0SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EB2C4CEFE;
	Sat, 18 Oct 2025 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760750640;
	bh=VZ+0PK7Xowje368lQGozH1qMIaGZqErCNscmB4ue3mY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SuH8G0SFf8tnTa5DujFZD38xFGUFaxQuFoKV51uK4JH1z7LFyPmflJHVuSnJ8FrWC
	 AO3b/oG0nZu8YZG2uxVcRtARPIAN0jBNn7tZOoeymv06i36LKIxB3Lfpcfoss8KqxN
	 erm/41d9xXprtVZePAzU9m8ygIk8Xi/qlI3JJqYBa4Xg0JTip9jUrADT/srN4SlXZ9
	 qMv4A+Py4QrSFDUBy436rj9bXzEpBOfm87/3JqL9mg0vhOhXePQuc0QXAADLQMSZQH
	 HHg5++uP8wvG24Ume/bZ3TaZyHvVVc0lIGSNyVLq656h5A28f+S46Y9g1Mdy/SYcrH
	 Kbztuc1thO0qg==
Date: Fri, 17 Oct 2025 18:23:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: stmmac: Allow supporting coarse
 adjustment mode
Message-ID: <20251017182358.42f76387@kernel.org>
In-Reply-To: <20251015102725.1297985-3-maxime.chevallier@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
	<20251015102725.1297985-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 12:27:22 +0200 Maxime Chevallier wrote:
> The DWMAC1000 supports 2 timestamping configurations to configure how
> frequency adjustments are made to the ptp_clock, as well as the reported
> timestamp values.
> 
> There was a previous attempt at upstreaming support for configuring this
> mode by Olivier Dautricourt and Julien Beraud a few years back [1]
> 
> In a nutshell, the timestamping can be either set in fine mode or in
> coarse mode.
> 
> In fine mode, which is the default, we use the overflow of an accumulator to
> trigger frequency adjustments, but by doing so we lose precision on the
> timetamps that are produced by the timestamping unit. The main drawback
> is that the sub-second increment value, used to generate timestamps, can't be
> set to lower than (2 / ptp_clock_freq).
> 
> The "fine" qualification comes from the frequent frequency adjustments we are
> able to do, which is perfect for a PTP follower usecase.
> 
> In Coarse mode, we don't do frequency adjustments based on an
> accumulator overflow. We can therefore have very fine subsecond
> increment values, allowing for better timestamping precision. However
> this mode works best when the ptp clock frequency is adjusted based on
> an external signal, such as a PPS input produced by a GPS clock. This
> mode is therefore perfect for a Grand-master usecase.
> 
> We therefore attempt to map these 2 modes with the newly introduced
> hwtimestamp qualifiers (precise and approx).
> 
> Precise mode is mapped to stmmac fine mode, and is the expected default,
> suitable for all cases and perfect for follower mode
> 
> Approx mode is mapped to coarse mode, suitable for Grand-master.

I failed to understand what this device does and what the problem is :(

What is your ptp_clock_freq? Isn't it around 50MHz typically? 
So 2 / ptp_freq is 40nsec (?), not too bad?

My recollection of the idea behind that timestamping providers
was that you can configure different filters for different providers.
IOW that you'd be able to say:
 - [precise] Rx stamp PTP packets 
 -  [approx] Rx stamp all packets
not that you'd configure precision of one piece of HW..

If the HW really needs it, just lob a devlink param at it?

