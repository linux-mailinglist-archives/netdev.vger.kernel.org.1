Return-Path: <netdev+bounces-300043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2HyHBjM+Mmp9xQUAu9opvQ
	(envelope-from <netdev+bounces-300043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:26:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 264AA696D99
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:26:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=lH7GSFc+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300043-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300043-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D4673004C27
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1A739526F;
	Wed, 17 Jun 2026 06:26:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A031B824
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:26:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781677616; cv=none; b=lh3sMGchcVoiSUKtZXal9XNRpb8X/ZTSuzEDn3wf6BeGAwFBTCSD6kzpwA6p5V5U+ho4teOcGG322d7F+Psaj7TwGn004eVXaSaL5RWDywicaOdvC0C3KETJbr6npIj13FZIOoP8HuKw8eIrdwHDqjr+Wf5CehTBHCjSLWgFuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781677616; c=relaxed/simple;
	bh=zR1nJnoLjqvQrhg/jKxvHUu/vdS1Qm/wTgP/TWCK9pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWw6w24I8tIDSG0NHjv86dGIjvNhZVBjv3itLiM3kj1igDByrDqCebzIj3FH/JaKyNqeXDA8uTd2YkT4TJ0ZQQhJk43AiCCr86IM5dKapCO+aA6gAn4wRL9i0FGQHvpCLetNLb7NENAfxHtFvGfP00PvCNLTwdxrFew61SA6pMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lH7GSFc+; arc=none smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781677615; x=1813213615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zR1nJnoLjqvQrhg/jKxvHUu/vdS1Qm/wTgP/TWCK9pc=;
  b=lH7GSFc+s7vMlR+SGAYz7367wZZpIr2xbh4+TjVyl7QmUxlqAy++VLZH
   IZlYN1E0444s9o4I5PE4EgGd5vbWgnEpLSkxEZa0AIlM6rUdptr8f4baG
   X1eVOoqyFt54IoCZDXaqrD5NPfV8vOLP3URnFCtxXqmemSSpuNQ+zVnNT
   2RUf4aJi3SmFsQo1NsEjoywdii3tJQoi2JEYEX6on8HzfRiLNsdLl41kR
   WPQw/ychuzCiyMVTlTmviWq5caFpc+2See+c3B9kxA2gqZhdPY0zI4Hfo
   E9sP5BcNTeJ+f7kwdh/yOF0quDQsxKup5mt6nJXRE4IECPFo1NEUgHUGu
   w==;
X-CSE-ConnectionGUID: EjQTiFOFTDGPAwqJFcAUUw==
X-CSE-MsgGUID: Cb6HTG97Sm+OJJfteGjEUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93029374"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93029374"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 23:26:54 -0700
X-CSE-ConnectionGUID: CBg9umjjRH2UuKHjDZ2blg==
X-CSE-MsgGUID: d2f0PuEcTsqvNi3LZ20mtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="248059448"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 23:26:51 -0700
Date: Wed, 17 Jun 2026 08:26:47 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
	kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	dev@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com, mallesh.koujalagi@intel.com
Subject: Re: [PATCH v3 3/4] drm/xe/ras: Add support for error threshold
Message-ID: <ajI-JwsLcVWoUiqj@black.igk.intel.com>
References: <20260604184849.1011985-1-raag.jadav@intel.com>
 <20260604184849.1011985-4-raag.jadav@intel.com>
 <4d3720e1-1268-4a17-a8f8-f03e82aa1c5b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3720e1-1268-4a17-a8f8-f03e82aa1c5b@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300043-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:riana.tauro@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:kuba@kernel.org,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dev@lankhorst.se,m:zachary.mckevitt@oss.qualcomm.com,m:rodrigo.vivi@intel.com,m:michal.wajdeczko@intel.com,m:matthew.d.roper@intel.com,m:mallesh.koujalagi@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 264AA696D99

On Mon, Jun 15, 2026 at 01:47:02PM +0530, Tauro, Riana wrote:
> On 05-06-2026 00:16, Raag Jadav wrote:
> > System controller allows getting/setting per counter threshold, which it
> > uses to raise error events to the driver. Get/set it using the respective
> > mailbox command.

...

> > +	xe_dbg(xe, "[RAS]: get counter threshold %u for %s %s\n", *threshold,
> > +	       comp_to_str(counter->common.component), sev_to_str(counter->common.severity));
> 
> "get threshold" to be consistent with <operation> <value> <component>
> <severity>
> and other prints

I thought "counter threshold" was the correct[1] terminology?

Raag

[1] https://lore.kernel.org/intel-xe/ahgNW0Z9eQmQzGzY@black.igk.intel.com/

