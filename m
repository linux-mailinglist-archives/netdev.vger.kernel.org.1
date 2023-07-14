Return-Path: <netdev+bounces-17984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E0B753F75
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227D228209C
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54C214ABD;
	Fri, 14 Jul 2023 16:04:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF18013AFD
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 16:04:30 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462C635A6
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:04:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b9de2bd0abso11381485ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689350668; x=1691942668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zx5JY7ylb+YdMu2KAjvPhPY7KTm70/2SOvBiz4fVW8=;
        b=zbACXGID2Fszh2wywEgK5kXQzpIy0fPdMjFnUG2HVFo+j2/NJCBmKoAIm5B+ECQo7S
         /YqBG4jNkW78mozSfX+U1l9mrrfQ0+1GmSfeQUlf/iZadyOrKrNqNEqaeMfEv+yCQn8s
         DH/WJ1MKrsr81Dv/oujupUT6nCeheGMakOHLlDGDIO7h6A5zPtE6gVky5ArOJB16q5zn
         D6KzCOH1JNBepUPSt2H4nkYSGnPKw75GTCjLwD2p3Xw6cnquransrtxMP8/u3pQXOi+O
         OL+TehxK3aauyp7Se2Qp5z7pDkVMU+M6uTQDFI7D34ERaTf+CEAGOKtzoMCq6nucidFV
         34LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689350668; x=1691942668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zx5JY7ylb+YdMu2KAjvPhPY7KTm70/2SOvBiz4fVW8=;
        b=Zh9IxqBgBDkgMzRdJVeT7wIoyEAaoqyUqumGXCHY+skHA2Pd1MC9ZML+IwdU1iDQNJ
         XtKGjelNYqvfprIZezUcbeeF1CzsGQGEN/qT7GvePzmGdDsvmsMhdWrzBuGv/p/5fTim
         89Cjlc4Y/MVYqIRZNhALQqwCvayHhnimDFzgklJzBgZtC+O9wWt/ANncw/DVl6YeRmT7
         YHU0DJXiU3/PQGTCtAzSFVACd3P2iUw/YsgWev9dUeeY3Ox59/0jPgiuLi+Y2BtiuZBt
         lleWjOH82ySzqKNwBq/kYKK8PK15AEYROIJwV2yxHRboncv4Ky++F1kRlWOBX7cBFlyp
         e7jg==
X-Gm-Message-State: ABy/qLZm1+/Eimpe8M8OzxRdeENZ65Lsl1AYRPg4Uy1D1Rxd2ShmHt8c
	iLDXg3XjUQdhsZG9UO3mckdc6yerTw2CbxIfOyw=
X-Google-Smtp-Source: APBJJlH69gaBjUMqmvoL9UsizhC5jaYhuFeLPUDxog2aGA/g3CX1UcaY57L7IFQHkByQ5vb/KiM2dA==
X-Received: by 2002:a17:902:b90b:b0:1b8:64e9:e4b3 with SMTP id bf11-20020a170902b90b00b001b864e9e4b3mr3405403plb.39.1689350667677;
        Fri, 14 Jul 2023 09:04:27 -0700 (PDT)
Received: from hermes.local (204-195-116-219.wavecable.com. [204.195.116.219])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902694900b001b9f75c8c4dsm6791540plt.52.2023.07.14.09.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 09:04:27 -0700 (PDT)
Date: Fri, 14 Jul 2023 09:04:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chander Govindarajan <mail@chandergovind.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] misc/ifstat: ignore json_output when run using
 "-d"
Message-ID: <20230714090425.76cb96f2@hermes.local>
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

Was about to apply this but there a couple of problems.

First, in the Signed-off-by: it should have your legal name.
Is it supposed to be "Chander Govind <mail@chandergovind.org>"?


> ---
>   man/man8/ifstat.8 | 3 +++
>   misc/ifstat.c     | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/man/man8/ifstat.8 b/man/man8/ifstat.8
> index 8cd164dd..2deeb3b5 100644
> --- a/man/man8/ifstat.8
> +++ b/man/man8/ifstat.8
> @@ -16,6 +16,9 @@ by default only shows difference between the last and 
> the current call.
>   Location of the history files defaults to /tmp/.ifstat.u$UID but may be
>   overridden with the IFSTAT_HISTORY environment variable. Similarly, 
> the default
>   location for xstat (extended stats) is /tmp/.<xstat name>_ifstat.u$UID.

What ever you used to make the patch or send it got messed up here.
There is a missing newline, causing git (and patch) command to report
that this is a malformed patch.

