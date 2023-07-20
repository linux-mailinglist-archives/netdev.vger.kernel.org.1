Return-Path: <netdev+bounces-19678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A174C75BA3E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 00:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BB01C21593
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 22:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83B1DDD0;
	Thu, 20 Jul 2023 22:03:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007362FA49
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 22:03:00 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607B21B6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:02:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57704a25be9so22232707b3.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689890578; x=1690495378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=206RntJl5N4S3vyqz152CXiY4g52GnK3+N2rFMZD3P0=;
        b=K1+jILZpfkoO5Im0HytBfUxM8f/T2D2oeCcTa465luZQc4AJcA82UvxtwIgErC7U5h
         F1OJqlPCdIxpTJhkA/6rX0c/lqmn/KA35KppVsJScvOyHkrVdQTt0S2lEbpqLPOZJ23L
         PzqW3uZlT/FeXlKfEGFH9vpWxwhOsKq4x9rx4x8ZYif+i1XO/R7CWgQmWqjzkWADMKiN
         uJzwlumLqrS0kDj1T4FIQKzRA6Z8hcsICigUrDcvvpAyE6EJT3KDH0pO8+81z5J61+NB
         B/fRSjL6R92cu7QklMNwqdeOea4B7H1fCf6rlWyf/z0OUTG9Z8nbEFZDfeEmhONs7cbC
         vr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689890578; x=1690495378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=206RntJl5N4S3vyqz152CXiY4g52GnK3+N2rFMZD3P0=;
        b=BqKrKpGX6G8qHho2ScKOyKTIFJwpT7hLq5fcuJcvNvncrSbj0lMWgklzl1yZTbXHUH
         Nhd+SFXqByfY3Vr357izi+KHZ86mlT2yi05nmNkb85AG/BUjhevyLmwvZ4UmiNTWJxf3
         EllFc1XbfiMjR6Yc+zanwRJ8H9xcSC6Q+CQQtiaXFir4tdxE5qMm6slr1ZZPoVjVFPZ0
         RaU+Z/ogTnGqOSI8vIodWJ6WTn2+2+nLXc9aDzcDAvJwbhPoTnWY4DcB79RyrocYtEkp
         V5tYFjokFKhb6NMyHs0fXg1Mkgg3MRdB0ORFk3iozjTYdKAgaYe6XhfAomE1OX2j0hlC
         H/Hg==
X-Gm-Message-State: ABy/qLb/EsNQJZw9bWIB9ndfTIGVuIQ/FuvW3gQB718CSeijDhHA5IiF
	6w696yXqeyxTKBvaqJonjQ47K5Q=
X-Google-Smtp-Source: APBJJlGm4vXVIxoGX5PWiF+DOWtPFnx7UP3a09t0TTvXwG763koFsoHomxnwaRChpn0H98yPlIe6Q9I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:b652:0:b0:56d:19ce:416c with SMTP id
 h18-20020a81b652000000b0056d19ce416cmr91956ywk.0.1689890578683; Thu, 20 Jul
 2023 15:02:58 -0700 (PDT)
Date: Thu, 20 Jul 2023 15:02:57 -0700
In-Reply-To: <20230719183734.21681-19-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719183734.21681-1-larysa.zaremba@intel.com> <20230719183734.21681-19-larysa.zaremba@intel.com>
Message-ID: <ZLmvESUU0Gt5HgKU@google.com>
Subject: Re: [PATCH bpf-next v3 18/21] net: make vlan_get_tag() return
 -ENODATA instead of -EINVAL
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <jbrouer@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/19, Larysa Zaremba wrote:
> __vlan_hwaccel_get_tag() is used in veth XDP hints implementation,
> its return value (-EINVAL if skb is not VLAN tagged) is passed to bpf code,
> but XDP hints specification requires drivers to return -ENODATA, if a hint
> cannot be provided for a particular packet.
> 
> Solve this inconsistency by changing error return value of
> __vlan_hwaccel_get_tag() from -EINVAL to -ENODATA, do the same thing to
> __vlan_get_tag(), because this function is supposed to follow the same
> convention. This, in turn, makes -ENODATA the only non-zero value
> vlan_get_tag() can return. We can do this with no side effects, because
> none of the users of the 3 above-mentioned functions rely on the exact
> value.
> 
> Suggested-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  include/linux/if_vlan.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
> index 6ba71957851e..fb35d7dd77a2 100644
> --- a/include/linux/if_vlan.h
> +++ b/include/linux/if_vlan.h
> @@ -540,7 +540,7 @@ static inline int __vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
>  	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
>  
>  	if (!eth_type_vlan(veth->h_vlan_proto))
> -		return -EINVAL;
> +		return -ENODATA;
>  
>  	*vlan_tci = ntohs(veth->h_vlan_TCI);
>  	return 0;
> @@ -561,7 +561,7 @@ static inline int __vlan_hwaccel_get_tag(const struct sk_buff *skb,
>  		return 0;
>  	} else {
>  		*vlan_tci = 0;
> -		return -EINVAL;
> +		return -ENODATA;
>  	}
>  }
>  
> -- 
> 2.41.0
> 

