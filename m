Return-Path: <netdev+bounces-198254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DD4ADBB12
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8631892F14
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9281028934E;
	Mon, 16 Jun 2025 20:20:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF3BA42;
	Mon, 16 Jun 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105242; cv=none; b=ZliCzlfmo6maah2feHlsVDMzNz7FpQVJMxl+NLsLEweNmH0kXPjYude/AAD7DJsXAP4/bPyFcdZcOjraEtcdRf8qRH4V6wZfzxOJ+TFD8BCTH38XPPKbIVsIGEPhOUla61dd96zUi+1BTiV8fqI+RWB6Q10dCg2Yu8GD0P7PZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105242; c=relaxed/simple;
	bh=0Ryv9UCpOn6jJJKlgtabqaN9ktZGehGgpZGDWaGIGVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+RB2GCAZcyTgw7q3QLlsAFkdNKuQ39iQLG0YXRu9fXwJQNANh89er+rVetDcUJrfi1FLnzsTWRPBy33ff1lbAdVwesZdxTociaeU6P6AxE1QvEt8u2c1n3jMqaHxy2++4sSoAPcK/zMN673s/7xnyRTWXIjU7VGrH6d68ZxLgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id EA9CA140DFB;
	Mon, 16 Jun 2025 20:20:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id ACD2780014;
	Mon, 16 Jun 2025 20:20:35 +0000 (UTC)
Date: Mon, 16 Jun 2025 16:20:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH] net/tcp_ao: tracing: Hide tcp_ao events under
 CONFIG_TCP_AO
Message-ID: <20250616162039.6c030caa@gandalf.local.home>
In-Reply-To: <20250616131825.65e1c058@kernel.org>
References: <20250612094616.4222daf0@batman.local.home>
	<20250614153003.GP414686@horms.kernel.org>
	<20250616144718.4e8e12bf@batman.local.home>
	<20250616131825.65e1c058@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ACD2780014
X-Stat-Signature: zxgueftpktfut71o33xeh3itqyewppis
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/QrVKUF34VSnGMYo8mgDlWQZvoVVtRkoc=
X-HE-Tag: 1750105235-693059
X-HE-Meta: U2FsdGVkX1/Vn+Fk0EmiKG4pbp2Z4qZAwO5j3KL1FUoiwCoeBmmAL5GXGcmyc4wHb+OYnJkr2uFuD2wttsjOoW8RJZoHQmGU8Dfb6k8ev68FJRFAKUku0Yq/OyN8A1nFWNbufKxhY7TEV1rbwLWfVoxITlKlnSqDRzYN6xIlvcQLZ2J1tiv+w7K9qRvmMI9AlkYK3ngDX/0ncvgcZo+FudFdtNfrwvmWbaPnG+t8ZdPvIbOT/RiMfoz15D56E/atkZubz7Ww3VyjbEXHld4qmQgzJAk4BbPH5LZLV6mSYyF6LolXCuuMVhLm7vCWu3Tc8fzrVdlBNoWEFO4QZfQ7v0e72NLWJdVJ

On Mon, 16 Jun 2025 13:18:25 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 16 Jun 2025 14:47:18 -0400 Steven Rostedt wrote:
> > On Sat, 14 Jun 2025 16:30:03 +0100
> > Simon Horman <horms@kernel.org> wrote:
> >   
> > > I agree that the events and classes covered by this #define
> > > are not used unless CONFIG_TCP_AO is set. And that the small
> > > number of TCP_AO related events that are left outside
> > > the define are used even when CONFIG_TCP_AO is not set.
> > > 
> > > Reviewed-by: Simon Horman <horms@kernel.org>    
> > 
> > Should I take this or should this go through the networking tree?  
> 
> Weak preference towards networking tree. We'll apply by the end of 
> the day.

Thanks, much appreciated.

-- Steve

