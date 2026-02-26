Return-Path: <netdev+bounces-261178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDTCEcLDn2nkdgQAu9opvQ
	(envelope-from <netdev+bounces-261178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:53:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C751A0B5F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C368E3069E6E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B583876DF;
	Thu, 26 Feb 2026 03:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcW58/1c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9337107C;
	Thu, 26 Feb 2026 03:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772077997; cv=none; b=ZXo2lyt260h3DO/IwS8q16zOxOBQra2HLLn+QlD7bOU5G9HcZvn/2sGI+7Yzob+HSTfCiqeEc4MsnSG8YIa7XyqevsZwNfABqpRyisvye+1ktOc4wa9GF3/SRbWfSNwrsWOmY8lnJwfxB6NZmN+tMVVdHB4st0STVFRESmHTlGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772077997; c=relaxed/simple;
	bh=yzbN2KBViUdlZmyXF+cYM2ISXieW45lRVaOD9aTtZvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBCkinSWY2vfPjRbl1sut9q0U921ad9pev/c83qEhak7sk6y9om2q/MS+MmM6eu0ZpJeIkApgp9OO82dQZC8BeVTAwOBYd8MuDbdHvELHPaSWOdFrDF80XxrA95g7ZUbmtVe9YTY3L5Fr5WWuE1JB9gZEfs0kaXv74SrZfjotkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcW58/1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F513C116C6;
	Thu, 26 Feb 2026 03:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772077997;
	bh=yzbN2KBViUdlZmyXF+cYM2ISXieW45lRVaOD9aTtZvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XcW58/1crtVdRQeHRWrhn+RpXe1A7rqj+n6HArjRpDEiZYUFWzvRHK40wL13Za7PW
	 i8FAE3cMO7whLQqHHJt1MYBjnfBuCmdo0eNwL0idzYYaPIKGy+98r3HqcWgwnlGn/T
	 kSe+ltlhSNbeEkwzF4hl5klC1rt7jPXKaBmklZKvWa68NN2Ufp8x1vWnv6FH2/skrX
	 cCD8X97k5LYeV7RerDCPZvIj1yUN2YMAlvdfeHlzZD+Cwb2ZaY2kkku0nC/udAzAX5
	 P1seSizY4F00ajN1sTYuw8S06L9C2Dj9nByvXREGei+8HZON+2WpBF1os6S55oI3ld
	 eotlQu1MaGIdw==
Date: Wed, 25 Feb 2026 19:53:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Sun Jian <sun.jian.kdev@gmail.com>, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook
 <kees@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v3 v3 1/2] selftests/harness: order TEST_F and XFAIL_ADD
 constructors
Message-ID: <20260225195315.122772f4@kernel.org>
In-Reply-To: <20260225111451.347923-1-sun.jian.kdev@gmail.com>
References: <20260225111451.347923-1-sun.jian.kdev@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-261178-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0C751A0B5F
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 19:14:50 +0800 Sun Jian wrote:
> TEST_F() allocates and registers its struct __test_metadata via mmap()
> inside its constructor, and only then assigns the
> _##fixture_##test##_object pointer.
> 
> XFAIL_ADD() runs in a constructor too and reads
> _##fixture_##test##_object to initialize xfail->test. If XFAIL_ADD runs
> first, xfail->test can be NULL and the expected failure will be reported
> as FAIL.
> 
> Use constructor priorities to ensure TEST_F registration runs before
> XFAIL_ADD, without adding extra state or runtime lookups.
> 
> Fixes: 2709473c9386 ("selftests: kselftest_harness: support using xfail")
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

Hi Shuah!

Any preference which one of us takes this series?
No real preference here, just slight preference to ship it as 
a fix to 7.0 rather than via -next.

