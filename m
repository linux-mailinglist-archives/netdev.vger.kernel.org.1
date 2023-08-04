Return-Path: <netdev+bounces-24438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9052C7702FB
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C1C2826F6
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379C9CA5E;
	Fri,  4 Aug 2023 14:28:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247FDCA4F
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:28:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA7F46BB
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691159313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6TKiUoe55IIrqSia7IbdrPQay+jmTfT+IM/4+k+lpc=;
	b=MKI3CCERI1Ot67kFpsQ/GyHxjAveuNgaqqifMV8reE4ee9n2UYjIBZMqSsdsj4xmOrDChU
	Lf5nkM1kjJC0V6EYQYWmvLWLk6NkrvoPI5TceMNmbrjz6tUoNx/Y0VGryaWPS7VYOjm4qD
	ULNz9nU7lA3dJnSSHtqApt5mPhCpdsM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-eYEJna0MPv2kNiL1mS3WZA-1; Fri, 04 Aug 2023 10:28:31 -0400
X-MC-Unique: eYEJna0MPv2kNiL1mS3WZA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63d566837d3so24118386d6.3
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691159311; x=1691764111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6TKiUoe55IIrqSia7IbdrPQay+jmTfT+IM/4+k+lpc=;
        b=hLoi3aF+P0KOtuU2oWtY0iFe2uOkvJByaIpBHDuVQBRUNiGGHbOswj+rRRrg/xzpQB
         NcsNxAJNKUaKUFZ6hUOpsWddHGR74EesB4ZGjGOUtPvnKX1XMUyxfdE6jIRntlTGgkab
         aB77hwDd1Cb8n0p9We0AGPVCCTaprox+F5+ZhEfy+Od9c9TlQNromF1rrFzXedncSO6J
         bOUWHRM67bHPQT4cNYwZllFN1ykU77C3d4d3Sz5AC36kjX1ZVaBWSh5cGEJRBqW0dhgZ
         qGBJhpNcSAOZFNl6Z1ICPqJtzFiNnDN9CcPpyYX770DVbGV651axKJQmnPZ//+/4pEw1
         Qv1w==
X-Gm-Message-State: AOJu0YzniHYqNBUrj5G2/y+ZCsqV8q+CgwGLjyRfGaszKqS5fpNpV/ir
	3fqPN3m8OnGiBDDLpoRvI8SBc7hC8gD45+KUfOypNVg2F8oB987i+ueIuqLlxbncTSSJMlrjg+N
	9NEmnTvAtuWecfl+n
X-Received: by 2002:a0c:9d04:0:b0:63c:eb1e:e004 with SMTP id m4-20020a0c9d04000000b0063ceb1ee004mr1771020qvf.3.1691159310919;
        Fri, 04 Aug 2023 07:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQOm1oB5/xrHwYk3PxdGj4/DBN9i2DE5i3OHfDF64MaIhm95kSdYL67jDQe5etcx8sQx28kw==
X-Received: by 2002:a0c:9d04:0:b0:63c:eb1e:e004 with SMTP id m4-20020a0c9d04000000b0063ceb1ee004mr1770996qvf.3.1691159310619;
        Fri, 04 Aug 2023 07:28:30 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it. [82.57.51.214])
        by smtp.gmail.com with ESMTPSA id d30-20020a0caa1e000000b00637abbfaac9sm698043qvb.98.2023.08.04.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:28:30 -0700 (PDT)
Date: Fri, 4 Aug 2023 16:28:25 +0200
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
Message-ID: <bzkwqp26joyzgvqyoypyv43wv7t3b6rzs3v5hkch45yggmrzp6@25byvzqwiztb>
References: <20230801141727.481156-1-AVKrasnov@sberdevices.ru>
 <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
 <qgn26mgfotc7qxzp6ad7ezkdex6aqniv32c5tvehxh4hljsnvs@x7wvyvptizxx>
 <44fef482-579a-fed6-6e8c-d400546285fc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44fef482-579a-fed6-6e8c-d400546285fc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 03:46:47PM +0300, Arseniy Krasnov wrote:
>Hi Stefano,
>
>On 02.08.2023 10:46, Stefano Garzarella wrote:
>> On Tue, Aug 01, 2023 at 05:17:26PM +0300, Arseniy Krasnov wrote:
>>> POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which was
>>> shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>>> flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 020cf17ab7e4..013b65241b65 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1921,6 +1921,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>>>             err = total_written;
>>>     }
>>> out:
>>> +    if (sk->sk_type == SOCK_STREAM)
>>> +        err = sk_stream_error(sk, msg->msg_flags, err);
>>
>> Do you know why we don't need this for SOCK_SEQPACKET and SOCK_DGRAM?
>
>Yes, here is my explanation:
>
>This function checks that input error is SIGPIPE, and if so it sends SIGPIPE to the 'current' thread
>(except case when MSG_NOSIGNAL flag is set). This behaviour is described in POSIX:
>
>Page 367 (description of defines from sys/socket.h):
>MSG_NOSIGNAL: No SIGPIPE generated when an attempt to send is made on a stream-
>oriented socket that is no longer connected.
>
>Page 497 (description of SOCK_STREAM):
>A SIGPIPE signal is raised if a thread sends on a broken stream (one that is
>no longer connected).

Okay, but I think we should do also for SEQPACKET:

https://pubs.opengroup.org/onlinepubs/009696699/functions/xsh_chap02_10.html

In 2.10.6 Socket Types:

"The SOCK_SEQPACKET socket type is similar to the SOCK_STREAM type, and
is also connection-oriented. The only difference between these types is
that record boundaries ..."

Then in  2.10.14 Signals:

"The SIGPIPE signal shall be sent to a thread that attempts to send data
on a socket that is no longer able to send. In addition, the send
operation fails with the error [EPIPE]."

It's honestly not super clear, but I assume the problem is similar with
seqpacket since it's connection-oriented, or did I miss something?

For example in sctp_sendmsg() IIUC we raise a SIGPIPE regardless of
whether the socket is STREAM or SEQPACKET.

>
>Page 1802 (description of 'send()' call):
>MSG_NOSIGNAL
>
>Requests not to send the SIGPIPE signal if an attempt to
>send is made on a stream-oriented socket that is no
>longer connected. The [EPIPE] error shall still be
>returned
>
>And the same for 'sendto()' and 'sendmsg()'
>
>Link to the POSIX document:
>https://www.open-std.org/jtc1/sc22/open/n4217.pdf
>
>TCP (I think we must rely on it), KCM, SMC sockets (all of them are stream) work in the same
>way by calling this function. AF_UNIX also works in the same way, but it implements SIGPIPE handling
>without this function.

I'm okay calling this function.

>
>The only thing that confused me a little bit, that sockets above returns EPIPE when
>we have only SEND_SHUTDOWN set, but for AF_VSOCK EPIPE is returned for RCV_SHUTDOWN
>also, but I think it is related to this patchset.

Do you mean that it is NOT related to this patchset?

Thanks,
Stefano


