Return-Path: <netdev+bounces-101060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6A8FD148
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A401F25CF0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517E92C184;
	Wed,  5 Jun 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cakhw4GA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6ED1F5F5
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599466; cv=none; b=OODcmT6wqRGLrOIrz302XavZcbLFPNg5zpd1LuqzzgLk8Nb4miaTSIBsms3XV+YUs5LYPqNQ9vIuwreKG613eaUP6vlBxsrHvpluFTTvwBiFuT8vrxwTRjsaJWh+m/v039l2a9Tqsd0syyLRBrnAwOartxLQKTVwGfqLh/kK9UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599466; c=relaxed/simple;
	bh=rda2qVr9ADSPvG5O/5cyHdYtuW3TTsHiSUUX0pgDfS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ezQ7+AFUoowO7Jp+vWhhupJ2J9s5mNFbSC6J+zRheKOTUxOBr+faiQgRenrMCd35sVzsx+JlGV3P0I71RcNDmVJCZ+TXvVQr2mMRcRZVxre4msnhlQm2QHhg3fyHYurR0zmBmz1PqpmTtCqeqTvMLGeKj6+NPf1m25Pl7KGPEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cakhw4GA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9BDC2BD11;
	Wed,  5 Jun 2024 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717599465;
	bh=rda2qVr9ADSPvG5O/5cyHdYtuW3TTsHiSUUX0pgDfS0=;
	h=Date:From:To:Cc:Subject:From;
	b=Cakhw4GAc+qqw1VnTTY9N5KcJKzISmT8oi3naUaYVeCGxxyQdUVlE/kqwjyE1XFDO
	 8gI+pbSSaz3wY99NdyJZqf8vgaVlxGW+8CKV3uMum7neBh9n+yGVM6HY6Sr4oIRJfH
	 nNw01mOcERIVYqEZNFwnQf2fDTctb7zN974WEQlXs9hJqmjmXRz0ukH6N5aBXrbAov
	 xs3xzD8t8x7CdvE7VupQYbMpUUxCNZmXP9a51M15mxUFY2XLMJwNRVzUB8QhY42ggD
	 DS7iPjmDZ9J6dga3v8oV8t0Mj2V2c5fVi080MndrRg1LNCCnu0hiE0IZ/u3klnVpWz
	 mGE3FYWJJww4w==
Date: Wed, 5 Jun 2024 07:57:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: namespaced vsock
Message-ID: <20240605075744.149fbf05@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Stefano!

I found you patches from 2020 adding netns support to vsock.
I got an internal ping from someone trying to run VMMs inside
containers. Any plans on pushing that work forward? Is there
a reason you stopped, or just EBUSY?

