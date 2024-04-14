Return-Path: <netdev+bounces-86165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B463489DC31
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A881C20878
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA3912FB0B;
	Tue,  9 Apr 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqlFw8IQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C761212FB16;
	Tue,  9 Apr 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672851; cv=none; b=R5SL3uJeg31j4Zu5Gv/BEaTJ91A7CenyuasRFYX59QWw09GKLY5rwk6nOz/VNDOd4E0BkaaTDweUnEAbss5+Y99otZbStHjI0uqtpgu5rWYMN2qity48fTpvYZrRCLLqzjriXgpTrOi7VMzg5ETmqH9zc6b0jt4jzL4FuYQVNRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672851; c=relaxed/simple;
	bh=R7mPx1GbbF9Ro7OXOYu6FmDsreDUCs8cc9FnR8W1fo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/ktTu8qX55wp7aVaU2g2EI37pGModRjuR8Y34hLh+wFYKCfpFVOhOQjftgtbj7qA4hrRHA1rdUHqyQazBBtFzTQOBO5ZLu2D5W/blKci2hgM6Rzb/ei9LR7qoBxkRLv+gucdAKLMjXicc3swoDLDeJiQaRN0nRqLVz0WHyVxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqlFw8IQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0845BC433C7;
	Tue,  9 Apr 2024 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712672851;
	bh=R7mPx1GbbF9Ro7OXOYu6FmDsreDUCs8cc9FnR8W1fo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GqlFw8IQVvHQcHwGUZkAPC05n3+mOpFBtmCvVrGnHZrqDmylfgIdXd8tF9KEZ4QDa
	 WMaueOI62K2mU0v20n6sVhDpmA3fDcZMZ7DYCkV4qmd+rouiup+mp0fKmJQnLI/arb
	 pPNwZl0MGE5k8bFLPwr7RKjjmtS7e0DhQ57PYlLU9Nn5WRqytJ7Gnvkw1M2a6wIKqM
	 Hv+YaKVnTUXaavgVkhD2agHJgISwALJ6RxrZ4GNnwhQWCbUq8YE0wCjAh/GZEElpSu
	 JLSu/SchKouZZoxS0xPeTGzuh/eg0ldUyBqUBOopNal5OiJT7Wt5DErJzdLLrBTUH1
	 SbTYmDRv6qfAw==
Date: Tue, 9 Apr 2024 07:27:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, John Fastabend
 <john.fastabend@gmail.com>, Alexander Duyck <alexander.duyck@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alexander Duyck
 <alexanderduyck@fb.com>, <davem@davemloft.net>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240409072730.696a7a75@kernel.org>
In-Reply-To: <20240409070858.41560b1c@kernel.org>
References: <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
	<678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
	<20240405122646.GA166551@nvidia.com>
	<CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
	<20240405151703.GF5383@nvidia.com>
	<CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
	<ZhPaIjlGKe4qcfh_@nanopsycho>
	<CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
	<ZhQgmrH-QGu6HP-k@nanopsycho>
	<66142a4b402d5_2cb7208ec@john.notmuch>
	<ZhUgH9_beWrKbwwg@nanopsycho>
	<9dd78c52-868e-4955-aba2-36bbaf3e0d88@intel.com>
	<20240409070858.41560b1c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 07:08:58 -0700 Jakub Kicinski wrote:
> distinctiveness

Too trusting of the spellcheck, I meant disincentivizes

