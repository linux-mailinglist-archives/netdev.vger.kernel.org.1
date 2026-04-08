Return-Path: <netdev+bounces-276669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJFaDISU1mmiGQgAu9opvQ
	(envelope-from <netdev+bounces-276669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:46:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 894303BFCD7
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C628030166D1
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44445329E7E;
	Wed,  8 Apr 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjTTyCex"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BBFDDA9
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670290; cv=none; b=FWf6kfYyI43fITQuC50qC2kBUcYQvLB9sIArC6BX+hjOiV5BQ/XoilbG/O5wViRb45Go6E6utiWfIof7gpoHCB5/EQFYSyOHKDnG3dtyXuTo6HwpZjyVkmrB0BqlwO+ARJJJ/D3+fBB2+dTuCRdx4m2ki/5YBAC3+hsYFI3ctRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670290; c=relaxed/simple;
	bh=97qKwL0WGblAsNuUijYXbndOzdgjjTf+Mz3OmBdqK/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c91xFmaHto4zLI2HQQacykNKKhSw6oD343dmxAXlpaEBF4KAiIAiCl52ryCNYR3tmupo9qVEDnfnwf5k+pWBVq22JzzXu3bkhMDapllWdEKzCHZzi5rJAMli655Ueg83hw+3UTJa/5GmsxJJuAXzg+wVsc2O0RcXBSSomBzUVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjTTyCex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0427FC19421;
	Wed,  8 Apr 2026 17:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775670289;
	bh=97qKwL0WGblAsNuUijYXbndOzdgjjTf+Mz3OmBdqK/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TjTTyCex+I8zfX59nrOXuAQHD6ldGSwTPQCp7/d6EcsOI3vBKV7KloME43Ffk7e/h
	 Zw6Kwx3TULnalA7knY5ArX53kuZq1EZH1hzzTEZIt2Z4Wayq1Tlkdg1Iix5JAzpoJm
	 WOU6t80lArnc+hXAnRMrs1PH53mIcKukEsGZLNoV4aN7u9hgIrKuqz4i3atu/VEs4r
	 ZaS28zORzYUJF5J3I+68TpIiSls1evdaqpxEwtxe2hWz6y/UhGWwy5IorBC626NDwa
	 fIjJtawVgEERZhgXQinRoWZfm4ciQpGN4C82+om0qVW6HYVyCCSJ+SmDKrRjDb4pGS
	 OW8NPpAGx2FSw==
Date: Wed, 8 Apr 2026 10:44:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, borisp@nvidia.com,
 john.fastabend@gmail.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v12 6/6] selftests: net: add TLS hardware offload test
Message-ID: <20260408104441.49ba8451@kernel.org>
In-Reply-To: <adaGQRUUNbXWXNgP@krikkit>
References: <20260402235511.664801-1-rjethwani@purestorage.com>
	<20260402235511.664801-7-rjethwani@purestorage.com>
	<adaGQRUUNbXWXNgP@krikkit>
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
	TAGGED_FROM(0.00)[bounces-276669-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[purestorage.com,vger.kernel.org,nvidia.com,gmail.com,davemloft.net,redhat.com,google.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 894303BFCD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 18:45:53 +0200 Sabrina Dubroca wrote:
> @Jakub [top-posting so you don't have to scroll through the rest of my
> comments to find some global questions about this patch]

:)

> tools/testing/selftests/drivers/net/README.rst mentions "Local
> host is the DUT", but this test does rekeys on both sides and sends a
> bit of traffic back and forth. Is that acceptable?

Yes, I think so. Quick scan thru the code doesn't real much about
configuration and how the test ensure HW offload is engaged.
But sending traffic is the intended use of the remote host.

The statement is basically saying that if we have 2 hosts the local
one is going to have the kernel to test installed. The remote host
may have old kernel and no offloads available, it's just a traffic
source/sink.

> Another thought: is there a "standard" for stdout vs stderr, as well as
> verbosity of "test progress"/"debug" type messages ("sent
> keyupdate"/"received keyupdate"/"server listening"/"setup complete"
> etc) for those test programs? Any expectation for a --{debug,verbose}
> option to only display all this stuff on request?
> 
> Output for 1 test:
> -------- 8< --------
> TLS Version: TLS 1.3
> Cipher: AES-GCM-128
> Buffer size: 16384
> Connecting to 192.168.13.1:4433...
> Connected!
> Installing TLS_TX AES-GCM-128 gen 0...
> TLS_TX AES-GCM-128 gen 0 installed
> Installing TLS_RX AES-GCM-128 gen 0...
> TLS_RX AES-GCM-128 gen 0 installed
> TLS setup complete.
> Sending 100 messages of 16384 bytes...
> Sent 16384 bytes (iteration 1)
> Received echo 16384 bytes (ok)
> [...repeated]
> Sent 16384 bytes (iteration 100)
> Received echo 16384 bytes (ok)
> -------- 8< --------
> 
> With some rekeys I get 300L of output on each side.
> 
> 
> If not, I guess we can fall back to what makes the most sense for
> NIPA?

Best practices for these "Python-wrapped" tests are.. evolving.
The current thinking is to avoid the prints in the good case,
unless there's actually something sketchy that we may want
to double check (eg. the test is triggering some condition
probabilistically and we want to see if / how many times it managed 
to trigger it)

IIRC the command failed exceptions already print the command + stdout +
stderr. So having the C binary always print the debug output and exit(1)
if something goes wrong is probably the way to go. Python should then
simply do cmd(..), if the command succeeds there's no output.
If the cmd() raises an exception we'll see the "debug" info.

bkg() should hopefully behave the same, with the caveat that bkg()
with no exit param (exit_wait, ksft_wait) should be avoided, cause
without those we have to kill the process which makes the exit checking
unreliable. I tried to make it a little better in commit d99aa5912
so its not the end of the world if wait can be used. But good tests
should be designed to wait.

