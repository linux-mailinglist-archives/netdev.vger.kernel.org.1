Return-Path: <netdev+bounces-20479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7175FB21
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7125C1C20BA1
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2D3DF4B;
	Mon, 24 Jul 2023 15:48:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E932D507
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:48:24 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D198EE4
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:48:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bb893e6365so9863615ad.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690213703; x=1690818503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4RLUJOS8Sa0h9IJ4JbG/o9HQYV0AR90HmE0scb6NFA=;
        b=VVqWzVB8FOLiNHljBeWdf0YNZbvX8uU2JCZafxPyCP9NUGVcr7vrwSIZ4JLrUiAOND
         24tY/mmgZKZAhyNYp7tMjBHT19WNitjGHrNuiks+2LkoCgf8iiIklZ9XzkCGr75j8msc
         PHqHkm9S7T2JYKEdFXkJw2HilctlzYgF2vmSHIFGBU3/QxOfHaVCe5z0su0ZmJbUp0sx
         jTjbneMuPpIAcM9GalBNXqB13tOdZ91MMT/ZnHsWQw9J/aPinFoHl56mBJZHEDwj1yZa
         VbRLSvLqwSRP6zvZtMO4gAzyEB1zoJf/O2+lpEnVBuRxrFygl8jRM3f8+7KWcWr86Tv6
         lXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690213703; x=1690818503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4RLUJOS8Sa0h9IJ4JbG/o9HQYV0AR90HmE0scb6NFA=;
        b=UMG4OHV3pFAu7kRJZLj9R04lQynWGfKogl5AnZFonWubmgVvaxNC1LNeW3Au29pFn8
         5teUg2K60lmcScyJXDO1vjjAxiYxyDfj++1dWZvU8Ecxt8gSrx3L07GdDJIM54CNvHfZ
         6YfjgvhY7DNbjicp1yocv3iF4TCFoRAAohlDxBUN+ufDuI8Di5NF+SJiPI84Ki5HSwsE
         osLuakCSuTi6kFoMZ/6+L2RiFvAw1kOXFuUfbn3J5ktyYmiKdi2nGBqUxRMnEGdYXST3
         moLCyYgOEV9BE8Y7MZZC4D20mNa9eSqfSa6RhiZz2fybJ4uLW87RJsdwIbvMv3QGFKNX
         bY4g==
X-Gm-Message-State: ABy/qLZpxhpaxLX5a570lco2wxYBNkOejyahN4j43ph392yK9C9xqz8q
	HkW4Ii/+WGOxo9uudKPUGyrQ6A==
X-Google-Smtp-Source: APBJJlHTsyXE6HRH7BJ2KIpXDy1/7Dft6wy/RTAVHZGWbz+Tgnl+nMsrRkHT+NEhNMaMr+4XtJXg0Q==
X-Received: by 2002:a17:902:7c8a:b0:1b8:3cb8:7926 with SMTP id y10-20020a1709027c8a00b001b83cb87926mr9069063pll.23.1690213703320;
        Mon, 24 Jul 2023 08:48:23 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001b53d3d8f3dsm9055695plg.299.2023.07.24.08.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 08:48:23 -0700 (PDT)
Date: Mon, 24 Jul 2023 08:48:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <20230724084820.4aa133cc@hermes.local>
In-Reply-To: <ZL48xbowL8QQRr9s@Laptop-X1>
References: <20230718080044.2738833-1-liuhangbin@gmail.com>
	<ZLZnGkMxI+T8gFQK@shredder>
	<20230718085814.4301b9dd@hermes.local>
	<ZLjncWOL+FvtaHcP@Laptop-X1>
	<ZLlE5of1Sw1pMPlM@shredder>
	<ZLngmOaz24y5yLz8@Laptop-X1>
	<d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
	<ZLobpQ7jELvCeuoD@Laptop-X1>
	<ZLzY42I/GjWCJ5Do@shredder>
	<ZL48xbowL8QQRr9s@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 24 Jul 2023 16:56:37 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> The NetworkManager keeps a cache of the routes. Missing/Wrong events mean that
> the cache becomes inconsistent. The IPv4 will not send src route delete info
> if it's bond to other device. While IPv6 only modify the src route instead of
> delete it, and also no notify. So NetworkManager developers complained and
> hope to have a consistent and clear notification about route modify/delete.

Read FRR they get it right. The routing daemons have to track kernel,
and the semantics have been worked out for years.

