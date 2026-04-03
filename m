Return-Path: <netdev+bounces-275139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM2TKNXsz2lF1wYAu9opvQ
	(envelope-from <netdev+bounces-275139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:37:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7076396831
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D36300EF59
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A143CCFB7;
	Fri,  3 Apr 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaTQQxIN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8183CCFA3
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233589; cv=none; b=Av2iWYNs6TszeS0lmWiTAxvdSfoYQRvWpCg8gfhOpyLfG8JPaGnxh9PQAYDvCLkaypIjl3UZJV2rWHqa4ySoD6iIRY6yZJhlgKoX+TswVS9lOwgAg3r5M1kBjfowyK2egVTGuwQ0vmKxmUBVmioQD5UwRbzGSIqDaRsvUWBn8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233589; c=relaxed/simple;
	bh=PQI8hQoKKs0qI4ILdyv4HJHsJNSJoJIs4raAItgmIss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW4GlCtbyxdX3lh0CEkykx38XqfEiN5I3z6jt2qLVwBSm7jweXHW/G2p9DKaF+KP9RAsgzqiFLIb8p/xYKAtnamP4R2Px6QNzWo7Ty1Mj2MXApA8FSCOLSTz7ILI6NhsCbYeyCsAWJ9zuoCiZ15ppiIhltZTZoeZeGJGfSnCaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaTQQxIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF7EC4CEF7;
	Fri,  3 Apr 2026 16:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775233588;
	bh=PQI8hQoKKs0qI4ILdyv4HJHsJNSJoJIs4raAItgmIss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YaTQQxINOeWP6B7PclF6HmREFfoquk3E/N9saH5emM0RPcG+eiPjU7D+QqHrv3NrU
	 qdk7yHEq3t/uktAHhvJxshdXJTPHHfF52kAZT1XLcTguJN/dJSvDOTS1jlQCdvW8SL
	 eqAFq2G6L4eWhnEP2rfYrE4jOE1IrC7hJXDsSIbK4f6expMEo2qGoTipy+uXc6qr/q
	 B3Fh/R7udRHi0o4U3GYp+ebeetLUyakV4Alu/QCvOAxVf8S8xPfdV6MYy5WDHnaMQZ
	 +4baEPmbvM/Q67TpCn4sUpLATVQ7bXJ2jClMFBpbPcx0VUpagXxnl/Ul47yaE+cmaI
	 ik6vn2YYRXweA==
Date: Fri, 3 Apr 2026 17:26:23 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, elibr@mellanox.com, yifanwucs@gmail.com,
	tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn,
	enjou1224z@gmail.com, caoruide123@gmail.com
Subject: Re: [PATCH net 1/1] net: sched: act_csum: validate nested VLAN
 headers
Message-ID: <20260403162623.GP113102@horms.kernel.org>
References: <cover.1774892775.git.caoruide123@gmail.com>
 <22df2fcb49f410203eafa5d97963dd36089f4ecf.1774892775.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22df2fcb49f410203eafa5d97963dd36089f4ecf.1774892775.git.caoruide123@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-275139-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: C7076396831
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 10:46:20PM +0800, Ren Wei wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> tcf_csum_act() walks nested VLAN headers directly from skb->data when an
> skb still carries in-payload VLAN tags. The current code reads
> vlan->h_vlan_encapsulated_proto and then pulls VLAN_HLEN bytes without
> first ensuring that the full VLAN header is present in the linear area.
> 
> If only part of an inner VLAN header is linearized, accessing
> h_vlan_encapsulated_proto reads past the linear area, and the following
> skb_pull(VLAN_HLEN) may violate skb invariants.
> 
> Fix this by requiring pskb_may_pull(skb, VLAN_HLEN) before accessing and
> pulling each nested VLAN header. If the header still is not fully
> available, drop the packet through the existing error path.
> 
> Fixes: 2ecba2d1e45b ("net: sched: act_csum: Fix csum calc for tagged packets")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


