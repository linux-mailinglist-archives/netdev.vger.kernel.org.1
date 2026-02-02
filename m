Return-Path: <netdev+bounces-255854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDU2ORSXgGnL/gIAu9opvQ
	(envelope-from <netdev+bounces-255854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:22:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DD4CC4D2
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF26A3006B5F
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 12:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B2B361DA3;
	Mon,  2 Feb 2026 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1KZL/wTg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88262D060D
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034962; cv=pass; b=H4ExDrXfTcW/dd3fGcH3LMLvBzieMZN73DrlnqUuB1sUeBqUAV051W/qbH+fWHTr1H0kXXQoGmmTd6qXj75N+qDVClOiCmvjIR2Op1hodNljBGbR0lg3bjoK0fkdBXA32ax/lablC8LoEBgNQl5uevRTJTPajckxGjE6W3COmMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034962; c=relaxed/simple;
	bh=9pfwSnYRbuqMRB57vP+4N+UsP6yRFCNRCgCrL1+OKPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F48e/YhF93/qy1joU/Q8+C1J0QuDWevZducOkTL4ejIpi3ojlseXfE/HKF+lbnJLxOEy7Wuc+vr0jn5zz/mC48K6bUSh/ihU4BbhiQ5ij+djRo5OU4o21ud7SxfuFSqoW89TODGNc853JXURbBwOicUWFgjZjB1xPwc/EA5H+t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1KZL/wTg; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5029af2b4bcso23851391cf.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 04:22:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770034960; cv=none;
        d=google.com; s=arc-20240605;
        b=Pnfq2DDhWl4Llrrg+cMub+1RowZjZdxSqVfLH8QjgBXQ7nm4V1mswW2HzawOc4DFtm
         0bcRSdc5gmPpgtTN1tRFs2XsryqFpovsJdhZvTa2UUMlZcE1Koky4K3F1EjO52faZckR
         Q0QzSwiaP88f602yuFcFocy1S2YA7dxTDpviDUixhDjzRV+diuBtNVRgRD4lZGGsBcmm
         PJPadCf/02MlzEQc2SgwHtFkl+t3CTJrf5WiOKbV4jmlRd0SprYz+2qVvMxxI9ARl1mL
         S7uZq7bN3R7r1eDLXU3kVuUVQs/Z5a8BXd8ki1SU8ay3wd6pfa2+KwFvDibmIjLjCTqb
         bMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9pfwSnYRbuqMRB57vP+4N+UsP6yRFCNRCgCrL1+OKPA=;
        fh=8xeuYFObQOYk989QdWXuM9sxZUi9IVaU7nKSL7S9QrA=;
        b=lvjM9p775EpfpmpttwWcFOuR3kfKeoPalmGUDZmOzItpMLrCFHCks+uMAPTVdhKrlz
         6mco4Q82m19mjmzlyv2OWHaX6ZP+34OXJpqWlkB11WaqD4QczRx9Ai+k6TpBC8rlktsk
         +FA2cx9gEIEwsQlVB9tWpwV0mEeA4+CnM7A2UCMppdhe6fc+04aVD+Lb/gTdPVvYy6qs
         vcnX0z0MYXWnX6n/Yl4bixLosVLEi+I+Diso+Q9J+mRmjWOxh1ehRhUU4QLfypUaWNi2
         dIZl4Nk0EzSIjGl1s3SH86iHDT/faM5IJ9bf0YKVWBiTpvSi9hnJ1E13tHfzhiF5rdH9
         vrDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770034960; x=1770639760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pfwSnYRbuqMRB57vP+4N+UsP6yRFCNRCgCrL1+OKPA=;
        b=1KZL/wTgAQse6U0No6nNXtbbo/oLIL90JB4EH8oXLM/7VVwimrmufuFL8rHuNgV9eq
         yRXJ0K3bpzXiajQ6vB2NVlRW4m0Q+kT1n4Zn3ml8x7RUEzfA0gfBzfVOi/jw0xgWaOfD
         7D4VMkLdB6VElXXGX9QPEXfwLYmJoGcJbpDTR5DgANgIA2QksNnaRBTIVdRWFgAC8LSY
         PfMRitsnmA+ENOPPWOdesjy1VjOpKMldC/AbNEyFzL3DOf5yKeC/3/2tr9feC2uB+gRK
         OXXTqruShJK7Sg/T3sNvEwyOJPFbY1ZDjxuzBLQFMUcje/KwbWOT7QcbSExzZa78cdDm
         QJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770034960; x=1770639760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9pfwSnYRbuqMRB57vP+4N+UsP6yRFCNRCgCrL1+OKPA=;
        b=jmQUbXO7TA3To5ZFvUDcRt5ryYzz0ZOHhhdBmmKxQgxVqmRzjGyOO+pQaIiuE9uRJR
         sPuld9rmJkHohjjnbz2iVw9KdootWyWtza/m1zowEYV4pYNxZagzk71o4pQRE21ucwiH
         CEyPgqHS6JUzppH+yPxhZvIjynR2ddaaHuZtZ9Q8aiNtGBzhtNS+VtaDzlWJBemnfRx8
         MQTS/4cU3Y3IcMCyjRh7cn4KRscGmsOuLGE5mOd99S++1lZnAalZ3lGSaXxLfxqBKNU3
         agYk0UIrU8sKslT0HXXe4qu0Rl3rOR0m78dhrs0l6rplZC/J39bRy1iF4ytsRSWyxaWp
         086g==
X-Gm-Message-State: AOJu0YxHFWe01ry+dhyMdiS1cnyK3LTbQimQBj/Z9C+wfC9WG/Tt3mIk
	6ByaxOwYarFP9vFbMncYorOXK+RmB4/KPdweWRH53nLQNkFtsScWpfZE6BkWUiT5vpIAM5KWjU2
	cQaLRH6WEOVFsNurYBykAR25M1s27zfewEeXKd8h8
X-Gm-Gg: AZuq6aIhPDjiJxhiCCn/rJEpqXtLlBCB57s2m+jzLudCCwMJA2X9tGVDY5H/+1d6whr
	HgDA9gK8a4Cu36G3IjxtfFDvOfyLiWrqvOXm7fo8wABo2KpCxunNKjQiy0JPEZG8kdYrVjaWKga
	F0fFsDzUNfR8udv16zXuTJabqL9kZIYHZZox47Ke/rgOgEM8syra/KZk8iXRjpXvyg36q2yHRhS
	9LLWJCtABguoV76gBMjefvpqAhdTHrJhezvrv/jZSNl8BwMJNYOR3QJlXFDB8jkMxI1Jcr9ivHU
	kZCPnA==
X-Received: by 2002:ac8:5a8c:0:b0:4ed:b83f:78a3 with SMTP id
 d75a77b69052e-505d2264074mr140685471cf.47.1770034959265; Mon, 02 Feb 2026
 04:22:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770032084.git.pabeni@redhat.com> <562638dbebb3b15424220e26a180274b387e2a88.1770032084.git.pabeni@redhat.com>
In-Reply-To: <562638dbebb3b15424220e26a180274b387e2a88.1770032084.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Feb 2026 13:22:27 +0100
X-Gm-Features: AZwV_QgvBa-oT_GRK6FHEVAJW1yt1Df7ZjFVbgtcNuFODuwiXmakPwocOjt-MqY
Message-ID: <CANn89i+fAQ3fCvJwmCJ9gvN4Yx9Xms0hTMdPrJs_qLnNnZdL4g@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/2] net: gro: fix outer network offset
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Richard Gobert <richardbgobert@gmail.com>, 
	linux-kselftest@vger.kernel.org, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,gmail.com,intel.com];
	TAGGED_FROM(0.00)[bounces-255854-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 73DD4CC4D2
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 12:43=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> The udp GRO complete stage assumes that all the packets inserted the RX
> have the `encapsulation` flag zeroed. Such assumption is not true, as a
> few H/W NICs can set such flag when H/W offloading the checksum for
> an UDP encapsulated traffic, the tun driver can inject GSO packets with
> UDP encapsulation and the problematic layout can also be created via
> a veth based setup.
>
> Due to the above, in the problematic scenarios, udp4_gro_complete() uses
> the wrong network offset (inner instead of outer) to compute the outer
> UDP header pseudo checksum, leading to csum validation errors later on
> in packet processing.
>
> Address the issue always clearing the encapsulation flag at GRO completio=
n
> time. Such flag will be set again as needed for encapsulated packets by
> udp_gro_complete().
>
> Fixes: 5ef31ea5d053 ("net: gro: fix udp bad offset in socket lookup by ad=
ding {inner_}network_offset to napi_gro_cb")
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

