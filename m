Return-Path: <netdev+bounces-46236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E587E2AE0
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 18:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F8F1C20C0E
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B929CFB;
	Mon,  6 Nov 2023 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VwIwIdXi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC328E33
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 17:22:54 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D88883
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 09:22:53 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a839b31a0dso96168837b3.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699291372; x=1699896172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjVO4sAOUldvg+TEp1bCwrL1tOOGvg0o40qn6OCIZC8=;
        b=VwIwIdXiX+TLbRGw0UvGHUurRaoakukQMkmKW74P0yPY+xlXzMEXWWiOEO9lIGg7hw
         grnI/qVl46gvJd/TOut+dB8kdOwu0fjYs24gQdoYWddP/fXLvS6w7fz8ea9N8Q/3avpi
         1lsqd+3akYpQ4VPgENRbzYLe44b4oupSWrNcvX388tszuJMfeepWAYkP07cenkoS72ui
         vt2y285MhnSyIEYejGXhD6/vZ61OO0ueVpS5YgQ7davB3gMo1VybB56EGtz8iadrl1bB
         FRTtV4sVheNFuqf1wi0cEVW+BgANYhxyz56dUR81/FIfbuLMjRtyTceZcfz00SKpqr6z
         IDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699291372; x=1699896172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjVO4sAOUldvg+TEp1bCwrL1tOOGvg0o40qn6OCIZC8=;
        b=nTcFkgH62Qn9zRvcsApNTnSGf0nwxUhncEmPX7fxjMGR1s2GKjt0S1V2JOKFhARHt7
         xMKXPZG0Slz0SI3NHXvwvRnJW2fzbzg+TqbUX7CaOr/+T1skJq79fLLQUFQhCAWmMJo7
         vfoPZedLhoMWbjt3WmcvTwrZKgE/3D0zMhRgEHF2b4a9ZxFzksJQKU7FGTMflaO27Wtb
         DOCYZBFlyS9FCD5CXd7NytkPKE1eXJrjPzOIJZuA/9tOVAWAOo5ws61ZAbAXzNEmU1uf
         WJUkizDy47UU/AOaBwembrg3anTtIKfko9Zvea9m/9mNOp4/Q6xwb2fayXV5KD+dRuMq
         8UDA==
X-Gm-Message-State: AOJu0Yw8hOqJZ5u/MSvuvke6aNmEh3v2QsQwDxFVM8ucqsBL85Z7chRp
	dPeqon9n3YtyjTQo7GibMmO1oFI=
X-Google-Smtp-Source: AGHT+IEVyhpt7fUPpfetx4DKqxAPIdrCZ9TLvPSLhdEldLH64LuoQvzQ4YdpQ+DKn+WedQWV80lSuck=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:4f12:0:b0:59b:ebe0:9fcd with SMTP id
 d18-20020a814f12000000b0059bebe09fcdmr202804ywb.7.1699291372467; Mon, 06 Nov
 2023 09:22:52 -0800 (PST)
Date: Mon, 6 Nov 2023 09:22:50 -0800
In-Reply-To: <20231103222748.12551-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103222748.12551-1-daniel@iogearbox.net>
Message-ID: <ZUkg6rkp0bGz7Fkt@google.com>
Subject: Re: [PATCH bpf 0/6] bpf_redirect_peer fixes
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, kuba@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 11/03, Daniel Borkmann wrote:
> This fixes bpf_redirect_peer stats accounting for veth and netkit,
> and adds tstats in the first place for the latter. Utilise indirect
> call wrapper for bpf_redirect_peer, and improve test coverage of the
> latter also for netkit devices. Details in the patches, thanks!
> 
> Daniel Borkmann (4):
>   netkit: Add tstats per-CPU traffic counters
>   bpf, netkit: Add indirect call wrapper for fetching peer dev
>   selftests/bpf: De-veth-ize the tc_redirect test case
>   selftests/bpf: Add netkit to tc_redirect selftest
> 
> Peilin Ye (2):
>   veth: Use tstats per-CPU traffic counters
>   bpf: Fix dev's rx stats for bpf_redirect_peer traffic

Acked-by: Stanislav Fomichev <sdf@google.com>

With one optional nit about indirect call.

