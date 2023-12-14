Return-Path: <netdev+bounces-57326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB1812E40
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A871B1F218B9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0980C3F8C2;
	Thu, 14 Dec 2023 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liQXxm2m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BEEB7
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:34 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c2a444311so77122745e9.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552353; x=1703157153; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGDHADo7C3NaDRc+ZRm9nq6QxuOQpyaoDXW27f7Yvxg=;
        b=liQXxm2mcqkC+yalyEpXo+Y4+ftqIqJGmiQDyZLuQKa4rJGBdhDIJBXpAPj40rtlsm
         gnWWE2K5JC+Y4KKwPT6dq9YGznrOJJyv5dWnxcYqteBeEdZOO3cno0umoA3fZD4muYOp
         8ukbYu/LtVRvTEhHoqvdTYHRloIYVKQ6kae+38LXp3sAbQtH5SmDPFkl4z9rlpWXBz8R
         DZR78QNAa5wiL1Z/cjjw7iyF10eqUSnw8Lyhn1TUQu6lolb6Cv6+3cwSe4HK0hwEQBGO
         DxE9u29nlkbo0F3eTvxf2Imwual0IdYkM2assKwD6FfaHt0UUgWB4fPljP6/9IrVv5cg
         qx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552353; x=1703157153;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGDHADo7C3NaDRc+ZRm9nq6QxuOQpyaoDXW27f7Yvxg=;
        b=IQLBIQP3RxqG+BF9eL/+PtSZqgz+ALSkEfs41pXHyPNa1fHhRkCbY0yuVzVDmEtNrj
         6f3MJSlJLj3UvYV+eTASwjwXH06XH5BL3CeMn9t6RbGRP3Mq3N0Gos10+Xsbx6QbJo1t
         gtVXDxmEaQ8OTlRs3bGzVzmflN5gpvntP7G6DdVuoYMo8+SPLeYzC6nLX/rWxe4WJAQ1
         nQbm6RnLZ2x78/ZOkfsVZ9DiP/iU95yrvyxdHtzXVukBSO80mEpbMoKKdJ+8UY2VsTFR
         VTmiyJR3ngrdi2GsYPSXwjuLjesI0BnQ7tiFuttRpLSaKxOIMEZMQd7t9Mqr6XyTNDrO
         1xxw==
X-Gm-Message-State: AOJu0Yzfg9ou9yz9GZ///XaNlvVXQJg3H4lk+2gh2D9A7JqZOtHoV/oo
	ajB/URt59ybAQEmZooSCeVc=
X-Google-Smtp-Source: AGHT+IHQq2H06/ajaLzf9ecb2zQvKQDlKeASRQe+NPs3P0RofX1vL7E9lJ60bUJ0sWpUFLobinZ3yA==
X-Received: by 2002:a05:600c:4fd6:b0:40c:38e2:8e51 with SMTP id o22-20020a05600c4fd600b0040c38e28e51mr2872515wmq.13.1702552352652;
        Thu, 14 Dec 2023 03:12:32 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b0040c4c9c52a3sm12581213wmo.12.2023.12.14.03.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:31 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  matttbe@kernel.org,  martineau@kernel.org,
  dcaratti@redhat.com,  mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 3/3] netlink: specs: mptcp: rename the MPTCP
 path management(?) spec
In-Reply-To: <20231213232822.2950853-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:28:22 -0800")
Date: Thu, 14 Dec 2023 08:42:48 +0000
Message-ID: <m2o7et5g53.fsf@gmail.com>
References: <20231213232822.2950853-1-kuba@kernel.org>
	<20231213232822.2950853-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We assume in handful of places that the name of the spec is
> the same as the name of the family. We could fix that but
> it seems like a fair assumption to make. Rename the MPTCP
> spec instead.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

