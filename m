Return-Path: <netdev+bounces-289594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INn7N1+/DGqJlgUAu9opvQ
	(envelope-from <netdev+bounces-289594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:51:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F4858458D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E73713110E8D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F73B52F4;
	Tue, 19 May 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9as5wua"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08905305693
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219968; cv=none; b=hhcV5JuVpWnO8lB7XeKHAymkfbHlTwr5i7jttEjQcofXk0rHonxh5rE3Il/D++4eALhgaO3kz0ckl0z4hKG+HoP4NJdW51TR0/oGB/hxuJ0YSr/fztplvn7L/vWdIz3k+ziRVz4nnM1cG237p2qAADU1Tch2MKw1YQB0BFDdL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219968; c=relaxed/simple;
	bh=eIdSbpCOE2tEp4vI10CL0o7hq3T4MveO/HhVOdB1Fwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3FuBfGaQWu/QfhAl6EOSShUpvD1ZD1PrDEi+s1eCfgY3j58iMg/9+fKhcZRB/VuZ1ZGlrxMRH0LPTB7BshlZigHEO7XM38BIUJodmQQT9WSC71vyk+noF2od4dTP93VQ9UIlJCenspkKV8xEqnhF4avkS13S0B6nFR98w4fZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9as5wua; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2281F000E9;
	Tue, 19 May 2026 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779219966;
	bh=9/gISngu1YBPhlTCpjdF9NeYFRX29qtCBzl2K8u7rMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B9as5wuaORLXiWK4cLkWHmh5uPzJYl+P8FtQ2E1SQffGs6a0SzEn6BHGjiRf65qif
	 lpj/RKDO+K/77WnitPgMAJMyTDPHgmUJh9ToHgZjjG7fDvYc/A7freDBX/NSuEi2LW
	 EMzcq4uma7zQLPsWsmdfw0OJOBZnNjQ7sHboJCjG0kn/Amk8eA40PERiCjsft5EEYh
	 LGmumH61snkjbrhri52tzT1wzyKMxwAwGA+w+URk1Lr3qhJj3gRe7y0FvSyaZZwjez
	 LlRkM6KA3fnZQdI84YA+LDbjGhWLr8qiy1lUAXgvf53Uns4JJcSc8Mi6x6GwAlUV34
	 ruD1Oc3TqNORQ==
Date: Tue, 19 May 2026 20:46:02 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: add missing xa_destroy for sched_node_ids
Message-ID: <20260519194602.GK98116@horms.kernel.org>
References: <20260514-jk-fix-missing-xa-destroy-v1-1-de437bf52347@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-jk-fix-missing-xa-destroy-v1-1-de437bf52347@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289594-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 50F4858458D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 14, 2026 at 09:55:21AM -0700, Jacob Keller wrote:
> Commit 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
> added a sched_node_ids xarray to the port info structure, but never called
> xa_destroy on it.
> 
> Since xarrays can allocate internal memory, this can result in a memory
> leak even if every element in the xarray has been removed.
> 
> Add a call to xa_destroy the structure during ice_deinit_hw(), and one to
> the unrolling cleanup path during errors in ice_init_hw(). While here,
> remove the overly verbose comment explaining the nature of the
> sched_node_ids xarray.
> 
> This was caught by Sashiko during development of unrelated code.
> 
> Fixes: 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


