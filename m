Return-Path: <netdev+bounces-166795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B277A37571
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64BE18830A6
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410BF1990AB;
	Sun, 16 Feb 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PPG5cayv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A81946A2
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722188; cv=none; b=fJLDlb/LvGzwTK2BbDJKcqZ5RusSVn5rbnF1A6170DpEtP+0J/CZ2uI8gDeoRKVTx1XWCFmR4cXa31zk8Uld4FT/SW5QWDtHyAkZVpwWEBBWA8gwu4XTMqvnLnvWR3JDvXYYWeTS8LvhfgUW0Ofw06JfF/ZqPEkoxYNwUSXx/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722188; c=relaxed/simple;
	bh=YI5ij21+HfseFkhTVZVysEbpD3cTmtD64puOybzKYdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSINcNU3QFJBJBx5zdzRVgIlO3M2a+y63RFw81BsZFmj0wYT4KyFTo9zX8dHIRvndOsx4mspom9JX6/rXZT9q+1qUNvuGDHFIPI5K2zb3UvEs2yOtwqZdJo+TWdj/af46ccRfVk2M1nyCGF1Xo3+uDxDgk2jr4rfyXYV9Wp0p1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PPG5cayv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TXRf+05JvfZEUkaWHyWdLGqj24efXRWUxo7Hm9/hCqc=; b=PPG5cayv2tLC3vgNcsksS3EDVw
	u5fxdh6uWUtPy1nl6g5wrNHa7IReidIbcJB5bHC4RwJtFSUi9QU9MTJeha4HKJcQ9zw2zn+rCV8aN
	6+SeVA05pUn6OT//rQRminVG+UxthS2rePn5/Y0GRSqYKojgXm6zbGwgw2mrnFkiSqE0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhD7-00EhCC-AH; Sun, 16 Feb 2025 17:09:37 +0100
Date: Sun, 16 Feb 2025 17:09:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: realtek: add defines for shadowed c45
 standard registers
Message-ID: <c6580e7f-f26c-4f95-b816-ca99aa73299f@lunn.ch>
References: <c90bdf76-f8b8-4d06-9656-7a52d5658ee6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c90bdf76-f8b8-4d06-9656-7a52d5658ee6@gmail.com>

On Sat, Feb 15, 2025 at 02:29:15PM +0100, Heiner Kallweit wrote:
> Realtek shadows standard c45 registers in VEND2 device register space.
> Add defines for these VEND2 registers, based on the names of the
> standard c45 registers.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks, much more readable.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

