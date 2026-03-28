Return-Path: <netdev+bounces-272727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PaeOPBvx2nnXQUAu9opvQ
	(envelope-from <netdev+bounces-272727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:06:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5834D799
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B812B3034DC1
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3618D309EE9;
	Sat, 28 Mar 2026 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="I8PeJX2A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0B2DF156
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774677998; cv=none; b=Q1jscXhwfhCsrdsTTIBU01/Ewfa1we+U19VxyNN2zdhLPxuRL8WVxiiAsLUaW6uiYmPT3gEX2KRJ092706zH+3srfKoaypNKmLn72uP0VX8ARA2wsd06CsAzRT5yIV7HdX4n6Mz9jg95M1OXEqZeSQWFuXJWChPNiLPnKeaa+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774677998; c=relaxed/simple;
	bh=0Xp/nC473N6MzrjjihQ+pA/SoM0IAByS0Khxi3q9oP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9rwKvyk1066KZKg01RZiMJdyuSA27T8O37alPaeKhgnVIaDMmw0w8jIn62oCVNKjZRuMf6jxlfnwwImdakZJGS9oR1+SkWSQT169uoVHI+C3aR22cCHyqzgorvzieqjsF33/uD6af0X8QUlju9ReFRCFLa0Rk9E/zWXahvbVFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=I8PeJX2A; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c175635a33so1979338eec.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774677996; x=1775282796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UFRU1bS8HFHkRjVrl9E5GNOg3WQVTUj/Y+AMxYSKfQ=;
        b=I8PeJX2ALRpHslFarOGmanSxQ3Ve76TvTmuZuZadacceaJcaW42S9UHNxoIuK/klW6
         23lptN2J1wR9pXAaprsM/9lDVLAtM5XdrFGRGugitNR4u8WEX9ojkAdnWc7iGMMnCYbH
         U5uoNtkcDoSmaPRLnF0nFDmiPXe4RlQMLDA1CiAQDu4EgxDqEwtiU5PuxA1oPlUiQKak
         pfy95xqSBYI1qjVqXaiJwqQP/Q05ce9OjVbPVCE58E4CQtyNbqbskKT2VeHgYglB2eor
         9Zae19Cf0kLhf7VqTGifZUrONilA17j0V6UxKwhQHw8Suc8XM8++xsmq4Za21TaTFLhg
         2piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774677996; x=1775282796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UFRU1bS8HFHkRjVrl9E5GNOg3WQVTUj/Y+AMxYSKfQ=;
        b=fQyXPpsRpFQLwyQ1Acgbt9gR553cJvnvR9ukhlEOpcBv0ASBAg3VQwszdX3z+oIUsg
         dJEBf0SUgOfJXO19YcuquuxBCiyyCBOfVPgCviHgYDorU5hqjknXJkfwF5qZqyTBCVWM
         OHt8H76/s8InYI1MgHLBhms+nYBOaDm2PlZwk2nvY4w+jJ7rYsB7rVLilnlIwqz527mS
         +3kGdNghyI1/McgYzJg2zfdb4f2SUxdoUv4mjemaYkTMkBaht/ruiS66CpPzUVYaBYJR
         5sRC3UIS6lrH71pEhaoSW8Y7xLNQYn1A77YSiP/dvlmOqTlkOmVfca2/1sd0MRwF+i96
         eu9g==
X-Gm-Message-State: AOJu0YyHgQZt63aXTzncjXQ/FZgeIaN0ElmQzMnE0K6CuNgOOrOCC2Z8
	0C5R+PeKtb5KKkXLpUyrSniVVhDaZPcuBHuMezq1YS1kfTP0fFA7IFz2UhMVIgDAOez0fvlPXs0
	eG/q+8Q==
X-Gm-Gg: ATEYQzw22NJpK6mpihlvkmMLRJH1T97iAiPpExYoxnS9KXMu8vHDsroRzEkbBmUFdlW
	vkGSa7Vf58q2mVh5dqSO3lGLNcN9+BvP2K7Au7KkanOfKgpiwSftGvLLCJSn86e2FCckQyVNOIK
	ohyXlIWHM6VsnSj4vb3VfSEu+hfoDPvk+MdDLTj6+sDCoOtqT3us1pAYp8wCi4HwTkpvg0iFg0J
	8ti0O283KPDwY14Rt10enOBi6nuWSsqQWF7HVlgPZ56UvoZ9ajDCmVoek508ImVWvgI/CaP+2u1
	vDAuwIc+kVwkP3iAk8SBRsALrv2PtQrQ7kuH2bgAJlYEyskrIKHzUGFAg4sqD+hWFYmm0v9SFin
	jxVpvUy8AP9kBAMyTCoCg3sxxaBNK1F5jwOfVWKDfi0KdWORhT9QfVO9EH9oaLQJDBRSEuyiOB7
	A79B9MTSlZBSsOWFiPid1Oo+4AwvZNhA==
X-Received: by 2002:a05:7300:ec18:b0:2c0:c482:805 with SMTP id 5a478bee46e88-2c185deb4a5mr3348153eec.15.1774677995658;
        Fri, 27 Mar 2026 23:06:35 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c49a5b0fsm1461097eec.11.2026.03.27.23.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 23:06:35 -0700 (PDT)
Date: Fri, 27 Mar 2026 23:06:32 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org, 
	idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
Message-ID: <ddglb3jhxn453xi3csd2telvziriqzveqsokxdtestwrgeptan@ptrhexbfkvsx>
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327113412.GD567789@horms.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-272727-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EF5834D799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 11:34:12AM +0000, Simon Horman wrote:
> On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> > br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> > interval value from netlink without validation. When interval is 0,
> > usecs_to_jiffies(0) yields 0, causing the delayed work
> > (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> > itself with zero delay. This creates a tight loop on system_percpu_wq
> > that allocates and transmits MRP test frames at maximum rate, exhausting
> > all system memory and causing a kernel panic via OOM deadlock.
> 
> I would suspect the primary outcome of this problem is high CPU consumption
> rather than memory exhaustion. Is there a reason to expect that
> the transmitted fames can't be consumed as fast as they are created?
> 

yes, you are right. In the default veth setup, the primary effect there 
is CPU exhaustion. However, if a qdisc with delay (e.g., netem) is 
attached to the bridge port, skbs accumulate in the qdisc and are never
freed, leading to actual OOM. Both the qdisc attachment and the MRP 
configuration are reachable from the same unprivileged context.

In our test, for a 3.5GB ram machine, with interval=0, OOM leads to a
kernel panic in 10 sec:

[   10.901868] Kernel panic - not syncing: System is deadlocked on memory
[   10.902139] CPU: 0 UID: 0 PID: 2 Comm: kthreadd Not tainted 7.0.0-rc4+ #6 PREEMPTLAZY 
[   10.902525] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[   10.903045] Call Trace:
[   10.903163]  <TASK>
[   10.903262]  vpanic+0x694/0x780
[   10.903451]  ? __pfx_vpanic+0x10/0x10
[   10.903625]  ? __pfx__raw_spin_lock+0x10/0x10
[   10.903811]  panic+0xca/0xd0
[   10.903952]  ? __pfx_panic+0x10/0x10
[   10.904118]  ? panic_on_this_cpu+0x1a/0x40
[   10.904319]  out_of_memory+0x124e/0x1350
[   10.904497]  ? __pfx_out_of_memory+0x10/0x10
[   10.904694]  __alloc_pages_slowpath.constprop.0+0x2325/0x2dd0
[   10.904949]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
[   10.905214]  __alloc_frozen_pages_noprof+0x4f8/0x800
[   10.905445]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[   10.905686]  ? kasan_save_track+0x14/0x30

When interval=1, we can't crash the kernel even though netem reaching
sch->limit. You are right, it's a race between creating and comsuming.
But interval=0 gives the the user too much power to win the race easily.

> > 
> > The same zero-interval issue applies to br_mrp_start_in_test_parse()
> > for interconnect test frames.
> > 
> > Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> > IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> > IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> > netlink attribute parsing layer before the value ever reaches the
> > workqueue scheduling code. This is consistent with how other bridge
> > subsystems (br_fdb, br_mst) enforce range constraints on netlink
> > attributes.
> > 
> > Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> 
> I think you also want
> 
> Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
> 
> As highlighted by AI review.

Thanks for the reminder.

> 
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> 
> ...

