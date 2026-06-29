Return-Path: <netdev+bounces-302855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rFsmLyP/Qmq2LwoAu9opvQ
	(envelope-from <netdev+bounces-302855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:26:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 103B96DF374
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gRHCj5jO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302855-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302855-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFD1430125E4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882B63CF05E;
	Mon, 29 Jun 2026 23:26:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A43CF02B;
	Mon, 29 Jun 2026 23:26:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775582; cv=none; b=qbOkCW5c/9GwGsQrRVsMnAPnQpHtW8+ijEBPPw1oR9UgOWm3w1ywJLIPPbdzVLMWoXoKhFPjPWQCiBlYYxoyDJcW8Jlil5yXkZCdVz2wP3bbx32qFBCm4tfWrPAbuPO571YrRWDV2FDEvhG/vlNdedXdm0Ukwvdb8h/Fa0lsVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775582; c=relaxed/simple;
	bh=6Ymxt66jECafrDULw9WAiFaejCE/Gk8aOce8Mfo8zpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnGm+rg94XPGhVl4ybtrMxwXKRqPa2Bt/qwuqXKrWtt9cyNwPqmZ4zWE3Aa+wKSm9AEZV7oykGooNatA5RAXTf+7Y/BybNapwkBsD0o0Y3BH/dyeT3EXpMtrmdGxWREDFULNvPIxsM6nyexGMdlJIjpbdHxMe87oPIyVvTVojgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRHCj5jO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7B31F000E9;
	Mon, 29 Jun 2026 23:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782775580;
	bh=3P7Bo+K2ACW1PfU5Qo7t2Ig/w6+tpBNk9Q3FEVXsDtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gRHCj5jO1ecsN9W9DMSbJV1nUBv/Kspt/BW1W1VHkp/PAaiAxJBnri/hnK8tUCOh+
	 ekVBPz2bNoBpIhBwHCefPAy+iweXBb9zV+yah61EX5vedtJUC+kf2qbugs/dy7dxvu
	 pbI4irXFXnqitou8BqYL/54/L6JrQteXbkWv217LWtTjObH5qEgOn6n4fdGoLpA6bP
	 lhXfhMhRAf+uWkpieEWXACDOiEdGaY1w9GybMam3MxxneI54FP44lzyYqOUtGFVYLh
	 jkKE0MrzR3mUT40XvwdIZrA4su2bj0juAdBcSAWFxC125Djk14F7d+WNqCK94+Ij99
	 GNQvp9EIAnm5Q==
Date: Mon, 29 Jun 2026 16:26:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shuhao Tan <tanshuhao@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
 <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>, Samiullah
 Khawaja <skhawaja@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/2] Reuse threaded NAPI kthread across
 napi_del()/napi_add().
Message-ID: <20260629162619.55297244@kernel.org>
In-Reply-To: <20260629192029.4013794-1-tanshuhao@google.com>
References: <20260629192029.4013794-1-tanshuhao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302855-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tanshuhao@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:almasrymina@google.com,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 103B96DF374

On Mon, 29 Jun 2026 12:20:25 -0700 Shuhao Tan wrote:
> These drivers destroy and recreate queues during configuration
> changes. If a NAPI was threaded before destruction, during the
> creation, a new kthread will be spawned for the NAPI.
> 
> Some drivers do not have this problem, e.g. netdevsim. But these
> drivers and the drivers mentioned above will still lose kthread
> during link flap (ndo_stop/ndo_open).
> 
> Because the kthreads before and after these configuration changes are
> different, all the attributes associated with the kthread are lost.
> These include CPU mask, priority, scheduler policy, etc.. If the
> threaded state is preserved for a NAPI, it makes sense to want to
> preserve the attributes of the thread as well.

Send a netdev Netlink notification when NAPI is re-created and
let the userspace re-apply the settings? Keeping a few u32s
around is one thing but keeping a thread running and visible
in /procfs for the lifetime of a machine feels a little bit much.
IDK.

