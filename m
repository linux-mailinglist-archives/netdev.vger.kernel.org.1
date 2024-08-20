Return-Path: <netdev+bounces-119968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77964957B07
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DF91C20B10
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5801798F;
	Tue, 20 Aug 2024 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/FKAQRU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA09E2CAB
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117744; cv=none; b=IRJzKjNDr8jDNe05T3bA06lfIDcZ/aO3C/74N8SODsTe7AWjGP3Rr/U0clOyrEf5BjsP8j3xBLAfLUP0qpRHM42foBdxbk/qtwH9tKug+scwsfa5P6eHrPCx0e2krVOv06uUFUJUd3xU3RfkohB4bpjiiptC8K6jmAPubpZHCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117744; c=relaxed/simple;
	bh=V8yf/ymqRrfJCcI1wxWwGUNU+4eeAGaSbmUKc2vN28E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBHjyUG/FW7jbk1DkSs0ekypovhbsIXdyMiEyXZ6lqXxhknB2PVThBKhwCdJJa4trUseySepNkCwprGDW6usMOOQlgchvtUzJqLvqZcj2IQUqTk1ervEH7J4BzKHJ/C+I3sYiqPDAgabN/9bwmGMcPNU6GjgOiTsiyT5u4gWfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/FKAQRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADDBC4AF0F;
	Tue, 20 Aug 2024 01:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724117744;
	bh=V8yf/ymqRrfJCcI1wxWwGUNU+4eeAGaSbmUKc2vN28E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a/FKAQRUvyLBXN6YDJoJUWaoXlGncgRdJFyh+1OedvMdJod+bViRb7dWnXIUB718L
	 BR92sdT3QQU+AzwrIbYYCd15ysUo103OnSC7PtlcvCogsw4tT6sY8vZ7ecmWp7bzI0
	 RVR/qCd3v1BJvFxmqi0vpXqFqUfW9jTDwOYtfOvs1uv51I94nMAe7+waGOKIv2Oije
	 DTrJlc/5C329nJJxU54uPn2kRZUeKnfwtCxstiBRyWllDoKUmh+Y/aMDg39UtwPsoG
	 kRcld6AZi1trIym7hjzaDA/ovTw3+0BLztgKgtzxtDciMjJmWOAGg/0dxkmpsAV3MD
	 Wmj7/adyHqvCQ==
Date: Mon, 19 Aug 2024 18:35:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Subject: Re: [Question] Does CONFIG_XFRM_OFFLOAD depends any other configs?
Message-ID: <20240819183543.64a1d7ab@kernel.org>
In-Reply-To: <ZsPw2W8nLR4azKLo@Laptop-X1>
References: <ZsPXnKv6t4JjvFD9@Laptop-X1>
	<20240819172232.34bf6e9d@kernel.org>
	<ZsPqS6oFNpRmadxZ@Laptop-X1>
	<20240819180525.5996de13@kernel.org>
	<ZsPw2W8nLR4azKLo@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 09:26:49 +0800 Hangbin Liu wrote:
> > doesn't resolve dependencies, it only enables that single option).  
> 
> I didn't get which "select" you mean here. Since INET_ESP_OFFLOAD will select
> XFRM_OFFLOAD, Isn't adding
> 
> CONFIG_INET_ESP=y
> CONFIG_INET_ESP_OFFLOAD=y
> 
> in tools/testing/selftests/drivers/net/bonding/config enough?

Sorry, I misunderstood. Yes, for the test that should be enough.

