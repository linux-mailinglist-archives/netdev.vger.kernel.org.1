Return-Path: <netdev+bounces-139594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D039B3792
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AB82818ED
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E31DF247;
	Mon, 28 Oct 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8rOGRv2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5E1DD533;
	Mon, 28 Oct 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136180; cv=none; b=UksdfVu7ZJx5yuW7MiEoWrZEczU11M/lPyBBIwD+nOXV1qNCsRRKfx1nWc3CP8dGlADT/UlSs90YMCiU8lFRpe3C/JEG6mKA6YW/u0drechbZqGGaMykQOGV6ucCmFNI6LmCTAV8YrHIPrc/fb9UX8JJX+bPXD9ViRohzjuFWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136180; c=relaxed/simple;
	bh=xzyG4rIG5C7NfzKoivllrpnpChoOceA95/YZP5TXOBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMmknqNKTrBsslg8Mu5B4Vu+ru4zkVV+vNLMSu6CVBFso8+l16VqtyHVKKXTSy9JCvuMRhzdA9jxNRAKkiNZPRbFuLxCpCWJYYNquqGTo4EYJ7JbDNvBplagR5olRHpKJpjvLMICg842V2uharbMZywdV5KG5AK8c4Tz6SZeSu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8rOGRv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63381C4CEC3;
	Mon, 28 Oct 2024 17:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730136179;
	bh=xzyG4rIG5C7NfzKoivllrpnpChoOceA95/YZP5TXOBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u8rOGRv28WhU00GY8g97ElMpxfrBFsu8p9Sj7xYCmUzSbqYb2VNr5leRbeRO7D6Qa
	 HwdroqUjZ6igtFcB3gnBbbz79FIY0vuR3vQtRfO54JjduDutgi/NN4u7L5XO3FZemq
	 8GLlVIprsUulVVIY7NnA02KJiirbS1CDPWgAFlGfWBi0qZ2tGOuXpO+z/Dk3AXTuQc
	 S2KvlfRQRD+LB4hs2raRRolBrmuqd18PwqUNnEIle/c8IamYhXoLmRRJ1pK2ySVFgL
	 LYwJhAU7crpypYDN+RzO5oXiQ+mkn8pfVSyTPWgYJhBBpndZ5CXxwvdP4v661Y3mkp
	 KVb7KZgZcUAFg==
Date: Mon, 28 Oct 2024 10:22:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joel@joelfernandes.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH rcu] configs/debug: make sure PROVE_RCU_LIST=y takes
 effect
Message-ID: <20241028102258.3bd81eeb@kernel.org>
In-Reply-To: <22df18fd-4db4-4bf6-94e2-5a45aad91680@kernel.org>
References: <20241016011144.3058445-1-kuba@kernel.org>
	<22df18fd-4db4-4bf6-94e2-5a45aad91680@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 17:18:47 +0200 Matthieu Baerts wrote:
> https://patchwork.kernel.org/project/netdevbpf/patch/20241016011144.3058445-1-kuba@kernel.org/
> 
> If the impact is important, it might be better to target linux-next
> first, no?

Thanks for testing! I didn't anticipate it to be so effective.

Looks like it's not in -next, yet, and we got an Ack from Paul 
and co. so I'll toss it into net-next.

