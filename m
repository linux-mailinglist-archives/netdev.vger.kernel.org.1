Return-Path: <netdev+bounces-30205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8174E7865D8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 05:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C09281427
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 03:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D4D24527;
	Thu, 24 Aug 2023 03:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C1B24521
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 03:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532F0C433C7;
	Thu, 24 Aug 2023 03:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692847985;
	bh=nY1Gsc6fqgwgmMYClHWG1eFrj8eQv/EMxZqykRcXD0g=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JIU2e/d/QFbWCYedjjU1Z9+b0bc7UCmPdQhJ6M8NMRqAPE5cYiDIJ1xNjRqEGzF7O
	 qYAh+dRwhj9zG+E9wfllO2/4w+SUnLC4ZfBPfbANiATHrh3V2QBSj9GVKdRIv8ZGCB
	 9QYtD9ZJGsXYuoqWGZe/DuM+nmKIbEpVl4leF8daM4fat1eHOpIGN7JmXcghg47Ilh
	 vvhODKnyNcBM2TUFW55lHv3w6LohdgIspJv5b1lln40osLf5oL1d+5A4N5KsyW9kha
	 komh2a6e9Mpb7wwIL/0LIa89KLqB9qT/9IsKZqkKBEvNuIkJ9zJQrhQsDINg7U7i3J
	 4s0uUUrET3q5g==
Message-ID: <08d0b5ee-fb78-b1ad-2b18-f9fe6fd6c48b@kernel.org>
Date: Wed, 23 Aug 2023 20:33:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: ss: support for BPF sk local storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>, netdev@vger.kernel.org,
 stephen@networkplumber.org, Martin KaFai Lau <kafai@fb.com>
References: <95161136-5834-4176-9faf-8531268705dc@naccy.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <95161136-5834-4176-9faf-8531268705dc@naccy.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/23 6:55 AM, Quentin Deslandes wrote:
> Hi,
> 
> Could it be possible to print BPF sk local storage data from ss?
> Reading the original patch [1], it appears to have been thought
> out this way, and it seems (to me) that it would fit ss' purpose.
> 
> Please correct me if my assumptions are wrong.
> 
> 1. https://lore.kernel.org/netdev/20190426233938.1330361-1-kafai@fb.com/
> 
> Regards,
> Quentin Deslandes

Adding Martin, author of the patches.

I have not looked into the details, but if the intent is ss style
monitoring then please send a patch.


