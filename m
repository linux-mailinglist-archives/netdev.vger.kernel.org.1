Return-Path: <netdev+bounces-248560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E404DD0B869
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0319930D80F2
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EF435CB82;
	Fri,  9 Jan 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8O/6TDq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C615667D;
	Fri,  9 Jan 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978228; cv=none; b=mnRwCkgZlKo+NP4nVEaPH2YfCU9sy1vie93GIkE3zGLb+Jyw5uGnl8C5nAYuuLTYBs0Okp90qXKmIbrb9tLuFdyo//AsnLkaDSp3blg54S4J5XryLRU7eGNfMKwhul/UXDxEeXb0daxfDeCC7/Um9S8w1ASA5t1bMj4nugkKgWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978228; c=relaxed/simple;
	bh=E8hkh2iKi3pQ5sq+60n+L5BxuNRqiD2HkhODYEyOsfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fRvLruC6Zi7Y8bh1psE5BvgW1TG7n0bp9NHgtV+M9fq8Vhu/KFmtfufO3RuQZzysDVPOGWNe80QK7YOHSVoJAQERjt0zGuh4wLG1kyrHYAimH5WVfwMIK63Ts8T1eOeA1Yb5POM/r+rOsPTRavE2oOUXdYJJtALG/rdBijAZlGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8O/6TDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14956C4CEF7;
	Fri,  9 Jan 2026 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767978228;
	bh=E8hkh2iKi3pQ5sq+60n+L5BxuNRqiD2HkhODYEyOsfo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o8O/6TDq9GpTZniJr/1qzrXdhDY771vTF2nmswtGya+J8V2XhbjHvzFO5gZOsyES/
	 cUh31ARvs0AXyofWAz50JMVf84+iF97RRWtaf0uwJUOYQVpNDlQnEmjUetb0sN+pbe
	 +Z9XpUnXKaLriJMkur8BAF5NvGiLUQuufTxIjvYB3Lqd7dJYo9677yze28jKH1osZO
	 GYXeOmfs6wPiwqR2fxyPcNooWxdWIpCjCA16YZtyY73Nc2I62T7vsscM/D1zsh7jUy
	 YU1c9GlhPuaNmiiMV/UX9f12aJouZO1nfn7spVYWVMTKT6a1CzLh2heAFvyLpgIYdL
	 tingTxsQHkphQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1DFE63AA9A96;
	Fri,  9 Jan 2026 17:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/13] tools: ynl: clean up pylint issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176797802404.330174.4360642003047959122.git-patchwork-notify@kernel.org>
Date: Fri, 09 Jan 2026 17:00:24 +0000
References: <20260108161339.29166-1-donald.hunter@gmail.com>
In-Reply-To: <20260108161339.29166-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, gal@nvidia.com,
 jstancek@redhat.com, liuhangbin@gmail.com, noren@nvidia.com,
 netdev@vger.kernel.org, corbet@lwn.net, ast@fiberby.net,
 mchehab+huawei@kernel.org, jacob.e.keller@intel.com, rubenru09@aol.com,
 linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 16:13:26 +0000 you wrote:
> pylint tools/net/ynl/pyynl reports >850 issues, with a rating of
> 8.59/10. It's hard to spot new issues or genuine code smells in all that
> noise.
> 
> Fix the easily fixable issues and suppress the noisy warnings.
> 
>   pylint tools/net/ynl/pyynl
>   ************* Module pyynl.ethtool
>   tools/net/ynl/pyynl/ethtool.py:159:5: W0511: TODO: --show-tunnels        tunnel-info-get (fixme)
>   tools/net/ynl/pyynl/ethtool.py:160:5: W0511: TODO: --show-module         module-get (fixme)
>   tools/net/ynl/pyynl/ethtool.py:161:5: W0511: TODO: --get-plca-cfg        plca-get (fixme)
>   tools/net/ynl/pyynl/ethtool.py:162:5: W0511: TODO: --get-plca-status     plca-get-status (fixme)
>   tools/net/ynl/pyynl/ethtool.py:163:5: W0511: TODO: --show-mm             mm-get (fixme)
>   tools/net/ynl/pyynl/ethtool.py:164:5: W0511: TODO: --show-fec            fec-get (fixme)
>   tools/net/ynl/pyynl/ethtool.py:165:5: W0511: TODO: --dump-module-eerpom  module-eeprom-get (fixme)
>   tools/net/ynl/pyynl/ethtool.py:166:5: W0511: TODO:                       pse-get (fixme)
>   tools/net/ynl/pyynl/ethtool.py:167:5: W0511: TODO:                       rss-get (fixme)
>   tools/net/ynl/pyynl/ethtool.py:179:9: W0511: TODO: parse the bitmask (fixme)
>   tools/net/ynl/pyynl/ethtool.py:196:9: W0511: TODO: parse the bitmask (fixme)
>   tools/net/ynl/pyynl/ethtool.py:321:9: W0511: TODO: pass id? (fixme)
>   tools/net/ynl/pyynl/ethtool.py:330:17: W0511: TODO: support passing the bitmask (fixme)
>   tools/net/ynl/pyynl/ethtool.py:459:5: W0511: TODO: wol-get (fixme)
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/13] tools: ynl: pylint suppressions and docstrings
    https://git.kernel.org/netdev/net-next/c/37488ae6ceff
  - [net-next,v2,02/13] tools: ynl: fix pylint redefinition, encoding errors
    https://git.kernel.org/netdev/net-next/c/bcdd8ea73f75
  - [net-next,v2,03/13] tools: ynl: fix pylint exception warnings
    https://git.kernel.org/netdev/net-next/c/b6270a10b0f8
  - [net-next,v2,04/13] tools: ynl: fix pylint dict, indentation, long lines, uninitialised
    https://git.kernel.org/netdev/net-next/c/04b0b64e86b7
  - [net-next,v2,05/13] tools: ynl: fix pylint misc warnings
    https://git.kernel.org/netdev/net-next/c/542ba2de32fb
  - [net-next,v2,06/13] tools: ynl: fix pylint global variable related warnings
    https://git.kernel.org/netdev/net-next/c/00ef9f153ed8
  - [net-next,v2,07/13] tools: ynl: fix logic errors reported by pylint
    https://git.kernel.org/netdev/net-next/c/9b6b016df4c2
  - [net-next,v2,08/13] tools: ynl: ethtool: fix pylint issues
    https://git.kernel.org/netdev/net-next/c/301da4cfea5f
  - [net-next,v2,09/13] tools: ynl: fix pylint issues in ynl_gen_rst
    https://git.kernel.org/netdev/net-next/c/9a130471f854
  - [net-next,v2,10/13] tools: ynl-gen-c: suppress unhelpful pylint messages
    https://git.kernel.org/netdev/net-next/c/c2fa97c509ec
  - [net-next,v2,11/13] tools: ynl-gen-c: fix pylint warnings for returns, unused, redefined
    https://git.kernel.org/netdev/net-next/c/93ef84292959
  - [net-next,v2,12/13] tools: ynl-gen-c: fix pylint None, type, dict, generators, init
    https://git.kernel.org/netdev/net-next/c/a587f592d6c4
  - [net-next,v2,13/13] tools: ynl-gen-c: Fix remaining pylint warnings
    https://git.kernel.org/netdev/net-next/c/1ecc8ae876c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



