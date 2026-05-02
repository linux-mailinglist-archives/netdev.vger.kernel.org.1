Return-Path: <netdev+bounces-283331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k0imLDxJ9Wk4KAIAu9opvQ
	(envelope-from <netdev+bounces-283331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:45:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A63294B0814
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C688D3008091
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 00:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748D918BBAE;
	Sat,  2 May 2026 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjI+RAru"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC440DFA0;
	Sat,  2 May 2026 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777682743; cv=none; b=Y7PYs0X2TobtvnEWgI+h0ig1hy/krgghIojWcDLbWB7cFbgci0hjBT7ptzfVJwhqhrhmXzCEJfsln95tn9i90YAL2f5H226raZlpOrq1hN0UCNSsZwWv+9XfNp1utc0vnp9P9Y832vreUe1t/HlH3MubiRTGAEDr5q8qQmCmjYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777682743; c=relaxed/simple;
	bh=2bVyOlG8DIIcdk2f1Ny3W3YiMVFlBFhBI1XAed3eLKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ya1R/3W+vnvTUgUsxiLtG5TY+YY8KVgHzbhjo3BRvNAc/jmkNKNP50NkcozJIj1P4lIePNRXB+jl7wstEILP00EhcjEq753WbAej+zodl+cEhYv0Xn5BKKS+P8Muj0Iy8brxEubTmikLHusW8OkHTrf1G4Ols6a5RGvDS10dbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjI+RAru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0E3C2BCB4;
	Sat,  2 May 2026 00:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777682742;
	bh=2bVyOlG8DIIcdk2f1Ny3W3YiMVFlBFhBI1XAed3eLKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MjI+RAru2LMTZkN3fARRyNW3ryR1auKn/XqBrLyJvhN7neIeB5IZPClHx7kJtSdPJ
	 sRUvBdRxjkaXAmUzSSRx4qh5iIwrLZDtLCqSXzobYKa65sK19/UAgk9MTv55594078
	 STvOP7zICOgnv7Kmpdqm58QvHWmx7uwGDpvvwaXdwmSnQj47+BhFGHhgCtlhfYJCgb
	 Y0ZY3+zsz6KN5tFZrM0eSAvBAUAF/qaCmdGYQmPkWQnC+o05gV74WUOCqZW7vAUQzF
	 dvEvisQQAn3oX8GepGZl3tBbJNJN/buQUbdJssP1pRB+U+SR52+fCC+yYGYV/8HksA
	 4hPQPgTQoy45g==
Date: Fri, 1 May 2026 17:45:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v6 3/3] selftests: drv-net: convert so_txtime
 to drv-net
Message-ID: <20260501174541.0338ad0e@kernel.org>
In-Reply-To: <20260430132820.1944517-4-willemdebruijn.kernel@gmail.com>
References: <20260430132820.1944517-1-willemdebruijn.kernel@gmail.com>
	<20260430132820.1944517-4-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A63294B0814
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283331-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 09:28:06 -0400 Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> In preparation for extending to pacing hardware offload, convert the
> so_txtime.sh test to a drv-net test that can be run against netdevsim
> and real hardware.
> 
> Also update so_txtime.c to not exit on first failure, but run to
> completion and report exit code there. This helps with debugging
> unexpected results, especially when processing multiple packets,
> as happens in the "reverse_order" testcase.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

