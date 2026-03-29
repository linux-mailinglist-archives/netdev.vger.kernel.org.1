Return-Path: <netdev+bounces-273029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R0mpBkeoyWny0gUAu9opvQ
	(envelope-from <netdev+bounces-273029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:31:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7290F3544AE
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 234AF30062DF
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB56261B8A;
	Sun, 29 Mar 2026 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxx+dkiV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8918EB0;
	Sun, 29 Mar 2026 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774823492; cv=none; b=QrHUPBS7InmgQ1Pa6oHUQFZIiSsSH8bW5qmFROgt4cIYehPr1AxypYMP9qQy0k4BinQxDhZTSdGklVcNQ2MnEedCEnKDhDvb9i9SMwwtLaPMlZ9xc9llKtMR4Fo35k5lH7QNZvKumU1c7O32qcuXE7IosUjDb+ClJsmaSmV2sms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774823492; c=relaxed/simple;
	bh=RA8DnV0hQRDREKNhohv2PyO0L+kW8dFp3Hbn8fzGax0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWRWNy+gAY16WAQqpIkJMdF8K71/E7zLJKp4+jCiReHUZQ2X+rX3mms0+jRUCJMRwCJDg45OBhFMzf7jjrgaUeFb5+S7q7T3c4PdVPPeq0UHpzRYTKc0Bisf+WrNL/xFabCq5vy/sAKpPp8MMQ9TLQn7H6eGpUA3bagsa1e1g+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxx+dkiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CE8C2BCB1;
	Sun, 29 Mar 2026 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774823491;
	bh=RA8DnV0hQRDREKNhohv2PyO0L+kW8dFp3Hbn8fzGax0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hxx+dkiVB2+js0zIvoY+Gfn11VoQaxLdccHW30w6UDwcyUeBpOTXcDPc2hueOuEwS
	 gca9jjos5F2f5n+JtacCvPCEddNNZOCT+yQB2cMHkwz5He32Q/cJPkybGDceWbYS1f
	 jwThVsNE3LPFxstMH9Gfh2/7ZQg4Q5aHKL0Ibe8qZ/y0xlB4YvuAXJ8+HlYLJpk67D
	 EDnil4PQu7ntN9gvxJr+0iCUMG7mf/LpmjvEmxJ2xb7b3GWwB9ZVjuBMuPgsEG25q3
	 zw3QRSib9bHhwJJnpfopGfl7+ZP6/t61iXpj6nQCZtd2kmy4fx8SBxLB4UOb0+zUAc
	 /jhzaHm2Lc5wA==
Date: Sun, 29 Mar 2026 15:31:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [net-next v6 12/12] selftests: drv-net: Add USO test
Message-ID: <20260329153130.61b29766@kernel.org>
In-Reply-To: <20260326235238.2940471-13-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-13-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273029-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7290F3544AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 16:52:31 -0700 Joe Damato wrote:
> Add a simple test for USO. Can be used with netdevsim or real hardware.
> Tests both ipv4 and ipv6 with several full segments and a partial
> segment.


> +def _test_uso(cfg, ipver, mss, total_payload):
> +    cfg.require_ipver(ipver)
> +
> +    try:
> +        ethtool(f"-K {cfg.ifname} tx-udp-segmentation on")
> +    except Exception as exc:
> +        raise KsftSkipEx(
> +            "Device does not support tx-udp-segmentation") from exc
> +    defer(ethtool, f"-K {cfg.ifname} tx-udp-segmentation off")

If may have been on already when we started, no?

> +    expected_segs = (total_payload + mss - 1) // mss
> +
> +    rx_before = _get_rx_packets(cfg)

Let's run a little program on the remote that receives the packets
and validates they were correct? Maybe socat can do?

> +    port = rand_port(stype=socket.SOCK_DGRAM)
> +    _send_uso(cfg, ipver, mss, total_payload, port)
> +
> +    time.sleep(0.5)

What's this? Did you mean to wait for stats to settle?
cfg.wait_hw_stats_settle()

> +    rx_after = _get_rx_packets(cfg)
> +    rx_delta = rx_after - rx_before

Instead of checking Rx (which is probably fine) we may want to check Tx
has the right number of frames. Sender may have mis-counted the whole
USO as one packet if it's buggy?

> +    ksft_ge(rx_delta, expected_segs,
> +            comment=f"Expected >= {expected_segs} rx packets, got {rx_delta}")
> +
> +
> +def test_uso_v4(cfg):
> +    """USO IPv4: 11 segments (10 full + 1 partial)."""
> +    _test_uso(cfg, "4", 1400, 1400 * 10 + 500)
> +
> +
> +def test_uso_v6(cfg):
> +    """USO IPv6: 11 segments (10 full + 1 partial)."""
> +    _test_uso(cfg, "6", 1400, 1400 * 10 + 500)
> +
> +
> +def test_uso_v4_exact(cfg):
> +    """USO IPv4: exact multiple of MSS (5 full segments)."""
> +    _test_uso(cfg, "4", 1400, 1400 * 5)

Variants are probably a good fit here.


