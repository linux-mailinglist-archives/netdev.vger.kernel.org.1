Return-Path: <netdev+bounces-161196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244AAA1DDB0
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D423A4898
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227C191F83;
	Mon, 27 Jan 2025 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkaE2m9I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0673918E351;
	Mon, 27 Jan 2025 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011825; cv=none; b=b8kNiw7sLQDxXU0FJBXDTT/uOtt1ivQsD688hG5iZoW4t9S1flepyeOW92YC+aM+oPecB34lqAjCGKl9k5448i2vkEhNyywzkeIEPgNIDeL5wAoFsAoMXjEeXi8zmLO7llC/cm+Ohayhbtrrq+zWcRFQ0+HuG48GhF/GlrYXRME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011825; c=relaxed/simple;
	bh=WVG1MPhd1HOw3Gt5nUM041Hsql8yO2/kRnMQw0w2s+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjnZI/icT3zEZOKk/VTx1lrm6YszCOPocQr2vINnhYj8eNprnwTfYY/qDf0aQf9cz88EnnzMaQ/Lp9cbVEKwx+4Bnu+B1X0W48QD2BMT7292TG7AALg+VP6Trff8jHLckMSLjqKiAdc9N9hjgZVeDfnDk6JiUZmaD+KbtWAkZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkaE2m9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DFFC4CED2;
	Mon, 27 Jan 2025 21:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738011824;
	bh=WVG1MPhd1HOw3Gt5nUM041Hsql8yO2/kRnMQw0w2s+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pkaE2m9IYX3BiHqcBoFLWU4//r7Wjk8TGvMJ92/b51qrSj02gFTXn+H1tmtfaCvON
	 az4e9drcle1/kXlP4KKGiG5Da4zjh0KxAhxn1HPEMdDv78oVpa4Bb9HqeOj+bpQDBM
	 C7AiBzDupLGTGePtkfanyUrmCKEJKjvXPoeZkAvkqQ5h/rsoZ1VG/jmvGCioT4znJ1
	 bKrkqoumWFBJ7OB03jR3gR9o+xIl6yTR4okl/ToDpwfzfsKisKRiLYSPTfqaIiJyT3
	 QdLw1u0nzKqxNdLF15EMevuQTiIRRTOk55tN6lk9a7w4OXXoosUVEPFGtR7EOZRn58
	 LJywnw+L9rMaw==
Date: Mon, 27 Jan 2025 13:03:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] net: stmmac: Fix usage of maximum queue number
 macros
Message-ID: <20250127130342.4e5d1f9e@kernel.org>
In-Reply-To: <CAAhV-H73FNTzhjwkZwO4RAZFF1Ri6EzpJL3jnWW4rPRFZQRZZA@mail.gmail.com>
References: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
	<Z5dXJ1EIUx8DAh6J@shell.armlinux.org.uk>
	<CAAhV-H78fbK+jAsootOaZW=eQ3RPna3VQTxHd33vDSueYkyYtA@mail.gmail.com>
	<f1912a83-0840-4e82-9a60-9a59f1657694@lunn.ch>
	<CAAhV-H73FNTzhjwkZwO4RAZFF1Ri6EzpJL3jnWW4rPRFZQRZZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 21:47:29 +0800 Huacai Chen wrote:
> > There is another aspect to this. We are adding warnings saying that
> > the device tree blob is broken. That should encourage users to upgrade
> > their device tree blob. But most won't find any newer version. If this
> > goes into net-next, the roll out will be a lot slower, developers on
> > the leading edge will find the DT issue and submit a DT patch. By the
> > time this is in a distro kernel, maybe most of the DT issues will
> > already be fixed?  
> Goto net or goto net-next are both fine to me, I just think this
> series should be backported to stable branches. There are lots of
> patches backported even though they are less important than this
> series (maybe not in the network subsystem).

Please remove the Fixes tags when reposting.
-- 
pw-bot: defer

