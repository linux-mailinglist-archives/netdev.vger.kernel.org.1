Return-Path: <netdev+bounces-14455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943497419FC
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 23:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56A81C203B6
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EF81118B;
	Wed, 28 Jun 2023 21:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554A11181
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 21:02:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CA810F5
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687986135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9506tjdRUpf919lvfhcv2C6YbXpf1fvzNXoPxI/AF8=;
	b=OBzE8YKEz9Nh9e8OfQSjKHcPuyCMRQmzgwRrHJPwyh+DF9LlmZhEnZf2aiEGsgMpIxwMyk
	NaWJLmzJrR9gg4JF26+sD6EucXwR5UYPM6NX4oFTk+a77msheDM2xkxRJfwc7jetixv0CX
	2ufLSaL9UxRM395MUdQJp0vY6VNo2ZM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-O5SxSL_sPHSCYtBO5tpP6g-1; Wed, 28 Jun 2023 17:02:09 -0400
X-MC-Unique: O5SxSL_sPHSCYtBO5tpP6g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa83859fa4so1721875e9.1
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 14:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687986128; x=1690578128;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9506tjdRUpf919lvfhcv2C6YbXpf1fvzNXoPxI/AF8=;
        b=HLm3tJz1AgafOwXVdg2ZbF3rWXTnUtYIgr6A+MLw9fTJP0a9hpzTsfTi5KSxVDnfUr
         1AVk/c/5TbjvVDcEMN5jaXpit4aL3InqCh6Edxetd846nF870ebINg75de9UoJDZIm24
         1UjDyRdeu+iqL0Wg4sII6WNxAfMC0vJNtTjSjVyMLOSW3q+0WR7+oSWuZaX9HB8HObog
         Uv/6ZgX2aqTUuuuzqH7d/l9pn+/uPXBjze7rOLPq8//vgL1asKoVVip85xYGBE87zLKc
         xMFmWPV7dTR9n8cbf0GGfQSW2NMqyBm9RmlNg3DjdFoERrA9X8gRWROyicNWAJNN6roM
         Wqig==
X-Gm-Message-State: AC+VfDzo+pa1wnCif6a4hva2QCBApRjv3pChVhC834BolrzhWqbzUjbN
	ChwfEru3fJOueG32k+zYLik2Zrmp+VG+FxQREb5EHmKJDNtu16a1QqF6RJSr46DLQcPx3wEUg3c
	i92Q13io104UH6LeO
X-Received: by 2002:a1c:750a:0:b0:3f5:878:c0c2 with SMTP id o10-20020a1c750a000000b003f50878c0c2mr25649661wmc.3.1687986128201;
        Wed, 28 Jun 2023 14:02:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ555s0Uauaywa+YUbpgGLrI/eB4NrymjZvBeM3Ccx8OEyCLZQopFxpFybHVInNG5cu5CiBqYg==
X-Received: by 2002:a1c:750a:0:b0:3f5:878:c0c2 with SMTP id o10-20020a1c750a000000b003f50878c0c2mr25649640wmc.3.1687986127792;
        Wed, 28 Jun 2023 14:02:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003fa74bff02asm14621588wmb.26.2023.06.28.14.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:02:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 51EA7BC0244; Wed, 28 Jun 2023 23:02:06 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, tirthendu.sarkar@intel.com,
 simon.horman@corigine.com
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
In-Reply-To: <ZJx9WkB/dfB5EFjE@boxer>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-16-maciej.fijalkowski@intel.com>
 <87zg4uca21.fsf@toke.dk>
 <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
 <87o7l9c58j.fsf@toke.dk>
 <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
 <20230621133424.0294f2a3@kernel.org>
 <CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
 <875y7flq8w.fsf@toke.dk> <ZJx9WkB/dfB5EFjE@boxer>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 28 Jun 2023 23:02:06 +0200
Message-ID: <87edlvgv1t.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index a4270fafdf11..b24244f768e3 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -19,6 +19,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
>  		return -EMSGSIZE;
>  
>  	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
> +	    nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
> +			netdev->xdp_zc_max_segs) ||

Should this be omitted if the driver doesn't support zero-copy at all?

-Toke


