Return-Path: <netdev+bounces-19130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BC4759D3B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 20:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE74028138B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0BA1BB23;
	Wed, 19 Jul 2023 18:26:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4801FB3E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 18:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94506C433C8;
	Wed, 19 Jul 2023 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689791207;
	bh=j2n5w0iDHqceFh/zcYF1K66xYVrTMsBMIJYklZgsxWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DrbOiIEN2ubDOvjGPIpJDrhlkvoyjyIMPKIXE/FROKtOHrcxuXe6zFUYmB7vnnzFG
	 eoY1Y/M/3H+4kTe6s5DABXltXwIE6uT0JqJOcLUNDm5OyvC+e/59yYZAzFdTEC+aOJ
	 MQWcUrjl073N+K+owljRf+zo+B15xZiL85m11/TkcRTVJK/FGH8B6K1dgcNOrowlLo
	 OXeI8mLHRWWRtynNp2PDT1bc8fPel+0dccVSBFV3EA2qLL1jdQK2aPTzvRlxYyE6uM
	 6xthwltUrAJF5WnCwoenDR7w9I8pPd0yfGqt9JitbCAUdVEqAdeAQFDC2qVUlJmu/f
	 MSWXFqoCVZUzA==
Date: Wed, 19 Jul 2023 11:26:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, linux@leemhuis.info, krzk@kernel.org
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of
 small time maintainers
Message-ID: <20230719112646.52977803@kernel.org>
In-Reply-To: <71224ff9-98d0-4148-afb8-d35b45519c79@sirena.org.uk>
References: <20230718155814.1674087-1-kuba@kernel.org>
	<71224ff9-98d0-4148-afb8-d35b45519c79@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jul 2023 20:55:37 +0100 Mark Brown wrote:
> > +Maintainers must be human, however, it is not acceptable to add a mail=
ing
> > +list or a group email as a maintainer. Trust and understanding are the
> > +foundation of kernel maintenance and one cannot build trust with a mai=
ling
> > +list. =20
>=20
> If you're revising this I'd add a note about the L: tag in MAINTAINERS
> here, or possibly just adding a list in addition to humans.  It is
> sensible and often helpful for companies to want to get mail copied to a
> wider distribution list internally but they're not really what we mean
> by list since external people typically can't join them.

=F0=9F=91=8D=EF=B8=8F Added: "Having a mailing list *in addition* to humans=
 is perfectly
fine."

