Return-Path: <netdev+bounces-83118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292E9890E97
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 00:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C75298879
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 23:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975FE80BE0;
	Thu, 28 Mar 2024 23:39:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FE4F881
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669142; cv=none; b=NFS+BxGHnPoC0y2tGUZcr5JbsIBdKDp5eQGu4bKikIvW9/aUTJKACwnCN9xixlBfM6/qok3+SzClV+vth+8xnzdkiVeVeXH1g9Da0i6IHR9105jlDloSQ5ZIJo0m6obMx6wqth/YXUEvTzeF2XPfhvIGgEvhmJAE76BHbdZ2ojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669142; c=relaxed/simple;
	bh=wIBk8zTBEE7uSRk1ranGS4zTe6D/JaOHoJikEodZsbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0DnS1wD9uP/RsdA3z1HTIN8BYajUgO0BSzmep3OoXmo4ltHMtucPeRnDLLtX1FlbJBRkgaR3wEVhL5i3V5xX7yPH/JvAQQgvgGB6dDsCINqZyie/W5PU/PkIR2Vjsj1b+QWfMuuoqQYSZKNfNWyrLQ1RNcCA6bmvFhiYO1PILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c147205b9so2667542a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 16:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711669139; x=1712273939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfcfQlcJEvHTtJDm6FczhwUjiRdabmrf95f7H7kz0gc=;
        b=OlLJPhct5jW/uzVkva20GaXa4f1Nt7a6Dusiug+SVCBy8rdUN6jcjbuGBqpa+yqObc
         2PaQvKV2B/U9TsvIBmRwXTC+LbwYLi/zd4N8gh7+YmBLFePMR+lrG2ojQd+M0+O174v8
         yUug6LttCseM3eGjiQa3pjBDbbcXmU56OlE38meUyzf8WBHdfo2UN/uf5GzeXenUnz4D
         V1ZXjmDOIOMcMk3sFajPGMsRhsie8hfoBFHZIvzi6XY+zJ5eFTfPOo0JNEnMUnmKl10c
         gm8ngy6Fh+CZWPU8nbH0cQs3f6Gj/6HNy/dRQCET9Y1uLtTUTOcBC6g5zByIMtD7cboO
         Uy8Q==
X-Gm-Message-State: AOJu0YxD7AN96XoaL17z71RsgRsPUFur98QmRVowG8x3Tphbnir43ISd
	ALZqMfmosLX0M8sIgufMSqbVsuNNVc5FWGNf9rZZ3VfnteGprzOG
X-Google-Smtp-Source: AGHT+IEg1VbuRjZJJsJBNOePXvaKKHZV9FJYjXGWvzy9Dyeb/Nta2yNEjF0Wbf/icFV9Id/ipGVXSg==
X-Received: by 2002:a50:ccd1:0:b0:56b:d1c6:66a5 with SMTP id b17-20020a50ccd1000000b0056bd1c666a5mr3283882edj.6.1711669138858;
        Thu, 28 Mar 2024 16:38:58 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id fd6-20020a056402388600b0056c53ea5affsm1125071edb.77.2024.03.28.16.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:38:58 -0700 (PDT)
Date: Thu, 28 Mar 2024 16:38:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/3] doc: netlink: Add hyperlinks to
 generated Netlink docs
Message-ID: <ZgX/kJTKQP7GaR/b@gmail.com>
References: <20240326201311.13089-1-donald.hunter@gmail.com>
 <20240326201311.13089-3-donald.hunter@gmail.com>
 <ZgWF/fIGXo/C1LSh@gmail.com>
 <CAD4GDZz+-3=fBqEkMJqORxF=1wwX84aXm3JW=K0tLG2vNF+Vdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD4GDZz+-3=fBqEkMJqORxF=1wwX84aXm3JW=K0tLG2vNF+Vdg@mail.gmail.com>

On Thu, Mar 28, 2024 at 03:54:09PM +0000, Donald Hunter wrote:

> > > -def rst_section(title: str) -> str:
> > > +def rst_section(prefix: str, title: str) -> str:
> > >      """Add a section to the document"""
> > > -    return f"\n{title}\n" + "=" * len(title)
> > > +    return f".. _{family}-{prefix}-{title}:\n\n{title}\n" + "=" * len(title)
> >
> > Where is 'family' variable set? Is this a global variable somewhere?
> 
> Yes, here in parse_yaml(). I realise it's a bit of a hack but would
> like to clean this up as part of switching to using ynl/lib/nlspec.py
> for reading the specs, in a separate patchset.

Thanks. Is it worth adding a hack that would be removed later, other
than going straight to the final solution?

> -    title = f"Family ``{obj['name']}`` netlink specification"
> +    # Save the family for use in ref labels
> +    global family

Is it hard to pass this variable by without having to use a global
variable?

