Return-Path: <netdev+bounces-215325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0A6B2E199
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9775E74CF
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907732275C;
	Wed, 20 Aug 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH8yFEBb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3031B110;
	Wed, 20 Aug 2025 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705288; cv=none; b=mQk+Ru6jmt4mclL7oRjzqf1DYUrgiEZCEpDIFK0a1pAlAsa1k+edMJvYxJmAH8jWFHhqiyCfC6CHpiOSE2LZoAGpKbbBxn+6jjEK585NHvTK0D6/xKLDqR0d1RcNdpBjQ/iCQaOEyPkaJGfWcbFn440yp3OqV/omqhIlPOmOaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705288; c=relaxed/simple;
	bh=rXsvCo54vmzimq+tMCxR9+qLXEc3s/ulFZc1gIen3Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3rFiwaFeaOoEwmIIZFfUm8wy8KuCqerSNX9wMurv1TMEsjvLKDd0YasIdWxcMaQsQ5uAyNad/j6bi7HdRj3S6GJzemsBFMkUssTMsTSnFur1a9GnoBqK2zSn3RPnpcJZ59Hb8PwP+ARXol//D/1tsAw+B1h07dNNwK/R1LLKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH8yFEBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121EAC116B1;
	Wed, 20 Aug 2025 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755705287;
	bh=rXsvCo54vmzimq+tMCxR9+qLXEc3s/ulFZc1gIen3Mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sH8yFEBbP3jESsYJR2shssaXL3L7FXtsORvJgYtBft2gbooUWw3+0TObMw4bSfjuW
	 DUsNrXXxfTEyvqtEv9Zli4Oex9ZeNbbfXmclMsgJFrbO4C7c5SxOWP6ef1W8idmFAB
	 6RK7Cc0KzS6bQEm6M+Qhrv5OOEITnZAVIjL5CJEb2N2RSphl/OhDT/1bqrAqhIlL6F
	 aHQHV3ClIhNAg/0nZtW1vS4b0PhFlDdbjPD3VHeZw4Avr1yZcsAFErFxZ2Fu9U8Wsq
	 6EOJBz8pDevyDZRh1HJzC6rzlHd/YUi7H4eqDigJ9RtQ7OSWqqrvaesYsJ2R1NvanI
	 N1/ZlK1b8nErw==
Date: Wed, 20 Aug 2025 08:54:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>, Jose Abreu
 <Jose.Abreu@synopsys.com>, Ong Boon Leong <boon.leong.ong@intel.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Set CIC bit only for TX
 queues with COE
Message-ID: <20250820085446.61c50069@kernel.org>
In-Reply-To: <22947f6b-03f3-4ee5-974b-aa4912ea37a3@altera.com>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
	<20250816-xgmac-minor-fixes-v2-3-699552cf8a7f@altera.com>
	<20250819182207.5d7b2faa@kernel.org>
	<22947f6b-03f3-4ee5-974b-aa4912ea37a3@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 12:44:18 +0530 G Thomas, Rohan wrote:
> On 8/20/2025 6:52 AM, Jakub Kicinski wrote:
> > On Sat, 16 Aug 2025 00:55:25 +0800 Rohan G Thomas via B4 Relay wrote:  
> >> +	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;  
> > 
> > Hopefully the slight pointer chasing here doesn't impact performance?
> > XDP itself doesn't support checksum so perhaps we could always pass
> > false?  
> 
> I'm not certain whether some XDP applications might be benefiting from
> checksum offloading currently

Checksum offload is not supported in real XDP, AFAIK, and in AF_XDP 
the driver must implement a checksum callback which stmmac does not do.
IOW it's not possible to use Tx checksum offload in stmmac today from
XDP.

