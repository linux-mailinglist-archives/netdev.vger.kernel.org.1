Return-Path: <netdev+bounces-248235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C0BD05AE5
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28484303C981
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF9731AABF;
	Thu,  8 Jan 2026 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dhtmp0Ok"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5131AA80;
	Thu,  8 Jan 2026 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897186; cv=none; b=izD6qQ7DNSOJ3TUKiWNURPbZpMzj6y3vm4uYXMCxlFdzl0stJ9SroNf45amMQBKTt/mA1Es9dpwZ0mB+ygVY0ACYCuPm0KAoq9u1JXR1nSjyZxVUeD8WxD/wNZCsn7+yFcF5eXbqEQjxvL3ufIe7j0z6mvughHSBBHTMa/4RXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897186; c=relaxed/simple;
	bh=2FW/IDH+2Egb7zWDKH2rylDh5kq4bwT2xoEtEENeGPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fc/1TpyM6R6GKjc3qm/+eKTJZs6bEbRY7mzmkCokf69+Bomm9zMM9ox7hmOCGmqgknrc2A0kM/z6CO6O2dRVfrhB0ObW6xiy8X6odXYuNtldmTdNmspAs+zqihzw+EhyilFaFMgWPSHwhcTpseNQneoOUZCDp5JMwTSEzdHg2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dhtmp0Ok; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ps7jZPY4FbDGZNsFiPtKjpsvXqKdPPCB6ro6RC6MSWU=; b=Dhtmp0OkfgIUIdUqT+a79nDLqT
	U19hLHEM3un0TRFDyIDzoLP/wHoTTkZizFXuOfmk6cCQAM+F0wGf2Mcz8YWn2ivO+8G1+NJeEqy+6
	yaRL0WJSsHSYfaY7IkxrpH6VRhkuQUQ/p+ZLdVGFNYr3JUW4w4eoZgh+6NcpVFAB6ot0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vduoT-0020Bo-GE; Thu, 08 Jan 2026 19:32:49 +0100
Date: Thu, 8 Jan 2026 19:32:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: ethernet: ave: Remove unnecessary 'out of
 memory' message
Message-ID: <81841486-b0c2-4f12-b4d5-08fe214f18d9@lunn.ch>
References: <20260108064641.2593749-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108064641.2593749-1-hayashi.kunihiko@socionext.com>

On Thu, Jan 08, 2026 at 03:46:40PM +0900, Kunihiko Hayashi wrote:
> Follow the warning from checkpatch.pl and remove 'out of memory' message.
> 
>     WARNING: Possible unnecessary 'out of memory' message
>     #590: FILE: drivers/net/ethernet/socionext/sni_ave.c:590:
>     +               if (!skb) {
>     +                       netdev_err(ndev, "can't allocate skb for Rx\n");

Please take a read of

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You tagged this for net, not net-next. I would say this is not a fix.

    Andrew

---
pw-bot: cr

