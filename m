Return-Path: <netdev+bounces-60933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D668821EAB
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A771F22D17
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5521427C;
	Tue,  2 Jan 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlyDwsi1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144D1401C
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dbaf9b1674so5771353a34.2
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 07:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704209219; x=1704814019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlxiZB9ZdmHstotVeNHsb5Q9Fn3m46Lurhbn3decmIg=;
        b=SlyDwsi16hfLfUWp5GBD0IXGsyXlpM8spQdtNAS24hM/+YTmvwbOpnfTuLU1eT562s
         HrucRHcrSbd2KvOr6wB0xGXcxboxID8fYxAVkQ53nyRKhEclLOLLvQQodamenIqxz+HT
         qBJwPZ+FsspnY/piOmWI7tTzZNvtGb67RUUl2xdps2BvjVETewXPYvQ99RJscF/0PTob
         5vE5MfDxlJ314ovCDFYqMEfbJBqBjN+DL7oNROLdZpv6+Reh5izYAGUWY690ajfw6gNL
         KGNMMHPTa8jhL+AlYkTyfvhVCCjzccR8UycCLcylKsQjrNs3IBPquj0UJVl4ksQdkxNd
         aong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704209219; x=1704814019;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlxiZB9ZdmHstotVeNHsb5Q9Fn3m46Lurhbn3decmIg=;
        b=Pi/ya3Ekh20JuKSQmZ/XZ7blgJ3GxcDqiPj6uxrtWIb50sDL7sOI+hNBy0DSqGeJc7
         iHYo6iNNBPkCyAhWTRn+uCLUiNkQdEVRbLD2mn9MVgCqhyiBTXbnc3Z4j69LBP0X2nPB
         kyCc+EMSdNJrAMS5zxYXY5EHPBsZYPSCjYV9H7KE9ViU87DEJyB7UB6lck0AuI02vA7K
         IlfooUTJYq1wQyZSd3EgjGYpSOo/cnJOi3XVEv/08TcFiv0fKaOPTA2TQqyLVzCqshr6
         tC+FP3VjP8PhKhRxk4+Jowmp6W+xIvJLhjdmYmyzIlAPen3mxTc/eB8tqfzDmqIeWf26
         x2tw==
X-Gm-Message-State: AOJu0YzJD2WJwelo/1PHjOZdGVh3AauL8At05H6gZPdUrn2g0dSF2cVE
	Uxpamfr2Sktay22ner5JWZY=
X-Google-Smtp-Source: AGHT+IEUQcn3fsPZvoz3qfTmgDXiwQutuPsB9En9LiZFAI8SQFbMFOeRupGrdf60zUab1JVYc556aQ==
X-Received: by 2002:a05:6871:688:b0:1fb:75b:99c8 with SMTP id l8-20020a056871068800b001fb075b99c8mr16622707oao.119.1704209218958;
        Tue, 02 Jan 2024 07:26:58 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id e5-20020a05620a12c500b0076ce061f44dsm9539696qkl.25.2024.01.02.07.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:26:58 -0800 (PST)
Date: Tue, 02 Jan 2024 10:26:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Thomas Lange <thomas@corelatus.se>, 
 netdev@vger.kernel.org, 
 jthinz@mailbox.tu-berlin.de, 
 arnd@arndb.de, 
 deepa.kernel@gmail.com
Message-ID: <65942b4270a60_291ae6294cd@willemb.c.googlers.com.notmuch>
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

The fix to getsockopt is now merged:

https://lore.kernel.org/netdev/20231221231901.67003-1-jthinz@mailbox.tu-berlin.de/T/

Do you want to send the above fix to __sock_cmsg_send?



