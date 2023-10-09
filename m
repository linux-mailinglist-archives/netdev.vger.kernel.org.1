Return-Path: <netdev+bounces-39282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23B07BEA8D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD1C1C20852
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE4B3C681;
	Mon,  9 Oct 2023 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zH4xbDsi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA2BA4B
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 19:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32B5C433C8;
	Mon,  9 Oct 2023 19:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696879643;
	bh=bMuuJuCXLdqxidHDsH8QCILci9B9gM7g0lwjeG1YW4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zH4xbDsiAQHqh6hl8mrAxYcwj8mNztG5SYCp7m1W3xhND77GB3rwmbtQwUEp7F3Uw
	 UXe/oyvEukMz43DGszMtGlflcZmRQhICRgJmWArRZ+8XMfEb+Vrx2HHsLCjAQ+S73w
	 9gcdagDN42f8J6TBq09O0xKebvtnByN6FBpnEVDI=
Date: Mon, 9 Oct 2023 21:27:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Doug Brown <doug@schmorgal.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] appletalk: remove ipddp driver
Message-ID: <2023100910-hydrogen-unless-9916@gregkh>
References: <20231009141139.1766345-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141139.1766345-1-arnd@kernel.org>

On Mon, Oct 09, 2023 at 04:10:28PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After the cops driver is removed, ipddp is now the only
> CONFIG_DEV_APPLETALK but as far as I can tell, this also has no users
> and can be removed, making appletalk support purely based on ethertalk,
> using ethernet hardware.
> 
> Link: https://lore.kernel.org/netdev/e490dd0c-a65d-4acf-89c6-c06cb48ec880@app.fastmail.com/
> Link: https://lore.kernel.org/netdev/9cac4fbd-9557-b0b8-54fa-93f0290a6fb8@schmorgal.com/
> Cc: Doug Brown <doug@schmorgal.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

