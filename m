Return-Path: <netdev+bounces-41263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D72A7CA65F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2064B20CA9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10621A04;
	Mon, 16 Oct 2023 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0O7Of5i7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956D14283
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:13:51 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BF911A
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:13:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so10831a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697454827; x=1698059627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n9YlSDdx+kqyGs+k0iaPUOdfzBGEcWWoPk3I4BOM2c=;
        b=0O7Of5i7y4jzrDox9CuDMC5q3kwEerntcVWb6VR37Azy+slcSOw7yQ8XbFd2VzRhJK
         isbAsmxUAcVbY9l65bSns1II/PjOn40fAZ75p9jwuE/LH/0Kr3K3Smx2t1FCQ/vMFQHr
         LVSN+HJfyZuE3Imcok3TBQh3IenLdWAIcJHm9+UV5iTrfg0+bAGFBJdfAur4ymmUWBoC
         61boTNGXvhtn+a+ck08FeqpaR/Koc7vK4dcE++wYGRpL+mXnmEop9MlTZ19mdqCWtK4Z
         WFkG1P3mo/8m7318QhiwkFNLaFmVqoyO00Idh1nyx5iY1mb0Qca/JcL/nQlXePT0cw2B
         Ar5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697454827; x=1698059627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n9YlSDdx+kqyGs+k0iaPUOdfzBGEcWWoPk3I4BOM2c=;
        b=mBhP8W5VTkNgZQ9iYrClESgIcDmlGrZo1pELoiIqESyQhdN8dbF4IE/7OZyGY3l/pp
         YVl83NtodhHGJo7+NOCfU092IfWR78PEmDIlQQd4dp2l9RktfDGeWpG89QSoJ7HoKUKg
         BsRezFatYSlM9/Q1OO29vy1F88lf+UU6d8K0tDmaZEr6KdSdYHI639F7gSdgMczs80Tk
         cS0Q3ZxazO0WGVDGnPGCWSIMq7Kn9wGRUhtiKmLCwXmNxppM8j821mNIoLJg86VRruMg
         H07wiM4Q3CGzYNXZWgq1ELf0il2leWgSClEz9FgTBGAgG01CLbbFQoDiymdPKAasnkIb
         E4fw==
X-Gm-Message-State: AOJu0Yw7i8WBmJPKnzoMMV1KxSY653HroJEPYG+XE7GoC7nK4EjRK0pZ
	0egjkIuLLkJdYr/+8mH6HMLU9mbqkfZ3bLG1hwR5zw==
X-Google-Smtp-Source: AGHT+IEIdJ1sDT5G7U+ydBEL5nwgZQpZywAVaJm6ya7XWIbyxhyGq5JKCoUX4WzsGN6FVsv/Xse7TWDqLFv3Qcd69ns=
X-Received: by 2002:a50:9ec5:0:b0:538:2941:ad10 with SMTP id
 a63-20020a509ec5000000b005382941ad10mr127632edf.5.1697454827211; Mon, 16 Oct
 2023 04:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCjhhxBHL63O4s4ufhU7-rptJgX1LM7zEDGeQ9zGP+9Am2kA@mail.gmail.com>
 <20231011205428.81550-1-kuniyu@amazon.com> <CAAvCjhhEPd4MHNT9x5h_gpyphp3jB9MAnzbCDogiuRVGcqtdkQ@mail.gmail.com>
 <CAAvCjhjOmDDbDCF9xAVifHEsQqJOFJ1whtzzKu-0+Um=Odm=NQ@mail.gmail.com> <CAAvCjhj+c14o1EN77gtU_EsPM3_TzY5riQ3zH=AmaU2pUjMoXQ@mail.gmail.com>
In-Reply-To: <CAAvCjhj+c14o1EN77gtU_EsPM3_TzY5riQ3zH=AmaU2pUjMoXQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 13:13:36 +0200
Message-ID: <CANn89iJALZHwJCgpL3vz6_S-drXTQCtny2fxgMX2zY_DXuyCWQ@mail.gmail.com>
Subject: Re: kernel BUG at net/ipv4/tcp_output.c:2642 with kernel 5.19.0-rc2
 and newer
To: Dmitry Kravkov <dmitryk@qwilt.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, slavas@qwilt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 1:10=E2=80=AFPM Dmitry Kravkov <dmitryk@qwilt.com> =
wrote:

> Hi Eric, do you think we can try something to avoid the crash?
> Decreasing tcp_wmem[0] did not help
> # cat /proc/sys/net/ipv4/tcp_wmem
> 4096 1048576 629145
>
>

Honestly I have no idea, it seems strange that you are the only one to
hit such a bug.

