Return-Path: <netdev+bounces-32050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6809792216
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF971C20944
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB02CA67;
	Tue,  5 Sep 2023 11:21:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DEA6AAB
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:21:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0CE1AE
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 04:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693912871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnmxN6wdOs0OTw/mMrxBK5I43rixoIsLKQZXA7I2EWc=;
	b=AGkfNfF9tGQBXfZKlGgmRO1ngbMvAFKRqqJwBmrSwayEzT9FStFhERYdqaI22QUy7m9iZ4
	KBBhgd/uydQWPLyQrRAZgUoY63SebtxlHVg9K7vO0IiWdIm8/Per5MkFr/Icpju7uUBjAW
	xQ1mTWoK8+nQ0zmplfXAkRvMyDv4SDs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-SoJs4REAOCGR2Wfe7DjLWw-1; Tue, 05 Sep 2023 07:21:09 -0400
X-MC-Unique: SoJs4REAOCGR2Wfe7DjLWw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a1aaaf6460so49795166b.1
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 04:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693912868; x=1694517668;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnmxN6wdOs0OTw/mMrxBK5I43rixoIsLKQZXA7I2EWc=;
        b=R8jnrAKXPVJB5Uj+w3mbmjFnSNQOUijwlhs4fGub1IXB/yHcMkqFOlKN3eigNmsbAv
         Ba3kcHdNpHbyLn5s6VsyFYpjPD+qkNlAcs2p/QXPGcmbQW4Z2HmcNf3ZWpNNcgnHGnZf
         czOdOqCUxJmUiwDm63XPCojB2nGeRhxE0w5hpYKhx8wV6ua5021P6/TajB0VCpfXG9sz
         iONA3bydbtc5FNSayXBg2ZZ1L8bEXd2jc5kq9MIb/mEYLvVUOMhRFIRWk9qEJnyc3Tml
         5lLX+CCZdVVEOSUrDMyCKnu00lHWg2QS1+/qvhyQW053+EgGgP+ZGLhSKATCRZoL2S9f
         HLdw==
X-Gm-Message-State: AOJu0YyD+XDiLJCmIKQGEmAg3prxYB0q7U/Wp8c94wxR5I1UP0eNZm8v
	DjinVdNxB9/mRtTsXfYP6jpnPT7t+BmaNFWy59B0JS920Xr1qdphIrr+NeuA9coeHxBmksCjKwJ
	z0jxJPaom2V+8or4u
X-Received: by 2002:a17:906:212:b0:9a1:d79a:4190 with SMTP id 18-20020a170906021200b009a1d79a4190mr9465383ejd.2.1693912868253;
        Tue, 05 Sep 2023 04:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/2JNpRm3ICUmbaI95oTYHDX/wRK2j5nb1uLhZMDTcx0zla0a42LuJEDAP+RUjDfkLj0lIyQ==
X-Received: by 2002:a17:906:212:b0:9a1:d79a:4190 with SMTP id 18-20020a170906021200b009a1d79a4190mr9465373ejd.2.1693912867909;
        Tue, 05 Sep 2023 04:21:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id a1-20020a170906684100b009920e9a3a73sm7453309ejs.115.2023.09.05.04.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 04:21:07 -0700 (PDT)
Message-ID: <223569649ad4ded66786fcc424156b2115b8ccd8.camel@redhat.com>
Subject: Re: [PATCH net] r8152: avoid the driver drops a lot of packets
From: Paolo Abeni <pabeni@redhat.com>
To: Hayes Wang <hayeswang@realtek.com>, "kuba@kernel.org" <kuba@kernel.org>,
  "davem@davemloft.net" <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, nic_swsd
	 <nic_swsd@realtek.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	 <linux-usb@vger.kernel.org>
Date: Tue, 05 Sep 2023 13:21:06 +0200
In-Reply-To: <48d03f3134bf49c0b04b34464cd7487b@realtek.com>
References: <20230904121706.7132-420-nic_swsd@realtek.com>
	 <32c71d3245127b4aa02b8abd75edcb8f5767e966.camel@redhat.com>
	 <48d03f3134bf49c0b04b34464cd7487b@realtek.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-09-05 at 10:37 +0000, Hayes Wang wrote:
> Paolo Abeni <pabeni@redhat.com>
> > Sent: Tuesday, September 5, 2023 6:11 PM
> [...]
> > > -                     /* limit the skb numbers for rx_queue */
> > > -                     if (unlikely(skb_queue_len(&tp->rx_queue) >=3D
> > 1000))
> > > -                             break;
> > > -
> >=20
> > Dropping this check looks dangerous to me. What if pause frames are
> > disabled on the other end or dropped? It looks like this would cause
> > unlimited memory consumption?!?
>=20
> When the driver stops submitting rx, the driver wouldn't get any packet
> from the device after the previous urbs which have been submitted return.
> That is, skb_queue_len(&tp->rx_queue) wouldn't increase any more until
> the driver starts submitting rx again.
>=20
> Now, the driver stops submitting rx when the skb_queue_len more than 256,
> so the check becomes redundant. The skb_queue_len has been limited less
> than 1000.

I'm sorry, I have a very superficial knowledge of the USB layer, but it
looks like that when such condition is reached, in the worst condition
there could be up to urbs in flight. AFAICS each of them carries a 16K
buffer, can be up to 10 standard-mtu packets - or much more small ones.

Setting an upper limits to the rx_queue still looks like a reasonable
safeguard.

> Besides, if the flow control is disabled, the packets may be dropped by
> the hardware when the FIFO of the device is full, after the driver stops
> submitting rx.

If the incoming rate exceeds the H/W processing capacity, packets are
dropped: that is expected and unavoidable.

Possibly exposing the root cause for such drops to user space via
appropriate stats would be useful.

Cheers,

Paolo


