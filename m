Return-Path: <netdev+bounces-53411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A9802E63
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBAB1C208DB
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1C14A86;
	Mon,  4 Dec 2023 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3S8i6CT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466A2D2
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:19:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so2855451276.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 01:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701681553; x=1702286353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QKbMBYZcuC+nd2VDIV9BwYsXts0oE4Wkgal94oI+4wg=;
        b=d3S8i6CT8eEaLlqfxUPFd7JyFN01ARRmi/bXbq0bjctEc4MbB56+ptg4YQf2o9tF8u
         EzVMr6D7U/Kq/qB64saCNb2nPf2lvW1ZLT9zz2K0gt3xg3iRatTDSdn9AweWxueqx97I
         3nvI/iICJs+qw16gXPE1KAb3DW7HSLajJw4QaxWEhNz0AItQHkjEbq9kYmBVQrUzwU9P
         1vqjL5vJk2y3ClkkcVSFrz+B3aVPtrtmRrBSM+YaPFyrMhf/M6/cyapxbkQ2kjYq2nFP
         /J74ztgWGo57y3QLeJzsj+Q/+ZCqZq2LkF03VSgAHKsin75+rjub8d2p69+ux92exrTI
         GKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681553; x=1702286353;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKbMBYZcuC+nd2VDIV9BwYsXts0oE4Wkgal94oI+4wg=;
        b=LebvHxxEfFM4XWZs565meZ9u6z3U2Vje/mKzA2IEo+Xnag3VOqfuDE3i2mcsWKIVMv
         JMt4Esxiiy5QvDKn3X3xXDjX+DTMTDoM/BkPDLUJodp9oZ16D+uFskuvGoYEcnbXGzt/
         S8ZClg9wTjXjivMOeuGX7PBAWTzg7S+Z14TL7RqFRiT6FKRlvaXgf7RC6lipddwGZGLG
         Z0rOUILle4KkCrIG47LbGIkVpG1vpXUmxGlzeyBN0KFWiT/zonWiwwoFZxSEGknEGc+E
         ylf4eNRktoi3JHv/LUmTX9QYNDwcyo5NOLE1/yp0LO/GXXrK2A4y52ekDWi4NyMjoLQF
         2uVQ==
X-Gm-Message-State: AOJu0Yz6SzGGsqQakTc5Sk0YNYSgZSouzxuyB/Wj8O2EVX5AvjyMKRpe
	hUhPv177rj/TUgr1r0J/TIVkQztuvgRpXQ==
X-Google-Smtp-Source: AGHT+IFr/6opqxbXUHkqpXqwg1S6dEOPEmRJQIdPXR1qI8+g1N/14FT2hyC4A5cpOsZ+LVM5v/ZMNk6ey23Wlw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:6e83:0:b0:d9a:e3d9:99bd with SMTP id
 j125-20020a256e83000000b00d9ae3d999bdmr925402ybc.5.1701681553468; Mon, 04 Dec
 2023 01:19:13 -0800 (PST)
Date: Mon,  4 Dec 2023 09:19:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204091911.1326130-1-edumazet@google.com>
Subject: [PATCH iproute2 0/5] TCP usec and FQ fastpath
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add iproute2 patches to support recent TCP usec timestamps,
and FQ changes landed in linux-6.7

Eric Dumazet (5):
  ip route: add support for TCP usec TS
  ss: add report of TCPI_OPT_USEC_TS
  tc: fq: add TCA_FQ_PRIOMAP handling
  tc: fq: add TCA_FQ_WEIGHTS handling
  tc: fq: reports stats added in linux-6.7

 ip/iproute.c |   7 +++
 misc/ss.c    |   4 ++
 tc/q_fq.c    | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 137 insertions(+), 1 deletion(-)

-- 
2.43.0.rc2.451.g8631bc7472-goog


