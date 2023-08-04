Return-Path: <netdev+bounces-24333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843A376FD06
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E781C217B8
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 09:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0DA923;
	Fri,  4 Aug 2023 09:16:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7428F62
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:16:08 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9704EF7
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 02:15:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4036bd4fff1so245991cf.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691140535; x=1691745335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gCApSh+3QoKFFXm72Q2sP7BRCH1xMX79v40690ymm0=;
        b=bq+4BaFgfpZxFpolBHZRAfB6FwRpKR2bd8J+AE5cIhjYHJoLjAfmOYH1DXPHI56Vve
         Jaeo7BZKUYWrFqWy6n9lHsfpGvoaFjaSx/JBzXijLTfmaz7H6OgDDEEUa5aaM3tHwapR
         uiSLJBWWnwsLR18F4kJNHbPcmhkO5F+sLf5sNx4NCKXf20JVhyIvBWeonsh4PUP7Iyuy
         2IrxYEYAAt3KzW2CcG8XuRFSSHfSVtj3gBM8KfkjIem5C+oCYAAbyfvSUJXVz2G7ZYdt
         N/Efq/BK9wdKznMDqWWCrcBJfctLxmEBI2eHIRAq0z41Q8mIRWj+uwdNHxi4mZ0FbN/k
         WkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691140535; x=1691745335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gCApSh+3QoKFFXm72Q2sP7BRCH1xMX79v40690ymm0=;
        b=PPZFEz7o0wNwdbtylTUdATotSmB4xT6HbBLIN2/9xHmdE+hpu0uGJgOCjQc1yDX2oE
         33YizIdW/LXxE66paJshnhTfnQzDUw6eFngoAvEokkkDXRrgndFnChYzzSRrR5bG3s6F
         Vf76qn425A5I8q3eoFGbQDcnfCcVBraRT0AZKu2Ee7YikiLMIBLpOj9rKrYsAEHC6vRU
         kx8gU/calrvhoytB4/ubMPbdw/rQIrC4pXf6F8aYf8f7PdPBOasc9SfJuik6Nioro0W4
         qsZ9BaIAoJln2C5EC6VwfIlnQjKT8hbmFABkmYtDexsTcQ2+rYvNtpbIfr3S7JHQSoWX
         9r1w==
X-Gm-Message-State: AOJu0YzDRiS29YnhKBLpCQkYjPa2DnvT2MEEiqvv2DstLc6qhYlnNNk9
	RxpE6mMbdZq1EL7R6wHsTyjE4CQiJywx8oAuYM4qneIunv2D5K4Hy9A=
X-Google-Smtp-Source: AGHT+IGulEjMHxrconlUGsxnkPUMu5nVbreps1LiOhPrc6YwyenRh+8OkSjfrGfbu6jcF10DrAIrtnscs5Lcy1OlrA0=
X-Received: by 2002:a05:622a:590:b0:403:b242:3e30 with SMTP id
 c16-20020a05622a059000b00403b2423e30mr140768qtb.1.1691140534690; Fri, 04 Aug
 2023 02:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230803224552.69398-1-kuniyu@amazon.com> <20230803224552.69398-3-kuniyu@amazon.com>
In-Reply-To: <20230803224552.69398-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Aug 2023 11:15:23 +0200
Message-ID: <CANn89iLq8n8ecYYoNzJN-+R3hfydNyiBvTSfDb_BCZhae5n4zQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/2] tcp: Update stale comment for MD5 in tcp_parse_options().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 4, 2023 at 12:47=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Since commit 9ea88a153001 ("tcp: md5: check md5 signature without socket
> lock"), the MD5 option is checked in tcp_v[46]_rcv().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

