Return-Path: <netdev+bounces-244063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B768CAF14C
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 08:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C49300EE67
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 07:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4F245008;
	Tue,  9 Dec 2025 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cSAQuZyQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093A226CF1;
	Tue,  9 Dec 2025 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765263637; cv=none; b=ifE6TOScQr88MRnkkTUn8cvLH9b1hWVeYw+niAi7qarWqRARukOMtmh5g0Y+mVkR1A7bQTGbx5puwSRiJdBAYdIB8SKqOs/icWnCJrYUrrusNMlizVo1JUYY4eW0ibU/dnSz+KJAgWZqcYrtG5UNJ8yRoLcD79Nrmk3JJDiZIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765263637; c=relaxed/simple;
	bh=f86f5rReVxk1F6O+tXRBg1h07FfxviZkz06O5Qk9GKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDWpoIZJoB52m419HECYYsrUfTSBVh8rURhPFDGbhu1m6LiG8BWeM9eE206oPc5xgKZQLD+p3RMB0Y00wMNd+adDXRqrL2CN5GDArBXFoautmJCDYkqE1IjyHwveEyTxnXCV8cFpe/RDznpGBifFb5OBOEVNHm1I/eLJF1mfIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cSAQuZyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DE1C4CEF5;
	Tue,  9 Dec 2025 07:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765263637;
	bh=f86f5rReVxk1F6O+tXRBg1h07FfxviZkz06O5Qk9GKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSAQuZyQYpiHlAFs7gZpiKRm1CFcgf6XfmcqniVjHPFaz8FiABRctqBFr4OhH8jyC
	 I2RGG2+BstJwmxsHPlV0xw89YGWTx1/DX7MVqvOotmoPO89aYMsXTAHnXE3Idajk5i
	 6xUJH0eR24Z4F8UV2HA1ggnm975jVlbBEJ0Wb3yQ=
Date: Tue, 9 Dec 2025 16:00:35 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Johan Hovold <johan@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] nfc: pn533: Fix error code in
 pn533_acr122_poweron_rdr()
Message-ID: <2025120906-pulp-espresso-7334@gregkh>
References: <aTfIJ9tZPmeUF4W1@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTfIJ9tZPmeUF4W1@stanley.mountain>

On Tue, Dec 09, 2025 at 09:56:39AM +0300, Dan Carpenter wrote:
> Set the error code if "transferred != sizeof(cmd)" instead of
> returning success.
> 
> Fixes: dbafc28955fa ("NFC: pn533: don't send USB data off of the stack")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/nfc/pn533/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why to me?  I'm not the maintainer of NFC that I know of :)

And shouldn't this also cc: stable?

thanks,

greg k-h

