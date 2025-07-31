Return-Path: <netdev+bounces-211264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E56B176A6
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 21:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760FB17C84C
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 19:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CD7246770;
	Thu, 31 Jul 2025 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWFyi71i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8F2459E5
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990067; cv=none; b=kI7ougQUjo/xv6tRheMnocDe59Hjw5LwAG4VsGCl/f2C9TeUtJbu1xM8t5HeKRMQV4EN++eFt5oYAfpDgRwg/aldkPRbzJl54CIuqYGj5ab6EPXu55VWpHrt/tHwGLO0T0HP062p/JFBQ6Ro+LUZS0TCv4dwDZ516vQZFzQX3/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990067; c=relaxed/simple;
	bh=J+CgDJONEW9adIFLv+Mj07ElvmbXmtk846LMMaix6o8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LoRuFLsJQ+xsYEtM1Q6ccoDTR1GdGpg6FYhc55Oj/8ES/XfKuxA2Ed71Ox6Cc+Dx4f48BVXdbzXbxSDhRwkSx3AgfxXvIsgf/rVnVPSWuohXp83p+FE+gzREFXZZI78Qvo0TfO+8AF0MWPDgH0XbWGng1uDdpdhcnqsXqFIU9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWFyi71i; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753990065; x=1785526065;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=J+CgDJONEW9adIFLv+Mj07ElvmbXmtk846LMMaix6o8=;
  b=LWFyi71iLUrrn8mvimKZ0lETESP1v6xZvVXAAGEjn/ssgYX4LA+mfLzT
   HGQ5e7FrD5N05HBnGIGmKpBxtxYrmSGNSU3UXkNx5DzA56W2o/RDL00Ax
   jYDxnAUVC7mUPbEYQlXcgyUo/Omb3BXGM7LoHovPnI6P8enAIZG94+gmu
   TmzzkFdDnDHY7ybbztAEDv6hLLh1XHSzUqf3BfcyoEMW5dO1SKVQnxWtE
   jiZFVsaUYJfCuyzRnD7pf6p/iyLaGIlbPp6bDhpDuXqBDCVySOl8zfvqF
   6qdNuC10V90JBdP70BaZeGef5ZbfiybSf7+ROkt7p5omLY3X9pti3wZUY
   w==;
X-CSE-ConnectionGUID: Hw4hpjn4TIKIyLh14OOEXw==
X-CSE-MsgGUID: 7G9aK3yaQAGvzJbqeSbtNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="66898682"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="66898682"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 12:27:40 -0700
X-CSE-ConnectionGUID: if7nJLRBTcyAvSVnwWM08A==
X-CSE-MsgGUID: O5C24G+nS4WRSfzZCpWuaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="168628969"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.125.109.214])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 12:27:39 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, Takamitsu Iwai
 <takamitz@amazon.co.jp>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 takamitz@amazon.com, syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 net] net/sched: taprio: enforce minimum value for
 picos_per_byte
In-Reply-To: <aIpbK1q47giH8SRg@pop-os.localdomain>
References: <20250728173149.45585-1-takamitz@amazon.co.jp>
 <aIpbK1q47giH8SRg@pop-os.localdomain>
Date: Thu, 31 Jul 2025 12:27:39 -0700
Message-ID: <8734acw47o.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cong Wang <xiyou.wangcong@gmail.com> writes:

> On Tue, Jul 29, 2025 at 02:31:49AM +0900, Takamitsu Iwai wrote:
>> Syzbot reported a WARNING in taprio_get_start_time().
>> 
>> When link speed is 470,589 or greater, q->picos_per_byte becomes too
>> small, causing length_to_duration(q, ETH_ZLEN) to return zero.
>> 
>> This zero value leads to validation failures in fill_sched_entry() and
>> parse_taprio_schedule(), allowing arbitrary values to be assigned to
>> entry->interval and cycle_time. As a result, sched->cycle can become zero.
>> 
>> Since SPEED_800000 is the largest defined speed in
>> include/uapi/linux/ethtool.h, this issue can occur in realistic scenarios.
>> 
>> To ensure length_to_duration() returns a non-zero value for minimum-sized
>> Ethernet frames (ETH_ZLEN = 60), picos_per_byte must be at least 17
>> (60 * 17 > PSEC_PER_NSEC which is 1000).
>> 
>> This patch enforces a minimum value of 17 for picos_per_byte when the
>> calculated value would be lower, and adds a warning message to inform
>> users that scheduling accuracy may be affected at very high link speeds.
>
> Is it possible to reproduce this with a selftest? If so, please consider
> adding one.

Good idea. From a quick look, it seems that netdevsim doesn't have
support for .{get,set}_link_ksettings(), so I guess it would be
something for later.


Cheers,
-- 
Vinicius

