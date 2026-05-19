Return-Path: <netdev+bounces-289597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFZKDy3CDGqJlgUAu9opvQ
	(envelope-from <netdev+bounces-289597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:03:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D366358470F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08D883043A68
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53C3BA23A;
	Tue, 19 May 2026 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/zfszjE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E684369D67
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221033; cv=none; b=fomMFVT9MtJynKV0I43UE6Tiw10YOH5GBwFQjEqCU92Qx7lDfHdnD9uyo3OfH5FPsiGpoRqo+uvCiZ7lrvmY5Xio/8A983fJaG9qBvRcAH/vzKqiKNSvdi0FxKX9ej60LtRe0n+3yoBjch+eBlwinykNUjrKcyxm82e83UNuxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221033; c=relaxed/simple;
	bh=WHDM785B9yVM06w+RjREjbFS0sLovY5Se9X1ZZS/f/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfRAciE6E/S3De+F6oaLjfy8+gOBFDyoHVgMP8t2YO0Wf0aGTNPO6hnjToeriBLEJhIKwbPCiNFTU17YOzQ+shPsD1/Vlvjknwld+QjUwv+UuXJQXyFo10Wv4DijY22rgmzqsC5AikD071s12HwLuM/8gmNNFoCIo6EcRhqWMvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/zfszjE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D441F00897;
	Tue, 19 May 2026 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779221030;
	bh=/r9YFl785KQdMtzFPchEoXmlFNRrb5Ocaxtx4B6cJN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I/zfszjEAE4IbyCqyB7uAb207Tc4oPCjUmoMlFzwUyLsUQDOI8LRPmT6IT4gLbZaI
	 ry9AMXs/Oj0PRTWwN8YT/mux2lHmtnI76tjL3x1m3zLObCNpejcQeBu8nb3XZtCkBc
	 2/Yra67gUCeUanLqEqoh1Df9ljuKLrnOtgiBZy1z3aNEWTSGzkvFKS7SofhhK0H8QF
	 WWS56Kmsnc0TOXuKGnLceL6Z2Q2i0MfbRpH6IjdqHq2+eH3TIS4nasMWpeGBHMH1oT
	 WhVGIOKi9Pme5nc720kLYZZUrADoFhFkRVjFqpXwG4aLkthZXlHvu0mXmgVQHVW9+5
	 YhxRxPtLmwtfw==
Date: Tue, 19 May 2026 21:03:47 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-next] iavf: convert crit_section to DECLARE_BITMAP
Message-ID: <20260519200347.GL98116@horms.kernel.org>
References: <20260515063836.3300442-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515063836.3300442-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289597-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: D366358470F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 08:38:36AM +0200, Aleksandr Loktionov wrote:
> struct iavf_adapter::crit_section is a bit-lock container indexed
> by values from enum iavf_critical_section_t (__IAVF_IN_REMOVE_TASK).
> It is manipulated exclusively through the kernel atomic bitops API:
> set_bit(), clear_bit(), test_bit(), test_and_set_bit().
> 
> It is declared as a bare 'unsigned long' and every call site passes
> '&adapter->crit_section'. That is functionally correct -- the bit
> index is a compile-time enum value well below BITS_PER_LONG so
> BIT_WORD(nr) is always 0 and only the singleton word is ever
> touched -- but it relies on layout coincidence rather than on the
> documented contract of the bitops API, which is defined in terms of
> 'unsigned long *' arrays.
> 
> Static analyzers that model the same contract flag every such call
> site with ARRAY_VS_SINGLETON because the address of a scalar is
> passed where an array pointer is expected.
> 
> Convert the field to a proper bitmap using DECLARE_BITMAP() sized by
> a new sentinel __IAVF_CRIT_SECTION_NBITS at the end of the enum. The
> underlying storage is unchanged (a single unsigned long word on every
> architecture Linux supports), so there is no functional or ABI change;
> the type simply becomes 'unsigned long[1]' which matches what the
> bitops API expects and silences the analyzer warnings permanently.
> 
> Drop the leading '&' at every call site, since arrays decay to
> pointers.
> 
> No functional change intended.
> 
> Suggested-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


