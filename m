Return-Path: <netdev+bounces-259178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEA9EloPlWlsKgIAu9opvQ
	(envelope-from <netdev+bounces-259178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:01:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6C61526DA
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C4C6301CFB4
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696EC2BEFEB;
	Wed, 18 Feb 2026 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVKZWy82"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B433288CA6
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771376471; cv=none; b=f/ZoZ0DLpK90Z768w5w3Ce/KEk8GWFuiHFhYYEWER72z9jSwgJHgGP6QHO2y9eidLcKFRo6p2Xp6qw7lHPThODffpemvoifYUUGvKgYWVHDlb6ObN/zSvkyEXHoggTkz2gTAR9bEwJsHORc8Lb7mPipbHxk15FCVkXhv8JPpy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771376471; c=relaxed/simple;
	bh=AKwmyqWipydSHremCFQgnlHauwexTBBnYrUYEyewhLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvi2GBaUnjkrcinhpALRsrfD29b1XZ5F2jEqa2Dm9lKmNDRaTswaD68xzxTQlfBmx2AiMc1ffRzlK+NPNJb3BNT1RifkfSODC1QxPVV+xkpZJsXDqoW5/SoGRCIh2Qj3zJ2LSnZHfP7GF4BOII2oPHV7rxtA1ZuQYDNeDlhRcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVKZWy82; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-127380532eeso12030010c88.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 17:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771376469; x=1771981269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHDJ91Fh3k4sfksoLBobkNabAM6CU9B6Swq8q++g+cs=;
        b=jVKZWy829FuhbDhkutpbjjmC4Mm8ZLls+0Pk6AVURp07pQrD6hqZE7+N88Cycz47iO
         HIuzYeFv98PZz6rDXfTDyAN3z2LEeKeDzHKQb4yzM+g67pI98KN/Z7Nsy6WR85/qNoNt
         Vb1cTBCgKwu1zsO3kQ9PN41Fo8+q5ySlmYgiWhi9ZfBaxTIWMZwgwFDm/gsAjTEIpENR
         /yYKeUTkPhHNodt72xHZfazOSDi5TBdXMLN9zxftYSLSGnbu1L/mvj3B9HiUDxUkJ9B+
         wIUPi+eho80iGiGT1YjAw2LHcjmBXk130UH70TrFJuuJrWv+NaZJ/zisIdVj6ICWJ7A9
         WTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771376469; x=1771981269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHDJ91Fh3k4sfksoLBobkNabAM6CU9B6Swq8q++g+cs=;
        b=bdmFIPANscp0wn1lofMdlElVhbu4n/UL5SaNmJybZi6iwwfPT+dm5eaSG5dHTwQwMH
         SqGEkZLgAofgpRciGBYdqJ0CjHPdl8raqgzeH+slOTzaheWAbuJMt2E4oB10z9Kfijy4
         ET+PVy2XE6Zm50QamXdF9VBz/KDeKBD3wmx5hmBq2mn3L97DYy+Pn0rOd93umVqgIyWR
         zmixuXgrF0u+gN4xHPGJIf4sY+NaJojBS2cgwnuYHc4S+ZT9tL1VLP0xUrg2J3LMe/Mi
         LWdUHWXbW2TFWcAGWGEJfAKH+X29f+0eavIkJSIr7+WpiCo8K5aspMqqfecJZc1cXxDg
         gt6g==
X-Forwarded-Encrypted: i=1; AJvYcCWe89RtOipQyfsd1sm2EXDgz0/Z0zCWo8WNKQ0fec6rfexCmESdahLyUo3XC12HZ26zEfYYF4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqKGbH5QKGTKgoIxyncyaM4EBlomjnJ8mYts45ttktR3NTZNM
	/XPD71GdY7QK6N/9CJJW6qUsJ7IQQxxeZAvB2Eq1+/CYmGvzjaqySr0=
X-Gm-Gg: AZuq6aIFXEn2Q7GThjGmnzuCNew+5SVTP5XXlVL1Ln0v0fDM6U/OT3hCkQVpSVgdEZ5
	IstdiU7buBT6mLyFWSSdKVa4xuFTSx7tIdjmeGd/T6qHPPCnN8FFLxkq0b5Ic5FGwfdcwpYYDqE
	aLHSr44yjIbWFUahiGFPU7snWMF1spgiapAqmsYswa+zO57gqNONjxQo3CNj4THiJWfCl0xU0z2
	YgWvH+lE67CFEjD6rgbPMG3sRwH0znHZOKLgh5Q5KkhhsIkkHvJVFqVjwBJkq2l9x3a1kPf6dun
	3VlbRiaoEOFU9zjsgrCRk/CEsMyWg3qNnLH4qSTEuWRcUYKZDI/6nnR2aY3GaPuTTlfCo9kP1X2
	hx0cI7sl9pEGXS+PpWKC70rzLlfoxk2dXgu4dvouAI1c1YMk0UeD3zH4JEngLZiu/VHJR9+4Z87
	BcrWPz1Rac6DU1/ZEQ5710CWuin0rwhfKr/nWcQG9CQYtDoQ9nnJioD8aV7jEk0EcJFJ+IHEXTN
	KScvG8vSpwMSduhew==
X-Received: by 2002:a05:7022:1707:b0:124:9dea:188d with SMTP id a92af1059eb24-12759a709cfmr63162c88.30.1771376468918;
        Tue, 17 Feb 2026 17:01:08 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c6dc70sm16497835c88.8.2026.02.17.17.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 17:01:08 -0800 (PST)
Date: Tue, 17 Feb 2026 17:01:07 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aZUPUwYMRNXSg-eI@mini-arch>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B6C61526DA
X-Rspamd-Action: no action

On 02/17, Lorenzo Bianconi wrote:
> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> checksum will be use by devices capable of exposing receive checksum
> result via bpf_xdp_metadata_rx_checksum().
> Moreover, introduce xmo_rx_checksum netdev callback in order to allow
> the eBPF program bound to the device to retrieve the RX checksum result
> computed by the hw NIC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml |  5 +++++
>  include/net/xdp.h                       | 13 +++++++++++++
>  include/uapi/linux/netdev.h             |  3 +++
>  net/core/xdp.c                          | 28 ++++++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  3 +++
>  5 files changed, 52 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 596c306ce52b8303b20680ff0cd34d4fd9db0e48..58eda634668a07860447a65d9fc2284839af6244 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -61,6 +61,11 @@ definitions:
>          doc: |
>            Device is capable of exposing receive packet VLAN tag via
>            bpf_xdp_metadata_rx_vlan_tag().
> +      -
> +        name: checksum
> +        doc: |
> +          Device is capable of exposing receive checksum result via
> +          bpf_xdp_metadata_rx_checksum().
>    -
>      type: flags
>      name: xsk-flags
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c358575396530879af4570dc3fc18de..00abb2e1e85514b4080d0e4e6e3b8f5f67f73b61 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>  			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
>  			   bpf_xdp_metadata_rx_vlan_tag, \
>  			   xmo_rx_vlan_tag) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> +			   bpf_xdp_metadata_rx_checksum, \
> +			   xmo_rx_checksum)
>  
>  enum xdp_rx_metadata {
>  #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> @@ -643,12 +647,21 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
>  };
>  
> +enum xdp_checksum {
> +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
> +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
> +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
> +};
> +
>  struct xdp_metadata_ops {
>  	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
>  	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
>  			       enum xdp_rss_hash_type *rss_type);
>  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
>  				   u16 *vlan_tci);
> +	int	(*xmo_rx_checksum)(const struct xdp_md *ctx,
> +				   enum xdp_checksum *ip_summed,
> +				   u32 *cksum_meta);
>  };
>  
>  #ifdef CONFIG_NET
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index e0b579a1df4f2126acec6c44c299e97bbbefe640..d20da430cfd57bc26b5ea2f406c27b48d8a81693 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -47,11 +47,14 @@ enum netdev_xdp_act {
>   *   hash via bpf_xdp_metadata_rx_hash().
>   * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
>   *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
> + * @NETDEV_XDP_RX_METADATA_CHECKSUM: Device is capable of exposing receive
> + *   checksum result via bpf_xdp_metadata_rx_checksum().
>   */
>  enum netdev_xdp_rx_metadata {
>  	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
>  	NETDEV_XDP_RX_METADATA_HASH = 2,
>  	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
> +	NETDEV_XDP_RX_METADATA_CHECKSUM = 8,
>  };
>  
>  /**
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index fee6d080ee85fc2d278bfdddfd1365633058ec06..7d1e08d8ab4151ab42c91203def2afafc66d3149 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -961,6 +961,34 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>  	return -EOPNOTSUPP;
>  }
>  
> +/**
> + * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
> + * @ctx: XDP context pointer.
> + * @ip_summed: Return value pointer indicating checksum result.
> + * @cksum_meta: Return value pointer indicating checksum result metadata.
> + *
> + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
> + * values are:
> + * ``XDP_CHECKSUM_NONE``
> + * ``XDP_CHECKSUM_UNNECESSARY``
> + * ``XDP_CHECKSUM_COMPLETE``
> + *
> + * In case of success, ``cksum_meta`` contains the hw computed checksum value
> + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE``

The only thing I'm still not sure about is the csum_level and whether
we need to export it or just start with csum_level=0 and extend later
when needed. The rest looks good.

Jesper, Lorenzo mentioned that you might need it? Can you clarify?

