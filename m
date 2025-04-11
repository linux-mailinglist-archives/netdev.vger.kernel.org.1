Return-Path: <netdev+bounces-181624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C15CA85D0A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C22A7AF749
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA65A293478;
	Fri, 11 Apr 2025 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GfYPvYj2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AEA213E81;
	Fri, 11 Apr 2025 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744374414; cv=none; b=sZdo/g7EO9Afzu0cDgkwWMuK9qiguaz1AVMuaLPysRE3hL3j7243EYTESpt2UtJAEE+TvhpaObQFNfd6EQQ8cv7frOCXA8QtaJkqvTXQb2TTLFY6ZsRDqLhGw96RSHs1t0HnZtJutyg23vBvGxPxNfM9eG3nTVw7J0k9qF0eagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744374414; c=relaxed/simple;
	bh=FqShqnnVufRBb5rNLXSZf05DetjwYO540CrOZmPWxb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkqZRbrcPa5WwNjEguZsUkaTyYaBpzMsK9yB/bWfdLvAPEIcEKmKEmyHekUXEfn9ipeN8qLoxCgWZo08hHpxpj2/ri9RNMBhkuDMjuaWZrYYZfvBhXsSHnME9z/eEA1c1elZwsm3823TzvGq9ZONHtBi/WgIrKeuQrTpUw2sX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GfYPvYj2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LrZdh+poEHqluBAWamb9c0Us0R4xYVMIWRYTWI8yWC8=; b=GfYPvYj2YpuY0FakqwJ18AYy7Z
	l4P32HJxETjyHv46jdNXZCQJDOBqgncPzVTO2KRwdRLjW5EyLg+GM5QcoZ0fgXp7tz7wm6m3wJNOW
	SSQTyOA/X10oRju+vgTz3UZcDRgWhYyneNcw/fVOMgg2yIoKpxan6kXEwkuBtfoBpad4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u3DT2-008nvb-JC; Fri, 11 Apr 2025 14:26:44 +0200
Date: Fri, 11 Apr 2025 14:26:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, rogerq@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-controller: add
 5000M speed to fixed-link
Message-ID: <8aea379f-836c-4402-8781-ac7ae26c3529@lunn.ch>
References: <20250411060917.633769-1-s-vadapalli@ti.com>
 <20250411060917.633769-2-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411060917.633769-2-s-vadapalli@ti.com>

On Fri, Apr 11, 2025 at 11:39:16AM +0530, Siddharth Vadapalli wrote:
> A link speed of 5000 Mbps is a valid speed for a fixed-link mode of
> operation. Hence, update the bindings to include the same.

Yes, O.K. Technically any speed is valid for phylink fixed speed. You
could just as well say its a 42Mbps link. But keeping with the speeds
actually defined in 802.3 makes sense.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

