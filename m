Return-Path: <netdev+bounces-243093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9CAC99729
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3ACBF3404EC
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A682329AAF8;
	Mon,  1 Dec 2025 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Buo8q8P0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CD1E7C03;
	Mon,  1 Dec 2025 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629602; cv=none; b=uDyJ6DmswGQIG17JG0DbCJMcZ24scOpuG78ZxtGcBAG9ZpVQZ0TiFDey3tcGLPJgf+FKX9jWt0hOIsB+RKbwLYBUrIeNM/n1vwNJpBTdey/wEerEP5ASQEgbMl7arSbByt05UsvC86Pozv2tz/TAmochDk/ZKdkgShTdQ++5gT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629602; c=relaxed/simple;
	bh=uw/kkT/ooZbHkkATRRJxoW6D40dh3H41msOhQ8INyqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j7R+ONZvLg484O6imBZKNK/C36R1WJnjGquo++IAW0qYvOGJ8StmhJYlmJ+nDGcOgrdX3+NHCLX4QIQJv+vel9uLcXJy5r5QioVGtbWXXf/8c0m3f7IS+ar+yR2vTH1yKjrSBkPSqVPF9fkFLrJrJGRPSrz9YiOT6GG1gMc6RBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Buo8q8P0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EE9C116C6;
	Mon,  1 Dec 2025 22:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629602;
	bh=uw/kkT/ooZbHkkATRRJxoW6D40dh3H41msOhQ8INyqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Buo8q8P0+siSY6ijWh/fl4dmca7pTKDfuyxr77ezN3+avA8/th7rDGARtEJ9Dhgl9
	 Mej6wpcGjPK4pko9h9UEynvFNLFTQVthYXGblJ7e5ChtaLXsb2+6nEwc2030l2ggg+
	 wb6q7qOarZBk16/438yd/DE2gq4jVZNPGIZvLNj+yQkTQLfz+E0KPfSA9EFQnwALk7
	 PwdySp36XcVvezYnn/3OGcDj94xOovD4mJm7ijEax1CX4wZUnVPRVVmmib5PlSg+3e
	 y565MIYFY5kxx/xwDL5n0ysi2W98UoVya9paYlT5jDE0isp0OZX0RXpjtCw9zIjqj6
	 m9Ky+su6DbfWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA9B381196A;
	Mon,  1 Dec 2025 22:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] team: Add matching error label for failed action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462942202.2581992.12765522387772260479.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 22:50:22 +0000
References: <20251128072544.223645-1-zlatistiv@gmail.com>
In-Reply-To: <20251128072544.223645-1-zlatistiv@gmail.com>
To: Nikola Z. Ivanov <zlatistiv@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Nov 2025 09:25:44 +0200 you wrote:
> Follow the "action" - "err_action" pairing of labels
> found across the source code of team net device.
> 
> Currently in team_port_add the err_set_slave_promisc
> label is reused for exiting on error when setting
> allmulti level of the new slave.
> 
> [...]

Here is the summary with links:
  - [net-next] team: Add matching error label for failed action
    https://git.kernel.org/netdev/net-next/c/aee0f01b4f11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



