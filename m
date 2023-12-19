Return-Path: <netdev+bounces-58978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 367B4818C22
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 17:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99FC1F258C6
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307CA1D542;
	Tue, 19 Dec 2023 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8kDf+vB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B41DA59
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3366920db54so2450750f8f.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 08:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703003066; x=1703607866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uNwkU9kqRe/iMS3l4jAnLfwvJqCmqKLT4regqpL0b4=;
        b=R8kDf+vB3QMVDhYpRODEeyuSiy8QAWMNO1oSr8bWBz9fVS03kCaziTSmNFaAKRr+2a
         b5ZVxb1UjlP+eFoFjbqfnBDK6rYO1EXP7rpsA/sagiPgwE8mqXk/mDwWZfW4MY7wh5a/
         5pbojOkBjcbGU3NIg/oFc3LIC+nk+S1nNZJxp0yIuRvd4zDXdldji1o9vGwzqlgis9oE
         nxHriHY9RFUFZtR1eqggnR5cbXOyhXqOvZiRmQg0Oso0OnU6ceD4ZUAqIxGB2kV2nWWT
         vRN9A7RDJl0/QQNnrGFxMrefywbNmhcS0/LTG4w6QG7mr5LH8dWwHoqlN+IC/hlIfkUI
         4eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703003066; x=1703607866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uNwkU9kqRe/iMS3l4jAnLfwvJqCmqKLT4regqpL0b4=;
        b=igTnQKRQ9gxHEMiUErY5IDIkeZhrOMRVkCZnErRzZnjEvzIVyFetwZNbuu1ISgpYJo
         a9yk9KmRcneIZ+HdP3sqLLYKhjJ7VqjshMLFNyWKhtkuv7vzhpCwhA7gMqQwtkTYyWKD
         Pj6dmOJhxY8dlIIWqxq/yOFIc7U9ZPJXiTyD0Q9sBWoHfgtxB5UrnGVRnZqBi7/t/BJM
         vRsfajxI4GaKRcgfNDffBz645bIbp68pknZPCin8SMguqPIUzGoTfG2l/8yV3jxGCOQh
         MEXCT8Qp7lv2cYk2j3jz/NWWv+3Uh41SLqX+Hl80M9R/Jhr2GM7rjaE1ae6ijtVkthrv
         xS7A==
X-Gm-Message-State: AOJu0YwfSgB/q7Iynvibbe10VjA7s1nqKGmTWy5BrzWGpQ7Bsp2m2v79
	hixEY+wjQygE4zaN5ufgSCJ2OoOMszCJVGVaWG9vIw==
X-Google-Smtp-Source: AGHT+IH1fQpHrgQ1AQ0sGIpdVwNAENGWCsTtuPMZEL7iT/lV+6KhEOFjQ0f7EQjww7MFIhQn55pIpmcjQyZ4enkYLwk=
X-Received: by 2002:a5d:6786:0:b0:336:5162:de5d with SMTP id
 v6-20020a5d6786000000b003365162de5dmr1714276wru.227.1703003066507; Tue, 19
 Dec 2023 08:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217-i40e-comma-v1-1-85c075eff237@kernel.org>
 <CAKwvOd=ZKV6KsgX0UxBX4Y89YEgpry00jG6K6qSjodwY3DLAzA@mail.gmail.com>
 <20231218190055.GB2863043@dev-arch.thelio-3990X> <CAKwvOd=LjM08FyiXu-Qn7JmtM0oBD7rf4qkr=oo3QKeP+njRUw@mail.gmail.com>
 <20231219101202.GE811967@kernel.org>
In-Reply-To: <20231219101202.GE811967@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 19 Dec 2023 08:24:11 -0800
Message-ID: <CAKwvOdkLx64b2d+F1CgRn6duxhUDNWfdj7mRuoScu1Jz2H4mXA@mail.gmail.com>
Subject: Re: [PATCH iwl-next] i40e: Avoid unnecessary use of comma operator
To: Simon Horman <horms@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 2:12=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> So while I'm all for more checks.
> And I'm all for only using the comma where it is necessary
> (I suspect that often it is a typo).
> I do not get the feeling that we are sitting on a trove of nasty bugs.

I still get nightmares frome:
- commit e7140639b1de ("powerpc/xmon: Fix opcode being uninitialized
in print_insn_powerpc")
- commit f7019b7b0ad1 ("xsk: Properly terminate assignment in
xskq_produce_flush_desc")

--=20
Thanks,
~Nick Desaulniers

