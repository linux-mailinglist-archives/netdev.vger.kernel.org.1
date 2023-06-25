Return-Path: <netdev+bounces-13845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA773D4B1
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 23:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB511C208E4
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6CF944F;
	Sun, 25 Jun 2023 21:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08AEA4
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 21:54:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D6B1A5
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687730042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7K4oZGxfnRQ5Kbcr/TMT6ATY4u3TAiqKM1oEjq6Wqbs=;
	b=YK/GmRcNnU86Hdy8OylwE/sqfz4N+edChR+xYQqxQD/6RPWxO1s7EzdYoGrY0QE6wqfZ9m
	atv3cKxkM2cP7MEdf2esMTTxVp92ewLl2v5lnRkx9f+eIwvYPk4vW4oM4AtTZzJzRDEH/D
	ZkgMqYCSgya6J6cuSe9mMNT0G7/wEeo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-2_qsWSgfOR--Zn4zb_lV2Q-1; Sun, 25 Jun 2023 17:54:00 -0400
X-MC-Unique: 2_qsWSgfOR--Zn4zb_lV2Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa7a851dadso15306145e9.0
        for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 14:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687730039; x=1690322039;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7K4oZGxfnRQ5Kbcr/TMT6ATY4u3TAiqKM1oEjq6Wqbs=;
        b=drmK0Vq2AU9wH68nW1z5mO1ZHoAumcK57sF5BAtkHTCuzMR/Y9XE4ZeGAip6lSu2fc
         uwSQuRjw36MYdflLW439wH0WTedIYgo1LcU/E8sJWzwMeE/uljwbE1eCoosqNsMPQeCe
         LmjGVwINmIj18nsf+oNuAOyO5Qe5iYhm32thok76ee/2hInjXhw9EYY0ZOJtKjaOeTJb
         dU3N+7DsmOH+o2iGLV1LrEgb1m0ZIALGXeHp6wnJiZZPQ341oV23otY//1oH1oW84dgz
         ZXvNKzrELu6ExNd5BdznIYCJ82mJVALxTqDXBcj+HXaRe56GtrxTqHHjRRuIiEeK5QAS
         FKXQ==
X-Gm-Message-State: AC+VfDywAgG00cWq/CraKdun8uI0v3Ib3Pc7XPfGu3b4rncm6IYTKxMg
	G5BhYbACKCQ2VwQTKAruFjDDUDbVNcSKrsMl8xn+OsKvME0jk9bMcOzsUTxFELQyhnBlwjQb2oH
	eofzjYPyTYhAi7zlP
X-Received: by 2002:a05:600c:2c2:b0:3f7:3699:c294 with SMTP id 2-20020a05600c02c200b003f73699c294mr20914685wmn.29.1687730039041;
        Sun, 25 Jun 2023 14:53:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YLKbrTNd4D5rPv7fDnrpFIdLUBGklnn9qU6r26Dqf36h1LAW2Xr+PDjXdq8RrNEdgpi4PmA==
X-Received: by 2002:a05:600c:2c2:b0:3f7:3699:c294 with SMTP id 2-20020a05600c02c200b003f73699c294mr20914680wmn.29.1687730038775;
        Sun, 25 Jun 2023 14:53:58 -0700 (PDT)
Received: from redhat.com ([2.52.156.102])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d69cb000000b00313f07ccca4sm1341205wrw.117.2023.06.25.14.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 14:53:57 -0700 (PDT)
Date: Sun, 25 Jun 2023 17:53:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] virtio-net: reprobe csum related fields
 for skb passed by XDP
Message-ID: <20230625175337-mutt-send-email-mst@kernel.org>
References: <20230624122604.110958-1-hengqi@linux.alibaba.com>
 <20230624122604.110958-2-hengqi@linux.alibaba.com>
 <ZJdCW4pxTioTPKJn@corigine.com>
 <45bda8e7-8d4a-c7c9-1fe2-af6926329ef7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45bda8e7-8d4a-c7c9-1fe2-af6926329ef7@linux.alibaba.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 25, 2023 at 10:17:15AM +0800, Heng Qi wrote:
> 
> 
> 在 2023/6/25 上午3:28, Simon Horman 写道:
> > On Sat, Jun 24, 2023 at 08:26:02PM +0800, Heng Qi wrote:
> > 
> > ...
> > 
> > > +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> > > +				      struct sk_buff *skb,
> > > +				      __u8 flags)
> > Hi Heng Qi,
> > 
> > Unfortunately this appears to break an x86_64 allmodconfig build
> > with GCC 12.3.0:
> > 
> > drivers/net/virtio_net.c:1671:12: error: 'virtnet_set_csum_after_xdp' defined but not used [-Werror=unused-function]
> 
> I admit that this is a patch set, you can cherry-pick patches [1/3] and
> [2/3] together
> to make it compile without 'defined but not used' warning. If people don't
> want to
> separate [1/3] and [2/3], I can squash them into one. :)
> 
> Thanks.

the answer is yes, do not break the build.

> >   1671 | static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> >        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > --
> > pw-bot: changes-requested


