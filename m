Return-Path: <netdev+bounces-228692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BCEBD2530
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94930189AAE4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D12FDC39;
	Mon, 13 Oct 2025 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dF2aK5md"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38ED2FDC41
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348224; cv=none; b=Gp/3cIeXisk7++Bi/cBFRUvIRsXLNboIaarfyJn35yWdMHwpvdOq3KBxIjUZ4N2Ikj+iPiUyWQYB2eWTwftUjIEfyab8j0q5jmcGwtx5fyGjowV8yNFkKdgoti0TZQ9qyFF6wGWhw+PNd8SS+6zNvuS/ZEsv/WVSu/6vF38JW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348224; c=relaxed/simple;
	bh=6LWJAszpBzDDNcwsP7mxSu6hCo8vBo3umaJU9IG9AP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0F5Xezk+aIoUQwd7TxtTuHog5teeWjEYlWmFRrvM1bsvtf66/ARgbuHtWHDljZNRjbrpwSbYJ2GWonYaOUq2GgSCmoK0rXmFEanpmd7NHn/4Ozqu0Abqznuu0C31Y/URLcURS+WlimZ7LVSmkreeFCfRf9nx7AEsOvVagJBJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dF2aK5md; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1D8C04E41064;
	Mon, 13 Oct 2025 09:36:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E04CD606C6;
	Mon, 13 Oct 2025 09:36:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 636D8102F2259;
	Mon, 13 Oct 2025 11:36:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760348213; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=GttWDttud3s8DcIDHj6W8PemmzlZdLiY0kQdEAtHOtU=;
	b=dF2aK5mdeEn7pAgB9mHN5tqumXkPEF/bibVs7yjA/xahD27fzrPbBgkVsf7REjxjkjTUrd
	VbItglTchQQ0L5v+yazSwvc5MO51yx7a96RbZvWJd9rVjHvQIh80SHv+NTYA/dbs4OaKbM
	CJiFZfuKM2movztZpQmCYIf2QAkQJyK3+0gOwaTRa2pKAKD7dCMvWIg9p1m+ysA0gnGMrg
	qwid3vV/GeFENuifz2eH2lT083FS1pDFCwSWuE5rpQgLTNUZiknxNXb69AqLuOEpfz7Gzl
	xQJFCK+FebdOYbsW3i/bUyBi5nOW6wu9iK7LTBXSADzUH617Ht04XkwFJq7MiA==
Message-ID: <3da0cdaf-d337-4c67-acdd-2f07e686e4f6@bootlin.com>
Date: Mon, 13 Oct 2025 11:36:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH] net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not
 present
To: Marek Vasut <marek.vasut@mailbox.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Daniel Golle <daniel@makrotopia.org>, Eric Dumazet <edumazet@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Markus Stockhausen <markus.stockhausen@gmx.de>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
References: <20251011110309.12664-1-marek.vasut@mailbox.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251011110309.12664-1-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Marek,

On 11/10/2025 13:02, Marek Vasut wrote:
> The driver is currently checking for PHYCR2 register presence in
> rtl8211f_config_init(), but it does so after accessing PHYCR2 to
> disable EEE. This was introduced in commit bfc17c165835 ("net:
> phy: realtek: disable PHY-mode EEE"). Move the PHYCR2 presence
> test before the EEE disablement and simplify the code.
> 
> Fixes: bfc17c165835 ("net: phy: realtek: disable PHY-mode EEE")
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime


