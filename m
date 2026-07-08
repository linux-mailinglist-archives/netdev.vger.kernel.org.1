Return-Path: <netdev+bounces-305813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HFITOS9NTmrCKQIAu9opvQ
	(envelope-from <netdev+bounces-305813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:14:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DDD726AF9
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:14:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b2jit3P9;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305813-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305813-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 775DD3009507
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E72571C0;
	Wed,  8 Jul 2026 13:07:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB739213254;
	Wed,  8 Jul 2026 13:07:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516077; cv=none; b=SEK42fLxPpF4bnLVL98JQKdIplX6Gz3bMe/kzNLuRrHDScJDIyTcCc1oudOONziWauSeZT5ohBQ40egysteOkBWrQddSNT7TBPNBGGg8jqO9GrazJUi3XuGpOpd7cAkYgSvrgzXe1xnoXB2v+OlHxsQFB5CjiPeag53WeZL98ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516077; c=relaxed/simple;
	bh=68S989PONmhv7+eqxY9lQaNx5Y4o6WwzG4wnhKkqZlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnTu7aFd2j54Z0BLF+Q1iyanJlD17gy74tyl/QMHPxuUEIAxJmT6nk8kHHeK2vCQ6+8ZcAzhLAxfajmb0KLgCKXaEorA5IVzqMFQw1md3bDEo6zU/6ABKHG30hCQFqdcT2Zuz8Dby+2SDW5uKGxiejdNcmca2VYBpuTDZVqbgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2jit3P9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56C11F000E9;
	Wed,  8 Jul 2026 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783516076;
	bh=Hd9z8VELC8Q9jRxuWHqe0GJM5+T9P0twkrs5m0ntfM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b2jit3P9I90j0FZjTmExlp1xbmH1GSvS4sU8IR3MyVc5sSpljbnNNdxGqkxsK2C3L
	 mmYeQcbz4811i4MpBns2qIcDzmt9GY+4F/qGKEsnth8bJVmZmIv5WEKSMvsQUm/pQM
	 NO2tCBRiZn0uM881e2uvqCJHEWrnO5D/LI6E1LdqS/AooESId9VYxZ8wbpk9zUpMWU
	 lm0hR7ekV4iUpI/DpMsN629BQUCuTyQfrFxrOzIlGoL4QPaVjaoUXam5hAkIom7RVK
	 QhaS3ubPY4NCh+harlsLa6KhQELB2Bb3QucvWb+CkBPivRb0Z/fnrNq2Y3kwH5rt0E
	 RsIdGMCRFtPAQ==
Date: Wed, 8 Jul 2026 14:07:20 +0100
From: Simon Horman <horms@kernel.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfc: nci: fix out-of-bounds read in activation
 parameter parsing
Message-ID: <20260708130534.GA1481798@horms.kernel.org>
References: <20260628210026.129941-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628210026.129941-1-meatuni001@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305813-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:meatuni001@gmail.com,m:david@ixit.cz,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36DDD726AF9

On Mon, Jun 29, 2026 at 02:00:26AM +0500, Muhammad Bilal wrote:
> nci_extract_activation_params_iso_dep() and
> nci_extract_activation_params_nfc_dep() receive a pointer into the
> RF_INTF_ACTIVATED_NTF notification but are not told how many bytes
> remain.  Each reads a one-byte length field (rats_res_len,
> attrib_res_len, atr_res_len or atr_req_len) and then memcpy()s that many
> bytes from the packet.  The length is clamped to the destination size,
> but it is never checked against the remaining activation-parameter data,
> so a notification whose length field is larger than the data present
> reads past the end of the buffer.
> 
> The sibling nci_extract_rf_params_*() helpers were recently given a
> data_len argument and matching remaining-length checks, but the
> activation-parameter helpers were not updated.
> 
> Pass the remaining length down and validate each field against it before
> copying, as the rf_params helpers do.
> 
> Fixes: ac2068384034 ("NFC: Parse NCI NFC-DEP activation params")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI-=generated review of this patch on sashiko.dev.
However, I think that the issues raised there can be treated
as possible follow-up rather than impeding the progress of this patch.

