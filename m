Return-Path: <netdev+bounces-284182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wyQ3B+9a+WlR8AIAu9opvQ
	(envelope-from <netdev+bounces-284182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:50:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA14C6130
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34FCF301B4C3
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECDA3563FA;
	Tue,  5 May 2026 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU90zOmT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3827279355
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777949420; cv=pass; b=F/LlaUoeY9Ef1mLVLf9pzabHjaFgVN1szu9B9j5tiIuSXPY+MCgNNu90mpszHQn3xqlPM8HWdEfrUlSuQI5xDZe3a6sXDCZXVZvPlRIkLD9Pb7uA2HXWJ49wAQcsbaee9tGqPtKi1Ghv0o/n2teRujCQK01CBcHKCIeo/lIS8MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777949420; c=relaxed/simple;
	bh=siAAmbXrlBIkzRyVF3Zz7pGHlxgaLhwbozNP74z/0q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtjvVtAdzCnyyl+dVe0TKVkeRFYNTX1qwANUE2vFAalDKI+6JYotR6FwpIQQLwNyIJ2/dT+5Vo+/B2aRL/rKkkFP5rKUKptAf3M8JuLdeXkRyYurZiWU32Ryq0sRbfaBEkox24N0xG9XdHMYogdYbME/B81SHJA5JzoFecVjWh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU90zOmT; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6948fb494a0so2655306eaf.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 19:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777949418; cv=none;
        d=google.com; s=arc-20240605;
        b=Y1QyTKxPFhWq5mLn5g76lvnilE7/Rj2P2zDhC5ORZf0MrQsMdwskJhBPc5M4fIwLQb
         ycCtM9yrZqrgrLYpnnnLRwQPpaoSuDcY8O7gawibP6rmgSUEvoitMrF3yWJfztRYYkpE
         RIBPMnzqbK0LPN50lljNa3Rpkf3R9RGujUPMim+9SKa+jJYa5gkNjTyJQLhUiTkJu1E2
         OtjBBH1Tan7anEp2aroJwzLIJAYpjuCyPr+EkOdonePG74NL4rm+0dwcZz9NF3NMB0Pv
         DkJkySyBPnMLwQM2OVLuiMqrSNELzpBSNaiIqCwTMUt9w79NCBct2VKowGycrxD8/eky
         b/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H4hpcs7pkmf+t4XcyqdqOFCJINDa9QTRi94Gcvphr10=;
        fh=Xbmr0kqdAE76biESqIlJ+LYlT6X+VvV2MGw98sWjUsY=;
        b=Xj+psvv4V1zmIb6FJBywTTBRlVio4yqXfOEHKlmlVcEDA/shLHtU7Ooeub8n5PlspK
         UvZV6hLQVQfiRXxkJkcUGWxW8yUgLl+SVHU1V4KtQ1vUjt0N5O6qNi2R9DmtxTHj4iZS
         yO9U/B8aN09e2170hvgctxyfyS/0LRkIgwa+VmNZpJO3/zhRhx6V91HXPsqaqqaWtyrH
         TzRIAx91e0y/YQtUR2+mQPigxCVuW6gshZyXGk/nr8QzNpdZHtOoxD5tFhf++tM3mmUS
         bUWtjiG4yht3uYa+4FjLVr1rotYXrVqnUsrkx8z68WJ4nAAr8BzXm4NdoB+vy0xZVn/1
         fDoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777949418; x=1778554218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H4hpcs7pkmf+t4XcyqdqOFCJINDa9QTRi94Gcvphr10=;
        b=eU90zOmT44A7D80lLnaq6bODYWzaMEQBW3GKPiICEhUJ1oPV2slhjHcRrkrhF36bRf
         0+tOGh5ZzPzOfnXpBnpncbd1qr72pzPjqbtOF9LGBoaIrB2vShVaL3elB0xAx5ILBe1t
         rlR30IZnCrQc/gsdIk0RQcG2G1F7eDQKUPwySbLt31TavlilYaOGSheEBxgwdY4+eYAt
         knpTPqcBUVzj1xTY8V84DEH9sECdqvU7TZf/dtxW3zuzc0jcsrkOkJI/sWW4YsL0m8Qg
         IB3SWQhwlNpxp9TTBVN+vlKlJY0E6e1FWK1AYrQWbTViH2xv+7I88cqk7Rg9Bh2pTYX2
         8rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777949418; x=1778554218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4hpcs7pkmf+t4XcyqdqOFCJINDa9QTRi94Gcvphr10=;
        b=BF+K4MfbkmkwJHGImaPFWK5Ue1bESmQPhccLscNOdfIKCNM8k8kpx1fnx6//tlF9dx
         gA2H5fP3jls2eDD8qbKmebwg5UdsY0oY8j14kdJyuk2LTyM1dktJSiDl1y9sjrs/eKFO
         3HCKkYDw8+wlv3TE9gOfxun1ZE4GrAnbGZCYCCy3GWl+r+pSfysb/6fksbmxkEfCtF6H
         xp8siyobrCHF1a8xrmcDaSRGcF0MfFcBTfWVr66UAbg9BBUtuGM2oAR3NPSm1QaQOhQD
         Bad+Nm1rfHEizIBrlrZzXazruppFQ0uuzbedz5EyOj+PNU8SMjuiCT44df1nrD5jfsDs
         bP6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/er+WR2OUIr5yUH+MExd9TpRp2x6kpt0AfRPxOzO3BP6WyHWqeAKIC3gjMdgkGmWAGhT7acVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5cg82iiYja3jpGUtWs5y6MZkZq2czlms/HW0+kMBKGE5kYUA
	cd8jTlpG6+hIlNVPLoTsS4avWllJDNaVkFRirz/HAjvaMBIw/uiBYMaxo7OgzxQqrWgyjVDsfP5
	FokzLWFZ/gjqAg4+ln3mrn68Bv5uAluw=
X-Gm-Gg: AeBDievhXQParbbI5WVcy6E7qTJXRAj+Q+SP9ypH7Pt3VGKGQ6pyx0LXym9aKhxf04S
	xgMuMt3J8bR9v/IfTjRAoYQQvbw/FShP4bpMnr4l17s/q7HSvmfVfeJZOEtIwI0iCqS8OVHu9k2
	2WyOdovyVIyckRqxRflrDI6Ck17qKueIGGrkB+/TTrqBqYFfSHrEYLasvTyaDTVKVApryns9q4y
	wEjQFR+151l3l/h9FWZfKgRDYzL/T6W/tBnvhqkpj9G/GeN0Tghf3XnZd6uzEjApfOI2D3tDfuq
	A8vSaoOfeKhsk74=
X-Received: by 2002:a05:6820:4df7:b0:696:8e8b:20b7 with SMTP id
 006d021491bc7-6998a5cf63fmr574150eaf.22.1777949417804; Mon, 04 May 2026
 19:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504152712.76305-1-h3xrabbit@gmail.com> <afje62FxYMuTUpSb@v4bel>
 <afjpqNXYFVfZjQl5@secunet.com> <afjrqlBPSv0X9kaY@v4bel>
In-Reply-To: <afjrqlBPSv0X9kaY@v4bel>
From: Hex Rabbit <h3xrabbit@gmail.com>
Date: Tue, 5 May 2026 10:49:42 +0800
X-Gm-Features: AVHnY4I-pxDBbHXZYmw-CKdNZRe_x2mSceYQ-ZZtp1wyMxXpNISkCYXZpVFEdFI
Message-ID: <CAF3ZFefQM5Ud8iWDoKV9FPdZ=8V0KD56Bvkdcku1fmm6aaD_Cg@mail.gmail.com>
Subject: Re: [PATCH net v2] xfrm: esp: avoid in-place decrypt on shared skb frags
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6AAA14C6130
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284182-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[h3xrabbit@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]

Hi Hyunwoo, Steffen,

> The report and patch for this issue were already posted on
> the public netdev ML 6 days ago, i.e., the bug was already
> publicly reported:
>
>   https://lore.kernel.org/all/afLDKSvAvMwGh7Fy@v4bel/
>
> Credit for patch authorship is adequately covered by
> Signed-off-by alone. Setting aside that your work proceeded
> independently rather than as a review of my earlier
> submission, the trailer should conform to convention to
> avoid future misunderstanding.

For clarity, I also found and reported the issue independently to
security@kernel.org on the same day, with my own reproducer and
root-cause analysis. At that time I was not aware of your report or
patch; otherwise I would have referenced it earlier.

I am still not fully familiar with the exact kernel trailer convention
here, so I added both Reported-by tags because the reports were
independent.

Steffen, either trailer form is fine with me. If you decide to drop my
Reported-by because the patch already has my Signed-off-by, I have no
objection.

Thanks,
Kuan-Ting

