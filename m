Return-Path: <netdev+bounces-256211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEpfDrO7gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:11:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0D2D69EB
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E45283023032
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11692396B8E;
	Tue,  3 Feb 2026 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrpWvaUQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41D396B76
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109871; cv=none; b=Bn1PcRrNLUpMAOy1su2ydr1J98zurwDOofOEHZXDTkvZURHwhJFYXB1tUNOe04gA0KrqhzPl/VYpc9tx9SYjLF6CdVKaND6ihE37WWb82niRIgjIt64k3yPKX467QG/9V+rHbjomf9DBHyoOGVaeOYmA3Dk4DEJecXm4A957JYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109871; c=relaxed/simple;
	bh=cfdU1kSo8gBSVmXxXxV+VeJp31P0ZwNjDc7NslD7Etg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=R0Atur1RdsW2DfEvG1e8N5NHzfmgJdxEoQE9N+MAhSL/4ptmVEBOg9Vf0FEruDp46rnUDIYFIMnWBHbD3/uoV03f+BPFzLvVClQmUzT/lHDxFoTKSQQgrTE4nqLiBpWnTfkmLASaXXe6lBqXCr45CH9nGQM4GzF5+EfC8vvZnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrpWvaUQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-658b7d13f09so9713318a12.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 01:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770109868; x=1770714668; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfdU1kSo8gBSVmXxXxV+VeJp31P0ZwNjDc7NslD7Etg=;
        b=NrpWvaUQ7ZMI9gIow61dAaW4Ip7by6kXP9mns53l8SYTiJpJ3xRC2CVHYNWuWBVT/q
         8Qj0/oyvoqt+/2w1AeAvmQQRce2E5PXsJThn5RI+Olwo7VvXwmclR85KRq3oIoxWbduf
         f/3IJxns7vWqYy8JK30LrO4dgubIGk7vV9q/yELstasx9PvdVN0XSFVEUjen2rS26eXG
         rXlLJq4zCzUTshwIcOEQRuGlORLqIkwubzL7CgegZFFrF1HR1M2pXtWyIZ7eBYkSTzBs
         PxD1Kv1GAcl4fehwcAERT1BEsC+yQWzoXae/tbNJbU5g7+QVfOrL1FetJiaaxdbJwsjS
         RL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109868; x=1770714668;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cfdU1kSo8gBSVmXxXxV+VeJp31P0ZwNjDc7NslD7Etg=;
        b=akZW3QOObRrlVqYKLXBEumiE65sOnof+fISmr1QFo3gM+qt8pfvq74G9Gg7kCM4G4r
         KFWG+i5x8MUsvgE4NRjOik74D2P5/QD5kLHY+Lk79/3jkHJXTLmkeTTFAPKBgLNow/Pc
         Bi+wf8W00BWVrpyZXQ7ht8cLjtaRRBZQRc7OOx52wE4KXvgPg/BjLmmDFFvd6EZ/sw2h
         br7gLfOCmOIYFFFth8yv26eZJN6nwTrL/3WFfa6S1w9rLil6OsxCVYlgXvea5GIA3Vo1
         Mk/nJX0wzdce8jrvuN6rcgNsH4gocTABWiUrzVEhDm5svc+7B/YM6CgT/w9Nt12/djK0
         VHHA==
X-Forwarded-Encrypted: i=1; AJvYcCWYuivp3McAJoD94cbdI/XbBD5oO8fnE/RtmdRsvH2JeMlLe/oSqIMAsh8i8zeza+PuWdd3PvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmZxjoUrN3i+w/B2q4seUY/NIQxOAfEkSLoeodQYxXKPvZlou
	pZ8sYPEMq3pAc35h254DSRtLRsrx2MspS4LvmYp8Zd+GVSTRm4nVcGDw
X-Gm-Gg: AZuq6aKfCffoXBMbDct40hosMO5sYJAfAGk6tMgDQ6RAfp+3lo9i+GUNLPTnz9nuA7I
	2LKCU9j8nOSro4LBHCYLkCDPzVNut9VBQUtkXAyDW7Q5xLZ2DzFfTzOprkgrhbqi4rZYZ7Adymi
	wIrAkFC2F2rxFa+UZ+f82yZa0xd0giRcprtSyT0/2W4rB/CG8PmA5/UVrVyKMuqK2q/tw+rxAK8
	2q50g53Yrhav9MKkT49QhYI/z3ZZOBJdZrp0Nphgk+pkNTNEClB3D6Wv4PP/kYC23VqNtVoVM42
	7ypiALFMfRjtKwAiz2C65C/mpzP9Tpz9dL+bAD/Q+cHNmw5UiaR4mRho9xeZt7IRJrMJ/tJH7qv
	ZU2q4wQdT8WBFfCoKBNeJjRwCEXhvYh1BPz5Oh/sWGDyoABgnYfHTwKpbOaBc+vcMWeL0qvuUKi
	bCYUTzhX2FW1FgcTAgLhPKzpQ=
X-Received: by 2002:a05:6402:50cd:b0:64d:2082:d027 with SMTP id 4fb4d7f45d1cf-658de5a2f83mr7948742a12.29.1770109867713;
        Tue, 03 Feb 2026 01:11:07 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:c42b:3329:fccc:c347])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b42563dbsm9307740a12.3.2026.02.03.01.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:11:07 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,  Pablo Neira
 Ayuso <pablo@netfilter.org>,  Florian Westphal <fw@strlen.de>,  Phil
 Sutter <phil@nwl.cc>,  netfilter-devel@vger.kernel.org,
  coreteam@netfilter.org
Subject: Re: [PATCH net-next v7 2/5] doc/netlink: nftables: Add definitions
In-Reply-To: <20260202093928.742879-3-one-d-wide@protonmail.com>
Date: Tue, 03 Feb 2026 09:04:05 +0000
Message-ID: <m2jywu9p16.fsf@gmail.com>
References: <20260202093928.742879-1-one-d-wide@protonmail.com>
	<20260202093928.742879-3-one-d-wide@protonmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-256211-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC0D2D69EB
X-Rspamd-Action: no action

"Remy D. Farley" <one-d-wide@protonmail.com> writes:

> New enums/flags:
> - payload-base
> - range-ops
> - registers
> - numgen-types
> - log-level
> - log-flags
>
> Added missing enumerations:
> - bitwise-ops
>
> Annotated doc comment or associated enum:
> - bitwise-ops
>
> Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

