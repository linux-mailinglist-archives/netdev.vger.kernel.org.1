Return-Path: <netdev+bounces-211617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEC2B1A73B
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 18:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E45217FC2B
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B34E2853FD;
	Mon,  4 Aug 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T5DSSnkk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5B2853EB
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325825; cv=none; b=my66j+XHRyqSwzBCdQ3y/lbMr7IkprQ8Xb49C3yHgzVpbSZ6GEIonWhcJn7aYbk0tRoziEj9UjuxmVUiP9aXSdgYuI42eb2l+IBkME9XLnvtRj/d9wBXVsAoQ8+5pCFr7Y/ljk2/5m22XJeBDQxG5vBMmnm59ZJMkL2gfBfjFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325825; c=relaxed/simple;
	bh=CKX3qYg4n91IDLnXleoSbtHQsa5hz2JMBcJPrukY/JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScmsqRYd0XxbLgwEsgQIc8fnxFJi09EVGYN850X+InArK2gQtu2kHHtPcwgiepan7z91BCicyXbp8FzH4yFPD2qdxPhfI2yHwj0PwA2i3VBOZWiwFoGNtbC8Bcgej66aH/vM5sbt/QV7dxpDqzai5rcrLI5mHRHD3/hPT2Xldzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T5DSSnkk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EkxIzZ1WJhUctEmEC9hbfaJYZPCzsM0oDIdvRVh7tvg=; b=T5DSSnkkG5IyA/fYWXZKneMbib
	P2t5pkr1TU2TgeY/bIpbXuCx34VMyV0unsmy1Z8YV8vZSqLagz9fBeR2dHjKsAv54svuuDvYwiRJu
	l9r5v+tb3laxqQ1Z0k+eeJ9xXQmN13fnK4o5sY8+NjFkdnu8al4jM4KAcJmuJbCLD84o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uiyHc-003jDs-Gg; Mon, 04 Aug 2025 18:43:32 +0200
Date: Mon, 4 Aug 2025 18:43:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: npu: Add missing MODULE_FIRMWARE
 macros
Message-ID: <5c4c928b-d660-4ef3-a306-eafe688286a9@lunn.ch>
References: <20250801-airoha-npu-missing-module-firmware-v2-1-e860c824d515@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-airoha-npu-missing-module-firmware-v2-1-e860c824d515@kernel.org>

On Fri, Aug 01, 2025 at 09:12:25AM +0200, Lorenzo Bianconi wrote:
> Introduce missing MODULE_FIRMWARE definitions for firmware autoload.
> 
> Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

