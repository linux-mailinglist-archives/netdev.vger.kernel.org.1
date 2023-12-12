Return-Path: <netdev+bounces-56246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E940380E3D7
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 06:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14661C218F4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340F13AF4;
	Tue, 12 Dec 2023 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrRhM4ml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED0EBD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 21:35:35 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d9f879f784so2664012a34.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 21:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702359335; x=1702964135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KlklsxZVKbXvSaG0yP8L4PztU97RmMlihq0bX0XwRM=;
        b=KrRhM4ml3snQ4th6JTrffa8ChN4AvqrXIp8ev7SEFCDhBBYIRPESONmfRrBHC4cIkV
         0nNVSX0jM9Z++8Z71HM++8HBMsyfejsV4ApwroeLBODZYaWaquc+uAzNLbCOdaLlzIPm
         1ukg9Y0vtT+ASltmIdIXrnSqZyk7k6bglV1XYD1MBn4Linf+Q+3UnPdWzfQkdnWgQHea
         9g/IcBZuCsyIF8xZa2gGrJMNHh2P6cQgQtVnWRkWICTpcJj/ZSUDJ3Ykbm+lknRH+b89
         J0NZNuto9sOtwPvoChUyS8mIZLaq5ZIBdoZiEnPQZo4slPjtbs4FBCD3bVJM8wDvFjE5
         YLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702359335; x=1702964135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KlklsxZVKbXvSaG0yP8L4PztU97RmMlihq0bX0XwRM=;
        b=m+5O0u9DnfQHks8oFZf7AmNXWnCv8Bduv2oev0efviUl9KoF7UqZslykJXMXdrbw/q
         SV8cKcrFWfr+9Ijt+iwlIOgqwhKtOzc9KC20Ak3k77E89gTgbsIkeXF1pzjQEK8gxLx/
         V5Qie+I+VQVJT8ccL+h4COBxnU3toWJ8aF0QlBsHF36MakgaLd84nALTw8F6K5P/xpId
         q+iPadjWDyGTh85FpvPn+7hJ58v69rsW5326EUeGKXgGLX56111aLm6/h69yfSD06ttt
         RQVn5PQz+YMhi1Efgc4FqOopH3CPqhJlNH2mZGIY/aI/Qn2PTRGpcphJWz8dK6QiJis6
         UADg==
X-Gm-Message-State: AOJu0YywYfG/VLq9zXa1GBqnTTPJXp5EJgTEyqlxmWcb4Rx2kXfIdyD0
	vWpMm7mmQ685Cr1Cs7gGkxw=
X-Google-Smtp-Source: AGHT+IHOl7CXUqOcuutmMTsYpBEyVy3UNVAHyJ24YJsddR8queP26hFCQHF7PlnDlMaSchD+7ur3QQ==
X-Received: by 2002:a05:6830:61a:b0:6d9:d507:28a6 with SMTP id w26-20020a056830061a00b006d9d50728a6mr6347831oti.12.1702359334951;
        Mon, 11 Dec 2023 21:35:34 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y33-20020a056a00182100b006cc02a6d18asm7280954pfa.61.2023.12.11.21.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 21:35:34 -0800 (PST)
Date: Tue, 12 Dec 2023 13:35:29 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: thinker.li@gmail.com, netdev@vger.kernel.org, martin.lau@linux.dev,
	kernel-team@meta.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, edumazet@google.com,
	kuifeng@meta.com
Subject: Re: [PATCH net-next v2 2/2] selftests: fib_tests: Add tests for
 toggling between w/ and w/o expires.
Message-ID: <ZXfxIe1qzxMQC1jV@Laptop-X1>
References: <20231208194523.312416-1-thinker.li@gmail.com>
 <20231208194523.312416-3-thinker.li@gmail.com>
 <ZXfDd_tzAwDbi66Q@Laptop-X1>
 <83a83ca3-3481-4e2d-a952-37437fca1800@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83a83ca3-3481-4e2d-a952-37437fca1800@gmail.com>

On Mon, Dec 11, 2023 at 06:40:43PM -0800, Kui-Feng Lee wrote:
> > > +	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
> > > +	if [ $N_EXP_SLEEP -ne 100 ]; then
> > > +	    echo "FAIL: expected 100 routes with expires, got $N_EXP_SLEEP"
> > 
> > Hi,
> > 
> > Here the test failed, but ret is not updated.
> > 
> > > +	fi
> > > +	sleep $(($EXPIRE * 2 + 1))
> > > +	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
> > > +	if [ $N_EXP_SLEEP -ne 0 ]; then
> > > +	    echo "FAIL: expected 0 routes with expires," \
> > > +		 "got $N_EXP_SLEEP"
> > > +	    ret=1
> > 
> > Here the ret is updated.

BTW, the current fib6_gc_test() use $ret to store the result. But the latter
check would cover the previous one. e.g.

if [ $N_EXP_SLEEP -ne 0 ]; then
	ret=1
else
	ret=0
fi

do_some_other_tests
if [ $N_EXP_SLEEP -ne 0 ]; then
	ret=1
else
	ret=0
fi

If the previous one failed, but later one pass, the ret would be re-write to 0.
So I think we can use log_test for each checking.

Thanks
Hangbin

