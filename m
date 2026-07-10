Return-Path: <netdev+bounces-306578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1eEuDxn7UGq49QIAu9opvQ
	(envelope-from <netdev+bounces-306578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:00:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B873B898
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:00:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=b+oIkwmj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306578-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306578-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B517D306C070
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3939E28A72F;
	Fri, 10 Jul 2026 13:48:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4DB7E0FF
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 13:48:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691336; cv=pass; b=fDA4CdqLIe8X9I5pJxCuGkCEhrsgNUoA13BNpkGB6MfoqSIVsQv7FD3s8ylstDPKbA4ggNED6H1YykR3gAuBIjm9EivRzAvJlt1rl+fwy85K3ebAUsBWw20jpIKKQ7govrnPXIJSKS33lmW3/KmHVId3wOPvFNXgTf6rY5BUnFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691336; c=relaxed/simple;
	bh=Fk0f9NBKXxCuSGCMO1qvLKZJT4FJuEzHm/StoATrZJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9uTtqGkDqnNgzlQt/8IImkHixXeG+SCY2Cthzr/tQ6M+7472MpGLfh6uhVOHZMGetJoLHIMkjeJQ0XvyN9sDMU/8TPi2F4ZstPVaM9R+oMuPjPHuD2cHL6mfRleXCejLMKD7zn17CX7IacCRrM+7aMLJofkDkbV3vI5DTdgt0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+oIkwmj; arc=pass smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-476a130c138so1237557f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 06:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783691331; cv=none;
        d=google.com; s=arc-20260327;
        b=sYzu6p+JkkRmKs8e2Df9Hd9i5imL5EUmngS2jR4DFNRN9kcPrbHwJy9Lo3JJqvXYyG
         omOKUAsdpubBZRk3Dckc2WUxvYSp9VWIZ9OEfOTdQFvTJJOFp7EtZrZiNQlmsHDMGFHv
         K4/XWftkp6PQkB4aIll8Kqs1ooYIA0fIUoJWXtOsjF1evlDLoadYxDUhZlVCFh6WWgfg
         EItyw6tMdVUB7LITLFse2QeKlA/r45RGmHaC4yJmGudBtc7ZzzunQaNwVYI8SSVgCkxK
         Ye1ISL++2M9+L01ys5YKNqh6MZFGjaWpfGFOwuUe0sdKadL12mDPvoMNqfHKgujm10Cp
         6hXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fk0f9NBKXxCuSGCMO1qvLKZJT4FJuEzHm/StoATrZJI=;
        fh=LhiquMkHX23ymoeqrhlhRws47WCbnobWGq9OyF0UqEg=;
        b=gcTiQuQ+2spU67tpoRfakGpt4EKnBVggsM6IL+Bwro6M00y+fEhIeUBNax4xefAm8d
         0eR8/m/dIJ3fypl1IHKo1GEvLfzCXB0QJRmVPZPgvBtmKzhKPRt0BK1cn4uBkDXXk7Mf
         2Zg2uHNvDJYpEjQ/ybYcksD3xAW59ShwopqztyMo87okBPQsVRyOKpq+MfGcwqvtkYX3
         cy0zP1mPKxzNuzGqtwLijmfjbxYl8r+Ajus4upl1B1hxSCf2z8WFwE1ZBBJkvD9EshOd
         fSTrwQdMiFIykmFxJe4mCD+Abe0hvazEQkTksMm+sRS64IglyJzrcF3QwI6KEE2dYfLQ
         TuBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783691331; x=1784296131; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fk0f9NBKXxCuSGCMO1qvLKZJT4FJuEzHm/StoATrZJI=;
        b=b+oIkwmjLj7a5hRzrCUuxCMMHLbxBW5HaKP0UomN3bvFas9o8h1frzJOXv6fyVQ3v0
         YH7NVZJxaGMamMAaBXNt/46HH01b/m91bKSA5ir7t5pxGMjzm/dQkgh7zbX3qUX/uIKj
         R7i1hGugziHUBLXyd0nCCmLHljZRP62xLYcSeET8KGvLfSXSQAEnQWjqqT1ynDgdqiFd
         tngBGlCno0vTUA2/5cjX9OiM3UKtrTsF44xWm8lNeQviz1u2oTStEXnj7OoT+KYq6yqe
         AE7b28MfOg/TkQu7gXFdxz6zCcSaPvWWar2n6SqonKhgqFhWbjhrbsBDm9QObJQ7z878
         p6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691331; x=1784296131;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fk0f9NBKXxCuSGCMO1qvLKZJT4FJuEzHm/StoATrZJI=;
        b=h+JjKQcppZQ1UsOKkpz7zFh4g3GbcDnI8rEalYu7sE6cRAt2z6hNfuXWCp/FWue2ut
         NLeAA+oM90498n9EBXKCX86WpUua4EX8se1lW2lm2hySOC33Jp2sGsSDX4/dMd5FOfqz
         r6JkjXKuk4HtJjZS8QwP1cqycXTxttWrv5v6MandwMQBteR/Iln3cXwFFdumJAdi/3zr
         QfETj4OmK6KEmYzASSXBMJAFqcLER4WiOKsQDAz7jbbqWMqz6+p7iTWnKPn8/TtGAN3l
         YZ1u+h96loH7pfYvq0A4hPRAxm+0C7baCJMAD0BvS0vCGUn39CDy5KhUUG7Nahk8VWbT
         ZwPw==
X-Forwarded-Encrypted: i=1; AHgh+Rra8YE2HtXewW97Y6soAGbjKueuqxiVywaHLtQPTQQZhRqUOTcvQkjR1A/8U5RpLwvp7MH9rGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjiIVizrVWSNwfEkw3GUB0S1yvExsXL+SwM/jSLZgjx27wgirf
	pKblpYKlZFBWns0GGWqbXtGDlAibhdhA0gYiAbybb1eyvdj2R0DHpZzT0QxPzhs5FplebCLQIPz
	GqPdJfk/MHBityYudkrRw4hI3rVjgbLE=
X-Gm-Gg: AfdE7cl7BkoyyZ3J3JhdXSpLUdy8r3U89ATAhc6gS4Z+0fmaSiqtdCFFanFfroX3xVv
	i+iIMLk57Zqb8+CDmzNhN7lRKioeT5JmLVL0C/cVggWY5PvoE/Lty61C1qwfPHNOgTUQ2lMoZqX
	rGPGMHeSy/YlxAwSOu/xiyo/VhIzWJw+5g8wC55CiKRznw+JeQtukowkYo9Q3GIrxEbVj/0uI5F
	F7wed6gtN8dyTaW8MKvwmjLsm/62E6uTH/zrhpOzVFFR8I2bCe79jTd1Qr1kwdC4hY1yuVKd2aI
	5AeDJasKBM+Efgevguk+otaQgGI=
X-Received: by 2002:a05:6000:2007:b0:46d:1433:77ec with SMTP id
 ffacd0b85a97d-47df071567emr12423202f8f.2.1783691330567; Fri, 10 Jul 2026
 06:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704080653.33740-1-atharvapotdar07@gmail.com> <20260709170151.1577992-2-horms@kernel.org>
In-Reply-To: <20260709170151.1577992-2-horms@kernel.org>
From: Atharva Potdar <atharvapotdar07@gmail.com>
Date: Fri, 10 Jul 2026 19:18:38 +0530
X-Gm-Features: AUfX_mzij9uJi1NxmBfsvdi5VakX6iKjRv_IWy3odvl-DmkRIpln3GBpi1sb15A
Message-ID: <CAF9AHvZe5sgmpZQ+Jb4s_h0NCnUdmMVODpbDhF3O213uWqTZhQ@mail.gmail.com>
Subject: Re: [PATCH v4] r8169: migrate Rx path to page_pool, prepare for XDP
To: Simon Horman <horms@kernel.org>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	romieu@fr.zoreil.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306578-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,fr.zoreil.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[atharvapotdar07@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:romieu@fr.zoreil.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvapotdar07@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B41B873B898

Hi Simon,

Thanks for the review. v5 addresses all three points:

- Introduced tp->rx_buf_sz to fix the DMA overflow and skb_put() panic.
- Fixed rtl8169_rx_clear() to iterate all NUM_RX_DESC entries.
- Fixed rtl_reset_work() to repopulate NULL slots before re-arming.

Will send v5 as a new thread.

Atharva

