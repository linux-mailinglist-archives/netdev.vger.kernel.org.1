Return-Path: <netdev+bounces-15155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14328745FB0
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ED41C209C3
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A3100AB;
	Mon,  3 Jul 2023 15:21:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911B100A3
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:21:47 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C0FD;
	Mon,  3 Jul 2023 08:21:45 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-57722942374so55785377b3.1;
        Mon, 03 Jul 2023 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688397705; x=1690989705;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1nlFNiWBGjT79s+TDoJWb+KEl6wO2BXh4mDpz1hVVgI=;
        b=cD0QycFMhoG5IKwO+t0fCr/obn7kNO1vRLruJ/TF6q5RPjPPOoe2z0M5+XJego18zC
         TfV1NUsOHD40U0oePG5zVkXoD7MnR+WVMyjbGnFsIxqZdehGDhJN8sCPrS6jpF2budPY
         8ZqZHl5KhQ8pq4M+C2gUyjNJaVPi/9pjuJM6xHOIXTkQs7R1YmxxMyVygAdlGwYlOpEI
         6nesyOQs31WS+YYrL6i4JqZkstM08//QfIU3PrseYV9TKfgP0BzDVo5XsPEpqd+NYSKz
         ER+xBiIM1Xo3yJN8OoxrPIOf0+/NRKclPndDvC5V2FcGYbztQV93DML2OgbzV4rIexmt
         wodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688397705; x=1690989705;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nlFNiWBGjT79s+TDoJWb+KEl6wO2BXh4mDpz1hVVgI=;
        b=C4WjBJ3s3C4KIed+VL/B6QhfNGz4ndnAPtMNV4Uj89XDzcIhF9C6RscUkwBzQkdyZs
         EXppOINOYR9LWPHwERa+aQ4Ip749/bxf63K8FrWo8CtD2kM/OfTihWE3rSpmBk39AmOi
         LJFgoK8fVzk51R7H30+XTngTniBK4EWzaSwI8t3sbor/j5QnFYV+QA6Z7b/ZPKB7kPb0
         rQVcCB+sMjdlW37cIkjrj1rffmJNYC0u3/mpQO1TkFCiTZ5UfhQdUEcBo+JwfB2jcq7K
         Vcymnm7vKIvxLYUf+Z7kYYwfuSUr5BacOZOyaDwFBV7EvkHYxEoJfrQmsMJdR3800wX8
         Nduw==
X-Gm-Message-State: ABy/qLZZoaYlIcpM4OAeZOCHvLAfsfrVCqYjwWnvxBq0/Df1etXHnNXH
	LAtnNZxzUctAou+zbzM/cI4c7kqHalWyltFUwuWuxp14acc=
X-Google-Smtp-Source: APBJJlE3cUSMFqsEKEGQdOQOsSRokmJ99kCBJs7x0Wvucr81LXIuVRDDGEbRETCuJYh9y/c/8I93tLIn6A8rqZYLcjQ=
X-Received: by 2002:a25:69c8:0:b0:ba8:6c1f:f5ad with SMTP id
 e191-20020a2569c8000000b00ba86c1ff5admr10660205ybc.29.1688397704856; Mon, 03
 Jul 2023 08:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Mon, 3 Jul 2023 17:21:34 +0200
Message-ID: <CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com>
Subject: Regression bisected to "crypto: af_alg: Convert af_alg_sendpage() to
 use MSG_SPLICE_PAGES"
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

It seems that the commit:

commit fb800fa4c1f5aee1238267252e88a7837e645c02
Author: David Howells <dhowells@redhat.com>
Date:   Tue Jun 6 14:08:55 2023 +0100

   crypto: af_alg: Convert af_alg_sendpage() to use MSG_SPLICE_PAGES

...causes a segfault in libkcapi's test suite. A simplified reproducer:

git clone https://github.com/smuellerDD/libkcapi/
cd libkcapi
autoreconf -i
./configure --enable-kcapi-test
make
./bin/kcapi -x 2 -s  -c "gcm(aes)" -i aac774c39e399e7d6371ec1d \
    -k 38bd9eb2cb29cc42ac38d6cdbe116760 \
    -a 5dbb2884f3fe93664613e863c3bd2572855cf808765880ef1fa5787ceef8c793 \
    -t 34a21cc3562f0ba141d73242e5a3b666 \
    -q d127b39d365d16246d2866b2ebabd201

The last command prints the result and then segfaults in a cleanup
free(3) call. Before the mentioned commit it printed the result and
completed successfully. I haven't dug any deeper to figure out the
root cause.

Cheers,
Ondrej

