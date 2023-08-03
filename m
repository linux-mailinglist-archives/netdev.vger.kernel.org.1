Return-Path: <netdev+bounces-24156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAEE76EFD2
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629F328225F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5424121D50;
	Thu,  3 Aug 2023 16:43:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616D1ED5B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 16:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E6DC433C9;
	Thu,  3 Aug 2023 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691081024;
	bh=t2efrwd21vFvvl7GhICo1tZ73gri6q0VneszKH4LxNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=St6hTYZKmM99n7KxnE0J+5FCP45WP+hKD9Nbc28A/nQursI7MwoqUNHEBAfYd57UJ
	 w6LZ46FhYfB9qtbGRXoYHsSSgnNdq1rG56cUvKiiSe2VTIyqmgc4r3aGlPb1oAk9oL
	 NgbdOVyVmrQW1wguLZs3IfHtnREiESDbTqccrxynazZCTkeAi/1G7kNxdHxYd4mvsF
	 dDPx9iM12bzmTtc+F/xpL58KwcWLDT2xsjhdtcav8BNRFjnrYMlE+Z7pQQ5r9lvw+Q
	 B+p2KVsJzjBclYftr5P+z6Hnh7Yn9fs7dZlEYviUGxfr++bPvan5c5mpgi8BVn+fF4
	 l7+ogYlD/+b6w==
Date: Thu, 3 Aug 2023 09:43:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Laszlo Ersek <lersek@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Lorenzo Colitti <lorenzo@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Pietro Borrello <borrello@diag.uniroma1.it>, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/2] tun/tap: set sk_uid from current_fsuid()
Message-ID: <20230803094343.698b3c34@kernel.org>
In-Reply-To: <20230731164237.48365-1-lersek@redhat.com>
References: <20230731164237.48365-1-lersek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 18:42:35 +0200 Laszlo Ersek wrote:
> The original patches fixing CVE-2023-1076 are incorrect in my opinion.
> This small series fixes them up; see the individual commit messages for
> explanation.
> 
> I have a very elaborate test procedure demonstrating the problem for
> both tun and tap; it involves libvirt, qemu, and "crash". I can share
> that procedure if necessary, but it's indeed quite long (I wrote it
> originally for our QE team).
> 
> The patches in this series are supposed to "re-fix" CVE-2023-1076; given
> that said CVE is classified as Low Impact (CVSSv3=5.5), I'm posting this
> publicly, and not suggesting any embargo. Red Hat Product Security may
> assign a new CVE number later.
> 
> I've tested the patches on top of v6.5-rc4, with "crash" built at commit
> c74f375e0ef7.

FTR this was applied yesterday to net. Thanks!

