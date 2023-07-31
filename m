Return-Path: <netdev+bounces-22684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C4768BE6
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E784281579
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 06:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F219EBC;
	Mon, 31 Jul 2023 06:24:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C4A5D
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 06:24:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8A1E41
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690784649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFujNs0s393AKJL9Pn5KqZK/kd8R31aOCdV5SggcTOg=;
	b=S7oKCc6ZQsiRPSnztsRbtVU/v+xYQeOYBacxJOMZ8kql53nO0n0TK4z2xxKZXR7HQ+QJtN
	08GktQSVyVLSJrxvj1mlLy8eXWBpccz2YHLPwu02h5d6MT5M2Gwf3MoSuTCHAu4Zra+vo8
	xuxKrZZsduBYK65JQ5RD3FV373ljFSY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-K9csOzSdNJyNQTsTlD3fPg-1; Mon, 31 Jul 2023 02:24:08 -0400
X-MC-Unique: K9csOzSdNJyNQTsTlD3fPg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bb982d2603so45334445ad.3
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 23:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690784647; x=1691389447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFujNs0s393AKJL9Pn5KqZK/kd8R31aOCdV5SggcTOg=;
        b=IJ0qAisi7Ib8JcABXlib+dUngvwZQNjs88mL/4MI3G4OwJwhEB/fLRjwSc/M3BwAHY
         QqtRtnZwPejwkyqmsEQXFx4bSKE13nsN5ZMcTFkKJbHNpqJgViPjChV0jWtMe9G1HoX3
         3mDItiVZfWBdglZcu35ZBYxboNr9KxBu1lNC/wW3p2FWmfM2GzkwBHlVXmKhMOQZITa9
         fZSzDba2Fcr3Spuw00TYx91vBOrbDDcwK3tMQMzZdAbv4g52QSk5APZOg/jJEF87LCjd
         K8WwOCdjHeTJv8J9jhM3+7w/VDfM8w/T4iil2k3cybPsu28IbQ72Nn/Vl6PpCGkDXopJ
         2Wbw==
X-Gm-Message-State: ABy/qLas/vtplzefUUyM+/SUYm6zTy+NlHuUD2G8oNWLXgf7uEGc9prY
	n/7PRMoHa9xa6EdOdG+OieaNjbwd6t8xa/cHzsTE98z7Fq+FOCsLqavTwZrBDNqtZEwPybBhVfS
	oBaxeUhEkhHR6W9MM
X-Received: by 2002:a17:902:6b88:b0:1b8:16c7:a786 with SMTP id p8-20020a1709026b8800b001b816c7a786mr7837681plk.4.1690784647317;
        Sun, 30 Jul 2023 23:24:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH7mH2Qi6DFfl6DwSxvSKUPeZPkzsuIKf9buf/HUaThSCbGhjgk9r38CsiEE+rud7IO8Nb3ow==
X-Received: by 2002:a17:902:6b88:b0:1b8:16c7:a786 with SMTP id p8-20020a1709026b8800b001b816c7a786mr7837667plk.4.1690784647016;
        Sun, 30 Jul 2023 23:24:07 -0700 (PDT)
Received: from [10.72.112.185] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001b5247cac3dsm7590352plz.110.2023.07.30.23.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:24:06 -0700 (PDT)
Message-ID: <66cd33fd-5d92-915e-e7ac-9eb564936eab@redhat.com>
Date: Mon, 31 Jul 2023 14:24:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
Cc: gavi@nvidia.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
Content-Language: en-US
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230725130709.58207-3-gavinl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


在 2023/7/25 21:07, Gavin Li 写道:
> Add interrupt_coalesce config in send_queue and receive_queue to cache user
> config.
>
> Send per virtqueue interrupt moderation config to underlying device in
> order to have more efficient interrupt moderation and cpu utilization of
> guest VM.
>
> Additionally, address all the VQs when updating the global configuration,
> as now the individual VQs configuration can diverge from the global
> configuration.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


