Return-Path: <netdev+bounces-34812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99D7A5501
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8F91C209DE
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC6228DB1;
	Mon, 18 Sep 2023 21:26:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D228DAC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 21:26:05 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D91890
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:26:04 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-44d5c49af07so2038830137.2
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695072363; x=1695677163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL47fE9GczhHo64YJNF23PxVQ0nZVrLZ8XkIKXNXNbU=;
        b=Zx7+oO4lY4SCnTFe6GMlPw5k+jIsmRP3Zjrkwlf1oPahAeGNNjqBEgBGeIETLJvU1r
         8WUnEIquEXqVlwj6XDxg3GR4RdVxmb1oU1BBIuTs/2fV9+MuP3bmeGlKSxUCF8oTSjyu
         sKVzife8K8wz2Q4uNfaZYxEgXihL8xUZh04GCJsg5h04A4QUj7Mnn69K+i8Xu53Pth50
         sqRgO6WWMgOI1/rikgB5dgMrBBVzaEXgSKr5nNjssaC3kpRcZJO1Uk4gHYsUD1DGvprN
         s9LYaGD7273YCJm8OAH6owrL6XoK0jusqh9MAAMzUOpAWTkZLnbdFM73oVW6Y90uoc+u
         7rVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695072363; x=1695677163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL47fE9GczhHo64YJNF23PxVQ0nZVrLZ8XkIKXNXNbU=;
        b=QQzLH9mSUF/d1myAWqxzIbEOfkHhZPNyAJ3zt854InDRYxYtG5j4wQxstdqzL6OfTE
         HJFBSwzohZIOWYR0jWm0J9KsysMWUB7ClLm/EI+Q1sj3fDOh4Y1SHGnDGrN/nBmYgg0Q
         EGaMZdQIkHSec+h9AgvaR6h7o17TqaRnEWOoHnEwzhtrjVX06+2NMqNpAKK8RBh1QUCT
         RWxO79q/RNY6GbNVAGfIqx3DfFvTmfZ5WhKfiQMhc7aX140ILjHniSVU0M5upJQ+eExK
         gII/VtwdglH8Rg87TQogVlt3Y8RzAM9+NmVwOxhctxUIIpzlRTutvEcbbVslBRqei7rg
         NQEw==
X-Gm-Message-State: AOJu0YyIZefm0MWHx9OpiA8vPqN1XxCHoP8gGfSdhk81tAAHq1rcwG62
	077+0Yw4LGS4AWpq/mvcaT2vJRcs0YvUbIkfurc=
X-Google-Smtp-Source: AGHT+IG2Ef1nos0o/zR5tkh3mu75TWcH/oXpQeVvAhq7STthd1IAVAh5XC6zRNp+sFQCXz15hppntxLQC4KkG+Y1WQE=
X-Received: by 2002:a05:6102:1586:b0:452:71ea:551d with SMTP id
 g6-20020a056102158600b0045271ea551dmr3451955vsv.11.1695072363439; Mon, 18 Sep
 2023 14:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com> <20230918025021.4078252-2-jrife@google.com>
 <CAF=yD-KoKAv_uPR+R+RkVbc3Lm3PREao-n7F1QckPWeW9v6JqA@mail.gmail.com>
 <CADKFtnQnOnaq_3_o5OoWpuMvzTgzL2qKcY5oc=AbdZJvONSyKQ@mail.gmail.com>
 <CAF=yD-+DmargLvi=i-YJ6JCJov8xYEbyQf8+KhQ00UTYry_9UQ@mail.gmail.com>
 <CADKFtnSoB+_RjEJZsvkM9TpEm6xmmATnBL0jj7n-JbFAxbBc-A@mail.gmail.com> <CADKFtnR5WANzLqA=WE_2Stii8aDPGy7Hi2tUReF1BtWe5FqOMw@mail.gmail.com>
In-Reply-To: <CADKFtnR5WANzLqA=WE_2Stii8aDPGy7Hi2tUReF1BtWe5FqOMw@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 18 Sep 2023 17:25:27 -0400
Message-ID: <CAF=yD-J6YNpsbZvaoqZ=u1Do65ej35wRZeZ+4Dwwx-hv+zwrog@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] net: prevent rewrite of msg_name in sock_sendmsg()
To: Jordan Rife <jrife@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 4:49=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> Just a heads up, there are also kernel_recvmsg/sock_recvmsg functions
> that mirror the kernel_sendmsg/sock_sendmsg. If we are are doing this
>
> > 1) Rename the current kernel_sendmsg() function to
> > kernel_sendmsg_kvec() and name  our new function kernel_sendmsg(). To
> > me this makes some sense, considering the new function is the more
> > generic of the two, and the existing kernel_sendmsg() specifically
> > accepts "struct kvec".
>
> it creates an asymmetry between *sendmsg and *recvmsg function names.
> If we wanted these to be similar then it means a rename to these
> functions (e.g. kern_recvmsg becomes kern_recvmsg_kvec, rename
> sock_recvmsg to kern_recvmsg).

I see. That's definitely outside the realm of bug fix.

If we have to keep the two consistent, then I suppose your existing
fix is the best approach for net. And any renaming to clarify the API
is best left for net-next.

