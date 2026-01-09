Return-Path: <netdev+bounces-248584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D209D0BE50
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 19:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B92F530186A7
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EAC2BE7D6;
	Fri,  9 Jan 2026 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z/kwJsiA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1738E27B4E8;
	Fri,  9 Jan 2026 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984103; cv=none; b=IYZILvKjXY/bW6y1u8oiPl2Ne9QWGVr7Jy2TQwdYxWdOODR/0O0iLlEO7vq2LpA/+3S6Qp0zQekXQwknNn8VWXznNNXavqqfJplRpTIUhbScs0hUNJsGH3s4zcIExtNwiQhWXYMm05eHrWaQdpsoB4dESF4lUNjLPDLT3ugg900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984103; c=relaxed/simple;
	bh=uRwR7i5N5hrKc3LOg0yE/D7RcASl+IrFQQLJg5Psj0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8wRV3+ewB+nbScl7ILUlhHW4OfRKtt702+QmvCrYmDbNS2u1n81mW3CKpSm+TmIP1X7GI0rLMmPRsaErGPaWrUTz7hufYWjpxpO1/ri6RPFDgSaVi5FnQiUgaotRV9ZUciyIz389a1IBMIbI35eFtepiwLvz00N0cHq3HImILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z/kwJsiA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y2arKIYINm6+DoLhwZpYtjtYEdBJoBpiX+wv56J5tLU=; b=Z/kwJsiAqIb80Eh+sGA5H1tfvG
	vmGtEwx4wqtugP20xFGz5EWWpb2oNlfs4WgMqZBXucYrp6RJ4A26bdVQDXSPEP6shz4WFZAX5GpsS
	X8qcuJsrMJFb5yGA3q9UAUbq2zmfKYmDdhP37oBVnjf63kZfgkrspFi86RK/oGsfkcmw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1veHQI-0029f6-GJ; Fri, 09 Jan 2026 19:41:22 +0100
Date: Fri, 9 Jan 2026 19:41:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND net-next v1] net: ethernet: ave: Remove
 unnecessary 'out of memory' message
Message-ID: <d5db51bc-3d67-442f-a687-a9b959f45568@lunn.ch>
References: <20260109103915.2764380-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109103915.2764380-1-hayashi.kunihiko@socionext.com>

On Fri, Jan 09, 2026 at 07:39:15PM +0900, Kunihiko Hayashi wrote:
> Follow the warning from checkpatch.pl and remove 'out of memory' message.
> 
>     WARNING: Possible unnecessary 'out of memory' message
>     #590: FILE: drivers/net/ethernet/socionext/sni_ave.c:590:
>     +               if (!skb) {
>     +                       netdev_err(ndev, "can't allocate skb for Rx\n");
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

