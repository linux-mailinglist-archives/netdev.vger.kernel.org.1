Return-Path: <netdev+bounces-33667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312D379F241
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 21:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E225E2817CF
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 19:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5000D1A72C;
	Wed, 13 Sep 2023 19:39:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276B1A708
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 19:39:56 +0000 (UTC)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB8019A0
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 12:39:55 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34f5357cca7so250095ab.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694633995; x=1695238795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tft1HooN87hi/19RuephXAGarkXU4BD94o5nCoYckJ8=;
        b=pNQ0oV1Wwn3LRIFz/Kn8b8xec3OuZPtPpz/wzOcOfDndpvgi6/oE8Y8qDS1W23RBl/
         gsjsyUxgzV9SIXxLsBhEz80kFbNmjjpntZ2K+hIlCRuuIDc00ARCHjsP2qjsFFYtU+8d
         adccqSp4pwsT+Mz+rfrjOUbXf5MZkx2ttYieZyLeznSDIVl7vxk/UVTDRNWzfEImsJa2
         PYLUNpD6cKeZ9HGUhFlqIKpCKka8NMUE/rvZWMq+HUQfLMg3SlO+OdX865sPO7923rkw
         ZPICN4yBO6BpIhqGWUztAfkHMugorYZALESivKg4DLoAmMinwMhcfYZGwuIXziPys7SH
         SleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633995; x=1695238795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tft1HooN87hi/19RuephXAGarkXU4BD94o5nCoYckJ8=;
        b=MSUd8kVx8tzVM/YruFDGcPhmXhO2Z+FOMctnQCSVqrXi6sWduXgII5H4+/1YMCpjz+
         hH1va8fbDFKWtslJItXRmmUTOXgmxT4+XRvn3SLyQE4omAPN8rNO4rtFJe0+nU2gmPza
         2yRp5466ed3pMIg92kFNK2/vJaDYivvjN9Iu6UqbEedGiW3H6A7iy+W2+sYyRyIpMbYY
         y7tpvNQD4N1QN3NVSLwtwWJYMCkqx9MB/zwsWpaMe/Q2loY2fbfFmnLWpkkD9Iz7BKqV
         X6FSoH6Cb7XKl3UbBJqmKzAAemX0QFUVNimGUww0FjBgXXnNbNd0jkzX+IgeGlD/uhja
         cH5A==
X-Gm-Message-State: AOJu0YzAVHeFgnvLqWecuRvreq8fdkuJQtu/XsER21KSPIBOwd78lloV
	QcrH7L1G693Oq4Wxx5yT8W4CdQ==
X-Google-Smtp-Source: AGHT+IGtBzcobfCWCkQ5HPj4+SqKK9ECxFRGlGCGQqDAtr3vPCIrAPClhL0Dsulx18cZsBLQCEwl2g==
X-Received: by 2002:a92:d986:0:b0:349:4e1f:e9a0 with SMTP id r6-20020a92d986000000b003494e1fe9a0mr3254955iln.2.1694633994913;
        Wed, 13 Sep 2023 12:39:54 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d4-20020a056e02214400b0034ac1a32fd9sm2500863ilv.44.2023.09.13.12.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 12:39:54 -0700 (PDT)
Message-ID: <efe602f1-8e72-466c-b796-0083fd1c6d82@kernel.dk>
Date: Wed, 13 Sep 2023 13:39:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] io_uring/cmd: Introduce SOCKET_URING_OP_SETSOCKOPT
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, sdf@google.com, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 martin.lau@linux.dev, krisman@suse.de
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org
References: <20230913152744.2333228-1-leitao@debian.org>
 <20230913152744.2333228-8-leitao@debian.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230913152744.2333228-8-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/23 9:27 AM, Breno Leitao wrote:
> Add support for SOCKET_URING_OP_SETSOCKOPT. This new command is similar
> to setsockopt(2). This implementation leverages the function
> do_sock_setsockopt(), which is shared with the setsockopt() system call
> path.
> 
> Important to say that userspace needs to keep the pointer's memory alive
> until the operation is completed. I.e, the memory could not be
> deallocated before the CQE is returned to userspace.

This is different than other commands that write data. Since
IORING_FEAT_SUBMIT_STABLE was introduced, any command that writes data
should ensure that this data is stable. Eg it follows the life time of
the SQE, and doesn't need to be available until a CQE has been posted
for it. This is _generally_ true, even if we do have a few exceptions.

The problem is that then you cannot use user pointers, obviously, you'd
need to be able to pass in the value directly to do_sock_setsockopt()...

-- 
Jens Axboe


