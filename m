Return-Path: <netdev+bounces-27196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1377AB29
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 22:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF089280FAF
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 20:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F149457;
	Sun, 13 Aug 2023 20:22:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE35A9443
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 20:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01502C433C7;
	Sun, 13 Aug 2023 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691958151;
	bh=mGaxb/v93wxDqmTbSSYAvxfquShX5rFkS3m7T1jd2ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cH8v7AQ5dn480AL1+dwxHnHHbDNogreUZb4lh1Xp86gJBrEFYi7SJuhXAIkWUf0y5
	 UzuvLoWpQdzPnMl2dh/1SuAO7TZhm+VCzw6HVib+N1DPLXLPHE5m4CRUV8+xzraQl9
	 9Zcdp1f/Tv/ZwBRVVZbG1WxZSzSOfu/Ok4PEvReI=
Date: Sun, 13 Aug 2023 22:22:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 4.19/5.4/5.10/5.15/6.1 0/1] sch_netem: fix issues in
 netem_change() vs get_dist_table()
Message-ID: <2023081318-dental-rocker-796a@gregkh>
References: <20230813200746.288589-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813200746.288589-1-pchelkin@ispras.ru>

On Sun, Aug 13, 2023 at 11:07:45PM +0300, Fedor Pchelkin wrote:
> Commit 2174a08db80d ("sch_netem: acquire qdisc lock in netem_change()")
> was backported to older stables where it is causing 'sleeping in invalid
> context' bug. The following patch fixes the problem and can be cleanly
> applied to the stable branches affected. It was backported to 6.4.y about
> a month ago.

Now queued up, thanks.

greg k-h

