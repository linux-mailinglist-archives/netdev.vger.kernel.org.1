Return-Path: <netdev+bounces-63263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054E882C02D
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946C41F21859
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5C559B64;
	Fri, 12 Jan 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O5qQm374"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55B59B4E
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28b1095064so712090166b.2
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 04:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705064181; x=1705668981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xBU27MlZTqHSaK+9/DPt2UFYW7bDObb/k/9gGJLMPrg=;
        b=O5qQm374NVsuLP81ChDSX3i0slk0AY+IGa6tQKfb51rsy244fuilpRVmAwBAtkgDiL
         44LPM2daVtOkpftsVlS6a370BPG/FVpwuOBbA+i5ERyz4Yaycmr/BDOw5/5RW7Hfz9zj
         JNc4pC3BBoSvdyKBk6EohBXsZQ+G1SxEnq1GOgNeuKQY0pcvUolsZEAMT8Ns3EzVoCo/
         NZY8/IT1mfBAKcOAj+p48qrTTdMl2Uvb74hpi8qNNMNQQoXi6xGjnqUorvE7Te5b69he
         peXBn7TD6QJJtr6TmA/1MUAytREK07W3IMcJ5dqWseQC3V2I8Ff+a08S0uEFjKKU44MX
         2dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705064181; x=1705668981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBU27MlZTqHSaK+9/DPt2UFYW7bDObb/k/9gGJLMPrg=;
        b=L8l3GUnX/Msu81vsFnKq2nUT2O2n2qq2iQEHDClsSejVZ4HIFmjjtK8b8VPOFFZa54
         vWq37NdtIDyzPJxQerpbmGdaxTMbDr/RmAu6c4jRTyOsEyHqI8Wl0PjtZVKue0nK6dng
         6OqNVso3s8WzoLCG2nTLgwUo7y1p0MkACFe3QGWF8x229O27qqJGRqRCP1U8AIVL9iOx
         WS/miJV8TmRRTDB/mVc7eeA5nDWNauU+K4+yCXCUBYe6wOBc6y0uFrYWY4Sfc3owGsbP
         JHXVpf7xPWMuNsu2MNwCpPh02f7Z4B4YBQegmbuZVx2185cKkTg8Zoo/e8+0/K4wg3go
         /JLw==
X-Gm-Message-State: AOJu0YzFNDMwBnVPV8i0rVOp5wdUAa5aenDSCy5Sbx5GBZJ7khDNkuYN
	P84nCxluOG4Le97TmI93oGo7Q8FqQmXGgg==
X-Google-Smtp-Source: AGHT+IFi3Xi8S8VOkUT686qJLuycjNVr+AkQBJHqrhrYDUCFIhQDogT0K0tvurM9Itkv5Zy3hAM33w==
X-Received: by 2002:a17:907:20e3:b0:a2b:2615:25d1 with SMTP id rh3-20020a17090720e300b00a2b261525d1mr297878ejb.90.1705064181034;
        Fri, 12 Jan 2024 04:56:21 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id y23-20020a170906559700b00a269357c2e7sm1764202ejp.36.2024.01.12.04.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 04:56:20 -0800 (PST)
Date: Fri, 12 Jan 2024 13:56:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com
Subject: Re: [PATCH net] udp: annotate data-races around up->pending
Message-ID: <ZaE28zQdlP0hhWOD@nanopsycho>
References: <20240112104427.324983-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112104427.324983-1-edumazet@google.com>

Fri, Jan 12, 2024 at 11:44:27AM CET, edumazet@google.com wrote:
>up->pending can be read without holding the socket lock,
>as pointed out by syzbot [1]
>
>Add READ_ONCE() in lockless contexts, and WRITE_ONCE()
>on write side.
>
>[1]
>BUG: KCSAN: data-race in udpv6_sendmsg / udpv6_sendmsg
>
>write to 0xffff88814e5eadf0 of 4 bytes by task 15547 on cpu 1:
> udpv6_sendmsg+0x1405/0x1530 net/ipv6/udp.c:1596
> inet6_sendmsg+0x63/0x80 net/ipv6/af_inet6.c:657
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg net/socket.c:745 [inline]
> __sys_sendto+0x257/0x310 net/socket.c:2192
> __do_sys_sendto net/socket.c:2204 [inline]
> __se_sys_sendto net/socket.c:2200 [inline]
> __x64_sys_sendto+0x78/0x90 net/socket.c:2200
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>read to 0xffff88814e5eadf0 of 4 bytes by task 15551 on cpu 0:
> udpv6_sendmsg+0x22c/0x1530 net/ipv6/udp.c:1373
> inet6_sendmsg+0x63/0x80 net/ipv6/af_inet6.c:657
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg net/socket.c:745 [inline]
> ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2586
> ___sys_sendmsg net/socket.c:2640 [inline]
> __sys_sendmmsg+0x269/0x500 net/socket.c:2726
> __do_sys_sendmmsg net/socket.c:2755 [inline]
> __se_sys_sendmmsg net/socket.c:2752 [inline]
> __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2752
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>value changed: 0x00000000 -> 0x0000000a
>
>Reported by Kernel Concurrency Sanitizer on:
>CPU: 0 PID: 15551 Comm: syz-executor.1 Tainted: G        W          6.7.0-syzkaller #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>
>Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>Reported-by: syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com
>Link: https://lore.kernel.org/netdev/0000000000009e46c3060ebcdffd@google.com/
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

