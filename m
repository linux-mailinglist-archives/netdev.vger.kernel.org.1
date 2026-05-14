Return-Path: <netdev+bounces-287973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LULIznVBWrxbwIAu9opvQ
	(envelope-from <netdev+bounces-287973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:59:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F28542ABD
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9468E304D15C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAC83F7A9A;
	Thu, 14 May 2026 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOqEg7Fk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5573F164A;
	Thu, 14 May 2026 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766928; cv=none; b=OqQ14qKyB/60TeHNzxjbVf0FRV6ulS1gRjEGPB/1FmScJ6nq3Ylf9PgahH7w8o7zBrQWV1dgUSFXRq6ZJ+TAmXV4/mReZf8K3O1jCLCluRCSc14Y/nbJIyH3TaRGU4Pgqhf2Teu0h1dhxu2Hjf+rBLZVlrYzZhLcpLY9quVCF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766928; c=relaxed/simple;
	bh=r7mG7yDnWwBV/HSGjyNKbzwn1lcn8TH2fUbNtfrwYyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgj30YowMHXq3UyDrIyShMYfLWlJ0V+QccoL37SqsPeCst8SOMECW3pcGeERAOlA9lthm7trE/YWuP/8wNrLCOfnY2Jpz6yu+wOgrjDk6nNgtYDwlI8TB7PRqRUhIcDIEbJzbWN5s3mB53QSwDicOkfEYTs+PY4FdoQvY3OUorU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOqEg7Fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B806BC2BCB8;
	Thu, 14 May 2026 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778766928;
	bh=r7mG7yDnWwBV/HSGjyNKbzwn1lcn8TH2fUbNtfrwYyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fOqEg7FkJK8+qC9U3mtMh20HHfE19ij1yPh8Dpo1+m4k5p92nrcz/SL0Yz0EtLg4D
	 OP2yuJRZDGgjujMGIJALgP3g6RFN1yQ+Azv5aVCziTb38MFHijPVVIZDLJ8St0bXdF
	 4l8nGO/66DPkfDX5EIV3Phh3NpyF+tRnvMJrm8kIFbQortL+HWFlDiDQZkK5ITraKK
	 LY1mEW60DUtnqQuTkQ4Er5xZsiXnLuVhQUJs3dUjqxM0OSQxRRzVS5VANrJJrULRN+
	 PhVQpaMIBrUUdLT5SmJ40O3+WgaoAt1qsPcSLmhKVzmicCwhfqT2RGDqpg7LLh7291
	 y2CnmFfcw7fTQ==
Date: Thu, 14 May 2026 06:55:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Rodolfo Giometti <giometti@enneenne.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pps: make number of PPS devices configurable
Message-ID: <20260514065526.2ed937dc@kernel.org>
In-Reply-To: <20260514112614.2016026-1-vadim.fedorenko@linux.dev>
References: <20260514112614.2016026-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 33F28542ABD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287973-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 11:26:14 +0000 Vadim Fedorenko wrote:
> Modern systems may have more than 16 PPS sources and current hard-coded
> limit breaks registration of some devices. Make the limit configurable
> via Kconfig, keep default value of 16 devices. UAPI has to be changed to
> support maximum possible number.

Hm, since this is effectively just sizing an IDR maybe we should just
bump it to 64? It appears to cost nothing if not used.

