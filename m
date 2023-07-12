Return-Path: <netdev+bounces-17300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955457511D8
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A341281AD1
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 20:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1AFDDC8;
	Wed, 12 Jul 2023 20:31:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F75A29B0
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 20:31:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F03E1FE4
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689193910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CLC6MS7IctwmXUDETfJjR5ufwkPsFb5h2nwSk8tNn0=;
	b=ZcL2cz4ri9YKQThlav8hWYZYM9FCcmpKRu9q9NcqMStemw50Z+BXoYnI6NRN2aoQM+DbC2
	b6xmUWSeF9DYcJSsp7Fm6K0A3lJt6VxZuxsaB8KYr++9rtuJgKsMYUHOZNI+eei12Y7ePx
	IDqOgAz6NVML6xGdfRpRVNqvRLKKsYo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-P9lqqYfEOvyWVrz3ZsL3JA-1; Wed, 12 Jul 2023 16:31:49 -0400
X-MC-Unique: P9lqqYfEOvyWVrz3ZsL3JA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-765ad67e690so159596585a.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689193908; x=1689798708;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CLC6MS7IctwmXUDETfJjR5ufwkPsFb5h2nwSk8tNn0=;
        b=HR0YDC1E6nErSlFP2JdAiCfteoLtCKl/kiXqrSnn2O6oO1s/qZtQXcu7f+eQOnx+yz
         gr8I3G7VyDuBMzqOvdKEOblRnfAfL6fAyRUOMexSXF+GRNwzzZoUdgBkIPYDmg0rtqUO
         XWHXwFE+q2oD6LOJkw0SETIL6hltWw9N5eew+nLdC2iHzeNMSVS0om4y/34xARDC3dXC
         YAfH0wuIRb7bmxbShDbsIUr1wmKdes5/cA9IV/Gl332btCYQ62iPV3QMvBR/rkZStUuR
         VWV+cF2Aum1ezk7RV1oVTWdzdiT4GWqZNcbSO+IOsX0q+Q3zExJiiD/ttTnLPNtu52sn
         JR/g==
X-Gm-Message-State: ABy/qLbNzovs44EKYSSQK3lqe0pK1jMvWXnmoXST82MrPu+ARGw3O2Ub
	D4NLqd4AQNLq84cX7XzJmhl8a2KTUANzfYr85LzNpTH+FnXRYnDWzQxArSBGsrIb0NErfGt8uuL
	sPJUPaBBG1kHnI+Wp
X-Received: by 2002:a05:620a:440b:b0:765:97b7:cfb5 with SMTP id v11-20020a05620a440b00b0076597b7cfb5mr341711qkp.6.1689193908736;
        Wed, 12 Jul 2023 13:31:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEUAP696XqbPkuEMI2+Hl6TdkwAxaT6QN2HelvP54O4pCPt4Q3r/Nqj4e8ew8o2bLCj62o4SQ==
X-Received: by 2002:a05:620a:440b:b0:765:97b7:cfb5 with SMTP id v11-20020a05620a440b00b0076597b7cfb5mr341697qkp.6.1689193908480;
        Wed, 12 Jul 2023 13:31:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id r30-20020a05620a03de00b00767f00a9c67sm571192qkm.95.2023.07.12.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 13:31:48 -0700 (PDT)
Message-ID: <c3ad12394627fffc5a0d8e48e019e6ef61814597.camel@redhat.com>
Subject: Re: [PATCH net-next 3/3] eth: bnxt: handle invalid Tx completions
 more gracefully
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	michael.chan@broadcom.com
Date: Wed, 12 Jul 2023 22:31:45 +0200
In-Reply-To: <20230712093418.5578c227@kernel.org>
References: <20230710205611.1198878-1-kuba@kernel.org>
	 <20230710205611.1198878-4-kuba@kernel.org>
	 <774e2719376723595425067ab3a6f59b72c50bc2.camel@redhat.com>
	 <20230711181919.50f27180@kernel.org>
	 <5b722084c6031009f845e6af8b438d49b9ea7dc1.camel@redhat.com>
	 <20230712093418.5578c227@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-12 at 09:34 -0700, Jakub Kicinski wrote:
> On Wed, 12 Jul 2023 08:50:06 +0200 Paolo Abeni wrote:
> > Surely not a big deal. But some users (possibly most of them!) have
> > older compiler.
>=20
> I checked GCC 10 and GCC 9, and the code is the same :(
> Any idea on how old do we need to go?

I guess that would be more then enough!

> > Including an assignment in the test code, I get this
> > additional difference:
> >=20
> > -   c:	80 4b 09 01          	orb    $0x1,0x9(%rbx)
> > +   c:	c6 43 09 01          	movb   $0x1,0x9(%rbx)
> >=20
> > with the bitfield using the 'or' operation. Not a big deal, but the
> > other option is slightly better ;)
>=20
> Is there really any difference whether one changes a byte or ors
> in a bit? Either way it's a partial update of a word.

Really not a big deal, but 'or' fetches memory and then store it, while
move [immediate] is a single store. In case of a cache miss, 'or'
should stall, while 'mov' should not. In general with 'mov' there
should be less pressure on the cache and/or bus.

Cheers,

Paolo


