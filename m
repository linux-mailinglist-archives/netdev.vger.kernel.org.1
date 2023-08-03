Return-Path: <netdev+bounces-24221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2B76F456
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A965F1C2169B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD6525936;
	Thu,  3 Aug 2023 20:55:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355762591C;
	Thu,  3 Aug 2023 20:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2C7C433C8;
	Thu,  3 Aug 2023 20:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691096125;
	bh=nYP64sQ/gfThlmF2ABzQB1MQxACGhOHvusoxvRpvRKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EBT3ghVk4TrjA5Cgv/zszqj6P8U89CdRTezXwhAReACbhaLNx41oK0ugQud6/isgz
	 Nj1tcdXFf5KCXgkdxTenWdsx9CGyY6f1B59Ri5+YQR0Bb+DlKqiQ51sKFEQEnn4Wxs
	 Nz4/9Yy48ZoCRQmvID91PW6VyDMS7a4DKr7ie2TPelra9+U0hJ1K6sh3zISG1CcKLV
	 XdR4FbuRDx6ktVKF1/c3PrTfDOLIAol6aofilX+PDTecC3TqIulkYshUMmIC0qvr1g
	 jlwkJ9OKjJ30HESZe6fw3Dk92Ast9awQrxnGNdoTAiPPJaZpBJ+xabIQ06Z+yDhO5+
	 cEJ2CgkURUY4Q==
Date: Thu, 3 Aug 2023 13:55:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Xiang Yang <xiangyang3@huawei.com>, martineau@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH -next] mptcp: fix the incorrect judgment for
 msk->cb_flags
Message-ID: <20230803135524.4dbcc943@kernel.org>
In-Reply-To: <21fad913-dd47-4d45-865a-3af877990246@tessares.net>
References: <20230803072438.1847500-1-xiangyang3@huawei.com>
	<d3fa9b41-078b-4bb5-9f5c-d8768b787f4d@tessares.net>
	<20230803110424.5ca643c9@kernel.org>
	<21fad913-dd47-4d45-865a-3af877990246@tessares.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Aug 2023 22:18:18 +0200 (GMT+02:00) Matthieu Baerts wrote:
> Thank you for asking that! All patches sent to our mailing list are
> automatically tested but the report is only sent to our mailing list
> not to annoy too many people. This patch passed all tests we have:
> 
> https://lore.kernel.org/mptcp/20230803072438.1847500-1-xiangyang3@huawei.com/T/
> 
> I already applied it on our side. For non-trivial fixes or features,
> we usually prefer to keep them a bit only applied on our side for
> longer tests and to have syzkaller stressing them. But here, because
> this patch looks trivial enough, it seems fine to me to have it
> applied in -net directly.

GTK! I'll apply it in the evening, thanks!

