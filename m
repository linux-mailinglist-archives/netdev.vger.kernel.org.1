Return-Path: <netdev+bounces-289227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ij6FwOyC2q2LAUAu9opvQ
	(envelope-from <netdev+bounces-289227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:42:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC409575A36
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAC2030151E0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294524A047;
	Tue, 19 May 2026 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpRUIa5I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F6C248F62
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151331; cv=none; b=ToF1FJvJXfemg0FVZcWUhQ2dtm91Zyt5l7gC6bjHezxwHmRE25BnaCa30ylnd+Mhc63fnCcBlCMd5tIuJWdAqp57pr4c6e8vYiC3pOl8eoTru33qb4+70vsazwhqFOng4FPj0PXQ0klUuuplBn7wTugM/7YL/SAzZrfDe9eAQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151331; c=relaxed/simple;
	bh=khJuqC4VgFub/c9zDNpa7BGP+NHfJDHSSBUiFNN8ae4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTFQW8YXJsNWGz9G4hLyTiCoTI2crAHBMMAKhziVONB5gnFEciy2iV9SymYKsXNEA2Ir2CLpVVLzx9btHL1n5keP0q09g9RiExe6VwrOFmkrivQYQytkowpURhJFlikoCO9RAKep9hen+HiSZ4cIQyPT1XO8t4tAUOgux4iJ/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpRUIa5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E918C2BCB7;
	Tue, 19 May 2026 00:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779151330;
	bh=khJuqC4VgFub/c9zDNpa7BGP+NHfJDHSSBUiFNN8ae4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gpRUIa5IPpHZaMFmjWq7hp1z3zaf0DVnMw53GAkjUa9p+El/p6LaRmwDfJK6eMHEy
	 acp56o0rXA4I73j0woSjKfcpVtBnJy5vFjSZ/Pv906+ay1h2XFZPdBhasVIrKffPsI
	 CFLZKBPic87leuWxmx2wifrqoiUT3c9MXOnJbVQMI0nWRjQLfXE5WFB93E8GU8aBHU
	 BCoebCzRoSfQOpvl9Dkoy79vbfPeZeV88BrDLKw2FjE2bw2hMCBNciB+JCgRQa7UWC
	 5sLtbPax/kXNTtYIbOpjwnEBiHEc2jZ2ALXLHPSPKunk5BKLiNrgJnS5Gvsk3BZW8o
	 bN4NRIFy1Oeqw==
Date: Mon, 18 May 2026 17:42:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v6 net-next 3/3] selftests:net: Implement ptp4l sync
 test using netdevsim
Message-ID: <20260518174209.41e2e039@kernel.org>
In-Reply-To: <20260513094520.325693-4-maciek@machnikowski.net>
References: <20260513094520.325693-1-maciek@machnikowski.net>
	<20260513094520.325693-4-maciek@machnikowski.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289227-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DC409575A36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 13 May 2026 11:45:20 +0200 Maciek Machnikowski wrote:
> Add PTP synchronization test using ptp4l and netdevsim.
> 
> The test creates two netdevsim adapters, links them together
> and runs the ptp4l leader and ptp4l follower on two ends
> of the netdevsim link and waits for the follower to report the
> synchronized state (s2) in its output log.
> 
> This implementation runs the test runs over IPv4 link.


> @@ -135,3 +135,4 @@ CONFIG_VLAN_8021Q=y
>  CONFIG_VXLAN=m
>  CONFIG_XFRM_INTERFACE=m
>  CONFIG_XFRM_USER=m
> +CONFIG_PTP_1588_CLOCK_MOCK=y

config needs to be sorted too

> diff --git a/tools/testing/selftests/net/ptp.py b/tools/testing/selftests/net/ptp.py
> new file mode 100755
> index 000000000000..dd6f12cf3d91
> --- /dev/null
> +++ b/tools/testing/selftests/net/ptp.py
> @@ -0,0 +1,184 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# By Maciek Machnikowski <maciek@machnikowski.net> (c) 2026,
> +#
> +# Self-tests for HW timestamping and 1588 synchronization
> +#
> +# This test runs a ptp4l leader/follower pair and waits for follower sync
> +# state (s2), using one common execution path.
> +#
> +# By default, it:
> +# - Creates two netdevsim instances in separate namespaces
> +# - Assigns IPv4 addresses and links them together
> +# - Uses those interfaces as leader/follower endpoints for ptp4l
> +# Optional: --leader and --follower override endpoints with existing
> +# interfaces. Each argument can be either "ifname" (initial netns) or
> +# "netns:ifname". Both options must be provided together.

Please use the existing DrvEpEnv infra!?

> +import os
> +import shutil
> +import subprocess

And existing helpers from net/lib/py

There's a bunch of legit-looking pylint warnings, too.
The expectation is that the warnings levels higher than R should be
addressed, but the Rs here also seem legit

