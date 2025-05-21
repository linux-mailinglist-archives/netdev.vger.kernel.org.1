Return-Path: <netdev+bounces-192467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD310AC000C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 00:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572677B1025
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A812376E4;
	Wed, 21 May 2025 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/zCTlo+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7121E0A2
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867808; cv=none; b=QkF7OkwbeooxwvKJbqjputUanTswAP5uuqhVSQZrjIwmSOfH+Ik7NHksaz1JdNiN4nVSKhjR3GZJ7VO6MvPb0hvMPe+RWXkQAURWcyvw/LafOQ0cERLnM+obalbWObl6SzkbhxoFqjI/7rbfiViYWVS2vRUWihWe0rXRJuTEwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867808; c=relaxed/simple;
	bh=PwPXXXwBJaEV2MVtNYm3cPTrYLT81D063IYtc8CMTy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TzsOSq5YM3fzjLUDAOOhG6Vi2IQiQ/a3KS+hYWuuBee5CKIKZ6tga5mLQeli/7BxqwsAqTjQQd43SAek47sTW4iBoiBaEqSTLYNOM21yBTGc/qf16tpsrc0XEb0LZIw7o0MR7tgthJvvuvpvGcYESHTrPQBAdX3itq84yVFoRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/zCTlo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8750AC4CEE4;
	Wed, 21 May 2025 22:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867808;
	bh=PwPXXXwBJaEV2MVtNYm3cPTrYLT81D063IYtc8CMTy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c/zCTlo+CS8VR77sfMTZo4Nd4rkV1D5JKNHpwgm5XWM1dkdiEBpFShG8F3YK8ZkVV
	 4d7tKckL60fBrHX/Kigliym3cCpr4KKbtWvkOvkAsIBnmOgvK2OffDMDv/EhaaK+pQ
	 8efRsKDBU3D3ts2r1vJojg40QlGp+66L86XshAUZ77k0QLBLF7drFbjhjG2AFIzWGF
	 0AlnTJv7G4/vjPwtTqE0r3QWZhB4SwZmE5W4hoB89JTDof0CGvfcDqB5eG0EI7CjwB
	 0691UUCFtzJHfHJXS8qIiWGNRTNkpeAjruZwZM/mjXaFtmwn2ay2UqzJFETP6aW6rX
	 3r0tRJez7B/ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71009380CEEF;
	Wed, 21 May 2025 22:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/12] tools: ynl-gen: add support for "inherited"
 selector and therefore TC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174786784426.2306436.10410311936016337174.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 22:50:44 +0000
References: <20250520161916.413298-1-kuba@kernel.org>
In-Reply-To: <20250520161916.413298-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, sdf@fomichev.me,
 jstancek@redhat.com, kory.maincent@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 May 2025 09:19:04 -0700 you wrote:
> Add C codegen support for constructs needed by TC, namely passing
> sub-message selector from a lower nest, and sub-messages with
> fixed headers.
> 
> v2:
>  - [patch  1] new
>  - [patch  8] small refactor
>  - [patch 10] add more includes to build on Ubuntu 22.04 system headers
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/12] tools: ynl-gen: add makefile deps for neigh
    (no matching commit)
  - [net-next,v2,02/12] netlink: specs: tc: remove duplicate nests
    https://git.kernel.org/netdev/net-next/c/e9033a846eb9
  - [net-next,v2,03/12] netlink: specs: tc: use tc-gact instead of tc-gen as struct name
    https://git.kernel.org/netdev/net-next/c/eb1f803f9851
  - [net-next,v2,04/12] netlink: specs: tc: add C naming info
    https://git.kernel.org/netdev/net-next/c/f9aec8025ab5
  - [net-next,v2,05/12] netlink: specs: tc: drop the family name prefix from attrs
    https://git.kernel.org/netdev/net-next/c/ba5a199b2401
  - [net-next,v2,06/12] tools: ynl-gen: support passing selector to a nest
    https://git.kernel.org/netdev/net-next/c/cb39645d9a6a
  - [net-next,v2,07/12] tools: ynl-gen: move fixed header info from RenderInfo to Struct
    https://git.kernel.org/netdev/net-next/c/a66a170b68af
  - [net-next,v2,08/12] tools: ynl-gen: support local attrs in _multi_parse
    https://git.kernel.org/netdev/net-next/c/092b34b93735
  - [net-next,v2,09/12] tools: ynl-gen: support weird sub-message formats
    https://git.kernel.org/netdev/net-next/c/4e9806a8f494
  - [net-next,v2,10/12] tools: ynl: enable codegen for TC
    https://git.kernel.org/netdev/net-next/c/e06c9d25159c
  - [net-next,v2,11/12] netlink: specs: tc: add qdisc dump to TC spec
    https://git.kernel.org/netdev/net-next/c/33baf6f73a7c
  - [net-next,v2,12/12] tools: ynl: add a sample for TC
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



