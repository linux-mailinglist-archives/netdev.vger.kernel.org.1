Return-Path: <netdev+bounces-290371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COnGAZfxDmohDgYAu9opvQ
	(envelope-from <netdev+bounces-290371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:50:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E6B5A43FE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705A8304928A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054303C417F;
	Thu, 21 May 2026 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB87bd3F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F23C37AA
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363883; cv=none; b=vCoVcCoXAp/4dCp35Q8+l7UjiEEUY//78LwceYFiIIDcyEVGyZBSwKFRYi5qSUfxhoIwDSvlH66/p3OxbsaiJGcRY/oYJiP+N2W9GCgr/zY3/ij7XnPbvpQPWx+NBzWCEkyzaAojtudA06E5fmowGxw9BevUJTA7lQyZgbIuqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363883; c=relaxed/simple;
	bh=SSqTKybdilJla6LSsbey+ec5pEya8aICrXNtQEI5akE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjP8wOLnPU2Atj0o3MXvG3sYh+FUdyw+aq959U0D1D6AnDMO9Y5qwffhZQvEHo5IvYgUWmhpYf7fYufoUmh1SWHpqfu1sLUko9MFyFJVJjURn0BMt+t4yM6eo4bD/1WL/9YQl/v2pPTOVt8108hBmLvGOJGAm92oMp/X6zTTIVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB87bd3F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601E61F000E9;
	Thu, 21 May 2026 11:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779363882;
	bh=iNnbfmHcW0NGw442nS2PoBdygOAsR81qw2FLANfMcw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oB87bd3FrVyGHG1FvoPIaplTVUD0KiT7JNCyKbXKCLK2vTlz/ihHKzxOM9mbbYTfm
	 0WLP/u1QMEFP10NPXnKWdnxeK5f+rlfTQt30rp24wnKJFKY/374651ypMQkXwPYEkl
	 SEn+lB/CnsiIvctF8CIrzoz6Sy+z6hMckJTQBla3gdzpZVS8GczProzYBMPCuOC38c
	 v+QXnA5N/fs0dnC8cWJkoioAWmWFn9PstLu1KFobKmhsqxk++uc41z4YLbCZS0XJfe
	 hEF4N0YGzzPbNuDNxzr/o91WnzCvBYgJpEx29eJSGV4GNtyJbgvRe7s4PukWddTfBJ
	 JlAO6J/A3uOVg==
Date: Thu, 21 May 2026 12:44:38 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v1] ixgbe: LinkSec deprecated macros cleanup
Message-ID: <20260521114438.GD1506108@horms.kernel.org>
References: <20260518123611.2252139-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518123611.2252139-1-jedrzej.jagielski@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290371-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 94E6B5A43FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 02:36:11PM +0200, Jedrzej Jagielski wrote:
> There are some unused LinkSec macros. Get rid of them.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


