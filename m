Return-Path: <netdev+bounces-29423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5AB7831B4
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C22280F36
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF61171F;
	Mon, 21 Aug 2023 20:05:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC571171A
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0241C433CC;
	Mon, 21 Aug 2023 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692648313;
	bh=ZnF3adpTq3Rd9NDFbPI8Dp5AX87vmComBUZYXb/SPpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fmvoBYHxJyLjcMQkF/O10pqvND5eb5L1l5qZdQXQiWOVu+pqDBtB08O+l5lCTiKMx
	 Q0ClbWV8ewEbrZ95RyvWU3m9j6Vid6Zbm9F2zW1qeK7znlwcC8qYe0yDMSDg4IQ91s
	 0WN23R+HL7gQTqXWTJldmgHGF/Zv5RcjNOu1sJwubMloSnwfQwzRJ5/3JVtRua+PdS
	 oJApps6i55xcEFCMBDr1imXqM82oQKKXz/UDXeAHHUz3sippk4LGWbFEHcgIYlx0NT
	 mA4aZe4WdvIQq2k3NTiMm+8G71xEl3g+K8mcroBDU7Wg0mim/rDEZOop49URDaQgKJ
	 JSyxK7l/h49HQ==
Date: Mon, 21 Aug 2023 13:05:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Yue Haibing <yuehaibing@huawei.com>, brett.creeley@amd.com,
 drivers@pensando.io, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ionic: Remove unused declarations
Message-ID: <20230821130512.27d0265e@kernel.org>
In-Reply-To: <b113a610-15b0-460a-a439-3e8461ae3f60@amd.com>
References: <20230821134717.51936-1-yuehaibing@huawei.com>
	<46c62232-9a00-4a9f-b1ea-288c53ae47c3@amd.com>
	<20230821123927.4806075c@kernel.org>
	<b113a610-15b0-460a-a439-3e8461ae3f60@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 12:42:52 -0700 Nelson, Shannon wrote:
> > Nope, it's harmless, no Fixes needed.
> > Fixes is for backporting, why would we backport this.  
> 
> Okay.
> 
> Unfortunately I experimented with sending the "changes requested" 
> message to the pw bot just before receiving your note...

As luck would have it - seems like something in the copious Outlook
headers confuses python's email library:

$ wget https://lore.kernel.org/all/69e9c563-2f07-4e9e-b43a-145839fe2afd@amd.com/raw
$ python
>>> import email
>>> from email.policy import default
>>> with open('raw', 'rb') as fp:
...   raw = fp.read()
...   msg = email.message_from_bytes(raw, policy=default)
...
>>> msg.get_body(preferencelist=('plain',)).as_string().split('\n')[-1]
''
>>> msg.get_body(preferencelist=('plain',)).as_string().split('\n')[0]
'Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net'


It thinks the headers are the body, so we missed the pw-bot command.

