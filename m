Return-Path: <netdev+bounces-209407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD62B0F85A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD40DAA6DF8
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C671E5B72;
	Wed, 23 Jul 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8k8wR8+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7986328;
	Wed, 23 Jul 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289243; cv=none; b=fVt7IcK+rs5yl2qDZSky0xLyaJ6WX9siEVp9QTWyeSI7LzZb9+kqaffONQnb0gfad53/wMOaSJZvZG0fZUyxZOzU2qsvNMpkuspdHMNyA7CHpkSsziZQmbkB9j/aH1coFjp8GoqI6LgbVVq5btD64kazrnSZHueXdxH7TBeGa80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289243; c=relaxed/simple;
	bh=Z6vG8MGgVxWwLfr8GOJ9M9wDfu96wcG3fGhvFxzOBxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLuPegEaHLZSJxsyttMi1hG0oEVjBmkaAVW9RhPTmCE3axMEDYE3iwtoCJPEU9fT9HP/RJidqFY/ijQljcYAmqGK7H7IjMa4MGZKcyN2C2im2mcbb/WyM9cIfbh65Tjmd4OamQXJtx/eGdbn2nhogKDDYVvia7o1++lmL2k/ICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8k8wR8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48783C4CEE7;
	Wed, 23 Jul 2025 16:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753289243;
	bh=Z6vG8MGgVxWwLfr8GOJ9M9wDfu96wcG3fGhvFxzOBxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I8k8wR8+UgihugNbKZ3wgiu9PcZ1ob5FEv2U3EtH339yOQtmmAysD1R4YCZALeHUp
	 JTEFXIj67O9SZ4AfCG8Z2ldmoqocxqgM71QzIo2TOv4eZoJhElJxldnPxU5ZgrWg4R
	 RbjUqY5DDn9UfY3VN4bbidB6LPEtvXnpamj7cKSgH42I4Ma+p75dBm6kI1zc5qX/XC
	 4GFN5WyCQGZIPJyCpEFd8WG7aqsVLXCGMXhCErhV8XuLhPQIvr3r8FfcBEN2UYv0yZ
	 LG00+UytB+64df/JtZfslYc0IjGMw6LcYdAIzddvSdtETSN5ndZ5qznoQBIYnfnzgg
	 DJpxfvWCtonXg==
Date: Wed, 23 Jul 2025 09:47:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: dvyukov@google.com, edumazet@google.com,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzbot@lists.linux.dev,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: net: Revert tx queue length on partial failure
 in dev_qdisc_change_tx_queue_len()
Message-ID: <20250723094720.3e41b6ed@kernel.org>
In-Reply-To: <20250723162547.1395048-1-nogikh@google.com>
References: <20250722100743.38914e9a@kernel.org>
	<20250723162547.1395048-1-nogikh@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 18:25:47 +0200 Aleksandr Nogikh wrote:
> On Tue, 22 Jul 2025 Jakub Kicinski wrote:
> > I think this email is missing a References: header ?
> > It doesn't get threaded properly.  
> 
> Yes, that was indeed a bug that has now been fixed, thanks for
> reaching out!

Thank you!

