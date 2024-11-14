Return-Path: <netdev+bounces-144652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970389C80D0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF49281C73
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6FD158DB1;
	Thu, 14 Nov 2024 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ade21xMJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3072A1F95E;
	Thu, 14 Nov 2024 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551610; cv=none; b=Zix7ln1tUb38NPhlZuKYkl7jNET9wqBH90KproYZ5Ko9nW6vSAw85co+ZFGv+237TA48QLFd/e/osE5Fh0ULMOSKgtTbszKvAMws2SzsIyeT2QmGQf9rfKR/KU3pX53bt3pTkTViEs+tEy4Q6RnIk4v93xxQ4hl2plcuClcYCuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551610; c=relaxed/simple;
	bh=e/12JquSkTLwk0Bizr45OunNjl3XiNxztkpxtywRkYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeyLC4sIiSAhHTgXWLb+M9GswAUO/hiLK3JjnyUeFssIjRCLPz4sEq+d0k/3inc/Xva9KhA2R6nTnXl8br3Vju3wJENxav1eYH6kteJLDnonGHe6iw/6f7PhakCIycipifcgHb9etfaZxuiz/uao3G1IYTfTx5TfU4OIudHKyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ade21xMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AD6C4CEC3;
	Thu, 14 Nov 2024 02:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731551609;
	bh=e/12JquSkTLwk0Bizr45OunNjl3XiNxztkpxtywRkYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ade21xMJMB+LzS+uAM8zLAG4Sd0mzu4/sLyfeL5WylbFyBf7sLkbabsVVC4v7T8WO
	 Teh6yprgOS+4lfRT3SxEEaNW9cYwyzcDiWEw1doCTKDkcQBbECAY8Jz+BMTas2oA3O
	 N9YTZSqOoeyary4eef1bekWg9zP2zZ7ZCVHkGUPyY0FUq/iLzi6xHjcqu2XZhATJow
	 4O5wlru4OubpXzuA6oPWnVQfygG4b0fCO6+kpvvoL5lz6nCrjE6V6Na2APDIcUG9kE
	 2vpdkWAyu+X5Rs5SUnKDsYLBlrEqYeAgmjJ2mX4ApTGGXlAMJDtUoh25wiXM5zGO3i
	 IqfNsJgfABTUw==
Date: Wed, 13 Nov 2024 18:33:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, horms@kernel.org, donald.hunter@gmail.com,
 andrew+netdev@lunn.ch, kory.maincent@bootlin.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 2/7] ynl: support render attribute in legacy
 definitions
Message-ID: <20241113183328.58efabb1@kernel.org>
In-Reply-To: <ZzU40AtcsZzj7YuG@mini-arch>
References: <20241113181023.2030098-1-sdf@fomichev.me>
	<20241113181023.2030098-3-sdf@fomichev.me>
	<20241113121114.66dbb867@kernel.org>
	<ZzU40AtcsZzj7YuG@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 15:40:00 -0800 Stanislav Fomichev wrote:
> > In file included from ethtool-user.c:9:
> > ethtool-user.h:13:10: fatal error: linux/ethetool_netlink_generated.h: No such file or directory
> >    13 | #include <linux/ethetool_netlink_generated.h>
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> 
> I don't see any existing usage (or maybe I'm looking at the wrong
> place), but will spend some time reading the c-gen part. Worst case I
> might refresh this thread with more questions.

Could be the magic in the makefiles that tries to include uAPI
headers directly that needs updating.

