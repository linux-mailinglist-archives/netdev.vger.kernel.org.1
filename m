Return-Path: <netdev+bounces-18350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941357568AD
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20236281246
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A3BA49;
	Mon, 17 Jul 2023 16:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F84253DE
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 16:05:57 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCFD1B0
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:05:56 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1a1fa977667so3650144fac.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689609955; x=1692201955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnFL1AmrlheeY75vh6+ImZJxiaSYl7pddcdn0WO5Ko4=;
        b=Og7E9Y0BGSs9U4HtJuBz92O5FCZFfUD7Bu5iNoKzoW4e25+9ledteWm+0hcBx8wi0N
         MLTdgyZKDLKzLXSEkx/H2jPMhIdp6Ln8Z53FFcHUkwnWwJqEuFhGv/xAHFfPfGrrM/hX
         e3oPeqqIYVt7wXwoRlTz6irQydaBMW31ZC8L7WxMoSTrza1lCy+sBL/JpKXhqW8dMmTZ
         qENiyUXayZPzeKWhrL2Djot02nFtOL3W0fRMKZaSBPV0SGmU7F/UymPu4Pt/7jZxge4t
         rAEJ/G0RSmLjWG60NDnjRuYVQWYC1TJu7xJIv9nA/vndEANaERhcf5R/paJuG7GZmrOV
         qeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689609955; x=1692201955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnFL1AmrlheeY75vh6+ImZJxiaSYl7pddcdn0WO5Ko4=;
        b=Zc9hHuyd0sZDJr7kM5pfTDp3GI3Vce6bYzYaI+dz6HHX/uYgwpHOM4qHe2484nJ7zG
         iZ0MwxuxcRXB0ioRfKHc6NikV3gVoLX31v1S/eaIz/FYf2HVjoeTXViorKkqvBbi6bTK
         yoiT29D18d8XY7XUndZ7ccZCMQYkFTa5A4Cshn9Ysq/sMh1xLyyiHBcLrNkiLDdeKroz
         RRqruFpNRd/BUsSIUhBGu2S8soQEUk0KIVtkWauphBDUqfsYEd29MZRBGACSBiph8oSx
         jHDtH7Ld6w87jA+IkU8bT44Jx7R3mj0c8wiuREXltjebsam6lj/bk96L17Bo+QgCAAzL
         GS2w==
X-Gm-Message-State: ABy/qLYTNNkWs9tx1ZNtFuxkA7ZVatPmRvDtqR0nPYNu/rFyZ2BHDUOS
	zSmb4C2tzX/V9kZQakPM0Z8svmgZRBW+JPlRgBlr
X-Google-Smtp-Source: APBJJlEkQ8jfboNvol4sSiMDOSxb3dzPR8+YbJL6Osnf4gfzCjolPepfBVC3Z8iLIS3Ip+BO+PBLYW9yf+OYEA0pBoc=
X-Received: by 2002:a05:6870:9726:b0:1b0:5bf7:3bb6 with SMTP id
 n38-20020a056870972600b001b05bf73bb6mr13595803oaq.28.1689609955350; Mon, 17
 Jul 2023 09:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689077819.git.gnault@redhat.com> <980e4d705147a44b119fe30565c40e2424dce563.1689077819.git.gnault@redhat.com>
In-Reply-To: <980e4d705147a44b119fe30565c40e2424dce563.1689077819.git.gnault@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 17 Jul 2023 12:05:44 -0400
Message-ID: <CAHC9VhTrfw+5XJ+Fr0dQg0XayiD5x4-SREjpjOGmqroEbScVgw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] security: Constify sk in the sk_getsecid hook.
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Eric Paris <eparis@parisplace.org>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 9:06=E2=80=AFAM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> The sk_getsecid hook shouldn't need to modify its socket argument.
> Make it const so that callers of security_sk_classify_flow() can use a
> const struct sock *.
>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 5 +++--
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 4 ++--
>  4 files changed, 7 insertions(+), 6 deletions(-)

Thanks Guillaume, this looks good to me.  I had limited network access
last week and was only monitoring my email for urgent issues, but from
what I can tell it looks like this was picked up in the netdev tree so
I'll leave it alone, but if anything changes let me know and I'll
merge it via the LSM tree.

--=20
paul-moore.com

