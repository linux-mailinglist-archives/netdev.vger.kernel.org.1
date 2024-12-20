Return-Path: <netdev+bounces-153581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082789F8AD1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 05:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05A8188CAB9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADE115ADA6;
	Fri, 20 Dec 2024 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei2J7/q/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D988635B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667221; cv=none; b=o7L+LSD4RJBXolU8ls/qOeS5W4UH9wJ9+3y8RcEely9EL1yKA1Ar5+wNV+z9ARKpkhmmgl0CTEdUqvv0wFGnWmZ0+ZKrpNoSbdeAJ4PvytnXIzVGvUcY84Q4dovBClz+Uqyme5LKyB4Kd6qBkpdt3K50om0GK9LcZ7EYbJB0SjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667221; c=relaxed/simple;
	bh=VqVBnYpNNYzLzTIAuaZGqxhu8fnr5JXaaemvGOGe3qs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T12pm61LjYw5ChyWt0LyS71K8W3izT7wmZZriiy0UNljARagllW4N2nfPTrSi2yB7YzvqxebWiiQtZDvk/Nyr/2kDbEojZJ8BC1wAlEpvChZPym0mrcsKOzDqbpwP2uIaRImEijyjYkWbPOKKnd8q0j77n8RpInj5Xp2h46Py8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei2J7/q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDF7C4CED3;
	Fri, 20 Dec 2024 04:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734667219;
	bh=VqVBnYpNNYzLzTIAuaZGqxhu8fnr5JXaaemvGOGe3qs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ei2J7/q/lRYP7E0atQlUZyupOKP2Lm0aClIu863reGDm8ntYsrNpKZYSfBdXma+ZA
	 HZsRcjPTY+/3XYylz4v6q/D/J8bSnVBANhioKk5aK6Kp+nt/hSzKQDmx3/9l+AYKFf
	 gWIPf1Bem7ICpEqtYZ0nmVGfCxIdYVwWQ4LnMBVrPXAIP0Y6EMNkBfQOSaaOA0RSGU
	 HYYXCP5y565v6M2UtFc/vwLSZM3Rx/0tp1GmxaeJhh+eZYMFHOetEn8k0PEZzlo6MZ
	 8reZVfdm9aHdcrvSfUgM+usCkNlVwAOEilo3msvjtZoVR4WBSsTg4I7xt4PMF+zUj2
	 FQCaU6W80iAgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFBD3806656;
	Fri, 20 Dec 2024 04:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gre: Drop ip_route_output_gre().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466723750.2467402.16019253908547121220.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 04:00:37 +0000
References: <ab7cba47b8558cd4bfe2dc843c38b622a95ee48e.1734527729.git.gnault@redhat.com>
In-Reply-To: <ab7cba47b8558cd4bfe2dc843c38b622a95ee48e.1734527729.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Dec 2024 14:17:16 +0100 you wrote:
> We already have enough variants of ip_route_output*() functions. We
> don't need a GRE specific one in the generic route.h header file.
> 
> Furthermore, ip_route_output_gre() is only used once, in ipgre_open(),
> where it can be easily replaced by a simple call to
> ip_route_output_key().
> 
> [...]

Here is the summary with links:
  - [net-next] gre: Drop ip_route_output_gre().
    https://git.kernel.org/netdev/net-next/c/29b540795b42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



