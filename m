Return-Path: <netdev+bounces-300387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id al3cBl7EM2r2FwYAu9opvQ
	(envelope-from <netdev+bounces-300387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:11:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1223E69F26D
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:11:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hq+PwJ12;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300387-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300387-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC21F3052B7D
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB453A6EF0;
	Thu, 18 Jun 2026 10:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5A319851
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:06:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777184; cv=none; b=MgLhNFpA/NAXeiRtsgqo39Lg0TSg3XKi2ApeioE2MubL2vi7plxhCEQAIA/5RLBu3K0UlimndQbsk4Kp/XENg37xs/jG/7TI30dSH5Q6vANpmAiNs4/A9Gs2S0p0Qa7fCrZ5sd2ffAj7EzfQUPOtQAhDEj7MeIQUNkjDEzSBkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777184; c=relaxed/simple;
	bh=cvwVzsEL9xApN4x9ItSHnV9jxXJ6wS2ecG7KMdHfUC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zih1IGRvFYA53SQEd52otHpZbXP8Ke+Ra1QZq/+yy10Psx0zhXdk60pwFolODgN3LZyv2uQqBSLy6H+Xp5lqgcxMc3Ja2RZ2EMCYFDhChjcZ2PNRsalVAplWgDZYJHmzIq31EqbHXsqJksIbyKmkTZ4mn3R29cEKFIz+vnvs/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hq+PwJ12; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781777183; x=1813313183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cvwVzsEL9xApN4x9ItSHnV9jxXJ6wS2ecG7KMdHfUC0=;
  b=hq+PwJ12Q+4cwqlz5pih7gbY1dTOq30y/vQsmyYAgx0/HjHXqGnRoomD
   flN/4TC+5uaZloXiOJfW11pEeq9GakH9XwxLi7m2W1wB4VmFbVeu4Fvhz
   z6FevkwcQZsHQay8nyznGJ0rPVbOGMj1OJNTosIJSXe0uzxF8jtpbQa6w
   O+tgMO5d9aNRwLE/mOFH5BjbnDWLIo5M/zNvMuknfk+1P7UVKTm/I4mQh
   dZn3PB1pQSluFV7QKzV8XDMtIR+vVFK4bRCDaObBy2Bf1tSlbNBO2Rvgt
   CFhIfmCupMVselUZny4Gw/yyzaGpNInTx2aqLyfkOXDpiskWyjkvPc3ao
   A==;
X-CSE-ConnectionGUID: 1Qpj3+uAQiC27DCSMX0/hg==
X-CSE-MsgGUID: S6z5xl5ATXiznD2BkKP4bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="94107377"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="94107377"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 03:06:22 -0700
X-CSE-ConnectionGUID: bNBJ3vr6R6+G3IpaKhn9Rw==
X-CSE-MsgGUID: Zf3jdA2jQ7a4TI+NVtAOvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="252226229"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 03:06:16 -0700
Date: Thu, 18 Jun 2026 12:06:13 +0200
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
	soham.purkait@intel.com,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 1/2] drm/drm_ras: Add drm_ras netlink error event
Message-ID: <ajPDFcp36k1mGcdB@black.igk.intel.com>
References: <20260611052144.784969-4-riana.tauro@intel.com>
 <20260611052144.784969-5-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611052144.784969-5-riana.tauro@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300387-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:riana.tauro@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:aravind.iddamsetty@linux.intel.com,m:anshuman.gupta@intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:kuba@kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:zachary.mckevitt@oss.qualcomm.com,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:from_mime,black.igk.intel.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1223E69F26D

On Thu, Jun 11, 2026 at 10:51:46AM +0530, Riana Tauro wrote:
> Define a new netlink event 'error-event' and a new multicast group
> 'error-notify' in drm_ras. Each event contains device name, node and
> error information to identify the error triggering the event.
> 
> Add drm_ras_nl_error_event() to trigger an event from the driver.
> Userspace must subscribe to 'error-notify' to receive 'error-event'
> notifications.
> 
> Usage:
> 
> $ sudo ynl --family drm_ras --subscribe error-notify

...

>  operations:
>    list:
> @@ -124,3 +151,24 @@ operations:
>        do:
>          request:
>            attributes: *id-attrs
> +    -
> +      name: error-event
> +      doc: >-
> +           Notify userspace of an error event.
> +           The event includes the device, node and error information
> +           of the error that triggered the event.
> +      attribute-set: error-event-attrs
> +      mcgrp: error-notify

This looks much closer to "notify:" property, which IIUC it's not. Looking
at some of the existing examples, a better name could be something like
'error-monitor' or 'error-report' to make it a bit distinguishable.

Or perhaps it could be just me without the coffee :(
so I'll leave it to you.

Reviewed-by: Raag Jadav <raag.jadav@intel.com>

> +      event:
> +        attributes:
> +          - device-name
> +          - node-id
> +          - node-name
> +          - error-id
> +          - error-name
> +          - error-value
> +
> +mcast-groups:
> +  list:
> +    -
> +      name: error-notify

