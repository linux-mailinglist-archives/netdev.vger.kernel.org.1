Return-Path: <netdev+bounces-206505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 720DCB034F0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 05:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273EE7A06F2
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 03:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6578C1C84AB;
	Mon, 14 Jul 2025 03:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3SkKoNGv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4998BE4A
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752463333; cv=none; b=Qqw3EloUMF1B5F8BTSonbh3wY5dRuXQ5t9Rz0umQgNkFQGCL19CO0mDFFtwsTA/OcKEVP0DRFpzqfDtKjeevr9XbaxaZ2JJ9JBntbBUzCtBKEZmVXAF4nFBSabOzmbTWSbdM/QlYZGPfaA07ZpG82d80UMtGjnVHtnC0bNcHUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752463333; c=relaxed/simple;
	bh=UhOhYhF5kRDq3pnWChDtdqvQetRsWYULJEJv+nANSdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8n7EMfvCWwwL1LaOeL0UDeCnFFHAJMIO6wL+/4nXOUw/k1IYVgeinwvo5jy8yTMUQyDwKseYrxZx1DmNQM+AK94cdFgl+oOk5T48degW7y0kc+H3cYdIhHlLa8m8S2LrMOc5w5t6/ogDrPgM7ALg+3yBL/SvxM6XYp9W7mEf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3SkKoNGv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mSlL9yoU7UARseb6ywTRXG/K2VRKY5hFBpTl2TTot0w=; b=3SkKoNGvtw2W322bFAY9nd2opG
	F/L5Xw42vJjgLKJPwoWzlZtmZhoM34VASm9hDimjo3YgLdi9zuuZ/KYqnoP6TyRrtYEqDH/UGd7CU
	57A73k9Z4eYISe2lszynZVFUNt7tiocJxneZyzhBKN1eCVXb0D2SYAVsSjy7chb86P64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ub9lX-001Pa8-Dm; Mon, 14 Jul 2025 05:22:07 +0200
Date: Mon, 14 Jul 2025 05:22:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, fancer.lancer@gmail.com,
	yzhu@maxlinear.com, sureshnagaraj@maxlinear.com
Subject: Re: [PATCH] net: pcs: xpcs: Use devm_clk_get_optional
Message-ID: <a9072d67-d48d-4c43-aa9f-2957c53b3772@lunn.ch>
References: <20250714022348.2147396-1-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714022348.2147396-1-jchng@maxlinear.com>

On Mon, Jul 14, 2025 at 10:23:48AM +0800, Jack Ping CHNG wrote:
> Synopsys DesignWare XPCS CSR clock is optional,
> so it is better to use devm_clk_get_optional
> instead of devm_clk_get.
> 
> Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>

Please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You need to indicate what tree the patch is for in the Subject: line.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

