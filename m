Return-Path: <netdev+bounces-26692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2897789A1
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236B9282088
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004E4567B;
	Fri, 11 Aug 2023 09:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28425675
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:21:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6C52D78
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691745714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qc/WOX45CsZJBV93Err2MVMANsAd+cCgENPpEN+I0vA=;
	b=HEciJhxfSG6QfDR+0fTTmk072F/Cp/OeWz6kwc9AHMmvuMe8lD00keVrAQzLHP3bYIF006
	oEKY7E5o0aAFmNLQcxGD4NgdlPVF1RTHOfc+t7fjmjm00VUFukbgi819hij0BNTYfV3hC0
	Frcw83xHtiiQqQc6osRphclIPS1edPw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-_5lrgXyPNciIy2OMe6SqZA-1; Fri, 11 Aug 2023 05:21:53 -0400
X-MC-Unique: _5lrgXyPNciIy2OMe6SqZA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe11910e46so8702515e9.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691745712; x=1692350512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qc/WOX45CsZJBV93Err2MVMANsAd+cCgENPpEN+I0vA=;
        b=JE59ghlxR0NCk7oTzZVoQje+V7JwJ40Qg8aENzb6JlulijuYmomZjv6SahN0iiSCoo
         GeuvJpbGTirMal62IMWdGBgsgbdJcP4DIWmRVxCTnANFXPDI+qJPRpmJWCl9N+8aiikV
         ekVFVOd+fK8f27Vl2zbWleaEBGo38Qc/it9NtCCS5gp3dnBY6DvW4WXDp0rHh9QdA6IE
         Ay3h22/kLW0Sc3gdHlNOQiBTCKMqk6qLLYjWg1TuMDFSv3yqzfzngD2nPVwW7zhZ3KOF
         YYPgLhOgK8WS71oINsNVJ33ytPf8h9rv8PZ2aKoA+2lKI784cS/yzZbQzIOQaMgoVdqs
         im/w==
X-Gm-Message-State: AOJu0YzhzyMFNp9Y5SP///3dIz1PLG/H7cnIp3LloJ6GPQGhc2RxUiGB
	Mfs8zBXz4w1KL2iv/td/+OXCCvYuqnBDO28fDzx3P6xfMkXhFv6Ex9E+o2Rfc4pYHYa09OJp7DJ
	aNGULwc6WSflXAiZT11B/Up1s
X-Received: by 2002:a7b:cd0d:0:b0:3fb:e1d0:6417 with SMTP id f13-20020a7bcd0d000000b003fbe1d06417mr3662329wmj.19.1691745712234;
        Fri, 11 Aug 2023 02:21:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER/WnnKn4hVj56w4Zkki7TDfm7jIFT+xEdAc/BAFLPHbIKDezcMwpxxeM0f+d3cm1CIvnNuA==
X-Received: by 2002:a7b:cd0d:0:b0:3fb:e1d0:6417 with SMTP id f13-20020a7bcd0d000000b003fbe1d06417mr3662316wmj.19.1691745711863;
        Fri, 11 Aug 2023 02:21:51 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d4690000000b00313de682eb3sm4764736wrq.65.2023.08.11.02.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:21:51 -0700 (PDT)
Date: Fri, 11 Aug 2023 05:21:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>, xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230811052102-mutt-send-email-mst@kernel.org>
References: <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
 <20230811012147-mutt-send-email-mst@kernel.org>
 <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 05:18:51PM +0800, Jason Wang wrote:
> On Fri, Aug 11, 2023 at 1:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Aug 11, 2023 at 10:23:15AM +0800, Jason Wang wrote:
> > > On Fri, Aug 11, 2023 at 3:41 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Aug 08, 2023 at 10:30:56AM +0800, Jason Wang wrote:
> > > > > On Mon, Jul 31, 2023 at 2:30 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 27, 2023 at 5:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > > > > > > > They really shouldn't - any NIC that takes forever to
> > > > > > > > > program will create issues in the networking stack.
> > > > > > > >
> > > > > > > > Unfortunately, it's not rare as the device/cvq could be implemented
> > > > > > > > via firmware or software.
> > > > > > >
> > > > > > > Currently that mean one either has sane firmware with a scheduler that
> > > > > > > can meet deadlines, or loses ability to report errors back.
> > > > > > >
> > > > > > > > > But if they do they can always set this flag too.
> > > > > > > >
> > > > > > > > This may have false negatives and may confuse the management.
> > > > > > > >
> > > > > > > > Maybe we can extend the networking core to allow some device specific
> > > > > > > > configurations to be done with device specific lock without rtnl. For
> > > > > > > > example, split the set_channels to
> > > > > > > >
> > > > > > > > pre_set_channels
> > > > > > > > set_channels
> > > > > > > > post_set_channels
> > > > > > > >
> > > > > > > > The device specific part could be done in pre and post without a rtnl lock?
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > >
> > > > > > > Would the benefit be that errors can be reported to userspace then?
> > > > > > > Then maybe.  I think you will have to show how this works for at least
> > > > > > > one card besides virtio.
> > > > > >
> > > > > > Even for virtio, this seems not easy, as e.g the
> > > > > > virtnet_send_command() and netif_set_real_num_tx_queues() need to
> > > > > > appear to be atomic to the networking core.
> > > > > >
> > > > > > I wonder if we can re-consider the way of a timeout here and choose a
> > > > > > sane value as a start.
> > > > >
> > > > > Michael, any more input on this?
> > > > >
> > > > > Thanks
> > > >
> > > > I think this is just mission creep. We are trying to fix
> > > > vduse - let's do that for starters.
> > > >
> > > > Recovering from firmware timeouts is far from trivial and
> > > > just assuming that just because it timed out it will not
> > > > access memory is just as likely to cause memory corruption
> > > > with worse results than an infinite spin.
> > >
> > > Yes, this might require support not only in the driver
> > >
> > > >
> > > > I propose we fix this for vduse and assume hardware/firmware
> > > > is well behaved.
> > >
> > > One major case is the re-connection, in that case it might take
> > > whatever longer that the kernel virito-net driver expects.
> > > So we can have a timeout in VDUSE and trap CVQ then VDUSE can return
> > > and fail early?
> >
> > Ugh more mission creep. not at all my point. vduse should cache
> > values in the driver,
> 
> What do you mean by values here? The cvq command?
> 
> Thanks

The card status generally.

> > until someone manages to change
> > net core to be more friendly to userspace devices.
> >
> > >
> > > > Or maybe not well behaved firmware will
> > > > set the flag losing error reporting ability.
> > >
> > > This might be hard since it means not only the set but also the get is
> > > unreliable.
> > >
> > > Thanks
> >
> > /me shrugs
> >
> >
> >
> > > >
> > > >
> > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > MST
> > > > > > >
> > > >
> >


