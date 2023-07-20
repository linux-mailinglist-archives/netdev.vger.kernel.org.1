Return-Path: <netdev+bounces-19675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D274E75B9ED
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA051C2029D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2341BE9C;
	Thu, 20 Jul 2023 21:59:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40E168C3
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:59:01 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C468B3
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:59:00 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55ac8fcc887so662803a12.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689890340; x=1690495140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivp1TBnd1/v0oKmUsvkQtIucEL7zSFDmhW7hv5CZdSE=;
        b=bWs4BZZ3m4K2zmKM84WnDVPczXKXUyoQbP6+eskzSCyz31t95wHTQt147Fw7Ywrdpe
         rrc7zoE0IYfuSfDaye8tZ3HzdexMisi8gE0f+TjpB6YS0wT5IlyQkFA/Vn2y3YyBfmY/
         n/v+WKlwa30egyzHT6JoDsBWt6iIWzVDpOqr2giYATPamecQvOA4O/6mYt/v1ktFEvQo
         t6JSLaZ2ZMXPLY3b3j7OJdUHSw44b9JpgoHwZyL7V9xqmm14VK1gnKnq8npUZTJMxg5j
         AoMiYQ6zzuscmxRQ6DAoxqmvGw/NncACnK7EsiAwNxu3C9RcD6C0vebGv/ibtGOX/Teo
         MIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689890340; x=1690495140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivp1TBnd1/v0oKmUsvkQtIucEL7zSFDmhW7hv5CZdSE=;
        b=azRR5B8WfdqPe142UxmRUv2q+JmoHAlFeahudYRCIzcFrhvYuXMaG2ESYxg9Xkf8X2
         urdWbUv4rbIOmzZZ8vg/pRXkz2mgFSJf743/KTfA2BKQonI4ejC0EnmeCpFSw8vd4t92
         IrZ9IWoU8+xOYEiPaIOd7tj7KjIAAylCd+n3qGCAaE0YOBjY4RoV3k2DJTrwVHC2s4GL
         S1RfVZEUEyFnJsRvvQzeJgwaHzFyoZCRXKPe1pXtOcs//U5quz//5WbYwO/0YwjJ5nmX
         MShNPnsVynP5QkhN9OVa7UqeKC+QMDhajpV6Z/8NrtdyWDwyUrC9zVZRTTS37btqnsWy
         JIrQ==
X-Gm-Message-State: ABy/qLYBn/dRHx17QDjOKrpnM6th+5k50vRjRD4PsOw5ySMyQji+ikhe
	5Q43V0fPfmrN+fsWD/sG5ng/+so=
X-Google-Smtp-Source: APBJJlG/BmoDsdKv6D4hJ7EFRM2hqK7fNtNz1zIBvbPMMkks4eL22Y9O2fOri4s57vaA8eh50zWuKNE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7942:0:b0:542:c9ed:b with SMTP id
 u63-20020a637942000000b00542c9ed000bmr35418pgc.7.1689890339748; Thu, 20 Jul
 2023 14:58:59 -0700 (PDT)
Date: Thu, 20 Jul 2023 14:58:58 -0700
In-Reply-To: <20230719183734.21681-15-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719183734.21681-1-larysa.zaremba@intel.com> <20230719183734.21681-15-larysa.zaremba@intel.com>
Message-ID: <ZLmuIqf/PXnUZ6/F@google.com>
Subject: Re: [PATCH bpf-next v3 14/21] selftests/bpf: Allow VLAN packets in xdp_hw_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/19, Larysa Zaremba wrote:
> Make VLAN c-tag and s-tag XDP hint testing more convenient
> by not skipping VLAN-ed packets.
> 
> Allow both 802.1ad and 802.1Q headers.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  tools/testing/selftests/bpf/progs/xdp_hw_metadata.c | 10 +++++++++-
>  tools/testing/selftests/bpf/xdp_metadata.h          |  8 ++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> index b2dfd7066c6e..63d7de6c6bbb 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -26,15 +26,23 @@ int rx(struct xdp_md *ctx)
>  {
>  	void *data, *data_meta, *data_end;
>  	struct ipv6hdr *ip6h = NULL;
> -	struct ethhdr *eth = NULL;
>  	struct udphdr *udp = NULL;
>  	struct iphdr *iph = NULL;
>  	struct xdp_meta *meta;
> +	struct ethhdr *eth;
>  	int err;
>  
>  	data = (void *)(long)ctx->data;
>  	data_end = (void *)(long)ctx->data_end;
>  	eth = data;
> +
> +	if (eth + 1 < data_end && (eth->h_proto == bpf_htons(ETH_P_8021AD) ||
> +				   eth->h_proto == bpf_htons(ETH_P_8021Q)))
> +		eth = (void *)eth + sizeof(struct vlan_hdr);
> +
> +	if (eth + 1 < data_end && eth->h_proto == bpf_htons(ETH_P_8021Q))
> +		eth = (void *)eth + sizeof(struct vlan_hdr);
> +
>  	if (eth + 1 < data_end) {
>  		if (eth->h_proto == bpf_htons(ETH_P_IP)) {
>  			iph = (void *)(eth + 1);
> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
> index 938a729bd307..6664893c2c77 100644
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> @@ -9,6 +9,14 @@
>  #define ETH_P_IPV6 0x86DD
>  #endif
>  
> +#ifndef ETH_P_8021Q
> +#define ETH_P_8021Q 0x8100
> +#endif
> +
> +#ifndef ETH_P_8021AD
> +#define ETH_P_8021AD 0x88A8
> +#endif
> +
>  struct xdp_meta {
>  	__u64 rx_timestamp;
>  	__u64 xdp_timestamp;
> -- 
> 2.41.0
> 

