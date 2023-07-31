Return-Path: <netdev+bounces-22948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043CE76A26E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB983281602
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910721DDF5;
	Mon, 31 Jul 2023 21:07:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB11DDF4
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6536CC433C8;
	Mon, 31 Jul 2023 21:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690837622;
	bh=tkAfo/j4zgsAFGvrWUpfgO1ceI/V5/Ok7moEgwD40LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vvuxxx2869dvOHp20tF0Bbng4rhhKfNOEuUBOlDb7tQXsuGEVrEjtutX9mQ2+pqun
	 07aaq1jpqQUD6fFx/x4gohA3PqS9mWJ10YIEJLcWtw0w9RjNGmXJTzp2zYxojVRGTw
	 2GEr1oNQV4TTSZ5DV9+iMEGIDCGIT04gKAcEH0gAFsX1sT3RlqkPowH/d68sJLY2m4
	 MVGB/OlJnIp++FtArsaoaoj7MAQD2s5aNigllWUbb/hq2QKSloLjW6eFHxEPKwbJye
	 5ykVT1AZKISv31igBf0dYrUJ4ENJiMyPIWQcZaWFJGIRCUeDFLRAg+sqotytyyYjUT
	 oSGx6gbQ8rMHw==
Date: Mon, 31 Jul 2023 14:07:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>, anjali.k.kulkarni@oracle.com
Cc: shuah@kernel.org, Liam.Howlett@oracle.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] selftests:connector: Fix input argument error
 paths to skip
Message-ID: <20230731140701.6c659cf6@kernel.org>
In-Reply-To: <1471f593-1ff5-902a-a045-9241feda7bd0@linuxfoundation.org>
References: <20230729002403.4278-1-skhan@linuxfoundation.org>
	<1471f593-1ff5-902a-a045-9241feda7bd0@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 14:23:45 -0600 Shuah Khan wrote:
> I sent v2 for patch 3 in the series. Do you want me to send the
> entire series again with this revised 3rd patch.

I think it's all good. The build bot couldn't parse the partial series
but the patches are pretty trivial, so low risk of breakage.

Anjali, it would be good to get your Review / Ack tag on this patch,
since you're the author.

