Return-Path: <netdev+bounces-269736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMEMAOeevGke1gIAu9opvQ
	(envelope-from <netdev+bounces-269736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:12:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC392D4981
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8D7C3023DA2
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E9E279903;
	Fri, 20 Mar 2026 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZbvpb7m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA07B2594B9
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969122; cv=pass; b=huY25Y/RG8+0PePjOUlUAXfLUI12uHbQBkXAFzUrWF5KxT+/hkDNXXOtlV+tK53zpuE57SfsGZWFLcK7tLSzHhghrrGakvzWRHOYWrQff+aNlZjHvYv81FvNC5xkSemvSyDwESeWZ+1cm2LqzU+9JqhbfraPsAnIVI6h2Ie4/Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969122; c=relaxed/simple;
	bh=nzszZFUGC5eoe6b65OiyPCgDvur5T6niG6Xz4kQ9bFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuMWK5OkYrglml/F4NihIKbnN9RPK8UFd3a2zblnI7n7sQeEHwlRXaARNcaMLpIvqut2MOY1dO+cyN1eyaUWlYk6xcvXUhMpvOrEZ5OH5N/mhdAHYxOZORY7r5KFBdraqKuc8zyYbcbfdHlDPjUvQ2OdUEGF/3l5ThLoYnisY9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZbvpb7m; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso622735e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773969120; cv=none;
        d=google.com; s=arc-20240605;
        b=cwGshAlBldgHeZh39PjMYyz7morHZgKXy0uG1wQBNR+XqkEaHHTe4t7P/i1Rkrijdk
         ERmAmLUKlWWu2AUerrZ5HZ+GCTLeC//Ste1mci0PExO35ySArOV9KvgbySsMsxF9ZcfN
         +7azM4Vea7Q+j9JTIiViPow0X+aZl4jX4PBQY5pdo9vh3J0553tZKOfwrAaan8bPHviv
         N6ZwwJo/6pyAVCEPbrQMiLDul70MtIyN6ad1hMXFbtNiJyr7jj2E5M6pBl6C4YBVK5gs
         UXL1so1IY2o6ZZ3478QjnsOLcFYW1H5907/qL6aP/ppSHY3o8DwOYGBGbp/SUg3oWgOs
         Xy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ayGFwySZHs4z9NIt8eLhyZLQX64EBLltnUs8BhPc48Y=;
        fh=tmIu7IGYS8TO8ixWWIxVZdyXdHSR3LfLK/n0WwroH8s=;
        b=aJIbWzb5ERarM5YUePDvtq6ZZFuJvzD4ThVZ0024rCZisBpYLaqxlGyQqCFR5hUiBZ
         +q1Uy4gobwTEc6mEwCo5Rdmj3jJ5swBCWgiWgaTiaR4tzSeLZOvvzHA6SsBobfsFmXEP
         dut6HrtoMDrxnJ2GiBetLNBz17x4GsJpUOfF4qENboVKiT1W0joc5Jq3p9PeLe04shCW
         36Exw/mdwZks3nWNtIjim3wcjJMpe0pm14MyYtG9XPa19T7MykEL0ctYahXR/dzatMir
         16hvTO4qYtbF0rqfVLzbhhkS6VbSgWXcA4pIWJG9gRYM0C3jPKpBb1LY4X0QSFdxfHs4
         MXIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773969120; x=1774573920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayGFwySZHs4z9NIt8eLhyZLQX64EBLltnUs8BhPc48Y=;
        b=mZbvpb7mnU8Ar3hRC87vmrktAG7veVIkyG3LmP5JfPA3mxwIjBOnxWg1+XpXYQ9qlM
         MPWPFggPlOx1B09BFOttnQK6DwWqFfoPKAxIbRoB4LTj7oGemszAZRww/YR5p1+exDOo
         O5c99FDkTAPmpwBEoX8qkC/LDoZ4LNX6OhDQSMAYzgPkPJuaJjT30r4GuEvXdRK5b58C
         Gs9d/iFvxBcT5IziQ8O6xrc8UAwRPS2lC7UPqraDBudNVUpN31aVJ3K0u9WQBvboNRga
         DxlenQFSunqef8zo/TAFzgSbE34zgOaMvn9wXKmebtTP8mh7v0/kFnjQwOwKWOJKCeWO
         bU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969120; x=1774573920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ayGFwySZHs4z9NIt8eLhyZLQX64EBLltnUs8BhPc48Y=;
        b=sEW7Az3PdCdNZfeN6dJqjkhXboH6BQRi8dTBhkRDkABQo34gtivKBqdZVnPLA7KMMQ
         dunoU3ZyCQGztsvkpmPniExtTyekF2Vs0mImW5B8LW6HC3mpL7K6FbKxXjLdJcbBO6AJ
         f7dwqgL82JEFItsGrbI0CLDHvlW9LcRR5Bt/iVdUhd8Q7Uq+gJT7bFMrgfqXgHIHVb/x
         GlkPs/xtH3W+VlrA8/PD5juxjtq/vn3rJ3BeTLRFkf6ccBwhqdzLbuwxAFo2U8s40TVp
         a+clL5cjDFZPEmv1ygo/FIp/62if8O1Ycul3GnMwUyTS5esOTjtLf0agzJRxplDuD3cY
         WjRg==
X-Forwarded-Encrypted: i=1; AJvYcCXG1fqCfuftPw97Qzt0Mon3gEIcofrT+Lll+Lnsl3CLLkzLgSpsLZqdQNB62OrCLWYInIbj5+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0YkqILDPew+NntAyr3a4rZXXNVX/dZm7VkRFW3OLK6fSdNSiY
	tWLeWCzcMNyIAH6LSOKaIS8tQGyMUVuKmx2gyON6aNhkHa0KVGQTXtqX6JGmp0wmitZjxq0LJJN
	0GiFp+SBHC9hadfhBRfn5Zix1hr5kO4g=
X-Gm-Gg: ATEYQzz3bN0bpylze/ZKdWnhKpCnxyJ+HGSwqKxTJULkb/n4AyjJ+srLtLMGXEpLCLa
	I1wViOdj+7JsnVtgTcj4fKhzGnRga9zMLHALSLClGsEoO6WT9Ce/0uAAvLr7NmTxycgeHBBFtdS
	hrayWhArQ0F4lFbDObX+8G6wmpeCU9PEmjDH3LCak1DFejMXUnlk5X58905hE1b5fbzEm/j/X+B
	z/2GW1kTV7Ft1YyHXwGgFSAbESoJmvv+sAvHDfV1CCGw79TMJ9fFyk34WLdWjlI8hNBI3ohJdN5
	lwvgTVlwxHxDw8XRwDXBPegJnKrXyn6Dx7j2bNtZ
X-Received: by 2002:a05:600c:c167:b0:486:fc94:d8f2 with SMTP id
 5b1f17b1804b1-486fedbc066mr17394635e9.14.1773969119695; Thu, 19 Mar 2026
 18:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319184031.8596-1-CFSworks@gmail.com> <20260319184031.8596-2-CFSworks@gmail.com>
 <abxxyHVXp6QpPue5@shell.armlinux.org.uk>
In-Reply-To: <abxxyHVXp6QpPue5@shell.armlinux.org.uk>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 19 Mar 2026 18:11:47 -0700
X-Gm-Features: AaiRm50mRwjPccV1Lpd9XuZSBHTAzYDUmTRqARu72YFqm9lh9utWbuv6pvfVHYE
Message-ID: <CAH5Ym4htit49autJb8E=eatof23YK3qomVBCsXZi2cFR6CyViQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: stmmac: Prevent NULL deref when RX memory exhausted
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269736-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.343];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 6BC392D4981
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 2:59=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

Hi Russell,

> Isn't the limit equivalent to:
>
>         space =3D CIRC_SPACE(rx_q->cur_rx, rx_q->dirty_rx,
>                            priv->dma_conf.dma_rx_size);
>         limit =3D min_t(unsigned int, space, limit);
>

I had to think about the edge cases for a few minutes -- yes, you're
right. However...

> (Think of the "full" and "empty" cases as "space" which can be
> consumed to provide entries for the refiller to action.)

...this seems like a double negative: We're looking at the ring from
the refiller's perspective (i.e. considering "dirty" the meaningful
state), and *then* looking at the "unused space" (i.e. "not dirty").
If I used it, I'd at least add a comment explaining that CIRC_SPACE
is, counterintuitively, not measuring "space."

After the bugs are fixed, I'll follow up with a net-next patch [1]
that removes the `min` altogether and makes the loop check for 'dirty'
directly, so my focus here is "minimal, obviously correct" and not
necessarily "tidiest." Would it be acceptable if I simplify
stmmac_rx_dirty() to use CIRC_CNT() then, instead of using
CIRC_SPACE() now?

> I think the same applies for patch 2 - when the above returns zero
> it means we have no entries in the ring that aren't due for refill.

I'm not completely satisfied with the `stmmac_rx_dirty() =3D=3D
dma_rx_size - 1` expression either. One might argue we should keep
trying until dirty=3D=3D0, because tolerating *any* dirtiness risks not
having enough buffers for the next traffic burst, causing avoidable rx
drops. But that's a discussion for patch 2. :)

> Have you checked whether stmmac_rx_zc() also buggy in this respect?

I skimmed it. I saw that it checks the return status of
stmmac_rx_refill_zc() and on failure, returns the NAPI budget to keep
polling -- which told me that the ZC author(s) at least considered
these problems.

Looking at it more thoroughly now, there are a few code smells around
the unconditional `dirty =3D 0;`, and `dirty` being used as the "budget"
for stmmac_rx_refill_zc() (why have a budget at all then?) so it looks
like something's there, but it's a separate bug if so.

Best,
Sam

[1] https://lore.kernel.org/netdev/20260316021009.262358-4-CFSworks@gmail.c=
om/

