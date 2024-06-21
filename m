Return-Path: <netdev+bounces-105616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 358C4912054
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B421F2417D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39AB16E86E;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym9TXzQp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011E16E864
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961631; cv=none; b=L2REPb7CLeOI/80RP9KrVwsg1Y0ZvUczKEspyIXPXQyuze1ILqYZIVLy65JtUIMs6pn2UqLLARwrslwi1xQuTlQJc4QjzUp9db6ZySQZSPb0o1achFVBCMJgyIvLaCCo42RrWCMQLxrPjOJfNiGgzUYmeu6KEHMU10h+r1/CCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961631; c=relaxed/simple;
	bh=Ntxch3hTMcx/5ZdXBZM5nFkRJHBDiAqX/obQ0bPyW0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GF2ZjYmqgKqTm/jnFCcE56N6hcqXwhJwlOM+2Yuq4VorC2S75ZQsiWpDHWLWlIAId4WeKYJ0U+oVKFWQKTSdZ2FKgPerV9AGNvR3bOOvY6FzNei3ua8cWtbC/4fT9Ucw4W5gX9G2u+/Gk6VlwZQqZ/xE/DmMFZUHBSH/0ojMbXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym9TXzQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63670C4AF09;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718961631;
	bh=Ntxch3hTMcx/5ZdXBZM5nFkRJHBDiAqX/obQ0bPyW0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ym9TXzQpJl/BOZtTJAnWvMOISnGDsTc5kVjfPSc7ujoE+3XIBJDwPjB9/uG8DxzKV
	 C3wzp7V78tahdfqAMkLCkVn95Fz4wsQXs4flH8nRU5F3JnsMSqVaVuHfbLkWQtreUa
	 jGIZGGAlC/QMcO1erTGmghFbIrMsTOoIC5iArozK8Vh9flfWOBa2Dz8h4J6n0q0OtT
	 785f2IZ76gLMxzIVcwkKrvas8BhPQnQ4O8LdOyYzTlUcvdiY3U+laeI5q7Zvlooab1
	 l5eDK0bQRVLSSMN0tIzvZFuH685XZ3xQe6IXhGx0R1kbiWTamzJ8u7UywHdt8+t0Gh
	 QYYKjZL3qnHhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B914C4332D;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] bnxt_en: implement netdev_queue_mgmt_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896163136.20195.9908582965018289812.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 09:20:31 +0000
References: <20240619062931.19435-1-dw@davidwei.uk>
In-Reply-To: <20240619062931.19435-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: michael.chan@broadcom.com, andrew.gospodarek@broadcom.com,
 adrian.alvarado@broadcom.com, somnath.kotur@broadcom.com,
 netdev@vger.kernel.org, asml.silence@gmail.com, kuba@kernel.org,
 dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 18 Jun 2024 23:29:29 -0700 you wrote:
> Implement netdev_queue_mgmt_ops for bnxt added in [1]. This will be used
> in the io_uring ZC Rx patchset to configure queues with a custom page
> pool w/ a special memory provider for zero copy support.
> 
> The first two patches prep the driver, while the final patch adds the
> implementation.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] bnxt_en: split rx ring helpers out from ring helpers
    https://git.kernel.org/netdev/net-next/c/88f56254a275
  - [net-next,v3,2/2] bnxt_en: implement netdev_queue_mgmt_ops
    https://git.kernel.org/netdev/net-next/c/2d694c27d32e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



