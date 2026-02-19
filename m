Return-Path: <netdev+bounces-259420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHW6K4XblmlJpgIAu9opvQ
	(envelope-from <netdev+bounces-259420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:44:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAD315D7A1
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 716C1304A329
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C45325488;
	Thu, 19 Feb 2026 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCR3Ki3B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BE145FE0;
	Thu, 19 Feb 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494050; cv=none; b=hjHwrR6UGGz4al4TDKPEGElpk8OGV5jre+GODF20mqclFnE6QEpvRjmajW6CzBOa+yL5uXz1e3CVnDPFadBJBkrnuf1iMgCGBTFDsnSVCo3QmTKABFkYp+lHAcV8lQVLX7BhQkKxv4I8KZ4zu5qIzBafPvaTL6NHbTKnSU8V/BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494050; c=relaxed/simple;
	bh=T6w5GKsIgoEG6KRs18wTkCD0f1hYe1RlC28TLv/Hmyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srwJch608zEKHisu68qpjY28LCRi3XU7ZoZoQe/rDtx9yo+kazobWcRHWv2D3hAsvA6iXOnbmHu3qIbQIMfgDo2D61f9N8N8QN4BZI7eZjkscHy5wpsoMNJCFkaTWvwOQ78DzzYwT85X2tXVvlHR54G0u3ZmrUOtBVE0XBzf4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCR3Ki3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9324C4CEF7;
	Thu, 19 Feb 2026 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771494049;
	bh=T6w5GKsIgoEG6KRs18wTkCD0f1hYe1RlC28TLv/Hmyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCR3Ki3BrRY9t4a3tuHHH41DPhYGzOUbvqhFAo3pOFTP+VjVbaZl5nLQMrdOzbfkB
	 hA7FQEt/LUzdIfyHx30abRFeWbyOyzeh+cMotlHwZdiSdSJfvUo0wPtoh4bfDEpGOC
	 Zl2YlQ5n6TaO7Xo/1Y1x9h2Q8C87IYT4WV8oFCRiXyejY37yQYBrJer+ai1iwSQrnp
	 hNnrKSsqLp++klS6muhxLQJbdCtY90sr6SJRBroGhU0oDA8KYtKunPKjLnbbnjY5Gy
	 8/ZthfYmqktoiuDlPz/UkPaegh7Ji3rvC99DyzhkFAlJbpG7hFFVUNQ9bYxU0Z9qF7
	 Uz1TgBS3K//9A==
Date: Thu, 19 Feb 2026 09:40:45 +0000
From: Simon Horman <horms@kernel.org>
To: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: core: fix logical inconsistency in
 failover_slave_register()
Message-ID: <aZbanQC5ci7yLqzj@horms.kernel.org>
References: <20260219090216.12884-1-zeeshanahmad022019@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219090216.12884-1-zeeshanahmad022019@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFAD315D7A1
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 02:02:16PM +0500, Zeeshan Ahmad wrote:
> Smatch warns that 'fops' is dereferenced at line 66 before being checked
> for NULL at line 85.
> 
> The current code inconsistently assumes 'fops' might be NULL at lines 62
> and 85, while dereferencing it without a check at line 66.
> 
> Move the NULL check to the beginning of the function immediately after
> 'fops' is initialized. This ensures safety for all subsequent
> dereferences and allows the removal of redundant checks.
> 
> Signed-off-by: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>

Hi Zeeshan,

It's not entirely clear to me what the behaviour should be if fops is
NULL, or indeed if fops can be NULL.

But looking over both this function and other users of failover_get_bymac()
it seems to me that the general patter is to skip steps that needs
to dereference fops if fops is NULL.

So I think it would be best to do the same here - that is modify the
code around line 66 to make it conditional on fops not being NULL.
Otherwise, if fops is NULL then steps that would have been taken are skipped.

It is true that in those steps would never be reached and the kernel would
have panic'ed due to a NULL dereference on line 66. So maybe your
approach is better, perhaps with the addition of a WARN_ON_ONCE.
But I feel that opens a larger surface that needs to be fixed in terms
of understanding other users of failover_get_bymac() and if they (still)
need to take fops being NULL into account.

LMKWYT


On process, if this is a fix - which I think means there is at least
a theoretical case where it can go *boom* - then please target at net
rather than net-next, and include a Fixes tag.

Else,

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.0,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 23rd.

RFC patches sent for review only are obviously welcome at any time.
                                                                                See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

