Return-Path: <netdev+bounces-258457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDqwMi/YjWkR8AAAu9opvQ
	(envelope-from <netdev+bounces-258457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 14:39:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BD512DE30
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 14:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B019E309526C
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A5735C1A2;
	Thu, 12 Feb 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rblpKQRE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35835C195
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903590; cv=none; b=N5zP5YlYV6d2kQKXX3SOAizFr8GR812kUKrD08azF+4wO5QyNkwbbUWlc2Qbvu01YycEiXSJJNI59EsQ7td9XN5pkSxPl6ebdtCxjPxK9PWQvw5GRwQqtyV5URAFKPHSyAsK4VOIZm25wuzbgILZrAykdWlchRSNIn5QUxPqI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903590; c=relaxed/simple;
	bh=GhP2JH8hv0QUuMt7s8iCgKyAUNoOmckDel9CKid1yAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO8UldawzIF8RxdtNn3LoMT7HxmEmjBhF+N43IBC3BNVpC0hGBcxAiakHG+7o4H7/mKAuT0yMY1yb+GYowIRL7bM5507xxyvNQ+tynvX9aSk7Jg7je8oeBDB1/kobSFfQtH25s++55cvMz+tv5MXzIhWgMTnwIPrzoMAOn5QcEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rblpKQRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D28C4CEF7;
	Thu, 12 Feb 2026 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770903590;
	bh=GhP2JH8hv0QUuMt7s8iCgKyAUNoOmckDel9CKid1yAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rblpKQREppu1Ecof+VBy8uLpwjJ2ZAw+lUr0kVBhuIpmCJ7i2syVz8PDRUWhQ33Rx
	 WdfbHeInMHxIZmdzFRfcG5LrRnYlcXJGgfojyx0rO/ub6EucsMSlyswEk5jtyDRlxX
	 bcuU5zVWCZIwm4hrVRpvtgzYUbkoqEQvftEsoVCiID7IAx+Nv0IJPm9NdJASU2E7lo
	 B9Mfg9l7ZODxnGRKvxrAQ+LQkBacF+UDKNUHGYoFZxDpSiTrOwtZ6J1dYzFso7q2jD
	 QIC4IYCgh8bEf4WgL6eI012hcNaUCLUQWC+HVjOWr2CW3wXLigiOA1rXdw+AYHpkIf
	 IQf02OMIfMrQg==
Date: Thu, 12 Feb 2026 13:39:46 +0000
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matt Johnston <matt@codeconstruct.com.au>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mctp: ensure our nlmsg responses are initialised
Message-ID: <aY3YIiY8_wr5IvKn@horms.kernel.org>
References: <20260209-dev-mctp-nlmsg-v1-1-f1e30c346a43@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-dev-mctp-nlmsg-v1-1-f1e30c346a43@codeconstruct.com.au>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258457-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10BD512DE30
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 03:27:33PM +0800, Jeremy Kerr wrote:
> Syed Faraz Abrar (@farazsth98) from Zellic, and Pumpkin (@u1f383) from
> DEVCORE Research Team working with Trend Micro Zero Day Initiative
> report that a RTM_GETNEIGH will return uninitalised data in the pad
> bytes of the ndmsg data.
> 
> Ensure we're initialising the netlink data to zero, in the link, addr
> and neigh response messages.
> 
> Fixes: 831119f88781 ("mctp: Add neighbour netlink interface")
> Fixes: 06d2f4c583a7 ("mctp: Add netlink route management")
> Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Simon Horman <horms@kernel.org>


