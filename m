Return-Path: <netdev+bounces-49819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3347F392A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1471C20E8E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC69A58129;
	Tue, 21 Nov 2023 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0O/QUcw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486F5647D;
	Tue, 21 Nov 2023 22:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210E2C433C7;
	Tue, 21 Nov 2023 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700605809;
	bh=E/bj/1FVapv7EKfhI42/zUXrmVv/I6HbzaDjwjJln44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J0O/QUcwf+hJ+9u9th7dU4ofixzovumMaQmyel928dNYI3hDAJCkcNaTDY1YmSPSY
	 k4JEXGgkPh6+2HD0yj3ygvLKntXV+4Tm7RJc8gv8cB45K2aA93QUPbdxgrZW+Bmino
	 9zX/6yfoT0Q66adsWy5pqbzUZROQLvIzs3aXRDrdnySIdjnXW0jVo39VHRA4WbT15p
	 dij3w0gQdCj4D7jnuEasrt64GCxI7XA9h8wX45W1J/xG5/QYDT0XMbMmdgg/dgYLBs
	 oculAlRo7XNFCoKGLeEguIrSPGRw6zvAciYRVBJddP01oVEsSOQEffzrbkFGmMwy7M
	 mSCzyhHpnt5kA==
Date: Tue, 21 Nov 2023 14:30:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 10/17] tty: hso: don't initialize global serial_table
Message-ID: <20231121143008.576f4ca9@kernel.org>
In-Reply-To: <20231121092258.9334-11-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
	<20231121092258.9334-11-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 10:22:51 +0100 Jiri Slaby (SUSE) wrote:
> 'serial_table' is global, so there is no need to initialize it to NULLs
> at the module load. Drop this unneeded for loop.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>

Acked-by: Jakub Kicinski <kuba@kernel.org>

