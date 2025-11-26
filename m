Return-Path: <netdev+bounces-241917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8AAC8A598
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C19A4E3351
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C33930217E;
	Wed, 26 Nov 2025 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oUJkjBjg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15193019B5
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167573; cv=none; b=sb1cBbuY6YZB8JTb4uI/L9c4mc74J/R4neMeQdIter0yOvyQRcRtExnWhapLTeG4RUI0weMsWX1Vzyjw4NUs84gceGe5tsQXY+Nnb2Ylgsu0ADGSLTTq7b7jAvtAz/X/KJs4dC9VVjOp0zxOd6KwQh5JcOml0kc39KAw/GW2kME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167573; c=relaxed/simple;
	bh=zSM+qRKDRlsWru/fWlnQ3JkmLTcfWV4fzWk6NKj/jQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQz4PXAcaaCNhszrQv45hyv2tbxfryMcAsKUsWXefAcRIvxB1u8P8QqnO1pmLKKuZdePCkIfhWpv7r3siMdfyIjLeNc+vDgJ3Fe9t/Vv7nQCtkJWpY2Ag8W0yR52qB/aiw02hCVy1sRcZNtxYp86batU8Z7kXWhsFDLTZpKYRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oUJkjBjg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bc8Jg8Bka+bZkKjCf/d9rGakMulcRZyhMGCFVBN5Zl0=; b=oUJkjBjgrMIH4gOuG4kscxy6h/
	pdrL7fBVyrRHMXRhPO1l7obzvvUPUC8hNGrV7Iz34HvWQGdc94jRR9+BKO93g4zDyued6G9fJh0NQ
	ajbkCZ37Ncemwn7AutSaiYW9qMdVZq/0OK3X2N6c0FGRtmDLiQhds6ADsCwZ322GsYYM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vOGZX-00F9zB-Cr; Wed, 26 Nov 2025 15:32:43 +0100
Date: Wed, 26 Nov 2025 15:32:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Peter Enderborg <Peter.Enderborg@axis.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	Peter Enderborg <peterend@axis.com>
Subject: Re: [PATCH net-next v2] if_ether.h: Clarify ethertype validity for
 gsw1xx dsa
Message-ID: <ece45621-9f17-4c7b-b89f-ecf19a1cf617@lunn.ch>
References: <b072d237-2bc0-4930-a8f0-2adb7eb81043@lunn.ch>
 <20251126135405.58119-1-Peter.Enderborg@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126135405.58119-1-Peter.Enderborg@axis.com>

On Wed, Nov 26, 2025 at 02:54:06PM +0100, Peter Enderborg wrote:
> From: Peter Enderborg <peterend@axis.com>
> 
> This 0x88C3 is registered to Infineon Technologies Corporate Research ST
> and are used by MaxLinear.
> Infineon made a spin off called Lantiq.
> Lantiq was acquired by Intel
> MaxLinear acquired Intels Connected Home division.
> 
> The product FAQ from MaxLinear describes it's history from the F24S.
> The driver for the gsw1xx is based on Lantiq showing it's similarities.
> 
> Ref https://standards-oui.ieee.org/ethertype/eth.txt
> 
> Signed-off-by: Peter Enderborg <Peter.Enderborg@axis.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

