Return-Path: <netdev+bounces-67390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3BC8432E6
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 02:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B08A283C33
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 01:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305FC184F;
	Wed, 31 Jan 2024 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKoPAyRN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB51849;
	Wed, 31 Jan 2024 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665661; cv=none; b=Vx7y15IQPHTeT3p3ksvjcBL3tEwskwGAEAPHo1O16hJlihGB4hSEy9xZKCoNfzNQtL6XhTRKx5wueq2+suLCIOM1P1lgz8jSgGxvD0K5MqupjDibPlAe/oj0VtNfl6Rs3qbY4+AG42bn5R5Gj0+JtdxXbJ+rQS5tSPTxmXxTTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665661; c=relaxed/simple;
	bh=YE+fSNLLGhXaNKqNnAJc7wI5mkYohvK3KykEhUCuZuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZO2Ct3/4YPcoVyC7kPzth8u6TzIQDeaKJ+TjMjmu+Ka3ThWo/DBEwtbsFOnsk2rCnuHYsm4Gf/Q2N7iwLT6He/EHArznQPNcP0PCXdCxm1QrsG5XL0vUpgU+RR12pKTgWVnqJtDbgkP7EdgsoOf3DLfSY8UXdRDZRxCw9/I4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKoPAyRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2E8C433C7;
	Wed, 31 Jan 2024 01:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706665660;
	bh=YE+fSNLLGhXaNKqNnAJc7wI5mkYohvK3KykEhUCuZuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QKoPAyRNu2HKIK9fn+FvYleSQOkF27/oP47x2c+lEB7Qnusn/zC3KZfevoQiOmw5e
	 fhaGHIo7P9znNU3i+Is8WWfknUF2VqjJDSykwsMQ6CV4Nx9RoUwTbt2QM9TxOIiAUg
	 X3UcnRx2PU4zCkva7P2NbNCLIeEJsLMxH3w0f3qRpQwkMcLrDE+1Zq9ZVFDBJAyPV8
	 1WrpY96eM0fSALao7yse1f7kvoxpb8isMpygf+GM71jv8dmhnqVcf/WREB3uYNJtTT
	 fr3fyvdBX/bnq+xNV6nD49C6nRBYyxwryqo7GHuebD4Wki+lpY5BguTu8QMr22N09a
	 3MyJ5vnFC6NqQ==
Date: Tue, 30 Jan 2024 17:47:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next] selftests/net: calibrate txtimestamp
Message-ID: <20240130174736.03c79071@kernel.org>
In-Reply-To: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
References: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 21:31:51 -0500 Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The test sends packets and compares enqueue, transmit and Ack
> timestamps with expected values. It installs netem delays to increase
> latency between these points.
> 
> The test proves flaky in virtual environment (vng). Increase the
> delays to reduce variance. Scale measurement tolerance accordingly.
> 
> Time sensitive tests are difficult to calibrate. Increasing delays 10x
> also increases runtime 10x, for one. And it may still prove flaky at
> some rate.

Willem, do you still want us to apply this as is or should we do 
the 10x only if [ x$KSFT_MACHINE_SLOW != x ] ?

