Return-Path: <netdev+bounces-74277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FC5860B27
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 08:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494111F22107
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392A12E6F;
	Fri, 23 Feb 2024 07:08:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F212E6C
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672132; cv=none; b=nF8TlhqgQypVsoXDK5/+9Id6PC0wSyW1rqTh8K3sEveUUmaTmZNMUOuvMkPB6ZjQ66qtI+f7lE3pRhRdbWutEQ1DeGAcgfczNnV3MuphyigkJiKjj+bnIIVLmBHXTi8NJ/uEQpa8v4/ivxvO/tNjnWIIzxD+rSlo5+NLvB91h70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672132; c=relaxed/simple;
	bh=/RSHtva03pJlz38QVk1XqYIs88C6KQpwpJz5TT3ylWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aB/vywhz6Y6Sqgi8lls0OgsKHEYF47XuKJqt44WjoBbAqjffEEU8ODB6tvEyVy1CPF/bdA4tJX1UB6XDwaIHkts9gx/Fgx8T/Od3nrgbJhb/PB0bLJMh/r4g1ZT4uzUhJfpJkLVnpJ1AttezmdsVCDFbj26w8eRPNqRTzjpsJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rdPfr-0002zU-1I; Fri, 23 Feb 2024 08:08:47 +0100
Date: Fri, 23 Feb 2024 08:08:47 +0100
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: mpls: error out if inner headers are not set
Message-ID: <20240223070847.GA24292@breakpoint.cc>
References: <CANn89iJZnY_0iM8Ft9cAOA7twCb8iQ4jf5FJP8fubg9_Z0EZkg@mail.gmail.com>
 <20240222140321.14080-1-fw@strlen.de>
 <20240222193320.58e34be1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222193320.58e34be1@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 22 Feb 2024 15:03:10 +0100 Florian Westphal wrote:
> > Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push helpers")
> 
> This is for net-next, right?

Yes, indeed, this is better suited for net-next.

