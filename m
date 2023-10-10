Return-Path: <netdev+bounces-39397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778227BEFFF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28141C20A5C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B568D37F;
	Tue, 10 Oct 2023 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLMaAPpQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D6E377
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706DCC433C8;
	Tue, 10 Oct 2023 00:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696899263;
	bh=kUK2sT/V0xniU7l1mfm7A8ZGocRqD/CTjDCiVYXl8Mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lLMaAPpQUmzUosar0uT9nw4Jc8IP2s7MHOZbUYBI1gxzHZEHbgmYGI1wIt0hkNFtY
	 qE5+c6bPlED1Rrer9etn//LLO5Z/jlP3rvQde4Qxy4b0D/mB+LjuWwxs10SOzyc4l2
	 9ni3pUroFkoi3idi7JR28QT1GhomxN7tgO8dmpajJxysZfd8NX9hwwE9I4sC7FLucd
	 OGNM2SzvKWPx/xybsbP1B6s+/C+SQhUvhap1eDFd7jGisjC/Xe0B1pyXUfuuIT+LIS
	 vw9/MiVqGekJNfHVtKqsh3FI0on1qobBj2h7UCFvcRpUxYjdGLw2wLB1++yg+/1DDX
	 uEavzB5QkX1hA==
Date: Mon, 9 Oct 2023 17:54:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, tglx@linutronix.de,
 jstultz@google.com, horms@kernel.org, chrony-dev@chrony.tuxfamily.org,
 mlichvar@redhat.com, ntp-lists@mattcorallo.com, vinicius.gomes@intel.com,
 davem@davemloft.net, rrameshbabu@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH net-next v5 5/6] ptp: add debugfs interface to see
 applied channel masks
Message-ID: <20231009175421.57552c62@kernel.org>
In-Reply-To: <72ae11ff23793730a64cc1a037f9a6d59dbfbeea.1696804243.git.reibax@gmail.com>
References: <cover.1696804243.git.reibax@gmail.com>
	<72ae11ff23793730a64cc1a037f9a6d59dbfbeea.1696804243.git.reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Oct 2023 00:49:20 +0200 Xabier Marquiegui wrote:
> The mask value can be viewed grouped in 32bit decimal values using cat,
> or converted to hexadecimal with the included `ptpchmaskfmt.sh` script.
> 32 bit values are listed from least significant to most significant.

If it's a self-test it should probably be included in the Makefile 
so that bots run it.
-- 
pw-bot: cr

