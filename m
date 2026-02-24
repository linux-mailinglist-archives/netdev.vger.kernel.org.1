Return-Path: <netdev+bounces-260287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLqCH3P9nGm9MQQAu9opvQ
	(envelope-from <netdev+bounces-260287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:22:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABE8180761
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3AB930EE0DB
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C412C234966;
	Tue, 24 Feb 2026 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTdUSTrY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28222D4C8;
	Tue, 24 Feb 2026 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896136; cv=none; b=bHwGpAFZLOBY0w0vsF7Xwbdn72OVE5TTEB4Nzmcb2sv4BtlDSQJj2f+ShLenJl7CatA6CwiZjRpXumv+/C3f6RADHUd8tLHjsugvFz23mqElAbH+HpIT+XErFRFnMkN3gfhq+oNHigG5jpvo3HmN8t1mgIrAJb1erc0qIn32OA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896136; c=relaxed/simple;
	bh=IcyFI9ljFMLaZ7L6auBlDV7YTiPLEAx0QauZHXRSQpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVtOWd266W/H0Q+ZucsRMViOO/2Ono4RTLoHCKnH3PKCASTTZxpWsWIx4G+3U494sJfEPevnLe23kVznzsF+DUaN4SLzhsjsdXUwmCZmHry9d4VHHz5iwWduBnC175R49bWZvoEKkYeJHeecfOXEVHpn1wO1U1VlxoWTMcnKGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTdUSTrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0DFC116C6;
	Tue, 24 Feb 2026 01:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771896136;
	bh=IcyFI9ljFMLaZ7L6auBlDV7YTiPLEAx0QauZHXRSQpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XTdUSTrY2eJ/NmIDIEnFSQYhXq/FtkYnW6go51ytCmJ9mRwlR3UZI/68AZEuaMjAG
	 erQt+wRsdC+N+OlcNWLs4dnCF6XQyHQFKJ5yVxnwFJSeTiNooKK6HzQ7tYzu0jMBmm
	 jN+ltuxDSen6QbF7VzRR4cEDpSD0I1eqNuNSfnNfaUfWjMIvph94lxBH4vXeeBuuv+
	 RAaHIrzGufKBmnriyMRLbNN9i/wisYJyo3VTqdqJYw+DvlAkFmVwJKCxtzPovmPU+V
	 mXUeathl4Sa5lz1fVjUiuJGtrw6c2+tuLHdqO9kMIhMSxCFnRRaJ+4X2MmyDcte+gY
	 QMyT1fPfksODg==
Date: Mon, 23 Feb 2026 17:22:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/harness: fix XFAIL_ADD matching when test
 metadata is not initialized
Message-ID: <20260223172214.5d8ddaa1@kernel.org>
In-Reply-To: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
References: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260287-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2ABE8180761
X-Rspamd-Action: no action

On Sun, 22 Feb 2026 19:18:46 +0800 Sun Jian wrote:
> XFAIL_ADD() registers expected failures using constructor order, but the
> associated struct __test_metadata pointer may not be initialized yet.
> As a result, xfail entries can end up with a NULL test pointer and never
> match at runtime, causing expected failures to be reported as FAIL.
> 
> Store the test case name in the xfail entry and fall back to name-based
> matching when the test pointer is unavailable, while keeping the original
> pointer-based matching for compatibility.

This looks a bit inelegant, what compiler is this failing on for you?

Constructors seem to have a concept of priority so if we have to,
we should probably used those for the fix.
-- 
pw-bot: cr

