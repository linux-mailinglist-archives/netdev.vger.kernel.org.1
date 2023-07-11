Return-Path: <netdev+bounces-16954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AADC74F90A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 22:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3251C2107D
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 20:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE6B182CD;
	Tue, 11 Jul 2023 20:30:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD01FCF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 20:30:50 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3451718
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:30:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b89b75dc1cso83335ad.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689107443; x=1691699443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Kp/6meO+w1aimqGiyEuROntFbV2GqEUjX5yCtvPfYg=;
        b=AYqUeJQDWgedyNAoZAeWOzo1DnmzOgRPaQMHa73TeorAOqJCRRKjU8Y/d8dFAIdxlZ
         MMw5U9X3fg9HmDNh0uFuFkwTBIgVT/zez6Lcp2NUWOLta+dfGo02I/5VSyuWxKsGN6as
         nW2E6yPMuksAW88A8jpWScVf3EigOo6pCfQ3GY6cLnPoc73G4Wv/yt1OX86mo2HvMEuM
         h0Y0GkXQ27XdhtaPYOqF+FseGVi34JmoF67/Y0IjQ/Ukay8Lc+BIT2ukuLGh2dgW4UWJ
         T1kSsdQeFjJPJtbOfK1Jdq0SVDXTSczl/sxzJ8rh9KfUKGfPwe2MAmIOzvkxbEuVh14g
         gqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689107443; x=1691699443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Kp/6meO+w1aimqGiyEuROntFbV2GqEUjX5yCtvPfYg=;
        b=UMhqUi33WfC9v9ceL/qWVqyUE1v5wVgffDB0PWH9D8VCXFgx7gr50bN9sEgdVtHI6b
         ypOqDqbxH+SGAhbCQ5yFSN9QssAX7IVfNtAfnU8nsagGyaxUUc+mrdOg4ZZ5niMlZkA4
         cFgYFqUZ3xXOk+XldxGIVjxm77jIcy81nvN84cWU8lnAGe4UJsURh2TSYaN+vFYFrm4t
         0KBUkyGsvOXAdN6aDkOOcfVirCM2EdXQkckIrC8H4Yb+itnVe4ShPzjHAm1sAPBEoNtv
         SjgZTm3rRwBA0q0yTDvpPN+44SlRUTO+rLQkSxfbYPW0S5q7b5bduSPnKL73FFTrAKN8
         KgLw==
X-Gm-Message-State: ABy/qLazn3R+AEYMtK9G9y8F2utql/3uXOZ1eUYkJIt9PT00IciZkFZS
	yquqDwvZOREupWt4k104p+zJ9G041uG6M2U8PmSF9A==
X-Google-Smtp-Source: APBJJlEH1ZrDQi68PHG7wT/rWhXXiEz7Cs8uormhwQXIzo9j1Y6JXijT0yJ2byykjdvGYNniyL5QwQ==
X-Received: by 2002:a17:902:d4d2:b0:1b8:656f:76e7 with SMTP id o18-20020a170902d4d200b001b8656f76e7mr25218533plg.23.1689107443640;
        Tue, 11 Jul 2023 13:30:43 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001b8896cd57bsm2317738plg.269.2023.07.11.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:30:43 -0700 (PDT)
Date: Tue, 11 Jul 2023 13:30:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chander Govindarajan <mail@chandergovind.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] misc/ifstat: ignore json_output when run using
 "-d"
Message-ID: <20230711133040.2fef3caf@hermes.local>
In-Reply-To: <2d76c788-4957-b0eb-bd5f-40ea2d497962@chandergovind.org>
References: <2d76c788-4957-b0eb-bd5f-40ea2d497962@chandergovind.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 10 Jul 2023 16:15:22 +0530
Chander Govindarajan <mail@chandergovind.org> wrote:

> If ifstat is run with a command like:
> ifstat -d 5 -j
> 
> subsequent commands (with or without the "-j" flag) fail with:
> Aborted (core dumped)
> 
> Unsets json_ouput when using the "-d" flag. Also, since the "-d"
> daemon behaviour is not immediately obvious, add a 1 line
> description in the man page.
> 
> Signed-off-by: ChanderG <mail@chandergovind.org>

Rather than avoiding the problem, why not have ifstat support json in daemon mode?

