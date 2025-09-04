Return-Path: <netdev+bounces-220064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F0B445AC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA152544A3B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560411E3DFE;
	Thu,  4 Sep 2025 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n8/Ns55G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB4F24A069
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011512; cv=none; b=jVzcjF4IErgZxG6LZAhDO5BVUiDmLsT+F0apWrG7Rx3kzJaVbB7tnCVEMAr6hlas7UIwvzbC1Yfp+3I5S0OqN5HOuLUqR1bqWshnM0Jw+VKylpgf5oO7yf/IMRBFqPdfsag3rVQPsBBwXvJKOrUVq32doSYi3abTi4+hl/t7mvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011512; c=relaxed/simple;
	bh=w59LEGWTOFQyjqSUQebd9xyBAGJ6ybpIDu4r8IR1WwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTABRYi9SNR9tko9YXwY4OSG9XqqcrIxK9KrabdSGbBXX9WW4cuFJNPi4VF+rwbn2jDYNLQacN4+0Ue12qa1k8A2zIoYpaFl+7tzs7dHWIiBRwKfY6cQ3XYBYTifuG2ydnl5txsI66xRw2SwYs19pT/Zr+06DT4ALEl2q6tQ6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n8/Ns55G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8zXTgLp+REuhLdavUz779iwcjPXkA1oJdiUgi8FfO/M=; b=n8/Ns55G0w8UM8vYC/p+0Ll7Si
	ubBljP42/T1Ioifd52FZh8DlSPOJOxXl8iULP3hXXymRAhTsw9aP1lszROyT6ltvb+cW8qSsLSlBP
	dzBDWd0hoLtT2Vmo1V3tXJZXNhMTA99SeVOtrJifOFGbNUGjvmFJQZm/Y8INQVDjKiMc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuExA-007Fuu-PQ; Thu, 04 Sep 2025 20:45:00 +0200
Date: Thu, 4 Sep 2025 20:45:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2 next] microchip: lan865x: Enable MAC address
 validation
Message-ID: <27319721-53f4-403e-9cb3-ed0c7d0a3221@lunn.ch>
References: <20250904100916.126571-1-wahrenst@gmx.net>
 <20250904100916.126571-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904100916.126571-2-wahrenst@gmx.net>

On Thu, Sep 04, 2025 at 12:09:15PM +0200, Stefan Wahren wrote:
> Use the generic eth_validate_addr() function for MAC address validation.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

