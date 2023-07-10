Return-Path: <netdev+bounces-16518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD1E74DAD6
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1459281303
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8AB134AF;
	Mon, 10 Jul 2023 16:15:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548613222
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5836DC433C7;
	Mon, 10 Jul 2023 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689005746;
	bh=EnHiiTkYovbRCqP6GjWdTZK3cChn2ZgTf/L/xSKlxg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qsXqxqLtPs5Kh7AH2qMcLa6/7Hf6Kx9qDckz7k49WWVlUY5f9qoXDq6IuC8Kt59Qo
	 tKivWokTCFCjmICnjs6cladxP4VxbaDp8j0oMlg8hQjlqjTHc0ZKHVZ9AzPzZk73UB
	 4B8cmDgBKIjSMCsYsnumgCbNGvr1FzNwesOfbsVY4DTz/UZiB+cOW/jq7BtVrshItP
	 E8CMr/zhwj8vLXkqRI8NWJXd0sEhkkiZTorh0XgJBxy6tJydlK006/bsTgivdQZgnf
	 bUqyV1Sq8ePyXa3hdPuNza45a+rUfyTmqthAVSh6G/dg/6o8Xl/eZmHKN50IgQj+a0
	 3xvT7zXk3lXVg==
Date: Mon, 10 Jul 2023 09:15:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Jones <lee@kernel.org>, s.shtylyov@omp.ru
Cc: Zheng Wang <zyytlz.wz@163.com>, davem@davemloft.net,
 linyunsheng@huawei.com, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 hackerzheng666@gmail.com, 1395428693sheep@gmail.com, alex000young@gmail.com
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230710091545.5df553fc@kernel.org>
In-Reply-To: <20230710114253.GA132195@google.com>
References: <20230311180630.4011201-1-zyytlz.wz@163.com>
	<20230710114253.GA132195@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 12:42:53 +0100 Lee Jones wrote:
> For better or worse, it looks like this issue was assigned a CVE.

Ugh, what a joke. 

Sergey, could you take a look at fixing this properly?

