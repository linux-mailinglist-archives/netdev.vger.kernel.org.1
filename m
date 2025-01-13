Return-Path: <netdev+bounces-157747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBFDA0B89A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE988168725
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922F235C0E;
	Mon, 13 Jan 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3KcShy6C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897D1CAA8C;
	Mon, 13 Jan 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776096; cv=none; b=DiJriJRkIyoZcpmt5hJ3yUc7lZXfps2qMCjhMfNdrw127mbM2xyFKNOUPqdB9r81/aG0+eUNFA+a1i4e/s1MDqf/6mBeSqt3Z6NV+N9/Hl2YsJ4rz6hZ/+xY3ksonKS8ST3os92D21MX+WzYDLuyEBawSlMVAUykv4qeOhnEkT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776096; c=relaxed/simple;
	bh=rQEwxqCEB/1YuP2FXEJk8qVbPLS1Qzt0Zl022xTYdo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpXdsXPHWWJvJq1BtRJNveXgLJeOSgicphakGZyagl6JLV5W5HF2do/ZgCpwF3iTqTGm9qveCzFyxKhoh4RNQACl0lki3s8xj7mCFc71cE4rbvf6HBt5t6H/OZpXwy+w9JZwVWfImi1JMq+D/EGzw013gYmZ8CbVFy12VaEJXxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3KcShy6C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HV9E6yFunTBFSMsnaDZTf3fcrXGi8EXxXbUNvG/Y8m8=; b=3KcShy6CNi7Fmxo/FaPg+uj1nd
	yvocBzcTKpYhznG4xR5n7FmY2wJwjaAaKvqWYT9ogCVfpE6cznZ9AmKD8ejUtFEE/CTQP1Ggxs54D
	Q0ryC+8YKPcBtAiV2yT1nJhNPPjYuvA3hgFb8ZSs53+Re+4w5I2YjfjxLRJpBbyYnPqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXKnX-0046co-3b; Mon, 13 Jan 2025 14:48:07 +0100
Date: Mon, 13 Jan 2025 14:48:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: phy: dp83822: Fix typo "outout" -> "output"
Message-ID: <90779923-0ea6-4754-aa93-c3c191ec4980@lunn.ch>
References: <20250113091555.23594-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113091555.23594-1-colin.i.king@gmail.com>

On Mon, Jan 13, 2025 at 09:15:55AM +0000, Colin Ian King wrote:
> There is a typo in a phydev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

