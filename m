Return-Path: <netdev+bounces-227165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F055BA96EF
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 15:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09F3188CDC5
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04345308F1D;
	Mon, 29 Sep 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwDCXw4o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41762AD24
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153925; cv=none; b=I/2sZMV7pQrJOp40meSLtrPo2yulNEW0NG/N8Hr+ZiV6rgp30eylqyFVyh1EEQ302wSx+1r3Juvo+UdJ++nHd8AGu996DVbxuQxwwKsg99fwpJDkqIiWCbTnuo4kSFuSaf6AtxvfHv4NC7wR9ErpK3zBUDkzriRbcXHaL/aYsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153925; c=relaxed/simple;
	bh=zbWgLnhJVt9rJo3K2bQPC9Wx7qexNQJ4iy6/wdxmPFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7bbaYIKlt0pGKJv6NnbeKUp2K5gbV+g/PxBuO6hw6Zko1FcjCa2C3A3azlvMSmH0fy+//sYXjH2LTLT/a6F7O+92fCuqs8v5W6rhWnnCTxgI2S/Xdaj+Z2ixWQMUTnyg6ApM8dEHlcXIZx4OUHMjEvPKizu9457G5wpMAGRFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwDCXw4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8397C4CEF4;
	Mon, 29 Sep 2025 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759153924;
	bh=zbWgLnhJVt9rJo3K2bQPC9Wx7qexNQJ4iy6/wdxmPFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwDCXw4oq7xoWsHO2EchZbJK4AwRpDHkPr8b0Y68N9P9+H9bHKbk/1LEXAxvWMAB6
	 tU9M489piouY4KJBOmkkfOSd/9/j30lLVkC0Fmh/4G/gxQ/cXBX+T7KbZQwoXpkJHQ
	 SBVvdS+7cGg8y6TeZ/Y7WVivrSFQM/Bore9yx361HCc0FBxRrUohq9AeKECLtOg7O1
	 8/gpp1evqLF5bI4TlKYnUkVRwZzDRtPsMwQ7b6bPd8evvjRxv/eE/85twVEGk4C/vn
	 bJ8FaJPdn8NJqrpKsZhBpn4GFhhSmV1ve+61WgO7gKJWIBmYu86+zApZnVpWT5COGw
	 oJvYxV0cobZ2A==
Date: Mon, 29 Sep 2025 14:52:00 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next 1/3] net: txgbe: expend SW-FW mailbox buffer
 size to identify QSFP module
Message-ID: <aNqPAH2q0sqxE6bX@horms.kernel.org>
References: <20250928093923.30456-1-jiawenwu@trustnetic.com>
 <20250928093923.30456-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928093923.30456-2-jiawenwu@trustnetic.com>

On Sun, Sep 28, 2025 at 05:39:21PM +0800, Jiawen Wu wrote:
> In order to identify 40G and 100G QSFP modules, expend mailbox buffer
> size to store more information read from the firmware.

Hi,

I see that the message size is increased by 4 bytes,
including two new one-byte fields.
But I don't see how that is used by this patchset.
Could you expand on this a little?

> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

...

