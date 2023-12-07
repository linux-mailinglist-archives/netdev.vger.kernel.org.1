Return-Path: <netdev+bounces-54865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF85A808A82
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 15:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C885A1C20967
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 14:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF88641C98;
	Thu,  7 Dec 2023 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kk5oat6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E33110F4
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 06:27:50 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-58df5988172so399430eaf.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 06:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701959269; x=1702564069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=450M0AQxIxgaM1VLNXLyeZJkmjwkJaCjk2V9n5tnm28=;
        b=kk5oat6gdB8cR3bg0bMPW0YFsiFkhaucDYzuccd2B8V1SR6ME7tvw1nGj5YmRIQlSc
         biV5owuOHZE0sphcLFsWXgj3db8gJybGk/xyrRZtS2ikFmJfa7abJ9R/O2FW8Aom6cOa
         hEwnpotpuNKbbZpYsVM8vm/mMXM7pvHRM4b/0uSuu2sXn85MPcHZyR2772y6vncNWtfw
         lMsOwdJANMlKrCA7+Dqlagpyw2EVlZ9nZ2QubEFHfL65g6d0N4qrGDXmsVvXAns8QySU
         fL7N/CPsBVOb/ID9PKAmc7bueax0DXDbUsYDdRkKn2DgrvHvKskoHEw4VYNfRKKyurkH
         p6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701959269; x=1702564069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=450M0AQxIxgaM1VLNXLyeZJkmjwkJaCjk2V9n5tnm28=;
        b=Q9GZ+G+eqGONTRPTqIYSqah25UwAzxgSS7nFl032a1KsGTs/bJAv+O65vw2dQmxHb6
         4xNcuCwyrxyEiK3iDxNHqqygCb2ksNVjV8rmR+Ku8r5ZqTJ0+reOPFWiOHfV9nsLPbgg
         yxc2AF51gqFOqTRVbnbhtRfGzaWI+W3XrIgX+4vulL+oeH4j0rmvR6ITY0n2ldFIQYkJ
         7BQ3KWbqhmk3/yZE90Rr8TF+lnbl2ycbevnJA0d0htbfeGuAE1wCA3FqUj3ZapiUtfRa
         ymS5sKXwZ2Gw1rBSr5f4MdvZGDLJlGfUWxTGkTDIGho1mv5ZFqv9QPkf13LPi98pQxki
         9GaQ==
X-Gm-Message-State: AOJu0Yw1j67jvExrsAbVxMD7dY1a7/w3jbxcwa60ns5I2h9gBwvp7RRO
	0FMuLblFzyyQ+WNVQICJV6I8T1G/L/212cH2GrE7Eg==
X-Google-Smtp-Source: AGHT+IFsS8ZotwJYg7hGsduC5QWUllce5/gQ2SPETv47QZsDRcQ1x+VKt0XD8FZpXJiSii0SSYq5G2EarHyPUgheHKw=
X-Received: by 2002:a05:6358:7581:b0:16d:b577:e9f1 with SMTP id
 x1-20020a056358758100b0016db577e9f1mr2934420rwf.9.1701959269433; Thu, 07 Dec
 2023 06:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLyH=PmSoP8=PdkyK5VG1vhiG8fHKg2Xie4oBrVeYbdhHw@mail.gmail.com>
In-Reply-To: <CABOYnLyH=PmSoP8=PdkyK5VG1vhiG8fHKg2Xie4oBrVeYbdhHw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 7 Dec 2023 15:27:10 +0100
Message-ID: <CAG_fn=XnFw0756BNQSVXUwCh7-JjzTgfp6jCvut41++PSJ9oeA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in ip_tunnel_xmit
To: xingwei lee <xrivendell7@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, 
	syzbot+4a2c52677a8a1aa283cb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 2:28=E2=80=AFPM xingwei lee <xrivendell7@gmail.com> =
wrote:
>
> Hello,
>
> When fuzzing the latest upstream linux 6.7-rc4,  the following crash
> was triggered.
> HEAD commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei Lee <xrivendell7@gmail.com>
>
> console_log: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90=
c98b6583#file-console_log
> report: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c98b6=
583#file-report
> kernel commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
> kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D=
ce27066613dacbb6
> repro.c: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c98b=
6583#file-repro-c
> repro.txt: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c9=
8b6583#file-repro-txt
>
> In the lasted kernel: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8 the
> [  199.471467][ T8590] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  199.475015][ T8590] BUG: KMSAN: uninit-value in ip_tunnel_xmit+0x857/0=
x3e80
> [  199.478180][ T8590]  ip_tunnel_xmit+0x857/0x3e80

In the future, please consider symbolizing your reports using
syz-symbolize before sending them upstream.

