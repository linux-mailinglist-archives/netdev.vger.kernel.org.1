Return-Path: <netdev+bounces-59905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE05881C9D0
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 13:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BC31F21826
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42182179AE;
	Fri, 22 Dec 2023 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHVDKGYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8805168DC
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc259392a6so21125121fa.2
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 04:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703247732; x=1703852532; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UgVRQlz/8NCchVQ195lMgTdFBHOGyUcRndgz7s8ppPw=;
        b=YHVDKGYknfPSH+lSuJ22Yc20D/msBuVT2RDh6++kICR1t3fk53lyBE12lA2lDygAYJ
         kf+8L3A32o55r9PgmzB+6uzDSNJM7qUbQp69qtJvCBJwkja4rKzqoQcDAaXcgCg7R9Br
         THVncCpKoGFOyg49Zvn4TeYpJBHH7ZoCN6D705YmO61mbfkOlWcjVx4mSTzDv2fGMKI8
         ABiI6XUWSYBgDiUPWxzVaakfM6rbK0nVgx1zPWla6bdvkn272GEfvWuWavR/r3x662z+
         DRB7Q4FnYWJqzHtXdQN2dR2MQEVgu04msIPnHwnCSvECiU7jA+OsBBRgqFCPeEVj23mj
         z7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703247732; x=1703852532;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgVRQlz/8NCchVQ195lMgTdFBHOGyUcRndgz7s8ppPw=;
        b=DLFp9pQsIoruS0xJ5/TE+RKFM8bQ74dHQbfafImdH8jJFyKL3zE2CXiHDOfv9jXWOJ
         tQwpf/SMrj1Ju5HzjhdUEgmpmyr6unqzNdk31FiMhTJFdIYVURKFBty3KcHpUeEBI6Zo
         Ik2fWu5kIlWYXCV3eIW1G4lzG8x9vyMAEdoLUBP77FJNRwGJDKrx+fWrVFMHUGRn5rPq
         o/kZ7cjsB7Z8znGGyOVWHrGMkGBQ0rH7tokKOuILzVopPtpfdCGpThza4IqUhFqhT4jg
         he5CoYB4a4/+wNpcWQUY4u2rjPytmxf7d9j1YCl+C4XKoQUqEdsegK6dMb2TuzfHBCQf
         NWdQ==
X-Gm-Message-State: AOJu0YxPZ3nBF43v+WCWYGLNIVsCk0t/8ABFcnx7+/xGmlkLGxRgsZkd
	AiLSdenPYH3DktNLIEboE0z6o/7Js+8bDtn+szhUWYmROvs=
X-Google-Smtp-Source: AGHT+IHYBbTfCLlTljkkNVMvSGOY3tzGdshjQ6x3bBx7ue0HaVkK5bEgqbd6FyBzDFgBfDla7NM9nMQGBa1Yuy67Cjg=
X-Received: by 2002:a05:6512:3f26:b0:50e:5c71:51f1 with SMTP id
 y38-20020a0565123f2600b0050e5c7151f1mr693623lfa.62.1703247731919; Fri, 22 Dec
 2023 04:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lucas Pereira <lucasvp@gmail.com>
Date: Fri, 22 Dec 2023 09:22:01 -0300
Message-ID: <CAG7fG-YswhncaXn1JrpDsyji8yjaDmN-Ph5VrBxKszh10oeFVg@mail.gmail.com>
Subject: Re: Stop traffic on an established ipsec tunnel
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Netdev List Members,

I hope this email finds you well. My name is Lucas, and I am reaching
out for assistance with an issue I previously posted on this list,
which remains unresolved. The link to the prior discussion is:

https://lore.kernel.org/netdev/CAG7fG-adZdzc-8JG0dbHUQo+cpUunfm_qOi8iP3TqQPsD94=SQ@mail.gmail.com/#t

I am seeking guidance or suggestions on how to proceed with resolving
this problem. Any help or direction would be greatly appreciated. If
further information is needed, I am happy to provide it.

Thank you in advance for your attention and assistance.

Best regards,

Lucas

