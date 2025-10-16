Return-Path: <netdev+bounces-230234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 374E8BE5A50
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4E78357254
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D682E6CBC;
	Thu, 16 Oct 2025 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipLnBCcF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30CD2E6CAB
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652628; cv=none; b=rvZSuwyp6EzjJ9fi0ws/BwqhKDdGo0VqOuCtOkZaZrTjw0VvxprSr1Wnwt4Ki55/ANT0LJwrLH00VdpoDIyOhDHZQ249DK1e2G7fjx4jwc9hx6RxooAzX0J8EiScKcgyZdlwC2/4Qr7JTDSY/t8MZSgpMAN+P7oGZywik/k78Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652628; c=relaxed/simple;
	bh=gHHhAjYF4O2tFcfoNqPo3mFnYA9ZnwLfZqZchB31utg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QX5IiMZNI4eTDlJikRwL3r9KAF+AFe0rIbyv7S4pJVk+PwnWEAdPjlYx+dn/nbF2Ywy3IZCuCb5i+5UHXqo2IyyXebh1cXQk/UB7oxnDaoThV8iuzQRRVtzRB7FYLOqM8n1ov967V1gzPbQG8cBYIhZb2iuL33mQqe4eQTPkG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipLnBCcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F2CC4CEF1;
	Thu, 16 Oct 2025 22:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760652627;
	bh=gHHhAjYF4O2tFcfoNqPo3mFnYA9ZnwLfZqZchB31utg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ipLnBCcFaFNvoC13JJFbFOCOIkxb93VMP/iMxkW2ROynzt0PDwrKxTUBRzGxJeVov
	 Yrde4U3qOxmCHo8qjpvc9V+L1fagqeuhm6sRJ03Li0CjE2yfpJHC9w52FTupx6TA7/
	 0Wa0E5JyVaXCh2K2VToJUDvwvR7PMe+hfrkds3FB4zYLIFk6qEsAe8tsuk6kIjU5d9
	 8ELT0KwZciU3pQzs480JkF6GrgS06iDuPheXZjs4gXnVTZOQLLYDh7hHEat3TiR90g
	 N3PWlRGX34jCH56YrtDcEScfTeLTXPl1kY0cCbuDOCOTcoGkHlV4g739DI2DD2QpdA
	 vsr7JkMPUhbOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4A639D0C23;
	Thu, 16 Oct 2025 22:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] netshaper: update include files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065261149.1923966.11047327912510252550.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 22:10:11 +0000
References: <20251016215955.14261-1-stephen@networkplumber.org>
In-Reply-To: <20251016215955.14261-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 16 Oct 2025 14:59:46 -0700 you wrote:
> Use iwyu to make sure all includes are listed.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  netshaper/netshaper.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Here is the summary with links:
  - [iproute2] netshaper: update include files
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ae2ac1ab9cee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



