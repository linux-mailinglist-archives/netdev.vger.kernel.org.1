Return-Path: <netdev+bounces-117856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F394F8F9
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381DF283B0F
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EB014EC59;
	Mon, 12 Aug 2024 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfxpM+Ow"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF554759
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498254; cv=none; b=H1OEyeuVMxqyzIuij1trMM5HcN/rXzROv/h+V2aY+0rCcdwd4F5TbmDD2fJ0DRmVcGlDtJo+UBxFvvEMSzkAx0YWe8i17v6AdhLYOtcFyZD1XyIZP6pNoMjqYuJ1KS620GxUE/ipertLbwsLWfV23D9Vo0cokFQ0XSDh8BWbv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498254; c=relaxed/simple;
	bh=bail6VLDd5MGn5dPaD0cau2CnlFEwTwmcJ6TZ3zMRZo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UzNpHyIVfRgvcBcB4HOGI6q47nfgqxL6Y2sCErjGffYzKhmHJ52t2vPkd4ytQPci6c2VzPjyAs3Xy3sV+tEPRY3SgXkADu3z3/lpZ+cEMf/YZKmnhxDlsNlp78zVjEQzXj7WuoJ8rj3pBahVFt+eB2qLPrMDBlrN3d1pQYMY1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfxpM+Ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31058C32782;
	Mon, 12 Aug 2024 21:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723498254;
	bh=bail6VLDd5MGn5dPaD0cau2CnlFEwTwmcJ6TZ3zMRZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VfxpM+OwKNEdZya5Pte3xQx0RjuIsDGIbVSMfQE7Nn6eoYPB7ydomX7C7xXZDHd3O
	 6JThk3Aa/S58+oEVyLkcC8PqPjdEZxqebvF2VzHFKluGdHzV+Fu7Hd2KBYxNp4XHdL
	 fvFK/afmbXnFFEm4cnFvlS/gqkkUs2/j6T2e2hPkbOMno5YZ9aUuMpC7eY132o8AJp
	 TdmkQzjfEU1o6C6hnK1ltzbLbA/W6dn/tUthdChcpHym5QPKbGaBquHgsz1Q1RJLkh
	 TGd6NuKPGQJq2P3uaY97HHCYDB36DgFePEkz8/0PRdR0VVyuH/vP6BUDUfm8+6FLGS
	 rFwehFipsGRiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E37382332D;
	Mon, 12 Aug 2024 21:30:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] man/ip-xfrm: fix dangling quote
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172349825227.1144807.709460668728268649.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 21:30:52 +0000
References: <20240811164455.5984-1-stephen@networkplumber.org>
In-Reply-To: <20240811164455.5984-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, leonro@nvidia.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 11 Aug 2024 09:44:46 -0700 you wrote:
> The man page had a dangling quote character in the usage.
> 
> Fixes: bdd19b1edec4 ("xfrm: prepare state offload logic to set mode")
> Cc: leonro@nvidia.com
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  man/man8/ip-xfrm.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute] man/ip-xfrm: fix dangling quote
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=6d632bbcda73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



