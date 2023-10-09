Return-Path: <netdev+bounces-39133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A8B7BE296
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A5F1C20949
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE8C35894;
	Mon,  9 Oct 2023 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="h3hdiZeI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCE35891
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:21:35 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEC810C9
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:21:13 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DFA573F670
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1696861271;
	bh=B96PVjO/dQ3gfVlhgj+phv5BjtntXKadFzqOCRy8X5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=h3hdiZeII0LB8f/oWDM33KTfcqb9kx2qEGi3quzNU/yT+cDb+5XN4slRW5WfCHni0
	 L4/222k+kyxNTqt8f6qwB8XKQR/yLqBC5odh9ExJbzzls+V00mEhHo6v1xa1W80mb1
	 r43ovMYGxKfNjOW5I7t/eosA4D13ziYm+jKFIxFmbggqHtTPNYN26Ru19lS/XJQEQs
	 8FRgYFcB1YF/oJACOP9Z1qifMWsvxYt1r5Ry9Y17YhExo9hr6riFDL1nF0VaEdNmFJ
	 POQY/YBJtv15bijyVu/DLlAybOQnQTL8wsPd8sRf0a33Zx8N7jkmw5HDM+6vFwTl5b
	 c0vR8/J9gnX5g==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-533ddb3cb28so3732734a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 07:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696861271; x=1697466071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B96PVjO/dQ3gfVlhgj+phv5BjtntXKadFzqOCRy8X5o=;
        b=dches8sWZeb8H4xJX5OcBX3knzlBMl9nrD10UYvS55leZpXHkjMHuD9VwVpZGw2Bxj
         nat7Xjg59lweA8yuu9zoKKo/Ayg74T1FPIqTE5FP9pq4QVo1XUscdbfZonTocEtueojo
         M5wJqL3Dx9hZhgx6jbHSZ6gHRDdIEPVn/WuqMitVNZWoeFlNFle+9+VBis+oEVywYL9b
         gP23lB4GI38Fqda8geDUCukWEFl7JJdW9+Hu+LZ7W82XT7Cyvf7uUPDBMG6usajShJW/
         0t23B42nJ/Mk0kw8FrsAbyXkESmC8P/0zk5aHpIk8D/JTbMMqny/PmkdkbPj/W98jVnG
         17Pw==
X-Gm-Message-State: AOJu0YyVghqIsSwgaVEFlcsegY8qaAutG5uYpQqmCDgduRqdO6AIxpCM
	eqdZJ/Fr9EeSr0083CVo1yz+PvkC6j+oet9y68QQ17VE4hjcOeoKVR3ivoMPmaXCCcNbWnr4qgF
	2Apo9WiWnqt2jYeDUvPjQGh9olox5Jq82aA==
X-Received: by 2002:aa7:de0b:0:b0:52f:fa53:9fb6 with SMTP id h11-20020aa7de0b000000b0052ffa539fb6mr13592183edv.10.1696861271602;
        Mon, 09 Oct 2023 07:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN5uHW2mQbyZfXtLTo4TlVZ+BI37A+D7RKCe90j3APgcSY4/uXNoFPWjpcwltgcTAQgtkoOA==
X-Received: by 2002:aa7:de0b:0:b0:52f:fa53:9fb6 with SMTP id h11-20020aa7de0b000000b0052ffa539fb6mr13592151edv.10.1696861271298;
        Mon, 09 Oct 2023 07:21:11 -0700 (PDT)
Received: from localhost (host-79-19-77-113.retail.telecomitalia.it. [79.19.77.113])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7ca4d000000b00536275c28dbsm6058070edt.94.2023.10.09.07.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 07:21:10 -0700 (PDT)
Date: Mon, 9 Oct 2023 16:21:09 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
Message-ID: <ZSQMVc19Tq6MyXJT@gpd>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch>
 <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 02:53:00PM +0200, Miguel Ojeda wrote:
> On Mon, Oct 9, 2023 at 2:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > Any ideas?
> 
> That is `RETHUNK` and `X86_KERNEL_IBT`.
> 
> Since this will keep confusing people, I will make it a `depends on !`
> as discussed in the past. I hope it is OK for e.g. Andrea.

Disabling RETHUNK or IBT is not acceptable for a general-purpose kernel.
If that constraint is introduced we either need to revert that patch
in the Ubuntu kernel or disable Rust support.

It would be nice to have a least something like
CONFIG_RUST_IS_BROKEN_BUT_IM_HAPPY, off by default, and have
`RUST_IS_BROKEN_BUT_IM_HAPPY || depends on !`.

-Andrea

> 
> Cheers,
> Miguel

