Return-Path: <netdev+bounces-36120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893327AD6A7
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 13:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id C0C3AB209C0
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 11:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37124182CA;
	Mon, 25 Sep 2023 11:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7C14009
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 11:06:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BDFD3
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695639984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQRWTolrc1uePhvYxe9aPNX0v4LbfRDKHKl3Z6tC+kg=;
	b=bfsx1q8VW72Oto2Qb4GHvuFFwzmPPi95euIBdE1w7RIuAFhKhByObrY9Rz05Nnl5SOmOdh
	72K32iMtyge4Q4LCJ1aS+LaogL+8Vtkka5N1CO+h6yRrB6Fd7404oizsFj9vJypb5FWlTf
	BQGwyI9qdhwTJaZND23PE40jxVjfMS4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-I_wemmJ8OkG_JnRGitK8yA-1; Mon, 25 Sep 2023 07:06:22 -0400
X-MC-Unique: I_wemmJ8OkG_JnRGitK8yA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3217fdf913dso4390938f8f.3
        for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 04:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639981; x=1696244781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQRWTolrc1uePhvYxe9aPNX0v4LbfRDKHKl3Z6tC+kg=;
        b=R3n6YQWikaifwXEDuOFze5lPOFVW7sua9VV8jd7T2EyYq2NUCqey+PzV/7EUvPaGKr
         1KHFDtWhrbN1p85M1QGh933hB+juZnxosBDEeQOXFU7DQ2aybvkxx2z7KONGkJ5kfEwv
         oDXBcyh4fB+HO3YUEINpVkY8gh19uLRsmf190KdHBaHmNPcQMbiCfCeiO76TGLtpZmeu
         ZvcTZ/VjJbOr2KHl4rti/RzHYchd9Rc2m6zd6ygLFrZwIyzEOvsYi0eYFx+RwywbU4ct
         Gv5rVH8H0ZEm56OsPyng75SvZG7DfTDQ2jIG5Z2EN3LZlsXEGUWoBY6lhvkBGNjPKrdU
         jiJg==
X-Gm-Message-State: AOJu0YzTR9h8pEieJH6VWPDEfqEE3pdz8YpvpSrL/smUZwSCca3P+vKX
	wwpfPUmheFLGgkedgtolimg5jHNzzvN15knHx/kYNF6mNh8weru7cqgcOPkHGscbuuxIknzOCXO
	zRdp2xQnFZBRYUAo9
X-Received: by 2002:adf:f68d:0:b0:320:16b:167d with SMTP id v13-20020adff68d000000b00320016b167dmr6027679wrp.63.1695639981767;
        Mon, 25 Sep 2023 04:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3lAC4ITmJN1cbZviSsIr7upH20AuX9eMFgek6yDvi8V904h35Q6YFoYgDWz4VY9q0pBgnbA==
X-Received: by 2002:adf:f68d:0:b0:320:16b:167d with SMTP id v13-20020adff68d000000b00320016b167dmr6027663wrp.63.1695639981450;
        Mon, 25 Sep 2023 04:06:21 -0700 (PDT)
Received: from debian (2a01cb058d23d6002541150e39af35f7.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:2541:150e:39af:35f7])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b003fee567235bsm2424660wmj.1.2023.09.25.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:06:20 -0700 (PDT)
Date: Mon, 25 Sep 2023 13:06:18 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: mark address parameters of
 udp_tunnel6_xmit_skb() as const
Message-ID: <ZRFpquxdCJdTtcHT@debian>
References: <20230924153014.786962-1-b.galvani@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924153014.786962-1-b.galvani@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 24, 2023 at 05:30:14PM +0200, Beniamino Galvani wrote:
> The function doesn't modify the addresses passed as input, mark them
> as 'const' to make that clear.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


