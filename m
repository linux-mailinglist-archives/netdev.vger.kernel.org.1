Return-Path: <netdev+bounces-269003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0e0oE4ubummHZgIAu9opvQ
	(envelope-from <netdev+bounces-269003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:33:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C03DD2BB874
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE3B31B270E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361823D5238;
	Wed, 18 Mar 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLgsf9gT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02533AE707
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836855; cv=pass; b=fph9ucDLk80LOUe1OQI4ASLOlzOg++nAlUG+ccGkpMjWHr7fYMW0pPBMwPLmn1xiABWI7iQ0+RTHPNuMSO+xOZXu8nm2yelC5oRCXZFIHzPKf3D8LlRQZz6XhWFMyHh90kI/LmwM3Dd8/Sp//oCIwhyodnlR2GzDGIB7dPLqXGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836855; c=relaxed/simple;
	bh=57DBatuAN96wEw1hs2NPGmR/MF6/IhbrTXX5NsTXVwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAGSfrqqrp3y21TNhx7zXysFunygfVTwj+ilQW0RfftjFzOSjwry8aoJzOejNAI3TbCME75Oqt2on3KmyR/5PmnofirycKvrIfV4KKpiBUaS0lpE0PVkMhG8oqJl6QnoxIQMvOCLFavwNFHHhp68bWN5PKggjxxM06YX00bQNP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLgsf9gT; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d7b685faeeso1443486a34.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 05:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773836853; cv=none;
        d=google.com; s=arc-20240605;
        b=HQHb2Lhxv0DDZbnPz8RUhfwjLBN99uNSbUiAH5Vo0wcGdgzQc2I9Gf/t8AnnA6XInL
         eVf/DeYKMjlKwkbM2lTNfk5sB5MifUA8y4zcMryXG/DiimO25dJBlgDu3AgAun+Gv9R0
         kMTYzB5I9XxpVA243Njf7RXOdqDUIjFM4mZAi/0WqqCdGbq6R3NuifG8/LpJ8GAbf3jv
         nJlnwxZcgska4VBg+Fm03956DvNu61KZ43Bf6oKnnWOnfBZPk2Ae+ONviPBTjxkx/7Sq
         OUwsbVL22IrHzN/TD0126tWEGaIHEnea0lskMUIqh05CTRN1F+veXZuEK+X9mWnC0Xq0
         9Z+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=57DBatuAN96wEw1hs2NPGmR/MF6/IhbrTXX5NsTXVwQ=;
        fh=tkM+0yxzm86pmC11XRpvWe7zG6CO38CKIGyRTRjv65Y=;
        b=IEh9M6ShZ/ABAqzkpsDwXPTrSVDNCKp8wuM0dWKfRIo/VHmt54r1xeuBNAm8ohDxWv
         HpUD+DuBRGOGekCPQAVhtHwq5ajJ6DHOuwbiAc0VEwsW4iXm40uBp5z1eSQNSHb2m9/s
         yyUPsbyJLrsZiKJNh1z1ao5q3ceNtEeOoUUdknWyCRuKR3pVC3+8Dzq8A7kxhiiorkDR
         ZE+5P+YBQFPn9XzUbQx4OogAkuXA8YILzZggDWUmTFXqhrgmbYiLn1xjpBi15U3kNT9e
         wL0d0CmdqNkOGs2dZwSNSe3tk7QRm6SU2AxFRwNarD1onbtZ/LqYzKojY1teM0JEpB68
         RujQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773836853; x=1774441653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=57DBatuAN96wEw1hs2NPGmR/MF6/IhbrTXX5NsTXVwQ=;
        b=VLgsf9gTPIazixgSHn+tH1bt/smKQvDbvn2KQGuMClCCX8bP5rht0pcPmqkZm/UoBz
         uA/nyqu0G23bFF8foVCTA8puYumRZvIZVViWTLv9ClyG0VE/SF81rxMX4nTn5HWCWjVM
         rYShf3VYLQKjRxK27WnTRtgNRlf17H54elG24LyA4r9PhL3WVtEb3Tw50FLsOy5buOFA
         zWfYZ/QGG6Lwya7oD/ycxv9zW1X6Ar5h0eEuqv9cBTIG/bnIByHMpt7uMG7zDE57Wnqp
         safG8c31RrM82MJFMIqM454aEHe9qdYZUAF8IGHfMuJQbiPYuCYPPNm6pg67sOcTxPrd
         1qyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773836853; x=1774441653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57DBatuAN96wEw1hs2NPGmR/MF6/IhbrTXX5NsTXVwQ=;
        b=bDKYqcgVdG07jLIfRLBkq3lHqMFDZY198jfk/5xd1kZeSuoG54TzIw+sBGq3ua/baw
         dAinw4/U6NWlHIG7woUsimXdOKaAcCSgKgCECaSb2LaYzemRKqtpWEGty/9h+H5DB4sn
         IYsulaTJqg9iE6loZdgxYV59eq/k52eJLK7yOW843pGDy7mranzmhUH91oEJ+pLvAfW5
         PlM1np86yZUmPIG8+coRnVJSn1wxEeGtIAhTzth4dea4dJUlg/pmaXEnzX4/5oKzeE9z
         aKsj8tdTdjPpG3zoqlnTwExQzHiy7O267B/npARGeSqDGNtAdxZIEgn2DqHBLunx/4l8
         13HA==
X-Forwarded-Encrypted: i=1; AJvYcCWXhz4ujMHZI+dwtdR/S8dRFoHc+33UKjXMPIBI5dRb8sWTQ9DjhqOrxYSiGt6pgn8htjY0oU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3xXCPyeETEXcbyfPO77ohkvEV3EhCwNWMGmVaPxuFJVZBHV2
	8v+sSaqO8u2p3ZbP5ZHTA2rI4SrUu0VcqkMhkQ8/6wSq8DejQt8ukjjP3RaeK5xMDyxJl0HiGHb
	WBM4rLkeB27R9bCa62D4PRlOny3Oc/m8=
X-Gm-Gg: ATEYQzwJBk/tv9wWR4qSTl8/TxwBuE7tqJn8wxOnjvO3+BwJ0zxwBaDYE1p1RagOQEx
	ejGjXZfjWGFHO01yq+xEFgzcuJedTO7qS3hKsoSoigO2oDvksU4BVaZa1K91F5l8fFS3tVmMwwU
	mhdpskVdVK/Pma2XKWkq/jEAkI/c02mBMVah9exTNj5NQqIz31Fw9NW82Kc79Jj8UBP2zotZK6s
	3FR+Wsr0V1HtyC6xzH4Jfupywb+gGiK3GgwjUcYzn4/esbPfHETc8mna1eLoUhuRvQAMRiD1AC4
	TnE2KA==
X-Received: by 2002:a05:6830:380d:b0:7d7:d4ee:c02d with SMTP id
 46e09a7af769-7d7d4eedb6emr394812a34.21.1773836852833; Wed, 18 Mar 2026
 05:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313232047.2068518-1-kuba@kernel.org> <20260317160948.5a358df0@kernel.org>
In-Reply-To: <20260317160948.5a358df0@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 18 Mar 2026 12:27:21 +0000
X-Gm-Features: AaiRm50bKgI6qFOFT8WN3AQLtiSOOJ_pGC3hgT5P-Ky2jxuc2s378FO250cJxrs
Message-ID: <CAD4GDZw2GXOEGy=wbwDMbncwUr5o7T9W2cxRBO8SGsLsVGhnDQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tools: ynl: rework policy access to support recursion
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269003-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C03DD2BB874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 at 23:09, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 13 Mar 2026 16:20:47 -0700 Jakub Kicinski wrote:
> > Donald points out that the current naive implementation using dicts
> > breaks if policy is recursive (child nest uses policy idx already
> > used by its parent).
> >
> > Lean more into the NlPolicy class. This lets us "render" the policy
> > on demand, when user accesses it. If someone wants to do an infinite
> > walk that's on them :) Show policy info as attributes of the class
> > and use dict format to descend into sub-policies for extra neatness.
>
> Hi Donald, you promised to take a look when officially posted?

Apologies, my response was sat in drafts :-/

