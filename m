Return-Path: <netdev+bounces-39157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E987BE3F4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B451C2094D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FEA358A5;
	Mon,  9 Oct 2023 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="auSPnnma"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0054171C0
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:09:36 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AF3CC
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:09:34 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C9BCD3F231
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1696864172;
	bh=g1ZxryJ9Fp89sg+aPudijHRzb5lOs8xwITYaOZXplaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=auSPnnmaOyn/GcW6R3ZlUpAgvKRn2PdFeyhqLyn5hasjJM86068jhxo9sPkFnLtg/
	 ckRaAfBMHHoPR/J82tPx7zep/LZ6LYKrBSfgYU7THCNHzQFNSW7WDoPB5BtJ3ZN2zg
	 Bgp72FqMa49wVMHauCHT5x2PLls8H1aVF7J+sO+2z9joIhxiLbBuSRWHgbRNUwPGx4
	 GC8QQ8QGxoFPMs2s0Pi9zM69ncJWggzYHRg/x1b/UUCOHa9KmSqbHPKnbKH/8xHuup
	 qa1punVI3TDOchhilS6LxaZ1SQgp0uJYAC3PyxX/Nk/0Byk9fSD0KrhjOuFd116JDB
	 YkXwHaM25gAKA==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-323306960e3so3063312f8f.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 08:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864172; x=1697468972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1ZxryJ9Fp89sg+aPudijHRzb5lOs8xwITYaOZXplaA=;
        b=P8l4xo4esN9h85NPzX0cZSv1jg98Q0QzhkmjbfyAw+LWg47a//mlCBqa3fUkEi8P+3
         wNMaSBSRfxtO5p2x3/P5IseTiLWwT4sir/CHdsqOfNxwotpm7ot0CLcGsk5rjaK120Rw
         vsZoLq7d3QZuTez+dWItWLH8pRwWXukQ3VIrIa7FX93VvVBgHW2pF9i9OGu7u1lZLoFa
         a+EA+8JV1gd5GA/zkP54j6czJ9pcWvlixayBcKQooWu+V4RZRFC/dpw8iDj7+jOqgDQM
         WMpizMay7jQr1Zq+F/0AVZz76GzBTmhNvaZ1iejmv6QU3rEgmMjH1yfSwpmWpEjVvCfd
         7l/g==
X-Gm-Message-State: AOJu0YyXjtW5E6ycbK2xPFDG7Q9srXS9ZfQyv0fGHuu11wLoPaN+6iMN
	llElnngWR4G82NVsjii1xvAKta3ro+u68I+E4bxwvaeilpuktttQDqYUDKIbtPiiCKgrRV62PUW
	LNNpZ8xxIldkf25xur65+kzs0SjsRtiVtHw==
X-Received: by 2002:a5d:4b48:0:b0:319:7a91:7107 with SMTP id w8-20020a5d4b48000000b003197a917107mr12511715wrs.48.1696864172374;
        Mon, 09 Oct 2023 08:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNdhhpK3/6huTJ/MSJwcUs4ijAlXc+xATCdR6O+yF7QfE/IfnubleLZztmPTkh4CJ2Hth6cw==
X-Received: by 2002:a5d:4b48:0:b0:319:7a91:7107 with SMTP id w8-20020a5d4b48000000b003197a917107mr12511679wrs.48.1696864171687;
        Mon, 09 Oct 2023 08:09:31 -0700 (PDT)
Received: from localhost (host-79-19-77-113.retail.telecomitalia.it. [79.19.77.113])
        by smtp.gmail.com with ESMTPSA id d15-20020a056402516f00b0051e1660a34esm6274494ede.51.2023.10.09.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:09:31 -0700 (PDT)
Date: Mon, 9 Oct 2023 17:09:29 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
Message-ID: <ZSQXqX2/lhf5ICZP@gpd>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch>
 <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
 <ZSQMVc19Tq6MyXJT@gpd>
 <2023100901-panic-strobe-5da7@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023100901-panic-strobe-5da7@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 04:56:47PM +0200, Greg KH wrote:
> On Mon, Oct 09, 2023 at 04:21:09PM +0200, Andrea Righi wrote:
> > On Mon, Oct 09, 2023 at 02:53:00PM +0200, Miguel Ojeda wrote:
> > > On Mon, Oct 9, 2023 at 2:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > >
> > > > Any ideas?
> > > 
> > > That is `RETHUNK` and `X86_KERNEL_IBT`.
> > > 
> > > Since this will keep confusing people, I will make it a `depends on !`
> > > as discussed in the past. I hope it is OK for e.g. Andrea.
> > 
> > Disabling RETHUNK or IBT is not acceptable for a general-purpose kernel.
> > If that constraint is introduced we either need to revert that patch
> > in the Ubuntu kernel or disable Rust support.
> 
> Why is rust enabled in the Ubuntu kernel as there is no in-kernel
> support for any real functionality?  Or do you have out-of-tree rust
> drivers added to your kernel already?

Rust in the Ubuntu kernel is just a "technology preview", enabled in the
development release only. The idea is to provide all the toolchain,
dependencies, headers, etc. in the generic distro kernel, so those who
are willing to do experiments with Rust can do that without installing a
custom kernel.

And as soon as new Rust abstractions will be merged upstream we already
have the infrastructure that would allow anybody to use them with all
the components provided by the distro.

So, we really don't have any out-of-tree module/driver that requires
Rust at the moment.

-Andrea

> 
> thanks,
> 
> greg k-h

