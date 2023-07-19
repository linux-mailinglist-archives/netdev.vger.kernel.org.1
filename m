Return-Path: <netdev+bounces-19138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E15759D7C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 20:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422821C210BF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18968275A2;
	Wed, 19 Jul 2023 18:36:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971F111A9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 18:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147F2C433C7;
	Wed, 19 Jul 2023 18:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689791783;
	bh=i0UCInbZcP5QkOgVWTWoZZYo5sBM7w7AUy/qgXJAKqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OtcJycs603KfeRaT7rm5I5qvi48ExseEPsUdOgdmUBJ+C9LuJxtAuAQ2gk3ug8Kg+
	 Hfq7atKHckdBgbpkYNQOeTF327nRkSySRlK/1pLVPoCrXFf37SPu7KutRPZHnw1Uwf
	 L+MM7I2XhptQuRIWhhM/vRuFHrF7vq8xbLORk8CKC517+UpSu0juNbFRxe391V6fnz
	 algtCABm3I8s9kfiJwZYCO8tvF4ITYt47UZyLSau7rsGSRzCLNzwfRS74BPhRPI553
	 nHxZNYeqsMN9q941DQUgojKWi3PrZxnyrPUELjCMjzJk3Ax4GitepwC9AtARTMXvAx
	 f2ap+e9JCDMQw==
Date: Wed, 19 Jul 2023 11:36:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, linux@leemhuis.info, broonie@kernel.org,
 krzk@kernel.org
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of
 small time maintainers
Message-ID: <20230719113622.27afb5f0@kernel.org>
In-Reply-To: <CAL_JsqKBbP_dXZCbyKtgXVDMV-0Qp8YLQAXANg+_XSiMxou9vw@mail.gmail.com>
References: <20230718155814.1674087-1-kuba@kernel.org>
	<CAL_JsqKBbP_dXZCbyKtgXVDMV-0Qp8YLQAXANg+_XSiMxou9vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jul 2023 11:54:53 -0600 Rob Herring wrote:
> > We appear to have a gap in our process docs. We go into detail
> > on how to contribute code to the kernel, and how to be a subsystem
> > maintainer. I can't find any docs directed towards the thousands
> > of small scale maintainers, like folks maintaining a single driver
> > or a single network protocol.  
> 
> I think the split is great. It would be even better if this
> distinction could be made in MAINTAINERS and then the tools could use
> that. For example, on treewide changes on Cc subsystem maintainers and
> skip driver maintainers. The problem right now is Cc'ing everyone
> quickly hits maillist moderation for too many recipients.

Interesting idea. I wonder how much of this can be accomplished by
improvements to get_maintainers and interpreting what we already have.
There are inverse annoyances, too, where patches for subsystems get
CCed all the way up the hierarchy and including linux-kernel@
for not apparent reason. We have to go sprinkle X: entries in
MAINTAINERS currently to prevent it.

In any case, I think that's a bit tangential. I sent a v3 already
'cause people kept reporting the same typoes :)

