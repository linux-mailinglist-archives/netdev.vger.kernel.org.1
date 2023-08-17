Return-Path: <netdev+bounces-28512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2303C77FA7C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1F61C21380
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C9B154A4;
	Thu, 17 Aug 2023 15:14:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873A154A3
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:14:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31172D7E
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692285289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rMcUmL6AXhc8fjvYYEPQQR3T2MZJhmm7V1iY9JABclU=;
	b=CqtVmSpIVCDc3X0vn8qeW2PX0JmY+QXIkpnjEcwOn3ovtJgCwK2Sj7M3l6n98eCUBnUUiY
	GbNMBGsROuUj50R+bmdhlQ7LWc/3z2c68t0f4asmIYRr10QHF5TSBcwtQtAn3G6y6LGxfg
	aUHFiksdMbv31A4u+qtXroB4sOfFYb8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-tbDB-H3qORid67dZA04t0g-1; Thu, 17 Aug 2023 11:14:47 -0400
X-MC-Unique: tbDB-H3qORid67dZA04t0g-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-589f7d66f22so47758617b3.3
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692285287; x=1692890087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMcUmL6AXhc8fjvYYEPQQR3T2MZJhmm7V1iY9JABclU=;
        b=bEBqqWMRMB1sz+x/WCLATTWni4o0VrMVmjU1mDIMNz9IdPsIqqA1LMvkJ4VklyF4VE
         w4i5TXL3gEEJR/85qFCUx2eztLM9xJuZdzZKIhsSIbOvNaDBdzFrNHOtEVag8THWjnZ3
         aUjRAdoL6IBUcvnqODyTZ/LjqIbjKoUrET+sPQ1TU1uuDtXczBXKjLb56P5hYPxT/Sft
         jdhQ74nTcVWD5+eZ1PAb1XGIMZANu06PaQGS49hiHbGxmKCNxGepp8+xanJyA6Ruo2AY
         mVn0dT62y02sc2hs6rkvozeDIeVTcd6TApeTypj/CU38U7dq32rnPJh9bliLP19u2W2x
         pgMw==
X-Gm-Message-State: AOJu0YxFe8/Z63rMWjQRA/YeuSGezhHfIATyDNq4lDXsvHkALGWB7UNd
	6XCRASbSgyDVju7u8Hf6iqDhmAmajNSXewjJtqnzGboPON6Fmu76TQff2IIIUPc8Ijl0RYRcU66
	GHf8hO9P9kCE3+D3TaroSHRElCAUtJOPp
X-Received: by 2002:a0d:e815:0:b0:583:d9de:8509 with SMTP id r21-20020a0de815000000b00583d9de8509mr5208739ywe.27.1692285286917;
        Thu, 17 Aug 2023 08:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6kNYiYSV9JRT0QmwiIjzWEUy91weshJK4xrpmANQe+cYDzBWzL6xtqQmHQZdAJ3FxjPQjPHtSEClWX7mtyo4=
X-Received: by 2002:a0d:e815:0:b0:583:d9de:8509 with SMTP id
 r21-20020a0de815000000b00583d9de8509mr5208724ywe.27.1692285286693; Thu, 17
 Aug 2023 08:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230815194254.89570-1-donald.hunter@gmail.com>
 <20230815194254.89570-6-donald.hunter@gmail.com> <20230816082030.5c716f37@kernel.org>
In-Reply-To: <20230816082030.5c716f37@kernel.org>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Thu, 17 Aug 2023 16:14:35 +0100
Message-ID: <CAAf2yc=C4N=QT6hpxmLi-uywc+MhuLdAsbfPRORv5ms9k1JAfQ@mail.gmail.com>
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

On Wed, 16 Aug 2023 at 16:20, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 15 Aug 2023 20:42:49 +0100 Donald Hunter wrote:
> > +    def __init__(self, nl_msg, ynl=None):
> > +        self.genl_cmd, self.genl_version, _ = struct.unpack_from("BBH", nl_msg.raw, 0)
> > +        nl_msg.raw = nl_msg.raw[4:]
>
> It's a bit of a layering violation that we are futzing with the raw
> member of NlMsg inside GenlMsg, no?
>
> Should we add "fixed hdrs len" argument to NlMsg? Either directly or
> pass ynl and let get the expected len from ynl? That way NlMsg can
> split itself into hdr, userhdrs and attrs without GenlMsg "fixing it
> up"?

I agree, it breaks the layering. The issue is that GenlMsg gets created at
some point after NlMsg, only when we know the nl_msg is suitable for
decoding. The fixed header bit is quite well encapsulated in NlMsg,
it's the genl header that needs pulled out and NlMsg shouldn't know
anything about it. How about I add a take_bytes(length) method or a
generic decode_subheader(format, length) method to NlMsg?


