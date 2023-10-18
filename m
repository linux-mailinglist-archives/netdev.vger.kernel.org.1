Return-Path: <netdev+bounces-42074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C9F7CD13C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 02:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D3BB20F4A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 00:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1B39B;
	Wed, 18 Oct 2023 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew8nsr/c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F6A49;
	Wed, 18 Oct 2023 00:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80D3C433C8;
	Wed, 18 Oct 2023 00:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697588551;
	bh=1ILIudyutyqZMoLATDL7ktSJVKE0d4FEmyHMN6PVyv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ew8nsr/crp6mvSPZsT9b6FvTqZJ3I1MknEdLUAoEtQr9yozMAX7djc/6Rl35YIvyx
	 JiRcLMweJCI8OXEKoR+WB6YKVBMyufhZV6UDRz6ppNMCwerS0zPpqnx12EOy9uCt59
	 s903rRG6Ouwx7ivk0GZwMuLL0G/55PvDEwyGac/uUBG+KjNp7dWoXaSO5v6L7+RfN0
	 b6dC18FrB40qt06ewalWwYsTXTU3ddkea/gbsv+7JZQdzw6SMK05RS36xCQJ5LevM1
	 qGst42zsQLKKazxd0GOlgwDMdWF4P7zQ0f/RrwNt9/Xn7lRTvbKP5vcuzcmUHhP1Mb
	 Pi8qIa58O/GDg==
Date: Tue, 17 Oct 2023 17:22:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
 linux-wpan@vger.kernel.org, Michael Hennerich
 <michael.hennerich@analog.com>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>,
 Rodolfo Zitellini <rwz@xhero.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 01/10] appletalk: make localtalk and ppp support
 conditional
Message-ID: <20231017172229.582c58d8@kernel.org>
In-Reply-To: <20231017172202.71c8dcf9@kernel.org>
References: <20231011140225.253106-1-arnd@kernel.org>
	<20231017172202.71c8dcf9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 17:22:02 -0700 Jakub Kicinski wrote:
> Hi Arnd, the WiFi changes are now in net, could you rebase & repost?

s/net/net-next/ to be more clear this time..

