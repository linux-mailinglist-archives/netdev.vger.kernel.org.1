Return-Path: <netdev+bounces-204539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993F1AFB143
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA533AF73E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E420C28851E;
	Mon,  7 Jul 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxQ5ubRd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC734156C6F;
	Mon,  7 Jul 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884344; cv=none; b=MDZJ+ihyvlNmYKN6196SmiGie87PEBZ7imVcuHI+KdFZ1GN9uBq5QI7WAuB70+H2s2Hg2Q6b8rvk5+QaW3s08ngKrWGrOhiBdnqxsDijpy+j4TyjnQexeQVCeNqBVJcI/ys/hQdQVhl++Dao4dOuKpPq5ZB+b9/MO2zxD84Oh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884344; c=relaxed/simple;
	bh=R1sO1hRGmClExUVJvsVPulbTgZTZR+vNRZmGD1Ircbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSFLi5W/f5Ovz2fWBQIqdnrCIsniVWSsUsU+vZ9qacTK1cm8NeszWhqz0RqZ2cngSFAWKIITWzNGPXm3IgbeqjLvNoXVxKCPL9nnRxSp+4grzpWoIUQeIk6QIbm8tqRQQQKNWDZ2nNNzQfnj5Iq5qqKPCIsmjNNBdmVsMdTzjsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxQ5ubRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF621C4CEEF;
	Mon,  7 Jul 2025 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751884344;
	bh=R1sO1hRGmClExUVJvsVPulbTgZTZR+vNRZmGD1Ircbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxQ5ubRdv7M2ulDRIo6Is28RKakOge2FUzoYIcNryUG/gqY9wKyxq46gumfjUS4hr
	 BFneWz2/I4C70ECfRLWh0aIgHowEfy1/443BATk6Esbx73OSl/a+Ozo0hbfntNY/1K
	 SIoXrKEF1LxsLzg9YrwSK4jHHjxKsQA68yMLVukVvSP7CbK049UugTIk6YewjSHhz2
	 H56zqFMlURln7e53KCAv2LszU5V7uO8/Y5C/3Hx77Hl+F3vW2rBJtGdM2rEK36nwlB
	 xw7oW4J35hGhR+eBqvoAVG9unagGFS4M6rm8AWmjdaoLcsFNqh1yEfyUDVyaibTxZt
	 3XVWs+1nJHQbA==
Date: Mon, 7 Jul 2025 11:32:20 +0100
From: Simon Horman <horms@kernel.org>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gve: global: fix "for a while" typo
Message-ID: <20250707103220.GE89747@horms.kernel.org>
References: <5zsbhtyox3cvbntuvhigsn42uooescbvdhrat6s3d6rczznzg5@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5zsbhtyox3cvbntuvhigsn42uooescbvdhrat6s3d6rczznzg5@tarta.nabijaczleweli.xyz>

On Thu, Jul 03, 2025 at 08:21:20PM +0200, Ahelenia Ziemiańska wrote:
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnrufop6tch@tarta.nabijaczleweli.xyz/t/#u


Reviewed-by: Simon Horman <horms@kernel.org>



