Return-Path: <netdev+bounces-186818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF273AA1A94
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5519C0A5E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1522561BC;
	Tue, 29 Apr 2025 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2oS9D/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE52561B7;
	Tue, 29 Apr 2025 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950802; cv=none; b=TnMqaJpUctnf9SmFmzAz8mTq80hw9GetnIW92vC4oc/wXqtTeTn8/9HggUUYPQUstUtHSCenCRVAjQNRE7EcThGWiw+tbLwcq9E3rDLWzt3FJujgqsaOl/6T3vCwOFhvsAXfXeuYMsh+EgORQRw7XcyOpZYB2CEZn5HbFnRPsic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950802; c=relaxed/simple;
	bh=3IlaztnPua5p1rEn1Yfbk+GhYFDzcOleimvk5WzusRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jj0Gt3yCZgW2Yg5t9FjWG8LoGY+D6mLbBY6hJV22Sh6rOfOc8jWKlTtQ2EyUY0IaWcLMdDsjSxVtES5c2DE1ZFAIU9gYVhF2dncabVucmcyCoxUFmwc1u0n//mFACyxuckcbsg+V/adr04hFZ+V3I02AjKezXl3Y1WJKWwevJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2oS9D/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012A2C4CEE3;
	Tue, 29 Apr 2025 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745950802;
	bh=3IlaztnPua5p1rEn1Yfbk+GhYFDzcOleimvk5WzusRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K2oS9D/jqwQ+lp+pZISVoidOrtyfYXNQ/vccQlxiSKcDGlkdtpA6W172NjEpWuSWS
	 S+YbOhJyErL4uQgHpJJr/cOZe58zJZltd/WV9MH0JDKlj8OaXuZRb0CM9uxwlrS3ii
	 NPnKD2E3x8EJyPVu90gkLuvF4439yob/IWg2v5y7SRXCpAhLp8xUXAF0CJi6GUf3se
	 8VPOxLxZj/ZiRmsd4bwWI92lILmJ1xoC/a/chMQepe3mQoTYYkc+EZMV92SeXZ2wYn
	 uObqfwImV5F+Bvf6LkcTZc0JbI244o7ZRrAfkIUB5qQ+qp8SSDpT7FwpARikZaV5sV
	 3hw2prR6Ht5Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B593822D4C;
	Tue, 29 Apr 2025 18:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: ocp: Add const to bp->attr_group allocation type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595084074.1759531.13294818915548833067.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 18:20:40 +0000
References: <20250426061858.work.470-kees@kernel.org>
In-Reply-To: <20250426061858.work.470-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 23:18:59 -0700 you wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "const struct attribute_group **", but the returned
> type, while technically matching, will be not const qualified. As there is
> no general way to safely add const qualifiers, adjust the allocation type
> to match the assignment.
> 
> [...]

Here is the summary with links:
  - ptp: ocp: Add const to bp->attr_group allocation type
    https://git.kernel.org/netdev/net-next/c/5fe6530cd54b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



