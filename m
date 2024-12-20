Return-Path: <netdev+bounces-153722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386B99F960A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 17:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93ECB163213
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 16:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2839F21638A;
	Fri, 20 Dec 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dqgar4bG"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77C39FF3;
	Fri, 20 Dec 2024 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734710999; cv=none; b=L3LTNxbLwYe7HbRIO9ofNWQHcbVDblvgLJ7RTqjJTp/D3+EcAeAXxjNtywyi24cir0vlI9cVuh9NPJv/yP6SrNgSA+Oj2bU9rhn/3qt+VGiLHoocMJqqv/YtBinTFNbh2UwRLniaMyqt2EL5NUH5XADfYY9q9vrA9+a1w3orark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734710999; c=relaxed/simple;
	bh=fSXg3M/0mE8dVreQMS+uKgIjGxP4AW3NuyFyKIkJBq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1FZzPLBqWskIi5M7AZ7okUHu6AOk3tnkMfuY8GetkrM5gMQAoE6Or63OzMeBOnd8AyDGWsK41wzlDZSc9EQ3PFw5xW3mODXrZfw8DLBwOysRZGx/JH68fb5YA9n2CKTesrGL/MYWszU7cXOJJZ9NS7cTl//PoMJZCh346FCk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dqgar4bG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734710994;
	bh=fSXg3M/0mE8dVreQMS+uKgIjGxP4AW3NuyFyKIkJBq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dqgar4bGC/BLTv2QAKUIkd2BygKD5e+I0N6V1xCCiHT4NcuJf81I2UBZKgl/I2g0I
	 xe9LrGIyhi7C1/heLBUBDO9Skf77DK2pj7i7SxlKOg/5f9AzGqx52JiQelpf/+sZZ0
	 u+Ty20bmSfwigAHVjK7LVjv7NACp3IIM0822nozSR64AdZiFSUZm1aDySRvxihfbnZ
	 5HvHwXOW8O7OYTTygAdQi5vEaXe6sZwaQKCGAkgRPGo8DxDVWt+YsSiZRyabLxHEml
	 5CCY8Q9OkSZe6yVrutIwuFPJwcNeQez0WcFSAZePgyev6fQJttjdxW1p/RjjvfFnW/
	 C85XNIPcbjE1g==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CE71617E37AB;
	Fri, 20 Dec 2024 17:09:48 +0100 (CET)
Date: Fri, 20 Dec 2024 13:09:45 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado_=3Cnfraprado=40collabora=2Ecom?=@codeaurora.org,
	=?utf-8?q?=3E?=@codeaurora.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	biao.huang@mediatek.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	bartosz.golaszewski@linaro.org, ahalaney@redhat.com,
	horms@kernel.org, kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 0/2] net: stmmac: dwmac-mediatek: Fix inverted logic
 for mediatek,mac-wol
Message-ID: <876cf020-e2ba-46a7-b9b2-82dcd47f7a04@notapiano>
References: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com>
 <173155682775.1476954.16636894744432122406.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173155682775.1476954.16636894744432122406.git-patchwork-notify@kernel.org>

On Thu, Nov 14, 2024 at 04:00:27AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Sat, 09 Nov 2024 10:16:31 -0500 you wrote:
> > This series fixes the inverted handling of the mediatek,mac-wol DT
> > property. This was done with backwards compatibility in v1, but based on
> > the feedback received, all boards should be using MAC WOL, so many of
> > them were incorrectly described and didn't have working WOL tested
> > anyway. So for v2, the approach is simpler: just fix the driver handling
> > and update the DTs to enable MAC WOL everywhere.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [v2,1/2] net: stmmac: dwmac-mediatek: Fix inverted handling of mediatek,mac-wol
>     https://git.kernel.org/netdev/net/c/a03b18a71c12
>   - [v2,2/2] arm64: dts: mediatek: Set mediatek,mac-wol on DWMAC node for all boards
>     (no matching commit)

Hi Jakub,

This message implies patch 2 was also applied, but I only see patch 1, not patch
2 there:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/log/?qt=grep&q=mac-wol

So I just wanted to confirm whether it was applied or not. It would be fine for
patch 2 to be merged through the mediatek tree as is usual if you haven't
already taken it.

(Also, FYI, I was not CC'ed in this message from the patchwork bot)

Thanks,
Nícolas

