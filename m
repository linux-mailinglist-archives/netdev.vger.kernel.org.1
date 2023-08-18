Return-Path: <netdev+bounces-28767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3317809E9
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90F928234E
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047D11801B;
	Fri, 18 Aug 2023 10:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E863B4
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:21:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1313589
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 03:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692354113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MMCs5YxFvVB+fiLSaL+VMY2Wpe2VaOEHRXiYp6vzx4M=;
	b=PWviVAYMSjmglLBYghajp03zLc2Ttfnref8xJV04Ci/4IW7pqeIDftFlCi2UG8nFKREMQ3
	S/qJlwO6qJRjZ18jpxUTtuuD3FY7dCOimeuxzoniSqjkZrXQKwDcsEfacmEuXj5AZmfFk6
	WwpHtPFoFEpv5DIgNPvIyQtznl91oWk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-x0AYZ8EeMJ6V0bMLxYgcjg-1; Fri, 18 Aug 2023 06:21:52 -0400
X-MC-Unique: x0AYZ8EeMJ6V0bMLxYgcjg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56c877bb4a9so899457eaf.2
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 03:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692354111; x=1692958911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMCs5YxFvVB+fiLSaL+VMY2Wpe2VaOEHRXiYp6vzx4M=;
        b=LLPUtfdbmq2Y7UuoqICn+tEHy7bTxRQiNoI1gpZuhbbPVlV0t2BhT2e1mTcH9VevL9
         HLAd71M39SJMpN0zJcxPhpBG2t0y41LqJZeCq21Pt15exuvDyxYPuKBZiNOj90OnhrIF
         JzHbfqSViNVfv5MSYuKH/t+zJlf92khKl0x1YtJ5GW3FHKuhFb0BjGpGUpeKkAXGZuXh
         wP/kYOcP19Ua+iJ2GcaI1SFR5oKbKFuADLTISuyx7qKAEaahuImd0M/FTYw/9zVZL1aD
         pmFB9JBk4ojR9MTGJow1fei2PkNiqWXAby1ycOSkGwE33Twcd8oKPvcILbp5dGw2gZPV
         lckA==
X-Gm-Message-State: AOJu0Yzjj8yCJE4SpkYBYboESlfw21bzd2oABxI8ciKKZ5BflhYkF3eR
	b72U8hQ4B8XQ3G2+hFbTigi1q0rxs+1fT8k2xHApq5990pDH4+ZivFAFZsMNUbQs0dLHiFP9MB+
	8KHYR+du+DKQ529EgUn6ys6NWv3zreM0O
X-Received: by 2002:a05:6358:27a4:b0:139:c7cb:77d4 with SMTP id l36-20020a05635827a400b00139c7cb77d4mr2316828rwb.24.1692354111670;
        Fri, 18 Aug 2023 03:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVl7u3okw/rSA7AwHYEXaUXprn/MNPwiAA8hA7Tw09iDT4nRzegrWi2GlgLqVnNfTt3BzQBxpRCirLH8dFvMw=
X-Received: by 2002:a05:6358:27a4:b0:139:c7cb:77d4 with SMTP id
 l36-20020a05635827a400b00139c7cb77d4mr2316801rwb.24.1692354111375; Fri, 18
 Aug 2023 03:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230815194254.89570-1-donald.hunter@gmail.com>
 <20230815194254.89570-6-donald.hunter@gmail.com> <20230816082030.5c716f37@kernel.org>
 <CAAf2yc=C4N=QT6hpxmLi-uywc+MhuLdAsbfPRORv5ms9k1JAfQ@mail.gmail.com> <20230817183751.194d547a@kernel.org>
In-Reply-To: <20230817183751.194d547a@kernel.org>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Fri, 18 Aug 2023 11:21:40 +0100
Message-ID: <CAAf2yckUjoKOqxF1uMB+3jo9gQomSfva72WKZmpKjKUdFpQqCQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/10] tools/net/ynl: Refactor
 decode_fixed_header into NlMsg
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Stanislav Fomichev <sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 18 Aug 2023 at 02:37, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 17 Aug 2023 16:14:35 +0100 Donald Hunter wrote:
> > > It's a bit of a layering violation that we are futzing with the raw
> > > member of NlMsg inside GenlMsg, no?
> > >
> > > Should we add "fixed hdrs len" argument to NlMsg? Either directly or
> > > pass ynl and let get the expected len from ynl? That way NlMsg can
> > > split itself into hdr, userhdrs and attrs without GenlMsg "fixing it
> > > up"?
> >
> > I agree, it breaks the layering. The issue is that GenlMsg gets created at
> > some point after NlMsg, only when we know the nl_msg is suitable for
> > decoding. The fixed header bit is quite well encapsulated in NlMsg,
> > it's the genl header that needs pulled out and NlMsg shouldn't know
> > anything about it. How about I add a take_bytes(length) method or a
> > generic decode_subheader(format, length) method to NlMsg?
>
> Why do we need to fix up the .raw of NlMsg underlying the GenlMsg
> in the first place? GenlMsg by itself didn't need to do that until now.

Fair point. I will refactor to leave nl_msg.raw untouched.

> Another option to consider which would make things more symmetric
> between raw and genetlink would be to add a wrapper class for old
> families, too. ClassicMsg? CnlMsg? That way we could retain the
> separation of NlMsg is just a raw message which could be a NLM_DONE or
> some other control thing, and higher level class being used to pull
> fixed headers and separate out attrs. Just a thought, not sure it helps.

I _think_ I can avoid doing this. There's an asymmetry to the way
the NlAttrs get created that I need to fix. When I do that, the rest
should be a bit cleaner.


