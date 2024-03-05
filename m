Return-Path: <netdev+bounces-77642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063EC87275D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 20:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B22E1F26DCB
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4E22EF3;
	Tue,  5 Mar 2024 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="eyIuCu00"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099717997
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666090; cv=none; b=q2VjXyiDya+WnCu3OxInOiDsLKY79Szj8DkLAMAgCT2NvvpJsckHQNEz/zV5XhrV7LcNCJU32Grgrf7TnBz0pAWkcQMrqDUHIPZdnEjhCetAEvS96Um68ELvr0c/zpkP1S6SOxh5IldOpxyFi9WgtlTnH+SDZtXfBg/IFsftEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666090; c=relaxed/simple;
	bh=oVcaIR3f/LZgftTQjMVNUrpPr3fRC1Olz5EJlBg50do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db4bZjekZVOtG+022YtQXLZVq3oTai3yhVSQJJt+Cq0enyuDuCbBGgVy/u+gVhO6Tau3TogLcsWc6nikQrkfbxj+YYtDRT+7/YPwXgmEY61Dm5/5S8hs89crPlXqLQviNU7JN4rFD+iwcu+QOCmGa5wzrfF4592oyZjDFklqndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=eyIuCu00; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tq4xv4FxfzQcx;
	Tue,  5 Mar 2024 20:14:43 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tq4xt5RWTz3d;
	Tue,  5 Mar 2024 20:14:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709666083;
	bh=oVcaIR3f/LZgftTQjMVNUrpPr3fRC1Olz5EJlBg50do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyIuCu00U99zo12kkYKyA/lBATCMU/x0cvJGLTgBB24Tl/c7d/JeCO9KYfgcq175c
	 R+8w8djwLcouyvk4IHF16yPJhZjO4E98tf++0EX5Ilg6365pUm9eAjRqsZIOZ26G9J
	 mbHQsR0RVGRiuyS6br5vNfn2+/mZJrkGr5xVMOJk=
Date: Tue, 5 Mar 2024 20:14:32 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>, 
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <20240305.sheeF9yain1O@digikod.net>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
 <20240304150411.6a9bd50b@kernel.org>
 <202403041512.402C08D@keescook>
 <20240304153902.30cd2edd@kernel.org>
 <202403050141.C8B1317C9@keescook>
 <20240305.phohPh8saa4i@digikod.net>
 <20240305100639.6b040762@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305100639.6b040762@kernel.org>
X-Infomaniak-Routing: alpha

On Tue, Mar 05, 2024 at 10:06:39AM -0800, Jakub Kicinski wrote:
> On Tue, 5 Mar 2024 17:05:51 +0100 Mickaël Salaün wrote:
> > > I think we have to -- other CIs are now showing the most of seccomp
> > > failing now. (And I can confirm this now -- I had only tested seccomp
> > > on earlier versions of the series.)  
> > 
> > Sorry for the trouble, I found and fixed the vfork issues.  I tested
> > with seccomp and Landlock.  You can find a dedicated branch here (with
> > some Reviewed-by and Acked-by removed because of the changes):
> > https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=kselftest-xfail-fix
> > 
> > Jakub, please send a v5 series with this updated patch and your
> > exit/_exit fixes.
> 
> DaveM merged this already, unfortunately. Could send your changes
> as incremental fixes on top of net-next?

Ok, I'll send that today.

