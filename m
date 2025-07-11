Return-Path: <netdev+bounces-206232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D79CB02410
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 20:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBEE1CC571D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C62F3C0F;
	Fri, 11 Jul 2025 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLtVZ9Ra"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D62F3C03;
	Fri, 11 Jul 2025 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259604; cv=none; b=N63nusfvEy0w6RdA776jjkaQQOPZPparvetUyx53JJoZtso80HY3WeKjyaGIN7O/2x1zuzxaaC0WlsVA9+2r8vHBmMW1lFyissyVJzVpX4Px1h0BxDsaojyaWeg4jfYQiKE94PeEqkFxZJxqJ7kluNGk8mKO1tXggPovHCF0kWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259604; c=relaxed/simple;
	bh=0TkEIXf++g99C3zeGWDyX2nQea6CDn0SC/EAE+N4esw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAnWsyIdojvl6WL7SaXZD7OMo+oRFziTKtov0h5Ywt619M1zqbStRBRZm9rUsJqmHA9qcyoAOW5pzjGeyhZnYKv0VSqxjDLPIDsgVrzhKVxBfu/6OiuvIdBD0QJ63gRfyaMLKYaWq3QyJXuS9MTTKo92nrRb/iql/fXuSN0C7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLtVZ9Ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51366C4CEED;
	Fri, 11 Jul 2025 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752259603;
	bh=0TkEIXf++g99C3zeGWDyX2nQea6CDn0SC/EAE+N4esw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CLtVZ9RaATumi99vK1TwLAUyC3evJEVu45rsgw26SqLhupzDXjPoGnokgCZVVT3t7
	 t0fX+pPPgIVAz5F+VPJnwppL4u+Cmex1b1ldxbioJmvbZZBybMceAu4JxAWLB32tTl
	 8/lqHQnmVoaBmRwxO0vAynKg9BMaVpUJS6aSYNjpQtFxv5qAxQ8Vl/WefYKVpQNQPY
	 TGUfOlB+VVURQgWl0niDDnzEQnhmI94dkD4qhtC8z3n1G6JR+2cZ5VkrNIYX/BSqzs
	 OJP4X7Q44YMTMTHCOEaZVlkKzCwX/4nfptVFGtOEbIx4DpmdSU1MZERnD8TudaSRsT
	 yRwuM4cBTyC7Q==
Date: Fri, 11 Jul 2025 11:46:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter
 <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
Message-ID: <20250711114642.2664f28a@kernel.org>
In-Reply-To: <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
References: <20250711151002.3228710-1-kuba@kernel.org>
	<CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 11:33:10 -0700 Linus Torvalds wrote:
> Because this "emergency PR" does seem to have turned my "annoying
> problem with timeouts at initial login" into "now it doesn't boot at
> all".

Hm. I'm definitely okay with reverting. So if you revert these three:

a3c4a125ec72 ("netlink: Fix rmem check in netlink_broadcast_deliver().")
a3c4a125ec72 ("netlink: Fix rmem check in netlink_broadcast_deliver().")
ae8f160e7eb2 ("netlink: Fix wraparounds of sk->sk_rmem_alloc.")

everything is just fine?

