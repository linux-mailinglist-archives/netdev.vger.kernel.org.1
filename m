Return-Path: <netdev+bounces-17719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B8E752D07
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 00:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06696281F3E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 22:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC82419D;
	Thu, 13 Jul 2023 22:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5511200CE
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 22:28:52 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE07A2D50
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:28:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-262e66481c4so611104a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689287328; x=1691879328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB0B1D41F7qTaQfOXZwvohesj/AKxEzgOQAEnIiBKUw=;
        b=zazJSiDAmHAjpZrGMYWBTzKOIlIFHwZqg8hoBfrC/xh+NopgxXCh7sj8U/fI7JjF3g
         e/p68eM+TKjWGsO7q12WL9qUBlq/8oVQBKaOsHmh+E6b1VtFl9ctemDaExHc9Yv6ZwrD
         JZaxicy6ps2l3hdQDfWyLPymn6je6GDfcl9jF8HzCRTEW/3vGPsex9l38LKzGVhbie87
         T+bRFc2E3aute2X9y2g/yjahXHJG8vQ4SZ7b0QUQevlgVUDy2slEZJ4txnrH/jWxVrBH
         qKHY7uXoJrZB+3RWEfv+TDGvS7s+9Tf8nXedMUMDPva07d6AepBrJRbnKmTmBex2pXdf
         R11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689287328; x=1691879328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eB0B1D41F7qTaQfOXZwvohesj/AKxEzgOQAEnIiBKUw=;
        b=J97LdN1QziiHF60DTZmaBZQEJ8XxSY/KgVG+cYxO51ZUies+60NfBc+uUgBvNa41zK
         J8txkbdLPlqA/xipaXWszWMZ/Yez09kJEsBp3wMI6Hv+jS35Xoly27wMmui3cqwAsqmW
         1jIARN5k9S0OMdXvzsjOuOpTyXneCoD3HL26qiZYGyaAkRVprBTeRz8LWpdjInxgkiHv
         L0BLnYI1Vv61aqQzWfsJh4cM+rw7XrmNJYS41zOhzoIq1y4rT12gnl1D6Tk2BJ38ibKj
         z9wPveqNhkBkSCqlM3YkXBYecaJxHu1pUlMCHn7jSBKYYjaX07Lb4fC86LdQN4XSw/I7
         V4gw==
X-Gm-Message-State: ABy/qLYPWIePrT2sewB75xiXNkxJTfLCWE5df2uJ4LmT2zGljdN6+wfT
	YOjzSm78mVZPL8HMY7pBvE281A==
X-Google-Smtp-Source: APBJJlG+tl0E9oeziL45JqEVRD9LFb5QBvZoZHutsZGWn0ARXa7X7NmPd5PW1RIVuVXL5NIaxkKfbQ==
X-Received: by 2002:a17:902:aa07:b0:1b8:2ba0:c9c0 with SMTP id be7-20020a170902aa0700b001b82ba0c9c0mr1862538plb.59.1689287328251;
        Thu, 13 Jul 2023 15:28:48 -0700 (PDT)
Received: from hermes.local (204-195-116-219.wavecable.com. [204.195.116.219])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902c1c900b001b567bbe82dsm6397001plc.150.2023.07.13.15.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 15:28:48 -0700 (PDT)
Date: Thu, 13 Jul 2023 15:28:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Andrea Claudi
 <aclaudi@redhat.com>, Ying Xu <yinxu@redhat.com>
Subject: Re: [PATCH iproute2] lib: move rtnl_echo_talk from libnetlink to
 utils
Message-ID: <20230713152846.5735066e@hermes.local>
In-Reply-To: <ZK4Z8j7hFHcjWv1i@Laptop-X1>
References: <20230711073117.1105575-1-liuhangbin@gmail.com>
	<20230711090011.4e4c4fec@hermes.local>
	<ZK4Z8j7hFHcjWv1i@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 12 Jul 2023 11:11:46 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> > compatibility if an application links with it.  Collect2 should be
> > using a supported library like libmnl instea.  
> 
> It's not about compatibility. If an application linked with netlink.a, the
> build will failed. e.g. 

Applications that link with libnetlink.a do so at their own risk.
It is not guaranteed to be a standalone library.
If it worked be for, that was by accident not intention.

The reason libnetlink.a is not supported is that the same reason that
kernel API's are not fixed. Also, there is no test suite for just libnetlink.


