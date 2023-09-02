Return-Path: <netdev+bounces-31813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2B57905A5
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 08:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17812819A7
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 06:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DFA1FD8;
	Sat,  2 Sep 2023 06:43:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E161FC5
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 06:43:24 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10AE1702
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 23:43:23 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-414b35e686cso98391cf.0
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693637003; x=1694241803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1YlTacI7EIsQxn8/ngfsPieQ7RFGMSBJUUAaDWAyPY=;
        b=5na6bJ+OO9puCsc+Xzf3GGbE/CvYlt0zf+tW6aAtWLuj+xfLsUALZxF9xa78cEeMWn
         cV7hZZcdp4px7IfjXFArDlXPiDVxfr4MKnqSAd1PSN0GGT7CW2M4LVMEK1j6Z11Fkk/7
         h+yi22ZFGgk0jSzucmi9k4DQyvamLZB1Sl6PI4hVQePAGcHqt2t0V6fMdfD7K5wQJ03h
         UHFNUCokWkw6rz39zuKheMYp/vvOeEAKWT8E35fGe3p9Xb2rUv8VLI9KIa4tu8O9pxtT
         A9XJMOXTIob1DyLGTo7R6VK6FgbZ60FikoJ1522VukeEoG1FHQgDdcLgHLIV5gD1XztO
         llqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693637003; x=1694241803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1YlTacI7EIsQxn8/ngfsPieQ7RFGMSBJUUAaDWAyPY=;
        b=AGGT/GSN4N/uY8PdcmTSZUBvQmuWtwVBcbwCiOKAlk/Kqs5cpRhldbOAxLZdDj9yHC
         VOxw1Tj428d1hMYGE4rVm43jWSweypgIGqNdim6tFRuaqNLoLOPkj0XNkRdJIYtYdJGl
         1d2YhPzl1Kft0HiCLhXfM7A3rD53Dnc0sbiIqZT/CAydWB3Yo8V+BvrrL8vVaHa2Y0PM
         du3h/9yaCX1U3ht7BaW2fqkxQid6uFiroRgXd+pirj1hY6zfJBumThiPDVt2tLidrsNe
         nhtMzlgGxv3EYMtU6V2yjx2i9p3vNSOiHgluUlRuksaZYsW5HXhh0sXrcfrg+rIMroM5
         m/2A==
X-Gm-Message-State: AOJu0Yys4dP7uB1u0SYFct+xHAo14VUnPpEjG8x4ipOx/TMtIayTMVXI
	G0kz4neD/l/Hecp/XTF0l/BCFAejmu/HGTyTdLGYrA==
X-Google-Smtp-Source: AGHT+IEUOXEjw2PK/MPuO2Y5olstS3no2GbDUmrdwGz4jQJTkARdardoH5rcpAyQSv4uar76TuAvmKNFLW+6wpqaphU=
X-Received: by 2002:a05:622a:11d2:b0:3fa:3c8f:3435 with SMTP id
 n18-20020a05622a11d200b003fa3c8f3435mr90685qtk.27.1693637002490; Fri, 01 Sep
 2023 23:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230902002708.91816-1-kuniyu@amazon.com> <20230902002708.91816-4-kuniyu@amazon.com>
In-Reply-To: <20230902002708.91816-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 2 Sep 2023 08:43:11 +0200
Message-ID: <CANn89i+vJ-0zbGHRhWUKys1K3_D36y0jrHm=X5zY=qxuRZ-SoA@mail.gmail.com>
Subject: Re: [PATCH v1 net 3/4] af_unix: Fix data-races around sk->sk_shutdown.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 2, 2023 at 2:28=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> sk->sk_shutdown is changed under unix_state_lock(sk), but
> unix_dgram_sendmsg() calls two functions to read sk_shutdown locklessly.
>
>   sock_alloc_send_pskb
>   `- sock_wait_for_wmem
>
> Let's use READ_ONCE() there.
>
> Note that the writer side was marked by commit e1d09c2c2f57 ("af_unix:
> Fix data races around sk->sk_shutdown.").
>
> BUG: KCSAN: data-race in sock_alloc_send_pskb / unix_release_sock
>
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

