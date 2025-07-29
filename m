Return-Path: <netdev+bounces-210702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BD6B145DE
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 03:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D058E7A4D7F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 01:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1111F7554;
	Tue, 29 Jul 2025 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PXT8XbJ3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3217578;
	Tue, 29 Jul 2025 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753753156; cv=none; b=Th4aELIlvggcXcZfpOSfv7S91czpVVt5BRLWJ6az/Kbc9sTpTbq+8eVTvcDq4NY/VY/egP3r5AAc4LI6cjMETUHymGGieMek08h27MjjZitXNO+3TqiV2FeIY+0wZCU/9iDPnedOmP7I0ld3/5UUT6TaDGXsMMKcthxN3S7tQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753753156; c=relaxed/simple;
	bh=AynWej14Z8u6vor1cVo1nb+DdTK/gwxAF0l7UsCdBHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfQEHtLEtFqEGjXtkMMy/7O2h4eK8FN+SrK+JCBedVLZa9/EW0RbCbr0qNTwH+gCffLpKVgj2Yl5t3TXCfMT7fJ4WxvI/SULMa+Vs1Axc7JsfpBMyNUUAhlnFAnwqXLxD2ADhy3zjiRDK121/DDBiC0iwdPTNJdT7iTPZ7CCciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PXT8XbJ3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bDiSGgTwK4oBVoJWbPnfgIkn9cdp9raOCjF1DXXqbno=; b=PXT8XbJ3aykBGDknc/4YVv92Nr
	+IgTSHbSlgw6iJ4wUqEQ6t22vorhwC9nj0BjNmOScRxAWYmBYqqTWpUHtQkrZFJwClwMRRlS0thlC
	zxdFoDtIHxGGSFDiJm8vKGKpyUlACN+SmBWjsmaQ+f12aZpvT5P43L8/nQzNvZs4zLhc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugZIz-0039Jo-8C; Tue, 29 Jul 2025 03:39:01 +0200
Date: Tue, 29 Jul 2025 03:39:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tian <27392025k@gmail.com>
Cc: irusskikh@marvell.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: atlantic: fix overwritten return value in
 Aquantia driver
Message-ID: <3ef5e640-9142-4ebb-9b0d-a6c62e503428@lunn.ch>
References: <20250729005853.33130-1-27392025k@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729005853.33130-1-27392025k@gmail.com>

> This patch uses `err |=` instead of assignment, so that any earlier error
> is preserved even if later calls succeed. This is safe because all involved
> functions return standard negative error codes (e.g. -EIO, -ETIMEDOUT, etc).
> OR-ing such values does not convert them into success, and preserves the
> indication that an error occurred.

22 | 110 = 132 = ERFKILL

How easy will it be for somebody to debug that?

	Andrew

