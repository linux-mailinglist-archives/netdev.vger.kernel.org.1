Return-Path: <netdev+bounces-257409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMCNOFRVhWmnAAQAu9opvQ
	(envelope-from <netdev+bounces-257409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:43:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 787CCF9692
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33862300C003
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E527FD44;
	Fri,  6 Feb 2026 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqa0prJB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8215027FB2E;
	Fri,  6 Feb 2026 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345810; cv=none; b=YJ9IOCNRRpC6+29LJkdk7VuSaS8BS4/s+9W3ixAyX8+uCAwF9/Kv/CkHcfV51jcEp1blPAsR5os24sZRR6vtXhJmuUO451vYuYGlYcsSE+yqKSxcR1CG4r36Gzw1So+YwQTwHCcC226ctuUZ7Y+cyLJIpvRFXhG9g0XS5ZCUH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345810; c=relaxed/simple;
	bh=1mtz9bXcHfQVPpIO3Wmak3+aScB0UmfFuOn2bp1w4Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMkI4g40fe3VPlFQHYD6Dgu68wESdJFPej4QZru+nNCUcCZNf9U7qSVjocF+SXLgWM+fonHhifEsCvYJ0R0owRSrz786/j3V1UyohS9xnSXYRohBn6x/hr2D95pqbUpvVKu8X4tRsnG1n0fWZ5uoHdQQ0c/Um0eWsonB+Wj/1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqa0prJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAB0C4CEF7;
	Fri,  6 Feb 2026 02:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770345810;
	bh=1mtz9bXcHfQVPpIO3Wmak3+aScB0UmfFuOn2bp1w4Kk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cqa0prJB58Yv3GvnfmJQn7jYhNnJjH5I4koyBZ6riuURArYRuT9hFzNUbEqfk0Zal
	 jYxVlj4aZTW/BmFePom6+JsuZ4uANJ8uXfBFQ/euyAm1jsO4YAC0tJsiOhZTEk9t0C
	 FMvGHQhLQ1NSR3nZXU7m1bUFuGBN4AjgZ7riQKoYYuLwEYaxKW63/X1aEkQn6ReMzD
	 PHF86CiEI0xSsCX2VZGemiKFK4tJwF5L1uv5tDEcLGwBuUuYIc/QR8jG3Q3UFdVVNc
	 7lJKSYjvNbx+rPSsmwZnSveIZVgDQdi55sUA8NDHXqmG0JnPWCCcfdjoU+kItIKss8
	 Tlow9FMb9ACHw==
Date: Thu, 5 Feb 2026 18:43:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
 <pabeni@redhat.com>, <virtualization@lists.linux.dev>, <parav@nvidia.com>,
 <shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>
Subject: Re: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20260205184328.3b706154@kernel.org>
In-Reply-To: <20260205224707.16995-1-danielj@nvidia.com>
References: <20260205224707.16995-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-257409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 787CCF9692
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 16:46:55 -0600 Daniel Jurgens wrote:
> This series implements ethtool flow rules support for virtio_net using the
> virtio flow filter (FF) specification. The implementation allows users to
> configure packet filtering rules through ethtool commands, directing
> packets to specific receive queues, or dropping them based on various
> header fields.

This is a 4th version of this you posted in as many days and it doesn't
even build. Please slow down. Please wait with v21 until after the merge
window. We have enough patches to sift thru still for v7.0.

