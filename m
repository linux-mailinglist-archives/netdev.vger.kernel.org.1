Return-Path: <netdev+bounces-294815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wUqxHfpTIGrC1AAAu9opvQ
	(envelope-from <netdev+bounces-294815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:19:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC71639A31
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:19:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y2rzOcWO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294815-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294815-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D25231D122F
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130C9481A91;
	Wed,  3 Jun 2026 15:25:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1754048165E
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:25:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500354; cv=none; b=tuqsHnNImiVuWHL/1ZT7Tq++XKuySL6LNMiZSlTNjbRg7v0rMouDYxp2pM9rakLQg8KokckBWtOzVwGrOTNGecpDdhyR+5/n7uXAqMoL3KiWYz1FtJFp9ZydABjQuGAIfXu3Dx0kpeavPpH1nIfdhZPGiOhEadMbYnMFQYkJRLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500354; c=relaxed/simple;
	bh=hiV5wjfi0ksmcZVrrOgVqE6eZqBUzpFFmG8w8NDSGY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsBB6iyYtohjreZ/k442VOeUbXJ+q8YK9B6n/kHeY1qWcTYsTUhwgAQZLWKBIjavRKCudNZ2ailKd+Eg8o7u1XXevTwlut21Vagvyt8rTA7M7PTy2PsmWNfmOQAuZqXtVla3ykWo3V/XLUiORQCZApQu6eH5udjZuELh4TzZNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2rzOcWO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098331F00898;
	Wed,  3 Jun 2026 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500353;
	bh=QY2N2XF8Xy9LWkg4ETKn3pjdKoLHVKBBH9yoExCV/Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y2rzOcWO1NAzil44qLurZP9u983aIjK0LhY1d+ZhU/ElgdBesAXvQEUCST9bGRUG6
	 Ldix1n4GvO7ImRTOOHYBXtRlsFLX38tj7IKhbASNmGLGlVs4rgpERu+G/E4Q3gzMuo
	 M2D/U/r8JPjcxdvm6h9SjwLHrB5yWgTxM38mHsqzrg3VKDSp1//lbBFiMXzHdf/bME
	 gxVbJ93Kye1bKqUe+ZB4OtX07+uJXIhymd+ZytcCj11vgXIrNOjZX5lLQYLrl7yvyn
	 SaMqQCljVCMm8MyZLSEr+PlJifNilojGYCWv4V/pgPXAT0em1lzQBi2Om40z+PLm57
	 gKSzOnHnr0d1Q==
Date: Wed, 3 Jun 2026 16:25:49 +0100
From: Simon Horman <horms@kernel.org>
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 1/3] net: libwx: add support for
 set_ringparam in wx_ethtool_ops_vf
Message-ID: <20260603152549.GB3766816@horms.kernel.org>
References: <20260529075147.88398-2-mengyuanlou@net-swift.com>
 <20260603152134.3794913-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603152134.3794913-1-horms@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294815-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mengyuanlou@net-swift.com,m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDC71639A31

On Wed, Jun 03, 2026 at 04:21:34PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, I forwarded this in error.
I don't think anything in this review is
actionable in the context of this patch-set.

