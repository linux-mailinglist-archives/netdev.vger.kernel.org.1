Return-Path: <netdev+bounces-273279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF2SLiGyymkX/QUAu9opvQ
	(envelope-from <netdev+bounces-273279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:25:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA435F476
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8513A300C9A7
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD53D47BB;
	Mon, 30 Mar 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="3OtttYzE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3EE3A4F27
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891531; cv=none; b=OEjpy6cBcxC8ziy756ddq82qzDQ+KHoxfecR6ZouhYiceEMXV5cj/r+8lv8eMPuVl8sbhpF9d1oOMHZBbvlMBJjl0QmebuaoxYBzwJwNjPUmG/jJzAiDkk+6v8MTaprRJZ9wJdoxf0gHnDEsdNLEV5G61suwfShvC6omqJBPnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891531; c=relaxed/simple;
	bh=NnyYFE+HJVLJxtcsT92HLFm8mSe3dFIK/BDLxpKXpk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5zHKDDZza+OQAa6bqBZ1w0mv+Nrk3vfcz+rjucdSa9RQ7ecb1kOP3qt8w80ol4bpXFzTREMEzQcHRDr5pRQYo/zhxO3+wp+aTjLgvP0MtWKqpjmr2PIMQpu+AVLkLW72pUAyr6xl7NdxYiZY7daClt/0plfdyoziaR4yvVe03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=3OtttYzE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35691a231a7so2886361a91.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774891530; x=1775496330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4onAiBRNZOZ3SZoDzbxcCiu00GtL8ucl3I9j0zyMyW0=;
        b=3OtttYzEJgroh67iVYPSE8N2X0NeztMY+l6lUU1py3PoW54ggsF5/MMlIXuMsOltaA
         HWyBe656zNt/PLi+pr32AjiwpX/pvf83wAY+Lb45iIjrwq99wk0iggSWKFn9RSFB3zro
         W62dL6X5tmyTi+OuHjFR6m7dG1TzzDvVDJ/e7AdxSh/4SSb4X7VNiqjN4FMxBCJIWkTx
         OblUyIqYIPESB5pbFd+q28VUQqoda0xWKdueIG8huDjnclHlUuytewJAyygFl9IFzc0F
         fecJSKD4w7ICLpgSJeVxiGn4qckwJB3yS1KciyxHu/nj9eoRrz+ojKmHrK/v/u1uOvvG
         FAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774891530; x=1775496330;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4onAiBRNZOZ3SZoDzbxcCiu00GtL8ucl3I9j0zyMyW0=;
        b=jXlZmfwPj2aQ/2hV2L9dNoDMsI8t7zxERbi56+tEkrUW2mJ9aq+e91IE1kwrKVYHqB
         k8OI7mXeebt9Vxg+Ok3lhMCL5ZRlSRxhky4y4xQuhVaM11IOKTcl+3cT98s0viMqV4mt
         rHTctyRgkZZM92Cl9JPKbtMFiAnMooDRhLqO0700kWvOSiIhYQFdh8m0p6wtRMiJmVGV
         jdBc65tV8YpgkMiOnoL5niSCRXP5g7H8d/oNvILTOiMMc+BUYXkmuJrGtCFxKyWBWza4
         63Pdm/+eM/xM8fbxFmguURypjzJH0f3UWBx+rANl6sJvcaGlyLDKyHY/Aew0cM/LIVs0
         aWjw==
X-Gm-Message-State: AOJu0YwIBi1plqeOq99ucjOB4gRpUyfr9gKkzoBgWhKufTtppQJ7wiP0
	/Hl2z9EsyYfR2oPeLu+5M4Cin/5W7WhXSf4hxfpcE+hPWKXwpbVHTT3Yp1LselJ3dE4=
X-Gm-Gg: ATEYQzzlcPki3U8lkiDORCmWjIiNxeMRK1gBuOILsUyLI9bkon8CzBCw1VcuvkdDsnU
	O8wMaNCOjWnJSXzGFmJvLPSA2AbpXhlqCo7NPbZMUv/WHcajZFceZZc0PNimLxol4KirjN4gTPW
	T9/BMxG6qBmyz1h66dxW5XulVDHgOO8RyBipSIgSibI8IPzd162Fon4JMWPakdrkiwUZlcicuxU
	gfjdSYYNQ+3XJjxNUg/qswT+JvxzriHLDAqQoKWSUuMwiW2GbdDMdw4+6jo38BJgwTAntwCNkFK
	7vCkZDJCm8e44WqRORAZhAFKYt9LN7lFttdfstCvZPpQE8fY4VyBRkK0vIdlFBXv818mriM9bwS
	8E36Mk4WjXlXO7V3BKeHhApFYCid7G/jXe9CbibE569uA0u24v5ZE4IChpjNMJsHjmKvICHyA+3
	Pp78Q=
X-Received: by 2002:a17:90b:2ec7:b0:35d:974d:8f3 with SMTP id 98e67ed59e1d1-35d974d1935mr7478634a91.15.1774891529936;
        Mon, 30 Mar 2026 10:25:29 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2eaf1dbfsm5134650a91.3.2026.03.30.10.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:25:29 -0700 (PDT)
Date: Mon, 30 Mar 2026 10:25:28 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	leon@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [net-next v6 12/12] selftests: drv-net: Add USO test
Message-ID: <acqyCOYz7HqvnvQz@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	leon@kernel.org, linux-kselftest@vger.kernel.org
References: <20260326235238.2940471-1-joe@dama.to>
 <20260326235238.2940471-13-joe@dama.to>
 <20260329153130.61b29766@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329153130.61b29766@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273279-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 2FAA435F476
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 03:31:30PM -0700, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 16:52:31 -0700 Joe Damato wrote:
> > Add a simple test for USO. Can be used with netdevsim or real hardware.
> > Tests both ipv4 and ipv6 with several full segments and a partial
> > segment.
> 
> 
> > +def _test_uso(cfg, ipver, mss, total_payload):
> > +    cfg.require_ipver(ipver)
> > +
> > +    try:
> > +        ethtool(f"-K {cfg.ifname} tx-udp-segmentation on")
> > +    except Exception as exc:
> > +        raise KsftSkipEx(
> > +            "Device does not support tx-udp-segmentation") from exc
> > +    defer(ethtool, f"-K {cfg.ifname} tx-udp-segmentation off")
> 
> If may have been on already when we started, no?

Right, yea. I'll fix it. Is there a helper that does this generically for any
features, by any chance?

> > +    expected_segs = (total_payload + mss - 1) // mss
> > +
> > +    rx_before = _get_rx_packets(cfg)
> 
> Let's run a little program on the remote that receives the packets
> and validates they were correct? Maybe socat can do?

Sure, I can do that in the v7.

> > +    port = rand_port(stype=socket.SOCK_DGRAM)
> > +    _send_uso(cfg, ipver, mss, total_payload, port)
> > +
> > +    time.sleep(0.5)
> 
> What's this? Did you mean to wait for stats to settle?
> cfg.wait_hw_stats_settle()

Yea. cfg.wait_hw_stats_settle is clearly better, thanks.
 
> > +    rx_after = _get_rx_packets(cfg)
> > +    rx_delta = rx_after - rx_before
> 
> Instead of checking Rx (which is probably fine) we may want to check Tx
> has the right number of frames. Sender may have mis-counted the whole
> USO as one packet if it's buggy?

Sure.

> > +    ksft_ge(rx_delta, expected_segs,
> > +            comment=f"Expected >= {expected_segs} rx packets, got {rx_delta}")
> > +
> > +
> > +def test_uso_v4(cfg):
> > +    """USO IPv4: 11 segments (10 full + 1 partial)."""
> > +    _test_uso(cfg, "4", 1400, 1400 * 10 + 500)
> > +
> > +
> > +def test_uso_v6(cfg):
> > +    """USO IPv6: 11 segments (10 full + 1 partial)."""
> > +    _test_uso(cfg, "6", 1400, 1400 * 10 + 500)
> > +
> > +
> > +def test_uso_v4_exact(cfg):
> > +    """USO IPv4: exact multiple of MSS (5 full segments)."""
> > +    _test_uso(cfg, "4", 1400, 1400 * 5)
> 
> Variants are probably a good fit here.

Is the right way to do this by using test_builder?

