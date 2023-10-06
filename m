Return-Path: <netdev+bounces-38598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFEB7BB9F6
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105A0282245
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6110F241E3;
	Fri,  6 Oct 2023 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgpgOAvK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94779C3;
	Fri,  6 Oct 2023 14:09:40 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73A995;
	Fri,  6 Oct 2023 07:09:38 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-351610727adso1479775ab.0;
        Fri, 06 Oct 2023 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696601378; x=1697206178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vGbjqn+D1kmlaA1HVCU/edLVP8HBOnt2wmn9GYSooo=;
        b=JgpgOAvKWY+WE9GA84rsj3VH4WHt6/FNVNdUI6qZqut6WTKouMblXQVqMmwEW1HB7c
         lkfX3aZs9LGqQABS7+2Ux24pfoVbntBkkjM2oOm/SgluNWusKqs386c8Zr0Dca+PMiJz
         /17lBKU8lPr2aAU9bggad2YD6Gj+8K067NeIhTYVv66OsmpHUBiD3z16lL8gTjCNkTL8
         cxya01WDrT8gvQOVc8auHGGRL6WfzkKMlwBnE4W4Of5iq/MVu+Yl7Lvp/Utg8LCu/eFa
         UPD/7XBiiBCPAb9Vw1CHeiNxaHhx6v4xKo53beCTVvrEqXtW+zW+WikTnRxzE8kyfU2I
         bnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696601378; x=1697206178;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8vGbjqn+D1kmlaA1HVCU/edLVP8HBOnt2wmn9GYSooo=;
        b=TNpCgXnd3FKXdCfx52zm+W+wi1Ys8Wcl9JMq6hcMnyUe2peVQ6XduyiiZYDKhD/6wi
         /t0hoteqzTkFC4U9zxtc+h1l3jyrloQuRk5I0fMjbFcixjDmgxn7MhosPgBIik+L4Nmo
         nPzjnfAvI4fidgURLXecdJKO9M7tnIlnjUT5XeVdU7g6vTTJpti7ECaBP/IZLzpaxIEG
         EVmZ+5DYJnoSZzwmhzkSErMogciPQdWgvGpzhluyTPkcivPzOHCEzB2fl3ymhzUL4pLJ
         H9zGDo/kSOJuqW3VaZ1wRhAAOI9xhlu3Q5wJYErfG9i7x54ljlBuwWZ9YLFI+jUbfZ0G
         HsZA==
X-Gm-Message-State: AOJu0YwWJ1EWqCgOVhZw7/DDvF5zIhHSGPGfmDO4G0u97LTrGSAQsTuu
	mM+iXQLQaozz5tRJMITz9DsCqvTWnYjH42dS
X-Google-Smtp-Source: AGHT+IHKcgNqPum+0PF7IWz4lNICwgtpkvmrN9tXRdrUFftzldhdh9PDOHgftOOZGhvk0O5X3ptbJg==
X-Received: by 2002:a92:cf41:0:b0:351:54db:c1c9 with SMTP id c1-20020a92cf41000000b0035154dbc1c9mr8096272ilr.1.1696601377847;
        Fri, 06 Oct 2023 07:09:37 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r29-20020a63205d000000b00565e2ad12e5sm3248485pgm.91.2023.10.06.07.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 07:09:37 -0700 (PDT)
Date: Fri, 06 Oct 2023 23:09:36 +0900 (JST)
Message-Id: <20231006.230936.1469709863025123979.fujita.tomonori@gmail.com>
To: andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH v2 0/3] Rust abstractions for network PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <6aac66e0-9cbd-4a7b-91e6-ea429dbe6831@lunn.ch>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
	<6aac66e0-9cbd-4a7b-91e6-ea429dbe6831@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 6 Oct 2023 14:54:43 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Oct 06, 2023 at 06:49:08PM +0900, FUJITA Tomonori wrote:
>> This patchset adds Rust abstractions for network PHY drivers. It
>> doesn't fully cover the C APIs for PHY drivers yet but I think that
>> it's already useful. I implement two PHY drivers (Asix AX88772A PHYs
>> and Realtek Generic FE-GE). Seems they work well with real hardware.
> 
> One of the conventions for submitting patches for netdev is to include
> the tree in the Subject.
> 
> [PATCH net-next v2 1/3] rust: core abstractions for network PHY drivers
> 
> This is described here, along with other useful hits for working with
> netdev.
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> This tag helps patchworks decide which tree to apply your patches to
> and then run build tests on it:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20231006094911.3305152-4-fujita.tomonori@gmail.com/
> 
> I don't know if it made the wrong decision based on the missing tag,
> or it simply does not know what to do with Rust yet.

Thanks, I didn't know how tags and patchworks works.

> There is also the question of how we merge this. Does it all come
> through netdev? Do we split the patches, the abstraction merged via
> rust and the rest via netdev? Is the Kconfig sufficient that if a tree
> only contains patches 2 and 3 it does not allow the driver to be
> enabled?

A tree only that contains patches 2 and 3 allow the driver to be
enabled, I think. The driver depends on CONFIG_RUST, which might
doesn't have PHY bindings support (the first patch).

So I think that merging the patchset through a single tree is easier;
netdev or rust.

Miguel, how do you prefer to merge the patchset?

