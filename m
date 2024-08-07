Return-Path: <netdev+bounces-116497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EBB94A92E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B02E1F294C3
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D4E200138;
	Wed,  7 Aug 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HEpCA+Wq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3120012B;
	Wed,  7 Aug 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039079; cv=none; b=WrsD5pwh03kYymiFNFQ1T4l1pH8ZY6HOUpsueh7GoWCiQdAgahphJ+U6Jg3EyPIDQ5NrSX30haKwNgYj9/JyGQuEr/iwUMx3qZzYVjaosIgQJeiOuGPzwuPGVV9GD+LwyXByzgBjyAb6xOUQ6H/ZUxLpdEPLkmlIRShA4L0sgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039079; c=relaxed/simple;
	bh=CCQCZ71qXiqhU3eno5AZEBoHx6KAPM1o/3yJygdVuA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbcpxCXxLS4mafuqEtB7FeoDZAUAUx/4/4k5tcbi+qHTr9e2b7hTvYdYJQDtnd9J51fRHBzamoZ9DOQwR4OyY90i/32x9+yfXYwr3DOGEZc/1L60FDSAUhC+btNpmxrOyPkLpoaGY1qvUMjnleK7gDXFRYGerc4B524BEiNGI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HEpCA+Wq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7fbD49ri0vKahZfkFcLs5AsG3uCibmwewh1+ZOt+Ies=; b=HEpCA+WqzL01yE/+x6Xmgfx7Pa
	c8XuQV6uuS1H+aDwRNyk9fiT2VnnX85zzGkAnxqIp1/DXhw554d6tfaSMi7eXuDRzVB+l+Sa7aiAQ
	3IUV1C1l2Y80R2wsY99X/WJX1iBF3nce47ROBI4GmdwyRSim8gJpOZRiPxkp8fNXRdWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbhAl-004CuG-66; Wed, 07 Aug 2024 15:57:51 +0200
Date: Wed, 7 Aug 2024 15:57:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: sungem_phy: Constify struct mii_phy_def
Message-ID: <34d55ac2-83ca-4463-bfb6-35e431340df7@lunn.ch>
References: <54c3b30930f80f4895e6fa2f4234714fdea4ef4e.1723033266.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54c3b30930f80f4895e6fa2f4234714fdea4ef4e.1723033266.git.christophe.jaillet@wanadoo.fr>

On Wed, Aug 07, 2024 at 02:22:26PM +0200, Christophe JAILLET wrote:
> 'struct mii_phy_def' are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> While at it fix the checkpatch warning related to this patch (some missing
> newlines and spaces around *)
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>   27709	    928	      0	  28637	   6fdd	drivers/net/sungem_phy.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   28157	    476	      0	  28633	   6fd9	drivers/net/sungem_phy.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

