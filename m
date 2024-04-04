Return-Path: <netdev+bounces-84680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61245897DB6
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 04:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8151C21EE6
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C01B1CA8D;
	Thu,  4 Apr 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1TnjmBN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC66B17FE
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197830; cv=none; b=p5sUDgX1UOFZKVR24aAb54vUs/cz7C6Trsz1twS4IsF7+ZTLbR4cxEl9ARy+yX1sELIb4N+NrpNDXe6LIbgfVYj7EnaKxOEp8LdJc1sPyHroV21q6GPASwxvRDbeU1fCN3hYqpAH03yOLiZAl1TfEhCJpm0RZHZniPBGgh3gUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197830; c=relaxed/simple;
	bh=k9tXTUxeCYIAG46NLFfM5wL52mbKoIol+mWzhLrPXfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fs2qmTv8wdxJCrZGcFZtjlEEb/g/SsPMTUN/TTgtdQ+KDaKIPIzBb3c8e3/PT1T1OXE/8idFg5XYpt8HUScjigpKNZzjz+YtUKYicHUpubz3sLrxEqVW3wX1UxqIuUDrVjpw+ecagylEKeJ3aNKLcqJYVSXeM6kX6nPfrI7Ju5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1TnjmBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD0DEC43330;
	Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712197829;
	bh=k9tXTUxeCYIAG46NLFfM5wL52mbKoIol+mWzhLrPXfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L1TnjmBNO19r6FqFYFCA1hf9T7EYjjQPd5M0ItmZGgK+EBptCd/3R6r+iYyxBwdkX
	 vMoQatLRRtsa9MaZrzzkwt1zSCyhIgsLqwoWgm1LdPIlFr9tJ00JfKSzJFBI+7vGyS
	 ad2te9eGViyuWkUQrWc+V5A13sUiwhZwu/lf9ENONl5OlCU2Oh+KT0oXY2WaLm3Lx6
	 rIu+QUYDeaHR9yRDr9zlRxFafd6TOhv7hJbOH+hKrzQInZZWjGmk/N7eiT6BcXsCB3
	 kEEmv+GqRjb5BEhXiJ72zHu7I4v9EdvOeMkame8xEHaLWbgBrIHw0ylWZUJPAZVbvg
	 yQfC2krU73CTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC462D95068;
	Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net v5] net: txgbe: fix i2c dev name cannot match
 clkdev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219782970.25056.12493154581367962567.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:30:29 +0000
References: <20240402021843.126192-1-duanqiangwen@net-swift.com>
In-Reply-To: <20240402021843.126192-1-duanqiangwen@net-swift.com>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
 andrew@lunn.ch, wangxiongfeng2@huawei.com, michal.kubiak@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Apr 2024 10:18:43 +0800 you wrote:
> txgbe clkdev shortened clk_name, so i2c_dev info_name
> also need to shorten. Otherwise, i2c_dev cannot initialize
> clock.
> 
> Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,net,v5] net: txgbe: fix i2c dev name cannot match clkdev
    https://git.kernel.org/netdev/net/c/c644920ce922

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



