Return-Path: <netdev+bounces-284120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC83K9Q2+Wki6wIAu9opvQ
	(envelope-from <netdev+bounces-284120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:16:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A84C52DE
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAB8B30037CC
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 00:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7C0187346;
	Tue,  5 May 2026 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="j3/QywUO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC117C220
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 00:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940177; cv=none; b=SVnNmhEnHBx9huB2xnojajbvFRmrOae5zRkHOyBCHUCT62xvHyy2liakVYe/iwazJmAwk6vp8RnmMX7e3LWv4umBE/N9WAGkmmFrcEFTgN1wFEeAmf/75tbVOMlrCq9qkxB/gKSmxNRvYfdKu98VVmKvTliStcbfv9wW0MTDUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940177; c=relaxed/simple;
	bh=N7Q0Ae6m6x6vh7LGHKXMsvlFaehBTgaWDd++H1tb+oU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzJsKrFh7RdojIIEugoY6ibRM1vTdmd8hKTqRyF+dXzRbty1GcMgzz2SKWacFWKjqfrRNELOwZ4cVP9W6CuERiqFDAAHa6TCDSFRRSygvFDgr7uIuw0iERgve5ZsBcvU7PwLUs6FR10HEFAJQjUVxurut01uNZLaQXqPS0WbC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=j3/QywUO; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-479fc1fc048so3308452b6e.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 17:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777940174; x=1778544974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vW3wfKNDyblJFV7YdonZtH5qOl3Qb0KySHL6/x6bkk=;
        b=j3/QywUOuDHlyATUMzjMgKnuBKehTCZU+/zosTDSYX/MkBNC95u3WqG6j3DjR5/LIo
         4iw/pjPZM9Ruz0L2Xl2bYasowVmd3B+i+p8Rq1SFxw3ordUQFnlH93tU5LevMPZ4MoMj
         SrbNjE+WgkbDRI4wFinqllpwp0c2h73nJYtW6OPuXZyuP+DbeYb5yz7Acfr70m31dYy1
         vLzyl4LW3KYsgzrcEMzJ4ZCNifnlXGp5hrD674MdQ0SDKDE0q6UXqqzHEJ1+wDOjjTcm
         158xMII/qVacOeoqLruwEYY8Hql9ZCHCXdYpURslhsX3hWTPzbk6BFnkQK/bqdepJi9D
         bRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940174; x=1778544974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0vW3wfKNDyblJFV7YdonZtH5qOl3Qb0KySHL6/x6bkk=;
        b=mXEy5IBhaqAPgNJW9Sljq11UbGOAWMJtiBA9ZXd2kBcWZlxmrbRpf1PL6YzoEmH4mt
         wd43+prtwaQrNO4gT6+5hlPwmXH8uDjJOkQHnFjnDVIlxhSuysXqQESyYBjq3pguLrDo
         wQRCsqJ9FsCUJMY6FjBJYMH+UBD6d4WIpzgFRlGvi62GWQ6aRx/BwXyx6QNRusb0thGG
         27R4B4KwBwKaE5+nxaxlDVnyRqbQUNpCycYU5GZnB6IBNRfrfX01a58+B42LsPE7oD/J
         SKEiiW/f76D1HMIxITBj/Akuamw0f/rDxjWVrF821r/PXPC92LT8LHd2t+Xh8bwVmGPh
         YVdg==
X-Gm-Message-State: AOJu0YyRZyBvUTWH3hBQnQ7HxUaoupWSDr794BEX2Xi1N3kUzXxFzKkX
	E8nh8BMU9tR+13dUN5muU2JVPuisfWUG3KIMHOn6r/6DCWT4CqwL4cQazaNjUcC9JGmknMmShCz
	+rjNX
X-Gm-Gg: AeBDieudMuwiVriSM4IwvfHAkjtrFGgmvqylC8J7DtZhG51tYSPMVUxgHQYxEhbEte3
	S/F0l/mLz49v22vAjM/v+7FPTLy7A1MZXU7RmtK0QRyLFiU6lplxBZYyt2ylKrQ/kBte1K2W+yP
	LxsAvzuWCz6NvhNDX0COgmvU66TPpWUUyPzdbmNYV5mHIbiarzK6fGyhX3duJ9TnoJgvD0g2cxk
	8aVxjRsjpqRRr7/Kj3O1Newx516frNb+cm4tGTVIlp+vcUZLxKXACJD1/3nJ7rHmTFXdAEjHtx4
	qNoAeS2abFuOfCStxVqD1G9yYFnck0zSVI96p3F6Bohq82ru9WCzRcLNWKFmd3ZGIq9UAB24ngP
	SCGU0MmRifmlzUcpo8r9HxwZLZZ80H/VjQN8Kv5vvbgo64jM1PirdueyxNcxyQE7+mnlDjkXcTI
	H4AiykKv8iYcJpbdmxSW0e9YR+pEQSlWt3yl+Yko0O7VdKVQ==
X-Received: by 2002:a05:6808:1b8d:b0:479:e96e:65b0 with SMTP id 5614622812f47-47e18250dc1mr572179b6e.10.1777940174531;
        Mon, 04 May 2026 17:16:14 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986404sm7590602b6e.15.2026.05.04.17.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:16:14 -0700 (PDT)
Date: Mon, 4 May 2026 17:16:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [PATCH net-next v2 4/5] net/sched: netem: add per-impairment
 extended statistics
Message-ID: <20260504171611.127dc06b@phoenix.local>
In-Reply-To: <20260503195348.521225-5-stephen@networkplumber.org>
References: <20260503195348.521225-1-stephen@networkplumber.org>
	<20260503195348.521225-5-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 069A84C52DE
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
	TAGGED_FROM(0.00)[bounces-284120-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun,  3 May 2026 12:52:02 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Adds new counters that keep track of when netem applied
> impairments (delay, loss, corruption, duplication, reordering).
> Add a struct tc_netem_xstats reported via TCA_STATS_APP so that
> userspace (tc -s qdisc show) can display per-impairment counters.
> 
> Use the WRITE_ONCE/READ_ONCE pattern to allow for lockless
> qdisc usage.
> 
> Accompanying iproute2 change is submitted separately.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

I don't know how to argue with Sashiko but it is wrong.
It flags the counters as susceptible to torn reads but these
are informational only counters and the new counters follow the
pattern of Eric's other recent changes.

False positive report.

