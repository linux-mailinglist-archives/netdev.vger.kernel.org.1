Return-Path: <netdev+bounces-252694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPeEF5E1c2mgtAAAu9opvQ
	(envelope-from <netdev+bounces-252694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:47:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D62F872B51
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7ECF30094C2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704EF253B58;
	Fri, 23 Jan 2026 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cA1rnTpR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299D2C11C6;
	Fri, 23 Jan 2026 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158029; cv=none; b=GLkL03S0Sewi4+gy79m692k0n5puIBq3cRyYaT+2VI5iqgyU0ZTSqbah5ADCtrmYvsMIlmlKEMo+Dll2TAvJrYD1d9vKHdFIXR1P1F4GnH+96A5BmDV796oi2E84q+cUH+1KG8wJ7cTpdS6PaepESxS8BmcVl0JYlWmLsJMWS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158029; c=relaxed/simple;
	bh=v8+ahdeqZNGqOg7rDkKp02b15PjwNKBNctCI/PSRyVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILBoU+6hrL62w5fZ9b7M3/nwGxGENbQpoiM2yLvadlDCR2KvgwD9A3SkLdsozJK4VfC5B0a3/rl6BIACVJGuJMmTfjvos3j05OMuu2hC5fkcevccxDqts/8Zne4luuISaE38b6GJstv4TfS2SdEtekClzvEfV0d4Lnh/MzMNf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cA1rnTpR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769158028; x=1800694028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v8+ahdeqZNGqOg7rDkKp02b15PjwNKBNctCI/PSRyVY=;
  b=cA1rnTpReM/5b24/0i/hze83JqweIxPcdFSIOVp/6YeFkphlcjZ+AkCW
   t9tRQQrhp7nIXDhi14YnjAlbaaMqUC0AMsQiPAMuYe54lRewWcBfU3Ahu
   /PRK+WPMQxb6R+5WUoUvPbQNqm5i4b/Uzwwr1vd+E14ObwqDO4rEa4Ey3
   ZzRFvG0q8QnzVPzgOlrT1ZtY1nebRFlstgF6Pb+YCkL8TmcID4a2DdPsn
   G6xrSHgJtN/HTO/V4yMs3Er0V7cOhx0biufEhWReFyNUqIJfV3jCJQsqT
   OzA8IOR5qeINAcH1JV1ud1CAk0G8DFW5SvhS/bMONVU24NmJXfFQh4+Dj
   g==;
X-CSE-ConnectionGUID: rITCRjPSQ1mbQ79YsLVPOw==
X-CSE-MsgGUID: vsYvG4dDTn+3bRzit5ayUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="95880490"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="95880490"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:47:07 -0800
X-CSE-ConnectionGUID: XUjiLKQ6SCuorlhafBqovg==
X-CSE-MsgGUID: X6uVMcT7TuKTw4K+KOqjwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="244588308"
Received: from vverma7-desk1.amr.corp.intel.com (HELO kuha) ([10.124.222.195])
  by orviesa001.jf.intel.com with SMTP; 23 Jan 2026 00:47:04 -0800
Received: by kuha (sSMTP sendmail emulation); Fri, 23 Jan 2026 10:46:38 +0200
Date: Fri, 23 Jan 2026 10:46:38 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Matt Johnston <matt@codeconstruct.com.au>,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mctp i2c: Enable SMBus ARP discovery
Message-ID: <aXM1WKi6L8PAAN2F@kuha>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
 <20260121092328.2308705-4-heikki.krogerus@linux.intel.com>
 <d681a9d5-ff37-45a0-8398-3e770052177e@redhat.com>
 <20260122080526.4fe83a3a@kernel.org>
 <9fa316a1a4b16e9f4e1601beeebc5a5e42232dca.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fa316a1a4b16e9f4e1601beeebc5a5e42232dca.camel@codeconstruct.com.au>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252694-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D62F872B51
X-Rspamd-Action: no action

Fri, Jan 23, 2026 at 11:18:42AM +1100, Jeremy Kerr kirjoitti:
> Hi Heikki and Jakub,
> 
> > +1 I don't wanna speak for Jeremy and Matt but with their Ack, and
> > assuming there's no dependency in net-next I think i2c tree may
> > be the easiest path?
> 
> Yes, given this is more i2c- than net-related, I would be fine for the
> changes to go via the i2c tree there. Staging the core via i2c and then
> (subsequently) this one via net would also work, but seems to be
> overkill for a minor change to the net driver.

OK. I'll drop this one from v3 and send it separately later as a
follow-up, once we have the i2c side ready.

> I have some overall comments on the i2c side though, I'll follow up with
> those separately.

thanks,

-- 
heikki

