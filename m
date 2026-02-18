Return-Path: <netdev+bounces-259297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLOWLZOblWmsSgIAu9opvQ
	(envelope-from <netdev+bounces-259297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:59:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9A155BAE
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 153D6300DDC3
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D173033E1;
	Wed, 18 Feb 2026 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZpUFL7U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0C27713;
	Wed, 18 Feb 2026 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771412342; cv=none; b=bavKAHo5ekrJ8KkL6STBS+VsJYU8/X1CpAWuvkfGuvA/1amcqHhFpZBoo162HYGMz+xTCiqDUP4hc8KQ/UalyF1qFABfbIB+YdA3y/CuMAGLqlTAaec94JxTcUCd5yMmKKpd7ystFquxvWoiKueHVmO5dY8/4u5vtI9z3/C07Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771412342; c=relaxed/simple;
	bh=ExYM4GllfmADUjEjQoM2UYVUP6BlZRRL6bd+IQoD24U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+JGL6e1jaZdTGtPLl6e4VJlplG3SPZcq6rgpR0gtHZasbVa005uHGujvuYS3vEyIxhit640SrvLtUTs56eMJ1Nov8wTyg5K62vGWsNje2oyYlWMtMU/cIPeQl6aVRl3KMm6y54Le87JzccgRq8oDAhEMyVlvVGA6+7v/gDLK3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZpUFL7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7038CC19423;
	Wed, 18 Feb 2026 10:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771412341;
	bh=ExYM4GllfmADUjEjQoM2UYVUP6BlZRRL6bd+IQoD24U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oZpUFL7UbeSg9oxx+5ocBW10Hez4rK8Ywn1GTIJvuvO1VAfuPqKCtELpHKDIxBncs
	 KJ4vtX2edWTa0l5u7iBN93TrkRXf6dVi4M1aAAmJnDiBDDV/QPWh/5YrDIHwGGYx2r
	 aF5bVrkGvkBprxjVeOIVYmgcqx/6TafGUQPuVHur18V6fBZGyu1f6djmo9C2MlaUfv
	 oTZQDU1HbZIQ3syH4WHyc+pQHNJIZu0X/gUbwVmj61uun+juAMQcirK2NsKP4R7B16
	 /BaCu41DMGuoBBTKJk5s3lRe60sThdtIeJJBB1p1XVErSA0FAMGwCIwWqFhihIKxh1
	 E8R3wRzIaiePg==
Message-ID: <cd3d6e59-c103-4279-8e01-8792a78981c3@kernel.org>
Date: Wed, 18 Feb 2026 11:58:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Arthur Fabre <arthur@arthurfabre.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Lorenzo Bianconi
 <lorenzo@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
 Willem Ferguson <wferguson@cloudflare.com>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
 <aZUPUwYMRNXSg-eI@mini-arch>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <aZUPUwYMRNXSg-eI@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259297-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,arthurfabre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,cloudflare.com,vger.kernel.org,lists.osuosl.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56A9A155BAE
X-Rspamd-Action: no action



On 18/02/2026 02.01, Stanislav Fomichev wrote:
> On 02/17, Lorenzo Bianconi wrote:
>> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
>> checksum will be use by devices capable of exposing receive checksum
>> result via bpf_xdp_metadata_rx_checksum().
>> Moreover, introduce xmo_rx_checksum netdev callback in order to allow
>> the eBPF program bound to the device to retrieve the RX checksum result
>> computed by the hw NIC.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>>   Documentation/netlink/specs/netdev.yaml |  5 +++++
>>   include/net/xdp.h                       | 13 +++++++++++++
>>   include/uapi/linux/netdev.h             |  3 +++
>>   net/core/xdp.c                          | 28 ++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/netdev.h       |  3 +++
>>   5 files changed, 52 insertions(+)
>>
>> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
>> index 596c306ce52b8303b20680ff0cd34d4fd9db0e48..58eda634668a07860447a65d9fc2284839af6244 100644
>> --- a/Documentation/netlink/specs/netdev.yaml
>> +++ b/Documentation/netlink/specs/netdev.yaml
>> @@ -61,6 +61,11 @@ definitions:
>>           doc: |
>>             Device is capable of exposing receive packet VLAN tag via
>>             bpf_xdp_metadata_rx_vlan_tag().
>> +      -
>> +        name: checksum
>> +        doc: |
>> +          Device is capable of exposing receive checksum result via
>> +          bpf_xdp_metadata_rx_checksum().
>>     -
>>       type: flags
>>       name: xsk-flags
>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>> index aa742f413c358575396530879af4570dc3fc18de..00abb2e1e85514b4080d0e4e6e3b8f5f67f73b61 100644
>> --- a/include/net/xdp.h
>> +++ b/include/net/xdp.h
>> @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>>   			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
>>   			   bpf_xdp_metadata_rx_vlan_tag, \
>>   			   xmo_rx_vlan_tag) \
>> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
>> +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
>> +			   bpf_xdp_metadata_rx_checksum, \
>> +			   xmo_rx_checksum)
>>   
>>   enum xdp_rx_metadata {
>>   #define XDP_METADATA_KFUNC(name, _, __, ___) name,
>> @@ -643,12 +647,21 @@ enum xdp_rss_hash_type {
>>   	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
>>   };
>>   
>> +enum xdp_checksum {
>> +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
>> +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
>> +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
>> +};
>> +
>>   struct xdp_metadata_ops {
>>   	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
>>   	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
>>   			       enum xdp_rss_hash_type *rss_type);
>>   	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
>>   				   u16 *vlan_tci);
>> +	int	(*xmo_rx_checksum)(const struct xdp_md *ctx,
>> +				   enum xdp_checksum *ip_summed,
>> +				   u32 *cksum_meta);
>>   };
>>   
>>   #ifdef CONFIG_NET
>> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
>> index e0b579a1df4f2126acec6c44c299e97bbbefe640..d20da430cfd57bc26b5ea2f406c27b48d8a81693 100644
>> --- a/include/uapi/linux/netdev.h
>> +++ b/include/uapi/linux/netdev.h
>> @@ -47,11 +47,14 @@ enum netdev_xdp_act {
>>    *   hash via bpf_xdp_metadata_rx_hash().
>>    * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
>>    *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
>> + * @NETDEV_XDP_RX_METADATA_CHECKSUM: Device is capable of exposing receive
>> + *   checksum result via bpf_xdp_metadata_rx_checksum().
>>    */
>>   enum netdev_xdp_rx_metadata {
>>   	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
>>   	NETDEV_XDP_RX_METADATA_HASH = 2,
>>   	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
>> +	NETDEV_XDP_RX_METADATA_CHECKSUM = 8,
>>   };
>>   
>>   /**
>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>> index fee6d080ee85fc2d278bfdddfd1365633058ec06..7d1e08d8ab4151ab42c91203def2afafc66d3149 100644
>> --- a/net/core/xdp.c
>> +++ b/net/core/xdp.c
>> @@ -961,6 +961,34 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>>   	return -EOPNOTSUPP;
>>   }
>>   
>> +/**
>> + * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
>> + * @ctx: XDP context pointer.
>> + * @ip_summed: Return value pointer indicating checksum result.
>> + * @cksum_meta: Return value pointer indicating checksum result metadata.
>> + *
>> + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
>> + * values are:
>> + * ``XDP_CHECKSUM_NONE``
>> + * ``XDP_CHECKSUM_UNNECESSARY``
>> + * ``XDP_CHECKSUM_COMPLETE``
>> + *
>> + * In case of success, ``cksum_meta`` contains the hw computed checksum value
>> + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
>> + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE``
> 
> The only thing I'm still not sure about is the csum_level and whether
> we need to export it or just start with csum_level=0 and extend later
> when needed. The rest looks good.
> 
> Jesper, Lorenzo mentioned that you might need it? Can you clarify?

At Cloudflare our load-balancer Unimog[1] does GUE (Generic UDP
Encapsulation) when XDP_TX'ing packets to neighboring servers.
Thus, I assume we want to know the csum_level, as this is for
encapsulated packets, right?

Cc Jesse, as he knows more about the hardware and csum_level. To Jesse,
we need to test how hardware handles our GUE packet format (which is
slightly modified).

Cc Arthur + Willem, as they knows the details around how Unimog
currently have to recalc packet checksums in software.  Hopefully this
patchset can help us avoid doing this in some cases.

--Jesper

  [1] 
https://blog.cloudflare.com/unimog-cloudflares-edge-load-balancer/#encapsulation
  [Patch-0/5] 
https://lore.kernel.org/all/20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org/


