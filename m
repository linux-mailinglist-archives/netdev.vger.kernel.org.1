Return-Path: <netdev+bounces-255282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIH1OuFKfWlZRQIAu9opvQ
	(envelope-from <netdev+bounces-255282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:20:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42120BF9D6
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B260A3004C59
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 00:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318142F0673;
	Sat, 31 Jan 2026 00:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEvZzNem"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37B283686
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 00:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818847; cv=pass; b=pPw+UowsSo4P+zl7jLvIYRLuWwPCjNnqHPsPy2e/BZHkZx0yxTwuCzgC6Hk7UG9qLAQFndBmnT94IVX9lNzv71TQM9Zlzgz94d2MfowaDLAwt0xueXEzlvRfPXP6BVy1qPQMSqQ1uLMAF4GJ1tEAw74iWP6ZolKLVu8jt0HQydo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818847; c=relaxed/simple;
	bh=BxvFuJC0bIZLCHrCpS3SPXZeathH+1ZgXjBGfDE8li0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L//h59YPeTUcYIoE0CUBwBh+uj14PCGSkuqjS7pFPC5rYOT4NRr7UGchoUHJQEtokn/gVZknLu77ezC2mdjj89qRXlMw9cMCc11tglYaCImgw+H9EPjqUwqRuPBFmTKY2/U5E81NNUUxby+MyTjX9LfY+nuRDMWgLy3Ikyjaux8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEvZzNem; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8947e6ffd30so32222776d6.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 16:20:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769818845; cv=none;
        d=google.com; s=arc-20240605;
        b=OQjLoanPewQVFCiiWwuQaWWHczd8H4DSdZnTx/h5xz7mtJhlBVGv8F4O2q+v3EAl6/
         tFmMkLtKUalnXLiNaj2a5//8C1JLu2qutIDjtsFg3jNp+GTxILkfZHz+prgVsY6OFPP/
         AjDHYx4cHgZEvxk2A98e2a2lD/jmh5T7Z0Bt7v/szF/LNRl66sD2KzPdJleM3Wm1Px+X
         cwsrIyCOFVnqWDP7hT7ecr9BjVoRPMEQgJa7z6dI0U7ip0Zd/Z8hmTNnZISVJ/xKq1LT
         fQwEutJVvn4qCPeBDJ1Blb+cO1JAkLFho/D+1Z+58oDPsO+2XVRjnkbRcYEZROCE3BHp
         hlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BxvFuJC0bIZLCHrCpS3SPXZeathH+1ZgXjBGfDE8li0=;
        fh=M6DBnmXk01vJZXT6LcvJlKrL0Q3rciMXhrE+yDJvfoY=;
        b=T9tkI/kBf9kmSzXOkvXoMAxQTkbA9y+cSlVINZP4NHMKRFclLN+fdaZJRgGGyrxIWc
         dNlaXmoG6lcOHc9wN5ymSGFrCbpiB9pwMSSUsetsHQ5EBeAj6I21boeenBpWelzIzgh7
         hZWzZGs2IBYpKu8Rr2Y7qNKYcSdItIv6hB/L7BNjKacfPpIkN9KxEGn8xowPBCtJxrSR
         3WiXyonN6B6KBDF1bspU9tdIUKdCGuHLA6QhVO3e3pXU5MIb35dSpgmsA4Nzo46CHt+c
         By7tcwjiywGX+6DzeZdF64xo0USOFDziuZv2YBvmy54o1svmkNg4ic6xh8pdvSYocI8p
         644g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769818845; x=1770423645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxvFuJC0bIZLCHrCpS3SPXZeathH+1ZgXjBGfDE8li0=;
        b=BEvZzNemY1yqb7XszHK6CD7Vz2RG1j/6mzwlx3M4de5X8vDvpXWVXLOPN1FIQa3enm
         6+Ak/lmT9ipPI+byMtCpG11kXjZIOkInWU/7P3X0nGSzlK17a0s5OaYjo6Tk95u5vST2
         BeOF0hZqwh2NuXpg1FjOOummNDsk2Iagrivr8w47AK/Q+0z9a6mzE6uEkePKdQHQ5ctg
         C6+HM21Ocem1aV4Yz+rt7secOkkxt39R4smUTD5aKvR7xO1heKrDKJkcB5eOlnxECBws
         gNhWXmXnZ1BqjLxuYAQhRjGU9qhFrZB3aqJSQ0SpPbqmnBAbLspkUZxKxxZQR6ANjG/V
         82Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769818845; x=1770423645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxvFuJC0bIZLCHrCpS3SPXZeathH+1ZgXjBGfDE8li0=;
        b=llQ0VkgQEvlW1hdEIqlSD+u/s+yfXfllbekExGtWfEqFySIkuW5hE8TSc4PKmnNTZ0
         DprVhHY7VOZtVLjOdN2hohtdIKZFh8uwJCKZ6qeI+mA7pl/HgFjRmaQ9Zo0Ff1oBC4fq
         /JLdmL/mPYn6kyCW4+jLnYrMHXzTuB7ObBZDQ1Sg6NCCCyuvwFK1Z0mZqYKuWy83SUEv
         eNRxZgD9X/sIQGCaQ3G3Gj05RwLv0n0b/mnHot5S7u1mt2G5KlBms8xJsg2oIn3QHSzI
         YA9+Iou0hAzNQchGVTkIHqM3Bs5n2GjYG7cy7HjX+pJfqGOPUTDT3Jg4vyoGuv0Nk9bH
         9SoQ==
X-Gm-Message-State: AOJu0Yx/Ej1D9Ahq87ARA9wpp85ay6/DI/AjxCyjLBUqstbUGk4LIOL2
	Xi1gzruUlNapaIIRs0ylgQewW8zL+fL+JF+wh/zttfZ3tJKRbFyeeWtnOfclw/QO6z7m7yTQfiB
	vYCtdCM9a9sAOh+/e8jodYZ/pFtUVduGq0t4lcno=
X-Gm-Gg: AZuq6aIzOV5QF1JHZq/LlYpAe++B38ScVm3XoHXanGe1xOk5fKY+UR5nfvv8HPZdkty
	ZAMixQuKs+fV29I6jLmaTPcLvQq4qL5lGew77VT6915uq4NJEJ9+AM74Ejh78bwI5CeBSC15YF1
	f633DpRQZ2puiGWKJUJkVKpYuFUNk8H5ch1L6aLgT+pjThYCSAMEjypE6TQLDs13mVh4A9iqa8P
	PGe0fhaEIkE1+yZ0QA/Q0h8rEQDIsuJERmM9lL4BQxsImvaU3oYxSaT3BblbHPlGCdHes8Jp7se
	YJnlW7n+ZwVxWnxd85mH3jDe9g0gA37V+PKVHsKDNk7pWGIHnYni9sUk
X-Received: by 2002:ad4:5cea:0:b0:894:7e6f:f92c with SMTP id
 6a1803df08f44-894ea11702cmr71373576d6.58.1769818844692; Fri, 30 Jan 2026
 16:20:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130093412.98407-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260130093412.98407-1-xuanzhuo@linux.alibaba.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Fri, 30 Jan 2026 16:20:33 -0800
X-Gm-Features: AZwV_QiONEu0gkSuPS6SfVZkmenzt-yOhvJlJ170RUgBj563Xy1w4BI2i3y3J2c
Message-ID: <CADkSEUhHch7E9rfb5UQ1XRZRhF=vGx-B5J5g1QATYrXxh2L5Qg@mail.gmail.com>
Subject: Re: [PATCH net-next v24 0/6] eea: Add basic driver framework for
 Alibaba Elastic Ethernet Adaptor
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Philo Lu <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, 
	Dust Li <dust.li@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255282-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42120BF9D6
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 1:34=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
> Add a driver framework for EEA that will be available in the future.

Hi, Xuan,

Would you please remove me from the CC list on future patches? I think
I am only getting CC'd because I recently edited
drivers/net/ethernet/Kconfig.

Ethan

