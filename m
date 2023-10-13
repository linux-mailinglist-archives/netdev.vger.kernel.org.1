Return-Path: <netdev+bounces-40801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E535E7C8A2A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84BC2B212C8
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2991F164;
	Fri, 13 Oct 2023 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdRrTPDg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F3D1CFAC;
	Fri, 13 Oct 2023 16:12:09 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D62547B4;
	Fri, 13 Oct 2023 09:11:37 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4180f5c51f8so18633041cf.1;
        Fri, 13 Oct 2023 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697213459; x=1697818259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJv/ioOw3o29guXqBtGVgQVNenfbs/5Pj9gRvK1wduE=;
        b=mdRrTPDg2GIeC4R4VlxxzcmP8Xlz7ok4H+guO5oIT8hFAOZJwMNQQGOGM2rawWi1yP
         GwD8U+U5nBDq/XGHJeSsZC4D/wbcRMKXSkhI0TM+lmSYYu7Es58bwzUREWIpbOMCttqg
         U0TTFcJIVnhJP6WDHedFpMx4INBRLR5bRfaUdBYXuqPro+mSQt/YvRg9n73MAY9RCzd5
         yzGhvfJ6TsMn6JlU5XrXNPCmP6FutTorWOmbbBYT2U6GB1X+QtTtk3ySfcmbBSRC9yhI
         hlLSnlvX4eDbdxFVNsujN8j8riVIsXJk7/Lxgsd557inW1z3+IsmmO7Ewoh8tzgjndSl
         RyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213459; x=1697818259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJv/ioOw3o29guXqBtGVgQVNenfbs/5Pj9gRvK1wduE=;
        b=cqBk2ERcxy+8PjVL3jExk1E84Nrw94Zzaef+xYyl2jd3iiM4+vrwlqHCWKmw1WeUoN
         qVj5eXOOo6nhOM6pwRjlQFXMhau7lFDLgAExCGIGv9vvEehRzbc6+Icz5ND7lha33/uQ
         Fexwb/aq0IRgZmesaaf8TanuZvN6M8q3KbcgdPkZsAEx6asnvYQptPrM/qnj/1pBQi/4
         8z3Hu0OJhLMCHaYPx1Bk/fY+D6wH0BklW61cXm7dpnN54P7x1HEd/CFocPEXsWM2W87g
         mPNg9ODGqGVQu6z/ok+0AeRfq8yqR+eyfrjI7CD7H4hJ68tGPd1NVP1Lkkdz1boC6A/E
         PQUw==
X-Gm-Message-State: AOJu0Yx3cSITdAB2jYT/NRE8ys/Ne1gs408tS0izxxvLrjdQ/VBnWWkF
	9l+bwbTXdmzJeUVsgFYaOss=
X-Google-Smtp-Source: AGHT+IEcVwFwZJ5mQi958wdtfvittuLWHhaAGfi1ZgN0TRICD4DU+9l4G3iK/aHHQ+WZcZJkUp/iFA==
X-Received: by 2002:a05:622a:1a9e:b0:419:a2c6:8213 with SMTP id s30-20020a05622a1a9e00b00419a2c68213mr976722qtc.5.1697213459443;
        Fri, 13 Oct 2023 09:10:59 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v8-20020a05622a188800b00418142e802bsm710641qtc.6.2023.10.13.09.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 09:10:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 5C83727C0054;
	Fri, 13 Oct 2023 12:10:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 13 Oct 2023 12:10:34 -0400
X-ME-Sender: <xms:-mspZcDej8-1zyzzaEIvajcaHt1E5kwpyxQbF_YYd-ZR7rI1bSdonw>
    <xme:-mspZehzWMMnyHZ103SoBx5HJ-rFoKWHGE1g8eHh-GkS-Y9eyH62vgBxrZYIYyiP_
    cisqjNKuu4MSWPz9Q>
X-ME-Received: <xmr:-mspZfkhDKbvPxhUJq5HMcEsaH2z4Yvf5ieNVlN8l22P1tyvY3vJd0W8Tgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieefgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:-mspZSyZHx7bYn5ELXqaVVNRVbh0WfWuvOPIYPvMaQqv5nGCILciTQ>
    <xmx:-mspZRSE5c_3SZE15Rj3hYEF387wbizhyxKKs3e6VWJNwYm96STUAQ>
    <xmx:-mspZdbQuVS97UEwaBk6IKXa2KrIzhcu7k3QHQGe45n-7IF9VE0gXA>
    <xmx:-mspZcF62z3yG_ykaXlwUGv5sTnCRDgwtiyTfXmQmsUKbdD72fDq7g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Oct 2023 12:10:33 -0400 (EDT)
Date: Fri, 13 Oct 2023 09:10:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu,
	wedsonaf@gmail.com, benno.lossin@proton.me, greg@kroah.com
Subject: Re: [PATCH net-next v4 3/4] MAINTAINERS: add Rust PHY abstractions
 to the ETHERNET PHY LIBRARY
Message-ID: <ZSlr88x2OVlAw1SJ@boqun-archlinux>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
 <20231012125349.2702474-4-fujita.tomonori@gmail.com>
 <ZSlVgAfz-O5UR_ps@Boquns-Mac-mini.home>
 <20231014.002431.1219106292401172408.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014.002431.1219106292401172408.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 12:24:31AM +0900, FUJITA Tomonori wrote:
> On Fri, 13 Oct 2023 07:34:40 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Thu, Oct 12, 2023 at 09:53:48PM +0900, FUJITA Tomonori wrote:
> >> Adds me as a maintainer for these Rust bindings too.
> >> 
> >> The files are placed at rust/kernel/ directory for now but the files
> >> are likely to be moved to net/ directory once a new Rust build system
> >> is implemented.
> >> 
> >> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> >> ---
> >>  MAINTAINERS | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 698ebbd78075..eb51a1d526b7 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -7770,6 +7770,7 @@ F:	net/bridge/
> >>  ETHERNET PHY LIBRARY
> >>  M:	Andrew Lunn <andrew@lunn.ch>
> >>  M:	Heiner Kallweit <hkallweit1@gmail.com>
> >> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
> >>  R:	Russell King <linux@armlinux.org.uk>
> > 
> > Since Trevor has been reviewing the series and showed a lot of
> > expertise, I suggest having him as the reviewer in Rust networking, of
> > course if he and everyone agree ;-)
> 
> There is no such thing as Rust networking :) This is PHYLIB entry.
> 

Right, my bad ;-)

> If it's ok with the PHYLIB maintainers and Trevor, I'm happy to add
> him.

Thanks!

Regards,
Boqun

