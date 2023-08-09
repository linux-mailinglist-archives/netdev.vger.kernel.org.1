Return-Path: <netdev+bounces-26027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B293F77697F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE34281D97
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A82452B;
	Wed,  9 Aug 2023 20:09:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483A24505
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:09:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7FB10CF
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691611756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UI4MpUxYa7asPwT6vRagp+E5hi0tX/TsRpk9l93Frc=;
	b=QzLl61czWIXjb1LTJxscs7sAazeC19X6qw2q7jiBjfK1oLBlru3+qbaFljMMIB0NFn66GR
	snvYXKk8FxXOv3lUk7FBHNnZI6rLO9BPlT0zGUYegUoaxzco2G+IHzhNyIKZpg8MBVjHZT
	XXr9Ush7UKbnfCl34zuoKHbRlU4mm5Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-dUdx7NyAP1a68OyJGPyb_A-1; Wed, 09 Aug 2023 16:09:14 -0400
X-MC-Unique: dUdx7NyAP1a68OyJGPyb_A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-523400c3638so69786a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 13:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611753; x=1692216553;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UI4MpUxYa7asPwT6vRagp+E5hi0tX/TsRpk9l93Frc=;
        b=SstimV4Sb9GmqDf10C5wTieP22K1bIHhkJxUbO6WHUnCt44A7bMGgiF/SwzVjHsM9v
         Lad6rSepaiqWctnvMnk7njUseS/Hop6mMLYqTREyl95svAb5rDI9GHDU/yuCYowqc02f
         MZWBsqXtJ6xCEVA3F5GK8yqlyOUDdbj8oUoub27U0uXRcw85wILG4ouTVgDF37W8NtSh
         FHJOyfuBW3h4CMmNlderduKbjKagCnAAQyrPrJYl4oQSJabueOG8Fl3NiYG7SiHoAMNI
         1MmQurpEarxLP3rN2K8quk9JsK0bnM29sI7qli/Rg9lw5G+p7tLNM5m1W33pghJff4eT
         TjVg==
X-Gm-Message-State: AOJu0YymvkQoLQxFTrJFyCDgVVuuwqJb7miJw4FSSoZnAlAyY/iiZQRq
	3/tVN3LgZ2PTe+DMiYLRLVNnPLmdUbTesY1nYbNpl0PAZGL5DA9MQbzYVvqb462nSYbN3A5cztL
	nCtwxY8Nmp+FLdisE
X-Received: by 2002:aa7:ce0d:0:b0:523:2e0e:5462 with SMTP id d13-20020aa7ce0d000000b005232e0e5462mr153785edv.42.1691611753137;
        Wed, 09 Aug 2023 13:09:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+VvPzm14EVc5hzu8EUxTUqBK3Dx3Y6e/2dvKvte00uHaf7IepyuqRwWUvlhzIq20YEDM4ag==
X-Received: by 2002:aa7:ce0d:0:b0:523:2e0e:5462 with SMTP id d13-20020aa7ce0d000000b005232e0e5462mr153769edv.42.1691611752756;
        Wed, 09 Aug 2023 13:09:12 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7c6d2000000b005233ec5f16bsm3817868eds.79.2023.08.09.13.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 13:09:11 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <0cd7fa8a-6fe6-9945-4656-b4bd941b3d3c@redhat.com>
Date: Wed, 9 Aug 2023 22:09:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com,
 dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 maciej.fijalkowski@intel.com, hawk@kernel.org, netdev@vger.kernel.org,
 xdp-hints@xdp-project.net, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [xdp-hints] [PATCH bpf-next 0/9] xsk: TX metadata
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230809165418.2831456-1-sdf@google.com>
In-Reply-To: <20230809165418.2831456-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 09/08/2023 18.54, Stanislav Fomichev wrote:
> This series implements initial TX metadata (offloads) for AF_XDP.
> See patch #2 for the main implementation and mlx5-one for the
> example on how to consume the metadata on the device side.
> 
> Starting with two types of offloads:
> - request TX timestamp (and write it back into the metadata area)
> - request TX checksum offload
> 
> Changes since last RFC:
> - add /* private: */ comments to headers (Simon)
> - handle metadata only in the first frag (Simon)
> - rename xdp_hw_metadata flags (Willem)
> - s/tmo_request_checksum/tmo_request_timestamp/ in xdp_metadata_ops
>    comment (Willem)
> - Documentation/networking/xsk-tx-metadata.rst
> 
> RFC v4: https://lore.kernel.org/bpf/20230724235957.1953861-1-sdf@google.com/
> 
> Performance:
> 
> I've implemented a small xskgen tool to try to saturate single tx queue:
> https://github.com/fomichev/xskgen/tree/master
> 
> Here are the performance numbers with some analysis.
> 

What is the clock freq GHz for the CPU used for this benchmark?

> 1. Baseline. Running with commit eb62e6aef940 ("Merge branch 'bpf:
> Support bpf_get_func_ip helper in uprobes'"), nothing from this series:
> 
> - with 1400 bytes of payload: 98 gbps, 8 mpps
> ./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189130 sec, 98.357623 gbps 8.409509 mpps
> 
> - with 200 bytes of payload: 49 gbps, 23 mpps
> ./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000064 packets 20960134144 bits, took 0.422235 sec, 49.640921 gbps 23.683645 mpps
> 
> 2. Adding single commit that supports reserving XDP_TX_METADATA_LEN
>     changes nothing numbers-wise.
> 
> - baseline for 1400
> ./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189247 sec, 98.347946 gbps 8.408682 mpps
> 
> - baseline for 200
> ./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 20960000000 bits, took 0.421248 sec, 49.756913 gbps 23.738985 mpps
> 
> 3. Adding -M flag causes xskgen to reserve the metadata and fill it, but
>     doesn't set XDP_TX_METADATA descriptor option.
> 
> - new baseline for 1400 (with only filling the metadata)
> ./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.188767 sec, 98.387657 gbps 8.412077 mpps
> 
> - new baseline for 200 (with only filling the metadata)
> ./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 20960000000 bits, took 0.410213 sec, 51.095407 gbps 24.377579 mpps
> (the numbers go sligtly up here, not really sure why, maybe some cache-related
> side-effects?
> 

Notice this change/improvement (23.7 to 24.4 Mpps) is only 1 nanosec.
  - (1/24.377579-1/23.738985)*10^3 = -1.103499 nanosec

This 1 nanosec could be noise in your testlab.


> 4. Next, I'm running the same test but with the commit that adds actual
>     general infra to parse XDP_TX_METADATA (but no driver support).
>     Essentially applying "xsk: add TX timestamp and TX checksum offload support"
>     from this series. Numbers are the same.
> 
> - fill metadata for 1400
> ./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.188430 sec, 98.415557 gbps 8.414463 mpps
> 
> - fill metadata for 200
> ./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 20960000000 bits, took 0.411559 sec, 50.928299 gbps 24.297853 mpps
> 
> - request metadata for 1400
> ./xskgen -m -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.188723 sec, 98.391299 gbps 8.412389 mpps
> 
> - request metadata for 200
> ./xskgen -m -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000064 packets 20960134144 bits, took 0.411240 sec, 50.968131 gbps 24.316856 mpps
> 
> 5. Now, for the most interesting part, I'm adding mlx5 driver support.
>     The mpps for 200 bytes case goes down from 23 mpps to 19 mpps, but
>     _only_ when I enable the metadata. This looks like a side effect
>     of me pushing extra metadata pointer via mlx5e_xdpi_fifo_push.
>     Hence, this part is wrapped into 'if (xp_tx_metadata_enabled)'
>     to not affect the existing non-metadata use-cases. Since this is not
>     regressing existing workloads, I'm not spending any time trying to
>     optimize it more (and leaving it up to mlx owners to purse if
>     they see any good way to do it).
> 
> - same baseline
> ./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189434 sec, 98.332484 gbps 8.407360 mpps
> 
> ./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000128 packets 20960268288 bits, took 0.425254 sec, 49.288821 gbps 23.515659 mpps
> 
> - fill metadata for 1400
> ./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189528 sec, 98.324714 gbps 8.406696 mpps
> 
> - fill metadata for 200
> ./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000128 packets 20960268288 bits, took 0.519085 sec, 40.379260 gbps 19.264914 mpps
> 

This change from 23 mpps to 19 mpps is approx 10 nanosec
  - (1/23.738985-1/19.264914)*10^3 = -9.78 nanosec
  - (1/23.515659-1/19.264914)*10^3 = -9.38 nanosec

A 10 nanosec difference is more than noise.


> - request metadata for 1400
> ./xskgen -m -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189329 sec, 98.341165 gbps 8.408102 mpps
> 
> - request metadata for 200
> ./xskgen -m -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000128 packets 20960268288 bits, took 0.519929 sec, 40.313713 gbps 19.233642 mpps
> 
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> 
> Stanislav Fomichev (9):
>    xsk: Support XDP_TX_METADATA_LEN
>    xsk: add TX timestamp and TX checksum offload support
>    tools: ynl: print xsk-features from the sample
>    net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
>    selftests/xsk: Support XDP_TX_METADATA_LEN
>    selftests/bpf: Add csum helpers
>    selftests/bpf: Add TX side to xdp_metadata
>    selftests/bpf: Add TX side to xdp_hw_metadata
>    xsk: document XDP_TX_METADATA_LEN layout
> 
>   Documentation/netlink/specs/netdev.yaml       |  20 ++
>   Documentation/networking/index.rst            |   1 +
>   Documentation/networking/xsk-tx-metadata.rst  |  75 +++++++
>   drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
>   .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  72 ++++++-
>   .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  10 +-
>   .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  11 +-
>   .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
>   include/linux/netdevice.h                     |  27 +++
>   include/linux/skbuff.h                        |   5 +-
>   include/net/xdp_sock.h                        |  61 ++++++
>   include/net/xdp_sock_drv.h                    |  13 ++
>   include/net/xsk_buff_pool.h                   |   6 +
>   include/uapi/linux/if_xdp.h                   |  36 ++++
>   include/uapi/linux/netdev.h                   |  16 ++
>   net/core/netdev-genl.c                        |  12 +-
>   net/xdp/xsk.c                                 |  61 ++++++
>   net/xdp/xsk_buff_pool.c                       |   1 +
>   net/xdp/xsk_queue.h                           |  19 +-
>   tools/include/uapi/linux/if_xdp.h             |  50 ++++-
>   tools/include/uapi/linux/netdev.h             |  15 ++
>   tools/net/ynl/generated/netdev-user.c         |  19 ++
>   tools/net/ynl/generated/netdev-user.h         |   3 +
>   tools/net/ynl/samples/netdev.c                |   6 +
>   tools/testing/selftests/bpf/network_helpers.h |  43 ++++
>   .../selftests/bpf/prog_tests/xdp_metadata.c   |  31 ++-
>   tools/testing/selftests/bpf/xdp_hw_metadata.c | 201 +++++++++++++++++-
>   tools/testing/selftests/bpf/xsk.c             |  17 ++
>   tools/testing/selftests/bpf/xsk.h             |   1 +
>   29 files changed, 793 insertions(+), 44 deletions(-)
>   create mode 100644 Documentation/networking/xsk-tx-metadata.rst
> 

Thanks for working on this :-)
--Jesper


