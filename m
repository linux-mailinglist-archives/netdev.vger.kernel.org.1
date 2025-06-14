Return-Path: <netdev+bounces-197789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E245AD9E4F
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239F61756A1
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179E01A08BC;
	Sat, 14 Jun 2025 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijZ/RaAs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A71802B
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749918333; cv=none; b=qAhPQaaYW6rPpZcnn4d+TuENP8+xuYFyNDCxXfqhUWNF3fOl9MEzyHJuNXhhct2eCGh+VlRbNlqdk7A+xfB6nUWVNVnlWUumaF7oZYj8AJqrsDH1aN5542AfLMQ3yRbwONOED/Zb0KLKC8mqn028BozdVRw2qLOUa4usZRjVK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749918333; c=relaxed/simple;
	bh=ap4K8YCdQM57wDVU0dI0R0Zw/KtxgfzFuyj8Zdzx3MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JduBH9svJFJytYAKmDoLGxqAangspKJ+gAwLKA0si3FjzGpBOkLZePf/wN87AkqhB28Sgfdf5aZnhPmcLN8WTX5iTAML6O9xbib6nir2BWUsFSmhV99Z1ZADC5OMRAder8XcD98stCxKWaE1X5G8HRRZ6w4JMjre/scXOVTaLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijZ/RaAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B9BC4CEEB;
	Sat, 14 Jun 2025 16:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749918332;
	bh=ap4K8YCdQM57wDVU0dI0R0Zw/KtxgfzFuyj8Zdzx3MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijZ/RaAsjEC+nILVTzcgoKo5B6rcKBQTqN9Qov6/IjrlR3n4iXmMvhFWVhdQKaInc
	 KHshV9DDbyfzSb+GgKw2VW/pCmPotl2gJWRYWeQWlAcy9OCBjlRG4lSIVmhRUeozEn
	 M8TXn1XtB+855xPjv7m472UtbkPF/EpJXMAcuYoYQMzK5FcZm5gcqNprEHrK5PQqGj
	 kxTPwtJKC02esst3y35mw+ZMIBt/VXnH2giclpNiL07ZgXPqZr+zXaLVhcXASq0HWJ
	 TrIF6IMxYLkQQg7ZcGJ046pD/5V7Y1/sAypayIp08FmwjB7GXn0I8iklfQ3veqqA/d
	 pCkO3QHBC86Dw==
Date: Sat, 14 Jun 2025 17:25:28 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] selftests/tc-testing: sfq: check perturb timer
 values
Message-ID: <20250614162528.GS414686@horms.kernel.org>
References: <20250613064136.3911944-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613064136.3911944-1-edumazet@google.com>

On Fri, Jun 13, 2025 at 06:41:36AM +0000, Eric Dumazet wrote:
> Add one test to check that the kernel rejects a negative perturb timer.
> 
> Add a second test checking that the kernel rejects
> a too big perturb timer.
> 
> All test results:
> 
> 1..2
> ok 1 cdc1 - Check that a negative perturb timer is rejected
> ok 2 a9f0 - Check that a too big perturb timer is rejected
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

