Return-Path: <netdev+bounces-182696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C71DA89BA1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6C54406B6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76B228F53A;
	Tue, 15 Apr 2025 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vpd49iQI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1228F515;
	Tue, 15 Apr 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715601; cv=none; b=f0vi4Gr4YphgSRqgQm5HUSJ2Oa4FRBcZ/RKv1fk3eG7x80C/7T1RXXbBmoM/NwSyr5x3HtEKgQkQA93w1ZrZQsiIKJsTpNW7YwHu2PQdYgFNOn43nHn+KwCynhT99aVUN9ZjbGJJAi1LjQg2GvxyVmSDPWq5IYb7GpiPkl0t5d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715601; c=relaxed/simple;
	bh=JImvK1kbxpz/Pko6NQtBvb6KK/vNuwZZQJ5c/28uPhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEOXTZouSUADLarKfjh77Aiq1ldG3FFFG6iS/Eckc1Qt9HlrRO9AzUvOZMQY9KC6nn0TyAsuzWTGmpyblnRyONMRro9F1ER+ysSTtkvOeZLBAyMScl7HNyzsCGxuVsRVf+fHYdpLalzpiF91fiGwR74ZvFK4nCGqj51TvDb0Wvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vpd49iQI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744715600; x=1776251600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JImvK1kbxpz/Pko6NQtBvb6KK/vNuwZZQJ5c/28uPhM=;
  b=Vpd49iQIbyd5FrpQWR7buVyV+ZM7ZVZxb5Pk6MrmuF18w8VfkVuUb3Yl
   UE+FdtoQdgtVoMnVClQRqDJt4kvmuLnm7bbKbnenPxSYPryWnxW0kMnhl
   eZv9zrXVnfLjKaKZjE9YpaTLm+gy2/rg0lclsw4M4nUB267Ir1dQcYdjv
   wLzw9VtW3PeUr6WcsAewLyEtde4ZpcHmSW10tJ1xPPQpnh+vqIYtJDYXe
   JrdBoJbUdVFrk6V8b7CgDEwtnt7f1EtMgehMhn/sEmVxzaHZ2HmHReknJ
   CKvr7Uf5xHaWxzg0OEz0UxXmtdv9GLLKrRzWGPtsRexbYhTceiC4xlPoM
   A==;
X-CSE-ConnectionGUID: xpNBkC9rQ+6d39GOapeicw==
X-CSE-MsgGUID: /4WOGKEFSkaTPYYl2XbonQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="56879281"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="56879281"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 04:13:19 -0700
X-CSE-ConnectionGUID: 7lTl8OIGT+ydGVvqP81thw==
X-CSE-MsgGUID: cu5VTjdYShWgiaKp42kSxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130049566"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 04:13:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u4eE5-0000000CWdf-2Uer;
	Tue, 15 Apr 2025 14:13:13 +0300
Date: Tue, 15 Apr 2025 14:13:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <Z_4_SU5kOko49Twf@smile.fi.intel.com>
References: <87mscibwm8.fsf@trenco.lwn.net>
 <Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
 <Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
 <87v7r5sw3a.fsf@intel.com>
 <Z_4WCDkAhfwF6WND@smile.fi.intel.com>
 <Z_4Wjv0hmORIwC_Z@smile.fi.intel.com>
 <20250415164014.575c0892@sal.lan>
 <Z_4sKaag1wZhME7B@smile.fi.intel.com>
 <Z_4sxCFvpqs7qmcN@smile.fi.intel.com>
 <20250415180631.180e9a9f@sal.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415180631.180e9a9f@sal.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 15, 2025 at 06:06:31PM +0800, Mauro Carvalho Chehab wrote:
> Em Tue, 15 Apr 2025 12:54:12 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> escreveu:

...

> I'll try to craft a patch along the week to add
> PYTHONDONTWRITEBYTECODE=1 to the places where kernel-doc
> is called.

Cc me and I'll be happy to test. Thank you!

-- 
With Best Regards,
Andy Shevchenko



