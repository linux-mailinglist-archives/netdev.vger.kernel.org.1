Return-Path: <netdev+bounces-48511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3357EEA6E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 01:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F451F225D9
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5730381;
	Fri, 17 Nov 2023 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C13M6DUW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA135655
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 00:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46E9AC433C7;
	Fri, 17 Nov 2023 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700181623;
	bh=D9mJhKQTheELXxLPtK1TMo1qKHE3Q8g2bys3rN1R6f0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C13M6DUW33oCrKlgi/MSolPxf1bvzzbMTY7ZDF1s7dQeiwipAcLYD7fsgLrHipMcY
	 4Kp6XBgNgFe+FqmR4WQADOYMzv6dslZkxIBuvyRk4MvQrhWErQev1cm2MIIcYLP6NV
	 UDbORZYiqnciwtT9dEMHHqKWf05+iIpnLRC4HVjvlhgL8LtCHqh6e6jX6ERjHD+1pa
	 bV7No7347PsDIS+fCU6s/FmOYGkthIVYaUe1E/85UzH6nkEoM7Oc6GtzeQc5lGesqz
	 JDIHeAVTT0A7aOBygHlkWY8q3JZO3wFXb7h5T9mA2cY34JZ2hUsxEwaI6KB32Iir8q
	 Jy7nd22ncPmSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C111E00090;
	Fri, 17 Nov 2023 00:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] s390/ism: ism driver implies smc protocol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170018162317.17554.15888902026228306856.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 00:40:23 +0000
References: <20231115155958.3249645-1-gbayer@linux.ibm.com>
In-Reply-To: <20231115155958.3249645-1-gbayer@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, horms@kernel.org,
 pabeni@redhat.com, guwen@linux.alibaba.com, rdunlap@infradead.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, dust.li@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Nov 2023 16:59:58 +0100 you wrote:
> Since commit a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
> you can build the ism code without selecting the SMC network protocol.
> That leaves some ism functions be reported as unused. Move these
> functions under the conditional compile with CONFIG_SMC.
> 
> Also codify the suggestion to also configure the SMC protocol in ism's
> Kconfig - but with an "imply" rather than a "select" as SMC depends on
> other config options and allow for a deliberate decision not to build
> SMC. Also, mention that in ISM's help.
> 
> [...]

Here is the summary with links:
  - [net,v2] s390/ism: ism driver implies smc protocol
    https://git.kernel.org/netdev/net/c/d565fa4300d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



