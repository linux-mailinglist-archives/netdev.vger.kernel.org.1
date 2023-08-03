Return-Path: <netdev+bounces-24161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297AE76F086
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5CD1C21561
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95024193;
	Thu,  3 Aug 2023 17:23:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80001F937
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 17:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5C7C433C8;
	Thu,  3 Aug 2023 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691083395;
	bh=y8eGtQQgDapSBxqm5rIyj31sufYbaMEgXLeK19zO7LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TV3mGJLBxAKOBcjGquYn6Gmjq5TTuB4Rk54K0nNdkJ1siAAM/5vGB2E+7iMCzVCme
	 n9nXIb/CClmNhi6ktroMwe4JvPmRFSFr27xkNFHdKsm2ZZUuHjLBm4XWoOwahOUcW4
	 4sj8DuAAoqVO2oD9Q6uB18ShOzdXg2sjN9k7UjJgR6S0nGPqp2WXSWSqLmh4nBLb0M
	 DbXUCm220kMgBYoWGauX8beHsnG80zR6F+j0jEzqZHIUOwOnx8oZyB8nUXt+CnVTmd
	 sNcVnhoCz0DaVqMXqo1MeCZJlsjpURrhifAEm+/idcGd+m1n+CB+0+lxETSXaGb8bW
	 vfQtqWR4pGQLA==
Date: Thu, 3 Aug 2023 10:23:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Sonia Sharma <sosha@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, sosha@microsoft.com,
 kys@microsoft.com, mikelley@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH v3 net] net: hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Message-ID: <20230803102314.768b6462@kernel.org>
In-Reply-To: <ZMuaCetqzgRsMDvd@kernel.org>
References: <1691023528-5270-1-git-send-email-sosha@linux.microsoft.com>
	<ZMuaCetqzgRsMDvd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Aug 2023 14:14:01 +0200 Simon Horman wrote:
> > The switch statement in netvsc_send_completion() is incorrectly validating
> > the length of incoming network packets by falling through to the next case.
> > Avoid the fallthrough. Instead break after a case match and then process
> > the complete() call.
> > 
> > Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>  
> 
> Hi Sonia,
> 
> if this is a bug-fix, which seems to be the case, then it probably warrants
> a Fixes tag.

And a description of what this problem results in. The commit message
kinda tells us what the patch does, which we already see from the code.
Paraphrasing corporate America "focus on the impact"...
-- 
pw-bot: cr

