Return-Path: <netdev+bounces-66833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFF284111A
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 18:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80A9B25DA4
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD573F9D3;
	Mon, 29 Jan 2024 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fO68IfSF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F0376C87
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550326; cv=none; b=OWzth1A98FjDBg3RdBQmBmQmcOi9yevsSDmQKzfdi6CIYB+Snz8/WxcMICvn+aP1e6jdBotnvxUUqKL9ye06hsh0OWjF0NqEIhdmwlOniHglg5OrB0CRce1KO5O5tTNY88Lri9iLJwNCAgDawdBloLZNiu5WW1oi1F+82W6UUjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550326; c=relaxed/simple;
	bh=RoAgDl9YkrPT80LsXfwgN+DR/Vjp62ly2cwn32dx/fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK5a1UfN0IV6prrLP+t9En+jQH3KpvQFjr+20R3lKn9M608WMlhKRE3JuBlp964d5/hU+EjQ6rTvloHchG9I2pqVP+DJa3tWvJbB7kONxz5nMZ0h1ts7uDI98RPY/WufFPCvsHEzYWBo6USV2yWLUtyEKFQgJiRKWRTv1vsnJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fO68IfSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4646CC433C7;
	Mon, 29 Jan 2024 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706550326;
	bh=RoAgDl9YkrPT80LsXfwgN+DR/Vjp62ly2cwn32dx/fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fO68IfSFus08nFkZ6GKgFEnRJM2XRrbeOkWe8mO/AHYHFBcKatW6advYl9gQ6IhfS
	 PhcQNkZSlrbk9s7f6yx7Oko8ZhSdwgOKvIhv3RuS3U2clVOxwmTBvdO5H9S8iCCRHN
	 z5Cd/j6FZ6ev46Rce5sWjZvenCvFULghUtnpyBqo=
Date: Mon, 29 Jan 2024 12:45:24 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Vladimir Oltean <olteanv@gmail.com>, Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
	netdev@vger.kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 0/8] net: dsa: realtek: variants to drivers,
 interfaces to a common module
Message-ID: <20240129-astute-winged-barnacle-eeffad@lemur>
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20240115215432.o3mfcyyfhooxbvt5@skbuf>
 <9183aa21-6efb-4e90-96f8-bc1fedf5ceab@arinc9.com>
 <CACRpkdaXV=P7NZZpS8YC67eQ2BDvR+oMzgJcjJ+GW9vFhy+3iQ@mail.gmail.com>
 <ccaf46ca-e1a3-4cba-87eb-53bf427b5d68@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccaf46ca-e1a3-4cba-87eb-53bf427b5d68@arinc9.com>

On Sun, Jan 21, 2024 at 01:13:36AM +0300, Arınç ÜNAL wrote:
> I've had trouble with every mail provider's SMTP server that I've ever used
> for submitting patches, so the web endpoint is a godsend. It would've been
> great if b4 supported openssh keys to submit patches via the web endpoint.

The only reason it's not currently supported is because we don't have a recent
enough version of openssh on the system where the endpoint is listening. This
will change in the near future, at which point using ssh keys will be
possible.

> Patatt at least supports it to sign patches. I've got a single ed25519
> openssh keypair I use across all my devices, now I'll have to backup
> another key pair. Or create a new key and authenticate with the web
> endpoint on each device.
> 
> Safe to say, I will submit my next patch series using b4. Thanks for
> telling me about this tool Linus!

\o/

Please feel free to provide any feedback you have to the tools@kernel.org
list.

-K

