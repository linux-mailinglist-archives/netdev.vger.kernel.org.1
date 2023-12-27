Return-Path: <netdev+bounces-60382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB13181EF2E
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 14:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D95B2144D
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763F44C83;
	Wed, 27 Dec 2023 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQqubKd3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DCA45947
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbc648bed4so424742b6e.3
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 05:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703683421; x=1704288221; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3KiUyWQVZegOM1Bky0WUmul7VbRjuI0JPtLHWl7GeM=;
        b=jQqubKd34yo+oKKFrXNrFbaZVHHNY5Vh8XBHkZ3c+2+i0AzHVC18xbezRlSl0ARrs9
         CcNJtro1BGnU9jVsSc9Cv7EK8eTFGRURewm5R7/fN9M210mNU2qbSOe3UciXAb0f1o6f
         rpZ/2mIGNAWvXes79woqUi28AKN5omNoMMe5M45TuyDsyiISMW5L+EmxSSQByXbmRA1O
         nzAlIb8n1JuOYObiHV5ya3c1/oRQ2uuPkht2czDbnJWNo/g3Nj+X4o9psYy5j6ceYjXP
         5njf1o0FA0rZ2DK+2J4VVF7d8tWabYQwAD9w47r0n30NB8PPGd0UIamf2q2DP1/OqYGn
         wRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703683421; x=1704288221;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3KiUyWQVZegOM1Bky0WUmul7VbRjuI0JPtLHWl7GeM=;
        b=hEGDdPPBPwAKrN8T3SwGcUIy9uXgDwqW2FJZee5a45dcSK606NSWkxkA7dSdNu3Cdv
         0zVyLYJocXoCUmbDqo58PMxOqUQepK7+PPy08d9/vAMJ6nJ0pvg+4B18jrZaRG9BPBRE
         tJKnCWqn+0VmE5fgbAzcIr9eVi7MrLm/eXxRQ2nFd+6Yn16KNELJXMm4rRtO+dDBaxqK
         yNx0lRMWgcESfa6PvVJHPeceOzF+WCYZ/kXb2IxdJVBLi7dU6jtkeEhhq2JJ9caZJUgw
         Qijs54Jg3SiwvPLvuvNWqcUB0MnIcuSdP5Lg+Nb7jABQLWDmRv6hVDed8JVXQu6/d2n4
         TEbA==
X-Gm-Message-State: AOJu0YyDIt3SCKBuUvfvUStdci6UlZWsILaF6l5XyEVG4IAPyWArGUM1
	oVuLeI6D183z2h5OsnOMQHDU7zE3jI2RciRGvUvNt4z4cks=
X-Google-Smtp-Source: AGHT+IGoxEspM/lnJh21MuFrVdqonIyFcy1MpU1ubUcyhtXWVlsHpNT19vm5ricGJW7e6/um8FqawHsQ5m170cdcbjo=
X-Received: by 2002:a05:6808:e86:b0:3a8:432a:ea13 with SMTP id
 k6-20020a0568080e8600b003a8432aea13mr9579205oil.46.1703683421148; Wed, 27 Dec
 2023 05:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK2bqVJPOE85VqfCEU07sjjE=530D_ac_AgcnFB6GdFKzN85AQ@mail.gmail.com>
In-Reply-To: <CAK2bqVJPOE85VqfCEU07sjjE=530D_ac_AgcnFB6GdFKzN85AQ@mail.gmail.com>
From: Chris Rankin <rankincj@gmail.com>
Date: Wed, 27 Dec 2023 13:23:30 +0000
Message-ID: <CAK2bqVLX9PTQoeWw7rOP4Z3z84bqT_k0mb-y8jORWMNx-v3LXQ@mail.gmail.com>
Subject: Fwd: HID-BPF fails to initialise for Linux 6.6.8, claiming -EINVAL
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
I've stumbled across a BPF configuration issue and was wondering if
anyone could help please?
Thanks,
Chris

---------- Forwarded message ---------
From: Chris Rankin <rankincj@gmail.com>
Date: Tue, 26 Dec 2023 at 11:06
Subject: HID-BPF fails to initialise for Linux 6.6.8, claiming -EINVAL
To: <bpf@vger.kernel.org>

Hi,

I have tried to add BPF LSM support to my 6.6.8 kernel, but HID-BPF
fails with this message:

[    3.210054] hid_bpf: error while preloading HID BPF dispatcher: -22

At this point, I can only assume that the Kconfig rules are somehow
incomplete and that there is a missing dependency somewhere.

I have raised this issue as:
https://bugzilla.kernel.org/show_bug.cgi?id=218320, where I have
attached my kernel config. Can anyone see what I might be missing
please?

Thanks,
Chris

