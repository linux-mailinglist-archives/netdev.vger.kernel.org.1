Return-Path: <netdev+bounces-262027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Mg5ANtBomlz1QQAu9opvQ
	(envelope-from <netdev+bounces-262027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:16:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3871BFACE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25AF530616C7
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EA92DECC5;
	Sat, 28 Feb 2026 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnGnx9LJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD4262D0B;
	Sat, 28 Feb 2026 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241244; cv=none; b=LW/oTGXmcKOn5wKAOWPI8XrxUQYEtWn8n9he5515OXiQQeO04aJldeErAZLU9Fz9KY/ZFdtrlt4JDF1Ff/UVUXE5YBpyd9X3n9L6Fp9Nsx+t+O0FKXlgFFJO3diQh2M+HCHdu9trNu7wOgk4O1BdMNCu3q4PM9bBHb2UAWrsgZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241244; c=relaxed/simple;
	bh=4fyGez8Gp7VTPfTNdlPV+3xxbcqGU5YQPI2GTIGTxDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEbKCVltmczz2JOfel3FDiPPKcUBqwCyiU6xkkAGEWVEVXIKfnKb1LI5u8ffCdYrY86iYrHX1iZtMl8K1iAYDXfbk9yboHK/qp7JCgQuGw5lqTbJOAUmQ4eCX99ggtSE1eSXjRFfkYNhqDlawrN/hFmrHjxwkkXoxh0eyB5HU0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnGnx9LJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7126C116C6;
	Sat, 28 Feb 2026 01:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772241243;
	bh=4fyGez8Gp7VTPfTNdlPV+3xxbcqGU5YQPI2GTIGTxDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UnGnx9LJSKochupny/TOu3VUSXDMysqAdOu0RTYUZEIQDGewodJ9rxMmsKCC2BBhu
	 vVM4C3SmsGGAgvFBptQ2SjPEt1UtgX/7ckrF6PQ/eDaRUNrEyEwl7wj3u5v6n1HrpW
	 +zKwHjmnR233/Mdv0uFAK+CG9UEJxZmHRE9QxWRJwvQdOzKHmZuy9/SNJ+Lc1XIjPU
	 k9a92XsnS0gdoPdEASaoVnNt+6j8yibrGxOTScjg03ISDZtdPlhyHFrHT9LNn2Uxk9
	 eAQEzckovsP570wTl15tgJimSvkKT4Gicus9CndxH+t8/t2vFyttC1ydUymFh2s8yv
	 Ps4NcTM/OO5RA==
Date: Fri, 27 Feb 2026 17:14:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: xdp: Add rss_hash
 metadata tests
Message-ID: <20260227171401.14389c0f@kernel.org>
In-Reply-To: <4cf6b0ddf92fa8b9bc2107a20be08ea0a232e4ca.1772211065.git.carges@cloudflare.com>
References: <cover.1772211065.git.carges@cloudflare.com>
	<4cf6b0ddf92fa8b9bc2107a20be08ea0a232e4ca.1772211065.git.carges@cloudflare.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262027-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B3871BFACE
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 11:40:20 -0600 Chris J Arges wrote:
> This test loads xdp_metadata.bpf which calls bpf_xdp_metadata_rx_hash() on
> incoming packets. The metadata from that packet is then sent to a BPF
> map for validation. It borrows structure from xdp.py, reusing common
> functions.
> 
> The test checks the device's xdp-rx-metadata-features via netlink
> before running and skips on devices that do not advertise hash support.
> This allows the tests to pass, but one can override the device and test on
> HW or veth devices.
> 
> The test is fairly simple and just verifies that a TCP or UDP packet can be
> identified as an L4 flow. This minimal test also passes if run on a veth
> device.

Thanks for adding the test! The series doesn't seem to apply, I think
you'll need to rebase on latest net-next and repost.

> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 8154d6d429d3..6f9708e8d05a 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile

the drivers/net tests are expected to run against netdevsim.
You'll need to implement the xmo in netdevsim.. Or does it
already support them given it uses xdp_generic under the hood?
Alternatively you can move the test under hw/ and not bother.


> +# BPF map keys matching the enums in xdp_metadata.bpf.c
> +_SETUP_KEY_PORT = 1
> +
> +_RSS_KEY_HASH = 0
> +_RSS_KEY_TYPE = 1
> +_RSS_KEY_PKT_CNT = 2
> +_RSS_KEY_ERR_CNT = 3

Does pylint complain about those ? We try to keep pylint --disable=R
clean for new tests.


> +    ksft_ge(pkt_cnt, 1, "should have received at least one packet")
> +    ksft_pr(f"  RSS hash error count: {err_cnt}")

Does it randomly report non-zero?
I'm wondering why not ksft_eq(err_cnt, 0, comment='RSS hash error count')

> +    ksft_ne(hash_val, 0,
> +            f"RSS hash should be non-zero for {proto.upper()} traffic")
> +    ksft_pr(f"  RSS hash: {hash_val:#010x}")
> +
> +    ksft_pr(f"  RSS hash type: {hash_type:#06x}")
> +    XDP_RSS_L4 = 0x8  # BIT(3) from enum xdp_rss_hash_type
> +    ksft_ne(hash_type & XDP_RSS_L4, 0,
> +            f"RSS hash type should include L4 for {proto.upper()} traffic")
> +
> +
> +def main():

add:

	""" Ksft boiler plate main """

to silence pylint?

