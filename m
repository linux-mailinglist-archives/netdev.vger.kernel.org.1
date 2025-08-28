Return-Path: <netdev+bounces-217946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9240B3A7EB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE5A7A5B71
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A76338F32;
	Thu, 28 Aug 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxRKtoJC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA71338F22;
	Thu, 28 Aug 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402030; cv=none; b=drdGtXPGBCTtIGnEifqXBt1mICLt/mZWuCP66Ai7F9KlQzkyje34yEvXIk3pJoeSVQTSg/0uyk8D6mSOA5WS+8YztKa8knrUuBGN/Mfv9qoQdFmx5XHPwoHYQSmcooLu+hSWugbxljnzmVod+5wElC52HuXG7h2NzjPrdh6VIB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402030; c=relaxed/simple;
	bh=u+kT+uvX1lsiNF6Q9SN1xDI1dZ0DaacH8V/4zDo4fkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1FLicB1V8eOVYK8M0UDDdojTL3i0BKxFzRMozu4LndT9HptDEdzIm0iyAndj34fIZjZtoXVi9weTW1dCSP1Ba0ByJnY+K7OZsuX7HrADDzr+HVDogk65KlLbfdpsQl8UFqEFTYOyqI7xkgpRtmKvjSYvbCymIi8DkamPeZp+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxRKtoJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F146C4CEEB;
	Thu, 28 Aug 2025 17:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756402030;
	bh=u+kT+uvX1lsiNF6Q9SN1xDI1dZ0DaacH8V/4zDo4fkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxRKtoJCxZT7dyrXebZjmdVixndhhT3d20qgCE5O91UYmyBIaZwQict2A8MUCiyIx
	 rDyeUEsmMdvyfuHeRWK3impE2b49u9cv19UNrO9md4NqbIs3ynJfCvjmlqTutd+Gmr
	 WKba8JRPz+o7ZJCEImZAiXs8wTb3osenhvX/IDfv2ZttFvcxgCVpy1i9ris1teshgh
	 s0vjDJSIXH8UlLB7ffHamUrBhDRiRtnIkS/kkuTkXkaD5rJ506T8rMqE5oDtijn3jK
	 UzN9m8W1okHBjowGwScNnHI7379JgMn8sZ4ARr126JB7mM7rhsai+hsxlVfAjeX39k
	 fsti41fL9CRcQ==
Date: Thu, 28 Aug 2025 18:27:06 +0100
From: Simon Horman <horms@kernel.org>
To: zhang.enpei@zte.com.cn
Cc: chessman@tux.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ethernet: tlan: Convert to use jiffies macro
Message-ID: <20250828172706.GE31759@horms.kernel.org>
References: <20250827155455583-PdvmDYA9SD3J37_XRza5@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827155455583-PdvmDYA9SD3J37_XRza5@zte.com.cn>

On Wed, Aug 27, 2025 at 03:54:55PM +0800, zhang.enpei@zte.com.cn wrote:
> From: Zhang Enpei <zhang.enpei@zte.com.cn>
> 
> Use time_is_before_eq_jiffies macro instead of using jiffies directly to
> handle wraparound.
> 
> Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>

Unfortunately W=1 builds fail with this patch.

GCC 15.1.o says:

In file included from ./include/linux/bitops.h:7,
                 from ./include/linux/kernel.h:23,
                 from ./include/linux/cpumask.h:11,
                 from ./include/linux/alloc_tag.h:13,
                 from ./include/linux/percpu.h:5,
                 from ./include/linux/context_tracking_state.h:5,
                 from ./include/linux/hardirq.h:5,
                 from drivers/net/ethernet/ti/tlan.c:32:
drivers/net/ethernet/ti/tlan.c: In function 'tlan_timer':
./include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
   12 |         (void)(&__dummy == &__dummy2); \
      |                         ^~
./include/linux/jiffies.h:149:10: note: in expansion of macro 'typecheck'
  149 |          typecheck(unsigned long, b) && \
      |          ^~~~~~~~~
./include/linux/jiffies.h:292:38: note: in expansion of macro 'time_after_eq'
  292 | #define time_is_before_eq_jiffies(a) time_after_eq(jiffies, a)
      |                                      ^~~~~~~~~~~~~
drivers/net/ethernet/ti/tlan.c:1846:29: note: in expansion of macro 'time_is_before_eq_jiffies'
 1846 |                         if (time_is_before_eq_jiffies(priv->timer_set_at + TLAN_TIMER_ACT_DELAY)) {
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~

-- 
pw-bot: changes-requested

