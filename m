Return-Path: <netdev+bounces-268656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H+prG5lzuWkHGAIAu9opvQ
	(envelope-from <netdev+bounces-268656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:30:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD82AD12D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 394D830488E4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F6A3EAC8E;
	Tue, 17 Mar 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUJiYIP/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EA32D9EEA
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761217; cv=none; b=DCncm9u0tKvdz4Resw9ds/ZtDtgAjnP4N1+RYmTWxtcTENKLZ/sLG263nmna5ZVf/vbdlpy+U+C4pt8GpAjkByblVZm+7KO8hWpNXp4I8imFqFVx/iEPB6QcJRj4ENuM795ujk7JUmG4EyxmSVX734Cc7WxJgBgOajZMCRntR0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761217; c=relaxed/simple;
	bh=0vg4W2GoR7PnbwNtmDdK3fkY20wSN6pc2k0whl27i3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXIg25MfuQ1fGty8Lw1mp5dq/7HBds9om6XT1EzlUGONHydrnSlXa9BVX3ivHokY31wQeIqU1grVLUIyKTbEGGmWB16cOvGw6MK4irUJwDIr8JaUbi2QLwSyiSm93s5Nz0ybHXIAiFkdpKNQ2uicpZfqfNUFtHl9GAPaz/yHuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUJiYIP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24758C4CEF7;
	Tue, 17 Mar 2026 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773761217;
	bh=0vg4W2GoR7PnbwNtmDdK3fkY20wSN6pc2k0whl27i3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUJiYIP/TZ+apFLiiMpIZG4rOUoOV4wP9fKMLqYw3vBRxEGKR9ghq2EI1vh6Mh0zE
	 GUnPOZemR7S/CWTddUFxURipe+e4GvqEhehdZ1z78Is3dDLsz0qPtT+cNmrDAhqnul
	 80kSee5/+BURffgpxSJZkBk5SdQDKgbzLGKpwVcKvgIRd81+vi+OwX9EeIIYtfpz7o
	 soLm3XssUm2XRG2qztj6EDOqB4GFBYAMrCk2Ow0cHDmLeL2cRxSXeMQNnDldTuAaXt
	 19NT+4jvlJMSqBXaIXMk1dgAZ/I/4YNVjq8gAkRHEsEdR8xV+gxUwO+W3MTEOFsbGi
	 v9hFNkYQzlWww==
From: Simon Horman <horms@kernel.org>
To: tom@herbertland.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	justin.iurman@gmail.com
Subject: Re: [net-next,v9,09/10] test: Add ext_hdr.py in networking selftests
Date: Tue, 17 Mar 2026 15:24:58 +0000
Message-ID: <20260317152456.1742468-3-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314175124.47010-10-tom@herbertland.com>
References: <20260314175124.47010-10-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com,google.com,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268656-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ext_hdr.py:url,proto_nums.py:url,linux.dev:url,shlex.split:url]
X-Rspamd-Queue-Id: E0BD82AD12D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html

Simon says: pylint also has quite a lot to say about this patch. I'm
assuming it is all minor stuff. But could you look into addressing the
issues it flags?

---
test: Add ext_hdr.py in networking selftests

This commit adds a new Python helper file that contains Extension Header
format definitions and related functions for building IPv6 extension
header chains in networking selftests.

> diff --git a/tools/testing/selftests/net/ext_hdr.py b/tools/testing/selftests/net/ext_hdr.py
> new file mode 100755
> index 000000000000..bfb7da4a7c88
> --- /dev/null
> +++ b/tools/testing/selftests/net/ext_hdr.py
> @@ -0,0 +1,385 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Helper functions for creating extension headers using scapy
> +
> +import ctypes
> +import shlex
> +import socket
> +import sys
> +import subprocess
> +import scapy
> +import proto_nums
> +
> +
> +# Read a sysctl
> +def sysctl_read(name):
> +    try:
> +        # shlex.split helps handle arguments correctly
> +        command = shlex.split(f"sysctl -n {name}")
> +        # Use check=True to raise an exception if the command fails
> +        result = subprocess.run(command, check=True,
> +                    capture_output=True, text=True)
> +        value = result.stdout.strip()
> +    except subprocess.CalledProcessError as ex:
> +        print(f"Error reading sysctl: {ex.stderr}")
> +    except FileNotFoundError:
> +        print("The 'sysctl' command was not found. "
> +              "Check your system's PATH.")
> +
> +    return int(value)

What happens when an exception is caught here? When either
subprocess.CalledProcessError or FileNotFoundError occurs, the exception
handlers print an error message but don't set 'value'. The function then
reaches the 'return int(value)' statement, which will raise
UnboundLocalError.

This will crash the test in several places:

tools/testing/selftests/net/ext_hdr.py:check_eh_order() uses the return:
    do_check = sysctl_read("net.ipv6.enforce_ext_hdr_order")

tools/testing/selftests/net/ext_hdr.py:make_eh_chain() uses the return:
    pair = make_full_hbh_dst_options_list(nnext_hdr, args,
        sysctl_read("net.ipv6.max_hbh_opts_number"),
        sysctl_read("net.ipv6.max_hbh_length"))

and:
    pair = make_full_hbh_dst_options_list(nnext_hdr, args,
        sysctl_read("net.ipv6.max_dst_opts_number"),
        sysctl_read("net.ipv6.max_dst_opts_length"))

Should the exception handlers return a default value or re-raise to let
callers handle it?

> +
> +# Common definitions for Destination and Hop-by-Hop options

[ ... ]

Should ext_hdr.py be added to TEST_FILES in the Makefile? The selftests
build system documentation requires that any file imported by test scripts
must be added to TEST_FILES. Without this, tests will work in the source
tree but fail after 'make install' with ModuleNotFoundError.

The file is imported at line 12 ('import proto_nums'), and appears to be
a library meant for import rather than direct execution. Both ext_hdr.py
and proto_nums.py need to be added to TEST_FILES in
tools/testing/selftests/net/Makefile.

