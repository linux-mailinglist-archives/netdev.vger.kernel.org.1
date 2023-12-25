Return-Path: <netdev+bounces-60167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B31A81DEFD
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DA61C20A88
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8B7E9;
	Mon, 25 Dec 2023 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNhQndTB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C491C14
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703491433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCwTTNNyqrMfZw/hNOREXjBR0xNOBHLOAENENPZLEbY=;
	b=XNhQndTBmyJLtY657cxQTAbCjxwPDmfNdDJlvL4e5o8xesjroVjGR1OTmCC7+LTGnen9sR
	TFiAOfKvZ0GzShGD4iEtuEkGS0wc5FgyFbH4SKBtKhmn2rwsY021emqYum7ziCXtFMz2Cu
	nVAKovZlzL8X52fFoWxBwkhPH/ZxfXA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-G7XxhHesNBusoPRAm8z1YA-1; Mon, 25 Dec 2023 03:03:51 -0500
X-MC-Unique: G7XxhHesNBusoPRAm8z1YA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d54db2ab5so9917225e9.2
        for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 00:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703491431; x=1704096231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCwTTNNyqrMfZw/hNOREXjBR0xNOBHLOAENENPZLEbY=;
        b=oz/z9LO6XiorWlEImbIfd93VYqpQxG6O/hkZXkl5BiGQB0Xt6DZRBME5VoqFNzBRvV
         GEmXO6ME606ycmmo8waiY8V89eEjDucY6oERd3rkXSWMWDUTnH2fobGVNPC+2hz2II4J
         xjfMtYVJ3buAxPzvLioT/Jff+/zoUN/FD7qW5sCYA0n20WArQgHZxruy0rbXsr3NlQlt
         ORcTECIrPa2+3E2Ti2IlSYRrNnUbRUsR79arKIctiw4+TqbkzGHw/wBw4AVx1nNJ3wN6
         LNYQfHsSPoRF/Ngh2FxH5/TCo1iEhhqcNrN/eRbBf4e5kh8gBO5t7RaV+wgMRT/M0EAS
         T3bQ==
X-Gm-Message-State: AOJu0Yz3Ht7YOyTWedv/JPsAhXp2bRnbnQG/1TqnXQLyX6Av64mCdVWs
	Lvki02Rcic0EAOXakHFKnl34sAo7o/UD2fe1LwgrPoHw639+D3zqhbGIOneVX7yg9DFeYaCXWhM
	SU8ly0C9lPm/Q4M5CQNPY+Mpl
X-Received: by 2002:a05:600c:524c:b0:408:434c:dae7 with SMTP id fc12-20020a05600c524c00b00408434cdae7mr2777989wmb.2.1703491430691;
        Mon, 25 Dec 2023 00:03:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZgyHSr0SfK4IlMsoMWoOO6taBhyRbYG9Be5tX7F8nmLfhtDinWZt84jKjwnyMxfcf5lIUjg==
X-Received: by 2002:a05:600c:524c:b0:408:434c:dae7 with SMTP id fc12-20020a05600c524c00b00408434cdae7mr2777976wmb.2.1703491430375;
        Mon, 25 Dec 2023 00:03:50 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id w18-20020adfee52000000b0033657376b62sm9789710wro.105.2023.12.25.00.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 00:03:49 -0800 (PST)
Date: Mon, 25 Dec 2023 03:03:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
Message-ID: <20231225025936-mutt-send-email-mst@kernel.org>
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch>
 <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch>
 <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
 <20231222031024-mutt-send-email-mst@kernel.org>
 <CACGkMEsZDYFuvxgw63U5naLTYH5XNwMTMNvsoz439AWonFE4Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsZDYFuvxgw63U5naLTYH5XNwMTMNvsoz439AWonFE4Vg@mail.gmail.com>

On Mon, Dec 25, 2023 at 12:12:48PM +0800, Jason Wang wrote:
> On Fri, Dec 22, 2023 at 4:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Dec 22, 2023 at 10:35:07AM +0800, Jason Wang wrote:
> > > On Thu, Dec 21, 2023 at 11:06 PM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Heng Qi wrote:
> > > > >
> > > > >
> > > > > 在 2023/12/20 下午10:45, Willem de Bruijn 写道:
> > > > > > Heng Qi wrote:
> > > > > >> virtio-net has two ways to switch napi_tx: one is through the
> > > > > >> module parameter, and the other is through coalescing parameter
> > > > > >> settings (provided that the nic status is down).
> > > > > >>
> > > > > >> Sometimes we face performance regression caused by napi_tx,
> > > > > >> then we need to switch napi_tx when debugging. However, the
> > > > > >> existing methods are a bit troublesome, such as needing to
> > > > > >> reload the driver or turn off the network card.
> > >
> > > Why is this troublesome? We don't need to turn off the card, it's just
> > > a toggling of the interface.
> > >
> > > This ends up with pretty simple code.
> > >
> > > > So try to make
> > > > > >> this update.
> > > > > >>
> > > > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > The commit does not explain why it is safe to do so.
> > > > >
> > > > > virtnet_napi_tx_disable ensures that already scheduled tx napi ends and
> > > > > no new tx napi will be scheduled.
> > > > >
> > > > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack cannot
> > > > > send the packet.
> > > > >
> > > > > Then we can safely toggle the weight to indicate where to clear the buffers.
> > > > >
> > > > > >
> > > > > > The tx-napi weights are not really weights: it is a boolean whether
> > > > > > napi is used for transmit cleaning, or whether packets are cleaned
> > > > > > in ndo_start_xmit.
> > > > >
> > > > > Right.
> > > > >
> > > > > >
> > > > > > There certainly are some subtle issues with regard to pausing/waking
> > > > > > queues when switching between modes.
> > > > >
> > > > > What are "subtle issues" and if there are any, we find them.
> > > >
> > > > A single runtime test is not sufficient to exercise all edge cases.
> > > >
> > > > Please don't leave it to reviewers to establish the correctness of a
> > > > patch.
> > >
> > > +1
> > >
> > > And instead of trying to do this, it would be much better to optimize
> > > the NAPI performance. Then we can drop the orphan mode.
> >
> > "To address your problem, optimize our code to the level which we
> > couldn't achieve in more than 10 years".
> 
> Last time QE didn't report any issue for TCP. For others, the code
> might just need some optimization if it really matters, it's just
> because nobody has worked on this part in the past years.

You think nobody worked on performance of virtio net because nobody
could bother? I think it's just micro optimized to a level where
progress is difficult.

> The ethtool trick is just for debugging purposes, I can hardly believe
> it is used by any management layer software.

It's UAPI - someone somewhere uses it, management layer or not.

-- 
MST


