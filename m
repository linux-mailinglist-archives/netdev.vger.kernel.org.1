Return-Path: <netdev+bounces-252923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCNDHKrAc2mjyQAAu9opvQ
	(envelope-from <netdev+bounces-252923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:40:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F9279B86
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A70CC3004DED
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DDB2741AB;
	Fri, 23 Jan 2026 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPLMsh2j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03156224AE8
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769193634; cv=none; b=rjIcnq/B90Xls1KEvEUgYFVgc605owaqAge7ppxgbsJeBa/XYHJxkyl1Jd06muGX/bl2uBYlUESLXAt+jkbWGiWV4aekhLSeq6DFMV/B6acFDlb2lOf1TJoqgjRn43ZXGrC4rDcn6xMc36l+nJTTJf7/+75X9N3v4ruqppBYHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769193634; c=relaxed/simple;
	bh=ZyqCpOGYNOyBCJMXkpWtMqpyYpq9PiBv4GvnCMB6J48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYpuWP5Sv1mZYErNzQNufNP5F/2n8IcxeJlBNf0q4WJkw3CJ0mubgOt11mXpRXAuN6AuNy9ZsNT5Z7q4IKFEVn3nzBHC5+w3pRD/+k8WXF87VVKUUT2CwcwCVmj5AySnY22feCK8LxktCrMk5Gd9Bn/YA5kUJATuKmGYCRgsDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPLMsh2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A0FC4CEF1;
	Fri, 23 Jan 2026 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769193633;
	bh=ZyqCpOGYNOyBCJMXkpWtMqpyYpq9PiBv4GvnCMB6J48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PPLMsh2jaJClI0FkLp6k4CVSxJZth2s05XiLlEW9fqpjeSiGuptxsgAWLBaOnhf1i
	 QKISdYGRMIc1NapJ09bXeWFioB9o14nwekpj+wUZ80Q5namhJLB5wiOSNqKcge6cZ6
	 I/I6xrr4Aa/cAulH+6trRKRohO4Ja5S0zH3fx1hZwt5dzM/S31j+GuHPmpyktDh0dF
	 EYn24/q2qHTfmFj6FU079NbwaA+dPcI0wWrFiZCkAfcXj4VKNbcPseBcEXQuzOkmtH
	 U1aFSnfRdqab7dXy63qZqNFiaqU/UIgTAfXUrYX/hN0nzSOh5PMPVbj70yJ4OQoaps
	 iY8HrEKm9LsWA==
Date: Fri, 23 Jan 2026 10:40:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, alok.a.tiwari@oracle.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, chuck.lever@oracle.com, davem@davemloft.net,
 donald.hunter@gmail.com, edumazet@google.com, gal@nvidia.com,
 horms@kernel.org, idosch@nvidia.com, jacob.e.keller@intel.com,
 kernel-team@meta.com, kory.maincent@bootlin.com, lee@trager.us,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/3] net: ethtool: Track TX pause storm
Message-ID: <20260123104031.16d914e4@kernel.org>
In-Reply-To: <aXNbTVF5KNz1yV-1@pengutronix.de>
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
	<aXNAjOjkCqOESf5y@pengutronix.de>
	<aXNbTVF5KNz1yV-1@pengutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252923-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,redhat.com,linux.dev,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04F9279B86
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 12:28:13 +0100 Oleksij Rempel wrote:
> Here is a TL;DR summary of my questions regarding the pause storm logic
> :)

Eh, did you get AI to help write the full version? :) So much text :)

> - Does the 500ms hardware timer reset on "flapping" pause signals? If so,
>   a stuttering storm might still crash the link partner (tx watchdog
>   timeout).

Yes any discontinuity resets AFAIU, Mohsin keep me honest.

There's a conflict here between respecting user configuration (pause
enabled) vs safety of the network. We're trying to err on the side of
respecting the config. We haven't seen any stutter, yet.

> - The auto-recovery (service task) enforces a fixed policy. Can we make
>   this configurable? I used devlink health (.recover) to let userspace
>   decide between auto-reset or manual intervention.

There is already a tunable for this exact feature but for PFC:
ETHTOOL_PFC_PREVENTION_TOUT. Should be trivial to add the same thing for
non-PFC pause. But we didn't want to open the uAPI can of warms unless
there's a clear ask and consensus. We don't need tuning (or so we
think), and there was some talk about not adding uAPI for fbnic because
it's a "private device".

> - Should we standardize an "RX Watchdog" mechanism in the core instead of
>   or in addition to driver-specific stats?

Our primary use case is machine is hard-wedged. Either Linux crash, or
kexec died, or UEFI issue. So it must be the device that implements the
logic.

Florian was proposing a hook to auto-disable pause from the crash
notifier. It sounds like your use case is closer to that?

> - If main case where we will run in to tx pause storm is OS crash, what
>   instance will be able to read this stats? Are they preserved on reboot
>   or kexec?

Good question! I was wondering the same thing. In the end I couldn't
figure out which behavior would be less confusing. We want to make sure
that the stat never increments on a live system, if the machines come
out of boot with non-zero value some alerting system could fire.
OTOH as you say we may want to know that it did happen while machine
was out. So IDK. The fbnic implementation starts with 0.

