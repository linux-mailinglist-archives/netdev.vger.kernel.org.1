Return-Path: <netdev+bounces-86530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF5389F1D1
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949851F22BDB
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7615B124;
	Wed, 10 Apr 2024 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXTgv6nZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6415ADBE;
	Wed, 10 Apr 2024 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751264; cv=none; b=LKcVH4Fj6VhMHOY8Ls7wg8se9zYFv1RESrnxPmgjoTcZFC2g8BHbxggbg7b4JmgXwGg2ylisaL6b8rKXAx0mJwzURsH9Vr9YZWLIyuxL3G1Y2lgeReQ8T6G5XFxNpbVgnO5xldifFsOhzCq+kUC4/lhw4SM0ZfXYf7eIqoy4VLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751264; c=relaxed/simple;
	bh=OaX/6ylrWPUnuJtLPhgRUaBtWsP+q2WReYTskGc5dfs=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=B95AR4DZfH1bBOjjTorIy14jJt/CExBUUAL5dy+0JilNHM0YvavI3P2RADqAoQk1sZKqxYLItXtpllEBuFSOsNz5oc7AkYfgRi0OcirrDt4EP7bvHkwn2XbeAni3onXQj79H20v0PcJpG6kjdHiBpQKKieNjhVd0sBcxqClpNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXTgv6nZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BADC433F1;
	Wed, 10 Apr 2024 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712751264;
	bh=OaX/6ylrWPUnuJtLPhgRUaBtWsP+q2WReYTskGc5dfs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mXTgv6nZvTjb3TpO8M/LFBfH/GBFA57yKOrKp6YSm8fnUEZ7b9IW+uLcW3SUo3+us
	 Xyf9J9gCkyVWlgJL4xEbkPvFgrB/0wVQkbwxyaWI3pu/G0p8uOzvr4sF63gIONBNEL
	 YBY2zDIzMFf7H8GdI1O8wwhijKDoWaeiFJ9RA9PnPB1OIYL7eRtWXjlnwSQJsiDQKv
	 n6Ro1AhAgTlw4gHFxpsqvIGsc8mmzXGdm85GBcdaxpc5VBOiJnCT20pj6WRQMn4cek
	 yM4UkqN4WGgFGdw5/rxHRmqzfz+NeF8FUv6+FUKd98ak8SvR36EQYShzOZHRZSGcJZ
	 nw0TNq01dc+Lg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240409100934.37725-3-kerneljasonxing@gmail.com>
References: <20240409100934.37725-1-kerneljasonxing@gmail.com> <20240409100934.37725-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 2/6] rstreason: prepare for passive reset
From: Antoine Tenart <atenart@kernel.org>
Cc: mptcp@lists.linux.dev, linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, kerneljasonxing@gmail.com, Jason Xing <kernelxing@tencent.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, geliang@kernel.org, kuba@kernel.org, martineau@kernel.org, mathieu.desnoyers@efficios.com, matttbe@kernel.org, mhiramat@kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Date: Wed, 10 Apr 2024 14:14:20 +0200
Message-ID: <171275126085.4303.2994301700079496197@kwain>

Quoting Jason Xing (2024-04-09 12:09:30)
>         void            (*send_reset)(const struct sock *sk,
> -                                     struct sk_buff *skb);
> +                                     struct sk_buff *skb,
> +                                     int reason);

I get that 'int' is used instead of 'enum sk_rst_reason' to allow
passing drop reasons too without casting, but that makes understanding
what should be 'reason' harder. Eg. when looking at the code or when
using BTF (to then install debugging probes with BPF) this is not
obvious.

A similar approach could be done as the one used for drop reasons: enum
skb_drop_reason is used for parameters (eg. kfree_skb_reason) but other
valid values (subsystem drop reasons) can be used too if casted (to
u32). We could use 'enum sk_rst_reason' and cast the other values. WDYT?

Thanks,
Antoine

