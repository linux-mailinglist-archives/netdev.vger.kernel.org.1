Return-Path: <netdev+bounces-259137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMHTMCi+lGnHHQIAu9opvQ
	(envelope-from <netdev+bounces-259137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:14:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2704F14F8EE
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 263C2301BCD5
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453AF376481;
	Tue, 17 Feb 2026 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGc6WYI8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659C13DDAA
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355662; cv=pass; b=ezlpuU9uSKepouIi4pZx/x5OReBdJr2jQFOesmv3eTTHbOdGCe549+/3lryHBoTPNhuM5SuhXMCwz0Q1jpmrs9VZq023I+Ejh7tLXcip5VzluxTtsRkBQN3DzI2qMBosRcG9S/q4M1Kx2ZY8wwaxhdV5frkODk3mcZelVtSyK5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355662; c=relaxed/simple;
	bh=aQiWyVSftilCOyVcfGMO5Txk9dV5oTrqKLEhf2u13ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0nODsf14WZhp8ft9AzSVRMG0Ow5F6ZN0I0WRjtaDLgDjIe2puMTktbE4cHmvlFdjPJ/aZERONa4/AxyKrSKYxpRlO5aGMfC1l07+jBC7HJvyagPUFuXLJ1EyUCIC1Y0gTs+whYKDoyMjngtiob7fjKxICCM1r+/PpRC2gUxifI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGc6WYI8; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-94abd52b274so1112481241.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 11:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771355660; cv=none;
        d=google.com; s=arc-20240605;
        b=MJtk5OEJ3+nItqgjTp5pBJQ1S4PmD9rh0Wj+WvyG47M64sohDJbMCLrx0NlQxscbUu
         OKpOxN5UIiczkrd/2RO6/w3l0WXFOUVaDPp2agubzr/O0i6XmVYuDbkkK45yyznEZxbV
         kIL0OxPX6uYu3yv1LArAW3Z2mcWgDGrYEbpQEhGc/l/nshXOcrjjTUxoT17UBOAPpe12
         1q90rh6I2MnBj3ZSJ7W5oZnkZLYyA0kUdO2pr0i5H/cqlwMgmhUF61tHxZY50NnukGwb
         psc+v1p/u7Mz9W/U4Wi8itkMTuQP+KJstO4GyY4g8h1kO/e2jCJsui4dBVzY+y0XlL7X
         617A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aQiWyVSftilCOyVcfGMO5Txk9dV5oTrqKLEhf2u13ts=;
        fh=pI09umewJsPgQ4thhjaTJHBlxj7x1coiMJ7dEizJeus=;
        b=YKOVD2/T5nKElIUhWdi0GXj8GynOW0nJUApSeFJHBKlUfQ0uWsYWdJeDtsEt19eHtd
         h/Oi3V79GEiKzXCP0O6OswxSvZzwBelxQVmIMSD/ZLOKajaqFPrrFwE8K+YAp7OFXjRb
         ZRQ6QpUBFETxnRyQJobj+BMLn+fNHQDkQCUlfjeBaqMxFW0xwrS1BTdk8J1/vwEt+VZ4
         FopR3E7sWhxkaoWa3bnrQML7n94Ko4+PUbpddntygkBdRUtYIOYP5h0fsUOGEmaWfzFJ
         gKAPuVhh1yJoER4yKTdOrthxqirCOeL/hs1S2T8Amul3/Pr6nS7L42X2uc2XBAm5HbuM
         5F/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771355660; x=1771960460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQiWyVSftilCOyVcfGMO5Txk9dV5oTrqKLEhf2u13ts=;
        b=IGc6WYI8bY/ZXMjW9lw9OTgrpY2bnGl/0wSGdys9qkp0xk6ie+qaAjZWmhOmuOoyTj
         zd5vQ8Q1k1RIHJHe1cRcZ91lvduoAD0nBt0jgwjzjR66lkfRdtVCDGvu5ZlgxnukBRUR
         vU3ImO8RbmGWiRehhqHpIMLdEDFEyAxl847jeWKfNPSnL15FHPLfDnhCj96CbYRwQ6eo
         YOzHoRTTn+0GQqfRG+w7HYYJVnVnef+5pKFp0HNKkmgBL55zZZJDZBVk2NlyBlNhyIDY
         P1OcrUHcFT4g4cFogP0QCmGWiis8A6kNF0prL1LxeCFcROCq6lpdIkLMdiLRmhHeeb0/
         zPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771355660; x=1771960460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQiWyVSftilCOyVcfGMO5Txk9dV5oTrqKLEhf2u13ts=;
        b=u7YXPRYUw0EaTKZvyn//3+oBanTvljmZFQPnOuRWn/gzyjwOjYSrsrDyjGwywHyhaG
         HxdlOGrFhulZXUxKja9WfGzSIKoE4GbQw0K8bERi841rxym/sXcGL8IfLJtCo5XD+TVu
         hZWDaQzqWcBN5LWYe5O7my9MF4nMR2ZNkN3Z7FxW6g3a5MlVHaw41gEfhrByM7ybFt46
         MBmTNmnUFuUsMEN1wOfo7uEp++RGrv/XH8OPTRaJyRcDaNqhi0sjvSeMaldrW/xdW83A
         MN74J+w3q+mc1t3DGK8cFUx7nlmPILXT3LmBGWHav+T2yTPYZyO7Q3P9dIzCeQ5dymla
         A87g==
X-Forwarded-Encrypted: i=1; AJvYcCWL6i4hk7PZSK0vMQC97pJarHY5WaTAgCKeh/Y7A/HbGxOTXOBhlf+UVNl57ZhV5bjLX/8s3+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/njrhnVwe0RTn4lPOxuhCEvI2vqp40kqQ31g0SM6K59G7ud4
	pNzlThqE7PIXfARXnnV1/uD92rnfe2TskS3rFIhEexGesRdngqpVSbijB+WVSS4HwJXLy22Jpj0
	4/ry2hjKRh2rzhr2McCjRPCDcot3QO/E=
X-Gm-Gg: AZuq6aIrtG6GeBjxEJoromnl0tg2fYK7CmXdl9/ic+/2FUB0To70o39IwBiRqsWfRfM
	We5Xggi0d1k4eOH8mHoT2Nficl4zgZuANidSjvphFU9RBJ47BfwK2B/plZevPETouMZwcy+IpCU
	kg6z7vQTorLrUtXTB2BWTGzlYVC8IZ2zplL8K1+ZVI0gvGlIMS4wvJCbbZtGW09fGYG/6uYGL6o
	NrxHel1kT6yzITFQuitIHgeZH1GTjxhAecvAR7g7aKUKJYIsWE4enNRnAE65WR/KYP/M6h9T933
	KRftmw==
X-Received: by 2002:a05:6102:290c:b0:5f8:e509:aedf with SMTP id
 ada2fe7eead31-5fe1acfffdbmr4992636137.17.1771355659924; Tue, 17 Feb 2026
 11:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-3-seanwascoding@gmail.com> <f71cdfa7-25f8-487d-b727-39ae962401a4@lunn.ch>
 <CAAb=EJWNSvTHuUX862vLmA2s1uKO0vy_x9OSZ6VXqY9X-+JNsg@mail.gmail.com> <00ebdd77-d6ef-48f2-a25d-8d8b3c7dc7a8@lunn.ch>
In-Reply-To: <00ebdd77-d6ef-48f2-a25d-8d8b3c7dc7a8@lunn.ch>
From: Sean Chang <seanwascoding@gmail.com>
Date: Wed, 18 Feb 2026 03:14:08 +0800
X-Gm-Features: AaiRm50ToVexierr1z1Su_gldXlSCi4DybqgKCXAHCAJD53YMQslZ6G7oLK7A-Y
Message-ID: <CAAb=EJXQjraL=VEod0N8Pm5tuQ5UE9UbrdxdZQ+ArKVhDUT83w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: macb: fix format-truncation warning
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259137-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: 2704F14F8EE
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 1:46=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Given the other patches in there series, i have to wounder, is the
> diagnostic analysis correct? Or is the RISC-V toolchain buggy?
>

I retry the different methods, I found that when I directly compile
the macb_main.c, it can trigger the same error, and I already prove
the different compiler will reach the same result, so it is not a bug
of the compiler.

I also found that the x86_64 defconfig does not enable CONFIG_MACB
because it requires CONFIG_COMMON_CLK (which is also disabled by
default on x86), whereas the RISC-V defconfig has both enabled.

>
> I do agree ethtool_sprintf() is better. But we want the commit message
> to reflect why we are making this change. Is it because
> ethtool_sprintf() is better, or are we working around toolchain bugs?
>

according to the content I mentioned upon, I think the commit will
something like "ethtool_sprintf() is better to prevent data truncation
and properly fill the 32-byte ethtool string boundary.'"

Best regards,
Sean

