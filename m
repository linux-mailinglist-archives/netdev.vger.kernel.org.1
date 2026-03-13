Return-Path: <netdev+bounces-267254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BasXOWxls2mVVwAAu9opvQ
	(envelope-from <netdev+bounces-267254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:16:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B127C32C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1B4C30131D5
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A3530DD2A;
	Fri, 13 Mar 2026 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbDVFGue"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF715665C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773364583; cv=pass; b=d7cOTlz+IlQqVwkQguR0vQY8LZ2tOuz93ZGso7aNQMbSJzD6LrkTy09fBAy9gGvxxCzhxtBWJWW/+7O4PGOOSBODocvP2LgwKydSRfJVwDw0gFvENurAvfkz5HKbvyeYxdPxbIPtLJ5WL8MRQ0BkAvngYRa5OQbgGvyWpawGCZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773364583; c=relaxed/simple;
	bh=ODWaR3nFXxhTq+knkAPMZkyyR9eyjra/Z+l652kZT7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LekHuJj7pcc/78dj6QNPpKuupiAjM579nuMwF/VGynHfgPugDET3i2ur7P9mMoXrS4wozv4UGzTBEO3JIWHzsjL8piRaFPcf8ns1iR1i7Uu/mPQ23ZKtXH5uLlyJBOusaE15G4FpxeRWTPs1BvxJJbGRGanrKe7iUuhuz/mShWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbDVFGue; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b942b36de08so284342066b.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 18:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773364580; cv=none;
        d=google.com; s=arc-20240605;
        b=B32ZxHIwhup1eLaG36mn9dhI3Er7A/KHPyyM/JZgrpLTn4ygCQBTzgqRuM77/WKbLN
         EBMOGjX5OWUfVmpzyeeG/s+LIm9y01OgV99A8lrLss11mlw2BLLE/hrc3YgWy56fnSdi
         tT7gthpfcOi37VdbyPKckaSSuf4Wy6RiexeHqhkJL56o6Er9IIMBjek0h6vcVmLeddxP
         rAfYQnFpbpoSY2l69Bl2Lfmg7xr2z33GLyb/MYOdrQJgfaDCsjpIrAWSX2cU3UcqDtSs
         jSphu/cPbUQPfp8p0KMEiii6H751ED6z8rly0sZkRJ0r9GqZ4eNDZgVJlNmjqh8T1IkC
         9YFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RAG7cR9Bz0TQVww/2OwxJdM2p8V7n9WqbxWdKMi/J1Y=;
        fh=J8+BY+BQnNMmzCzMoDZ1ai3C1MdmdZTwqs/hw98cqPU=;
        b=gDc6Yl6GMS/2WyzN3yZPB+42qkVoC6zh/v185R7629p+8Th4Z7jGQzDHp37sGMC9hy
         vW4DZOCWSr2LwJnBS3vKk3UuVKt0bj74i7XeX6nXz2KY/5kWqvK7BJ5GvgvOWbGUUoJ7
         uxyogP8qoqWSWqEMSdDkjS/ppiFsLqlI82C4Cf843a2F2E1I5T0CEkIWR7PvDnHJqtEH
         tHHjzcQ1y/Ra4+A6pwOnuT6q169EN4vD8j8oom+k6NX+W+mznQW+zZ0Y4zUDB4uVmLCi
         K9KBIugZnhG4ajcAzbzz26I9yvYA7txllfiz84AwclFvd4DX1D7s+RofdeLsP0kaRGcF
         9Cbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773364580; x=1773969380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RAG7cR9Bz0TQVww/2OwxJdM2p8V7n9WqbxWdKMi/J1Y=;
        b=WbDVFGueBvQlu0+c7FzL5lDjB+51y43udKZrgsWPihasgVBhkZ9+S8yamAaJDSDPeg
         1ADSR0KZYcarYQ97S6OqNrHMpckPCQPf2OCtESKEFhrIhaEagWfFQ3mbgYiQiooqpgLH
         FPvfO+aOpbtr9jnYekOQiELt3WQJqD5E9cqrEQCfSMBUzFBjyr2C2zYPS1NTHyOWE0B9
         uQ4NnGnAnmpYnbChKZJgLMIYrYZgvOW9jRu8VEFGF8yYynudVwIli/qLNsBkJDJ3q2qd
         msNzG7Ol+1j2gy4cQIYeO28Fmz4Sbp0zmtqLQ0TMMpw9lctanrSpZ94v/sVg6byUxZhM
         ZEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773364580; x=1773969380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAG7cR9Bz0TQVww/2OwxJdM2p8V7n9WqbxWdKMi/J1Y=;
        b=BJiWW0BTqjcM2h4twvxCXn6U+83MNNRljAtM+Pqu6qZLa3iX7Z4BEwJtl4weACExV5
         t/3levLj2wvxJWOsK+oj1rVFqqOqgXDxa7exUV2z5MLyRp8diIntvjZy6HscR8pDr2eW
         h9+WcVdcNAVRxpIJ0dSl6Tc3apdNo363KOhQIpKFSCQOjVqrVgeuwEjgJF0bUW0yacR0
         7o1xGiny7uqIV7GNyDmVSqMV51XvOj9R0LDYasLusKNyQqdi2Xi2/SJ0dYd2SnOF/6vp
         uxRPCQqupXwDuxtChi/Ig4INQvpIZlEZehxC/hBUVcFO4Wthp7I1qvkAh1YgE3+YUzV5
         ZTcw==
X-Forwarded-Encrypted: i=1; AJvYcCVjq+Bw/DdcsZx7ZYolvbpJTUqLo5P58TCVl9nAufkqudGwlMvqJoNJA/lUxMDtR71p7q378tU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyotjva9wyxiEzv+0wgucxDBVPdLyflXybgyHXsvftjEAx8vzLN
	WsLccVn1xtpuzj3CLW2XLaSjZSZ69ANxflXMZnqNLuXIpeJAd6zqKC7G1rCKUr5bvX4mf8ggybB
	9F8UChE19kZh5oshQrxqkqSvX+lOJDZQ=
X-Gm-Gg: ATEYQzyTlqC6XrUp77vHhO/GTgz23pVFwYn9V3NaUGd/V21yZBjc0Syi/pUHEE4WaTN
	ALfOOrCFqnQLR2GtCXleH8T7i4XumkXq5KEYEjJyIgo5cF4DCia05fbxomZ9mRZpkrjbYWnn1Cs
	lQLt41swGZOySjN29sUCIqZJJCmDkWc+PGzxMcx4cW17xzIiT57oCE6yWU+IH4aAflPsMU/lskG
	ILf7i8S1exda7cQsHAtQ36rd6uUJzrR73eJ6AFM/GFT2eR8K+y3wdhAf8pn5/c1y+GdPzlvdqIP
	CUKGR0EpBtFnQCTKg3Y=
X-Received: by 2002:a17:907:c1e:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b973f6eac02mr376987366b.0.1773364579979; Thu, 12 Mar 2026
 18:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312183817.104878-1-teknoraver@meta.com> <20260312183817.104878-2-teknoraver@meta.com>
 <20260312173041.36bbfe4e@kernel.org>
In-Reply-To: <20260312173041.36bbfe4e@kernel.org>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 13 Mar 2026 02:15:43 +0100
X-Gm-Features: AaiRm52yizaDdjEL-sEiEhHWB1GeEcg30yq4KwZRdHEWmjoGb6VT2S7HOf1R7hY
Message-ID: <CAFnufp2BbYu4PcPoYEL-Z27S1ApVV-VS2Dh2DfwBVxzC_tUwKA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] e1000e: add basic XDP support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267254-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[technoboy85@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E19B127C32C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il giorno ven 13 mar 2026 alle ore 01:30 Jakub Kicinski
<kuba@kernel.org> ha scritto:
>
> On Thu, 12 Mar 2026 19:38:16 +0100 Matteo Croce wrote:
> > Assisted-by: claude-opus-4-6
>
> >  .../net/ethernet/intel/e1000e/netdev.c.orig   | 8529 +++++++++++++++++
> >  .../net/ethernet/intel/e1000e/netdev.c.rej    |   46 +
>
> Well, I guess this gives me an opportunity to test some new patch
> ranking features..
> --
> pv-bot: slop

Oops, that's a leftover from a cherry-pick.
I test the patches also on a machine with the e1000e card running an
old kernel so I move patches back and forth.
Surely I ran `git add -A` thinking that .orig and .rej were in
.gitignore but apparently it isn't.

I will submit next week, sorry.


--
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

