Return-Path: <netdev+bounces-48964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DCD7F0392
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 00:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2801FB2098A
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 23:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15431C684;
	Sat, 18 Nov 2023 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGdFQ7Fa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0961E508;
	Sat, 18 Nov 2023 23:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC071C433C8;
	Sat, 18 Nov 2023 23:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700349754;
	bh=dRhlMOMZc7Ynh+zzEWrF7VAnXdYgBqVfroBd0Kd7Sos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vGdFQ7FaOy4xdKz5BTNwA6NNCJ5XxGyjM/DjwOke7DlE098ZLfazgXqUKMW/ohXts
	 ExxSI9xheSdCn8J0KWZqaulzouLOxrOu6O4M1zY6/CB6kJYI/fvaY8/NbnTfuRsN0Q
	 pXKQgDitNSVfBxUtPXONeiv5lXUvtc0TZxEo2RxAgafNCUxqk/dtnX00AyXd1oYCqx
	 +FnE6QP9coBcTGPjDZ2oQMwdomm4ANMlWbQAQ7IurFhpu8vLeLKAVUdE3GbZ7eVilj
	 377MuK/GqWax7f4ND2jQT5U3ifxjDpkZEaw3tVyCYM99+P4i+0fhETI88takISm5A3
	 cznTd38DgJLwg==
Date: Sat, 18 Nov 2023 15:22:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: try to guide people on dealing with
 silence
Message-ID: <20231118152232.787e9ea2@kernel.org>
In-Reply-To: <dd172cac-f530-4874-a4e7-fc8d7676d708@lunn.ch>
References: <20231118172412.202605-1-kuba@kernel.org>
	<dd172cac-f530-4874-a4e7-fc8d7676d708@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Nov 2023 20:09:43 +0100 Andrew Lunn wrote:
> > +On the other hand, due to the volume of development discussions on netdev
> > +are very unlikely to be reignited after a week of silence.  
> 
> My English parse falls over on 'are', and wants to backtrack and try
> alternatives.
> 
> Maybe:
> 
> On the other hand, due to the volume of development discussions on
> netdev, after a week of silence further discussions are very unlikely
> to occur without prompting.

Hm. The whole "On the other hand, due to".. felt a bit clunky from 
the start, maybe that's the problem? Is this better?

 Generally speaking, the patches get triaged quickly (in less than
 48h). But be patient, if your patch is active in patchwork (i.e. it's
 listed on the project's patch list) the chances it was missed are close to zero.
+
+The high volume of development on netdev makes reviewers move on
+from discussions relatively quickly. New comments and replies 
+are very unlikely to arrive after a week of silence. If patch is
+no longer active in patchwork and the thread went idle for more than
+a week - clarify the next steps and/or post the next version.

