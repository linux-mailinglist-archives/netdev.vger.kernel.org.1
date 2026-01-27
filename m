Return-Path: <netdev+bounces-253629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEVLM8UDeGlvnQEAu9opvQ
	(envelope-from <netdev+bounces-253629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:16:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7008E6D6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29496301A156
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D62C13AF2;
	Tue, 27 Jan 2026 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quBCTbQ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C01FD4
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769472963; cv=none; b=IVmFDBaPqsMxLzWOgmzNBPpoKtshPoJsKxkMnqd6PzuHNo36Asx9JHfY4lkMLpzkxO60tPsvx+CIgmWnmUaxArgLo+Zm9GDL0XYwzexRMMmwqCPsQDzFoJ/dsynesPrRxPIUQdUmJyI7kasx4CYAYHnx89bdmwwLIuprHzG9ae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769472963; c=relaxed/simple;
	bh=wmiTUsPzab6qWAS7Hn1UQRhd6VQuBtWOAoZwxEFeaPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RG4XjStSSASMiNY7wru2vTnajfyetsqJXwRShViBPdxkndjKKR24FlMjUXVOcWan3melZSTavNG0OYYCAG4V5MosBzRvuIPA/ucVixtyTzqcurQl5ie4LwiRPuQ6zQwJzShEFjbCt0cSZFXF818Ta8fXbYWGHmd/B/Q3itIrjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quBCTbQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC2BC116C6;
	Tue, 27 Jan 2026 00:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769472963;
	bh=wmiTUsPzab6qWAS7Hn1UQRhd6VQuBtWOAoZwxEFeaPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=quBCTbQ7/dWuHQ+XaukAXhuNlhXBAVRwVdU6M8wczWWJQlfTODmvG5XkMB8TIcy5V
	 Xpo2ohPi0dDUrv489ADp8jqEVMoTyeFxpBQlJFw980Gd9bQa1fVs/LVuG1wirA74MM
	 0pfbaPCBakqJ36tzQy32cGePl1hJnqW08haN2vAuQWcdNne1w8E9BueSv7nesPI0eH
	 NJ81eK9h0HAMvmNi6Fh9Zan3xd0ISZoKB+BMKwEgJEbooXTW17CwuMdA+qWPjO8Pvn
	 eJ+5DHGE6zZY91Q48s0dR0O8Qzu6hPtgUd2QM03B52zfxf8+qJvD3iEWlvQp2/ClN4
	 8XMizXvioxmlw==
Date: Mon, 26 Jan 2026 16:16:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v5 0/3] tls: Add TLS 1.3 hardware offload support
Message-ID: <20260126161601.1c2f18ec@kernel.org>
In-Reply-To: <CAKaoeS3ZLtiXNLNoJXGyTRp_-4yywdmDdCbNtjA-Q_w6mT_oaQ@mail.gmail.com>
References: <20260122192851.86670-1-rjethwani@purestorage.com>
	<20260122174821.70553ffc@kernel.org>
	<CAKaoeS0f7z_pjJhij8dFpgPPJfiWGsn25k6rgBUMUM4wiFHurA@mail.gmail.com>
	<CAKaoeS3ZLtiXNLNoJXGyTRp_-4yywdmDdCbNtjA-Q_w6mT_oaQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-253629-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,queasysnail.net,davemloft.net,redhat.com,google.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E7008E6D6
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 14:07:52 -0800 Rishikesh Jethwani wrote:
> > > Selftests are a hard requirement, I already shared a link with more
> > > info with you.  
> >
> > I will run the existing TLS selftests to verify no regressions.  
> 
> I ran the TLS selftests - all 898 tests pass:
> linux-kselftest/tools/testing/selftests/net# ./tls 2>&1 | tee tls_test.log
> # PASSED: 898 / 898 tests passed.
> # Totals: pass:898 fail:0 xfail:0 xpass:0 skip:0 error:0

I am asking you to implement selftests that will test the HW.

