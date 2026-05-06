Return-Path: <netdev+bounces-285056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA6PKKS7+2mTEAAAu9opvQ
	(envelope-from <netdev+bounces-285056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:07:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 958D74E11A7
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C7AF30069B8
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2474C3537C0;
	Wed,  6 May 2026 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi4DG7WF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BB2E0938
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105247; cv=none; b=On7OMtPv/eRK0GuvDdiqywOYoBMn1H7uTCRzBChJL9bOUdcJyNkA7V39L0+91rwn0QRogHJHCB/YMybJEyAtK36kQIe8pFO1mQSmY3nNI/xFlJOMrkKcTgN2IGJ8L4yT6yFU07B9R++SAX26gdI04lr/LptkQryhamT8baFEFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105247; c=relaxed/simple;
	bh=C/ayCCznEXYLF4PVWAUxQtgAMDfoqmcwfHaUmsYKDCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCQ06+zBnJPi+GD3bA+xCyMddEj1eC+TIbS+o97T2Uk2jxIj/Q4VwmAnrF77g+/0xIMzHIyrwxufCfkdGeS/IMPt4mcfuZk8Ws3jRteY/ehyIJIvU2iFbRKTS7OnpqLRXehyJQvmq3tMdn78hE/Yu/oR1z3TySUXgMjXgI7n9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi4DG7WF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C29DC2BCB0;
	Wed,  6 May 2026 22:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778105246;
	bh=C/ayCCznEXYLF4PVWAUxQtgAMDfoqmcwfHaUmsYKDCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vi4DG7WFKhJun/BHbY+BemXXfyIsoZDYGPSOdPMhFWrhrNduPMk4X17yA+hbA+1Qc
	 QZTQVvxBM/GLwx4VcS7oqF7XCKuuvrIqdrPzS9689UzzZNs+q1/VY74DUbk+VDhOh4
	 pKCQ1rUnVnh4PJkC4lejiSTrPlFg0Xm5NfcRRqoIkXugcNFN8b1X49Yq1T5DLcVyBQ
	 ppkM0ANgCa5umSeRWeGzOOHGXVY2lvgNhGaGk+W9WGBlvT479tt7DuW8WykqgQXVmF
	 jVlwofRHlG+9XDPta4sximTuWIHQ0Ugp9d6YT2toI/qk97OPPsLWBFjaOEKxo0cRRc
	 jOpVvzveCnh2g==
Date: Wed, 6 May 2026 15:07:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync
 test using netdevsim
Message-ID: <20260506150725.14c82e23@kernel.org>
In-Reply-To: <7fc0a457-7153-4b22-b3c9-2c6298b75d73@machnikowski.net>
References: <20260503074747.1321-1-maciek@machnikowski.net>
	<20260503074747.1321-4-maciek@machnikowski.net>
	<20260504100753.7cc193cc@kernel.org>
	<b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
	<20260505172234.3348a81b@kernel.org>
	<20260505172317.089fb380@kernel.org>
	<7fc0a457-7153-4b22-b3c9-2c6298b75d73@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 958D74E11A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev,kernel.org];
	TAGGED_FROM(0.00)[bounces-285056-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Action: no action

On Wed, 6 May 2026 13:18:01 +0200 Maciek Machnikowski wrote:
> On 06/05/2026 02:23, Jakub Kicinski wrote:
> > On Tue, 5 May 2026 17:22:34 -0700 Jakub Kicinski wrote:  
> >> You have to add it to the relevant config.
> >>
> >> Please read: github.com/linux-netdev/nipa/wiki/Netdev-CI-system  
> > 
> > Sorry, wrong link, this:
> > 
> > https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style  
> I did follow the guid, ran the test on the vng environment and it still
> passed the test. Is there more debuggability on the CI system? Can you
> share the .config file it generated while running the test? Or the
> commands it tries to run so I can verify them locally?
> 
> 
> The commands I ran were:
> 
> make mrproper
> vng --build  --config tools/testing/selftests/drivers/net/netdevsim/config
> vng -v --run . --user root --cpus 4 -- tools/testing/selftests/net/ptp.py
> 
> The tests were done on the ARM64 Fedora 44 with the default kernel
> 6.19.14-300.fc44.aarch64 running inside the Parallels Desktop VM.

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/631241/config

