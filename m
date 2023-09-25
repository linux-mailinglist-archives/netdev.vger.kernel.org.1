Return-Path: <netdev+bounces-36165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11607ADE96
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 20:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 47A5B2813D7
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 18:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F03224E4;
	Mon, 25 Sep 2023 18:24:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9D224D8
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 18:24:49 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D825F12A
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 11:24:46 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57bb3872ff4so1771985eaf.0
        for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695666286; x=1696271086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JalN6K/Eoo9npF4TbMOa2TJXjbJ6ml17qCEKWKghNpM=;
        b=YcHSk2Udb+IoE/wP65w3OackHf3vW3e8n66NNoCRMFKw/GyMZL9ugem8sf1I4m0tg2
         wMJ6mVb2OSWh1vfxH/wkc8KVgvUnUxEwfTpbsJdfDICrNFsI5YC47FUWIeh2oQ9bDBeQ
         TFgAIB2Hskpf5c5X21KaOdLWPj9fC31IdhpgNNi8JwlzMZ16eOkfXEnzFZAwdhkf5Y7M
         qhMOo8WgUI12uKYecF2vhzhBQz4jiDLYXIdBCkHxdordw0LTLVM6OhboV7G6VVUhLHRi
         Fi/1YhspgKz9GgdsKE0GHWZemjxB6C9eBnVCYDpvXXIReSdO13tzQX/pqxHgo2TwwUFr
         GuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695666286; x=1696271086;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JalN6K/Eoo9npF4TbMOa2TJXjbJ6ml17qCEKWKghNpM=;
        b=Hrt8nHXcWNjaYRZS9Um4FOEaXJaRFW5SPHOygwsUr2tMbbu/+Uw6nfA6x3Bes3gRcR
         KK/33PjR+uCaoBBliUBL7tn+MoeTrQSNr2xsFFposm9gMreE2FzPzaX1f0iZTk4sdt6g
         v/0npQ51GLYeLSqZ8ThhRoKaBiCRIfyLsx+UfsDNvfY3afpbRrQRM8b81papIxqrYz8j
         G9xAZ0SA55HT+80IeD7WMxcFOtU8ilbxcax1jyZzZ8WyDGdxoiEdETS4U9LKJI/AnrhP
         7K93aL3pv2+42toe+OAZHfnVC0aw+l75BuB9TumEwrcyMTYrAzbvmePbdSDTWcCmJFbU
         7kRA==
X-Gm-Message-State: AOJu0YyKgGzkdUFIinvGUTCZ+tVItkecefKlN2K98rlwSqOZeb57ppcS
	h4owI1NviGW+gYb9+2zlXpE=
X-Google-Smtp-Source: AGHT+IFu4RDkJ4l40sHTtZr3sWroT2tvVXjoAvnAnhJg+IMaQK/q/HMi3HeMo3iuW7trLAxpTsNUWg==
X-Received: by 2002:a05:6870:d626:b0:1dc:7e71:d471 with SMTP id a38-20020a056870d62600b001dc7e71d471mr10799599oaq.31.1695666286014;
        Mon, 25 Sep 2023 11:24:46 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:51e:699c:e63:c15a])
        by smtp.gmail.com with ESMTPSA id n16-20020a637210000000b0057408a9b3a8sm8186832pgc.42.2023.09.25.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:24:45 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:24:44 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Ferenc Fejes <fejes@inf.elte.hu>, 
 Farbod Shahinfar <farbod.shahinfar@polimi.it>, 
 john.fastabend@gmail.com, 
 netdev@vger.kernel.org
Message-ID: <6511d06c64462_110e5208d1@john.notmuch>
In-Reply-To: <3fd39981aba0e0aa8ced76398c2ea8ad85208f7d.camel@inf.elte.hu>
References: <be02a7af-5a00-fef7-2132-0199fad6ba7a@polimi.it>
 <3fd39981aba0e0aa8ced76398c2ea8ad85208f7d.camel@inf.elte.hu>
Subject: Re: question about BPF sk_skb_stream_verdict redirect and poll/epoll
 events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ferenc Fejes wrote:
> Hi!
> 
> On Fri, 2023-09-22 at 19:32 +0200, Farbod Shahinfar wrote:
> > Hello,
> > 
> > I am doing a simple experiment in which I send a message to a TCP
> > server 
> > and the server echoes the message. I am attaching a BPF sk_skb 
> > stream_verdict program to the server socket to redirect the message
> > back 
> > to the client (redirects the SKB on the same socket but to the TX 
> > queue). In my test, I noticed that the user-space server, which is
> > using 
> > the poll system call, is woken up, and when it reads the socket, 
> > receives zero as the number of bytes read.
> 
> Do you poll for POLLIN events?
> 
> > 
> > I first want to ask if this is the intended behavior.
> > In case this is the intended behavior, my second question is, what 
> > should I do to prevent the user program from waking up? I hope by not
> > waking up the user program I could better use the available
> > resources.
> 
> AFAIK sockets in sockmap are propagates every events to poll (fixme),
> but with pollfd::events you can specify the ones makes sense to you
> e.g.: POLLERR, POLLHUP, POLLRDHUP, etc.

Agree we should not wake up the application in this case. I currently
fixing the wake up for cases where SK_PASS is passed. I can add this
to the todo list if no one beats me to it. For reference with parser
program we have a series of similar issue I'll fix next.

> > 
> > Sincerely,
> > Farbod
> 
> Ferenc
> 



