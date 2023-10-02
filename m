Return-Path: <netdev+bounces-37459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9801C7B56E4
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 19165282477
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F421C6AD;
	Mon,  2 Oct 2023 15:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA66199CA
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:51:45 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C3AA4
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:51:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b29186e20aso1607211666b.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 08:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1696261900; x=1696866700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpFVhwvvyKOhe8Ad0bzCkIEDZEU9f12oQEadNgJFOWA=;
        b=Ch1B0tg+T1Eu7ArABnLtTsuSuDUzqmBMn2jhxq7lyucESabNXHp8OHfHitOkee0RHq
         +v2iQd2eMF/VNspPXdTQg3vQCTpYlx7suuNZ9QXseoXd0we2YF/kTM2tH3LCS1Yqqcu/
         ykQzDAQZjmQXSFAi5DANkeA+qGCYQKjpBSiURlWhY44gGMgtRuGWkXM9E25tLhqoP8d+
         vAJPOnKhAjloddDaTufWEOfDXTiGTeQuVW0kbF09uM7CdmWkzSB9pq6DWGPhBQoLj8lX
         W4B799PzyLU3Iv/Pj1WCcsBZaTYNBT5GwyCVM4oCiRNMYcYsNTYn51YfQJaG4L+lxTYl
         hXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696261900; x=1696866700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpFVhwvvyKOhe8Ad0bzCkIEDZEU9f12oQEadNgJFOWA=;
        b=ZOfVX8m3nV85fWRdLCwQpdzN8vlq6Vxm1vusQ9SPbwxWNCysBp7cHacvOR5GQgmXWg
         hZDsiasDqhlCNabrbzgba83OItWQ27luW5/2ZpzfV6/7cV1Dchs4SoHGAABbGn2Bccd+
         6RjtYa1dN5fg6R89sKsNiG5ratnz3nUYWnmZh/GsVM7vvpGGSYWoid67HVcHjX4NI/Dz
         Ubd7Zm7CK1dve+BKn3VXhdTKAxmPZfK7cZ4vAzkX58q7qXy2qlWquASoFMJU3x6yqrPk
         WWN9bxNl6/mbUeEaTkVZOuKbJW5maJyd46VPvPKhBfI/ypuJDIDx6kFAIKuh9oongtWn
         ON5A==
X-Gm-Message-State: AOJu0YyTQvr+EZ8OT1clUBNlIY3pOnFdubLbsUw6GD1ZafNqfFVx07uZ
	+rMhnbtzDxSTptcZmhCNwr5jUojbhjoPRwkpSI7V7g==
X-Google-Smtp-Source: AGHT+IFq5bmkuGiToH1F0K2G2b1y3FT9p5rJjAGCpVshgz+oirRuPTK3PQzffnVUecToJJXkWRVuv1IXYmxeAADVNf0=
X-Received: by 2002:a17:906:739b:b0:9ae:38d0:ef57 with SMTP id
 f27-20020a170906739b00b009ae38d0ef57mr10221900ejl.66.1696261900467; Mon, 02
 Oct 2023 08:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZRcOXJ0pkuph6fko@debian.debian> <20230930110854.GA13787@breakpoint.cc>
 <CAF=yD-JR8cxEt6JRhmMyBFucyHtbaKrarDh=xN7jeT2obBsCRQ@mail.gmail.com>
In-Reply-To: <CAF=yD-JR8cxEt6JRhmMyBFucyHtbaKrarDh=xN7jeT2obBsCRQ@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 2 Oct 2023 10:51:29 -0500
Message-ID: <CAO3-PbrN1fXsWoPeKn0swbBRihuUfRjMfXxKHo47USHhiSdwMw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: avoid atomic fragment on GSO packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 1:53=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> To add to that: if this is a suggestion to update the algorithm to
> match RFC 8021, not a fix for a bug in the current implementation,
> then I think this should target net-next.

Ack

