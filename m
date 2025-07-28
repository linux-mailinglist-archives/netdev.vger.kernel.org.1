Return-Path: <netdev+bounces-210516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112E5B13BF3
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA0517C8A0
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 13:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F042269D11;
	Mon, 28 Jul 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWEgpl9k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702C262FF0;
	Mon, 28 Jul 2025 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710596; cv=none; b=MT+vJ3I8AuJ4JcTdzVJaHEnbcZppb8mJuv/8l0lCDRKo7u8NeYNAw8w4Dq3iqYew61Kuh+UVRq+cpc0JU6z+oQ/WpeXJ6v1r2epxC2/SKq8JjKr0L8759tPe5Q9MnmdAMuvXhPuHR6AVFXK0E/3cpBh6xJGn49M2LSHUJ7cvru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710596; c=relaxed/simple;
	bh=Gy8BBiEAPALvc01PibnEwxXobZrOY+POP6zVBySxNgY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ou9Yv6xuM8C6rA9mN3wggyrNAHI3tcICDiLAJVTBymtNpLd2ABaKlws0NSVcWFGWJME2vA3qvgbLeQCQy4qhMZVyqt/2RI7YzmloWjb4HtqbtQTlqK4tbO9C1Zf7eD2s665mu+i/sl15PAUft3BSSYrK0N7XamPj5uw8MUV3IVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWEgpl9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99183C4CEE7;
	Mon, 28 Jul 2025 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710595;
	bh=Gy8BBiEAPALvc01PibnEwxXobZrOY+POP6zVBySxNgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aWEgpl9kCDBr28CDsocZCSe/2uhX1euPG4F66gUhK3y+gyQI6pwR+3kewoIsRHo5k
	 AaKPdIoqzvlSbLs7X0DR2qh9IlxJWwiv3n3pZ81f7H+pMMTFB3MwKerWC0UPJFVtkR
	 vheZdGCMbicD3u2umbXAqJL96eQGzSwzJCG2JYtrpVoX7WP1O6EruI9FfaKIpifLw3
	 ER6sZAniWdg66V1yNyFsm60ZAEI6qy+Niq3xyEifG3vC/NVq+WUDsk8yzWiV2a8n+L
	 nm13Atz1BeW0HtllKns9erchysBJH3AfWvQPZ/kNWdyzxOvLzOVZ0SLS0E3580x8rn
	 3CaqLUjtsRv8g==
Date: Mon, 28 Jul 2025 08:49:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] net: Fix typos
Message-ID: <20250728134954.GA3227267@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08deec62-e20a-4a54-a655-38a0335a74cd@gmail.com>

On Mon, Jul 28, 2025 at 02:19:41PM +0100, Edward Cree wrote:
> On 23/07/2025 21:15, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Fix typos in comments and error messages.

> > +++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
> 
> mcdi_pcol.h is automatically generated from an external source (it comes
>  from the firmware development team), these fixes will likely be
>  overwritten next time we pull in updates.  I will try to get them fed
>  back into the upstream sources.

Thanks!  Is there any way to include a note in the generated file
about the fact that it is generated, and maybe a pointer for where to
send corrections?  It looks like others have made the same mistake
before, but maybe those fixes got fed back upstream behind the scenes:

  982a2b5ffdbb ("sfc: fix repeated words in comments")
  ac6bef064f71 ("sfc: Fix spelling mistake "writting" -> "writing"")
  0f5e15583060 ("scripts/spelling.txt: add "an one" pattern and fix typo instances")

> > +++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
> > @@ -442,7 +442,7 @@ static void efx_tc_update_encap(struct efx_nic *efx,
> >  			rule = container_of(acts, struct efx_tc_flow_rule, acts);
> >  			if (rule->fallback)
> >  				fallback = rule->fallback;
> > -			else /* fallback fallback: deliver to PF */
> > +			else /* fallback: deliver to PF */
> >  				fallback = &efx->tc->facts.pf;
> >  			rc = efx_mae_update_rule(efx, fallback->fw_id,
> >  						 rule->fw_id);
> 
> This wording was intentional, not a type: delivery to the PF is the
>  second-layer fallback when there is no fallback action, which makes it
>  the fallback to the fallback.
> I will post a partial revert to change this line back.

Oof, sorry about that!  Adding something about this being a
second-layer fallback, or a default or last resort when there is no
fallback, might help avoid confusion.

Bjorn

