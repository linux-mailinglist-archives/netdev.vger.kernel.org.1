Return-Path: <netdev+bounces-93920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9388BD94E
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 04:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2A91C20DCB
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 02:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE04A20;
	Tue,  7 May 2024 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ2keh2p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D14A12
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715047884; cv=none; b=Eemtazfhwbo59FN5+SjRyv3wQSNMKuJE+v+1DAQaqGkvjFmzTVP0RA2L26TzKIaxAsrJLt0K98ZDuKOMTZNOWcRo8yag5EbkngwfteQpS0bqw/+8d7tSt6D3sC3EPPsFyMQ+Nji5X3Cgmbar3KW47gGYkqCobgG0Xk6MUJ04ISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715047884; c=relaxed/simple;
	bh=VklxtigMVpLy/wemkOY5pVV1pqBo7jD/1AV/9pQ8rNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N17JEwiK/ZA2bgjyebxtRQm2dawpNmKF3QcU35fLC3Rew02Y0b3kqmzKRunW/iz1yZaZOkmEw+yfYox3C0fiNckezS+AEydjNKRvE0HXMss1ghV8UGE1M1bq2Gox0N+W/UE+n76uQvmkT1hDNlukUHl8SwU4lA6TXbz3Enmapx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ2keh2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F22C116B1;
	Tue,  7 May 2024 02:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715047884;
	bh=VklxtigMVpLy/wemkOY5pVV1pqBo7jD/1AV/9pQ8rNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DZ2keh2pHyywGrIxKKlPA4gG+XO1uaEcQlQ+wq5NSRqO43VfcZjh4NKl380INIhAj
	 GHPwjXaIN2Et+FMlaymD64ZuTlp9md9dmBoENq4Y3fAdRW/pwvZVNXAIeKX8t6QTQ0
	 qtLQ77liwcazQPlng1EYXLqtjGYl8jbul6uPwQJZj+3cvWA42313igzudIj8bmt8xs
	 DymRhfwLwW5gSeqWvBv8AC9Klpnqn+NFaXCLaSpcp3DNitDjAFj6m6IfF3jwyn/LwP
	 3Ge8TDcDbomAne+762Jr/poFNev8ck9R7dMsefYV7n/V7mCWQ/xgTjGUsVTiXCi4Qx
	 /eD/DnS5CZvzA==
Date: Mon, 6 May 2024 19:11:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 0/2] netdevsim: add NAPI support
Message-ID: <20240506191123.5dfc549f@kernel.org>
In-Reply-To: <20240502163928.2478033-1-dw@davidwei.uk>
References: <20240502163928.2478033-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 May 2024 09:39:26 -0700 David Wei wrote:
> Add NAPI support to netdevsim and register its Rx queues with NAPI
> instances. Then add a selftest using the new netdev Python selftest
> infra to exercise the existing Netdev Netlink API, specifically the
> queue-get API.
> 
> This expands test coverage and further fleshes out netdevsim as a test
> device. It's still my goal to make it useful for testing things like
> flow steering and ZC Rx.

Looks good but doesn't apply, could you respin?

