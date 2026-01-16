Return-Path: <netdev+bounces-250404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B67D2A4A2
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 354E8303ADF3
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9DA33B6E7;
	Fri, 16 Jan 2026 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYsU4zFM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8E33A9F9;
	Fri, 16 Jan 2026 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531488; cv=none; b=BbhQ5MKc8DIOr9lDNWl7Wdb+g3H2Snsw9ZAe97yKDHejq9G6khCCUBCnxE6oyJj80KLxEt6W0UfR/ZSJlns1b5iaC0XyG9VRnJ0kU8BwSDCvnUOxax4FoZnICk8ICLkvOxei8BSIcW8FbfySfYY+Vv5MP9y+czaNer7sBa4gDWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531488; c=relaxed/simple;
	bh=zjjgKAUFFV1Di6ur378+taOvNIZx/kP5IsC6jbp5tjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDxUJ+ZhFy8H7+W5Xtbl/WoJNQyuedbVTEEIZR7k4Ozc6ku5kxHe2Ai2FfW2k2XAX4Oxg61qeS0JeB3DRHEPpJfde4e7FkALJxgztEZAtFImUaO6OulamFLjbm99HQ2EasvkJXlrRErVtdm7dA4I2kJYSwCbFkceMfKEJWUkMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYsU4zFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC226C19421;
	Fri, 16 Jan 2026 02:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768531486;
	bh=zjjgKAUFFV1Di6ur378+taOvNIZx/kP5IsC6jbp5tjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYsU4zFMeqR5ZKrh+17wtiYIi1+Ov2oAZ/EaV8m/K4ghdlcs+2QDgyCwfmpZinzOI
	 Tf3vZQHvFyuS1+33mYCpzdDbi318KLVA5gJbqel10vMhJRWFTWJFZzhjocoxx/7aBF
	 CogwhwXO+D553HfFjnvLn889pG+R9psO05wcqswJFlQ+CnyMwG9JxlnTm7Ds11A4Ff
	 +gWps32VQXWYg0zGQ6aeATk9IxH2lkyhUZx/LzgAgxbqUydfj1VxI6iqCctovr4vHT
	 sEZoA6K0BCebJmtwnqgLrjkZoar64vpGYwmzrqiVCndqcXdu2E0HHIn0Rw5sJCd0Zh
	 3aXCNMtWOFqew==
From: Jakub Kicinski <kuba@kernel.org>
To: slark_xiao@163.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	quic_qianyu@quicinc.com,
	davem@davemloft.net,
	loic.poulain@oss.qualcomm.com,
	johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	zaihan@unrealasia.net,
	johan@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	dnlplm@gmail.com,
	manivannan.sadhasivam@linaro.org,
	pabeni@redhat.com,
	mani@kernel.org,
	ryazanov.s.a@gmail.com
Subject: Re: [net-next,v7,7/8] net: wwan: hwsim: support NMEA port emulation
Date: Thu, 15 Jan 2026 18:44:41 -0800
Message-ID: <20260116024441.347826-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114625.46991-8-slark_xiao@163.com>
References: <20260115114625.46991-8-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: wwan: hwsim: support NMEA port emulation

This commit adds NMEA port emulation to the WWAN hardware simulator for
GNSS port testing. The emulator generates GGA and RMC sentences every
second via a timer callback.

> diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
> index 11d15dc39041..e4b1bbff9af2 100644
> --- a/drivers/net/wwan/wwan_hwsim.c
> +++ b/drivers/net/wwan/wwan_hwsim.c

[ ... ]

> +#if IS_ENABLED(CONFIG_GNSS)
> +#define NMEA_MAX_LEN		82	/* Max sentence length */
> +#define NMEA_TRAIL_LEN		5	/* '*' + Checksum + <CR><LF> */
> +#define NMEA_MAX_DATA_LEN	(NMEA_MAX_LEN - NMEA_TRAIL_LEN)
> +
> +static __printf(2, 3)
> +void wwan_hwsim_nmea_skb_push_sentence(struct sk_buff *skb,
> +				       const char *fmt, ...)
> +{
> +	unsigned char *s, *p;
> +	va_list ap;
> +	u8 cs = 0;
> +	int len;
> +
> +	s = skb_put(skb, NMEA_MAX_LEN + 1);	/* +'\0' */

[ ... ]

> +static void wwan_hwsim_nmea_emul_timer(struct timer_list *t)
> +{
> +	/* 43.74754722298909 N 11.25759835922875 E in DMM format */
> +	static const unsigned int coord[4 * 2] = { 43, 44, 8528, 0,
> +						   11, 15, 4559, 0 };
> +	struct wwan_hwsim_port *port = timer_container_of(port, t, nmea_emul.timer);
> +	struct sk_buff *skb;
> +	struct tm tm;
> +
> +	time64_to_tm(ktime_get_real_seconds(), 0, &tm);
> +
> +	mod_timer(&port->nmea_emul.timer, jiffies + HZ);	/* 1 second */
> +
> +	skb = alloc_skb(NMEA_MAX_LEN * 2, GFP_KERNEL);	/* GGA + RMC */
                       ^^^^^^^^^^^^^^     ^^^^^^^^^^

Two questions about this allocation:

1. The buffer size appears to be insufficient. The allocation requests
NMEA_MAX_LEN * 2 = 164 bytes, but wwan_hwsim_nmea_skb_push_sentence()
is called twice and each call uses skb_put(skb, NMEA_MAX_LEN + 1) which
reserves 83 bytes per sentence. The total needed is 166 bytes, which
exceeds the 164 bytes allocated. Would this cause skb_over_panic() to
trigger on the second skb_put() call?

2. This function is a timer callback registered via timer_setup() in
wwan_hwsim_nmea_emul_start(). Timer callbacks run in softirq context
where sleeping is not permitted. GFP_KERNEL allocations can sleep when
memory pressure triggers reclaim. Should this be GFP_ATOMIC instead to
avoid "scheduling while atomic" warnings?

> +	if (!skb)
> +		return;
> +
> +	wwan_hwsim_nmea_skb_push_sentence(skb,
> +					  "$GPGGA,%02u%02u%02u.000,%02u%02u.%04u,%c,%03u%02u.%04u,%c,1,7,1.03,176.2,M,55.2,M,,",
> +					  tm.tm_hour, tm.tm_min, tm.tm_sec,
> +					  coord[0], coord[1], coord[2],
> +					  coord[3] ? 'S' : 'N',
> +					  coord[4], coord[5], coord[6],
> +					  coord[7] ? 'W' : 'E');
> +
> +	wwan_hwsim_nmea_skb_push_sentence(skb,
> +					  "$GPRMC,%02u%02u%02u.000,A,%02u%02u.%04u,%c,%03u%02u.%04u,%c,0.02,31.66,%02u%02u%02u,,,A",
> +					  tm.tm_hour, tm.tm_min, tm.tm_sec,
> +					  coord[0], coord[1], coord[2],
> +					  coord[3] ? 'S' : 'N',
> +					  coord[4], coord[5], coord[6],
> +					  coord[7] ? 'W' : 'E',
> +					  tm.tm_mday, tm.tm_mon + 1,
> +					  (unsigned int)tm.tm_year - 100);
> +
> +	wwan_port_rx(port->wwan, skb);
> +}

[ ... ]

