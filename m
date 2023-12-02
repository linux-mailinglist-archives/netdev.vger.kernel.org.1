Return-Path: <netdev+bounces-53296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC428801F1D
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 23:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6589F281037
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA92136F;
	Sat,  2 Dec 2023 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxTvSK8r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7394F1A6
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 14:36:29 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cd81e76164so36890907b3.1
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 14:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701556587; x=1702161387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYU49zqAJmONqf3Y+j9isDqO+cPsZ8bcHgIltaXeOAY=;
        b=JxTvSK8riqWHxCujh1RC94oITlRlVuR1gEyS51UnT7VPlLE8CprJYpnBVygWPxJ8zI
         8g0SnBdqgm5MFgjbgbPQOcC6ijWvjBvZfcY5VPGtSaOCpNltOy8TA1r0MVKoGI6e4Rhc
         /KxKzLqHZnem0/CAliTxnp8ADfaDeoPtxrrkfZdapAquL49pa39XWVtxqKpyjy3PFUX+
         6q+12laU4kpe1jyWUHOFajEYaW2bFEZp2ahD76A4bs3HBkl3AgiUh13SivEpMtdZQPHJ
         Gwgs9kxxM+FE6LM8KfXrJbJ8mi8ewcxJEKjZHH5IGoETC5sKqkeDaEh4tnxH5IJbZrS1
         qJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701556587; x=1702161387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYU49zqAJmONqf3Y+j9isDqO+cPsZ8bcHgIltaXeOAY=;
        b=WjG1Q1PIISsqSbLBoD6kvlDrn4jmo0rs/YhI0EUCmaFFtbnYpyNQrCmtcUD+mPsIU9
         lRJsy7AABZist3cGIC3zNF0DdEOatyANTtUZJS0JZwqRghKSZqJMkxNawOh9sofVPdF7
         ga+ds7XaC0AmIU16rxRiV32iV7sWEQLh4ABC6ryt7oZxx6axMT2aytb20HKxa2BQW4To
         w7dSIvXEs/ScVMOVFoJPMf6ASL34tYktmp4cHMErziEIe9lPKKKYNgr59D204cb5kLQC
         lQVxuNoq1u8LeA4UBFn5FUDfV+QQY9EAmWVHGX3skXMbYcCItb9WPClkH/DDLd0KX3eZ
         iYsA==
X-Gm-Message-State: AOJu0YzeREUlpyzCywG03PBBzHAWR9UyF1NvFyJgR0s6LDD+gWKwF6EN
	jftjjFSSEjjbGzdSW3vbdbOtMM8X0nvW4LwoXdhlHw==
X-Google-Smtp-Source: AGHT+IFaZb4fvWDNQhP//OG9UMG97ReraVhZJyDB3JuiVGo8yiN3+OFKzYVciKh69lYwn92hPe1k0fkSnvopa/49H9Y=
X-Received: by 2002:a05:690c:dd0:b0:5d7:1940:dd83 with SMTP id
 db16-20020a05690c0dd000b005d71940dd83mr1272086ywb.89.1701556586873; Sat, 02
 Dec 2023 14:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com> <170155622408.27182.16031150060782175153.git-patchwork-notify@kernel.org>
In-Reply-To: <170155622408.27182.16031150060782175153.git-patchwork-notify@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 2 Dec 2023 17:36:10 -0500
Message-ID: <CADVnQymKa65a7O=YHqbjm3042+HusyP2t0m_ocf6RXkaRTwjnw@mail.gmail.com>
Subject: Re: [PATCH v8 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
To: patchwork-bot+netdevbpf@kernel.org, 
	"David S. Miller" <davem@davemloft.net>
Cc: Coco Li <lixiaoyan@google.com>, kuba@kernel.org, edumazet@google.com, 
	mubashirq@google.com, pabeni@redhat.com, andrew@lunn.ch, corbet@lwn.net, 
	dsahern@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org, 
	wwchao@google.com, weiwan@google.com, pnemavat@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 5:30=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
>
> On Wed, 29 Nov 2023 07:27:51 +0000 you wrote:
> > Currently, variable-heavy structs in the networking stack is organized
> > chronologically, logically and sometimes by cacheline access.
> >
> > This patch series attempts to reorganize the core networking stack
> > variables to minimize cacheline consumption during the phase of data
> > transfer. Specifically, we looked at the TCP/IP stack and the fast
> > path definition in TCP.
> >
> > [...]
>
> Here is the summary with links:
>   - [v8,net-next,1/5] Documentations: Analyze heavily used Networking rel=
ated structs
>     https://git.kernel.org/netdev/net-next/c/14006f1d8fa2
>   - [v8,net-next,2/5] cache: enforce cache groups
>     https://git.kernel.org/netdev/net-next/c/aeb9ce058d7c
>   - [v8,net-next,3/5] netns-ipv4: reorganize netns_ipv4 fast path variabl=
es
>     https://git.kernel.org/netdev/net-next/c/18fd64d25422
>   - [v8,net-next,4/5] net-device: reorganize net_device fast path variabl=
es
>     (no matching commit)
>   - [v8,net-next,5/5] tcp: reorganize tcp_sock fast path variables
>     (no matching commit)

Both from this email and the git logs it looks like the last two
commits didn't make it in?  Is that intentional? :-)

cheers,
neal

