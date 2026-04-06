Return-Path: <netdev+bounces-275616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I53GnPG02mqlgcAu9opvQ
	(envelope-from <netdev+bounces-275616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:42:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 107263A4511
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3ADA306A93E
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E175381B0C;
	Mon,  6 Apr 2026 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox90Kz2+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4A33438F;
	Mon,  6 Apr 2026 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486298; cv=none; b=QRyT8XTOtwXG14myVMQHUrEkgslOPWfWiXurxMRCcRyKKbXfef73A8B83BDi/nJHVp4b+WakuYrE1rlvkVFkQaPiM3Ho7D6LhawaQvC6/RPfAwRrA4WyPxrCSo5Rn48lMwolVp58a3w9KuoL10SqcAg2KAcVc7w9IS3oD0Xy3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486298; c=relaxed/simple;
	bh=10F6laciObSBOZ+/ZH33QFfxTqUAm38VUiS/FDdye50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooeo+z2V6bzybITYFCcwhe8wiH4vozsSMqa2EzpQ448f/bKcJx9NJSlB3OXRC6z4aP8kzSsfo7xyB3/+Licv+FwW4z+oucd+LQKW8V3usu7K5447/L4szqjONrJBrQ7S8/+HJg2yqI2vOWcQomBba83C1ZBuwpqk0zn0K6dIxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox90Kz2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4BDC4CEF7;
	Mon,  6 Apr 2026 14:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775486298;
	bh=10F6laciObSBOZ+/ZH33QFfxTqUAm38VUiS/FDdye50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ox90Kz2+NpMNBy6f6x5ADx3lPMTf71gdt3bGzebTsbQ5KI/Xuv+f3gcCbfecRHj4e
	 KYxkMbmlfjbHZ08eq1/DcXkFwIPv7GVNg25L/pVyJNFgCtvpMDZmc8W4pHsd5qCKVh
	 JLKSvPAe/ZSKpS8c9rhZgB4hQw+CE+M3kkgUscvanhJM2a82gUVl+h5t5CbDUmIqVW
	 jKiHmv82uJApzE6f0I+HwfCUnckG8Xpq06wHp8dK2vw1czVR9AZslxhJb0QWRgQAZ1
	 zFvEvKbaMH533mXGS1rD41dlHSsSNlgYv5Tt7lwd4rqfVB308qIq0L1rZlWWv6xI3Z
	 jcKPf/o5Xd2tQ==
Date: Mon, 6 Apr 2026 15:38:13 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ip6_tunnel: use generic for_each_ip_tunnel_rcu
 macro
Message-ID: <20260406143813.GG395680@kernel.org>
References: <20260403084619.4107978-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403084619.4107978-1-yuehaibing@huawei.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275616-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 107263A4511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:46:19PM +0800, Yue Haibing wrote:
> Remove the locally defined for_each_ip6_tunnel_rcu macro and use
> the generic for_each_ip_tunnel_rcu from linux/if_tunnel.h instead.
> 
> This eliminates code duplication and ensures consistency across
> the kernel tunnel implementations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/ip6_tunnel.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>


