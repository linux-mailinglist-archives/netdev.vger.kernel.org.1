Return-Path: <netdev+bounces-251682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBQnMlsqcGmyWwAAu9opvQ
	(envelope-from <netdev+bounces-251682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:22:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C264F050
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D71A3903A20
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0CE304BDC;
	Wed, 21 Jan 2026 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaRJr9r0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F5F2E03F5;
	Wed, 21 Jan 2026 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958459; cv=none; b=cpqEH6JulHt9t7AAC1X6hyi+E5q9vmCIjYbNr5O4cz/POt59KcdS0TBg9EOcKmXZ5nvUpVEzr+i9dK/REKNhvhqc5SPBPADEpy1X8REqaWizKKGVFJzSP04HaxikHPskG9rN951nLneBJlZVjaslJUEhxudElk37fxiAhW2bIGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958459; c=relaxed/simple;
	bh=pq6LGkZKbu+Y7ikc9vrBHrd3pcAGdOQR3oyZRSHXkjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Of+88SOG4r27uSKmXQwBqEcMdNlGSWZPLmNQvZ8JTLzFYb61oiB4kwm3zhkO0bSfF+3zcfRoqeGADI1jso4GGrkppqJSA11xS2wHIqvwFr9fws+TazVgIKz0HnKG4FO/9HyjknDe1lmpOJ5f8Fb7JqslWpX+ITcZHWFAqSVUjuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaRJr9r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7695CC16AAE;
	Wed, 21 Jan 2026 01:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768958459;
	bh=pq6LGkZKbu+Y7ikc9vrBHrd3pcAGdOQR3oyZRSHXkjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BaRJr9r05E1LpqSJTVHc2u9D+LNsv6+rjRqkCSRA1CFWDSYIgO4UryosSklb72uQf
	 imN6D3dvcqN768Oou5GcCnNgC94o1STltLvR/Wx5ZvdEVsaLrLyO6m4DHtw2S9PnDv
	 UdsvqJkdWOUsOwB3lZKqe3/XkUSg5xMYS9sLDl2L+wuX2eRDQaMVIBl5TZ/8+++2wa
	 kAVUJLGMH6j5caUGfpQiIHx6cu3wlyHVhrIxe1gEG3aPTxM4HzSh1pBjaTOvcblgLG
	 QZ+UoVdgw4zJcCL9NgHz95sHS/VCy15m4P+tBxpQz2pHsf8KbqMTXJAX6SeUxaSkd/
	 kMp3y0eBUWlLw==
Date: Tue, 20 Jan 2026 17:20:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 7/7] selftests: netconsole: validate target
 resume
Message-ID: <20260120172057.6600eefe@kernel.org>
In-Reply-To: <20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
	<20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-251682-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url]
X-Rspamd-Queue-Id: B1C264F050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 18 Jan 2026 11:00:27 +0000 Andre Carvalho wrote:
> +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh

We'll keep this series in the queue but I think it's time to move 
the netcons tests out to their own target or move them to netdevsim.
There's too many of them now and they keep failing on real HW.
With absolutely no error message getting printed :|

TAP version 13
1..1
# overriding timeout to 360
# selftests: drivers/net: netcons_resume.sh
# Running with bind mode: ifname
# ifname : Test passed
# Running with bind mode: mac
not ok 1 selftests: drivers/net: netcons_resume.sh # exit=1

https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/482560/4-netcons-resume-sh/stdout

