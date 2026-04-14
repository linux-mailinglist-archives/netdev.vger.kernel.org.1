Return-Path: <netdev+bounces-278437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJqoHg803mm4pAkAu9opvQ
	(envelope-from <netdev+bounces-278437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:33:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2E93FA021
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F3F9300D771
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31150390CA9;
	Tue, 14 Apr 2026 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtK0m82D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8A1D9A54
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169997; cv=none; b=k230YOuVtpM4bqqoq5nbUOlxybtw3V7TGf2gfSd3mqkV/vMFiV/ymDR4dXP1mzULMX5m+0L26ZyS5F2o15lBfFMtxpiwaXgGm3dPv8lqT22kGqgXDSWgGmR7nWSR9DGd4vhwzdz0jM1slMaKm4F6Z5Cyl5w1Rp7b/R7mx2FDPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169997; c=relaxed/simple;
	bh=VqY197kaRg/NI/6eR7QGHIk1nvNHulpurLpja3VDkuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXxbIeMsLw4iKoO4ZiHt7nBSr9eR5l6WD6Vps2A+ThIOqVLUShEKW5E2JR7ZOW/or8IF0K7kMuawxoxbAsHdi8/IMycecy1v7jm4mnlBUAN48h9uJKracI2bqeKiroVeMZQtPhkd14hkMLwZubmtXrooKOSw5cTEkMrphZ4swYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtK0m82D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A2FC19425;
	Tue, 14 Apr 2026 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776169996;
	bh=VqY197kaRg/NI/6eR7QGHIk1nvNHulpurLpja3VDkuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtK0m82DHW0nRdwBpSp1njXIFWhDpZCCdAFeoyTvddiaZBgmn/HU0JiUTe/yuNBO7
	 Qki7xMCVtgBT9PTlCVhIP8i7JOtOEPZER2RY5XvEKfkobQxclzVo0a7w5hbukxZk8w
	 g2WoQI7g4bcuaRjgnwXLbm31jdP2sdL7egbiV8tvvgh2laCSXq3dMy9LSQnFajt2k5
	 +OmNU7+iZU/O5F7juvMctilERMpvcftwlKSJ3J6Upadw389JKOX1gmhn8ufRvYkQEN
	 lUFzb7NCTALzi40Di83Eer3N8t/XdOU+08Kq3dNqI3fs8tnIK4tTpnYO/WP3/0rJCJ
	 0zLrH/Y9qhQLQ==
Date: Tue, 14 Apr 2026 13:33:11 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, sd@queasysnail.net, yifanwucs@gmail.com,
	tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn,
	caoruide123@gmail.com, zylzyl2333@gmail.com
Subject: Re: [PATCH net 1/1] ipv6: xfrm6: release dst on error in
 xfrm6_rcv_encap()
Message-ID: <20260414123311.GE469338@kernel.org>
References: <cover.1775886482.git.zylzyl2333@gmail.com>
 <fc06a81e1c1cbbb3e918825a718046cb18204f3c.1775886483.git.zylzyl2333@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc06a81e1c1cbbb3e918825a718046cb18204f3c.1775886483.git.zylzyl2333@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,secunet.com,gondor.apana.org.au,davemloft.net,kernel.org,google.com,redhat.com,queasysnail.net,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-278437-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 1F2E93FA021
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 01:07:54PM +0800, Ren Wei wrote:
> From: Yilin Zhu <zylzyl2333@gmail.com>
> 
> xfrm6_rcv_encap() performs an IPv6 route lookup when the skb does not
> already have a dst attached. ip6_route_input_lookup() returns a
> referenced dst entry even when the lookup resolves to an error route.
> 
> If dst->error is set, xfrm6_rcv_encap() drops the skb without attaching
> the dst to the skb and without releasing the reference returned by the
> lookup. Repeated packets hitting this path therefore leak dst entries.
> 
> Release the dst before jumping to the drop path.
> 
> Fixes: 0146dca70b87 ("xfrm: add support for UDPv6 encapsulation of ESP")
> Cc: stable@kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ruide Cao <caoruide123@gmail.com>
> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/ipv6/xfrm6_protocol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Horman <horms@kernel.org>


