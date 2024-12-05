Return-Path: <netdev+bounces-149514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB69E5FBE
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 21:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A081518805EC
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 20:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E7A1BB6BC;
	Thu,  5 Dec 2024 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmCNnW9K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542991B6D02;
	Thu,  5 Dec 2024 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733431818; cv=none; b=AEoCCQt1+rPto4Ay54Z97D6+keUwFIPmleHtMJpPSNYDfe4V9GaHOfri8q85eToPSToJYvVXoJfXd25jJ+KXJ4NQ9jfgluIBy7W4GZJfvyK5Z+RBJznu/poAFDJhKLK9eoUqgnPErczLdNIhWwuaQ1D90mHGYqu7iGH09jMkqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733431818; c=relaxed/simple;
	bh=X+ywS6TndeJbU11f75kUJD8TXWzdqlfBtR1l0GsEh6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lgs8123remKbXOI713JDuPSKSSZUn+HTtlAwMkx/XF7PvAzyzkobog+5CHl1M6F96uQ69ZCTy0KsUuA2rkt/fwR5vfEFZYuJ2Rw/6wjBD2UV9VXpC301d2B4AQxMrYHGzU57jtT4QGDGdDnf1C9hI/XGzxZ2lpjBqejzMox0ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmCNnW9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB46C4CED1;
	Thu,  5 Dec 2024 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733431817;
	bh=X+ywS6TndeJbU11f75kUJD8TXWzdqlfBtR1l0GsEh6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TmCNnW9KRZkwcByrs95o62IYwxSrE2krxZb1sGQbd8cpNu4JV664VCkDhopcP43IK
	 mSUPJMQhsoJaYDoz1RaVfbGQg7Aj+MLJnFVSuV7TLK/JF7rTVPXPbUVy/FQFWefx9X
	 FVQtXkgGd4AFMNdWMf0BGxpWx30Lc/HKPowYFckYlem9EMOJ38GnvWdLy3nGbIAuHz
	 TnWKCnCn9yL40XA1BJM9hjLbfYwjRI9Yy/yGp344onFNNS0NWLBg0HNPKPLe5llxxA
	 n35yZWyGwqsSQq0wseauknKgSR/jSXXRCons6YfhA3fJoQ+RVHfasl097pjzYYO+qJ
	 zFPIvXSg5RuMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE828380A951;
	Thu,  5 Dec 2024 20:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/8] ethtool: generate uapi header from the spec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173343183250.2063743.5447149013565962028.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 20:50:32 +0000
References: <20241204155549.641348-1-sdf@fomichev.me>
In-Reply-To: <20241204155549.641348-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, horms@kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, andrew+netdev@lunn.ch, kory.maincent@bootlin.com,
 nicolas.dichtel@6wind.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Dec 2024 07:55:41 -0800 you wrote:
> We keep expanding ethtool netlink api surface and this leads to
> constantly playing catchup on the ynl spec side. There are a couple
> of things that prevent us from fully converting to generating
> the header from the spec (stats and cable tests), but we can
> generate 95% of the header which is still better than maintaining
> c header and spec separately. The series adds a couple of missing
> features on the ynl-gen-c side and separates the parts
> that we can generate into new ethtool_netlink_generated.h.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/8] ynl: support enum-cnt-name attribute in legacy definitions
    https://git.kernel.org/netdev/net-next/c/523d3cc4b6d1
  - [net-next,v4,2/8] ynl: skip rendering attributes with header property in uapi mode
    https://git.kernel.org/netdev/net-next/c/8c843ecde4e4
  - [net-next,v4,3/8] ynl: support directional specs in ynl-gen-c.py
    https://git.kernel.org/netdev/net-next/c/56881d07f0b4
  - [net-next,v4,4/8] ynl: add missing pieces to ethtool spec to better match uapi header
    https://git.kernel.org/netdev/net-next/c/0187e602c03c
  - [net-next,v4,5/8] ynl: include uapi header after all dependencies
    https://git.kernel.org/netdev/net-next/c/001b0b59efbb
  - [net-next,v4,6/8] ethtool: separate definitions that are gonna be generated
    https://git.kernel.org/netdev/net-next/c/49922401c219
  - [net-next,v4,7/8] ethtool: remove the comments that are not gonna be generated
    https://git.kernel.org/netdev/net-next/c/dd7cde36de15
  - [net-next,v4,8/8] ethtool: regenerate uapi header from the spec
    https://git.kernel.org/netdev/net-next/c/8d0580c6ebdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



