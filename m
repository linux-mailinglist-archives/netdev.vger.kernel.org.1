Return-Path: <netdev+bounces-267253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kpC3C2Nks2lfVwAAu9opvQ
	(envelope-from <netdev+bounces-267253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:12:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6DD27C2D4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B3AA30BA3DD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEF5309EFC;
	Fri, 13 Mar 2026 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSYbkoxk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187F305962;
	Fri, 13 Mar 2026 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773364308; cv=none; b=jryMYaOr0Pq3EuLKwSeSDcGQk9SmOHsaPz/aLpuXGRIgqN6oMEEFO7GoxT1YQ6yRr7sV65BIrc59010cV/OX12s/EfW/gA8dh5Ilg4jHLLXH0yhGrf5H5WIyvo7GuPEyyuU0wWbLHhjDG6PsXQN8tbRiG31yTNYh9OuQ+2FVs4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773364308; c=relaxed/simple;
	bh=+FHR5HkHe5dEzhU7wYfy3RYD1aPbmHxdo9/3TzU/KXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0rmf1y21bXfY2vvhbGdkrZZWRHTvbm9LSY8LDkWTf5IhptL5F8G0FUZQAgoJqA9p30u5BV2fjkCLhApJ3Qb+8cAK/2Si8jKF7IkGFUdC1EkABs7qCCBCTszFhhdv7PPe0mGzuu65KwN3iyRPH305L4JrPQM1ZZFiC7Z2IeBQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSYbkoxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103E5C4CEF7;
	Fri, 13 Mar 2026 01:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773364307;
	bh=+FHR5HkHe5dEzhU7wYfy3RYD1aPbmHxdo9/3TzU/KXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kSYbkoxkXLCF2EXzFtZkuTvxRz10PS0lUScodEdtI38UFNqAWzbF+ZMo8FO9xAv0T
	 Uot+4vSqhIVV86hk8NQb9zf9uiVW9hmOKrAR7NmodasBrCLzqMIF7POKo0qI8SyegC
	 1JWuRU/b61MHIwhL4yd/mtXZq8rijYU/1Q+F841OS9Gpk6b0mCSt1bCsMxyNnecs2b
	 M/CtEVrnlvMHtHieJIh66gF1OTyxXxJVZ0Wyr3Kbn/qL9kl6s/Rs4G+Z2DAixjXcVx
	 kD/lt+kmfa89qEXfZ94L4SZtY1xjZVCIc+X+/kTnl5TJZVPiLbmU0BwF1JSRD2KR8c
	 hw7IkXaA1kSFA==
Date: Thu, 12 Mar 2026 18:11:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Damien Dejean <dam.dejean@gmail.com>
Cc: andrew@lunn.ch, krzk+dt@kernel.org, robh@kernel.org,
 maxime.chevallier@bootlin.com, pabeni@redhat.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 edumazet@google.com, davem@davemloft.net, hkallweit1@gmail.com
Subject: Re: [PATCH net-next v7 4/4] net: phy: realtek: add RTL8224 polarity
 support
Message-ID: <20260312181146.266c5205@kernel.org>
In-Reply-To: <20260310173846.230923-5-dam.dejean@gmail.com>
References: <20260310173846.230923-1-dam.dejean@gmail.com>
	<20260310173846.230923-5-dam.dejean@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267253-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,bootlin.com,redhat.com,vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E6DD27C2D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 18:38:46 +0100 Damien Dejean wrote:
> +static int rtl8224_package_modify_mmd(struct phy_device *phydev, int devad,
> +				      u32 regnum, u16 mask, u16 set)
> +{
> +	int val, ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	val = __phy_package_read_mmd(phydev, 0, devad, regnum);
> +	if (val < 0) {
> +		ret = val;
> +		goto exit;
> +	}
> +
> +	val &= ~mask;
> +	val |= set;
> +
> +	ret = __phy_package_write_mmd(phydev, 0, devad, regnum, val);
> +
> +exit:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}

Can this helper be added in patch 2 so that we don't rewrite the code
we just added? It makes the diff harder to follow.
-- 
pw-bot: cr

