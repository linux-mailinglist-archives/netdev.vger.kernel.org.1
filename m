Return-Path: <netdev+bounces-256685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEvlLqI1g2kwjAMAu9opvQ
	(envelope-from <netdev+bounces-256685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:03:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA98E5838
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F8073037295
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AF03EDAA1;
	Wed,  4 Feb 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8Kz6ly2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BB3ED111;
	Wed,  4 Feb 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206321; cv=none; b=araSf2AbFxIXxepIOWCQ3vkwdbZVC1tX7fJb8nvYI10b2kR6FsTiRL/7gIf7vmHuI3ryI0Qhp0g8o1C2by0Bknpcqt4gZfj2wA4ORqOkC53I6LwUjD9QLSwfy6xPkuaFa6oerQ+AI/G1ixgxslsoTUgye7XEYCMrcFuz7ouJ5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206321; c=relaxed/simple;
	bh=aBgYq5sKLNarh8sJoMQ3wtdCMcUApTBI0ornbC2y7YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaB6KqL8HdqIp3XQexRvUPYRpxTy06xMoP0eiOUHXSNr68q5OJh/lW3tdEbbB0gFEEsvURdb9Cfv7tAhmp1qwFocHQJx1ntt4ngAVtoa1kNx5+YD+cLD658HYcxRRe7L2eEsOt1HOLVxj3zmnFqPbrs5KtZRqJ5sVGOfZxj4zc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8Kz6ly2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA93C16AAE;
	Wed,  4 Feb 2026 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770206321;
	bh=aBgYq5sKLNarh8sJoMQ3wtdCMcUApTBI0ornbC2y7YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8Kz6ly2u6h4bavNw72G6Hf58FESgDqolQMQYYpIEDvhwpPiOyUfQt2ZM+xurObbZ
	 tH9zLXq/95DNhEL2zAUodYlHbc76EqX6Q5R646qCwWIj56R20+OkO/UAUxKAE1qOT4
	 /nMBsXfzAwDlqljUezJwdqUPkvdu+LmGMhS9RzRTzh456wUqgte5a7aNCcUOHLLglX
	 YmboBUItpr9H2e0uN4vdJ+apjN1Ey0JKcqtTGRrz/aaSW68/BuqRRT6K8GCR6hVxs9
	 RhjT6V6mhOiLtlvA5VNrqLkQXQPfSP6t4BCp+fYu01RZtPkITMCnxCai9kWePV8hmh
	 zr2atUFgAMKjQ==
Date: Wed, 4 Feb 2026 11:58:36 +0000
From: Simon Horman <horms@kernel.org>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ice: recap the VSI and QoS info after rebuild
Message-ID: <aYM0bLu3GMvcc8Um@horms.kernel.org>
References: <20260129040026.832452-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129040026.832452-1-aaron.ma@canonical.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256685-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,canonical.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EA98E5838
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 12:00:26PM +0800, Aaron Ma wrote:
> Fix IRDMA hardware initialization timeout (-110) after resume by
> separating VSI-dependent configuration from RDMA resource allocation,
> ensuring VSI is rebuilt before IRDMA accesses it.
> 
> After resume from suspend, IRDMA hardware initialization fails:
>   ice: IRDMA hardware initialization FAILED init_state=4 status=-110
> 
> Separate RDMA initialization into two phases:
> 1. ice_init_rdma() - Allocate resources only (no VSI/QoS access, no plug)
> 2. ice_rdma_finalize_setup() - Assign VSI/QoS info and plug device
> 
> This allows:
> - ice_init_rdma() to stay in ice_resume() (mirrors ice_deinit_rdma()
>   in ice_suspend())
> - VSI assignment deferred until after ice_vsi_rebuild() completes
> - QoS info updated after ice_dcb_rebuild() completes
> - Device plugged only when control queues, VSI, and DCB are all ready
> 
> Fixes: bc69ad74867db ("ice: avoid IRQ collision to fix init failure on ACPI S3 resume")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Reviewed-by: Simon Horman <horms@kernel.org>


