Return-Path: <netdev+bounces-59699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70A081BD2A
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8190528B886
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED62627E2;
	Thu, 21 Dec 2023 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="mxejLntX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04F55E77
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so802359a12.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 09:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703179475; x=1703784275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J+1ta8VTYH6uO9fMkD6onJzwkdcVJrspwHe9g6FGbM=;
        b=mxejLntXtsJsa0pMG9y9iggmiEWA+7dWSQ1LYs2o2jXGWZYHBxBJUbpw5FYyrWY4zr
         Qh4y+TTZINTPu+N5E8n+7O9BkqWiD1WNmKDTBAVEP9OkkgBgT+AIw7lUqbh2wavIDXlM
         lsdCXsQFWEwouiy20pOSVt4BJB7qYTXVC2bR41gPbB5OmYcTKH7p+JS8R1Mclss1LCvG
         gAQaDFfQl7ijYuCx9NkAd8n91hL/I4VaQ1cmN7hLLRdP9s1EeLgF+iwo8YOaVC6XtHfZ
         +t0dWfyFjhPy4qHJBolZtWMPAX21vZcgpo976V4/P9pbvZEocMoZCMDDKCSmVwN0Eg/x
         EIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703179475; x=1703784275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/J+1ta8VTYH6uO9fMkD6onJzwkdcVJrspwHe9g6FGbM=;
        b=Gw6cFXxALiwmKyFm0MvdGa2f8oWAcVn5Dn8juep26w9pZ+Y/AWOkFZRWDVcls1YGKT
         7C/tIw8kvEhIJvfQ8Hl/0A2pDCv0W0AsRAieDwaedF7OF2TYhNgF6JXAcIhp00ZVK0F6
         5ffn2b+8n2ZEc7qRqayLHvq0WF70RIJyweiRnaVrEZVcvWuETNITAgQgUTSqFpRjOlcI
         0b6psba9CmxNEWsidlck2C711IvZYOAfWzaL6Dq5UvrMajQXTpjTqHDHjO7sImdShYmx
         FrqRfH3ndO+0gDluXEoqweuIq/i7TRM2/aoQ56ERNtxC8a5PD6TCcqUx6PzYSf59XrA8
         1nfA==
X-Gm-Message-State: AOJu0Yys5oiTzwvAzdGl9QLio9RUqz/ziQoIshLK0eUBzla5fxtLtuIz
	LjlvTl13RGuzi+nXR0EnVzKWOIWom3OVWQ==
X-Google-Smtp-Source: AGHT+IHySwzC9pOhhcWKBTgwJW1jnVBGrc1D9/9QIOzafUtSp2+AexvR6cWigPMKWEUKS6CklzdPwg==
X-Received: by 2002:a05:6a20:54a8:b0:195:1c85:bd38 with SMTP id i40-20020a056a2054a800b001951c85bd38mr24237pzk.17.1703179474904;
        Thu, 21 Dec 2023 09:24:34 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id 2-20020a630d42000000b005cd64ff9a42sm1805275pgn.64.2023.12.21.09.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:24:34 -0800 (PST)
Date: Thu, 21 Dec 2023 09:24:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 01/20] bridge: vni: Accept 'del' command
Message-ID: <20231221092409.44d0cbae@hermes.local>
In-Reply-To: <ZYRt2VCTVnGxI_1j@d3>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-2-bpoirier@nvidia.com>
	<20231220195708.2f69e265@hermes.local>
	<20231221080624.35b03477@hermes.local>
	<ZYRt2VCTVnGxI_1j@d3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 11:54:49 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> On 2023-12-21 08:06 -0800, Stephen Hemminger wrote:
> > On Wed, 20 Dec 2023 19:57:08 -0800
> > Stephen Hemminger <stephen@networkplumber.org> wrote:
> >   
> > > On Mon, 11 Dec 2023 09:07:13 -0500
> > > Benjamin Poirier <bpoirier@nvidia.com> wrote:
> > >   
> > > > `bridge vni help` shows "bridge vni { add | del } ..." but currently
> > > > `bridge vni del ...` errors out unexpectedly:
> > > > 	# bridge vni del
> > > > 	Command "del" is unknown, try "bridge vni help".
> > > > 
> > > > Recognize 'del' as a synonym of the original 'delete' command.
> > > > 
> > > > Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
> > > > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > > > Tested-by: Petr Machata <petrm@nvidia.com>
> > > > Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>    
> > > 
> > > Please no.
> > > We are blocking uses of matches() and now other commands will want more synonyms
> > > Instead fix the help and doc.  
> > 
> > I changed my mind. This is fine. The commands in iproute2 are inconsistent (no surprise)
> > and plenty of places take del (and not delete??)  
> 
> Indeed. Thank you for the update. In that case, can you take the series
> as-is or should I still reduce the overall patch count and resubmit?

I will take it as is. Ok for me to squash a few patches together?

