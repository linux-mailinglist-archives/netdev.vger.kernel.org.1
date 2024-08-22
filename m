Return-Path: <netdev+bounces-121098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2CA95BAEC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1B9282A5A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796E1CC89A;
	Thu, 22 Aug 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="46Cbf/Um"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4101CC17B;
	Thu, 22 Aug 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341747; cv=none; b=doR+G7EARuJbDQBfGJeoc7lmjSPuDQ2EiEdgpiAyYlrVQBu2+3KrOiZRI8IqkERuDplNRPT6OlnCH7BOzNKIfIDnflHOrmZiD9dBdsMXWGSYNb4rgkcJf3hXRxpa7BUomNdid4kzoG2IDl08JMwYucUgCTvYhTC+p/UduKRA7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341747; c=relaxed/simple;
	bh=pSUr7Jl/dycOkYCg0NFDyBz1NR2nkrdr8+XDXoMya8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giknNuzDv5TQb7opUgYuBhzjcJbpscXk7EZFn+lSpwxj1zMMAq4RvQq+Kmo6DXrSR2yYEcnt0YVs8qy8mc83sUwlj05/q6Wx9eYDKO992hoKR9FwuEiaEJpQQIuEtd+sc0UGWo01JGryHjbf+yXkMxWuODLY6Pn8i6H8ROl2kXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=46Cbf/Um; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CyiT+u3sE6Sphfx4XkOSujMQSwDpTWCM/mVPfdgxHPc=; b=46Cbf/Umo/OHw8OUeMGCZ3xRlW
	WbJ29NTo6liQLcjuEFrB3L+sYW6SCn2m9upWgPBBycsV/cuVPQByXYq9o1WOYAwg8lLUIRPpVn64y
	EUhU1JJUZ8KEWD4PqhsFW9ZU4NfH2ZF1BQS9ANjeEd35U1OQRyG46G85cCVdSNVFRw/4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1shA3Q-005RZ7-7d; Thu, 22 Aug 2024 17:48:52 +0200
Date: Thu, 22 Aug 2024 17:48:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] phy: open_alliance_helpers: Add defines
 for link quality metrics
Message-ID: <f7d06672-9113-4bbc-b141-361957140522@lunn.ch>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
 <20240822115939.1387015-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822115939.1387015-2-o.rempel@pengutronix.de>

On Thu, Aug 22, 2024 at 01:59:37PM +0200, Oleksij Rempel wrote:
> Introduce a set of defines for link quality (LQ) related metrics in the
> Open Alliance helpers. These metrics include:
> 
> - `oa_lq_lfl_esd_event_count`: Number of ESD events detected by the Link
>   Failures and Losses (LFL).
> - `oa_lq_link_training_time`: Time required to establish a link.
> - `oa_lq_remote_receiver_time`: Time required until the remote receiver
>   signals that it is locked.
> - `oa_lq_local_receiver_time`: Time required until the local receiver is
>   locked.
> - `oa_lq_lfl_link_loss_count`: Number of link losses.
> - `oa_lq_lfl_link_failure_count`: Number of link failures that do not
>   cause a link loss.
> 
> These standardized defines will be used by PHY drivers to report these
> statistics.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

