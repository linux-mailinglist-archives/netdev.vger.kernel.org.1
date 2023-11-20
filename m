Return-Path: <netdev+bounces-49323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B97F1B38
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39DAAB210A5
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200C208BE;
	Mon, 20 Nov 2023 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRoVhwIZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB122329
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193BAC433C7;
	Mon, 20 Nov 2023 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700502155;
	bh=VYsVMb7dTZSeGCIvqAHMIHrNGYFSYLbLSCW2ZnJAC2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aRoVhwIZzsovcUht4xexdrGQy1sY4u1raQytjdoBKYogoR7+Ksy32OmeKkb1yg8iU
	 d7DdalH5URIptKGMKEgvgXuvLVNCA0DqZ8XwO/IgeoA+/qwAg0TuOrsqUCqcKMH3Wf
	 2dMVb//32yoT65XNhOJiE8NXaNxvu7OWMsRRxnEr4xtLkTtOIJrReh58SdYABbi0ZW
	 KLVlpgSRUNhHIv8UmrqQuFaEpTEwKU4m0WlM0jNMx9m4NOwsBB9V2cyGMPg3zJ32EV
	 NGSflUAmBj/tjylbccffM11JtPeJMT+pPN1fTZgisAmtAQm83ufWaO25XlpFxve5ZS
	 SP8xddyEtuY1Q==
Date: Mon, 20 Nov 2023 09:42:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: correctly check soft_reset ret ONLY
 if defined for PHY
Message-ID: <20231120094234.1aae153e@kernel.org>
In-Reply-To: <20231120131540.9442-1-ansuelsmth@gmail.com>
References: <20231120131540.9442-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 14:15:40 +0100 Christian Marangi wrote:
> Luckly nothing was ever added before the soft_reset call so the ret
> check (in the case where a PHY didn't had soft_reset defined) although
> wrong, never caused problems as ret was init 0 at the start of
> phy_init_hw.

not currently a bug => no Fixes tag, please
-- 
pw-bot: cr

