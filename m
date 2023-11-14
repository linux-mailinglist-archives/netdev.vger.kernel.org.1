Return-Path: <netdev+bounces-47830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB557EB7A1
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20D81F258F7
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DED35F00;
	Tue, 14 Nov 2023 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3p2RH03"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F726AD1
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 20:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87C1C433C7;
	Tue, 14 Nov 2023 20:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699993011;
	bh=8mmL3I3erEwwdl8wOfZypEEHw8UywftF8yDJWg/57kM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M3p2RH03l1i6INY0wbihE+Jde/WWCLYu7RCYouEgYsVe8pqVXx5qbivbIlnThfgNs
	 c2e8Le2gNfZXZHHcM2JhmuWOhMsCKu2nx6MGLyWjYkDOpNo3ABSu7YQeF4yGTyWTcu
	 O45GOQUnyunGrJVcutsbdFGm9a063bhoEmVBQ9WMtC6thEf9WU4pSUL4BYy4Fmzav7
	 2TFh0x/NyFFi3FWq2RWoyBsNRb/6iIQV5RMcf7D6605ezwP4kLfJxrLHhi+1eVIzH4
	 nLaleIpKIcY9B6OZ93ZiCFqMowPzecuinhoS7JGc0UFmAMMtgClWD62JFFMdPdr7L0
	 fPh9wHDHn1t9Q==
Message-ID: <0fe29f0c-5418-49a6-ab62-f210f8f7e765@kernel.org>
Date: Tue, 14 Nov 2023 22:16:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: ethernet: am65-cpsw: Set default TX
 channels to maximum
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com, srk@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pekka Varis <p-varis@ti.com>
References: <20231113110708.137379-1-rogerq@kernel.org>
 <20231113110708.137379-3-rogerq@kernel.org>
 <20231114121343.o3nk3lddzy57mqgw@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231114121343.o3nk3lddzy57mqgw@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/11/2023 14:13, Vladimir Oltean wrote:
> On Mon, Nov 13, 2023 at 01:07:07PM +0200, Roger Quadros wrote:
>> am65-cpsw supports 8 TX hardware queues. Set this as default.
> 
> Motivation? Drawbacks / reasons why this was not done from the beginning?

Motivation was to get the "kselftest -t net/forwarding:ethtool_mm.sh" test to work
without requiring additional manual step of increasing the TX channels.

Another issue is that all network interfaces (can be up to 4 on some devices) have to be
brought down if TX channel count needs to change.

I am not aware why this was not done from the beginning.

-- 
cheers,
-roger

