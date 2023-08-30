Return-Path: <netdev+bounces-31451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F178E0B8
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 22:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3AF280E56
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 20:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1540379C0;
	Wed, 30 Aug 2023 20:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D557476
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 20:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0EAC433C8;
	Wed, 30 Aug 2023 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693427567;
	bh=SzzWusXtXJX5L6WVyCZuB0hjgeuxLc63hlHpUKYBYrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iMBnXw4nwL1/LTlpQevoLpNRzuINhyInuowN0KBMiRolKd93ZVFqv6NulHZz7xJ5y
	 w1I4ORAQ+fGZkisGNKRcqJ36ojp09wb3cF8diM6EnFoi3NFdikEjk6Yo7ETc8YXLDG
	 nImuwK5/6Lu2DGB27luHIPeEOZknem5v91zYk/hhN5E94QQXvlDqa1G9O+QNEHR0Sy
	 qxr/51EDOc5Lva6lfJiCst5GnfkZFXXhHYXNZhLDUqGEYXYkfCbrmi22G7C9F8V6yl
	 FihBNAxP3aAwuV00j6UTUWPF00m+kszZG0qZTex2tDGK+Sh7rp/xDEK+1Q132b2FsN
	 CREZrsQjysJPQ==
Date: Wed, 30 Aug 2023 13:32:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: netdev-driver-reviewers@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [ANN] netdev development stats for 6.6
Message-ID: <20230830133246.1a059f0a@kernel.org>
In-Reply-To: <20230829150539.6f998d1f@kernel.org>
References: <20230829150539.6f998d1f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

A minor follow up / question.

Would it be helpful to generate these kind of stats scoped to
particular companies?

Very few people end up in the top 12. It may not be entirely trivial 
to run these scripts locally because people use their non-company
addresses at times. And because of GDPR and data privacy concerns 
I don't want to upload raw results to GitHub or some such :(

The best idea I could come up with was to post the stats
to a per-company ML. Intel has the "wired" list which is 
a perfect fit. That way the result is accessible to developers,
and they can refer to it in the "performance review" or
whenever they want to get credit for upstream reviews? :)

Does that sound sensible?

Please don't hesitate to LMK either on or off list. 
Particularly if you think this is a bad idea.

And LMK if any other company wants similar stats.

