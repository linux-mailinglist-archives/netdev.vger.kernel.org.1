Return-Path: <netdev+bounces-136518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF7F9A1F98
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FA5283072
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B41D9A44;
	Thu, 17 Oct 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldn9oUeb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6081D934D;
	Thu, 17 Oct 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160342; cv=none; b=MqKaS6qAtk6Z4FAXhTkuM5VzSIwNRMaeVMDZEGs7/46NKa5X0pFYzN4FnwyJLa8smI0K0Rvuz0j/dI8cM2moaaCsFd/sISeSHgk7alf9mZoG5A4+elELxDu2UtRe+q3aXYXnP4ys0NOxSyOtVCcpLJWy+AuEcM5TTKYKBoewffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160342; c=relaxed/simple;
	bh=EwYIiVN0SdU+AkH/bqOTTx9jJa66IvHYmbDVoyJuE1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJbKyPZVGTb4FZnE+cdXK2h+WV1lI0QFzMqumVM3SknqHw0rA78hFgxmlY8fppxfkRr2YLE6jml7JoNnQq9d0oUv0uBLyul9iyXwjuhOta1pOAWI/BDw49sFlzcvnpJA0BOeVnkuRfaUbvk014XRDkqFZmSrMNe8u3vD1h4TDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldn9oUeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B19C4CEC5;
	Thu, 17 Oct 2024 10:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729160342;
	bh=EwYIiVN0SdU+AkH/bqOTTx9jJa66IvHYmbDVoyJuE1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldn9oUebm27rhdmUNrnOOid25bg5Cnqabl8JZE4coHOkSMDkAe0L/JXRjSxp8UR1L
	 cK2rQdpLhLvXQuXRvoPWb32T8XPVjrpIVkKJLsJoehDXa5qxTrfXrEbh0AAAZ4ktBY
	 iFM9sgzhMBOfM8ypLdkqQdRwIT6csH5c8/TBB7IDkcvKZrlYzsCabhf5XM+Cvi9K+9
	 ZjkIxqy66D7ecL44cSqTHccZaralLQVsdC6wiKhCSzMrQlylRPRwuS9qsULCGDBR0w
	 mzmK/IdZ/W5WNGYiGz3I6r17rhQGInyAww+I6Et5AkEcoSFD97NDtZ5edBhATBj4uL
	 vzL+hfqAm32Vg==
Date: Thu, 17 Oct 2024 11:18:57 +0100
From: Simon Horman <horms@kernel.org>
To: 2694439648@qq.com
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	hailong.fan@siengine.com
Subject: Re: [PATCH] net: stmmac: enable MAC after MTL configuring
Message-ID: <20241017101857.GE1697@kernel.org>
References: <tencent_6BF819F333D995B4D3932826194B9B671207@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6BF819F333D995B4D3932826194B9B671207@qq.com>

On Mon, Oct 14, 2024 at 01:44:03PM +0800, 2694439648@qq.com wrote:
> From: "hailong.fan" <hailong.fan@siengine.com>
> 
> DMA maybe block while ETH is opening,
> Adjust the enable sequence, put the MAC enable last
> 
> Signed-off-by: hailong.fan <hailong.fan@siengine.com>

Hi,

I think that some more explanation of this is required.
Including if a problem has been observed, and if so under what
conditions. Or, if not, some background information on why
this adjustment is correct.

I also think some explanation is required of the relationship
between the changes this patch makes to setup, and the
changes it makes to start and stop.

...

