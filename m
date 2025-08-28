Return-Path: <netdev+bounces-217787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085EFB39D6D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6CE1C23F91
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAF530F550;
	Thu, 28 Aug 2025 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R0qGFq7C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0D222575;
	Thu, 28 Aug 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384620; cv=none; b=I7cby60iDY1fQD04DiVmEZ81TUuT4J/Ml2WWPaooztwsoFbJig0WLZe6kCsKF6S4BjzvB7Rj9eDWKpYiHT2OXcNwubnuoOSFfsa6DlqyvEQijB/vCsxP6hZcRYXXNpswLv8XtWa3fxCviIURjK1QtY9A1hTk991uxxMrJj7Ofm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384620; c=relaxed/simple;
	bh=blUJciJSSLxwF/RY3sOrPdO4YO3qAfCiZkydDBkm1wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBuv4ewM3iKe+G3Kn5VlpU2YnV4KiYBRItQ5OJs+B26zSvZ6sAMLWL63oiJOc269iFF/ZHZM4/bdNxX1OFDFi5aW2XqsZhnoGcF2yNjF6j4PqdDr+D23iZNnZFElvHNxhk2QQsV21yCXGcfHL8sYCxtGx/qXtO+2qFNXQpPE9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R0qGFq7C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=RDpyjCF+yhv6g6MHMLBvkxezcise4ZtJujs03AREeDA=; b=R0
	qGFq7CWq98tW9sry+u6pT6Foho8TWfKqoqyHNhrpAkI/Pwp85zE4I6RDDn6DMplLtYoK/y4vDQd0B
	KXME/F5qUx9LPQv0gRDtwa95XbWtpCR6xC7EJErfGOlaEeju6zNIPFei+hoJ0g3if5DW7XGXfxQCT
	N6BX82HBtchHKqw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urbrs-006LYk-8J; Thu, 28 Aug 2025 14:36:40 +0200
Date: Thu, 28 Aug 2025 14:36:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: mysteryli <m13940358460@163.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Biggers <ebiggers@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?4oCcbXlzdGVyeeKAnQ==?= <929916200@qq.com>
Subject: Re: [PATCH] net/core: Replace offensive comment in skbuff.c
Message-ID: <39356464-0b83-46f5-bf13-4f38c3ba2b53@lunn.ch>
References: <20250828084253.1719646-1-m13940358460@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250828084253.1719646-1-m13940358460@163.com>

On Thu, Aug 28, 2025 at 04:42:53PM +0800, mysteryli wrote:
> From: “mystery” <929916200@qq.com>
> 
> The original comment contained profanity to express the frustration of
> dealing with a complex and resource-constrained code path. While the
> sentiment is understandable, the language is unprofessional and
> unnecessary.
> Replace it with a more neutral and descriptive comment that maintains
> the original technical context and conveys the difficulty of the
> situation without the use of offensive language.
> 
> Signed-off-by: “mystery” <929916200@qq.com>

Sorry, but this signed-off is not valid:

https://docs.kernel.org/process/submitting-patches.html

says:

Signed-off-by: Random J Developer <random@developer.example.org>

using a known identity (sorry, no anonymous contributions.)

Please resubmit using a real identity. Please also take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


    Andrew

---
pw-bot: cr

