Return-Path: <netdev+bounces-15653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65176748F71
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 22:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B8F281157
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3069C14276;
	Wed,  5 Jul 2023 20:55:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90F13AEF
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 20:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82782C433C7;
	Wed,  5 Jul 2023 20:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688590549;
	bh=uiTvJCau7YJw9n0j5AlyOXFdzLt/ldvFjBcrnv8HuVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ajxd1wErIXQtvCUd0gJSO/SNM13g6HK2w4YkygqktkFTco9dijPC6jarBfTiYrzJr
	 KxcEUs2LAPZfuf5VYreCIYDtK7Zx6O51GLZyb+V1En0UPzJglqi+4zDypRtIbPh4+8
	 ZJ7TMdsIamP4N3+QC6XExX5Ihl+HPR06fkF0GVv97mlM+eeuv01qDhQH+8qJC3xQ2x
	 xmTfN+RDB5vYg+YILcjfWKKNlRrcgRk4IhudMpWQp87+QAb4Jsyc3rsc5rI0bY877u
	 Npft+iAS+sW3VT7xCfl9MUDOmCqPf4XJiqoETlum7tcRJZ3fIc0NLlHPsZXuEvlpVp
	 3w0fuDKC8U0YA==
Date: Wed, 5 Jul 2023 13:55:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] net/tls: split tls_rx_reader_lock
Message-ID: <20230705135548.52db9949@kernel.org>
In-Reply-To: <0e230fdf-6af6-926f-305e-2f34ac6a6812@suse.de>
References: <20230703090444.38734-1-hare@suse.de>
	<20230703090444.38734-5-hare@suse.de>
	<1ebc60c1-c094-98a0-5735-635a8af5bf63@grimberg.me>
	<0e230fdf-6af6-926f-305e-2f34ac6a6812@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jul 2023 12:21:32 +0200 Hannes Reinecke wrote:
> > Nit: I still think tls_rx_reader_enter/tls_rx_reader_exit are more
> > appropriate names.  
> 
> I don't mind either way, but I've interpreted the comments from Jakub 
> that he'd like this naming better.
> 
> Jakub?

Slight preference for enter/leave (leave rather than exit).

