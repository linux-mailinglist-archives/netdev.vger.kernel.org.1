Return-Path: <netdev+bounces-142199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D41669BDCF2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69802B24500
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C98192B7A;
	Wed,  6 Nov 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYb5N7/r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E2519047C
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859624; cv=none; b=YpM6OEgBFJcW+2lujPXn29z257UXYe7gKeHsxP5mQmr2fgpjWz3E66kOI6Q4X+W5tEcI2LxydD7lMKztNlheotu8/oktsSD0Dx2C3/4OSB2ZydnMkHxxv7ozXYuZaFlaSFaFenAnaqmVTDsfObDdMhQ6coUMT4Vzi7ByYZ+JwNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859624; c=relaxed/simple;
	bh=iQPJ0oY9hrzjpYRWU9kG6kLWUZS9cAcvn4Oc590I0CM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZMZxWuvQBKN71EJ/AngKaR7hroHy72EVueVWfGZ47GUwVJ8pPWJ/IGE8wJ8fEZlA+qFQYkR8/oF8iPhLOlpd3IlL56aD3hwCR+ndPWXQN6RAv7aF4Zrqt+T3pzgwtjJ4NVgSoqDooqkda9sGdeptYmeZ37giItFvz6fPxTdvPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYb5N7/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B70FC4CECF;
	Wed,  6 Nov 2024 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859624;
	bh=iQPJ0oY9hrzjpYRWU9kG6kLWUZS9cAcvn4Oc590I0CM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HYb5N7/rGxXE7R5XqSheGdv4pp8GYdZ/SQUiTRcGIUjCiRydOjjQYmKB1gtzV3xuC
	 cB+hyWHWy9MkCjKNITfCTJx8VfXL985cUTz0QTLwD5DEItiTuG00i1xRD6mQnoLaSq
	 5yo/PuzocVCkBJSMPhzKQrEj8FXMopxSNySJicMlbn4JwEuaNTzvLs4xPBFRy4LuJF
	 yAKkLYsDmXQI87buL6i3l1lHgu6csy2FptfBy79kjbklYsX9cTUdquzD35t8ewtbU/
	 MwT6c6vZrYGZ0kFRJ1cIXRLjcSAkaFkjsxjzLJLcG1tez3Byb3SaQh8JWiKpP1ZsQD
	 WgG9wtiwGLJaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710D33809A80;
	Wed,  6 Nov 2024 02:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2024-11-04 (ice, idpf, i40e, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085963325.771890.2276241760095412939.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 02:20:33 +0000
References: <20241104223639.2801097-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20241104223639.2801097-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  4 Nov 2024 14:36:28 -0800 you wrote:
> For ice:
> 
> Marcin adjusts ordering of calls in ice_eswitch_detach() to resolve a
> use after free issue.
> 
> Mateusz corrects variable type for Flow Director queue to fix issues
> related to drop actions.
> 
> [...]

Here is the summary with links:
  - [net,1/6] ice: Fix use after free during unload with ports in bridge
    https://git.kernel.org/netdev/net/c/e9942bfe4931
  - [net,2/6] ice: change q_index variable type to s16 to store -1 value
    https://git.kernel.org/netdev/net/c/64502dac974a
  - [net,3/6] idpf: avoid vport access in idpf_get_link_ksettings
    https://git.kernel.org/netdev/net/c/81d2fb4c7c18
  - [net,4/6] idpf: fix idpf_vc_core_init error path
    https://git.kernel.org/netdev/net/c/9b58031ff96b
  - [net,5/6] i40e: fix race condition by adding filter's intermediate sync state
    https://git.kernel.org/netdev/net/c/f30490e9695e
  - [net,6/6] e1000e: Remove Meteor Lake SMBUS workarounds
    https://git.kernel.org/netdev/net/c/b8473723272e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



