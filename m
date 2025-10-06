Return-Path: <netdev+bounces-227995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E054BBEDBF
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 19:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7000F189AD13
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2162D8789;
	Mon,  6 Oct 2025 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVBibZdm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B172D6E4B
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773308; cv=none; b=TjtQNxWKKHSiVshSVnUdsqjAGF9eDulobtTWgZz6/246oQXk56nB40TV/GaLEfh1HgZREcZMdHQu16le82nY2xv1NDQwhwZV+RfDs1dtHVYkMroEiYRFXva151EMAylylKkhYxPl6j8U/ZuvttPPxMlSy0PUL37w/Jtm7RVL0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773308; c=relaxed/simple;
	bh=JuGaA7BF6zBP+b+TjShk1ikztH8dCKjQPcPmVvj/tW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcD6lV7R2J46ozZQDYWOedN+gF8Sb96VcwQyTaL3OtpHAXe5bF897I7ZnnOf9bBonJ/OCO55INnmbayrp1vYrH4bxBJoOV5XfkJ0M4vDmpItQlGGoQEJXqShTrkHOJLOIJPaZcy3OZqbqCxySM3t+Cbv/hAo46HFAcdm4op9yV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVBibZdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1511C4CEF5;
	Mon,  6 Oct 2025 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759773304;
	bh=JuGaA7BF6zBP+b+TjShk1ikztH8dCKjQPcPmVvj/tW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YVBibZdmiR+8epRFT6MyHPAzZS2yxp3i60eVkacSZeXNzQTUwVAZ74rE88jyWUrIB
	 l+/H+csO0OVDKaATTy7IC+iwT96TUzjk8r9rZt5mQuGlXQ5vKDNcv3qgpJkdwnb6fK
	 ldiyWaE7LGL/3hCSytsy+IIOO1mgAnH8086VdgBvSgPKFlcCJnvavveBbpYCwxBSTC
	 embhOZ68S6NRupgwEdR+IJyfiNtas3Z6GebcmGhdoF3mo3joF47P6K6EVr3GkAj2Rw
	 84u/QGhtYMi6WeCss1t/AeKHn+nW4ClcyEZIi+BPPUo2SSyQYwe5oTk5/hMWD/dwh5
	 ZKQX1v4BsAcHA==
Date: Mon, 6 Oct 2025 10:55:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, mkubecek@suse.cz,
 netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <20251006105503.6ca81618@kernel.org>
In-Reply-To: <20251006144512.003d4d13@kmaincent-XPS-13-7390>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
	<20251006144512.003d4d13@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Oct 2025 14:45:12 +0200 Kory Maincent wrote:
> > The kernel supports configuring HW time stamping modes via netlink
> > messages, but previous implementation added support for HW time stamping
> > source configuration. Add support to configure TX/RX time stamping.  
> 
> For the information, I didn't add this support because it kind of conflict with
> ptp4l which is already configuring this. So if you set it with ethtool, running
> ptp4l will change it. I am not really a PTP user so maybe I missed cases where
> we need these hwtstamp config change without using ptp4l.

FWIW I sometimes enable Rx timestamping (from whatever chrony uses
to ALL) to measure burstiness of incoming traffic when debugging
application packet loss. Would be quite useful to have the ability
to configure this in ethtool.

