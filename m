Return-Path: <netdev+bounces-52423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E51927FEB1A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F86B20DD9
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4725E2D609;
	Thu, 30 Nov 2023 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXqL4m8T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D1510E3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:46:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b35199f94so51455e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701333985; x=1701938785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC3vGfw8buwXx/+n8qL73juvjuvtnig2ryfrV/uy7ZQ=;
        b=tXqL4m8TG+Kly8PJVjMO3y7O8GzDkyUrZQPcn7n/ylfmo6y3AG+XPg+yWmeFbIVyez
         yKrTNMaDPOP1ubolcm6Hfb5xqFtEzdEpTEfPutco13iLtHU1Jr9tclwtMo2i5FF/6Y7o
         xEs7w9Qkgk3QHVmwj33gbf/T0LWSwUDmO8U8MdeDvvMPPRkdy86Qv7L3nVO0yMU4nugB
         0udkVQEwE5c/ZbMev2Udh2L33+fNLVeXyMXo4r4bMgmev803n6IiAVF373lvESSpx4Tn
         MevpVPTrjWhtx7pzGybMQo2pkMcIyY3CckEa8iDH3hW/rrVOlb5lZ/S9mYp77sB9nDLt
         s3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333985; x=1701938785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wC3vGfw8buwXx/+n8qL73juvjuvtnig2ryfrV/uy7ZQ=;
        b=owhLKNp3TwhAi4QcLucIA3xoM9B/mXE9x25dlZ1bmFo3YhaBeqUeMVXoBdVUTYPdxl
         aEdwn/QGZn81lLHnYabMhoeBpYtTlUIesenITbAAvmHmdaGqaUlLpUExxagPBGBn/60R
         N0Ju26UMUaPM50f7iGwDyE/x36V+N/Mxzjmde0DUQ/s6Hp2R14iwn6URiXyuPygcNqOc
         Q8WilJ2LprO+Gue0uKyXk6freoGAvk1n3L3+bkiRXsaA8JbeMj3jNmVU0qtc/qFybYtv
         UstERwCA9Nr9ORXhkdSP2vPOdR3zlYnZJHKEWfALxCodRFjmHfZuKxURbQnnFgTvO2nl
         R0yA==
X-Gm-Message-State: AOJu0Yz9ryQal1hznb92sNsw0IqPMzyyRgBNlJi2xutbOgh4m99I84/X
	3JzHbnuIuxJJWwwUOhrR2I8qVU8gLpilBiekj7BWJw==
X-Google-Smtp-Source: AGHT+IFCUSEg8dN6oCdqKrhoebdwpoM1SqTlSMDHfQfBP47TnasviGUbaB/JoKO5XvBtjrGpyWvK43c278oK7R6mLnw=
X-Received: by 2002:a05:600c:6006:b0:40b:443d:9b78 with SMTP id
 az6-20020a05600c600600b0040b443d9b78mr119836wmb.0.1701333985108; Thu, 30 Nov
 2023 00:46:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLy_ufLD=BWDJct2chXMDYdZK=dNb4cnPYD5xo3WW1YCrw@mail.gmail.com>
In-Reply-To: <CABOYnLy_ufLD=BWDJct2chXMDYdZK=dNb4cnPYD5xo3WW1YCrw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 09:46:14 +0100
Message-ID: <CANn89iKpO35x-mFNgGA1axhn1hrq2HZBOFXo+wkTRPKxCQyQKA@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
To: xingwei lee <xrivendell7@gmail.com>
Cc: syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com, davem@davemloft.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 9:42=E2=80=AFAM xingwei lee <xrivendell7@gmail.com>=
 wrote:
>
> Hello
> I reproduced this bug with repro.txt and repro.c
>
>


Is your syzbot instance ready to accept patches for testing ?

Otherwise, a repro which happens to  work 'by luck' might not work for me.

The bug here is a race condition with rds subsystem being dismantled
at netns dismantle, the 'repro' could be anything really.

