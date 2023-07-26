Return-Path: <netdev+bounces-21127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB97628A7
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB61281B51
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462FD111F;
	Wed, 26 Jul 2023 02:16:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8C7C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:16:12 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02D02707
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:16:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-55adfa61199so4399720a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690337768; x=1690942568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hjNxREQH5BDBq3OYYRudVRIq/XRC01xqv+GSOmQWD8=;
        b=1Ku/JXypIySY/urxIwpXvaLjO4d2HZylJ92qfdOftS4Nna2kczBdFypwfisStSj2H7
         W6bstqUBYq65Q8tC++JyI3iUT1ufxBovxg0p5cjwBbevFb6dc1osTwD0I83S6L2axENf
         0zL4pJIiWPb/9UOt6Gb4+oCTNaCbuMPwt82lKaleY6kATjrn2kISJnjYY9lKk03oS6ZN
         LmMBoxjmF9RGgmKgBoxtPmJhT8SVB6nnIds585gBwCSXdV1f1DalxWemUj3BXzO8iZpG
         p5/5F1JpTkHP0Ma1F73Hk2zTrZzJ0p71UGPSy5cZZqHiQCRJdz8Pv948VqvuorClI9YX
         CSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690337768; x=1690942568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hjNxREQH5BDBq3OYYRudVRIq/XRC01xqv+GSOmQWD8=;
        b=a45jpLIh0mArIoYwSBCtnMW3kmwT8LcYTcjX2VV9+24+SQbn2zTfhdYzUh/QAXGo+o
         8jmT44TESCntCNOU+vee0YwdygYxfIwyXJtenk51R+E4ZB+iOYvyWptSuw8uJACinJM7
         MEAjUdguFSWvPxwvLFb1BkEV/pd9FF55LIZOk+ak1ACEmR3vT/jTeeCnRrxx8wkTPuPH
         8lf8SHso4Jht6Qo/axFWs9BdAizQ4hTESua9S5WdIiixguoLOUZHiTTgJhrsbbFzb2lc
         /4sd1OMvfGpgCA6AO1pn6MjzsrGLjdN03jiMDGRkyhGXhF4SqAV/SsduXox3+vrpIgR+
         TBMQ==
X-Gm-Message-State: ABy/qLY0GpUYrPeHI+7NA1P2BFXcNviXGXECoZXZgunAC1l8Nnv2CnIv
	UFaNj1dtYqsuQ4rX8tuBWKDX4zwfgcrwU8TMnhgbpA==
X-Google-Smtp-Source: APBJJlEHhL9NwLVIUqy5Q6/ovKYLt9nBnfRstpYf3JNOBuLuXXCak9OvVHRXOgbZyoolUtAdSVitGQ==
X-Received: by 2002:a17:902:934c:b0:1b8:954c:1f6 with SMTP id g12-20020a170902934c00b001b8954c01f6mr805682plp.36.1690337767945;
        Tue, 25 Jul 2023 19:16:07 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001b8a00d4f7asm11772486plf.9.2023.07.25.19.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 19:16:07 -0700 (PDT)
Date: Tue, 25 Jul 2023 19:16:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Nicolas Escande" <nico.escande@gmail.com>
Cc: <netdev@vger.kernel.org>
Subject: Re: [iproute2] bridge: link: allow filtering on bridge name
Message-ID: <20230725191605.3ca8e599@hermes.local>
In-Reply-To: <CUBL17I9Z3W5.1XR1LVI9CRDDU@syracuse>
References: <20230725092242.3752387-1-nico.escande@gmail.com>
	<20230725093725.6d52cc03@hermes.local>
	<CUBL17I9Z3W5.1XR1LVI9CRDDU@syracuse>
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

On Tue, 25 Jul 2023 23:48:16 +0200
"Nicolas Escande" <nico.escande@gmail.com> wrote:

> On Tue Jul 25, 2023 at 6:37 PM CEST, Stephen Hemminger wrote:
> > On Tue, 25 Jul 2023 11:22:42 +0200
> > Nicolas Escande <nico.escande@gmail.com> wrote:
> >  
> > > When using 'brige link show' we can either dump all links enslaved to any bridge
> > > (called without arg ) or display a single link (called with dev arg).
> > > However there is no way to dummp all links of a single bridge.
> > > 
> > > To do so, this adds new optional 'master XXX' arg to 'bridge link show' command.
> > > usage: bridge link show master br0
> > > 
> > > Signed-off-by: Nicolas Escande <nico.escande@gmail.com>  
> >
> > Looks good to me, but we really need to address removing the term master
> > from bridge utility.  
> 
> If you have a better term I can respin it.
> But the thing is 'master' is still the most widely used and understood word when
> it comes to bridge terminology. And as you said we have it in the output of many
> 'ip' and 'bridge' commands, that why IMHO it's the term we should use for now...


Leave it there for now. Only Linux uses the term master.
FreeBSD and other use the term adding interface to bridge (addm)

IEEE uses the term relay mostly.

You won't find the terms master/slave in any current spec.

> On another note, there is a slight indentation problem in the new if in
> print_linkinfo(), if that can be corrected when the patch gets picked up that
> would be perfect, otherwise I can send a v2.

Send a v2, that would be easier



