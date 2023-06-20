Return-Path: <netdev+bounces-12338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA6E7371F5
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA6A2813BE
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BA62AB28;
	Tue, 20 Jun 2023 16:42:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7D2AB20
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3973C433C8;
	Tue, 20 Jun 2023 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687279347;
	bh=xGO7ZSTqNQ+wuxoAioN5+dW0PlyPgIm2sknw/OCQ8/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uq4oAvbjyqGCsQYwYKam7WXy5pj3VgRmNI5igkZh6brpB2jBFnyeFV2zlJLVkkQsG
	 LdElDqc7cMLAZziAJ00+POhANG4mfRPf6HQVSCI4pFs/cFxGQOJDJUw60sMklGLJwY
	 81WOw3qMvzPFefkHi7hrRgkhWuk3hXA2n+sYng9gURLPO4hEan6ulYHCgMXyHK5B17
	 YONhJ2kQ8QdHZkg1QziYCj01zgiFGsYBUyv2/JCLMZgESNdZd1+vvXgnc+tJrg23nW
	 5d0peJBXUszjJgxkakYTR6JYStnvcct1Th/xBPRDRpvwC0aiq78PiuuwUuL97U//PY
	 fqOv+F4Me49ZA==
Date: Tue, 20 Jun 2023 09:42:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maftei, Alex" <alex.maftei@amd.com>
Cc: "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net 1/2] selftests/ptp: Add -x option for testing
 PTP_SYS_OFFSET_EXTENDED
Message-ID: <20230620094226.170f7e7b@kernel.org>
In-Reply-To: <BN7PR12MB2835AE60CC3164A47FD21C8BF15FA@BN7PR12MB2835.namprd12.prod.outlook.com>
References: <cover.1686955631.git.alex.maftei@amd.com>
	<e3e14166f0e92065d08a024159e29160b815d2bf.1686955631.git.alex.maftei@amd.com>
	<BN7PR12MB2835AE60CC3164A47FD21C8BF15FA@BN7PR12MB2835.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jun 2023 09:46:33 +0000 Maftei, Alex wrote:
> I see I've accidentally sent an older revision of the patch series, before I've rebased properly and before I used checkpatch.
> I will send the fixed one (and to the correct tree this time) in a v2 series.
> Replying to the first patch because the cover letter did not land in my inbox, somehow.
> I hope this is the right thing to add:
> --
> pw-bot: cr

Eh, didn't work, the bot does a simple == comparison:

https://github.com/kuba-moo/nipa/blob/master/mailbot.py#L294

so "Maftei, Alex" <alex.maftei@amd.com>
vs Alex Maftei <alex.maftei@amd.com>

won't match.

