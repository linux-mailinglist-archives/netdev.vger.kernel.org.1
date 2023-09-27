Return-Path: <netdev+bounces-36434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730797AFC30
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 09:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5856A1C20869
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 07:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F45114AB6;
	Wed, 27 Sep 2023 07:38:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB912575
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 07:37:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AED126
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695800275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzmdkgJVacl611f+REy0nRFcZdf1f4FGc4mWf9kNvKg=;
	b=DhlnTdlGZGwXrRxwmmatqNNB0Wx605JKjC5CJqBYOLFPHWFHziSiSAs7RLdlAMaFfoqYzC
	D6uwmbz7ebnsrBlS7opUT82+AV4Ampvcs4AtvXiL2Aw25jovW8GKzJaADOM8IWYVOojFIN
	f/+xmy/SVKN3115/SpsJ/WEvE+a2uuE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-gYR72qWqNluqTorwZg8QdQ-1; Wed, 27 Sep 2023 03:37:52 -0400
X-MC-Unique: gYR72qWqNluqTorwZg8QdQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-405917470e8so58166825e9.1
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695800271; x=1696405071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzmdkgJVacl611f+REy0nRFcZdf1f4FGc4mWf9kNvKg=;
        b=JNujm8Oa1VNvtERTD7CI314XUPm+JvgCYwHh/jaQk+uPiKtzOD5aJElmlHWBIdLwMz
         J+lmCzL5Lpq5nFg8XxlMzDVwvM6hapHoaVRJuY0HdSUOpI5HAxq8KU8eahdTCjWTTIa4
         1Gc2gZ0RYAJ+4a5PMLRVbl1v+IS2YffJMM5UZjWTBOe4Iadvf5OsSHwBzK2Dg3mIUE/k
         0sSAOu2hujpv/1yTTEl3ZTqlaCSz03vv9xjFzTjt1io6KXWfDW9E1RBHSgGHXIKDpo3N
         axxBxJOseRe6xhsmyPOKJr25QFQhsG3Li6yXen6LlSsbYgxRwvAwXXQFh20A9h3J3zDQ
         tLfQ==
X-Gm-Message-State: AOJu0YzmK+KzVWnhM394TOojCsJEaxdQXEvQj3jJPT9VIsuuXJT2CmQb
	r+O9seDRKCE9zVBuKJdEObUzY1sBvuEqoaaw7JH/QgjwWZcSzwI5AjUpBPk6Y9N+4LM6pmO1/ow
	5QUE5yTsQiXU3xs6398ggmiDg
X-Received: by 2002:a05:600c:214:b0:401:bcb4:f133 with SMTP id 20-20020a05600c021400b00401bcb4f133mr1317735wmi.22.1695800270779;
        Wed, 27 Sep 2023 00:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6GTWPyjdRalcEyKRa4+1Afbjfckld/pyknV9vE0PjXAKdAdSloWwE+dhutPySlcYVRFQJ4w==
X-Received: by 2002:a05:600c:214:b0:401:bcb4:f133 with SMTP id 20-20020a05600c021400b00401bcb4f133mr1317712wmi.22.1695800270393;
        Wed, 27 Sep 2023 00:37:50 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.19.70])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm2530401wrn.114.2023.09.27.00.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 00:37:49 -0700 (PDT)
Date: Wed, 27 Sep 2023 09:37:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v1 12/12] test/vsock: io_uring rx/tx tests
Message-ID: <46h5yyg62ize2woqu6rp5ebffuhrivo4y7fw3iknicozcaxiz5@ojfvm6qeqzam>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-13-avkrasnov@salutedevices.com>
 <kfuzqzhrgdk5f5arbq4n3vd6vro6533aeysqhdgqevcqxrdm6e@57ylpkc2t4q4>
 <708be048-862f-76ee-6671-16b54e72e5a8@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <708be048-862f-76ee-6671-16b54e72e5a8@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 11:00:19PM +0300, Arseniy Krasnov wrote:
>
>
>On 26.09.2023 16:04, Stefano Garzarella wrote:
>> On Fri, Sep 22, 2023 at 08:24:28AM +0300, Arseniy Krasnov wrote:
>>> This adds set of tests which use io_uring for rx/tx. This test suite is
>>> implemented as separated util like 'vsock_test' and has the same set of
>>> input arguments as 'vsock_test'. These tests only cover cases of data
>>> transmission (no connect/bind/accept etc).
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>> Changelog:
>>> v5(big patchset) -> v1:
>>>  * Use LDLIBS instead of LDFLAGS.
>>>
>>> tools/testing/vsock/Makefile           |   7 +-
>>> tools/testing/vsock/vsock_uring_test.c | 321 +++++++++++++++++++++++++
>>> 2 files changed, 327 insertions(+), 1 deletion(-)
>>> create mode 100644 tools/testing/vsock/vsock_uring_test.c
>>>
>>> diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>>> index 1a26f60a596c..c84380bfc18d 100644
>>> --- a/tools/testing/vsock/Makefile
>>> +++ b/tools/testing/vsock/Makefile
>>> @@ -1,12 +1,17 @@
>>> # SPDX-License-Identifier: GPL-2.0-only
>>> +ifeq ($(MAKECMDGOALS),vsock_uring_test)
>>> +LDLIBS = -luring
>>> +endif
>>> +
>>
>> This will fails if for example we call make with more targets,
>> e.g. `make vsock_test vsock_uring_test`.
>>
>> I'd suggest to use something like this:
>>
>> --- a/tools/testing/vsock/Makefile
>> +++ b/tools/testing/vsock/Makefile
>> @@ -1,13 +1,11 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> -ifeq ($(MAKECMDGOALS),vsock_uring_test)
>> -LDLIBS = -luring
>> -endif
>> -
>>  all: test vsock_perf
>>  test: vsock_test vsock_diag_test
>>  vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o
>>  vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>>  vsock_perf: vsock_perf.o
>> +
>> +vsock_uring_test: LDLIBS = -luring
>>  vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o
>>
>>  CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
>>
>>> all: test vsock_perf
>>> test: vsock_test vsock_diag_test
>>> vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o
>>> vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>>> vsock_perf: vsock_perf.o
>>> +vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o
>>
>> Shoud we add this new test to the "test" target as well?
>
>Ok, but in this case, this target will always depend on liburing.

I think it's fine.

If they want to run all the tests, they need liburing. If they don't
want to build io_uring tests, they can just do `make vsock_test`.

Stefano


