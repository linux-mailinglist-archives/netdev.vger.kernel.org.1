Return-Path: <netdev+bounces-267647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHLmFVantGlvrgAAu9opvQ
	(envelope-from <netdev+bounces-267647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:09:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AACC428AD7A
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A91D3014C37
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD88B23B638;
	Sat, 14 Mar 2026 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="eYWz5ZG3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2400C2135AD
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446993; cv=none; b=HTMPht8pRor3vyDztrXaEYayDp/e/+FqSPlil+4629mlagG2beiHFd9k4g+W21/CW4W9SGXLhiqPN92EYm+ZDyXOlh9s1ZVIcgbEhsBD60gctHALUgejJBmzRQARXzH0aG08U7yjUyyJ2vPAYxJm4eHXG99iccwDY27GyNXgDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446993; c=relaxed/simple;
	bh=+dGmrcuiiuuV1a5p0Ly1Q66s4c6kjuU3qUogVTsRx/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPP7oTRXAUMboQVuhutbK4Ba4SD8chdajVrjZbpop4fICcVf8razlaDDlFJWFYYZnIYPPemgeUwZtN2zTgpgr9MSHtW7H4JexcOm7mTSYhg4/MWF5NobibFIcnzrXgGA8qI0lVojWXXuGM3Bchd8TMki14mUuIU6Yu1OBpm90/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=eYWz5ZG3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35b88a4f123so109780a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773446988; x=1774051788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1K2wFHnPv60zEHnUhHNmA3kV7XBCekNFy/nqC8VtDo=;
        b=eYWz5ZG3SkHbmN6i0CtHOXl3IouV61rGqnaTjW5MT8crAImGqevzBKhYO4ZcwdyDIr
         IcpNvb9SO/zD+CCRaa2zLhWbuT6Ego4AfZ4KUw7rx/6w6gZ8rinweWwuqiDq0FDtD/Mw
         bEaX5UCRqRu9xuvFnHkxYSYLgE15WTgxtu3xpqLo6ouM8upLuhyDRFrMp3RdbJZSq9M3
         +IJBU7dvM1Jd1Cbk/LGJypj6R+UlGMZXjYPzj1xc96Zr+hpFc70v8pNHW3HjpxKrnh99
         iD0dkP2bD+DTm1tpZBvpNRzaEnD0tyDFWgCKIcmkCLDSnbUZk93S/0HvPFFyw+wK6Zbi
         SNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446988; x=1774051788;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1K2wFHnPv60zEHnUhHNmA3kV7XBCekNFy/nqC8VtDo=;
        b=JoMZUp28X0nlGTOVDcVFt2s2tUVwpdLDwouFj8TpvSSN5JPA6mtWddsToL3TIZbAae
         YWWw7mljBPb+hcoQf1VVoIJ1gf8lggmTkvB8KoF5xbUpwY5wecpKg4vAs1Gy71JJR2jc
         9h+qYixJR/sbU44wd+rEES4W2s3teYnVOo1phX0KVJUDp58zNMoLMkpmvdaJpFmV6V4/
         l8/uUZkstncMX3dth2kYzdXewI/nHLA2sdHufdYkUS/uiZvgQqfeQ1Vt3jQab3xkoCf/
         pRxKzVY5bWd22Npo9ZkUBAtjFVwn/gdNyRsxpe+v3IrCX5e9BiY+PYsjlWoVUE1nF90M
         /7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV5kxFxIT55RPzjlp8/D+LgkwWQo2oEq29CQfG89vh/8hQqUU2BmOiTAe0/X4WJo2oKGO0Lsyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJlht65mGEk2BKfqlVoNZQMsKAo7GHxCxs2ZZYA1tdpcWJLOf
	pVJU5f+jDOxSASbKL7bipa3q6G4dc94uthVCZEUadtI/H42MeVkS4PcEgBQhV7Mhb3M=
X-Gm-Gg: ATEYQzwKvJeesxhMctGuktHBgPn3E3yW+VBevf1r/DX5ki45WGZ2THbx6qV68sxhRzg
	IbgzZEyxQSM5i+tsKGSNNJ+eHrhFV/h+Np8sJXPeLQKKlsY68Q2gmONQjbh/WWGLt2FIWd68qs4
	jOYWo2zBzsh/ulSvz4Ezc5L8SC7b2MQnb8m5GYqEQc0uKWV+D4y1K7DT6Q045dpSphYiwGfSUCW
	PIR+26O7CReY5RpIgdneF2c1r1RhsZEeJ5ve8Lvv+xgJdkIcDFpRlrhAZZ4qeX4aBOYOXTsZGdp
	sWgZ1StpzPsD3480lgkwRCRt+xJ9qixIlngjB3gaP5+RFJH5q3+P39DPJp3/XyWtVWp6CdLLS2a
	9Jb2LRf2py2tn1m9nTCcCs/2GANPWrqf26DPVm5P3TakhgGurg1f0kCfSpvZAIdtdP9LBo6CU2O
	dFx++a
X-Received: by 2002:a17:90b:4ace:b0:359:8ca0:308d with SMTP id 98e67ed59e1d1-35a22053554mr4077220a91.14.1773446988255;
        Fri, 13 Mar 2026 17:09:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359fe40bed5sm10347528a91.5.2026.03.13.17.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:09:47 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:09:46 -0700
From: Joe Damato <joe@dama.to>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next] net: enetc: remove stray semicolon
Message-ID: <abSnSjp7cIj/qWGG@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Wei Fang <wei.fang@nxp.com>,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
References: <20260313112454.427191-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313112454.427191-1-wei.fang@nxp.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267647-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: AACC428AD7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 07:24:54PM +0800, Wei Fang wrote:
> Remove stray semicolon from ntmp_table_name().
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/ntmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Hm, I'm not sure, but I suspect this might be rejected due to the note about
cleanup in the docs, which generally seems to discourage this sort of thing:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches

