Return-Path: <netdev+bounces-17656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F61675283F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7391F1C20DEE
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300F01F188;
	Thu, 13 Jul 2023 16:27:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6018017
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619A6C433C7;
	Thu, 13 Jul 2023 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689265647;
	bh=TQd9NwSzph5m0kY0DKUsNIEpK4uft4AQq57KRTzuqAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V+yFRX1bS6xMm0r8EqergiOrYLT06Ej+vU+XAIRpbJksw0aei1tu8m8+JXCjy1qm2
	 vwmXkYERelEg+exLu+Ipk2IcC9nUOg3nXVqlZ6ag4e6zqDU0rIGB7OxcB6zcy5EQDQ
	 N2YEUdvIDtB/87/HoStQLa4GeWR+k7uBiSFm9mY8PqdeGVQsO+BN2HHzlx1Yw26JmY
	 Ht7xjQd2K93y3tGB8eCKl2OoiKrg3Mc5rfN484H7AsP/YEWXs/CPPpmkTUVEYJZzPL
	 ujhagFFVuaE9qefFbZgr4wg1mIwoSGhlKTVig/J0dGS8fWZUQOLyFqQUxOQm82E4rH
	 A1PmPfzP9OYjQ==
Date: Thu, 13 Jul 2023 09:27:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: brouer@redhat.com, netdev@vger.kernel.org, almasrymina@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, edumazet@google.com,
 dsahern@gmail.com, michael.chan@broadcom.com, willemb@google.com, Ulrich
 Drepper <drepper@redhat.com>, Luigi Rizzo <lrizzo@google.com>, Luigi Rizzo
 <rizzo@iet.unipi.it>, farshin@kth.se
Subject: Re: [RFC 00/12] net: huge page backed page_pool
Message-ID: <20230713092726.161f9768@kernel.org>
In-Reply-To: <4b42f2eb-dc29-153e-ace9-5584ea2e5070@redhat.com>
References: <20230707183935.997267-1-kuba@kernel.org>
	<1721282f-7ec8-68bd-6d52-b4ef209f047b@redhat.com>
	<20230711170838.08adef4c@kernel.org>
	<28bde9e2-7d9c-50d9-d26c-a3a9d37e9e50@redhat.com>
	<20230712101926.6444c1cc@kernel.org>
	<4b42f2eb-dc29-153e-ace9-5584ea2e5070@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 12:07:06 +0200 Jesper Dangaard Brouer wrote:
> > For the ptr_ring I was considering bumping the refcount of pages
> > allocated from outside the 1G pool, so that they do not get recycled.
> > I deferred optimizing that until I can get some production results.
> > The extra CPU cost of loss of recycling could outweigh the IOTLB win.
> > 
> > All very exciting stuff, I wish the days were slightly longer :)
> 
> Know the problem of (human) cycles in a day.
> Rizzo's article describes a lot of experiments, that might save us/you 
> some time.

Speaking of saving time - if anyone has patches to convert mlx4 to page
pool I'd greatly appreciate!

