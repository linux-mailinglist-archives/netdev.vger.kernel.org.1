Return-Path: <netdev+bounces-33723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C374A79F889
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 05:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A05C28180C
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 03:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF87FE;
	Thu, 14 Sep 2023 03:06:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB947F
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 03:06:16 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D411BD2
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 20:06:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c1f7f7151fso3897045ad.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 20:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694660775; x=1695265575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w01M0493ZvOfZifASnTwFAmm/fuch5cz5Iq7ETBbZMQ=;
        b=ZMCZN0nk7Y3kywEm91GkOw57cpthoKSml7bgyTTq58a7KWzOAq4NOvtWR+yplbONtX
         QP63KGC3zdOi9+m4WqwdypiMCLMK5kQc/L2fcXYiCy+/MHiL3XOLaHgc6DCGh4xi406P
         fdgTkLPRSRH/9lD3TKzjrHaQ0CDsCMbUUlFPLqoFplW4yoqF32vbae+unpMcY3SKgcy5
         hRt8i8E2s3T4UrIMGL3+/k5tkVNvtKplsF9PqEhx4RUc7vyvr6N8I4USbFuKKyxD8VkM
         vvrweTFY/etMLjiJ8S9AsYRav+Cn9SncyzY/MQT598BwlgXv/xoKFVeNBz5Wp3An18Hz
         mUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694660775; x=1695265575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w01M0493ZvOfZifASnTwFAmm/fuch5cz5Iq7ETBbZMQ=;
        b=hKnmo+vDJtnDlqpbtsdSAEhxIv998wqumJjc6Aiyf8hwSiQbOnO2QvXGogfRFqi9ZZ
         LO4+Q3HyhMRrCIV1uSXLskCYXw+Mz0sn9BLOKj9HKmUhBnFJ5lX1JVXXxKZZmFVxGWTR
         S7wjx7WncdnLfXVQmOPx8eM+sTpxCMF7US42dSuhVBmFG6HNzECzuO19TBnbHTzIW4HC
         eCW6JWN/GRw6TzjXeJUN2QVQmPLxe2cnQbFsXL2JCmQnMyBZmf5yKDiRlrE6nFusTSB7
         soUZ3XZgQ5supOBELb2t1EYe+QjUJYW2JL/e9qdHD+oJ7H7Hw+HaSsxwaXZD6FnG/U13
         jMcg==
X-Gm-Message-State: AOJu0YzRCTHjLzzD4o0TRu2SZR//TrIf3NFMn8byBJ4chZeEaU9mOJKd
	VOAB7Mw4YSeolzZHhr3srSg=
X-Google-Smtp-Source: AGHT+IGCSce5F+Qz4UN9WYxMrL5ALI0CCTAm0lUxaELpeTgffzOZCiJ6zlW6nT5Ryo7WoD1Q7jmbOg==
X-Received: by 2002:a17:902:a5c7:b0:1c3:a4f2:7c84 with SMTP id t7-20020a170902a5c700b001c3a4f27c84mr4030105plq.60.1694660774612;
        Wed, 13 Sep 2023 20:06:14 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090311c600b001bbb25dd3a7sm329723plh.187.2023.09.13.20.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 20:06:13 -0700 (PDT)
Date: Thu, 14 Sep 2023 11:06:08 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [RFC Draft PATCH net-next 0/1] Bridge doc update
Message-ID: <ZQJ4oFoPFqbr09O7@Laptop-X1>
References: <20230913092854.1027336-1-liuhangbin@gmail.com>
 <20230913042224.1e44dcaa@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913042224.1e44dcaa@fedora>

On Wed, Sep 13, 2023 at 04:22:24AM -0700, Stephen Hemminger wrote:
> On Wed, 13 Sep 2023 17:28:52 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> > Hi,
> > 
> > After a long busy period. I got time to check how to update the
> > bridge doc. Here is the previous discussion we made[1].
> > 
> > In this update. I plan to convert all the bridge description/comments
> > to the kernel headers. And add sphinx identifiers in the doc to show
> > them directly. At the same time, I wrote a script to convert the
> > description in kernel header file to iproute2 man doc. With this,
> > there is no need to maintain the doc in 2 places.
> > 
> > For the script. I use python docutils to read the rst comments. When
> > dump the man page. I do it manually to match the current ip link man
> > page style. I tried rst2man, but the generated man doc will break the
> > current style. If you have any other better way, please tell me.
> > 
> > [1]
> > https://lore.kernel.org/netdev/5ddac447-c268-e559-a8dc-08ae3d124352@blackwall.org/
> > 
> > 
> > Hangbin Liu (1):
> >   Doc: update bridge doc
> > 
> >  Documentation/networking/bridge.rst |  85 ++++++++++--
> >  include/uapi/linux/if_bridge.h      |  24 ++++
> >  include/uapi/linux/if_link.h        | 194
> > ++++++++++++++++++++++++++++ 3 files changed, 293 insertions(+), 10
> > deletions(-)
> > 
> 
> Not sure this is good idea.
> - you are special casing bridge documentation and there is lots of
>   other parts of iproute2

   Yes, the patch's purpose is to save the work for bridge doc(at present).
   So only the bridge part of iproute2 man page will be updated. I added a
   tag at the start/end of the bridge part. Other parts will not be touched.

> - you are introducing a dependency on python in iproute2

    There is no need to build it. I put it in the tools folder. Any one can
    choose to use or not use it. So I don't think it count for dependency.

> - the kernel headers in iproute2 come from sanitized kernel headers. So
>   fixing the documentation would take longer.

    It doesn't matter. The python script only grab the attr description from
    net-next and convert it to man doc. It doesn't care about the kernel
    header in iproute2.
> 
> What problem is this trying to solve?

The bridge doc in kernel[1] is too old. There are a lot of details hide in
the kernel code and new developer is hard to catch up. So the kernel bridge
doc page need an update. 

You could say the iproute2 bridge documentation is new and updated. We can
take it as the new bridge doc. But iprotue2 bridge doc only contains uAPI.
The kernel API doc is still needed.

On the other hand, the bridge developers already speed a lot effort on iproute2
bridge documentation. It would introduce more work and complex to maintain
the kernel and bridge doc at the same time.

So I suggest to only maintain the kernel doc. And convert the kernel part
directly to iproute2 man page. With this, we can maintain the doc in one
place and update them both on kernel and iproute2.

[1] https://www.kernel.org/doc/Documentation/networking/bridge.rst

Thanks
Hangbin

