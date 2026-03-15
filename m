Return-Path: <netdev+bounces-267929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VHD0MMPZtmnBJgEAu9opvQ
	(envelope-from <netdev+bounces-267929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:09:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B619F291590
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7700D3004600
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00826371869;
	Sun, 15 Mar 2026 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rVdpOlrX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69D1A3157
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590973; cv=none; b=Dz6R9eBdpfom/qet7je06otdzmf1aEPa4DKO4BRBilTadh7sxvMZVnBFVb5B+3rfSLd63Aik/mBK7HON04tFDXt550yuVdVmqypuXK7EGJZ+EFUru/2i3YVWVY1c0KqWEYFj9GTfxfF5M1C0UUDXg/pi9A8u35riCE7WwkxePq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590973; c=relaxed/simple;
	bh=T2vp3844fJTBrEDvl19e3BV77MqfhOXX2yA53rOUILY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1gmSmNbuRQd4Md52YPhjYh1ZZXbOfndeyb4spyHNzrAp+NgTOLAp9zk2zqSpjMi7/ymBAATcLdLifvwmXZyR0bXiWjOciB0YI0ZibNBEd6vs6zk30X7I5WDvTQMgu15rpPXwlgYkaPWH6ph+wL7ustHI0K1U+/xQnUgSQRd3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=rVdpOlrX; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4b77adso4488901c88.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773590972; x=1774195772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qJ+hHVKiROPoKaNf1w0wFOK4ImNMy0k37ajAkoMv14=;
        b=rVdpOlrXHTQFEfyY5Yen9zonvuylB7JMnaFDb21SjS/H/fdwHHcu6ANRmh7ORY/mw/
         uP1SK9qRlpszTxwpiO8a07/v8HLHg94ziARNKe6TPI+2nT+sLZvZc5opVcAv9OIN0GRy
         5LpbDoOXs/fMjIeMd0jK3Anw+01yL2ZKZPsPtNyMEaZjX62fLtc1tE8a3rhF0aagEgOp
         wS529i2DTUCwobTB0SKb64Wf3q+d6/0673jfm3QBeNUALF/A7yQufnx7cwXArgUFcr0k
         5IA/fe3lYh9ysKHGOQv9B3aAct0317S3ojYXFu5gGCXWh28/yGyRJUekJbf94JrxxbQD
         MoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773590972; x=1774195772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qJ+hHVKiROPoKaNf1w0wFOK4ImNMy0k37ajAkoMv14=;
        b=Z0QHubfEIhrj5fEBEiF0DwJWxi4TyE44gmZEekm/qZAgpajSW8VInk/ZErbBwmT+w+
         vVIXisFvP1hXwjvPvYoWQ3cDfgJDngK8lCNJHmyIpRRy1li1I+A5qjNoHWbLkpehGQXw
         9k8gH4onx3P+5KqSHQd3Ylalr3pN/XSHkIM5B06E6Pb7TzdbS3inuPxvSbn3EnsGV5OE
         bfOLXJUyYIY9C7kslc6eD/Mi0S6DiJI4FuRrEWMinCEp7hNwP+ZOO5eCXYrY5MPRqA8H
         v8U/pqweqOhiF4lBe1/TG1GGP8kbiapJ4LPT2Weezyy94xQwmz+EHyHd3AlJqfoiXSPL
         AJjA==
X-Gm-Message-State: AOJu0Yw7Ie3HymnuObGBjBHRhRujpLEcXtQpQ730W1gQERsdTtfa2mOn
	RfGLfv9zoh6MDMxwPaPMGDYzA86xvZ39ohoPZ6ZQIQULrnl0T+F0RJbKXy4TiYRDhLltnXYNk8p
	K0cUR
X-Gm-Gg: ATEYQzxYVWs9VQGaAGdP3H10Tkf5w4LHUudzN13YDat44c0/STT2E1YvqnJdQFy6pyW
	cRt1C1oeAqoMla0smV8Lj98fyWgET6Sr4tPf23KDdtI3l33G7H8PL001svPdEDLt1Ei2uhAUCB6
	8BINcpgPZkHf9Ix3v/2SVcTZTrL9UyLEXGhY0k1WvYk4tEKaDQWl/0IxXSPy7LuhqBMXX4w+zHK
	QE4NAoWSfrvQlP7/Q5tQgMn2OlC5KeOMVZXw46giFmXWiXbJAnhwXYb/pI+1Akm+7OdqO+CkzKm
	jr2BW0P5tVlL9xyo8D1hN1izABnmkv4lbz/DrtcCnQJ7F/q67cwBOQHKiXvXCNxmmgM/333fDCF
	KWZn8fEuSYvVbc/vnIFJCyQ4MK5PaitGvjLJ5uZczPw/GtGLONzLYXatB0gM2kOs5m3ilBipOu/
	QDm+hzpSjuzEZJuvJJiN1uZcH2l90iu19j0XE=
X-Received: by 2002:a05:7022:309:b0:119:e56c:18ab with SMTP id a92af1059eb24-128f3d4fd5bmr4135038c88.19.1773590971642;
        Sun, 15 Mar 2026 09:09:31 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62b2100sm8420862c88.8.2026.03.15.09.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 09:09:31 -0700 (PDT)
Date: Sun, 15 Mar 2026 09:09:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v2 00/10] netem: fixes and selftests
Message-ID: <20260315090929.7cf2c132@phoenix.local>
In-Reply-To: <20260315081953.3ceb7a84@kernel.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
	<20260315081953.3ceb7a84@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267929-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B619F291590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 08:19:53 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sat, 14 Mar 2026 17:14:04 -0700 Stephen Hemminger wrote:
> > The check_netem_in_tree() restriction added for CVE-2024-45016 rejects
> > valid configurations such as HTB or HFSC trees with netem on multiple
> > branches -- including examples from the netem documentation itself.
> > This has been an open issue for over a year (kernel.org bug #220774).
> > 
> > This series replaces it with a per-CPU recursion guard, restructures
> > dequeue to fix the HFSC eltree corruption, and addresses several
> > additional bugs found during a code audit.  
> 
> # not ok 379 7a01 - NETEM passes traffic with delay
> # Could not match regex pattern. Verify command output:
> # qdisc netem 1: root refcnt 33 limit 1000 delay 1ms seed 151499771072372938
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 380 7b02 - NETEM passes traffic with duplication
> # Could not match regex pattern. Verify command output:
> # qdisc netem 1: root refcnt 33 limit 1000 delay 1ms duplicate 50% seed 4449138859105539433
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 381 7c03 - NETEM passes traffic with loss
> # Could not match regex pattern. Verify command output:
> # qdisc netem 1: root refcnt 33 limit 1000 delay 1ms loss 30% seed 17755509090945397811
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 382 7d04 - NETEM passes traffic with corrupt
> # Could not match regex pattern. Verify command output:
> # qdisc netem 1: root refcnt 33 limit 1000 delay 1ms corrupt 10% seed 15571003730150948945
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 383 7e05 - NETEM passes traffic under HTB with two netem leaves
> # Could not match regex pattern. Verify command output:
> # qdisc htb 1: root refcnt 33 r2q 10 default 0x10 direct_packets_stat 0 direct_qlen 1000
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # qdisc netem 10: parent 1:10 limit 1000 delay 1ms duplicate 25% seed 7229481943258718053
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # qdisc netem 20: parent 1:20 limit 1000 delay 1ms duplicate 25% seed 2614650852791982394
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 384 7f06 - NETEM passes traffic under HFSC with duplication
> # Could not match regex pattern. Verify command output:
> # qdisc hfsc 1: root refcnt 33  default 0x1 
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # qdisc netem 10: parent 1:1 limit 1000 delay 1ms duplicate 25% seed 1742473429681626986
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 385 7a07 - NETEM passes traffic with nested netem
> # Could not match regex pattern. Verify command output:
> # qdisc netem 1: root refcnt 33 limit 1000 delay 1ms seed 959619114654116267
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # qdisc netem 10: parent 1:1 limit 1000 delay 1ms duplicate 10% seed 1402527459214356892
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 386 7b08 - NETEM passes traffic with TBF child
> # Could not match regex pattern. Verify command output:
> # qdisc netem 1: root refcnt 33 limit 1000 delay 1ms seed 3026058286388988065
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # qdisc tbf 10: parent 1:1 rate 1Mbit burst 10Kb lat 50ms 
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 387 7c09 - NETEM passes traffic with all impairments
> # Could not match regex pattern. Verify command output:
> # qdisc netem 1: root refcnt 33 limit 1000 delay 1ms  500us loss 5% duplicate 10% reorder 25% 50% corrupt 1% seed 4173999615992747611 gap 5
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 388 7d0a - NETEM passes traffic with reorder
> # Could not match regex pattern. Verify command output:
> # qdisc netem 1: root refcnt 33 limit 1000 delay 10ms reorder 25% 50% seed 16878270064950901169 gap 5
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 389 7e0b - NETEM passes traffic with slot pacing
> # Could not match regex pattern. Verify command output:
> # qdisc netem 1: root refcnt 33 limit 1000 delay 1ms slot 20ms 40ms packets 5 bytes 1500 seed 12148330044418512905
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 390 7f0c - NETEM passes traffic with rate limiting
> # Could not match regex pattern. Verify command output:
> # qdisc netem 1: root refcnt 33 limit 1000 delay 1ms rate 1Mbit seed 17545598048030611383
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 
> # not ok 391 7a0d - NETEM passes traffic with SFQ child
> # Could not match regex pattern. Verify command output:
> # qdisc netem 1: root refcnt 33 limit 1000 delay 1ms seed 7568266806072117190
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # qdisc sfq 10: parent 1:1 limit 127p quantum 1514b depth 127 divisor 1024 perturb 10sec 
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
> #  backlog 0b 0p requeues 0
> # 


The new tests use scapy like the other qdisc tests, looks like CI is not
setting up the interfaces the same as local test. Is there something needed
elsewhere? The codel test does similar things.

