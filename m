Return-Path: <netdev+bounces-161215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA7A200BB
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C6C3A50F8
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F65F1DC9A2;
	Mon, 27 Jan 2025 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPBP/BEU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A519885F
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017609; cv=none; b=R8nOrPtM5ewWpdIw4lSBoU25CC2nXR8B41T67SZBCzVW5PB3o5eJ5nE4C3A0hpFnt0UQhnDmTTmoCtNyw/a3DvQv2885O+vb0b0WJQYGGIsMZZQbmI6Svp1kSQbts8x/SyMcM1caivHcphNodi2FBrIVl6srlBB1vKuMjOrunZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017609; c=relaxed/simple;
	bh=mK9MaOKp3gnhau3jnnpFm7aI8KkjOtwJGtoH15Qfru4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OeAfKa0xx3BhDpjycJKOwn/VMY/9B4jolzwuc49NL0TDzh0xLJpWC+oQGHf/Rkl/RcPVj2thAbT8wmwQxfya1hgky85g+aVTIUlCRe4SylG3uTRydRNvJviN+GTykH1VBLAPCEx1b1i7aYAOYBYkxuWybGg+PxS/EiJg4yLQ9NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPBP/BEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C901AC4CED2;
	Mon, 27 Jan 2025 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017608;
	bh=mK9MaOKp3gnhau3jnnpFm7aI8KkjOtwJGtoH15Qfru4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FPBP/BEUxZHnB4c2ShxgA6e1MAIoGbiOc9yA3+XaDU95osZ7VtwKnyWVg0YhNTd2k
	 TQyLTbzJNoZhhRa/cvBn1ItGBDH0TkjJZUlGfGaIote0RXggp757lt8mZ0iv0mbFmQ
	 3kAIMwr/hD4xYcKR7T8AgL0hakGGHd2wnPLbtx/cqA/pJI06lh3R8GOoxMHXrP/Zm3
	 0Kcg7XHEVa66LzKLLIt0SpXR1BRq7CylS3Mn20ShZtGTYgDFE/a0n/wx8Yq73Up60H
	 9c9xFbSXf8zH5keKXki6UddUng/IsZoYrrooiypnqp8K3SMSKfhKoQkJLECp+RqVhv
	 Di35c32E25MWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD65380AA63;
	Mon, 27 Jan 2025 22:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add Paul Fertser as a NC-SI reviewer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801763423.3245248.14145146421737017824.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 22:40:34 +0000
References: <20250123155540.943243-1-kuba@kernel.org>
In-Reply-To: <20250123155540.943243-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 sam@mendozajonas.com, fercerpav@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jan 2025 07:55:40 -0800 you wrote:
> Paul has been providing very solid reviews for NC-SI changes
> lately, so much so I started CCing him on all NC-SI patches.
> Make the designation official.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: sam@mendozajonas.com
> CC: fercerpav@gmail.com
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add Paul Fertser as a NC-SI reviewer
    https://git.kernel.org/netdev/net/c/3b1af7660439

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



