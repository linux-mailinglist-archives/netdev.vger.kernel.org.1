Return-Path: <netdev+bounces-276842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF9gKpU612kwLwgAu9opvQ
	(envelope-from <netdev+bounces-276842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 07:35:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 729983C6517
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 07:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA1C73008D40
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 05:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84685221723;
	Thu,  9 Apr 2026 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1ALvW5I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD074A3E
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775712914; cv=none; b=Lmxa+XZPTWFcXRcD0DVg5zjusNGAebBvhwOIO/Qp657oYTy+xyFvnxaLDVNaEJgTGWR7AQ8lIEANZnEccCUOF518hzLPeFqjD5nye66VnOSiJlEk1PS7UhxOSWblHdsGBFyJGf10XOqnxTJDWtCDCnVIz1seTASJC1o4tCzS+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775712914; c=relaxed/simple;
	bh=7npnzABvqfg2jz0cdMpucuiHpYVl7AsGFV3xItDNmN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZupBHfXq63oLHk/gkNHrzuY3PKTCb/kC7Be+ukE4aJ0bDMjpoaDVnstouCVWpubMIrAwvOSWEoZQf/Gfm7HLsWDq9ZOnrZhGuS7x6jCVv3KFYgN8bLjpBzfE5mb1KBLGShIIFA3kh/UmmEoECL2WIypT+wDkb0osf3peyozwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1ALvW5I; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775712912; x=1807248912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7npnzABvqfg2jz0cdMpucuiHpYVl7AsGFV3xItDNmN0=;
  b=O1ALvW5IC8xfA1h62WrOnHGsH2xPLAK7a8mB2Cq1OAhB3zhys44pOnIl
   TP65lkxydco8bWStowhbQxGnD4B03Z71uvAB604/iHktupsb92jvoTnQf
   IeWoouU9FdoLa4/6IIQ3KD1SOmV/OyAnSXkq9/dfKDs1QnmqUa0PCNzEH
   sRPqKd7yiNks7tE//dSjbbr7wsTwtX10j+ecAF+XgvoGlOrKmsG3aOHk3
   jbaxQ8HPEMImiftNspca4EXGs7yVyZwmqnbGJ6xe/9X003GbjkoII0Hgm
   /lff/cpkFFYOAcJZM3GgNufmors41BVedfRpnyYVv8ysyPFmHlQcIHcr6
   A==;
X-CSE-ConnectionGUID: +Xa6V5LHSuawK8OBFY7b3A==
X-CSE-MsgGUID: aj350JZqTx+84xMJnq/qxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87786548"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="87786548"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 22:35:12 -0700
X-CSE-ConnectionGUID: gniwR4MZR928eHdSjeG6YA==
X-CSE-MsgGUID: VjNMsctqTh2nSkTBfIR0/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="230338182"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 22:35:04 -0700
Date: Thu, 9 Apr 2026 07:35:01 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: aravind.iddamsetty@linux.intel.com, rodrigo.vivi@intel.com,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, anshuman.gupta@intel.com,
	joonas.lahtinen@linux.intel.com, simona.vetter@ffwll.ch,
	airlied@gmail.com, pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
	anvesh.bakwad@intel.com, maarten.lankhorst@linux.intel.com,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event
 notification
Message-ID: <adc6hTz-xMopiJsc@black.igk.intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-9-riana.tauro@intel.com>
 <acPjxf5XTYuR7sbM@black.igk.intel.com>
 <09f253b3-ee64-4fbb-8cec-820e9769aa80@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09f253b3-ee64-4fbb-8cec-820e9769aa80@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,lists.freedesktop.org,vger.kernel.org,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-276842-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 729983C6517
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 07:59:33PM +0530, Tauro, Riana wrote:
> On 3/25/2026 7:01 PM, Raag Jadav wrote:
> > On Wed, Mar 11, 2026 at 03:59:17PM +0530, Riana Tauro wrote:

...

> > > +Example: Listen to error events
> > > +
> > > +.. code-block:: bash
> > > +
> > > +    sudo ynl --family drm_ras --subscribe error-notify
> > > +    {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}
> > Can we also have error-name and node-name? I'd be pulling my hair off
> > if I need to remember all the ids.
> 
> Yeah makes sense. We can add the node_name, error_name.
> Adding device_name would also be more useful in the event.
> 
> @Rodrigo/@aravind thoughts?
> 
> > 
> > On that note, I think it'll be good to have them as part of request
> > attributes as an alternative to ids (also for existing commands) but
> > that can done as a follow up.
> > 
> We cannot use names as alternative because it won't work for multiple cards.
> example in xe: Suppose there are 2 cards and each has 2 nodes. We cannot
> query using node_name+error_name.
> Also most of the netlink implementations use id's as unique identifiers.
> 
> $ sudo ./cli.py --family drm_ras  --dump list-nodes
> [{'device-name': 'bdf_1', 'node-id': 0, 'node-name': 'correctable-errors',
> 'node-type': 'error-counter'},
>  {'device-name': 'bdf_1, 'node-id': 1, 'node-name': 'uncorrectable-errors',
> 'node-type': 'error-counter'},
>  {'device-name': 'bdf_2', 'node-id': 2, 'node-name': 'correctable-errors',
> 'node-type': 'error-counter'},
>  {'device-name': 'bdf_2', 'node-id': 3, 'node-name': 'uncorrectable-errors',
> 'node-type': 'error-counter'}]

This means they don't persist the user needs to figures out all the ids before
anything can happen. In device node world we have /dev/dri/by-path/<bdf> which
makes it much easier.

Also, I'm not much informed about the history and it's still unclear to me what
problem did netlink solve here that cannot be solved by anything else? But we're
too late for that discussion, and again, not my call.

> > Also, what if I have multiple devices with multiple nodes. Do they need
> > separate subscription?
> > 
> No, we subscribe only to the group not the nodes. In this case the group is
> 'error-notify'
> 
> $ sudo ./cli.py --family drm_ras --subscribe error-notify
> {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}
> {'msg': {'error-id': 1, 'node-id': 3}, 'name': 'error-event'}

Hm, perhaps I need to spend some time wrapping my head around the new concept.
Let's catch up sometime this week.

Raag

