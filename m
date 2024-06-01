Return-Path: <netdev+bounces-99944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BB8D728E
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 00:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E27281E3E
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 22:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36607224CF;
	Sat,  1 Jun 2024 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwjxzfg4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE09B657;
	Sat,  1 Jun 2024 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717281736; cv=none; b=acewAfsUp4khCDQZMGx6VHRfuY/wAIozSpe+o+gQqEogS5hK9BvJkzMxMX+aU0Lq8YB47qAaHTk+wVL5avJeqe3WT/ggvd2tPIwbJ01whTnUeHwaiZZ7u4sfq+z1iY04TZiGexICYiI6txzY4HbwIyGrfh5ljJ1Ov2UFaMnHeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717281736; c=relaxed/simple;
	bh=VXcYJY/8RPuKEhVc9Wqew0vicKGpKsnPJEECmXGSwdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HL31j6BT8j4zr9SkuD6qdwLxEVszaRNIRY89l0LkfllLFGm4+wvLRXvzbtMeCwbn2mCutwWT1HUpQaBENQ1PSKS4HiC91mPPD1fe0EBvkjtwObHmi92RAOZTKaI4uK/PKJLAtFyfQ2RwxS4FRXd5oMj7nz3AruWhFJzygNlPpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwjxzfg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9148C116B1;
	Sat,  1 Jun 2024 22:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717281735;
	bh=VXcYJY/8RPuKEhVc9Wqew0vicKGpKsnPJEECmXGSwdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwjxzfg4ZbT0Wh+4UG3lMf80ORi9fffALl2kgiT3nsz5geBq+OqkZ81Oiyhi0hK1c
	 iduohA9e/lJx69kwzZEKFmlBYWxh4PU0NnESJ8vx1fF0WlNFEky7utfsDY07UnaKIp
	 Hj7ewf3LRpkjXm+PgcR4UirM1EMsdNO4FQx+q+CqhXpJJ5IPJ9bKc2MXJUWuT5cICh
	 mSYY81dR35NWLxxi2NjR3bAzTpmNnMRsPIaJOGOMz8xM/Gf0SPGGZ+ocG1bFxy9QwO
	 PxwxwpksCIRrUmI3IgXG4xN/S+rrknaw4dIJr1k283I7N+k3gsmdAzJulwO+DgVDdP
	 XTNDLetTycaaQ==
Date: Sat, 1 Jun 2024 15:42:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, Nicolas Pitre
 <nico@fluxnic.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao
 <leitao@debian.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann
 <arnd@arndb.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: smc91x: Refactor SMC_* macros
Message-ID: <20240601154213.7274767f@kernel.org>
In-Reply-To: <20240601165342.GS491852@kernel.org>
References: <20240531120103.565490-2-thorsten.blum@toblux.com>
	<20240601165342.GS491852@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Jun 2024 17:53:42 +0100 Simon Horman wrote:
> >  drivers/net/ethernet/smsc/smc91x.c | 132 +++++++++++--------------
> >  drivers/net/ethernet/smsc/smc91x.h | 152 ++++++++++++++---------------
> >  2 files changed, 131 insertions(+), 153 deletions(-)  
>  
> This is a large and repetitive patch, which makes it hard to spot any errors
> (I couldn't see any :)

+1

While the spirit of the patch is right, I don't think we should
encouraging refactoring of ancient drivers. It's not a great use
of anyone's time.

