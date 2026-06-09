Return-Path: <netdev+bounces-297219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /yxaHhhUKGoNCQMAu9opvQ
	(envelope-from <netdev+bounces-297219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E396631ED
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:57:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l9Tu4E46;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297219-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297219-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 192FA30B53BF
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB063C1090;
	Tue,  9 Jun 2026 17:51:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D73331EAE;
	Tue,  9 Jun 2026 17:51:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027469; cv=none; b=Z79vn4IOUFLkVeUvWQIh5KTRQVR0f4UVn0dw8nz5YqpxkJejWo0eBw5H2G6veKFIIn9DVn0HKFFRXsoAm5G47HEkr/DpUOhjklD/5JfHSsuY0egViRykjbq+zEQmOo/EsVYdfzponyhN2MAlYFn35Ltt09rrwT0cQ4pDf0sugMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027469; c=relaxed/simple;
	bh=MHSrLwUeLOfYLkwPcrWffBG0d8LBYSrvwS+e7ygv0cM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f+LiV+S+k69vfc+HKy32pfsV2w5uz9E9cx4UDcim9D59p0fI+Gfcx7SIQCbleP8UupnXedTODuPP5G5XH2z2X25SK7xBZa9/K01ec8DapCLFOQg7fEc8s/PolzRkG4w/9abHWBIsjjqw1hr9Nt6AY7KN8GhQHbpsTTW4N9Nf1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9Tu4E46; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B381F00893;
	Tue,  9 Jun 2026 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027467;
	bh=cFXAfTPwn5puZHl7L/GydstH0PobxJJd7HC+8+4WE30=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=l9Tu4E46gqjGAwhuTOUnqz5NbqW4G+Njutq0In/8eTz1yIOmG3VoXviWZkUsIcKOv
	 kHj6TkbCqZQCaXXX6JKD0yuvuYa4Wtp8+4jpbaoe2nmpmAp5AQwC6DrSsZLwkO3hcC
	 7tW6yj4WCfanHVD3T/YaJwJohiZ4qdKiwnu7ej48tdUKa4kdd+PL/nGcoVKk1ac43o
	 +Ey8R6rBCXNKhkzghrz1JgEZ34fcnBdMWL8m8BtlRLg+VDPhQvLFJCSrLHgw+xMP+c
	 RR/5ts/wHSKOP+E45fQE1P7w+jm+YC1sNX37hx2QTFN7hKyDLF/b/Rw0yOT5tiDU0a
	 O2MW9iQcCofOw==
Content-Type: multipart/mixed; boundary="===============4493727351168416969=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d8b1da1af69842d46dd4a02216a183e8ba611a2af4ca07ed4c2c7957be4698cc@mail.kernel.org>
In-Reply-To: <20260609172052.81613-1-avinash.duduskar@gmail.com>
References: <20260609172052.81613-1-avinash.duduskar@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
From: bot+bpf-ci@kernel.org
To: avinash.duduskar@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,hawk@kernel.org,kpsingh@kernel.org,toke@redhat.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 17:51:07 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-297219-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,davemloft.net,google.com,redhat.com,vger.kernel.org,iogearbox.net,meta.com];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:hawk@kernel.org,m:kpsingh@kernel.org,m:toke@redhat.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04E396631ED

--===============4493727351168416969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 11dd610fa5fa..aa7fe378a35d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714..782fa86df95a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6119,10 +6119,28 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
>  #endif
>
>  #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
> -static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
> +static int bpf_fib_set_fwd_params(struct net_device *dev,
> +				  struct bpf_fib_lookup *params,
> +				  u32 flags, u32 mtu)
>  {
>  	params->h_vlan_TCI = 0;
>  	params->h_vlan_proto = 0;
> +
> +	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
> +		struct net_device *real_dev = vlan_dev_real_dev(dev);

Does this correctly handle stacked VLANs (QinQ)? Both the commit message
and the inline comment below mention that stacked VLANs are not walked and
only the immediate parent is resolved.

However, looking at the implementation of vlan_dev_real_dev() in
net/8021q/vlan_core.c:

const struct net_device *vlan_dev_real_dev(const struct net_device *dev)
{
    while (is_vlan_dev(dev))
        dev = vlan_dev_priv(dev)->real_dev;
    return dev;
}

It appears vlan_dev_real_dev() loops through all stacked VLANs to return
the ultimate non-VLAN underlying device.

If the configuration is QinQ, wouldn't this set params->ifindex to the base
physical device while only returning the topmost VLAN tag in
params->h_vlan_TCI? This could cause an XDP program to push only a single
tag and drop the intermediate VLAN tags, bypassing the outer VLAN entirely.

Should this use vlan_dev_priv(dev)->real_dev instead to only get the
immediate parent as intended?

> +
> +		/* Only the immediate parent is resolved; stacked VLANs

This isn't a bug, but the comment style here differs from BPF subsystem
guidelines. The opening /* has comment text on the same line, but the BPF
comment style prefers the opening /* on its own line with text starting
on the next line.

> +		 * (QinQ) are not walked, and a NULL real_dev (which
> +		 * is_vlan_dev() rules out in practice) keeps the
> +		 * original ifindex.
> +		 */
> +		if (real_dev) {
> +			params->h_vlan_proto = vlan_dev_vlan_proto(dev);
> +			params->h_vlan_TCI = htons(vlan_dev_vlan_id(dev));
> +			params->ifindex = real_dev->ifindex;
> +		}
> +	}
> +
>  	if (mtu)
>  		params->mtu_result = mtu; /* union with tot_len */
>
> @@ -6265,7 +6283,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>  	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
>
>  set_fwd_params:
> -	return bpf_fib_set_fwd_params(params, mtu);
> +	return bpf_fib_set_fwd_params(dev, params, flags, mtu);
>  }
>  #endif

[ ... ]

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 11dd610fa5fa..aa7fe378a35d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27223878961
--===============4493727351168416969==--

