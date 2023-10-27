Return-Path: <netdev+bounces-44778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FFF7D9B65
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 16:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B8F2824A5
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D63715C;
	Fri, 27 Oct 2023 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLw1AJyH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF053B7
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 14:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CCAC433C7;
	Fri, 27 Oct 2023 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698416925;
	bh=pvAlIgjUUqdF9V7h0tznOJsjCCDdWmdtSRxZOhkOF28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iLw1AJyHDn7R+rTWBw+LINZGzxu4ylfJ2zjSmzjGYEKM4Q+3f958buMA/pyt8dQWf
	 MtsUaMzhRHw4QM8gVr7OVOCNKC4J3t0jrhXe7mBJeWYbn566y/6HuR0Z9EnCbRMuU7
	 5cF5iLRlkvYNEIonCIYv5gYxQhQ6JUKGbT5qq7i7ZpZM+Jhih6kqdQlTWYjQv5KtcZ
	 TRsc2bpzmi3GkMlUbAIkWNoW1BscwhhmfjABCg4gWN6UYuW7l1ApnmKf+VHKyidOH0
	 bqxiZIKVEYkiec+8iPoIOW8C+/D4T1s2nHLiwe7KGW6kkhBwdJKTdP8kB/go3hWNi9
	 pd8aPp3dpgF/A==
Date: Fri, 27 Oct 2023 07:28:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jonathan Bither <jonbither@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: fill in MODULE_DESCRIPTION()s in
 kuba@'s modules
Message-ID: <20231027072842.41c4ca60@kernel.org>
In-Reply-To: <323e1669-e145-21bc-a124-923303ad2138@gmail.com>
References: <20231026190101.1413939-1-kuba@kernel.org>
	<20231026190101.1413939-2-kuba@kernel.org>
	<323e1669-e145-21bc-a124-923303ad2138@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 10:15:02 -0400 Jonathan Bither wrote:
> > +MODULE_DESCRIPTION("MediaTek MT7601U USD Wireless LAN driver");  
> Did you mean USB?

Ah, I do, thanks!

