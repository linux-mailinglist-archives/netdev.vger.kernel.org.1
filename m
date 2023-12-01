Return-Path: <netdev+bounces-53010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D32A78011C3
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B48F280A6E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474524E1D3;
	Fri,  1 Dec 2023 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFbT7iZ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5C4A9B2
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 17:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF9FC433C8;
	Fri,  1 Dec 2023 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701451999;
	bh=0xeSZluF+4id8vnCBkeFjfDDNTOiiCyXIrlrCuFfkvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UFbT7iZ3df6HKRzFYiBdkn/QlyeDGaFJ0t5uvIJiCFROkTFfAEgSSVOCT95ezIUeH
	 Es5Q2URfocJurGH5pIbTj9kEHVTooi1xtGvCBI5UM66CtHF/QNrJeujv8v6pPmpzG5
	 W+lev2r8hJErhVqVK9o6CY7DMrGWmsB+cld6i7Zy+e7taxCi+pQSxjQC8KZRedzNUj
	 gFczly5c48cvQMslJ1oHyrUm5y1CLsep9Un2kzCF6Ikoryx7LD2gpmRWqw4R1NJLvR
	 hy2j3Ac7bj4TE5GD/UQZAaA3gJCJNuDy5Vlt5Z/RZ/KeSO64zQWGqd6JTkp8HHYtpT
	 1XlovoRtKZKJg==
Date: Fri, 1 Dec 2023 09:33:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, mleitner@redhat.com
Subject: Re: [PATCH net-next 0/4] net/sched: act_api: contiguous action
 arrays
Message-ID: <20231201093317.017c6424@kernel.org>
In-Reply-To: <20231130152041.13513-1-pctammela@mojatatu.com>
References: <20231130152041.13513-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 12:20:37 -0300 Pedro Tammela wrote:
> When dealing with action arrays in act_api it's natural to ask if they
> are always contiguous (no NULL pointers in between). Yes, they are in
> all cases so far, so make use of the already present tcf_act_for_each_action
> macro to explicitly document this assumption.
> 
> There was an instance where it was not, but it was refactorable (patch 2)
> to make the array contiguous.

Hi Pedro, this appears not to apply.
-- 
pw-bot: cr

