Return-Path: <netdev+bounces-189253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482E8AB1572
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8BE9E85C3
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343F291897;
	Fri,  9 May 2025 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kS2Y6zk/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E815E96;
	Fri,  9 May 2025 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798170; cv=none; b=LCeuStEHIV7EIkL/V9W4mhPEghglXbFumL4bA4gz1CKKjdl4y6woEnJyMYfncGVPl5fMySzG2nblBy33fkvewjYS13SbB76Ufn8fRuH82x1r1Q6LRXmn944ILuzr44EmdZrQCgEQTdeN7JaOYFUzqUFjff5/vheBg2uW6I+V9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798170; c=relaxed/simple;
	bh=Gg64AEBjd7bGc2+Mb6LpNmlNpxffcQAMTUvt0Jg91mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UL1sLkaHX8K0qqc5kfyjbm+4uJUN7Y/KADXGNEo3lL6gFqg0WUQV/gJLdR38jwoRLDhfiz8hfEHeHS/q0DgbmgavtZAOgTV9NaH2hTrVWMfQJ8xls3g31JN74SqF0lEp4jDFDtjvTEhN6bHsUZ1Q+DcrxEuhyEW9Uw+FQWR8vys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kS2Y6zk/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ydj8SsT5If79NmzGkKscGUrzKr/1vYbNATENdOccLJ4=; b=kS2Y6zk/gPRVnsjApiVLkUS+Y1
	+fhU7ret1pR7CYha1emPX4zJwJueWrBYDEUoQ1NcgWImXLE/6DZbiLqQka60qCDex698+oKv0k5JG
	Dw8G/BBfsqHDOqqSfFEUfrWcR0eEvjvc5o0i28hyjcLviH7hDgRonNg69KfgCGyRrnYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uDNzu-00C7Fm-Lf; Fri, 09 May 2025 15:42:42 +0200
Date: Fri, 9 May 2025 15:42:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next V3 4/6] net: vertexcom: mse102x: Implement flag
 for valid CMD
Message-ID: <217b64f8-b44d-4eed-b5cd-06d886117daa@lunn.ch>
References: <20250509120435.43646-1-wahrenst@gmx.net>
 <20250509120435.43646-5-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509120435.43646-5-wahrenst@gmx.net>

On Fri, May 09, 2025 at 02:04:33PM +0200, Stefan Wahren wrote:
> After removal of the invalid command counter only a relevant debug
> message is left, which can be cumbersome. So add a new flag to debugfs,
> which indicates whether the driver has ever received a valid CMD.
> This helps to differentiate between general and temporary receive
> issues.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

