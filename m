Return-Path: <netdev+bounces-260464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDc6EfCHnWnBQQQAu9opvQ
	(envelope-from <netdev+bounces-260464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:13:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9452185F63
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C64C530AD657
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7549B37D104;
	Tue, 24 Feb 2026 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grEiPb7l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EAA37BE6C;
	Tue, 24 Feb 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931581; cv=none; b=uqlrh0V72CGE4IWZgcTTbViqkT0cKELIgbXcl+M+Az+33iDQUtZPw87iH92owQ0e+dlD4ACPitfuL6dgTKGRBhDT7C8oxuo9blQBNWYwI6S4/QACHKnDu+6LgthnTuMyLqWhQgu076n8qXQ7h2LvXrQQxdYpstq5wXHQdrGbJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931581; c=relaxed/simple;
	bh=VbxZylF/i0+qus4j1jJd41aBvCmM0Tg8x0WPmkOnUzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLamue34V43KUkV+zKEcKy/DmrpLj8etLXI9GjwoURN9tHs1Q4YY8/49+ZEaveh0LqY8yoWj+kF9V4Fml3wKPmgIWZt2vBIKeUsZjEqxsZizVj07TPfT9voZ0ML+pKVeKNk8AktkRnNcs9/WGyFHWxUIYGJFomapkrR6ttSuPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grEiPb7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B200C116D0;
	Tue, 24 Feb 2026 11:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771931580;
	bh=VbxZylF/i0+qus4j1jJd41aBvCmM0Tg8x0WPmkOnUzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grEiPb7lEkw4zfG2ZjZQaAJIXlVZKD2wUr3GiIIciP4VDw3/sGBiYhMvuIHsr1AXH
	 KIUlOyfD2ZslrwYguQ6qqNLwMYHdbAiG4p8rz0CpVFnxkaOXzRq9cC+P7LbVd+f0kc
	 3ieecYTE1cERj94CO9o5b/qg5V9yIuNaUOe37ZAyqV4wUM6fTc9Dr3LAZxJzHKvuE+
	 i88Ortgbu9wwxLJ8Lm5EeUnfDLn9ZJV4Y4ibDaE8andpIXKvRTnYWl+knlkl5tSUtB
	 SkI8aeTrDQ3F2k1Oty8LHJxOs2sd9mp5yYV4l9vbG8WaYCwUsEvsp0CUuNScwNqoDa
	 lqqx4WiBC+dFA==
Date: Tue, 24 Feb 2026 11:12:56 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	petrm@nvidia.com, gal@nvidia.com, leitao@debian.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] selftests: net: py: improve bkg() error
 reporting
Message-ID: <aZ2HuNl1ldE54lup@horms.kernel.org>
References: <20260223202633.4126087-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223202633.4126087-1-kuba@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260464-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9452185F63
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:26:30PM -0800, Jakub Kicinski wrote:
> bkg() is a helper for running commands in the background.
> When init or body of a with() block fails check if the bkg()
> process already exited and report its status (including stdout/
> /stderr). This significantly improves debugability.
> 
> Jakub Kicinski (3):
>   selftests: net: py: avoid masking exceptions in bkg() failures
>   selftests: net: py: use repr(cmd) for failure exceptions
>   selftests: net: py: add cmd info for ksft_wait failure
> 
>  tools/testing/selftests/net/lib/py/utils.py | 44 +++++++++++++++------
>  1 file changed, 31 insertions(+), 13 deletions(-)

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>


