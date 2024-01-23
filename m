Return-Path: <netdev+bounces-65079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F0E839281
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308C328EE65
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A8C5FDB9;
	Tue, 23 Jan 2024 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH6IEXcc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991E5FDA8;
	Tue, 23 Jan 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023212; cv=none; b=WIGFDOD0Bty7NFfPc9NWPONtK9ZmqjtwDFat+wcdifLwyuP08dNlJb0EoOsj9nZ9AYF6Ov1A+LssQVBwnmZDz9lSEpm+A6D0RvDEhEbcr/9tp0cT2K6BnNCYo6S9Ojn6oI33qaC0baTnGAH9pgW2CW8fxfAosHWUYUjyqTZ5SlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023212; c=relaxed/simple;
	bh=y6Y3q7VymjvJulxs3xYJ+xTFgnItfIvzQuEUfNt7I7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJweFSJdsP12M40hj3e2ZjhlvChFhWiHGlGo3D5KhqWaUe1yJYSw2YvaeR26JD2Zb/mXJPumh2JGBJ0WUkD/oh+2+8MKIYYRxrRCEhUeR97vPe6v9opW3sbUyfmCOVkvEZGdesuvvuumZGZDivt8Kl/Cu9C9l7a8lGE5g6TzQq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH6IEXcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E598C43390;
	Tue, 23 Jan 2024 15:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706023211;
	bh=y6Y3q7VymjvJulxs3xYJ+xTFgnItfIvzQuEUfNt7I7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XH6IEXccyZnsDeFhUQOUUJHiQBLUhIC8PJbd94lKOOS8HkbYIPAOj0ps6V8xYw15p
	 pfnaZZD/3baZtJYfFJqM0lUhDOkMIN+JLoUd46hCdvWKR7ZLvrOvn9hMbo+E3Ksdcq
	 zMuOXxbqgzodoxe8zcyZ74z0glEfwpKmDtKqRVtmesFKzIKGe3y4QG8AMJMrnUXYJr
	 2XAZkIfCzn+nFqQ9Y4Rz6seii+PMS7BMTjVnPgan29oXMgu9SGPVUgy3BeMQsKch73
	 bXCGeFrKERNrhL72ZqxNO0q1f1qwXrzjzbrYtazjXn38EW4/PcXR7xstKzlcMuTqDo
	 IsoZF1ZQR3T7w==
Date: Tue, 23 Jan 2024 07:20:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240123072010.7be8fb83@kernel.org>
In-Reply-To: <Za98C_rCH8iO_yaK@Laptop-X1>
References: <20240122091612.3f1a3e3d@kernel.org>
	<Za98C_rCH8iO_yaK@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 16:45:55 +0800 Hangbin Liu wrote:
> > Over the merge window I spent some time stringing together selftest
> > runner for netdev: https://netdev.bots.linux.dev/status.html
> > It is now connected to patchwork, meaning there should be a check
> > posted to each patch indicating whether selftests have passed or not.  
> 
> Cool! Does it group a couple of patches together and run the tests or
> run for each patch separately?

It groups all patches outstanding in patchwork (which build cleanly).
I'm hoping we could also do HW testing using this setup, so batching
is a must. Not 100% sure it's the right direction for SW testing but
there's one way to find out :)

