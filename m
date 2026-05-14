Return-Path: <netdev+bounces-288052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JSMBIwEBmrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:21:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E3D5452B8
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC8933038C40
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3601436493C;
	Thu, 14 May 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhHdVqAh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA5C3F4133
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779122; cv=pass; b=gCGdDRzz7/TJAqb5bntC2w/u6tXipNpxllmjwJjHKcoiPaWUzh65lrA567uD7A8EIGCMFOACej4zwbSAjlsSWbWEm++WOfk17D62Ytr7EDvmkkAUNsaMyFPX5/ZVj7TfJMApH3a7Q1gfPOgqlp0yr1XWwesqvoMdNL+lrTb2Bl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779122; c=relaxed/simple;
	bh=VvoldeyhbT2l93d9aPm/XKZKdD+a0k6CNpfmqR4nviE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bl1Won5CrS3I20tKuy6Xf9vX2CkIPyhmRP+fnyuv+IsJ1qkEcX6gTT9CyG/cayQopHjdPU+Ane/EIe+BN9nB2DbmKwS0IyEtAmCei9K4fcVkh/4tyaTDz7Y7xWb9/f/nsH81HugvuhoQZk4LLqaotDlaAeYnMcU4Wbei7hJBQQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhHdVqAh; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbe437b072so4835130a34.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778779120; cv=none;
        d=google.com; s=arc-20240605;
        b=XYwZvfbcvXMs2GIQX5Xs6u37k2j8oFLJS3l1+4c57aGXYklUruOkSzinN+66dWgEgH
         21F9lJR2RMcuw3UKChvOAlKzrJP6FSeWOTsJHFJ815nPYnpLy9nhdRlH66q0EoVNdIaQ
         Kd3fHp+Jq/C80ntx5YqzFnFlgaQFFv04rfYKdvxVOnOWDKykcIJj3AlrxDL4bo7Hzvqe
         z9s6xiYYGmYcsThtaJpfwiAR0m/tjBbnm9FkZ97l1SKyrct4+JsFfooCVcl3c2qG0dTX
         GkGVh83zkACmvd5URi3P6P4sTOuveCekMCm4xJlDXXE7KPVXI6hnxFjFpCYzLRW6AeMe
         x1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VvoldeyhbT2l93d9aPm/XKZKdD+a0k6CNpfmqR4nviE=;
        fh=53TbqAnUMBd+zMgHV1ssIfB3M7JENWlyFPrZER16Bsg=;
        b=LBGjEiMAOACdm5+8UpO8UKborv2apw/UhgM39ViWPd9nvk3WGyMpVTrU5nfz7bsm1S
         jXD9nNGgZrLf0FkI4FDuiSva1IeTZxEHFqA4c0XEfNOBZ5jPcmznJpReUlrfjymxt/2A
         5JbGpkogdb2aIqrCVWf/ZLFDjn8kVptadUadGmO96VRYO6d5G4uqkO+4Igo17dP2forz
         yyTWNW2x0sibTLYpLMbVwlpo/HH9CNB0slzJGF6nqarjuzZz17KHIVC2J8JvxrJuXQG4
         8UFqjKQKitomdt1VRKSf46QBjG5vJLnnJkTsOPI75MTrFvW94IuOjgivsHOYJ7GPebXx
         1nww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779120; x=1779383920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvoldeyhbT2l93d9aPm/XKZKdD+a0k6CNpfmqR4nviE=;
        b=RhHdVqAh40QwoXZbVCxxBDqaTgZaxtjValocOpk+Ec0sNYYD2U19v3eW+WEzniFWPM
         YBpOSh3L4cQRNoQDYRvDYMJTz6THBS+EmEMZfclH+6VaLEVWfHH+b2J07DuGBk15fAgy
         ilv3mzUvq/8OrZgvds/FcXJ1YO6J1zYB9L5DMKkbdJzwThwl5+peR2m7r8jGDEfBxzPQ
         iRMJbgbbIq2WVLhgGKFf3AdD3BvKT9Hxp0CgO0k9TwA35WSo/po5LnevvJwSwpXCtJqj
         RZLjn/6DsO9C30o4+Pun1L+6OOq3mGAGXuZ0wJffDxpTPY6sRX+oauvEVvBWdmHSwgwL
         XQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779120; x=1779383920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VvoldeyhbT2l93d9aPm/XKZKdD+a0k6CNpfmqR4nviE=;
        b=S1sbMJOA6pzw5xV1yg/Fs8vnxx+VjFtgloj68E+7cJYsNaQg5ew5tYWkGCe2s942v2
         e53xFXgWrHqvV7JWQk4+DRzwLfrx9xojo5aTIB01qbmkrFbTR2wsICTcg307TWHY7f+k
         4ubq1iqozEg2QC50KV6b0WKxlbUJHnYyN4lcuBYJHZd2GIc1aXosmivbnblbkAmsOhme
         1bGWYcTqFFGXZJRFNK8IYgv99GDLEEisO8mCqm/ZZw4j7BgjJBPf2TwPVfazQyeF4Kob
         LK2FGKxPKkyWSAyJf9Y9gVCJZtZlHqrj14jfds9yf9o8gwXGU6M80RNgBiIjMazEuQSQ
         itjQ==
X-Gm-Message-State: AOJu0Yxl4D8AmF6uOVNW2EgMCTuEvsKRgqs45zarddUDsgXT9Gix0RkD
	TBveoNIpMC/mmLfZPTm7oNdtRD93MceJDZJAbeaDvdH0Qy4JOATTsDvXpNa+WukdYOK7CB8KIAp
	45mZ6IhG7JcpdrYdkvXd8Y+Q+FkRboq8=
X-Gm-Gg: Acq92OGKpbhCiyZu1MjRC33EufoB4/lOoUAF4eVzJUadZLkL2ikdp5WSG6s+G2IlCm/
	cd3i9r87Ma0+rvM1j9qRKkN4xPJF6kq52DDDKD4BOxwwxEpBtmvY0RKpSIhx0WsIvOmyIhk8qtv
	xPKcePov13oZdx5ptt9T4XqTSkpla1o55gn1UW4aWaLCxqnPhkMCdliio47NI1QkLaFh3NGFPWU
	YWP/xsHJbL31tZ28mq0X36RnpvNbRwldyb51pLaPcsoghdIgO0F4D3c/YSxg2ZLBOfnNrcblhZD
	l2yOf7dActcCGssGiwKMRJTMzGwN6PwEfw+3Zbg=
X-Received: by 2002:a05:6820:616:b0:696:6585:a51 with SMTP id
 006d021491bc7-69c942e319bmr261130eaf.13.1778779119920; Thu, 14 May 2026
 10:18:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509122238.2792915-1-mmyangfl@gmail.com> <20260513174234.3e78e67b@kernel.org>
In-Reply-To: <20260513174234.3e78e67b@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 15 May 2026 01:18:03 +0800
X-Gm-Features: AVHnY4LSbn6JKEZowiz4Xr2sSFf9Ew9t4Docb_tRV2PhEnE6ECq4wpXL3aJLLHU
Message-ID: <CAAXyoMMJygZe6Z5=fDoLBGYYynQ=a7DhQAM1as-st4EHV6ceNg@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: introduce TCQ_F_IN_HW to track
 successful qdisc offload
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 62E3D5452B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288052-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 8:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> I read this 3 times and I'm still not 100% sure what the main problem
> you're trying to fix is. You don't know if the DELETE is for the
> offloaded qdisc? Can't you just store the handle of what's offloaded
> in the driver?

The point is exactly NOT to store the handle in the driver. Only mlxsw
and nfp handle TCQ_F_OFFLOADED correctly today. Fixing the others
would mean repeating the same store-and-lookup logic in every driver,
even ones that don't care about the cookie at all.

But I'm open to other approaches, for example driver priv in struct
Qdisc, or removing the seldom-working TCQ_F_OFFLOADED from
qdisc_offload_dump_helper().

> The qdisc offload is a bit of a mess without a dedicated maintainer.
> Sweeping changes like this are a bit burdensome for the core
> maintainers..
> --
> pw-bot: cr

