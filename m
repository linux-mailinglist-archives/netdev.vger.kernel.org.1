Return-Path: <netdev+bounces-26070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47E6776B31
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185E61C21405
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B991F172;
	Wed,  9 Aug 2023 21:40:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80424512
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:40:54 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC691FC2
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:40:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c3c8adb27so42446766b.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691617252; x=1692222052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDXCpn35Ad7J9f0GEXMuzOeFfEoO9YYwjjKca2hgV+s=;
        b=1l6WWpjTsrbthqxhqFGUE8vjdistC/b68tPuqorgdfs9jwlQbok4bWgV5WSKec9y3j
         4KZRPqOwBNt7ekYP8bPwGHCegv/pb40YWXzlPOQZL7SYPw+UB8TH8bc7AwjwOlTGWmTb
         1k1y3vCIcXfIlcOcIfY9lvJsbvf0745T0vsVX0j4dOp2ChfqhSKVQhqQGY0AVGj45k1q
         P49NZVxzeDswm3Cg3rGPuPlVfj6zIdq8uRCY3qDy9rjZJTb6VbDOnWz0llsfbErm/x0B
         GcQsXjrob1op8XZkdMoGgrBV0Njc19OsCegP0BOkcYFsDSvlmmWfTnj1k0jHKNpjNzgC
         LrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691617252; x=1692222052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDXCpn35Ad7J9f0GEXMuzOeFfEoO9YYwjjKca2hgV+s=;
        b=DaiVXYs1fVbaLB3WLOIXkVnlJkFS572oDA00uN/M4uRoN4yvwlx9XkPEOgy30pv+DB
         jeuK9W1MSGs0HvF7Wz03qwmsofMOrKvv+u8XuJsDGqfmR3jNSot+mVKifjLDj4OyTm3W
         CYXgwq9rAmUOaT016P2Tk84hYXWkB89o+oRRa96dESnh/lt3a92LnS2p5EjET2QUfODe
         ShUMqxBCIM+wzi7ze11Ucv9zcZHFozbkWaSiA5+m0u4HARHuda9NWi9v/OeaN4nAG2/r
         DQJJxv73F+5gsHHKVfYeo6U36s+XqFbrJqGQZwbaXKrQuWLsTdRhElcBXVRRrg/hq+ax
         Kw4Q==
X-Gm-Message-State: AOJu0YwMkfIqR3zNQlALVjEAD36dcSkPgxecrQr0Y/160ZZnCbol2LvG
	lLaJ/8DbBQ7XWmrIQ9lNj/wRTHKYbF+dgDeBbBH13A==
X-Google-Smtp-Source: AGHT+IFZ3NZAFSyxJj8icElVTaEEzHs0mTmf5HaiCvahAmIMW6IV58Wp/pOQOKWT3GQpfjDAato2Bd0/2ySUKL6nrTc=
X-Received: by 2002:a17:907:788c:b0:99b:bc51:8ca3 with SMTP id
 ku12-20020a170907788c00b0099bbc518ca3mr323484ejc.1.1691617252270; Wed, 09 Aug
 2023 14:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
 <20230809-net-netfilter-v2-1-5847d707ec0a@google.com> <20230809201926.GA3325@breakpoint.cc>
In-Reply-To: <20230809201926.GA3325@breakpoint.cc>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 9 Aug 2023 14:40:39 -0700
Message-ID: <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] netfilter: ipset: refactor deprecated strncpy
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 1:19=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Justin Stitt <justinstitt@google.com> wrote:
> > Use `strscpy_pad` instead of `strncpy`.
>
> I don't think that any of these need zero-padding.
It's a more consistent change with the rest of the series and I don't
believe it has much different behavior to `strncpy` (other than
NUL-termination) as that will continue to pad to `n` as well.

Do you think the `_pad` for 1/7, 6/7 and 7/7 should be changed back to
`strscpy` in a v3? I really am shooting in the dark as it is quite
hard to tell whether or not a buffer is expected to be NUL-padded or
not.

