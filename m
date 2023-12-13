Return-Path: <netdev+bounces-57028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF48811A5B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FFC1C210FE
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B143A8C4;
	Wed, 13 Dec 2023 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4oNzTx9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F26F7;
	Wed, 13 Dec 2023 09:04:23 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ceb2501f1bso6099619b3a.0;
        Wed, 13 Dec 2023 09:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702487063; x=1703091863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7l8BED4TeYhufhQEv3oEjWqt5UjqEKMjcFSRBI7uaiQ=;
        b=I4oNzTx9Q3q4JtLCHptQgCdXzDlghn+2/XM1DbqxiaiuxCx61dCihCSOOxTmrf5LMy
         0HSw1jGiS7cFxurHPHnB2W2GcLtHTPX40Dh8Knc3/+RYwJ+E/0KIsxZv9CaJJZEEFjgo
         aW7qQ/F4TZVqqk3otYbD/LBy3hI00oVJ+1GJ2sSj8xPm8o6Xi1p6MPplu+9jBDUGZOcW
         rTSd3BkRTV5SvnH+bqweLebWI2Jzcm4tYKi+CbcaTk8Jjw1x3/fprUUpeA34jJFE0JXp
         wtdznIvFnkFv9qF7AiRwHdlWnceFa5n1bEuxd6ZidEBugaAErdLz1sfdU/Wsbxd2QS4T
         DALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487063; x=1703091863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7l8BED4TeYhufhQEv3oEjWqt5UjqEKMjcFSRBI7uaiQ=;
        b=dInNHtCDvzWlGl+2zlIN4O6qAeUnlDbhGR2rJ50Y1oTS/SQCy2SRpRB4rPBxJ/lKWU
         ct6O8ae2Q+idgjDiE3WqYJYcl6AIdloImF2/ZzCsznVirnZpNyf28qOiQeNh5rjG9nun
         cEnMIXoBBXUidzpfJ9jOv/vI/7mQQbeNPflCFZjI0w3Bz0yqUUl+0AR2JY94QznuYNnI
         76Ur2VGHU9g9StAWg7MgpYcVrRgTmOoo9kblUoAE/auZLMc4SvuCm4E+eo3YOdFY0ohz
         E7wbpBdgBPBM6pynyZtgupdzN19TmuuJe8b6Ku//mZaQHCtWjPsURyHb5okQ/WWfogth
         KQJA==
X-Gm-Message-State: AOJu0YzxuBFMpqSSW4JnrnEzaNeToudrnI4AzS67Nk7VFcfN2hPDg0WP
	ObkG8stZWh86q6Rc8VGaV+D3xPfSIP33c7DgkxU=
X-Google-Smtp-Source: AGHT+IFp4c85uxk8quZAy+Ix4OppQhiyiE9YhkmV5BCLrKP1VGXURaAkrg9sj6R3rQXF7Tt4KhDp3XXWCfV73XiLvVw=
X-Received: by 2002:a62:b410:0:b0:6d0:d46f:8f8f with SMTP id
 h16-20020a62b410000000b006d0d46f8f8fmr1095648pfn.2.1702487062910; Wed, 13 Dec
 2023 09:04:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212221552.3622-1-donald.hunter@gmail.com>
 <20231212221552.3622-10-donald.hunter@gmail.com> <ZXjuEUmXWRLMbj15@gmail.com>
 <m21qbq780z.fsf@gmail.com> <20231213083931.2235ca18@kernel.org>
In-Reply-To: <20231213083931.2235ca18@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 13 Dec 2023 17:04:11 +0000
Message-ID: <CAD4GDZztgSHGsYQkK3jZSrwgS1FKrGmGw7AnGe7vqz40zE9JFA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 09/13] doc/netlink: Regenerate netlink .rst
 files if ynl-gen-rst changes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Jacob Keller <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 16:39, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 13 Dec 2023 09:42:52 +0000 Donald Hunter wrote:
> > Sure, the transitive dependency is sufficient. I tend to add an explicit
> > dependency for a script that gets run in a target.
> >
> > Happy to remove that change and respin if you prefer?
>
> I can drop patch 9 when applying if that's what you mean.
> No need to repost the sub-message support.

No, it's one line of patch 9 that needs to be dropped.

> +$(YNL_INDEX): $(YNL_RST_FILES) $(YNL_TOOL)

The other three lines should remain.

I'll respin if you prefer.

