Return-Path: <netdev+bounces-75415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977C869D4A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A79290C2A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9E62C6A4;
	Tue, 27 Feb 2024 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAgcVODe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE51EB5F
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054030; cv=none; b=iItydW/e22vogPXJkm2AknH6OIEXVNZwxXv9q08MzFWXur7P0amwHhq/4WDSNPNoTPX7BRy8Gt4iA8khQAtdBAnsyYN2h0UVaqEciopHKWAFgw6dMT6ILng0Q3hFY3S2Kr1J12iAaWlvaEQ1m4g6QEyUyqEx/lT1q5BGiSOYOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054030; c=relaxed/simple;
	bh=JcHPyItt/T5I7WiovqvG2X7EZZArgjEELVxg+LuGcEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCXPVctxPpHUW5yVBFqC8D64HFIPawSkUesNMMcd0yttAn+ZS//kK+RPQSYUtN1t90WYKI/Znswx0ewZ9pSjFkYZzl5RX0HBhyKKarkyxnRVOXLXCFpTtojl5oBP1fpuF7NP0s5ijYUQEpYIJdG8ViuSWgWRQuamUiJsaHJR8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAgcVODe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4E5C433F1;
	Tue, 27 Feb 2024 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709054030;
	bh=JcHPyItt/T5I7WiovqvG2X7EZZArgjEELVxg+LuGcEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FAgcVODet6y/839eauxuEFJtp2h3uZM7VqyPNS3glAw7K0/DKY7guqFsrN3IsIZZY
	 CKeGrCBJ2bQn/rUcH4TsPqvtIe0fqaOE5r/7Ly7q5/O1gbLOhasdUpDAXdYDw0rtRY
	 MXHmv3CGjob4mbhvt6fhy7K8KFhLhp3XqHpPB69gXfi1BbBmWnc4HO//v5N14/59rX
	 5swwmrmaqpGSrmg5Nr9VzJWKKd5DSjsGInwdkdXYEwYXGlQmW8LOVcVbRQ91kAr/EB
	 RWVYhQtpbz1eE1AzTRgUidXXLh54HWf5h89W38iYxAHQQ7KPXpM2GNXu1tuxsJeL3g
	 ET/wMG9ytjE1w==
Date: Tue, 27 Feb 2024 09:13:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [RFC net-next 1/4] doc/netlink: Add batch op definitions to
 netlink-raw schema
Message-ID: <20240227091348.412a9424@kernel.org>
In-Reply-To: <m2zfvlluhz.fsf@gmail.com>
References: <20240225174619.18990-1-donald.hunter@gmail.com>
	<20240225174619.18990-2-donald.hunter@gmail.com>
	<20240227081109.72536b94@kernel.org>
	<m2zfvlluhz.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 16:52:40 +0000 Donald Hunter wrote:
> > I'm not familiar with nftables nl. Can you explain what the batch ops
> > are for and how they function?
> >
> > Begin / end makes it sound like some form of a transaction, is it?  
> 
> Yes, it's handled as a transaction, containing multiple messages wrapped
> in BATCH_BEGIN / BATCH_END in a single skb.
> 
> The transaction batching could be implemented without any schema changes
> by just adding multi-message capability to ynl. Then it would be the
> caller's responsibility to specify the right begin / end messages.

That's where I was going with my questions :)
Feels like we need to figure out a nice API at the library level
and/or CLI. That could be more generally useful if anyone wants
to save syscalls.

