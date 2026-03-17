Return-Path: <netdev+bounces-268752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACEDCcTQuWmMOAIAu9opvQ
	(envelope-from <netdev+bounces-268752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:08:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0B2B2F0E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 305B1305092B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5331C35DA7A;
	Tue, 17 Mar 2026 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtgAt3+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD234D90E;
	Tue, 17 Mar 2026 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785279; cv=none; b=lW9XDsqiX0cF/M9lvEgEiMCOMUm/3ujkL31VXfo6/FSgryaDFNwWmQJcaKB7Tazr2S3C0vRB7qHQOJE+sWDwn/1Z06AXSCtS9OKmOqXAtbAPOod/VM4pQjfpLm53tdFJxNyUGKCV6Z77kXLoM1Rwtic9oXe4+LsUXRVDdOmE4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785279; c=relaxed/simple;
	bh=YMWl9JylU67g9q2CU2HLFbVGLCVT1Yku1DRbMSM05EU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfuTmI/B9BkwEXP065pXmNLogxH8zl1QmauQHkrMFpqsq94HxeRnO84cQheD0mLQ2rTtdaOhQc5W6+gSD3o1PFydjBsO+ObD7Q0ua52vOlmGLI6635zqzVCTi+9bMAi+n5RjN32QN+rBVz2WDCZkBbx2I8Tr5BBRE6FIjzwuB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtgAt3+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38377C4CEF7;
	Tue, 17 Mar 2026 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773785278;
	bh=YMWl9JylU67g9q2CU2HLFbVGLCVT1Yku1DRbMSM05EU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KtgAt3+Mj9CRMFLFmw4JBiJ3qfkmbBJdywyO73Y8kOpXFMyfEci2kViyTXxfEmkRQ
	 5j/bMhioOEhl6PeJmKOTfF6iF+xE3lSJI4acRFNpNS7j+8ohrwVcRhGVxqja+Z3DVc
	 cwrW3f59LSHPv97wWUL7RQkP0PPtXQJw3Snjr+9/FovzpDO+U7T4gyRTF6yyqYD3t7
	 VLwZF2fBTaYDH/po0qomoDumzGxLxjzq5uZzbFa5MRKhKxxUQelb7FblJnkadUWVOI
	 eMt00Dndxw6fHC6caYAJskDKXRdYF1WINbWRaFxNlLQoPlXU8+Bjpkp6GSg1sCw64O
	 R/IArxW9O9EmQ==
Date: Tue, 17 Mar 2026 15:07:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Justin Iurman <justin.iurman@6wind.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, justin.iurman@gmail.com, nicolas.dichtel@6wind.com,
 stefano.salsano@uniroma2.it, paolo.lungaroni@uniroma2.it,
 ahabdels@cisco.com, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] selftests: add check for seg6 tunsrc
Message-ID: <20260317150757.3419e6b9@kernel.org>
In-Reply-To: <20260317115430.cfd3846b20c1e2314d468b5d@uniroma2.it>
References: <20260316162955.1253225-1-justin.iurman@6wind.com>
	<20260316162955.1253225-3-justin.iurman@6wind.com>
	<20260317115430.cfd3846b20c1e2314d468b5d@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268752-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[6wind.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,uniroma2.it,cisco.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82F0B2B2F0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 11:54:30 +0100 Andrea Mayer wrote:
> > @@ -819,6 +853,7 @@ test_command_or_ksft_skip ip
> >  test_command_or_ksft_skip ping
> >  test_command_or_ksft_skip sysctl
> >  test_command_or_ksft_skip grep
> > +test_command_or_ksft_skip ip6tables
> 
> This will skip the entire script if ip6tables is not present, which
> takes down the baseline tests too.
> I think a probe at startup that checks for both tunsrc support and
> ip6tables would work well here. If either is missing, we can
> just gracefully skip the new tunsrc tests and let the rest of the script
> run as usual.
> 
> The bottom line is that the script needs to keep working exactly as
> before when tunsrc is not supported or its dependencies are missing.

FWIW that's not the general guidance for networking tests.
If it's easy to handle cleanly then sure, but we should try to avoid
complicating tests with workarounds for degraded environments.

