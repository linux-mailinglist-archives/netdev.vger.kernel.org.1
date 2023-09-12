Return-Path: <netdev+bounces-33002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C679C2D9
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD3C28161E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237A85C9D;
	Tue, 12 Sep 2023 02:30:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A2BA43
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:30:18 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9730E7
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 19:30:18 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a8614fe8c4so3905767b6e.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694485817; x=1695090617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SO0neI9SNWHjsicJDOlz3jmxUmyOmDmP+Ez8+rWcNe0=;
        b=oT0kU22BP74ShdxPTtY8hFAmMxPaLEb1UwdeXdbpRb8kwHytCYoCJsIfqInfk7Rylj
         oDmOeFqwRV4jdmDNha7kFbEb2mkKowcuRy+eJvECA67JgKqhiFfsDPfdGkN4ZaF4LhMn
         xjn0Jzpb5r2fC6j2Dr3Az00QI8vEgsLFSRfdgazfYiV2ktL7tlFiyyqW7IoNdwsH+9Fw
         ryaO5OPS0eKtD2MJMSTOhgodf3NJWCWlDUbe0yNQ9A0Yo3b9jcQPubf5GSqQswK5/n16
         g59xAWFBpoQo4+O32wQ+GeYAPw+Q4L3yJ2zdVBIpORrjowsG+/CXgse8S9PT5I5y6DH5
         hOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694485817; x=1695090617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO0neI9SNWHjsicJDOlz3jmxUmyOmDmP+Ez8+rWcNe0=;
        b=JOENVp1+bI8ng/nvecs3VjgSzmQvQZXCZ/DXYWAmrU0yYEN6TzrzUif3H/irtFeUas
         9beMAexxB6H9jf9zzgK1mpUipeq450L36fk1qbxWmXbkwVB2Z9DeoNDliyB5NMXwwFVf
         PDBcNWoAdcOm6j/1z0a/PlOEZ3x6wO4iCkrGhn9hMRhmcJsyPZjDZgygRCJDFhtblnBp
         b4eHAZ5SyQ/gY6MfoKZW0k09h6WbgQq1HTO6ncwJVZfDS0QSbKRoVmX8AuAeAN83pk14
         kzCzSfBR/tRXFD1cIwzut7XFJjor0viJXrZP6r4tK4JW3tEcjIoqrCHmTnGqau56qRMc
         9vlw==
X-Gm-Message-State: AOJu0YwhlHeF7mH70/Op13RrvAHqz7zTU9/8BYcl4/w3bSYXPwI9UALP
	CYG47fIqzxXip+WbgsG8Zzw=
X-Google-Smtp-Source: AGHT+IHtQ6LOZHCKlMNRsyS84m56pLFYLsAY7lVikwpopUIJIJBZFdmGn8Ddm0DnOdVKRrbq67rYEw==
X-Received: by 2002:a05:6870:a447:b0:1b0:3637:2bbe with SMTP id n7-20020a056870a44700b001b036372bbemr13683791oal.54.1694485817332;
        Mon, 11 Sep 2023 19:30:17 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b75-20020a63344e000000b005776446f7cbsm3114966pga.66.2023.09.11.19.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 19:30:16 -0700 (PDT)
Date: Tue, 12 Sep 2023 10:30:11 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Thomas Haller <thaller@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCHv2 net-next 2/2] ipv4/fib: send notify when delete source
 address routes
Message-ID: <ZP/NM14oQXAkr107@Laptop-X1>
References: <20230809140234.3879929-1-liuhangbin@gmail.com>
 <20230809140234.3879929-3-liuhangbin@gmail.com>
 <ZNT9bPpuCLVY7nnP@shredder>
 <ZNt1wOCjqj/k/zAW@Laptop-X1>
 <ZOw7VIMulJLyU0QL@Laptop-X1>
 <8e539e610a7cb4d1cf31fa5e741eb111a3d2ca5b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e539e610a7cb4d1cf31fa5e741eb111a3d2ca5b.camel@redhat.com>

Hi Ido,

Do you think if I should modify the patch description and re-post it?

Thanks
Hangbin
On Mon, Sep 11, 2023 at 11:35:05AM +0200, Thomas Haller wrote:
> On Mon, 2023-08-28 at 14:14 +0800, Hangbin Liu wrote:
> > > > 
> > > > In the other thread Thomas mentioned that NM already requests a
> > > > route
> > > > dump following address deletion [1]. If so, can Thomas or you
> > > > please
> > > > explain how this patch is going to help NM? Is the intention to
> > > > optimize
> > > > things and avoid the dump request (which can only work on new
> > > > kernels)?
> > > > 
> > > > [1]
> > > > https://lore.kernel.org/netdev/07fcfd504148b3c721fda716ad0a549662708407.camel@redhat.com/
> > > 
> > > In my understanding, After deleting an address, deal with the
> > > delete notify is
> > > more efficient to maintain the route cache than dump all the
> > > routes.
> 
> 
> Hi,
> 
> 
> NetworkManager does so out of necessity, as there is no notification.
> Overall, it seems a pretty bad thing to do, because it's expensive if
> you have many routes/addresses.
> 
> Unfortunately, it's hard to ever drop a workaround, because we never
> know when the workaround can be dropped.
> 
> Also, it's simply a notification missing, and not tied to
> NetworkManager or to maintaining a cache. If you run `ip route
> monitor`, you also don't see the notification that kernel drops a
> route? The effort that NetworkManager takes to maintain correct
> information is not something that most programs would do.
> 
> 
> Thomas
> 

