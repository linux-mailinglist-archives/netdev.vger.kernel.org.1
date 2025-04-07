Return-Path: <netdev+bounces-179826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67568A7E955
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BEE7A5111
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B321A45E;
	Mon,  7 Apr 2025 18:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2453201270;
	Mon,  7 Apr 2025 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049205; cv=none; b=oWH2Uh8E2NbKojukaaXqRirvVUwbZpFXGrlIKi30YGMiaAppCVXvPCRLctAosQiuYvHjzTzcoqCW1zvoEy7VlgEGd1AWv+zXhWk1E2n6m5AX98EeLWTGPmCEo3J/yogsPgvpqZ3nzw1Cc5magrMGm+hbDXoCO11mlavnafHyPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049205; c=relaxed/simple;
	bh=Ry6t3Hd8IbtmmJ62LesWGyjvq2N2OUcDpXUza+xrfk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYgPevnbYE9S6c7sUHIN3KRI18VQjSiBlbihGseT67C/D9oEfKV3cQmOSF/7nw9Hef+Yxw/JXl3YM7xE/s1NtUFzRPZJTMhvpVl14bkYG0ykB++7rHWmHoxkXrixoDCmdrEm5wuSva3aScvHyG6VMBUsq4huFZZBXwJQOytLpR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: LQlEBrFjRjCzzDoE08nw4Q==
X-CSE-MsgGUID: yZdr1CvzSTCpzzidoD5imA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="62851847"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="62851847"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:06:42 -0700
X-CSE-ConnectionGUID: E0akH5x7QnSuKlLpN+cgnA==
X-CSE-MsgGUID: l7g6Xh/oT0SB+yeVZ4Xr3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="128561554"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:06:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1qrj-0000000A9kU-3IHF;
	Mon, 07 Apr 2025 21:06:35 +0300
Date: Mon, 7 Apr 2025 21:06:35 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/28] Add Microchip ZL3073x support
Message-ID: <Z_QUKyEmtNcxlbTt@smile.fi.intel.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 07:28:27PM +0200, Ivan Vecera wrote:
> This series adds support for Microchip Azurite DPLL/PTP/SyncE chip
> family. These chips provide DPLL and PTP functionality, so the series
> adds the common MFD driver that provides an access to the bus that can
> be either I2C or SPI. The second part of the series is DPLL driver that
> covers DPLL functionality. The PTP support will be added by separate
> series as well as flashing capability.
> 
> All functionality was tested by myself and by Prathosh Satish on
> Microchip EDS2 development board with ZL30732 DPLL chip connected over
> I2C bus.
> 
> Patch breakdown
> ===============
> Patch 1 - Basic support for I2C, SPI and regmap

Was enough to me to see that this need more work. Just take your time and do
internal review. It seems like one is missed. I believe you have a lot of
experienced kernel maintainers and contributors who can help you with that.

-- 
With Best Regards,
Andy Shevchenko



