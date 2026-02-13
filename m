Return-Path: <netdev+bounces-258563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDUKAEy0jmnBDwEAu9opvQ
	(envelope-from <netdev+bounces-258563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 06:19:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27957132FA8
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 06:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A960D30142A5
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 05:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193E423536B;
	Fri, 13 Feb 2026 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrJjT6C1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D143121CC5C
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 05:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770959943; cv=none; b=l/IGXRJEPaDRJLrkAJr1pegfPdFktS+W1ZOw2x5NZbV5l3KCrJwuLnWVtMa7ADQ456rSAi0sbGLBYGROLT0XitlEySLK64ol/sCChDjbQkGfcS/fpccjJFKjFweDdFzUUgnNfBKuCwMWXa4dlPqiPdW17/DYjNRxbWfsr0s3Dcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770959943; c=relaxed/simple;
	bh=C79fQuNmsoe1mDgNmWqWlrk1yFpf0tY09o68U+R5SG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP8pZfu272m5opLh/CRQGdyPb52kJHw7kEqGaoGqMGhUwMfX+DqHtAtKKJIs3pgckB1zF3gwGwnSyaAKnKwOAfLgVi/zLz5fKS2PguYHTF3rKdsBj5Bx+bOwaTjrHBz4GQcOxZHuSOJrv1KKnrJs+GrjMY3MtuzMnv6swsTSIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrJjT6C1; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba94dbf739so653243eec.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 21:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770959940; x=1771564740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JgXT3I4sUDI0oaN+QbxtrFi8HM7j7HM1bT+EMzWKpeQ=;
        b=UrJjT6C1B3pEiN9bMSkMMOb7eWvdOhOg/cJ0l4qu/fn4PN2OmYw/qNSCXLrBIWUuRu
         OBOExj9bYJ2GpCtCBRWIVszQulmr3GJfqRLGS6soRjjlqEEBcyvxSpokSSNLblm3W+Tc
         NIojup5O/8l6xc79IMEkNktyxX04OSpPPIAwFw2905ijz3m8bJHwju+8uPTowZ7aZgkt
         3ukfODrtj1lmPk00L6Ad6Z/a3HqjqDIoza1GCJusU5w7g2ipzgVtRV87+z9/Own3fJrT
         EAXSsDS+5hqHxL4pUuErdi+UY4XvDSZYTvlPkino5PW/Z1T9aftjAPI5EwIbuxp7kao/
         pnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770959940; x=1771564740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgXT3I4sUDI0oaN+QbxtrFi8HM7j7HM1bT+EMzWKpeQ=;
        b=QCZ3PypvaOvqcDpyXjzpuBXWRSH6mIqX9zLji41Vfj+68oUrx/1sdaPAx2Vmrh975V
         C0LsjEaIOvEVe2RKjEw6H2k9VBwSu10wRzcdPS047Ru5Q3t4wpIrinRXxe3mNwwrTv4q
         CI9eWzsKFDlu2+aEHR0x9dUnhgmipS/p/3qqLTuDvz1Z3mEeMD96vqkH9gSbw0LbQ9A+
         Vswq8/ChR5q/GmeiOMbVCxO8JZ8en6B4iglzj+qW+b/NL84Y00IQud3/Sf/6vUuhxTkq
         4uyogJPQmbuzE+0QHyZKppwD0nIw5atQjEXTcWBkSa4NQlTfP/hkguyXivkMYXq0mQ8M
         zeGg==
X-Forwarded-Encrypted: i=1; AJvYcCW/A8KtCer81szWdCKJfig94Os6Sfk0OgrH09BbecNV188Zq7toDWZJ/3qkpTuvECKo8rSIc+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYY4RGxAlsF7W54sTju8K/lwuYUyLlyiSlvZlDrlqxKTLsmgxw
	F2tIHpVswSmFosSuHw6InD+/DKMlaU4K9FBP0tGbyoWsDF6D71GstF0=
X-Gm-Gg: AZuq6aI0Hc8Z6HA2MJ/2zQfMHo9bJ99IGTzdGk4lOUCogqdffE0TZCjkY6fHAr+VKR5
	ysh+OJi3rwP7uwI8zg2Ph36b6VsAt6Ex9PS7cDuXlJIskL98vjVktpsLupQdzQXA4Syn5ELOrrI
	hcdkhXiR3Y5NjavMutkUbBm6nKG4i17MMm9HBT9bWap0XfklnK/lT+0+paqmdQo7NIF0Ta94DVF
	tM7eWQzIQ3rcoO4c/HI9wQjwoaZDQSTaz25mVa2MB54HvAFlzrY9p55qKiwDVpEJKNRCBMpTPVN
	4HW2Lv9psL5gQzdw9K/Yqa15EnmH5s8M3jLA9W2wKw/9XFkBIrPQ3OpL6cvZR2ywOoyTvo2dI+r
	yexElkrOlJgXi3dDsRQj0W7aCUT/8FO5f1AkBIEUiMkWfwhW1jC7WLb36u6bCUcu+VMqNSIwneM
	JdspS8cYRMsX4qrog5Lua8zo4PeXieukMnDOA9Cbl8Lt2CgNCBnvquzNzbn1jHkL7AAiLx1giIq
	S9bU84nxzAoIA5iIg==
X-Received: by 2002:a05:7301:7214:b0:2b7:ee0e:e9bf with SMTP id 5a478bee46e88-2babc4558femr275595eec.27.1770959939783;
        Thu, 12 Feb 2026 21:18:59 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd0614sm5463343eec.22.2026.02.12.21.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 21:18:59 -0800 (PST)
Date: Thu, 12 Feb 2026 21:18:58 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: Re: [PATCH bpf-next 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aY60QrE6DpXVecze@mini-arch>
References: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
 <20260210-bpf-xdp-meta-rxcksum-v1-1-e5d55caa0541@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-1-e5d55caa0541@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258563-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27957132FA8
X-Rspamd-Action: no action

On 02/10, Lorenzo Bianconi wrote:
> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> checksum will be use by devices capable of exposing receive checksum
> result via bpf_xdp_metadata_rx_checksum().
> Moreover, introduce xmo_rx_checksum netdev callback in order allow the
> eBPF program bounded to the device to retrieve the RX checksum result
> computed by the hw NIC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml |  5 +++++
>  include/net/xdp.h                       | 14 ++++++++++++++
>  include/uapi/linux/netdev.h             |  3 +++
>  net/core/xdp.c                          | 29 +++++++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  3 +++
>  5 files changed, 54 insertions(+)
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
> index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b70618a9d4f32544d8b9a30b63 100644
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
> @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
>  };
>  
> +enum xdp_checksum {
> +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
> +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
> +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
> +	XDP_CHECKSUM_PARTIAL		= CHECKSUM_PARTIAL,
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
> index fee6d080ee85fc2d278bfdddfd1365633058ec06..e51346ad3031f28d11c11f8205da6cd954da82de 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -961,6 +961,35 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
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
> + * ``XDP_CHECKSUM_PARTIAL``
> + *
> + * In case of success, ``cksum_meta`` contains the hw computed checksum value
> + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE`` and
> + * ``XDP_CHECKSUM_PARTIAL``.
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
> + * * ``-ENODATA``    : means no RX-timestamp available for this frame
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
> +					     u8 *ip_summed, u32 *cksum_meta)
> +{

Any reason not to do enum xdp_checksum *ip_summed here as well?

