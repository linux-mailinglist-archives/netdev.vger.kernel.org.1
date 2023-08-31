Return-Path: <netdev+bounces-31476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EADA78E453
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 03:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEEC2812D4
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796DC10F6;
	Thu, 31 Aug 2023 01:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1410E1
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D0FC433C7;
	Thu, 31 Aug 2023 01:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693445371;
	bh=QeTBNj4m+qfE+BDsvDv8vhuECn2zmtlKCZXCRdoO31E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HEqSDdHc+5X1AROMwHio5u866jWByeDoHBDFLiukeA25VmCOvZmA/VM/4zr+2z8cn
	 dHHbUQVC26g1EtcR/NffDV9/H9mM3X34Unhk+a2Y6LR5rg6xX06lDPPoI7JD8yVWbD
	 A/cJPY+tuQUU046avjsTFV0EKGzrWgdepy2NQGVCArsxzkew27fpSaUsAscdY+4miY
	 h0FQsCJ+ZS7fAH7Jz5pbC6/rY2Qo6nlZ3UuSX60I8nNyo4Z1jixIn5QOcpzTMXZ90k
	 xqjmEvd90w1x4ZdmehBqfIizuOXE/U7K45e5mxNcCRLli0IhrKVhPbOS7iL1fckcR+
	 D4ZKtkZvOOd9w==
Date: Wed, 30 Aug 2023 18:29:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <netdev@vger.kernel.org>, <gregkh@linuxfoundation.org>,
 <jirislaby@kernel.org>, <benjamin.tissoires@redhat.com>, Karsten Keil
 <isdn@linux-pingi.de>
Subject: Re: [PATCH -next] isdn: capi, Use list_for_each_entry() helper
Message-ID: <20230830182930.13bf817f@kernel.org>
In-Reply-To: <20230830090529.529209-1-ruanjinjie@huawei.com>
References: <20230830090529.529209-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Aug 2023 17:05:28 +0800 Jinjie Ruan wrote:
> Convert list_for_each() to list_for_each_entry() so that the l
> list_head pointer and list_entry() call are no longer needed, which
> can reduce a few lines of code. No functional changed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


