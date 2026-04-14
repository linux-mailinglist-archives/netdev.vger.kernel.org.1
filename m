Return-Path: <netdev+bounces-278272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IyTL6Gi3Wl8hAkAu9opvQ
	(envelope-from <netdev+bounces-278272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 04:12:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 224C33F4EBF
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 04:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B691302882C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C80530499A;
	Tue, 14 Apr 2026 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3SvGAR2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6BA3033E1
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776132759; cv=none; b=StLNr4hin/GJjjs/JkEXcyWihQCaPUiwt9HDM9aj9/14vUcXaT74TXlqZjZzrMp5Ff4zhO4CZat05HBoF62r+v/f+ZMyTN2op2CDyCkYudQyuVQIT+OF4luj17dT1rumEI57RAPWhFVTtwDSDwpPXe6rg4bkhYB3LYCgpqzev3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776132759; c=relaxed/simple;
	bh=DTiQFebWbihc5Y98wPeU/iS9BIuP+tW1FCRzdFc6EDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9dd1AaZ3oGrrNXfN4BCVKyZOj1b5OhebQ1JK8ZYnzpnbujb2TmAPXueW08L/RMlkAMLHtXXWMWq2CCnrEXiLw/vwq+hIVPl/3h7mr1zxzjtha4sslhyaROkLSF3nDafZqRdWSrkVBYdR8eK4bz/LMV4SUfJzR7wIu58i01eZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3SvGAR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AE4C2BCAF;
	Tue, 14 Apr 2026 02:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776132758;
	bh=DTiQFebWbihc5Y98wPeU/iS9BIuP+tW1FCRzdFc6EDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s3SvGAR2BlgepwSpaEe/KkbRysNprGgsj+s5R1U5agxmGok7FeV2GS2M7MyOUDC3M
	 0QhvQQHD7Ux61rhZvcWLAML2qwW7tYXb3AuPVm827AIiMHzalExMJTaaADqQwG9spc
	 W5B6FW7qEtN4Q0J5ldJV4IosMofGALcgwvus73l/1oDmZaJqs2wdrspWxOtZ+5SWcR
	 61OiP9o2OAt59H8paBBw6H315Zu5ZmAkg46pN99dlkFUzcXvABGxC/K3dZGQFnqXMQ
	 v4YP8ajRj2tqOWwqfVm/w3ivuD/cijKoozOLIItdJnmVIY/79uOEHiMk40rIDoYeka
	 /pxQ3KBR4JCuA==
Date: Mon, 13 Apr 2026 19:12:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, dw@davidwei.uk, pabeni@redhat.com,
 razor@blackwall.org
Subject: Re: [PATCH net-next v2 0/3] Follow-ups to nk_qlease net selftests
Message-ID: <20260413191237.43eee559@kernel.org>
In-Reply-To: <20260413220809.604592-1-daniel@iogearbox.net>
References: <20260413220809.604592-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278272-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 224C33F4EBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 00:08:03 +0200 Daniel Borkmann wrote:
> This is a set of follow-ups addressing [0]:
> 
> - Split netdevsim tests from HW tests in nk_qlease and move the SW
>   tests under selftests/net/
> - Remove multiple ksft_run()s to fix the recently enforced hard-fail
> - Move all the setup inside the test cases for the ones under
>   selftests/net/ (I'll defer the HW ones to David)
> - Add more test coverage related to queue leasing behavior and corner
>   cases, so now we have 45 tests in nk_qlease.py with netdevsim
>   which does not need special HW

LGTM, thanks!

I'll let it run overnight in the CI to shake out any latent flakiness
(and the crash which I think is from Stan's series).

Could you cook up one more follow up to enable VETH in the config?
We're getting:

# # Exception| Traceback (most recent call last):
# # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/net/lib/py/ksft.py", line 420, in ksft_run
# # Exception|     func(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/drivers/net/hw/./nk_qlease.py", line 393, in test_veth_queue_create
# # Exception|     ip("link add veth0 type veth peer name veth1")
# # Exception|     ~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/net/lib/py/utils.py", line 238, in ip
# # Exception|     return tool('ip', args, json=json, host=host)
# # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/net/lib/py/utils.py", line 225, in tool
# # Exception|     cmd_obj = cmd(cmd_str, ns=ns, host=host)
# # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/net/lib/py/utils.py", line 91, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/net/lib/py/utils.py", line 117, in process
# # Exception|     raise CmdExitFailure("Command failed", self)
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed
# # Exception| CMD: ip link add veth0 type veth peer name veth1
# # Exception|   EXIT: 2
# # Exception|   STDERR: Error: Unknown device type.
# # Exception| 
# not ok 27 nk_qlease.test_veth_queue_create


I guess you can post it without waiting for this to be merged, it won't
conflict.

