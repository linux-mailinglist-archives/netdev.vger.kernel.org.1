Return-Path: <netdev+bounces-53615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C45FB803ED2
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9331C20968
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9E33084;
	Mon,  4 Dec 2023 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+Jkfrq/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A519D2
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 11:54:32 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b35199f94so12735e9.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 11:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701719671; x=1702324471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSDyHZbgfMpfmtjpu3gf1dpo6B/sHbuEuqoPklbpWFU=;
        b=C+Jkfrq/NVra1BpqJgXDn626lGxFATBY10SfwGx+TZXs6ycCjL0FZFx88Cfa+ogfoY
         qc/Bz42nnYTEeoZRC0DHTRFUWGt6yBU6RNzkF21GTvjp36lWheRja8Y+E4fy6qnJkABn
         cd8c2KyqMZuKDITIwgW5Fn6NWHJ9v1VMS4QcCV5oFbn5VVodcEN5D8sDb9PLDEisx+ct
         ZvBYwLH1s4dN5w5+yfFZCFL+OdwBkUGZTYpq0G4mgAYX02LN+WBan5kg4DG+zgNXMCtj
         QAYqHxuh295Wmf7lxU3luEGB8v3b3KxfGuJFEGpGkh5uvNTUsXzEUTcj8CtWseR6o8G7
         +5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701719671; x=1702324471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSDyHZbgfMpfmtjpu3gf1dpo6B/sHbuEuqoPklbpWFU=;
        b=iMG1TcjnM8gB9gTRmkTptfSuEfmvDoY/dtO/BRiWLkDpQyjcDJcMTaSMjdJOwR+1nC
         4IIhGMyuDy5woJqcbpFvXBQF/OrlxnF5wZ8dTg9XjFgPqaclMbJTzpQ1T+8vTtOR0Dfp
         CmScepF7Grt2ngnogGuu+tlC4UJnwAiHQTRaCodlScrDxvpPJPGBOWGjGOFH4eIpOdGD
         u43vASFzROTpqaFGT8devC7nSrnWcAkrwiw1ADg4QLUElJz34rMyJPDOolIaQWen0kOp
         cu8VhczIRvSCCjNj1AEdAdp+i6AMbdkiGJ2mJtM0mM45gHKnD6hkUD+ngQKEvGhmcEzH
         n3xQ==
X-Gm-Message-State: AOJu0YwFOoJ9Nhi3jV18IMpB6KnO7k+1qfSNJkC2g8CT86EOXQ6olXvK
	a7NNAV+ElRGqUX1V3/PvKZ7KT/RVSLDlQoz0MUDZRA==
X-Google-Smtp-Source: AGHT+IF69oQBTeRFRue7IWvEd4nsZp7rfVR2VmwUwkEN/xvmD+fwtfix+pon5QY5xjC4NSHvqc4PKF3TCnSCPW50m+k=
X-Received: by 2002:a05:600c:6014:b0:40b:33aa:a2b9 with SMTP id
 az20-20020a05600c601400b0040b33aaa2b9mr466051wmb.4.1701719670907; Mon, 04 Dec
 2023 11:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204185943.68-1-yx.0xffff@gmail.com>
In-Reply-To: <20231204185943.68-1-yx.0xffff@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Dec 2023 20:54:19 +0100
Message-ID: <CANn89i+GBs23TzwMoRUSCNX60+FRLSm9KSv_T_prJUS=+9soCA@mail.gmail.com>
Subject: Re: [PATCH] net: ___neigh_lookup_noref(): remove redundant parameters
To: YangXin <yx.0xffff@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 7:59=E2=80=AFPM YangXin <yx.0xffff@gmail.com> wrote:
>
> key_eq() and hash() are functions of struct neigh_table, so we just need =
to call tbl->key_eq() and tbl->hash(), instead of passing them in as parame=
ters.
>
> Signed-off-by: YangXin <yx.0xffff@gmail.com>

Not sure, this might defeat inlining.

