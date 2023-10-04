Return-Path: <netdev+bounces-38127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF767B9852
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0309C281A23
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F4F26293;
	Wed,  4 Oct 2023 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvnJKHHo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442E10780
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 22:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B76AC433C8;
	Wed,  4 Oct 2023 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696459570;
	bh=8ro/a0Bpol+VYScaDsgjBSknL1h5UTqtEB8kDcWMyG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jvnJKHHo4Zwbi3zpqsrtxGJ92sSZrwqygzCu0OelPHkLTm/cKqtk7YzSw314/QR6y
	 BLtw0idqiTPN+2QQjkumlEUJx47RrJAVBxAq8RvkE0gNYBn4AxH0yvV3Y90R/q2uWw
	 /TqVex7OdZ4VK35V1CkiFU+eiMWGOEi35Cwv5mca4xyBhCYPWb5rxXYIw/5yUlwuya
	 7oTaZLFVbM9KlruwAsBPpWgknQTO/v/HTR2IVZLzBHAEar39ZmLU+w1hTI0YWj+TxS
	 8FIFxL4c59v8FlId6w+XVe5zvWikhfuLNb6xqA4E01SoPCDigvbOBYKqIxFQzg1nlM
	 MMmJmwdq6IHgw==
Date: Wed, 4 Oct 2023 15:46:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Wander Lairson Costa <hawk@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or
 optional).
Message-ID: <20231004154609.6007f1a0@kernel.org>
In-Reply-To: <20230929162121.1822900-1-bigeasy@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Sep 2023 18:20:18 +0200 Sebastian Andrzej Siewior wrote:
>    - Patch #2 has been removed. Removing the warning is still an option.
> 
>    - There are two patches in the series:
>      - Patch #1 always creates backlog threads
>      - Patch #2 creates the backlog threads if requested at boot time,
>        mandatory on PREEMPT_RT.
>      So it is either or and I wanted to show how both look like.
> 
>    - The kernel test robot reported a performance regression with
>      loopback (stress-ng --udp X --udp-ops Y) against the RFC version.
>      The regression is now avoided by using local-NAPI if backlog
>      processing is requested on the local CPU.

Not what we asked for, and it doesn't apply.

