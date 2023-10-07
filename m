Return-Path: <netdev+bounces-38729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29537BC482
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 05:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E789281DCA
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 03:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE161872;
	Sat,  7 Oct 2023 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdxLjr+t"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DF61842
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 03:53:09 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95830DE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 20:53:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c76ef40e84so4883215ad.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 20:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696650786; x=1697255586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTpChY0Q/l1bI7tFTAjK5oz03DsCSPfe+SY0tk4TTIA=;
        b=UdxLjr+tFdEniz8DYvhbfAdnbL5eVJK7NhYBmFA3/l1Rg94skJaN1ny1zML9b3/BhX
         IsG2TLNNwh+CXEvtdIjp4iS618v7ksa4pkwcXiEYM3vENpxS7lhK6fyQFIaQvorEnTPF
         ZeIbVgGX509kU4VdvTz1Jb6MbihDRfbC7woDfPJBwGsN3KrYsovDKRUv7IkUDB4m8l12
         WKLLjX1Y5rsp+AAQYHIFqrCqbRJ0IMIg1s7Ve1Ul1kQDGpsrSdaqqupDWg5THCtI/rI9
         Ilf62s8vhnUecrDku/2q4QHnBJyYKfv1yF0qhZihJv8bfUd43qJOmy2SBQtISWrcOLii
         l83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696650786; x=1697255586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTpChY0Q/l1bI7tFTAjK5oz03DsCSPfe+SY0tk4TTIA=;
        b=ps29mWqUxpxzz0yD1NtKqUYqPd9ORlbpdGYm+wAmFHOIKYMCQYqp800j9dTyVOsSTz
         ht2ixYmdxNbf0sg1tN9SjQRgdWpH0w5L3bOWif7/mNjeuhiffsVSS+0Y/S245Rz2Ail0
         oWFZYcW9uLopBisbu59nTHj/o6F2uYHLUNC0n8seB/Xuqu1CP6520PJC1+xJAcqTs1+Q
         4zjUn1xesR9099Jisd5ZO/mSckM0ff2pPjrITy2nSVPMcwSXI3VcZS8TeW/7TZaDn9Ly
         BShvm4StWhU8yK/XgvXaHodWYMbGgiovfKtfBONEsZjLXrbG7+T8VK5eEyclmfp7NSlI
         GLVg==
X-Gm-Message-State: AOJu0YzOYj7k3A8YTvgI8kAjverldjMLfz3j/JWZ9ytPLJmlu7rbBcKy
	StVMdIz+jbk9jLAwA63c6RM=
X-Google-Smtp-Source: AGHT+IGKCQLyoySc9k+7JkPWI0iv3h9dcG59RP5cxFR1b5HDbqiQgpjgYIubmaThP8lqwpyd2UYJxw==
X-Received: by 2002:a05:6a21:a588:b0:163:ab09:196d with SMTP id gd8-20020a056a21a58800b00163ab09196dmr11949681pzc.1.1696650785890;
        Fri, 06 Oct 2023 20:53:05 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id i14-20020a63b30e000000b00584aff3060dsm3687629pgf.59.2023.10.06.20.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 20:53:05 -0700 (PDT)
Date: Fri, 6 Oct 2023 20:53:01 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Xabier Marquiegui <reibax@gmail.com>, netdev@vger.kernel.org,
	tglx@linutronix.de, jstultz@google.com, horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, alex.maftei@amd.com, davem@davemloft.net,
	rrameshbabu@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH net-next v4 4/6] ptp: support event queue reader channel
 masks
Message-ID: <ZSDWHZb7AgAm6GT+@hoboy.vegasvil.org>
References: <cover.1696511486.git.reibax@gmail.com>
 <5525d56c5feff9b28c6caa93e03d8f198d7412ce.1696511486.git.reibax@gmail.com>
 <87h6n38l0n.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6n38l0n.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 03:05:12PM -0700, Vinicius Costa Gomes wrote:

> Sorry that I only noticed a (possible) change in behavior now.
> 
> Before this series, when there was a single queue, events where
> accumulated until the application reads the fd associated with the PTP
> device. i.e. it doesn't matter when the application calls open().
> 
> AFter this series events, are only accumulated after the queue
> associated with that fd is created, i.e. after open(). Events that
> happened before open() are lost (is this true? are we leaking them?).
> 
> Is this a desired/wanted change? Is it possible that we have
> applications that depend on the "old" behavior?

So the existing behavior is not very nice to user space.  The is
forced to clear the fifo after open, like this

ts2phc_pps_sink.c:

 117 static int ts2phc_pps_sink_clear_fifo(struct ts2phc_pps_sink *sink)
 118 {
 119         struct pollfd pfd = {
 120                 .events = POLLIN | POLLPRI,
 121                 .fd = sink->clock->fd,
 122         };
 123         struct ptp_extts_event event;
 124         int cnt, size;
 125 
 126         while (1) {
 127                 cnt = poll(&pfd, 1, 0);
 128                 if (cnt < 0) {
 129                         if (EINTR == errno) {
 130                                 continue;
 131                         } else {
 132                                 pr_emerg("poll failed");
 133                                 return -1;
 134                         }
 135                 } else if (!cnt) {
 136                         break;
 137                 }
 138                 size = read(pfd.fd, &event, sizeof(event));

So, no one will miss the old behavior!

Thanks,
Richard

