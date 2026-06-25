Return-Path: <netdev+bounces-301858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xRUNFpCiPGropwgAu9opvQ
	(envelope-from <netdev+bounces-301858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 05:37:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5F86C298E
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 05:37:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=uUz9NM0r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301858-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301858-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D678300ADA7
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6F72C0303;
	Thu, 25 Jun 2026 03:37:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B120E702
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 03:37:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782358666; cv=none; b=pvRsQOAQ28nlVx+aORUI2dX1cB8W0iaj3AtMdYuqYLP5NwJwEqWEgf0WU65DLiwK9uxSdWG+goV0yBUFI7WEg/n9XLjTO3w1EoMNwfhlSJRbX07ovsOCps+wEpdKJdtmx5MTJxwf+D2LEgYlB43Yhbfk1pfoSNtT3rnG3ZA3UYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782358666; c=relaxed/simple;
	bh=yNSdL2jeXaw2zEU4y1EU+2q083XD+wgFTn/Us9DKqYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnbFzH0NXRSn+a0nABdeMu6UGXus3Q5uq0bAGOkQF9PGRKh9GCPjgWixy4HEnYxuEknBgBq+cK9m0/DVtlfixz4GOeJG9NiX7xVNzVt6eAs3pyYjqp6imT0Qsg11nX0C66lYRkni7DARnTGCJ+YVF7O/xvIr3thKXbhkNVuJlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uUz9NM0r; arc=none smtp.client-ip=91.218.175.178
Message-ID: <184b1d3c-a9cd-436a-b2b2-c5bac488859b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782358662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLC4woZWpOCsOMgiHjNXcQjJ+5Cp5MOUCJPQZtPdNEA=;
	b=uUz9NM0rIBIUkVy0lZ1yq98dfh9Bb4qcQ/qVXyjzQ9uTOBV8xI7sySzY7waZ3kGlQn/BPu
	4p+WvsJZCP1DHHztVdGkwAM8rCn/2WNxv3aUhlGjZ0hWcb1+vpyhN8eI5raWTgHQU2w/0N
	+a61XEi7DRYZlT2/+aXrAMHnLyolTlA=
Date: Thu, 25 Jun 2026 11:37:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Support BPF_F_EGRESS with
 bpf_redirect_peer
To: Jordan Rife <jordan@jrife.io>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev
 <sdf@fomichev.me>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Paul Chaignon <paul.chaignon@gmail.com>
References: <20260618182035.43811-1-jordan@jrife.io>
 <20260618182035.43811-2-jordan@jrife.io>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260618182035.43811-2-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301858-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jordan@jrife.io,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,m:paul.chaignon@gmail.com,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,jrife.io:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A5F86C298E


On 6/19/26 2:20 AM, Jordan Rife wrote:
> We have several use cases where a pod injects traffic into the datapath
> of another so that the traffic appears to have originated from that
> pod. One such use case is a synthetic flow generator which injects
> synthetic traffic into a pod's datapath to enable dynamic probing and
> debugging. Another is a transparent proxy where connections originating
> from one pod are redirected towards another which proxies that
> connection. The new connection is bound to the IP of the original pod
> using IP_TRANSPARENT and its traffic is injected into that pod's
> datapath and handled as if it had originated there. This can be used for
> mTLS, etc.
>
[...]
>
>    [ ID] Interval           Transfer     Bitrate         Retr
>    [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
>    [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver
>
> In this test, using bpf_redirect_peer(BPF_F_EGRESS) for the hop from
> [iperf pod] to [pod b] led to ~18% more throughput compared to
> bpf_redirect(BPF_F_INGRESS).
>
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>   include/uapi/linux/bpf.h       | 19 +++++++++++--------
>   net/core/filter.c              | 12 +++++++-----
>   tools/include/uapi/linux/bpf.h | 19 +++++++++++--------
>   3 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 89b36de5fdbb..c91b5a4bda03 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5079,17 +5079,19 @@ union bpf_attr {
>    * 	Description
>    * 		Redirect the packet to another net device of index *ifindex*.
>    * 		This helper is somewhat similar to **bpf_redirect**\ (), except
> - * 		that the redirection happens to the *ifindex*' peer device and
> - * 		the netns switch takes place from ingress to ingress without
> - * 		going through the CPU's backlog queue.
> + * 		that the redirection happens to the *ifindex*' peer device. If
> + * 		*flags* is 0, the netns switch takes place from ingress to
> + * 		ingress without going through the CPU's backlog queue. If the
> + * 		**BPF_F_EGRESS** flag is provided then redirection happens in
> + * 		the egress direction of the peer device.
>    *
>    * 		*skb*\ **->mark** and *skb*\ **->tstamp** are not cleared during
>    * 		the netns switch.
>    *
> - * 		The *flags* argument is reserved and must be 0. The helper is
> - * 		currently only supported for tc BPF program types at the
> - * 		ingress hook and for veth and netkit target device types. The
> - * 		peer device must reside in a different network namespace.
> + * 		If the *flags* argument is 0, the helper is currently only
> + * 		supported for tc BPF program types at the ingress hook and for
> + * 		veth and netkit target device types. The peer device must reside
> + * 		in a different network namespace.
>    * 	Return
>    * 		The helper returns **TC_ACT_REDIRECT** on success or
>    * 		**TC_ACT_SHOT** on error.
> @@ -6336,9 +6338,10 @@ enum {
>   /* Flags for bpf_redirect and bpf_redirect_map helpers */
>   enum {
>   	BPF_F_INGRESS		= (1ULL << 0), /* used for skb path */
> +	BPF_F_EGRESS		= (1ULL << 1), /* used for skb path */
>   	BPF_F_BROADCAST		= (1ULL << 3), /* used for XDP path */
>   	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4), /* used for XDP path */
> -#define BPF_F_REDIRECT_FLAGS (BPF_F_INGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
> +#define BPF_F_REDIRECT_FLAGS (BPF_F_INGRESS | BPF_F_EGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
>   };
>   

Thanks, BPF_F_EGRESS is clearer.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


