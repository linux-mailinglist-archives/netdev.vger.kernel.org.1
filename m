Return-Path: <netdev+bounces-248763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD16D0DF25
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 194AE301A33D
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE1C26ED56;
	Sat, 10 Jan 2026 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMhzy3rX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54024DCEB
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087620; cv=none; b=HphIgtPmXlL5Ewa4pJv2/TcXcee17QskwVs3xdOw5IVb/POWlZBDSZVqnG/qs9yU0PFy/q3D0aQb6ZPuBOf0X332AAUpFaJROWBeCknu2yphxXu28nC980ytyAE6t75V/mCj5KKndTUjBRjc80OqJL8RpOJseEt2VBsE1LzKtuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087620; c=relaxed/simple;
	bh=jVOUsMaTdypyqGQYSgvEf129cbV/VtLDShE8P9HcElc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2e5152BtG0S8wb6J8zDvM0CEu13KYo3JHxLEfA+PA2CPh/e/RcGDfKSsOrRyclBXqDh6nBv8KbWaCJkda5CZI0cqbUpInU66pUu5gTtOeU2eLhzgKd8TJf9ts8SpRwDw8UY45KuNWcxpd2vk6Vlcmfw1L+hi+JZ1OEbcICCdRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMhzy3rX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C2CC16AAE;
	Sat, 10 Jan 2026 23:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768087619;
	bh=jVOUsMaTdypyqGQYSgvEf129cbV/VtLDShE8P9HcElc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CMhzy3rX0cZg8hTUV1IwJ1j6NS2cFaC/RawHFKIhE99+lNFwL9VMzaxCmQfcCLgwq
	 wiQdJgLjTlHVqf2Mzr2ZhxBV8s6fzwahAB5lSnFY9jZbQH83cyFQrER6ZbRkEraT8g
	 gyi9UTu+7/HT1WitDM+9kx4S6UlXPRy4UpmhrjVNoLhXdoXeP+wKxO0G9RGSe35eWc
	 kTfZfpS5kUSaMfL9znHh3MZWY5C/XsLUOISY+Yck26bqmUw0xrl65vMSclQKTf80Pv
	 lnIPMHcrrCn+bU8wenJvC75SmIEuskZNQAx7GbCczGYYIeM0dHuX4S/ol2nzk9ip95
	 BysT6XPd5AIiw==
Date: Sat, 10 Jan 2026 15:26:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, gal@nvidia.com
Subject: Re: [PATCH net-next 2/7] tools: ynl: cli: wrap the doc text if it's
 long
Message-ID: <20260110152658.2c828621@kernel.org>
In-Reply-To: <20260110110757.6dde2d45@kernel.org>
References: <20260109211756.3342477-1-kuba@kernel.org>
	<20260109211756.3342477-3-kuba@kernel.org>
	<aWKiqKPYiAeeyhPq@mini-arch>
	<20260110110757.6dde2d45@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2026 11:07:57 -0800 Jakub Kicinski wrote:
> > > +                if sys.stdout.isatty():
> > > +                    term_width = shutil.get_terminal_size().columns
> > > +                else:
> > > +                    term_width = 80
> > > +                doc_text = textwrap.fill(attr.yaml['doc'], width=term_width,
> > > +                                         initial_indent=doc_prefix,
> > > +                                         subsequent_indent=doc_prefix)    
> > 
> > Any specific reason you wrap to 80 for !isatty?  
> 
> not really, just the default width of a classic terminal
> the textwrap library defaults to 70 which is another option tho
> I doubt there's a strong reason behind that value either..

Experimenting with this a little bit more it looks like shutil does the
right thing and returns 80 if not sys.stdout.isatty() Let me respin v2
with the condition removed.
-- 
pw-bot: cr

