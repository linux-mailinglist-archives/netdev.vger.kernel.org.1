Return-Path: <netdev+bounces-213131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5EAB23D47
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15783B94B4
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 00:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA4B1C84B2;
	Wed, 13 Aug 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUD5o/jF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187E17D346;
	Wed, 13 Aug 2025 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045594; cv=none; b=PgscFJSJk3kpNKIrj+ZdSlj8bDFYFabSL5oIzCHYwUKuD/3kBX2wVRH4sHFBKsyCdPAT5Sf1zL/qTBNtFJ0BHh1/sOgoPV8KuGcao8hJ/Efj6gtOIdMLrlvJ2BCdL/Vwn1vdFOCQ6sMfFK38xuZRlTX+XqVUGFsQOo6tUJPJaVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045594; c=relaxed/simple;
	bh=4rjXDG1A468YyGqDi4pOOufXNkfZJ6qYx01fkJAN8MI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=glbSfpvHvBk8+/V2PcD50YgiUNdAC639LtWcxARSHfhUmJqOVnhhKQGfAEfQfZGquJpP43RLThdFUyDl1DI6IOBThrtnmaPmhGuyL+ZnaFg20RIYTVx4N/Wr2JLbIBz1b3nOIkJ/toCL4bfMQ7j7kydH0bCzXyYrJf3w2IRVbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUD5o/jF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0F2C4CEF0;
	Wed, 13 Aug 2025 00:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755045593;
	bh=4rjXDG1A468YyGqDi4pOOufXNkfZJ6qYx01fkJAN8MI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iUD5o/jF/14RjWfBtG0tG//upEq8U9JMNDh7b5xogZVYC0avZwOgs6GhLqQotL/pN
	 10z6/lTcWuVY3aDoq1f3XmJYMMsMvgG/0zTxWvhcZfi072QrKmEjfa64Hz9KfzpaNl
	 ZD6fwHPJekEJJCUBlqW85gw0tCrvIuTFRtDIKt6scjJoGSZw7GLHCkJ9tk0Qax291L
	 a5kVvZu0XaG6sR3btZNz969zFpoXcaQSt2CDBROL7NfaA64IEmVqYUbI1clDj4FWZ4
	 tHGt1olE2ByfZWpielT4Hx5HDdStMgW9euqDI1sUqEKiMgjwkXA8lTT/eUE1ra3Vvi
	 Z+9WBv8U7YxJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADFF39D0C2E;
	Wed, 13 Aug 2025 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio: mdio-bcm-unimac: Refine incorrect
 clock
 message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175504560575.2903381.16940639109125791687.git-patchwork-notify@kernel.org>
Date: Wed, 13 Aug 2025 00:40:05 +0000
References: <20250811165921.392030-1-florian.fainelli@broadcom.com>
In-Reply-To: <20250811165921.392030-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 09:59:21 -0700 you wrote:
> In light of a81649a4efd3 ("net: mdio: mdio-bcm-unimac: Correct rate
> fallback logic"), it became clear that the warning should be specific to
> the MDIO controller instance, and there should be further information
> provided to indicate what is wrong, whether the requested clock
> frequency or the rate calculation. Clarify the message accordingly.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: mdio: mdio-bcm-unimac: Refine incorrect clock message
    https://git.kernel.org/netdev/net-next/c/75f262576675

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



