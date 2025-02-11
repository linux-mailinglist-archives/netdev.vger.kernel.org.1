Return-Path: <netdev+bounces-165308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38009A31888
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 23:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B320A1889B31
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF326A088;
	Tue, 11 Feb 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT1dpVNT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918F7268FF2;
	Tue, 11 Feb 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312506; cv=none; b=ljLw99vW+yIeFKeNRA7fpMwb2L+pOfyguHyFIY3acmwyWA7ejSSZSRZflEVnHur4UsDSU+rNLA5tYi5Lf2OQnz1jSqRmLf1X7TDaJAdGcKenHLqHdMRkpXMeL83PMBqzu9wd/PEgGnM+vX+p75yL9WJRCpM0E0k5ntD7JNpglgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312506; c=relaxed/simple;
	bh=3NjxUODkDHz4Wrd65Bd6qQr3MBxV1yulnaxWtkDZ+JA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLFtP77S7lLCzS28rqORRjhn56/IiikdsdvbaUGY3COUetWVCZF/5A+kpMRJeMBUqMP9XM6/9+szyGVcVjvMYclBJRO/J8a3vVu2w+x5Prlt1U/GBRt4CbLy4ppRwufnLihAq3lczgJu154SpE2SnIuaqVkOgd6apXdWKtiiNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT1dpVNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609CFC4CEDD;
	Tue, 11 Feb 2025 22:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739312506;
	bh=3NjxUODkDHz4Wrd65Bd6qQr3MBxV1yulnaxWtkDZ+JA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hT1dpVNTzE96AzlazRcU3Vqbhh4bd6TSuC+U1Sx21Zw0tWMCWStBX/NckX57d8avC
	 Iw2AeXLdVzbd8F6JPS9HikUVajRMPTOCLZxCzCuobk/IP8+NwOxuAQmUrSiZAvO+yM
	 nERdwZ+wSEzP5njhzAuU/H/r347r2hzRznW6fx3eA4Attnmfl/xTRTw8NCBkTWC6nP
	 bdPSo0w0b3LSAFcbA0/pJ5qdnR1wwIT06tvkw+O6T2mny8Qyawvj8ovF7P7t/Bndsp
	 Tig8TdgW6Ow7UJCIdrWZ/XTaP1kP9BeUjIVeYEDZx0TWs+PuyqkYLRjQZ5fyfGeAQo
	 qI03Xx3wWoOSQ==
Date: Tue, 11 Feb 2025 14:21:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Message-ID: <20250211142144.30e5fa62@kernel.org>
In-Reply-To: <20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org>
References: <20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Feb 2025 10:03:53 -0800 Breno Leitao wrote:
> +DECLARE_TRACE(tcp_cwnd_reduction_tp,
> +	TP_PROTO(const struct sock *sk, int newly_acked_sacked,
> +		 int newly_lost, int flag),
> +	TP_ARGS(sk, newly_acked_sacked, newly_lost, flag));

nit: I think that the ");" traditionally goes on a separate line?

regarding testing if the goal is the use in BPF perhaps you could
add a small sample/result to the commit message of using bpftrace
against it?
-- 
pw-bot: cr

