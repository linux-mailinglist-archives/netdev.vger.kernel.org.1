Return-Path: <netdev+bounces-263391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPkNHVc8p2mofwAAu9opvQ
	(envelope-from <netdev+bounces-263391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:53:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D5C1F66EA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5342F300B541
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3557E37C919;
	Tue,  3 Mar 2026 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EixpWi2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA61A23B1
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567382; cv=pass; b=F6owavW1baGMuv128solEvZxYXN+LepO0InkUasahGDzN5+nsODzlaLy7UdJy+l5J2Zr0hXzkuaYF43nkDYhqeUtDwLYEY/mgktQl+nKcBFlQH6I5fS22ecDeWbK4Wx3X7HV6wKUB/bRxDF1b/4kPU8XAhE3Kgmlo0AN7eazUIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567382; c=relaxed/simple;
	bh=s5I50De8oWbqbqzs/JdgoFgransG2zQUPtHJLBImFzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0rFJ1dCGC524PTnuLYFHoKy9e1eVQp8puuR717Ecm/YwKPrBZBP6t9KNgbdQm7158jkj7Go6kQQSD1QRBsq1wPWae2sLuXzd6PdDZyHR77jP/788cnmxFK1Awz9aWxmTIp2AT1AEJdbGdPUMUVOAAKOFmZFAl6HZiSczyJYpFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EixpWi2Y; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1273349c56bso7356383c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:49:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772567380; cv=none;
        d=google.com; s=arc-20240605;
        b=NbIlcle1po3zNwp6nBOkWomHHbwaWRaYh6/wdRgOiC5jAga+KaOzehjGbZe53MpVa9
         bOgGiCWsms+OjaGF6Z4p77imfY754X5J4r0PhgLVF/VsEMdzQB7Byvqf+fycGedzYFnL
         sFEy1y+By7Tb8bmEgKYxBuoTKlWyY6nwHXkmtk7o3oLRUGNNouyiN1wHFF33do4Q/1qw
         88mYIZ54SWotEOMRKTrdY8E/C5ichDfKtOXu4CvPkQaaD7HW4wuvSlXdfg+IqcmjTulZ
         jAx1PdIeW4WH4ulD8YQxdfOyB0xxp7vGwAW6HeL7q6YswpYOdagNUgNoyZ8LbRlUT2SG
         WtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s5I50De8oWbqbqzs/JdgoFgransG2zQUPtHJLBImFzU=;
        fh=cDOIWdpESS8u6X80LqTt1j82SupjnpDhzf5qkyajosI=;
        b=btmvJ59MFO71jwxmK4Ng2bCnhWz9xTMKh3PhYy5yD7Uy3yHkWbUf5e3dftc8x9l62g
         B9R50rp64R20b6WazgGFycGt/cTIICYwSY4Zw1zfTXJkXcszPZyVU3yr8ykXKv5fgj+e
         mNXsapHH5yb6aiz8ZD2xE9tf1g4W+7Jlul9Wvu3ZZJoH7zNwLvWMphuBVizOyC8EzDOv
         lc9a7NZ9KpXQyNI8unQZXLYde4yr7X7waPPaqrPTjLA0SQQKnHPuxXkQU/1ka1HYsKdP
         QMcwMyOHQWUhmMZ9sus9+H4anz6gPnSxBLUlTpHWSWKHj8ulsQt9t88yQfymo3sMKjzH
         rEGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567380; x=1773172180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5I50De8oWbqbqzs/JdgoFgransG2zQUPtHJLBImFzU=;
        b=EixpWi2YE5rURCJDApY2NPQ2goKJZnJCWZ/wAtl8SXPoDdlbtAVRVfhdThxp0/sqU4
         UtT4tVLbm2to4Du94upDhzFg98KTJdHtPzeBoHz+co11GOzuxhg6zQkjhVZ8AQMYwsyr
         DmDEPvCYapL001gMreGu9Nc6iSKALq781eItkw5VfS/1k6xF63ZwYfwOePLDQ1WUOwjm
         u0Q1Z5g9UGyil1QYeAZTgSdOg8eVPKdd4+PaKVmwaw0Nh/9+K9R84CGOeLWA9AhsOEik
         hOvkS9gA+vpacmsliaVFqBjiWcE7Wt8k4tEIt+PqE1L9t8adFGuuz32CUX4SN0dlKjEj
         PhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567380; x=1773172180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5I50De8oWbqbqzs/JdgoFgransG2zQUPtHJLBImFzU=;
        b=UZy16bGw+kCVkMZxyETq9HVSalWMixuggvgZoG+gm+OiaGxJxhDC71pH1JjD5qOAvn
         iDWlTcW/isVTvizqnfOoObp9g904uFY6wrNLGrt/FA05UBeEUkEQkHNjnG/Pme3lvuvD
         CrLTXlHibA3YbSJ7xURtgVub+OxnSMrNCBkz/vlWYqhiGNpk51z/txovMqVd490wjYNS
         nvvbdjE80iUHOliZ8hO8fa6oR7//VS2/hsY6AJlN6URwP3mZyaSqeXYPWbVdaI3BQRuw
         JzTAIRpSEAVTxK8zDkJmXb+JRma6BU5EpN9TrtzoHXcd64S4pvdeFo4fPhpUX0+f8PSu
         fykA==
X-Forwarded-Encrypted: i=1; AJvYcCXki7KnqnfEFYZMJ5v2Bjadz2dPyZ3j9HuiVJKalTi2sJpEJExB6oIH0L/OsNQ0b965HkLYoU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGg/IDmCDAwoHFmdopzK1r/oAI5aI+zCt0LPsx6QB7gR4uPkvN
	sJBH3hXG5u/77uvfoDlC/lNMdmz7hZRJlLb4EkNjNaP24IAz0IyhxlJKOQTq7FTGF3D9N8ODzBn
	iPxdCUhBQrj0Yn/vtnFofWFIKcyBf75sU3+al+59k
X-Gm-Gg: ATEYQzzngfWLQ0tUncvctWh6IcjO92/ZhVlIVpbdoWdrZ8/Ggmr7AdApH74Y3/+l/QE
	M0Ne/El8JXBQHDsh59b1PqoroVeECXiFfD2UeuICjcvU6jlzTtWakGQX136GQRkJonhxCVcZi+Z
	Lx+IVMfgyhfH9LvajROf5zmQFnY9jhrciPK+RIwfQg/m4ywl39E2xIKXGUCsN9IxkdAaVr1FxCO
	RTfL8lEueLl1Jkp7JS/V7mpcImw+L07HRTF01w8Ux7u6/m8ROjWovttDTeqYgsVe6o7ZN6qsndx
	llCDbdaoABoLU5lcg4GTNwRBJsUSTXXYEiuFvbWrJ0rt6b3eqjzR5yVPqjOEBVSREwpp6w==
X-Received: by 2002:a05:7022:699a:b0:123:2d38:928e with SMTP id
 a92af1059eb24-1278fc52986mr4959398c88.35.1772567379688; Tue, 03 Mar 2026
 11:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302181432.1836150-1-edumazet@google.com> <20260302181432.1836150-7-edumazet@google.com>
In-Reply-To: <20260302181432.1836150-7-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Mar 2026 11:49:27 -0800
X-Gm-Features: AaiRm5112ZBPXCb2cnoCQjCckkLAK4mEmx2U7A19h8Yo3lDoLdQthy5dvu6i5OA
Message-ID: <CAAVpQUC62sSbTP+6HL3cRa1P1WvOginSujoy3Jn4mRLQRoR3xQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 6/7] net-sysfs: remove rcu field from 'struct rps_dev_flow_table'
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E4D5C1F66EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263391-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 10:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Remove rps_dev_flow_table_release() in favor of kvfree_rcu_mightsleep().
>
> In the following pach, we will remove "u8 @log" field
> and 'struct rps_dev_flow_table' size will be a power-of-two.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

