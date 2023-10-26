Return-Path: <netdev+bounces-44405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B6D7D7DCB
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC017B2120A
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 07:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68058168B3;
	Thu, 26 Oct 2023 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1Lz0K6g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42674623
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 07:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CF8C433C7;
	Thu, 26 Oct 2023 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698306296;
	bh=XAlEIrmdypcb+KqT0LBcwNCR9qQHpu+C3FpeZNHMc+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1Lz0K6gFIUQPy+avCBiBd+4PEGxGPhbHeCaZODqJwq2+4LbcM9HCF/++6nFWaUqe
	 EXar9/f8++QDvGGx1aPprPH1gQbTGegDsg6wYo7+MUwWLG/yz+mJqYFY3rDPPSIU7H
	 BAr3NK1WNpStquLTWMIjUnJZxwTzhJLdOZHENJR0D3Q+cuSt7Dq5nLkjL5jQnY5GjF
	 yx84orB3vgy1RldTVA76yhL5EjvxyUh/0fqdSc9i+34UL2FtZxyd3AJp1/+pmn0qHV
	 TV0qpeMVpchjBZEZYXOn55Fdf/VwahdITQ7ArvchDfSO1CE0G0OG2c07DuIPW/29IA
	 sLRcnTNvvVYwQ==
Date: Thu, 26 Oct 2023 08:44:49 +0100
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: microchip: ksz9477: Fix spelling mistake
 "Enery" -> "Energy"
Message-ID: <20231026074449.GM57304@kernel.org>
References: <20231026065408.1087824-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026065408.1087824-1-colin.i.king@gmail.com>

On Thu, Oct 26, 2023 at 07:54:08AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks Colin,

I noticed this one too.

Reviewed-by: Simon Horman <horms@kernel.org>

