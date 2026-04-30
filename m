Return-Path: <netdev+bounces-282768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFTkJi4282kUygEAu9opvQ
	(envelope-from <netdev+bounces-282768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:59:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F2C4A1285
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CD1230097DE
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2438D3B4E98;
	Thu, 30 Apr 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGWyeeSP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25BF36C0D2
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546796; cv=pass; b=X2z8aka/gzS9nuareZpLY0dH+yGqhBryXfM7Fe54B0qmUZilMWVvcNqEGN0IVF7MSeOqCdpvXGp3xtFQXucQ5LgWrqwBi/Rya0GAJE/0auChEGuG0ty/TE5aPm9RXEWWxMeizsxuPnWR6dVFO/WgVeNZNOgI2gQdjBtue8dDy4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546796; c=relaxed/simple;
	bh=WVyjPIFhFCn7s6/UTHOuJlTtYBjTTDJQRviOoUr9mmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VW/10jG4udI0Mrip7ViRakOXQs5v5yE0UkoOkEBv8AjFenHuU/Gg4i5rqMhOULBRLqb8E78XkBmJ8higBfMLqZGgf+uh09sDopxu7phgeU1AwdfdWkejJFd8Oivlm5LUOdYtBTY1cwNYds1GUhoi5FJANK9BmVvE5+/jRgX+Rf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGWyeeSP; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479eb8bcacbso456927b6e.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777546794; cv=none;
        d=google.com; s=arc-20240605;
        b=WdKgeV+S914JBIrJb+4WcfF62u/6pcUezY6fg8lX/GN749tphIRt6Li4LoBfHSMz+g
         Q47ssPBD+3zKLzzXdPyDz/unz7ytv1kvRgQXzC/z2Y/n5E80vWk+q8XK3j40W1GAUgI0
         Cuge48v1ayljKJT+mOHc0lCK7JVG+tiqYMMO+rKW8DS9KN+RAVHokDrcMdzZOnTNPeLB
         BbMxxLbDNVoMsO6h7rCPmH7g2k5ra2zWqgPGky4mmQrEnH16g1EyUpu8mhWjRvQCSScm
         dujNBoT9YwXKR3W31/LHyq43af7xALPNfxSjwpslOzasOhQyqja+p3qVZPxEGdeu9VVu
         o1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=06YwuKfij25TMX2FrMF5o1srZwpTgCpk+Rr9JZBBo8c=;
        fh=oJ2Fo+PZEJX4ZbNZAU4VRYqYCWNKpVt1+ZeDqcfVyi8=;
        b=IV/6XF3jdwAt8TsY3kPWncZPrPnpnoDFPoLaBL+3X7UYDOmUggQT/zXiW1uMJYHz9e
         hz/mSer1QGuuZE504qC8p/N4Oc+GKPesGPW+1CysTRdftvuN/2VOhYQmsgYPdBAIlfsc
         Lv/1sgnMykPNyl7/1gp4sxFHrZA1tl0E8aXV+eqiy8uLsQaZiHPQXXwM823d+BL9A+I7
         ILAEXz8J4vcuP34nmiU5ugfodinLrrR0i8VuE/5ytbMX8DvzQAPAk+t9oQBU+0qG6zIS
         H8Up7EzrdWZ8a4JHgZK0KxItmJoL5dlVIv9Pd27LJmutk6Q9WvHIWYUgGWlSPkZJU5ph
         5lFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777546794; x=1778151594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=06YwuKfij25TMX2FrMF5o1srZwpTgCpk+Rr9JZBBo8c=;
        b=tGWyeeSPM2cK5MbY7lBq3BoqeXxRFwQtMhrZQ+B6U68fMGQzJvkiem/zdT+Wmfw9CR
         k+9fD2twwZaxWMAfiDnvn/BUrfclFQ2to1Y/UUyw24KY6Vvk8hkwMTKl6VgffoHVbIDW
         abbtLWj2MoJaVqA8VeDnZdNX8w1Ui1+6AuWQwcZA9TPHpKb+mv/WHwrCPmRp/58oSlGy
         19GgqdXHYyTQuzKQ2giivHJrIxHospqVbBrSgUAIYCz4xYnwgu3obUSzaPdLxOuilE2x
         JjQvy5cMx7gzmPJn6MBovGiDZK0Y3RL3/oOs4xD+EWQ2FM3PSTTHsf/jbsDkXFxc7Jlq
         M8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546794; x=1778151594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06YwuKfij25TMX2FrMF5o1srZwpTgCpk+Rr9JZBBo8c=;
        b=aB6/Sn/JMnWHxrAJm+kYiYHo/D4+6p1IbbV2GnBELaiFOqvaakxfa6sNnMS8ii9oJ8
         fKI3orDuFMzfZnRYRqlT7UdFytUXqWYsrBMTjqg6w0ImSBs9mbnggUjAlq85lZDxAhOX
         6LuVMtZMBFhItOT8XA/Hzb3BEor3bNOPssqqTDN7/2pEJFTD1neo19LI+BQnvw1wouvi
         FNLvDM8nrEox8qTuuC01GgCvaxRHX8p9J8ICFUTyO1YW0rOvnH1HOWhEFeJjCrwiagO1
         mCFh0VxYklLryZTphNElNzx46NjEachzYUzZ022GtFFvKkd69/swl1crTs68QU5l9wQS
         lZVg==
X-Forwarded-Encrypted: i=1; AFNElJ+znPIegT4McPOH9DC23ItzGc7h7LHFmIc9kcHZAPpoogFeA5Z7aHTWMWyOu6z9aQSXYrt15Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDIDDlCpKmU4NGXtaUQ1p4ySY/UgxUMyzL5BraAtijZcvSq7g
	OD3k7EhNQM3yKowA7TITclyMitUbLcHictuK5eMNXQ1nSolKyGf59p1Lr/1kR6yj4RsSZsGEsu7
	7j+FhkcLvXq60+a/LUhyWRt8QZBBbUT4=
X-Gm-Gg: AeBDievJL75sb+azWH7VQvn7G01TwLnuzA2mOO7u8JyfNhw0DDCxoZz9/3d6Lxbg9Xl
	+ZFHlJdMxhIt43Lwws5mrhUCxcMirpU/xnaf72CXg3RdtGoKcxQuYfXWB/g63M78V0nARlPEWH1
	es70sEIjB1GSMMTV6yVo38FGvNm3LLM5/xKK5ocYs1cP2U48Jym5d0ia0Ouj6mMruHA+1Ppxj0b
	sSZBPKQEnRdmLN0zSXsZz0abYdJi4BMuR8zgEfVsbTpyYEPIxSLC0BGDheOq/QQ0kyzqZsU/k1x
	wVNgHL/YjFWSc/a8WZWD53Ofc58YRRMIwqUI1jHCNORvqmu7
X-Received: by 2002:a05:6808:2519:b0:467:1212:46fd with SMTP id
 5614622812f47-47c5fd77dafmr1043697b6e.33.1777546793717; Thu, 30 Apr 2026
 03:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430062033.20428-1-devnexen@gmail.com> <700329b9-e4b5-434e-9678-5a7f067a535a@gmail.com>
In-Reply-To: <700329b9-e4b5-434e-9678-5a7f067a535a@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Thu, 30 Apr 2026 11:59:42 +0100
X-Gm-Features: AVHnY4I9ukprlWisCYaFhCUtcKRssHArK9YkwSe2zPdGGSdz7gLHlpvQiZUShmc
Message-ID: <CA+XhMqyOSDFTwfbkBgvOw0GOu6KXT3-VmXimqFrg=rQrKFEGbw@mail.gmail.com>
Subject: Re: [PATCH] psp: reject packets carrying unsupported PSP optional fields
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: kuba@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, raeds@nvidia.com, 
	kees@kernel.org, cratiu@nvidia.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 01F2C4A1285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282768-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi

 > [...] we should fix it by validating that it is less than the
  > remaining bytes after the psp-udp header, and then stripping the
  > correct header length accordingly.

  Makes sense, I'll respin to compute the strip length from
  psph->hdrlen (after a second pskb_may_pull to bring the option
  bytes in) and drop the rejection -- easier to ignore VC/options
  than to refuse them.

  > For the other two, I'm not sure they are really necessary.

  Will drop both, agreed.

  > [...] this function will also need a comment update [...]

  Will refresh the kerneldoc.

  > For a fix, you'll need to target the net tree with this patch

  Ack, will rebase on net for v2.

  Thanks,

