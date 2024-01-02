Return-Path: <netdev+bounces-61003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09382223B
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 20:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C12284378
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D288315E96;
	Tue,  2 Jan 2024 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IycDA4TU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EDA16401
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67f9ace0006so44741966d6.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 11:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704224657; x=1704829457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8Jr197UFni9OLk3WuKNRk1S2zxszc2gQDbkeldNxlI=;
        b=IycDA4TUNpmbJ+/4UkNHxfbnw/Ys4zFx8sh2ZIc3Mt9ip6drHd7dNK7XQXm/+V7B10
         D/iQvS/sGJPWuxlP+N6rI3ePf8Dk7zXxDR2lNLVlgFe+pPdMmExeWw4uwwhzjCDclQxn
         Q8qgbAPQmFdTOEVQv8fagl5rYnlE+x7ztP52KXNG2S3s6dpfON17YN7WgcutAJJXMix+
         dmsG13FiDC7i7CJHFIPRugNet3MqsGvtQZo33hlLZKMWmWt8ynqHqbGbyHsv8gmjzG1i
         S9lQlZqXk9WoMkmfo0HIlDzmsmD4GcgMvwVSQkF7fQzjEWUi9k/PVhqhMtd6kuLVqkGC
         Jw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704224657; x=1704829457;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8Jr197UFni9OLk3WuKNRk1S2zxszc2gQDbkeldNxlI=;
        b=RQ8m2Dwmk7k1q2CBsH3YtaCeN4+ggCauV//Wyo8D0a0CXIBoDkZI/029HQ0H9k3+x9
         wSsnf4aUpb0qQBgu9535qh26PTi1hvPWm7hGuRFKIh7zPfX6BkBokFnG6Ude4GBl8At2
         UTLX45MgnzC8sKAQCKU/guFvT0ihZFnmsTL6w2B42QfWkak5ucH0/uohZ7mDtDPtrfpk
         UnnbO+4EFwlsLOAtGomHSK1UYPOSnKgGa658oQn8yEaaE2YqWjuw6rF34YQfP6/gdxLR
         kuJ6q1Ku3hBW92ABgzaEPVW6QVXvz3Cui7AQAdhb67PdM4CtZr9eXTeK4cWDlg1xdkpu
         fhLQ==
X-Gm-Message-State: AOJu0Yz/MPiMQkLuTiH2VXVIAyDFqC5GCvuaO7gSvtXMAGaxMHJVDXad
	4DrnXKXaDJhD8ml6deAh2FQ=
X-Google-Smtp-Source: AGHT+IEBjf0uka7qcdC3aRtzOw0huGvP79gnOILp3EmxiXe4aBzpT2iL8tn6S6ImyGbOFzu2Sdaxhg==
X-Received: by 2002:ad4:53ab:0:b0:680:79f1:7905 with SMTP id j11-20020ad453ab000000b0068079f17905mr6441815qvv.97.1704224657087;
        Tue, 02 Jan 2024 11:44:17 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id n2-20020a0cdc82000000b0067f49eef3b1sm10304580qvk.114.2024.01.02.11.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 11:44:16 -0800 (PST)
Date: Tue, 02 Jan 2024 14:44:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Thomas Lange <thomas@corelatus.se>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 jthinz@mailbox.tu-berlin.de, 
 arnd@arndb.de, 
 deepa.kernel@gmail.com
Message-ID: <6594679091ed9_29c0c629495@willemb.c.googlers.com.notmuch>
In-Reply-To: <dc642c69-8500-457a-a53e-6a3916ef6dab@corelatus.se>
References: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
 <65942b4270a60_291ae6294cd@willemb.c.googlers.com.notmuch>
 <dc642c69-8500-457a-a53e-6a3916ef6dab@corelatus.se>
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
> 
> On 2024-01-02 16:26, Willem de Bruijn wrote:
> > Thomas Lange wrote:
> >> It seems that net/core/sock.c is missing support for SO_TIMESTAMPING_NEW in
> >> some paths.
> >>
> >> I cross compile for a 32bit ARM system using Yocto 4.3.1, which seems to have
> >> 64bit time by default. This maps SO_TIMESTAMPING to SO_TIMESTAMPING_NEW which
> >> is expected AFAIK.
> >>
> >> However, this breaks my application (Chrony) that sends SO_TIMESTAMPING as
> >> a cmsg:
> >>
> >> sendmsg(4, {msg_name={sa_family=AF_INET, sin_port=htons(123), sin_addr=inet_addr("172.16.11.22")}, msg_namelen=16, msg_iov=[{iov_base="#\0\6 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., iov_len=48}], msg_iovlen=1, msg_control=[{cmsg_len=16, cmsg_level=SOL_SOCKET, cmsg_type=SO_TIMESTAMPING_NEW, cmsg_data=???}], msg_controllen=16, msg_flags=0}, 0) = -1 EINVAL (Invalid argument)
> >>
> >> This is because __sock_cmsg_send() does not support SO_TIMESTAMPING_NEW as-is.
> >>
> >> This patch seems to fix things and the packet is transmitted:
> >>
> >> diff --git a/net/core/sock.c b/net/core/sock.c
> >> index 16584e2dd648..a56ec1d492c9 100644
> >> --- a/net/core/sock.c
> >> +++ b/net/core/sock.c
> >> @@ -2821,6 +2821,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
> >>                   sockc->mark = *(u32 *)CMSG_DATA(cmsg);
> >>                   break;
> >>           case SO_TIMESTAMPING_OLD:
> >> +       case SO_TIMESTAMPING_NEW:
> >>                   if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
> >>                           return -EINVAL;
> >>
> >> However, looking through the module, it seems that sk_getsockopt() has no
> >> support for SO_TIMESTAMPING_NEW either, but sk_setsockopt() has.
> >> Testing seems to confirm this:
> >>
> >> setsockopt(4, SOL_SOCKET, SO_TIMESTAMPING_NEW, [1048], 4) = 0
> >> getsockopt(4, SOL_SOCKET, SO_TIMESTAMPING_NEW, 0x7ed5db20, [4]) = -1 ENOPROTOOPT (Protocol not available)
> >>
> >> Patching sk_getsockopt() is not as obvious to me though.
> >>
> >> I used a custom 6.6 kernel for my tests.
> >> The relevant code seems unchanged in net-next.git though.
> >>
> >> /Thomas
> > 
> > The fix to getsockopt is now merged:
> > 
> > https://lore.kernel.org/netdev/20231221231901.67003-1-jthinz@mailbox.tu-berlin.de/T/
> > 
> > Do you want to send the above fix to __sock_cmsg_send? 
> 
> Sure, I can do that. Do you want it sent to [net]?

Yes please. Same destination as the other patch, and same Fixes tag.


