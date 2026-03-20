Return-Path: <netdev+bounces-270055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEW8ByenvWkAAAMAu9opvQ
	(envelope-from <netdev+bounces-270055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:59:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34302E0A81
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D33F2305A496
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B8915E97;
	Fri, 20 Mar 2026 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojiZCEL4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF3359A88
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774036395; cv=none; b=ZcVpsZJfCKgVvt0kKm3GRvFruF31UiyJmWO0qAQGwELlkUVYb/7/fx0UK/j0Qte3k8cqVbi+buUPU5MpeLPA8azwuGoP6VtvDxBWUST0dXd/FB9ErtNO0qxmfE5luLxevJ0v6dOiMQNsKTkufOs93rjugmAg4NZaTgPYxOKm+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774036395; c=relaxed/simple;
	bh=yOlwrnfApgSr2V+5A7pE8Ew2hiOEjPzACHrqChYg0ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+yb4rc4jyKDVmgd1mR4U5hiM+4ZKqiH9FPK0R11PONld7s7/ryQmfLrjythQlYtoNwqh+iyJps9p+uHWMAY6mr+IObjq2AJwxtqhLAvaLwUhEp+U+Vn+6KysLCMARvLp/8+24Rvkws3wXbE/+lH4Rt/4A43wmPjG1VfBVrfx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojiZCEL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9506BC19425;
	Fri, 20 Mar 2026 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774036394;
	bh=yOlwrnfApgSr2V+5A7pE8Ew2hiOEjPzACHrqChYg0ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojiZCEL4DYXNLde91ANXhlXkvVIodJ9nQVyh0mL6mvlhYb++J1Dx2Jb+v/LwSu3c0
	 i9XTCgoc4/7q06a0yIwC8LWoqowP9qsDN27ib/VOj7w49P6RG31wv01p5TW05oa1h2
	 cIfz+hOxDFiuqx5cWQiESIfq2TVrB+q14vK0MM6cjQsRHR9io/o/K73C384TC7L9Sk
	 Zfk7QdhNZXPBlMx9ngO6as3bPtNUvd0Nqu9uahQ9VnA9ztGC0Zr4C5iMlwApLtzLt5
	 uF+Y4r1hfkV7HoAu0LvofsAZANRWQR7kNyJF7vwTAbevewN1DvmBJN2a/+utzZHSKE
	 vH5Pb6ztbJHPg==
Date: Fri, 20 Mar 2026 19:53:11 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jakub Staniszewski <jakub.staniszewski@intel.com>
Subject: Re: [PATCH iwl-next] ice: fix FDB deletion
Message-ID: <20260320195311.GK74886@horms.kernel.org>
References: <20260320050533.422475-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320050533.422475-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270055-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: C34302E0A81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:05:33AM +0100, Aleksandr Loktionov wrote:
> From: Jakub Staniszewski <jakub.staniszewski@intel.com>
> 
> Correct the logic in ndo_fdb_del() to align with other drivers in 
> upstream. The condition was inverted — it was rejecting permanent
> (NUD_PERMANENT) MAC addresses while allowing non-permanent ones to be
> deleted, which is the opposite of the intended behavior.
> 
> The correct logic is to reject deletion of non-permanent entries,
> mirroring the fix applied to ndo_dflt_fdb_del() in commit 645359930231
> ("rtnetlink: Fix inverted check in ndo_dflt_fdb_del()").
> 
> Fixes: e94d4478669357cd ("ice: Implement filter sync, NDO operations and bump version")
> Signed-off-by: Jakub Staniszewski <jakub.staniszewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


