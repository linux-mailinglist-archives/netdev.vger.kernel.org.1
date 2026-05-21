Return-Path: <netdev+bounces-290189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFzPNY1lDmqp+QUAu9opvQ
	(envelope-from <netdev+bounces-290189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:53:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4190159DD1E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF1FE3010173
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF27306B11;
	Thu, 21 May 2026 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYel7vEI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F75315D5D;
	Thu, 21 May 2026 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328290; cv=none; b=QD60l7EJ2/t4JNEtwfRMKt96UnfiPWRZBeA345jmOgrrsnj2ymNUPgSNdb9tYovDItdJwsdMhW/O2JwOKIIZSqYZxwCYpHI8N4J7GPFZe9C0ZSXY+W5GvjYwZRJDHJlue6vNEZ4lPu2YEIEQM4DRETCpT29cDc1sRkoOKESjVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328290; c=relaxed/simple;
	bh=A9aC8NrWbcH6KwhreiAIVDlbL1sZY/0ol0iNyXj+Xzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljMIRdTlYY7WSH9cN9W0AKWsCAax8mlzpZQ8CqQrqy27vARjCq2jp9c5GWDmEVlWOQ9XfrvCzPZkvlhXmkTEnQ8t0YRVPHZ7xAPNf2TMDrUOruHyILVZpTCPOE8Ba/CqmIt4zby/faD33wkL3kkhopDKpm5t3q7QSX/zbrQU9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYel7vEI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB5B1F000E9;
	Thu, 21 May 2026 01:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779328283;
	bh=qGEVDL80UZjAJT6sXCpUVDn7s0EJdUxacbE8pYP0FHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oYel7vEIpONw5CVUK1X7hcp2WKd7X+WKiN8v7BEutWg1t2Cq0YK4qDHpa/ejUrHOP
	 d3UGknJ5e3dgBb05npuHIdqQ7RMSf8kJo8M5yFqPQhJfhfTff0qFAa/fzhkgaSNLAD
	 m37hejLCn0PO2RLKqj+MVGQvrMQ9vj7YBsEHtYN2bpuZn9gsOlLG3Rc3phqm43F36/
	 qGBCVrMPOX12SaX+yVPG4xgiC/ymoa06CzVE0yb+tCV5T443K7hgLKpwy13MNGp1gd
	 mGfBYIIFYLtuwYQrgY67WTqlcfJvLueWAJp+Z2uDEz862tDnQiRrGR6pRpl44d6s4/
	 2DQTJ2wti/pFw==
Date: Wed, 20 May 2026 18:51:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Phani R Burra
 <phani.r.burra@intel.com>, larysa.zaremba@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 sridhar.samudrala@intel.com, anjali.singhai@intel.com,
 michal.swiatkowski@linux.intel.com, maciej.fijalkowski@intel.com,
 emil.s.tantilov@intel.com, madhu.chittim@intel.com, joshua.a.hay@intel.com,
 jacob.e.keller@intel.com, jayaprakash.shanmugam@intel.com,
 jiri@resnulli.us, horms@kernel.org, corbet@lwn.net,
 richardcochran@gmail.com, linux-doc@vger.kernel.org, Bharath R
 <bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 05/14] libie: add bookkeeping support for
 control queue messages
Message-ID: <20260520185121.6f380ad0@kernel.org>
In-Reply-To: <20260515224443.2772147-6-anthony.l.nguyen@intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
	<20260515224443.2772147-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290189-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4190159DD1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 15 May 2026 15:44:29 -0700 Tony Nguyen wrote:
> +	guard(spinlock)(&xnm->free_xns_bm_lock);

Quoting documentation:

  Using device-managed and cleanup.h constructs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  Netdev remains skeptical about promises of all "auto-cleanup" APIs,
  including even ``devm_`` helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.
  
  Use of ``guard()`` is discouraged within any function longer than 20 lines,
  ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.
  
  Low level cleanup constructs (such as ``__free()``) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  ``__free()`` within networking core and drivers is discouraged.
  Similar guidance applies to declaring variables mid-function.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

