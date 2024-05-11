Return-Path: <netdev+bounces-95706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AEE8C326F
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 18:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD6D281F6F
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B10B56766;
	Sat, 11 May 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uOasFtus"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446456B7F
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715444511; cv=none; b=jgLYlacCjdT/qOSiS9fwLVuzKSSBuy5eL9QcfZ6Dg3ajv8CtiOHT6sKUMSsug0k3S8YuFXDU0EvbVCXNOxQzttkCZzOt8O9ZbzlVw/3g34bSWwQbjPqY5sm6cfBAtScP4NoyA6i53pb5DkRaaVPoYgPKEh5OzVAqG2uPJy0dyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715444511; c=relaxed/simple;
	bh=IRDgsuaNPGgDYc3AhL72iXwJ5JSE0WJoBvnx+uWWE7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO3Py3cyEVEtwmsLU+o7i4jSZ2inJkqk3CZWFcBkJfAd+Trp44qElvfuUBCwhrsHze9GC+dX3KKY0pb3517w4J+hrgOn8MpbioR4JjFO5KI64B8/oWZkBg43A13qKWGo5poOkyaFgvx4PbbgwCAy5qlTyhg/Qy7LvgJAQYZVOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uOasFtus; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E6RJxudjrpTlrvI13ERkzV46DM0JaW6mjeDf7tlPA/c=; b=uOasFtustdwTRJNt06zwBD89si
	8khWxPNizid+Qfd7WqXcdUBcg88fI26+gDkosKTZ/tai2sw69YHXICLkAWL52L93XBh3khvTFAyPX
	Yc4qcbKI6XiRXy7X7ZHRURHBLsu+g1UbxTXEkylVad+ygG8X7l2xtLoCFKgWtqt/xeeM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5pTi-00FCga-1A; Sat, 11 May 2024 18:21:42 +0200
Date: Sat, 11 May 2024 18:21:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] net: ethernet: cortina: Rename adjust
 link callback
Message-ID: <142f59aa-7778-4f95-b142-144dde25292d@lunn.ch>
References: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
 <20240511-gemini-ethernet-fix-tso-v2-3-2ed841574624@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511-gemini-ethernet-fix-tso-v2-3-2ed841574624@linaro.org>

On Sat, May 11, 2024 at 12:08:41AM +0200, Linus Walleij wrote:
> The callback passed to of_phy_get_and_connect() in the
> Cortina Gemini driver is called "gmac_speed_set" which is
> archaic, rename it to "gmac_adjust_link" following the
> pattern of most other drivers.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

