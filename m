Return-Path: <netdev+bounces-141022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56589B9204
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127C71C228A9
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A724C16F85E;
	Fri,  1 Nov 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uSoDTAZ/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330515B984;
	Fri,  1 Nov 2024 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467893; cv=none; b=GvsCuyGXIPWRPb2JT3eQm36ooM67XZpoKNmcsqOjVA9+Y9x53mxHQW0Y5/rwhyn3W0+rkpG/ZHWfSa3Chw4YRgziGRKU15CGZuckAdTpaIvHAIVeQrSCwF/COoa3esBh9CMt9cjlrkUhLke7+p5BrQKqsT0jxF34vigvxt6Z6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467893; c=relaxed/simple;
	bh=3mbCmom/nu07QVlvK58TsMBcfzxoy+ECXoSajwniio4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZOYdcz2RjaRGY8DJC4DKgA4vdFju6ot08iFjoOsL4AWEJNYboFtR1OgD2S/qacCCR6GAzcNgq0k/NSTKE55piTjMj0SXXPL6Od+RCEloddS+8S77+a8lqH/a/BALhCJzp5anwZxnYUubl8GxjGyrA1sBNr7KauiV7PIW6qATYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uSoDTAZ/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ql376oc4wnaREcGn5krPx7lcPHscqZvo3JrbE7OYvGc=; b=uSoDTAZ/cIqasDwVtIG+CgRyvi
	viyfU4jVibbVCiECNT+PYWBrfx6BtAIbKed4/gdLYcACo2wsegoX2Q7yizHq+37NvkZUQZBQKbL5d
	LducaW7+attn4I75C/XMCl0SEubk0RtCMp/Y2ugT4hceF0VngTf7QqY3zRPuOJdBxCdI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6rk3-00Bso8-HF; Fri, 01 Nov 2024 14:31:07 +0100
Date: Fri, 1 Nov 2024 14:31:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com
Subject: Re: code From d0f446931dfee7afa9f6ce5b1ac032e4dfa98460 Mon Sep 17
 00:00:00 2001
Message-ID: <38e4fc09-7c88-448b-b9e8-f9a082f1dcf0@lunn.ch>
References: <20241101082336.1552084-1-leyfoon.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101082336.1552084-1-leyfoon.tan@starfivetech.com>

On Fri, Nov 01, 2024 at 04:23:33PM +0800, Ley Foon Tan wrote:
> This patch series fixes the bugs in the dwmac4 drivers:
> 
> Patch #1: Fix incorrect _SHIFT and _MASK for MTL_OP_MODE_RTC_* macros.
> Patch #2: Fix bit mask off operation for MTL_OP_MODE_*_MASK.
> Patch #3: Fix Receive Watchdog Timeout (RWT) interrupt handling.
> 
> Changes since v1:
> - Updated CC list from get_maintainers.pl.
> - Removed Fixes tag.

It looks to me that the first two patches really are fixes? The last
patch is just a statistics counter, so probably not a fix?

If this is correct, please spit these into two series. The first two
should target net, and have Fixes: tags. The last patch should target
net-next, and does not need a Fixes: tag.

> - Add more description in cover letter.

The Subject: like of the cover letter could be better.

	Andrew

