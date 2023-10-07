Return-Path: <netdev+bounces-38718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9D27BC34F
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 02:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF1B282138
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F83F197;
	Sat,  7 Oct 2023 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQybc0O0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C411FAB
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 00:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D48C433C8;
	Sat,  7 Oct 2023 00:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696638631;
	bh=qku4TIqBIeR0rMEANa6BdOWeqlBDvb7TPU0kzcdjERE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QQybc0O0C4H0SdKmbLe7VzodlG9ynlOhKBdsUkqq8TiWHz3Tg/f0Up8HUIMp2HKfS
	 97sGCF+uTHa+77XTLZSV/2Y8UKAmcHf78mG/UrfIyTfecWHcVVOPpeE+iok62Jx+N2
	 6w+x+VHn4zFG/ty0jp/myIBm+HNCguc/DbBdArr9N+HqXXraMTOjAbDGGWh9IJUYlY
	 DT2rQO7zo2R/4rpI4HaxLNIV/w5RqWNHRabb1tdBCCaPeE1+Foq0Asmcc9IzOX2I1k
	 TFUNOgFT9k/WSBs27tuvEz70ZysoSBhQdyfOxDd27QBPfUts/6IDP6BjgQpSeeVWV9
	 USX+gqddfhsPA==
Date: Fri, 6 Oct 2023 17:30:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, alexander.duyck@gmail.com, fw@strlen.de, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 0/3] add skb_segment kunit coverage
Message-ID: <20231006173030.4908a356@kernel.org>
In-Reply-To: <20231005134917.2244971-1-willemdebruijn.kernel@gmail.com>
References: <20231005134917.2244971-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Oct 2023 09:48:54 -0400 Willem de Bruijn wrote:
> As discussed at netconf last week. Some kernel code is exercised in
> many different ways. skb_segment is a prime example. This ~350 line
> function has 49 different patches in git blame with 28 different
> authors.
> 
> When making a change, e.g., to fix a bug in one specific use case,
> it is hard to establish through analysis alone that the change does
> not break the many other paths through the code. It is impractical to
> exercise all code paths through regression testing from userspace.
> 
> Add the minimal infrastructure needed to add KUnit tests to networking,
> and add code coverage for this function.

Apparently we're supposed add descriptions to all modules now:

WARNING: modpost: missing MODULE_DESCRIPTION() in net/core/gso_test.o

