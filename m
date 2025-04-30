Return-Path: <netdev+bounces-187147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACDBAA5394
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 20:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B67A9C75C8
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686622750F1;
	Wed, 30 Apr 2025 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRVgvaBA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8B265CCB
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746037021; cv=none; b=HyzN57UX5VzNyJRQpLgQG7MfDVx056baqS/P64Z/wycnWHzN/oqHkZuJt8xjv3iIdWJB5rtGuVkagguLbfKFoerSV3erj/SwpZz/c1wg6MTtvTFG8d/+wqbN6sA9j6ouvo7gUORomnA+3oRt2H0+IYI6kEedpYGGi5rlApELWwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746037021; c=relaxed/simple;
	bh=Nxdi4CYJTAlreKYjukkBrN0GQ02KL+2tFbybLRBhZF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwWmYa9dCKkWaP8zefJs6xpiFO7kMZjajjEF9E9rUDsx1Tq0mJlyGm+NGQCCnc9Jmz9rwNKiD0SoL4UovD+jbMpAsX9H8yO6c40200QKmZaz/wkWNbgbM9i7jS3KKlI08K0KNDwHoHDOlG8Bg05tHW6WAugNslGScgNR2lYDqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRVgvaBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD12C4CEE7;
	Wed, 30 Apr 2025 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746037020;
	bh=Nxdi4CYJTAlreKYjukkBrN0GQ02KL+2tFbybLRBhZF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRVgvaBAQ6TUC9Pejw4EY6FFKLYi+9Yy6AmweeUDU6iRlELIaqiK5TIWTywFv6MF/
	 Q6LGGUBVSZYsGhmJonMmGURvjW2eaOE+G4W/4p4rOpkn0jTk3otN+a2WDh8ZbPeynv
	 cPCBqe9yJJ3KfXsCti96XH9Iwoo8cNy9Pe/bpigWuh2ZlPRxOyGvNDBGjyKYCPN/Cp
	 ZHtPfUBwadooo1aQz+JdbzMzUuTLJUqGfg+oawVtgONtfaLLuqpetafhWNtf6upPLg
	 +xPzFRw3h506Glc/o4Qpv4UlDTM1XTfKs7EqYsfp2DaH/csaGdJlHFFuJpheuqJ1//
	 dkks0UYGMUYdQ==
Date: Wed, 30 Apr 2025 19:16:57 +0100
From: Simon Horman <horms@kernel.org>
To: Shankari <shankari.ak0208@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: rds: Replace strncpy with strscpy in connection
 setup
Message-ID: <20250430181657.GW3339421@horms.kernel.org>
References: <20250424183634.02c51156@kernel.org>
 <20250426192113.47012-1-shankari.ak0208@gmail.com>
 <CAPRMd3mRUi+ESqDy04c-r38JoSWxo8Ka0Et9gZbe+jRrL6G_nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPRMd3mRUi+ESqDy04c-r38JoSWxo8Ka0Et9gZbe+jRrL6G_nQ@mail.gmail.com>

On Sun, Apr 27, 2025 at 12:56:14AM +0530, Shankari wrote:
> Hi Jacub,
> 
> I have implemented the changes in the v2 patch. Thanks for your review.
> 
> On Sun, Apr 27, 2025 at 12:51 AM Shankari Anand
> <shankari.ak0208@gmail.com> wrote:
> >
> > From: Shankari02 <shankari.ak0208@gmail.com>
> >
> > This patch replaces strncpy() with strscpy(), which is the preferred, safer
> > alternative for bounded string copying in the Linux kernel. strscpy() guarantees
> > null-termination as long as the destination buffer is non-zero in size and provides
> > a return value to detect truncation.
> >
> > Padding of the 'transport' field is not necessary because it is treated purely
> > as a null-terminated string and is not used for binary comparisons or direct
> > memory operations that would rely on padding. Therefore, switching to strscpy()
> > is safe and appropriate here.
> >
> > This change is made in accordance with the Linux kernel documentation, which
> > marks strncpy() as deprecated for bounded string operations:
> > https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> >
> > Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> > ---
> >  net/rds/connection.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/rds/connection.c b/net/rds/connection.c
> > index c749c5525b40..fb2f14a1279a 100644
> > --- a/net/rds/connection.c
> > +++ b/net/rds/connection.c
> > @@ -749,7 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
> >         cinfo->laddr = conn->c_laddr.s6_addr32[3];
> >         cinfo->faddr = conn->c_faddr.s6_addr32[3];
> >         cinfo->tos = conn->c_tos;
> > -       strncpy(cinfo->transport, conn->c_trans->t_name,
> > +       strscpy(cinfo->transport, conn->c_trans->t_name,
> >                 sizeof(cinfo->transport));

Because cinfo->transport is an array it's length is sizeof(cinfo->transport),
as used above. But for the same reason the two-argument version of
strscpy() can be used here.

	strscpy(cinfo->transport, conn->c_trans->t_name);

Similarly if, based on my understanding of Jakub's feedback,
strscpy_pad() should be used.

> >         cinfo->flags = 0;
> >
> > @@ -775,7 +775,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
> >         cinfo6->next_rx_seq = cp->cp_next_rx_seq;
> >         cinfo6->laddr = conn->c_laddr;
> >         cinfo6->faddr = conn->c_faddr;
> > -       strncpy(cinfo6->transport, conn->c_trans->t_name,
> > +       strscpy(cinfo6->transport, conn->c_trans->t_name,
> >                 sizeof(cinfo6->transport));

Ditto.

> >         cinfo6->flags = 0;
> >
> > --
> > 2.34.1
> >
> 

