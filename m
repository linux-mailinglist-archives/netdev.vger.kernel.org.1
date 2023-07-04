Return-Path: <netdev+bounces-15360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA78274720B
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956A9280E5F
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0C85698;
	Tue,  4 Jul 2023 13:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC02611C
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 13:02:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1C0E7E
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688475746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDRjVUli4/Wo+gosprzbDZbukIPaouraxRxHctBqUJI=;
	b=EoOXHKgFIIbRcffB+jAPqwp3nuIDaQvI7MzO0lGNSCL5CpnbEjmuzNjeLFd4trlwuJZB8b
	8CR3PCjAGnWFRAgPUjv/fGju9yazhYzv9lvFFGbjw+qxaRnfToFQlKErPYN0PIBK1NJusE
	NTX+9WHbZlBMGVMiso0a3nvwPn5+JcU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-nnSgQym-PhCKaJwXeD-o9w-1; Tue, 04 Jul 2023 09:02:25 -0400
X-MC-Unique: nnSgQym-PhCKaJwXeD-o9w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-635de6f75e0so8803466d6.1
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 06:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688475745; x=1691067745;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDRjVUli4/Wo+gosprzbDZbukIPaouraxRxHctBqUJI=;
        b=UlNBlAisOTIhYX6ZmeCbI1XN2kgHVsMxgxrCtegv0qPEtbdp6Jyn4mZwxRTz40HyYH
         8X7q9oJT5c7p2mlPZ5B4/67BJxEEltZX1JMdIAQpnv6mRBmhJ67hY0K1ZIz0bhNYgx2w
         i7Inyaa8DiF8YqwfSNNwpx7JvMLTFMbCV1Fd1nLoautSQiSFTLVWrlxN8gaCmrLQdqTe
         uA5qdVH8oOnEI/ak5QxmUwA3cdfjiZIFMI5a/Cw+s9WXshSz6xTAtETFWRTIRkDqTmXT
         OQ0K/Ss220e+9EipdlJs2wDGMJ/LDrCyD9eX76aRfaTnW61/Hq7KQp+oA4SXa8b4wIZD
         /T8w==
X-Gm-Message-State: ABy/qLZQWXtL2jCPf0xo9smz31BkdugBWM4FBTkrdOdK5BPIFDcf6fpF
	vPtc7dgLqbqYnnUV1bGE/1Rdp0L7ZSZEBdXBwfYLTfmmRVR28ca89XlSIQurlt2DP/sgzomebPw
	G1HaZ/H0R3ZxAcIww
X-Received: by 2002:a05:6214:1c44:b0:62f:e386:1e45 with SMTP id if4-20020a0562141c4400b0062fe3861e45mr14935030qvb.1.1688475745317;
        Tue, 04 Jul 2023 06:02:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH1Ng7cnLpEMncNqQT8Wu70KWYSGYSrZZ+7l3UsJbbqOgTckJ0WeHx6v6IWOw9pN7kOy54sMw==
X-Received: by 2002:a05:6214:1c44:b0:62f:e386:1e45 with SMTP id if4-20020a0562141c4400b0062fe3861e45mr14934983qvb.1.1688475744669;
        Tue, 04 Jul 2023 06:02:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id h1-20020a0cf401000000b0063007ccaf42sm3480598qvl.57.2023.07.04.06.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 06:02:24 -0700 (PDT)
Message-ID: <8ad620b632d723bc2f61ec1efb81d16c465d58bb.camel@redhat.com>
Subject: Re: [PATCH net-next] bnxt_en: use dev_consume_skb_any() in
 bnxt_tx_int
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com, michael.chan@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Menglong Dong
	 <imagedong@tencent.com>
Date: Tue, 04 Jul 2023 15:02:21 +0200
In-Reply-To: <20230704085236.9791-1-imagedong@tencent.com>
References: <20230704085236.9791-1-imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-04 at 16:52 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
>=20
> Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
> to clear the unnecessary noise of "kfree_skb" event.
>=20
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle
--=20
pw-bot: defer


