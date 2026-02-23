Return-Path: <netdev+bounces-260041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKxvK2VanGmzEgQAu9opvQ
	(envelope-from <netdev+bounces-260041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:47:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E430177382
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36642303C862
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9093246BC5;
	Mon, 23 Feb 2026 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VW6zsY06"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F721F4168;
	Mon, 23 Feb 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854431; cv=none; b=tqJO5AkPGawidW6VY39x8XgywYTVUJAkAD2QagW2WkUuaDY9pQKqfHymwy8wEcc9g+8C7Re4Tb9cLgoqBGNrEs75DJ5b2deddqjtFOG5yy3ADDmgSQC1JSqD6hu+QYRyFBEOTP1YVz/PddzB9HipqqnZ1K32oW01bwGDnbTejBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854431; c=relaxed/simple;
	bh=ydmdhEGM/O41rgUA/G7JvzJvk3KxbBzvvuzH7eImK34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k/VoQTYw8potIPUIR5v/NCznulO228GGVuQBNyem0J3eX5EpR0kGPheR9yRtk+hSmaxAtZbsrnJqsH/jf3W6cv4By35m3iywf8SPcXkmF+QYNwPB4Q60IsGWG9QVDOPL87z7XjZZvRXoRMrprmmx8HrU/+K/aj8CRaqllpPm15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VW6zsY06; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771854429; x=1803390429;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ydmdhEGM/O41rgUA/G7JvzJvk3KxbBzvvuzH7eImK34=;
  b=VW6zsY06sAfcNAvKJWHscJ64vXxvEeKcaVZlOfLrkM+hM7lsQXrvesiq
   pr3SEdJpszneKIzb69UK/XLs9Ehl9kHECZmu81ue8uW6XqMc7bY7Mh52W
   lR3kgIIN2AppERlvRcPOhclAskuO3AU9XK5IX8B/c5vZSJy/LBKWgHZAd
   3EQf79t1MCDfIfqJMrj9FbIyVOyM8hC/mb2jwLWIYW3730sjVSAk3uD5O
   sCO9DsSFwQ+NnnxMImulw3b4uxKLaBrB5TKyQa3zGkUP2vzQlBjEMu+Eg
   tk0YA/oXRe+kW+6NbEZE0ONr9aQ1+lWRFQdnIp1F3vEKcgBL/0+nbeuEV
   Q==;
X-CSE-ConnectionGUID: MA+KWGozT9SQqzOOrCK+rQ==
X-CSE-MsgGUID: GXkOsBnVQUSbKYQ3oocZ5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72756781"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72756781"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 05:47:08 -0800
X-CSE-ConnectionGUID: 1v88AsnGQx+5D12EpgNwKg==
X-CSE-MsgGUID: mmVGelq+SZamc1NuWYyuZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="219682264"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.249])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 05:47:03 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jonathan Corbet <corbet@lwn.net>, Kees
 Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 00/38] docs: several improvements to kernel-doc
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
Date: Mon, 23 Feb 2026 15:47:00 +0200
Message-ID: <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260041-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E430177382
X-Rspamd-Action: no action

On Wed, 18 Feb 2026, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> As anyone that worked before with kernel-doc are aware, using regex to
> handle C input is not great. Instead, we need something closer to how
> C statements and declarations are handled.
>
> Yet, to avoid breaking  docs, I avoided touching the regex-based algorithms
> inside it with one exception: struct_group logic was using very complex
> regexes that are incompatible with Python internal "re" module.
>
> So, I came up with a different approach: NestedMatch. The logic inside
> it is meant to properly handle brackets, square brackets and parenthesis,
> which is closer to what C lexical parser does. On that time, I added
> a TODO about the need to extend that.

There's always the question, if you're putting a lot of effort into
making kernel-doc closer to an actual C parser, why not put all that
effort into using and adapting to, you know, an actual C parser?


BR,
Jani.

-- 
Jani Nikula, Intel

