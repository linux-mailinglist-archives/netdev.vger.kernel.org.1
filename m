Return-Path: <netdev+bounces-64864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071BE837510
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EDF1C252E8
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABE447F51;
	Mon, 22 Jan 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOh9Pqeu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAB481A2
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958020; cv=none; b=ik1BAsXTXXk7V8DxNEGEOC6z86mOadrsMhAygAFd9xb4Fzz3LV20joIerix/neGCFocUZsWM1TDGiVtS/XkuHiawkw+OxGpHHsG41U/1ial0B73KfA5hSKD5qe5cNoJpVFBUM8gTbk9oiDgvcxe6w3aVd+xjCDoPkKSB8Qlt7hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958020; c=relaxed/simple;
	bh=oWfpFhw7Ek+n1Zh3HX40tT1TJ8CRO24ISYxAqJq3T50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ywm+yFfQiYJOkJD6tEx2UGomYJCxh5cIjWyw5U28pU6rYDvDxX1fjRXUJn2Ez9/iLUlZ175EyoFmphAeQwLkVRcNJubkiqeUL0w4d7KCCyUI55zd4aCBquz0Za9uOGHFsJB872D+kcvkQBgchAvle8EYjj8iL2UMnoGAGMXMLlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOh9Pqeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB16C433C7;
	Mon, 22 Jan 2024 21:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705958019;
	bh=oWfpFhw7Ek+n1Zh3HX40tT1TJ8CRO24ISYxAqJq3T50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DOh9PqeusFwf+udikou09RJQerrA9f3QPAssGAyyThou+FzpXr3mTEbJV79CsB905
	 tGRlmwg+hmFgY35dp65i+q1f0ya4af+zFBHF10Ub+aqa5o7uk5XbmjltgVUcsacpsP
	 oXBvodVUOiOpZvX04hXr4JngBuC18yHgZNEVxdco1QRBOB4KGcaRWpWnkQRwWbJgXa
	 tIDiySOZYWzOsqkpYL3VhYF0EPixUl79IAEu4pyMtQ96l0KTghE+fYllQhirT21jUz
	 3RRjvm74bZMiZJztCn2dYXXFct+Z0htV6DmN1atiJ89TDQBto5KMDehdrSJW2TpCTS
	 SP2PZk/1WUmEA==
Date: Mon, 22 Jan 2024 13:13:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net] selftest: Don't reuse port for SO_INCOMING_CPU
 test.
Message-ID: <20240122131338.7c691d32@kernel.org>
In-Reply-To: <20240120031642.67014-1-kuniyu@amazon.com>
References: <20240120031642.67014-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 19:16:42 -0800 Kuniyuki Iwashima wrote:
> Jakub reported that ASSERT_EQ(cpu, i) in so_incoming_cpu.c seems to
> fire somewhat randomly.
> 
>   # #  RUN           so_incoming_cpu.before_reuseport.test3 ...
>   # # so_incoming_cpu.c:191:test3:Expected cpu (32) == i (0)
>   # # test3: Test terminated by assertion
>   # #          FAIL  so_incoming_cpu.before_reuseport.test3
>   # not ok 3 so_incoming_cpu.before_reuseport.test3
> 
> When the test failed, not-yet-accepted CLOSE_WAIT sockets received
> SYN with a "challenging" SEQ number, which was sent from an unexpected
> CPU that did not create the receiver.

Tested-by: Jakub Kicinski <kuba@kernel.org>

Thanks for a quick fix!

