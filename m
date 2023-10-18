Return-Path: <netdev+bounces-42071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A39E7CD127
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 02:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1485281356
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 00:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926481115;
	Wed, 18 Oct 2023 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6iicX35"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550810F7
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FD0C433C8;
	Wed, 18 Oct 2023 00:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697588004;
	bh=7EKETaIPTlMpyZz8yAKNjEOQs7PtK6fEALBLTW36zMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M6iicX35CWLEf1hKmTmCL7aL7CZdkLc8oEMHSg3ABONrZlGwUeMisUvxeKYcSO8j7
	 Tljs8Qfr7bjE7H04pshLp2MSYRa048MKGrlIJ1IuYfT3453EwR9PmhVfSH3s4/TRV9
	 nJwJ8ZEmFEClWI5/eJ2gRwSTDO0cw+ROwhl35W1vkVMOwAi13O5wf8fybfjPpucWxo
	 tHNs7rnQ2bLWAV8G2OFn7JLZNuChDR8pxwqkT/WYQT2cEpKl8f/dqAqkA+xWB+SR8c
	 AkNLd5hSppqZt7FmkpDYkuX5h7yB1vZWVWlyuyBXvWL5ZCrgA+IcIjUe9TqaJXK95V
	 HxBs7tzj2kF0A==
Date: Tue, 17 Oct 2023 17:13:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2023-10-16
Message-ID: <20231017171324.6c7c2986@kernel.org>
In-Reply-To: <20231016143822.880D8C433C8@smtp.kernel.org>
References: <20231016143822.880D8C433C8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 14:38:22 +0000 (UTC) Kalle Valo wrote:
> wireless-next patches for v6.7
> 
> The second pull request for v6.7, with only driver changes this time.
> We have now support for mt7925 PCIe and USB variants, few new features
> and of course some fixes.
> 
> Major changes:
> 
> mt76
> 
> * mt7925 support
> 
> ath12k
> 
> * read board data variant name from SMBIOS
> 
> wfx
> 
> * Remain-On-Channel (ROC) support

And due to our slowness it's almost Wednesday, anyway.. sorry about
that!

