Return-Path: <netdev+bounces-280131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHreFo9/52ku9gEAu9opvQ
	(envelope-from <netdev+bounces-280131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:45:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B80DD43B7AC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D70323028EC8
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BAD3D75B8;
	Tue, 21 Apr 2026 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="cClBgcUC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5EA3D6CDD
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779109; cv=none; b=hIphvKEQKQqMumvHUpHE6gCF59bN/kyTMKjQphm7dztdFeSeiabF5eZsinbWCBg25Mys3U8ODzYXnJG5hUBD0mmQDz79b/aXoy6F5blB2R0eWwU+sxqLgBNbcY63ySRNjGUnLKqE82No49k30P4LJ5bYuGzgHeQG8ScQRfc5ntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779109; c=relaxed/simple;
	bh=bksQ0Ol5sH++UgZ7eh1JZKghAgg2lGd7XkvUWodW28Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZvHKDLC3SFiTYQJxDdd2RjAyLjfaoLoS6vbaL6tY24sLA3VbJiFIPkqTFieJiagF5i39Qgr9c6gX5KuskSpQ3AbiEJw0bcWD4r8RFCLTh0VS7dFJ1FT91cP+17g+IBmL5BbXG/9mEaFyIWfr4ihAnKP2uxp0Li6Y0LeQDTiaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=cClBgcUC; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c45281a06so5567249c88.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776779106; x=1777383906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2J0baGW2c8ot7ZAwlVMoVMOKmtoMvPmfiKlkz6ZsUc=;
        b=cClBgcUC24FdpKU2JnH4Pa8ghonAWun66lvlqsMc0TS6SM3qmynBXdFhPo3KpyVpL3
         DKjBYtxguUkFOqMANugRC3jAVyxb1ZX6dIcyw6hwUjpTwr1XE7gW3u5T4G0BSoU/31g9
         voXRPi2wMK0NpJqP4ugLXin628LoKtljsRGv2qYTQYKQ6RgT80/ydejV1z85/MIC+w+h
         lnDc+oJqG4bbglJfzOb+2uxxrAF0hOKL+mnm99VJMHoiInwmUg1N6YN+idWC2RW0UxMd
         SofU7/kyVRijZ8CC5mVA4YW0PPNBSr1Z3vkxdLcRafiF67aAhqK1yY1Iz+bZuYcc2sdm
         Pmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779106; x=1777383906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2J0baGW2c8ot7ZAwlVMoVMOKmtoMvPmfiKlkz6ZsUc=;
        b=LBQCWvEp240ckSDNoThOeZ08Ub1L5QZ58nSz4/UzMIvkEl8ABtLdZJSS3zLu+QS6nd
         Q/ff7dRPXCCW2SxOVT+3RiUJY+1zjJBfX8c9ygB/F+wuiUTDcy4FauB3rNrpaFU9zbsW
         a37m9HUflDoUBJblxQ3kCtlKw851ikxv6fffh0YFTmf0r5iXbfc+WJFUjPouWkRIHfaw
         kVMev+Ay0iHymmUshIpKTUSOSgDGi9kWAK+iTrqc4oZuqehzz52pFO4vjl8WqEMp8POU
         sqkG6TBaUVjk+lwet2eJxL/lVYpsV00PxrlFFk1pWA5Kx4j+2tfqmgB6NSYo2qQHVILO
         7byQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5G7JHVNlK42HlYG5xi844At4jznwnsPNI1YPXADU6qu2kKBNnmSW2x0SM4m8UJlP8qZ8Rc3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxgoA1q6WbVWU3+kmhu6J2H6HMkJicl8pD/v8xrJflvHDOmRz
	Ph1piXOYsO4CilHdRx3fMw5lr3urLN4ebFyIKCgSa1GjnRaC13b8oMLx137NTLJAG0A=
X-Gm-Gg: AeBDievbunGcFstEWthUEiMBN+GxbgENgaYT+jh8LtaKCzQrts3iEWqKzwUWi9PwSip
	G9jFwFsKETsYCZgoDgmi3LuWvfAL7vkUqRUTi3/cRw9Uv3UCaUYfEy5hFFw6ZCBp5OgT9KnvVgm
	Oi3VAep9eiv0jhJpU2ZgWIseYtvaB2uFG5HTKK1xj2c5Oxyp9l1iwQKEuAqoRRdz6GPNm8WcouG
	hj7VSjNZXUxmm7NVaFWrOFQesT7i+celf2ESGH7efdbQWbQJ0g6ZHBEUQsEv37Trm9/776Xy5a0
	G7xsX+6yxOs0m7vaZ7s7kCyali+kqadkz4YvyLfBCxrZvZ+dvCM2QWU1GS2mRMPi55cMdvKcGu/
	3JpDKIH8fZFgXtxAFsOWPL2pmT9dJ/M5Eiba9uRBxZ9MYejCxNzGZfd+sHEnM3NfBrRp9K6iwFx
	sQ/xu5nT1QD2lDjzwQVuR505QNBj+xTOr8PdXRO18jtsMujA==
X-Received: by 2002:a05:693c:2b15:b0:2c1:3f85:747 with SMTP id 5a478bee46e88-2e47a1027d4mr10807993eec.21.1776779106079;
        Tue, 21 Apr 2026 06:45:06 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm19250116eec.28.2026.04.21.06.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:45:05 -0700 (PDT)
Date: Tue, 21 Apr 2026 06:45:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, federico.vaga@vaga.pv.it,
 carlos.bilbao@kernel.org, avadhut.naik@amd.com, alexs@kernel.org,
 si.yanteng@linux.dev, dzm91@hust.edu.cn, 2023002089@link.tyut.edu.cn,
 tsbogend@alpha.franken.de, dsahern@kernel.org, jani.nikula@intel.com,
 mchehab+huawei@kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, tytso@mit.edu, herbert@gondor.apana.org.au,
 ebiggers@kernel.org, johannes.berg@intel.com, geert@linux-m68k.org,
 pablo@netfilter.org, tglx@kernel.org, mashiro.chen@mailbox.org,
 mingo@kernel.org, dqfext@gmail.com, jreuter@yaina.de, sdf@fomichev.me,
 pkshih@realtek.com, enelsonmoore@gmail.com, mkl@pengutronix.de,
 toke@toke.dk, kees@kernel.org, crossd@gmail.com, jlayton@kernel.org,
 wangliang74@huawei.com, aha310510@gmail.com, takamitz@amazon.co.jp,
 kuniyu@google.com, linux-doc@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
Message-ID: <20260421064501.4d71b943@phoenix.local>
In-Reply-To: <20260421021824.1293976-1-kuba@kernel.org>
References: <20260421021824.1293976-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280131-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,linuxfoundation.org,vaga.pv.it,amd.com,linux.dev,hust.edu.cn,link.tyut.edu.cn,alpha.franken.de,intel.com,mit.edu,gondor.apana.org.au,linux-m68k.org,netfilter.org,mailbox.org,gmail.com,yaina.de,fomichev.me,realtek.com,pengutronix.de,toke.dk,huawei.com,amazon.co.jp];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B80DD43B7AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 19:18:23 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Remove the amateur radio (AX.25, NET/ROM, ROSE) protocol implementation
> and all associated hamradio device drivers from the kernel tree.
> This set of protocols has long been a huge bug/syzbot magnet,
> and since nobody stepped up to help us deal with the influx
> of the AI-generated bug reports we need to move it out of tree
> to protect our sanity.
> 
> The code is moved to an out-of-tree repo:
> https://github.com/linux-netdev/mod-orphan
> if it's cleaned up and reworked there we can accept it back.
> 
> Minimal stub headers are kept for include/net/ax25.h (AX25_P_IP,
> AX25_ADDR_LEN, ax25_address) and include/net/rose.h (ROSE_ADDR_LEN)
> so that the conditional integration code in arp.c and tun.c continues
> to compile and work when the out-of-tree modules are loaded.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

PS: once this is merged will remove these protos from iproute2 as well

