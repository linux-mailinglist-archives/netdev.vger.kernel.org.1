Return-Path: <netdev+bounces-145658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEA99D04FA
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 19:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACCE281FDA
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089F119BA6;
	Sun, 17 Nov 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6sKh383"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D8322E
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731867616; cv=none; b=MK/o2FCeG//nPy6YC2WwXn7aQkhz83TMa8TdqgmbYJ6Tx1pwldOkCaLvWEoUBhkRnzm4MfZztljIKk9kDHL/roIv7h1ifPvqJseE+lsqMXy9eBTRpjvCEzcy8nUHjNuzflOtYKpI15+DIWKuLUfw+t5lE+NEfKIuDP968mPHru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731867616; c=relaxed/simple;
	bh=Ry39eHUTCke4wc5kgUnL8bx/bN5xKDg5wufuIE0xaaQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZbHZS4i3cyVeW4JVwqE2+IPMBNg3YDSO5WnuCOhREQWz6CYuHLeESVcJ7p8c8fL0yaHgSLVvus5rZHMUhcdcPh+Ce3SyEM4emxRIjjL8eNIt3szYmb3NLXwJ55aveM3sLMOjIaqCpJAaewv5tc7Cy4OhCHz3fm78Rfsgv4WbnbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6sKh383; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F75C4CECD;
	Sun, 17 Nov 2024 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731867616;
	bh=Ry39eHUTCke4wc5kgUnL8bx/bN5xKDg5wufuIE0xaaQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g6sKh383jLepxAxAVBdUizzv0ENgt/8lw+ZFWRJUVYxjoN8kReYOCUpjxlpGgHXGj
	 D6LTXY/h78uSp3Z5srRCTXKRFDm8rrCz9n2JzMQrmKrywK0Krhvqn5IB+qls1JrP5x
	 q37tmeYM4g+kWYo31d8rVNmrtf9MLzTd5uO62tmBvGeNkMMdWmmay0qjP86UvicI3b
	 pmaMWjOKHCLt7r0hZzRncgu02RaMc3rwSXNxxJRuOTiasPYI41Bxhj2DP6OKMieW0/
	 gKbTfrShjrY/3KoaE67GRslm3fuDQgbAIbHeOu8amzUIl+T7VXqQfyS1IJ5Jvy+0BQ
	 SxQ74FnAtGsvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE51C3809A80;
	Sun, 17 Nov 2024 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute] lib: names: check calloc return value in db_names_alloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173186762750.3188493.10961108582163917002.git-patchwork-notify@kernel.org>
Date: Sun, 17 Nov 2024 18:20:27 +0000
References: <20241113105349.29327-1-kirjanov@gmail.com>
In-Reply-To: <20241113105349.29327-1-kirjanov@gmail.com>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 13 Nov 2024 13:53:49 +0300 you wrote:
> db_names_load() may crash since it touches the
> hash member. Fix it by checking the return value
> 
> Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
> ---
>  lib/names.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [iproute] lib: names: check calloc return value in db_names_alloc
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=225f74761b09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



