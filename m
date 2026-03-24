Return-Path: <netdev+bounces-271183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDWMHWfBwmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:52:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05E83196CE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 859863033511
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCF33AD506;
	Tue, 24 Mar 2026 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hlx1xwb5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678ED3D2FFD
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370970; cv=pass; b=MQ2wUH+mERQAqlht8TWTdQ2FjxKEoNvXgGUxtvdmWouRj/w3oopjlrjFNbwQLLTpDrKeRivz+/nCh8dfv2TtcAZAt5F7f3/DyjA92pcXzQFKhHo6WE9N4LCpEJ6dVOApKTeg1CMqQYQF8g6Q0Eq0bxztlwHDV7Wa7asP87KbErA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370970; c=relaxed/simple;
	bh=sTQqW7MB7tkWpsSAWmPEqS9yUjxACRtD5O5ZonpvFhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HxMtVMvArJHg0b/tnY5TvXh+OdO8vT3/u0pSlH6tiiKITdBKPlw/JgAz4kzm1nq2YmOMw9Xy6wQwPKdWPjawtRpXZTjPE/hVO2E5fOHaY31PD9tmHuQxHd5lydHO/q/R6bYDQkfWbw9uU/1uf/YlNrcDS0s1K40XrpXr6jc0zZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hlx1xwb5; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b983ca059a1so176229266b.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370968; cv=none;
        d=google.com; s=arc-20240605;
        b=UOX6lTjLB1reVNg9jr5wWmRzWNMDletvMAczSAH9aesEmGGQHp8LGvY+wUOJq8+75+
         knbpkU9bTxojkt44XqBSreGng/aN/SsStLT0BcL0i54iATXjF8kLkcLibFdCqqEYAdFf
         0ZweAibrwf50Jeqqq4L0sQZbnMGVeH5iBGo5AozBo5XPaWBopfeneeUD1ui99pV9MaqN
         4ngu3tiDw8Z8vau7pNlo4eVqfvypet9xfo25GtEqyQZz6YpeyyYUAPUqzYHTmoEAZgKo
         H10sleU6srnw+fjc+FZgups7imZb+2RjQ7idXFznP6HD2+lffQDBGzIvSiL6BWLcel0q
         OYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=LUyPHYFnDMu8hAARucm+50EyHryzQIeZaT9fhosOQIc=;
        fh=oyMgT9uL4DaSydASd5OFzpQqjDZ3yzFs2ZKTMGkPTXM=;
        b=kUR9SknsFyd5Ph43pvucBvAJ4MTrH87Jji9qm+u17PPcWDLHJYi92jPfgEbMCMTS99
         8xPwm2jDwix0rSTr/DraZz4K82dDJklBU0LM7zNDt7fYw9561eYo2IYs9hRMrWJSItg1
         uoOP8+gJkeZTKndi6rxUcqjNFLn3EU9ljYXWI5sdaQez1CZAkQdkvpW08kiJ6bJc3kzc
         CddEMb3/Rb2EzlfEPZ1SPgE8qH8aKLlbpX/DaulUj9sipWVcXpIJEdgxyWDX9euQEAhd
         i6Wne8jLZVJtPodJQjETzkEtJGTLpEWuBb2vrXQ12FfVPUOncOAZKD2ISYa4842ev2ac
         4Ihw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774370968; x=1774975768; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUyPHYFnDMu8hAARucm+50EyHryzQIeZaT9fhosOQIc=;
        b=Hlx1xwb5jW9MbnR2HiOrVd41zDtrvMi+iqfqLsnK2Gk2tNpQWKsz4sVNUCygN9LMJM
         hn1e3mGdsTVWvY8fsSZF6pSAqwnJE2qjBfLNOJt53R3jdjtAA66jW+UCm7rzajE4yR2A
         S2MgKFeF2JALhVazO3q448nytvs0Okl3GSrPKTd613or/nUkpNzQ5YXM6Fdl7+O47fKg
         S+ZRlNveULoxLuN3e0xoB8Zi+jPBmMAQB+fVXaZqhfw8iQpdB+JtHrSfTMbZLDf/xw0t
         +Cp+0HNjBlzT9l626R+xT3zQ9FEjOSQRrjiEYSx2Gg3gRG0kPEVuL9oWncl3qN8qeWNG
         vulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370968; x=1774975768;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUyPHYFnDMu8hAARucm+50EyHryzQIeZaT9fhosOQIc=;
        b=DU8W9XQjU+7W2KH9vDB3IZ6qf22kGmg0060fEeXUg01FBp4YQtazIZP5GliKF5Zj4M
         fuvhcGcRq9G6O6LuuqWbrQCpcegN0pZaaiPEuT9hQ2vSTUs+MQLwcYpjdha2AvrbwUqW
         OjBfHeWZRcx6tqs44JXhfP0B9KsUn6rYRHZmLJgyivDb0vz52Eo3vnA4N1/0/jrma961
         27gPgp5Qmq8NwROO6DlYoVfrzqdzkKngaiph+qoywYei2ACPHwQPLfMxMSN8ZUL/Fodk
         iqT5uvifxbV03R2RzyzOsGq4/B5GkgN+Q5OTOTgbRtMhVuSedhBSa17QzCZQVJOUVZEr
         daeA==
X-Forwarded-Encrypted: i=1; AJvYcCVPkn9ho3ZWCl16GlO4P+ZNEtSC9RA9sXOfWc/b5myH/DaJIosST749LTY9IFzVPliWRxnFJC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Eu5yweCErJkJBJ4dOUYWHyM/68pkV2yZAet/aw9CyBTvNXjU
	c3Akw+faZGBtceiYO0PE2ATIFBW3WgYbQn/yiHrQinIlfVz5Gdyn8xWZqV8v8409oceMkh74g0C
	8YiRwkhIUWKTWjzi7f30WcR6BnQ1uqak=
X-Gm-Gg: ATEYQzwOaLGAoBjF6omd1rPjSXUJmr7OqPjBi/Ke+1AMA9Fn3PA+pxwkpEGAvUj3DC7
	bNm/TMDviRXp6JVV3eoyqAm9n5YUZyNIKix9ddAYo9Be1QtkLPObo4Myl7yLyS0ZYrXdXEQUDFX
	2cRL5ff7BpcnUKcpNILb6nlpGrFCwOHb3kFQ0PccLW5g3CaFMAY/nN7lpm/btqQHSI9CPthWFmO
	yqVr9c2WIVUqcQaKrpz38bc5BcnCEIuJxyJTTwTy7LYBuMEgTeIS3sUWtlA7g4M0SymMNeOysy6
	Rkk=
X-Received: by 2002:a17:907:8694:b0:b98:11cb:5fa9 with SMTP id
 a640c23a62f3a-b9a3f1ac473mr9080366b.22.1774370967348; Tue, 24 Mar 2026
 09:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320132356.63194-1-teknoraver@meta.com> <20260320132356.63194-2-teknoraver@meta.com>
 <1d708196-7b89-431f-bb17-177564196894@gmail.com> <CAFnufp0LRVxwh50cLrg=hUe6itshTqrNy53HkvBWk6MQ7uL0KA@mail.gmail.com>
 <acK+z8Udlg1qyDeu@devvm20253.cco0.facebook.com>
In-Reply-To: <acK+z8Udlg1qyDeu@devvm20253.cco0.facebook.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Tue, 24 Mar 2026 17:48:51 +0100
X-Gm-Features: AQROBzA2_iW4WgzLGFh7V8V5wrdvQTwU5-3V6Nc152QQriQY_B9N3jAu42FUgtE
Message-ID: <CAFnufp0_xfO7XquPpWjHs3rJnPw=ygQgriGJXkss2nrrXq-UQw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] e1000e: add basic XDP support
To: Joe Damato <joe@dama.to>, Matteo Croce <technoboy85@gmail.com>, 
	Mohsin Bashir <mohsin.bashr@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271183-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[dama.to,gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[technoboy85@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dama.to:email]
X-Rspamd-Queue-Id: D05E83196CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il giorno mar 24 mar 2026 alle ore 17:41 Joe Damato <joe@dama.to> ha scritto:
>
> On Sun, Mar 22, 2026 at 03:11:56AM +0100, Matteo Croce wrote:
> > Il giorno ven 20 mar 2026 alle ore 22:23 Mohsin Bashir
> > <mohsin.bashr@gmail.com> ha scritto:
>
> [...]
>
> > I addressed all the comments and I'll send a v4 soon, thanks!
>
> I was paging through the code last night and I was wondering: have you
> considered splitting this patch into multiple smaller patches?
>
> It would probably make it easier for reviewers to read and comment on.
>
> Just my 2 cents since you are sending a v4.

I thought that all features included in NETDEV_XDP_ACT_BASIC must be
submitted in a single commit.

-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

