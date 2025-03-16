Return-Path: <netdev+bounces-175119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F4A635C5
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 14:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC46188E7EE
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AC419F487;
	Sun, 16 Mar 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxzQdZdM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F671991BB
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742131244; cv=none; b=NlnDjC4oYBzsKZCbXdQxPrJwwPEOMNl6wOoHjttAaB113C67mPceQIYXShGnTrwKarwt4hQ6X23mZZSTAd35GdIZB1UspeRA5nUSBrasC7+cm80gSF6yePAWwcYTtfzhDlJfC1RUH/a5hgGtHahraXQVckWtmddW024bqL356wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742131244; c=relaxed/simple;
	bh=Z1WaY3UtOZZv0S5uWA1TLnsXkAKuECHaTPbRePBVJE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp+XqBlMsCVwa2+VwDqRE4Io5nXVI2qY+pS/BxdI6IzVwzATrhc8ULP45XFgM81UeSh/WzsRnZXAvR+e9rP02u8nKwwvoHb+eTgExdcpexJcooiMBrGl2TPdBuDInnHowEYJZwbkUNgeis31CB7t8W7qHx9aa+F7yhVJGatg1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxzQdZdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783D9C4CEDD;
	Sun, 16 Mar 2025 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742131243;
	bh=Z1WaY3UtOZZv0S5uWA1TLnsXkAKuECHaTPbRePBVJE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxzQdZdMks1wUWS05aNS1f/jUuY4eGkQ4MXH1KWNlpLlI6ZhZEqhTWZFOiwXoH4t4
	 zx+6UEscH8TLXxJbBHkq7ain9/WLAxtJ0LdzFJtuhcvd1KRhqGEaHBB109u94Hsg27
	 78EbUgbyaS4nhF87O8wk7ug798ENuIGE0xXfnYNqFzLKQmclwjG6Byc51KBd0wPjEZ
	 t7HYcZsSCF/cynzfmbGYVUy0X3c6vfeMRVzi9TOyPSCktNBT/iVFfmJ9WenoCFLWcP
	 UmfSxH0ySnAMbKZSOxMUdpbw8YTKUeh46D/QnrN5NPRA+P87qnh9AJQO7fMSCoEGyQ
	 Xwm+CKXQOWEuA==
Date: Sun, 16 Mar 2025 13:20:38 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phy: remove unused functions
 phy_package_[read|write]_mmd
Message-ID: <20250316132038.GA4159220@kernel.org>
References: <b624fcb7-b493-461a-a0b5-9ca7e9d767bc@gmail.com>
 <5792e2cd-6f0a-4f7d-a5ef-b932f94d82f3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5792e2cd-6f0a-4f7d-a5ef-b932f94d82f3@gmail.com>

On Sun, Mar 09, 2025 at 09:05:08PM +0100, Heiner Kallweit wrote:
> These functions have never had a user, so remove them.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


