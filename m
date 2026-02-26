Return-Path: <netdev+bounces-261100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMcJJoqRn2kicwQAu9opvQ
	(envelope-from <netdev+bounces-261100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:19:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F4D19F57E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FBB8303AAB7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 00:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC490221DB1;
	Thu, 26 Feb 2026 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3FhyayY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D211A83F9
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065139; cv=none; b=W3Ipadd7KPcIZw9UosyQq+Y1TjelOtjmLdIN9K1Vt7iFJG2MiF8TPvHM94nINMp1BG8jBYKOBlKWStp3f/SQsHlLLUbn+7nxioY7QP4CHb0S4YK7WqYwgrmiZLpf0TDVbRV/ZewzlsEkjdwTKz+MARviUo14pYQWs+Eu5J2UN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065139; c=relaxed/simple;
	bh=w3m6Gvq8PtKvqJds8vqvFnCWFEGepn0lazcbw18+qOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1k/tiu7kuyiigU3ZJY7WJsJHDftSrgttPfb83xYMIo4Slj4CrDEC5EIhLaMLuh0VF8kTSza6dH+Juwxvxgf04yDpiVOLKZ2UpSpNVUELOvvCbPklrfHM7dSUsBuUIiSHZImEha47e0KNvvLVM+OoY8Nz4JeNURfJSO9hCnxheQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3FhyayY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639F2C116D0;
	Thu, 26 Feb 2026 00:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772065139;
	bh=w3m6Gvq8PtKvqJds8vqvFnCWFEGepn0lazcbw18+qOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q3FhyayYxO3igoPxQlkFl9p+Kfl+rgQl44e029l3FO2RUz3iO9mAnafK5riU+PfNu
	 6nM0r6g3d2lojrnvzvhE8fb84biXXw6w4DUjEe56LKSkHEbFzrAeHifTDi6kH6soH/
	 btvPiA1c5UBdNYH9h0QhQoZ141wg08VB7p6sgiso/RRUbu0DErebPVOnV8IieZgQFc
	 U/ns+6ecdqe+aZhYV6Q0TCOKptBc7qU/xzPF28zzt6xJBEBoBEDploSY426YGZeu/Z
	 RcIyO/SiXL9rBN+xB8IHYUve0Xgh2TUeVSzGuvuizbVSp7PlL4UFT+tJu1IUx2V/QE
	 2LpVGePCRg2Fg==
Date: Wed, 25 Feb 2026 16:18:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Riana Tauro <riana.tauro@intel.com>
Cc: <rodrigo.vivi@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <aravind.iddamsetty@linux.intel.com>,
 <anshuman.gupta@intel.com>, <joonas.lahtinen@linux.intel.com>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <raag.jadav@intel.com>, <anvesh.bakwad@intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
 "Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
 <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 1/5] drm/ras: Introduce the DRM RAS infrastructure
 over generic netlink
Message-ID: <20260225161857.55fd4ba4@kernel.org>
In-Reply-To: <686b63cc-2dfb-467b-a472-b6766b2c8dd2@intel.com>
References: <20260223060541.526397-7-riana.tauro@intel.com>
	<20260223060541.526397-8-riana.tauro@intel.com>
	<20260224162203.279f7b74@kernel.org>
	<686b63cc-2dfb-467b-a472-b6766b2c8dd2@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lists.freedesktop.org,linux.intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-261100-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5F4D19F57E
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 11:38:53 +0530 Riana Tauro wrote:
> $ tools/net/ynl/pyynl/ynl_gen_c.py --spec \
>   Documentation/netlink/specs/drm_ras.yaml --mode uapi --header \
>   > include/uapi/drm/drm_ras.h  
> 
> $ tools/net/ynl/pyynl/ynl_gen_c.py --spec \
>   Documentation/netlink/specs/drm_ras.yaml --mode kernel --header \
>   > drivers/gpu/drm/drm_ras_nl.h  
> 
> $ tools/net/ynl/pyynl/ynl_gen_c.py --spec \
>   Documentation/netlink/specs/drm_ras.yaml --mode kernel --source \
>   > drivers/gpu/drm/drm_ras_nl.c  

Oh interesting.. that's technically supported but the regen script
uses "-o $file --cmp-out" instead of "> $file". If we were to use
a shell redirect we override the file each time which makes incremental
kernel builds much larger.

> I used above commands to generate the initial files moving the 
> drm_ras_nl.h from include/ to drm layer.
> 
> Even after that if i regen using tools/net/ynl/ynl-regen.sh -f
> I see the above diff.
> 
> Am i using the commands wrong or missing something?

If you use the redirect the script doesn't know what the file name is
so it gives up on adding the local header. If you really want to have
the header under include we can just add an option for "--no-auto-hdr"
But again, just double checking that its what we really need, as the
auto-generated header is usually quite internal to the Netlink code.
The users of the netlink family within the kernel include the uAPI
and some human-written header.

