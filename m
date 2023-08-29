Return-Path: <netdev+bounces-31151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE48478BECD
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 08:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DC6280F31
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 06:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4261396;
	Tue, 29 Aug 2023 06:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA31116
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 06:50:14 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9D519A
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 23:50:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-268bc714ce0so3415153a91.0
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1693291812; x=1693896612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj0zcVFcZtB73joYoqKn7u0JrXUadMG4Ol0kcC0MOws=;
        b=G7vM+ORsSGeTaxZm4gkEkrKjbsOpnSZH5heH7t2yOKxd3MxGmPlGbejiGdvHq2rpr9
         Y+YuprTJ0yGdUYjqjPN6vyJFo3cVv3eUxI6B004p4gH5Uw3WZ6uRQeB75ZRCLTwDnRLq
         hiR+B4yJ7rewOJOlhP33q2FB0U6bR/DRMx2R6Oc90oTXJNzF27box2kr6Jyunx91E89P
         QuxbYzQRy82+gv/Q2O/roQR2sPPj3Ltv8uJFFDn5iGpUgx68pkXDqECBrz0H9HW3aZyT
         VptZmJHKWQJeJsTBPqRZjlkoMw9xNW7fQZ/XnN+MPqHtAeziyusFYeK6d6q9ksdQhlcC
         WwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693291812; x=1693896612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj0zcVFcZtB73joYoqKn7u0JrXUadMG4Ol0kcC0MOws=;
        b=Y888IqYtjRdP+9eFh1vpB3CRWgA0nT+TJ3dwlNi3HEnmEG/wywMqMc1EC/vDhODPnW
         CqQaxDRKxwLKrf14a6OVzVpGvbyBwxLZPRhPRtHuvAyqBsD9Wm+ICWJufFGnvK3CdX8G
         k+CKCrl9RbbcW4TFx24tHXxhexckgRemnI7Vfq2KZDcXRsnwTtTlBQA6YaVk4d2r2hm9
         5bFo1cwkxBSE+Pf8d58ZVnCc0elZaBdvtLVwGzV6yHQdIvEcew0ia6v9UOkjvgwkgWDW
         kcxE43d/FaFrZyTFUJUSsJwYF/0SdBjwXwECzoAIYiHPELLH2r9TRqcpoRzYzbLJs73D
         7vuQ==
X-Gm-Message-State: AOJu0Yz/4/76qluUl2dQieulcHckj+97IKhRlc/ML7wf/+9VSNRRpVyy
	6Ky0SlSQf6byqYtKEYlLaP3B7g==
X-Google-Smtp-Source: AGHT+IG7v6u6J583NScDd5VhvnBr3oBIVYMSHf38YBYeWjzP6/MlK11DhgHCw5e34bWatr8a9yrePg==
X-Received: by 2002:a17:90a:1542:b0:26d:609a:74cd with SMTP id y2-20020a17090a154200b0026d609a74cdmr2283335pja.24.1693291812530;
        Mon, 28 Aug 2023 23:50:12 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id hi14-20020a17090b30ce00b00264044cca0fsm608631pjb.1.2023.08.28.23.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 23:50:12 -0700 (PDT)
Date: Mon, 28 Aug 2023 23:50:10 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: willemjdebruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	David Howells <dhowells@redhat.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BPF [MISC]" <bpf@vger.kernel.org>
Subject: Re: [PATCH] skbuff: skb_segment, Update nfrags after calling zero
 copy functions
Message-ID: <20230829065010.GO4091703@medusa>
References: <20230828233210.36532-1-mkhalfella@purestorage.com>
 <64ed7188a2745_9cf208e1@penguin.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ed7188a2745_9cf208e1@penguin.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-28 21:18:16 -0700, willemjdebruijn wrote:
> Small point: nfrags is not the only state that needs to be refreshed
> after a fags realloc, also frag.

I am new to this code. Can you help me understand why frag needs to be
updated too? My reading of this code is that frag points to frags array
in shared info. As long as shared info pointer remain the same frag
pointer should remain valid.

Am I missing something?
> 
> Thanks for the report. I'm traveling likely without internet until the
> weekend. Apologies if it takes a while for me to follow up.
No problem. Thanks for the quick response!

