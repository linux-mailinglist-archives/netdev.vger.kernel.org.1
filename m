Return-Path: <netdev+bounces-278079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP9dLars3GkZYQkAu9opvQ
	(envelope-from <netdev+bounces-278079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:16:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1C83EC759
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65D59300BBA3
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA103CBE9A;
	Mon, 13 Apr 2026 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFZI+k8D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6953CB2F2
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776086182; cv=pass; b=PSgLnMmmcV5raeaKovGhoLJ6dc/D8ckIeUsVfP9Yl3lbzNzYnVx18GPNhzPlGtVz+o1OyqaLnXXuWn+6dL9Ca2rGnf3MtKFVUGihb8CCKTXElRCgfRhf4Z27XtG+4ctV5ffGO0lmqRASK7NJG+D5+Ra21TH003ym8v34ZiT3Ms0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776086182; c=relaxed/simple;
	bh=xapR5vYLfg/zslnpCFpmuJOHQmSBTW30qhgcNYbF99k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTQ9r2+3L9LgRv8fHtasFA/oT0hypEoA0x9j+mttqsIW8QA/Z+nx6ZAdcvpfKVgfxpMgdUpscitjNLWFs/yH4lTee9BtMqZxm7a0PZjBTmDn3q6L+C5tw9oxgdY/vWjoB3DKrF88ZbhBQWh8F0x3otfs+v4Xzl0dPYlxBdTAC+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFZI+k8D; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-47952229034so589979b6e.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 06:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776086179; cv=none;
        d=google.com; s=arc-20240605;
        b=GJsLLdzmXUM7ylsmuS317WXNrByaOZ5YjIjVkfXf0edX1qFP2jpYAy2bZgzqMaiK/2
         U61mYQIrpRFkFD+yIqqSuQtpn15FKEb3+FiZWmBC9AsXx6CDgPoz2Ple9AoD+8+1eH2o
         90Z1zZt8TQO6HYunuaQE4SNLJiu16xgdmjoY21nWdqfokRFYtcUnpBe5ZE7HCtWnErFE
         kIPA77d8PBeCf7wjoIVBJlaygs0b+kdG9NzibLxkVGpc9hQ+wr9hlwphnC/UR1WHdqtE
         DJr+mPY9JN+ixZD1wqGRwfdQXbqTJUq6O3pGhFLgk8oLv9ncFoL7s08TAlbMVzeu+MOP
         /pGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=monJL/cZOuO49Og/+UpJj57XhEtqcm3xize5yP5VRf0=;
        fh=HCM3GRjUIzlZqtPBlGeThgQIT01wsBm7ILRmB5/lFPs=;
        b=TG0DKMZINK/gVuwNFBPrTLaGXVWsYOEdsUiD6kJTIZYdGXJAlbXAcVkBh5YBQtxwhD
         ci+kY/UAqNvQriLPWnnN1yMGMONZd2yNLIkNbF7LAY+INDr+aVovxu2nXADqdHxch5ii
         nbenMOpxff64AddRZmMN9RZExciwyOjIHF/XiZI4wPvVhQI8RyCcLW9/toTZ4qjnSSKk
         cRi1J3H0ID2Te6zTdv7vftYyu7jvuEruqCYMu6qGDZ6Mjet7KzQYw4yL1mOAA3qiM3UP
         RwLuIYP0mG4Wa1UuKa1QgvUhpPnAlA8NBQK7XdxPLOsl0ObfyurEcCzDVKf3h/yhGxKN
         WTBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776086179; x=1776690979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=monJL/cZOuO49Og/+UpJj57XhEtqcm3xize5yP5VRf0=;
        b=VFZI+k8D1uMaP9BRw4tvquHmw/mvFlfpnHu3m7eTBXeYqtJ5+SE51/TGPYJtXIFY0d
         gUjTrBOj14ERbOYzo5DtAp3cUJMnwhsRhN2eaThqFpqULLFmlO/0sBvx8M9LbSdHb/7j
         fnYF6XtvT/1HNe/79OX616HFvOXZ6Yyw/XWfCxkD/1pd36tu4vD9Q/Ud20AE4XF3KOVp
         B3NNrbHAjzFShPfN2rzhMSdj/Xg2G6qg+xtFn7pV/tQzozhQe2zJaWvoks9LI7RgOknO
         BvAZVaoo6QVgoZw2PE/2Ruw0xUz1pkP1gCB4k7vMF6bFMQuhNcOq93CS+C6aKbUIy4su
         vV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776086179; x=1776690979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=monJL/cZOuO49Og/+UpJj57XhEtqcm3xize5yP5VRf0=;
        b=JC5U515op66/gfc0GUu1NOAt5FHGJbwzXW/HhVN8TvP+i3fkh4PLLpWd8iAsOPDHor
         NASVY9Q3Zfi7RmUr4sqx7Cejv96GjHR+byCF9ZPlUhPfDHrZT/IwZwar1/miYJaBgbVU
         utIs7JhLf4IHVL0+eD/Vyk2bceMU8zrMSsD9hfZGT5DFc961y9H5zCSZZPHiiN7lEAw+
         we0G9trpFDokLL9OOabVnSPyAi28UG3vXT/vgMSX03dm1coKHDwZm5j3+ecy7dNVPsTk
         LbbK5LofVNhBg6s8MgnyQJHqXLwSJl1xVBScX6tJwfPH/zYedjbdhtr00lF36uI9mroh
         JKZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xHo1Lqv2+hXtHhkYXLpGvfHYBNyH5VcO0qjWO3NqhM41ZYWiyDoCtoXBJZtvbS4Wi8kgtpGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvZPJriY+3t7/a+Fkis/QVX/FtuMeMccSO+Lqdd3w6vDhGiqde
	OgIH+gE4TVdw3JuQ2o0G4qrlkym+/WWE8xmWdVo/gJQ7dY5cxmFvdGsmfkV8DaEuzjpMZJvR42Y
	idfDOPEDEmAzFeRkIhcQvdz3R1n/fZF6WCPtf++XB
X-Gm-Gg: AeBDieuwFYFrhjqYDlgn1DecnUa+iqYKNcqYaVBbMTWqBdlV7yM2Rpp2d+SHAnFyif0
	/JWNLSNGBa4/yznyK36X8LL2zgBodwJ45Y8XNNZ0edkjsMI3+y4vHLP6pJDFS5lod7ebDxWLVgO
	ojiXhNT8jGNXp/hP7E0yvULy2KMcTS2L7nEnw9q5tCas8UpvE/JWoOOPQ48ldK8oLiHZ1xEr4Ss
	cWJf2TlXC0rxJ11QMad1VUzpG8M45y6OlJXPMkXnbvRleC3zC+O9tA+zL2Kzi6xhvJQt4eJ4/sr
	x0Zg/Bgiy6p3gr5TnEbwnbGGvcvcMWCYSdEISjcIiP4l85rvKYx29ufw/TOxLQT8jmZilGaKxPq
	2o8L219P3
X-Received: by 2002:a05:6808:1b21:b0:467:2dc5:f4a9 with SMTP id
 5614622812f47-4789e91decdmr6816413b6e.28.1776086178138; Mon, 13 Apr 2026
 06:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Apr 2026 06:16:06 -0700
X-Gm-Features: AQROBzAld_GS4iSQHxL-XynrvrXBSYUEHsi4obsX5N6LDZp8Sbyl65JsDF-KHw0
Message-ID: <CANn89iJNJtsqWxSF3mtynpCScSv8cVcruQ=H-TS+_d0bobZbjQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 00/15] net/sched: prepare RTNL removal from
 qdisc dumps
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-278079-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4E1C83EC759
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 11:23=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> We add annotations for data-races, so that most dump methods
> can run in parallel with data path.
>
> Then change mq and mqprio to no longer acquire each children
> qdisc spinlock.
>
> Next round of patches will wait for linux-7.2.
>
> v2/v3: addressed most sashiko.dev feedbacks.
>        I think remaining problems (in red offloads) are minor
>        and can be fixed later.

1) An issue was spooted in sch_cake.c (patch (13/15)

2) net-next has been closed.

Therefore, I will send a V4 in in 2 weeks.

pw-bot: cr

