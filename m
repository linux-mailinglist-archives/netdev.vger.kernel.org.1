Return-Path: <netdev+bounces-284963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCuLAr91+2kpbgMAu9opvQ
	(envelope-from <netdev+bounces-284963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:09:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D40F4DE977
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DEA6305DF37
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E84BC015;
	Wed,  6 May 2026 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="sF2AKF7Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rrf7ZRyY"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E474A13A2
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087262; cv=none; b=UbhcgJNFkzhA+r04RmOUsKG5HsqC/hY01eLGHub/cy+HYApbwOKwUknThQ8pzHtWnqK29NoBb5IaSG5VBNdDkzbICRyXiz6tTOsFr8i2qQE5df+6KWbR7Ajs7Df2CV8SwMjKNshrnKNNqtxE+EK08K7LYR0oGx4uEhVqmzHK1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087262; c=relaxed/simple;
	bh=nbN/QaHyJkxc9D1I5v6/xaZXd/O9cJWCUJL3XzW7x+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLeebQTKsLIh3CINK69TpS6g2wKtmgctFleFt5nknAEUUvmTJS0eM/lPejofjjaB/yIUvjIrXfcGIuq6634634PxNaCPI2gpKEXTKaRaqw7d5ufaGhFW/KwihVHwASiTybI+6yoah9AmZDAxpFdb7Hv+DgNXGmle3PLwCGCZhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=sF2AKF7Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rrf7ZRyY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F26941400029;
	Wed,  6 May 2026 13:07:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 06 May 2026 13:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778087246; x=
	1778173646; bh=pg5UDl7ri/CJrMBtix6PRVI3CPKEaNW8yniAN0viWx4=; b=s
	F2AKF7YRms/po+4IqdiEQUfov7zBJ05JY4R1AL6Jasnalh40ilnZq7AkvXEx7Zka
	eZcBZRZv4ITDEyLSIKb6eFgesVzSnpOEcPGkPgelHChNeazSCTQcDdDaW9cCwQ2g
	7imii/68OVmomZlRyG6/UZpHu6VlTpTAqx1kF7K2riFhyCwl5yI+ENgc4AEk7SqG
	BCKgwyGTUDK1JOgNElXnga1MTAoLZIYysz2LfxQqpNeU9m1iyiq/9HXwbsMyhSSa
	gz3SmlIgw0cRUF9iVXsnjoyuHUfMkXfxreE1HqPORaMnSzT7ZXWwMVGDxojIkTPj
	m0EjIrIjYaVXDc4h8sPzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778087246; x=1778173646; bh=pg5UDl7ri/CJrMBtix6PRVI3CPKEaNW8yni
	AN0viWx4=; b=rrf7ZRyY3ukr1rq26NZhmTR9K/oi3w7H5uC36pIGVU2Ndsy7Dpr
	RML+TE+jp8VoZQ+NzxUOPnFzWzXyw4ODUG1chzKugYAvmXWmVzxm84iJgI1PmXUQ
	D5l6xEWywvxOddxj2ke+o1Sg9mUygFg0dUXtmMt9Q/FOT6xtHD0i8nOGwkljiYhI
	ek0OMhAIFLI4yAEyzVpFqkBqwWFWsyK4andXwSgUtQmQOiw1liqvL4qIzKQBiK0m
	5z9c9eLkJXgXzc320xnz5a0ap+8z/S+wapn2KbVKknLVO7lL26IslzBxkSGtjFjK
	t4lw1u1j9sFMR7M9gYBBVzjk+1b4lyNQwHw==
X-ME-Sender: <xms:TnX7aRxAZdX02ad0r7qvvnyTUhyz6TsLZmDFj_1Rp-meTdq91hgQ4w>
    <xme:TnX7adHetvJZmjEACtGFuldVBTPRX1woqRTpinmFIq0tbPViDafPNnc_cKzp9nn7b
    5yz4Q6S-VUQx3I2iGeJjKXS3Liw4OkSHrUuXQOS7SLTuxyYuTaTVA>
X-ME-Received: <xmr:TnX7aWveCRM4wa_KEI_Xi1URHsV0GWjZel-bN0q7b9uNMvnosMkrrc3krnb5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdehudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjvghthhifrghnihesphhurhgvshhtoh
    hrrghgvgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsrggvvggumhesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
    epthgrrhhiqhhtsehnvhhiughirgdrtghomhdprhgtphhtthhopehmsghlohgthhesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprh
    gtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphht
    thhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvth
X-ME-Proxy: <xmx:TnX7adASWgBHNPzamGmi-vXeU33kBEq6vSlNDKH9y3qT2NxFaeqjQQ>
    <xmx:TnX7aRB5ixFnUpFeA6uFYU873ckeVpU2j_8ECzEJkLhwTyC4baOyZw>
    <xmx:TnX7aXq95WyYAd9VMRlHwzw3NmT6JCcSfYmTw57gBkDgdXAXmRwUMA>
    <xmx:TnX7acFWHgjfuCcx5r056HwtFTnUNlpJC4yb-TIQvINzXgA_4Ynk5w>
    <xmx:TnX7aTlwebvI8k6HktRlAEck-_1rSsAD0zU1RmD__Vmf-md9fkJGzp9G>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 May 2026 13:07:25 -0400 (EDT)
Date: Wed, 6 May 2026 19:07:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v13 6/6] selftests: net: add TLS hardware offload test
Message-ID: <aft1S8uBtoyiDdmm@krikkit>
References: <20260429181016.3164935-1-rjethwani@purestorage.com>
 <20260429181016.3164935-7-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429181016.3164935-7-rjethwani@purestorage.com>
X-Rspamd-Queue-Id: 5D40F4DE977
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284963-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,redhat.com,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]

2026-04-29, 12:10:16 -0600, Rishikesh Jethwani wrote:
[...]
> +static int do_client(void)
> +{

Both this and do_server could be refactored into a few nice helpers
(prep the socket up to connect+ulp/accept+ulp, echo handling, rekey,
payload verification on RX).

[...]
> +	for (i = 1; i <= num_iterations; i++) {
> +		int this_size;
> +
> +		if (random_size_max > 0)
> +			this_size = (rand() % random_size_max) + 1;
> +		else
> +			this_size = send_size;
> +
> +		/* In burst mode, use a per-iteration fill pattern so the
> +		 * receiver can detect any plaintext corruption without a
> +		 * round-trip echo.
> +		 */
> +		if (burst_mode) {
> +			memset(buf, i & 0xFF, this_size);
> +		} else {
> +			for (j = 0; j < this_size; j++)
> +				buf[j] = rand() & 0xFF;
> +		}
> +
> +		n = send(csk, buf, this_size, 0);
> +		if (n != this_size) {
> +			printf("FAIL: send failed: %s\n", strerror(errno));
> +			goto out;
> +		}
> +		/* Throttle per-iteration progress lines on long burst runs so
> +		 * stdout over ssh doesn't become the bottleneck.

I'm not sure those lines have enough benefit in burst mode to be worth
printing. (same on the server side)


> +static int do_server(void)
> +{
[...]
> +	while (1) {
[...]
> +		/* Burst mode: verify payload matches the client's fill
> +		 * pattern. TLS record boundaries may differ from send()
> +		 * boundaries, so walk the received buffer in chunks that
> +		 * fit within the current iteration's remaining bytes.
> +		 * Catches decrypt-succeeded-but-plaintext-corrupt bugs
> +		 * that AEAD counters alone would miss.
> +		 */
> +		if (burst_mode) {
> +			int off = 0;
> +
> +			while (off < n) {

This would be a good deal simpler if you passed MSG_WAITALL to the
recvmsg call in burst mode. Then you'd get the full chunk of data for
that iteration.

[...]
> +static void print_usage(const char *prog)
> +{
> +	printf("TLS Hardware Offload Two-Node Test\n\n");
> +	printf("Usage:\n");
> +	printf("  %s server [OPTIONS]\n", prog);
> +	printf("  %s client -s <ip> [OPTIONS]\n", prog);
> +	printf("\nOptions:\n");
> +	printf("  -s <ip>       Server IPv4 address (client, required)\n");
> +	printf("  -p <port>     Server port (default: 4433)\n");
> +	printf("  -b <size>     Send buffer size in bytes (default: 16384)\n");
> +	printf("  -r <max>      Use random send buffer sizes (1..<max>)\n");
> +	printf("  -v <version>  TLS version: 1.2 or 1.3 (default: 1.3)\n");
> +	printf("  -c <cipher>   Cipher: 128 or 256 (default: 128)\n");
> +	printf("  -n <N>        Number of send/echo iterations (default: 100)\n");
> +	printf("  -k <N>        Perform N rekeys (client only, TLS 1.3; N < iterations)\n");
> +	printf("  -B            Burst mode: client sends continuously without echo;\n");
> +	printf("                server drains and handles KeyUpdate without responding.\n");
> +	printf("  -Z            Enable zero-copy RX (TLS_RX_EXPECT_NO_PAD);\n");

This is misleading, since zero-copy RX will be enabled by default for 1.2.



> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> new file mode 100755
> index 000000000000..f12da0e66afd
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
[...]
> +def verify_tls_counters(stats_before, stats_after, expected_rekeys,
> +                        tls_role, is_dut, burst=False):
> +    """Verify TLS counters on one side of the connection.

Even with the introduction of the check_* helpers, this function still
has a lot of c/p'd code just depending on role and test mode.

> +    tls_role: 'client' or 'server' (TLS role this side played).
> +    is_dut: True for the local DUT; requires HW offload counters.
> +    burst: burst mode - only the TLS client rotates its TX key; the TLS
> +           server only follows with an RX rotation on KeyUpdate receipt.
> +    """
> +    errors = 0
> +    role = 'DUT' if is_dut else 'Peer'
> +
> +    # In burst mode only one direction carries TLS traffic per side
> +    # (TLS client sends, TLS server receives). Check HW offload only on
> +    # the active direction(s); require HW on the DUT's active direction.
> +    if burst:
> +        if tls_role == 'client':
> +            errors += check_path(stats_before, stats_after, 'Tx', role,
> +                                 require_hw=is_dut)
> +        else:
> +            errors += check_path(stats_before, stats_after, 'Rx', role,
> +                                 require_hw=is_dut)
> +    else:
> +        errors += check_path(stats_before, stats_after, 'Tx', role,
> +                             require_hw=is_dut)
> +        errors += check_path(stats_before, stats_after, 'Rx', role,
> +                             require_hw=is_dut)

    # in burst mode, client does TX and server only does RX
    # otherwise, both sides do both TX and RX
    with_tx = not burst or tls_role == 'client':
    with_rx = not burst or tls_role != 'client':

    if with_tx:
        check_path(Tx...)
    if with_rx:
        check_path(Rx...)

> +    if expected_rekeys > 0:
> +        if burst:
> +            if tls_role == 'client':
> +                errors += check_min(stats_before, stats_after,
> +                                    'TlsTxRekeyOk', expected_rekeys, role)
> +                errors += check_zero(stats_before, stats_after,
> +                                     'TlsTxRekeyError', role)

and same for those

> +            else:
> +                errors += check_min(stats_before, stats_after,
> +                                    'TlsRxRekeyOk', expected_rekeys, role)
> +                errors += check_min(stats_before, stats_after,
> +                                    'TlsRxRekeyReceived', expected_rekeys,
> +                                    role)
> +                errors += check_zero(stats_before, stats_after,
> +                                     'TlsRxRekeyError', role)
> +        else:
> +            errors += check_min(stats_before, stats_after,
> +                                'TlsTxRekeyOk', expected_rekeys, role)
> +            errors += check_min(stats_before, stats_after,
> +                                'TlsRxRekeyOk', expected_rekeys, role)
> +            if tls_role == 'server':
> +                errors += check_min(stats_before, stats_after,
> +                                    'TlsRxRekeyReceived', expected_rekeys,
> +                                    role)

Why are you restricting this to the server? The client should get as
many rekeys as it sends.

> +            errors += check_zero(stats_before, stats_after,
> +                                 'TlsTxRekeyError', role)
> +            errors += check_zero(stats_before, stats_after,
> +                                 'TlsRxRekeyError', role)
> +
> +    errors += check_zero(stats_before, stats_after, 'TlsDecryptError', role)
> +
> +    return errors == 0

-- 
Sabrina

