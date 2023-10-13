Return-Path: <netdev+bounces-40819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C760B7C8B03
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A2E282E2B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B4412B8A;
	Fri, 13 Oct 2023 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTx/vtjC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E518219F7
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 16:32:57 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87115DE
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:32:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso13526a12.1
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697214774; x=1697819574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wEK7yMLfQa7Rzf2G7nEIjByX5/jYVgZ7BdzM7Aex8g=;
        b=tTx/vtjCeXhr9yWCXJNm0yDTbVxLjEZxw54uHqY0XrgrHZ4T0hfuRvuVEGEIZspoYk
         8LnnENKdb1EfAHAlCEVxW7mbv2/cUyPhrsgqZ0abYBSShkwbZSpNY1OGvexuCStOx+qJ
         Qbg6Dbb58GD3PPuDk7Na4aHjkmXxhVPyr11kqGAg9Uv7O4VjMuQSjiasCyXhg/flXGr9
         MjcTMQusPcG14FHu/IlEijZ0dCN5iVtaovhqJO9QC9HJbtox5seTfDhl2Zy+RYzqRJ/Q
         1nxARlM2X+A7MJzVoghkZTRoyYRag2iuhlMQ0Q+7D97r3plqDPuh1WEC/i18+qV4EvE2
         jkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697214774; x=1697819574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wEK7yMLfQa7Rzf2G7nEIjByX5/jYVgZ7BdzM7Aex8g=;
        b=HzrvJBg66rCMLAfPKrGkidDcunTQW+1v5J5t+bW/n5BeLNBoq2Yo6b4ZEdNRvfxyer
         XACsJ0q2s3985M04VwAlV411s7L9nw5OVQe1wZWASAqNuroB6T6V5dYTworLb/7i2sFB
         dJHO57dXLwYGEESYJcEgc9Vji7gS5f/QkQVeG4nz4rU2pUjHs42RxM0VSK5O1lArDqyk
         Gh3gkzgpGeiBX21jo6kxxS82Fwr9GEHW3L4vRzoKjAlwzmQwFFhoQB4I5loT27EEjl3y
         Kp6JABtbxg+lNCgdl5ff7AQJQIpIJtjwNTud35XzpK5azOap8QZJdql2DN3piWLz2eOn
         tUGg==
X-Gm-Message-State: AOJu0Yzibwjs8Aawb0XlVD0WWO5zHUDCrD86XmxrvByWnzB5p5wtg0ms
	y1+bTZUlSdGkZJySLc+LTcpL5xburKpAVsiwwN0KIw==
X-Google-Smtp-Source: AGHT+IF7f1WC5QTLXYZjwxFCqWHjb3bxU7ON10IgKVx0ClthIiwSRVnhl4z3wN/oEUoQ/pbJ6X868yr5ywHycyxY/Gc=
X-Received: by 2002:a50:c35c:0:b0:538:50e4:5446 with SMTP id
 q28-20020a50c35c000000b0053850e45446mr133933edb.5.1697214773725; Fri, 13 Oct
 2023 09:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010013814.70571-1-kuniyu@amazon.com>
In-Reply-To: <20231010013814.70571-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Oct 2023 18:32:42 +0200
Message-ID: <CANn89iJcLQSsbD3pp_9pUwxyy1fBJnyO5Y33Q4t1Q7WmZ0e3yg@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Fix listen() warning with v4-mapped-v6 address.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 3:38=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzbot reported a warning [0] introduced by commit c48ef9c4aed3 ("tcp: Fi=
x
> bind() regression for v4-mapped-v6 non-wildcard address.").
>
> After the cited commit, a v4 socket's address matches the corresponding
> v4-mapped-v6 tb2 in inet_bind2_bucket_match_addr(), not vice versa.
>
> During X.X.X.X -> ::ffff:X.X.X.X order bind()s, the second bind() uses
> bhash and conflicts properly without checking bhash2 so that we need not
> check if a v4-mapped-v6 sk matches the corresponding v4 address tb2 in
> inet_bind2_bucket_match_addr().  However, the repro shows that we need
> to check that in a no-conflict case.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

