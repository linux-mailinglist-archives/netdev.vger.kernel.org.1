Return-Path: <netdev+bounces-29558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97741783CFA
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E69280FFB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF728F60;
	Tue, 22 Aug 2023 09:37:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521478F52
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:37:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C564ECC8
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692697023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88XKvBbvsZX0D94XbZs3LYQhbIwXeyaOzyGjFpIV09M=;
	b=dFYSAcYFGnHLCVXzwvEJU7v7iHJc/t2iu2eee5ms4dfei+t91ZIrvEYdz95aAEw5YM7aDk
	zoZtQpHLmIQ7f/rYaRuHBpR4LAU6TivEm/NZnFzWuiQp2y/EKOzJwFMLU7hA2OJ9G+xT81
	9UVQzWg1V5BjkmQk/W6IIiFWd+seaCE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-aoYDpb_vOtalBf47cmvFTg-1; Tue, 22 Aug 2023 05:37:01 -0400
X-MC-Unique: aoYDpb_vOtalBf47cmvFTg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76d8fc3ae0aso523754885a.2
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692697021; x=1693301821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88XKvBbvsZX0D94XbZs3LYQhbIwXeyaOzyGjFpIV09M=;
        b=Em3+xHDv9XHoDNhrcXKbQIgQEBZrJ1R93sP/vzAj0WKON+PqodEkwAk5F4cXR0WzYF
         gYkg9PVLQj2fDPlx3TjojQhEpZkcQ8UFmYSKbs6Mju2/MoBLlObK+JG1jft8TlU3h36y
         t7XIE5zxU+Ko3oVVKHBooDW27xARdqx13rV2R8SWhhBp0SZc6FHkgG2sJeypnYnMC2Cp
         k/k638J2a54o0mwoO4BBCQ67fn0VIh7xUbhZWAUffjjABjSqeGspQuzfA/L8nimr61hv
         WFM3hl119a3oViSdzaplWYghLBI1PVorAgdwPHC76eeei+86DGXQ/syIIeYxMa0dGpdt
         2UfA==
X-Gm-Message-State: AOJu0Yy0iXoquayqwCsZxZamrBTDpRdWZ6sf9aElHfIcemrbp+t11GTm
	WebbnfBVUkcUNixJ7WeViu4y/Gk9n0EUyydkyfzZBhir/cJ3VhXfixjC8p1IZkaulSTSeCg3BmA
	5OJvy2xidYnYWYCsT
X-Received: by 2002:a05:620a:2846:b0:76d:5d0a:bbae with SMTP id h6-20020a05620a284600b0076d5d0abbaemr11761432qkp.56.1692697020931;
        Tue, 22 Aug 2023 02:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqiiFiAb1dy2pjAQIW67i5TzCZYjsu3zaiNgThtV7tFgSZ11knhoDsrhWXkOFFbN2wgXSlMQ==
X-Received: by 2002:a05:620a:2846:b0:76d:5d0a:bbae with SMTP id h6-20020a05620a284600b0076d5d0abbaemr11761419qkp.56.1692697020641;
        Tue, 22 Aug 2023 02:37:00 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.203.174])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a126800b00767cd764ecfsm3103547qkl.33.2023.08.22.02.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 02:37:00 -0700 (PDT)
Date: Tue, 22 Aug 2023 11:36:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc: Arseniy Krasnov <oxffffaa@gmail.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [RFC PATCH v1 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <kernljom75y4nzle7s5cfid6pm6rvhf7t3zf4mrdes7oxjry23@pm7cdshzvemn>
References: <20230801141727.481156-1-AVKrasnov@sberdevices.ru>
 <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
 <qgn26mgfotc7qxzp6ad7ezkdex6aqniv32c5tvehxh4hljsnvs@x7wvyvptizxx>
 <44fef482-579a-fed6-6e8c-d400546285fc@gmail.com>
 <bzkwqp26joyzgvqyoypyv43wv7t3b6rzs3v5hkch45yggmrzp6@25byvzqwiztb>
 <140bb8ec-f443-79f9-662b-0c4e972c8dd6@gmail.com>
 <e2ytj5asmxnyb7oebxpzfuithtidwzcwxki7aao2q344sg3yru@ezqk5iezf3i4>
 <5a01c815-ae19-8f3c-2367-ca9aa74aba5f@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a01c815-ae19-8f3c-2367-ca9aa74aba5f@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 10:40:17PM +0300, Arseniy Krasnov wrote:
>
>
>On 04.08.2023 18:02, Stefano Garzarella wrote:
>> On Fri, Aug 04, 2023 at 05:34:20PM +0300, Arseniy Krasnov wrote:
>>>
>>>
>>> On 04.08.2023 17:28, Stefano Garzarella wrote:
>>>> On Fri, Aug 04, 2023 at 03:46:47PM +0300, Arseniy Krasnov wrote:
>>>>> Hi Stefano,
>>>>>
>>>>> On 02.08.2023 10:46, Stefano Garzarella wrote:
>>>>>> On Tue, Aug 01, 2023 at 05:17:26PM +0300, Arseniy Krasnov wrote:
>>>>>>> POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which was
>>>>>>> shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>>>>>>> flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>>>>>>>
>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>>> ---
>>>>>>> net/vmw_vsock/af_vsock.c | 3 +++
>>>>>>> 1 file changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>>>>> index 020cf17ab7e4..013b65241b65 100644
>>>>>>> --- a/net/vmw_vsock/af_vsock.c
>>>>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>>>>> @@ -1921,6 +1921,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>>>>>>>             err = total_written;
>>>>>>>     }
>>>>>>> out:
>>>>>>> +    if (sk->sk_type == SOCK_STREAM)
>>>>>>> +        err = sk_stream_error(sk, msg->msg_flags, err);
>>>>>>
>>>>>> Do you know why we don't need this for SOCK_SEQPACKET and SOCK_DGRAM?
>>>>>
>>>>> Yes, here is my explanation:
>>>>>
>>>>> This function checks that input error is SIGPIPE, and if so it sends SIGPIPE to the 'current' thread
>>>>> (except case when MSG_NOSIGNAL flag is set). This behaviour is described in POSIX:
>>>>>
>>>>> Page 367 (description of defines from sys/socket.h):
>>>>> MSG_NOSIGNAL: No SIGPIPE generated when an attempt to send is made on a stream-
>>>>> oriented socket that is no longer connected.
>>>>>
>>>>> Page 497 (description of SOCK_STREAM):
>>>>> A SIGPIPE signal is raised if a thread sends on a broken stream (one that is
>>>>> no longer connected).
>>>>
>>>> Okay, but I think we should do also for SEQPACKET:
>>>>
>>>> https://pubs.opengroup.org/onlinepubs/009696699/functions/xsh_chap02_10.html
>>>>
>>>> In 2.10.6 Socket Types:
>>>>
>>>> "The SOCK_SEQPACKET socket type is similar to the SOCK_STREAM type, and
>>>> is also connection-oriented. The only difference between these types is
>>>> that record boundaries ..."
>>>>
>>>> Then in  2.10.14 Signals:
>>>>
>>>> "The SIGPIPE signal shall be sent to a thread that attempts to send data
>>>> on a socket that is no longer able to send. In addition, the send
>>>> operation fails with the error [EPIPE]."
>>>>
>>>> It's honestly not super clear, but I assume the problem is similar with
>>>> seqpacket since it's connection-oriented, or did I miss something?
>>>>
>>>> For example in sctp_sendmsg() IIUC we raise a SIGPIPE regardless of
>>>> whether the socket is STREAM or SEQPACKET.
>>>
>>> Hm, yes, you're right. Seems check for socket type is not needed in this case,
>>> as this function is only for connection oriented sockets.
>>
>> Ack!
>>
>>>
>>>>
>>>>>
>>>>> Page 1802 (description of 'send()' call):
>>>>> MSG_NOSIGNAL
>>>>>
>>>>> Requests not to send the SIGPIPE signal if an attempt to
>>>>> send is made on a stream-oriented socket that is no
>>>>> longer connected. The [EPIPE] error shall still be
>>>>> returned
>>>>>
>>>>> And the same for 'sendto()' and 'sendmsg()'
>>>>>
>>>>> Link to the POSIX document:
>>>>> https://www.open-std.org/jtc1/sc22/open/n4217.pdf
>>>>>
>>>>> TCP (I think we must rely on it), KCM, SMC sockets (all of them are stream) work in the same
>>>>> way by calling this function. AF_UNIX also works in the same way, but it implements SIGPIPE handling
>>>>> without this function.
>>>>
>>>> I'm okay calling this function.
>>>>
>>>>>
>>>>> The only thing that confused me a little bit, that sockets above returns EPIPE when
>>>>> we have only SEND_SHUTDOWN set, but for AF_VSOCK EPIPE is returned for RCV_SHUTDOWN
>>>>> also, but I think it is related to this patchset.
>>>>
>>>> Do you mean that it is NOT related to this patchset?
>>>
>>> Yes, **NOT**
>>
>> Got it, so if you have time when you're back, let's check also that
>> (not for this series as you mentioned).
>
>^^^
>Hello Stefano, so:
>
>there is some confusion with check for RCV_SHUTDOWN: it presents in AF_UNIX, but missed
>in TCP (it checks only for SEND_SHUTDOWN). I performed simple test which tries
>to send data to peer which already called shutdown(SHUT_RD) - AF_UNIX and TCP behave
>differently. AF_UNIX sends SIGPIPE, while TCP allows to send data.
>
>I suggest to not touch this check for AF_VSOCK (e.g. continue work as AF_UNIX),
>because I don't see strong motivation/argument to remove it.

Yep, I agree!

However, I think it's a fairly borderline case, so unless we have a
specific request, I wouldn't spend too much time on it.

Thanks for looking at it!

Stefano


