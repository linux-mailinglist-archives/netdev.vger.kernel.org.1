Return-Path: <netdev+bounces-136990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E499A3DF1
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974BB282643
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9AC44C8F;
	Fri, 18 Oct 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRnXXM5J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D42032A
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253623; cv=none; b=rTZ5dbnneRCCobxmpmcfl5DqN3XB5I43S4t6PCL4WYS26Ai6VUcONHsMeR5Hij8U9nD05ZUyIG7+2f05AE76TtDp/pPKxmxs0rRRk+wycc5XH62JaC+6GdofX/NnNOkKzQhwPTlcLEuFlPCwxSvn8rU8lnntNtVhwAUXaVdD18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253623; c=relaxed/simple;
	bh=nvCMJjUR51IT1XTeirFucHMR82FxHl7qQ0HyGjgXv4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMf3fwxG6FmhJCqGAsUp4NwLeIGnFdGMQXr+PMYqakGmMjSJGddJ3n7SFZPlZPb+bHsK+Tz75I7ib7NQw4GUYk/NNfjXNkT6HWi/SIqbvk7ii6QA1YPS+OuXsXGvn6qzXVm9rxuOttlA6kh481+I80uHDgIhRuElD6oyxD9fQTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRnXXM5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9ADC4CEC6;
	Fri, 18 Oct 2024 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729253623;
	bh=nvCMJjUR51IT1XTeirFucHMR82FxHl7qQ0HyGjgXv4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRnXXM5Jj5Q4aKthZn9/KILpm+fCOCoASPoFaARNOqlraOSBt/Ya7iicKh5yZ1WVF
	 Buf9cpRllwyiWR1o0D0l7lq4jKYKIQc1qHOuWyP0jdJP55SqP5LsrTA2WLuoOohwk0
	 irNgvcAI3jVA5HTvNLIW9GrA9F6Z6sDciFh5HfkvvNUMCWkWe82DW3KkDynj6+lja3
	 0uhTCvIiZl4bkcO/olSV+CqfHZL//UKDRhMF9i5YFtR4CZu3DPCMW1IJa1SptZ+8aJ
	 6BjYpJKU0fyeAluoUQOW8yHK8oIY+uC7ihuKtML63eb8Wmpi8r8reKUADzNP5l8jyN
	 6F/DF+ys4Y3dw==
Date: Fri, 18 Oct 2024 13:13:40 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] netpoll: remove ndo_netpoll_setup() second
 argument
Message-ID: <20241018121340.GK1697@kernel.org>
References: <20241018052108.2610827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018052108.2610827-1-edumazet@google.com>

On Fri, Oct 18, 2024 at 05:21:08AM +0000, Eric Dumazet wrote:
> npinfo is not used in any of the ndo_netpoll_setup() methods.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


