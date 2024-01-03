Return-Path: <netdev+bounces-61237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49328822F4B
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2322283F7E
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6B51A29F;
	Wed,  3 Jan 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AGkoGxtw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D82D1A58B
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50ea226bda8so1394371e87.2
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 06:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1704291554; x=1704896354; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=zbVSOpqo56AA93/+ODXaNES/gCjGFmUJUy+xvUMVXJ4=;
        b=AGkoGxtw/5bSpDfjxQHPWtZdAQ11KI8xusECMEycf9M7aAQqh2o9MmE/4gxa6jDjZp
         qYKiMfmKo/LCcXAaK2RoT8xVbiEdl4XtftVmQX9eBKaMuDWiD2tvU3kgBSah3eNoebYo
         UfAMT3iFZxMNKSZDg+hoc3dZl6ACGVmFCDazdctOz0jhpDKEtnIOVJlnbet5NZS/QQ94
         Bz+/QiRNxItXObSxqe49r67kvoLkXCWze0cZgbM54HXTV0MUixVIBNYRfBmucCrWdNv1
         BxLyA2XfCVbszXR+sCnnLRNlHdUXBKFi44yRds8HbgVnz0YiMgtsO8KzWU9sVluHcNUV
         zC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704291554; x=1704896354;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbVSOpqo56AA93/+ODXaNES/gCjGFmUJUy+xvUMVXJ4=;
        b=NGjA5bYKzIbeD6VqrGhEdTyH2o70spB3f/uLCGSfAbLv8eiRnEvSkFF5OqvMczk3eU
         8+Dm/xwn3wlDTA4mfV0LgiYHpHFGmiQSTZ+dEn6YyASnOCbJ2qO3EZAu244D/S2YHhXU
         SPEUKRdAGW1KAf5UhKJ49yI+4oyqlyYnPj27Cq5AYgVYCw2NPfzL9GQCkjLObEqbkm53
         tab98j3OHEnZm/+FFDcBnItphFv5Bgx2FOJIQSmxcEGxFE0wBWHzsmpIlq6l9hQ/zoO6
         uGBWiWPTLFnbA38u+wyHOfa0BdhWQucFVpgwvSBa6OWrfpfwjpsHpQ02KgFOzp1iiQsH
         tRuQ==
X-Gm-Message-State: AOJu0YxpbdJom9dwQWI2NbKP4XmGx6kOTHhDri2h+/XigMu66SYrJSit
	nIfsksnAewpu+ijONoJ+/+WeLIZRM5sf5PTsHEVLwh+iSIg=
X-Google-Smtp-Source: AGHT+IHb6cmnmva2/Uofvm9LWxKvVHCSTXfZdsxvrQc2UhZ0Y/LDkxlGrYFU5RdhCbcPg98kT4ixxw==
X-Received: by 2002:a05:6512:2346:b0:50e:7dd2:4104 with SMTP id p6-20020a056512234600b0050e7dd24104mr7460365lfu.56.1704291554294;
        Wed, 03 Jan 2024 06:19:14 -0800 (PST)
Received: from cloudflare.com (79.191.62.110.ipv4.supernova.orange.pl. [79.191.62.110])
        by smtp.gmail.com with ESMTPSA id vp23-20020a17090712d700b00a27e4d34455sm3375931ejb.183.2024.01.03.06.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:19:13 -0800 (PST)
References: <20231214192939.1962891-1-edumazet@google.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next 0/2] tcp/dccp: refine source port selection
Date: Wed, 03 Jan 2024 15:17:26 +0100
In-reply-to: <20231214192939.1962891-1-edumazet@google.com>
Message-ID: <87sf3e8ppa.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 14, 2023 at 07:29 PM GMT, Eric Dumazet wrote:
> This patch series leverages IP_LOCAL_PORT_RANGE option
> to no longer favor even source port selection at connect() time.
>
> This should lower time taken by connect() for hosts having
> many active connections to the same destination.
>
> Eric Dumazet (2):
>   inet: returns a bool from inet_sk_get_local_port_range()
>   tcp/dccp: change source port selection at connect() time
>
>  include/net/ip.h                |  2 +-
>  net/ipv4/inet_connection_sock.c | 21 ++++++++++++++++-----
>  net/ipv4/inet_hashtables.c      | 27 ++++++++++++++++-----------
>  3 files changed, 33 insertions(+), 17 deletions(-)

This is great. Thank you.

# sysctl net.ipv4.ip_local_port_range
net.ipv4.ip_local_port_range = 32768    60999
# { sleep 3; stress-ng --sockmany 1 --sockmany-ops 20000; } & \
> /usr/share/bcc/tools/funclatency inet_hash_connect
[1] 240
Tracing 1 functions for "inet_hash_connect"... Hit Ctrl-C to end.
stress-ng: info:  [243] defaulting to a 1 day, 0 secs run per stressor
stress-ng: info:  [243] dispatching hogs: 1 sockmany
stress-ng: info:  [243] skipped: 0
stress-ng: info:  [243] passed: 1: sockmany (1)
stress-ng: info:  [243] failed: 0
stress-ng: info:  [243] metrics untrustworthy: 0
stress-ng: info:  [243] successful run completed in 27.60 secs
^C
     nsecs               : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |
       256 -> 511        : 0        |                                        |
       512 -> 1023       : 511      |**                                      |
      1024 -> 2047       : 8698     |****************************************|
      2048 -> 4095       : 2870     |*************                           |
      4096 -> 8191       : 1471     |******                                  |
      8192 -> 16383      : 389      |*                                       |
     16384 -> 32767      : 114      |                                        |
     32768 -> 65535      : 43       |                                        |
     65536 -> 131071     : 15       |                                        |
    131072 -> 262143     : 0        |                                        |
    262144 -> 524287     : 1        |                                        |
    524288 -> 1048575    : 1        |                                        |
   1048576 -> 2097151    : 3        |                                        |
   2097152 -> 4194303    : 1609     |*******                                 |
   4194304 -> 8388607    : 4272     |*******************                     |
   8388608 -> 16777215   : 4        |                                        |

avg = 1314821 nsecs, total: 26297744706 nsecs, count: 20001

Detaching...
[1]+  Done                    { sleep 3; stress-ng --sockmany 1 --sockmany-ops 20000; }
# { sleep 3; LD_PRELOAD=./setsockopt_ip_local_port_range.so stress-ng --sockmany 1 --sockmany-ops 20000; } & \
> /usr/share/bcc/tools/funclatency inet_hash_connect
[1] 246
Tracing 1 functions for "inet_hash_connect"... Hit Ctrl-C to end.
stress-ng: info:  [249] defaulting to a 1 day, 0 secs run per stressor
stress-ng: info:  [249] dispatching hogs: 1 sockmany
stress-ng: info:  [249] skipped: 0
stress-ng: info:  [249] passed: 1: sockmany (1)
stress-ng: info:  [249] failed: 0
stress-ng: info:  [249] metrics untrustworthy: 0
stress-ng: info:  [249] successful run completed in 1.01 secs
^C
     nsecs               : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |
       256 -> 511        : 0        |                                        |
       512 -> 1023       : 2085     |******                                  |
      1024 -> 2047       : 13401    |****************************************|
      2048 -> 4095       : 3877     |***********                             |
      4096 -> 8191       : 561      |*                                       |
      8192 -> 16383      : 60       |                                        |
     16384 -> 32767      : 16       |                                        |
     32768 -> 65535      : 2        |                                        |

avg = 1768 nsecs, total: 35376609 nsecs, count: 20002

Detaching...
[1]+  Done                    { sleep 3; LD_PRELOAD=./setsockopt_ip_local_port_range.so stress-ng --sockmany 1 --sockmany-ops 20000; }
# cat ./setsockopt_ip_local_port_range.c
#include <dlfcn.h>
#include <linux/in.h>
#include <sys/socket.h>

int socket(int domain, int type, int protocol)
{
        int (*socket_fn)(int, int, int) = dlsym(RTLD_NEXT, "socket");
        int fd;

        fd = socket_fn(domain, type, protocol);
        if (fd < 0)
                return -1;

        if (domain == AF_INET || domain == AF_INET6) {
                setsockopt(fd, IPPROTO_IP, IP_LOCAL_PORT_RANGE,
                           &(__u32){ 0xffffU << 16 }, sizeof(__u32));
        }

        return fd;
}
#

