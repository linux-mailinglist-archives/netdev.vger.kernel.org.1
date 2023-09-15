Return-Path: <netdev+bounces-34115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0377A2231
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21491C20ADA
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF0111A1;
	Fri, 15 Sep 2023 15:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019F30CE8
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:21:05 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA87211E
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:20:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so17446a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694791253; x=1695396053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi/+onFjP5DZ1Yp2PSuZQIjYbMc1Bg5oetVf2XE/4CA=;
        b=cYdRy2lQ2LqJ3VcY+oQ/vZQwXrztgfg4O8gaDNTCAu/Wo/HVVSQ+dX7hLJRdH9OUSO
         r9/HFj3yQeRWjaonCuEJ5RKyiNyRFrWtaPnPSaoR8yRhTpDjpIQcdMfMayHq3nOQqDjo
         kmlXoqqGp8nnOvYVn1r/jnwK8ABTA58vHxW0heJu4sxzPQWtaASp56Ez/Rrvisqba8sP
         CVLSgdNVrnoRNlgihR82aB3GP7IjfUuPGrBLVHe8q0Cf5H/JfY3fAbkN6mgy8g40pPO+
         ZsVQ+llZWzvZOhIHbuAep2aHeCiFtSLjUyvgRbN37ikpS9uMQBsUZSc1B1/iWK4U4jqZ
         08wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694791253; x=1695396053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi/+onFjP5DZ1Yp2PSuZQIjYbMc1Bg5oetVf2XE/4CA=;
        b=gbQzq7E76ubbRpDCfoHBCOuGTmV/IP4Nx1QnjoZy11Oj8UHQQZj9PRry6+x9zpQgw+
         IB7ySvzv+TYIGOJk0sGZqc6KVHdZZC2675mMdnM98/j7WolEUpjzi5VUJuPh0hEEAkdR
         LV2rRHzcqS6zlN3/PYNTgoUUNiMnKi4s1n9gQT7YWPyhMFhnSItvUDPJyroJT8XbXWSF
         QFEiHwiu6nI74cCkz//QpfKLBcGMFo5Vhqr0DaeeAErqgKacf8iH1k4yTQCsytXc47JA
         /j6mRyW7GAK4y80MYbJNe1tTMBYdoTwzVbKTCXJrcVvaoiF6+Jh7JCpIBnb9qLZhahPi
         KVyw==
X-Gm-Message-State: AOJu0YwddsYwQuIAjpYc0x+a53G7hyzYknAr25UC+wWrNFEA5fSi4BYj
	Frcc1eMXPijHoGNaHWJMTmZO7244Hq0H7UVJ521uqQ==
X-Google-Smtp-Source: AGHT+IHDJTp+G4qTgbWQ9KhHEkTqo155FZyrdRdWa1m/38koxOTYQSp2v3Slau8Amkf5xjwvTw2h9HE0ARW8RXhARDg=
X-Received: by 2002:a50:8a92:0:b0:519:7d2:e256 with SMTP id
 j18-20020a508a92000000b0051907d2e256mr183907edj.0.1694791253169; Fri, 15 Sep
 2023 08:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915151512.3803083-1-edumazet@google.com>
In-Reply-To: <20230915151512.3803083-1-edumazet@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 15 Sep 2023 17:20:15 +0200
Message-ID: <CAG48ez3P_jniG+qwL62Qf3FZvau2LnrgENo-C49u95PbzW5r7A@mail.gmail.com>
Subject: Re: [PATCH net] dccp: fix dccp_v4_err()/dccp_v6_err() again
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 5:15=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
> dh->dccph_x is the 9th byte (offset 8) in "struct dccp_hdr",
> not in the "byte 7" as John claimed.

Ugh, darnit, right you are. I guess I must have missed dccph_dport
when I was counting...

