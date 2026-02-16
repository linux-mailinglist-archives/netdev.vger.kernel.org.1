Return-Path: <netdev+bounces-258865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NjeLI4Jk2ni1AEAu9opvQ
	(envelope-from <netdev+bounces-258865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:11:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E838C1433EC
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A1963002535
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 12:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FE630C61E;
	Mon, 16 Feb 2026 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOFLYMeq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318EF30C613;
	Mon, 16 Feb 2026 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771243905; cv=none; b=f4X+HDeCWHJGULlrQpEyiPE6V4n5UKLFdpoE9KAuMCTcJ0SvAV2UY1XnVoJ79BAbz+9TxT5TMPak4c9gFp4lEC9MDlou6RMwWVtJFhgj8oTgbfuopBoZoworBbqyncQX96gE/huLpgxVWNBKX0A03ilrjTa80nBQaFmxTNQduzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771243905; c=relaxed/simple;
	bh=VrzPRqY2WAT6Xt7UjSu8aww5moulArYPq1BlYuYkS9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLnslJlBL7EHXyU8Ei9BphqYntL2bYf6U9WqWn/GO8+4hiDv/LTTGbmglF6jW9yNavUExNbeYCcvPEbLIZoGuNPQLdP/XRWNjy4nCku9JXgDxJ/KJsiOb25I0M5NQuCsiz7wGwnXiS144lrTNWDsLJL+UjALb4mbyRuj9rM+ihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOFLYMeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2AAC19423;
	Mon, 16 Feb 2026 12:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771243904;
	bh=VrzPRqY2WAT6Xt7UjSu8aww5moulArYPq1BlYuYkS9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOFLYMeqWPd4M5tToXP5cuD0dGmL+Rlcvcl/DjcdlTeUQJ4RGOzXNur28NDZSe9TK
	 iDrPinK0s0tEoJ0hAJe3be+PUchsT5De8xjEzgRXa2EUREtNSKTYvFdx6UZCVEKix4
	 YXaL2wZEyjE2Sb+jneFANXDWbkG8wNpJwqS9PXVhm7/Qv9PIcRYhXiguX9bT9wGw9P
	 Gbs7b2fmfolVQHrRRvt2Ndg8X2EqwtRmVDZJka5zJp9GKLI4D4sX/G5uZp3JwbRAoP
	 IxdNxDMcZIUZinDYhS0yYgSteSa2MNj0qP7GX5pMPu5/TB7s3OQ2g6LdXVMJxt4YvL
	 +4NknfF+DL6Xg==
Date: Mon, 16 Feb 2026 12:11:40 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	marcelo.leitner@gmail.com, jhs@mojatatu.com, dcaratti@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: tc_actions: don't dump 2MB of \0 to stdout
Message-ID: <aZMJfBldbj20FrUx@horms.kernel.org>
References: <20260214035159.2119699-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214035159.2119699-1-kuba@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258865-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,mojatatu.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nmap.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: E838C1433EC
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 07:51:59PM -0800, Jakub Kicinski wrote:
> Since we started running selftests in NIPA we have been seeing
> tc_actions.sh generate a soft lockup warning on ~20% of the runs.
> On the pre-netdev foundation setup it was actually a missed irq
> splat from the console. Now it's either that or a lockup.
> 
> I initially suspected a socket locking issue since the test
> is exercising local loopback with act_mirred.
> After hours of staring at this I noticed in strace that ncat

Ouch!

> when -o $file is specified _both_ saves the output to the file
> and still prints it to stdout. Because the file being sent
> is constructed with:
> 
>   dd conv=sparse status=none if=/dev/zero bs=1M count=2 of=$mirred
>                                 ^^^^^^^^^
> 
> the data printed is all \0. Most terminals don't display nul
> characters (and neither does vng output capture save them).
> But QEMU's serial console still has to poke them thru which
> is very slow and causes the lockup (if the file is >600kB).
> 
> Replace the '-o $file' with '> $file'. This speeds the test up
> from 2m20s to 18s on debug kernels, and prevents the warnings.
> 
> Fixes: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I exercise this by running ncat locally on Fedora 43.

$ ncat --version
Ncat: Version 7.92 ( https://nmap.org/ncat )

And confirmed the behaviour you describe.

Reviewed-by: Simon Horman <horms@kernel.org>

