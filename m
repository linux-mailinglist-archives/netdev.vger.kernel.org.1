Return-Path: <netdev+bounces-32279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66B9793D5F
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 15:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225451C20AE6
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82A0101E7;
	Wed,  6 Sep 2023 13:04:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF294417
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 13:04:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077C9E7B
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694005462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQC3VLJzelpWuewrYwxP8K1faarkwBrEJnD7vO08AbM=;
	b=V815qrXGDzxovDj31pg7xsJUKAGMBj+2W1S42XCmS7VixeLELa0qZOloCqNUfFpcP6QDjc
	j155r6rzxtBVfSY1I59ySJM1+vhp+o2C5oJOSYCauTbo7PWAvJZyafy1vmDT3YA4Odt3xq
	cZkFBtEhErt/0ZwnficAJ0+gM7AxNB0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-gNW5sO2qN1mVyp5w-_m2kA-1; Wed, 06 Sep 2023 09:04:20 -0400
X-MC-Unique: gNW5sO2qN1mVyp5w-_m2kA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31c5c55fd70so413282f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 06:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694005459; x=1694610259;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQC3VLJzelpWuewrYwxP8K1faarkwBrEJnD7vO08AbM=;
        b=G43oqQ43QxA5ynRqTAuxyu1VS5KbPoT7/YK79l52Cqp54aDi7B9fqw98iWgn215fKW
         ovogIyV4ChSnABG01E/YgSJzu+2gh1FGXW6V3xnfLodyLhmYscA9HXpVhJRFqresF5cu
         TD2brMm0MQsZBdrnCuTNgSOrAjs0fxxl3EQDkps+rRRNkWDV5EuAXhsoRABKGTuiZZFA
         ytVfQDSW0t6DuEi8Kx7kD1yr0WRxpMJV01jKeXQHwe6w2xCIVpXLIH3sMY0PqyQUY6F3
         sHghA5uhcBsN85iB4Mr0BL7FPQPS0OkywD+3KoBp7aOYr5wyBgYO1y96CNPHwIW3qPjr
         5GsQ==
X-Gm-Message-State: AOJu0YwGwfgZc2Cip7e85ZyHrXl2BGI5ewpDleH2N+OVZ44cfVtpM+8R
	u8UAwriZwoXbluWtIs+jzCOCO3+PwdYpiuMchwUjgc8QnVP4kv1peToiiBe6QQ2Y4WuqNf/tO0n
	kPM5wCpCeedUKIeW0k7ZvlhUP
X-Received: by 2002:a5d:5b07:0:b0:319:6997:9432 with SMTP id bx7-20020a5d5b07000000b0031969979432mr2735236wrb.1.1694005459149;
        Wed, 06 Sep 2023 06:04:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqGAlmieinZ1tupmHLodb0qLqsbi8aDyBGyUdUIauh7NwdJy4W2D9n0xTcf5thdTFqpjZBGg==
X-Received: by 2002:a5d:5b07:0:b0:319:6997:9432 with SMTP id bx7-20020a5d5b07000000b0031969979432mr2735212wrb.1.1694005458773;
        Wed, 06 Sep 2023 06:04:18 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.163])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe9d0000000b00317e77106dbsm20350110wrn.48.2023.09.06.06.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:04:18 -0700 (PDT)
Date: Wed, 6 Sep 2023 15:04:16 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev <netdev@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: Question on tw_timer TIMER_PINNED
Message-ID: <ZPh40NCKfj9FJ7fy@localhost.localdomain>
References: <ZPhpfMjSiHVjQkTk@localhost.localdomain>
 <CANn89iJFyqckr3x=nwbExs3B1u=MXv9izL=2ByxOf20su2fhhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJFyqckr3x=nwbExs3B1u=MXv9izL=2ByxOf20su2fhhg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/09/23 14:10, Eric Dumazet wrote:
> On Wed, Sep 6, 2023 at 1:58 PM Juri Lelli <juri.lelli@redhat.com> wrote:
> >
> > Hi Eric,
> >
> > I'm bothering you with a question about timewait_sock tw_timer, as I
> > believe you are one of the last persons touching it sometime ago. Please
> > feel free to redirect if I failed to git blame it correctly.
> >
> > At my end, latency spikes (entering the kernel) have been reported when
> > running latency sensitive applications in the field (essentially a
> > polling userspace application that doesn't want any interruption at
> > all). I think I've been able to track down one of such interruptions to
> > the servicing of tw_timer_handler. This system isolates application CPUs
> > dynamically, so what I think it happens is that at some point tw_timer
> > is armed on a CPU, and it is PINNED to that CPU, meanwhile (before the
> > 60s timeout) such CPU is 'isolated' and the latency sensitive app
> > started on it. After 60s the timer fires and interrupts the app
> > generating a spike.
> >
> > I'm not very familiar with this part of the kernel and from staring
> > at code for a while I had mixed feeling about the need to keep tw_timer
> > as TIMER_PINNED. Could you please shed some light on it? Is it a strict
> > functional requirement or maybe a nice to have performance (locality I'd
> > guess) improvement? Could we in principle make it !PINNED (so that it
> > can be moved/queued away and prevent interruptions)?
> >
> 
> It is a functional requirement in current implementation.
> 
> cfac7f836a71 ("tcp/dccp: block bh before arming time_wait timer")
> changelog has some details about it.

Thanks for the reference.

> Can this be changed to non pinned ? Probably, but with some care.

I see. I will need to ponder about this.

> You could simply disable tw completely, it is a best effort mechanism.

But, first I think we are going to experiment with this route.

Thanks a lot for the super quick reply!

Best,
Juri


