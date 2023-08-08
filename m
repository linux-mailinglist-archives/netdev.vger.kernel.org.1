Return-Path: <netdev+bounces-25377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53708773D15
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832521C21221
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721F171A4;
	Tue,  8 Aug 2023 15:57:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A4171A3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:57:44 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AA14AAB3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:57:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52348b53bd3so1036619a12.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510210; x=1692115010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=crkOG9q4R66ImJjW7bSEbQij1Zq/bE6EUz8snPgI08A=;
        b=GFT+uJlpXneGawFgFajkwhQsx1pdpsk97WdrmyJWcEo2Ko3ZI81cNyRr4BRPmkMqeP
         lZMhZZvhdqHw4dJ3+G1U5PYJaxXR+XzH8xwJV+FEnpgOiQ82iwmKfk/6R8gd6ldUAXjz
         Mb/mpeHRkInJkHtDcayl1OegYtzLHJXf5MtgdjvlL+MeUn/JD9e/SDXZnb1vYOs8+6lV
         ecmLNB4/JN3fdMg8+jBnScYsGuMxHcXmxHy8YYl00tYRYqwmP5NvUbVABU8JNliAmuDD
         rZO/oZzHvZQYpv0HIrFKyOwwjIKsYeLY8WWgeE/fa4pqv4JuU6P3oYQMwNQ2Y9DtzsQh
         vn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510210; x=1692115010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crkOG9q4R66ImJjW7bSEbQij1Zq/bE6EUz8snPgI08A=;
        b=bXp8z6xpOPuViCs1SqjzEv/5SPDCuoTfJhYFnc9uMqFTC3I8ia5IKwjjsz1/AqLr/l
         nYYjFxWuoQuh+pSX7dJJJGJnx+1ZmB4beIleOi9494waIwvrU2S6NfrEpFDPsCSk4wvX
         2FNOVM9A0F24KpemYDfzFeihgH8u9aTmJ8TV9RVmFQ6Tc2vV7vZf4SMZxJKh1Owzflyq
         ywhHshVDDdMXTIP2ZNF5gpgeIf8rxY+zcM8p7dFd8eaE5yREseJHixz4iFeBilss8u0p
         E9XsjQMfwOMaX2b0glVoSIIsaNaNgtNpLfrOWEjDeTLpQ0zFZc9HYIck1Zy45IfXoau1
         yUZw==
X-Gm-Message-State: AOJu0YzIO1JYdDw8MwhFdMSXziPTwGdu9pX8/V2FSZsjJTflm6zZQ0C0
	/AmRrANaW7eca+vU2tFdkuqoBgBVWCnv4CSfdovbhQVP6+GoiA==
X-Google-Smtp-Source: AGHT+IGwLWnv3+6pL/yyEmC55ESx4ZCzGTsydVzYPAfZHlxLd1MFqLLZbFEjc9xbX8Tms1RV11QyZb1uQnseqgkgWaQ=
X-Received: by 2002:a05:6402:1049:b0:522:1d1d:1de8 with SMTP id
 e9-20020a056402104900b005221d1d1de8mr8647143edu.2.1691478729111; Tue, 08 Aug
 2023 00:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACymnh97H2XT4V87mCCr=NOhHVRaE5qLngUGObU_12K2rVWvzg@mail.gmail.com>
In-Reply-To: <CACymnh97H2XT4V87mCCr=NOhHVRaE5qLngUGObU_12K2rVWvzg@mail.gmail.com>
From: Yu Yat Ho <lagoho7@gmail.com>
Date: Tue, 8 Aug 2023 15:11:31 +0800
Message-ID: <CACymnh89U3b21S+fc4mkZm7GSN9=rYh5GTL4s8JnsdDR9AOS6g@mail.gmail.com>
Subject: Re: [Linux Bug Report] Binding to IP address using bind(2) seems to
 leak traffic to other interfaces
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Didn't realise I was supposed to file a bug report to the Linux
distribution I was using instead of directly emailing you.
Terribly sorry for taking up your precious time.

Just in case you are interested, the bug report I filed is at
https://bugzilla.redhat.com/show_bug.cgi?id=2229902.

Best regards,
Yat


On Tue, 8 Aug 2023 at 11:34, Yu Yat Ho <lagoho7@gmail.com> wrote:
>
> Hi all,
>
> I hope this is the correct place to report the bug I am experiencing.
>
> The problem I am seeing is that data sent through a socket bound using bind(2) seems to be leaking to other network interfaces in the system. Here are some brief steps to demonstrate the problem, it works using wget too:
>
> Set up a Linux VM (I am using Fedora 38 on VirtualBox) that has one NAT interface (has Internet access) and one host-only interface (no Internet access).
> Try to send a request using curl that is bound to the host-only interface using its interface name. It should fail to connect as expected.
>
> $ curl --interface enp0s8 icanhazip.com
>
> Try to send another request, this time bind to the host-only interface using IP address. It will somehow successfully get a response.
>
> $ curl --interface 192.168.56.103 icanhazip.com
>
> The tcpdump output shows that the packets were originated from the NAT interface (enp0s3 is the NAT interface), but they have the source IP of the host-only interface:
>
> # tcpdump -i any -nn host icanhazip.com
> tcpdump: data link type LINUX_SLL2
> dropped privs to tcpdump
> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
> listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 262144 bytes
> 10:56:34.264997 enp0s3 Out IP 192.168.56.103.57656 > 104.18.114.97.80: Flags [S], seq 2864717259, win 64240, options [mss 1460,sackOK,TS val 1169355339 ecr 0,nop,wscale 7], length 0
> 10:56:35.320888 enp0s3 Out IP 192.168.56.103.57656 > 104.18.114.97.80: Flags [S], seq 2864717259, win 64240, options [mss 1460,sackOK,TS val 1169356395 ecr 0,nop,wscale 7], length 0
> 10:56:37.368625 enp0s3 Out IP 192.168.56.103.57656 > 104.18.114.97.80: Flags [S], seq 2864717259, win 64240, options [mss 1460,sackOK,TS val 1169358443 ecr 0,nop,wscale 7], length 0
> 10:56:40.726550 enp0s3 In  IP 104.18.114.97.80 > 192.168.56.103.57656: Flags [S.], seq 64001, ack 2864717260, win 65535, options [mss 1460], length 0
> 10:56:40.726609 enp0s3 Out IP 192.168.56.103.57656 > 104.18.114.97.80: Flags [.], ack 1, win 64240, length 0
> 10:56:40.727387 enp0s3 Out IP 192.168.56.103.57656 > 104.18.114.97.80: Flags [P.], seq 1:77, ack 1, win 64240, length 76: HTTP: GET / HTTP/1.1
> 10:56:40.728146 enp0s3 In  IP 104.18.114.97.80 > 192.168.56.103.57656: Flags [.], ack 77, win 65535, length 0
> 10:56:40.739934 enp0s3 In  IP 104.18.114.97.80 > 192.168.56.103.57656: Flags [P.], seq 1:550, ack 77, win 65535, length 549: HTTP: HTTP/1.1 200 OK
> 10:56:40.739977 enp0s3 Out IP 192.168.56.103.57656 > 104.18.114.97.80: Flags [.], ack 550, win 63691, length 0
> 10:56:40.742079 enp0s3 Out IP 192.168.56.103.57656 > 104.18.114.97.80: Flags [F.], seq 77, ack 550, win 63691, length 0
> 10:56:40.742822 enp0s3 In  IP 104.18.114.97.80 > 192.168.56.103.57656: Flags [.], ack 78, win 65535, length 0
> 10:56:40.751004 enp0s3 In  IP 104.18.114.97.80 > 192.168.56.103.57656: Flags [F.], seq 550, ack 78, win 65535, length 0
> 10:56:40.751038 enp0s3 Out IP 192.168.56.103.57656 > 104.18.114.97.80: Flags [.], ack 551, win 63691, length 0
> ^C
> 13 packets captured
> 17 packets received by filter
> 0 packets dropped by kernel
>
> Here are some more info that you may be interested in:
>
> My uname -a output:
>
> Linux f38-test 6.4.7-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jul 27 20:01:18 UTC 2023 x86_64 GNU/Linux
>
> My curl -V output:
>
> curl 8.0.1 (x86_64-redhat-linux-gnu) libcurl/8.0.1 OpenSSL/3.0.9 zlib/1.2.13 brotli/1.0.9 libidn2/2.3.4 libpsl/0.21.2 (+libidn2/2.3.4) libssh/0.10.5/openssl/zlib nghttp2/1.52.0
> Release-Date: 2023-03-20
> Protocols: dict file ftp ftps gopher gophers http https imap imaps ldap ldaps mqtt pop3 pop3s rtsp scp sftp smb smbs smtp smtps telnet tftp
> Features: alt-svc AsynchDNS brotli GSS-API HSTS HTTP2 HTTPS-proxy IDN IPv6 Kerberos Largefile libz NTLM NTLM_WB PSL SPNEGO SSL threadsafe TLS-SRP UnixSockets
>
> When --interface is specified, curl binds using SO_BINDTODEVICE when given an interface name, and bind(2) when given an IP address.
> https://github.com/curl/curl/issues/11599#issuecomment-1667391636
>
> My ifconfig output (enp0s3 is the NAT interface, enp0s8 is the host-only interface):
>
> enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
>         inet6 fe80::a00:27ff:fec5:2755  prefixlen 64  scopeid 0x20<link>
>         ether 08:00:27:c5:27:55  txqueuelen 1000  (Ethernet)
>         RX packets 20  bytes 2450 (2.3 KiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 35  bytes 3150 (3.0 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>
> enp0s8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet 192.168.56.103  netmask 255.255.255.0  broadcast 192.168.56.255
>         inet6 fe80::a00:27ff:fe2f:7c6  prefixlen 64  scopeid 0x20<link>
>         ether 08:00:27:2f:07:c6  txqueuelen 1000  (Ethernet)
>         RX packets 147  bytes 14330 (13.9 KiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 256  bytes 33720 (32.9 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>
> lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
>         inet 127.0.0.1  netmask 255.0.0.0
>         inet6 ::1  prefixlen 128  scopeid 0x10<host>
>         loop  txqueuelen 1000  (Local Loopback)
>         RX packets 0  bytes 0 (0.0 B)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 0  bytes 0 (0.0 B)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>
> I will gladly provide more information should you need them, please let me know.
>
> Best regards,
> Yat

