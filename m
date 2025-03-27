Return-Path: <netdev+bounces-178000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E718A73E73
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 20:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F75616CCCA
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239274BE1;
	Thu, 27 Mar 2025 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UATLF+8w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC5A55
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102975; cv=none; b=JWVcwkN2tIaiOl7xxxhl+xRMMC1fGftAaqi326f0mZEd8j1GCfHRvk/WVqp7TrxNulmxvzQ5E3VIv2gxlkIa092DmOVKlO6S/H5VKNGo9pmafvD3u6/30PggS8Tt45bnawgONJ6NqT7TFUUhZcrWl8NzlDrtFj0upToQKGQO1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102975; c=relaxed/simple;
	bh=78Y6qdBuxdoZB5z/lOJGCv+J5KFAp8tZOuulL/wS5qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQOWhvMnh8UBTi5rJmHePWCkeKzgpv3HyOpIqK0jpr7DUcU4KI79UQhIDS+rdkjsFsIDg4iSzLqjYCxW4f8CTC7W7J6VwLNbwU/bKIXoXE42vSQP/wDoknUacJ4lfEkaxTuRSlKD4kN7rpuvV/4L/jbc4AgbYX+E2RnFjBIR3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UATLF+8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2678AC4CEDD;
	Thu, 27 Mar 2025 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743102974;
	bh=78Y6qdBuxdoZB5z/lOJGCv+J5KFAp8tZOuulL/wS5qQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UATLF+8wJU1No+X3VpEpPPBx+NXQMjW8DmGkt8H5qpNpuf0IimMcPgFmJvycjGk+h
	 T5r9Hz5gtLqjF1L4DrtTJyksKdvZq4H8esGW+qVvQ6e4r1fCq9Me/TmHWA3jyncHG+
	 HRq+5QlrB/iJxb3MahgMsfEcnyN13wqL4TX5fAu8qlNoC27/TCNmCOhrAxIh4IQBi/
	 CERaaNA7fJpMzISMPAYFwliFuSYnm7gLS4NmgzbXG1JJM5ZJMYHdI7C6I9aFDr+ovA
	 tdFousiGQgdP8MXLYZpEQ8g8IcOKi9l3H9rtRpl9hGMonA3AcVoz5fr6WGJK/m76kb
	 yXlZI4T0t7zBg==
Date: Thu, 27 Mar 2025 12:16:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net v2 08/11] docs: net: document netdev notifier
 expectations
Message-ID: <20250327121613.4d4f36ea@kernel.org>
In-Reply-To: <20250327135659.2057487-9-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-9-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 06:56:56 -0700 Stanislav Fomichev wrote:
> We don't have a consistent state yet, but document where we think
> we are and where we wanna be.

Thanks for adding the doc!

> +Notifiers and netdev instance lock
> +==================================
> +
> +For device drivers that implement shaping or queue management APIs,
> +some of the notifiers (``enum netdev_cmd``) are running under the netdev
> +instance lock.
> +
> +Currently only the following notifiers are running under the instance lock:

I'd repeat again here:

... for devices with locked ops:

> +* ``NETDEV_REGISTER``
> +* ``NETDEV_UP``
> +* ``NETDEV_UNREGISTER``

Can I ask the obvious question - anything specific that's hard in also
taking it in DOWN or just no time to investigate? Symmetry would be
great.

> +There are no clear expectations for the remaining notifiers. Notifiers not on
> +the list may run with or without the instance lock, potentially even invoking
> +the same notifier type with and without the lock from different code paths.
> +The goal is to eventually ensure that all (or most, with a few documented
> +exceptions) notifiers run under the instance lock.

