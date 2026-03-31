Return-Path: <netdev+bounces-273772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCo5MbdRzGmvSQYAu9opvQ
	(envelope-from <netdev+bounces-273772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:59:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9BD3728BB
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7ED63029B52
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D46C45BD7F;
	Tue, 31 Mar 2026 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP10JjJz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8F38B121
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997941; cv=none; b=CoSMLxgnrD3OFnsoReiFnb8ayoQSxOUAbe31qisvdxS+5xW2bPRP2Ze84GMVcKajd9sgXV8mG4xpIMm6xyGIGa6FlumuLcmsWXVzVTyTcIP+LK+6gQ8GfowSeKsHZz4BuVps/raW1NS+WK1m18mXwqnCgN3yArVTg5ft5aanhtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997941; c=relaxed/simple;
	bh=F+Y1E3fP/RX+swrmXCMg3wHiakr00zQLw0jlgEEurzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=id33wtV83gYdS2XGp2v8g4zjqW17BgkAOfFALc8O+NyB/7fn8idFzlF7YkD40Py2S6Z+euOvyupt9M80M0FZjUbqnp7oqEpdOLzrNnlhvZFgjU/AAsN0bcI/dKJv3rJniEZ5mlIvJ9JDnVO2X/Vn7+xxS+ulaHg3FWQhZizz5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gP10JjJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0C6C19423;
	Tue, 31 Mar 2026 22:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774997941;
	bh=F+Y1E3fP/RX+swrmXCMg3wHiakr00zQLw0jlgEEurzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gP10JjJz9XUyc76y5p8X4lZ4EoDux/6hXjQ1k+HaKFeJ9m1g/4SmY097ptk0+rfNL
	 wnlOaNkpw9taoYqUjRrVupa8QGnOz5kVMbM8eMqBmkcXD/FkxmwqaVMSP8tW+f1JM3
	 +XNuRXL22WJyHKMMMm1WVsZ6xI2zYy54j6te+yVrTrY526TOGeRC17TNZANFmB8uxX
	 lTXg747t/Q392ezrj7V3Uad72ubGLhVGdUsUeqTGc0jtd58vfSlqZWVBEyby/ixwsN
	 jvyVcXMcA4Ga2ZCaIleihaomj3LUgueKCskhUxYsPNER1UNSyzuVOr6Vm1LtPIEvHz
	 lhO5MYLeYZglw==
Date: Tue, 31 Mar 2026 15:58:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH net-next v11 0/6] tls: Add TLS 1.3 hardware offload
 support
Message-ID: <20260331155859.1f34ef38@kernel.org>
In-Reply-To: <20260331163757.149343-1-rjethwani@purestorage.com>
References: <20260331163757.149343-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273772-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,queasysnail.net,davemloft.net,redhat.com,google.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D9BD3728BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 10:37:51 -0600 Rishikesh Jethwani wrote:
> Changes in v11:
> - tls_device_complete_rekey(): flush pending open_rec (from MSG_MORE)
>   via tls_sw_push_pending_record() before switching back to HW offload.
>   Without this, data in an open SW record would be silently lost when
>   the AEAD cipher is freed.
> - Selftest: enforce MIN_BUF_SIZE (16 bytes) on both client and server
>   receive buffers to prevent KeyUpdate handshake message truncation
>   with small -b values.

Not more than 1 version in a 24h period, please. No matter how trivial
the reason.

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pv-bot: 24h

