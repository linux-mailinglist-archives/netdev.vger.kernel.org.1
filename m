Return-Path: <netdev+bounces-295719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b88TJqeIImo/ZwEAu9opvQ
	(envelope-from <netdev+bounces-295719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:28:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B00646646
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:28:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=JVxHBFCB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295719-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295719-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B7DD3052886
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 08:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D473C062D;
	Fri,  5 Jun 2026 08:16:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19229393DC7
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 08:16:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647386; cv=pass; b=lenFJR/L4XlqLyv/oMsn0d0BRpwZIMI39WLhCHEDQ0+tWcLtHMdNgDx2/F18Kl25Bv2wMFcgT24dkpBc/aoT7Hy5EPXZAG6to+ZPBAp3yQnaz7tHOOB0WOXM/y1ubbYAlADg2QeWbYkRLtGyTLhA6x5OgF16WECt1+8/Wz+vdKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647386; c=relaxed/simple;
	bh=XnAelB6AxuXfk272RlEQBTCRyboXtSXruWGQB5iba8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EA51k7Vz0qicx6M+WDxn18n37kbGQTQAj/bK7JCo91UdYXc8PqvTkm437ouMRGvMffA716zhsGnnxlMXBNhzhfMahABwpfcyW6RXTCpYgb4Juz2mD63Z5agBW2I6hODxFHHAnZzg/Ibv2Ehyd9NghuXKV7lqguIpa7qMMF6fY/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JVxHBFCB; arc=pass smtp.client-ip=209.85.167.54
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa68d9d4a3so1762420e87.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 01:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647382; cv=none;
        d=google.com; s=arc-20240605;
        b=IEFBc5GZgyQx2PeExZnFabPeuvLRyratXsC+a0KqhFNBDKQnQj6oO1eWlyYc48NuAq
         a0bWguNElNiEXI0umoURHuYI9SOxc91d+WhHyc6cuUCZfEWiVxBwu42zySYs3jzFNHGU
         +85/w2zCjh6/sOKxtKXwii1rdKrlNArXwfkRf9FV1oXkSI1A+2IpXETYVelzX1218EnQ
         zCylx7UdEws9RILTTZapApazznlQAFdtgBE543YlWjDI+xTBbi1Z8UGfg3fpdCpdSIRh
         6TLqlLkGiI3KohwB99HgrdbR/PcT0VOH/5cBJ82DDKpBwonsFbAZ22ieChmDMvUeMkKB
         dcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=chP+DoD6o+jNnBy+ko9NHVAvB6qXMkilsQ0fEfCieus=;
        fh=kmtL4HuYysiJSmKnQqxEr652olNJHu6hWdh5mgBC7jk=;
        b=Gp+UNH8Od4m6wrES69FVXK60bziGyvcLJ56fXfUiUQElZekMtTa1S5uEVmMRqyf+FH
         AiZuKvDDsqjjyRX9dH+MuDJHglH0AZoB76vT3XZ47YRV/dKxSjzzX6H/fDtElkP7gumW
         /W36ng2+EJcWw/DB6uRFbOlJNpbKwMBpbVNslYhbwdBjo408qWfuvE+KIJsXnbrC5pUJ
         o0334hF63gP7Zqg95cPHfYMtmywoA0+j/o63npCDhzzAJmXfx7JhSa98BuSYdJQr1c7H
         42e385mEZu5S+rSc5SdNJsoF748Ua093DG9KEoBaxEXKbNvdfq07pumYjPk8M6X0NIOg
         zbzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780647382; x=1781252182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chP+DoD6o+jNnBy+ko9NHVAvB6qXMkilsQ0fEfCieus=;
        b=JVxHBFCBwYjhAhV5fuKrl44qmxgEgUj3f98LoOZ9pImBgPCvCDsDq+x6MLoYoDPnNU
         /QNizn1t3n+BKzy0PJCK1HwUa38uzxQVJPQwvAv/2n0MnUH/dqv/L29GSUMHaosIKpIF
         sTmQIKmt+fI1tgqdajvrE1iXeN6ld+ujp0ADjK6SMWrY+SRR9Oj9Hmf3DS7Pj68ViDPP
         w8AfLi//6ecBcbaP8irKHIjt8KcZJFh19l/nE3VDVQzAz0sJGxd8YJRbDywEuSIIq2IV
         wrArDiu1fFdsu43h8NMsCD4RgTj/TeVrc6uHJ7FnlVDhuNh2rAq0M+GwYuvPiINaGG/r
         SnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647382; x=1781252182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chP+DoD6o+jNnBy+ko9NHVAvB6qXMkilsQ0fEfCieus=;
        b=D37Wf1EiOOTGit/30mkMv3+K+JlwCY9HROxUkyyXWri541PcoeaCeAs0i6u8LWh4la
         97dSlloMEl4JO3TfuV7TGrC2lpglhTV3BReKwuYj33F6QrLKmFWJcu0tdLbIeiSpLsKY
         nUPDCgkjuPnFv7fMX60Nr+e0TEF5GIQceRfdwoAR/zjkojgYEg4toysXYwT+URF8lI8V
         3kWmsbcCZyqkfcQgBmv73+1O8FNOyT3hdgpqe+nKMZZJrepfgroGqwBpovpEHkl6i9IX
         Y0YnX3NzSo826exCW8NMZl3X9wJc7E8VBHZw96mVG1jOas9clzGglf3Vb/03JRskdaMI
         KshQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Qlvi93hmdLsvb6O0xdQP0Fu6rZkNiVQKUS9p4boxCd1Fvw5BzgcvrCZkFgTtoYRVwiTkfKu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsW2DAsLtfvl3zILnMHHnTH4kpSfSM6QfPnmJsMwV2bOsoTnhH
	3nj5gE1gntMQpGuwuyP3Eu6RF2A1oCPz/74dWwGRUF3bfiy2jKGhmoRVJnqb8ADekLd6QIbW+rQ
	oubeS818f8Ci00pjOkFPaqT51as+7AWrsGb2fRlmW3w==
X-Gm-Gg: Acq92OEUqoFXFXPc1Ovk3/sdHxeCflYLWpNkbGCcXZ6IQ4i1skO4O2kW7dHJNPdrBgx
	Y9ekNbipSatBMsL0o6+fJc5wVVB95SBdYDK5zkE0pYoBFZuEp0+yf66F0UpuC13itZ/7/HWG6LD
	puBmhmaeU409UgaLDSaEis4E+ZBuR4kb9fWa+ZX32sHpAW1gYPFE9f6pTr6tlQRm/8Cu2syVL87
	nqBFuMt2U/1D3FKRQEqyRLOMN+kfZ1HM+J3vaMNrOpzTC4zI4B2NE+qbRYDFELVpxTxeFaez4Hc
	1bTkGPemTYhT+FNMFsUfAuriodjbjADYplBmnrjJyrxYrG/204s=
X-Received: by 2002:a05:6512:804e:b0:5aa:6d0f:d765 with SMTP id
 2adb3069b0e04-5aa87b80e23mr404631e87.20.1780647382332; Fri, 05 Jun 2026
 01:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507134815.295588-1-marco.crivellari@suse.com>
In-Reply-To: <20260507134815.295588-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Jun 2026 10:16:09 +0200
X-Gm-Features: AVHnY4Kbl9XFe5VYdITzs-SAi1Xwku4lxaI3mSz8BfUmYzi35gpoXXmtmCC3UxE
Message-ID: <CAAofZF6CcyxoOsYr94KARUFtfi+=H1nF3mBQAtFWxEujdVgXUw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: bridge: Move long delayed work on system_dfl_long_wq
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	bridge@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Simon Horman <horms@verge.net.au>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:mhocko@suse.com,m:horms@verge.net.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:idosch@nvidia.com,m:razor@blackwall.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295719-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,davemloft.net,google.com,redhat.com,nvidia.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:dkim,suse.com:from_mime,suse.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38B00646646

Hi,

On Thu, May 7, 2026 at 3:48=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
>  net/bridge/br_fdb.c    | 2 +-
>  net/bridge/br_stp.c    | 2 +-
>  net/bridge/br_stp_if.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

SUSE Labs

