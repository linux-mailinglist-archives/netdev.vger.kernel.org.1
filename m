Return-Path: <netdev+bounces-29405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EDE783057
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470251C20980
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C54A17;
	Mon, 21 Aug 2023 18:37:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAEE3FC8
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 18:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4B8C433C7;
	Mon, 21 Aug 2023 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1692643047;
	bh=zTQ1+IeazDrIptXEwZ0bTowf4Ep2OUQZXD5/3+wyHXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qskHK/C+6Wjdwz/vQ1vj5zMKctaF2aY2HPiWyVhSDVJS9XmvFVPthWq3IikbwNgIj
	 ssRYGOOkwFxYmafvbCNoFD5E4mkKZwM/bl1KIg1taUBMm+dqIw1pwGS6yKuUTx0uAK
	 pEe0PH4nR4AoJeUsnbxwA50Vls7ade+GRDTANxG0=
Date: Mon, 21 Aug 2023 20:37:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, stable@vger.kernel.org,
	netdev@vger.kernel.org, Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH stable v4.14.y - v6.4.y] af_unix: Fix null-ptr-deref in
 unix_stream_sendpage().
Message-ID: <2023082117-henchman-applicant-bbe1@gregkh>
References: <20230821175505.23107-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821175505.23107-1-kuniyu@amazon.com>

On Mon, Aug 21, 2023 at 10:55:05AM -0700, Kuniyuki Iwashima wrote:
> Bing-Jhong Billy Jheng reported null-ptr-deref in unix_stream_sendpage()
> with detailed analysis and a nice repro.

Thanks, now queued up.

greg k-h

