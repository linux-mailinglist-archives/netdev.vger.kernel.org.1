Return-Path: <netdev+bounces-276042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMauKQUk1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:34:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC83B1192
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAE663079E2D
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916A5374172;
	Tue,  7 Apr 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOt0AYBr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD739479D
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575766; cv=none; b=U0hKVs6TTwuRKe30ZxYHQ5KdkEfe/kxERg5Tv//cO+7FnrAcxFh/qLtwSQMyiBgxwO1Gb56C1qM0Z+1m4wakg5LJH7qV4gSwf5jZalGS9ntVGKnuwycIC+OOgpzOojvpZ/KnP4i7lNY5IGx0VXVEu5OXHp75cbX2B4WllxqXCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575766; c=relaxed/simple;
	bh=tvRUSsiXl/2Qfo4SGD7jztbiqT95dIu9AiKtIvk10aI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=j4l9mveuit/8tVQ3vx2a6gvWVelxt9ZT/qLDZAYmeMhzNuCb+m5aL/I4IWXFZy7ddrZpzLZ9cFGljp5TWDBiYJcOAWm/yPg7tUyArcd2uvYPbfi86iWH7uJP2FswLRQl2HzTolmnkgxEFnsMv/ahtJnvatzyiXWTnVK/kZ9x54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOt0AYBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1305DC19424
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775575766;
	bh=tvRUSsiXl/2Qfo4SGD7jztbiqT95dIu9AiKtIvk10aI=;
	h=Date:From:To:Subject:From;
	b=uOt0AYBrFbFiMZUmTf2THFRC/B+XbZanBZSJZjwa43enWx/Nyn1ACCMs47jSRxjJE
	 EaQyF1YtMjZdroXBQzXPWt+FhuFdpTqhcWCYf7VCQlJWNNsZK7vkXP01LAc3lQx0IN
	 ExGcmaAgXx/qZL/b/e5Gfbb3LVMDj4SWPA4fS+/8Ty99f+VvQ/DAMgprNp0NQU/PhA
	 w1WtomYhZE47g42Q8mjF2SABQ0ODA1WAGtE/telz9IMZZjpdZUY0xo8eFho/42LG/0
	 4N4Vr3I02zRMRHLakHK13LJBeR2XHWV9f8xPOOA8HTHEnQ47Rhcdr2UuOL0BWmqaHb
	 lKjLKJrSKE/BQ==
Date: Tue, 7 Apr 2026 08:29:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Apr 7th
Message-ID: <20260407082925.38b248eb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-276042-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EEC83B1192
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Present: Andrew, Eric, Jakub, Johannes, Kuniyuki, Simon, Willem, Paolo

CI development and Lab maintenance
 - Contractor has signed paperwork (yesterday)

PHY development
 - Work began about a month ago, initially 1 day/week

Lab Status
 - OS updated over the weekend -> more flakes than usual
 - HW testing is running
 - i40e gets wedged, need to resolve
 - Added a bot to remove patchsets that turn (sw) CI red

Research grants
 - Drafted document: very closely based on BPF foundation document,
   will contact them about using it

Logo
 - Jakub to go ahead with contact

