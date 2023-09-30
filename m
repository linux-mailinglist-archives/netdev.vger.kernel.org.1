Return-Path: <netdev+bounces-37153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DCE7B3EE5
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 10:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CD40A1C2088E
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3BE8F66;
	Sat, 30 Sep 2023 08:02:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF517E9
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 08:02:01 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB8CDD
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 01:01:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so47455735e9.0
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 01:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696060917; x=1696665717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfHYxI0/k+6geCvMbeVcQWbsbc53UHVAVytgjx6G/9U=;
        b=kIhKMby6ReCCCB8C5vwrl13wDuZmYkEVOz0BZ5HHgdi7Bv7SllZW7QMYbPa2l1J/om
         dDm2V1NBlu13Lhv5zOlzRTfYqA4MlTFj8a6r5sHyhVp2fsAjUgX7v8oKMN6pAly+0kfS
         NCBKhwWzED3S2DQKUd/7e4JRcv2k2HoOpXiIrqxOMs8Vqhm0v10Hh0j7eGcXGmG4hktj
         QVw84CKvQg4kEYRHhyXTGahKu/HDvB41zNy6fpJgICCFEmbCTZGFtCRyGBCTlx0ydAEN
         0AwFpt5iDlbTnHZ7W/AEZHINfRZn7659quVrhSZFhuCz5JVtQGHu9+XICACGT6GJw+if
         hasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696060917; x=1696665717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfHYxI0/k+6geCvMbeVcQWbsbc53UHVAVytgjx6G/9U=;
        b=O3TDSZog8raK5ixHzeg4v0fjUmXFm5aBE3zQHb5RUjn7fq7zMnZUTBBFsPJFvxfXHb
         OHixy+ETYoRmXWZieuLyi0JMwizQELmcwAxNiNxffukvRm3sSb+gxptxsBTvCBDMYeNx
         90VaWRD4VMQC669Qen6opXRDJK+Ykd3WUAQLcYlMCQz8+BZ0cy/ia8uBhaNFQLgJ6/eD
         LQKi9yZbQHnqxlvRmff9XjWFViGK6fFCnOFP1DsGHYa1e5jlMDYNzTNPBpX4+uEgS8j0
         4IjIhk4D8lYTs0UAdWQ7djv8WAde0MyfhJEEhI1+xNp6OSMAzbDSEBoRYbrVGaVDc75t
         4qNg==
X-Gm-Message-State: AOJu0YxNQWCm5eDuLYozSafRWLUN0lIDl32mPrtkZc+Q0sRlPMbyGQ1o
	iolpB9SLwLR/wiWrXlU6LXyQXwiLlHlqtg==
X-Google-Smtp-Source: AGHT+IGECWChaSzjKQyo+kXfQVP/hla+y4HMaf6h6NIIP4Aj59EbfAg3dlNehPw6Hcljc+AswCPt7g==
X-Received: by 2002:a5d:6a02:0:b0:31f:facb:e1ba with SMTP id m2-20020a5d6a02000000b0031ffacbe1bamr4879118wru.70.1696060917302;
        Sat, 30 Sep 2023 01:01:57 -0700 (PDT)
Received: from Air-de-Xabier.lan ([2a0c:5a80:3e06:7600:5df4:5ca3:9797:3988])
        by smtp.gmail.com with ESMTPSA id d5-20020a056000186500b00323384e04e8sm10342951wri.111.2023.09.30.01.01.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 30 Sep 2023 01:01:56 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: vinicius.gomes@intel.com
Cc: alex.maftei@amd.com,
	chrony-dev@chrony.tuxfamily.org,
	davem@davemloft.net,
	horms@kernel.org,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com,
	richardcochran@gmail.com,
	rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v3 3/3] ptp: support event queue reader channel masks
Date: Sat, 30 Sep 2023 10:01:55 +0200
Message-ID: <20230930080155.936-1-reibax@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <87jzs84jee.fsf@intel.com>
References: <87jzs84jee.fsf@intel.com>
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

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:

> Looking below, at the usability of the API, it feels too complicated, I
> was trying to think, "how an application would change the mask for
> itself": first it would need to know the PID of the process that created
> the fd, then it would have to find the OID associated with that PID, and
> then build the request.
> 
> And it has the problem of being error prone, for example, it's easy for
> an application to override the mask of another, either by mistake or
> else.
> 
> My suggestion is to keep things simple, the "SET" only receives the
> 'mask', and it only changes the mask for that particular fd (which you
> already did the hard work of allowing that). Seems to be less error prone.
> 
> At least in my mental model, I don't think much else is needed (we
> expose only a "SET" operation), at least from the UAPI side of things.
> 
> For "debugging", i.e. discovering which applications have what masks,
> then perhaps we could do it "on the side", for example, a debugfs entry
> that lists all open file descriptors and their masks. Just an idea.
> 
> What do you think?

Thank you very much for your input Vinicius. I really appreciate it.

I totally agree with your observations. I had already thought about that angle
myself, but I decided to go this route anyway because it was the only way I
could think of meeting all of Richard's requirements at that time.

Even if being error prone, being able to externally manipulate the channel
masks is the only way I can think of to make this feature backwards compatible
with existing software. One example of a piece of software that would need to
be updated to support multiple channels is linuxptp. If you try to start ts2phc
with multiple channels enabled and no masks, it refuses to work stating that
unwanted channels are present. This would be easy to fix, incorporating the
SET operation you mention, but it is still something that needs to be changed.

Now that I think of it, it is true that nothing prevents us from having both
methods available: the simple and safe, and the complicated and unsafe.

Even with that option, I also think that going exclusively with the safe
and simple route is better.

So, I wonder: Can we just do it and require changes in software that relies
on this driver, or should we maintain compatibility at all cost?

Thank you very much for sharing your knowledge and experience.

