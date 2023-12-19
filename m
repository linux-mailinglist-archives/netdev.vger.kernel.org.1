Return-Path: <netdev+bounces-58829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B4C818515
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 11:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170661C20AA6
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19D14286;
	Tue, 19 Dec 2023 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFDC4x1b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076C14275;
	Tue, 19 Dec 2023 10:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4A0C433C9;
	Tue, 19 Dec 2023 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702980727;
	bh=BZrEszKUcvt1KXwaUy68ZV34ShH2PIpSZfr+gPHVJ5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFDC4x1bzF7SYYERBSQ1gwN/ak71N/qbFUgU6UiGwaWGVWvji8GH0uQsrS+Otgu2F
	 JwO6pxATBL/T+GsWdMp/Fusw0op/jcG3XXcNglyDMnPf98wVCoGMeoDX+UKZTXHmQ2
	 RWMPK07weHFS6BinjNo8kyLSjLCI066r5HtBRM8R0Erc0l4VJxr2Jdp0r8u1NRXpYj
	 yQzUyDxaI7eWSgqjjxZLD9GTNPCvMtjptnHG5UUcOxMocUHDvsQlAaxA+7XnPppa16
	 Piwq7FMhKXrdCI7KBPlYi0A5tJ+wrLMHmNIsOu0F5N+D2U6Gha2ouGkaxXa/Mzh7Ev
	 hvb6x71W/9X1w==
Date: Tue, 19 Dec 2023 10:12:02 +0000
From: Simon Horman <horms@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH iwl-next] i40e: Avoid unnecessary use of comma operator
Message-ID: <20231219101202.GE811967@kernel.org>
References: <20231217-i40e-comma-v1-1-85c075eff237@kernel.org>
 <CAKwvOd=ZKV6KsgX0UxBX4Y89YEgpry00jG6K6qSjodwY3DLAzA@mail.gmail.com>
 <20231218190055.GB2863043@dev-arch.thelio-3990X>
 <CAKwvOd=LjM08FyiXu-Qn7JmtM0oBD7rf4qkr=oo3QKeP+njRUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=LjM08FyiXu-Qn7JmtM0oBD7rf4qkr=oo3QKeP+njRUw@mail.gmail.com>

On Mon, Dec 18, 2023 at 11:08:38AM -0800, Nick Desaulniers wrote:
> On Mon, Dec 18, 2023 at 11:00 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Mon, Dec 18, 2023 at 08:32:28AM -0800, Nick Desaulniers wrote:
> > > (Is -Wcomma enabled by -Wall?)
> >
> > No and last time that I looked into enabling it, there were a lot of
> > instances in the kernel:
> >
> > https://lore.kernel.org/20230630192825.GA2745548@dev-arch.thelio-3990X/
> >
> > It is still probably worth pursuing at some point but that is a lot of
> > instances to clean up (along with potentially having a decent amount of
> > pushback depending on the changes necessary to eliminate all instances).
> 
> Filed this todo:
> https://github.com/ClangBuiltLinux/linux/issues/1968
> I'd be happy if Simon keeps poking at getting that warning enabled.

FWIIW, since the discussion cited above I have been keeping an eye on
-Wcomma, mostly wrt to patches for Networking code.

My subjective feelings on this are:

* Few new instances seem to be added
* There are some, though I wouldn't say a lot, of existing
  instances in files that are that is being updated.
* I don't recall any of the instances, new or old, being bugs.
  Though perhaps a very small number were.

So while I'm all for more checks.
And I'm all for only using the comma where it is necessary
(I suspect that often it is a typo).
I do not get the feeling that we are sitting on a trove of nasty bugs.

