Return-Path: <netdev+bounces-236708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B06C3F2C3
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 10:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAF73ACB3A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8691C2FD691;
	Fri,  7 Nov 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcQvDYwN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35146184;
	Fri,  7 Nov 2025 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508056; cv=none; b=CKh5zRwyk+NQv7vPJKNrjBqCNGTzrvjkeCbsp6pmryJtd/XlmpjvLeH2iW4CPfX1X+QwiZ26kmRJ27+bbz0WMyAoVEdx3KYJ7eq3KkNmOtwqAMGKERp8fQqNH0qRIXDIXmaIqBCJRnX82qH0hlhsxBSNuCf7MWYWgx2n2/egNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508056; c=relaxed/simple;
	bh=YStAr7/ZYwrF8NFyJegHFnFV6ylWkV6W3ZFf/ldtEAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU3KQl2CdgYiHZzTsicXu4FE/1v+Eg+EBQedmsWJw2ve+7E/npooYDBmKuQHptb9nIbf+DX5WQ2Ppqn/aA7O9j4EC39x3BcBs9dDTMlV0lJEcXEcmMxYCA/xfq9+FZcR4vfDGIlDEPhLIOhKWNa/+nnBSP6Dl4dJFX2JE3LWvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcQvDYwN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762508052; x=1794044052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YStAr7/ZYwrF8NFyJegHFnFV6ylWkV6W3ZFf/ldtEAk=;
  b=lcQvDYwNMiw9awcIc2lTkDl9UgFWWvMPhxOEuOAFNWA8q87JNwdod4qN
   sFz6BnornlXoq4B5d9Pa2PZELaDE5KQL6aznbFQcr4LOuTIPVtWCycQ4n
   XzwSB95+PdXl2YivbYWJ22y1bX9Nzh30xF6oaUJR8gOMWwbs/UNopy3kX
   0hWPmELnoxzws7d9PQ/jlo7Uc5yK6ZiyfsFVsXsnJ+JSJGhTIvXYmwZQZ
   TXGFeIfWPKFxTDJWiNzwIGmWyOdHpCCiF+BWVI7MyQ/J2Qw+PguTm8c92
   tW6LCbNW/EiIcun0U/94XntlcR9jL0KkqC2o5zOkbKkMTnRGCq/seK5ze
   g==;
X-CSE-ConnectionGUID: iNc9UWumRQmchglciS1Svg==
X-CSE-MsgGUID: 8S25eWvbR4GUajSd3juryg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="52222100"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="52222100"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:34:09 -0800
X-CSE-ConnectionGUID: lUHxLPWNS2Wmxq7ukqwnYQ==
X-CSE-MsgGUID: EpVxpFdeR0S3/K7iseNCXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="187655002"
Received: from vpanait-mobl.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.27])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:34:05 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vHIr4-00000006Q5x-0A0g;
	Fri, 07 Nov 2025 11:34:02 +0200
Date: Fri, 7 Nov 2025 11:34:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: linux-kernel@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org,
	akpm@linux-foundation.org, tiwai@suse.com, perex@perex.cz,
	linux-sound@vger.kernel.org, mchehab@kernel.org,
	awalls@md.metrocast.net, linux-media@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <aQ29CSOtOG_tmeIp@smile.fi.intel.com>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
 <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 07, 2025 at 01:16:13PM +0800, Junrui Luo wrote:
> Add a new scnprintf_append() helper function that appends formatted
> strings to an existing buffer.
> 
> The function safely handles buffer bounds and returns the total length
> of the string, making it suitable for chaining multiple append operations.

This won't work as expected in the *printf() functions.

...

> +/**
> + * scnprintf_append - Append a formatted string to a buffer

The name with _cat would be probably closer to the strcpy()/strcat().
OTOH we have pr_cont(), so perhaps I would name this scnprintf_cont().

> + * @buf: The buffer to append to (must be null-terminated)

Yeah, and must be not NULL which is no go. The *printf() should tolerate
the (buf = NULL, size = 0) input.

> + * @size: The size of the buffer
> + * @fmt: Format string
> + * @...: Arguments for the format string
> + *
> + * This function appends a formatted string to an existing null-terminated

Use the form of "null-terminated" used in the file. Perhaps you want to update
the existing one(s), just make sure there is some consistency.

> + * buffer. It is safe to use in a chain of calls, as it returns the total
> + * length of the string.
> + *
> + * Returns: The total length of the string in @buf
> + */
> +int scnprintf_append(char *buf, size_t size, const char *fmt, ...)
> +{
> +	va_list args;
> +	size_t len;

> +	len = strnlen(buf, size);
> +	if (len >= size)

How can it be '>' ?

> +		return len;

> +	va_start(args, fmt);
> +	len += vscnprintf(buf + len, size - len, fmt, args);
> +	va_end(args);
> +	return len;
> +}

-- 
With Best Regards,
Andy Shevchenko



