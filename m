Return-Path: <netdev+bounces-100884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8239A8FC74C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A886B1C22A74
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07DE18FDA8;
	Wed,  5 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pR3MiaFG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781918FC99;
	Wed,  5 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578630; cv=none; b=BhwPhG/hhxKtMzwRh8l8gy/Sq3ic5NnplIg7CylstSyEYVLxm1venmlUnl6jqmruhJph9LwpTxirX7KlNL+uwXrGiCBH67sid7Fp+q9XeRj8Ve69nGA+kV2TPtek/bpUqQCjPUxFrJ0m4Ysxmha/ouqINpJWl8psWK8c+8yc2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578630; c=relaxed/simple;
	bh=1ho3zw/R1c+1/WWWLwIIcTgIz8N9tEYZj9nfeJdbxcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H8OPl+j6I0nombYcq4ARDTFScyU2yrIVHRV3uglkP8osFIQTyz0S69uw/B7eA/SxLHLGJafw7HbgjjEA/lfKxhaAZtfjgY7QFYDS5uk/8YTBB36NOL4OqP6/0gs0J48OXT1EJo9m3vX6Gw2pdDT+A05fj5narQ9wnbkU4ZmTYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pR3MiaFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 180C8C4AF0F;
	Wed,  5 Jun 2024 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717578630;
	bh=1ho3zw/R1c+1/WWWLwIIcTgIz8N9tEYZj9nfeJdbxcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pR3MiaFGenouZ/WbqNuxsjMB65DLxU/VWIAsO18LywgufjHN8heJ4p/5RbAqqfePG
	 /mIo45/V5ffxV71kkvdsrbAPk7D9Y/AUytPBAs301a30DTtwtoHhsp+xR0TTLzUZif
	 r5lY+VBNfbSfa8FcTfS9yF/d03l4++rdM5XYNShDw3Q6zkP7OZ9lxa+i5L+V1sugx9
	 YcxHVl+di4kx9ZfgUB56UV3osPap3ouqSjNi1SW4e6gwuUtTYKZRfkdn/OdixbgCgD
	 bFdkpgqhAjT4or3xq49Q6iw4WP+vFY2MSfobmfUTuVaj6eU84/d25b+ibWR/ezdTL3
	 DWIAN+D4zfKIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BAD5D3E99B;
	Wed,  5 Jun 2024 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: dsa: Rewrite Vitesse VSC73xx in schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171757863004.24611.12150851739203160341.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 09:10:30 +0000
References: <20240530-vitesse-schema-v1-1-8509ad9b03f8@linaro.org>
In-Reply-To: <20240530-vitesse-schema-v1-1-8509ad9b03f8@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: paweldembicki@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 30 May 2024 23:53:07 +0200 you wrote:
> This rewrites the Vitesse VSC73xx DSA switches DT binding in
> schema.
> 
> It was a bit tricky since I needed to come up with some way
> of applying the SPI properties only on SPI devices and not
> platform devices, but I figured something out that works.
> 
> [...]

Here is the summary with links:
  - dt-bindings: dsa: Rewrite Vitesse VSC73xx in schema
    https://git.kernel.org/netdev/net-next/c/3374136f3137

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



