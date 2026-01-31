Return-Path: <netdev+bounces-255370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOe5MP2efWm8SwIAu9opvQ
	(envelope-from <netdev+bounces-255370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:19:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E105C0F10
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23CAC300BDAF
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F091DE8AD;
	Sat, 31 Jan 2026 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xvPqHT4X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3F78C9C
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769840377; cv=pass; b=ab9XCFc74HBpwJR65P/y9OdKoK8LpG2vj3Esa0hZFQE5XSjRuH68rdLiaAvpq3q58fgGk4V2qg56khCpxUzGVVuleydgeMywidhStk5DV5Ah2fhvMbsJO4Eln9mqBOWbWnv1eGqNuzukKj//E0UoHI5e5jtCc03p5SbbrG+Ldek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769840377; c=relaxed/simple;
	bh=KF3DAM117mRq3xAEdyccMs2mLI3w9haBUoX0n9LKOJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqwEt6mAHVcFSz9+/+6cu8ggukx8H//4Wq8Ro7h+lyZ6so1AgeV2hiFFB3Zofnbo8zRwKS5zb7DZ2cbtptiIdFtg576aXYYzzyagGqo7Yn2npBuIDNguZOL3X0BGyC097gWFzwYGRW+TThF2WAmoMKMBHPGMJkRZVwpfgJMyPNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xvPqHT4X; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12331482b8fso4002111c88.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 22:19:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769840375; cv=none;
        d=google.com; s=arc-20240605;
        b=B629h7a13ixjv9a17gCdxgmuw5aPS9Hu/96ME8CFAYTvJXV3K+tSdrF7bjAswZobDj
         tDyxATvE7PEJuusid5skK9j3IKBkY9ck8qtvimWGph31F9YcdI9AXqJhd/ioaNpZdEZk
         T1RzBMbd0hh7xyrwJrWxllyA9REqKC7KNWGt97n8j/8NQFUaV4JbJaBIsZRBIDUKFG7T
         Cxclwftc/DYF6CUtbCjvqbUNILsSWp4S9j8w8u6FqZEcXxAOXj+gwYo+4UtdP5uVCpTl
         xBVdmwmLpvbI3/QwBAWNfjkHRKm2EhFPfFGWHUVH57dwz2YY7wRazAevLpDjsrzrBqol
         j3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KF3DAM117mRq3xAEdyccMs2mLI3w9haBUoX0n9LKOJI=;
        fh=/HJAbosQSnTVxiQKcg4G1AWNmrojnQFNGr2yAurXYTI=;
        b=YmC1LzpxKM+9MrLzDfij2olIkEV/pSQBfoSkvObGRDPPvgjrTVc++1b4i+rnbDqGMp
         D5AhI0Eut/u5XqDqJCiciRnnO6+KCQwiEShdGHSMEbPesG6nwS5d423ub9xucOxMfXzO
         nQq0qc3Aj4dfTvl9HhcoELOikI20nMNECn3xMpseTH+7rZblG8qMsaz2PdwZWlC+b/fk
         jZaUq7Pnumm66+f2ugKYCPXhCn6gIAxiyQZGhKKtBL2iHS63MNDVkO9E0mfuHwzXm7uU
         iFiWSH22aaJ1I5KXvt8ihPmkonPI01nazUo8N4baPVV5iYo7UjjivLPVDIoHimX4gwoi
         Jzyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769840375; x=1770445175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF3DAM117mRq3xAEdyccMs2mLI3w9haBUoX0n9LKOJI=;
        b=xvPqHT4XKxa7Q0lylyUBn60kksAjMrAhXeuYaguF4dMnwFSFJ6/nURHRTEry/uOaxt
         D5505Tgv/Vf2VD+tj3GFhL11q0XICkQixm9+ptRDX6JjBVQ9SisNmz1mV03q6lBLFfDx
         wZu8ZxhhPizr2CxPYRnGXu/NXQl2ZTW5+3SWoiFb9ta5Af9vLDFobJn5+fahoKY17ZbE
         PD0kEfOY11YM5B7UiXE4LQAUYogPdUr78F090bF8pronpDBWfFhNcLhYusuFE7Mn/dg3
         Ht1qkVgt8rbHHZpQFeRObQo/9fNyV7x3hINToosCYti1ZBUsfEvYCOR/SaGlMbNAifgN
         AOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769840375; x=1770445175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KF3DAM117mRq3xAEdyccMs2mLI3w9haBUoX0n9LKOJI=;
        b=WyrqUb5NbszYDqPKGJPB0fEmJY3Kxhq25ItSH+KNxHOYO7/e5h/k/0mO8VsQbmwkJ9
         0/qp2+cwxb4VocbUBt9WL3urgEne/UhudBJxHaryJDaV7zvZDBQkRgubmCLWhFSfvx9O
         8qBCIvSmq7xR83RijXsdbmy9ruG3GLmBGdqmNbvn7ss1sUAwzRZxR2TbkhaBmsdewKee
         szxuw9vhzGB6Lx8neasaFYY8zk1Klf/tUaMShmJgob8DLJ+5YQJWRyUStwlQWww/IuIv
         R79zHXelyf2JvkTLPxjGNu1GBN9bS+WPrAt2ziZcWV2PoWLPibbcMHpLdLWtfO/He+TK
         bPHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrSrwac9sUuYyfZLWj1Ic0hrIzHkmOOPyW2nNVvOXo4ybPSJkxScJYNpx7pUGnFL1uHzishyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVwBoUNuo3fbqxRaEFuiOcpmooc+G0Cs7rsWw0hp7B04o12TP
	yu1YbnTJVjK6lCXWorarTO/L1BzPw1oFv+vcVUL6ROH0lzE9VHqZH7SauOINuFPQ0l+ezYtFKBb
	aAqVHENM7b/29L22irTKnWB0+n3kxgQMTsdZUyHNw
X-Gm-Gg: AZuq6aKMA4DuhBHe2M72jlQEFyMaY+hpMNqHQXpY+ww1F1xbV6Ucs1cmO1v4dDOFvcZ
	jUi5TldPO4xh9WxGfWwz/ASpICiL8V94bBaeiM58jxe47rSDYrRLK7/+E2yP+08XvJDlsHOpuWj
	/i/2ze3kvBWs2FtPzwjNh5ee5poqzQJPZJPG06bhFwiYaKGBdIoSMV3mZXH1i0oIMzrBKsUwyoQ
	JJ24orOaI2WfL9IWSAOFjMMQtYcQKGGLZJV4ip49R1vuD0F9Z5awkjPrHJUH8RbNlRiYuQpmV0+
	nX/ckFbaiMB+zvHvMmrdMWBTbRkKnSXboYgnkOrLtAMcNMUexOknjBgKd2Iy
X-Received: by 2002:a05:7022:e1e:b0:119:e56b:957d with SMTP id
 a92af1059eb24-125c0f797f3mr2482188c88.2.1769840375108; Fri, 30 Jan 2026
 22:19:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130191906.3781856-1-edumazet@google.com>
In-Reply-To: <20260130191906.3781856-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 30 Jan 2026 22:19:23 -0800
X-Gm-Features: AZwV_QjbHFPOub3n_pjI52l1LHnVI4G5yc4q6T1VGhMV7tIRRC8Kd0hq4zIvleg
Message-ID: <CAAVpQUC9H3dZYEG5c68v6hm44LESHy5U-u5Qa2drhY2RaeU1dw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: l3mdev: use skb_dst_dev_rcu() in l3mdev_l3_out()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255370-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1E105C0F10
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 11:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Extend the RCU section a bit so that we can use the safer
> skb_dst_dev_rcu() helper.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

