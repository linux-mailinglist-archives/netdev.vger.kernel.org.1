Return-Path: <netdev+bounces-100017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0558D7756
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 19:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A2D1F21255
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040255B05E;
	Sun,  2 Jun 2024 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wq878SaJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B726AE8;
	Sun,  2 Jun 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717350399; cv=none; b=nBs7hpPdsFKVwzsqgTHCm8aeYeg5teOpcZ3EIIjrNoMnhiGP/jhFXely6YYYc1g2hm0GhXjGuiSxxjGVeGORbE+tCb191ma+AnZ1iHshFtpOM3FdBo0o0ZOu6e2CcslH9uDbgL0DCp7hWBIWU3YcVJwzo+v9KcR0yWc8k3JbCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717350399; c=relaxed/simple;
	bh=Jo/8pxs64PL2IphdUCZq8A5myMqNEj/6zYhWmAd8Iz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngux1L54HiFDiU0Ru9MEwZTdd/PQZe2NNkaaRaZKOPQcDt+Msw8G0HcXuH04zu6W9goD2ErdMhSRuSK/6UHQVmaTW9HiUDY49B5EEbuIwAbzKoA5FMaxwZoFFVDdTmgWG0zbtqTik09GkC+RcEXYBhjcHyB3Eu7VJODW8zbSJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wq878SaJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s87pxhameWr/oWTNROl1ezKoYqagD8cuErFqB4w2Iak=; b=wq878SaJtmd4qH1KRu/afp/X0X
	HuUMcwGCbdxq2gtd5WbFcopmYWlqF596nD568IgaL61dKrys1CNsStgNZg49wXnTXb4Xg8KwUig1/
	lUVyAjDr1T/ZB9znuZfs7RKbMtjB8Ze0Pi7Bg4BKaWZ3ZsR3lY9f6oPfgCpGDr9MCyZc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDpHr-00GeJB-JC; Sun, 02 Jun 2024 19:46:31 +0200
Date: Sun, 2 Jun 2024 19:46:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: linux@treblig.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethtool: remove unused struct
 'cable_test_tdr_req_info'
Message-ID: <71b72dfe-9ff9-4ed6-9262-cdd819614211@lunn.ch>
References: <20240531233006.302446-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531233006.302446-1-linux@treblig.org>

On Sat, Jun 01, 2024 at 12:30:06AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'cable_test_tdr_req_info' is unused since the original
> commit f2bc8ad31a7f ("net: ethtool: Allow PHY cable test TDR data to
> configured").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

