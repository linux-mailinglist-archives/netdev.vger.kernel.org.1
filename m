Return-Path: <netdev+bounces-32266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3C9793BF6
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460C61C20A05
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EBCDDD8;
	Wed,  6 Sep 2023 11:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AF3D9E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:58:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD78BF
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694001538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=SKAV4fdQ3q6kj6qxeQRHTIbhfVN1rKf4+zbwkUoPtTU=;
	b=iv/RcfGDiuyHYNt+uJQBJyLJEhaIdD4d0q6BExUo1AFXWbzo/GOzpGalmfjQg6wij3I2yo
	wTM7pg7RDVX3M0POTjpDJPNYV60rDpvFuXIUTfvyLHsX4JGX+uvt1qht8MYBlIhuXFS4wX
	sSuPPdTm3VGZQIWIKxRJez/u8UyVVpQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-51OrYO8DNV2EFTfTikF0dA-1; Wed, 06 Sep 2023 07:58:56 -0400
X-MC-Unique: 51OrYO8DNV2EFTfTikF0dA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-401c19fc097so22038595e9.1
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 04:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694001536; x=1694606336;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKAV4fdQ3q6kj6qxeQRHTIbhfVN1rKf4+zbwkUoPtTU=;
        b=mCF4f+xDqcYvCHwdWGT3TWTScxQ68G1bP8R+jO2OhupUpKeuHnUDPV/a96Y26jNsHr
         7KvEZ7lWFpEoXzBPuLwrRGJgmOadaIKp+nXGj0uJ1TExPOVGCqc2J7YhBwkV1Ua7h2n5
         s4rY+92PV9YVoMYm82OzIHag+qDAuQBNQTDdHhjxPMNWJpvgfUuVF25AXZakK2frCgEW
         0dI5eOoUuHeTmg3Rq+zVvYtE3vH+Sx/Kw9FemWNd6WXSjLCzgwC6XDVVH7FDcH9TiYVX
         UlcWcdcATUNAAGjG+KmkYerBcIR//Cfof4ijHWajy2sejwxEjPu2yjT6M33nT9NS9yhE
         23yQ==
X-Gm-Message-State: AOJu0YxmQUWQvMOXZPGpL+BIUizMwYhIe+L9dg/j2E6XxcTWjPCXtonE
	8XRAWuGNuPuuZaLdqePnm7nmsaOcQyXiLWCeh/ijX4QXMKHS4ny4PYze5K6Vwr+ihHpAvO7PTfv
	ffi+ugR56HCRc6ENB
X-Received: by 2002:a05:600c:b58:b0:401:bf87:989c with SMTP id k24-20020a05600c0b5800b00401bf87989cmr2026889wmr.34.1694001535742;
        Wed, 06 Sep 2023 04:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPggtM57hDQTIGuqanL6rw8QE92aXofPdGiP8puZm9Op7yO5UYaLvV6EFOToqu3n5AXS4P7w==
X-Received: by 2002:a05:600c:b58:b0:401:bf87:989c with SMTP id k24-20020a05600c0b5800b00401bf87989cmr2026874wmr.34.1694001535392;
        Wed, 06 Sep 2023 04:58:55 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.163])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c299000b00400268671c6sm19480370wmd.13.2023.09.06.04.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:58:55 -0700 (PDT)
Date: Wed, 6 Sep 2023 13:58:52 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev <netdev@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Question on tw_timer TIMER_PINNED
Message-ID: <ZPhpfMjSiHVjQkTk@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

I'm bothering you with a question about timewait_sock tw_timer, as I
believe you are one of the last persons touching it sometime ago. Please
feel free to redirect if I failed to git blame it correctly.

At my end, latency spikes (entering the kernel) have been reported when
running latency sensitive applications in the field (essentially a
polling userspace application that doesn't want any interruption at
all). I think I've been able to track down one of such interruptions to
the servicing of tw_timer_handler. This system isolates application CPUs
dynamically, so what I think it happens is that at some point tw_timer
is armed on a CPU, and it is PINNED to that CPU, meanwhile (before the
60s timeout) such CPU is 'isolated' and the latency sensitive app
started on it. After 60s the timer fires and interrupts the app
generating a spike.

I'm not very familiar with this part of the kernel and from staring
at code for a while I had mixed feeling about the need to keep tw_timer
as TIMER_PINNED. Could you please shed some light on it? Is it a strict
functional requirement or maybe a nice to have performance (locality I'd
guess) improvement? Could we in principle make it !PINNED (so that it
can be moved/queued away and prevent interruptions)?

Thanks a lot in advance!
Juri


