Return-Path: <netdev+bounces-244824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1DCCBF452
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 18:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D10AA3016D9C
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC1331232;
	Mon, 15 Dec 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="F8/QTwly"
X-Original-To: netdev@vger.kernel.org
Received: from mail73.out.titan.email (mail73.out.titan.email [3.216.99.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41C32B983
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.216.99.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765820513; cv=none; b=Hdvrfn5dTxJiX+MMMHGm5WlqmKSND4yo0HFRYZe7ITxqEs1n7wCV4N7ubZqcStmn5ACsKAHFeXnn3fSHpodn/w+6iBc6fjovusmdj/c8Xd6ZqwhfwVVjbdwj5sb1l+Aq8uCZQ/cfqMTsMw3Hdjn9mXwuV9khJoAtsfALGhy5boA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765820513; c=relaxed/simple;
	bh=QFhdugKgV9wfj6qyqsSa5X/JraeWH2DOVcppi+5Plng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5TI/GVL/g0Loe/YfF3PC4TKesZl2W4LfYuXWToHxzO8GYCD2g38Xq7rLHkDTuIwMwBhrEQ488RQUj1x1ol1WmxcsKdYNiMgcqO/tnFlsLkIbn1dg5M2Mwqyea7jkn6nQlzv1nrtwihgZDhmQJ9ORgb17mN4pQQrL2fpl616aOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=F8/QTwly; arc=none smtp.client-ip=3.216.99.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dVS6Y3g3Mz2xJn;
	Mon, 15 Dec 2025 17:41:41 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=7iA0vMSPQXxHcSek4xkG1cued2KpzgzlMlDY9yTDcK0=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=cc:subject:in-reply-to:references:mime-version:from:message-id:date:to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1765820501; v=1;
	b=F8/QTwlyzrpWf7w1fsJJyiXLjk8BwagL3MWj1+mhrnRrNcSUEjoPU0GAMg4EZq5PU1rOS4yf
	+9fQIhjzTIno99b4uZlUMpjHTg5J51NOd/GxGILxRbjX5my3X8l1aIUQaDl2UNkX5/2pCFeKilC
	FMEniDXgHXX13JG2LvyiblOM=
Received: from pie (unknown [117.171.66.90])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dVS6S34bRz2xH2;
	Mon, 15 Dec 2025 17:41:36 +0000 (UTC)
Date: Mon, 15 Dec 2025 17:41:28 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: "David Wang" <00107082@163.com>
Cc: thostet@google.com, daniel.gabay@intel.com, jeffbai@aosc.io,
	johannes.berg@intel.com, kexybiscuit@aosc.io,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com, nathan@kernel.org,
	netdev@vger.kernel.org, pagadala.yesu.anjaneyulu@intel.com,
	richardcochran@gmail.com, "Kuniyuki Iwashima" <kuniyu@google.com>
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub
 for MVM/MLD PTP
Message-ID: <aUBIOUhRCVHrKKiI@pie>
References: <20251204123204.9316-1-ziyao@disroot.org>
 <20251214101257.4190-1-00107082@163.com>
 <aT-DmZTh_8I13Mg1@pie>
 <1218241a.4a90.19b203d3fd8.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1218241a.4a90.19b203d3fd8.Coremail.00107082@163.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765820501219385430.27573.922314659682516200@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=69404855
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=QyXUC8HyAAAA:8 a=LpNgXrTXAAAA:8 a=_aL0kkWJpOvXBAV9hzEA:9
	a=CjuIK1q_8ugA:10 a=LqOpv0_-CX5VL_7kjZO3:22 a=3z85VNIBY5UIEeAh_hcH:22
	a=NWVoK91CQySWRX1oVYDe:22

On Mon, Dec 15, 2025 at 12:20:43PM +0800, David Wang wrote:
> 
> At 2025-12-15 11:42:17, "Yao Zi" <me@ziyao.cc> wrote:
> >On Sun, Dec 14, 2025 at 06:12:57PM +0800, David Wang wrote:
> >> On Thu, Dec 04, 2025 at 12:32:04PM +0000, Yao Zi wrote:
> >> > Since commit dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if
> >> > required ops are NULL"), PTP clock registered through ptp_clock_register
> >> > is required to have ptp_clock_info.settime64 set, however, neither MVM
> >> > nor MLD's PTP clock implementation sets it, resulting in warnings when
> >> > the interface starts up, like
> >> > 
> >> > WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x2c8/0x6b8, CPU#1: wpa_supplicant/469
> >> > CPU: 1 UID: 0 PID: 469 Comm: wpa_supplicant Not tainted 6.18.0+ #101 PREEMPT(full)
> >> > ra: ffff800002732cd4 iwl_mvm_ptp_init+0x114/0x188 [iwlmvm]
> >> > ERA: 9000000002fdc468 ptp_clock_register+0x2c8/0x6b8
> >> > iwlwifi 0000:01:00.0: Failed to register PHC clock (-22)
> >> > 
> >> > I don't find an appropriate firmware interface to implement settime64()
> >> > for iwlwifi MLD/MVM, thus instead create a stub that returns
> >> > -EOPTNOTSUPP only, suppressing the warning and allowing the PTP clock to
> >> > be registered.
> >> 
> >> This seems disturbing....If a null settime64 deserve a kernel WARN dump, so should
> >> a settime64 which returns error.
> >
> >They're separate things. A ptp clock implementing not provinding
> >settime64() or gettime64()/gettimex64() callback will crash when
> >userspace tries to call clock_gettime()/clock_settime() on it, since
> >either ptp_clock_settime() or ptp_clock_gettime() invokes these
> >callbacks unconditionally.
> >
> >However, failing with -ENOTSUPP/-EOPNOTSUPP when clock_settime() isn't
> >supported by a dynamic POSIX clock device is a documented behavior, see
> >man-page clock_getres(2).
> >
> >> Before fixing the warning, the expected behavior of settime64 should be specified clearly,
> >
> >I think failing with -EOPNOTSUPP (which is the same as -ENOTSUPP on
> >Linux) when the operation isn't supported is well-documented, and is
> >suitable for this case.
> >
> >One may argue that it'd be helpful for ptp_clock_register() to provide
> >a default implementation of settime64() that always fails with
> >-EOPNOTSUPP when the driver doesn't provide one.
> >
> >However, it's likely a programming bug when gettime64()/settime64() is
> >missing, so the current behavior of warning sounds reasonable to me.
> >
> >> hence why the dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if required ops are NULL")?
> >
> >You may be interested in the original series[1] where the idea of
> >warning for missing settime64/gettime64/gettimex64 callbacks came up.
> 
> Thanks for the information, this link holds way more relevant information than the *Link* tag in dfb073d32cac.  :)
> 
> But isn't  the patch in [1]  and similar change to settime64 better? 
> What is the  difference between a null callback and a callback returning error? aren't they saying the same
> thing: "this device does not support it"?

As I said earlier,

> However, it's likely a programming bug when gettime64()/settime64() is
> missing

but usually you know what exactly happens here when writing a stub
returning -EOPNOTSUPP. IMO this should be the difference.

Quoting Vadim in the original series,

> WARN_ON_ONCE is better in terms of reducing the amount of review work.
> Driver developers will be automatically notified about improper
> implementation while Junjie's patch will simply hide the problem.[2]

Regards,
Yao Zi

> 
> 
> David
> 
> >
> >Also cc Kuniyuki, in case that I missed something or got it wrong.
> >
> >> 
> >> David
> >
> >Best regards,
> >Yao Zi
> >
> >> > 
> >> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> >> > Closes: https://lore.kernel.org/all/20251108044822.GA3262936@ax162/
> >> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> >> > ---
> >> 
> >
> >[1]: https://lore.kernel.org/all/20251028095143.396385-1-junjie.cao@intel.com/


[2]: https://lore.kernel.org/all/b4d675a4-b7ad-4ecf-8d19-6bf08b452472@linux.dev/

