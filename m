Return-Path: <netdev+bounces-252947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAQcLmTPc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:43:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 176BA7A3DB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5572F3030B2F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF032417F2;
	Fri, 23 Jan 2026 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq9t7mfP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3C1A9F88;
	Fri, 23 Jan 2026 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197393; cv=none; b=uvTR4jcRTuolAtlTH16hdpdpZKAp9l78/FQZ2sqfMj4mAB1xZDITjd6cYT2DI2bzv78xqSMrnxqcNv5cqNv1PjrYi8wlM7ShfM0DUMfWMQtOb9jiYAkto0lY+4wh9O+uxmTjP9dGPtrcO+0FEAPT3jENdTDrgPMqdnfXZdxACAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197393; c=relaxed/simple;
	bh=9iW2fL+bdbL87/HvTRzbq2r9o0MVTZB3AUK7/ku9a1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4mWyMZEtmVHyKUqcVZj1w3W75pWZAdj2Heb4Pnohh8VgvUMNL2vNpwqfftVIdjoK3aL+EHpf/raxmwFQIEKr/kJepnR3VDD7M5BHmggNErW82RjZFH3/SXGOAWILYnxpJDuparJqeeecfDzLQ1qPodc7KHJGCtvTFTDmWDzg+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq9t7mfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5C7C4CEF1;
	Fri, 23 Jan 2026 19:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769197393;
	bh=9iW2fL+bdbL87/HvTRzbq2r9o0MVTZB3AUK7/ku9a1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aq9t7mfPmSXPpLaKYlfAJvUjrvQk+iasjKNmFXY2AqTihtfyXaQtMPW4VWur7+poa
	 tove0sKttvPto8h1SeDk13NprzJG8W7emeazfaDpBqoBMwSLbtwaWzFhQBcd4UDj3v
	 TwbkrRUhk7UGDezy5DH7Q7QiaTVjztTjf3Rdti44UIFBBPA/UTKAZhqJL8+IC24oku
	 4tg45Gn3dXBdqe82Q9EsR4uGOtYendLjVNATquzafx91OESws0c5vchyYBpXVo/+oV
	 YnUdQ+B1su7bZUOzNi1Gq+n9ooPc/5IXv6WY1P/yuUMVDhpBGGPs+xUXbSJMuo+s/7
	 704e0YCYOLc4A==
Date: Fri, 23 Jan 2026 11:43:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xu Du <xudu@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 4/7] selftest: tun: Add helpers for GSO over
 UDP tunnel
Message-ID: <20260123114312.6f7c441e@kernel.org>
In-Reply-To: <b5787b8c269f43ce11e1756f1691cc7fd9a1e901.1768979440.git.xudu@redhat.com>
References: <cover.1768979440.git.xudu@redhat.com>
	<b5787b8c269f43ce11e1756f1691cc7fd9a1e901.1768979440.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-252947-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 176BA7A3DB
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 18:04:58 +0800 Xu Du wrote:
> +static int geneve_fill_newlink(struct rt_link_newlink_req *req, void *data)
> +{
> +	struct geneve_setup_config *cfg = data;
> +
> +#define SET_GENEVE_REMOTE rt_link_newlink_req_set_linkinfo_data_geneve_remote
> +#define SET_GENEVE_REMOTE6 rt_link_newlink_req_set_linkinfo_data_geneve_remote6
> +
> +	rt_link_newlink_req_set_address(req, cfg->hwaddr, ETH_ALEN);
> +	rt_link_newlink_req_set_linkinfo_data_geneve_id(req, cfg->vnid);
> +	rt_link_newlink_req_set_linkinfo_data_geneve_port(req, cfg->vnport);
> +	rt_link_newlink_req_set_linkinfo_data_geneve_udp_csum(req, cfg->csum);
> +
> +	if (cfg->family == AF_INET)
> +		SET_GENEVE_REMOTE(req, cfg->remote.r4.s_addr);
> +	else
> +		SET_GENEVE_REMOTE6(req, &cfg->remote.r6,
> +				   sizeof(cfg->remote.r6));
> +
> +	return 0;
> +}
> +
> +static int geneve_create(const char *dev, int family, void *remote,
> +			 void *hwaddr)
> +{
> +	struct geneve_setup_config geneve;
> +
> +	memset(&geneve, 0, sizeof(geneve));
> +	geneve.vnid = VN_ID;
> +	geneve.vnport = htons(VN_PORT);
> +	geneve.csum = 1;
> +	geneve.family = family;
> +	if (family == AF_INET)
> +		memcpy(&geneve.remote.r4, remote, sizeof(struct in_addr));
> +	else
> +		memcpy(&geneve.remote.r6, remote, sizeof(struct in6_addr));
> +	memcpy(geneve.hwaddr, hwaddr, ETH_ALEN);
> +
> +	return ip_link_add(dev, "geneve", geneve_fill_newlink, (void *)&geneve);
> +}

I'd be tempted to allocate the request in the here, and instead 
of passing the "fill" callback optionally pass in partially /
pre-populated req. Just food for thought in case you'd like the idea
and what to follow up. v6 looks good so I'll merge as is already.

Thanks for converting to YNL!

