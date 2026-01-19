Return-Path: <netdev+bounces-251189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913A6D3B2FB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B773312D0D1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE48732ED2E;
	Mon, 19 Jan 2026 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekaV+yxZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57B32ED2C;
	Mon, 19 Jan 2026 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841304; cv=none; b=tLc79xT3kGiWXPHxuKEzLPsHpc/kIJ/rz/qA9PmpWE+/Zh8Bd5cRLjQQnCP0lt1bouwB5YQJupy7iAgNS1ejs/uNY2uERvWxOO1IjVOspPn3tTMT/fMY3fN6xH5pUJgrlulXjuatwoyJhdnmKwsYsMLIoBFu4HTJRm4ko874570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841304; c=relaxed/simple;
	bh=FsHQ9qlTxxYa5NDTX3USAelpH419g21o139xDdfBEC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBNb0YgS+Rl/vID62iD/dyBOcrM2Ha0bAZxezGgyE9IfXp4Uv0rF46sGN/HXDZESjuTTOFCNVcUQenQlBp+/xLwYfU/qw2VhTx4poFr66Ql/5bZlmcI2HTdPDm6kB9HY20woAAWcZEXjTINXmtbM6BwhUSma5NhdaXztemfmH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekaV+yxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7868C116C6;
	Mon, 19 Jan 2026 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768841304;
	bh=FsHQ9qlTxxYa5NDTX3USAelpH419g21o139xDdfBEC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ekaV+yxZfQGMy2ZSYQ+N9Ek9DxLVehclxjFVxjxav6XpdxDGuXb8xE8TC25bu19Gc
	 wdzfYWmT9CYLeHCJZ9nHMs+6vBXLKEGgcd8QNP9abcbrz40h4TBPiLIn2ihC++2+Xx
	 y9LYPvFfbbaWtIkMnTCRKoY6hJaUtfuq3dhoohdYH2nunV6wMbQDggRWu0CL0WyQSd
	 vR0OrqFhBROr+ZV5eipxwLbolxicz7x2/DhWlkXNYTOYHqZiQ0bP8c69PPlYaYsvIC
	 MLLLFB9WtWY94Wd1zFvlPLeKqTGBOtxNkz+2aP2WrNahsSxmoIJr4g0dpX1+E1j9uU
	 4PfOp67FFA4fQ==
Date: Mon, 19 Jan 2026 08:48:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyue Wang <haiyuewa@163.com>
Cc: netdev@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>, Matt
 Johnston <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v1] mctp i2c: align function parameter
 indentation
Message-ID: <20260119084823.5c2aa9b8@kernel.org>
In-Reply-To: <20260119070022.378216-1-haiyuewa@163.com>
References: <20260119070022.378216-1-haiyuewa@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 15:00:06 +0800 Haiyue Wang wrote:
> Align parameters of mctp_i2c_header_create() to improve readability
> and match kernel coding style. No functional change.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: cr

