Return-Path: <netdev+bounces-304653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ERKGOU0CSGoejQAAu9opvQ
	(envelope-from <netdev+bounces-304653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:41:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5121C704FBB
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:41:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RRUXU661;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304653-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304653-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E065301441D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B10E3128D5;
	Fri,  3 Jul 2026 18:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B630C165
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 18:41:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104073; cv=pass; b=dUykBjUZTkiYrueKBHEeqLMF5zmnXeQkF9LAgHC07v4peXoNUdpGNTvItjyHV4m0Ic0FrYY4uCUbPbeHmZYP4QgE01B0Q2yBXdCV6oP6kveP7w8gpQrr7CinodLdnuTiX/PkZPHffw626d/8IXGCc2SsTof4jrnys0nQYe5FHNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104073; c=relaxed/simple;
	bh=0Qbt2nm81MoSrawX+7rKawGZQFGLjf8FPMXtAFGMjLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0WRoBQgw5Lxp0bVkvtI9p5SRmjFOw/sM1PXbav0Vzbrfo0fJwx9MqP8x7AW2XYQCvdAnbktxAtPBKTwnBoGyz8hHHVqJrrvVTTdGivn4HSHnoKgULrR1vodG8gmiz7RYvytWF40WBp6isKp6DoKH5DVHHKtXFPb6ZwV92ZTDIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRUXU661; arc=pass smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6976b0c5adbso1451542a12.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 11:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783104070; cv=none;
        d=google.com; s=arc-20260327;
        b=D6wrybvKRtSIKviv5WrvM4hinJ29wTlX1B1DMx21OzDg7inWQjH6Ctsv8btReuFvJ/
         8wDa/uLaogCIGcp4nvny7o6Xt9K0Mblj5/NpTs4czQZ62zXgq/gokKppxICvaDAY/4mW
         JrIEIoluEBebFuvezpn8CcDaPfI6zE5mFoAjhZ3gn21UVCipbef2WwpckMkHOWfSZ9oD
         Gg3Y/suTYrP5bhmSkLDl1cRn65ikQFyXphY8ycPslLeG3gPSMjdLPWtOiz/mmkq5HoOX
         GH8mUR0YBFXCBGeJ1p6Z5v2Ytwv8jL7nUgAdEBwiGo2J49MmCINTOEdPxlDFPQ070ixx
         gsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WBbHXOwzJl7j9yIFimPWLD+hLfRc6OqC6nXJMgCD74M=;
        fh=9qs7J2ij9l1jwcrECCkxzrXUjTRTgACkgSN7OSp4xq4=;
        b=CooDcTs+i/Rytq1s7untRfdIpwyeCCMP2ULTh9WOKDqLaTg6f4slheHUOMVnsTbrHq
         mVZ7v/MkpddhOR4eIkcXo0cmfN+vkPYE69Va70YsJa4wGnJjttfsV1D96eCKf71pvpAG
         eaA5mC9XoMreCOvjcgGS6r0Ux+AZIZ49IUfw6GqlS9EKnzCYj/xgeLxRxzZr59Mc5Z0F
         p7Aux08BVMtSUa4AT0inFvg7/L4ZgDrphoIATc5XZsKkDVYJFKpVbV3PGCJ+MVeW7+SD
         titQNy2qSot/qx+nzf+w/Y/ji8CLs7kOTDsnvnr6IHFo4+MqsnDBNVSeUfyFRbCbh1wx
         URnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783104070; x=1783708870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBbHXOwzJl7j9yIFimPWLD+hLfRc6OqC6nXJMgCD74M=;
        b=RRUXU661NlgEp7+AyaYJPcOn1kBlwAryr32Um06ftuURlGaR3lL6r8oaMAjyFXSwRy
         uSUg1tbfyYvOrxnfksXniOw0SQf7EyLQpJJzb8LDymAMJ9HWwWvh2cg0ZXyN53aCb9m+
         PLOH/w4vT7OOyyqDfJuPOdRP7l8UY8xloEGslrdGQpyc2HK5R8qGpMNc23WEQAXKob94
         27AP6344Lv0HcJ75FTFUrPxg+owy7hirgcMlQiRuu3QC3MRkDFo6C3Y/kR1AmmWVE2iD
         tcsrNgLVmAw9V+fjE5eStsEQ7STV9bu2sicumZm6frDgwC+Ec3Z8SyjsRXOHYjPjPM82
         NwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783104070; x=1783708870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBbHXOwzJl7j9yIFimPWLD+hLfRc6OqC6nXJMgCD74M=;
        b=VlN6fwPwWCw4AyBOjx60FlDmTaquAtKFwi4cZ37fWHrV5d80Z3tIB8smlC+cBtV2V6
         DpuzcILfwUOUmkHgECwv5O+f3FkVn4PmHmNE/gBb2YXAc7WFNlFTUiwu+TMvdUwdnHLe
         DRjRsGo8K64o7p6cT9WUnhPCPm+obTgVufe+J6j/3nPMEcc+zVYVTy4aGXfZS8dWpgD8
         JlQF68RZpEnH4N2Kizy1Dzz6TKejJOSPCW5aZISL67qtMqyDZNhr7noyK3bEt8LVZx/J
         xMmzLcr4sDXA7+iVS3g00HiIbgjI6N93cQGdjXOqDsykqZ6vOs6Mg/drN/zKv9BUZCGr
         sRHw==
X-Gm-Message-State: AOJu0YxXpJiEaTifpox8sUca0hOAvSsJsXxNWHmHqXorUkPJ8ilB+O4u
	EI802NCPu0ulZ5x1BuI+m18aKvQntsxz4jtyXDSrRs+bELL7cdjgy62tkJgrT4kC4RrNiGwczXO
	1fHpo3CF3Ghcx1doofmn/+oqHz2w8+VavPA==
X-Gm-Gg: AfdE7cn+sWPp/Iina1BuJx/CXukdFZmb1Z6TMD6F5mjG57zjLie4XfCD2uPsDrA+SrD
	vJGYyAs25rs0gWsSIY28md1PcdLSfW5XN7+vMupqHZtVoB+oK4dbppsRyZgbzjrTAPFX7Hrx1fl
	3Yv/JYE6qiJYNsGTZ7oQtvXuknmkvF/oGoXBAR4OO2SZb4y2p9ZnNuab5A8ktUCkgEW/aAlNot0
	pSYm1rl8jd06OAy1X1lJJpTe1ErnYI9c++RdDxcwKptCRSPL8/rXgVUw6KAdNYVeSb9NnYYNMDG
	EE9JRwqZNcxLKf/rpb3D6gOc3Y2szwXIrhgOdnK9pEk0NHVs0wlwMYs9a8jX7ExWFnZTpxeFt+p
	cE/JBtTrgsjSEDs1tP7SG9O/yPWM=
X-Received: by 2002:a05:6402:4497:b0:66e:abe5:ab22 with SMTP id
 4fb4d7f45d1cf-69a1a258591mr177686a12.5.1783104069517; Fri, 03 Jul 2026
 11:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702235045.1326384-1-rosenp@gmail.com> <fa4fa65e-1635-4313-a5e0-56a5208272e2@lunn.ch>
In-Reply-To: <fa4fa65e-1635-4313-a5e0-56a5208272e2@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 3 Jul 2026 11:40:56 -0700
X-Gm-Features: AVVi8Cf-ThBbJ_GxDQuvIOAkN2ONONkbVPiSWXn2EbeilUdDtgaMKDLY5jg8bJs
Message-ID: <CAKxU2N-eRQLw4NqTVXuZPvT78Cu22Z3YC2FD3jrghy1VEJ5vpQ@mail.gmail.com>
Subject: Re: [PATCH net] net: emac: mal: replace devm_request_irq with
 request_irq to fix probe error race
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304653-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5121C704FBB

On Fri, Jul 3, 2026 at 9:38=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jul 02, 2026 at 04:50:45PM -0700, Rosen Penev wrote:
> > devm_request_irq() is a managed resource: the IRQ is not freed until
> > devres_release_all() runs after the probe function returns.  In the
> > probe error path, free_netdev(mal->dummy_dev) and dcr_unmap() execute
> > while the IRQ is still live.  If the shared IRQ fires during cleanup,
> > the handler accesses unmapped DCR registers (crash) or the already-
> > freed dummy_dev (use-after-free).
> >
> > Switch to plain request_irq() with per-IRQ error labels that tear down
> > only the IRQs that were successfully registered, and add the matching
> > free_irq() calls in mal_remove().
> >
> > Fixes: 14f59154ff0b ("net: ibm: emac: mal: use devm for request_irq")
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> You seemed to of sent the same patch within 24 hours. Please don't do
> that.
Yeah local error. Sent within a few seconds of each other.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> Send a self NACK to the broken version, wait 24 hours, and send v2.
>
>     Andrew
>
> ---
> pw-bot: cr

