Return-Path: <netdev+bounces-104568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9652B90D59B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF6A2817FA
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F7618A921;
	Tue, 18 Jun 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVveqj/4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194316B395;
	Tue, 18 Jun 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720672; cv=none; b=e1BPvdi1HSMJ/OfmTktXRQPVwVqEicKXENOpuIXb3Crhx8n9B0eU8l3vzpF0s9OkOjlw8dVfdIQX54sCnV1MIWE/8KiDbQJQ4CzFTW7sLlcL0ayt+zyyzs6UXVUHdeGtxpcp/Rp/IgtTiqImBPe4BmR8nZ4W7wukynWy77tQHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720672; c=relaxed/simple;
	bh=XJaxKfakBj2xmYbwmIeCGAhkFD8WfczsO6zg20M7L8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4nbjH2fSTbh2Q8YKxYr1BU44QK3tgpY65teExBCV+WDByGFgigtuQHYqEo/AngpImqoYuyZMal54p3V8xv1yqou/ZdgFO1uByJwPCp9yqbqXHFNtRz/5vEwL8LSKa7wQjJnwoVgIHrA1qb89lacnj1qY3pRAGp8vMt8zttAuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVveqj/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E24C3277B;
	Tue, 18 Jun 2024 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718720671;
	bh=XJaxKfakBj2xmYbwmIeCGAhkFD8WfczsO6zg20M7L8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YVveqj/4oj2Rrz5WOc5yXnQK6JB3a36bZ6nffPeCbFuZu1OPXAROXm+xuqF60+gg1
	 E0lE84F1tvCnFwOBCbQeHCB0PfUvLTNxQQs4zZIcKn3/MWOxB1nHyFZsyi+t5gSyRL
	 r5oNZs3ZcH3WtkeE7B75RuEJspc65IGediScheTqdSusIrbK2pMCAleYxXcu+ZFXJU
	 iJ9pNHBfGsm3g/K0XeiLvT52jIwzLs9VUTffJi7Z+sY+dxieT56IkseMckQJGvJUBq
	 kS05BEem/ataqdNlGs+iohT10q7w1DAjN5kBc/icrJ/JvJ9+EKRkizLCTImHpL59hs
	 BdZ4kf9UmcfbA==
Date: Tue, 18 Jun 2024 07:24:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "jiri@resnulli.us" <jiri@resnulli.us>, "horms@kernel.org"
 <horms@kernel.org>, "rkannoth@marvell.com" <rkannoth@marvell.com>, "Ping-Ke
 Shih" <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v20 10/13] rtase: Implement ethtool function
Message-ID: <20240618072430.4ff15980@kernel.org>
In-Reply-To: <0dbefc7d70b4453c9a280a0a63a7c89b@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-11-justinlai0215@realtek.com>
	<20240612173505.095c4117@kernel.org>
	<82ea81963af9482aa45d0463a21956b5@realtek.com>
	<20240617081008.1ccb0888@kernel.org>
	<0dbefc7d70b4453c9a280a0a63a7c89b@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 07:28:13 +0000 Justin Lai wrote:
> > Are you basically saying that since its an error it only matters if
> > its zero or not? It's not going to be a great experience for anyone
> > trying to use this driver. You can read this counter periodically from
> > a timer and accumulate a fuller value in the driver. There's even
> > struct ethtool_coalesce::stats_block_coalesce_usecs if you want to let
> > user configure the period.  
> 
> As we've discussed, as long as this counter has a value, it can inform
> the user that the host speed is too slow, and it will not affect other
> transmission functions. Can we add this periodic reading function
> after this patch version is merged?

You'd have to remove reporting of all 16b packet statistics and 32b
byte statistics completely for now, and then follow up adding them
with the periodic overflow checks.

