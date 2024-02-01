Return-Path: <netdev+bounces-67822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D0C8450A7
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 06:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA8128F16A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 05:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2A43CF43;
	Thu,  1 Feb 2024 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWsJZuST"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956883C469
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764828; cv=none; b=ZuTPZB4PN7AJvxT1Q+HPfaMqPSKbclcqMzPPoS2uMP/fh+oEvoLr3IDIkLDr7xFAC16ukWJEUKp0dOuKz7VbRGGHfaz17PIrwRLWulwjm1QVwWENwhkF8dIu1KN1stpuUA88FDk7LrrNHNY37KEo6M57RK4TV6t2o/bykQny2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764828; c=relaxed/simple;
	bh=IZ+SE/Fy2d37IjFdKYgDWyIUas/Nh8vvU0ypkV90bHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lrfJOokUUKDQE07C46HbbtUrWylplPiT6HeITyOcnb1mMTWPj3hg2JeFhOmxcHNXsMJyUPsUKiWzU19EDd9Us4LoCyB3u9mskaO2rkl9eSaZ3JRZ2xCQewb+GIS6TQ0DvDjDzJGoUf8wXXlsl8iDnxI9xeZFwW8qeng17hamRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWsJZuST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D9F3C433F1;
	Thu,  1 Feb 2024 05:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764828;
	bh=IZ+SE/Fy2d37IjFdKYgDWyIUas/Nh8vvU0ypkV90bHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RWsJZuSTGPSlYsOopAdgUZLAObpDELCIsCUoZUbKqTGmO5KNdZ10fHhxS+YeNZmOs
	 +8EX7B7daoJcIJ9sWP7yaVpbGtYcvzyHcztlSOiMBJYoKxBjoZsLNRIiXBqNfzlz2H
	 Lum+0b0QuVlJJmavkDYZeCBrKtfnZ1kvYtWb+PKuMUc80eOGZpmh09/2J3rAr0yKqF
	 uPZyptU1VVyV2EnVabiuyy8KswEwjvF0seXU1Uzj2RVDwteSssnFJgLO+ulZIotQrW
	 YLmWTIu5E/ugsn0j53q03HJjrltm57sfi3gEg+Y7RVTRUAtAj4ZjOwX+X70aFuTT9o
	 8vT5fKypq9rPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 118FEC0C40E;
	Thu,  1 Feb 2024 05:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: Declare local variable for pause in
 fcnal-test.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170676482806.24744.2361521672144451400.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 05:20:28 +0000
References: <20240130154327.33848-1-dsahern@kernel.org>
In-Reply-To: <20240130154327.33848-1-dsahern@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jan 2024 08:43:27 -0700 you wrote:
> Running fcnal-test.sh script with -P argument is causing test failures:
> 
>   $ ./fcnal-test.sh -t ping -P
>   TEST: ping out - ns-B IP                                       [ OK ]
> 
>   hit enter to continue, 'q' to quit
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: Declare local variable for pause in fcnal-test.sh
    https://git.kernel.org/netdev/net-next/c/e79027c08302

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



