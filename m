Return-Path: <netdev+bounces-261354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBY6DyNQoGmIiAQAu9opvQ
	(envelope-from <netdev+bounces-261354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:52:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B271A7005
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88076308F6D6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815303164DF;
	Thu, 26 Feb 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBd8Zhxc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BC28489B;
	Thu, 26 Feb 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113457; cv=none; b=LamsC0cAFSw9+Q2jhM+UG88V6h8BGJkIZXaI5Y3kcSw3eQqe+V3aS/XZw2exwCYvIb1IygmXIgUSyTGGUqgRPUTwkxGNHvQRgEVgH7y1KNOk6VQUT/Cf+Iy3aibPyfNcnqWm+RDZZwSaHZvjMFRfaXzTYr3zEMAUGXBIpM5/oMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113457; c=relaxed/simple;
	bh=WcZwF9wDw1owtnf1rUQoVRjXkHyVltOHLpjN3GvpfEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8IlIaXUJNqX0G5Rq/BPw7ZhRY1hv6Snkz3Ix7N4jWEbLkwkk91VTXtQD88ILRS6eHMis8V+ILaW/X59Wwsfx2dvZbCZ9HQYDbGZILwKVJMXYwoZvFmFO3qCyi/wXfSroZ2CgFtiRgXoZUapBT3TXwhpP97RO/KBtybDu6I/CF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBd8Zhxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71963C19422;
	Thu, 26 Feb 2026 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113457;
	bh=WcZwF9wDw1owtnf1rUQoVRjXkHyVltOHLpjN3GvpfEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBd8ZhxcTIDXB8Ffeh5UBTxPjOt2TqXe6YaXuHQ6JdFFpdoRtD1bFUy6E54bbh4BL
	 EGc0tzwYwxrDAcnc3im/XM64EzkTJEDgNqyjN9n2DhA2E9aOzIpLPTY7jmAghavMMR
	 G0UOUpNvUXb6Iljuon4jL84flKZhljrPQ8jFkfglwblzjrDDm22sHck5ewzp0QlaEn
	 kfh1mFzfrcfmxlb1oAINpi43cn+j3TfwcTyFWJO4YQINvCtD+IC1cGsrcPB6xHrQJ7
	 u3p7D8OgfmEwT7HUxIVrQcKSpYoEHcREnG5XG0uO6BP3zJqWsS2iWhR8EDwbWvWr6e
	 kkcMLZFai5oKQ==
Date: Thu, 26 Feb 2026 13:44:14 +0000
From: Simon Horman <horms@kernel.org>
To: tomasz.unger@yahoo.pl
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfc: pn544: i2c: Replace strcpy() with strscpy()
Message-ID: <aaBOLp6Vxg0tVDgp@horms.kernel.org>
References: <20260225172715.75756-1-tomasz.unger.ref@yahoo.pl>
 <20260225172715.75756-1-tomasz.unger@yahoo.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225172715.75756-1-tomasz.unger@yahoo.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261354-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.pl];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,yahoo.pl:email]
X-Rspamd-Queue-Id: 54B271A7005
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 06:27:15PM +0100, tomasz.unger@yahoo.pl wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>
> 
> strcpy() does not limit the number of bytes copied which can lead to
> buffer overflow when firmware_name is derived from user input via
> NFC subsystem. This is a bug fix, not a cleanup.
> 
> Replace with strscpy() which limits the copy to the size of the
> destination buffer. Since phy->firmware_name is an array, the
> two-argument variant of strscpy() is used - the compiler deduces
> the buffer size automatically.
> 
> Fixes: 06c660340f1e ("NFC: pn544: i2c: Add firmware download implementation for pn544")
> Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
> ---
> Changes since v1 (requested by Simon Horman <horms@kernel.org>):
> - Use two-argument strscpy() since phy->firmware_name is an array

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


