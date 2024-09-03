Return-Path: <netdev+bounces-124349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5731B969160
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7431F23091
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809A1CCEDE;
	Tue,  3 Sep 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtqc3EfX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC722AEFB;
	Tue,  3 Sep 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725330029; cv=none; b=aBYh2FOxqaE9OdvRVn7XeMx8XZ+LZ0HeXAIZ8fqLhw+rJlevCErc1bC6kgD+YwkGwO/A+9VmDef7CREoileRHtQfqC9ezk+chkZEhtlOB5+QRSvF01s3K5CnC4pdi5O9lFn0xXMkpaQak/mC4doZ4jpU4qtXOycyOmVBNuoL/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725330029; c=relaxed/simple;
	bh=IVklJmJbtIcbl0iJ4lFwAT3iIukWsUwkHeFlEeX1u3w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PB+/rlqBu/pCANOn8JLutR3eAKnlCPK2bRGSaA0S6nMDPo6obRDOmNlCG7gax8cLhKdVYocrrEd73U10NPPbPQCbCQ0k+m8Xq7+HOkvG1jvK1vxMFQp5XvlWL2AZWixb6tCL0jqo9XDIoLOttifz5LKHty/lED+v/rAM4UAsNBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtqc3EfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB85C4CEC2;
	Tue,  3 Sep 2024 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725330029;
	bh=IVklJmJbtIcbl0iJ4lFwAT3iIukWsUwkHeFlEeX1u3w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jtqc3EfX9nyxqZ+4x4WIg2mh80vivK5rEfRZvIS7x4UiW6ZaiRAuFHB3o37aDAJuW
	 X9eLGzmmKZmZzAtVO1wPaoPfSH+PAvuENm+qQZwouyazdLKUNJrDyBXe4hbUoDAf1+
	 kKaQA2ZE/kxHS5zwmdNZxrTjyRYsSbjbB9D/NcSq+JTRNz9luQj9UIWl+GIljnFHM0
	 jvhuCZmWmVGdeQhpUXxKAreeNr4Dk/Q5T8P/CBadviGfpXsQu35nAZIxOGvssu7ayZ
	 Kj4wAgQnVEWemULkmmYIvnN3edjzJgUaiLqhWF47ohJuiRRoiUcz/7ufW8RyR6zVwD
	 0m9JM4mqfHJBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348123805D82;
	Tue,  3 Sep 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-08-30
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172533002902.4035616.6998535667640215071.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 02:20:29 +0000
References: <20240830220300.1316772-1-luiz.dentz@gmail.com>
In-Reply-To: <20240830220300.1316772-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Aug 2024 18:03:00 -0400 you wrote:
> The following changes since commit fe1910f9337bd46a9343967b547ccab26b4b2c6e:
> 
>   tcp_bpf: fix return value of tcp_bpf_sendmsg() (2024-08-30 11:09:10 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-30
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-08-30
    https://git.kernel.org/netdev/net/c/5517ae241919

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



