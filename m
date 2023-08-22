Return-Path: <netdev+bounces-29493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CD7837C6
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 04:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EB11C209DB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 02:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F64B1108;
	Tue, 22 Aug 2023 02:11:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3A10E9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B23CC433C7;
	Tue, 22 Aug 2023 02:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692670274;
	bh=qKpcYTt70Uys3syO2Gl3O3ERY9q0s2Fqepl6Jss6024=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MPFRXzUJtd18u97W/wLhEND0SCQ855lN4Ii7He8HwHGCkYWzXhmO+7rOEG6RGW1HX
	 AQVo+SpDphN9gQD5smpo7JZRBzFhSy+4tFVACTv/1iZbhaA5KYsJYpTcoy0bVmSED4
	 2oAGOMYuVZNdKfunHx+GEmZfqmcaHtVy9mhSGXKgg9MivZYjam/HIlpOG20UJ1O98K
	 3jlBHC/lRVCrVCysEjAke288sKUUF31k9KFcbUiNJHYsImI4FxTs9HtW5P3uMb07H0
	 irhpv7FubvAF4Ez3rGgeeaM71sHYftYrUCMh8C77zohCV3XMfgvjp2Y2bv7gOiWaQk
	 2+GPzlv/U8wEg==
Date: Mon, 21 Aug 2023 19:11:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net] net: Allow larger buffer than peer address for
 SO_PEERNAME.
Message-ID: <20230821191113.72311580@kernel.org>
In-Reply-To: <20230819005552.39751-1-kuniyu@amazon.com>
References: <20230819005552.39751-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 17:55:52 -0700 Kuniyuki Iwashima wrote:
> For example, we usually do not know the peer name if we get an AF_UNIX
> socket by accept(), FD passing, or pidfd_getfd().  Then we get -EINVAL
> if we pass sizeof(struct sockaddr_un) to getsockopt(SO_PEERNAME).  So,
> we need to do binary search to get the exact peer name.

Sounds annoying indeed, but is it really a fix?

