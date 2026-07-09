Return-Path: <netdev+bounces-306113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ybO3DXtoT2rIgAIAu9opvQ
	(envelope-from <netdev+bounces-306113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:23:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D2472EE56
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:23:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=IgLnkjdU;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306113-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306113-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 892FC302BCFC
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCC73FFAC0;
	Thu,  9 Jul 2026 09:22:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163873FC5D8
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:22:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588975; cv=none; b=Shj+fMKpNqPKuxciDws2Ku9OD89JbyjbvTa9g/ANcITVzPD/4d3Vo5cPMmuZS9bw9EcxgeaF4XXGMj55IaeRBgBXylbBHijajXt2o+0D6R2SvobW3awQaGYqWEeoy+KzEpNpSwCmhQBRZhtod1balwZo1iCyVBmWgusXskR6Yvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588975; c=relaxed/simple;
	bh=9EdaGAvYJ5tbCvOjl8CHeOoyPtBqGPgNsT9qMmRu+Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk5YYhJm/qMV9Tha7NvmlPQBGyCztTBtDyyWqLcX9/Czl4TdmOweZkJwT1OQVTxfwKr9dqK4lcQrzNYvNlQ/uC3VW8ZsYVXTlkVa7GwI2tvjgmK2TaDdVDPTL9758jijZcF6z3+7lCYu4qVjZKzlVXmft0tYhzEash1nIrGQ4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgLnkjdU; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783588972; x=1815124972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9EdaGAvYJ5tbCvOjl8CHeOoyPtBqGPgNsT9qMmRu+Es=;
  b=IgLnkjdUlLlmG4cE0DpGDcwjRO9bch+RbiHn0gHx/crmFpJnZvZd/TDk
   I3m7yWLTTQwTWmYf9tkXLWSikZFkxWbHJiLfRQwa/Z7NpU0x9H9d8oCSj
   PdeDN4SFLcuT+ePzFmHdpvNeFHvThTsIRdfWuQlTQ5sJ11gttI3H6l7Gn
   ZmpMOshKEuCEKgzirdmtWdBOpW2uGK+9mpJTzePLcaUOafSOFHx42r9cy
   ZdWi1SOJTIbd3aN1Qdyot+dk2qtWm8aVZNDyM4ADRwd8o9RxlZ9vSL+S7
   0IuNmdNNPFVYnnlfXMGWkGX8oVSbk7ZeSssjgzeakRflDCnrImRwRtDWU
   Q==;
X-CSE-ConnectionGUID: +n4N7rdTQrKbeo05NCyQhg==
X-CSE-MsgGUID: n2wX6xmkSwKSZhO+x73Khw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101693411"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101693411"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:22:34 -0700
X-CSE-ConnectionGUID: ReNFUb8JR7iKxKlmK8LGyQ==
X-CSE-MsgGUID: /O5vCSJFTeWSIIutLaS32Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251884450"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:22:29 -0700
Date: Thu, 9 Jul 2026 11:22:26 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, kuba@kernel.org,
	aravind.iddamsetty@linux.intel.com, intel-xe@lists.freedesktop.org,
	anshuman.gupta@intel.com, joonas.lahtinen@linux.intel.com,
	simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
	maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/3] drm/drm_ras: Add drm_ras netlink error event
Message-ID: <ak9oUmZ8sS3aF6jB@black.igk.intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-6-riana.tauro@intel.com>
 <202f6d3a-c29b-491b-979f-1d8223f59108@intel.com>
 <ak6xThf9qeB0wqgK@intel.com>
 <d96a4c3f-e0e7-42d7-bb8a-994b2f408dea@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d96a4c3f-e0e7-42d7-bb8a-994b2f408dea@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306113-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:riana.tauro@intel.com,m:rodrigo.vivi@intel.com,m:kuba@kernel.org,m:aravind.iddamsetty@linux.intel.com,m:intel-xe@lists.freedesktop.org,m:anshuman.gupta@intel.com,m:joonas.lahtinen@linux.intel.com,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:zachary.mckevitt@oss.qualcomm.com,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,linux.intel.com,lists.freedesktop.org,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ynl_gen_c.py:url,black.igk.intel.com:mid,intel.com:from_mime,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7D2472EE56

On Thu, Jul 09, 2026 at 10:45:27AM +0530, Tauro, Riana wrote:
> On 09-07-2026 01:51, Rodrigo Vivi wrote:
> > On Tue, Jul 07, 2026 at 12:02:11PM +0530, Tauro, Riana wrote:
> > > Hi Rodrigo/Jakub/Aravind
> > > 
> > > Please let me know if you have any feedback for this patch or can you please
> > > ack this if it looks good to you.
> > I looks good to me, but could you please double check the sashiko's comments?
> 
> Sashiko has a comment regarding namespaces
> 
> [Severity: Medium]Since the generic netlink family explicitly supports
> multiple networknamespaces by setting .netnsok = true,
>  will hardcoding init_net hereprevent listeners in non-init namespaces from
> receiving error events
> 
> .netnsok = true is auto generated not explicitly added in code.

Because that's what ynl_gen_c.py does without it being parsed from
anywhere.

> But from what i see, drm device is present in the host and not replicated
> across namespaces
> and most of the non-network implementations use inet.  (ex: Binder)
> If this really needs a fix, we can drop the has_listeners suggested by raag 
> in previous patch.
> I don't think in an error path, allocating a new buffer would be a big
> overhead if listeners are not present.

I don't know enough about namespaces to comment on this. I'll rely on
Jakub's disposition if netnsok is relevant here, or needed at all for
our usecase.

Raag

