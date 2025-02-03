Return-Path: <netdev+bounces-162292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B72A26685
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 23:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126F63A14E9
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C51D20A5C7;
	Mon,  3 Feb 2025 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odAS0O7+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C901FF7CA;
	Mon,  3 Feb 2025 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621424; cv=none; b=Y7Zmb7DR9luU9dRKBj4aAZWdTQp1ih7CqGsPvJMm/lzveFavaun27Tx6Og0RJbcIYE+DJdSjzqnNPdSQ8GvyOo11Z+LbmMY42DI0nj4GgMQqO1LR1NUCMkjU+ghA7AuSwcBaBkiFzM0PF1IZzHcZOs2s5zmQhLY5WP2bZxnIQv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621424; c=relaxed/simple;
	bh=QDO9GVeXAOaaRZkSWSLtvHPPP50q6hnF5jk/+ZuAFCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtHcXGy/AUPOKX93kJQlB7POW5ryy6qxCCTDCdxeOLOkaEOdlU6Tzn05rZMxJE9adn9yQNyOcmaoogI3Cz89aLlg7tOjBEtGO1QXoYAckI7caDODisM/UIow+q+ImGHJwV4EE0J0FzqY/5eFcLx0zQWopjbfYYwYmvXUDkqtv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odAS0O7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C93C4CED2;
	Mon,  3 Feb 2025 22:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738621423;
	bh=QDO9GVeXAOaaRZkSWSLtvHPPP50q6hnF5jk/+ZuAFCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=odAS0O7+0BpU5Lz+GlKYMGQ6c4ARoLckDjtLnhs8REL6A5uZgF1zTxV5NDNXJD8om
	 M8fSprvOVg3y5Fr9qU/2ggqb/XMEPTVVcO5GS/cP5vbjoJ/FaBi1czc80yrdigPSaU
	 sht0CkU3zWTLkYPlFF8eRXXnEGVC9YAFsqj3S+jtwd8OdbiQUJXAmK4YZ8og5R2SnJ
	 ZrJ9dSpKHeNgb/Q59p2FDVNYhY3x9S6FOslm2m88S4Ob4Ah44GDMJFp/ZzloWLRqhc
	 Fi1sDvBpk28JWpKvKy3s42spNVNCkwNjQJPf4TP1C2VfsZhqjXveKY1PLInfYyOKei
	 f5XmO3mH2VpOg==
Date: Mon, 3 Feb 2025 14:23:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Steven Price <steven.price@arm.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Jose Abreu <joabreu@synopsys.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 netdev@vger.kernel.org, Furong Xu <0x1207@gmail.com>, Petr Tesarik
 <petr@tesarici.cz>, Serge Semin <fancer.lancer@gmail.com>, Yanteng Si
 <si.yanteng@linux.dev>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH] net: stmmac: Allow zero for [tr]x_fifo_size
Message-ID: <20250203142342.145af901@kernel.org>
In-Reply-To: <Z6Clkh44QgdNJu_O@shell.armlinux.org.uk>
References: <20250203093419.25804-1-steven.price@arm.com>
	<Z6CckJtOo-vMrGWy@shell.armlinux.org.uk>
	<811ea27c-c1c3-454a-b3d9-fa4cd6d57e44@arm.com>
	<Z6Clkh44QgdNJu_O@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 11:16:34 +0000 Russell King (Oracle) wrote:
> > I've no opinion whether the original series "had value" - I'm just 
> > trying to fix the breakage that entailed. My first attempt at a patch 
> > was indeed a (partial) revert, but Andrew was keen to find a better 
> > solution[1].  
> 
> There are two ways to fix the breakage - either revert the original
> patches (which if they have little value now would be the sensible
> approach IMHO)

+1, I also vote revert FWIW

