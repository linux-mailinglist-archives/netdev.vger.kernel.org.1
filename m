Return-Path: <netdev+bounces-33574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F3E79EA4B
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109A11C203A3
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D0E1EA93;
	Wed, 13 Sep 2023 14:00:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481411A718
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 14:00:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4F2F19B1
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694613614;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yK3xgmt1aeFdUkAxw9Y0+ZQFHP2f+qkDkwODsKtQl0=;
	b=iTjKRLz++kwQDoV6ybdz5g8N2TXWH6cpoWNPaSc4YzSvbQP4qwEs+wjNdUrwlUyAWViYdG
	PlyPoIhPn1K4OZtmiIJB7rGuiUHqt5dMfqBjRbc2/giJKpa4viun2YwJqJtAA9nDLeqKgV
	u7am5H3lp2ThwbFzAY35iF3lgTd/QNs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-TVu3PfCyP56GETtd5vT1WQ-1; Wed, 13 Sep 2023 10:00:13 -0400
X-MC-Unique: TVu3PfCyP56GETtd5vT1WQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76efd8bf515so66974585a.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694613613; x=1695218413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yK3xgmt1aeFdUkAxw9Y0+ZQFHP2f+qkDkwODsKtQl0=;
        b=TAKUtuWGtcq0gaf7Nr2t3IeVsmbUW+na/pERc63sjg7ZB3Bjvf+6juiUlbTMlLEk8c
         G203XIBjZ6/2vdb9sPKirS9xY23mdScGA6sZffmA7B+flSZavNvzSNdCsxMgZ21eNzNK
         dhFJQHGrN90zlIDboYYjbYw4H5cFVlFNZC9wnfcAqZMhTV2IVUEQSM8Wg+9dX+O4Uip0
         zH8yDhC7lwmohvicvqCvEROIDIfnKM9T1rJILkxHt58d7iqJ0n0q202TKpbaEtJrVkzh
         xHZwCfbnq/NT9CsbDvtE9oxR9ZAxPhyo8u7chbcsid/EibcYombHfhTn6e5ENk7L1JvT
         x9qg==
X-Gm-Message-State: AOJu0Yy1PcXl92YW47rf91gDF22WzW3LbogKyjOP8ZVlOcMB1BCNCXfj
	vxlMAIp9IoSj/LBkAFIGog/AoC3rJdy5W8Ic89TZdIEsP9k3Usdfp/8ulnPxaTDcADUNYY6+SMO
	uDgbWfg9cE1MSX0I9
X-Received: by 2002:a05:620a:44c3:b0:76e:f686:cad8 with SMTP id y3-20020a05620a44c300b0076ef686cad8mr7244556qkp.13.1694613613036;
        Wed, 13 Sep 2023 07:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfk9vTwiioPzhJO0D1j6+0LQmPdk1mn8JxTGfaPUXi0LyXZ0YuCSf940L14zsRR6mW81HaUA==
X-Received: by 2002:a05:620a:44c3:b0:76e:f686:cad8 with SMTP id y3-20020a05620a44c300b0076ef686cad8mr7244535qkp.13.1694613612753;
        Wed, 13 Sep 2023 07:00:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id u9-20020a0cf1c9000000b00653589babcbsm4456536qvl.87.2023.09.13.07.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 07:00:11 -0700 (PDT)
Message-ID: <bed381a8-7d3d-d596-bc88-6ff8a7a5a33b@redhat.com>
Date: Wed, 13 Sep 2023 16:00:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2] vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE
Content-Language: en-US
To: eric.auger.pro@gmail.com, elic@nvidia.com, mail@anirudhrb.com,
 jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kvmarm@lists.linux.dev
Cc: stable@vger.kernel.org
References: <20230824093722.249291-1-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230824093722.249291-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/24/23 11:37, Eric Auger wrote:
> Commit e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb
> entries") Forbade vhost iotlb msg with null size to prevent entries
> with size = start = 0 and last = ULONG_MAX to end up in the iotlb.
>
> Then commit 95932ab2ea07 ("vhost: allow batching hint without size")
> only applied the check for VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE
> message types to fix a regression observed with batching hit.
>
> Still, the introduction of that check introduced a regression for
> some users attempting to invalidate the whole ULONG_MAX range by
> setting the size to 0. This is the case with qemu/smmuv3/vhost
> integration which does not work anymore. It Looks safe to partially
> revert the original commit and allow VHOST_IOTLB_INVALIDATE messages
> with null size. vhost_iotlb_del_range() will compute a correct end
> iova. Same for vhost_vdpa_iotlb_unmap().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entries")
> Cc: stable@vger.kernel.org # v5.17+
> Acked-by: Jason Wang <jasowang@redhat.com>

Gentle ping for this fix? Any other comments besides Jason's A-b?

Best Regards

Eric
>
> ---
> v1 -> v2:
> - Added Cc stable and Jason's Acked-by
> ---
>  drivers/vhost/vhost.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c71d573f1c94..e0c181ad17e3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1458,9 +1458,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>  		goto done;
>  	}
>  
> -	if ((msg.type == VHOST_IOTLB_UPDATE ||
> -	     msg.type == VHOST_IOTLB_INVALIDATE) &&
> -	     msg.size == 0) {
> +	if (msg.type == VHOST_IOTLB_UPDATE && msg.size == 0) {
>  		ret = -EINVAL;
>  		goto done;
>  	}


