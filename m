Return-Path: <netdev+bounces-21647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BFB764165
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979051C213BD
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05A1BF1A;
	Wed, 26 Jul 2023 21:49:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26B1BEFF
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:49:08 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D6CFA
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:49:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2681223aaacso152913a91.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690408146; x=1691012946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb9YC8hX6XkLT5eoXX1Q191alkB1moi8bE43Sv0cxAk=;
        b=NTs46ZmS8vMcavND5PT3/eJjZqozvM9sZdOaTTfggmuMq/v6EWcTSLxukHVyzbReRx
         nGfnGS2TkEdUpih0FM2qP9jVHTXpU4GqUK5kjZAd0IwcnqYnAeo4LnCMqFSBRWbVp8Zn
         YfaKFVCQKV+RZ2RZdJfey7LX8c9OzP3XDdXOP4l5wkaTpjA+TIZU4NHlSrcodzZMkBWq
         6jIWZ9SHDxFuoDJKSip4T0KUDSCXZ9+unt8PQwOeExAF28OedwJj3LFfTNx3JtoQeaJk
         kxUz7eWZbMExr1v1damwa7h5HyvwlTNyoFhjcjD88GEv2b5XLLLuD6drDZFJX4Obtpei
         Tluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408146; x=1691012946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mb9YC8hX6XkLT5eoXX1Q191alkB1moi8bE43Sv0cxAk=;
        b=CUKW4xhcDrPXKsjUicTlxwKpgsR32uU9sYNMI9JbYCMp7Jri7vTRsBBWUNlWcXmVx0
         ZJrM2G/jbnbjWoAcFdmWlTknQ9nuzOwrFxYZx0xW72DNkY7N/t/D5GMjHsXf2pybsrgG
         FWgv2v72dFsvgVQ4OaQnCFMJVmoZgzUpMj9tM49FWt16eZYUy3aI6BPT4ScSwsUMuand
         zFsTh5zWWDzu3lujQuXALJ3JNRkG2APsj0AkO1RSFZFhROmijUTyzz/Sa5PvJenEWYU9
         ZEUHsWdxZwjtxhH07lXZJvskXvqN68i1Q46MkJq90fgzxZrnZ0wbfQPcyah7FdedPDW5
         KVRw==
X-Gm-Message-State: ABy/qLboARbSaPUWREhEcCSGGhgOxKpCgwRhdJ6uCvIU22Z7KBz9zuII
	EXidV9+WoGINXN2EWAdsNibdVrpWtq12Ja82j5g=
X-Google-Smtp-Source: APBJJlFBY2Pc2jVV3aq3KHm7YTfI6xXx4yhiWaXuBE8/GinfbucCTHgvqY+1ArnMSyjqpIuMZJ56a6s3csNYgKI8S4g=
X-Received: by 2002:a17:90b:3a8c:b0:263:3386:9da3 with SMTP id
 om12-20020a17090b3a8c00b0026333869da3mr782457pjb.17.1690408145669; Wed, 26
 Jul 2023 14:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725162205.27526-1-donald.hunter@gmail.com>
 <20230725162205.27526-2-donald.hunter@gmail.com> <20230726140941.2ef8f870@kernel.org>
In-Reply-To: <20230726140941.2ef8f870@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 26 Jul 2023 22:48:54 +0100
Message-ID: <CAD4GDZy5BC6F_Asopz4WRnZ5KBasdHpchoseafcKwbBZ3ZLySQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/3] doc/netlink: Add a schema for netlink-raw families
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 at 22:09, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 25 Jul 2023 17:22:03 +0100 Donald Hunter wrote:
> >  - add an id property to mcast-group definitions
>
> nit: my first thought would be to call it "value" rather than "id"
> to stick with the naming we have to other objects. Any pros/cons
> you see?

Yep, that makes sense. I wasn't sure about "id" anyway but it didn't occur
to me to align with "value".

> Other than that the big ask would be to update the documentation :)

Do you mind if I update the docs as a follow up patch? I'm on holiday for
the next 10 days - I should have time to respin this patchset but maybe
not to work on docs as well.

