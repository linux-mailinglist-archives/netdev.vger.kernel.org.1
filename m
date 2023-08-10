Return-Path: <netdev+bounces-26164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3902D7770C5
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6541C214A8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 06:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83D20EA;
	Thu, 10 Aug 2023 06:53:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42671C17
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:53:36 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C405910F5
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 23:53:35 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4036bd4fff1so135981cf.0
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691650415; x=1692255215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SXCT/2gawCNMaorMZ7NOA4GCE3vpl+t+8z7dja7EwU=;
        b=k/nJYM/0P5WRKY/9FrmaDZqWiO046TENSs0xMrdnfbdDUxk1mPNrHRR+cDjydD7NFd
         b3r6XMSR08E1FyNZBCwZ+lqaW6ytPEi1335respAKmqyRdd8G1mE1xGXU6AHDEd9SrcB
         Zj+Pl93ymf28tiTRT0rZ6NEsQ24KCnSMKkqQWfxzAFkJphGAKs2cfXR1vYi3FQbmXrFg
         tEGT/W3paPeVWn1BJLQSfjajgb1B6A+Wrhwop1xlHWPBTFiqlH25yRrqBItvTS4GN0p/
         MVBx/NZ7ULlL0/y1dohbBztjkFahpK/bOZdbDP0IDnwM7xz8ihwBoFGCiU3YeHjwU+lH
         PlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691650415; x=1692255215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SXCT/2gawCNMaorMZ7NOA4GCE3vpl+t+8z7dja7EwU=;
        b=DLmpvIc97+17CEYuZnLIZJloxM7LOuammUHEO3WRgpmMgctTqJwFSGxx3iV2ilqDhj
         BOPhUVUNhUOebeDpu8a2/qkDglVhh2DRU93i5zesFeLOjN5Sv/ZYC3PGCEPRBN50fguL
         wz4ew2WPXPKaQJtg24yYFGH7VIhYpZSOJpbfoB3RPRuI+a1r1hPNMf2TDIv3G3g8+NqG
         JOi/cb6osWc9PDI/mxRmlHKnyH6vW0yBTTERIanW8KN7AJrKcnEntO2t68pW06xMxuQC
         Azkj745a7A8/DfceiQW2YRDvalPHXDMV85HgtdYNQ17dXi9lD/+ii1h3OI3NOTOMkSK5
         /wVA==
X-Gm-Message-State: AOJu0YzJ/Mk8tM4hVdYJERQw9T2TQ9m4lJi30frTFwWwT0SyJkWdyd5F
	ccziZS8otWIMwwkxfmJi+IcUuG4gy8FxyQj/dxNgtQ==
X-Google-Smtp-Source: AGHT+IGjbLMDBw3eHhD81jqgbpuCV6OqepVleEETJMwmfJagyg2iKtKs4dRp3YvwhOullwESxhhqV0aKqClwBtSdCyM=
X-Received: by 2002:a05:622a:1816:b0:403:aee3:64f7 with SMTP id
 t22-20020a05622a181600b00403aee364f7mr288282qtc.6.1691650414804; Wed, 09 Aug
 2023 23:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809164753.2247594-1-trdgn@amazon.com>
In-Reply-To: <20230809164753.2247594-1-trdgn@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Aug 2023 08:53:23 +0200
Message-ID: <CANn89iKvh=da2uRkGn5dTX5Yxvz-uZdSJoKf0+pPU16XVDt=fg@mail.gmail.com>
Subject: Re: [PATCH v4] tun: avoid high-order page allocation for packet header
To: Tahsin Erdogan <trdgn@amazon.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 6:48=E2=80=AFPM Tahsin Erdogan <trdgn@amazon.com> wr=
ote:
>
> When gso.hdr_len is zero and a packet is transmitted via write() or
> writev(), all payload is treated as header which requires a contiguous
> memory allocation. This allocation request is harder to satisfy, and may
> even fail if there is enough fragmentation.
>
> Note that sendmsg() code path limits the linear copy length, so this chan=
ge
> makes write()/writev() and sendmsg() paths more consistent.
>
> Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

