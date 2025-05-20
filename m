Return-Path: <netdev+bounces-191888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033DFABD9B4
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D6E173DB5
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CA242D78;
	Tue, 20 May 2025 13:37:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78249242D75;
	Tue, 20 May 2025 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748279; cv=none; b=saxMk6o2tl6Ut6x5F0TwrIyxmYhDEJ1Qt3s9KrKuY7Pq1ifgk1HtjRca4whzhKR54wHQHsvsY8Eh2UpfTRAzigPo7JJ/XRneqTzluvLaLSjxVMGQiTJIRr0teyXEh+61TKNXMvaTTsumjccAjqdGWcKI7Eri0MSG7ctaHgYqPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748279; c=relaxed/simple;
	bh=lJ1O6hVAeYCq3TjoW7lWKxUkpMal0DDl5preTzMeYRs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s4YF8iKcOaOrCVG1nSugAdgUpg1/0BryXSIJO05Jn53m7c88Fxo3Ai8oZkkN1OYK3VAdVntu74HcmLHJ5/JHNCM4LgjSNRJDLbfMeDRzEz3ewPdp7PBfvfEYfgXe3aM0nan+YAFdHMoJW7S4ELvyTHCakO4bF/Wko9MVBAnF6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a374f727dbso1387404f8f.0;
        Tue, 20 May 2025 06:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747748275; x=1748353075;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzKeHLvkldBBNWFlV3J1PWGfZydBkzACibJG9mKAtK8=;
        b=ZNgCxddjO6V8b2oXq1FlRsoNmdhGO3IDGVDc22z16CeIxPtikW5VxdCrVRC9ZtpXln
         fKq1+Lhq8DMxlQc+5BwsxHh0zPTb6D5q+fM2mu3Q7c5kVg3PJ/4p6h1CFLODA+spY6uG
         NCDNBujVd+tXd9qoEz5ymKaaBvAo0LQNV4RII9nlY/uWvw8igfOXWlKG/XnQOx0j+eE2
         tQp4cK9ees2i4+9Cc0t8MuH2lLO54vPOUvzPaxuwIKWGB9jdiEgXydwdZnS25XLwDYmt
         GVPba1y7/Q1PzxLU3IMyhpZl/x7xKXuaO6zjuCf/XN8NghDa+1oH5qrMBrCPwOfciGqx
         Uorg==
X-Forwarded-Encrypted: i=1; AJvYcCVnuhHpeXgnMOrjlGEDI9C2deo76U58S++qALjGPNUNQsldFOypaJ1CAzrXfVi0TqH1RKU3UbhW@vger.kernel.org, AJvYcCXc4hP6pqq0PVK3V9JiQNxx6lLIL2r42jvgy7fcy+EjMKg6ZashR7Ug6hMOzhjqwIWOLICgI8uUMuN4Z6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAB2bnDD+UxTmsKmGmheQ6ZZPvndTU4rb1i4TMckvJ+GKbB6A1
	krqiPYeumFHuWq44hq4mR3LlHRXYLsrAVgucyjN95QJetMcnKTnHuJEm
X-Gm-Gg: ASbGncsvLSi3HM1betu2YaX41uVCU56yWIaZDBljPtzRv0b/Boy373npPhStFS+Vhle
	XbFEpYSB9f80b+rN0aDhSr2IXjlpUlhjPcJ8hgOdzDKNRBFHVfG++so1r+unHrfU4Izc4YjlxH5
	CJglbPrtsMqhgXrAYnOaJ5GDxpNzZ3IV+cGgRjPyCieim52xhiDmznTpejgTNQii7LGPx0Qew3C
	mraAGqLnyXFgvXx9pmIYRpPVant74umi2eNGCyftFCZL3GU5Y0XEAQT4AJCcf43Put2uLv/d9K9
	TPJzIEAc/+0UfSVsfU+XRhDkxVOYQ4dWDZ78VKL/14hIh80b5F9PxmXvZyLDXdw+vGXUfDh82pO
	sgZpykUS68RFsyrMoqiTvBJNKKN0w
X-Google-Smtp-Source: AGHT+IGuUEXch/PCRoEM7ilkwD1/obd0T/A0zeMUHdVyeq/0l5jufLqdeNGlQ47tnwFhhrk/9LjIVA==
X-Received: by 2002:a05:6000:2407:b0:3a1:fcd3:a788 with SMTP id ffacd0b85a97d-3a3600dba61mr15218095f8f.48.1747748275145;
        Tue, 20 May 2025 06:37:55 -0700 (PDT)
Received: from [192.168.88.252] (194-212-160-119.customers.tmcz.cz. [194.212.160.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1825457sm33261655e9.1.2025.05.20.06.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 06:37:54 -0700 (PDT)
Message-ID: <c7d27849-f48b-4c85-bcd9-5d2206856abd@ovn.org>
Date: Tue, 20 May 2025 15:37:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, "aconole@redhat.com" <aconole@redhat.com>,
 "echaudro@redhat.com" <echaudro@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dev@openvswitch.org" <dev@openvswitch.org>
Subject: Re: [PATCH] net: openvswitch: Fix the dead loop of MPLS parse
To: Faicker Mo <faicker.mo@zenlayer.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ovs-dev@openvswitch.org" <ovs-dev@openvswitch.org>
References: <20250520032654.2453312-1-heapbin2@gmail.com>
 <SJ0PR20MB60791551365A54151B195E44FA9FA@SJ0PR20MB6079.namprd20.prod.outlook.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <SJ0PR20MB60791551365A54151B195E44FA9FA@SJ0PR20MB6079.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/20/25 6:13 AM, Faicker Mo wrote:
> The unexpected MPLS packet may not end with the bottom label stack.
> When there are many stacks, The label count value has wrapped around.
> A dead loop occurs, soft lockup/CPU stuck finally.
> 
> stack backtrace:
> UBSAN: array-index-out-of-bounds in /build/linux-0Pa0xK/linux-5.15.0/net/openvswitch/flow.c:662:26
> index -1 is out of range for type '__be32 [3]'
> CPU: 34 PID: 0 Comm: swapper/34 Kdump: loaded Tainted: G           OE   5.15.0-121-generic #131-Ubuntu
> Hardware name: Dell Inc. PowerEdge C6420/0JP9TF, BIOS 2.12.2 07/14/2021
> Call Trace:
>  <IRQ>
>  show_stack+0x52/0x5c
>  dump_stack_lvl+0x4a/0x63
>  dump_stack+0x10/0x16
>  ubsan_epilogue+0x9/0x36
>  __ubsan_handle_out_of_bounds.cold+0x44/0x49
>  key_extract_l3l4+0x82a/0x840 [openvswitch]
>  ? kfree_skbmem+0x52/0xa0
>  key_extract+0x9c/0x2b0 [openvswitch]
>  ovs_flow_key_extract+0x124/0x350 [openvswitch]
>  ovs_vport_receive+0x61/0xd0 [openvswitch]
>  ? kernel_init_free_pages.part.0+0x4a/0x70
>  ? get_page_from_freelist+0x353/0x540
>  netdev_port_receive+0xc4/0x180 [openvswitch]
>  ? netdev_port_receive+0x180/0x180 [openvswitch]
>  netdev_frame_hook+0x1f/0x40 [openvswitch]
>  __netif_receive_skb_core.constprop.0+0x23a/0xf00
>  __netif_receive_skb_list_core+0xfa/0x240
>  netif_receive_skb_list_internal+0x18e/0x2a0
>  napi_complete_done+0x7a/0x1c0
>  bnxt_poll+0x155/0x1c0 [bnxt_en]
>  __napi_poll+0x30/0x180
>  net_rx_action+0x126/0x280
>  ? bnxt_msix+0x67/0x80 [bnxt_en]
>  handle_softirqs+0xda/0x2d0
>  irq_exit_rcu+0x96/0xc0
>  common_interrupt+0x8e/0xa0
>  </IRQ>
> 
> Signed-off-by: Faicker Mo <faicker.mo@zenlayer.com>
> ---
>  net/openvswitch/flow.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 8a848ce72e29..834b1b9110ac 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -805,6 +805,8 @@ static int key_extract_l3l4(struct sk_buff *skb, struct sw_flow_key *key)
>                         if (label_count <= MPLS_LABEL_DEPTH)
>                                 memcpy(&key->mpls.lse[label_count - 1], &lse,
>                                        MPLS_HLEN);
> +                       else if (unlikely(label_count == 255))
> +                               return 0;
> 
>                         skb_set_inner_network_header(skb, skb->mac_len +
>                                                      label_count * MPLS_HLEN);
> --
> 2.34.1
> 

One other thing,

For some reason the patch was not delivered to lore.kernel.org
and is not available in netdev+bpf patchwork and not in lkml.org.
Both of our replies are available in list archives.  The original
email is available only via mail-archive, but it is ovs-dev and
not the netdev list:
  https://www.mail-archive.com/ovs-dev@openvswitch.org/msg94895.html
Same for v2.

Is kernel.org blocking the sender somehow?  Does anyone know?

Best regards, Ilya Maximets.

