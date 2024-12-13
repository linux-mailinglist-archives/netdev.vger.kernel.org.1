Return-Path: <netdev+bounces-151598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35549F02CB
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1811E16ABD5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A342502B1;
	Fri, 13 Dec 2024 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMGTanXO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B428DA1;
	Fri, 13 Dec 2024 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058393; cv=none; b=rA2aGdO5CFZzs9ifadQHCBycpMC/Yh0czF6N24B3il77Yxp0svxZjRQNwmLQqhd3s/RsDacqtWZnRZj8Q5fafthF1k/QdhbfCX+H9/jOy4i0HoxfATcNlA5k4Nr3f7knGq9uRYHAZVW/Hv8gJWzC+GEX5fZcN6V7Jpiiad/89Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058393; c=relaxed/simple;
	bh=No5N+ZNMFiFGAgxk2848SL0jVCsEhHgAvE4/eJDnpno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hD73K8Ca0tnGCcFejqDo3bnVYVe1qOeHYIXyu035S7+1as91nA3VqZthdhpipqUqbEA9OL9opPMQwRS0pHSERPzdnehxcyI77dkWCql2licDGdzlbWQqb8mEnXLb2n2nkv7FhZvFN834VsoaQHUb1uL8dhl5vVwjZqf9SSXjRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMGTanXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F434C4CECE;
	Fri, 13 Dec 2024 02:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734058392;
	bh=No5N+ZNMFiFGAgxk2848SL0jVCsEhHgAvE4/eJDnpno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMGTanXOvkOyGlAM4G2Xk39zwiSNOhISJ9gZ5Ox8omGDAMxM7qeZlDJAGdfYk1PYZ
	 /o7nroGeBOIPmCVDxbAfR1jUNQQxwvk442C+tVgdDszwUQyPPJFWWC0JuDMx8uu+4F
	 JL4QsKtAjPpl626LXcUypMFhQ5al/+L0dvf3WmXSYzWepq0Z+rzxS34gPJTBG27cIU
	 lh3HsohlJvdXHjGLEeCSK1oC4q2MhXt8DQWEKqybc11S8IHqykiCAMd2T+1f0QHfvP
	 hqUlgtPG5S1Emif6g4MoR9Xz8PfSFmw2wd3J0dRru85GQYXqmCwte8H4ipaiJYgrd9
	 t6i+I39MqE4mw==
Date: Thu, 12 Dec 2024 18:53:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, Willem
 de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v4 5/5] net: Document netmem driver support
Message-ID: <20241212185311.66bb4445@kernel.org>
In-Reply-To: <20241211212033.1684197-6-almasrymina@google.com>
References: <20241211212033.1684197-1-almasrymina@google.com>
	<20241211212033.1684197-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 21:20:32 +0000 Mina Almasry wrote:
> +
> +================
> +Netmem
> +================

The length of the ==== lines must match the title.

> +Introduction
> +============
> +
> +Device memory TCP, and likely more upcoming features, are reliant on netmem
> +support in the driver. This outlines what drivers need to do to support netmem.
> +
> +
> +Driver support
> +==============
> +
> +1. The driver must support page_pool. The driver must not do its own recycling
> +   on top of page_pool.

We discussed this one, probably needs a bit of rewording at least.

> +2. The driver must support the tcp-data-split ethtool option.
> +
> +3. The driver must use the page_pool netmem APIs.

We should probably mention that this is only for payload pages?

