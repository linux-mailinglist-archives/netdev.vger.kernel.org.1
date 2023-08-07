Return-Path: <netdev+bounces-24825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B413771D83
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 11:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE3F1C209FD
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2757C8DC;
	Mon,  7 Aug 2023 09:51:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF9C8D0
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 09:51:35 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384B170B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 02:51:12 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5839f38342fso46743237b3.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 02:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691401853; x=1692006653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFpp6vhgkpmCYMkonsz2DWx4YVB2jBp+P5tdU1foyY8=;
        b=KQhSzrWZSsoLxZ3rMA9WO+LVKIYVoRfBwn0WG05/pG9r9sCIuV5p4uP/FzG9Mw+QUY
         gi2e2DVsqd4dsRcWM/AcvdaqDsp6nq2N7CXx8Jb9vNO2Xh99SZCqmuTHkC6sQT2yefXV
         +OLcrKMB94Pg4FAXP1xv5hAZcvyriabgKfy48IbGA1yKcn1XvEp5oJW+KTvMYP2Pp06t
         9SWs1p1S0S7B52sComnFjKdC/QcL9+7hiC/7lIt3zApcfeU9DJCl0ktkp4A3DHlEGahw
         sgQYz+qMegmyzhfN1NChRt/drCGsyp7gdqNHvc2XmZt5G6dYX+dB7bSqYhRAXoGT0B/S
         mICw==
X-Gm-Message-State: AOJu0YzhFDu50nEdnDwPjf4rcuIl006f6I/JVbxNj8G51WFrZaJJo70G
	yb//jQZgmpsWSyaDMugwYSABr49aSfVG0w==
X-Google-Smtp-Source: AGHT+IHvxH9BPTWcFNbTL1nRoeD7c0rPOy14uDGIum5fdOfT7g/Nw0PV2wCOd/goBV3FZh4cArMEiQ==
X-Received: by 2002:a81:9105:0:b0:577:257d:bf0e with SMTP id i5-20020a819105000000b00577257dbf0emr10820166ywg.22.1691401853176;
        Mon, 07 Aug 2023 02:50:53 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id d17-20020a0ddb11000000b00586108dd8f5sm2626383ywe.18.2023.08.07.02.50.52
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 02:50:52 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-585ff234cd1so46545597b3.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 02:50:52 -0700 (PDT)
X-Received: by 2002:a0d:ef07:0:b0:56c:f32d:1753 with SMTP id
 y7-20020a0def07000000b0056cf32d1753mr8605330ywe.44.1691401852304; Mon, 07 Aug
 2023 02:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230807081225.816199-1-david@readahead.eu>
In-Reply-To: <20230807081225.816199-1-david@readahead.eu>
From: Luca Boccassi <bluca@debian.org>
Date: Mon, 7 Aug 2023 10:50:41 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnTcsYXnwDcKNxwbLCE3dWwaw_UBRmaBUNCYEF5X4BCGuw@mail.gmail.com>
Message-ID: <CAMw=ZnTcsYXnwDcKNxwbLCE3dWwaw_UBRmaBUNCYEF5X4BCGuw@mail.gmail.com>
Subject: Re: [PATCH] net/unix: use consistent error code in SO_PEERPIDFD
To: David Rheinsberg <david@readahead.eu>
Cc: netdev@vger.kernel.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Christian Brauner <brauner@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Stanislav Fomichev <sdf@google.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 7 Aug 2023 at 09:13, David Rheinsberg <david@readahead.eu> wrote:
>
> Change the new (unreleased) SO_PEERPIDFD sockopt to return ENODATA
> rather than ESRCH if a socket type does not support remote peer-PID
> queries.
>
> Currently, SO_PEERPIDFD returns ESRCH when the socket in question is
> not an AF_UNIX socket. This is quite unexpected, given that one would
> assume ESRCH means the peer process already exited and thus cannot be
> found. However, in that case the sockopt actually returns EINVAL (via
> pidfd_prepare()). This is rather inconsistent with other syscalls, which
> usually return ESRCH if a given PID refers to a non-existant process.
>
> This changes SO_PEERPIDFD to return ENODATA instead. This is also what
> SO_PEERGROUPS returns, and thus keeps a consistent behavior across
> sockopts.
>
> Note that this code is returned in 2 cases: First, if the socket type is
> not AF_UNIX, and secondly if the socket was not yet connected. In both
> cases ENODATA seems suitable.
>
> Signed-off-by: David Rheinsberg <david@readahead.eu>
> ---
> Hi!
>
> The SO_PEERPIDFD sockopt has been queued for 6.5, so hopefully we can
> get that in before the release?
>
> Thanks
> David
>
>  net/core/sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

As one of the first users of this new API, I am fine with this for 6.5, thanks.

Acked-by: Luca Boccassi <bluca@debian.org>

