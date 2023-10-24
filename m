Return-Path: <netdev+bounces-43752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44397D48C8
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B227D1C20B15
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72C113AD7;
	Tue, 24 Oct 2023 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Gl7KKMp0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D23FE1
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:40:50 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E3EB7;
	Tue, 24 Oct 2023 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wDdZe1ccmDlYEf7VbnHjWqpDq2mjMLwOKz8KmLSioHo=;
	t=1698133248; x=1699342848; b=Gl7KKMp0/2fbMdEI06eSLpDgullckzYiFaDvSwo9zirYEB8
	AGu5CMj5/EaI9eRCv+pP4/XLq68tY52rGnAWQJO2X3IcOQGJf3NKnTH/ykwWh4Kl0hNmnoJy019N3
	3Jxg1zepg2E6OMI7uv3YWXtXi/1sHRjF+JnUySi8LIwKMaMzYGNbeea1YcuTkrikrldmkDQLoh+B4
	eYDIZKSZm6qCANGEPgMHXh1IH/a4C7lzfBe+EhGYKsaigP4I2AMdWG8z657ZixF7oQZI7t/IZO97K
	gaiiVStt850HFiyVbiEQZinMdsnlJvV43DHqtrZ8ZLD8/8ifgCEDY7WLR3AWQ7Uw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvC1s-00000001IKI-3VUL;
	Tue, 24 Oct 2023 09:40:45 +0200
Message-ID: <3a68f9ff27d9c82a038aea6acfb39848d0b31842.camel@sipsolutions.net>
Subject: Re: [PATCH net v2 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Networking <netdev@vger.kernel.org>, Loic Poulain
 <loic.poulain@linaro.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Date: Tue, 24 Oct 2023 09:40:43 +0200
In-Reply-To: <20231023185221.2eb7cb38@kernel.org>
References: <20231023032905.22515-2-bagasdotme@gmail.com>
	 <20231023032905.22515-3-bagasdotme@gmail.com>
	 <20231023093837.49c7cb35@kernel.org>
	 <e1b1f477-e41d-4834-984b-0db219342e5b@gmail.com>
	 <20231023185221.2eb7cb38@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-10-23 at 18:52 -0700, Jakub Kicinski wrote:
>=20
> > He's now in a state of limbo. He has significant contribution
> > (and gets listed by get_maintainer script with (AFAIK) no way
> > to filter him out), yet emails to him bounces. What will be
> > the resolution then?
>=20
> Yes :( Not much we can do about that (even if we drop him from
> maintainers all fixes will CC him based on the sign-off tags).

I was hoping he'd chime in here - I did manage to find him at his
personal address, but I didn't want to just add his personal address to
the public list.

If he's OK with exposing his personal (or new work?) address I guess we
could add him to the .mailmap, to address this particular problem.

Anyway I've BCC'ed him now (Hi Chetan :) ), but he had also said he was
checking with his new work about this all.

johannes

