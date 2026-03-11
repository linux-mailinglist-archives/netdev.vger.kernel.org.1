Return-Path: <netdev+bounces-266723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG94IbeksWn4EAAAu9opvQ
	(envelope-from <netdev+bounces-266723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:21:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FF7267F3C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B869308A8A1
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC16E2F0C7E;
	Wed, 11 Mar 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzSMrLiO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8E2E9EB5;
	Wed, 11 Mar 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249427; cv=none; b=suz0yJQxwNqj9j7fwdWf529TDBmA8RKJaG5eUcJTugTCP9ZWgrWKB5dMcbihoybcMyWTF4Azg0MYwuEMvrac7HpZf1lWvwIelQpzSoh1T7QXxTMQd3bLiN0QFXwutO8qYlgdMHvX7gp7o8peSxZp60v+GR0KPdX2eBlii7HIZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249427; c=relaxed/simple;
	bh=9Kth9A+WZYjmEcGwSp4LyqYN+KEZJnlKJ5l3NryVM4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdQxT1juCVG4HMVfn0SQguwZXVVNXKn8+edrgbVs3u3zSjcVwkGasuY27ixsXEihLUw7HAXjOkQJ8Wn5psrGtB3ERTM97KYAL9p9ClCmSOgtwxbbOVfNkPKefrkvwnS2lBzxgTDKZxDNeN09hcVau/JDwGYJd8JLPSMUbGU6+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzSMrLiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F959C4CEF7;
	Wed, 11 Mar 2026 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773249427;
	bh=9Kth9A+WZYjmEcGwSp4LyqYN+KEZJnlKJ5l3NryVM4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzSMrLiO//8IQJk6ATkgpfFSj9fWLFwvZC/QdX0PI8KwoMdOhXadQjo5UVEoohqDC
	 gyVgoEGh/Gs9jEGdbwbhWXMVLpv75ynjdQiTQ10QS8n3quzONBDPnQDCfaEo0D7R83
	 ukT3eXcfh2DoKZiFIKT9GvOOb0zfSg8iG8kxEWwhPWsiu9TF7aoqUq4NbZPpl33nTJ
	 1H/QMBWrjE1hEmhJ0KYr/HoH1qeQuxfhyTh4aCwOJyqDDAlYg3mZeMjwLyQ0U2/71o
	 t3baWpf6nSyIK+mYC6VHgk+pmcpI0uP+BkgSoj7CsO1sUhWEdGQcg5GgUWpybW7QU+
	 H9KKNLAC3QeRQ==
Date: Wed, 11 Mar 2026 17:17:03 +0000
From: Simon Horman <horms@kernel.org>
To: tobgaertner <tob.gaertner@me.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, oneukum@suse.com, bjorn@mork.no
Subject: Re: [PATCH v2 0/2] net: usb: cdc_ncm: fix NDP nframes bounds check
Message-ID: <20260311171703.GU461701@kernel.org>
References: <20260309203449.2594858-1-tob.gaertner@me.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309203449.2594858-1-tob.gaertner@me.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266723-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[me.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30FF7267F3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 09, 2026 at 01:34:47PM -0700, tobgaertner wrote:
> The nframes bounds check in cdc_ncm_rx_fixup() validates that the NDP
> fits within the skb, but omits ndpoffset from the calculation. This
> allows a malicious USB device to place a valid-looking NDP at a large
> offset near the end of the skb, where the frame entries extend past the
> skb boundary, causing an out-of-bounds read when iterating the NDP
> entries.
> 
> Fix by including ndpoffset in the size comparison, so the check
> correctly verifies that the entire NDP (header + frame entries) starting
> at ndpoffset fits within skb->len.
> 
> Also use struct_size_t() for the NDP size calculation instead of manual
> sizeof() arithmetic, as suggested by review.
> 
> Changes since v1:
> - Split into two patches with separate Fixes tags for NDP16 and NDP32
> - Use struct_size_t() instead of manual sizeof() + count * sizeof()
> - Verified fix prevents out-of-bounds read via fuzzer regression test

Thanks for the update,

Reviewed-by: Simon Horman <horms@kernel.org>

