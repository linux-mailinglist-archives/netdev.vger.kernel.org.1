Return-Path: <netdev+bounces-58827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2EB8184FA
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 11:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279F61C23550
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A21426D;
	Tue, 19 Dec 2023 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf0ZkjDF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345D14265;
	Tue, 19 Dec 2023 10:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB051C433C7;
	Tue, 19 Dec 2023 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702980328;
	bh=BhpwEVgkX8t5FMZrEaOtiZBqFEAb7r/etFz6GvlMCVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bf0ZkjDFVCYcf+YVApvlzzFraAlgWb5am3k0eE/qi69tprIMIzpFuIHZ1FfIa6XQv
	 MBBV4AlpXXPUBc28+uqe+BQRzoside80HYSw3iw0sa0dT51WR1AVlniQdNcWT2C2Id
	 QWn8GnQHG9t0lHLvYRyRO5ewL0Sgrrgcnfp9zWRT2bvOlo2vjs70+8ynLy7UlGdwzk
	 xhZt0+17AazmZ2IaWUX4XkXlJI6e4TRdnrRbZ87nliT/wBZtns2jTkg2L2E0rGYMvO
	 xDSCwTmmWjqoMWKfxm2yFvMpx9pLmq6UnwMdDXMpypOF+TQTnmqDufdCxhrBGgTYpw
	 rVAiC7czOc4IQ==
Date: Tue, 19 Dec 2023 10:05:23 +0000
From: Simon Horman <horms@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH iwl-next] i40e: Avoid unnecessary use of comma operator
Message-ID: <20231219100523.GD811967@kernel.org>
References: <20231217-i40e-comma-v1-1-85c075eff237@kernel.org>
 <CAKwvOd=ZKV6KsgX0UxBX4Y89YEgpry00jG6K6qSjodwY3DLAzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=ZKV6KsgX0UxBX4Y89YEgpry00jG6K6qSjodwY3DLAzA@mail.gmail.com>

On Mon, Dec 18, 2023 at 08:32:28AM -0800, Nick Desaulniers wrote:
> On Sun, Dec 17, 2023 at 1:45 AM Simon Horman <horms@kernel.org> wrote:
> >
> > Although it does not seem to have any untoward side-effects,
> > the use of ';' to separate to assignments seems more appropriate than ','.
> >
> > Flagged by clang-17 -Wcomma
> 
> Yikes! This kind of example is why I hate the comma operator!
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> (Is -Wcomma enabled by -Wall?)
> 
> Is there a fixes tag we can add?

Hi Nick,

I don't believe this resolves a user-visible bug,
so for Networking code a fixes tag isn't appropriate.

> 
> >
> > No functional change intended.
> > Compile tested only.
> >
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > index 812d04747bd0..f542f2671957 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > @@ -1917,7 +1917,7 @@ int i40e_get_eeprom(struct net_device *netdev,
> >                         len = eeprom->len - (I40E_NVM_SECTOR_SIZE * i);
> >                         last = true;
> >                 }
> > -               offset = eeprom->offset + (I40E_NVM_SECTOR_SIZE * i),
> > +               offset = eeprom->offset + (I40E_NVM_SECTOR_SIZE * i);
> >                 ret_val = i40e_aq_read_nvm(hw, 0x0, offset, len,
> >                                 (u8 *)eeprom_buff + (I40E_NVM_SECTOR_SIZE * i),
> >                                 last, NULL);
> >
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

