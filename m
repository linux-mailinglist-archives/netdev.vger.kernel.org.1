Return-Path: <netdev+bounces-280255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA7xCoDu52mhCwIAu9opvQ
	(envelope-from <netdev+bounces-280255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 23:39:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9112043FCB3
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 23:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B73143002280
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344C43DD512;
	Tue, 21 Apr 2026 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Y2nYGQeH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E531939EF39
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807522; cv=pass; b=djPeCMSNsyUUkb3C9DXQiuUb1AWwGDkqEgAyfJtriiyx0RvT2dgwE8HZaJTXg0VbU82qIlME3JINaLAvXYQcP3yv2zQIn8b+kqpHeSBnPtfuO8TjXoLkmy686OY/RuuTImARDCUl90KyDDSXQ8d07078wBLzTT7Ys2G0G2QoCrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807522; c=relaxed/simple;
	bh=4H5MfuuLuxO52z3NVtk26UIyVBH5568btUcTZQrH1rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZRdZY7ZT/p7HSuSkn8Xpcy5P4EUNoXFr6UwU6FxuRXYn6gn1SX/YKwUNh1taRXQU9d1ZgviBKFXsgWgOCLXBuwl4ajzIIok+NdUL8XCC/kJRvWMaau4UEuw401sW6zB3H3cCM4NrNWN014vZKKqUfUwBQhhaYjp9cSpbVlE9xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=Y2nYGQeH; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-794719afcd4so50618597b3.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776807520; cv=none;
        d=google.com; s=arc-20240605;
        b=WK1NvUfPxAcIWrUDkvqNnFyDSQL6srKotJNKr2cH1QgXkKOi/UFjlsogIL5057OE2i
         657Jb3+fa99lBRvPwZCaRPJoJL2YgDJgG9Q4OoTphhuxHfncimhmyym/N06b8hvcZu+G
         5Tgc90UM8ZN+K7VlgcWSmXSVGUxKhBiiiNCm9vrs+VRl7d8MaxVS3NPxTMfMYTDjAgvO
         xZfkJDodQSRhMDVpL2AnDOtl0usfek612yCslxkO9/767jEWtqw6MpkvOVC6CQgxXKSv
         eRfZ7HBOdvKuXs4SHinHpelOTVNDrhV9upsZkLQZ0zjNx3mx+dmrZmfw0blN5rBj6fH7
         rfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4H5MfuuLuxO52z3NVtk26UIyVBH5568btUcTZQrH1rs=;
        fh=c9cZZo9F5KSJVNJk7ewloQve9SgvEfnLqu/jKKIW23I=;
        b=dmj68accQnU6b/7HDavOL4/yVVT1KaW8kOiWCbsvm+PDXWrJqIBHWwrMF5+159ANt8
         PyHEG0EtdyAYcxvqYIh+QSGMhJmN9lSSvuAfNhN754wpONazfQ47QUWoRMRjsFdACl+k
         vzPj/Jj+qXHlVWy0cyR6L9MdafTtlV9JSaI91ftZXeiJ5McpffmlGDvQyE/xb44DBi7S
         DE8efwehi/3fTiKkSPiIxOXMEntHR1Y6aW4U+e7tDBQWi4OrmpxkgePWYTrzJLOJxeQW
         Ftf3D/KGdATVGiJ/YfmQtRCH+Thg9oJZ5M+5vFH7wbp5Oh2tGPH2d7+oHo0p4rERvIKi
         D8ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1776807520; x=1777412320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4H5MfuuLuxO52z3NVtk26UIyVBH5568btUcTZQrH1rs=;
        b=Y2nYGQeH+SaPkHMR5sRtnnMnGi6TRbq+VzFvFbvyRn3m3urD9mTRrnFYlEzaES1TO9
         ggSwqV0hWp/Tn64oQtKJKo0p+Dp00SB3Y/x8jy4cqTNcMjX9tfHHJk3uz1/EhLjU0RC/
         Q7Ly5Cks9VqnUQN/uKLoyW9TVWo/IFYx9x1+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776807520; x=1777412320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4H5MfuuLuxO52z3NVtk26UIyVBH5568btUcTZQrH1rs=;
        b=tWaPg05i2rXPfleDfwspOiSJ0Tpgv13/AAhCAssqcej9Q9WFl60RqKsIOd+3aiG2nM
         ixV902Ii5fwSrpBwUcmBLIA16WfIpC2O5Su6R5ZvGDpKUBeFBiw1ZmhRPBhDDDdcBAhH
         VVZvdnDoFTLtxHLlmkh4GWNy5zPzUtDfA42OHQqJc2awF6cWbcs9T5HfmyerJQqJuF0G
         smuwO4Yja3dor9H/Ga/SaL5PVWPHORLs0Bt+fsmAr1PkGerbCu9FkqRtAtG5kKCcsRwQ
         Ab708/dTXjqy+aVo1/nOtwbnThoM2YsT6ib792PIHN0f2odKnxm90H1DqlduzSGX8kK+
         BvNw==
X-Forwarded-Encrypted: i=1; AFNElJ+rtuiwaI7NEx7fqgplOMfWzs5Mvj2OZ+qtNjKJ6Gx58R29GSKIf1Wuw3sG0FqKbS0mVZQaNEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM97sDjKhIfHxpFMh1ize9d1/5puJwim5h2TPmeCbPCgb7wJXK
	mg8kcbBEcx9p9KdV5vh7FsAUqUdjgOw2FT5Ytf9MiITnoVwVFxol1qjlxD8wBEbsNbuHA4urKku
	Eqk9kApPkpVBYVXzL6LRcAvlmk/VhgcPuAtz5XT7lDQ==
X-Gm-Gg: AeBDieuLmGY8QSm5SzWdo/CNkYf+XY8HyrrCnH6M904WPRPiJtNhWgcMcweeUCncIny
	AS3Rf15RztwY1bvkF1Jdz2Uw5kijvcpbVKFO3V/JudZhZv1yq9rPLR3Hgq1wQxu2/qGqKuNluTA
	/j7bb5UffYwOslPrNTyHbQMKx2zB7MD5Kv5FWfUkIP4PGk56AowcqKC958p4Hvtk5kzqhPMtqqn
	wYjmGBxX/GFJ3PemugUwjMuajmK57VMfxW95BCWfFbdzn7Q5XX9sw6AC+78rbOT1VqvJTAc3cps
	8zHl0f8HwGSuzATv2Frhd6V40zRT+1sVhqD6RtVVnjPQ2Z1ZcqLHXT6GlBGA4Q==
X-Received: by 2002:a05:690c:34c9:b0:79b:73dc:d30b with SMTP id
 00721157ae682-7b9ece5abc2mr183704767b3.8.1776807520008; Tue, 21 Apr 2026
 14:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
 <20260421-v7-0-0-net-next-driver-removal-v1-v1-6-69517c689d1f@lunn.ch>
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-6-69517c689d1f@lunn.ch>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 22 Apr 2026 06:38:28 +0900
X-Gm-Features: AQROBzAja3cUhpE_F5KhNE5qp_Vgfi7Dt81CqKo5JPKodn_l_SaymiCTWpB-riM
Message-ID: <CAFr9PXk=3md2oVDqFbmQLNiVMkRr32pHMPNSeskdTpM-1huB=A@mail.gmail.com>
Subject: Re: [PATCH net 06/18] drivers: net: amd: Remove hplance and mvme147
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[0x0f.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0x0f.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280255-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@0x0f.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[0x0f.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0x0f.com:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: 9112043FCB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

On Wed, 22 Apr 2026 at 04:39, Andrew Lunn <andrew@lunn.ch> wrote:
>
> These drivers use the 7990 core with wrappers for the HP300 and
> Motorola MVME147 SBC circa 1998. It is unlikely they are used with a
> modern kernel.

I have an MVME147 blinking away running mainline using the mvme147 driver.
I think some of these need to be CC'd to the specific arch lists so
the few people using them get a chance to pipe up.
I think I'm the last person to have touched the mvme147, I don't mind
being a maintainer for it.

Cheers,

Daniel

