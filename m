Return-Path: <netdev+bounces-70412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262B584EF02
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE44028AE87
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 02:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A615CB;
	Fri,  9 Feb 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGGywtNt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629FB4A31;
	Fri,  9 Feb 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447027; cv=none; b=qckQh4ZRmIWG3sXCVRFVZsADCTsIM4TwjON0sjg4CuyBxf/DbGKJ/tj0EHqT4yqPWinZwnN/osUp5lpz6UR/cVTOdd3/HTYN7iVjCDpl2orbETTWtnXjXZ8tCjMK+qJi4EY79LQj526XkvdClcyCgfEcBAH4amyfCTZ4W2RLQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447027; c=relaxed/simple;
	bh=o2FFJ6tbkXzLtU5ENONtTlz9fXCTdL7kRtm/rdMMEuA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QuWvfizG9dExVQLac4mnOPyK5o08qXH/SScqfZAxCwpM2yRXhP5eoPUS+yAGjvAIYj00x1QiAPPxJW26cczh6EXdAjaln6HkE5OiVj0Jga/k5URq20vN+4W5udYgAWji1JAjV2/83WpN/G3HdKAA3mvhXSz+0wFTenWNHMBJ7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGGywtNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03B27C43399;
	Fri,  9 Feb 2024 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447027;
	bh=o2FFJ6tbkXzLtU5ENONtTlz9fXCTdL7kRtm/rdMMEuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QGGywtNtFfMKlRuxqPhku7NH0Prb01PZ4QLdViATZy5SjVCRHauoJgnKIXwnAbD4Y
	 cVti4k4eYUpRifD3whludfNS/MkKsYYTfKNg/ss9xo2D9Ga/S1F4faTWVsXeBNuEf4
	 cS5k7M5s7qzfVnMSIbX7kbUpNaAt3LYl1aZAy+Ij7QBrd6zhxvp3W4Ud/xfdPOlq43
	 okz08iJuKuoYlaP8/hRQgboDilA3lIaiVhz802URHk8QRTtX2Bc10M7eVNQZ2mkBOm
	 /5Z8bJI+68cSV8c34/lSzwHgoCNZZxmvyHwhSsT8dbm+TF6qPVdJQErObQ0PW8xScT
	 p7yDHRTW4aT7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3788E2F311;
	Fri,  9 Feb 2024 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net/handshake: Fix handshake_req_destroy_test1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744702686.13594.13303626944494353923.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 02:50:26 +0000
References: <170724699027.91401.7839730697326806733.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <170724699027.91401.7839730697326806733.stgit@oracle-102.nfsv4bat.org>
To: Chuck Lever <cel@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 chuck.lever@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 06 Feb 2024 14:16:31 -0500 you wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Recently, handshake_req_destroy_test1 started failing:
> 
> Expected handshake_req_destroy_test == req, but
>     handshake_req_destroy_test == 0000000000000000
>     req == 0000000060f99b40
> not ok 11 req_destroy works
> 
> [...]

Here is the summary with links:
  - [v1] net/handshake: Fix handshake_req_destroy_test1
    https://git.kernel.org/netdev/net/c/4e1d71cabb19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



