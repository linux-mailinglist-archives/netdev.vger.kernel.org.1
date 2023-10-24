Return-Path: <netdev+bounces-44039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8807D5EA4
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E342819FA
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B37D43ABF;
	Tue, 24 Oct 2023 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnWeDlzt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1152D633
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 23:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC18C433C7;
	Tue, 24 Oct 2023 23:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698189837;
	bh=4LWi/VJEYYDswMPq2df7WDZz/rTvtg1tTAZKDHyw/MQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XnWeDlztLIsos1c47TVUYD8Lr+1keyPM5ndQS3u3tmAhE2ewlfEkWy94vr07Q6d3W
	 TiQQLR0nSV6k+V6BudorGi2BVMTPxiR9HEmTvtGRbI5WbroJRxHIaLGcHR7EWLW9mz
	 bqajcXZAuQn2OTbPT2VMChPNFMH15vAS0/lolqFECV/8flpZ7UCyWp60Epq+Zn57nm
	 ObHVdFTUfMOO58CQ19K/SgTFLbI/xbR6XbSvPqXDIFpWOP7TLtodVk3Jcip25yy7kD
	 XLNI861DBHahkhBqkSQcCesFh9cC0YMg6zye1o87c73kI4IqcC+KbIGZ959QnIWnXd
	 Kq8ILyqxN5d4A==
Date: Tue, 24 Oct 2023 16:23:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lucas Karpinski <lkarpins@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: give more time to udpgro nat tests
Message-ID: <20231024162356.6caf5cdf@kernel.org>
In-Reply-To: <t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzrzkwtj@toz6mr4ggnyp>
References: <t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzrzkwtj@toz6mr4ggnyp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 15:50:33 -0400 Lucas Karpinski wrote:
> This is the same issue and the same fix as posted by Adrien Therry.
> Link: https://lore.kernel.org/all/20221101184809.50013-1-athierry@redhat.com/

Let's not let the hacks spread.
We suggested two options in the linked thread.

Another one is to explicitly rendezvous the processes - have both sides
exchange a UDP packet or establish a TCP connection after setting up.

