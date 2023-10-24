Return-Path: <netdev+bounces-43961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C8A7D59CA
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B237281A09
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DED33AC28;
	Tue, 24 Oct 2023 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/SQZQvp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B872420F
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 17:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D868C433C9;
	Tue, 24 Oct 2023 17:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698168708;
	bh=C9FyShipTaiay0YmII6a1jcC5t2frEB8fyMPrZG49Lw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D/SQZQvpyTeCoa//8d154j+Y0t435HJzfGcoI9GdWuSRFeNyTZmTy17YpBleW3R+b
	 vn387QIYqU93uiZIJP1SQXrgKeM1jf3rOXI6ZOwv9GBzswnGZDW4E9LfIspNlCV3Wu
	 4Zm1EzpGaALjliKDtU8few6tOLWYqxGxoi2Omb0dHNe0mlF+TPeKXwWPVNhPiSK0zq
	 abK51CewuNj6/m6/FBL0xyhfTYchOVkhUr06j8lfC9EtPFn1T5vXyHPTSlMVTO2+DL
	 GfzOQn2q9m84nsAdELW1La9nH36p0YP331StGcL4unvKnOlhhLI34ezAFQbl90ytuC
	 B5JzrZwRrsg3Q==
Message-ID: <cb0d160b-42bf-40c9-ac36-246010d04975@kernel.org>
Date: Tue, 24 Oct 2023 11:31:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/15] net: page_pool: record pools per netdev
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
References: <20231024160220.3973311-1-kuba@kernel.org>
 <20231024160220.3973311-6-kuba@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231024160220.3973311-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 10:02 AM, Jakub Kicinski wrote:
> Link the page pools with netdevs. This needs to be netns compatible
> so we have two options. Either we record the pools per netns and
> have to worry about moving them as the netdev gets moved.
> Or we record them directly on the netdev so they move with the netdev
> without any extra work.
> 
> Implement the latter option. Since pools may outlast netdev we need
> a place to store orphans. In time honored tradition use loopback
> for this purpose.
> 

blackhole_netdev might be a better choice than loopback


