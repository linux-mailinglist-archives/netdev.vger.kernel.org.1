Return-Path: <netdev+bounces-286881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 15UfHLtyAmqAtAEAu9opvQ
	(envelope-from <netdev+bounces-286881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:22:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6992517D4E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 982DA3004C5A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BCD1F419A;
	Tue, 12 May 2026 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTGIhXmQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610A249EB;
	Tue, 12 May 2026 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545290; cv=none; b=Kcpd9aHVF9kF9cahH9JgDW0pcnqauXr1Hdwv+cwj5R7QbOTADedI9KAn/vc8rfGzlaRjVzU2I84GZC0vh4e7T2bCTjoXqTdL5cuYuomLdiq+LkzPICi6A6u/afz6Kfqw6T9v1d+1nIoIaPys7+SLNqaejy0RENfntGLnCFE60gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545290; c=relaxed/simple;
	bh=m3dOl51vgiXNVH5J9h0yitdbqqGVC55XsK4fvuDChzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c//oAii0HHB3ww2RUbCKMESHCtRcPwVfmg+I5J5DU2/usbvu7nWKlHmOAUWGVXlS/8tBLFEIN9Qq2GlTAfROcFdGE8IQ9cbsVIljLc5ldS9bpy7gAOKJfgTjps9GtefPhXc4Iva2+xw6Co39j5fpK1KlnaSd5a8VmxV/AQGakaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTGIhXmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0803C2BCB0;
	Tue, 12 May 2026 00:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545290;
	bh=m3dOl51vgiXNVH5J9h0yitdbqqGVC55XsK4fvuDChzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HTGIhXmQ3pkv8Fjgw5KgyvwmQ++JUCMza15Fg7uDvejFbY54F6dWhF1zuSpE8yt6s
	 40MFhbc89m4Qt5y8/pT+4LnSwBRXub7mBnuB8JirnYuUwRm/SBeYcmoXbbGgzaHckT
	 oiJPZ39hTr2Isz1wZ1zntQ5A+aNzcPj8k7TUxqWPLhA1Olyxn7nEMDKoyNzjHGf7ke
	 9ho+YDLmN0/ettls5A5QVaFQTM2k9PThTds2Dn2cm7cdMQSeS3UHHWz/Op+whcqqNz
	 80QKVVrJNGsszjX0EN/Um/CP997LL1NUAdItSkyDcHVqUxR7qTMGoMG63KHc+a+MUS
	 5ziDjXqBRwmeQ==
Date: Mon, 11 May 2026 17:21:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: mike.marciniszyn@gmail.com
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: eth: fbnic: Fix addr validation in pcs
 write
Message-ID: <20260511172128.57af5c5b@kernel.org>
In-Reply-To: <20260507154203.3667-1-mike.marciniszyn@gmail.com>
References: <20260507154203.3667-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E6992517D4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286881-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu,  7 May 2026 11:42:03 -0400 mike.marciniszyn@gmail.com wrote:
> The DW IP has two distinct PCS address ranges cooresponding
> to the C45 PCS registers.
> 
> The shim translates the PCS addr/regno into specific CSR writes
> into one of those two zero-relative ranges.
> 
> This patch fixes a one off in the test that could allow an invalid
> CSR write if an addr == 2 was called.
> 
> There are is of yet, no real impact for the bug as no PCS writes are
> present.

Applied, thanks! (bot is not replying for some reason)

