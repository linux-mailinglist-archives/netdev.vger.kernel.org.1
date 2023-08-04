Return-Path: <netdev+bounces-24566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA47709E4
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA6F2822CF
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F1C1BF0C;
	Fri,  4 Aug 2023 20:41:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A21DA2B;
	Fri,  4 Aug 2023 20:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A863C433C8;
	Fri,  4 Aug 2023 20:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691181687;
	bh=xcsViil0DGLXaWdiuVDPCxOVUlw+P8Xq3hHgt2h9jaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKp9R/cJgL+kEeGwHIXbHHblJtel4OuIyrNgsdzLS6d182eIkNfc5/8YnPDlNPEK3
	 c4oGvUPStMf6kOHhP8xE98/9uKBnRFnPIuEFg9g8pVWK7VsuPHzSOoNsMz+mi0PISQ
	 mPKzbLHFY+HHeU120+jawOOHRfhObjUEhEWUB0acBhjF0ySQGSIKD9Ndl0v+zB7xfu
	 Johmm/LzB5E2sNYx4ezxv+t1+XSruYi5EHqEeNz4gTViCCtzIrBLo6Q5huYcoxqT9i
	 guCiZ/HAbhK9QM//ws/vrt8o6kja4gGEjdHFpuTQs9qBFsmK0VjJwNqa1gANZacRPf
	 25Ay99oWkeY+A==
Date: Fri, 4 Aug 2023 22:41:21 +0200
From: Simon Horman <horms@kernel.org>
To: "huangjie.albert" <huangjie.albert@bytedance.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Menglong Dong <imagedong@tencent.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 01/10] veth: Implement
 ethtool's get_ringparam() callback
Message-ID: <ZM1icavv+8XeMcQL@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-2-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-2-huangjie.albert@bytedance.com>

On Thu, Aug 03, 2023 at 10:04:27PM +0800, huangjie.albert wrote:
> some xsk libary calls get_ringparam() API to get the queue length

nit: libary -> library

Please consider using checkpatch.pl --codespell

