Return-Path: <netdev+bounces-290115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNiMMWpDDmrV9QUAu9opvQ
	(envelope-from <netdev+bounces-290115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:27:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EFE59CBC9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A902830AB442
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE112395D8F;
	Wed, 20 May 2026 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBpc+bKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968728DC4;
	Wed, 20 May 2026 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313493; cv=none; b=tXi7Poqwpiyri4qK/lIoG/Nu8sOljtjThzU8chyfN8R88OstKzD+XZ1SEXgToZnc9HnRls/hN8xIFX7apiaYt5nW1u6/HIN83VWevvb8histtgTkD1DH5wZE2C03yy1Dt9d0zbx4u54yBNdQAT/8z2HWN69/TNDujc5aZtAduqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313493; c=relaxed/simple;
	bh=ETTX8Z7cbHdMVHMr1vc60X+MDKxdCLF/OiXVHWv9heI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmovAjYmkOlXsTMb8N2nTdfnNg2hijypbd07cv5eJHANKs3x/POy9uSFZ2p6Z5NJ460mwDGGpGShHuGAQM9BD4evx/TYt2zieU4ZBDMGcFyOA9VaEiiBIUh5CFirtok1ve9Fxik6BOftDv3zVomPIKcc9q5jqHAlVzAwaozcYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBpc+bKH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF041F000E9;
	Wed, 20 May 2026 21:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779313492;
	bh=ETTX8Z7cbHdMVHMr1vc60X+MDKxdCLF/OiXVHWv9heI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GBpc+bKHUfCNOEGs4e+X4S0NsXpDnID0qSPApfrFKJg28nlrrJwq/9Z3wvkbzAYI3
	 AE+s3ERGSJ2Q0d9LpjwfFP4Vgqlf66eq63HiF7ma4EZp7o7Cs3cfbHhfyl85P9cPqS
	 8ZwyuCos/cL9Yy5j6cF0Y9UZqatFxzsVgtM4GkSnnTQuFKmTotrEDZoFmYeY0cQAD6
	 Y+MYuyBRtlndDYV0fTUojRl41SBRWrto28XDM+sY+vygms+wh/YA94BbYZBZoZ/21v
	 kWH9ND8LOO/bwCvl9h5hkp/N60181XHBYyd3BCbNDoO6tEOSYd7c2TCpOj1n3Tjike
	 CBcQ20c5zgebQ==
Date: Wed, 20 May 2026 14:44:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Grzeschik <mgr@kernel.org>
Cc: netdev@vger.kernel.org, Markus Schneider-Pargmann <mail@markussp.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update address for Michael Grzeschik
Message-ID: <20260520144451.281c5729@kernel.org>
In-Reply-To: <ag4RnvXbAoITkwth@pengutronix.de>
References: <20260426-maintainer-v1-1-d74d2f4343f7@kernel.org>
	<DICBWQ0WBG05.1D9181KHYC61C@markussp.com>
	<ag4RnvXbAoITkwth@pengutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290115-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 57EFE59CBC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 21:55:10 +0200 Michael Grzeschik wrote:
> Gentle ping to ask if anyone is picking this up?

Please repost this with netdev@ on CC, if you expect us to take the
patch. Only your ping has us CCed.

