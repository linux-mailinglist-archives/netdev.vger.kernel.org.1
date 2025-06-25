Return-Path: <netdev+bounces-201047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FA5AE7E94
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8335016CA75
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EEB29B227;
	Wed, 25 Jun 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Suj92ufi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811E1EA7EC;
	Wed, 25 Jun 2025 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846059; cv=none; b=UPxo8WwnVBvl3BvP/ykil+lIoIoG0T65AU1kV1s/OJ+/pcGiXFTGTNySWzTScAlFFS052vzBhYfg/rGmdTAB610f+BSIfEOAem3iW/+THsq4iUGX4OFktaGpx3ddAztm7VihYV48cDNvVUKIq2sRA0VeAEAvdqq8P1aEIUSOBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846059; c=relaxed/simple;
	bh=GYh4JUENQPPyO2vSMusCqzdAX4LYjDMB6n46bpNIWhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWyzVE1ledqHNf6fuFZD/2PH8X6SSu4Q4E30MheRR2/qWRMtmKd12U6Oug6R0mB0J27xSmF208tUxE9FkOrF3gpcsT7xjsllzuNWoi3YFOCM1tfXfiD/TVwTT21zQ6QlnlBIHpKtab+9Z07olvM3O/AhsdK/w4txlINrcXAKwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Suj92ufi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4832C4CEF1;
	Wed, 25 Jun 2025 10:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750846056;
	bh=GYh4JUENQPPyO2vSMusCqzdAX4LYjDMB6n46bpNIWhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Suj92ufiU/D9UCQdCTElYKZ8Rgk+SWXTiae3jAQ1TBG52KPhYUdH1qtls3nCOBFdb
	 ncxozIhEtaXTH5I4Jg1uQZvTJ2+KO5BF7TAzEi7N7yL/J0Pcj2RJvVz5b/FkYU9PNa
	 ovRgsz2uOhk2JUFS6OGghL23NEJRTo6sBa3NOem9tF1FC1DJKJ+W7uf8N9JFIN/wJ9
	 dNRPZtrGvlrIsqqg8fKIZE3xBPTBdycNdtHy489uF0J4NeTvSlx6sTxCthPL+5Pqlx
	 C11GDeAMc75qAFSwIa2akG7WpEC6SOZZ6FCfkUJm1P0imNhp0MKk/3pQ8Qwhbct0TS
	 8WnNQAtoUIUXg==
Date: Wed, 25 Jun 2025 11:07:31 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/7] net: splice: Drop unused @pipe
Message-ID: <20250625100731.GT1562@horms.kernel.org>
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
 <20250624-splice-drop-unused-v1-1-cf641a676d04@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-splice-drop-unused-v1-1-cf641a676d04@rbox.co>

On Tue, Jun 24, 2025 at 11:53:48AM +0200, Michal Luczaj wrote:
> Since commit 41c73a0d44c9 ("net: speedup skb_splice_bits()"),
> __splice_segment() and spd_fill_page() do not use the @pipe argument. Drop
> it.
> 
> While adapting the callers, move one line to enforce reverse xmas tree
> order.
> 
> No functional change intended.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Simon Horman <horms@kernel.org>


