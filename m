Return-Path: <netdev+bounces-284130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMLsDY85+Wni6wIAu9opvQ
	(envelope-from <netdev+bounces-284130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:27:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8394C559F
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D913B3058E35
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 00:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A2E279355;
	Tue,  5 May 2026 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="iZ6gW5W5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FD27AC57
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 00:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940742; cv=none; b=MKpDl9sCXC8oiwO7H0iG7mR/U5Qz4I03pjbuu501khig2NR0cRCumQ3TewOeqF1xK6ULgd2ROEgCDztmy7dyyjlYjQC2r2svfb+0RipAHUJNGXClIIAYOiwh7WyCv4gWXkOs/o9WNCk0fgtyn5OqWIZVaPLPhu2D5bOIXjIpvlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940742; c=relaxed/simple;
	bh=CfNZ21j/ytOI11/o9nTzKxqdiP+E+HudmFUHHeI0zkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REot1UZvQVbrwOWJyPq94lVAjRJyKQdX6UhRhY0ivkI4vf69iiRB94ZgGnA6TSHmmpaDJRL9qBhwGkta4noRsELsJaiTnSIal5IXYEIxxx2OYwH9/VmVDYJSNdvZUnaB0evF0gq3VN51amNbTyj7Q05SV3hmnkyr/OYR4ST7WE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=iZ6gW5W5; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7de4ed0593fso2865313a34.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 17:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777940740; x=1778545540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF9jZOMoPMQrHLZjiJYbpYprix2/+SHujxlOxM3kN78=;
        b=iZ6gW5W58kwzlUHBzrBixfSKccBozvHcZaMQx5YK10u5bKvnUbS9cT8Kaomz9RybKP
         za4r+YHmwET8mIggEKlPLXn9mlpeetypUlf+b/Zh7+cSaG/0UThI0RO57tA6c+ZUxBBG
         thVehn+cXvG4GJsYZTU5zPDxhWf6Bb+ofKmhHmmZiQHumsdPGtKXYKDrTQNQlX3P8utC
         wHkmToBKetasA3Pypbm6+8bVFlJ1S1ADC9uSSv/M1UFWyMgTyEhJg0DYkqKGXaK58dCb
         etirJyLjst/M/bBweP3CbNh85ROP8TY85Uhktv7JC5DZlh1y8c1TwhB0lJ7M1k+g8uED
         Qogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940740; x=1778545540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CF9jZOMoPMQrHLZjiJYbpYprix2/+SHujxlOxM3kN78=;
        b=rhZA7gG7J4X6eM18QNYd5IldWaNkaaH77aAdAKhQY7pnkpQpVQ5Dh3gXQh01RLDSm5
         if5gnT5mhKKE3308YZJFjzzDBnrKzmDtIVvlnpeoG00nAYXuMzp5Kbzyqx6pXvTxk87a
         OqOzRIUQQzhRWBRMcBq7ASswijyDcxRLrUiZ+7LmRpaaWmhTcXVVcJrHSRFDbyYjT8RL
         rLgzszxqcy+Fq1MESMOzo0ycdIWuneSv3pzq0e+OdGAtckcPGbl2Ds+Gt0W977TNyMg+
         CeB/mv2YPA/UyF+X8gI6q/UzuGBmygZxPE0rmiMu6Vd3zXxdTG13vVe5p7dLJVrF1jWE
         InnQ==
X-Gm-Message-State: AOJu0YxV37y6NikXQ2ALqwRjaNXjkugcNHK2MxZ9cP4I/ieWBGptf19O
	yKhUclkIkrJL0omzVeRo2NV2cR6c+jHsSXrL4Yz2Rd13rsgL5spYqP7VnxD1M/8JjF+wk5swg7Z
	5auQ4
X-Gm-Gg: AeBDieuqCl0G4R4fY2Miz6NTYB05Bgq5BsF2+9d3g9/sfHn8+rIsKj0Bx6r3RwEnbPq
	oFq+0mNjkELBsZtV+Rlts9O22mI75m0cPikdkHXfYoVarIIX6e6BgQeasiU4mLzDPU4povvimfk
	YoC1Pg/zglteq/rJKTskKjfgLLtDZSk6AcELl+C7fi5uGkoV+2rh+AsCaxgqXyYs5v6UJ9EQei/
	wagMkLg7AIv1djoAPPfU6DYxVEUrlD60GQvP4LLnMWH057ri6j/wUru29iPgonIc8EPrTk4Uqrd
	gcyntAlONHnTp8SpO5VR1ROrkc+to+DSIlGl+4gifZKmM0Jq7Cfkn643wCRT2mBZ+bLA9uzNswt
	8sYLJDDWOIEl76AtzN8FTb30KttkM839kGNq5q1UrE+Yr5gTWmP3EU0fFIqWEpAMIlxehdu4xp5
	wNFzMPmrqFUnkPrE0Tk7RxI8nkWhDbADKjmSvNE1ie/sXzvg==
X-Received: by 2002:a4a:e914:0:b0:696:2cdf:15e2 with SMTP id 006d021491bc7-6998a599dd7mr421335eaf.7.1777940740134;
        Mon, 04 May 2026 17:25:40 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69689479359sm7507216eaf.7.2026.05.04.17.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:25:39 -0700 (PDT)
Date: Mon, 4 May 2026 17:25:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [PATCH net-next v2 5/5] net/sched: netem: handle multi-segment
 skb in corruption
Message-ID: <20260504172537.36d8dd69@phoenix.local>
In-Reply-To: <20260503195348.521225-6-stephen@networkplumber.org>
References: <20260503195348.521225-1-stephen@networkplumber.org>
	<20260503195348.521225-6-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8C8394C559F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284130-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,phoenix.local:mid]

On Sun,  3 May 2026 12:52:03 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The packet corruption code only flipped bits in the linear
> header portion of the skb, skipping corruption when
> skb_headlen() was zero.
> 
> Use skb_header_pointer() and skb_store_bits() to access the
> full packet data, allowing any bit in the packet to be
> corrupted regardless of how the skb is laid out.
> 
> Replaces d64cb81dcbd5 ("net/sched: sch_netem: fix out-of-bounds access
> in packet corruption") with a more general solution.
> 
> Only count the number of packets that were actually corrupted.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

There are problems with this since it doesn't handle zero copy 
correctly. Needs to make full copy.

