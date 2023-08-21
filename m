Return-Path: <netdev+bounces-29324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA19782A59
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E45280E63
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7BB6FCA;
	Mon, 21 Aug 2023 13:20:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DDA63DE
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:20:45 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768718F
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=P9MD/LH17yJL0a3UzY8YDWiS7UfvpwwolLYU37OGt5U=; b=fM
	EIRTuYR+Ha+q0Qn7JDMeUMIIYzRFUyzfWvdUXJU48D084xHi4iAS/kAjIoAkqAcQZEGWoBYnF3GIZ
	Ry3B+uQji1XJiRR9iJRUdGCa/KFB2c6nBRmn8Kd0w5H83/rvWxyNT43nC27wIryzwYRAWi321AHYV
	yrNGberFQGxkNVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qY4pm-004guI-Fq; Mon, 21 Aug 2023 15:20:42 +0200
Date: Mon, 21 Aug 2023 15:20:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net] leds: trigger: netdev: rename 'hw_control' sysfs
 entry to 'offloaded'
Message-ID: <5f08d682-8dbb-4f93-aa2a-057ca7a74b9f@lunn.ch>
References: <20230821121453.30203-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821121453.30203-1-kabel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 02:14:53PM +0200, Marek Behún wrote:
> Commit b655892ffd6d ("leds: trigger: netdev: expose hw_control status
> via sysfs") exposed to sysfs the flag that tells whether the LED trigger
> is offloaded to hardware, under the name "hw_control", since that is the
> name under which this setting is called in the code.
> 
> Everywhere else in kernel when some work that is normally done in
> software can be made to be done by hardware instead, we use the word
> "offloading" to describe this, e.g. "LED blinking is offloaded to
> hardware".

I agree with your reasoning.

> Normally renaming sysfs entries is a no-go because of backwards
> compatibility. But since this patch was not yet released in a stable
> kernel, I think it is still possible to rename it, if there is
> consensus.

As you say, this is still in net and so -rc7, not a released
kernel. But we are very close to the release.
 
> Fixes: b655892ffd6d ("leds: trigger: netdev: expose hw_control status via sysfs")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

