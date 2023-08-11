Return-Path: <netdev+bounces-26688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2F5778965
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025A2282088
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D5B566E;
	Fri, 11 Aug 2023 09:03:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABBF53A2
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:03:11 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12D1E0;
	Fri, 11 Aug 2023 02:03:10 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 07AC940E01A1;
	Fri, 11 Aug 2023 09:03:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y0YTwtLQLwFk; Fri, 11 Aug 2023 09:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1691744583; bh=Ve2Mil1sQIlcXhq3onKYup86b/L1zEeiBtw/IzTnjBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ku6mjL6+gY62olI7K3MIwkez291jkHMvrCu/wNndMg3ILZXYoazw54WiiPwTsGOzH
	 /J068E9Wq5sYl1tl5K4O8wM03T8SSTqqMvE5aiyzVUFgHYjEodPddOSEHEMofxCOYr
	 nb6Cwr00bFCsY2jnXHA5vQ0A/pRMhzavo6PQQKvlRC3Ayb6ClInAVl0FQFBTcHCwWX
	 YPrTDZpQggv/dN4hw3GkrWdk6PzUdHe8EjLurpnfrGIraGpT9o5BAn6btOWJi+EEW+
	 IXm2ZRjTNaNSNH9N/p3v9tzFBSWHxUQkLezpefcv9Dd6kf8WOcVFifdC0/o+mhIAni
	 mGZRIzEPMrP3ZD7vDKWoHcecPWuP/9bGyZDD+5arKz8DwkSujlB2ann4qIYXamAiaH
	 bpWInU1e0Kmh3wJJcKJTU5sipg+Dq6pz89oqKUbT0jMq2jIsZvh4gG6iukaycVqDOT
	 8CLOQVKwBkF2GtIZQVGU7kK2gPnRW8WDbIEhuanotC6P//B0oSzNOKhICTLKbif99m
	 ZorhwmMgSXHvXq9NGBXpdj/Kr4qI11+03WfAQUziPl/9GOtl3r/Svn4d+yuJDnsmSW
	 5uVX5LrsNy5h7nEwQ4pJWt04D8/YOOvUccyorU5dnKACIPCGn7oQIqe12J0K/p7oQU
	 DJnWGBaMM2QjramTN5UWxltg=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E721B40E01A0;
	Fri, 11 Aug 2023 09:02:50 +0000 (UTC)
Date: Fri, 11 Aug 2023 11:02:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Daniel Kolesa <daniel@octaforge.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Sven Volkinsfeld <thyrc@gmx.net>,
	Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [tip: x86/bugs] x86/srso: Fix build breakage with the LLVM linker
Message-ID: <20230811090245.GBZNX5NfEwyVkQLH3O@fat_crate.local>
References: <20230809-gds-v1-1-eaac90b0cbcc@google.com>
 <169165870802.27769.15353947574704602257.tip-bot2@tip-bot2>
 <20230810162524.7c426664@kernel.org>
 <20230810172858.12291fe6@kernel.org>
 <CAHk-=wj_b+FGTnevQSBAtCWuhCk=0oQ_THvthBW2hzqpOTLFmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_b+FGTnevQSBAtCWuhCk=0oQ_THvthBW2hzqpOTLFmg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 05:37:46PM -0700, Linus Torvalds wrote:
> If this is holding stuff up, you have a pretty good excuse. It
> shouldn't be the normal workflow, but hey, it's not a normal problem.
> 
> As I mentioned elsewhere, I hate the embargoed stuff, and every single
> time it happens I expect fallout from the fact that we couldn't use
> the usual bots for build and boot testing.

Yah, and this time ain't no different.

I was thinking of sending it to you now but Jakub pulled already. So
I'll send it to you on Sunday.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

