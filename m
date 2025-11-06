Return-Path: <netdev+bounces-236237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E6EC3A0DD
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9463B82B9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796012836A0;
	Thu,  6 Nov 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lhRimDfJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732C218845
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423084; cv=none; b=AQRFDFCmRM/DCCkN0eSJs3DmUDNaS9UMDyh3mWR6ZWbFdSU8hkPZX7uovD2ZQNHWWljpbDwoqDYDU0zjgk4X5bAzywDS43lDYVOdvTlwnIhZRrtav+BrIw8xcttkEkQpMliN6o16ZiWxIjAwNnStIfAjdJ2NpbpE1dzgxz/upTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423084; c=relaxed/simple;
	bh=oYHWyXchcTSHudXm2GEDAvWj65pnZu3m/69GO/asms8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VP7+a2ANAsjmueNM3uSNJIfBMj++hVQcColwi+b923Esi40qxLkxIqsX9OE3ARnBKNvySmAGTm0Q+kmu4FU0r829zcfqfrkdQqgLtnhLheVt8FF0fd9uzARPlN7yj+7pDlqARKZlR5M347LrqB+0ey1ELGtudaKhVwQEftXY2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lhRimDfJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EC8681A18F2;
	Thu,  6 Nov 2025 09:58:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9C0C6068C;
	Thu,  6 Nov 2025 09:58:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78B7B11850340;
	Thu,  6 Nov 2025 10:57:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762423079; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=aA1Nh5vuzSHJhmK4d/Q7OkqDwftB9kBY44MgWQ5fnC0=;
	b=lhRimDfJSU530Ra+0V83y5TFQDiqg/9/f8FnAk2IKLuWRO9dy+hm+9ADz+lW3upGtpklf7
	oc0k9xOyZw3gaBO0/RbKvc/arSMN0GsZnCYYN3Wl9ENtNXGgQvinAWn12keNsQljLWTxZA
	Go7AkNluOrGI4GJUTvLgOLTANpGbNoA85WTb/yhazPiDlD7B5e0SKc9PNWpj48ss/RpWnH
	bzqZKDlSVyEJGSVq/L6kPueEPsGFjk16uJBC6HdCBL8dO1KKnSJuoIq1KnVuVSUaGxcDfS
	6hTds9FbSa0y/flYWz0aEkjN7K1spVyR+RNtsC8O03HDCtUPstx6EybkOi3O5Q==
Message-ID: <6ad7667a-f2be-4674-99a2-2895a82b762a@bootlin.com>
Date: Thu, 6 Nov 2025 10:57:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/11] net: stmmac: ingenic: convert to
 set_phy_intf_sel()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 06/11/2025 09:55, Russell King (Oracle) wrote:
> On Wed, Nov 05, 2025 at 01:25:54PM +0000, Russell King (Oracle) wrote:
> Convert ingenic to use the new ->set_phy_intf_sel() method that was
> recently introduced in net-next.
> 
> This is the largest of the conversions, as there is scope for cleanups
> along with the conversion.
> 
> v2: fix build warnings in patch 9 by rearranging the code
> 
>  .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    | 165 ++++++---------------
>  1 file changed, 45 insertions(+), 120 deletions(-)
> 

Damned, missed that V2 and started reviewing V1... I'll resend the tags
for V2.

Maxime

