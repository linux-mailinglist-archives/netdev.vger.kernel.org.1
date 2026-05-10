Return-Path: <netdev+bounces-286284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBdgI/hzAGqaJAEAu9opvQ
	(envelope-from <netdev+bounces-286284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 14:03:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BBA503D70
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 14:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 237853002B36
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 12:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D50379ECD;
	Sun, 10 May 2026 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO0pJrO8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2500834AB14
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778414581; cv=pass; b=Dh1KBTVaUVZ13i4hUWxG+ZB3OPWnkQoDTtq9q/+uCgO1m1co93FvEgg0RHboyBteM/dDubH6BTif3EVflzWuYHgreb+JjeRnQROl7pUnpE3PKojV4rMFnO9gVMRX/vWIPthHi3K55nzRVBKl1Clwm43MHNEYQ1UYOV3rIvRQ/7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778414581; c=relaxed/simple;
	bh=bH+A1pcJNHbsEm31+G4EJAAN3LgMlSAJINOZTIByCpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6hB01BFQWpOurtcTts+PIn1qcCIaYNAA4O3qvGaz8YykNzlC0i0VSgq/eMCjb5lUQ9L+AgmBMGLKS0vCSpzHcY08goJfavajXzG6xI0vp0MGd+LNSH/8VdaxUEMgHrOY7lTQdVE4vLPCw6ng123WUIpzqXCEVsXY2ZHtbxKOGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO0pJrO8; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bc64ad08bf9so520829366b.0
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 05:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778414578; cv=none;
        d=google.com; s=arc-20240605;
        b=k01ThDybHOoyoR4V6SvGBXlSBM9YGa+2Ec2ZoFMNi4/6siQhcFDTfKNWuYqGDwSN2r
         lW4ebrmHz8jof7ITxz+f/0kTa6MbTYZZXYy9SYohhSmm/V21/QaG4etWTTsWIUYVaJJE
         sdjjGarTsKtvB9VRCa8WrVwlUJHfzR8PVTWT0EodFUePdqQYLfqB/bmirzpmDWo1hmk5
         mMY2CYSRhyxblu31oliiUVJk8Z8+k8UbIwL1rvVOHyEUWAAKnPCcyyFFQcHiTlBVcNoD
         PjDIqM55Re5EDVXK/3qP/aliAUwiNFbM2byPOtfPI6KW9rdj0ZzbBGHHQ0BEwigS/VA7
         q/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Vmli1MjJU1iPg6tCzc8RsiqsXAYEqteoIsuCG5nm0hc=;
        fh=iQMn4PA81ffs8RQyjb2y18viXB/cDoh/yOLGCaerMdc=;
        b=KAyhKP9xjOHPf3yUXPogY04cbcrAEp9POtzTK//96K8fN+MSpCGtS3ArQr10qPBFOi
         LoRdq3fXdsXwOVeSveA+3J1ddu+ncFHCOrpQCffExGMJM+EaX49Wl4zgNHfXV0iLLTfC
         QSgscz2EPVyyWKqWjreV0/CejHZ9t2NYuJkRrU7J9gHZsYMdKszz1lFuA2/ZItmip9jx
         W5S62g7yU71/GLTGjRJSx8Ccf5v3KdpYVdRHCGMWShi9C9u/LHdnexl4wNE3bTdgcaLM
         ZJ18Dv9W7xDGa1glnK7RapQsFOiDwJLM+SNm7VRm7S/E1PG/MD4DBuuUSTEmUAlAzstX
         LnLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778414578; x=1779019378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vmli1MjJU1iPg6tCzc8RsiqsXAYEqteoIsuCG5nm0hc=;
        b=fO0pJrO8ujKdOeYAdQyNU3+8Vm0rnTWHF7763Kct16qI84G4j3Xzo+XVwJpN7NKMrf
         TO6g7oBiNUrXU8H7Se7tTM+BqJOXbOjlXEqZNun8vGKTwQ81pbfnbptOYIzsFbzGBnZw
         9Zv+wa8pOf7abXoV7MVJBpuZUvzyZ5FiuAzUmfoLJP4/d1vePAl/P8PzPOz8ZE558CSy
         XJpeM1BY8r/J/GELM8VoXH+PCF+iXh2sU2AfRAdaoYkrfqMNFTKQvZLsCfFk2uTbVm6H
         FBBg+mkzWMzvkt/QD8YWa/Wlnccoc5A9xc8cUXVirru3X7G/0uydm7yWkQPGz0WfmTvm
         Wyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778414578; x=1779019378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vmli1MjJU1iPg6tCzc8RsiqsXAYEqteoIsuCG5nm0hc=;
        b=ayJsi27Fo1mBgfUTgMYsXHcSV5b1Gw3e5u3c3oiRlsb6s5ac2+6rJinc3/FJZcHg5o
         +LVkYbnUy5puzMzWFLuFoqC8dynH/lN/6+4cSdx437vGTdWiVVpgC1hDqB/f7H0nxI0U
         /kbbMxu27Z7g0h4BdTHJZaHGE95W3Sh2z07D0Zg9SYRdku2u8QhYeCZ7q1x06L9IeJTU
         3hGKVvePvO7QyLq3gYREkK8YbB6WIr6wT5ZGxlwqT7cGuVlTTkLeFVprj29mwYKsSofE
         cuW7lhOadVRzgQwzgOHDhKcbSfYxQDaczYMYCI5k6VHNGmsyjUKcEHlvQ/YfoZx9RYb1
         pTLA==
X-Forwarded-Encrypted: i=1; AFNElJ/+fwrbsXj0yE71eAR0wmvjWP01R8hA5h7KB7GaK4phxEcku9K15syor5zYL3E+w/0uUvnaEiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoL+1zZPisCVi6jjeCw/kkiTkl9RzOEEEekiOZdNMBxEumcnE
	honfqEUX33tgNmOcOLRc9FdKG9XzzxkHMwVAsXdVqn0ISUObdAa1+bnDtDxRBba5yBDUce21ICT
	db/SFMV5lmf3tEnSi8IkLm+fO9smmPlU=
X-Gm-Gg: Acq92OGljECOJLrb/mhYNfceVvCpR8naCReH9c3PXeGaN04DwOvrGovasVEPuAzrXm+
	jk4KPIvsNhqGmZfhp6j1PTmpXWnqOuRQr6A41tBhS80CRBO3pRDi5CvfaBveIP82BWjl2xr09zH
	w3bjugF0At1n/anDGM9t00NxqN8HwTLWmqRMwleRFA8hqfq10OR87Kj5vsehmS9U1EErxjL1B0s
	KGkKqxI4giN5ms1nxbgUlfmvdJEX7RRIEEkEMapE9b6joX3t9rx5adZn5d2LvNOyOGaaBr3LWgl
	RJCaHTzx7YQ2sJhWKeeKKomg7JKfsdLfQcKeT3SoPw==
X-Received: by 2002:a17:906:eec6:b0:bc3:ae9a:15 with SMTP id
 a640c23a62f3a-bc56b94225bmr1059279966b.9.1778414578150; Sun, 10 May 2026
 05:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
 <20260504163915.4a8b028e@kernel.org> <CAGCJULP83NnaX6HAqwb3umDXsxN8LH48_gPpJ_3gG8_xA96QNQ@mail.gmail.com>
 <20260504182833.344d7b33@kernel.org> <20260508033210.5149db4fc3977d33937e6942@uniroma2.it>
 <CAGCJULP_dTSjXQqyOYXckkmtd-HAPo4UT2V0WQofOZaJYLgENw@mail.gmail.com>
In-Reply-To: <CAGCJULP_dTSjXQqyOYXckkmtd-HAPo4UT2V0WQofOZaJYLgENw@mail.gmail.com>
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Sun, 10 May 2026 21:02:46 +0900
X-Gm-Features: AVHnY4IcF3vmMhSO8SdPuE7-fCfzpzAXRJRVY1ZnbUg0Ri8QL_dBkXa2fNxxouU
Message-ID: <CAGCJULMSMrcWmQUZ-RoWB8uAivZ2DZdefED7nShMpUNBzPBLFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] seg6: add SRv6 Mobile User Plane (RFC 9433) behaviors
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Justin Iurman <justin.iurman@gmail.com>, 
	stefano.salsano@uniroma2.it
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 20BBA503D70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286284-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,gmail.com,uniroma2.it];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 10:32 AM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
> just a heads-up: I am going through the series (kernel and iproute2)
> and will send detailed comments within the next few days. It is a
> substantial addition so I want to take the time to review it properly.

Quick note from my side before you spend more time on patch 4/7:

While preparing v3 I noticed that v2's patch 4/7 ("End.M.GTP6.D")
implements RFC 9433 Section 6.4 (D.Di) by mistake -- it shares the
SRH-augmenting builder with patch 5/7 and preserves the original
outer DA in segments[0].  Per Section 6.3 it should push the SR
Policy verbatim and write Args.Mob.Session into segments[0].
Already fixed in the local v3 branch.

Feel free to skip the End.M.GTP6.D-specific comments on v2 patch
4/7; patch 5/7 (D.Di) is unaffected.  Per Jakub's guidance I will
hold the v3 repost until your review lands.

Thanks,
Yuya

