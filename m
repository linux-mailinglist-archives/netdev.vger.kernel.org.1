Return-Path: <netdev+bounces-40948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941F57C92B6
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 06:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941071C209BC
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 04:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64F21871;
	Sat, 14 Oct 2023 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrQtsEPk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C6186B;
	Sat, 14 Oct 2023 04:11:10 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D02C0;
	Fri, 13 Oct 2023 21:11:08 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d0f945893so22976396d6.1;
        Fri, 13 Oct 2023 21:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697256668; x=1697861468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9GB9MkoNyibgBoWjlH68j35SKOWVZk3PIfxcDk6cVM=;
        b=nrQtsEPkP83jjk4umOpUTc1OetZdqblQvOaVpLB1zrSLhCQ27Du4X66ToKRNhA93lF
         SRdR/ma0yix1CVl8by+0ixeEeGubv4nIisCFdt/LZ3ytsxr1/9/LQ15DTaG0PfVV2YnL
         GCvgpstRtkvKu0yd2wKxaXJMXrcxyORIpz86NkVv9sFBhmS7y17+6PIeyD91sKdRpjN4
         q3y/sWAmcZbH5lpAciD/Bpx50DOO62Sb1GcqqmZiCtZx8v7t6uY0g+tOqP1boG30vu4D
         080bGYCqEQtVBC08kweYfrVRPt99VpBZPCQUGgQAxWdNTyFhYq6Lp/eJa0bckrtY3O+Y
         eEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697256668; x=1697861468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9GB9MkoNyibgBoWjlH68j35SKOWVZk3PIfxcDk6cVM=;
        b=IrE9a1u8MWACBBs4rU30Efd8s8cPYfCFUcXXSJKUXj4ttfhc5y44QSmVlU4Ld5Z6vP
         Kqs5TKqNhGj/SybcOBdz2iAyX+Mb9KTVnc+rgJUHun1bkg55tQx+W68QuPG4w3CznT+B
         /mxuiaxf62YNlr44BQx5WsFfRi+068Xj/M77RjORaXatnA+5xQHUP6cUJJv4J0D84bOX
         j41DDs8waJxmCcKA01f8GvXfawk9sTLJZK4iujTG4VuxHHEc11LwxsZBll4YMe3NOzfP
         cQ/+fG1TsFmJVRT5cxzmOfmzd1MYayfNVM7TgX4R/CvxxijO8FdLbVEsNnn4Qzf+Hexs
         6mlQ==
X-Gm-Message-State: AOJu0YxeKhPnI3bC7SAE86cWDzEQ9cezqPkPsO4tmdOQiPelefnHgpYF
	VKIXXnHIO3KeoePj0YV4xMY=
X-Google-Smtp-Source: AGHT+IFfnsobhHtce1Mup8AILOHzjdGsu1ckljABeYCRlKpf9znYv1MGHa+dnj9w8D+T12fr/we9YA==
X-Received: by 2002:a0c:c3d0:0:b0:66c:fd38:2266 with SMTP id p16-20020a0cc3d0000000b0066cfd382266mr2775205qvi.25.1697256667974;
        Fri, 13 Oct 2023 21:11:07 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id cr13-20020ad456ed000000b0066cf31eef11sm1285656qvb.132.2023.10.13.21.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 21:11:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 0CDAF27C0054;
	Sat, 14 Oct 2023 00:11:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 14 Oct 2023 00:11:07 -0400
X-ME-Sender: <xms:2hQqZXbsBEVJbg5OxFLWKnSB3ll1GIE_dlOhoblspoxxX0mRERXtBA>
    <xme:2hQqZWbOSGgWNaztV-mY-tHVWsLd3nuB9Btk9pyX64AZjX2ZarGCuP_J4IuYYl3Vt
    pb_Z1KOBuw1p4EY1A>
X-ME-Received: <xmr:2hQqZZ_d14EJf4ScLzhLWF1LYWt9wsVHGZEIgUh8zwd80K7p3yHn5h8Qnkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeggdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:2hQqZdqifa-AURJY1QhNyKNftqM0LfFGHM3kXZyfGYtmFdnzX44czw>
    <xmx:2hQqZSr3CQKG6RkYS8HuPpakDfjF_5jqLzyMwmwkOl6SQz7pQnHgQw>
    <xmx:2hQqZTSV7JmhPxzNvFgFtrmBK0N5fSo1p78P0j-P77GNA-HI3WVzwA>
    <xmx:2xQqZSK-usQRtJNLaGenRGyi4x2SlDWErPgvggUjznKzNY7Wzr67ZA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 00:11:06 -0400 (EDT)
Date: Fri, 13 Oct 2023 21:11:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, tmgross@umich.edu, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <ZSoU2ECHat2nVo4J@Boquns-Mac-mini.home>
References: <ZSjEyn-YNJiXPT4I@Boquns-Mac-mini.home>
 <20231013.144503.60824065586983673.fujita.tomonori@gmail.com>
 <1da8acc8-ca48-49ae-8293-5e2a7ed86653@proton.me>
 <20231013.185348.94552909652217598.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013.185348.94552909652217598.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 06:53:48PM +0900, FUJITA Tomonori wrote:
> On Fri, 13 Oct 2023 07:56:07 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
> 
> >> btw, what's the purpose of using Rust in linux kernel? Creating sound
> >> Rust abstractions? Making linux kernel more reliable, or something
> >> else?  For me, making linux kernel more reliable is the whole
> >> point. Thus I still can't understand the slogan that Rust abstractions
> >> can't trust subsystems.
> > 
> > For me it is making the Linux kernel more reliable. The Rust abstractions
> > are just a tool for that goal: we offload the difficult task of handling
> > the C <-> Rust interactions and other `unsafe` features into those
> > abstractions. Then driver authors do not need to concern themselves with
> > that and can freely write drivers in safe Rust. Since there will be a lot
> > more drivers than abstractions, this will pay off in the end, since we will
> > have a lot less `unsafe` code than safe code.
> > 
> > Concentrating the difficult/`unsafe` code in the abstractions make it
> > easier to review (compared to `unsafe` code in every driver) and easier to
> > maintain, if we find a soundness issue, we only have to fix it in the
> > abstractions.
> 
> Agreed.
> 

Right, so the soundness of the Rust abstraction is the tool for more
reliable kernel. And honestly I haven't found anything that "sound Rust
abstracions" and "more reliable kernel" conflict with either other. If
we provide unsound Rust API, what's the point of using Rust? You can
always provide unsound API rather easily with C or put it in another
way, you can always rely on various implementation details to prove that
nothing is wrong (e.g. "this function is only called under situation A,
B or C, so it's fine"), but these details lost track easily as time
goes. With sound API, hopefully, we can put these details in the type
system and the unsafe requirements, so that these can be helpful (and
compiler can be helpful).

Of course, kernel is compliciated, and I'm pretty there are things that
sound Rust API cannot express (or at least easily). In that case, if
necessary and possible, we should improve the tool, rather than bend the
rules of API soundness, because, as Greg said, there is no deadline
here, we don't need hurry.

Regards,
Boqun

