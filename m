Return-Path: <netdev+bounces-188983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E38FAAFBF3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B367B8648
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840422CBE4;
	Thu,  8 May 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0SMHTTw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043BC13C695
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712025; cv=none; b=WGIUamHY2MsPsGk4RDmq3byJ1AWa9jPXGsw9izrb85Fjz+09EwZ00VnWnHmUaSfNu2pCJLH3lACwPOFI6eOSkRSj+0+kOu1YbzS5IB7K8sejwOaUG90raKD6a8ABCHDxCrCbM56vqgIac1rinh5wfdB+k//IZCo+RErRwQ7FEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712025; c=relaxed/simple;
	bh=kJDvjeDaSauDK6hVzmuzind8TuNrUUe75gumjgqPvZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtocvL9VvseMg/hWXGah4YoZnE3d0jP+idE2de3q/BwkltfMscgOEX7ac8l5+TYH4Us7MwRW0Cpv7KB3iyTEzK4XWJVzPqYm9DefkixJG9OI696at6ZxqDfDmybzqac9GrUwqBpm0463po0o9bpCLpezIb+oVjBklCw2VIAn9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0SMHTTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF29C4CEE7;
	Thu,  8 May 2025 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746712024;
	bh=kJDvjeDaSauDK6hVzmuzind8TuNrUUe75gumjgqPvZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y0SMHTTwTN0xp+LG7sUKplwaGZmIoWuAggbbNQln/zAs7KJP4FVvK79iDHPCCymiL
	 JTWBu9oKaoCVdRnUKGdrDI8ndEiJnWC9X2YN7zgj5AOjKaoHWTUiQzEd/yzGzKnxJZ
	 CS6WFIz60sip6xoBT2FizPIRVHBdHybF0pYLP8IdASUlvz52qtOER9Res7a+xW2e8O
	 pQb2hV6xUYLRsycXECC7nyR+OPJmqceomG9IlBhOH2wyQskmu2u/mfz/TDwmO9o7gW
	 1MkEWzy81vRMDj/jaV8V8z/C2YrSH+Q6sh3mg57Be8d4WM8u/+FvnbrtvxWOndwLnA
	 qiWYnGqyi9rqA==
Date: Thu, 8 May 2025 06:47:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1] tools: ynl: handle broken pipe gracefully
 in CLI
Message-ID: <20250508064703.5d488277@kernel.org>
In-Reply-To: <20250508112102.63539-1-donald.hunter@gmail.com>
References: <20250508112102.63539-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 May 2025 12:21:02 +0100 Donald Hunter wrote:
> When sending YNL CLI output into a pipe, closing the pipe causes a
> BrokenPipeError. E.g. running the following and quitting less:
> 
> ./tools/net/ynl/pyynl/cli.py --family rt-link --dump getlink | less
> Traceback (most recent call last):
>   File "/home/donaldh/net-next/./tools/net/ynl/pyynl/cli.py", line 160, in <module>
>     main()
>     ~~~~^^
>   File "/home/donaldh/net-next/./tools/net/ynl/pyynl/cli.py", line 142, in main
>     output(reply)
>     ~~~~~~^^^^^^^
>   File "/home/donaldh/net-next/./tools/net/ynl/pyynl/cli.py", line 97, in output
>     pprint.PrettyPrinter().pprint(msg)
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^
> [...]
> BrokenPipeError: [Errno 32] Broken pipe
> 
> Consolidate the try block for ops and notifications, and gracefully
> handle the BrokenPipeError by adding an exception handler to the
> consolidated try block.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

