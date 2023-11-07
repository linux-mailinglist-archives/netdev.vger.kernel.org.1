Return-Path: <netdev+bounces-46470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E0A7E44BA
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C041C20BAE
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23931A6F;
	Tue,  7 Nov 2023 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsuqIDYP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338D315BE
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 15:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84891C433C9;
	Tue,  7 Nov 2023 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699372587;
	bh=UM90gK6k7dsz3gd2Yxb/FgNapJOxoWm0ijOk60YhGPg=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=YsuqIDYP7xwxC2BvGW6ymp0N0TJzwBnpVOQYZ8Mw+6tsi7Vz8SWISjhPqQoHIHltt
	 sslo4FGTd7fvmhd7vZ4fPpHuPn6QJ3TYJ74poWJpjwFUrSwl9WxESZCWS2CDm37HWS
	 HAUgj8ILVy07AIVutDYWnAKSFicd/douQJLuEIHUG/XuowpuYn4vD9E79zqZgmoog2
	 zh0MS/V0vSKO/wrCoIgq+9HrXV6J31JSpYymrb8jshhq6mqU5uYwWf8TfKUQOzkBNd
	 ZplDlSF/aPNQG1ktq0YW3cojn3arUcX9r3NSLvRPRajFY+gNEK9V1x9lD2vCLmbHh2
	 hXpt4TTzUll3Q==
Date: Tue, 7 Nov 2023 07:56:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [netdev call] Nov 7th
Message-ID: <20231107075626.19fce518@kernel.org>
In-Reply-To: <20231106162339.371852dc@kernel.org>
References: <20231106162339.371852dc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Nov 2023 16:23:39 -0800 Jakub Kicinski wrote:
> The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).
> 
> Nothing on the agenda at this point, please send topics.
> 
> We could discuss any follow up / comments relating to
> just-concluded netdev.conf, or upcoming LPC?

No topics, let's cancel today's call.

