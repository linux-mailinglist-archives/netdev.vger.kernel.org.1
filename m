Return-Path: <netdev+bounces-237381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BEDC49D3D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070893AD532
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17E717D6;
	Tue, 11 Nov 2025 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpXzPTAK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D13C2EA;
	Tue, 11 Nov 2025 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819689; cv=none; b=m19BsTqYn0dTqdI7SmvmRUCrJxESUpaNx5XnerHkitaXZ+CAzRbkWe+fzLYy73Lblf/qjAy5yIyGPLH4o25cr5gsSUZB0F7/goH+AZLf2yYunlDXDzNurl5C/00kiZ1yIaGFS/U25YKCoRQSHlezAzUQpGDxHRbCp5YbsoMCuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819689; c=relaxed/simple;
	bh=djAb6J7QFKS9qDYtB4F7gUgGG4e6wRxvzDJBL+JEplM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRSadPamjvJfTWBF5ow0wktRltuE70tksZ3EW+Iw2Z0fEenKLNBl5Gmmvyr/qL36ja6dVE4DhRcpYtzRiRHttTiakXZygLMuYi62co6Svc5zuQIxdFHSwI/ugDK4LU5vGP7NK6SAbE6oKVlaeaGVQsNtUw1+u8Tq4JKjqoxrIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpXzPTAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63468C4CEFB;
	Tue, 11 Nov 2025 00:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762819688;
	bh=djAb6J7QFKS9qDYtB4F7gUgGG4e6wRxvzDJBL+JEplM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JpXzPTAKALPbW4rCBDHh3AFopeKciFv6+2mO/97mPNAHrlaOvuuR6ifO3pSsaWoAT
	 ceV09Vck4wzMNzkxZXnQ1Sjsoim+PpMFX1HIJyozJMBWirm0o4jWvlAh1mOG+Jra7r
	 a+RkA+/x+fX394ghWmdQ1kGrYnCmJK5FzQo3GQK7Fo6VKfcnzDrhv9cYBGO7yqwEzG
	 UXwsUyWsiy3JZq7CcpKjkMR+BcuECIUrP7jMaCW66ff9wmFxoCjQsqjdYX/JbNwwPH
	 sevg9hv4cdcW6WrNdjjU+kz7ZSGCa3s8Eiapb9rDgC8NXGiJEkUq9N3HAqG8YXBrBC
	 4E4wwCGAbMjFw==
Date: Mon, 10 Nov 2025 16:08:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Networking
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Steffen
 Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next v3 0/9] xfrm docs update
Message-ID: <20251110160807.02b93efc@kernel.org>
In-Reply-To: <aRJ3rVhjky-YmoEj@archie.me>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
	<aRJ3rVhjky-YmoEj@archie.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 06:39:25 +0700 Bagas Sanjaya wrote:
> On Mon, Nov 03, 2025 at 08:50:21AM +0700, Bagas Sanjaya wrote:
> > Hi,
> > 
> > Here are xfrm documentation patches. Patches [1-7/9] are formatting polishing;
> > [8/9] groups the docs and [9/9] adds MAINTAINERS entries for them.  
> 
> netdev maintainers: Would you like to merge this series or not?

Steffen said he will merge it.

