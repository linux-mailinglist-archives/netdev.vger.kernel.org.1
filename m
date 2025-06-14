Return-Path: <netdev+bounces-197771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A677AD9E11
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 17:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409C8177E8D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7101B87E9;
	Sat, 14 Jun 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+18YWI4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C437262F;
	Sat, 14 Jun 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749915007; cv=none; b=LP1SYo9lWzC1AXN9nZpwGKJVjCt7QOfj3LuYPAHXDMpJezeO9bvnn+ISaeCfi4bXJGCxGxX4JLV8kblWRWOHely3kpv4e4fvLSieL0vACVA89yQRNJfAP3y2ql9sMAk/+WnZ31vVxkGgCJCW9GeOvRjVM1MlW+l12qlJadpKEWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749915007; c=relaxed/simple;
	bh=kihjM48CVgWsBERtG/oR5pSiMdZjTVyrPcUAW19SvAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLdcKNR3zZSMeK0/3adGuMqJxFnG+6cfxP4/u5fCiCDeWF9ducDivyMvByD6T2lZ/MdCF3Y5aonreguz6HEC5Yhd56IGjO6LxesrTfvsbsd0Ox4b5mOifS3aEdOVTgNFKKPR58OVSgZGxKAaLWuMPTq6jYFYs2xKJfG+VeWJ4KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+18YWI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC88C4CEEB;
	Sat, 14 Jun 2025 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749915007;
	bh=kihjM48CVgWsBERtG/oR5pSiMdZjTVyrPcUAW19SvAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+18YWI4cBH6MO8/2hvsVBkNCWQmYtr6B+bmgoz+L0ac7ZT2Mdn97n2qJ1rXpU4nR
	 nJD6m/ndxzjU5ek75GL6Tq+v790SC5fkLJL5Htoctg/FeAzccTMtv0cUIo43mKUFZJ
	 y+oUCGb+kDDE31mEMu1JSJEdIfYYQe77KoBEzWDzckyxjjqq3ocW9acSg4dwb1duqa
	 Mp53eA4KBe+yvZmJZi4h+t1xJLiSxq5EFXgjDLf/S9YAgECskSUxefaP6UA8jOn8/J
	 0scoPhAvZeTsGdjSx0+20QKWK+SSe3pC/2SXeebVitZId/BwGVdwrb0iETdjkH3S94
	 f01CQOeJrDTPQ==
Date: Sat, 14 Jun 2025 16:30:03 +0100
From: Simon Horman <horms@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH] net/tcp_ao: tracing: Hide tcp_ao events under
 CONFIG_TCP_AO
Message-ID: <20250614153003.GP414686@horms.kernel.org>
References: <20250612094616.4222daf0@batman.local.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612094616.4222daf0@batman.local.home>

On Thu, Jun 12, 2025 at 09:46:16AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Several of the tcp_ao events are only called when CONFIG_TCP_AO is
> defined. As each event can take up to 5K regardless if they are used or
> not, it's best not to define them when they are not used. Add #ifdef
> around these events when they are not used.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks Steven,

I agree that the events and classes covered by this #define
are not used unless CONFIG_TCP_AO is set. And that the small
number of TCP_AO related events that are left outside
the define are used even when CONFIG_TCP_AO is not set.

Reviewed-by: Simon Horman <horms@kernel.org>

