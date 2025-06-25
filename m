Return-Path: <netdev+bounces-201333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1765AE90C8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2353A9A1B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7026E6E6;
	Wed, 25 Jun 2025 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJQNRqnU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DBC211A0C;
	Wed, 25 Jun 2025 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889362; cv=none; b=D3L+qxtaHIdhhxHkKzCFngi4IoOIKfm5Zua4qDCUbX9Ps5l4WlFpu8+hL28ATLJ7h7vHZ2pCCw+grGEgv7EbDxXwndpsWc+qllGDw/yRTaesY1o0mUzkYxTqn7fginTLqg6aMCqe5HStkmgO00sPcUkVR64sslhA3vJ1k+pAVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889362; c=relaxed/simple;
	bh=K8hHE5BWmggPKab7FKtICo6ynYffcm2eR2dZZ1FkYNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhlullpxoEnmfrdC8wpSlaL6+ZLbWZ8eRL93kSmH+vwiK29LEWdRrQLAyaN8OoQ6ze9dKp6NUIhaUSzFJOgydJKsWDnc8DEsQx3YTXtBqynTu5XQHaByiCJB46WG2rghwC/0ympd04eDyzQoJZQzl3oHT7OdEFVqdJbS4Ua0dAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJQNRqnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4668CC4CEEA;
	Wed, 25 Jun 2025 22:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750889360;
	bh=K8hHE5BWmggPKab7FKtICo6ynYffcm2eR2dZZ1FkYNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MJQNRqnUjWFvzLaZtXp9rAauXn/F4/7OgmR/Ws7IehK6DhRybonES8LtVH1hKqFyk
	 XJ09ikivFTpgEBCt4OStNtFBgjrr2BF2dRnCOX3YXqM4hE/z+mucHGMN5CDaeBmVPR
	 eZ06EcaRc+sqpe5wDyhWRlCGt9Sfplj6CFTBCr2xPzMs38D07nowsriGwZgkjjuYDH
	 bKCLZrwoGRZjy58GnssldWEV6BTL7WYqVXz6KA5rZFlXnochWVZNKAI6rhGbUnTTVV
	 4cAk70WM04bw5dYi5C6WwQeDZrNLel/Ymx2Hzg0X8hHY6k+VFbfX1YAGDV5x/ivBxn
	 fWzV+xhTrzqjw==
Date: Wed, 25 Jun 2025 15:09:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next v2 4/4] selftests: net: add netpoll basic
 functionality test
Message-ID: <20250625150919.7b06b436@kernel.org>
In-Reply-To: <20250625-netpoll_test-v2-4-47d27775222c@debian.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
	<20250625-netpoll_test-v2-4-47d27775222c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 04:39:49 -0700 Breno Leitao wrote:
> +    raise KsftSkipEx("netpoll_poll_dev() was not called. Skipping test")

Let's make this an Xfail. Looks like the condition doesn't trigger 
in VM testing :(

