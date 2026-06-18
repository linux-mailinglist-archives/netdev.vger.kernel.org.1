Return-Path: <netdev+bounces-300389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +7TID4rDM2q3FwYAu9opvQ
	(envelope-from <netdev+bounces-300389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:08:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FDF69F1BA
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:08:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=lb4u7GNL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300389-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300389-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31A0D30117A9
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952F33ACA77;
	Thu, 18 Jun 2026 10:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C537C0FE
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:08:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777286; cv=none; b=NcXaDA0Zj7piJlydNSdiuaE0yenR6g16KIM7DhlwbkztjqAuE12t9NnauxUC3lliXGoHa/10mYZRdGbxSqtoLdp6aMJeI9x97PjB6RlqnynHtT7gaDK89lJGttZp8JfQ+2GzwNNy0NkaPuCEHmEQQ0wbt8HxgdQqjAzz2RIGay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777286; c=relaxed/simple;
	bh=C+XViI3owNPDk7ocOokFo/XxhRN3dEGwZ3OHdlhAOtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+NsC+mduu7Rju+Rb4JJryie2tzY41ZEykoF6ZWko3l3itAUvplanfuo3EU5NHR0hQjra7Hdftp8byKGiVzy4ozvkWmHYgeFa0Bsu7jlXOIa81ULPdweT71GGXGZNG12gEGYyYzpOZxG3CXS7OMOnjRyGFeuU1Ge3Ra9D6IscZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lb4u7GNL; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781777285; x=1813313285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C+XViI3owNPDk7ocOokFo/XxhRN3dEGwZ3OHdlhAOtU=;
  b=lb4u7GNLUKKbY/N7TxQDuruCz7xDTyOe6RpnVfJ8sUdZapuWGFPJEHap
   Gcmi8gmy4pak11SgSEA2gAEGzLLNV+2em97PVqHJUv2OOohTYTPwC1O3N
   /IEbx3besdnGRmSjir/8EKyMjzrEF5P1OLySiU6GCMpN1zK9Ja1Wrd2fr
   NF+RkkzxOSH6ALkVnLXGWPmM/IWCrxrXXW083YxUs+06+WAtd9TpW1/fg
   hh0QINBYXzjHZCSkrD4BS1AuTcpykwQe74ToDuPAcTaF7Hd+3pR/UU7b3
   SrG1obYKzW68iCDEUG6JqjF8ba77WAGURjFBuBFAxabN9UfNjp98MwzlW
   w==;
X-CSE-ConnectionGUID: PNFQdHHTT1mhoUueJRs0NQ==
X-CSE-MsgGUID: mX6v+GMuTlCTZ688ZN3d4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86450809"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="86450809"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 03:07:59 -0700
X-CSE-ConnectionGUID: AkhGEWlSRh+6lM90ZBVbsg==
X-CSE-MsgGUID: EIj4hHNTTYSlQPkrf+Hrug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="252644135"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 03:07:55 -0700
Date: Thu, 18 Jun 2026 12:07:52 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, kuba@kernel.org,
	simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
	maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
	soham.purkait@intel.com
Subject: Re: [PATCH v2 2/2] drm/xe/xe_drm_ras: Add error-event support in XE
 drm_ras
Message-ID: <ajPDeMpSypYrFllq@black.igk.intel.com>
References: <20260611052144.784969-4-riana.tauro@intel.com>
 <20260611052144.784969-6-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611052144.784969-6-riana.tauro@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300389-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:riana.tauro@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:aravind.iddamsetty@linux.intel.com,m:anshuman.gupta@intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:kuba@kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:from_mime,black.igk.intel.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6FDF69F1BA

On Thu, Jun 11, 2026 at 10:51:47AM +0530, Riana Tauro wrote:
> Add error-event support in XE drm_ras to notify userspace
> when an error occurs.
> 
> $ sudo ynl --family drm_ras --output-json --subscribe error-notify

Same comment as first patch, but upto you.

> {
>     "name": "error-event",
>      "msg": {
>          "device-name": "0000:03:00.0",
>          "node-id": 1,
>          "node-name": "uncorrectable-errors",
>          "error-id": 1,
>          "error-name": "core-compute",
>          "error-value": 1
>      }
> }
> 
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>

Reviewed-by: Raag Jadav <raag.jadav@intel.com>

