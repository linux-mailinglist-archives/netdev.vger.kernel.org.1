Return-Path: <netdev+bounces-116924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5C194C190
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDF6280EC2
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9848F18E77B;
	Thu,  8 Aug 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAcIm0N5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E46B674;
	Thu,  8 Aug 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131416; cv=none; b=VcoY2FDsHzUXnfOHSXaKBIcG4AnT+cEIW/HM3UWSReMg34d/QRd9QA/cuyvlynQD/ljtAIrEhY8DX85OI8pMeDTY4U/eHoR2FZV6xiwtBAkO3LGeVl/1Ub6w5ab1feDXxDRd/YyyBclXKv4VGHQwEaZCBkro3P6HhDYaGwC9HhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131416; c=relaxed/simple;
	bh=BZqJwdpjyaYWSS6qbvmr9ZOm2yEQL7qQ6I5f2FndR2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OR56ADK52jpCOlCCcqa9zfx3LoiF5iOEauJ5RHwkKc/rujcbRivavuhsnrzuVAXaeTEjQxqSo5qst1jSWmvqU88lCfAXtTj9nHUupsHuFTA2p6yhOGlN0qBZXDWzSOcoPGP9oP1+XgrDvlF+Nup4i4Vw0UH+1rtSpZb+eYT0hh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAcIm0N5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C69C32782;
	Thu,  8 Aug 2024 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131416;
	bh=BZqJwdpjyaYWSS6qbvmr9ZOm2yEQL7qQ6I5f2FndR2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mAcIm0N5FRqFVXOi9+6/X04ClXM2OmISCgg9Xy9Uc2bxtjjNN+jfUNKKYttF2gcNb
	 glTbVvjHemOsCTXgPUhQc3pZNsThvRv8eIWlxfbxzR+7Oo5o3efh6adw/Wvr9REXte
	 uBC5kuUbQrKMfcJARabqBuLx+OB5Dtd19JqOw36sPtSRS4+pMylToxYf7MN0acCPyx
	 aIEp9t38wPsBQh17rtAJs9LtzNLCsuhNqLASKhPtaRYC4uoSLIrRgG7c6Y+z8ySXUu
	 C/oA2gUhA3XSvd0wYWLuKzBq7pvmMHYb91puWBdNiEEPE9gTUZjfevtVowWYkj2TqL
	 4hQXSsLHz7voQ==
Date: Thu, 8 Aug 2024 08:36:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Kyle Swenson <kyle.swenson@est.tech>, Arnd
 Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@baylibre.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: pse-pd: tps23881: include missing bitfield.h
 header
Message-ID: <20240808083654.665523cd@kernel.org>
In-Reply-To: <ZrM6zOyLodtaDVpQ@pengutronix.de>
References: <20240807075455.2055224-1-arnd@kernel.org>
	<ZrM6zOyLodtaDVpQ@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 11:13:48 +0200 Oleksij Rempel wrote:
> I acked already other one:
> https://lore.kernel.org/all/20240807071538.569784-1-guanjun@linux.alibaba.com/

Thanks for the note, I totally missed the other patch scanning for just
fixes before the downstream PR.

I prefer Arnd's fix TBH, apart from not having the wrong tree in the
subject - the fixes tag is correctly formatted and includes are kept
alphabetical.

I'll "move" your ack here, hope that's fine.

