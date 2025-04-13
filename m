Return-Path: <netdev+bounces-181977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8DFA873CA
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357AF1890BC8
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 20:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0613155CB3;
	Sun, 13 Apr 2025 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tMlcgf0U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51676B67A
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744575334; cv=none; b=B3wPz8XE7N5WzBo1ENVYUsILbtaVHniHQt+yVwK+1pJww3xb75bs5giJtcqvSxdViFpITBNzkmgW6haAHrPCSCQ2cIIYaktstDm59k7MCEq+U/Q717WmrNIwCM7jf15J9QqcrVQs8e/g5PbwhzRgCSfUwhwZEhefbgGUFq0RYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744575334; c=relaxed/simple;
	bh=YOxHEY+9N5S1oYam1ga0FTyUuN87LZsJ/yDeCS6kEao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moG/HzNHkOWSvaT73V8hPsHUg34RPfNdBbL/v9Gol85lCm0wHmIee0/JNmx8SKVkZfjMsMv9iPkeTZIRNToTP058VWGe4qxy3QiaF7fGf7hztOB1iyXYK3LEUmUQJV4b+vxZLtAhzz9UI68XHPXH9n9KzdEKnFd/IS5mson5xCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tMlcgf0U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ga6zr6tC8YyIRXhBXTictPu4Ydf+raIvJ99cGyjOU8U=; b=tMlcgf0UVVqCf4ZM+sQk0MPDeM
	Jf/wLwpQ3wmERLTBbxo3LxXPaLYJ3wi+31XmHg0uTWiuvZLR4MWUrC8W2GlLqgj+GQ3e7SeihIfVF
	qYLung55epeUlq2qkUgLpG6ejbWBddTxJA9xZJXWLJYxDUcF7zg3MpTN/gRJDB7hgMJM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u43jf-0095lc-M6; Sun, 13 Apr 2025 22:15:23 +0200
Date: Sun, 13 Apr 2025 22:15:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: remove device_phy_find_device
Message-ID: <eb481421-cda9-4955-b418-8d98430062c1@lunn.ch>
References: <ab7b8094-2eea-4e82-a047-fd60117f220b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7b8094-2eea-4e82-a047-fd60117f220b@gmail.com>

On Sun, Apr 13, 2025 at 04:09:40PM +0200, Heiner Kallweit wrote:
> AFAICS this function has never had a user.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

