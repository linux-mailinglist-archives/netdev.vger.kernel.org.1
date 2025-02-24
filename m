Return-Path: <netdev+bounces-169202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF15AA42F14
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A22B3AF630
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB11917D0;
	Mon, 24 Feb 2025 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi8MSJVF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C42571B2
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432580; cv=none; b=VI7b+AQolZkzJ5J+JpfS4iivwrGCg2nheF07/lWK3dCv9DicL3DxBExZJa7iFpkbgLnyY0tIU/pBHW8tzT36+nvQ1TEyyqceZcIFhr5jce6s1dj6vLlnQRqTTjEBEFJV5ot/OZlMbMnD0Q3meogf9sXf6mktsJfgjRhSB8D5QOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432580; c=relaxed/simple;
	bh=2wIuo2JpNrpSXzbijZXMds2t2FH5opDQp0MBirv33i0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqEx4S3ZzbGgLhgrai2woYYbvic1fiCCrk2pAFIiGwPC8EvLou3sE2UjN+hztSpHTygzjscJXeTYZVkOnxcxkHreXmFcOhqJMhs3cplgLFpilx2ULZa3AR73/9ODDYgU0Hu0DfaYn7lNlaPOMjZRizE0eZXAdMUJIPaYKgCxEjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi8MSJVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB4CC4CED6;
	Mon, 24 Feb 2025 21:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740432579;
	bh=2wIuo2JpNrpSXzbijZXMds2t2FH5opDQp0MBirv33i0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zi8MSJVFCqiwf9OUs5sWKRYW6666HCAE9LClfaJJdld4CT/dvQKA+mFh2yqDuuYBh
	 T+ucoLngVzPbDBvHyZ5jfD9Ggsqclh1bmtQc+l9ErARAKBGVnboakH0OrS9fPEZ4l0
	 8AyA1C0Zpy48ekBhKpai+u1Byg0pgOq3QvgeVDrgjuf8uQRvg0gorn02FYrtDEAV5R
	 OaLvg3LI+yxKXvmuIFCs67v+udlk1dVD32+Sv3v6OY2Qr/NRNFLFngTo3ChIDJ5txa
	 mNxBw3qqV55ohBwvQCa9yjuCXY8UEdbWpXalhDGoMxEFF3XaKBqiujWbxBDrRjd/sw
	 Lfca3buOi7lPw==
Date: Mon, 24 Feb 2025 13:29:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwc-qos: clean up clock
 initialisation
Message-ID: <20250224132938.4b352786@kernel.org>
In-Reply-To: <Z7yjLjfNq89vPnOd@shell.armlinux.org.uk>
References: <Z7yGdNuX2mYph8X8@shell.armlinux.org.uk>
	<E1tmZjr-004uJP-82@rmk-PC.armlinux.org.uk>
	<Z7yjLjfNq89vPnOd@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 16:49:50 +0000 Russell King (Oracle) wrote:
> On Mon, Feb 24, 2025 at 02:47:19PM +0000, Russell King (Oracle) wrote:
> > Clean up the clock initialisation by providing a helper to find a
> > named clock in the bulk clocks, and provide the name of the stmmac
> > clock in match data so we can locate the stmmac clock in generic
> > code.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>  
> 
> Yet more warnings and errors from NIPA, yet this patch passes my local
> build tests.
> 
> As no one looked at v1, I don't see the point of waiting 24h before
> posting v3... no one is probably looking at v2.

NIPA builds with W=1 C=1, FWIW, looks like a sparse warning.

