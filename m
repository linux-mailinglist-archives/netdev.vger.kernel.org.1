Return-Path: <netdev+bounces-241355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 549E4C831E9
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3EB834A901
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 02:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA921A00F0;
	Tue, 25 Nov 2025 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuVWuNul"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E0B17A586;
	Tue, 25 Nov 2025 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764038391; cv=none; b=XBbzkSfAppQme+kNAju4zp+Qnh/SXz9+KDIPIA+n4dtOArXeKqlibChQTkT1Z/ihoopXnYeDX9YrR/FlFmFMfNnxaxlpIr526MKkJ9lLKyk5+HOdOxz1NQJc2v173wrvGkCIduxKv8SuQpeLxouT0K0d0AK5oFtDl7bNV3jhIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764038391; c=relaxed/simple;
	bh=EQBa74dCH+1SbXEM/XnzxK4sRiBYOGG3bxHC8a+1FuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFSw2beixn50sI/RcPV9Mvb/3vbrXG0DQ0CnP2k64QaGogqiLwqmzMJgxTNLkT2u/JCPhv+4g5ZQwtZa7w7yxclpIkWdtcRIIsFaXtgvSBevuqtdz8kjutRYVVdvIebOAX+rOQfhAeIS8XDsP9RXcG6fRAT6NfGC0zTfnVG53Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuVWuNul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62923C4CEF1;
	Tue, 25 Nov 2025 02:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764038390;
	bh=EQBa74dCH+1SbXEM/XnzxK4sRiBYOGG3bxHC8a+1FuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TuVWuNulMto9bYynoI6PE7Z1xt7N1dniqyDWfOgXZzlCCHt5FsI1gCAWuiYqJ10Du
	 J/NIHkTZauFYg+mrSHXb4ioPW4CmEHvtTv2F85YV9WaEH10g2zAYmyBxvrXe0zEwkW
	 tySZTWNfJxUnCdwiGVb7ScBTgFutETYt0MwYWjm8YvV3p89MIROnjK7ig+CpSHpOec
	 3fsMzpyKLX6FrBQuEb5cqtSpyF6+HaqImGJhoc+oL2JdQXnz7zdhdIe0rF6KwuEkD2
	 Lh7phwXI9kJmXqCW3NPn7w0d626gunBsIc6hHtiu25/c4EBfqMn0wVZlm2bZN7hxmC
	 riDenoZlZiOyw==
Date: Mon, 24 Nov 2025 18:39:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 oss-drivers@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nfp: tls: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20251124183949.62d61b24@kernel.org>
In-Reply-To: <aR5_a1tD9KKp363I@kspp>
References: <aR5_a1tD9KKp363I@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 11:39:39 +0900 Gustavo A. R. Silva wrote:
>  struct nfp_crypto_req_add_front {
> -	struct nfp_ccm_hdr hdr;
> -	__be32 ep_id;
> -	u8 resv[3];
> -	u8 opcode;
> -	u8 key_len;
> -	__be16 ipver_vlan __packed;
> -	u8 l4_proto;
> +	/* New members MUST be added within the struct_group() macro below. */
> +	struct_group_tagged(nfp_crypto_req_add_front_hdr, __hdr,
> +		struct nfp_ccm_hdr hdr;
> +		__be32 ep_id;
> +		u8 resv[3];
> +		u8 opcode;
> +		u8 key_len;
> +		__be16 ipver_vlan __packed;
> +		u8 l4_proto;
> +	);
>  #define NFP_NET_TLS_NON_ADDR_KEY_LEN	8
>  	u8 l3_addrs[];
>  };
> +static_assert(offsetof(struct nfp_crypto_req_add_front, l3_addrs) ==
> +	      sizeof(struct nfp_crypto_req_add_front_hdr),
> +	      "struct member likely outside of struct_group_tagged()");
>  
>  struct nfp_crypto_req_add_back {
>  	__be16 src_port;
> @@ -55,14 +61,14 @@ struct nfp_crypto_req_add_back {
>  };
>  
>  struct nfp_crypto_req_add_v4 {
> -	struct nfp_crypto_req_add_front front;
> +	struct nfp_crypto_req_add_front_hdr front;
>  	__be32 src_ip;
>  	__be32 dst_ip;
>  	struct nfp_crypto_req_add_back back;
>  };
>  
>  struct nfp_crypto_req_add_v6 {
> -	struct nfp_crypto_req_add_front front;
> +	struct nfp_crypto_req_add_front_hdr front;
>  	__be32 src_ip[4];
>  	__be32 dst_ip[4];
>  	struct nfp_crypto_req_add_back back;
> diff --git a/drivers/net/ethernet/netronome/nfp/crypto/tls.c b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
> index f252ecdcd2cd..a6d6a334c84b 100644
> --- a/drivers/net/ethernet/netronome/nfp/crypto/tls.c
> +++ b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
> @@ -180,7 +180,8 @@ nfp_net_tls_set_ipv4(struct nfp_net *nn, struct nfp_crypto_req_add_v4 *req,
>  	req->front.key_len += sizeof(__be32) * 2;
>  
>  	if (direction == TLS_OFFLOAD_CTX_DIR_TX) {
> -		nfp_net_tls_assign_conn_id(nn, &req->front);
> +		nfp_net_tls_assign_conn_id(nn,
> +			container_of(&req->front, struct nfp_crypto_req_add_front, __hdr));

Once again you're making the code unacceptably ugly.
-- 
pw-bot: cr

