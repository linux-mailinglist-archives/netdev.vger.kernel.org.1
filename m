Return-Path: <netdev+bounces-260178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEsHKS+wnGmYJwQAu9opvQ
	(envelope-from <netdev+bounces-260178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:53:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 158CC17C8CC
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A2530743E6
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D7437474C;
	Mon, 23 Feb 2026 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvvc3fNm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CD374721;
	Mon, 23 Feb 2026 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876246; cv=none; b=BcG96xSLh8eUWDPj4wMM7DwxbexFk50IKlu1FFSoxMq2nNIQ/SY0cgerI6UN1ZyNHhiaEdgsQxXcdEK750VcDHtVQWytgQqEji5yDPOHrctfU0VxirQvHWEn6BK61E7/NhEIXSJRSpzN0OHyU9PtK+ZnXpstii0gWUF2YGvc4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876246; c=relaxed/simple;
	bh=CuBM+Mhu0Z/wsRogwMIllQkoDc2++Sk/4R1h1ppYRm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMVNYik1chgXhIdnV5qCzO5y6e8mOVCpmK18xqxvi+5mtnHVhKG2BOtBJaHg09WTR7csNimY6EHDuOmUX8Rj+4C9QEwST9bpfy0Hx9BGQtDlo6GPrupdBH6KtCA+G7dBusN8hNqyJACEgujQzN04KYaQLIsz4Nu6ZEn5NJxfy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rvvc3fNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364A2C116C6;
	Mon, 23 Feb 2026 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771876246;
	bh=CuBM+Mhu0Z/wsRogwMIllQkoDc2++Sk/4R1h1ppYRm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rvvc3fNmjhRR+UfgZXnbAt7sdO3fWM4ODCNzyaUJkO5vN7hWLMWjSgVI80QhgtfNK
	 mTvc3maskMTVRUlZ4u2INM4MXgoX1SdN6JcGlFII1dR5rECSM/72/JNHJpEQgYKv9j
	 d2kWxRFg18orA6Oe6JXulvJsX0S+MVHXhV1b0jXMh4ORFL91YsyUjJ/v3G4xaehHpi
	 eHXU4orHwXme4O/xcbz3coj3tUWpMFg875iFViXwGtOqPsM11JF754c2Q/36MXOpXU
	 q8ZQA6mCIMgmVYuhQtFoBTZVkwWX/+yKLfhFUAMqxiJVs+DdEBrlly+HUuOjG88QK3
	 xrDNxX5sMN2xw==
Date: Mon, 23 Feb 2026 19:50:41 +0000
From: Simon Horman <horms@kernel.org>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: pegasus: enable basic endpoint checking
Message-ID: <aZyvkd_k47RuraeS@horms.kernel.org>
References: <20260222050633.410165-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222050633.410165-1-n7l8m4@u.northwestern.edu>
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
	TAGGED_FROM(0.00)[bounces-260178-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,northwestern.edu:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 158CC17C8CC
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 05:06:33AM +0000, Ziyi Guo wrote:
> pegasus_probe() fills URBs with hardcoded endpoint pipes without
> verifying the endpoint descriptors:
> 
>   - usb_rcvbulkpipe(dev, 1) for RX data
>   - usb_sndbulkpipe(dev, 2) for TX data
>   - usb_rcvintpipe(dev, 3)  for status interrupts
> 
> A malformed USB device can present these endpoints with transfer types
> that differ from what the driver assumes.
> 
> Add a pegasus_usb_ep enum for endpoint numbers, replacing magic
> constants throughout. Add usb_check_bulk_endpoints() and
> usb_check_int_endpoints() calls before any resource allocation to
> verify endpoint types before use, rejecting devices with mismatched
> descriptors at probe time, and avoid triggering assertion.
> 
> Similar fix to
> - commit 90b7f2961798 ("net: usb: rtl8150: enable basic endpoint checking")
> - commit 9e7021d2aeae ("net: usb: catc: enable basic endpoint checking")
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>

Reviewed-by: Simon Horman <horms@kernel.org>


