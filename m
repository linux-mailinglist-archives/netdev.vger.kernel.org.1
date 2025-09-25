Return-Path: <netdev+bounces-226351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAA7B9F558
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3A67AA5EA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE11DFDA1;
	Thu, 25 Sep 2025 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwOKBEWa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F871D54C2
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804433; cv=none; b=B3jotj2CMOymdykOSReUBEiwGAHG4eo77CfUvteMisXdrRrPssZcy9k8C5GKYQBQQXsZsSGX2uFKncyctAtPraCBYp5idnlzVhYZ/tgN9A5+m38kT8yURNGoPF8Tvswz7BCC0HI/qkXZVC8eZICHRUyxfKn7zyul9ajC0nYy+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804433; c=relaxed/simple;
	bh=h8dj3q/tU9y+h1ZUDAZ0aunuRC0Jsphsil4OfIWN+Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdV5gsHJAHkrgwrFf4jj21sF9zdH+LwqzOcrnNTsG7enCwYlu7dx//ODa8Fj+liHeZJG71EhxwyePntVfacvhwLKdxp+Awp57yqBRmqg3umAxhoecj9BMcru2kXb/Tv+ALDyiT4hJ4jIOKRC1TWbwyyX44DAclqiz2qoi43B/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwOKBEWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB51C4CEF0;
	Thu, 25 Sep 2025 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758804431;
	bh=h8dj3q/tU9y+h1ZUDAZ0aunuRC0Jsphsil4OfIWN+Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwOKBEWaBY2FwgNQU/9v6FuHWn53jynfIe0RQbVIH0WsJqEyU2nLnSTFhJAaBNr2w
	 QGUf1H7zdXRKe5MsYDi1GcwjEeKUsJtVc5h1OE3FWGmK6qpWSj7lv4UufpDglX3kAV
	 6YbF+W8JiYd0vGpQWYuM9C41m3tVXlgUTaHDTXwMKSd6MONm2JhxZ5KFDNhFAjMVgU
	 4owJ4shSBvkIcVCgkmMiM2FNH2Pkxw2P+/1Z2kp+H3hYaE4VMCiX8Okq41DZ0tp6ph
	 6ptT1duQ3E6TppYlSiJTgEMAQVEAmr4QtTkjMpmrIHmdbF2/hsiqkUd9uBHPj4XL2E
	 Ux3BxasBMc3Lg==
Date: Thu, 25 Sep 2025 13:47:07 +0100
From: Simon Horman <horms@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] tipc: adjust tipc_nodeid2string() to return
 string length
Message-ID: <20250925124707.GH836419@horms.kernel.org>
References: <20250924112649.1371695-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924112649.1371695-1-dmantipov@yandex.ru>

On Wed, Sep 24, 2025 at 02:26:49PM +0300, Dmitry Antipov wrote:

...

> diff --git a/net/tipc/link.c b/net/tipc/link.c
> index 3ee44d731700..e61872b5b2b3 100644
> --- a/net/tipc/link.c
> +++ b/net/tipc/link.c
> @@ -495,11 +495,9 @@ bool tipc_link_create(struct net *net, char *if_name, int bearer_id,
>  
>  	/* Set link name for unicast links only */
>  	if (peer_id) {
> -		tipc_nodeid2string(self_str, tipc_own_id(net));
> -		if (strlen(self_str) > 16)
> +		if (tipc_nodeid2string(self_str, tipc_own_id(net)) > 16)
>  			sprintf(self_str, "%x", self);

I see this is a nice clean-up. Thanks.

Would it make sense to move the '> 16' logic also be folded into
tipc_nodeid2string(), or a wrapper provided, to further simplify the
callers?

> -		tipc_nodeid2string(peer_str, peer_id);
> -		if (strlen(peer_str) > 16)
> +		if (tipc_nodeid2string(peer_str, peer_id) > 16)
>  			sprintf(peer_str, "%x", peer);
>  	}
>  	/* Peer i/f name will be completed by reset/activate message */
> @@ -570,8 +568,7 @@ bool tipc_link_bc_create(struct net *net, u32 ownnode, u32 peer, u8 *peer_id,
>  	if (peer_id) {
>  		char peer_str[NODE_ID_STR_LEN] = {0,};
>  
> -		tipc_nodeid2string(peer_str, peer_id);
> -		if (strlen(peer_str) > 16)
> +		if (tipc_nodeid2string(peer_str, peer_id) > 16)
>  			sprintf(peer_str, "%x", peer);
>  		/* Broadcast receiver link name: "broadcast-link:<peer>" */
>  		snprintf(l->name, sizeof(l->name), "%s:%s", tipc_bclink_name,
> -- 
> 2.51.0
> 
> 

