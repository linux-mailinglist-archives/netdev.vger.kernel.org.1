Return-Path: <netdev+bounces-95649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DF28C2ED0
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDAB283A58
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2443B12E5B;
	Sat, 11 May 2024 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZahE2HB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D44320E;
	Sat, 11 May 2024 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393312; cv=none; b=te5/KW4l1QN+XMBgc1S+ACyqvEX7Ha7Nie3xDzgkqAtKam/2XJrFLMCEN4TH1DVgWh16b/tk4yFu/stQFyOQxxex33Yf9OjFfVhv4IJrp0DSGLD/M/WIgyReTeGRE52lPyHRDTMZ0AfAxOS7/U9qe72LhXsetm9sejulTx3yScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393312; c=relaxed/simple;
	bh=R0x8obuPsGeOf3eMhsjoyyJL1qvGIsDXmpUyjG7RnVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hq6g47KpMto+g/gAnWv5ALZzn7yze2zRP4yNbGMrf9APXz4Ayl1GUuQGeLEfF09zSJtfFMdKo/4ys45lJuoi89mZzxc4fb7Ki/mYeG2A4cXxlG07safzVKpPzMnyjE0hJOH62lfQndCZgq8dY8zFD/uMbYa/hO9FTgZC/4W3s+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZahE2HB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1878EC113CC;
	Sat, 11 May 2024 02:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715393311;
	bh=R0x8obuPsGeOf3eMhsjoyyJL1qvGIsDXmpUyjG7RnVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QZahE2HB08jYVtIYa6IMDmfjKfJr/4gdpVVmZdb9GFz9GMY9eTDSBuYnhvDbe2im6
	 vub9qzWuQ8p+S1Lxv94763m4u3jHIMJR1a8P9RT7jM8+i9a2xvSjlHSWo2HMX1gHXF
	 H2usIafdSgTez/GtWlXmIjxx+M1j4PuuenFch3dDjTViqDrp1NB6KRrcxLTXyrWwq9
	 MTuJTxWLImGJes5EgvUrc4gB0jCMKY0Lp9FWAEoz7fWPpGWZ9m7W4PB0qe3VdvvkTV
	 /ODP+kih6zlSMUPzEJ5MxTsUFmNNvs8zWa5DxSgvhwd4WtcIHjesn4TJOvfUs1I2u2
	 GZ3Z690511Feg==
Date: Fri, 10 May 2024 19:08:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <20240510190830.54671849@kernel.org>
In-Reply-To: <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
	<20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 18:59:24 -0700 Jitendra Vegiraju wrote:
> v2: code cleanup to address patchwork reports.

Please read:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

