Return-Path: <netdev+bounces-99215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6878D4242
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22ED01F22A2D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BCC17545;
	Thu, 30 May 2024 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7/bhxbh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6E14F62;
	Thu, 30 May 2024 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028262; cv=none; b=V2h+iVPvxKYDwzdzYRRa8nkCvfvFOOrQfOzdx0zQLcsznrXVunRWAV+QukrYeZtM+O3eZTwpVjiW9B3WlPNDjAWOHdeaBo/ocCUoZzqwcdwpds06+2DB7x73DzNJUajMYd5PiVB56o0Wt+wSnNGSqOzIWS9OOKP5X0n0Kh4grxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028262; c=relaxed/simple;
	bh=djdHd8wIHONCymWta1CjqNGNBC7+yFbgjGcWEkWGUHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpIXUOilBiQZgA0l9eWIcSACzIPcapJ1wNA+CR1gB0B8tGrZUge+I45gxZ239+1WjbxbDLsBLcKw6VtMtIaRNXbBfRcLKQveVLQDLg6NR43XTQMlfAlEM0yE0PHZSuxHLOTASiGLf66hkVyJAw5SjJVV9qhMMW+Jo7Cm8YFFkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7/bhxbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD523C113CC;
	Thu, 30 May 2024 00:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717028262;
	bh=djdHd8wIHONCymWta1CjqNGNBC7+yFbgjGcWEkWGUHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C7/bhxbhCQ2f9sVQXyL58m7qdJhdR83K6vwFSyAUYKSZg8+cp36I01HifiNaqHV0r
	 2zgIpDY7J0QlBS9QXIqmQvmUVPnR8JVoyIbNSQr0HFva5moTIikCr4qFH1BxCX47iz
	 I4+ES8Ex9CTiD9utjC9srvXjvATl7/g4jRH0nN/NjkH9CXNFdj7H18C1P3JPVMqpPg
	 Xk0uLhHSCdppObIX0jDkIRSWZiI20dyzNMbII2MFuz6Cf4FV4cpLO51LZOaIA3xbOT
	 hefSAPPX+3X04hisxm1YZ9d4WX6bhlYbjWETU3fqQKLugVSDIKnLPoRnuBRa0yky/7
	 hznkxY928MTxw==
Date: Wed, 29 May 2024 17:17:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>, Uwe =?UTF-8?B?S2xl?=
 =?UTF-8?B?aW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Andrew Lunn
 <andrew@lunn.ch>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: smc91x: Refactor SMC_* macros
Message-ID: <20240529171740.0643a5a1@kernel.org>
In-Reply-To: <20240528104421.399885-3-thorsten.blum@toblux.com>
References: <20240528104421.399885-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 12:44:23 +0200 Thorsten Blum wrote:
> Use the macro parameter lp directly instead of relying on ioaddr being
> defined in the surrounding scope.

Have you tested this, or just compile tested (please mention what
testing has been done in the commit message in the future)?

What's the motivation - cleanup or this helps remove some warnings?
(again, please mention in the commit message)

AFAICT this will break smc_probe().
-- 
pw-bot: cr

