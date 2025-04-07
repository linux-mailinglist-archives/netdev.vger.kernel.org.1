Return-Path: <netdev+bounces-179788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C68FA7E84F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794C31769D1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2921C17D;
	Mon,  7 Apr 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM5acAFa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BB21C163;
	Mon,  7 Apr 2025 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046984; cv=none; b=u52XnjRFFmyUH0cbdwPQP09WE0Xf2YtxQJkpjnw6a56AgY3p7LEtXdQ5GnpZRJJ1x2U4jNqrE1EDBsmY/Axk+noNh4QnfGt+1KQPxMYHCHAauBrPFEgU1MQNLrAMyV92U4u12G/+auxBZKks0qEq+m5KiHnfWJLkhlvwwIaX2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046984; c=relaxed/simple;
	bh=40hG6O9bHbt4mq4rIG6FS5DBlcQ1hD3Fc0NtEd9xm2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROpv0kSeIRYsevFOadGum7qyAlWZ86kpmFvbzcCLo/JyRCFGW7DzTHD7dhC0lwZc8xvqwX7+9QpycbdL1a/RHyWpcIBsFpfEXctX9cBZtB3DbGRE0BzLFsfGCSYoyMJfBdTTRtbSImHIMSZWRvdgLgpNmFTktdium7JThYkT9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM5acAFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B5AC4CEED;
	Mon,  7 Apr 2025 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744046983;
	bh=40hG6O9bHbt4mq4rIG6FS5DBlcQ1hD3Fc0NtEd9xm2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AM5acAFah7Nu8oz/z0TcWFsRYk+JKhhpYu66P22ntue2yaoUukRMRVZeiLWypxloG
	 u1oBq+5xWCt++25okkzV5N/dUF77uExfQXvKbe3vy8UaF+OtKz4WyO5HkMXL+Ca6LZ
	 EM2Mxro6mHVC9UlUfEFctBt+aNgi5pRMmUDlQuJvp5HXh1WwwYQI1s4jgYoUQWvBmf
	 YTWGnbsxR9TLWnIq1MnpRwGcpBx8VG/v9zZ6z6+afKs5VUXFHaM3mUSDlTiiUN6Nal
	 5xbsI8KGPz0F4GOxbmB6QF9XQ1yU99/Z11y8DlcWcdadyXl26ybcJccoVd3dnNzxkL
	 +mGRv+mQhlIaQ==
Date: Mon, 7 Apr 2025 10:29:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: <netdev@vger.kernel.org>, Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Simon Horman <horms@kernel.org>,
 <linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>
Subject: Re: [Patch v3 net-next 0/3] Add support for mdb offload failure
 notification
Message-ID: <20250407102941.4331a41e@kernel.org>
In-Reply-To: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
References: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Apr 2025 17:29:32 -0400 Joseph Huang wrote:
> Currently the bridge does not provide real-time feedback to user space
> on whether or not an attempt to offload an mdb entry was successful.
> 
> This patch set adds support to notify user space about failed offload
> attempts, and is controlled by a new knob mdb_offload_fail_notification.
> 
> A break-down of the patches in the series:
> 
> Patch 1 adds offload failed flag to indicate that the offload attempt
> has failed. The flag is reflected in netlink mdb entry flags.
> 
> Patch 2 adds the new bridge bool option mdb_offload_fail_notification.
> 
> Patch 3 notifies user space when the result is known, controlled by
> mdb_offload_fail_notification setting.

You submitted this during the merge window, when the net-next tree
was closed. See: 
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
Could you repost so that the series will be re-enqueued? 

Thanks!
-- 
pw-bot: defer

