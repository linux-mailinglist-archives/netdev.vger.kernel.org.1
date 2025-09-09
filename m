Return-Path: <netdev+bounces-221381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B8AB505D4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE50E3A6C97
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCBC302760;
	Tue,  9 Sep 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmjMGkyI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9C3002C3;
	Tue,  9 Sep 2025 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444666; cv=none; b=gGS8vhEYFzXRlC7Udi8T84qcXwYVOqRQmApRpzjyVQtv9P0s8xTqgIkyau2gUQcDq3SsvVXh94DjX5okGM9YJIkw45okBlfq3/rKvcw4NAZF4P2M7SipGuhTFTCJ68h8Wx1A/ny4aaiqL1rjdwTtRmIEyjISxssjUjIMsmyA+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444666; c=relaxed/simple;
	bh=SUeQ7HwX00Wm+MAXVlX7FhoCnZHSaqLs8qCsarfPXaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxja63/uIyrAXMMP431R4HPYtjRH1hq/m6bNGYQJxLWwtylJN4s6/92BU7Xfz2d0NaoLv7cP6zPVIIsIc4a1X2IC9aGgd/ybQd0XLQOsKGxq7+xo/sjuMKcmRh6GeSl4YLIaMVXhlyr00AlI3BmGlhfqSXOPzGdzHWqtSEKnk4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmjMGkyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06100C4CEF4;
	Tue,  9 Sep 2025 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757444665;
	bh=SUeQ7HwX00Wm+MAXVlX7FhoCnZHSaqLs8qCsarfPXaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmjMGkyIFYDJxwqhAhpoM4Do8Kju/HoCYkdixxatIzsmt59kMUz0afrBqP4qa/waG
	 dDNNxga9OhZbYdqqTL0dbB+bkHrq/tYs06Qxvndo3oWzXUXL0MeaDn1ZzHhL0t6xhr
	 uTWQqDU4qGZOXduWjEGwk5zSYAKG+Gh9vyUghLVfJmCIG5UOgCS3X7LR9TsbWcDgSp
	 TQi2NWgiBqjDklfEsQX1uDWQqFyUfPZCHKsubQs4/DX8ReYIkjXK98O7qoW/lML7W9
	 /R2irpbO31dhc5WN9e0ri1yJdSZOZiifRkhAA9yLjO6wo1RGUF73OZ9FfjPFk0Stdf
	 NEQlQUvkGtenw==
Date: Tue, 9 Sep 2025 20:04:19 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/3] selftests: mptcp: shellcheck: support v0.11.0
Message-ID: <20250909190419.GF20205@horms.kernel.org>
References: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
 <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-3-5f2168a66079@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-3-5f2168a66079@kernel.org>

On Mon, Sep 08, 2025 at 11:27:29PM +0200, Matthieu Baerts (NGI0) wrote:
> This v0.11.0 version introduces SC2329:
> 
>   Warn when (non-escaping) functions are never invoked.
> 
> Except that, similar to SC2317, ShellCheck is currently unable to figure
> out functions that are invoked via trap, or indirectly, when calling
> functions via variables. It is then needed to disable this new SC2329.
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


