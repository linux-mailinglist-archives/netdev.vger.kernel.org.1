Return-Path: <netdev+bounces-176728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F8A6BAC9
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 13:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4523AA1DB
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99FD225797;
	Fri, 21 Mar 2025 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCNvmiro"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F070CA5A;
	Fri, 21 Mar 2025 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560644; cv=none; b=VRc8HUS5AQgIaWERgxI3IfMtP+Npzr8QvCczsPuyh28stqT/iKqCsga7YaE84IdhpRMfSQhXzgv2t8RAsVo83szQGIwjXqSI0Q+t5qcT3BEYLgOUBzs2aR2JGImGGyCXL3jV8nsEPphKiI6P0+M/qajBOES607xcs5hvJUd4O6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560644; c=relaxed/simple;
	bh=oQyGiV78LEK+tbLWGXm5etpWS3sUCPu5H0kZTYpo8lU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rRL0rAwAYJa0F5cFSzEqmuTI36+st0l5DSPDKidMrP6AvUNbhLgr6S8S4n9lvKTv+hXkvz0Aet1C8RpVX4UmdIyRsVaGWufuIfqemnbIbtX+L27xrIymi4WNVqW5xIjLE5QiaTaUDfOP4ZedC0r6EJhYZMMBQ6W54BX0V+SV+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCNvmiro; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742560642; x=1774096642;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=oQyGiV78LEK+tbLWGXm5etpWS3sUCPu5H0kZTYpo8lU=;
  b=dCNvmiroThBVGoOb5HAHbwY7cdtXwCg98vfZGyuHs6iCsgk9oeMCC3ia
   WhmGyA8339Wx3RFhhQByG+6q63S3PBd9Mem2E095UBBHeYMxjDo18d5zt
   A+YbbODCnA3uOCHG+0XCj3J9wrhz5dY/B/rBwXxSrqfaetIUBW14dPYSw
   L7MCO/eUpJ0BkjcANuYJf60Hc03e89Yc1mQoPFT3Sj2OdZmpN0SSJ237T
   ZrQoGxzbDOVa79Muf5+k+oGdQZ7WAvhLLR6S6ri8jh6rYmQN7GT5adqIE
   o3uic+0WKfHDqF2SL3QEszsswieXVhMDNXsrdmKW/ieEQynN3NmCvGEEC
   w==;
X-CSE-ConnectionGUID: szUApg3OTk6hqvKKhRI7lw==
X-CSE-MsgGUID: b4z1f3PHRg2/70jDYHPYew==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="31415835"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="31415835"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 05:37:21 -0700
X-CSE-ConnectionGUID: fN2LIwPEQj+XS2avHEyG7g==
X-CSE-MsgGUID: kaLgaq4RTxebwSNATqk6Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="127535785"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.201])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 05:37:19 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti
 <andi.shyti@linux.intel.com>
Cc: Markus Theil <theil.markus@gmail.com>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, netdev@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v2 1/3] drm/i915/selftests: use prandom in selftest
In-Reply-To: <Z9r7ORwztMxsNyF4@zx2c4.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAHmME9oqvWp_Nd1Gwgyw52qy8wxztMyCpNsjByH=VnRaXqczww@mail.gmail.com>
 <20250211063332.16542-1-theil.markus@gmail.com>
 <20250211063332.16542-2-theil.markus@gmail.com>
 <Z64pkN7eU6yHPifn@ashyti-mobl2.lan> <Z9r7ORwztMxsNyF4@zx2c4.com>
Date: Fri, 21 Mar 2025 14:37:15 +0200
Message-ID: <874izmd0g4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 19 Mar 2025, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> Hi Andi,
>
> On Thu, Feb 13, 2025 at 06:19:12PM +0100, Andi Shyti wrote:
>> Hi Markus,
>> 
>> On Tue, Feb 11, 2025 at 07:33:30AM +0100, Markus Theil wrote:
>> > This is part of a prandom cleanup, which removes
>> > next_pseudo_random32 and replaces it with the standard PRNG.
>> > 
>> > Signed-off-by: Markus Theil <theil.markus@gmail.com>
>> 
>> I merged just this patch in drm-intel-gt-next.
>
> This is minorly annoying for me... What am I supposed to do with patches
> 2 and 3? Take them through my tree for 6.16 in like half a year? Can I
> just take the v1 into my tree and we can get this done with straight
> forwardly? Or do you have a different suggestion for me?

Feel free to apply it to your tree too. It's not ideal to have two
commits for the same thing, but oh well.

Acked-by: Jani Nikula <jani.nikula@intel.com>

-- 
Jani Nikula, Intel

