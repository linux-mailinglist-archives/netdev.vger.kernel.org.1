Return-Path: <netdev+bounces-196731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3CAAD61AA
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946003A38AE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AA924DD1F;
	Wed, 11 Jun 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUvJI7S5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96E24729E;
	Wed, 11 Jun 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678008; cv=none; b=CVhujg4skSxcZbvQ721poF5I+fBCYpmv6OYYey3PqwZ2OWOgqpNcgAXL758zvvTex4R/Pe+Tx2N7Ke2mVURyYvERfoet3sRTggjexuLY2zeBFNMN3PwoIWvG3nl90najvhdyU9FIV4+ioFPbFQvQ5JLM46gEf/ISlwByudUu6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678008; c=relaxed/simple;
	bh=Y+7SL6a/uxFt7I+KV9WCZREo8uPTpjZfddI9p4MFulM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TNPGdASswUjjN6sg8acFS8UB+jjzjZRe6swlTcLS5tefAuvAOXVvQ5UT3zr+KlWBN+Gb4elrztONKCHQkY5YCi2Sm3qUngf3K7eo8aIo1/5SMh7Y6foTKCsspJp9zvlf2VM2/rroT5xtYaoFDOMmXHX3XuFXfqZ9L6aapEBxER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUvJI7S5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225AEC4CEE3;
	Wed, 11 Jun 2025 21:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749678008;
	bh=Y+7SL6a/uxFt7I+KV9WCZREo8uPTpjZfddI9p4MFulM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iUvJI7S5GJR10XfPc7psiaRJE6zOte5It8SuYmRBOFsKRfaQtt3mp+oT4JYRoG13W
	 spgscnroKaG7h7Y3ligWv4j5DF80jd6EBRvhMQZsUjFaOc95VgSA04fd9uVu4L9XMm
	 ikEZGmzH54wp8SrLLGsjc0e0ZA+1/d2zVFPvuUnFXdDTx1Tyx08oxLdE1LJOUNl/EH
	 2IrFOR+O7EHpJzTIROxkKPUBhWfEkZFdgr7OVkA61o3KN3ZvIDNUrMYIC67uZ9PBJ0
	 5/M1t4OezF2ZV6zbU8U5j8udBbEOgbK+5z5TuQwefHCiqf90OJzah/12CSznYmBIVS
	 WDvYg5eBF8/6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71989380DBE9;
	Wed, 11 Jun 2025 21:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] net: fman_memac: Don't use of_property_read_bool on
 non-boolean property managed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967803798.3496159.17632265399572187192.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 21:40:37 +0000
References: <20250610114057.414791-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20250610114057.414791-1-alexander.stein@ew.tq-group.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: madalin.bucur@nxp.com, sean.anderson@seco.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 13:40:56 +0200 you wrote:
> 'managed' is a non-boolean property specified in ethernet-controller.yaml.
> Since commit c141ecc3cecd7 ("of: Warn when of_property_read_bool() is
> used on non-boolean properties") this raises a warning. Use the
> replacement of_property_present() instead.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> [...]

Here is the summary with links:
  - [1/1] net: fman_memac: Don't use of_property_read_bool on non-boolean property managed
    https://git.kernel.org/netdev/net-next/c/7781c4f70305

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



