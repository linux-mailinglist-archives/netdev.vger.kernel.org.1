Return-Path: <netdev+bounces-17762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7511C752FF8
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61041C214EB
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 03:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A72B187A;
	Fri, 14 Jul 2023 03:28:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9181C08
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 03:28:40 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E827B12C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 20:28:38 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56352146799so1054413eaf.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 20:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689305318; x=1691897318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrz8wZBinnnuPE44+ugtI8DUFmegsPBLqbJJwtHWVTQ=;
        b=cS5dYqnBN95R7bx2ZlWJF/KOvvoGTUd9PyrXw3SeWAYfxLrnSVAXn4DYs8H4TpGGDx
         +jIFsPy/COA2nmzIo/XK+xUUxeKuCJa/2c1In76IoYcpQtMsqVwgIOaUYGtolN1+yOnf
         5F+v7nb3KxOyUghKxooqVnniyFR6bD0FG/LstaEMjwGC4liUQdr084Y7YkRGZfe8s84A
         jFxslLIPeu+PeqhfASTf1yVtU5Hhol56myNODfu9lQTAl1U9IfjFMzBo/DXSLnF/ySZy
         u1s1s4nrliomWcnOQjeWNyoRStgifz0+FPM4ztcmlT9/AAKC2BymzwCKAXYcIZcCCfX7
         ZX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689305318; x=1691897318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrz8wZBinnnuPE44+ugtI8DUFmegsPBLqbJJwtHWVTQ=;
        b=Z2M+ySioYvxoJvoZNenWrSRhWeUmwNW0FCuk09Pg2Hu0C+Lo5/oJm194quqxZOh7X6
         dPwunNXGmnEYrcREd4lTQwujNEme99XpYzuqcEkS08TKJ4f0SG9n9EWcp5Nr73y+bW4a
         tF4NT4teVWr6WzLccPOkOuZUBwUSSwFROrJdBzua4N4WUlPmECUR7jBo881TZ2xoTWkM
         gjluFIAPyGgGRqZC9BplMLQO8HDJxkfUMu81WarJnQhiYCj/AjLUsNdC1toPNrL5k64F
         MXng0sSHh+3qiBgr8RQGybaanxJTDge/4u3VprHjfrp9rxxQQmeLKXzB8SwrcCvL1yOO
         WejA==
X-Gm-Message-State: ABy/qLaKH7IFPmcJTsFK1h0UJP+6UjYvcS+ha/lolAxkT94F2szkKAZE
	XQcw8BAFmalH6ooLERF/Ytg=
X-Google-Smtp-Source: APBJJlGxF6njghI/qau8HUjVBo6CjF/2/JYdLc6GT+/gvyYC7NBbuTotsRbuyKibZep980TXEMsPwg==
X-Received: by 2002:a05:6358:4323:b0:134:c7ef:406d with SMTP id r35-20020a056358432300b00134c7ef406dmr4086228rwc.31.1689305317958;
        Thu, 13 Jul 2023 20:28:37 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782f:8f50:d380:ebf:ef24:ac51])
        by smtp.gmail.com with ESMTPSA id fm10-20020a056a002f8a00b00640f51801e6sm6108391pfb.159.2023.07.13.20.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 20:28:37 -0700 (PDT)
Date: Fri, 14 Jul 2023 11:28:33 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Andrea Claudi <aclaudi@redhat.com>, Ying Xu <yinxu@redhat.com>
Subject: Re: [PATCH iproute2] lib: move rtnl_echo_talk from libnetlink to
 utils
Message-ID: <ZLDA4dT+pF6AeTP3@Laptop-X1>
References: <20230711073117.1105575-1-liuhangbin@gmail.com>
 <20230711090011.4e4c4fec@hermes.local>
 <ZK4Z8j7hFHcjWv1i@Laptop-X1>
 <20230713152846.5735066e@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713152846.5735066e@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 03:28:46PM -0700, Stephen Hemminger wrote:
> On Wed, 12 Jul 2023 11:11:46 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> > > compatibility if an application links with it.  Collect2 should be
> > > using a supported library like libmnl instea.  
> > 
> > It's not about compatibility. If an application linked with netlink.a, the
> > build will failed. e.g. 
> 
> Applications that link with libnetlink.a do so at their own risk.
> It is not guaranteed to be a standalone library.
> If it worked be for, that was by accident not intention.
> 
> The reason libnetlink.a is not supported is that the same reason that
> kernel API's are not fixed. Also, there is no test suite for just libnetlink.

Thanks for the explain.

Regards
Hangbin

