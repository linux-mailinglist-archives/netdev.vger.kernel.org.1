Return-Path: <netdev+bounces-279524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODjRMQe242mVKAEAu9opvQ
	(envelope-from <netdev+bounces-279524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:49:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BF5421B03
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E62BC3011C65
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 16:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCF22E2DFB;
	Sat, 18 Apr 2026 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eolK7He/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D62D0C8F
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776530949; cv=none; b=KVRSCbcVEjYGTQlORflYaoQ5W9+P++rRkyuseP4eJjQeOFVdoh42RI4sP/qtsHAbRzpbRqOhrH6MVVI9sooTgwMa+d0DVkNZ2fluD6eB5nYtJGfQ6xM/LO5u9/WnN7TZ/ZFbv+dKSQEeZF8bHYHGFlU4jqGAN2mDvShN7fNe3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776530949; c=relaxed/simple;
	bh=zsFhT7C4RRvso6WDxH6i2cC6oqq51ld3WwQr2d/gdDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIHchBMmLYBbJ686BKeVfxCmj4fbJbjVO13pgqkbU02igOlnPDR1olcTcf9lRBxPgIhO2sgFpSYD7Xiaa+yCYUtZrHC4xCxh0/XsPYCNAxi997ldF8Ix+r/1zvumb13nWRwcPgNK4D6b76QMDRmGyciYCQQOkhpbNDEd4vqPWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eolK7He/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919EAC19424;
	Sat, 18 Apr 2026 16:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776530948;
	bh=zsFhT7C4RRvso6WDxH6i2cC6oqq51ld3WwQr2d/gdDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eolK7He/mx32ySTLNNqZ+OVK1eShLGdL3TMgsCS1HxMF/BNAGz8nDiiDNXj9k9kiO
	 Ag1D2wdiGMmFh/manYoNAvItagA8zjBXQnO5SW7nj1bV1/sw74IKO++bo6rZDQqc+O
	 FErhvtjjVvrKsRuUDOHfiuLg+t7oixrxuwV/HKv2boTehVelMOyAOFP6rw2e8t8hTL
	 eO4iRpNktpQzEDgq9YcxSDCxD1nw54Ingt8epBN8dpvUjSeoVPo+fcRKBSFbVhN1zF
	 Unz2bZ8ojcRJqskLwKm/wvD8OCGifdnn0acons9evLGLXqnX3MLlZYRLZU8rBPelL6
	 2WU1qJmm5Vp4w==
Date: Sat, 18 Apr 2026 09:49:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Juanlu Herrero <juanlu@fastmail.com>
Cc: dw@davidwei.uk, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/6] selftests: net: multithread + rss_multiqueue
 support for iou-zcrx
Message-ID: <20260418094907.3cde57ca@kernel.org>
In-Reply-To: <cover.1776444379.git.juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com>
	<cover.1776444379.git.juanlu@fastmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279524-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35BF5421B03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 17 Apr 2026 09:49:46 -0700 Juanlu Herrero wrote:
> Add multithread support to the iou-zcrx selftest, plus a new
> rss_multiqueue Python variant that exercises multi-queue zero-copy
> receive on a single listening socket with NAPI-ID-based dispatch.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.1,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Apr 27th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

