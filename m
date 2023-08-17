Return-Path: <netdev+bounces-28307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1620777EF7C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 05:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D7D281D5E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8675638;
	Thu, 17 Aug 2023 03:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD449EDC
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85058C433C8;
	Thu, 17 Aug 2023 03:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692242426;
	bh=/yEcdP100SBCBIghsSFUglUe80bOrx6oFsLN/1Q5ECc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UIVS+4p/DN1mXluznLts8/VspWtZuBimWZu+2mGlPWzNup8OfEZC9N2e5lx+WlOhM
	 2FmyB6GL3uRJfJ2GltX1vPgaQ9OeSw9IsLI/GPVRFEN5tma8SuvS1wyJPOLOtIqTGh
	 4Noc3XFelLCJAug0L/Ikead4DZlar8mZshKroxEBtbeqdot/b8vWGKEaK/Dxfo59wZ
	 6PzFhsdzo1aPEj0BDVHe045dMPzxDwwLb0MsfyPjWJvsuVSI/xTmcOK5Ev+UvI1Fby
	 2fnrOFAN78fvyOvhtK547R+SHnda2xOAVycGqaC4mXH4TAZjo99Q5sIzuZzNGHjchO
	 KYfb8S4O5/deg==
Date: Wed, 16 Aug 2023 20:20:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: thinker.li@gmail.com
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org, pabeni@redhat.com, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com, sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH net-next v8 0/2] Remove expired routes with a separated
 list of routes.
Message-ID: <20230816202024.1caa2257@kernel.org>
In-Reply-To: <20230815180706.772638-1-thinker.li@gmail.com>
References: <20230815180706.772638-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 11:07:04 -0700 thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
> can be expensive if the number of routes in a table is big, even if most of
> them are permanent. Checking routes in a separated list of routes having
> expiration will avoid this potential issue.

Applied, thank you!

