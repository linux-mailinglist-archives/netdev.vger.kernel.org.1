Return-Path: <netdev+bounces-161106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF31A1D682
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DE31644D6
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F421FF60A;
	Mon, 27 Jan 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zIxTF7Eq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10561FECD2;
	Mon, 27 Jan 2025 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984092; cv=none; b=DsMPB4dieIYc1Sxo1LvbqvbkuKgWbajOcQA0j4PTKgQ3AFnSkyHVeB6hVD9gYDpYjLrYKI+ZF2e6sLQwqqwxzwq1oJ3Tek+rr2EqQ0vWf7N7H7eLjEnWiBknbwxa3wAjgruhHI6LPs4k9iJBCtBC3AxZT0qRnydc74C889Hk2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984092; c=relaxed/simple;
	bh=ndZXOmMz6xzusGAEPOLYqWxnl5A6uNxrKU2fCQpxfXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB5RIOrcho+CgN+HgYQQuHcr1KKH5mJa+7eu4HzJ12rlkjaj+Kv4yDNkzmttBjPINPnWFiaXLGST+Ja345c3clnOMxTb4L9BLa9QEhpXCTd7E3CcJlToqQeXM1Qh2EPSn2bP4RzUKNUeIcYldOnbGHjmRhsxrJLTSsdNLhkNZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zIxTF7Eq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tFF5TUdVYQg+FyRVGEqx+EYIgUUw4Qjx7J3R/oaD48k=; b=zIxTF7EqDiEmlJyBGaLIoi6ORg
	eOnj91A+VQvp9/SwEsouCXvmGkrlNYeD/4eaixxGqUm8KtFTXi8cssq/ufhSOtirMSGabPAc0uwDD
	a4Mz6sEPCR5mVbabOTFGWhFljGTkIUkiqeriRV9n07rh1kPkE+wBWBV2BBSXDVNzObr0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tcP32-008Ydy-1N; Mon, 27 Jan 2025 14:21:04 +0100
Date: Mon, 27 Jan 2025 14:21:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] net: stmmac: Fix usage of maximum queue number
 macros
Message-ID: <f1912a83-0840-4e82-9a60-9a59f1657694@lunn.ch>
References: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
 <Z5dXJ1EIUx8DAh6J@shell.armlinux.org.uk>
 <CAAhV-H78fbK+jAsootOaZW=eQ3RPna3VQTxHd33vDSueYkyYtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H78fbK+jAsootOaZW=eQ3RPna3VQTxHd33vDSueYkyYtA@mail.gmail.com>

> I'm not very familiar with the difference between net and net-next,
> but I think this series should be backported to stable branches.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html


  It must either fix a real bug that bothers people or just add a
  device ID.

Does this really bother people? Have we seen bug reports?

There is another aspect to this. We are adding warnings saying that
the device tree blob is broken. That should encourage users to upgrade
their device tree blob. But most won't find any newer version. If this
goes into net-next, the roll out will be a lot slower, developers on
the leading edge will find the DT issue and submit a DT patch. By the
time this is in a distro kernel, maybe most of the DT issues will
already be fixed?

	Andrew

