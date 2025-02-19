Return-Path: <netdev+bounces-167752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02DEA3C12D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3913AC467
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43801EEA2A;
	Wed, 19 Feb 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t1ido8M+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12881E7C25;
	Wed, 19 Feb 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973392; cv=none; b=MTkkq3wZei9jTB0Bc6aKusmd5rWFlwn+Vq0FGhJIDucNlGqyrwwx3Yvc41udqsBfK4I+R6IDVl7IhnMzvqh6DIZFtvfjjtqkBCJd7gVoK+iPkZOgxgTDr8yEp6LuvEP/nfCpfVfywkGcJdbEU21SnA5EGPIYMfMtAmkhHXn2UZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973392; c=relaxed/simple;
	bh=ot8GgkLyzCkE9gV1gX3O8wm6e8Ok+KnDVvkcfBXptq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iygdjXQpg8bz6ZIE/nF/7ve5oM/n/lNSKvQLuVvvhT7s/3mEy83zMJMlwEClN0vDnpmvsd35SScQwQe7WL67gFTIsew8BR6ul9SYmIYF6s966PnAJmhI2RXAHJfSh/xHta2347+XQlP9NB2f8of1BtCTHVTM6xHPpXJWOb/RGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t1ido8M+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uc23WWc/UZMSXW1WlLBjBply3DEitxnwU2hL2lfpwFk=; b=t1ido8M+pdbcQX1NZUeudBofN0
	dmEXdi064iyem4MfY0K9sAKl1gPYMX3m/aM7MBDT8nOw+7B4dVz3vPGF1WlRds1F62oil0h1JLUsK
	NIGu9RRZC0NMXsLe5jUdJAXho88FtZ3MO1F4QG+Kz4txCSfDIq+6XGPIlxPwUHnDCJhg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkkYf-00Fe8g-Qc; Wed, 19 Feb 2025 14:56:13 +0100
Date: Wed, 19 Feb 2025 14:56:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: qt2025: Fix hardware revision check
 comment
Message-ID: <4bf73cd3-6504-4ead-9405-0e28b2666088@lunn.ch>
References: <20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net>

On Wed, Feb 19, 2025 at 12:41:55PM +0000, Charalampos Mitrodimas wrote:
> Correct the hardware revision check comment in the QT2025 driver. The
> revision value was documented as 0x3b instead of the correct 0xb3,
> which matches the actual comparison logic in the code.
> 
> Fixes: fd3eaad826da ("net: phy: add Applied Micro QT2025 PHY driver")
> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

