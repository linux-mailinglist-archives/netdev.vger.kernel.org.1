Return-Path: <netdev+bounces-274253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK4BFrp+zWnqeAYAu9opvQ
	(envelope-from <netdev+bounces-274253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 22:23:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFB2380204
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 22:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28E21303A5EA
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 20:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994A347FD7;
	Wed,  1 Apr 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoUJueOW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7B258CCC;
	Wed,  1 Apr 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074859; cv=none; b=Hw7b+1PoYqmHTe6AmQky7uZojPWCQR9vpX24cXFzNw+eVfFQCrzgSiqpwkmZZPS1AnIvYpbmKs7tLQhHiBuj2bnzSY3SY7wEO2RYur6q4E7Dj7N5U8EMUXk9loJXLe/NIPDqvEp0X5yLqAtdLxYdFUgSOCeiTqp/jkyJD7S5sg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074859; c=relaxed/simple;
	bh=1RcjQtgv6nCPlXqgFOGsKwCHeaW7HAs7c6eK6eQtM3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=un2OhJwTcVgr20yHOKSV6FGjatbEQoOmUBEafvhoHMrbivv7wKAd5Tj2667cPMAT2EPbQlMQX/gFRxkCT/p/OpEZmO8YDJQtaRDIRlmcijdXtd3Pd0btV4RQBc/iC/zSLQmFt40uK0XJ5Z9j4E+smAzNKIWSgukC0MUBc4YSGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoUJueOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ECEC4CEF7;
	Wed,  1 Apr 2026 20:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775074859;
	bh=1RcjQtgv6nCPlXqgFOGsKwCHeaW7HAs7c6eK6eQtM3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PoUJueOWCtAX24oRzQgr4+Kz8BUXkTu1owpVMvmuyhXppoocE8K4iGslQ4C/t+b3+
	 KDs6tywrF7ggrjf8gMeYW+/fReHcn1VfPCU6fsjFW5ru7UT7ycJZ+Y8Y+bvhS+ykzX
	 LGwg+gXCmnxQ0KxfAVxWvHWfX0Rz4LtXp5f0O7ZOkhIfJEs5U+JEQOhzgnKrfDv/CV
	 Gc0VZ9exDNN0inio2rXIOJSvhbWPr/W/VyLoNuhd1MIcDRPujZyyskZodfjn8JY8mj
	 tQj9ZIjjP3GAJHdZFGEj93gVnA8dP36n0KvSy6IexKbvBvcnXNdreE8DY4ZbVRLCqa
	 lYVX6KIZxM6gA==
Date: Wed, 1 Apr 2026 13:20:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <leon.huangfu@shopee.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next] selftests/net: Add two xdp tests to xdp.py
Message-ID: <20260401132048.3a15601e@kernel.org>
In-Reply-To: <20260401052746.314667-1-leon.huangfu@shopee.com>
References: <20260401052746.314667-1-leon.huangfu@shopee.com>
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
	TAGGED_FROM(0.00)[bounces-274253-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,xdp.py:url,lib.py:url]
X-Rspamd-Queue-Id: ACFB2380204
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed,  1 Apr 2026 13:27:46 +0800 Leon Hwang wrote:
> In "bpf: Disallow freplace on XDP with mismatched xdp_has_frags values" [1],
> these two XDP tests are suggested to add to xdp.py.
> 
> 1. Verify the failure of attaching non-frag-capable prog to mtu=9k driver.
> 2. Verify the failure of updating frag-capable prog with non-frag-capable
>    prog, when the frag-capable prog attaches to mtu=9k driver.
> 
> They have been verified against Mellanox CX6 and Intel 82599ES NICs.
> 
> With dropping other tests, here are the test logs.
> 
>  # ethtool -i eth0
>  driver: mlx5_core
>  version: 6.19.0-061900-generic
> 
>  # NETIF=eth0 python3 xdp.py
>  TAP version 13
>  1..2
>  ok 1 xdp.test_xdp_native_attach_sb_to_mb
>  ok 2 xdp.test_xdp_native_update_mb_to_sb
>  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
>  # ethtool -i eth0
>  driver: ixgbe
>  version: 6.19.0-061900-generic
> 
>  # NETIF=eth0 python3 xdp.py
>  TAP version 13
>  1..2
>  ok 1 xdp.test_xdp_native_attach_sb_to_mb # SKIP RTNETLINK answers: Invalid argument
>  ok 2 xdp.test_xdp_native_update_mb_to_sb # SKIP RTNETLINK answers: Invalid argument
>  # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:2 error:0
> 
> Links:
> [1] https://lore.kernel.org/bpf/20260326124205.1a3bb825@kernel.org/

Thanks for working on it! 

> diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
> index d86446569f89..fe34b491778b 100755
> --- a/tools/testing/selftests/drivers/net/xdp.py
> +++ b/tools/testing/selftests/drivers/net/xdp.py
> @@ -13,7 +13,7 @@ from enum import Enum
>  
>  from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_ne, ksft_pr
>  from lib.py import KsftNamedVariant, ksft_variants
> -from lib.py import KsftFailEx, NetDrvEpEnv
> +from lib.py import KsftFailEx, KsftSkipEx, NetDrvEpEnv
>  from lib.py import EthtoolFamily, NetdevFamily, NlError
>  from lib.py import bkg, cmd, rand_port, wait_port_listen
>  from lib.py import ip, defer
> @@ -693,6 +693,55 @@ def test_xdp_native_qstats(cfg, act):
>              ksft_ge(after['tx-packets'], before['tx-packets'])
>  
>  
> +def _set_jumbo_mtu(cfg, mtu):
> +    ip(f"link set dev {cfg.ifname} mtu {mtu}")
> +    defer(ip, f"link set dev {cfg.ifname} mtu 1500")

cfg records the original MTU, you can copy this line from here:
https://elixir.bootlin.com/linux/v7.0-rc6/source/tools/testing/selftests/drivers/net/gro.py#L88

> +def _exec_cmd(cfg, obj, sec, ip_opts=""):
> +    return cmd(f"ip {ip_opts} link set dev {cfg.ifname} xdpdrv obj {obj} sec {sec}", shell=True, fail=False)

We shouldn't need the shell=True where?
Also it's probably cleaner to pass fail as optional argument here
so that you can let this throw an exception in the cases we expect
to succeed instead of having to check in the caller explicitly

> +def test_xdp_native_attach_sb_to_mb(cfg):
> +    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
> +    mtu = 9000
> +
> +    _set_jumbo_mtu(cfg, mtu)
> +
> +    probe = _exec_cmd(cfg, obj, "xdp.frags")
> +    if probe.ret != 0:
> +        output = probe.stderr.strip() or probe.stdout.strip()
> +        raise KsftSkipEx(output or "device does not support multi-buffer XDP")

May be simpler and cleaner to print the whole command separately:
	
	if probe.ret != 0:
		ksft_pr(probe)
		raise KsftSkipEx("device does not support multi-buffer XDP")

> +    ip(f"link set dev {cfg.ifname} xdpdrv off")
> +
> +    probe = _exec_cmd(cfg, obj, "xdp")
> +    if probe.ret == 0:
> +        ip(f"link set dev {cfg.ifname} xdpdrv off")
> +        raise KsftFailEx(f"driver unexpectedly allows non-multi-buffer XDP at MTU {mtu}")

Hm, TBH I don't think this sb_to_mb case is adding any coverage.
Let's just add the test case below?


> +def test_xdp_native_update_mb_to_sb(cfg):
> +    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
> +
> +    _set_jumbo_mtu(cfg, 9000)
> +
> +    attach = _exec_cmd(cfg, obj, "xdp.frags")
> +    if attach.ret != 0:
> +        output = attach.stderr.strip() or attach.stdout.strip()
> +        raise KsftSkipEx(output or "device does not support multi-buffer XDP")
> +
> +    defer(ip, f"link set dev {cfg.ifname} xdpdrv off")
> +
> +    update1 = _exec_cmd(cfg, obj, "xdp.frags", "-force")
> +    if update1.ret != 0:
> +        raise KsftFailEx("device fails to update multi-buffer XDP")
> +
> +    update2 = _exec_cmd(cfg, obj, "xdp", "-force")
> +    if update2.ret == 0:
> +        raise KsftFailEx("device unexpectedly updates non-multi-buffer XDP")
-- 
pw-bot: cr

