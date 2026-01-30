Return-Path: <netdev+bounces-255180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFgiNPzXfGlbOwIAu9opvQ
	(envelope-from <netdev+bounces-255180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:10:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3359DBC682
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8698A3005D20
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8CA346AF3;
	Fri, 30 Jan 2026 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9Rog2xy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C86346A0F
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789398; cv=none; b=WZAr3/qVVTHD80pDoLVhAlzZNMiOotbWy+fNGbsvD2XF3YFO86siCACOHbjfb+UUEdNglR3Sn26h8dcBH9VbtAab5UyfJoUsb71X0XHXUg3hKO4oKyMPUsnSOX8YlWHU4dFY6CMaQvNvMoAOWr0bjxU65/YPwv4PgJmJBj1DXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789398; c=relaxed/simple;
	bh=F6trECvdTofvXyvyDnjdxAI+8VFG4Z9dNUhUuC3t14M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIBSy2yBRv9XR5Vs352yZ/Ng5HKDqxtbH+zkMGSsIlUebfongBi7OFM0ly7uo+R8IKAugyKRB1lwCaqF0bKl93y7PqWeFX7LYESyzvZh2PiB21nIbZE5D+o0lSU/jgejeZlLzrFABOAWhmmBwB5o90N5aEpJUM3Kwk6vGwvDjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9Rog2xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EA6C4CEF7;
	Fri, 30 Jan 2026 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769789398;
	bh=F6trECvdTofvXyvyDnjdxAI+8VFG4Z9dNUhUuC3t14M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m9Rog2xy33UqLgeKxDWxrtqpoxeARia/oCX4n7dHwRU+O3E7WN1Asa6WHN8LME0S+
	 aH8rya4qqjm2HsAwFuVpK2tlSW9n6iN218o3t3KLxoKqnSZnScxQ1zsvkyigJFyaLh
	 /S4K++JuUXAcMvUCTcGXamYHxMLDpHvnzBjmLqd0xCmFej3USzTkUvfsck2MwyXsmr
	 ftWk8r+wpbgVePDudDRfON9pt5ZR/X2MwScHiUGZtk8mFpLH1NITZM7/qbfk6pQL5b
	 95viSn4rOQ7gvrZjjH4MJ6IYVNXLRhw54/8N3zFtY6kx6+knnDKTk+BihlwPK1TQxO
	 9W1Yy0iEa/rWg==
Date: Fri, 30 Jan 2026 08:09:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
Message-ID: <20260130080956.175c5fbf@kernel.org>
In-Reply-To: <CALs4sv0ri0zrdM+qeRP3OZbcgBdvNTh+C8a6=VTtGTEex49W+w@mail.gmail.com>
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
	<20260129061646.1417185-5-michael.chan@broadcom.com>
	<20260129180320.1c69a0c4@kernel.org>
	<CALs4sv0ri0zrdM+qeRP3OZbcgBdvNTh+C8a6=VTtGTEex49W+w@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255180-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3359DBC682
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 10:54:42 +0530 Pavan Chebbi wrote:
> > tests1:
> >  - add a couple of contexts
> >  - add a n-tuple filter to one of the context
> >  - ifdown/ifup
> >  - check contexts and filters are there
> >  - run some traffic to make sure it flows right
> >
> > tests2:
> >  - ifdown
> >  - add a couple of contexts  
> 
> BTW, bnxt won't support adding contexts when if is down. I could still
> add the test..

I see. Yes, please still add the test. You can just let it fail, no
need to catch exceptions and re-raise SKIP unless you really want to.
The HW tests are expected to be automatically ignored if they never pass
for a given platform. We're primarily looking for regressions and
crashes.

