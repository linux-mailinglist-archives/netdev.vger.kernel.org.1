Return-Path: <netdev+bounces-275210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEb0IREj0Gkp3wYAu9opvQ
	(envelope-from <netdev+bounces-275210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:29:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B353982B5
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFC78300D0E1
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D923D7D84;
	Fri,  3 Apr 2026 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsOIvAS6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2219303C9C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248138; cv=none; b=bS5enc+yRtU4H3nDms/A7ZMU1GNgBNSAaSVoedWQ8Zl3xFCh5zwXmy+2HlpWMf2m62K3kqMwCLRnnXHll6donB7QM05kOiyB3ByIovYRyZE18hzyHDImjJ+z9tTtplCQhrRAuPZLSh9ZJFgEPK4g8HcCjLm6mCjIiL3Mduaow0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248138; c=relaxed/simple;
	bh=AKUZ4azwtlDhLujrLC4OvbyV+lAkv7tj0Dh2fTlm+m0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AABuNiq/kPjX1EF97HhPrg2GpKv1hIUP6T2V2bJ7ZmF6vEOdmhc9GmMaenE0k1EWUvmiuPZztiEMb8zrmkoErptoVGWrrEB8OgEteFsX5lQ7xbbgTaLWZzykt0uR4gAK79t6doWloOXdyt/gZPyR1zEj65hliA58gVCivLLRs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsOIvAS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53DFC4CEF7;
	Fri,  3 Apr 2026 20:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775248138;
	bh=AKUZ4azwtlDhLujrLC4OvbyV+lAkv7tj0Dh2fTlm+m0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dsOIvAS6hmdEkqxp4qBCcK61vEM3Wwfkp3H/0DsYb9y3iSES8MmHbE+7FhJj44ncJ
	 x8Rqbs9QjVhqYC5Lxh03yQwGGY1QS/3k8i0RDX2DEWeNio2hUjJif7kWrpFwIFmLwB
	 lf99KU+9DYfmmTpZchTOXTggUeZHfJYEdYytTKDMRkMzEgdXQOCZb0wQPwHfRnKkRk
	 tCjGa63yRgOEbVIpt4XhileTQQb77CKq7UOHkaa8DsWhDaSBfHH1XdQbNBngi5zmgP
	 RJMMfMOBf2HduqliGQpbFoBlCyrTu6uk9sb/7gUweF9XJVKU1YNIO7bGW7NBIsJpb/
	 x76XAQ6m3nnUw==
Date: Fri, 3 Apr 2026 13:28:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next] selftests/net: convert so_txtime to drv-net
Message-ID: <20260403132855.7616daee@kernel.org>
In-Reply-To: <20260403175047.152646-1-willemdebruijn.kernel@gmail.com>
References: <20260403175047.152646-1-willemdebruijn.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275210-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[so_txtime.sh:url]
X-Rspamd-Queue-Id: 29B353982B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri,  3 Apr 2026 13:50:12 -0400 Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> In preparation for extending to pacing hardware offload, convert the
> so_txtime.sh test to a drv-net test that can be run against netdevsim
> and real hardware.
> 
> Also move so_txtime.c to lib so that it is easily accessible for the
> new drv-net test, similar to gro.c in commit 8888bf4fb980 ("selftests:
> net: move gro to lib for HW vs SW reuse").
> 
> Also update so_txtime.c to not exit on first failure, but run to
> completion and report exit code there. This helps with debugging
> unexpected results, especially when processing multiple packets,
> as in the "reverse_order" testcase.

> diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
> index 77ccf83d87e0..a3301d4da540 100644
> --- a/tools/testing/selftests/drivers/net/config
> +++ b/tools/testing/selftests/drivers/net/config
> @@ -3,6 +3,8 @@ CONFIG_DEBUG_INFO_BTF=y
>  CONFIG_DEBUG_INFO_BTF_MODULES=n
>  CONFIG_INET_PSP=y
>  CONFIG_IPV6=y
> +CONFIG_NET_SCH_ETF=m
> +CONFIG_NET_SCH_FQ=m

I think our sort order puts _ after characters

>  CONFIG_NETCONSOLE=m
>  CONFIG_NETCONSOLE_DYNAMIC=y
>  CONFIG_NETCONSOLE_EXTENDED_LOG=y
> diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
> new file mode 100755
> index 000000000000..565cecf307dd
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/so_txtime.py
> @@ -0,0 +1,87 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""Regression tests for the SO_TXTIME interface.
> +
> +Test delivery time in FQ and ETF qdiscs.
> +"""

> +import time
> +
> +from lib.py import ksft_exit, ksft_run
> +from lib.py import KsftNamedVariant, KsftSkipEx, ksft_variants
> +from lib.py import NetDrvEpEnv, bkg, cmd
> +
> +
> +def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_fail):
> +  bin_path = cfg.net_lib_dir / "so_txtime"
> +
> +  tstart = time.time_ns() + 100_000_000
> +
> +  cmd_addr = f"-S {cfg.addr_v[ipver]} -D {cfg.remote_addr_v[ipver]}"
> +  cmd_base = f"{bin_path} -{ipver} -c {clockid} -t {tstart} {cmd_addr}"
> +  cmd_rx = f"{cmd_base} {args_rx} -r"
> +  cmd_tx = f"{cmd_base} {args_tx}"
> +
> +  try:
> +    with bkg(cmd_rx, host=cfg.remote, exit_wait=True):
> +      cmd(cmd_tx)
> +  except:
> +    if not expect_fail:
> +      raise

ruff check says:
tools/testing/selftests/drivers/net/so_txtime.py:29: [E722] Do not use bare `except`

Why not pass fail=(not expect_fail) to bkg ?

> +def main() -> None:

pylint --disable=R should be clean, please
I usually add something like:

	"""Boilerplate ksft main"""

> +  with NetDrvEpEnv(__file__) as cfg:
> +    ksft_run([test_so_txtime_mono], args=(cfg,))
> +    ksft_run([test_so_txtime_etf], args=(cfg,))

ksft_run() is not supposed to be called multiple times, it will break
KTAP format

> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> index ff83603397d0..8c50b6631524 100644
> --- a/tools/testing/selftests/net/lib/Makefile
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -15,6 +15,7 @@ TEST_GEN_FILES := \
>  	$(patsubst %.c,%.o,$(wildcard *.bpf.c)) \
>  	csum \
>  	gro \
> +	so_txtime \

is there a reason for the binary to be in lib?
gro is used by drivers/net and drivers/net/hw
if the C helper / binary is only used by a single target it should live
in the same dir as the python code

