Return-Path: <netdev+bounces-40390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1109F7C71C5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4272E1C20AE0
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492E2286BB;
	Thu, 12 Oct 2023 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urSiZTDh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D24C273D7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2CAC433C9;
	Thu, 12 Oct 2023 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697125468;
	bh=GICrSG2Yr7cyuandvlnQB4wtkQU/ONqfvxNpkn64C6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urSiZTDhcxBtHJPTvqtBC4cbLtC9OIQZFQf/8DnE7ETAiwuqDBbUXRQuEm41SaASc
	 QIW6lXY9WRyLn50Pu+zz9QzE+yC+dw5RwAzE4LdRW9RHA+84bytQo5AbqNAJyDSkzP
	 CoH1XRfilCg0doAuE8Yd4JdRbcCsQ6KRsIbJHkX/MKZPafuH6b8f7LPWmztVh3X9z5
	 9Cyy+vzf8G5cPYYhDnnTFtZW5uHUt4Yolt7eqNWMfq6bNdAE9ciEgZlRXCYiakemly
	 aPm3MhhdFqCQhK/TM4FNWQimBRHYFA5UoIuBnHCjbN9RkeL8lluk7L1aDOjP0oeLbx
	 KpcJdVuuX7PMA==
Date: Thu, 12 Oct 2023 17:44:22 +0200
From: Simon Horman <horms@kernel.org>
To: Johannes Zink <j.zink@pengutronix.de>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
	patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next] net: stmmac: fix typo in comment
Message-ID: <20231012154422.GE1178137@kernel.org>
References: <20231010172415.552748-1-j.zink@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010172415.552748-1-j.zink@pengutronix.de>

On Tue, Oct 10, 2023 at 07:24:15PM +0200, Johannes Zink wrote:
> This is just a trivial fix for a typo in a comment, no functional
> changes.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

Thanks,

I checked and codespell doesn't flag any other spelling errors in this file.

Reviewed-by: Simon Horman <horms@kernel.org>

