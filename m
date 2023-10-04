Return-Path: <netdev+bounces-38021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E227B8682
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B97451C208C2
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009F31CF94;
	Wed,  4 Oct 2023 17:28:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9611BDC1;
	Wed,  4 Oct 2023 17:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9E8C433C8;
	Wed,  4 Oct 2023 17:28:48 +0000 (UTC)
Date: Wed, 4 Oct 2023 13:29:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Message-ID: <20231004132955.0fb3893d@gandalf.local.home>
In-Reply-To: <20231004095431.1dd234e6@kernel.org>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
	<20231004092205.02c8eb0b@kernel.org>
	<20231004123524.27feeae7@gandalf.local.home>
	<20231004095431.1dd234e6@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Oct 2023 09:54:31 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 4 Oct 2023 12:35:24 -0400 Steven Rostedt wrote:
> > > Potentially naive question - the trace point holds enum skb_drop_reason.
> > > The user space can get the names from BTF. Can we not teach user space
> > > to generically look up names of enums in BTF?    
> > 
> > That puts a hard requirement to include BTF in builds where it was not
> > needed before. I really do not want to build with BTF just to get access to
> > these symbols. And since this is used by the embedded world, and BTF is
> > extremely bloated, the short answer is "No".  
> 
> Dunno. BTF is there most of the time. It could make the life of
> majority of the users far more pleasant.

BTF isn't there for a lot of developers working in embedded who use this
code. Most my users that I deal with have minimal environments, so BTF is a
showstopper.

> 
> I hope we can at least agree that the current methods of generating 
> the string arrays at C level are... aesthetically displeasing.

I don't know, I kinda like it ;-)

-- Steve

