Return-Path: <netdev+bounces-240930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B637FC7C279
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6B814E0735
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5568928A701;
	Sat, 22 Nov 2025 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhJXd9u9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279C023183B;
	Sat, 22 Nov 2025 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763777319; cv=none; b=qggFNMG1WufZ+np1CrtXofsz0BOQ6r+/IAZb0PL7eLK3UTZDG9Ov7TMTLoLJnx5QoSqU3kbMLLWjQp9HPpysASSkQw/l3O9ndY5eoXTCw3nNCxhyButL+1XhMM8/GHw3ahEABhx0HSahhxel+oH3SFDqwk4cPLp6s0oWFgZIrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763777319; c=relaxed/simple;
	bh=sofUNfpoDuo4wGyIvYezOZfDNv51rPi+5plOl3rav3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vC8eWMTai2MakEJg9NBHY/uE8CCvuzuHZg4g6kadQMJg0iyzKJVBiDvfpPVbj2GIxTAyU4LHCLUQl7XH58Ka14F9iwaDGq/bw4syedT5mYPop8ke78Y8dEDU44WnMi2ixM43Gf/4WlcXQEnfj/30YcK9v6WNZb6WcmX8KVUZ4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhJXd9u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DF2C4CEF1;
	Sat, 22 Nov 2025 02:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763777318;
	bh=sofUNfpoDuo4wGyIvYezOZfDNv51rPi+5plOl3rav3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WhJXd9u96G0uvPu9oo78YkEo/IFhFgsm6gTUc+2F3k7OV141A40AOdk6sTQhdGUZM
	 CvsWRUpkiS2dIFDQBwvprzDQKXpcQljR9iajVPqq0cwwKoZn+sIbLD3Mv/epVC2OjE
	 lSahswQ2NxE0zZR0ikDvcbjfQn6XU7tYW855MBP6NaFQaDJCLG6OWVNpuZAXOIO5zw
	 Wk02KIV3ef8/7TAX8/pj8Jci8EDRTmf3qP6oNbqQINMtGwBkqqOQXP6UJIJpBuhEd+
	 M76hHlBdpVD/CIXFs5aa+AeS6+VBeTD2EQ4YeoLeRp07ebcTROaZWGuwRZa7NVHulk
	 i4wK6H4zKZg1g==
Date: Fri, 21 Nov 2025 18:08:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mani@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn
 T99W640
Message-ID: <20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20251120114115.344284-1-slark_xiao@163.com>
References: <20251120114115.344284-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 19:41:15 +0800 Slark Xiao wrote:
> Correct it since M.2 device T99W640 has updated from T99W515.
> We need to align it with MHI side otherwise this modem can't
> get the network.
> 
> Fixes: ae5a34264354 ("bus: mhi: host: pci_generic: Fix the modem name of Foxconn T99W640")
> Fixes: 65bc58c3dcad ("net: wwan: mhi: make default data link id configurable")
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Doesn't apply to either networking tree :(
-- 
pw-bot: cr

