Return-Path: <netdev+bounces-286043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EMqOARt/mkgqgAAu9opvQ
	(envelope-from <netdev+bounces-286043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:08:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9694FC9DB
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72371301BA77
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 23:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4560739BFE7;
	Fri,  8 May 2026 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwpFOd0T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C5386575;
	Fri,  8 May 2026 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281729; cv=none; b=G6nn7KySvdcLKHbuKxUPGCQq9az3t71NSevTCnBL7FERy/H7a7JSle0CXk4I0MuOgiO6qvsEP3uHvb3kZ2Y/+elrwH+7AWmvxYeYJme4KIXCSmG0PXSRr5RS9x9duUjmAFn+ITrdglGND5avL+qTriXGPqKwLkQs5172pjo2GJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281729; c=relaxed/simple;
	bh=DQU7vSiVGqSnmiyHzNY57bXXPN3lLWa/BhvDFce0Mmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyC71KJWmMMqxCs5XUu07S9hWdoPdvQUd82p3gACHjVGbHf6/Jwe0E8WbZNYN7w+rtACc8bwZamrdPKCjzL2lAS1g9iaPYVMUeApS2jxikGBXFJ1E8MUKNruf3lxRlC4ag1Cft8NRECTd1mAgLIErttY4Q7xhVoi4lrMQebHpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwpFOd0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C47DC2BCB0;
	Fri,  8 May 2026 23:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778281728;
	bh=DQU7vSiVGqSnmiyHzNY57bXXPN3lLWa/BhvDFce0Mmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jwpFOd0TK1FiUT+G5BUncG8qZJm1bYzuIFANtOkGskmOIx1Q86uYXFa7TcgYxr4Mi
	 NJIFHVq3xQFvBDIaXYZqXhXAoaQVBfvfovkislcLxq6WEjeBjkNuiv76M1FHeIH1po
	 IcAroAySAqO3Jod1CPYLtamuSiTVg27SsX5arLedYbIExUXvFTMHzagDA+k2nuHQ+J
	 +A2tTz2ldboCkGn22xpKH6n/CmhiOtSmg4gZU00JBBAWebav1uLlm/VtkB/hGjBJw4
	 40EFu3tt5MpqJ3vfGvq69Q+nSaquMvqsy7eSc0DKFR2aeNpX8NDSruPVhKt09wwRvB
	 S/5Luh+cWGbsg==
Date: Fri, 8 May 2026 16:08:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/sched: sch_dualpi2: annotate lockless
 stats reads in dump path
Message-ID: <20260508160847.52187d26@kernel.org>
In-Reply-To: <20260508072918.324797-1-agarwal.vineet2006@gmail.com>
References: <20260508072918.324797-1-agarwal.vineet2006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7C9694FC9DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286043-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri,  8 May 2026 12:59:18 +0530 Vineet Agarwal wrote:
> dualpi2_dump_stats() runs without holding the qdisc lock and provides
> best-effort statistics to userspace.

Didn't Eric already tell you that he's actively working on this?

Please don't get in the way.
-- 
pw-bot: reject

