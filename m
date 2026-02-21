Return-Path: <netdev+bounces-259815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dSqkE2ZBmWn1SAMAu9opvQ
	(envelope-from <netdev+bounces-259815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 06:23:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8080416C29D
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 06:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30C70300F181
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 05:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FFC27FD4B;
	Sat, 21 Feb 2026 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="AuK+1nXE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6433207A38
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771651427; cv=none; b=t2Mu1CS5pQg7i2DHTRlItszYK1Ox1BYwA38ALpmPUg6a3J8ZI4aDlbyap1U/ls4StreU7ATRsdE7jFgX+aCEnbzhl7JruAoZ1nAvPaBBKDe01gOZwebAjYojBXe4+uLZxFoDTqdhu/ntd9dNDpr4INjwX7BImDTYVSV//NBMV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771651427; c=relaxed/simple;
	bh=p/xtHdMPk1pR+VdyNY1pDhFYN4fePitbnyNh4l8YYbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiJkNRa1AgkHIRY9qSRfWULihiveDaAT33e+XfBT+2kbxWy6ZPGmCiDfRRygQPaEUuBUaG8AmL6tIeQaiR/Mc4dMzEucTM8R9mGLFEVjHMIffmCweVhCtDetKm11AhFJ0lkZIma72HXatwsutq2VXO+q2ycdSA/DANp/2o2l/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=AuK+1nXE; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4be94eeacso2415084a34.2
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 21:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771651424; x=1772256224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Pg2SfmNcjcuUaWT9UVC8V53BPdNDRsv1m5oJtLpHbc=;
        b=AuK+1nXEfXDrlp2LCgQy2Ly1mt4S4jC0aLL2Y7sp4SJkAhr/5S1YPj6inctOVRwmJ3
         B5PEcJgaP0JozpnMajyl+LqMPzIY45Ks7LCcYttmJJyMk6hjYlL8BTUEmcGAuFEdUbBu
         Tw/6lKr89JeFK8yBFHuMjQDVjjQ7mBuJ0nKEz59UEjuS008s2j8PcN8kwoOqMIs5DRUw
         +Qj2EUKIDtJNnQZRnbDBjraLLPHjs/mA7mtmD+Xkznj4lDyQeL2kH4hpPwGVbAv1x4KK
         moEbEwZEpBZWSjJcpjhMS8bcSCoJ1ZFsFnGc3Z6zxFkRoMghjxpI3Z7WBX94qoIr8Wg8
         TQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771651424; x=1772256224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Pg2SfmNcjcuUaWT9UVC8V53BPdNDRsv1m5oJtLpHbc=;
        b=WxoKml8EW6aXnGNLh6WdvaAvUmALW8V1+RvQ+aBkvGCyyLdDxN527BqD1pvSOegNCp
         1/TNHTe9zHM6j4igv9thE5cplBgXLXxXgNiDV3mMgp8z/i9w1cuvUoUF0b0cfAW4+uau
         6iBqPDNWAjxaDvX5omXDOXNxrJqiq3oWslypwjLCa7GukfvKIVWutfFMcJs9nDwj8/w7
         IJ9nAgp2kAA1KlNqcBLcP+koUcbZu3JkPtOfw6NOOV6HdIOeqUjbOsK9ipQsGvNybe+U
         TZAFTAzX5+UD3E1aXk5rgTWWAhUTgh2Bq0fUcf8CLKIQ99bEnjJP8kW1m9+kRnOQCrn+
         n0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXLzR2i2Gy2EOo71lWqqzFwAAUSEOb0CWjAr5u8xbQjgN8NHrPiRANuDc1jjvTBa/XWR9feDUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUHFJ37iSgAE0pu0Ur8Rm+guFgbPegv0yaaNk8jErVoJan5aNC
	UaDtImjMiaIIHddxL92pi+XZnvt8VHYDD2Th8btPZgQjcPZtCpgwkL5YHhSrLbEoTpg=
X-Gm-Gg: AZuq6aK+anDGd3+8OMXKISftfwzUNqsjizUh02eJtvlC1wORM/+hvBrp6Xc327eaEwK
	a/EqRN3PMi4vp3EPVcK+B3nIA89KuyZrKolK8GrVVSrhwD7MinpnpLBlgVispmSziZTbhe8sP+n
	g5Hcdk3UXtYMkmd/qZHccA3H2cXEtzKVOGOwpHEHkMrjzFbk8XT7NuafpgF5FPHWfpPYC24+kQu
	hit+yUGqyrcYAkIxLJ5nxiMAr3ijRq6sxOiDSWZN8U3JhZXyzmTzyu46JpepQYo+yaXBUJI/Ej7
	VATTKXDA4erqOqB7Ea4Qnc20BOcbNhvn8ZHwDkdM0rNwsNhe39Bwb1Lox2QWiHefDCpIe91lMg4
	ro9SsVRNCkfEYtS+yHgoiyELhqDMNp5RSGDU1LbLmIQgCUJmDif/UgK6lrB14ppDkKZlsUFjvnk
	TzSem/ttuPtWNrkpRn8nwxotjL4gx99LPFGFjDie/Zu4YFj8D5riFQhVH7QPUL6nuCQQ3dsl90s
	90=
X-Received: by 2002:a05:6830:2aab:b0:7cb:125d:2a47 with SMTP id 46e09a7af769-7d52beb1751mr1373900a34.1.1771651424472;
        Fri, 20 Feb 2026 21:23:44 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d04e0bbsm1473746a34.24.2026.02.20.21.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 21:23:44 -0800 (PST)
Date: Fri, 20 Feb 2026 21:23:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next 3/3] mptcp: monitor: add JSON support
Message-ID: <20260220212341.2481f496@phoenix.local>
In-Reply-To: <20260220-ipr-monitor-json-v1-3-eb4b0d5f7820@kernel.org>
References: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
	<20260220-ipr-monitor-json-v1-3-eb4b0d5f7820@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-259815-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[phoenix.local:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8080416C29D
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 19:54:03 +0100
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> +static void sig_exit_json(int signo)
> +{
> +	delete_json_obj();
> +	rtnl_close(&genl_rth);
> +	exit(0);
> +}
> +

Technically, none of these functions are signal safe.

Maybe an atexit cleanup function, or on_exit, or destructor.

