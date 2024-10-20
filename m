Return-Path: <netdev+bounces-137284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4575B9A54A3
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55271F21C7D
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74054196DB1;
	Sun, 20 Oct 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9xq/AJE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2F196D90;
	Sun, 20 Oct 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435839; cv=none; b=bw69I/2jJhnT78QIReFnF8s9MLX0Xp7YilVBL6gQVQonCBeCdj5U46clcvBqZgwXgIOpeEMPaKL77wJkfFmJ4EfhCXez9zcZigqu0FXO2qFKnGHNwDJTIIgaJHfqkK2OQNhu5dB/5BShxUpisJDwZ8WrBokB1dErTiYCKxXi8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435839; c=relaxed/simple;
	bh=Ju6T0f31ontgzfCo+C+4Esyjjlh5OJI0L8qKurn5fwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c1xHk+OlD2wgJPpaynFVBlqc6FPQgifv4VediBnJUoThRf5ijT30KH6T3pDuFFbk2gU/9K5aR0XupuM9WMBivGIJOpvMYEMUndBOBl5joXEljpW0oSNjb9bJBXro2+kBEazqnyfT6wMzPPDVVXp3K3VmqXhMMxOtDIWolnBS/YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9xq/AJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D72C4CEE7;
	Sun, 20 Oct 2024 14:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435838;
	bh=Ju6T0f31ontgzfCo+C+4Esyjjlh5OJI0L8qKurn5fwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a9xq/AJEAY2bmSPhucvvt2GECp6CdF+3CjVMQhMATtdRlmpYw6ddzUcTf4/6o5has
	 CYYiF5dK9PON9o+Ywc9AhrGWWASQNynsowAxOMCWO2mgN9fkt5u6LGZsrldxqqiM/c
	 GgJDeeJlacWkt85DlKwgdrJLLZUKhHbBcXRdLbm1BbF81SvomN0baPH/pUl/sR7PMc
	 2O05S5I2gSrD6x+HrRqpeIZslOaJW691URdgpyi9xraMfF4iY1kPDz4Nmh52gYcmDE
	 Z8yBmLeXWNqsww/UpERAJEE7JJu6Fg5d9qa7w8R/H8qU2sxNl1b1nUAwZPPPRNstxa
	 0hvlQ4+b6xQRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB53805CC0;
	Sun, 20 Oct 2024 14:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mailmap: update entry for Jesper Dangaard Brouer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172943584474.3593495.5103156948610053485.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 14:50:44 +0000
References: <172909057364.2452383.8019986488234344607.stgit@firesoul>
In-Reply-To: <172909057364.2452383.8019986488234344607.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, toke@toke.dk, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 16:56:13 +0200 you wrote:
> Mapping all my previously used emails to my kernel.org email.
> 
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  .mailmap |    5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [net-next] mailmap: update entry for Jesper Dangaard Brouer
    https://git.kernel.org/netdev/net/c/3e14d8ebaa11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



