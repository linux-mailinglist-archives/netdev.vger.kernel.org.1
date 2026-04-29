Return-Path: <netdev+bounces-282537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMbGCpaR8mlhsgEAu9opvQ
	(envelope-from <netdev+bounces-282537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:17:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9CA49B4C5
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 014E83025E67
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2E239A06E;
	Wed, 29 Apr 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm3Mv4H1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FE39C007;
	Wed, 29 Apr 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504641; cv=none; b=vDO7NcfZo7j+q6cgnH/9BGSrFM0ui/arwO4Mmu+kGL90+kUPPDrRm2A8xY2AA3wX2fBzqXZGso/vTpG5bFL/siR1bmC7iUGI0NmKYEBEblfOjsx2dyGj6v/cbHJ19PaRwr6vuz/0TqsM6wfkyoRsaS+Rr4MF5amuueB3nJ69uE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504641; c=relaxed/simple;
	bh=4jJeWdmZnzZi/LhT/fJ6ga8VlqvfMGdY7/U3kGiTDpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJrZl6auRr9LGiNt/mBDwlHAz8T4N4CtjU8o3hgXRfWvD1fSw7J817k8kzVf8Gbm1onfoR4wuAxRils7kZ/p5dGrOuv9ACzjlSSYeIK92QFFreNslnlLLZLuLFqGsXCBzAqAMWxaqIWcGEPIoUyonVrdGHFQoqsICX6hGV+/WrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm3Mv4H1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1E2C19425;
	Wed, 29 Apr 2026 23:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777504641;
	bh=4jJeWdmZnzZi/LhT/fJ6ga8VlqvfMGdY7/U3kGiTDpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qm3Mv4H1oMHsYITiEHgnVa+SGjTAk7aTX7qaK+NJOKkhRmoWjTBIWbc4VCJexini+
	 hT7QWxyrqQwVPI9qCNs2pR304tCzOg26RJiDQsmewOQBgNJhrSc4WmPiz4IDghGC4p
	 C44ZA/aX2kJnmwRO+YNNK04wp9FIGrkCXLJ5Jy5Gy+sQZTnv+1vlqu778ZMI+D70UM
	 S3TY47jysA+8aFgijrEDznIQ1BH6NK4a6JVaet2RS8cmzLAB5K7iFy3V0fbqkBrgwV
	 lvEvaPN7SlBHvdyjmnzllOS5Ngwm7FpzvozH2+AWWb2TJXIW0ERS5pSLvCEUZUT+6p
	 ydb8i/+R4XQeQ==
Date: Wed, 29 Apr 2026 16:17:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: netdev@vger.kernel.org,
 syzbot+ca9d5686d06994c6547c@syzkaller.appspotmail.com, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in lane_ioctl (3)
Message-ID: <20260429161719.1ceca7f8@kernel.org>
In-Reply-To: <20260429151741.660828-1-arjan@linux.intel.com>
References: <69f16c26.170a0220.34e5b8.0013.GAE@google.com>
	<20260429151741.660828-1-arjan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CA9CA49B4C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282537-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ca9d5686d06994c6547c];
	SUBJECT_HAS_QUESTION(0.00)[]

On Wed, 29 Apr 2026 08:17:41 -0700 Arjan van de Ven wrote:
> This email is created by automation to help kernel developers deal with
> a large volume of bug reports by decoding oopses into more actionable
> information.

Just one opinion but I don't think it is helping me.
I'd assume at this point that maintainers can run the syzbot reports
thru their own slop generators if they want to?
And hopefully those local slop generators would notice obvious facts
like that this is a report for code which no longer exists upstream :\

