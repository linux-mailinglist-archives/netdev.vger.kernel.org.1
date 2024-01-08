Return-Path: <netdev+bounces-62445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA7E8274AC
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 17:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB36E1F23528
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5776524C7;
	Mon,  8 Jan 2024 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoUa8Hrn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D27537F3
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704730212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cKLHLhBEX8bb9WWT7OqrY212FY4x/L8iopt3fivYrUA=;
	b=IoUa8HrnPnBv7+km7lZBzWs4WpNZfOxxlWfBOtiO8JfMa/nGZHzp3zkJ1IL3xEoJul2OlN
	VdoXV+pRKp/LHoRWpD29u/htlMPrJx6sR9D7H22sKIn/wXzju3+f5tOVSCce7hQ09X88Bf
	SgpKMJJ9yNSVry3HJc5No2+PuMoHp8Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-5INAJMvfPC-ktcupYqUBOw-1; Mon, 08 Jan 2024 11:10:11 -0500
X-MC-Unique: 5INAJMvfPC-ktcupYqUBOw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-680b5b8bd27so23774076d6.3
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 08:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704730210; x=1705335010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKLHLhBEX8bb9WWT7OqrY212FY4x/L8iopt3fivYrUA=;
        b=A8/FPyagoIs4AedLoZEWTp+BEZlQWmD0lrNKrZsoHJRH/lpJHpAPmtLxYXTzMLZC6B
         bH1w56Lo+TQ+WkVF2fmGk0GnRCC20PJl85Si3x0G5L1U8MLZyAS4Dy8L5dyxkpuJ//+g
         1bs8G5qtx3567rfNtnYGrzXZ4rA+rPHVJLlRD1uJXi1jAiQEfu0Z+zTfNQCONiJHCRfO
         NNkM8ZIUWF+mmx/dE6xj0rs0gNP0lW1cd8WEJJMz0bycf3gYKkecwjW/zwqA0xWlzlv9
         1IwkabPux2hdsOr5xnoocG0vII4tMjGyTYrN8oYVyLacCet2LSpmbSKHZXW/Om8PLNSZ
         9Cdg==
X-Gm-Message-State: AOJu0YxV7z8u2oGOdtezP0wDY0bWF+t+A0y54P2WZyFpVix1U5da6Ef/
	uFd4CCpR+H4ZRd9w/ZWAZ2oFTPKLfuN2ckO33SeeuR8dPcJ0cFZVnL5yJJZ0UFr2BtBBACTNyu+
	cCypc7YQ6SKYxQuJmw7DHp+c4
X-Received: by 2002:ad4:594d:0:b0:681:967:ce0 with SMTP id eo13-20020ad4594d000000b0068109670ce0mr979870qvb.122.1704730210396;
        Mon, 08 Jan 2024 08:10:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5zkUshQJQO0Yn7/HhzYaTEGUr4o+kQ0yU3L5LCWG0qqYgnVwhmp7NeTgoPrvq+YKPodSQdQ==
X-Received: by 2002:ad4:594d:0:b0:681:967:ce0 with SMTP id eo13-20020ad4594d000000b0068109670ce0mr979861qvb.122.1704730210173;
        Mon, 08 Jan 2024 08:10:10 -0800 (PST)
Received: from localhost ([37.162.108.53])
        by smtp.gmail.com with ESMTPSA id l5-20020a056214028500b00680cb3fd476sm81118qvv.43.2024.01.08.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:10:09 -0800 (PST)
Date: Mon, 8 Jan 2024 17:10:04 +0100
From: Andrea Claudi <aclaudi@redhat.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, leon@kernel.org, dsahern@gmail.com,
	stephen@networkplumber.org,
	Chengchang Tang <tangchengchang@huawei.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iproute2-rc 2/2] rdma: Fix the error of accessing string
 variable outside the lifecycle
Message-ID: <ZZweXDQ-4ZrlfxBv@renaissance-vector>
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
 <20231229065241.554726-3-huangjunxian6@hisilicon.com>
 <fb7c85a4-165d-7eda-740a-d11a32cb86c0@hisilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb7c85a4-165d-7eda-740a-d11a32cb86c0@hisilicon.com>

On Mon, Jan 08, 2024 at 09:28:52AM +0800, Junxian Huang wrote:
> 
> Hi all,
> 
> the first patch is replaced by Stephen's latest patches. Are there any
> comments to this patch?
> 
> Thanks,
> Junxian
>
> On 2023/12/29 14:52, Junxian Huang wrote:
> > From: wenglianfa <wenglianfa@huawei.com>
> > 
> > All these SPRINT_BUF(b) definitions are inside the 'if' block, but
> > accessed outside the 'if' block through the pointers 'comm'. This
> > leads to empty 'comm' attribute when querying resource information.
> > So move the definitions to the beginning of the functions to extend
> > their life cycle.
> > 
> > Before:
> > $ rdma res show srq
> > dev hns_0 srqn 0 type BASIC lqpn 18 pdn 5 pid 7775 comm
> > 
> > After:
> > $ rdma res show srq
> > dev hns_0 srqn 0 type BASIC lqpn 18 pdn 5 pid 7775 comm ib_send_bw
> > 
> > Fixes: 1808f002dfdd ("lib/fs: fix memory leak in get_task_name()")
> > Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> > Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> > ---

Hi Junxian,
For future patches, you can have a faster feedback adding to cc the
author of the original patch. In this case it's me, so here's my

Acked-by: Andrea Claudi <aclaudi@redhat.com>


