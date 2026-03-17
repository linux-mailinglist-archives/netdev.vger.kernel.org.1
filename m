Return-Path: <netdev+bounces-268525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHeeETgluWm1sQEAu9opvQ
	(envelope-from <netdev+bounces-268525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:56:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE4E2A7595
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C8A130D55CF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A613A0B2D;
	Tue, 17 Mar 2026 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjAmoTJC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783439D6D9;
	Tue, 17 Mar 2026 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740994; cv=none; b=gh5LCLKKEYE3CmTu8CVhCSR1ac+hlMj+BxoNwINAyIOAhtc4nhvnv8Jxx0OunhCF9H5mzO68OyDMoH5a0n0Fr2/RAoC4CnXgXRa3duhMvckzOsYEjUZWyid/C+EtSFecTrtI0zerVozjyF2+jpZ3nkGKs3qsEUzt18NBzgzqr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740994; c=relaxed/simple;
	bh=Y37P4OdefzXCY9joMqOUrRnFRWZPXLodPfge2HEhFEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWw52LzJIt8b9prCbhkjLYoAYus66TOCYZ/xlZNjiEyan2fd7kt1xjbj4utwfeoZHntWnCAE5T4K2/nw2OwpSSUcUcOvbY3U2Tpvm2aXgBi2zTEUex/yL2C8Z5QXdhs9rjqkQUB4gLQky3CDS13v5i0y4a4X5KUC4aA7rNkcvFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjAmoTJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEC9C4CEF7;
	Tue, 17 Mar 2026 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740993;
	bh=Y37P4OdefzXCY9joMqOUrRnFRWZPXLodPfge2HEhFEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mjAmoTJC6USk8SekAtF8SLRTp1QiZRLQqpVDJaLpzUVOpG6VwUb+5ibGwtGB/x8lH
	 N7OYw01V/jjNLgXWzhv1iWS19CoIxJ0XTaNuFmMzzmzR/cP8Wq9Ww2wrQLaFhpuqrO
	 JJ0xmyDLdRip83l9ur+Ahi/o9Us1w/Zf/BxSlar1Xg6RhSIidUGcBsWiuee2N9VffB
	 mY9hV92Fv9EBMfezkkdxwNp6brgFwvGNb790meJr1T/NRCz69CWNGuFQ3w8NAK+zqx
	 i/TFwty4RI5wmBDq2iLpx1S6dM2vs04HSp+k/30oQfa/xpW9gbv70HYTfHGPMRLCqw
	 O3+T5FJKNPYBw==
Message-ID: <e8f25a5f-940b-4b89-8a88-ef984bd78238@kernel.org>
Date: Tue, 17 Mar 2026 10:49:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/6] selftests: drv-net: xdp: Add rss_hash
 metadata tests
To: Chris J Arges <carges@cloudflare.com>, Joe Damato <joe@dama.to>,
 Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Petr Machata <petrm@nvidia.com>, David Wei <dw@davidwei.uk>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Carolina Jubran <cjubran@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
 Gal Pressman <gal@nvidia.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
References: <20260313223029.454755-1-carges@cloudflare.com>
 <20260313223029.454755-7-carges@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260313223029.454755-7-carges@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268525-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[cloudflare.com,dama.to,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,nvidia.com,davidwei.uk,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,cloudflare.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DE4E2A7595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 13/03/2026 23.27, Chris J Arges wrote:
> diff --git a/tools/testing/selftests/net/lib/xdp_metadata.bpf.c b/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
> new file mode 100644
> index 000000000000..f71f59215239
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stddef.h>
> +#include <linux/bpf.h>
> +#include <linux/in.h>
> +#include <linux/if_ether.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
> +#include <linux/udp.h>
> +#include <linux/tcp.h>
> +#include <bpf/bpf_endian.h>
> +#include <bpf/bpf_helpers.h>
> +
> +enum {
> +	XDP_PORT = 1,
> +	XDP_PROTO = 4,
> +} xdp_map_setup_keys;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 5);
> +	__type(key, __u32);
> +	__type(value, __s32);
> +} map_xdp_setup SEC(".maps");
> +
> +/* RSS hash results: key 0 = hash, key 1 = hash type,
> + * key 2 = packet count, key 3 = error count.
> + */
> +enum {
> +	RSS_KEY_HASH = 0,
> +	RSS_KEY_TYPE = 1,
> +	RSS_KEY_PKT_CNT = 2,
> +	RSS_KEY_ERR_CNT = 3,
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +	__uint(max_entries, 4);
> +} map_rss SEC(".maps");
> +
> +/* Mirror of enum xdp_rss_hash_type from include/net/xdp.h.
> + * Needed because the enum is not part of UAPI headers.

It is on purpose that enum is not part of UAPI headers, because BPF
progs (like this) are suppose to handle this via CO-RE.

Asking CO-RE experts (e.g. Cc Andrii), will below enum xdp_rss_hash_type
usage automatically get relocated by libbpf, based on running kernel?
(or do we need some explicit bpf_core_ calls?)

> + */
> +enum xdp_rss_hash_type {
> +	XDP_RSS_L3_IPV4 = 1U << 0,
> +	XDP_RSS_L3_IPV6 = 1U << 1,
> +	XDP_RSS_L3_DYNHDR = 1U << 2,
> +	XDP_RSS_L4 = 1U << 3,
> +	XDP_RSS_L4_TCP = 1U << 4,
> +	XDP_RSS_L4_UDP = 1U << 5,
> +	XDP_RSS_L4_SCTP = 1U << 6,
> +	XDP_RSS_L4_IPSEC = 1U << 7,
> +	XDP_RSS_L4_ICMP = 1U << 8,
> +};

--Jesper

