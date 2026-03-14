Return-Path: <netdev+bounces-267867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOcDONLYtWkn5wAAu9opvQ
	(envelope-from <netdev+bounces-267867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 22:53:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0F028F210
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 22:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85B94301E3E5
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15293845B7;
	Sat, 14 Mar 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RICRGkp9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B81A6819
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525123; cv=none; b=F+EG6nTLuxyKK+1TJfuVR4seSm4Lej935q0DEwAus+PvpcMKYCSNJZZgLH9rxqe27WZtD3eMNNbibWJ8+q3pnFP6wUD5Kpm4TuDOTi0587SnNTClTatH7eHoMZ1xNtp6PWWQUMbT2AnGWYGLfl5lhFXxX8RaCRxp3c7OzGq6A4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525123; c=relaxed/simple;
	bh=UPYq0NlNjl2ED61JZnMdwPQk6YbawUXEt/+51o2jiAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBEIvHhQ9JZiSrphy7VexjHlSQVg+dE9Auwk1ImJh4x18yH1iG8NxQmW07NTxxavq7Xo6AfZf2kLUu4jWb81nBJef4NZveq7Vxe9RMOYT8c5rs1rKurfpRwvMG2PkM+44pcDU8DGbo2nmuYyJVum5LLsg6eZWon4EC/5i+HTJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RICRGkp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BDEC116C6;
	Sat, 14 Mar 2026 21:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773525123;
	bh=UPYq0NlNjl2ED61JZnMdwPQk6YbawUXEt/+51o2jiAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RICRGkp9n1N99hpgdUjHWT8bAbtrLMShpNmebvkkTRcX2u4WdnNMYaktocIpQSsDM
	 bbyNHjIrJDI+jgATnAWEo88yYHN+/DRz9bZGpbKZbtogkautq14AiM0CmNj0TExQE4
	 oWx21RJBWrhCk7C/pcA53ut+QA7Z9nldaUOlnaltxrWSzI6vlFJnVq8NO67DVXXKJ0
	 zAlnkRPXIJ7taxF5k443BDP4WmKb4sR/EKISKMdoNzyCws66DE3n7y/mN6HRBWFriy
	 lez6dx2yHxupRQcj1CJGfb4Zj1QtAR2Ub5cy0OU1CTxEDNaVUKZOLz+ZLe1Khtr+2S
	 Uba8Lze6RgvtA==
Date: Sat, 14 Mar 2026 14:52:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next] tcp: add cwnd_event_tx_start to
 tcp_congestion_ops
Message-ID: <20260314145202.778a8535@kernel.org>
In-Reply-To: <20260314180802.50222-1-edumazet@google.com>
References: <20260314180802.50222-1-edumazet@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267867-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E0F028F210
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 18:08:02 +0000 Eric Dumazet wrote:
> (tcp_congestion_ops)->cwnd_event() is called very often, with
> @event oscillating between CA_EVENT_TX_START and other values.
> 
> This is not branch prediction friendly.
> 
> Provide a new cwnd_event_tx_start pointer dedicated for CA_EVENT_TX_START.
> 
> Both BBR and CUBIC benefit from this change, since they only care
> about CA_EVENT_TX_START.

BPF still not building :(

  progs/tcp_ca_kfunc.c:121:33: error: use of undeclared identifier 'cwnd_event_tx_start'
    121 |         .cwnd_event_tx_start = (void *)cwnd_event_tx_start,
        |                                        ^~~~~~~~~~~~~~~~~~~


https://github.com/kernel-patches/bpf/actions/runs/23096281431/job/67089276918
-- 
pw-bot: cr

