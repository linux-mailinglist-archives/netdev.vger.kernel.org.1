Return-Path: <netdev+bounces-286080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC/INhqU/mnJswAAu9opvQ
	(envelope-from <netdev+bounces-286080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:55:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1764FD767
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A7C300E3A4
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 01:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BDB286891;
	Sat,  9 May 2026 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBbxPHZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D272848AA
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291641; cv=pass; b=orpoLqvd51bwWjfX3fjJP3ZrGgtEMrjpSBGxk5z78r+YSaost8x98npbYZnlVXFsarHQR1t8R2eZb8/p9VbyZNkgFyHyXSY99YdA+kRZchieqtD+qMohgQV6lTKKCXgRCvm6TGP8C+JlpqRm4t6wEBQoRFNkw4+keOcVnVGVzPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291641; c=relaxed/simple;
	bh=1PWTKn7AYLgvu7KMlD/EOdk2ffKe20IVZ6QglBuuceg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC2ce33G246zpYlWemTJfrQ+6YAe0fMqqCxJj9lbKYdXYmCzQ1bpI5qO+mzA/FJ+1KaPFuFfRbaAMt+l7N8xntp3frhTH1ewACIrSOAWUhF0xgpcuXsWtjs4l22wHDOpmnCIund0GdtF8ON249l4Eg6GNk0/YJdjgVfc1dKYIhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBbxPHZA; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so4106663a12.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 18:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778291638; cv=none;
        d=google.com; s=arc-20240605;
        b=fMcAQhGkB8Ezs9lLnbM8ZxuCRkKgK2mHCv5WTBdaoEgL/Lasa7ng6KT2RaIVIT04kz
         3WLHmxFXgzm5NQk+Ld4vyQqdpa84lxMSQLNVZWWVaWGp5fGddD6QrgBVSFdno0F4b7Nn
         LuZEGVi+BWVKYpGc2fAX1pTy9EYUbRS/dbwmpJLEnh5KtCQYkLlxCr4ek28mpgKwKLF5
         lCwdDSXOkoOpbcMH603WBxsCntcGFdmilmSDmbC8E+cQbLCUBvdvFn554We75nFJTMFw
         SpFO8MjpILBqxqSTD2nZjiffxiJvK4GbETNiloKeD0+trbFn6w+CFAxeCNJQ5qvJ2yl3
         pSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PWTKn7AYLgvu7KMlD/EOdk2ffKe20IVZ6QglBuuceg=;
        fh=zT/iROwVQgIRQQtzKCHE9bpWhvZMQe5eJp9uMYTD9xg=;
        b=ATs3PN6LQfUykEHL7FL0v+nhZiOFh1IUSzDmevh7q7PLcWj8KLJwxdAzvIexQyqAvv
         Jef5GY41BWxhV5D4qkvamggtTMiwh5QpRWamX37kd8Lm5UI+0EBXjIA9869/adUpdWWF
         6qDgA7Ro7OPjLI6jq27WBTImi0wMc4H6DeZawXgR2cmkKc76s0HkElLJWiHEehvAM60Y
         647gtMugwBw2P4PJ+z6MoCu129+0csqzkU2E5r2/ViX9wZOCHJS39vyNP+DRYenkS5oS
         vDCwsRWzoqnAqId7pu0LWyo1OB4licJJPLF8g3RYIa9ZrPwe8cB4N4wQs5uF4f7N0XS1
         Whtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778291638; x=1778896438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PWTKn7AYLgvu7KMlD/EOdk2ffKe20IVZ6QglBuuceg=;
        b=oBbxPHZAUv7GbHoC8LfNfUKARojEG0bdBoI649iItmGXXh9mmbkuAjhPqvKrk+A1Ca
         4ueD7tzkuspkQuiQNLxSUbaa5H0Uvk8lWtjImJ3wBUisqVmdzudlDqO8bXznX0OLKaKN
         x2s0QorCWYP8iy6DvLYbatHASFYBqgCbWk8Bu8ry28E6DrAPHYGjGwJJmSkKArFZNP7t
         zavF3jkqBvX5v1Fb/f02Z6Q4XwVmg6ku9+Y0XDuR8rbDfbweVeYG8cow3ZXlF8dfs+XB
         GsxU1w6Z7WtYmCnZG2yAK0Eumr+0hUCqVrBMO8a/oMzqqzMqVlIJ3UkpJWUwJfez9pqb
         I1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778291638; x=1778896438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PWTKn7AYLgvu7KMlD/EOdk2ffKe20IVZ6QglBuuceg=;
        b=gZJHBNL0qcFHOaoFon9Pm7HRMp8abLPuZObZReTcjE9Yp+PFkFVeXgj/t+nz8ACDjs
         M44VnHp6wP24fQAXLsMb+6sYdHwgm72zNVV1HdIXeKka6Eb+UxHXKkZ5C+D4nJnTBhUH
         Z0ZqtfTG0Ocv46xPg18GPE50mdnbjoJaBIAGkcvM8Anr5loUFVrhgjIc5YNHolKmnlIV
         hFOK1T52Ro/t4fV19/8+iu8U1pENfB6LU/EgEFiWoudeggo8C/MXTPwoex4YsGp5Su6H
         o50cUnCFb7zrEqkbFSjGv+ZAWAKaxhWb4ZUnAZO/TJKJvlsfdRhBaFgT80BCvIuQFZXm
         VKfw==
X-Forwarded-Encrypted: i=1; AFNElJ8w2jCrD1FuVdSqRi5ZySGidLuMRC61nkS/9LVhdQSQ+/muqRJ8O0t4IsMiutJerDbYHoUApgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0Xn9vH0jyioI/rZV0jOP5r9VOzg5JDbzl6SkIOJdMwM8FBYN
	O5hR8YZuwsPxmtmdckdYkrzHVHrmZnLli+MuUb9X5sa30SC40x4U/loZo9FEjmJA/FPx1o5gMc7
	APJ+IJKDkmpIfwT23fEqsJGMjMA0iFe8Yt0MD8AE=
X-Gm-Gg: Acq92OFQKLG4nmm7t2qh3JV0mBuS9nSyaoQn8O9SsGkuSeqcXAg8NwyhMcZhpPXV8uG
	ZPLtQp7JPlecmTrlCC6MDFR4dk4CY6JhsxHj3P8FFZ6+q0sftZ/tFxr8ZjVLN/ZAbADWu64ZG+2
	JdPyzhCyuIbne4yS85yVDElhfnYpUiF+1HLCfpHoi+ukOX377tihNe3DLFKmqtEawVgDX60Uure
	VVgfm6cNkRTK/Mqmk4M/hG1/ILihU49aKuz5oU59PgwuMYHsxID1wtVjDr1fcUuYhSWgUWj4X87
	4LokErTNdfQ/l88EUJ7lvf2EMAislDtxubxGcH1j1E8RBpTEcsHU
X-Received: by 2002:a05:6402:e88:b0:672:be92:e913 with SMTP id
 4fb4d7f45d1cf-67d645ba7ffmr7195826a12.17.1778291638384; Fri, 08 May 2026
 18:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
 <20260504163915.4a8b028e@kernel.org> <CAGCJULP83NnaX6HAqwb3umDXsxN8LH48_gPpJ_3gG8_xA96QNQ@mail.gmail.com>
 <20260504182833.344d7b33@kernel.org> <20260508033210.5149db4fc3977d33937e6942@uniroma2.it>
In-Reply-To: <20260508033210.5149db4fc3977d33937e6942@uniroma2.it>
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Sat, 9 May 2026 10:53:47 +0900
X-Gm-Features: AVHnY4K_nqWe5NsW0wxsdZ1F8p2ge0h6vNtdlnAMLhajGOPTKK7c810iiAxGn0w
Message-ID: <CAGCJULP_dTSjXQqyOYXckkmtd-HAPo4UT2V0WQofOZaJYLgENw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5B1764FD767
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286080-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:email]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 10:32=E2=80=AFAM Andrea Mayer <andrea.mayer@uniroma2=
.it> wrote:
> just a heads-up: I am going through the series (kernel and iproute2)
> and will send detailed comments within the next few days. It is a
> substantial addition so I want to take the time to review it properly.

Hi Andrea,

Thank you for the heads-up and for dedicating your time to review this
substantial series.
I will stand by for your detailed comments and prepare to address them.

Thanks,
Yuya

