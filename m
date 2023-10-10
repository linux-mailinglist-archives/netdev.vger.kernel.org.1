Return-Path: <netdev+bounces-39535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C414D7BFA6A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866CF281B04
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156AF19447;
	Tue, 10 Oct 2023 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrGTGY+N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D515AE8
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:54:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47F0AC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696938857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tbnLdjCwjILQJD/IMnGZzaAGrTaKd8Yu5qRfKcHrbI=;
	b=XrGTGY+N2m8BS8m+9d4u6sgrMJehyB1dTECdVucl6RqAVKfN04X9w4qbDjgAxOZQlRYJSk
	1yfew0etA+EClmpb1sOag3B2r+ylhf1ikvsWI7XEdB3dJNMyNTju24ryycDnu6AQIKtIgi
	KmrNnqEBrVzx6rbpegreddsLCt8cPtI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-anpKG0JiO6OTY8UlxEu0zw-1; Tue, 10 Oct 2023 07:54:15 -0400
X-MC-Unique: anpKG0JiO6OTY8UlxEu0zw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-536294c9526so4502916a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696938854; x=1697543654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3tbnLdjCwjILQJD/IMnGZzaAGrTaKd8Yu5qRfKcHrbI=;
        b=UAz/Dro3RyxDz1EMDDavpQr4q/R8NFIZuQkmISvyEDF/lHyRHOR/DgH2YEsNEdc7KI
         0w6U2JidpaDiAcP6/Ypfov0QFYAKvTGbCSb0JwZrirQ9kaz5IaaxUTFIquFTxHn7fEiY
         I+RDl8WGp0xvnzmP6LjDPnlVMf8Y+DElJvOs90g7X3uEFPxs2WUqJY94c9t9eoj9N693
         167VjQ/CHDZiGU0lsCWU9TCkKcxzTrm5Fw0gdFEgm3fTgvvdV6rPuywBEsu8z6Ad4Lu+
         cppgGKkvFHOkCpzj4E09VAelXC5SUsMjX65QumGp0dKSJawpLVNmivvWW2TLYRmw26Wm
         ntGA==
X-Gm-Message-State: AOJu0Yy4KcwehhypbfCbSD9NwUjUAPIHt2XXPnBxtpVlg+Rv9j6yKXFQ
	g+134t8DeOuDpJwK8GgSAlvLQLjY9GpTdrEhNBzaBUslkEQbYgYDeEjZp6Lco2eSHHF56U0N0Et
	+z6C9bZ/6GUAYRy4R8E8rStscb0bKgHNP
X-Received: by 2002:aa7:d94e:0:b0:530:bd6b:7a94 with SMTP id l14-20020aa7d94e000000b00530bd6b7a94mr17557821eds.24.1696938854752;
        Tue, 10 Oct 2023 04:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZcl390EAyEeWbkdMIglY8Vca/IQGNUJlT+C/+JvFZnnsB02OuxrK+/NPH1WRteqUcfv2bnHNQWmXT6+/8B5Q=
X-Received: by 2002:aa7:d94e:0:b0:530:bd6b:7a94 with SMTP id
 l14-20020aa7d94e000000b00530bd6b7a94mr17557792eds.24.1696938854353; Tue, 10
 Oct 2023 04:54:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Oct 2023 04:54:12 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
 <20231006152516.5ff2aeca@kernel.org> <CAM0EoM=LMQu5ae53WEE5Giz3z4u87rP+R4skEmUKD5dRFh5q7w@mail.gmail.com>
 <ZSEw32MVPK/qCsyz@nanopsycho> <CAM0EoMnJszhTDFuYZHojEZtfNueHe_WDAVXgLVWNSOtoZ2KapQ@mail.gmail.com>
 <ZSFSfPFXuvMC/max@nanopsycho> <CAM0EoMmKNEQuV8iRT-+hwm2KVDi5FK0JCNOpiaar90GwqjA-zw@mail.gmail.com>
 <ZSGTdA/5WkVI7lvQ@nanopsycho> <CALnP8ZbD_09u+Qqd2N4VcrstuGexh7TiNAtL7n4pyUvLAQ8EOw@mail.gmail.com>
 <ZSUAF7tzCq+Vwj2I@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZSUAF7tzCq+Vwj2I@nanopsycho>
Date: Tue, 10 Oct 2023 04:54:12 -0700
Message-ID: <CALnP8ZZkPO-QgoPCZRyryxmZNaPLSQyNNUtkZ8PKHAtoKKvJwQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, vladbu@nvidia.com, 
	simon.horman@corigine.com, pctammela@mojatatu.com, netdev@vger.kernel.org, 
	kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 09:41:11AM +0200, Jiri Pirko wrote:
> Mon, Oct 09, 2023 at 10:54:07PM CEST, mleitner@redhat.com wrote:
> >On Sat, Oct 07, 2023 at 07:20:52PM +0200, Jiri Pirko wrote:
> >> Sat, Oct 07, 2023 at 04:09:15PM CEST, jhs@mojatatu.com wrote:
> >> >On Sat, Oct 7, 2023 at 8:43=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> =
wrote:
> >...
> >> >> My primary point is, this should be mirred redirect to block instea=
d of
> >> >> what we currently have only for dev. That's it.
> >> >
> >> >Agreed (and such a feature should be added regardless of this action)=
.
> >> >The tc block provides a simple abstraction, but do you think it is
> >> >enough? Alternative is to use a list of ports given to mirred: it
> >> >allows us to group ports from different tc blocks or even just a
> >> >subset of what is in a tc block - but it will require a lot more code
> >> >to express such functionality.
> >>
> >> Again, you attach filter to either dev or block. If you extend mirred
> >> redirect to accept the same 2 types of target, I think it would be bes=
t.
> >
> >The difference here between filter and action here is that you don't
> >really have an option for filters: you either attach it to either dev
> >or block, or you create an entire new class of objects, say,
> >"blockfilter", all while retaining the same filters, parameters, etc.
> >I'm not aware of a single filter that behaves differently over a block
> >than a netdev.
>
> Why do you talk about different behaviour? Nobody suggested that. I have

Because if mirred gets updated to support blocks, that's what will
happen. It will have options that only make sense for netdev or for
blocks.

> no idea what you mean by "blockfilter".

Well, it's described above. It was just an example.

>
>
>
> >
> >But for actions, there is the option, and despite the fact that both
>
> Which option?

To create a new action.

>
>
> >"output packets", the semantics are not that close. It actually
> >helps with parameter parsing, documentation (man pages), testing (as
> >use and test cases can be more easily tracked) and perhaps more
> >importantly: if I don't want this feature, I can disable the new
> >module.
> >
> >Later someone will say "hey why not have a hash_dst_selector", so it
> >can implement a load balancer through the block output? And mirred,
> >once a simple use case (with an already complex implementation),
> >becomes a partial implementation of bonding then. :)
> >
> >In short, I'm not sure if having the user to fiddle through a maze of
> >options that only work in mode A or B or work differently is better
> >than having more specialized actions (which can and should reuse code).
>
> Sure, you can have "blockmirredredirect" that would only to the
> redirection for block target. No problem. I don't see why it can't be
> just a case of mirred redirect, but if people want that separate, why
> not.
>
> My problem with the action "blockcast" is that it somehow works with
> configuration of an entity the filter is attached to:
> blockX->filterY->blockcastZ
>
> Z goes all the way down to blockX to figure out where to redirect the
> packet. If that is not odd, then I don't know what else is.

Maybe fried eggs with chocolate. :-D
Just joking..

>
> Has other consequences, like what happens if the filter is not attached
> to block, but dev directly? What happens is blockcast action is shared
> among filter? Etc.

Good points!

>
> Configuration should be action property. That is my point.

Makes sense. Whoever is adding such filter, already knows the block,
and can add the parameter to the action as well. Making it automatic
is not helping out that much in the end.

  Marcelo


