Return-Path: <netdev+bounces-59139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937AC819776
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 05:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A021C23A3C
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 04:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401048C09;
	Wed, 20 Dec 2023 04:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9dQUGN4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79691170D
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67f0d22e4faso38497666d6.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 20:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703044833; x=1703649633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qg5ZM7wl3mdgRJVaR2HFR+uAJDIuc1ux83XRCxfF2YE=;
        b=d9dQUGN4CdfvfxunTkGiWL5KZXzD3egymSUOs5z3nCPkXj+32nh0QarVKHszUIhML0
         3vzlpRFgVH04RHI2igyeLQxx3bI5BOZudlXIsSLv+aujXoeK0nP38KaUiZ1d9laHd6lN
         cv32D0md6hFZChzvcJm9oNKfwioHSvsuhCecQs7pLIH1/8tdAVgyD/WCLVKnYE2Ar6Jp
         ER75wHfCvYS+yrUSENNopWwcX5Eb00hAlCAr5nKYwj/ema8wVBwziOvLnwXqkzlfqtv4
         Mo+FfLCxtUjxe+R9hn6Hhsw6mfXMC9tCRR2vMlbiDSOLlPnvHyCeL03JMZ/nJdftoZDY
         6jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044833; x=1703649633;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qg5ZM7wl3mdgRJVaR2HFR+uAJDIuc1ux83XRCxfF2YE=;
        b=gZtxWS+N79V5ATgFUFbxUfcaLoNSUSo9CVHP4bIuBz0QC6G4LLPmTifiD0mYVVDR8+
         wv3d+tXKIbp6tpBU2nIv9isyqOYp3NK3kmmO+il5cCUaHnLdDbVKU13KjeHQj6NKEdT+
         urwxqfBgcvWj8FdrhGUwmp0/kgzCxQWtuvqC+/T+V6XUrKjaUOb9Og+ncf0YWclZKTdd
         /DFxWc6kGw9H8SrinKnqklZaDrRMj3EkNranqYM9VA2hPVzJneRqGIyeUDKpUwOWj3nh
         SdLch915QHNxESyxXHVsorJnHUG9K5Dxn7X5109Ql+SXS1CuDX2Z8AJKQp5WGwPXvF0V
         +sOQ==
X-Gm-Message-State: AOJu0Yx4R75NjtnwBTr4poc3TSuguhHDXmW0K3wbZkGTC7kJCsjgoi/O
	8NDHxUaUSEzm2K1V7DszKrv+GFN5kDY=
X-Google-Smtp-Source: AGHT+IGaTE6ObuWRizdDugU7mUlGT0ny2YoJERYDQOEQrVb4DeDrjH+hYMLMZiT5Wt5/qPUtc3gAvg==
X-Received: by 2002:a05:6214:f6d:b0:67f:34fa:3171 with SMTP id iy13-20020a0562140f6d00b0067f34fa3171mr8984675qvb.121.1703044833656;
        Tue, 19 Dec 2023 20:00:33 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id h13-20020ac8714d000000b0042389b32e97sm10851487qtp.53.2023.12.19.20.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:00:33 -0800 (PST)
Date: Tue, 19 Dec 2023 23:00:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Thomas Lange <thomas@corelatus.se>, 
 netdev@vger.kernel.org, 
 deepa.kernel@gmail.com, 
 arnd@arndb.de
Message-ID: <658266e18643_19028729436@willemb.c.googlers.com.notmuch>
In-Reply-To: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
References: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
Subject: Re: net/core/sock.c lacks some SO_TIMESTAMPING_NEW support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Thomas Lange wrote:
> It seems that net/core/sock.c is missing support for SO_TIMESTAMPING_NEW in
> some paths.
> 
> I cross compile for a 32bit ARM system using Yocto 4.3.1, which seems to have
> 64bit time by default. This maps SO_TIMESTAMPING to SO_TIMESTAMPING_NEW which
> is expected AFAIK.
> 
> However, this breaks my application (Chrony) that sends SO_TIMESTAMPING as
> a cmsg:
> 
> sendmsg(4, {msg_name={sa_family=AF_INET, sin_port=htons(123), sin_addr=inet_addr("172.16.11.22")}, msg_namelen=16, msg_iov=[{iov_base="#\0\6 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., iov_len=48}], msg_iovlen=1, msg_control=[{cmsg_len=16, cmsg_level=SOL_SOCKET, cmsg_type=SO_TIMESTAMPING_NEW, cmsg_data=???}], msg_controllen=16, msg_flags=0}, 0) = -1 EINVAL (Invalid argument)
> 
> This is because __sock_cmsg_send() does not support SO_TIMESTAMPING_NEW as-is.
> 
> This patch seems to fix things and the packet is transmitted:
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 16584e2dd648..a56ec1d492c9 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2821,6 +2821,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>                  sockc->mark = *(u32 *)CMSG_DATA(cmsg);
>                  break;
>          case SO_TIMESTAMPING_OLD:
> +       case SO_TIMESTAMPING_NEW:
>                  if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
>                          return -EINVAL;
> 
> However, looking through the module, it seems that sk_getsockopt() has no
> support for SO_TIMESTAMPING_NEW either, but sk_setsockopt() has.

Good point. Adding the author to see if this was a simple oversight or
there was a rationale at the time for leaving it out.

> Testing seems to confirm this:
> 
> setsockopt(4, SOL_SOCKET, SO_TIMESTAMPING_NEW, [1048], 4) = 0
> getsockopt(4, SOL_SOCKET, SO_TIMESTAMPING_NEW, 0x7ed5db20, [4]) = -1 ENOPROTOOPT (Protocol not available)
> 
> Patching sk_getsockopt() is not as obvious to me though.
> 
> I used a custom 6.6 kernel for my tests.
> The relevant code seems unchanged in net-next.git though.
> 
> /Thomas



