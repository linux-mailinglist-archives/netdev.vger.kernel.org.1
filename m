Return-Path: <netdev+bounces-24461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D47703C9
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AA31C218CC
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE98CA73;
	Fri,  4 Aug 2023 15:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A3BA3B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:02:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308349E8
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691161344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAWIlYpJLnUymxT3pJEp6AXLP821uJJ5c8Qht/hXEKc=;
	b=jMxoj31uMilJzvmvxrYMydZ1XgHbqlWwd08eTC5S6HONBmlEUaIgYPgZSex2cOQv1ftBtG
	eM3U+OXYzDVTHLOfkTPSwigbUUZyceMLOjXhDYnX5YLCt5wk4H9coqPgypGaGvuuYSw2v2
	l29OOTv0eGzG+YznpueYHfXg+n+G/Pc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-sUhbYyqvMyKlw4kz2AdIjQ-1; Fri, 04 Aug 2023 11:02:17 -0400
X-MC-Unique: sUhbYyqvMyKlw4kz2AdIjQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso142803766b.3
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 08:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691161336; x=1691766136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAWIlYpJLnUymxT3pJEp6AXLP821uJJ5c8Qht/hXEKc=;
        b=gBVJZY6+Mt92C5hnit8YE9QfbPcP/kKElcSVgJjQntsYUFPQ3d/tbmHffS50sGDJDt
         YKKFXubHVoaV04IPsNnQMhdAfTCw/hx0QsKpKetIxFWoR8F0gOhy9aF8ZQFHEtrNKZ4Z
         mUvbJcMC1nwf0jixWvx/xLWBu6KTZrsm5FC+YMAIvBYMrBUET0V2s72aFrBvQ+BHueyw
         kBXqmced4Pnu6DNGrtDxp2kBjN7TWcMTQiuupaz4JKrRnYfMSMzCM92GvnIvWqkZgUHy
         /v9fifkP8ISEEz2rLZmirE3ajz/wAaJoyvafvUH80VgAnmBwzmmYmwbso43e0pEtIP9m
         w7iQ==
X-Gm-Message-State: AOJu0YyJNjo5JkABgwHJQ1QbY1W59MmsR63+x/nRzbwXwPbET7xWhRnl
	e19zGcU+a/N4ZwR0Q9XvAfJQoeFZYUN+TYJMKM5aUjiZdVS5ZBpVpe2unICDrYT6kO3S/iXhsF8
	XdV7sx113tzM1H/ww
X-Received: by 2002:a17:906:308d:b0:99c:5708:496f with SMTP id 13-20020a170906308d00b0099c5708496fmr1476058ejv.47.1691161336694;
        Fri, 04 Aug 2023 08:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4buQlfj5+z9A6xIc2zcmROIFoujfZijSLwc66A0Da2XFPINrE4kSVfdcb8SyEajwJi0yrCg==
X-Received: by 2002:a17:906:308d:b0:99c:5708:496f with SMTP id 13-20020a170906308d00b0099c5708496fmr1476035ejv.47.1691161336276;
        Fri, 04 Aug 2023 08:02:16 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it. [82.57.51.214])
        by smtp.gmail.com with ESMTPSA id lc21-20020a170906f91500b00992b510089asm1414920ejb.84.2023.08.04.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:02:15 -0700 (PDT)
Date: Fri, 4 Aug 2023 17:02:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <oxffffaa@gmail.com>
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [RFC PATCH v1 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <e2ytj5asmxnyb7oebxpzfuithtidwzcwxki7aao2q344sg3yru@ezqk5iezf3i4>
References: <20230801141727.481156-1-AVKrasnov@sberdevices.ru>
 <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
 <qgn26mgfotc7qxzp6ad7ezkdex6aqniv32c5tvehxh4hljsnvs@x7wvyvptizxx>
 <44fef482-579a-fed6-6e8c-d400546285fc@gmail.com>
 <bzkwqp26joyzgvqyoypyv43wv7t3b6rzs3v5hkch45yggmrzp6@25byvzqwiztb>
 <140bb8ec-f443-79f9-662b-0c4e972c8dd6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <140bb8ec-f443-79f9-662b-0c4e972c8dd6@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 05:34:20PM +0300, Arseniy Krasnov wrote:
>
>
>On 04.08.2023 17:28, Stefano Garzarella wrote:
>> On Fri, Aug 04, 2023 at 03:46:47PM +0300, Arseniy Krasnov wrote:
>>> Hi Stefano,
>>>
>>> On 02.08.2023 10:46, Stefano Garzarella wrote:
>>>> On Tue, Aug 01, 2023 at 05:17:26PM +0300, Arseniy Krasnov wrote:
>>>>> POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which was
>>>>> shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>>>>> flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>>>>>
>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>> ---
>>>>> net/vmw_vsock/af_vsock.c | 3 +++
>>>>> 1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>>> index 020cf17ab7e4..013b65241b65 100644
>>>>> --- a/net/vmw_vsock/af_vsock.c
>>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>>> @@ -1921,6 +1921,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>>>>>             err = total_written;
>>>>>     }
>>>>> out:
>>>>> +    if (sk->sk_type == SOCK_STREAM)
>>>>> +        err = sk_stream_error(sk, msg->msg_flags, err);
>>>>
>>>> Do you know why we don't need this for SOCK_SEQPACKET and SOCK_DGRAM?
>>>
>>> Yes, here is my explanation:
>>>
>>> This function checks that input error is SIGPIPE, and if so it sends SIGPIPE to the 'current' thread
>>> (except case when MSG_NOSIGNAL flag is set). This behaviour is described in POSIX:
>>>
>>> Page 367 (description of defines from sys/socket.h):
>>> MSG_NOSIGNAL: No SIGPIPE generated when an attempt to send is made on a stream-
>>> oriented socket that is no longer connected.
>>>
>>> Page 497 (description of SOCK_STREAM):
>>> A SIGPIPE signal is raised if a thread sends on a broken stream (one that is
>>> no longer connected).
>>
>> Okay, but I think we should do also for SEQPACKET:
>>
>> https://pubs.opengroup.org/onlinepubs/009696699/functions/xsh_chap02_10.html
>>
>> In 2.10.6 Socket Types:
>>
>> "The SOCK_SEQPACKET socket type is similar to the SOCK_STREAM type, and
>> is also connection-oriented. The only difference between these types is
>> that record boundaries ..."
>>
>> Then in  2.10.14 Signals:
>>
>> "The SIGPIPE signal shall be sent to a thread that attempts to send data
>> on a socket that is no longer able to send. In addition, the send
>> operation fails with the error [EPIPE]."
>>
>> It's honestly not super clear, but I assume the problem is similar with
>> seqpacket since it's connection-oriented, or did I miss something?
>>
>> For example in sctp_sendmsg() IIUC we raise a SIGPIPE regardless of
>> whether the socket is STREAM or SEQPACKET.
>
>Hm, yes, you're right. Seems check for socket type is not needed in this case,
>as this function is only for connection oriented sockets.

Ack!

>
>>
>>>
>>> Page 1802 (description of 'send()' call):
>>> MSG_NOSIGNAL
>>>
>>> Requests not to send the SIGPIPE signal if an attempt to
>>> send is made on a stream-oriented socket that is no
>>> longer connected. The [EPIPE] error shall still be
>>> returned
>>>
>>> And the same for 'sendto()' and 'sendmsg()'
>>>
>>> Link to the POSIX document:
>>> https://www.open-std.org/jtc1/sc22/open/n4217.pdf
>>>
>>> TCP (I think we must rely on it), KCM, SMC sockets (all of them are stream) work in the same
>>> way by calling this function. AF_UNIX also works in the same way, but it implements SIGPIPE handling
>>> without this function.
>>
>> I'm okay calling this function.
>>
>>>
>>> The only thing that confused me a little bit, that sockets above returns EPIPE when
>>> we have only SEND_SHUTDOWN set, but for AF_VSOCK EPIPE is returned for RCV_SHUTDOWN
>>> also, but I think it is related to this patchset.
>>
>> Do you mean that it is NOT related to this patchset?
>
>Yes, **NOT**

Got it, so if you have time when you're back, let's check also that
(not for this series as you mentioned).

Thanks,
Stefano


