Return-Path: <netdev+bounces-48857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3531F7EFC1C
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B59B2813AF
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA04445004;
	Fri, 17 Nov 2023 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSh1bSWd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8D1D6D;
	Fri, 17 Nov 2023 15:28:59 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41cc7b67419so15152921cf.2;
        Fri, 17 Nov 2023 15:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700263738; x=1700868538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s7uMXmr45O8ynGtxCGBLeawA7umPbFDTmd85tKTgws=;
        b=kSh1bSWdAvvJbWXBS/QdIKGYQTMdEWawPMe+fGqJznqT3y2C0F9CcwR/KDySqIR12H
         XKPtYjJh9oamWS57ihvEZTcBE9BXmfg4pyNP2g2M9Fh38DeDnoJnZjZZ6FdNfEVaQkSi
         wFHgsdtHM1uuIAn1ptwMzVhBijDV5Qj8UnZFlPYvwKLBjRRH3t2Taek7EFVp14/JIOkH
         01EXO99DK0VEPm49mMt0qkX7Rd5rxH1viKVNLqg/LdIaOgJnRAMp4hoW0rleK+lzDiX3
         ssRoSvS+miQyYArh8Tv8MmfzqZv59NJaKLHmNAMB9CG+t/ZFyhJN7pGnK3yXgIpH1t9D
         8ZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700263738; x=1700868538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9s7uMXmr45O8ynGtxCGBLeawA7umPbFDTmd85tKTgws=;
        b=I+uky3K2KbdkcyEacT/rIeFFA4wj6FvHGdEaMtADRidRM4MQduxJH0EYVTsbM7iVEY
         yWM38tWW4E+jQLFUDZBCzzr7yv9ziLpKN1CLo27ON4DBptIEte2m2SnBLftzEoIGSFIP
         vhYN23Y1qEAc5fEHmnJxIz7Vw5jV3LoCxFkgfyLB4jS/5yEt4TVD7cvXuv/uevZq9RXO
         gSSkc8bisVuUmyzvBxUOP8KwPioxRTeP37V85ZBO/V5qKXKfl49Q2tHu0twPNHMTNi58
         8/d1YRQqzz3OQm8/p+fy9CAUWwB7deCjJHiyGwsN9T7GcdfLv7y8D8IMS7Myh2uVrYvk
         RP0w==
X-Gm-Message-State: AOJu0YyoLfjAVxOOj/Mhs+tC5Y6+rECj+kzNbteBmMiEQuWGde+aR33v
	S/u3xn6K1SG71WBfjwGdQlg=
X-Google-Smtp-Source: AGHT+IHMobkpuc4bCqDivtMyXzQcbVWDlPzFXkyPSmZwsFhIMURCJaN4ioqEOdL1dVH6ddBdoRgG4A==
X-Received: by 2002:a05:622a:145:b0:41e:2948:5389 with SMTP id v5-20020a05622a014500b0041e29485389mr1144281qtw.15.1700263738058;
        Fri, 17 Nov 2023 15:28:58 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x8-20020ac87a88000000b00419cb97418bsm908523qtr.15.2023.11.17.15.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 15:28:57 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 3E1EB27C0054;
	Fri, 17 Nov 2023 18:28:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 Nov 2023 18:28:57 -0500
X-ME-Sender: <xms:OPdXZcMYGRDHcGcSbVfR-jnU3DxNDPDZDoR8WU28W-P12_KDyrbKkw>
    <xme:OPdXZS_ZqJySF51ZDWowBsP98ZzxiH6dgP-iQM_dnQRJhFPVzrK7tPmZI4kCJyfk0
    1cKO69TIE0i-aHpTQ>
X-ME-Received: <xmr:OPdXZTQLuVdcKgU8LtjONk03GVPm_D-_b7DNv9RD8mXy4jJWAXUOnUCkIiI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeguddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:OPdXZUvprUqgxFnnBK1-qqkId_hub1TPIYgyzNDLxf_QAW_12aEpRA>
    <xmx:OPdXZUd7DWMGhyqgKewpshuQmGs1Wdix9XOLjVpuOoKfODj8ldjBkQ>
    <xmx:OPdXZY3j2QFB1LaNo-VE_4E9Zko1mGitt8gsK6IVmnmlT0U0oEBXMA>
    <xmx:OfdXZc7yC0VvWsefwGufemCdgdN-OcyZM9tXKufpuoe1MCeGRjezk60TJ7E>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Nov 2023 18:28:56 -0500 (EST)
Date: Fri, 17 Nov 2023 15:28:46 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Alice Ryhl <aliceryhl@google.com>,
	fujita.tomonori@gmail.com, benno.lossin@proton.me,
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZVf3LvoZ7npy3WxI@boqun-archlinux>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <20231117093906.2514808-1-aliceryhl@google.com>
 <b69b2ac0-752b-42ea-a729-9efdee503602@lunn.ch>
 <2023111709-amiable-everybody-befb@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023111709-amiable-everybody-befb@gregkh>

On Fri, Nov 17, 2023 at 02:50:45PM -0500, Greg KH wrote:
> On Fri, Nov 17, 2023 at 02:53:44PM +0100, Andrew Lunn wrote:
> > > I would change this to "it's okay to call phy_drivers_unregister from a
> > > different thread than the one in which phy_drivers_register was called".
> > 
> > This got me thinking about 'threads'. For register and unregister, we

Just to make things clear for discussion, the "thread" here (when we are
talking about trait `Send` and `Sync`) means "contexts" (thread/process
contexts, irq contexts, etc).

When we say a type is `Send`, it means the object of that type can be
created in one context, passed to another context (could be the same
type of context, e.g. sending between two thread/process contexts) and
dropped there. For example, if you have a work_struct embedded type, you
can create it in the driver code and pass it to workqueue, and when the
work is done, you can free it in the workqueue context.

One example of not `Send` type (or `!Send`) is spinlock guard:

	let guard: Guard<..> = some_lock.lock();

creating a Guard means "spin_lock()" and dropping a Guard means
"spin_unlock()", since we cannot acquire a spinlock in one context and
release it in another context in kernel, so `Guard<..>` is `!Send`.

Back to the code here:

	unsafe impl Send for Registration {}

the safety comment needs to explain why the `Registration::drop` is safe
to call in a different context.

Hope this helps.

Regards,
Boqun

> > are talking abut the kernel modules module_init() and module_exit()
> > function. module_init() can be called before user space is even
> > started, but it could also be called by insmod. module_exit() could be
> > called by rmmod, but it could also be the kernel, after user space has
> > gone away on shutdown.
> 
> The kernel will not call module_exit() on shutdown.  Or has something
> changed recently?
> 
> > We are always in a context which can block, but
> > i never really think of this being threads. You can start a kernel
> > thread, and have some data structure exclusively used by that kernel
> > thread, but that is pretty unusual.
> > 
> > So i would probably turn this commenting around. Only comment like
> > this in the special case that a kernel thread exists, and it is
> > expected to have exclusive access.
> 
> With the driver model, you can be sure that your probe/release functions
> for the bus will never be called at the same time, and module_init/exit
> can never be called at the same time, so perhaps this isn't an issue?
> 
> thanks,
> 
> greg k-h
> 

