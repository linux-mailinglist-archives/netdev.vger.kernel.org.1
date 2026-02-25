Return-Path: <netdev+bounces-260687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mj7iHbFAnmlgUQQAu9opvQ
	(envelope-from <netdev+bounces-260687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:22:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE4618E5B2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 524AA30391C2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6A421420B;
	Wed, 25 Feb 2026 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge0AiJIv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEAC1EFFB7
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978925; cv=none; b=b6fWxylDhQB7w/pwn1KawbmBoI5FlzpCY4oS+wcS6UIJ1F6ZLpuc1b1gKfLIJNVkMttoHOaHLQkAOwEeU9RpBbsLABkidzqtDAZCK5WSA7qq2qqJ2aq9feOtRKmoBQyo7e72OI6Pk+e1eQxYY5suPAT1dRr7V8PzTM+zV358Shg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978925; c=relaxed/simple;
	bh=ynS84/0PMmxwKi16uvPa1XSyB0im66wxPhqSCK6S0ds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biNOO8KOCzAODv8Hd6zDV6/PSW2ntbfWXn9zsDzOytA1eJp4BqHDyEzIbnG/eYLj80fMnunCOhXlIUwa2C6aR4iMMfPJEg0H4adg2yp+1dqHiMm2ISv/vqg1we05FjWo0Me3HM91uh1TdMHsKbkcmOqwSzO9brr/Ygk8Dd2bUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge0AiJIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8666EC116D0;
	Wed, 25 Feb 2026 00:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771978925;
	bh=ynS84/0PMmxwKi16uvPa1XSyB0im66wxPhqSCK6S0ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ge0AiJIvBbl8tSOzxzpG6pDDxdakdYHxj/SGqI3iokbedOLglImYp+KS38hGNLx0a
	 aM4z068jN6vU+r6rQx96V354L/n0avRsXMP61aiek7Wk/sTQI/b/qtcaYXPMNI4jIj
	 pUvPi6m8MfYfGpMMgEMs1mEvyNGFgZsjTHt2fO9tuWmafIKW9JNw94xJZSonkwZQhO
	 N7N+6eS2Ypj6Qedc00oqWRi1T7HC9ThxHiXUEdpSGv68DZ7fIpzGbprS9+eBwESEDG
	 WBdNBdDQRHLx2jz2FBUpPSykRhJDOHutCVc2UfCQYFN0Xags6ULJmM8vzqnJm5JvDH
	 ICcFRdvLF48gQ==
Date: Tue, 24 Feb 2026 16:22:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 aravind.iddamsetty@linux.intel.com, anshuman.gupta@intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 raag.jadav@intel.com, anvesh.bakwad@intel.com, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/5] drm/ras: Introduce the DRM RAS infrastructure
 over generic netlink
Message-ID: <20260224162203.279f7b74@kernel.org>
In-Reply-To: <20260223060541.526397-8-riana.tauro@intel.com>
References: <20260223060541.526397-7-riana.tauro@intel.com>
	<20260223060541.526397-8-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,linux.intel.com,intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260687-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CE4618E5B2
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 11:35:41 +0530 Riana Tauro wrote:
> From: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> Introduces the DRM RAS infrastructure over generic netlink.
> 
> The new interface allows drivers to expose RAS nodes and their
> associated error counters to userspace in a structured and extensible
> way. Each drm_ras node can register its own set of error counters, which
> are then discoverable and queryable through netlink operations. This
> lays the groundwork for reporting and managing hardware error states
> in a unified manner across different DRM drivers.

Family itself LGTM.

I'm getting this diff when running regen:

diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index 4714a574a143..8bc85eab751f 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -7,6 +7,8 @@
 #include <net/netlink.h>
 #include <net/genetlink.h>
 
+#include "drm_ras_nl.h"
+
 #include <uapi/drm/drm_ras.h>
 #include <drm/drm_ras_nl.h>
 

Is there a reason why drm_ras_nl.h is in the global include/ path and
not in drivers/gpu/drm/, directly? This header is meant to be used
just between the generated C code (which is mostly structs at this
point) and the C source implementing the family. We haven't had any
use case which would require making it global so generator doesn't
support that.

The source needs to be clean after regen, so we either need to move 
the header in this patch or I can send you a patch to add a new
generator feature to override the header location. LMK.

