Return-Path: <netdev+bounces-278099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJjCKhYA3Wk3YwkAu9opvQ
	(envelope-from <netdev+bounces-278099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:39:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2C23ED61F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B2AC303DAEF
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128AF3DAC13;
	Mon, 13 Apr 2026 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pR42IbE7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DE3CA4A2
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090548; cv=pass; b=eudaaq6QSkNEoMI7PjVrHZgexNEmz2g5zqbk70cTH/QhNTIRRmO3MmtJ+AONghb7nLT44az1La97+sK2MGB0z5B8U6FJf8b5uRR4TGX/FOMcY5d9NcXmC57+UAE5f/85/svBlEQFfue3jN3T41SFoheB0eFIkW2Ko+SZ5c1hfJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090548; c=relaxed/simple;
	bh=5pGldg5LDg3CMGSfJFi6YTbRbiKoEeZVwIRYs6LRBd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0X0StvoIVcLf2ubUuFpcL2YRYhJ2PlwFh1476Bi/XKskzaS1Jgpmhi8ERdZiPl0YXVitGokDPjj3mnoPhtyR0xnRNK8rw95iNs31j+WiCLLovkZ5RGJABNELIHRD6DnXmoC4wO78zw22/WWikKQUF6D6cj6zPkcAp26aEnKT74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pR42IbE7; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7b186dfc1d0so21435247b3.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776090546; cv=none;
        d=google.com; s=arc-20240605;
        b=POhmyZfiTaUTjTIGi5lKzCGQWffZXNrbeaZnuhXGVWUgBj12Ghbk4pMnTxePdB36O1
         K4WOha+GL5a5H27a3qVl1J7w+8Ec3La6j1eEnXIsky/zlFN4VjLXixOKhj2dZSzmIVvl
         l8kVHi/1ZUmIrhoqeQA0lugI7pYVxGtIXNsNVcF4k30ZsgoxLiIue/69DN0p+xg8vM4T
         iZBvVsmm2c2ObqmE7pUK8nh7UAyoYvSKrg3MgdwgSxL6oG8jihqNr/OkzsDoFVih9eJg
         fJ5hzXEV3tfhV81t00wSBWz10dnsSdpUI3Eyf57e8Pj84koaiwXSVJTbn3jj5K6uMzVj
         8mig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pGldg5LDg3CMGSfJFi6YTbRbiKoEeZVwIRYs6LRBd4=;
        fh=dOT7WAD1fzWXEctuF7FqdF4MdnI4aAdsgrBYQLD2SHk=;
        b=b2t97YBS/HBDrn4XSqD9YkQPVLKu1hYD055Qu8EQeQLR+C2wNhnmr73TpWGmnA7V7T
         jYkxpvmwNdnd9h8rbU3FwCL7rbnIG7HYa1W23yAB/sb2bjHvj52UeWGjhMcimfNbGyYp
         5i42XXe2qnil3XZRlwYISI+PGlUbO100obLFT+akl1eKwjl5+5J3mvgTlVNgWpVFHjGn
         J22jF5D6yOWszbKkYuJJ2ft9Y/VF4maymXS+7AKw5i1WTfu8hn6wj1oHvHuL0SmPzcvF
         9mplPM5jEj0ojesa9t9c8hxXAZgP3WV5nFdmr9b4u2M9XhGKkL2Fh2RC84C9hLYWgdOR
         6JMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776090546; x=1776695346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pGldg5LDg3CMGSfJFi6YTbRbiKoEeZVwIRYs6LRBd4=;
        b=pR42IbE7evYwzN5vqmKK5oyUtbwoUjnqkUYqmuvIWFdCrHGXCRUbn3L2jk1Bo4cqlE
         ZcM/78TDmk+KhVgb25YhfZBb3ZnGb3dwNtL4vh70ys7aQEXXOscaO//5PUC6r0aCaZ9R
         6KUhIl8NYYwqZKISW3F0Sjod30FmJtk/IS532j2RB+83Bbj4IJF1F9oTsSyrr5L8zOSf
         foBscaA8U6ghhz23EuRl7eBdzhmHI+IlmjgSx6dNdKGxjGcpfMITISXcaUDP+1G5pViH
         kf+iLiZzdDm+CjzAoCYK/vNrSpDzgJCmDdvaseYZmjcda3H6DCrwVJ1QAso6dHxEt8l0
         qVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776090546; x=1776695346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5pGldg5LDg3CMGSfJFi6YTbRbiKoEeZVwIRYs6LRBd4=;
        b=iJfTRLGMwQ0zmyBE3NiRa2q3Z6vvNbBH/RYzF/W6UkbP3zJVBapDGxW82eAhj3C6sd
         zA/B2LgIQb9GRT3dT81OM6PiQPJRp8WNM3N0gGpJ2f9o6C5QkFIwmn8cbQcYb9nc+Qba
         ityn/Rk9yA7FOeTKGCL6kreTGyXAwkCTx/rTcYnl+00a/CwURsUmcIS5KjiU4VVKII05
         pUMAZr+vbqf8DI/WptAOYGguvL86JFMaLd22gL7oSDvNBFXpyQP/H6Li/0sAYti4f52+
         Hxc7PIZMa0rvwQ0SrpdCunoLh14vmzLqAK69QtvooTIler5XV958lSl4e2HB1dlJQDZc
         Q4ow==
X-Forwarded-Encrypted: i=1; AFNElJ+4gLd0lbp4b8SpN8HdVZB4/2wTjkaCG/88BqXT8Y1+3Gm8Y8x+dDOobCPUGfSp+Bc8JbH6GYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkEE2Y/mjWyPCTB0dRko1I2Wr/unLEVoExazeY6l6vfDAVIru
	oAAb7uhRwn1suHnpMDBLDUgszZMIoYhCyiPxZmYj5lm9jMqBHqZcsDJZTUU0chFUn56kA2cu/E2
	IYDp70/2Qv/UuAmBq5vFkvOpP4FXnoNg=
X-Gm-Gg: AeBDievLFRrtzLlr9KMLLA1h1lhk4IxfWVcLJfB3MuUCX2OBQhRYwyI3Ad+woiFNYls
	THeM2lFl9SW0POY6rU5yozm5cQ9EsZAdGdXrRm8Z8cjyMr+AFLpLW7HsJQwL29hp1M53avOcKm7
	+A19XZYmAPAj9QZJqwpwSu7MiZADNcjYgdjbq5OC9nIlr2s+l4mEYEOFK8EC/DeZlPkIE5Mg4VY
	eXkfYJuI4Wc32D8xzL1m+A72eUBvS1DbVJjHY0slHOaqSasF35aN8T8J+ir+1MsLm4SJPI4UfYR
	udOWNMjDV4R1sUjnGPaME2FW9k8Ra8bm6p1w1k/nHFwVEk8S+TnkScHWqFRQX58LVqOuefM=
X-Received: by 2002:a05:690c:6b01:b0:7b2:1bf1:7fef with SMTP id
 00721157ae682-7b21bf18563mr51148787b3.10.1776090545774; Mon, 13 Apr 2026
 07:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412020809.35465-1-kartikey406@gmail.com> <adzwiKOPptwbNp7Y@krikkit>
In-Reply-To: <adzwiKOPptwbNp7Y@krikkit>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 13 Apr 2026 19:58:53 +0530
X-Gm-Features: AQROBzC_yfKoPJ4uCTQI_2WpxPA_gzw1_B6l09wDF5vAxCHxHODoUUtoT_KEj0I
Message-ID: <CADhLXY5a7QCdp7NXC07fma905O8YJ4jPcbbdK0=kFgD3d2AF-A@mail.gmail.com>
Subject: Re: [PATCH] xfrm: fix memory leak in xfrm_add_policy()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, leon@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+901d48e0b95aed4a2548@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278099-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,901d48e0b95aed4a2548];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0E2C23ED61F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 7:03=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>

> What is missing in the current code? "we have a better way to do this"
> is not a bugfix, it's a clean up. The kmemleak report says that we're
> leaking the xfrm_policy struct on this codepath, which doesn't make
> sense, that's covered by the existing kfree(xp).
>
> Also, please use "PATCH ipsec" for fixes to net/xfrm and the rest of
> the IPsec implementation.
>
> --
> Sabrina

Hi Sabrina,

Thanks for the review!

You are right, the existing kfree(xp) already covers the struct
itself, so my commit message was incorrect in claiming a memory
leak fix. I will resend this as a cleanup patch to replace the
open-coded manual cleanup with xfrm_policy_destroy(), which is
more consistent with xfrm_policy_construct() error handling.

I am also separately investigating the root cause of the actual
kmemleak report and will send a proper fix once identified.

Sorry for the noise and thanks again for the guidance.

Deepanshu

