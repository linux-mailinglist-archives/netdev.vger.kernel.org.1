Return-Path: <netdev+bounces-272710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hpqqKj1Lx2nbVAUAu9opvQ
	(envelope-from <netdev+bounces-272710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:30:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00BC34D29D
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B95273024534
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 03:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2418D2DEA75;
	Sat, 28 Mar 2026 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgfoPf2C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012AE175A94
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774668601; cv=none; b=FyHVB+y9cT4KDVJ9A7sf7o7g19Ij3OTKR5wQUvb+srsWcs92Is+9Ff9AHKEU+HmOqw3ORScNyBQyDegmG8qHu3Vtd1g5ikph/vDCoxoPIMFaPlFd3gUI5VKepmICJ2L9kLjeiD5FzoDOFQUoCdZ7Tm9hULX19ZuXe/QSbCav3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774668601; c=relaxed/simple;
	bh=xrLAyfb2IjnGy5/+yFpJQusMn22PiglbRcq08RIukVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1tWFl1RkZVc0BL9LMs6bZjEhgyOtPeuRTxIG8aEbrMCV/tuIarKks2QCbFKBiWkDse84JWmijdLoI2CQU3AhMQR8+w2mJ59xOCFG829QqBXyc15aaL0Xuj7LTRJ0xHaeNcevtjqDj8py5GGeAmzaudJzuAgaLVBp4K6V24RQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgfoPf2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5564C19424;
	Sat, 28 Mar 2026 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774668600;
	bh=xrLAyfb2IjnGy5/+yFpJQusMn22PiglbRcq08RIukVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KgfoPf2CnUXWgv9bUL6W24xmPdXwAUWzOyCSLSl/nrPHQ4AhiFHV0tveUHpA7aUwD
	 0MjYGg0xVLYKELh0qPTInEXqB+Aa1Peh32wEyYL64Mhh1XLV88EDkHBNmJQgKDLS4d
	 cYbaeHxpUe1JHj6dIWfXege+M+M1yySl1VhKxmXd0Xis8NmLlNt0+sXcs3AGVKnzpG
	 CKD1wHocxThxcT11F0Yaw9cXHVVEiQlh/wqpzwiy73TdlJTftc5EEzAo6aXIh+rYcZ
	 aeorVUZPx9VN38FgiH7GWp4h+/X6Ay5i+DAO9rttw2BQ1cmoLbuKHydd9Xy4lxrSAL
	 tibimx/rSiIig==
Date: Fri, 27 Mar 2026 20:29:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Alexander Duyck
 <alexanderduyck@fb.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Mike Marciniszyn <mike.marciniszyn@gmail.com>, Lee
 Trager <lee@trager.us>, Jacob Keller <jacob.e.keller@intel.com>, Mohsin
 Bashir <mohsin.bashr@gmail.com>, Mina Almasry <almasrymina@google.com>,
 netdev@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net 0/2] Fix page fragment handling when PAGE_SIZE > 4K
Message-ID: <20260327202958.53d26d46@kernel.org>
In-Reply-To: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
References: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272710-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[davemloft.net,fb.com,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,trager.us,intel.com,vger.kernel.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F00BC34D29D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 12:51:21 -0700 Dimitri Daskalakis wrote:
> FBNIC operates on fixed size descriptors (4K). When the OS supports pages
> larger than 4K, we fragment the page across multiple descriptors.
> 
> While performance testing, I found several issues with our page fragment
> handling, resulting in low throughput and potential RX stalls.

Google AI reviewer points out that we will also be toast if someone
configures the ring size to just 16 descriptors. Can you check what
is the min size that doesn't wedge w/ 64kB pages and let's just set
the min to that instead of the current 16?

