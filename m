Return-Path: <netdev+bounces-288777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C1KhDcooCmoNxQQAu9opvQ
	(envelope-from <netdev+bounces-288777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 22:44:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E850563D0F
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 22:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 686493009CEF
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 20:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9F30C630;
	Sun, 17 May 2026 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHP8VziX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8022DCF52
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779050694; cv=pass; b=DhKiW8/bBjGxJylIABQNa3a6W9LTNbY1aHjPyROrgCoqAj1TxKX3eV9cAywV/TWHsYOKQ1L1iAbzXPXJO9UtTekNC8P/iVSTVK9FuMlWgm29d9LhXLgedAtk/YJPS9MJz5bncgpkpuaCB0EF2e8LRxMHQ4ugGfARdVjLUl90TGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779050694; c=relaxed/simple;
	bh=GGnt4sE8ne/H7gWGmET0kWN59JZ6UJ8t7pw1xM4zOis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrHJpzsWp1lZQtRHXxuKQ9aN0Dxu/J6xsWiywmY7E9YDwWzZ4/pqXzCv66Jdlx9ZAFRYfH+ppFJ+uFoBj1H77AtlYkgn/uUQ9GRKc2Z2N1O4WJsFQiGT/xzg/IJMcx+dYQAcL/vEVu3P3Hu/IS4dl1Wxg1IMbQv+TXPE410xUAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHP8VziX; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso2890793a12.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 13:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779050692; cv=none;
        d=google.com; s=arc-20240605;
        b=LACKdtnOPaco0RN5CcuAuYDXWpe2UnI4xh6C/T4d/Z+6ree9IcLYEN5uALngEhT+/V
         KXTWItTSoINDuafXa8ykIs6W3iQNiOXxrfl0xabR1EpK5d6z+T2CF5tLJzRyMVh1Een3
         MUmeYwzn8KP0U+g4VSFe67rAj2fvytcIkda1yIxksZcOHMIP4H1v8GhI2E2FxP8l2XE6
         rVvQrVeP5ouK+GSXj4QHfY5d0Ftlnuw/ZGwrEVQYOKZW/amax3X4IvzB3tQntL2Q7zQ4
         LWwdauWkEXMu8KgstPRyGUCT/aN28CTdCT/mLvG/Ye2fvmXCQGVrAo4KTQLPqD6+U1hq
         8Gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fmRI5awy/IsMQtPy04G4b/GKkceXWQShYolKMTFKlkw=;
        fh=L/RDECSWUYzKPgyF1m8AdqueXG4dNMr2rkuKhZ9xVy0=;
        b=eEplfSy8N8pBKUQYMuWNj3mzdz+8Yxg9Xu1XQI7KONoARMmoLccbD/f4qM1WfN/ByH
         +Jk6kVnxfOIZCyta3kITViA5zvo+R+CNoAIcy3qOwDTJC19vSEs18FZUQ7gLWFaXMZ4Q
         G67zp29HzltxxMcPhT2F26amdBAMY8IpdrS5HOI2n9P2/3x1zjKerAbBETRI2A3RDIEH
         WcEtZOTIo4CTS0A+Qow+1d5SUrCVGzRZy0TKbCfN2knsNRZGslRc7K5byoh8V/xC4bnm
         8aYiRUI03wh82fumkrrnwOLTlLxKvyz+CKJSI1CoEHxuyWLWu/UhmHPkIGli/WLr1NT0
         g1FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779050692; x=1779655492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmRI5awy/IsMQtPy04G4b/GKkceXWQShYolKMTFKlkw=;
        b=RHP8VziX+vDWo8pH5gVme6lEctqll/bgqJ38x/wViiso/7wlTy9FOpq8I2b8Ac3NL8
         6ew/p/antKUI25VAwdVd5SY6GAIa1gXsqEJHuiE0i/T9TKXZGMyXpXT66S6ZXSaWqZNr
         dZSW2n7N1faGio5mJ1ORadHHjeVUNidUYsX8jPLcShmIe3fl+813MfIwLdikb9nSBwiS
         KRGkAhID4rs5AA6IbPqyWdaN4QDPh0fSTVh+FbRrGaW3JJ3Hw2HjmrotIEO0wT/HBxYg
         Uwmk21D+VtsgzMn4tS9KcuJN9SozoG0zWXdkD5TEVJYTig1Ujh8/lRF6r5b6GS4fLdzZ
         tRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779050692; x=1779655492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fmRI5awy/IsMQtPy04G4b/GKkceXWQShYolKMTFKlkw=;
        b=VCImKOv1AZ0Nr09aqeE3+ZT2u7QbtwzR7NDfoWv8i1nTl6TBnKHearsyYAPujCVNFI
         cJ5nXR0+a0ja57FUSRMbc8aEcw49md9sdjTcyrwjp/RcjoTPt8ZyqM9S/nEBREzpKdsb
         OIgmuW02HJoojlG13URKF1LtTdRbvsoSSRn7VNrA7UuMGEM3JkEWtqJvP0uYsEza1dKR
         pAlceQQ1PcRypaiqAmWUxOpXttqxPZGlSkshJItmSgs/fnkeEqeUcdNwq+w9nQN9mEzv
         perPyBB1uzrr6qXAtj2pFmFUtSLZzyl3OUUShzZ4ulPzYVGWLZEGXtU82WRjslmKWcwS
         phqg==
X-Gm-Message-State: AOJu0YyUVrhGiwyF2UM5Mwnxj1gGbEAsngWy78SgfN0zd3cFILBTQDKC
	hxETdar09Le9J0gd05C5X1r/Cznwgclo9uibjaJDYzxJbH+DoFMTrC7JByyGxXSXpk+U063mHva
	q6g7rq5u/tXW1c8SGON7MfnHf4F426Yk=
X-Gm-Gg: Acq92OFymbcSSuIFM6DiHX0kG+/LKoK6ige/T9o8C0YAxQwKAYKzJkzD6EkE08SXZw/
	IbHjsZTKY0j4unudly1LitVAWmFF8kYNGeiyyloh47Bq86o8FslHZhVfk4FsK5sN2gWlYmkjTxn
	xoDdRbdEJ3hvB788SNJl2FGzl5ZzIrsjPCt93UpCmYeBGpKPMMhE0tUKWPG9A2ToTUW5Gov6fpE
	GR4oO/OBq7OvkSz4rrI1jdrbAjuRJ9kCZLxNMQEIme0BvxZZd9ievnXisVKoGVZRqQDBosO6nhX
	58baxIsiNq2L2oUkgcDOStTMFU7M0ElzBjLjSbgtQPEzOETQ59Z59nnlmLhi0KEqn55WQJCSpAG
	2NFf+DtpOjhb4xQWa9fwbSWl3a+kqHokmN+G6FW+GviLDdMcSce3kVyfclw==
X-Received: by 2002:a05:6402:40c3:b0:67c:5a2e:18b8 with SMTP id
 4fb4d7f45d1cf-683bd18c6f4mr6445415a12.18.1779050691596; Sun, 17 May 2026
 13:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517192856.3925-1-rosenp@gmail.com> <5ac9f5ca-4706-4617-a5fd-d3e6dd3b254a@lunn.ch>
In-Reply-To: <5ac9f5ca-4706-4617-a5fd-d3e6dd3b254a@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 17 May 2026 13:44:40 -0700
X-Gm-Features: AVHnY4JiaYR3WrZAxUy-DcVUwF8ojrxL8XGkQvWd1mkI9m_lJ9TkC5LVysMD-g0
Message-ID: <CAKxU2N_SygFAKQuhwnZG7SP7jiRdkmwS_R+VwHap33UUfbQmAg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7E850563D0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288777-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 1:24=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, May 17, 2026 at 12:28:56PM -0700, Rosen Penev wrote:
> > Collect received skbs on a local list during RX polling and pass the
> > completed batch to netif_receive_skb_list(). This lets the networking
> > stack process packets from a poll cycle in bulk instead of handing each
> > skb up individually.
>
> So my first through was, why is the core not doing this? The core NAPI
> poll code can initialise the list. netif_receive_skb() withing the
> driver poll would see there is a list and append to it. And when the
> poll finished the NAPI core would pass the list up the stack? Maybe
> this already exists and this driver is just using the wrong API?
I do not know. I know several drivers are already using
netif_receive_skb_list, some even which support hardware checksumming.
See 0a25d92c6f4facaf2852f1aac4cebfe01dd57a91

The core seems to use netif_receive_skb_list_internal. I do not know
the details.

Anyway, the performance difference is real.
>
>         Andrew

