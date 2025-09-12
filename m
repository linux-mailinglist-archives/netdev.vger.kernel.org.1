Return-Path: <netdev+bounces-222724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2094B557C5
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1763C1C2291E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D5A2D29AC;
	Fri, 12 Sep 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o5kgKe2a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB132BD036
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709851; cv=none; b=l3CvZoo1Wkwikk30XuxgL0kQMVbY+/Vw4F4vyIitqi39dImNu3/L3tlANXz5OhvGMaulcHwwdHhRtMBoiYoRLLjGpk+dXvChYB+F11F4ecx/RvqvR/O1YwKRilZxDsoWtkqBSRYQWGK/ftsMQTaXwStgnuMn0l/AG/YfwIbvVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709851; c=relaxed/simple;
	bh=hP6ICZkZwMBX7TxHKE9pVwjqtg2Hp+iGzqz1ii73ki0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EolezDp32TxFUZZtjvQSf1CtwAyvToL7mq1idRbXmstKVz8aKmA3V+WZiHrP15KZjzTuVY16eB5SuRwgcONXvdHcxXC7bWwn8bUZuqhStEgJMKDFh+191QWMdKHLcHcqhwEfm8QG8YAcKhgJnp7DGE6SnKX0qhsMmmxAJ5BZyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o5kgKe2a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iwN1QiecwKUgiA5BqbQsAiVYW2O418orBBaACjtdJjM=; b=o5kgKe2aWPGjgdiTzhp4xulT4d
	MUWzqak8SSkAo7B7vIJAyGh5aiH38a62Wv3/CmeSzVdK5vTxB1oRLnTyXCvtoCo2161Y/i4sFJEyn
	FziacD1A9ppL0i2qKyTifrDGz8Ewj4NrmwRKLLnAXEtQW2yc5xjoQ5Q9hh2q8NFQ1oq4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxAcm-008Fsa-BD; Fri, 12 Sep 2025 22:44:04 +0200
Date: Fri, 12 Sep 2025 22:44:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] net: phylink: warn if deprecated
 array-style fixed-link binding is used
Message-ID: <53f9019b-ca94-4f12-b3d8-51021879d795@lunn.ch>
References: <b36f459f-958a-455e-9687-33da56e8b3b6@gmail.com>
 <cc823d38-2a2c-4c83-9a27-d7f25d61a2de@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc823d38-2a2c-4c83-9a27-d7f25d61a2de@gmail.com>

On Fri, Sep 12, 2025 at 09:07:16PM +0200, Heiner Kallweit wrote:
> The array-style fixed-link binding has been marked deprecated for more
> than 10 yrs, but still there's a number of users. Print a warning when
> usage of the deprecated binding is detected.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

