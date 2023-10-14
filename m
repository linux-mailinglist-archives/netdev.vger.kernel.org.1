Return-Path: <netdev+bounces-41002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46157C955A
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C43AB20BCA
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6815E90;
	Sat, 14 Oct 2023 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7mm8mQs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530B12B90;
	Sat, 14 Oct 2023 16:19:22 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E169A2;
	Sat, 14 Oct 2023 09:19:21 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7e5dc8573so38068437b3.0;
        Sat, 14 Oct 2023 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697300360; x=1697905160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUWq7b5yKF0jbzR8yVQydGkAeCE0fMsRly225OuT7qM=;
        b=Y7mm8mQsouL6cRo+JgmlBXwo5jFr7WCjk8VhiibdDRbfzBj3I3m45JLZ3nGTtQePUF
         +tLEg8Sfh0Qut0fG/eGnPN8KEomUvJyHqpQSUCdeOmGou4B9riWiBsCPmsTWcvVyUnBP
         Ae4ReynD/MT1ck0dKjLZchmXGKZehxBQiutORRepHw3Puz0knQMThtE4KCC7d0/7Pqcu
         5gJsG9O7HmtUmM/ovz0EBMZ3RhXI9990D62tyGf9xBT0mC/toLALMlYPBZ+Uq9HQewA9
         1hFfiX8wvZcz07Z3y2DDQtSW7GRWVAbeALJq/kVnHXNiPm8FeY2InorY2Ne0SVg9yxWg
         Keyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697300360; x=1697905160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUWq7b5yKF0jbzR8yVQydGkAeCE0fMsRly225OuT7qM=;
        b=rbOFNPAiHepJAfuFw9PtNzBfoMjSO29KGAp3/ZhRDdPpTKDdUqdE97NlbYYKOPa2tv
         1XPUhDzb5BBfi3MCXNu2IV1xXsUvzn/+xFjmuIaUzFHqjMqkEY/y/qIXXHaD7jZOwewA
         3ySS21GS9SUdDRw1VcqLuGxfjnMcivGk+z3kxOgAjfk5JwSLX3k9zSK+99e4/RlUox/K
         RcqtWXjCLsDOluNf9+h/hTn3vcgIh+V/lkvRpN+8LzMmvxsasOGk0hXNl+RDHdeEzT7X
         skWDk0fhCfc/N7VIqOGUT//Ns7RaJoLvUKNsoMW9t+wHPtXdLT8dh/mSKYz2t2hQNJlj
         Eu3A==
X-Gm-Message-State: AOJu0YwU/JDQmmuTJv8gHV9nNHkryrr4189xq7Mau5015TbtE/g7vut/
	lxmhxwDLkjEVctRCtoUhZu3jd6bZyK9kaldHc8s=
X-Google-Smtp-Source: AGHT+IEfLRfRHVhOl5kILcnNRx5P6z+ORz7pZMTHJJZkrBC5ZaXCRFyz4+zBg8dIHFmUESvpmQUqpCl7ABcTQoBvHZI=
X-Received: by 2002:a81:8683:0:b0:589:8b55:fe09 with SMTP id
 w125-20020a818683000000b005898b55fe09mr31662044ywf.50.1697300360469; Sat, 14
 Oct 2023 09:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mgeVrcGcHXo1xjaRL1ix3vUsGbtk179kpyJ6GAe9MMVg@mail.gmail.com>
 <20231014.001514.876461873397203589.fujita.tomonori@gmail.com>
 <CANiq72=JQseA6JFy7g489Wwk8kc7-xk2GLVVJC8+T9eMNxvitw@mail.gmail.com> <20231014.213114.1223712652378299068.fujita.tomonori@gmail.com>
In-Reply-To: <20231014.213114.1223712652378299068.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 14 Oct 2023 18:19:08 +0200
Message-ID: <CANiq72=8asMCngzi4m4GNsC3yLj4CvFq1zKh7vqXm0EkmDAckA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 2:31=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> I expect that you don't want a commit introducing UD so I squash your
> patch with the explanation to the commit log. If you want to merge
> your work to the patchset in a different way, please let me know.

No, that is all wrong.

Your commits are not introducing UB (at least regarding this topic /
that we know about), whether you use the workaround or not, and
whether you use `--rustified-enum` or not:

  - Using `--rustified-enum` does not introduce UB on its own. It does
introduce a *risk* of UB, which is why we do not want it.

  - The workaround is meant to avoid desync between the C enum and the
Rust `match`, i.e. forgetting to update the Rust side. It has nothing
to do with UB.

Furthermore, no, you should not squash the code into one of your
commits. It is not OK to do that, and even if it were, you would not
need to do so. Instead, you could put the feature into its own commit
(but the patch is still a WIP, I have not sent it formally yet), if
you want to showcase how it would work.

In any case, we have not even discussed/decided whether to use the
workaround. I sent it mainly for your benefit, so that you can show
the netdev maintainer(s) that it would be possible to keep C and Rust
enums in sync, so that hopefully their concern is gone.

Cheers,
Miguel

