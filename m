Return-Path: <netdev+bounces-279691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE9nHlDk5WkupAEAu9opvQ
	(envelope-from <netdev+bounces-279691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:31:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8B842828F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E17A730164B2
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A73A2BB13;
	Mon, 20 Apr 2026 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxud+BDQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577042D8DC2
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673868; cv=none; b=rnAbz7KJ/vRyrljXhJfE1hhPH68K4Z7sMxzsKAgVEiInV3Kep5ZkriCx4FJ1CbhK7qHqQFoLJHTEmpFCeegDRM3QMOxemu0I7c80dgOZd0QnH6IJVxNXegN3OW6aupWyepHcZqYymEuux6YoBiokLS64zOTku7iQm9dLYIavxcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673868; c=relaxed/simple;
	bh=TkxBkpxIkLfIlBiUOnE+RSkdH2oRaYJgDneP5SU9m9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1K/qtfo+I1LTXYn4XiCVHJ+4bRvATp/c9VDemoJt3Ur8EuKGmrH+wVPHX/mtvUn0FqcT6Wkb+wf76QJ8cd817FJ58SnFUAj5a+U3uICRn0l789b4ERDYag/xM3q2FCh6OGIXsD0hqZjKBaxX8LUL+BU+ZP+Pg+5vEtM6+MPxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxud+BDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED491C2BCB8
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776673868;
	bh=TkxBkpxIkLfIlBiUOnE+RSkdH2oRaYJgDneP5SU9m9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uxud+BDQSiTa6Bs4hptkPn+00Xt41mVF8mW0o+nR9mbPg4KDp7Ep3EsJ3xWz8yo14
	 GE7FPgmMe5IQ+wDOveCrb7tKe0B5xoNKds69fA4KbiZ2GZI778TSTUXgEjT7iC8Fr5
	 yswgdkUDqg8d10A064DuZ1GQ+vegOru820herN0X0LSqL9TA8taYWCRukaElNAhHzo
	 JO7kRsJwlx2YW5KLNMCwzjUB9mpP73omTQCKIMo+rb+eoteH+NbuVenDU9Z527fzgJ
	 54wQfokGlIhI+FJGfE2aEeHhLp3QtPpa6ZtkPow7hk74g22yf4flb8S0F0XITGY2Wg
	 uujms7QDQxn6Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so2720953e87.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:31:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Np/VK9GZHaDjEGWps1vzSlgl+Q83tEGcscEVgZ4Sg1tQbFFUrInwIGBUuKY0yUHldgNc2N4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw27UGCd7QYkOagcVl6GUnwNqTsN3mCTJTWezwiV0aTa7VWM28b
	MGEgHAYaPIMjF8t20Qy4c47t5uvFao1jcd3ktxWgTRZ0+3F51gM//0e+lXfa4nFhYQ9dpxKpeBx
	ZVXUSPhq5kbsbKAssxju7sp5gczGFyjM=
X-Received: by 2002:a05:6512:2208:b0:5a1:3f3f:a29b with SMTP id
 2adb3069b0e04-5a4172bb1acmr4057641e87.6.1776673866600; Mon, 20 Apr 2026
 01:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416182829.1440262-1-kuba@kernel.org>
In-Reply-To: <20260416182829.1440262-1-kuba@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 20 Apr 2026 10:30:53 +0200
X-Gmail-Original-Message-ID: <CAD++jLmBxH1Zubh2avWrvMs4L0zv1NU7WEO3D8aeGiiVZo5AdQ@mail.gmail.com>
X-Gm-Features: AQROBzBS1rwUfJkxu4I1Uao8rY7kY_R00Kb59THitu5QitALyMHIJTX2479zrZI
Message-ID: <CAD++jLmBxH1Zubh2avWrvMs4L0zv1NU7WEO3D8aeGiiVZo5AdQ@mail.gmail.com>
Subject: Re: [PATCH net-deletions] caif: remove CAIF NETWORK LAYER
To: Jakub Kicinski <kuba@kernel.org>, phone-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, alexs@kernel.org, si.yanteng@linux.dev, 
	dzm91@hust.edu.cn, linux@armlinux.org.uk, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, xu.xin16@zte.com.cn, 
	wang.yaxin@zte.com.cn, jiang.kun2@zte.com.cn, jihed.chaibi.dev@gmail.com, 
	arnd@arndb.de, tytso@mit.edu, jiayuan.chen@shopee.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279691-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,armlinux.org.uk,linux.alibaba.com,zte.com.cn,gmail.com,arndb.de,mit.edu,shopee.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA8B842828F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 8:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:

> Remove CAIF (Communication CPU to Application CPU Interface), the
> ST-Ericsson modem protocol. The subsystem has been orphaned since 2013.
> The last meaningful changes from the maintainers were in March 2013:
>   a8c7687bf216 ("caif_virtio: Check that vringh_config is not null")
>   b2273be8d2df ("caif_virtio: Use vringh_notify_enable correctly")
>   0d2e1a2926b1 ("caif_virtio: Introduce caif over virtio")
>
> Not-so-coincidentally, according to "the Internet" ST-Ericsson officially
> shut down its modem joint venture in Aug 2013.

Reviewed-by: Linus Walleij <linusw@kernel.org>

This specific code was used out-of-tree for modems M5730,
M5740 etc used for minor Android phone brands such as Sharp,
Motorola, Philips.

However it is also used in the Samsung Galaxy S 4G, so
let's page phone-devel@vger.kernel.org so the possible
audience knows. PostmarketOS is not actively supporting
it.

I remember that I advised Sjur to use virtio for this project and it lives
on through the generic contributions to virtio that resulted.

Yours,
Linus Walleij

