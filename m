Return-Path: <netdev+bounces-38709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E097BC2FC
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2E5281FBE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1798F47347;
	Fri,  6 Oct 2023 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6+EXW/F"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEB844487
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:35:42 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A91BE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 16:35:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so2325648f8f.3
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696635339; x=1697240139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=socYq0gt9rTuSHsDcW8icrc/tNjJPbXYZLxAyxXLNQ4=;
        b=I6+EXW/FBQospyiWOFCWtELnWLY/VxrBOZw5OJ7Pqdu7PVNzvIWWqFUBJiZjG7aQdg
         ZaSWjNDBd1GjmLQFEfrZCqJYMxz4wZFG9OTSFYGBOQWI/PVb+1u0q0LMsPAmNIYYUFJC
         f1H3Mb4J3IKiFqO17vTU//s/JFNY0VlRO4HcABpIWVJR1DN0tPLlIH0qCZAErp9Z7SDf
         zNaU44RpAy2edDT5yqJp5d7jk0ZWtaYlK2LxJtag3nuUo+Noba7rW7gaWKYmDaH3euji
         zuWW5WY54OdpZsWKaJA3PU4G9EfuVs8HuFzg/940EUGUtKuGFnfVoaCqwTwILji5Lsmv
         hrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696635339; x=1697240139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=socYq0gt9rTuSHsDcW8icrc/tNjJPbXYZLxAyxXLNQ4=;
        b=O7JJq+3fA06Iqo6QBgMgZ3NN9UfVvn15FXs5gVJGqTYAZ/ep56Y426EKv676KGV7GS
         DsG8UlcoFBerKA0PeWejobCFw4nPqhYr1MKP44dRYKttIpDyfz84aa3DIGczWjzlaj9d
         QUrx2vBCjSvVmQuUCDSz5AomOuxVk4Yb2UlhM0YmdLVwRdsq8oa2q/agKHq0buZ4RS9X
         wsyX1IO2LQCC0vVp3D+6yGgK2ZU19tHfjrmIrbvvhvU56v1UxvTvNPCmaSBjsqAXzx93
         N/uLXEYz3MnhGpC1HhiUf/JpYSBG+ND8tkdnUCF1VQ3kXQNqXlzPZxNdGqwgaiTxd+M/
         QxnA==
X-Gm-Message-State: AOJu0YwP06sNzI09fu9OofzEBy4KBD5GplebYZbdysvy34NQIzsd9pyT
	H6j7LLnmYnvuJDpGiBj5Uu4=
X-Google-Smtp-Source: AGHT+IFVIbD1Q61dO5SxYz8kqkRvZV2HDrgahx6Mb/azro0H8INBQrqc8OBRwmQ7y0I/RHX4y99XEg==
X-Received: by 2002:adf:e606:0:b0:317:6314:96e2 with SMTP id p6-20020adfe606000000b00317631496e2mr8094698wrm.14.1696635339130;
        Fri, 06 Oct 2023 16:35:39 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3e06:7600::978])
        by smtp.gmail.com with ESMTPSA id a9-20020adfe5c9000000b003142e438e8csm2651687wrn.26.2023.10.06.16.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 16:35:38 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: reibax@gmail.com
Cc: chrony-dev@chrony.tuxfamily.org,
	davem@davemloft.net,
	horms@kernel.org,
	jstultz@google.com,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	richardcochran@gmail.com,
	rrameshbabu@nvidia.com,
	shuah@kernel.org,
	tglx@linutronix.de,
	vinicius.gomes@intel.com
Subject: Re: [PATCH net-next v4 4/6] ptp: support event queue reader channel masks
Date: Sat,  7 Oct 2023 01:35:37 +0200
Message-Id: <20231006233537.7721-1-reibax@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <5525d56c5feff9b28c6caa93e03d8f198d7412ce.1696511486.git.reibax@gmail.com>
References: <5525d56c5feff9b28c6caa93e03d8f198d7412ce.1696511486.git.reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simon Horman said:
> Hi Xabier,
>
> queue appears to be leaked here.
>
> As flagged by Smatch.

Nice catch Simon. Thank you very much. I think I know how to fix it. I
will keep it in mind for the next revision.

Vinicius Costa Gomes said:
> Sorry that I only noticed a (possible) change in behavior now.
>
> Before this series, when there was a single queue, events where
> accumulated until the application reads the fd associated with the PTP
> device. i.e. it doesn't matter when the application calls open().

You are totally correct about that observation. I had never thought of
this angle until you mentioned it. Thank you for bringing it up.

> AFter this series events, are only accumulated after the queue
> associated with that fd is created, i.e. after open(). Events that
> happened before open() are lost (is this true? are we leaking them?).

Old events are indeed lost for a new reader, but I don't see how that
could be causing a leak. The way it works is, we always have at least
one queue: the one corresponding to sysfs.

Whenever a new reader accesses the device, a new queue is created and
starts to get fed with new coming timestamps alongside the rest of
existing queues.

> Is this a desired/wanted change? Is it possible that we have
> applications that depend on the "old" behavior?

I would really like to hear the voice of more experience people on this.
On my limited experience this is a non-issue because I can control the
sequencing and I am sure to have the reader ready before I trigger events,
but you might be right that there might be some use-cases I didn't imagine
that could be affected by this change in behavior.

We could tweak the system a little bit by having an additional reference
fifo with no readers. Whenever a new ptp_open happens, I could just copy
the entire reference fifo to the new one. I guess this would bring back
the need to have the fifo mutex.

If this idea works we could be maintaining the same functionality, at the
cost of making the system be more complex and slower. Is it worth it?

I look forward to hearing opinions on this. Thank you everyone for your
feedback.


