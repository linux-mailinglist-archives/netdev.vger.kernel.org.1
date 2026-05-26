Return-Path: <netdev+bounces-291968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBeOIIgiFmoViAcAu9opvQ
	(envelope-from <netdev+bounces-291968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:45:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 217965DD553
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18B03304CA67
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8803C9ED8;
	Tue, 26 May 2026 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmSD/1pS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483E3CA493
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835499; cv=none; b=tJt33c6uNhRJHql+oSrmumEq79q/b/AtkIhp+GH6Ubx4S4gAXfDE0IROMu7ZZX18jMZd8ywTTQEWCHa6h+jHcN5ps5hVBr2rM6GLf6RMKZmelu8TW5JqDJWuAFWn/8yzeydxMs5HRcqUO1vURd66El4dnytPK2VAzurto1i/LCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835499; c=relaxed/simple;
	bh=HULnY9ojAYZD4Xu1b40rZ/VLRT9Da9PwoZILDmv7YYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6CDJFRXj4UyY7vooWJP5TCjQSi8nBjSjwAfStkQSynXIiCWLtqe4sdSuDEFMhEuyG4Ik8eDWjidpZpb8GpmNUKO9ZUzya8CTjHnQRCRjYEicdCECAeUMSEkeIxrAKzZ/NV5qsTPc/xqWFMUrM9sqGNe004kq4lPKQLD5e0H+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmSD/1pS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471281F000E9;
	Tue, 26 May 2026 22:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779835498;
	bh=lfsfFOSWQeZsfeh6RXb/T0mED4t6wvi7ICwpA9X0f88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DmSD/1pSAl/1e8G702OwJ7dCGLWYm1gShyXkUJ7MJYYPZuUoiKLABZUAI2M53I1Qc
	 ARH4YvvTin23KbPlS1Apalp6cUeV3nEf4FU18X7SjwHkBmLDKB/ysMnXy44jNxZYCr
	 Yq3G5fCkno1EM2uvD7Hy6KF9PYLoysWspaVxaoOuFh8iqQN+cZGY2E2dvyLKHcc6NN
	 PiL8PYN75HbDhHem5zReKJLmax6NQ5gKs64+zrlIB0QrDIIgIaabkkL8ncV6yD4sMZ
	 Xca/MA+gmxFG44mVUoJWN7UVQZ10SrCAEi9d+SmkRm7nucsM+uOH7NXPWmZEcf6BDZ
	 zokrjC9lGJEdw==
Date: Tue, 26 May 2026 15:44:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] doc/netlink: rt-link: fix binary attributes
 marked as strings
Message-ID: <20260526154457.57b16659@kernel.org>
In-Reply-To: <20260526161641.459869-1-one-d-wide@protonmail.com>
References: <20260526161641.459869-1-one-d-wide@protonmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291968-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[protonmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
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
X-Rspamd-Queue-Id: 217965DD553
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 16:17:22 +0000 Remy D. Farley wrote:
> These link-attrs attributes were previously marked as strings:
> 
> - wireless - struct iw_event
> - protinfo - a nest of ifla6-attrs or linkinfo-brport-attrs
> - cost, priority - unused

We need your Signed-off-by tag on the patch.
-- 
pw-bot: cr

