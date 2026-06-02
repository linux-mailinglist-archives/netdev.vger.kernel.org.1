Return-Path: <netdev+bounces-293990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG+UL2ZJHmq+iQkAu9opvQ
	(envelope-from <netdev+bounces-293990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:09:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6458D6278FB
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF3543011063
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 03:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5313367B89;
	Tue,  2 Jun 2026 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PC/9yDxT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF293369D71
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369750; cv=pass; b=n27vHCfuqOS2Dvjzr8wWCUe6jirL9rEXxg+WFIJbjvWg1ECAFSx5lPiCkkPX2Gb2AYH2QV1J+0OmjeiZo1YXLawEyJcyDeZ/FC8ACWMzKHbU0VhU5TNNMM0NfKRXq0lzCKaStKzhwiHIssOI8YA8ICgyUA3vwR5AWxAblPTecW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369750; c=relaxed/simple;
	bh=RkU/12cK7hYiqOuf8ggxFTWQjPB1bnSQT0ROuSD4Kf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6ftFY3dHpL1+LHUIHoprWLt9UmsULDCHePf3ulWNBUhRShSeCg2AzWW6k6kB8epiWIjuaXYMetCTiWe4p/XOs9fixjzes4J7uQ2JsZOYeeGbJfbMkGtRX53CqOBEbBaF36exXfCylm19qGE8SM3TLF4ZNwnSGsR3wRq9xZzftA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PC/9yDxT; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso13867315ad.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 20:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780369749; cv=none;
        d=google.com; s=arc-20240605;
        b=NK0/Y9Y2Gr6gjmzTGHG7CXEwpFdbD/Ukl88EcGAl8WBpAv1zuIWHe/Ei6Xt5wyMzkE
         7o0Yx29nPRg8UOGz3a1ZKqvMRdxZmBLNfv7zpEKfIe3gb02howvRc24XQRE7Mf9y2hik
         BXiKvsZJxo2gYZeAqGi/SiwgPV0GGnW6i6dUlV3x3LHIaeFiT55HdEHe2qm27nymQvt6
         4SUojpV8+tqe+smFak5vCUF06M+YJ8MKERdkXTsxgp5KIh0ES1+rDD5KM7NqQOsLdSWk
         +yeN6yDPR0iroL+XbaKSYmkYGlEM5+qM4jWuzFK4nIr4ZKJ+zMRY/OGKE0ISkP0pnzWK
         i3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Bq3RePJEw0dpHZjElKcKomidBiHV5J9wG+oOvXOgVU=;
        fh=YZ1nDbsEPWtfHQTtuvG4NP3bVmjPxFjz1oRIH1ATqZE=;
        b=QF+Z5vDv8Uj01OD4Goki/DB7K3q1x1NB8tMZNqqsh6sLh1BMd3AYPQPy9zMHs8HTC1
         UI98+OyW/VXiMK2CIZatFeetLtyyN2+jcreA65/9NXkCuI9/CDPCe2R8RWL+H9WZtlW+
         IKj+zJXxOm/Ed8W8X2wGkVpQ2CdjEPHiJsNUJkydU9sYTgJqN8Q0H5BPhI8tHnqSdxtL
         u8OAQNgOSLJrK1F7f9EJN3ZPcySToILmbGavy7DOcZcwNf4whe7k0Q1k0eB4aTKDwoWT
         vCWxOTY+Osy27furyornC/iq/lqvvZR/9apbSsa1ybOCh4EQAlGbG3qp+ijJUQoEniiC
         y7+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780369749; x=1780974549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bq3RePJEw0dpHZjElKcKomidBiHV5J9wG+oOvXOgVU=;
        b=PC/9yDxT9uG1vJcmaE13mmksx20463uGtNe9DCC5czF6uBiEFtWu7nguJjwjerYP/v
         zDF/t8KqsepujcLulAjrFyajSaCigKXcrNkqBzsh/9XnWqlSMbVkaOr4SXchvtSlYKZj
         mf820gdjqWUVpracIkEFbbo2tHNUUWIrb1YexlPflEiC+sLU/u82WM27az3j1dT1j4Bp
         7AeXPidtPC/zl2PDKu1tYE6V1xe+t63VtkpGdlQN7/cAAH5OmGvJz2yd3dxihjzvMbYk
         7fNv9/pO/Hdbon4eVsL2OybQbX4j7j3Scl8XKqaid3CcZcglUqAGgNG8DjOY3F31uc+m
         2ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780369749; x=1780974549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Bq3RePJEw0dpHZjElKcKomidBiHV5J9wG+oOvXOgVU=;
        b=GuWQSEee0EGE8Bxu7/laJajKAv0AxgmvJMcfQoFQ8w8Q0hPhyFm+M3hwVaviLXNYZH
         kGcaQ5bW1mWUXvDssRBkcGjkUgy+bNNhcweDNcr1g6Ryyv7SJSq6iPKfcEx6WkvK2/+8
         LxIyGFb6qne4lb9Da6VS/wRY7psG6kLLGsDLGzeXV7/D/XpvmmWOE/8c2Q5ea4/iOLuO
         RevbzlCOAaqNW3g9GdQsGeTfz7tm2kdm46oVT4aZkYwGns2FxdYPW/dTayZLFZr1qDOH
         6lPYl06answxpiK9xjZtGFtwZvasPw0jzhLu8fvRQKuTWucURGK9MqKiB3TTI5P5oXQq
         469g==
X-Forwarded-Encrypted: i=1; AFNElJ/4fcQKQaFUote0a1tcLQz24IlX+XTpTF222gf2PC4+Zmj1fxLzHq6ASqdQ5S7oahK6xDjQO1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrpnyBYTwv68tk+c1Dph/jG6isxoox9DFJh8uO1AgMIq9PKTS1
	w0Gu9j+1wvItHUxBQCx7mpPB0vgZGBsr39nnHaKIi3d/pkGrtqsVOjLYW58EYiw4MBXgo/Qi56A
	QhN36Y8h15NlkZEKL6spdTePLaIRUbrQbZhz86CAG2/BStBmHlfXqmtFj
X-Gm-Gg: Acq92OH6tpT847lmgPgb9y3mdnviqrqi9gdnN6WDxQpnoU4VXJOdYzE5ww1XMyOu7iI
	yrG+WJnir+PoXoWhnzoCIOGcfoJ4MVosVR84/jaugOYkBNeS5ddWnEoKNsev7NTa/heqU2ykylm
	06MXjDac1b3KaHMyy6CyMsD9mrmdqnLvLIs6L6OnfoJbKcKq6m0jSPHfbPFFRlZ7SuRYa/VqaHl
	jCAj2+auiX5bF2QBL2qEjbUtMTosolVQlecsL2kyj2J78zhE5Is9lHcFiTZJO4Q3xPH+YC8FOhW
	Vl2Nh5lWjDXKJJhE96kpdR29XRQ4
X-Received: by 2002:a17:902:e5d0:b0:2c0:ccdb:e029 with SMTP id
 d9443c01a7336-2c0ccdbe566mr94480965ad.18.1780369748980; Mon, 01 Jun 2026
 20:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528015913.190970-1-zhaochenguang@kylinos.cn> <20260601193805.011c7f15@kernel.org>
In-Reply-To: <20260601193805.011c7f15@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 23:08:57 -0400
X-Gm-Features: AVHnY4KozWy30zJsbUGGCJ6Tse9WWG7WuffD_wxHtYQhSWLL5KLDic58pOgX3Q4
Message-ID: <CAHC9VhTwu5vQf+RHutS4Wwb4ApBcwMXDXEKZg1EOL16jv3jNrA@mail.gmail.com>
Subject: Re: [PATCH net v2] netlabel: validate unlabeled mask attribute length
To: Jakub Kicinski <kuba@kernel.org>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293990-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,paul-moore.com:url,paul-moore.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6458D6278FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 10:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Thu, 28 May 2026 09:59:13 +0800 Chenguang Zhao wrote:
> > netlbl_unlabel_addrinfo_get() checked the address length
> > but allowed shorter mask attributes to pass through to
> > fixed-size address reads.
> >
> > netlbl_unlabel_addrinfo_get() only rejected a mask
> > length mismatch when the address attribute length
> > was also invalid.  A crafted Generic Netlink request
> > could therefore provide a valid IPv4/IPv6 address
> > attribute with a shorter mask attribute.
> >
> > NLA_BINARY policy lengths are maximum lengths,
> > not exact lengths, so the short mask can pass
> > policy validation.  The mask is later read as
> > a full struct in_addr or struct in6_addr.
> > Require both address and mask attributes to
> > have the exact expected size.
>
> Sorry, didn't look at this until Paul responded.
>
> NLA_BINARY does _default_ to maximum lengths.
> But you can use NLA_POLICY_EXACT_LEN() to have the policy do the right
> thing. Using the policy is preferred - less code, and policy
> introspection informs user space about the expectations.

Thanks, I didn't know NLA_POLICY_EXACT_LEN() existed, and yes, I
agree, that would be a much better way to solve this problem.

--=20
paul-moore.com

