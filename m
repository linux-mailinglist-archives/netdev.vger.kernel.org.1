Return-Path: <netdev+bounces-32715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0015799A43
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 19:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D8F280FF4
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E6A7484;
	Sat,  9 Sep 2023 17:34:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6589746C
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 17:34:44 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7123B12C
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 10:34:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-573ccec985dso2286140a12.2
        for <netdev@vger.kernel.org>; Sat, 09 Sep 2023 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1694280882; x=1694885682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb7Lm6JGvWMPHNMySSc24TURh8IEOR8HmhYqff4klrA=;
        b=Wal/MlU5hAJaPNCZbQqnMvAhZgr8AH77ZiZndlfupAeZYXhGOB/KqQXvTa+AVAWkDC
         uWZucgGi57vxxrhiG1couK+Bws9bkHSQ/muvrXcPWQdZl2un4HRY9k4puHt3b+s6/hS5
         Y+pKjjILLHUHOzRYt2hvR9xs7jo0KYYjGZZhUiOF5858uYqwa1mSr2REYnZra5DDAMim
         WHHapEULIJow3VLldqXZHLlonT/KKB23yi/cF8KO7uvzkqhril7BbRgKxuuNN4WZdA3J
         DhMW2XFQ2qDeiGDnK+uD/8UxN71Hub+pTgc5egwCxis7SThdvZsnpoflI//YoJjsNUDZ
         Zqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694280882; x=1694885682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rb7Lm6JGvWMPHNMySSc24TURh8IEOR8HmhYqff4klrA=;
        b=oWNHPtou7g8AA8jTcU98ei2QE0BlwztFVswMZ+NOtxPuUvnMtBw2Xi2Q8PgnPbws4V
         PrjYzZKTv7JhPYmuxe3N0+MkEBfMIHdIgAYHBP4O7jxpnOda8Kh/Yto+oyZ5BX4rZYFy
         n00+ZhXxPSZkJG9hu+tBlLfOeyCOvEzjQv/YSXly7/EREUSGAlLJakzOCSVEl6oEhapb
         qsd4oynhLZ2MJ8VBWBK8Wa28A+byUOa3b3ENjb/+exoCXqTU+n/hdBhPr3ekBT/JKinO
         Vuf/u9r4764PLyYK3UoHOtssMIMj/DH2kvT3oDiLtioVEt5395dxj1mAJ/VAGwYYBc5/
         SR9w==
X-Gm-Message-State: AOJu0YyXFtkpiU7mwmw6Ucv9p02FAo/QhGwbXh1yLgQIxAWXbnXtx/1g
	IfKgAFiS+mgqmXsAeMU8bixl9ZeRsvUxp9nMYVz5gQ==
X-Google-Smtp-Source: AGHT+IEyO6XoHIO8++WS7nm+NWWPjY8eeZ+5YNf/eR0XHp6bi084Ex2eXiughOlaXFTz/E18FD2BE32lP1UlqFPMLRI=
X-Received: by 2002:a05:6a20:7fa7:b0:141:69d:8041 with SMTP id
 d39-20020a056a207fa700b00141069d8041mr8030130pzj.48.1694280881974; Sat, 09
 Sep 2023 10:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230904021455.3944605-1-junfeng.guo@intel.com>
 <20230905153734.18b9bc84@kernel.org> <CALx6S34B_BvkNuqALCCT+2V2dL8rwr9n_DnRfevjkW4UwMF=pw@mail.gmail.com>
 <8df3c9c6-19ed-acc8-f2ac-1826a81ab53c@intel.com>
In-Reply-To: <8df3c9c6-19ed-acc8-f2ac-1826a81ab53c@intel.com>
From: Tom Herbert <tom@herbertland.com>
Date: Sat, 9 Sep 2023 10:34:30 -0700
Message-ID: <CALx6S345sufnhn6zVO03ZauDiU52F9SbbZTgaGm6xxr=yKyPUQ@mail.gmail.com>
Subject: Re: [PATCH iwl-next v9 00/15] Introduce the Parser Library
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Junfeng Guo <junfeng.guo@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com, qi.z.zhang@intel.com, 
	ivecera@redhat.com, horms@kernel.org, edumazet@google.com, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 12:10=E2=80=AFPM Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
>
>
>
> On 9/5/2023 6:05 PM, Tom Herbert wrote:
> <snip>
>
> > Yes, creating an elaborate mechanism that is only usable for one
> > vendor, e.g. a feature of DDP, really isn't very helpful. Parsing is a
> > very common operation in the networking stack, and if there's
> > something with the vanglorious name of "Parser Library" really should
> > start off as being a common, foundational, vendor agnostic library to
> > solve the larger problem and provide the most utility. The common
> > components would define consistent user and kernel interfaces for
> > parser offload, interfaces into the NIC drivers would be defined to
> > allow different vendors to implement parser offload in their devices.
>
> I think naming this framework as 'parser library' may have caused the
> misunderstanding. Will fix in the next revision. This is not a generic
> network packet parser and not applicable to kernel flow dissector. It is
> specific to ice and enables the driver to learn the hardware parser
> capabilities from the DDP package that is downloaded to hardware. This
> information along with the raw packet/mask is used to figure out all the
> metadata required to add a filter rule.

Sriidhar,

Okay, the DDP includes a programmable parser to some extent, and these
patches support the driver logic to support that programmable hardware
parser in ICE. It's still unclear to me how the rest of the world will
use this. When you say you the information "is used to figure out all
the metadata required to add a filter rule", who is adding these
filter rules and what APIs are they using? Considering you mention
it's not applicable to kernel flow dissector that leads me to believe
that you're viewing hardware parser capabilities to be independent of
the kernel and might even be using vendor proprietary tools to program
the parser. But as I said, hardware parsers are becoming common, users
benefit if we can provide common and consistent tools to program and
use them.

For instance, the draft mentions the Flow Director use case. How does
the user program the device for a new protocol in Flow Director? Do
you expect this to be done using common APIs, or would you use some
common API like TC Flower offload. And note that while Flow Director
might be Intel specific and not visible to the kernel, something like
aRFS is visible to the kernel but could benefit from a programmable
hardware parser as well. And really, when you think about, what we
really want for RSS, Flow DIrector, and aRFS is *exactly* an offload
the kernel flow director because those are effectively offloads of RPS
and RFS which rely on flow dissector for packet steering in the host
(in fact, the very first flow dissector was created exactly to produce
as packet hash for use with RPS).

Wrt flow dissector, the missing piece is that it's not user
programmable, every time we add a new protocol it's a major pain and
there's no way for users to add their own custom protocols. Frankly,
it's also spaghetti code that is prone to bugs (I take liberty in
calling it spaghetti code because I am one of the parties responsible
for creating it :-) ). We are working to completely replace the flow
dissector with an eBPF program to solve that. I don't believe we
should force devices to run an eBPF VM, so in order to do parser
offload we can start with a higher layer abstraction of the parser in
a declarative representation (for instance, see the Common Parser
Language I presented at netdev conference). Given the abstracted
program, the idea is that a compiler could produce the instructions to
program the hardware parser in a device with the exact same
functionality that we'd have in a programmable kernel flow dissector.
In this way, we can achieve a proper parser offload.

So I think one of the requirements in hardware parsers is to offload
flow dissector. If that is the requirement, do you think these patches
are aligned with that?

Tom

