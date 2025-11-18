Return-Path: <netdev+bounces-239670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F23F6C6B3FF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A689129F4D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2930D2C21C1;
	Tue, 18 Nov 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpETt1aw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8192C2349;
	Tue, 18 Nov 2025 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491047; cv=none; b=MAc45CuhL6sNNdNPyH/MVLcxfAIQ3um/Yt7ddj3qLduPmAFh3rnCQgDhnrCDH08VrbeoWNa4w8+ZgBXOUmL7ALLQ498nO+xXdLuzy/V08bW0uqZUWNZ2kbyEtPsxNWYyHH5qJz/A2LIlzTGFuqYgd2cNz0+JrpqM1sEa/BN5ZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491047; c=relaxed/simple;
	bh=iIYEMQjx/M1XUrR5hgrjP+2FqsUWRotw30++B0tJHME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AIK6h3yegxDZjUMKd9IwfbE4Ww5+EOLjM9PYIRVQGswLuBaEmkvn6OsXfR/2i8ztj3YSC2N3Z4nsDCpFfGriwA85+y4M8PLmNEFR9KSej96ZIat/UWU7lhCeahFBSJiL3h3zUF05ihbJs1j9cuvxj7u9MQABnisZ8clgC2TTqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpETt1aw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763491045; x=1795027045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iIYEMQjx/M1XUrR5hgrjP+2FqsUWRotw30++B0tJHME=;
  b=NpETt1aw5iFXwLlWhSCW8Kr6Fy2jmoqNzaTxMUP1NpOOAAeTZV5+KqhT
   wtJf4KUQSvaojysytvWQVLXYlJkck/cIO28pEsq6f4yCJHQoEHfMwV8e7
   /eFuUUosDBD3Mpy71r9d8CptkR9bLr85eYE5kMERTS5FBKbVu7IQ/B3jP
   jRAddhTFCqxkXdCsVU6/CSpQIp+VEOUuerrjAL5d+LN7F7CtEFq/ai8Be
   z2s5NGZxmQkF/719r0mC1Lj9+uoNJVqWXTXOROZcQSfqNsQg09lQwAALH
   jtIzbZeeh037lsZTN/tjZycmsoWt77Yq04NRuAqNnGvkBF+W9LTwsbwGe
   A==;
X-CSE-ConnectionGUID: 1laKZg9HQlCYOcuNnIZIbQ==
X-CSE-MsgGUID: AxDzOP6CSj60+B2SRyg1UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="90999881"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="90999881"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:37:24 -0800
X-CSE-ConnectionGUID: 5jsUiwQYTZ+aZm1TcLT33A==
X-CSE-MsgGUID: F02ZlehpSQKaQESX8lqbDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190488586"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:37:22 -0800
Date: Tue, 18 Nov 2025 20:37:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1 0/7] ptp: ocp: A fix and refactoring
Message-ID: <aRy84Cm8Wo84SIpo@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 12, 2025 at 03:27:14PM +0000, Vadim Fedorenko wrote:
> On 11/11/2025 16:52, Andy Shevchenko wrote:
> 
> >    ptp: ocp: Sort headers alphabetically
> >    ptp: ocp: don't use "proxy" headers
> I don't see benefits of these 2 patches, what's the reason?

I may give these reasons:

1. Makes clear what headers are in use (avoids dups and improves long-term
maintenance experience).

2. Makes sure we don't "include everything". This might (slightly) improve
the module build time, but also shows that we use what we use.

There are patches in the history of the Linux kernel for both scenarios
in C files (yes, for the h files such a change is much more important).

...

TBH, the driver is written in a bad style, it has so-o-o many issues,
I even don't know where to start... Oh, wait.

-- 
With Best Regards,
Andy Shevchenko



