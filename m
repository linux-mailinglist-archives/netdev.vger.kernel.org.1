Return-Path: <netdev+bounces-85092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C45689964C
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 09:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA94B231C2
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 07:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4872C19C;
	Fri,  5 Apr 2024 07:12:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318752D04C
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301133; cv=none; b=VILI0S+534T/2oli63QrobVjYAK8+cRSGnur9G+LXOgGFY/hodEqzIiD25IMageOrXdSrGrCyOhWE1S/p+TXHrAEhJ1cEd08uhYSUitrO35CRn3JmxZwkk+DGTtCGkwzioTs1gEc0c6ykjmh222x1hzyrQq55Yqgn8/Bu5WetaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301133; c=relaxed/simple;
	bh=uzh/Mszl2+B3KFQvKUH37svKj+pJExNIQuJAXKf2FPs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=LuSSoDCmm9n7qn5yo8cpryEB08vzNLB8yfSjtIlaMAiqasPWIun0xrGyVP0OlaNJyv6kgSmv32/NTecdqKgWWP4n8zz4D+5MaJkuJ5yIS6+g9Sy4F6inQOkdvvdzG5qaUlobP9Sco4gWQPAyQ+w0ZFAy2BO+OSJAQ4LSh0MpEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inf.elte.hu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inf.elte.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-415446af364so17329315e9.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 00:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301129; x=1712905929;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzh/Mszl2+B3KFQvKUH37svKj+pJExNIQuJAXKf2FPs=;
        b=NfEZxo0vT4LB6EQyAm/mPGfD7sFs0/1X3UWM9HSwMhRqPQvrtWdmlowI/kez86ISEY
         dETlmf+f2RriDVyQvL75iCmSKA55VzQow8wCTi4LUXdNJ9gbO1YIab4IamK1kfCfVTQ2
         LbVcrCd+3XujO9Tuu1rxQd4saAxvyWI4scfP3/OXn4SsSlv6UaEeYQY+YHQ+cApR3SjT
         sB8LAaggzmuBFrwEQj5XTNYbZJw0Ix9s/FeMwjUoDG0KmFAQPwCqFNvhqa51uk27FquQ
         Qkr0mmLXOfhpLJqEY7bCgW+eiht2tYz+Pbhzra7jB9NadkFw9ETGHQOIm2yLtLIHrqpt
         Dyfg==
X-Gm-Message-State: AOJu0Yyr1Fk7M+RgssjvPqvNwNBy5dQ1kYADq77oEflIGOCDTShw2KqF
	XDCOnD/cY1+sPvkozh95ULDUlmRCWbgLnqldaGVpE+eZlPSOFQpJVoT+QhcHfizFkA==
X-Google-Smtp-Source: AGHT+IHhVpNE78D8yPNvyaDzdNhVgbX26ypZaQOkkukk10mBoTAJhk0t3BbwCvVMJA1KnHCCSL3b4A==
X-Received: by 2002:a05:6000:ac2:b0:33e:710a:b699 with SMTP id di2-20020a0560000ac200b0033e710ab699mr661720wrb.9.1712301128920;
        Fri, 05 Apr 2024 00:12:08 -0700 (PDT)
Received: from [10.148.80.106] (business-89-135-192-225.business.broadband.hu. [89.135.192.225])
        by smtp.gmail.com with ESMTPSA id dx18-20020a0560000e1200b00343d840b3f8sm1266977wrb.33.2024.04.05.00.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:12:08 -0700 (PDT)
Message-ID: <6aef04e4ea98227c18328126d0a2fcedfaf362b6.camel@inf.elte.hu>
Subject: [question] SRv6 socket API
From: Ferenc Fejes <fejes@inf.elte.hu>
To: netdev <netdev@vger.kernel.org>
Cc: andrea.mayer@uniroma2.it, sr6-dev@listes.uclouvain.be
Date: Fri, 05 Apr 2024 09:12:07 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

While experimenting with SRv6 and IPv6 sockets, I skimmed the relevant
parts of the kernel and failed to figure out how it was supposed to
work.

Two questions about the SRv6 socket API.

1. No matter what I do, the nexthdr field of ipv6_sr_hdr is completely
ignored and the field is set as if its a sticky option. For example, if
I open my socket as (AF_INET6, SOCK_RAW, IPPROTO_IPV6), nexthdr on the
wire is set to 41 (IPv6). If I open the socket as (..., ...,
IPPROTO_UDP) nexthdr will be UDP. Do I miss something?

2. Is it possible to request the SRv6 header? I see the relevant parts
in the kernel code for legacy routing headers (type2) but not for SRv6
(type4).

My test code is as follows:
socket(AF_INET6, SOCK_RAW, IPPROTO_ROUTING)
setsockopt(fd, IPPROTO_IPV6, IPV6_RECVRTHDR, &on, sizeof(on))
... allocate enough space for cmsg, prepare msghdr, etc...
recvmsg(fd, &msg, 0)

When I send an SRv6 packet with a few segments, recvmsg returns, but
there are no cmsgs.



Are these expected operations or do I need to dig deeper?

Thanks,
Ferenc

