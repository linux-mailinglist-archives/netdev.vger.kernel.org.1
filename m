Return-Path: <netdev+bounces-261068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAjqHhhPn2n+ZwQAu9opvQ
	(envelope-from <netdev+bounces-261068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 20:35:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0103819CC19
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 20:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD0D630338B0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218323EDAD6;
	Wed, 25 Feb 2026 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuUm8457"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15312E175F;
	Wed, 25 Feb 2026 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048150; cv=none; b=Mv1oujsHmgZwOZekqLrJEndiYj9FKRMM/lZxpNHP2I45FyGksGk7OVOzmATUU9d9xzY2YNfhWBW9lRsVZY6/tcPmXh2PuWI1eskji6x1WUDv5qJJIgYkKcqPyHW5+Mj3Ouzkg3eoid89l8lwCLJfUi+ajNuvuH+JRZLhKgCHl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048150; c=relaxed/simple;
	bh=LCcCGykLEqUy1dDs5e+ctne0AhEZqRPJSzXFbWQkanE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVlVBolWM0KXz9Ufm0XRWzQ0GJrlpmv7Pt7WfYFrGhFylaFvA/p+Um3LgMZ6l4YEbXQY+SND6udXn8C/D5DGQwTBh0JJT+7zg5k4iuSuXiIAsFf+Rr0JQtZ2t2zQMQuVwCWcfBAqJx1RYaRSFXBWjhbYhqzyTwtZcW5PvhcZ7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuUm8457; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BE2C116D0;
	Wed, 25 Feb 2026 19:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772048149;
	bh=LCcCGykLEqUy1dDs5e+ctne0AhEZqRPJSzXFbWQkanE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DuUm8457BOfpyG2LF6Aawb2CnIyALtsyAAnPzQ6jyysWIOCEZuVVbN6gZRvd8ywmZ
	 SzdQ654EnIeoke7oBprsGnsOnJZG2OPZfs3zTBaWVXvDU7JbhiOuR/H/kqMdbuIAeq
	 EvDFGjc/OlaBxGldm7MJy1NU3GNJ2ct4NhEMmt9VH5eaJHj8gQHVKLDmMSDz9yZTFj
	 OCBw/WYQGBwPF34HcYWhKY02bWGUsbKSH02AO21SFnixMkxKz8ACdfyaBn6R5s3cOt
	 KE7dRgT9Ac9aQtvDKS4e47hYMQvUXtND9LHMlmF8pDKStiEQb3UvBkyolKAl9hUmIK
	 4Tqszr8GKHdmA==
Date: Wed, 25 Feb 2026 19:35:45 +0000
From: Simon Horman <horms@kernel.org>
To: Abhilekh Deka <abhindeka@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/ibmveth: fix comment typos in imbveth.c
Message-ID: <aZ9PEaog5ZMr7LqW@horms.kernel.org>
References: <20260224153101.16935-1-abhindeka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224153101.16935-1-abhindeka@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261068-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 0103819CC19
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 09:01:01PM +0530, Abhilekh Deka wrote:
> Correct spelling mistakes in comments:
> - Fix misspelling of gro_receive
> - Fix misspelling of Partition
> 
> Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


