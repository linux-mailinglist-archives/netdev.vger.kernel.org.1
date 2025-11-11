Return-Path: <netdev+bounces-237434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F3C4B47E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 04:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237963A3329
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340FC31353A;
	Tue, 11 Nov 2025 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EkJXkqjo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72D2F5466;
	Tue, 11 Nov 2025 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830416; cv=none; b=BIyV5e8aIQEyMnTGcdV3yxcA53ehALrN1+BrMXOQB9JQ+Xyr8II3Rx+wLoHfaCYhQOPO926G9XONvICA8djdb+HV8x9RX46/nK6Cdc4ByKVHZc3B+X+K8Ig6yFRmK6jyLuKOf7QaF3JBUwfmHh9iNrXcXJOE29P+wZlyJ/cZ0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830416; c=relaxed/simple;
	bh=h+vNCdFsfQH4wcyyT/Dj9tkYvsJ4RNMjVKyiTETnqwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+qrPMPWJ4GtRQls20ZUNIwQhfKTV6swmckuVen5diNdUczthXe9DmsDQR9W+vqDyOFaPmXSUGudULGoiFy9YtmFQygcoYaMNkNKSWA7/vK+ZdNizDfBD3ZYZDfaprNhpsCNnMfvtj+N6KUZwgXGqF43qVfZ7Qz/nwEJG22iVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EkJXkqjo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MO98nzA9KXDx6Wn49Jli5f1q2tXQ5XfjlvW2UYF1Gys=; b=EkJXkqjoO2RAjCZ7DLrj6Acncr
	uNV8cT5oDbtnZ4Vl3kGJ8Gh6bDzbSRVgSjQoOyty9jEUyeLDzxHNtOxqwMo4QOYVCGdF650eA+6Vj
	kGmOtFy4E5tPNywPRC5XN36QexNua1q48OGMsOQDU/VVky0DQy6J0BUC05qRQ8NGHHqU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vIeiV-00DaId-K6; Tue, 11 Nov 2025 04:06:47 +0100
Date: Tue, 11 Nov 2025 04:06:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, Wei Fang <wei.fang@nxp.com>,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, aziz.sellami@nxp.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Message-ID: <1f42240a-2322-4b4d-b0ae-6c08b927ea18@lunn.ch>
References: <20251105043344.677592-1-wei.fang@nxp.com>
 <20251110181306.5b5a553f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110181306.5b5a553f@kernel.org>

On Mon, Nov 10, 2025 at 06:13:06PM -0800, Jakub Kicinski wrote:
> On Wed,  5 Nov 2025 12:33:41 +0800 Wei Fang wrote:
> > v2 changes:
> > Improve the commit message.
> > v1 link: https://lore.kernel.org/imx/20251030091538.581541-1-wei.fang@nxp.com/
> 
> Andrew, is the explanation good enough? 

Not really. I'm still confused.

Let me ask more questions.

	Andrew

