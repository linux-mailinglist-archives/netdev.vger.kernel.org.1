Return-Path: <netdev+bounces-162230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3347AA2644A
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7F33A1A0D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E9714037F;
	Mon,  3 Feb 2025 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hu2hN4MG"
X-Original-To: netdev@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3954414;
	Mon,  3 Feb 2025 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738613756; cv=none; b=QXOunLZlUyCpLJOGao20DZuMupomHifCiHHLgo//YBY9caobxZKiMcZSQr4VuwQsDHU2QZndNG9LW/2TmRCrZP/FIW0u5TwQ2GLe0AQ4u74n64DFh+LQ8yK+9i6e42vv2PU6Rl7zSvWOTEv7M5DcrUi5SOeJVR6uFKhfNx77/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738613756; c=relaxed/simple;
	bh=CMsRxRRcOlSLQMjRd9+IVcchv0iPRBlXiJNkU4xsdlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA7cEs7XC1yt4ChJOuu/Ljd6ylljYmBOX5nRNsnNiugyqH0WYmyh2UZNCtAK2hxdqvPz+yonQTr1qbU7VJBCCQk2XU8MjjxRT1qOAVNrEg4yENEfNjD3Q0kS7bMaIoYIFjWu+It/DngozGV3rCRYWPTST0F8XFpC4njyW0z+jpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hu2hN4MG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738613748;
	bh=CMsRxRRcOlSLQMjRd9+IVcchv0iPRBlXiJNkU4xsdlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hu2hN4MG65ZvEIzaeyNvxBvFN163dpSO/N26maMKZKCByl9gvNGLkwTSYY+Wl1ZDM
	 9vPyznudwE4qIJsLpm0og8FDKzHIwNcv0YFayuUM41tFeC6tbxtF3MvHgo4AwejAGP
	 t9UUpJyyMLpgvBgFBL5gKv9UODkeN+/FBllJpB24=
Date: Mon, 3 Feb 2025 21:15:47 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] ptp: Add mock device
Message-ID: <8ea4c7d5-28bd-4ea4-ba43-3cd3e8a6162b@t-8ch.de>
References: <20250203-ptp-mock-dev-v1-1-f84c56fd9e45@weissschuh.net>
 <b383c0b2-42cc-4e40-a7b8-f2b393387043@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b383c0b2-42cc-4e40-a7b8-f2b393387043@lunn.ch>

On 2025-02-03 21:07:29+0100, Andrew Lunn wrote:
> On Mon, Feb 03, 2025 at 08:50:46PM +0100, Thomas Weißschuh wrote:
> > While working on the PTP core or userspace components,
> > a real PTP device is not always available.
> > Introduce a tiny module which creates a mock PTP device.
> 
> What does this add which netdevsim does not provide?

Nothing. I did not know this existed.
Thanks for the hint.


Thomas

