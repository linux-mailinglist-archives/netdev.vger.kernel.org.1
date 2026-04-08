Return-Path: <netdev+bounces-276242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LNzBlS61WkB9QcAu9opvQ
	(envelope-from <netdev+bounces-276242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:15:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D65B3B6351
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB12F3016C90
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272B1F4180;
	Wed,  8 Apr 2026 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoKIMZ+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7318871F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614545; cv=none; b=mzPt7plLrnkXRG44bAnW5A634HXgLzDrRAeZWm0gvh56xOCDFUqOcsgHFoZyBQWjwxY0TSYfsUZ2ZoJpb7kUzx43n83/sgADoeX+hfWYK4kmN3EExVuzaj3ibVFmefU+fyLa90boUXS0oS0uFiIpTZVLUbUMVOiGwXX9bNSda54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614545; c=relaxed/simple;
	bh=uRgCcXnxqAK8WOFlzbn9Lfj/9x1GvwDCBtC97jUzkkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBaclVv1icB0grZ/RAwk+YTvvDaVrbn1DZhG8IhNcbVpYh5dZFFziBrDHKSUR206QW38K9tUYGnF/nbkhEdmBy+koe+D9EjGENkJPEZ8O/ZDCYvtNh0mKY+xIliZB4gAzdXuopU9NxY9tLRbj5OKWw/9cDGjIYYS1BIY5N11E7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoKIMZ+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59F8C116C6;
	Wed,  8 Apr 2026 02:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775614545;
	bh=uRgCcXnxqAK8WOFlzbn9Lfj/9x1GvwDCBtC97jUzkkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BoKIMZ+io4pgGP98NQjU9FSNBkm6FHNDTaVx5WrUBr+jXLbF3W4wnnl5kVl2y/DOz
	 fzk5zmXGIYox/Nc0Jcrcs3mBpxim7btxoR9mT9nnHPl76gfvmEGdHb1Muwk0xYFGLm
	 LTNirlVmI40y1opATHkMmK5fiI3r7RlSRMQaWxwqwlsg5lz/9TcxyM6LIZyGvKrzAN
	 4R3CbHTG30a+mYLjqEgwjMbEqz3YFyd11iHF3RVAsLG88tlqs0q6DnbXR3LYBacTs5
	 erMREAi21cB71zzdQN1jLK9QbhcBCn3Kf8DfEvVLk5xby2WpOiSdUD18erWp1j4e9x
	 gW5OYsl62CXsg==
Date: Tue, 7 Apr 2026 19:15:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3] selftests/net: convert so_txtime to drv-net
Message-ID: <20260407191543.0593b5aa@kernel.org>
In-Reply-To: <20260406025020.1636895-1-willemdebruijn.kernel@gmail.com>
References: <20260406025020.1636895-1-willemdebruijn.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276242-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 6D65B3B6351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun,  5 Apr 2026 22:49:22 -0400 Willem de Bruijn wrote:
> +@ksft_variants(_test_variants_mono())
> +def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
> +    """Run all variants of monotonic (fq) tests."""
> +    cmd(f"tc qdisc replace dev {cfg.ifname} root fq")
> +    test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, False)
> +
> +
> +def _test_variants_etf():
> +    for ipver in ["4", "6"]:
> +        for testcase in [
> +            ["no_delay", "a,-1", "a,-1", True],
> +            ["zero_delay", "a,0", "a,0", True],
> +            ["one_pkt", "a,10", "a,10", False],
> +            ["in_order", "a,10,b,20", "a,10,b,20", False],
> +            ["reverse_order", "a,20,b,10", "b,10,a,20", False],
> +        ]:
> +            name = f"_v{ipver}_{testcase[0]}"

nit: looking at the results in NIPA:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-drv/results/593442/5-so-txtime-py/stdout
the leading _ seems unnecessary? 

> +            yield KsftNamedVariant(
> +                name, ipver, testcase[1], testcase[2], testcase[3]
> +            )
> +
> +
> +@ksft_variants(_test_variants_etf())
> +def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
> +    """Run all variants of etf tests."""
> +    try:
> +        # ETF does not support change, so remove and re-add it instead.
> +        cmd_prefix = f"tc qdisc replace dev {cfg.ifname} root"
> +        cmd(f"{cmd_prefix} pfifo_fast")
> +        cmd(f"{cmd_prefix} etf clockid CLOCK_TAI delta 400000")
> +    except Exception as e:
> +        raise KsftSkipEx("tc does not support qdisc etf. skipping") from e
> +
> +    test_so_txtime(cfg, "tai", ipver, args_tx, args_rx, expect_fail)

I _think_ we'll leave ETF installed on the device after the test?
That seems not super great. As we discussed before rebuilding the 
whole hierarchy will be tedious but we could at least replace with
mq on exit and let it put whatever the default qdisc is as its leaves?

