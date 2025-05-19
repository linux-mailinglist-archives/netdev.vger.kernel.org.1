Return-Path: <netdev+bounces-191547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63569ABC016
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 16:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C2E188821F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED6A27C179;
	Mon, 19 May 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWFahmit"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B226E15C
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663244; cv=none; b=pV/NAxYigjOxwZyyPAFL65vGs9C+fHCxoSMHbXTHqFvb1oVqtbURflW50kIr/Sb7xe2KYMk/bdBOgm9N0nBho4oYnXDBolzP0cSm+hd/kwp1uACs6Nho3P0DTsu3IPqEd8d0aeBuXANmrrsPl2fIkwSHA6ONlC1PZfHhCyE/rRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663244; c=relaxed/simple;
	bh=KUbCkR/S+G6cIrwc8uGCrJ9Wp5dd7McV34lfXBmiKS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a89Q3+YVrDbLAgkyEoie1USRnUMkN25z1n51y71kOio0Wun+SJWDQKCvrU5S2NO7S/9SYOY06MJxcUntmcFI/EujC97BbgcXTeOc/xfnEREmHAwZjQ4st6xDGVvSxz4xLlTA5Su/F6k0QAqhJztZeuxrNBqwDg71j9VGuvNmYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWFahmit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C44EC4CEEF;
	Mon, 19 May 2025 14:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747663243;
	bh=KUbCkR/S+G6cIrwc8uGCrJ9Wp5dd7McV34lfXBmiKS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DWFahmit+L7XyV0j2UEmB4cyPVlaaN3rlaDZEnAWGZ4ixxUHA2B9uEXTJTyI1+BLA
	 ZQVkITgXFYwjXrSFnhtZ80s9f4+fYArSOuQ7m26ri8IWOKqGbdEmhGlh1UIXQWy/G5
	 Q7QjoOVAxfnJC4sgbsSI6x6UWsZXuBi/pn5oXwpoJgGfCdsU63WiAjjy1D/SGQvQCU
	 QxMAmhOdq3FV5Wp2ntEihp4hqwG23pKjh5X6/kZVKVdysjSGH9pyJiJooDBARnbPvz
	 IPe41lQEIKUcTo1FXHscZOobbo1/vYwFkbbehIXsJoXIzfK/rxE1B8gYJ1GEUrXtQc
	 M1lkpT27+5X+w==
Date: Mon, 19 May 2025 07:00:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Simon Horman <horms@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 0/9] af_unix: Introduce SO_PASSRIGHTS.
Message-ID: <20250519070042.662fceb6@kernel.org>
In-Reply-To: <20250515224946.6931-1-kuniyu@amazon.com>
References: <20250515224946.6931-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 15:49:08 -0700 Kuniyuki Iwashima wrote:
> The v2 of the BPF LSM extension part will be posted later, once
> this series is merged into net-next and has landed in bpf-next.

This breaks existing BPF selftests ever so slightly, I think:

Error: #358 setget_sockopt
  Error: #358 setget_sockopt
...
  test_udp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: actual 0 < expected 1
  test_udp:PASS:nr_bind 0 nsec
  test_udp:PASS:start_server 0 nsec
  test_udp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: actual 0 < expected 1

https://github.com/kernel-patches/bpf/actions/runs/15112428845/job/42475218987
-- 
pw-bot: cr

